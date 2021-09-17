Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D497AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EA8604E9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0EA8604E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06AE36EE7D;
	Fri, 17 Sep 2021 19:25:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8CF6EE7A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:25:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaMKQzo8u0jPva4d38N251rjHIXnGG4ckV+lCE+FCUaIkOIFiZrzb9YxQwvUWYGodMhFlFLVqguBZlFvJCIW5CqhoAbLdwfIZ0VZXIPpNqnUO9sSAUDMy8v6LqgVaN4c3zkSKnEsQ43Di4sTjSSSwYuuWJL0z+1QBbQZ18kCEqMpi2XxWItP+ZiWQOSYdPzaEHnzBi8AtOCt1I9W8G7PAEGYUYl/dveBMaBzhR4ZmKiiYcKqCszm+WXqijloa1Zcf7mc6o3ToDfOIiF/jAcGy1FbWp1pPWuWI0iSW6sJtKljyUodkLoq2ULBrQskEJZ2UlotV9uGsNobdJ6ND//gZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=9VnPc6nABX7sdcA5yw7EOm/fk1T7F08ZW95C6hDaW+E=;
 b=dF33Tyt7Je6H9WwoRzZAXCrJykPZF/D7+LpipMgzUPvLaxsoQsPacWotpH0x9p3x7faKtK7uUBypeoZke0HuwxEJZkcOVqRe9r/5py9Wo5q74I4+2XpeEjP3fJEcVusSMnGGA79vNOxAPauVg4lsS5zDQbdgtEMkzYJnym5VGhLqWMTobnPh39Yo8ci5OghTn808GHWoD7K5V3j7EIHytpn/hVsAWMyhZObDVkdKoH+Nph1vi240Kbc/YSr4XfVxbcjxhHryqZnG0e4Q8ajS1JSPG9K9ORkfw+bmCutb9sHPJ2L2mWmNPS272ZuLzgAVeZDdxqCKseJ3ThnxhX86JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VnPc6nABX7sdcA5yw7EOm/fk1T7F08ZW95C6hDaW+E=;
 b=OH5A4FIdGqfPRPKDeoZr4bjFJX75coHQdlryK1Ye7L42DWrRTM/6IT0q05+UhppMduOqgPl3DsQ+qgYW7a886A3Nl3ZfvC80wM0wYF+h5zPmStdE841XHGs6Z4+H24iWDx1XNnd6QKy7UZmeNs8BKuSzj2cV+Yh7ybgfQ99eRVc=
