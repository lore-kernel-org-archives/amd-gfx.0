Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15C4C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10DC4A99A2;
	Fri,  5 Aug 2022 18:01:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9457B9347
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjTWq8uRr3VYyBWmicenON0XobZmcDtSB4pRsplihQa78dBN8gF/ta/EXFVQpocPEGFrnDOi+mVnrv/DZQpM4u2rRNPuYM8ozPwcWXStl4aI1jcW52wriOj8SZyowrRcy/jOOyP0eZDYEoJb8IypoDL2/by4P3KQWg3MG6pjM3TUIR9i8tRGnqSqntivnSScyaNXrll8aik5p6AeSmQvoPnVzvdyR3nqG2NmQKwWMfa4NDBbpsBjaQEf7Q/rSjs4g6nAct4wM/7KP6M3aMCTZQP4SqPDdydEjn2jNtSki5s2hgALG3ruePBzoohtVNrXuzCjhOM6Pfigavs5qsTdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Anz6EuphuiTIxAA3AM+HF5i2eJ1hUuFL9bT2VJy5Nnk=;
 b=jR34NO/SFk9t7tSWznzr4lQA1U3wDhZnv+7AOZcmhJOLMm8xPaL5AFcXGKoB5FQLk/o/hN70JQaWOFWJJltIdkb6eXad0cD0oXXOqZW/UXcod5dQ3y6gkaMI1zhzYa3PQdHwzkLtZ3QctkGcUJEypN/uo72U53Wevc3t8ZZzDvY56XNV3NOAIxQ5F6GplJVpwKomki0BqZplLx6Gi/LoI0lvIKqMk1p+97ZKvOwhjljPjzWAx9L/gfBIT/J8kwwJKtPU5hhB7kq8Z0r1shLKYuZzrsM1H3p0e6nMkuSmxyr4Nd9QEYecmq1fJ1hsYnEUQwaCQ1AdIRrRGHnoTMeEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Anz6EuphuiTIxAA3AM+HF5i2eJ1hUuFL9bT2VJy5Nnk=;
 b=JyucLEPcAyPvkfQG7iTcHIZ9AfnY+Fyy4FRVkNCVOsvT8Vg0v/vC4bz5ggD1awMiv7AAstyeAuNfDkT3LDwlgqzBepviN1MXktX8sw1wYdVoR8cJVUAJ4RmpCt8mZPTIItNu4ByjpJNDJtJ2gZLS6IGBEbY8YJBlq5G9hkpFDJQ=
Received: from DS7PR03CA0169.namprd03.prod.outlook.com (2603:10b6:5:3b2::24)
 by CY4PR12MB1317.namprd12.prod.outlook.com (2603:10b6:903:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 18:01:44 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::d4) by DS7PR03CA0169.outlook.office365.com
 (2603:10b6:5:3b2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 5 Aug 2022 18:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:01:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:01:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:01:43 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:01:38 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/32] drm/amd/display: Don't try to enter MALL SS if stereo3d
