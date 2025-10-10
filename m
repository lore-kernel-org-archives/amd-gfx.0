Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D4DCCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 14:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FBD10E089;
	Fri, 10 Oct 2025 14:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vXdRmScF";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9198E10E089
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 14:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFYWw2asOOJYyLWbZRPz+k2u8AJ8GjIgYBdYwzwiZao8tIa93q24BypCjkzm6e72zg7rPzIeB2+hdxOb7mvy7izcbdW3wtUjuhSvOebUPvCO/o36TwkGJWx7GE0hdrv7G7QNRRtSoiPykm7GEcKlPYhW3ro0TjWM3QqlfNz2XlSPFNnNPj3n8VM3d7GJBeiOLkz3+C4mas+s5Xy74WM97e8UhDNETZO8hzVwwpfLzwCtnUS8/31AVNy37MS4cp4tSvvkNiACOMw8Pi9m9GhPinvkUo9AKE4vX0eAWudpS9fjcB7DS9AXThGrTj+6QQAvfUXxHt7KvJMaSFORyDXf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t23n869PFIhkD8fXMMYMQcHSGLA6x9DrFxj8VG+zSUw=;
 b=F0rezRG1fFSh1xDHsSQ8BXk0YhP/Fi06GyYAU5QiwBl/l5FYYViW8odE2L8sV8iXmUGR6fg082XXhi7u+DLLYxFh49kMp62PLXRgJWT9CmhHplBzXg1+Q4IRzo/n7qZ2iNCV6RVWXShAcwUSckdL95g2z0BUyBi2esWN7SScqFGbbYGWndckQkSPwUfdCK/4XZ1fRUNvfA9w578N1cTaldwpW0TNqIK9yXYRjvuFMlU7AwZqM13A1ZEmFZU+qtVItPvvS+pDlhIORBzbOroEdTr14hDYRhI7rldsEGumDc8JG30a2CUcfo/H0e//pu1xYBdXarBTZ9JYu+lM+9/VwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t23n869PFIhkD8fXMMYMQcHSGLA6x9DrFxj8VG+zSUw=;
 b=vXdRmScF/3BI+LNvoEdE+j2/5MOVLhut8iGfxm9G4emQOTZBkVwkt3KW5obSC/5do7+HB7ISnZYKVlBicczsnBsceCMaDxboilXD23RQV75LczgO04wjP0BIWziLhx8TBHBu3sz32dhKEAGs9VX0prgQv9HDmxNGw7z4DaoQwXQ=
