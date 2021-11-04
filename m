Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CCCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E3D961207
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E3D961207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1813D73794;
	Thu,  4 Nov 2021 20:52:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7AD73794
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGMi1xOcX5xfDib6ovLNLzNftgFB35b+kyC1eNejTJaALQb/a5HC8VWb+iDPiG0UyZ61xizpVw/BJAII4bNTAMkNzxmO2GQ2a4bG0rfZ1skM7uLwTkxlPQIx96C4+nSYRqPkA4U/Rs8h/8fi7auU5brrWEidqOM4M1PoLxbXJEKa6BetFb2lHz+nhp6FcXBgtqBTbAUhKbk6wpc1Fq5i10rawOALxqVq/bn1Disux05Hc1N4vwLAo23szsOH5PwLEbi3v/tULYDTyVEfX5Iz46gC7NNQ/QbMHk374fIBOHfDb7G21xOFolBi71vnoSo+ZyuDsYnoYq11kmFUvALKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEFOX4PKTtFpLlUPQ6oMxT81kjPFMtSUfwmmf0rCEns=;
 b=TeekEwbRljSM0VIIY2aOR+hc/BWsLGJLveCBvY2+F6rBq+TMwE5TiV4uAOPmmTzLv+707R+bEmVzjK97VgEynOAT0r1NxhqlK2lp/pDLrD+M3L4G9haOh08i1kYyUAPIiwNlAXoSRNRIZ3tgcI+M0lKNskaqJ7tI5ejpZTkXwrB3LlZLNonNaYyaqUSQUsxYOrZBa/dUwPQpAZ1ik9fhdgRigBHY8H12DEPE45G3uyXG8W46hoLDDIJ5+tdwqGGdWe2JMrL7z5xytCsCq6HuG3lI6ltlF2DEiideKSAU/vfJMBjZp3ntpfnaVcW8NU417dCLfNiDLLKBEnCxFqztfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEFOX4PKTtFpLlUPQ6oMxT81kjPFMtSUfwmmf0rCEns=;
 b=vrd4UnwKEGtqFrARnZCqJj52/w/2Abi4G2UyTLeXynI8ULBhsZQ84/WMDE7WGmIC4+Kz5qAivCeyeD9SY9/raBRWO+f+kpSAFtZZViHVReaVbnsWjXdhRxld/c27kXfJBzvVd9Da7GAOru/udK4Xb2DMRYsPe789Me27UYnc3Ls=
Received: from DM5PR10CA0005.namprd10.prod.outlook.com (2603:10b6:4:2::15) by
 BYAPR12MB3320.namprd12.prod.outlook.com (2603:10b6:a03:d7::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Thu, 4 Nov 2021 20:52:44 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::60) by DM5PR10CA0005.outlook.office365.com
 (2603:10b6:4:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:37 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:36 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/22] drm/amd/display: fix stale info in link encoder
 assignment
