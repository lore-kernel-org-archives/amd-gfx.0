Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9166AC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 08:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05FBA10E6E2;
	Fri, 10 May 2024 08:51:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L5r2oXXL";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B69410E669
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 08:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyyC7WYbWXwTpePtuXT4QrRYNisW6Ki+5T1uJAPBHAbQvenxv28UBmMDEKP+04xpCnP2dXPIgWlgLQSQbk6Szpd/d0ze7EYaDsAYjxkpnr7pFq0loIu4UTZ3Xq1WiKeL1JVbxDcVOkx6p4IekT7CsM1MzsrQhBYFFKtWrTLPboNYEaIaaXtkdNpoZFC0n8bbcuXFDHuldgERJLUWLGmuSec5617mILouB2XrXOoQaAirBbtt8cc/w9lHfQhIixNyJPHa5j/x6Emnxql/tGJ3qLmiM3MK1hYQ+bHijAu/Bhm01xgg61Q2yA0uLH0eTg2PRFh9IM/359pwjMLgh29etw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPdL5dcSRSegTkbHFadL1tph7iu7Snamtun+6k7TFMQ=;
 b=T0hPU0tq9HAxSqO/YzuTJMUgHYSRuqRVSznVsBU7mkhpULweP4LZ+JvE3pod+BimM6eGWVzcFWwginhhe7f2RUckkkl6MPL1gGQYtbva0J8B6ri63iBWvNX+ty/Uxiv9bqwg0J1rjE1AnnWYp/NdOE9Z3QQ1Ex2/DDyWxpsR0C3wxjisuEWv0KyAVitpUCuNEoSjNVQpwpBvi7xXB4l3ICo03ZoLHPG+szI+o90DlZuQd4SQzlH0JLEHyqJPhjZzSyOdo7QUtbgu+SXyYfG26W/2a8JCaU007/VEIIR4BjXeaiDiUl0uqZUnQlX3L5vmK5f/cDqAzaJjajdptT/N6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPdL5dcSRSegTkbHFadL1tph7iu7Snamtun+6k7TFMQ=;
 b=L5r2oXXL/wsABVmbAQvdZux5SDRH2SCG2a1HbIMq4DD7/DZp3QC502nts/U1L8CkHWNACWDBDkgiAB5SRqHh6JET59LQ748V3yHOWcgiI4jNEGpHJUMVoJ1RPNOnR7cPeGbSmlx49riEB+8NBOkrlzaF3NNaFv0UD1sbTzp31pg=
Received: from CH5P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::25)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Fri, 10 May
 2024 08:51:25 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::73) by CH5P223CA0018.outlook.office365.com
 (2603:10b6:610:1f3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 08:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 10 May 2024 08:51:25 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 03:51:23 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v10 5/6] drm/amdgpu: Remove the MES self test
