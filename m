Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64FAC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 16:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AADC10E787;
	Fri, 18 Nov 2022 16:59:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5ABF10E786
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqxLXpj5H6lEqJ+Rmxy4dDwx1pqVUbNvqoO/ZroG8Vq2E2t35/Bs4SuHtywtO2q3Z56my9/4Aeurb5/SwGrROQFaJdKmRSnc0xzLQLmDsu8KvhlMA7QRzzrQWM8MQoT+mEK9/T8b6q+JoYjzAxwbbBVFyQVs8OUJEDJIqJEL0A4eZKbPOCAmqbSQAwLgtV3FtMcIJyX8ewy+bkNXn7ROac4VR+eCX5LAxsOK9BiOpZYAV7vh8OYYZd+c/hMJJVct+duWOe4wITvh3dBYavhaqlAyeZE3K3xH3JDafEFLnpAu03gQNDZ94dS1/CeD7g0qCrxB99h13Fu03859lpJsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SqHd/C0B/Nlyka5+3fAOOMzL6I4ZzpYhDrTU6rAXes=;
 b=W7/rPQo9VyBqG1vUdLSV7rpYNtboUfJZ6xYCfnr6ML1FRFbTi+A4TkEIH3FZpGIAxshnuLNPYG0xDGUMW1fGPQmEScGQRjscbOxdF+ixm8TVFYKCKHciHeMa9iqCwD2EPIS5qtpb1o7H5MtalLhsiFrEE2jS01YJVq0fqHWVjNP4wgE9mCrCDHXiJixLGkLBFnQAY3kZawqdzlezYFNsV12R05jM7V5X03jdh+Fh0WfutClYNRAIbeUP6g/AOXOqciEsfLQDXOEuuj2qJ5cIofudUv/AR9n7sYy0XOg2H48xcPmlBE7n2Bl8ciRcLnLKpbPNYJlYzJHI0APt3pxY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SqHd/C0B/Nlyka5+3fAOOMzL6I4ZzpYhDrTU6rAXes=;
 b=oTqTfIgTsuSABPdGCMRUKu6+rxvN4mxymV8NVuMbNAoF3wdl9OUg8TtYDTI0zJce1sW/37VNDJraFu+R7cW1t2VHPgspHcXll0Xp3pA7Q/Y/svbF9hpNitmNe93T/uvOoeUfMK/8mFfuxVxEF8YWjyIXU0D8oil9p13oofd8f7o=
Received: from DM6PR06CA0032.namprd06.prod.outlook.com (2603:10b6:5:120::45)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Fri, 18 Nov
 2022 16:59:44 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::ea) by DM6PR06CA0032.outlook.office365.com
 (2603:10b6:5:120::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Fri, 18 Nov 2022 16:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 16:59:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:43 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 10:59:39
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/22] drm/amd/display: Add Z8 allow states to z-state support
 list
