Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FDBC43217
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C7510EA17;
	Sun, 23 Jan 2022 18:21:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7901410E857
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1aKeNTtzSLTJHETulP94hPunRuQrs6ITZGoYrs6RcR9buXS+MG+rSExnv3fjwSlT5ay6u9UFm0rMIuKVyA62hjpSktWAQTtwL+z+SH7X2Q3exetBmM1RMSJPFZ5vyvnOlVjMMyFhq4MbBckhxabf7Vp7aacZM1AY3y6xGLkk9Ha6P8Y7seaPmtpOxXzE95QoWq9OrhKX1/0op1dSKNgyjyNMblzwjfB6WwVIvi3dQeSGPUI8q4flVx16HPmxX3ZrARDfnRKsQrLaY8n6JVyOs13/sUuIKtNppqx12fFuyb/T1l4CKg/J1ExzGznc1Zfr86AgMuzTfi9Qs4i1FxgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dRUC+ep5pCW7PLDOlhx9OC/8XJc/ZATiiZlpBadA6s=;
 b=QZFdn+ec5nJzmpDmE+ik2gEIennqmesP2g2jp6YOsexKLtnthc8G8AzBzrJviB7Nu2Rvb6uhsrdPIHkWLD/DOTNpQAbq41hczKHi69E+eyIuFRjzQKTx9z/ip+Ty/cPfzY8NMRY1C5XimSIE66IgVWNAdL77Y5dEzYVjMo+FR2Q7K9Jckk6Dp3xhNiZbttO9bkoCWb4mlpR64EZfa4CGKCeeziZ1gE8Zk+cURZPcr8K5R9CjWp3fBlR4b6yQ9F56LoqCzUNO5UQTrApHXs3UR6NvWb7mwPBfXye6vZlVx+w35rIQ6ynajLnt/xjIIMDMO58KJnLCfM6yf0TPWUZnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dRUC+ep5pCW7PLDOlhx9OC/8XJc/ZATiiZlpBadA6s=;
 b=YxpRD0sIW8ScKe93Z+7p1qGO3Rd3nWmAJfNTCrKr8wI7MVlPIYnfKw/AMdeodz5auiwJ7//hjo1ZQ/8aKxB6pvLcGdD5+ndQQlKF/GKfiOxasNqlO5OzY6vdQXFlMCe0Sh3wz49xIQyIZnfwMGiD50t5nSGMSHdYRvyqD6NFwYU=
Received: from BN9PR03CA0978.namprd03.prod.outlook.com (2603:10b6:408:109::23)
 by MN2PR12MB4829.namprd12.prod.outlook.com (2603:10b6:208:1b6::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Sun, 23 Jan
 2022 18:21:19 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::5c) by BN9PR03CA0978.outlook.office365.com
 (2603:10b6:408:109::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:18 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:17 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/24] drm/amd/display: add debug option for z9 disable
 interface
Date: Sun, 23 Jan 2022 13:20:21 -0500
Message-ID: <20220123182021.4154032-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df1cb72c-7217-4e9b-d096-08d9de9d26a7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4829:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4829CF5C77F3822887E325F2985D9@MN2PR12MB4829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AA4rFQR+ZzyCngHhvk0ZsoxwAVDJlQh7oRkWVw/IEaFXMtHyixJqhaN1FPhMaGCBmJmuOqcXhg29Uf1UdoEaveVIbXpWeuKDuX0V7+vxv7aIBDw0hdx93P1WKHTzPvAMdCzxTsejEiOY5i8yqJ9JUrPKIXp3kzm0QHU5XRSsN8to/DYxMZvmWynC72VPI/99yZ1RKPhw8sIwp9V+dZlj/MVSXr7Vp7AZQMkx2N+nlDOgvT06apZEa3djzOuwXhYCo89Cpg4sFG8Tp93r1nuNe0/qITV5YK1J0nIi9KCZUC/DE0TJNY4ev3R/phikz2fVVnhh7EpccQCoTjfGYv8t9Y/eMxgpAAER24qFDuHhTEtXTiotpzPcjiJvP0vuZs9qS0tiG8eCSm7K/c7L8SRcxPD8JzOci+WIu7bvCf1QDzgWwBXLPhz6Jrdt35N+islCJJk/dLgYuAiNIcqTn7W23PN4Gk4Jls+a5N5shkx4kf7W9IfEXjuvTBod4uwtXnIN1lVdDevlps0BtMilTXPSTZ0QBDfzxw4pdCXRCNm73eA4+VWGMTqvzunWCdR9rvog8VEXMVCNsN+TLkhFGifXfNae2dB/2lg3txMVEvGRTaPHHjoCEvZIEZ3Ah1YvNaozMLG30bt6lVpEyz/758+v8oJpuT1kifIhBlKJNqfY0rpu2L54hNozdXbihqndw+eZqcC1PfEc2bkrbL10xtH1jJAgVV68UsvzATdukfpKHqnzIPrNkDoc7Y/23hRC6WJtyE9XU9iUGn8ZeQHMFbi7NcMCekL2yz1fY9f3VLB2sXo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(2906002)(336012)(47076005)(508600001)(426003)(70586007)(26005)(4326008)(6916009)(8936002)(81166007)(40460700003)(2616005)(86362001)(6666004)(5660300002)(356005)(316002)(54906003)(36756003)(36860700001)(16526019)(186003)(8676002)(70206006)(83380400001)(1076003)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:18.8930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df1cb72c-7217-4e9b-d096-08d9de9d26a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4829
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
To help triage issues and coordinate driver/bios release dependency

[How]
Only enable the new Z9 interface when debug option is set, otherwise
treat Z10 only support case as Zstate disallowed.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c | 6 +++++-
 drivers/gpu/drm/amd/display/dc/dc.h                      | 1 +
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c    | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index 1c0415366216..9b4836350547 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -308,12 +308,16 @@ void dcn31_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr)
 
 void dcn31_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zstate_support_state support)
 {
-	//TODO: Work with smu team to define optimization options.
 	unsigned int msg_id, param;
 
 	if (!clk_mgr->smu_present)
 		return;
 
+	if (!clk_mgr->base.ctx->dc->debug.enable_z9_disable_interface &&
+			(support == DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY))
+		support = DCN_ZSTATE_SUPPORT_DISALLOW;
+
+
 	if (support == DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY)
 		param = 1;
 	else
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 69cf78fe78cf..4f9dacd09856 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -703,6 +703,7 @@ struct dc_debug_options {
 	int crb_alloc_policy_min_disp_count;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool disable_z10;
+	bool enable_z9_disable_interface;
 	bool enable_sw_cntl_psr;
 	union dpia_debug_options dpia_debug;
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 40778c05f9b3..7f9ceda4229b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1033,6 +1033,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.optimize_edp_link_rate = true,
 	.enable_sw_cntl_psr = true,
 	.apply_vendor_specific_lttpr_wa = true,
+	.enable_z9_disable_interface = false
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.25.1

