Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9732ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC3110E7FA;
	Wed, 14 Sep 2022 03:34:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 628E610E7F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqziXdxGdOL1Ii0iL1D7uXK+/ns6F0gGyjwzliqIkBpEKmaWGvjKZm/9z8YYysAxTtu1nJAyukcbdvqj7699vtFuoLNhilGJM4LrhHm2+HsksK/rYd+sNtSsukzknu42DUIik8gZs4eqLOzLEM3OxdbeYzm1UqV2UNUFox+b6qd1JNp2t4Y3zbyPnMCNc/hVB4GOIkLMyZkf/azTmZUxiyr+KOJsZ0l5EoojOv3bD1a3xCpkbEjcCryk6+Asg75PdHAPo63NZysyvzOB2TOMhTPbitQVf6T6E0vlVT/VGYWxg4635V3DUOL3SgWIuSXGl0XQAT2TG3DKmYD6V/0tGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5D/kWN32UWc0bccXRYLkW4B9d71JkKKfDfnFIqrDsg=;
 b=VH4s2Zni9AvCZ3zrZUb/EN4Z0XSZEia7p20Ov7qC6NDmvOLqf9MihWI3FEu8rJW7Xdx32pEbhmlQWNyCNmi8H8RdsPkGEPwTf5XMm4IDZzC63p5Pq+BZBHCiPGC8Ki9zKZGYwhhA9vSmhY/X2T/mDNki3ua5VeNA9TeTRIrnBMqIyunjoBKmRCnxP/tX/200p8Popu3XtPFU9ld8rFRLPr54XBUpzTuSU5HMp8OSM79zGZHJX7BWQrMVIPJdMyMVf/0tTydo0AxP/QMhr+bNJOyhFCz903AJRXtUnCCGmvFKWmg19u7/gVeID5Lz7UVrD7ZUAVMXapQAIGS6p1HenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5D/kWN32UWc0bccXRYLkW4B9d71JkKKfDfnFIqrDsg=;
 b=bPWMb1NSiSTZPxCmG2griq0ZQ2rEhaCaPp5byDT1n2q++wkA/bmgE0EcICeQRP+c1mnVkJNEScN0+AzAlEBB6lKFXDFPuEfky1W4N6PToTeVXbOlqp4WJXpholr1o6elRmpy5VZhwHfQNy934XSW8Bhzv9kq/WgsXOBH3SuFWWM=
Received: from DM5PR07CA0054.namprd07.prod.outlook.com (2603:10b6:4:ad::19) by
 CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Wed, 14 Sep 2022 03:34:05 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::d6) by DM5PR07CA0054.outlook.office365.com
 (2603:10b6:4:ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:34:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:34:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:34:04 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:34:00 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/47] drm/amd/display: Expose few dchubbub functions
Date: Wed, 14 Sep 2022 11:24:21 +0800
Message-ID: <20220914032441.1075031-28-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|CH0PR12MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: 054679a3-52c5-49b5-dfd3-08da9601f9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cw76v9HRulvjE9oAh0xkeO4mBf8ApIeDJaMuZ7dGGbJoj9Ot8BWYBhhcXJTKAbd0NTDxr7pwLcrsYE21rbm3aVoEoZUHKddt/+T3snMvGoEWWRRIm6nMJyWEUT9XKiwXMSnSqydf/uMgdESsobqLSZ89NDoxQdFHbujLrjcSD/4ZV+/KU+JIWQM9kpTkM67bQq4p9qZAvn4SXJ4r1LgnrTS4Q8bdbFllNs9Q/kMdAk/8N155hxYr5Z2043+jEd/gL7OE9XQF6a1lnxqcRJax/JS+S5evbtj1IJSwewqd4+VAMUia37sMyCUdS4KH8tPPy1FCz9HyPo2rmifKgB1x1kyWUsoCwtgF5aSLofQfpM5Es3K5hUQBQBukwgcqNWaE+N7Ga63w365bW3iVW3TgfcDa1/A5Q+ZxTX1wSyQiN8W0uxHhNK9hdOaqnURumj7HQwlIeGFisRKuBHN/9b2sUdDSBFVFT4xCCI30wAek8RSgNUHRYSNDZQ+7zo2qfc4mGTow+GIqJTbPXajN/osB0BChzBdhN+31OewqknzO2EhPm3wGw8vHrGu6FBxMOhKJd+Ph0RPDZgY9FMIM33qJP1rLnqLwUOHkHPRoSnVk2gZjCppiruMZMgIeHQ1KyY1IMFuBHc2pX+nXV/KqvBeUWvPFpFpPGNb4u/ZCpkbvx6jocs6jTxMU+k6iawdTFDpumYLKiXBBCH8N/xoD22QtE0/kuSVzvsoUKpWZdqSMtqsejHuK8010PjKOhtEiPkxdW7vYiS4z57SOekzhkQ95XdcC9OdQ7ff2D9GFLtIkN7Jex9urqeRHtnHaAiUju29D
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(6916009)(316002)(82310400005)(54906003)(41300700001)(70586007)(2616005)(7696005)(336012)(36756003)(40480700001)(4326008)(40460700003)(478600001)(186003)(2906002)(6666004)(70206006)(8936002)(426003)(356005)(5660300002)(86362001)(82740400003)(1076003)(47076005)(26005)(8676002)(81166007)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:34:05.3988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 054679a3-52c5-49b5-dfd3-08da9601f9b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
Expose few dchubbun functions in dcn31 and dcn32 to leverage.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.h   |  2 ++
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   | 10 +++----
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h   | 29 +++++++++++++++++++
 4 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index 51c5f3685470..6360dc9502e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -876,7 +876,7 @@ static bool hubbub31_get_dcc_compression_cap(struct hubbub *hubbub,
 	return true;
 }
 
