Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8470FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7095F10E6DA;
	Thu, 27 Oct 2022 18:40:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0EB310E6D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBx/TNQj8zr/BsDcSRoKValZwqDMhefkw4ODmv2rUpku+Lu5chmUPJFTs6sSlB8jvb+9NVZgEYMp0wG9vqdyt0sMIeHWC0vslthyp/Rzm7cLjWmxtFibIirrWjwHpMMkFKXhsM9XRYETucQqWtjbnGH8OGk8E5eazNcfCSOR0BBwYx8PBWPd+JEBIsByvosB0iFN6CAS5ZLJ981x56CUbLoCncNevsW19eV0+F6AOFKYe+0VdzGeS1RXa/xgy6YutGnOeHqSBaluRtjhOBnr1FonnjAZyjxriMbgZhEMCrkazKfjR9N6a9b4Kf4c2KPkC69/RaCozBpQRmU69bA1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQsCIpM2am7e2HNtNoaywm2FZJFQz4V9KBHmeTNLGG4=;
 b=V8P98gjdq04RAGFzK9KvnuOtmCtvmZBr9DPZ7x78yzMhCunQDYwqD0yzMNzVqgO/X1Z+kXBGQqzv51hF9TW4fpdt0vEXDJRAqNJmeEE32aj/Qr5Fe+VpH2vXGvOz0OXSZ7VIpdJlDy3l6jq4GtRvH44KD8UWe4mAk1d3DUco1u9A9PRPLxgjhqASwtQYScq+yHobZZYhrAwrGFwPW8wfIGpuIaqnJnAfjehX2tHCuz/oW0FfgZW7TggufLPmrJu2K88uQosYwCViRJPtZKuU3TV/4D/D1gFKAHZa7eNykH8ujVYOTvfjIfE28ZRNP3leUIs11OAESurCtNrWTbClsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQsCIpM2am7e2HNtNoaywm2FZJFQz4V9KBHmeTNLGG4=;
 b=yWW6vwbShm5Tjm28JVPgL0EqgxvWDny6fCEVJ1HemK2G6WmugttKA+EqJsYWK3Cq0UcyxJVihxYRXLdBiIF0lcXnx0e2xheVbccuytbBD8q5hEW+UYCccaJL0J56S9VG96W8u5dCKgyAP4uSaFc99QdbmJb0C/TxDxFfzDElV4A=
Received: from BN9PR03CA0229.namprd03.prod.outlook.com (2603:10b6:408:f8::24)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 18:40:46 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::25) by BN9PR03CA0229.outlook.office365.com
 (2603:10b6:408:f8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Thu, 27 Oct 2022 18:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 18:40:45 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:40:42 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/18] drm/amd/display: Add a debug option HBR2CP2520 over TPS4
Date: Thu, 27 Oct 2022 12:35:34 -0600
Message-ID: <20221027183543.1117976-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT035:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 472b9ef5-9207-4aaf-f181-08dab84ac2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKJgG9ul4i5tv/cJJbScWONS2JLqhU/NRctRTI+zEYa5AWDY4kbxwUVDeyPC71/QWU64MQAelhbQsqLO0fh3vBTwWae8LMC7XF3O6itq/NE07mE0u18OJZNtV04lRh2/FUinJbIUfMCHOscD0FPGcQ2HDcclRKxOiUDXYdVjRK/9XZuJPwOnFMG+0QOBvc90OEE4Hk6U039TlsXaD7t00YgsBClR4uHIlQA5Rzfh7gLBZy2/fb4N2CkcpgopwkQ3Osbd7iZhnYqe4XXBWr336fK1ZQ+9TfMxb4F2nVfIEb6VcXO2TwKDTnYfffBYeHR0I8VRkouWAjSHrJiKVybzt168cLXsfTU8XZ5km2t3fLgEWTAwKJBKP14Stc6x5QiuEPXgfWacjgOvFfhRLmuCJhnFfkLqUSQKVEFB4AZyTGv6CEYKP5kkhygUWwyZh323Gu3k8rjusEANpnP/zMcDoeNQra2nXARdFCl99OcUQj/Sl/MGS3y183URn/0CcI/+q9gWbBAQ2CcoHCx7CHi93hbTF7mrphCl3nt96WS1O3eINChcWWM94tTRJ1ZyuX2bIC+3HFP2DDyEGKmHPA7uN8F31cQH0EB+XFrmqjk2s7/iePIV5KQKXF4puEZAA6oYiS7EZ83Hg62VngM5XGrX5SZUhadnbSwwoXFhxsB1OYwd0fnUJlOIsLybLsZsAK5wYjvN3hx3egHZE9hjmtEKT3Y6Ha+upJcfTHS8qGcPIMzJc4reZM61DMOc+m0IKlbBMhE9AK6AkoQN3gbceySiB4nICdjwspgm2EDhXjUr8jY/RFfKb7foMg7dhLFfQ+no
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(40460700003)(82740400003)(356005)(81166007)(86362001)(36756003)(40480700001)(2906002)(6666004)(478600001)(8676002)(5660300002)(4326008)(54906003)(8936002)(70206006)(70586007)(316002)(41300700001)(6916009)(44832011)(83380400001)(36860700001)(2616005)(7696005)(26005)(82310400005)(426003)(47076005)(186003)(16526019)(336012)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:40:45.9304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472b9ef5-9207-4aaf-f181-08dab84ac2ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Leo Chen <sancchen@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[Why & How] There are cases when we may need to override the hardcoded
TPS4 test pattern. Added parameters and config option to be able to
allow this.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 2 ++
 6 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d9f510b4e848..dc0d51396626 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -393,6 +393,7 @@ struct dc_config {
 	bool disable_dmcu;
 	bool enable_4to1MPC;
 	bool enable_windowed_mpo_odm;
+	bool forceHBR2CP2520; // Used for switching between test patterns TPS4 and CP2520
 	uint32_t allow_edp_hotplug_detection;
 	bool clamp_min_dcfclk;
 	uint64_t vblank_alignment_dto_params;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 8729d6305996..8f5e89cb9d3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1902,6 +1902,8 @@ static bool dcn31_resource_construct(
 	dc->caps.max_slave_rgb_planes = 2;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
+	if (dc->config.forceHBR2CP2520)
+		dc->caps.force_dp_tps4_for_cp2520 = false;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 85e2d87a8e44..3b3e093e9447 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1770,6 +1770,8 @@ static bool dcn314_resource_construct(
 	dc->caps.max_slave_rgb_planes = 2;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
+	if (dc->config.forceHBR2CP2520)
+		dc->caps.force_dp_tps4_for_cp2520 = false;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 31cbc5762eab..96a3d41febff 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1783,6 +1783,8 @@ static bool dcn315_resource_construct(
 	dc->caps.max_slave_rgb_planes = 2;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
+	if (dc->config.forceHBR2CP2520)
+		dc->caps.force_dp_tps4_for_cp2520 = false;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index af3eddc0cf32..2f643cdaf59f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1785,6 +1785,8 @@ static bool dcn316_resource_construct(
 	dc->caps.max_slave_rgb_planes = 2;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
+	if (dc->config.forceHBR2CP2520)
+		dc->caps.force_dp_tps4_for_cp2520 = false;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 287b7fa9bf41..4ba9a8662185 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2126,6 +2126,8 @@ static bool dcn32_resource_construct(
 	dc->caps.max_slave_rgb_planes = 2;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
+	if (dc->config.forceHBR2CP2520)
+		dc->caps.force_dp_tps4_for_cp2520 = false;
 	dc->caps.dp_hpo = true;
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
-- 
2.38.1