Received: from BN9PR03CA0474.namprd03.prod.outlook.com (2603:10b6:408:139::29)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 14:58:38 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::eb) by BN9PR03CA0474.outlook.office365.com
 (2603:10b6:408:139::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Fri,
 10 Oct 2025 14:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 14:58:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 07:58:36 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Reserve discovery TMR only if needed
Date: Fri, 10 Oct 2025 20:27:34 +0530
Message-ID: <20251010145814.3514884-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251010145814.3514884-1-lijo.lazar@amd.com>
References: <20251010145814.3514884-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 6752d914-d96c-4e60-c0f2-08de080d7e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JE/Qz0PSSChKVu8xcrF8C80v79woyOfIS/07/ZcpZzB5ZTb//t4hzA3eEIRI?=
 =?us-ascii?Q?ChFliYkat3UeY5nXv2c/mLQwP/NveRkfUKB7cevjmHka0nZBFo35wVbBmhHs?=
 =?us-ascii?Q?1/LPhEQItI9gJ53ss2fM/fZdeV/JpUyDsqiQ9qjOI7H58pJa8mc3u4erP0aP?=
 =?us-ascii?Q?MZzpD6wmv3HjNzXhrgfCFiNBZP8LcSFqLZCQE13omSe3xmZsVfamD6j4cxfm?=
 =?us-ascii?Q?tU1Ikw52Q2W4h2n4rp0JiO7g0uQVfrfiYhYypVuTcGtNNEUBYF1o5vE4QREq?=
 =?us-ascii?Q?CivKRpgAQDCeOGDpO7+IoYHorHvnsuGbiHoQoCvM/9KzE5ZQvfnSEvFNp7qU?=
 =?us-ascii?Q?Yz0+UM3jtj/h+cHVE3k18aViw++AvreA5VrZCXZAPKjIF0/sBOyLdF8RvLWh?=
 =?us-ascii?Q?Wb2WTW/uDawCa+/Y+ARoFzCAJiulL9ucaLrOkKGVqK9KfdEU5R+9MRAmXPi0?=
 =?us-ascii?Q?lhbGJa+Ty2nmyq0vRzKX7kaLKgGVLKNivcSn1Um/JCbZ3YQdNQSgqJS56KGw?=
 =?us-ascii?Q?Uij/SdWDBSx3WTs15CP+8eMiy8Ia8cWLi4/Wxt+b9NIoCxUT6/VtJaKaxvxy?=
 =?us-ascii?Q?GL6Sd327/hvqROKPum9jQAJ2pz/gGkwj5RJdmY+Cn1gD2P3po/zM0XLxY43f?=
 =?us-ascii?Q?wfemUkPaGw24K8mwPyZ/eOvbwKlDLCihidA/ZsuY0z36Yy9eQTnF+VwcMIkR?=
 =?us-ascii?Q?RHacGbuGdHEvNW4s/PxwTBgpzlcUN4eq9iiuyg/Zy9/U+ApyKGq9aYuWVSsM?=
 =?us-ascii?Q?n7HQNpR/Yb0r/aGdobuT60A5jgZPXc7Gp/F+FEFSjUh2tMxVdq+Ey8Cv3TTB?=
 =?us-ascii?Q?wIobdAXoaRqxlZn/Csv2j55U8yNjvhe4bRsRcRICqL0SsMZJgZC0CTQ5fA1r?=
 =?us-ascii?Q?XpYTSaPEunfMyoQwqAl54Tli+Oc9B14AnYBQ3BvufDcSxsiOqJzPzoEqYxjA?=
 =?us-ascii?Q?mVR7ecYPmCV2wmn9MFalhLMRIBt16Sou98TFoE6Wg8aJSuF01Nl0OJai5oPW?=
 =?us-ascii?Q?a59cYlY6jDa10iwFbHdcIGihyvOoXQ0a6LDMJvSHLpB01MsD1X/nv6FysOJp?=
 =?us-ascii?Q?W6kTRN8y37e20bRpU7SALafmgaFo3Sw8cpqQlQamvgr0J4eSA5+2zBgjLQZ8?=
 =?us-ascii?Q?K36/dKIOXUcXAQjFzfM8vqlcRBEMQSdMXaGIpKJgflyxQvVUeFxHgZdWnFEK?=
 =?us-ascii?Q?B8OD5M7z7VTCT4W8W2vtWwOMOW4FzyKXRz/wf43djB3FOMr4jpKbBfuhqoMp?=
 =?us-ascii?Q?T7FFi7b4DThf+uayzyEFIV2S/K56EmKU1KJQz+RmBz3FJEIhsjvjK9Wb/9Kt?=
 =?us-ascii?Q?Hpy/2luNeQnFBjP+S0VDXTWPRmgVZLXEyzwEuloVeltz7t6YQj1fCv3lP8xk?=
 =?us-ascii?Q?g3QZcWGv16n1HWVRtrXnbkIgckddZKGp6k1fw1FtX8s8FAPjKA2XevA2H/Gj?=
 =?us-ascii?Q?Ub7wRj0vnuJGuKjxnPVYjyT8dbFpLl+7h3N5HbPcTRvvfcrr+Ku3IQ9nx6V3?=
 =?us-ascii?Q?XtuyNcwsJeLWwFavO9gSvc1uSa8/y/geYe25bvgILBnIJBD7FDBbXSmhRYDm?=
 =?us-ascii?Q?Xdo0qdu5b2pRhCObX2A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 14:58:37.7410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6752d914-d96c-4e60-c0f2-08de080d7e2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798
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

For legacy SOCs, discovery binary is sideloaded. Instead of checking for
binary blob, use a flag to determine if discovery region needs to be
reserved.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 22 ++++++++-----------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 02b661232db8..478cbfcc5b5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -298,10 +298,15 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	else
 		vram_size <<= 20;
 
+	/*
+	 * If in VRAM, discovery TMR is marked for reservation. If it is in system mem,
+	 * then it is not required to be reserved.
+	 */
 	if (sz_valid) {
 		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
 		amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
 					  adev->discovery.size, false);
+		adev->discovery.reserve_tmr = true;
 	} else {
 		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
 	}
@@ -418,8 +423,11 @@ static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
 
 static const char *amdgpu_discovery_get_fw_name(struct amdgpu_device *adev)
 {
-	if (amdgpu_discovery == 2)
+	if (amdgpu_discovery == 2) {
+		/* Assume there is valid discovery TMR in VRAM even if binary is sideloaded */
+		adev->discovery.reserve_tmr = true;
 		return "amdgpu/ip_discovery.bin";
+	}
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index b1eec3af3c4a..4ce04486cc31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -36,6 +36,7 @@ struct amdgpu_discovery_info {
 	struct ip_discovery_top *ip_top;
 	uint32_t size;
 	uint8_t *bin;
+	bool reserve_tmr;
 };
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5bf6bb3b2faa..d0a7379255e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1767,18 +1767,14 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
 	}
 
-	if (!adev->gmc.is_app_apu) {
-		ret = amdgpu_bo_create_kernel_at(
-			adev, adev->gmc.real_vram_size - reserve_size,
-			reserve_size, &adev->mman.fw_reserved_memory, NULL);
-		if (ret) {
-			dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret);
-			amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
-					      NULL, NULL);
-			return ret;
-		}
-	} else {
-		DRM_DEBUG_DRIVER("backdoor fw loading path for PSP TMR, no reservation needed\n");
+	ret = amdgpu_bo_create_kernel_at(
+		adev, adev->gmc.real_vram_size - reserve_size, reserve_size,
+		&adev->mman.fw_reserved_memory, NULL);
+	if (ret) {
+		dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret);
+		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL,
+				      NULL);
+		return ret;
 	}
 
 	return 0;
@@ -1955,7 +1951,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * If IP discovery enabled, a block of memory should be
 	 * reserved for IP discovey.
 	 */
-	if (adev->discovery.bin) {
+	if (adev->discovery.reserve_tmr) {
 		r = amdgpu_ttm_reserve_tmr(adev);
 		if (r)
 			return r;
-- 
2.49.0

