Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C37FC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD53112F25;
	Tue, 30 Apr 2024 20:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tGBYx+4O";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EEE4112F1F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOWsuMqK9jtbbuiinzhMfnT+09QpUi31eJSFqmo7nDzickDfm7aj3PnHjRmVApryHDhd79a33umqS6bV81lOOdcINi5cHky+odQIlhuakxskhWonDOSVfvTDTo/cm6A0BTYSD+qvANEcxyNM/XifIZaBh9Eo/qXqNy726n+WnOi2X9fCL49jO4reY5PYj5nZCVuYz+TZgGfnakBaoCvpifJYJGx8mQgJNkyJiNEPeg29YbfWNikwgZvyPjqE+tGIr+dY8xTea6E5XBbLJoBqcZ8cKz2VlWtTMpmbLpdlMMW1CQFjz5KTXOY2X+dXWOWixKh6aXR9kMx91Vs5A02mqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8FMw5vA/09nk2zO/ciudmgPFkyoH+61JCaJ1FHwyDo=;
 b=aF/krCpPfK3KSmDX7CSODRFH4qDhVKdn58oQq+62iDR4eUITWQxectm19vo7Y3eQOcIrTVSTn63DPpAkO7nu+cdfzdylxQJASf5IBVYFOvK3RDN7Tj73FYm34BIBQbsSo2jReIL8VdXPeAgWQ2nDV45225kzOfQZ4EEO5abHEQ8TJfWVI+XUrn9Mgjht76jz3cvcUoxXU4YsXw9e523oM5YVKalYvdHjsO0MiF56QrNwqaAojcR1ResCUmh7rWKBkLi2tYIPAWkBkjWJ00jzZkp5c/w419NuRw9vBM3OqXHGsUk2p7Ui7KGfOK5cyMuk0cfPJfkMkjj0NHuoiXaL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8FMw5vA/09nk2zO/ciudmgPFkyoH+61JCaJ1FHwyDo=;
 b=tGBYx+4OjjLQLgJ8xAx31CqKh9JT606aR/Hihi3eyZ8wMcZQJAirDY3OlvcM8TSyvpJ7m5EJTxLrRhLioGq/mikc1ZmpNbwKmenOjxAE7fFM7lSakIfOAA3U7KBGRUU4AAIoDaWqtF5+nxTBk9spOxvgwUs58VoWAe7pTn8xf2I=