Received: from BN9PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:fa::24)
 by SJ0PR12MB5487.namprd12.prod.outlook.com (2603:10b6:a03:301::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:25:52 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::ad) by BN9PR03CA0019.outlook.office365.com
 (2603:10b6:408:fa::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:52 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:50 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: [PATCH 06/18] drm/amd/display: Fix concurrent dynamic encoder
 assignment
Date: Fri, 17 Sep 2021 15:25:12 -0400
Message-ID: <20210917192524.3020276-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce457091-8ba8-4906-f81f-08d97a10f671
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5487:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB548759658F4BE50EC0D4F43A98DD9@SJ0PR12MB5487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXwWr+6LDKPhPb7VakWe3fWUe8tXUBkvwqHQ2VGXAfOuCB1ImqSusSqzoddJXLyfnpmzrTdVO3+RpD+DnUee7deIzQiQo8wgVQDP+Fq5mEv+os39z1QPdReW70oxaROG4x5NOFbXSsH7Z8zWg83/qtb9SV/0mymlncCxoI3JIs3BLFumsrJpQalDp6eNcBhiNqoVgL/VFRhQND7h5Sdp4/FbxzsnbYgVswHKnxB4cAZD7zKp7gQoEMqoxk/luBYpTTNW6LzaddalVZAPJkZQhCK2HlYeaXfhFTmcZ9lRiz7RMa8ecjuvnUCrs7eM8BXSIbv3ZOdQ2v8hik+eINTHRZ9S6gtuNtTVUBA/n3kMCrnlZIGZrYV4QC8ifX6f9neLGZFWWn0M8Lx0+tNX/YC29vlZ+Hez7mVOl9XnbjwxJYKYJRnUJLx+cwgiNs3CNbhKK11vkNMtQmKli01EQAZgbpdAhYDKf9rylpwcSL2Ajf7liK+ISPaQ5+kCTEsh5Zwrv6opsD1CWnCblEwmaaITJjoEAr83dMdBkRwtXRvybF4FgMZtM0izYnUhKrPjQEdd//8pZB2W6DE52kU8k8dIA1I7ux50k5U9x6bXYmOXMbNgZyNEAudRVbEKkt7y2VjNiahAs2TVuFEHNJPpDtvoSvFk0hF1sEJ3lCjqLiy8PexInfLCtF2hJhDSmWtWRkOmKdQ/4iMeBMGmxTYO2jp8CbL74irZjWl3IhCP4zd8HCo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(36756003)(8676002)(54906003)(47076005)(86362001)(356005)(316002)(2616005)(81166007)(36860700001)(2906002)(186003)(336012)(26005)(508600001)(82310400003)(8936002)(16526019)(30864003)(426003)(5660300002)(70586007)(70206006)(83380400001)(1076003)(6916009)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:52.1925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce457091-8ba8-4906-f81f-08d97a10f671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5487
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Trying to enable multiple displays simultaneously exposed shortcomings
with the algorithm for dynamic link encoder assignment.

The main problems were:
- Assuming stream order remained constant across states would sometimes
lead to invalid DIG encoder assignment.
- Incorrect logic for deciding whether or not a DIG could support a
stream would also sometimes lead to invalid DIG encoder assignment.
- Changes in encoder assignment were wholesale while updating of the
pipe backend is incremental. This would lead to the hardware state not
matching the software state even with valid encoder assignments.

[How]

The following changes fix the identified problems.
- Use stream pointer rather than stream index to track streams across
states.
- Fix DIG compatibility check by examining the link signal type rather
than the stream signal type.
- Modify assignment algorithm to make incremental updates so software
and hardware states remain coherent.

Additionally:
- Add assertions and an encoder assignment validation function
link_enc_cfg_validate() to detect potential problems with encoder
assignment closer to their root cause.
- Reduce the frequency with which the assignment algorithm is executed.
It should not be necessary for fast state validation.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   2 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 329 ++++++++++++++----
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |   3 +
 5 files changed, 260 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c96a8694236e..920ae2b0b165 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2362,7 +2362,7 @@ bool perform_link_training_with_retries(
 	/* Dynamically assigned link encoders associated with stream rather than
 	 * link.
 	 */
-	if (link->dc->res_pool->funcs->link_encs_assign)
+	if (link->is_dig_mapping_flexible && link->dc->res_pool->funcs->link_encs_assign)
 		link_enc = stream->link_enc;
 	else
 		link_enc = link->link_enc;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 49b17bbea8d1..5536184fff46 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -35,78 +35,116 @@ static bool is_dig_link_enc_stream(struct dc_stream_state *stream)
 	int i;
 
 	/* Loop over created link encoder objects. */
-	for (i = 0; i < stream->ctx->dc->res_pool->res_cap->num_dig_link_enc; i++) {
-		link_enc = stream->ctx->dc->res_pool->link_encoders[i];
-
-		if (link_enc &&
-				((uint32_t)stream->signal & link_enc->output_signals)) {
-			if (dc_is_dp_signal(stream->signal)) {
-				/* DIGs do not support DP2.0 streams with 128b/132b encoding. */
-				struct dc_link_settings link_settings = {0};
-
-				decide_link_settings(stream, &link_settings);
-				if ((link_settings.link_rate >= LINK_RATE_LOW) &&
-						link_settings.link_rate <= LINK_RATE_HIGH3) {
+	if (stream) {
+		for (i = 0; i < stream->ctx->dc->res_pool->res_cap->num_dig_link_enc; i++) {
+			link_enc = stream->ctx->dc->res_pool->link_encoders[i];
+
+			/* Need to check link signal type rather than stream signal type which may not
+			 * yet match.
+			 */
+			if (link_enc && ((uint32_t)stream->link->connector_signal & link_enc->output_signals)) {
+				if (dc_is_dp_signal(stream->signal)) {
+					/* DIGs do not support DP2.0 streams with 128b/132b encoding. */
+					struct dc_link_settings link_settings = {0};
+
+					decide_link_settings(stream, &link_settings);
+					if ((link_settings.link_rate >= LINK_RATE_LOW) &&
+							link_settings.link_rate <= LINK_RATE_HIGH3) {
+						is_dig_stream = true;
+						break;
+					}
+				} else {
 					is_dig_stream = true;
 					break;
 				}
-			} else {
-				is_dig_stream = true;
-				break;
 			}
 		}
 	}
-
 	return is_dig_stream;
 }
 
-/* Update DIG link encoder resource tracking variables in dc_state. */
-static void update_link_enc_assignment(
+/* Return stream using DIG link encoder resource. NULL if unused. */
+static struct dc_stream_state *get_stream_using_link_enc(
+		struct dc_state *state,
+		enum engine_id eng_id)
+{
+	struct dc_stream_state *stream = NULL;
+	int i;
+
+	for (i = 0; i < state->stream_count; i++) {
+		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+
+		if ((assignment.valid == true) && (assignment.eng_id == eng_id)) {
+			stream = state->streams[i];
+			break;
+		}
+	}
+
+	return stream;
+}
+
+static void remove_link_enc_assignment(
 		struct dc_state *state,
 		struct dc_stream_state *stream,
-		enum engine_id eng_id,
-		bool add_enc)
+		enum engine_id eng_id)
 {
 	int eng_idx;
-	int stream_idx;
 	int i;
 
 	if (eng_id != ENGINE_ID_UNKNOWN) {
 		eng_idx = eng_id - ENGINE_ID_DIGA;
-		stream_idx = -1;
 
-		/* Index of stream in dc_state used to update correct entry in
+		/* stream ptr of stream in dc_state used to update correct entry in
 		 * link_enc_assignments table.
 		 */
-		for (i = 0; i < state->stream_count; i++) {
-			if (stream == state->streams[i]) {
-				stream_idx = i;
+		for (i = 0; i < MAX_PIPES; i++) {
+			struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+
+			if (assignment.valid && assignment.stream == stream) {
+				state->res_ctx.link_enc_assignments[i].valid = false;
+				/* Only add link encoder back to availability pool if not being
+				 * used by any other stream (i.e. removing SST stream or last MST stream).
+				 */
+				if (get_stream_using_link_enc(state, eng_id) == NULL)
+					state->res_ctx.link_enc_avail[eng_idx] = eng_id;
+				stream->link_enc = NULL;
 				break;
 			}
 		}
+	}
+}
+
+static void add_link_enc_assignment(
+		struct dc_state *state,
+		struct dc_stream_state *stream,
+		enum engine_id eng_id)
+{
+	int eng_idx;
+	int i;
+
+	if (eng_id != ENGINE_ID_UNKNOWN) {
+		eng_idx = eng_id - ENGINE_ID_DIGA;
 
-		/* Update link encoder assignments table, link encoder availability
-		 * pool and link encoder assigned to stream in state.
-		 * Add/remove encoder resource to/from stream.
+		/* stream ptr of stream in dc_state used to update correct entry in
+		 * link_enc_assignments table.
 		 */
-		if (stream_idx != -1) {
-			if (add_enc) {
-				state->res_ctx.link_enc_assignments[stream_idx] = (struct link_enc_assignment){
+		for (i = 0; i < state->stream_count; i++) {
+			if (stream == state->streams[i]) {
+				state->res_ctx.link_enc_assignments[i] = (struct link_enc_assignment){
 					.valid = true,
 					.ep_id = (struct display_endpoint_id) {
 						.link_id = stream->link->link_id,
 						.ep_type = stream->link->ep_type},
-					.eng_id = eng_id};
+					.eng_id = eng_id,
+					.stream = stream};
 				state->res_ctx.link_enc_avail[eng_idx] = ENGINE_ID_UNKNOWN;
 				stream->link_enc = stream->ctx->dc->res_pool->link_encoders[eng_idx];
-			} else {
-				state->res_ctx.link_enc_assignments[stream_idx].valid = false;
-				state->res_ctx.link_enc_avail[eng_idx] = eng_id;
-				stream->link_enc = NULL;
+				break;
 			}
-		} else {
-			dm_output_to_console("%s: Stream not found in dc_state.\n", __func__);
 		}
+
+		/* Attempted to add an encoder assignment for a stream not in dc_state. */
+		ASSERT(i != state->stream_count);
 	}
 }
 
@@ -127,30 +165,29 @@ static enum engine_id find_first_avail_link_enc(
 	return eng_id;
 }
 
-/* Return stream using DIG link encoder resource. NULL if unused. */
-static struct dc_stream_state *get_stream_using_link_enc(
-		struct dc_state *state,
-		enum engine_id eng_id)
+static bool is_avail_link_enc(struct dc_state *state, enum engine_id eng_id)
 {
-	struct dc_stream_state *stream = NULL;
-	int stream_idx = -1;
-	int i;
+	bool is_avail = false;
+	int eng_idx = eng_id - ENGINE_ID_DIGA;
 
-	for (i = 0; i < state->stream_count; i++) {
-		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+	if (eng_id != ENGINE_ID_UNKNOWN && state->res_ctx.link_enc_avail[eng_idx] != ENGINE_ID_UNKNOWN)
+		is_avail = true;
 
-		if ((assignment.valid == true) && (assignment.eng_id == eng_id)) {
-			stream_idx = i;
-			break;
-		}
-	}
+	return is_avail;
+}
 
-	if (stream_idx != -1)
-		stream = state->streams[stream_idx];
-	else
-		dm_output_to_console("%s: No stream using DIG(%d).\n", __func__, eng_id);
+/* Test for display_endpoint_id equality. */
+static bool are_ep_ids_equal(struct display_endpoint_id *lhs, struct display_endpoint_id *rhs)
+{
+	bool are_equal = false;
 
-	return stream;
+	if (lhs->link_id.id == rhs->link_id.id &&
+			lhs->link_id.enum_id == rhs->link_id.enum_id &&
+			lhs->link_id.type == rhs->link_id.type &&
+			lhs->ep_type == rhs->ep_type)
+		are_equal = true;
+
+	return are_equal;
 }
 
 void link_enc_cfg_init(
@@ -175,11 +212,17 @@ void link_enc_cfg_link_encs_assign(
 {
 	enum engine_id eng_id = ENGINE_ID_UNKNOWN;
 	int i;
+	int j;
+
+	ASSERT(state->stream_count == stream_count);
 
 	/* Release DIG link encoder resources before running assignment algorithm. */
 	for (i = 0; i < stream_count; i++)
 		dc->res_pool->funcs->link_enc_unassign(state, streams[i]);
 
+	for (i = 0; i < MAX_PIPES; i++)
+		ASSERT(state->res_ctx.link_enc_assignments[i].valid == false);
+
 	/* (a) Assign DIG link encoders to physical (unmappable) endpoints first. */
 	for (i = 0; i < stream_count; i++) {
 		struct dc_stream_state *stream = streams[i];
@@ -191,26 +234,73 @@ void link_enc_cfg_link_encs_assign(
 		/* Physical endpoints have a fixed mapping to DIG link encoders. */
 		if (!stream->link->is_dig_mapping_flexible) {
 			eng_id = stream->link->eng_id;
-			update_link_enc_assignment(state, stream, eng_id, true);
+			add_link_enc_assignment(state, stream, eng_id);
+		}
+	}
+
+	/* (b) Retain previous assignments for mappable endpoints if encoders still available. */
+	eng_id = ENGINE_ID_UNKNOWN;
+
+	if (state != dc->current_state) {
+		struct dc_state *prev_state = dc->current_state;
+
+		for (i = 0; i < stream_count; i++) {
+			struct dc_stream_state *stream = state->streams[i];
+
+			/* Skip stream if not supported by DIG link encoder. */
+			if (!is_dig_link_enc_stream(stream))
+				continue;
+
+			if (!stream->link->is_dig_mapping_flexible)
+				continue;
+
+			for (j = 0; j < prev_state->stream_count; j++) {
+				struct dc_stream_state *prev_stream = prev_state->streams[j];
+
+				if (stream == prev_stream && stream->link == prev_stream->link &&
+						prev_state->res_ctx.link_enc_assignments[j].valid) {
+					eng_id = prev_state->res_ctx.link_enc_assignments[j].eng_id;
+					if (is_avail_link_enc(state, eng_id))
+						add_link_enc_assignment(state, stream, eng_id);
+				}
+			}
 		}
 	}
 
-	/* (b) Then assign encoders to mappable endpoints. */
+	/* (c) Then assign encoders to remaining mappable endpoints. */
 	eng_id = ENGINE_ID_UNKNOWN;
 
 	for (i = 0; i < stream_count; i++) {
 		struct dc_stream_state *stream = streams[i];
 
 		/* Skip stream if not supported by DIG link encoder. */
-		if (!is_dig_link_enc_stream(stream))
+		if (!is_dig_link_enc_stream(stream)) {
+			ASSERT(stream->link->is_dig_mapping_flexible != true);
 			continue;
+		}
 
 		/* Mappable endpoints have a flexible mapping to DIG link encoders. */
 		if (stream->link->is_dig_mapping_flexible) {
-			eng_id = find_first_avail_link_enc(stream->ctx, state);
-			update_link_enc_assignment(state, stream, eng_id, true);
+			struct link_encoder *link_enc = NULL;
+
+			/* Skip if encoder assignment retained in step (b) above. */
+			if (stream->link_enc)
+				continue;
+
+			/* For MST, multiple streams will share the same link / display
+			 * endpoint. These streams should use the same link encoder
+			 * assigned to that endpoint.
+			 */
+			link_enc = link_enc_cfg_get_link_enc_used_by_link(state, stream->link);
+			if (link_enc == NULL)
+				eng_id = find_first_avail_link_enc(stream->ctx, state);
+			else
+				eng_id =  link_enc->preferred_engine;
+			add_link_enc_assignment(state, stream, eng_id);
 		}
 	}
+
+	link_enc_cfg_validate(dc, state);
 }
 
 void link_enc_cfg_link_enc_unassign(
@@ -226,7 +316,7 @@ void link_enc_cfg_link_enc_unassign(
 	if (stream->link_enc)
 		eng_id = stream->link_enc->preferred_engine;
 
-	update_link_enc_assignment(state, stream, eng_id, false);
+	remove_link_enc_assignment(state, stream, eng_id);
 }
 
 bool link_enc_cfg_is_transmitter_mappable(
@@ -248,21 +338,18 @@ struct dc_link *link_enc_cfg_get_link_using_link_enc(
 		enum engine_id eng_id)
 {
 	struct dc_link *link = NULL;
-	int stream_idx = -1;
 	int i;
 
 	for (i = 0; i < state->stream_count; i++) {
 		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
 
 		if ((assignment.valid == true) && (assignment.eng_id == eng_id)) {
-			stream_idx = i;
+			link = state->streams[i]->link;
 			break;
 		}
 	}
 
-	if (stream_idx != -1)
-		link = state->streams[stream_idx]->link;
-	else
+	if (link == NULL)
 		dm_output_to_console("%s: No link using DIG(%d).\n", __func__, eng_id);
 
 	return link;
@@ -282,13 +369,9 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
 
 	for (i = 0; i < state->stream_count; i++) {
 		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
-		if (assignment.valid == true &&
-				assignment.ep_id.link_id.id == ep_id.link_id.id &&
-				assignment.ep_id.link_id.enum_id == ep_id.link_id.enum_id &&
-				assignment.ep_id.link_id.type == ep_id.link_id.type &&
-				assignment.ep_id.ep_type == ep_id.ep_type) {
+
+		if (assignment.valid == true && are_ep_ids_equal(&assignment.ep_id, &ep_id))
 			link_enc = link->dc->res_pool->link_encoders[assignment.eng_id - ENGINE_ID_DIGA];
-		}
 	}
 
 	return link_enc;
@@ -318,3 +401,99 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream(
 
 	return link_enc;
 }
+
+bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
+{
+	bool is_valid = false;
+	bool valid_entries = true;
+	bool valid_stream_ptrs = true;
+	bool valid_uniqueness = true;
+	bool valid_avail = true;
+	bool valid_streams = true;
+	int i, j;
+	uint8_t valid_count = 0;
+	uint8_t dig_stream_count = 0;
+	int matching_stream_ptrs = 0;
+	int eng_ids_per_ep_id[MAX_PIPES] = {0};
+
+	/* (1) No. valid entries same as stream count. */
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+
+		if (assignment.valid)
+			valid_count++;
+
+		if (is_dig_link_enc_stream(state->streams[i]))
+			dig_stream_count++;
+	}
+	if (valid_count != dig_stream_count)
+		valid_entries = false;
+
+	/* (2) Matching stream ptrs. */
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+
+		if (assignment.valid) {
+			if (assignment.stream == state->streams[i])
+				matching_stream_ptrs++;
+			else
+				valid_stream_ptrs = false;
+		}
+	}
+
+	/* (3) Each endpoint assigned unique encoder. */
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct link_enc_assignment assignment_i = state->res_ctx.link_enc_assignments[i];
+
+		if (assignment_i.valid) {
+			struct display_endpoint_id ep_id_i = assignment_i.ep_id;
+
+			eng_ids_per_ep_id[i]++;
+			for (j = 0; j < MAX_PIPES; j++) {
+				struct link_enc_assignment assignment_j = state->res_ctx.link_enc_assignments[j];
+
+				if (j == i)
+					continue;
+
+				if (assignment_j.valid) {
+					struct display_endpoint_id ep_id_j = assignment_j.ep_id;
+
+					if (are_ep_ids_equal(&ep_id_i, &ep_id_j) &&
+							assignment_i.eng_id != assignment_j.eng_id) {
+						valid_uniqueness = false;
+						eng_ids_per_ep_id[i]++;
+					}
+				}
+			}
+		}
+	}
+
+	/* (4) Assigned encoders not in available pool. */
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+
+		if (assignment.valid) {
+			for (j = 0; j < dc->res_pool->res_cap->num_dig_link_enc; j++) {
+				if (state->res_ctx.link_enc_avail[j] == assignment.eng_id) {
+					valid_avail = false;
+					break;
+				}
+			}
+		}
+	}
+
+	/* (5) All streams have valid link encoders. */
+	for (i = 0; i < state->stream_count; i++) {
+		struct dc_stream_state *stream = state->streams[i];
+
+		if (is_dig_link_enc_stream(stream) && stream->link_enc == NULL) {
+			valid_streams = false;
+			break;
+		}
+	}
+
+	is_valid = valid_entries && valid_stream_ptrs && valid_uniqueness && valid_avail && valid_streams;
+	ASSERT(is_valid);
+
+	return is_valid;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 8766b124d4b0..b4e986f736ad 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2241,7 +2241,7 @@ enum dc_status dc_validate_global_state(
 	 * Update link encoder to stream assignment.
 	 * TODO: Split out reason allocation from validation.
 	 */
-	if (dc->res_pool->funcs->link_encs_assign)
+	if (dc->res_pool->funcs->link_encs_assign && fast_validate == false)
 		dc->res_pool->funcs->link_encs_assign(
 			dc, new_ctx, new_ctx->streams, new_ctx->stream_count);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 5084289810e2..23af9640c544 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -212,6 +212,7 @@ struct link_enc_assignment {
 	bool valid;
 	struct display_endpoint_id ep_id;
 	enum engine_id eng_id;
+	struct dc_stream_state *stream;
 };
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
index 2472c9aed095..09f7c868feed 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
@@ -93,4 +93,7 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream(
 		struct dc_state *state,
 		const struct dc_stream_state *stream);
 
+/* Returns true if encoder assignments in supplied state pass validity checks. */
+bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state);
+
 #endif /* DC_INC_LINK_ENC_CFG_H_ */
-- 
2.25.1