Date: Fri, 10 May 2024 14:20:45 +0530
Message-ID: <20240510085046.2718-5-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b8b459-f0e5-4773-37cd-08dc70ce5fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0yt5Wa/dNuVeMLnbyLdIor2AlngWbDYifzzm0Du6OvYtn9TeYgHFIgQaxnBl?=
 =?us-ascii?Q?O83w3k6zWsLuECFQQkvJtilPWWYf66Lh2/Rs+WQIQB4kg0gNsNbCWTbhymRz?=
 =?us-ascii?Q?Us0AmPNxy4ToyyvTXxYbCYT21ykmRKSnTjsTD66XNBhbADY+oBfimp6SeIxM?=
 =?us-ascii?Q?QB2rl1Hy/y75F6jZ3T7RqcocO18RBhYYtBSC/8Qflt1yekS08Aspn4bpqbgO?=
 =?us-ascii?Q?FGbLFBjRHXrVvOsTvGUgryUFxOGnQZN0lLqTQ6CC7JUvKUWCDC5a4dMqffRa?=
 =?us-ascii?Q?sgqfMTqGU/ceC3dWLV6U22zcdzChE3XfbVwQEuoGn8VFUGHRsru0JbM+15u9?=
 =?us-ascii?Q?OFtsLyB/BDRaNJSTiAtIvjNutldfed56w653nb73TbZ7WseiALpOw6V73B/l?=
 =?us-ascii?Q?MuX20jB4dOVnMIaRclEEu09BAa8ph7L5TZ6LhQ55iO8Gwd2nsnKosz+FtLpe?=
 =?us-ascii?Q?2333OQdzNFAc6V4ucsH74cKBac7ldSVZjJ/eTW0Xyu4lI908eZ48EzqfuPuV?=
 =?us-ascii?Q?Wix/X7HFR1f+67JISrlVeLVhPfQmC7X6CP7eN/36V4wuham1M8Dc+MF3MsVh?=
 =?us-ascii?Q?YH8VbcL4l0awajZdeYJIPZ82IYAzNSwggLIFDUIMHr6D521o3XHx6Y7BELUr?=
 =?us-ascii?Q?ilj2oAYYWO3wQsm7yH150bDHRcf54CeBtJlmyVz9BROdNwgxMiOWrBoUA/dZ?=
 =?us-ascii?Q?IoD4NVnNycSU+kOyqWG7TOVuiVXW6KLxoGGphgPaAMhur+PhTHwJcoJJRbL6?=
 =?us-ascii?Q?4JERawUfxYsznE3XHWioU9TsRpzfrUlIv2HmlreM24E/UhX4IPSOkEUrf4Jc?=
 =?us-ascii?Q?9OamM9d5B+yrnJA0CBl4L9xtTNenM8mribweUJTDsW0leevo0ClT3zNqa9rv?=
 =?us-ascii?Q?43KcmIOheohQTCGl8bCzwBokOvl3we+VtnVenkgRYccU6BUAPV/gTxw6d5jW?=
 =?us-ascii?Q?4YqF+C6SsDXKkk7YNKH9zd+FYfwMsBtiCjsJrhk6By4chjQSyrs5KIS8neG2?=
 =?us-ascii?Q?oxB1KLDsanDS2+P7bylR9sINYsLGjRrXqXQg44hQsBfl/NtiSo7uq5GXB90Q?=
 =?us-ascii?Q?hh8/0fZQcGjN5lJ/5WIco0BN05mcFe3vr6G4D7UZ7gKMw0N+EdR3bhourjUY?=
 =?us-ascii?Q?8//0kRev0jB2qtQltC9zzDXZ1bWfB9C8E1tSgR/uQmTu9Dd9kt0VkTy6Ix0t?=
 =?us-ascii?Q?H0HQIhtMew9ZB2a2gz91ErnvXKLq7wrCLgPmd2+3yktF273xJot0PhidrIP3?=
 =?us-ascii?Q?rFRgcJWb3FtU5+Sj9Qshu4ozQpnKXpc6/9A2xn693qeQzUEPKV2Pqoabi0as?=
 =?us-ascii?Q?aQhOPocGaSaV7mQFfxDArExxiXngGFw0RFT+8KJmROFJ5ePu4urzdzN5GtDg?=
 =?us-ascii?Q?xznmRJ+jMXb/w3TvPaUHnE3catFW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:51:25.3115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b8b459-f0e5-4773-37cd-08dc70ce5fde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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

Remove MES self test as this conflicts the userqueue fence
interrupts.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c     | 12 +-----------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 14 +-------------
 3 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7753a2e64d41..2d9fa3d0d4a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4719,9 +4719,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	}
 	adev->in_suspend = false;
 
-	if (adev->enable_mes)
-		amdgpu_mes_self_test(adev);
-
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
 		DRM_WARN("smart shift update failed\n");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 4d1121d1a1e7..b7bfb3185a30 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -1161,20 +1161,10 @@ static int mes_v10_0_early_init(void *handle)
 	return 0;
 }
 
-static int mes_v10_0_late_init(void *handle)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	if (!amdgpu_in_reset(adev))
-		amdgpu_mes_self_test(adev);
-
-	return 0;
-}
-
 static const struct amd_ip_funcs mes_v10_1_ip_funcs = {
 	.name = "mes_v10_1",
 	.early_init = mes_v10_0_early_init,
-	.late_init = mes_v10_0_late_init,
+	.late_init = NULL,
 	.sw_init = mes_v10_1_sw_init,
 	.sw_fini = mes_v10_1_sw_fini,
 	.hw_init = mes_v10_1_hw_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index feb7fa2c304c..5923b7b0bd95 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1274,22 +1274,10 @@ static int mes_v11_0_early_init(void *handle)
 	return 0;
 }
 
-static int mes_v11_0_late_init(void *handle)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
-	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &&
-	    (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(11, 0, 3)))
-		amdgpu_mes_self_test(adev);
-
-	return 0;
-}
-
 static const struct amd_ip_funcs mes_v11_0_ip_funcs = {
 	.name = "mes_v11_0",
 	.early_init = mes_v11_0_early_init,
-	.late_init = mes_v11_0_late_init,
+	.late_init = NULL,
 	.sw_init = mes_v11_0_sw_init,
 	.sw_fini = mes_v11_0_sw_fini,
 	.hw_init = mes_v11_0_hw_init,
-- 
2.25.1

