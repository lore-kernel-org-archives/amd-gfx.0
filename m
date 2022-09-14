Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B847FECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6DDC10E844;
	Wed, 14 Sep 2022 05:16:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC56310E837
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz6HMQzIKOHkzGu/RFThyVE0CUJSd17rwfPbzrtOe8/Ox41dwBCAJEMQU7UylMNWwDyMhzG5NlMajTkIKF5LHVQrpHMh8ypzfQlmb4O5of8r1eZiPi+AYtWDLHefdvshXIOeFAPEjwaxTCbxy8PS/lxFmS+l47T/q5ccR+KwRjtY4Dtek1VuBnGPhKk89VySDVGlKX1BenNyvW5g+wzMIJ6YXxYpB4MapjOLP/mK5CzKLUWxEkegUpyVhPJ4cJ8tISqg1qrvWjqPozHltpjHtatsoShItDzfS1hCbZyxjudoF/27B2qaJFH2RuqIij6AzuKhulbMoveL1lD6FsshgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5D/kWN32UWc0bccXRYLkW4B9d71JkKKfDfnFIqrDsg=;
 b=Hftqsyz+ykvTb40AiNhRhX6A8Y1OiRMhkSigs57l28fbUWhy+MvhjDYw3C7dJmvmodtQRfn1AnGHPz1jI3S+HEK1HGD6B3zNCd62r530VDHCSpSk2l4RkilC5HO7pfO2vmQ1UhDOEfVMqk/C856dD8Ji3MjOmXIpjSBJFBo1oGC/QKQXvaCO7MxFb5NOnf4w/Ev0JIy4fQbCc0djONomJrkBO0tO1UjknaQAgeogUfp41j/Z8odueN7D6tSdJkR41i8jNSi5MqvUAOROrYKT3zDoZOX/17ypIvt/0VFd8IiIOXH6hoh3Ap7igKaOhZ+hIcle8HnaWRdNpjklDWlV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5D/kWN32UWc0bccXRYLkW4B9d71JkKKfDfnFIqrDsg=;
 b=Gvt8ta1oMaae5CaRFNZqp5yK3e8yt+4tVvAvi0eh2M8RNGRQ3fJmtthL/Gkk0MZ+AWygSA9l1TR2cKdvyz/xw4lKv1Bj7ia73082FIKPq6BmkwhvhQvs4751BazA0RCFBnv/ZK3YU9agbDm4YmsaQ1KiWdC73zVYSF5/pA1T7Zs=
Received: from MW4PR04CA0190.namprd04.prod.outlook.com (2603:10b6:303:86::15)
 by DM8PR12MB5479.namprd12.prod.outlook.com (2603:10b6:8:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 05:15:47 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::dd) by MW4PR04CA0190.outlook.office365.com
 (2603:10b6:303:86::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:47 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:15:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:15:38 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:15:32 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 27/47] drm/amd/display: Expose few dchubbub functions
Date: Wed, 14 Sep 2022 13:10:26 +0800
Message-ID: <20220914051046.1131186-28-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5D:EE_|DM8PR12MB5479:EE_
X-MS-Office365-Filtering-Correlation-Id: 7605ff01-241e-45e9-6b89-08da96102ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90kGU/7EvJBsY64h6CNWbT07tRat+lpyBnZ4IXW0NEm+7rCK486pnE+EnOSY8LDjMcQ1GZRo9tgT6R+2UQg59BPgZXjm86EsOIafGp9I7Mx797e/9TtLeR/rqM/6S6aY7uM3mFYDGaKfCvGQI35q1PfulgxJ7aFaKW209oZzPxl++Zc5JYRKEAKXLeY6FaL/+JYzvYNks5BodDXLvKutjhefd5n+N9PNGDlj4cp4gD223qaew5/IYv3hVkpDLF0PCOBbR66UxKV2DeBzc1Bu+qYF1sftAqfQIZ3ynSkzOlIpcsGQ5ucFbHg/SrdbqXyaCLJ7egqWWjBUGtWMWzIjcxZSEcNNdhQfixUO/r2YsOVJmhheZ7HmQ+sGMLDpTN/REcPou2JAJvAUfd7ElI+P9rWrKcpKYvvP/6rO8xW4Z2M5ng2BHeAlEGMc0ZMSRkAvK9hh7dyexM0p01nKkWdtPW12xJBxJVuVo7yIzSBtLr7XmBqyDSQCyq1CWDAMwwPZi7G91mskteXBFBNby1YziGbbmnulGez14Ytvrb0T7pHwMdQ2VaJx1TfcNOPsAQbNGT9Pq/Saok/asHJxIviv7nSfNRtZViPWqgSLmtSHJi1AXBqQUjq19pfpXcg2+H+z9Eq2+CDdshkpp5xQYoQb2rdFR9E5GIiTGo51VggbfDV7FuG46Z76TCEeAGx2AozgulXDCbdUD+/aWT0cj8v3e1SiwZJ2N1Fc4TUYUN59fTjShO5DlebZpiw26Bh6q0RESCpN4zHwlFJZZujvd+5DOvgiWdomJqCq5eL6kkXnNHmbBx/t/jkj9M0Gi441o0vm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(4326008)(86362001)(7696005)(478600001)(2616005)(8676002)(426003)(26005)(47076005)(5660300002)(40460700003)(2906002)(316002)(41300700001)(6666004)(70586007)(36860700001)(83380400001)(81166007)(82740400003)(36756003)(54906003)(40480700001)(6916009)(82310400005)(336012)(1076003)(8936002)(70206006)(186003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:47.0289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7605ff01-241e-45e9-6b89-08da96102ea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5479
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