Date: Fri, 18 Nov 2022 20:59:19 +0800
Message-ID: <20221118125935.4013669-7-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c01f0f4-521c-4f27-ad96-08dac9864abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2RfL94r6UM0jG9bYWw0CUoquuwiL8s/+OqntfaD7QFB+KeACAEqXVPdV8R2dmS3bBYKXfK7NW0okMq8o4EK/y1j2FVFmC4gXuiV7sRutb+u5Zqm/PzSqFlG61gmloMXfIstiniL/87J0GdFO/+x3QgyJYHodsQFDvX/tE8BRE2/vE/sfnvW+PmPI1Pnth6D8KL9UGqEyuHl861yWCBW8dH5ecWgRz1V9xDM6LCVM3X/5tTKR5PnHMcBCLWSmjsxJVNjmPrNCtdNlizE1dv2tGcyi3Atr92LfuUrp+/lJSeiz/xtVNANyZ/wzvqaOFm99DPboVdozkXGscFasicvSuh/SabMuWsZoKAMY9hJDNtNYNDKZq8NO194Y79Na8dwes54+w9aFSrSk/7aqV6nS7MbY0Sa/mEA0piIEBqwgR9bgKE9v9ZiFulq7KIMivscxJ5y9KHZMZiWRqbEQw68X6OBd9jrGzWFcChMmGAKvCdZT2OeVITXFe43nTQ7FA+k42dP/vHx3QDo/pI75zPMsBIVAM1FAiPFMprC1Z9r6S+slKtVMjCFYGOdzdNMbA0+vSsq3G4yg+Kr00k7O1R8LJLxD/UGzvwcxL+P9AJhY7ndveQnmcmKmgRUKf7ZtZVAtTjzOm8fQVYIrzUZ8dXlBNJ9vOqURuUFzFatm5TL9cYDPCVAPucoGuayaRHWAeuIn9dej4TIrl8JduSyFnRB4ioZufX7gW7J0l3cOIvoF71cF7YsXEMz+0rx8bTbew36+t06GW9V7X/DvfhBXgmaeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(82310400005)(26005)(356005)(36860700001)(83380400001)(81166007)(86362001)(40480700001)(7696005)(478600001)(4326008)(8676002)(6916009)(5660300002)(316002)(41300700001)(6666004)(70586007)(54906003)(8936002)(70206006)(40460700003)(426003)(2906002)(336012)(2616005)(47076005)(186003)(1076003)(36756003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 16:59:44.2245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c01f0f4-521c-4f27-ad96-08dac9864abc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Even if we block Z9 based on crossover threshold it's possible to
allow for Z8.

[How]
There's support for this on DCN314, so update the support types to
include a z8 only and z8_z10 only state.

Update the decide_zstate_support function to allow for specifying
these modes based on the Z8 threshold.

DCN31 has z-state disabled, but still update the legacy code to
map z8_only = disallow and z10_z8_only = z10_only to keep the support
the same.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c |  4 ++--
 .../drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c   | 12 ++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h                  |  2 ++
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c | 12 +++++++++---
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index 090b2c02aee1..0827c7df2855 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -333,8 +333,8 @@ void dcn31_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zst
 			(support == DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY))
 		support = DCN_ZSTATE_SUPPORT_DISALLOW;
 
-
-	if (support == DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY)
+	if (support == DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY ||
+	    support == DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY)
 		param = 1;
 	else
 		param = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
index ef0795b14a1f..88fbc5aabc74 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
@@ -339,8 +339,6 @@ void dcn314_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zs
 	if (!clk_mgr->smu_present)
 		return;
 
-	// Arg[15:0] = 8/9/0 for Z8/Z9/disallow -> existing bits
-	// Arg[16] = Disallow Z9 -> new bit
 	switch (support) {
 
 	case DCN_ZSTATE_SUPPORT_ALLOW:
@@ -359,6 +357,16 @@ void dcn314_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zs
 		param = (1 << 10);
 		break;
 
+	case DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY:
+		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
+		param = (1 << 10) | (1 << 8);
+		break;
+
+	case DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY:
+		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
+		param = (1 << 8);
+		break;
+
 	default: //DCN_ZSTATE_SUPPORT_UNKNOWN
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
 		param = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1f6dff9904f3..be2a62f4df32 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -493,6 +493,8 @@ enum dcn_pwr_state {
 enum dcn_zstate_support_state {
 	DCN_ZSTATE_SUPPORT_UNKNOWN,
 	DCN_ZSTATE_SUPPORT_ALLOW,
+	DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY,
+	DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY,
 	DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY,
 	DCN_ZSTATE_SUPPORT_DISALLOW,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 75dbb7ee193b..c4eca10587a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -949,6 +949,7 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	int plane_count;
 	int i;
 	unsigned int optimized_min_dst_y_next_start_us;
+	bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > 1000.0;
 
 	plane_count = 0;
 	optimized_min_dst_y_next_start_us = 0;
@@ -963,6 +964,8 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	 * 	2. single eDP, on link 0, 1 plane and stutter period > 5ms
 	 * Z10 only cases:
 	 * 	1. single eDP, on link 0, 1 plane and stutter period >= 5ms
+	 * Z8 cases:
+	 * 	1. stutter period sufficient
 	 * Zstate not allowed cases:
 	 * 	1. Everything else
 	 */
@@ -990,11 +993,14 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 		if (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000)
 			return DCN_ZSTATE_SUPPORT_ALLOW;
 		else if (link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
-			return DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
+			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
 		else
-			return DCN_ZSTATE_SUPPORT_DISALLOW;
-	} else
+			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY : DCN_ZSTATE_SUPPORT_DISALLOW;
+	} else if (allow_z8) {
+		return DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY;
+	} else {
 		return DCN_ZSTATE_SUPPORT_DISALLOW;
+	}
 }
 
 void dcn20_calculate_dlg_params(
-- 
2.25.1

