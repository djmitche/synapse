/* Copyright 2021 The Matrix.org Foundation C.I.C
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

-- Add a table that keeps track of a list of users who should, upon their next
-- sync request, receive presence for all currently online users that they are
-- "interested" in.

-- The motivation for a DB table over an in-memory list is so that this list
-- can be added to and retrieved from by any worker. Specifically, we don't
-- want to duplicate work across multiple sync workers.

CREATE TABLE IF NOT EXISTS users_to_send_full_presence_to(
    added_ms BIGINT,
    user_id TEXT
);

CREATE UNIQUE INDEX IF NOT EXISTS users_to_send_full_presence_to_added_ms_user_id
    ON users_to_send_full_presence_to(added_ms, user_id);
