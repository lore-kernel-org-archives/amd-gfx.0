Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90D8C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC7D10E780;
	Wed, 26 Mar 2025 19:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aI1wd+yo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB7710E779
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1sAtoUW4HtllbMfO9ee+7yPkNIwyAL8AiteSkdStwhMRpSKsc3ThSpubeUhlP7QcIDY27Qs/7+UXenSuZ5FVIljlrDZRd11mqPreiYYVAIwfVq2k9anOsLXF3gHjqCEO7bZZz1eFnKm+z8a23c9ZLPwVQP+PvEaSDF4/3LyYarbZKaUa7wXM8rBbcuCOXq7/MHv338m8sCwZl3VruCGBgqLNKIFPF1qo6fdhLG+h3rnY4GgRl4K8lBi4BsNIloZzh928fvhLuVyweFHjSyNYxzLquC1YEwFwX7cgRiylsygtm0tYu2TbsackqjAYJDEnebU0aHrrvcsQ8SzKFPStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpxDxpJLLuSF3es0YxQwhKRrKgPTBkT6YiGCpgD5EJM=;
 b=f/PfeqYDfrVxQe7TVpTyP6aUQL3gv3Stzz6Zry2kw/zh6fKZO4adsUoqQel3lBLJuZlrcRi10ElszutZrUj1DRS7Xa5WaN0ZmSmRcG+HAQaBdRGgWe044h1CSfTvn1MhAxBbaBK+NFmh0xoUD4Y/AOeBQFrRruJjRS2viqrChdea2li3neOrOSAjsLEU4DOkvcmmdS5Wpcypaplq/LFpqiPvrCx6CVW9po2ZKvohws9qDX36FZ3yiBeDeN9ppGeNfubPwja+3wdM7zwcanOpBVn2cHPoBCXA+ox7qowXwGXLBLl53Vcm6bH7Llptl2JLwUhR39f5hIK9xemBX035+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpxDxpJLLuSF3es0YxQwhKRrKgPTBkT6YiGCpgD5EJM=;
 b=aI1wd+yopab4Irs7JlZDXoNZG1qyE+zsTq8luQTFpTVP8wfz3ReFB+YRtjCgTtqV71muWIr2sQZ6HtWVjbQKqhj5T2QR7eGSbta5S4JJMkaSOSiIqKPXiMw78CgPuz+G2rWbHMs0e0+SoCKLBKxsCOHq++PTSRObmU2SsdeX8fw=
Received: from PH1PEPF000132F5.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::3a)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:53:23 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH1PEPF000132F5.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 19:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:21 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:20 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 14/17] drm/amd/display: Do not enable Replay and PSR while VRR
 is on in amdgpu_dm_commit_planes()
