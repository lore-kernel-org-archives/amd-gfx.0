Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AC4CD611E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 18:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989CB10E2B0;
	Mon,  9 Oct 2023 18:35:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A79F10E2B0
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 18:35:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVKW5d3S/9IAVSW2ZaCK3pg+TiWlygGFb/5qp4FL2NSG2D649LAW/JfiVyPTykynDIak1zNuli6kb4v27aCEGClrCInKPkx7ub9GLFzuzAlPsGVzaxktun6NOPJXtu6wE4uPIczGBbNT3SaK0eiG/0i8T/RM4hPhTb+zOgYDTK8AtL1uQTsBPvCjgSvdhzhDKqTq2zlq7AW5R5vKv0oxFEJKHXfuAOgqPqslsoG8T+fE20Q1E9sfRyLlBu7jEoqNl+7p1KJYW9GZMe2qe62ImMRy0uSUuSDd4rJDTbaw6aylt6zcq8j9WmtSqslB/mhIdoTB5WeI1wNzwJHNGlgLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRgB13KnIQjvUHte6tqPg6qedR4aD15T1iDZdFRbmJE=;
 b=XJyXKeDg7pV0ynizRR7HdFvSZdKamhA9EDinkb/4zeEaoyhwSDfOK7NJVfq9UpGJqwcrhTz2nlLoJDZ0kw+VqtOEF4ahB7ZdVh6sBMG3rFdX2PvQT0GBbq8uYrT0sCg6Z3U4QD4vB+XzWL7/DTk+HmiiSaQL7PnwImho0W3tdN0HlQgo/2mw8diZvJdUttt1amhE1LSL6e0JYTs6ZdkW6Rx06j700qlLBCXxwt9nr6ldjYDOozFwpYePiVCOSwMqulDG3/mq4RZoOSgmXMV3YRV6LgsIxlW9Ys4D386GqpPXp5zkZAy8JX8WslUkIiJCh9f2P2hfJsHrqq7mOsf4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRgB13KnIQjvUHte6tqPg6qedR4aD15T1iDZdFRbmJE=;
 b=4P1MAn1vWzN/LaFC8azv9tcX1fdU5iXsJXni4Sa56mirUWC0tuWl9Nn0sLhQCFqID+Y2TzpaJDDPZR/fIzvlcQUk3I5AzuvgWdjO75DWchEjc+39w3C5+kR82o12lfvkttLnG8tEXWyfFzMo7WuiuIZ7DLqUN9hz1263qdARwps=
Received: from CY8PR11CA0039.namprd11.prod.outlook.com (2603:10b6:930:4a::27)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 18:35:07 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:4a:cafe::d8) by CY8PR11CA0039.outlook.office365.com
 (2603:10b6:930:4a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 18:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 18:35:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 13:35:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable GFX IP v11.5.0 CG and PG support
Date: Mon, 9 Oct 2023 14:34:48 -0400
Message-ID: <20231009183448.518695-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebb1e8d-06c3-4e67-e5ca-08dbc8f675c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vI8P8I5VGqBdkSgK7CD6RJVWiaFkEvHT0SJdf+uRa7+XIHLk0ExU1c8RKS8XQQpnRAkwuVOe37WufAfOxnh3frHbZTGjRstkmaJFpc6Lc+QckuRymnKgkyW653Jfu0YPwGmidkkLnwSk063QgcyqgsGbyU9qHkCNunux5w+w+VhaK6dlLLlvanGPEosim+5rRCfZl0yfEMKAhT3y1uvol9jDkz7cBp+kdh2WY6ZAtnxNHh4SmWwBgCG9wA0TiAUyFMoKmNnJSvQJhxZ0UAApYl/Oh7xcyBR7IfP89njB56QamaBL4tIHChj7fyeVsrutdOmxy3i1riB3533ttNM2mR3NzQDGT7p62FVepZuoqtoIn9yrV9qJ6Uwin2hVxTjlzg/z+J+Fsah8Xtf1frhmpvx67V/38NUiGBBEEZ8HGdEKK6Usf+c40gFCY7FHK90IwghfgPDizPkuXSkqi22VwAf8JCBwZZiuXgnIjIaXy2unGWhrympZpUBd5nZe8O5ObXNgDlfRaGOle+hIoFFDLiOATUCTm+eX+1diWqooFJmyuRGB1cq/tl7GDLvAhp255Lnq5wuuEABX7q5/oFllhTl27dFNWJl+ejLPGbNdrJVvZ3bhAG6ZcscvnhnEPD32QERmvyCmTTQNFSCC43aa5UadPVg8IL5ON3E7oaQ6iuJxDWGo5XLrG0EmEruvvJ/SlYJaSxARuj/SaXYnjfdU3q+Y3OGJMPl3Q3cQ6/4JYkqMVDozwoTEmCaX7JCllCupRukpkTOxdIFdpCneLRMtMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799009)(46966006)(40470700004)(36840700001)(82740400003)(40480700001)(47076005)(1076003)(40460700003)(2616005)(426003)(26005)(16526019)(70586007)(36860700001)(6916009)(4326008)(70206006)(54906003)(336012)(83380400001)(8936002)(8676002)(316002)(6666004)(41300700001)(7696005)(2906002)(478600001)(5660300002)(36756003)(356005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:35:06.5377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebb1e8d-06c3-4e67-e5ca-08dbc8f675c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Li Ma <li.ma@amd.com>

Add CG support for GFX/MC/HDP/ATHUB/IH/BIF.
Add PG support for GFX.

Signed-off-by: Li Ma <li.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/soc21.c      | 22 +++++++++++++++++++---
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
index 5a318bc03d23..f0737fb3a999 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
@@ -103,6 +103,7 @@ int athub_v3_0_set_clockgating(struct amdgpu_device *adev,
 	case IP_VERSION(3, 0, 0):
 	case IP_VERSION(3, 0, 1):
 	case IP_VERSION(3, 0, 2):
+	case IP_VERSION(3, 3, 0):
 		athub_v3_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		athub_v3_0_update_medium_grain_light_sleep(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 9c4562bda8cd..27b224b0688a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5027,6 +5027,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 		case IP_VERSION(11, 0, 1):
 		case IP_VERSION(11, 0, 4):
+		case IP_VERSION(11, 5, 0):
 			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
 			break;
 		default:
@@ -5061,6 +5062,7 @@ static int gfx_v11_0_set_powergating_state(void *handle,
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
 		if (!enable)
 			amdgpu_gfx_off_ctrl(adev, false);
 
@@ -5091,6 +5093,7 @@ static int gfx_v11_0_set_clockgating_state(void *handle,
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
 	        gfx_v11_0_update_gfx_clock_gating(adev,
 	                        state ==  AMD_CG_STATE_GATE);
 	        break;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 6fcc4f7be117..df7462cec6ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -689,11 +689,27 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x80;
 		break;
-
-
 	case IP_VERSION(11, 5, 0):
 		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_PERF_CLK	|
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS	|
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_DS |
+			AMD_CG_SUPPORT_HDP_SD |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG |
-- 
2.41.0

