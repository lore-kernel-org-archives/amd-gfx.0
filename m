Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D635E77183
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 07:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D481810E19A;
	Wed, 18 Dec 2024 07:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QuWZI+jL";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0699F10E19A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 07:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hpmt/35iUiYqelvXHu4U0D5BwZ6EErUhmsVYHH3dmTPgnwHHVVZvWhV3rRecTyQgSKcgqeCuJNNFoCpP2qfXgtg27XT4kta06p+99CaLJCokv68XZBI0BVAct/qfjI8uJC2JeLXVFhOElPYOWm76KobFHp7s/bSZtIeoQJe/ZQDDEGiqL5X75aU1if7CekVCm/1K8EvEh+zvu68vWrJkQyeaU6ha/Y8Arl1nNdha49bUm3FVVB36x9GnDrkw1ETNRYLurlPKaU57Qj+Mj+5ucLOwKhDWaI/EUsN2KMOOr+SH1Ge8hzbDvVnXcAzz50QuKpawzR9KjWaFaXuufKyw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgPbf3j4+Rwi//0wsrDHuylqQr7Cdw/9il9rSGEZXNQ=;
 b=fK8EwlUZMFcjSiQT8g507bLmn2HiyZtfuiWqURGsLstMOqO+sqcoWevKLiSS5ZLP/DO5wqYyLYkvqD2Dv3YFJxrkezjahpUc9ne8h8dyMX3qBKMzotFV8vjrqD9pgo8E/o0aNz55Xv0GL/ol5uF6cTGXQmGAoO5DUEHYAYdp318JgVGoHL+l1mNHlG5oWlaI1CP5g4u8222FsoKf9NG3/7tm8VOc+UikrLZCFOYWVRhBbUEOU+ISSHEbqKikkwAh5P89mUqStx9ZNR8mhZQcSCE2c+UVI1ki/gz2NYZCmAjShgmWEc8z2yT8AdvIHwvJQNbce2gH2lBlauXN7bHx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgPbf3j4+Rwi//0wsrDHuylqQr7Cdw/9il9rSGEZXNQ=;
 b=QuWZI+jLJ8+Siia5aoB6Jwk/ZnkLvsC+pZLcTmLSUOMaE68Jkhx8BPf2KdEdd84H8RMsPox/lNb//R23rXDnbLDZxYdV/bHs+B7+88vkYgyqTWrnF2AdEmYRTp4L53UOrgUhcY2zFgf8MXqsy57XEcAuuyUo2UIqzF4t18Wzfm8=
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 07:32:14 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:1f1:cafe::c8) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 07:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.6 via Frontend Transport; Wed, 18 Dec 2024 07:32:13 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 01:32:11 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <lijo.lazar@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: Driver needn't request RLC safe mode for gfx MGCG
Date: Wed, 18 Dec 2024 15:31:54 +0800
Message-ID: <20241218073154.843863-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|SN7PR12MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9927f5-2e67-4497-9058-08dd1f361704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KZjeU8Kr1JfoeYVLMvq1kNVEi0aBzfXmz0wz4JiqyO/3zkrAsB3OnjXhSbl4?=
 =?us-ascii?Q?8gwSV0oLT18CWpFlSBTVuS2o9u0591PTisFvzVhJLOmAGc5dmwydyVLs4Oa9?=
 =?us-ascii?Q?aBxvmoYMVABHC3Bjg7pVn+fC1maJML9YrX55+qforf1bb1plCLqF2i7BXs0f?=
 =?us-ascii?Q?tZ7KIqB4OlToifO4EBE1p9LnoZ06E+dtIUqugE5JOLXskgPvlDD0G7aCPJDr?=
 =?us-ascii?Q?URkdrvn3b0XuHTgqQde0FSLeLoF+WLxCnXlUJCYXQxCgVilgLXShJC9P3qyt?=
 =?us-ascii?Q?urQTKk5iEYCoCJ128x6UWYNYxusv/e4VX+pSIv6EDznuXeqmwrxmgMiWmAVe?=
 =?us-ascii?Q?Wyh0frHl6dH5W0N2raoQRtWbg0dFoQ8cI4GFYXs8OJMrrjwB8HtvOvfCP9xq?=
 =?us-ascii?Q?qc6LoLvyjy/mDOA4mTiYWGJa0bHe3S+o3d+v9xPbzGcVnlTR7qsBEEWQGuyh?=
 =?us-ascii?Q?nq1zOcghl6umx7CK/nH77Rvix6XTKthv8aT+WBIxJrWIheYaDcP3WmRjeTb7?=
 =?us-ascii?Q?+XRLcd4WtONiTal83SO1xI4PcSkRyVSaBKBdF0Ep1uTJ9I1PXa7d5FEelBIa?=
 =?us-ascii?Q?u+hlZR9I+XLY2vAelhe9oG9B0XGHcwV3c3VffhvYER+88cLHrrBn8q2NE7Wy?=
 =?us-ascii?Q?L0in5VfduYFYSuphx9xsgz2RAo6LCLtF6xUbyJcJf8X4JeU+92vvNc9iQFQ3?=
 =?us-ascii?Q?YqfXVKpyIlNMzzIZxBYO8PvQTwxhYB1+I5IXBYRBwZLm2up0dUKaioiV/tl4?=
 =?us-ascii?Q?iQWD8dfDejiGclzDtDkgpo7FNfQVNrIEsyCBp085pb1fFx714x27HwhPhfUB?=
 =?us-ascii?Q?j7KerYCuUFw6fDdR07wtUfxNo9Lzm7xGJuEFSwQeERETonzQ1hCVeamXzU8F?=
 =?us-ascii?Q?DBxichyeLK9EJnJvpEkrQhu1kbYvaLctaNwerQZNGkS09IGmhySaTayMcuKU?=
 =?us-ascii?Q?rd9Kl/v0giz4PbBIPG++Gz9gh2AvWyRSVSfc3MA6VIJfqBWRKejXLKgubHHO?=
 =?us-ascii?Q?dHMr9+1kIIcent2T3zjruqzguVKrs5IGhnkn5QhWmcOg1XDvIzbSGD5KFDRG?=
 =?us-ascii?Q?eQMJNqKQFk2ZwBtgZKiL/ezrTknfXr60AIraxRTm5IHDcJflnrkVSrS5Swr7?=
 =?us-ascii?Q?wM+zSfzcYNxvmZtg50JRQdhSZJ12qQAJOVLqf+i3kcYbfQnQvPJ1gu0zZUSz?=
 =?us-ascii?Q?lNbURufxTQ/zFEyH8RHZsjY6hJhFepHd1BQ2zbvc7ZSIopTT1W4CsgYPIWlO?=
 =?us-ascii?Q?Q4kI03JbPw9Qmv94ThWqVe2f/CFQesXjtOMHBolNkYdc0yk5IonIsUWPdzpU?=
 =?us-ascii?Q?i9ru6LAsQ/WVte/nly8/xiuIzyDB+zD5l1cd9MkHAX6LHNTjkHLL8gCT1UHl?=
 =?us-ascii?Q?dCcEh4ZPQWPmvDTQn5ZkdDk6nVsjHeQsJW9x277Uy+2YUqhV2Tl6IbphpTNA?=
 =?us-ascii?Q?y2cVKAQQDBnr40ZPDvUkOgwpgHjYUKEZNJa/z3tViHBFiSXx/mEGdQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 07:32:13.0411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9927f5-2e67-4497-9058-08dd1f361704
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
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

In accordance with the MGCG HW sequence, there is no need for
the driver to request safe mode before enabling GFX MGCG. For
GFX10 and later versions, maintaining safe mode is acceptable
for GFX MGCG; otherwise, there will be an increased overhead
during safe mode entry and exit when enabling other GFX clock
gating. So now this change only apply gfx9 and gfx8, and without
polling safe mode, the time required for GFX MGCG entry and exit
will be reduced on GFX9 and GFX8 systems.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 4 ----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index af73f85527b7..690235dafec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5639,8 +5639,6 @@ static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 {
 	uint32_t temp, data;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGLS) {
@@ -5734,8 +5732,6 @@ static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 		/* 7- wait for RLC_SERDES_CU_MASTER & RLC_SERDES_NONCU_MASTER idle */
 		gfx_v8_0_wait_for_rlc_serdes(adev);
 	}
-
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4b5006dc3d34..6dec5383ba17 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4964,8 +4964,6 @@ static void gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 {
 	uint32_t data, def;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		/* 1 - RLC_CGTT_MGCG_OVERRIDE */
@@ -5030,8 +5028,6 @@ static void gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 			WREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL, data);
 		}
 	}
-
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
-- 
2.34.1