Date: Sat, 6 Aug 2022 01:58:23 +0800
Message-ID: <20220805175826.2992171-30-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c816862f-cd66-4172-5cff-08da770c8ed6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1317:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Il5YopjK8G8dWTNlqIGICz1G4eSH2KewXVQrmdewGYXd+g8KTnWyNF9cwMqqy/gJvtRqY9imrz7RLqRkrzeT8rv7DoTVMr0bbxAzOguSWft/vVl5gPKEwvPJNIYnMm9NNuqRNCIZyQuJuY8RpLRj9LH0di3NbhynQK6PiMYBm525l5D48xK7/ZJIYf+3NS1OGHRFa7D7NRXWXK8eEsJ7FCCzEbu8/eAsEi9m+VUZtwbnWNNbOLZnZx0hPbeGirziPuwZ8J9zil8vZoJHJ9jkShw0hbtZwxFfdvYlfUoMzGXtBnBThLGWb894tvq30tUj7jRlKD4OqmItsXD78Flv+rzhmsaPL8Y84wyokXjGU75gUe0ZmA9GaEIPEiZLcAm6NqdA12kIRJ5sCm1Hz5I9XLSs8qNf+9JABVxP1VGzMyFzuhgBWFOQEuaehubPLOgpIPQHtWaA0TN3SZRNoY00HU78hu1rTZziGXWAbWoj+NsBw6MWb3CYoyT8ES/bc9To2poiP0b8i+IU9y6ut+eZ0pHTvuTlgLPZ4rUn0NsdqLcB8l0k7vSSUthqwhrto6Dln8XHXTgX/CXrVFX/5l7t6UOq90DnPNAnV+tQbbsisV2LELLUiT2PaVyLwRm9GcGx68rryrlhvF148Misz84SNd4FEouc+HGW7nCwIEtylVCYTNwo4TJSIcH77KNP7J0qSFaHhQ+NYuPBTwDCDnNYGbQBOJtZZFxyho4cXsH1CRc91JvtBZQLCDg89US78cBwSGrK1KmTfvSNcu1NAlyTbi1SR98+3OF8Jp8vw14IFM0Dg+PG9TRZCODcFH6P71ac0Bg73mjBeI+Fb8Ep/5QkMef9IjqACR+3NP1spa/qR2Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(40470700004)(336012)(2616005)(1076003)(186003)(426003)(47076005)(7696005)(6916009)(316002)(36756003)(81166007)(2906002)(70206006)(70586007)(8676002)(4326008)(41300700001)(54906003)(36860700001)(478600001)(82310400005)(26005)(86362001)(82740400003)(8936002)(83380400001)(356005)(40460700003)(40480700001)(5660300002)(6666004)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:01:44.4978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c816862f-cd66-4172-5cff-08da770c8ed6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1317
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
MALL not supported with stereo3D according
to DCN doc.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 5ba503d80728..4aecbf230446 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -331,7 +331,9 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
 {
 	union dmub_rb_cmd cmd;
-	uint8_t ways;
+	uint8_t ways, i, j;
+	bool stereo_in_use = false;
+	struct dc_plane_state *plane = NULL;
 
 	if (!dc->ctx->dmub_srv)
 		return false;
@@ -360,7 +362,23 @@ bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
 			 * and configure HUBP's to fetch from MALL
 			 */
 			ways = dcn32_calculate_cab_allocation(dc, dc->current_state);
-			if (ways <= dc->caps.cache_num_ways) {
+
+			/* MALL not supported with Stereo3D. If any plane is using stereo,
+			 * don't try to enter MALL.
+			 */
+			for (i = 0; i < dc->current_state->stream_count; i++) {
+				for (j = 0; j < dc->current_state->stream_status[i].plane_count; j++) {
+					plane = dc->current_state->stream_status[i].plane_states[j];
+
+					if (plane->address.type == PLN_ADDR_TYPE_GRPH_STEREO) {
+						stereo_in_use = true;
+						break;
+					}
+				}
+				if (stereo_in_use)
+					break;
+			}
+			if (ways <= dc->caps.cache_num_ways && !stereo_in_use) {
 				memset(&cmd, 0, sizeof(cmd));
 				cmd.cab.header.type = DMUB_CMD__CAB_FOR_SS;
 				cmd.cab.header.sub_type = DMUB_CMD__CAB_DCN_SS_FIT_IN_CAB;
@@ -694,9 +712,11 @@ void dcn32_update_mall_sel(struct dc *dc, struct dc_state *context)
 			if (pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
 					hubp->funcs->hubp_update_mall_sel(hubp, 1, false);
 			} else {
+				// MALL not supported with Stereo3D
 				hubp->funcs->hubp_update_mall_sel(hubp,
 					num_ways <= dc->caps.cache_num_ways &&
-					pipe->stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED ? 2 : 0,
+					pipe->stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED &&
+					pipe->plane_state->address.type !=  PLN_ADDR_TYPE_GRPH_STEREO ? 2 : 0,
 							cache_cursor);
 			}
 		}
-- 
2.25.1