Date: Thu, 4 Nov 2021 16:52:04 -0400
Message-ID: <20211104205215.1125899-12-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f004d89-d075-4db2-2193-08d99fd50cb1
X-MS-TrafficTypeDiagnostic: BYAPR12MB3320:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3320BF1ACFDFA120452ADBC7EB8D9@BYAPR12MB3320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYThLL4k09Suak8eYLDpZzID+UqCbQPMvp5tIKs1e8M1X1ZhkWJ6rFKGN22/izO20hTROB8uKIakmdYU7pNX7drVE1t/hxpW+I3qZYVt567hQbtRFLMtuQtGHhetf0AJYpO6bkRzhdspIXMloLoDh8OHwId/oy1aG2tPNm2hR+O9W+quS9mT26gsotoTMm0bd6cS8MHirQi1H3eAcFaYxc3XJ4gVerZlu7Shr1VuLXovEAFqqSuSYQnQm5GX/GWCzxDzZwjofQjTK8HVPsZeB7GWk9Va2l2ofeqOOtpanfIgoAlWZHSBLJd5MMgBgrhP8XawHNQStL+RN8dmMazk+/MFPtenEFzRBUZYjhm/sottcDnc7TV/EvhLzge8BnFDf6t34+lrESTNPz0KbRW3ZR7Y4icNKt6l2Bfq9mRm9f4cYlkROktRvXwKmg9Hr8jO0tmAcqPiWxmhfYxnpJHStczPIYOFyCHB/f/VxThfU8pliD/vjqFcVs2983/R224FofA2FI9zgvoS/sQcWjWzrOq364OiVYmoOicl5Fo8Dgcq93NgjtVIkCAM8VsKlifEnELxfTvHeLdXk9nqBcOc/sNHxdy/7Mr7uRJUYS5dbOE+ivH7Bg5ui3qPxfYveJpaoW5ODF1RX1WAcq4uPQJThAgG/95bQSRUS9icOigBV98CxylyHsfLLfIbkB2TF8qXx+wWdbG3LwjWmNOaqOAk9pxWAKWNE5MCHC3AH9XknFg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(1076003)(36860700001)(426003)(36756003)(336012)(82310400003)(7696005)(5660300002)(2616005)(2906002)(6916009)(508600001)(8936002)(86362001)(83380400001)(81166007)(54906003)(26005)(70206006)(8676002)(186003)(70586007)(4326008)(6666004)(356005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:43.8561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f004d89-d075-4db2-2193-08d99fd50cb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3320
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
Cc: stylon.wang@amd.com, Roy Chan <roy.chan@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roy Chan <roy.chan@amd.com>

[Why]
The link encoder assignment leaves the old stream data when it
was unassigned. When the clear encoder assignment is called,
it based on the old stale data to access the de-allocated stream.

[How]
There should be no need to explicitly clean up the link encoder
assignment if the unassign loop does the work properly,
the loop should base on the current state to clean up the assignment.

Also, the unassignment should better clean up the values in the
assignement slots as well.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Roy Chan <roy.chan@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 36 ++++++++-----------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 25e48a8cbb78..13a9d55930ed 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -118,7 +118,10 @@ static void remove_link_enc_assignment(
 				 */
 				if (get_stream_using_link_enc(state, eng_id) == NULL)
 					state->res_ctx.link_enc_cfg_ctx.link_enc_avail[eng_idx] = eng_id;
+
 				stream->link_enc = NULL;
+				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].eng_id = ENGINE_ID_UNKNOWN;
+				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].stream = NULL;
 				break;
 			}
 		}
@@ -237,28 +240,15 @@ static struct link_encoder *get_link_enc_used_by_link(
 	return link_enc;
 }
 /* Clear all link encoder assignments. */
-static void clear_enc_assignments(struct dc_state *state)
+static void clear_enc_assignments(struct dc *dc, struct dc_state *state)
 {
 	int i;
-	enum engine_id eng_id;
-	struct dc_stream_state *stream;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].valid = false;
-		eng_id = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].eng_id;
-		stream = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].stream;
-		if (eng_id != ENGINE_ID_UNKNOWN)
-			state->res_ctx.link_enc_cfg_ctx.link_enc_avail[eng_id - ENGINE_ID_DIGA] = eng_id;
-		if (stream)
-			stream->link_enc = NULL;
+		state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].eng_id = ENGINE_ID_UNKNOWN;
+		state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].stream = NULL;
 	}
-}
-
-void link_enc_cfg_init(
-		struct dc *dc,
-		struct dc_state *state)
-{
-	int i;
 
 	for (i = 0; i < dc->res_pool->res_cap->num_dig_link_enc; i++) {
 		if (dc->res_pool->link_encoders[i])
@@ -266,8 +256,13 @@ void link_enc_cfg_init(
 		else
 			state->res_ctx.link_enc_cfg_ctx.link_enc_avail[i] = ENGINE_ID_UNKNOWN;
 	}
+}
 
-	clear_enc_assignments(state);
+void link_enc_cfg_init(
+		struct dc *dc,
+		struct dc_state *state)
+{
+	clear_enc_assignments(dc, state);
 
 	state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_STEADY;
 }
@@ -284,12 +279,9 @@ void link_enc_cfg_link_encs_assign(
 
 	ASSERT(state->stream_count == stream_count);
 
-	if (stream_count == 0)
-		clear_enc_assignments(state);
-
 	/* Release DIG link encoder resources before running assignment algorithm. */
-	for (i = 0; i < stream_count; i++)
-		dc->res_pool->funcs->link_enc_unassign(state, streams[i]);
+	for (i = 0; i < dc->current_state->stream_count; i++)
+		dc->res_pool->funcs->link_enc_unassign(state, dc->current_state->streams[i]);
 
 	for (i = 0; i < MAX_PIPES; i++)
 		ASSERT(state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].valid == false);
-- 
2.25.1