Received: from BN9P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::18)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 20:34:22 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::f3) by BN9P221CA0016.outlook.office365.com
 (2603:10b6:408:10a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 20:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:34:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:34:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amd/amdgpu: enable mgcg on gfx 12.0.1
Date: Tue, 30 Apr 2024 16:34:00 -0400
Message-ID: <20240430203405.798798-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430203405.798798-1-alexander.deucher@amd.com>
References: <20240430203405.798798-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1b997e-f13d-4a33-bbb8-08dc6954eafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kmOSmBUMFZctXbFXeTI1MABhGRbioRnDmJsFdKTzcHjPl5BEo44AkFx3CDnh?=
 =?us-ascii?Q?7Isr2Nd4wcURyY+9BAUT/ntRWPlbiWQnM7GTL8Jv0BU7mUaYVCsVA9TgoRV0?=
 =?us-ascii?Q?rkU+23gGbeH9sSF5k6hz7uXc4bFB2uHGIlcKc8gBMEgvqaignUzTvcaCmpvw?=
 =?us-ascii?Q?2JoodCZ58vCaiTFOVcQ+6wzmcvukcbFEPov5oaVfnqTOIAah5BEHOZsldtUV?=
 =?us-ascii?Q?vlNxiplgHpu2fedKVF28DpuCT1028n16NXuTLiRVMCp8URUh4rD4pbz4HXbE?=
 =?us-ascii?Q?kvI9SV+lDG3eB+Q/Yo7MwHPhqAYxet+boPglVcCXH2E8SQm1Cti5nunzILZY?=
 =?us-ascii?Q?PydyDVB2iTXQLe7Sy+g1TaDgunTvOJmfU0YztAorXYTEOocTYKvX6V0TIjwv?=
 =?us-ascii?Q?GT1RvXeSv+TUP8VH8PKEJGJsNTY+Nd/PmUPh6iSNmNcXLx55CaHfIXmx4Qa+?=
 =?us-ascii?Q?jE3kXJJ0rMSrk2tubANBkSlE4aD2GaBr3eGwqeZ3Lzd+iXXm+7W7kKwrqcQh?=
 =?us-ascii?Q?TQeWwocw8J+extVK1Dnb2J621d317OfRc5O6utYo6jVDHvzx6UeOxNDkZOFK?=
 =?us-ascii?Q?qP7zAQzshS6X7kzXOrXg0ajqP/tUZ4TQhGUxwN3Pe+3efAROcRumcVI6+Icd?=
 =?us-ascii?Q?AKthYlWQZ/SRzZmTGapfjwSDa1vAQz7McGLI8SAvDpFBpjjFiq3hrWiIt9ki?=
 =?us-ascii?Q?ueEbbWDHWvvISRwnyILYeUqfIOXdukxTsioNdi6wKmKUcJIOLOWn2EAxVUlE?=
 =?us-ascii?Q?QIYd+UxWwPiVfriupnXzcLrAExGqbySqmVrWN+535Af3dfoCOkdYim0Jptai?=
 =?us-ascii?Q?TX38Ze4uli3+pEi6Ru4y7m67VZ1B9IT8Sxzbr5zeidcDm7R/3m4MjoBTTD88?=
 =?us-ascii?Q?RjeonJOJJyZm8XGpn+mnNnDUI277hulOIDlzvRQ4yoTQFK9QV5wVhYm+sXCm?=
 =?us-ascii?Q?0G8OyWP5H5RigTa3fViRAmxWtsBKdikIhezZGMd6zyhQoyAzG6AyktdC6Ajl?=
 =?us-ascii?Q?BVI/VS3WseNNbKRJIqyqECVKJGg+PGT0ekK0vmfuQq9q+AW8Zm6x4XuFldG6?=
 =?us-ascii?Q?rvDa0a/aNXwgEbttjBGPdPto7I7lkdDoCuKguEispgqC5V5MfgddFvun2NsR?=
 =?us-ascii?Q?WRhk4+l7fJvxUm8tTApn0HFqsWZDSVeciJgJ1QA1Ab4SfW2JgG3MQ137A3rr?=
 =?us-ascii?Q?cvSW3/TQqN/9pXsHY0W3e2Wb144PjtJOfXfwPlVGxjQ7VO7WVv5hta5q586+?=
 =?us-ascii?Q?14kiJy3l2eZPQcvWZQM9p/mPYyBn2DsZ91F+IA/JG+Uy47E3pQKA/+1OW9F5?=
 =?us-ascii?Q?7tWKRvQY/QaPfwsOcBx3SbgzcT2NoAj/TS/WMiXWMFXgrosqpvLjUvA2qdbw?=
 =?us-ascii?Q?V0y6pKMssVN9zi3SIcWXvT2a1CQm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:34:22.0031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1b997e-f13d-4a33-bbb8-08dc6954eafe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005
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

From: Kenneth Feng <kenneth.feng@amd.com>

enable mgcg on gfx 12.0.1

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 30 +++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/soc24.c     |  6 ++----
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3e2a6806f1c19..f7c5b10c753dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3729,7 +3729,35 @@ static void gfx_v12_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 static void gfx_v12_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 						       bool enable)
 {
-	/* TODO */
+	uint32_t data, def;
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_MGLS)))
+		return;
+
+	/* It is disabled by HW by default */
+	if (enable) {
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG) {
+			/* 1 - RLC_CGTT_MGCG_OVERRIDE */
+			def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+			data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
+				  RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
+				  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK);
+
+			if (def != data)
+				WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+		}
+	} else {
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG) {
+			def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+			data |= (RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
+				 RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
+				 RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK);
+
+			if (def != data)
+				WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+		}
+	}
 }
 
 static void gfx_v12_0_update_repeater_fgcg(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 143329ed2c9a1..30e166004e39e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -402,14 +402,12 @@ static int soc24_common_early_init(void *handle)
 		break;
 	case IP_VERSION(12, 0, 1):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS;
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x50;
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
-				AMD_CG_SUPPORT_GFX_CGLS;
-
 		break;
 	default:
 		/* FIXME: not supported yet */
-- 
2.44.0