-static int hubbub31_init_dchub_sys_ctx(struct hubbub *hubbub,
+int hubbub31_init_dchub_sys_ctx(struct hubbub *hubbub,
 		struct dcn_hubbub_phys_addr_config *pa_config)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
index e3a654bf04e8..70c60de448ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
@@ -122,6 +122,8 @@
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, mask_sh), \
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh)
 
+int hubbub31_init_dchub_sys_ctx(struct hubbub *hubbub,
+		struct dcn_hubbub_phys_addr_config *pa_config);
 
 void hubbub31_construct(struct dcn20_hubbub *hubbub3,
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index 99eb239bbc7b..3d3226aca2ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -68,7 +68,7 @@ static void dcn32_init_crb(struct hubbub *hubbub)
 	REG_UPDATE(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, 0x47F);
 }
 
-static void dcn32_program_det_size(struct hubbub *hubbub, int hubp_inst, unsigned int det_buffer_size_in_kbyte)
+void dcn32_program_det_size(struct hubbub *hubbub, int hubp_inst, unsigned int det_buffer_size_in_kbyte)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
@@ -140,7 +140,7 @@ static uint32_t convert_and_clamp(
 	return ret_val;
 }
 
-static bool hubbub32_program_urgent_watermarks(
+bool hubbub32_program_urgent_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -330,7 +330,7 @@ static bool hubbub32_program_urgent_watermarks(
 	return wm_pending;
 }
 
-static bool hubbub32_program_stutter_watermarks(
+bool hubbub32_program_stutter_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -476,7 +476,7 @@ static bool hubbub32_program_stutter_watermarks(
 }
 
 
-static bool hubbub32_program_pstate_watermarks(
+bool hubbub32_program_pstate_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -629,7 +629,7 @@ static bool hubbub32_program_pstate_watermarks(
 }
 
 
-static bool hubbub32_program_usr_watermarks(
+bool hubbub32_program_usr_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
index 3bae6e558971..cda94e0e31bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
@@ -161,6 +161,35 @@
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, mask_sh), \
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh)
 
+bool hubbub32_program_urgent_watermarks(
+		struct hubbub *hubbub,
+		struct dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower);
+
+bool hubbub32_program_stutter_watermarks(
+		struct hubbub *hubbub,
+		struct dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower);
+
+bool hubbub32_program_pstate_watermarks(
+		struct hubbub *hubbub,
+		struct dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower);
+
+bool hubbub32_program_usr_watermarks(
+		struct hubbub *hubbub,
+		struct dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower);
+
+void hubbub32_force_usr_retraining_allow(struct hubbub *hubbub, bool allow);
+
+void hubbub32_force_wm_propagate_to_pipes(struct hubbub *hubbub);
+
+void dcn32_program_det_size(struct hubbub *hubbub, int hubp_inst, unsigned int det_buffer_size_in_kbyte);
 
 void hubbub32_construct(struct dcn20_hubbub *hubbub2,
 	struct dc_context *ctx,
-- 
2.37.3