Date: Wed, 26 Mar 2025 15:49:11 -0400
Message-ID: <20250326195202.17343-15-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a6e675-8d85-44d0-24e4-08dd6c9fdd47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5pwITDyO/DvMRPLO9oM4Z7OO4hk9irhJ3Cvivefyg17b2k5CJoC+0NuPdNEl?=
 =?us-ascii?Q?kE0ZFsb53xosJeNCf/kRcM29mAWDI45TUxhGTNAxjBW9Gg4zDpZP+GtG+enP?=
 =?us-ascii?Q?/ZlByPEbeNfEd2RfYo5e+HePSIslYuZZiMbX4XL2kPM/ET0ELjfW6UFjIMyn?=
 =?us-ascii?Q?W7R7qHVT/1JdjP7puMsjHl27JIxgHTEIkxTlfbP+6egYfYDDh+JVqskeSrW4?=
 =?us-ascii?Q?XqY5PXr5UtbNHmbXjfIGv+tXk0ypI5H3y5H/yuUsUZmWaguVyk030COXz0de?=
 =?us-ascii?Q?2Frl9AND8qMXTh0bawfB3A+wrvsHk31MXMGvK+Hso5BR1VdonRoDikmil43Y?=
 =?us-ascii?Q?OBUuVk3q7JdZDJxQ3lt+6gZoEJlmarHWjkxtpVzmqc1lFOA/krVb2JJazsnZ?=
 =?us-ascii?Q?0CIOhv1KIxP3dmapyEJHbTvRhUkaU0HPOsIEZ07V/xS9ssCjBRhTML9P45G1?=
 =?us-ascii?Q?30a5QmLcZbnpDPxiMAnmiNSlbKwt3pL1CUJ7v334ORzPWEvxidXRFMHQD2m4?=
 =?us-ascii?Q?iGP0/orMYPYDYQviOrVihzf/n4py3ZKY86lCcvJs1EtDlfx09JWTYyETWihB?=
 =?us-ascii?Q?6hGMpqZBnBHOS9h19RAyUndHu+R025dBawVD0yvWUxuy05KOGRa2A7UxEvy4?=
 =?us-ascii?Q?jDNfmycXPxurDZdC90oP1bh4ZS+nEAu4O5io+KRjAU+vIPZv3pA01vuP6MjJ?=
 =?us-ascii?Q?YFnOZ81B8pti++jCoBgH7EqNR3So+R0vNb4aD6E+2wnaqrvAvB1DayOzWdUd?=
 =?us-ascii?Q?mxFUQJIi+Jjb7jVUbrF+CHrDUbZfxoMGv6gQ6uLSMd1EfGaMQLW3YSj2nCVq?=
 =?us-ascii?Q?63/AaVaWpcj6C1xRFnrKb2VueWc16bZlp/xwZFP0AZo6LCP9SGP317k/zJAq?=
 =?us-ascii?Q?/+3t9TDpQk+6IgTRJEq3lsOEPtY/3l/zd9gbNo88/+pkqzQXaKEmXj7NGcur?=
 =?us-ascii?Q?AVrHREN94ceRbbAxqLerNe48GV6uxOt7mLZG+EBInapkITpabXeSvqQu/x7b?=
 =?us-ascii?Q?sJLe3r9nA2ouSzu7NW+EcZqVtNdQ540DRY7hZWEe2sKntPElpA4sGESHp7EB?=
 =?us-ascii?Q?IReZ59nwjwGYS3icVohAfXh3Rrp/v3hivmNcPSykgsQee1ZBcv09AV0WoG/o?=
 =?us-ascii?Q?Km+wXUJFaN5Hy+gggWS6/Zep+YIoJ9i7K5WuEMksUxbmYzih+u5G11tTJNSD?=
 =?us-ascii?Q?sM5SAGebkUIYuiyzUze8TJOGqm0dWUkkFWqs3VzBdRdkzDvk1nyfbqr9bZQd?=
 =?us-ascii?Q?qVrm5MSsTRnUGI6XyJ5NqUAFM/MTGF03/9jcou6hNPbzC0qpbwpphxBRZIfN?=
 =?us-ascii?Q?ogEM5PmM5W21ke4SKl+8Teg3t7b5sXymJH5hsn/FJiMUeLxVMZnwE969FcC5?=
 =?us-ascii?Q?EzDvbfZNjBQv1yuIepaxKg1GGmXEfiXYfMG92PnQk1dElCgqO6oAdq8JVQ1r?=
 =?us-ascii?Q?Q2rktW4CVLZKAuI0L8mU+8BHZ+DvQ8PxQHh5xr1iQ7zutoIzoIPcFbWjI5JD?=
 =?us-ascii?Q?D6U133HUVVEKwuQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:22.2943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a6e675-8d85-44d0-24e4-08dd6c9fdd47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
Replay and PSR will cause some video corruption while VRR is enabled.

[How]
Do not enable the Replay and PSR while VRR is active in
amdgpu_dm_enable_self_refresh().

Fixes: d7879340e987 ("drm/amd/display: Disable replay and psr while VRR is enabled")

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 36a830a7440f..87058271b00c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -113,6 +113,7 @@ bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state)
  *
  * Panel Replay and PSR SU
  * - Enable when:
+ *      - VRR is disabled
  *      - vblank counter is disabled
  *      - entry is allowed: usermode demonstrates an adequate number of fast
  *        commits)
@@ -131,19 +132,20 @@ static void amdgpu_dm_crtc_set_panel_sr_feature(
 	bool is_sr_active = (link->replay_settings.replay_allow_active ||
 				 link->psr_settings.psr_allow_active);
 	bool is_crc_window_active = false;
+	bool vrr_active = amdgpu_dm_crtc_vrr_active_irq(vblank_work->acrtc);
 
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 	is_crc_window_active =
 		amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base);
 #endif
 
-	if (link->replay_settings.replay_feature_enabled &&
+	if (link->replay_settings.replay_feature_enabled && !vrr_active &&
 		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
 		amdgpu_dm_replay_enable(vblank_work->stream, true);
 	} else if (vblank_enabled) {
 		if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 && is_sr_active)
 			amdgpu_dm_psr_disable(vblank_work->stream, false);
-	} else if (link->psr_settings.psr_feature_enabled &&
+	} else if (link->psr_settings.psr_feature_enabled && !vrr_active &&
 		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
 
 		struct amdgpu_dm_connector *aconn =
-- 
2.43.0

