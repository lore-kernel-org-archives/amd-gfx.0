Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7158BD3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C40810E4AB;
	Mon,  8 Dec 2025 17:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PNKIIJ0F";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B93510E4AB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:18:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCYcKaq4v/zcSj+7do88TKxiIbIX5JGi+VlPPs4uAd4d12P9e2JUS0wSP39e+Iq34X0/K9WokqV4emEsfap4p50k8kBEB5xE93Ihk90QUKm1YNVGDfTq19theJ6AGKKaCFhoHWl1K8IBctQonPKbRgQqrjJURckzFi/JTd2KuwV2sCR0m6ERs8Rx+sS4Y8ARoeTRk3oLSnj1oHdWUOF8lJhMpvH3lN2DnxdWm6LGpjooGBvd/u0GANsoDW79cbju/kiVPwNCTVpEg9fpj2szQr4e/LH+hf9/Wi4/bMrAjCVli1jxEnmcjtgzqNI9M1saCIrNihxUo6RowvQ1TKt0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0KGQe95pypBAGX/aHVE2fUZDBIKP5lFCXbeTnuPOWs=;
 b=FoSVz2z0bCO6dUPbd4AB2N/m7xgZ0zvC1yYZ8CgLu86EsU1i/nJjffgIKtoaTDJ+ENAqHcyRfQ8GBuCj9zUnq/jBOrU+1hptc+QpFXWZnWZmDFvBr5nfk9NBCqJLz6ZWqt0gHEuqNFpj4bJY0MXeSsS/qCFmoYVz91pp/6+XsCa5HIQcBPvOfFeoC8ytnuKh1PgzwoUWfKAp+xFL3q0/3/Iff0i47wnen5354x3CoOo9Px0VoNmP5ooQz/bf5ky6LHLHVE8Sxr0YXWV/joyXAvsCTlCK6NCvrpHQu+31JynwXB9a1eKBJ+gKWRvsMe+ZUvYc1GS14OK2ne3IMOHJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0KGQe95pypBAGX/aHVE2fUZDBIKP5lFCXbeTnuPOWs=;
 b=PNKIIJ0FBqDc8YHfG/dXhvOsAownC2tmN+b6eRBaeIHPOCr8rZHLBm9XpxCKWznczd8gtn+QjE1oIe5XAFD3wqZehie/GTDsGDKvu9DROyfaB8LbATDnbzKj5Tnqjcr829UszaJuvl93f0ZQnmc/9lFiHv+W35EtKyrczilG+p0=
Received: from SJ0PR03CA0136.namprd03.prod.outlook.com (2603:10b6:a03:33c::21)
 by BN7PPF49208036B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Mon, 8 Dec
 2025 17:17:54 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::ca) by SJ0PR03CA0136.outlook.office365.com
 (2603:10b6:a03:33c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 17:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:53 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Initialize vram_info for gmc v12_1
Date: Mon, 8 Dec 2025 12:17:12 -0500
Message-ID: <20251208171720.153355-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|BN7PPF49208036B:EE_
X-MS-Office365-Filtering-Correlation-Id: bebf0fab-beda-455b-5215-08de367db911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P+G9uOhdX9Lh+VjvgH37KZ953UQ7HNE5+/+U5MSBgSwxy4mLaSmnJoQOyPg+?=
 =?us-ascii?Q?9tjISqF+l6PMgWC96t/Q5ZacIo/x0RZV+pQGuGxjLcusf++BjLtKslgsKN2e?=
 =?us-ascii?Q?dOZI8TYMjwGBIryyz+RL4mvm9m30IBfdtxF2mw9tOUK/PpRRzn7SJoyxhsol?=
 =?us-ascii?Q?33Zs/pJoPRgkzokKw/gx3EKc8QvjtxpWWgabMtanNQI5zaTn1piBY8pdLuNx?=
 =?us-ascii?Q?5tlAYVU/rMADg74y0I/W0LBImU40mvf5SB+1aSMFRKGg2y9srNcPYAxiHfhw?=
 =?us-ascii?Q?NQuW1VFxXJ5H9kANhqRJUNlBxHvzgRhvGPaVZiH+TAiYo3VbCNT9RLkDEKRI?=
 =?us-ascii?Q?2SJ52LLSOESJ/N2RWPMhMTVt55KUU8PMFLujFzYzhvt0HMvLevDoi5PM32nz?=
 =?us-ascii?Q?ERDRaMmTbR74Yq1eGBbeMiolqY2mWcQGkvirxFdqqEisZOHzsT5MFzOM5ADe?=
 =?us-ascii?Q?fMCRrUiHH9iQQTOdTr0jU4PA9JMphgjKy5w9+p0/iI6vCsQdjZFK7m9NpPdh?=
 =?us-ascii?Q?O9VUyfe0hiEV8C5pQ8q9VEySXveHxg+G6r8HGEyjNnlDI8Kae0Xwr/MBfrXH?=
 =?us-ascii?Q?wEdb9mye4ZDFLqQ64D8Jnh4NQ2/wDKIyK4pRNAaLNanzVBPU3qLU935UEZLs?=
 =?us-ascii?Q?hNSgtTWiDlm2MDwtc4THf+5y/8CaezhWsMGADZ/kW0CN/8ZKNdFZWNrcI31j?=
 =?us-ascii?Q?R6ZO/RyZqXX46VEfSc1ESp5E5ztSOMQCevzp4Y11jcLNOfFhahuOhKOl0gLE?=
 =?us-ascii?Q?TBUbYhxnmQ9BF0zMVbS0KWvCi1ejkNWt7stBCgt0ZL5aooJVpwjgafhj+CLA?=
 =?us-ascii?Q?s+ON1bPOQ4pl0GjdYar09UTM77by1GwRDnYcvnM7CpmvF7DywxyDyS2AVduN?=
 =?us-ascii?Q?xPV6YUtcVDS8NxvN9NH9Fx2iCRF3mERpzz8d8tPvfv9DDbRbeVaAfvB0/J1w?=
 =?us-ascii?Q?RQ8KzHiP1MnAOHJcWDBkH3qSjUL9uD7QkTdPDGG7mV8ZOSYbmYPH1WAsdGuN?=
 =?us-ascii?Q?foGoRbT4x4ONVnBdk0rlC9Eqpvb67Ex5H01rn8WoZVwkmwLEZBH9a//zS3Rj?=
 =?us-ascii?Q?CtmExgDFp14gW0bJnmXX1A7nX60BNDWuBDl3SBBhfz2MtT3lSwLKD4E9+Tk0?=
 =?us-ascii?Q?YCyKylcFuirbZwPMBXzYt00bCgR/YCTQuPa/chb1G+SPz5xT1xMednCK6ESu?=
 =?us-ascii?Q?CPo847/6JYZBYIh7Djhw/s2w8wbONC25uZ6fA4tJ5hh1Obg+XgWVDFjWtT5K?=
 =?us-ascii?Q?qzoH8AvCbkmqcnd4GYLNsWBXDj4O/qb6jpg4JayHXRTd5GKdVqs7EzkE0+vI?=
 =?us-ascii?Q?kMVynI5Dft1M4JIr9WBCKsmikiQnCUOcOAllLLO5rB+67CWv5tHTcIfZTvZP?=
 =?us-ascii?Q?ahLH8QnWaENqkEkxSeMzdH4BemyFTEocF8uDEzUAnQS5SnyroQay0YPFiTC3?=
 =?us-ascii?Q?VpLDE4NRbtpK9b8A2Ayput+ZmU63qeKrdpHhFkO9Ns83IvYx5mGp6d44SktB?=
 =?us-ascii?Q?gXD8He1dT4ZRnpfsVpSfRjG6kGn9JAbxB8QEV/F9xl1WFASR6HrZZv6iHIvE?=
 =?us-ascii?Q?gqbgWfBZMYL8sF4wmsc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:53.5571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bebf0fab-beda-455b-5215-08de367db911
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF49208036B
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialize vram_info for gmc v12_1

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 15 +++++++++------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h |  2 +-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 8e3e2d3c553fc..90c5159a5a85b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -781,12 +781,15 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	r = amdgpu_atomfirmware_get_vram_info(adev,
-					      &vram_width, &vram_type, &vram_vendor);
-	adev->gmc.vram_width = vram_width;
-
-	adev->gmc.vram_type = vram_type;
-	adev->gmc.vram_vendor = vram_vendor;
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
+		gmc_v12_1_init_vram_info(adev);
+	} else {
+		r = amdgpu_atomfirmware_get_vram_info(adev,
+			      &vram_width, &vram_type, &vram_vendor);
+		adev->gmc.vram_width = vram_width;
+		adev->gmc.vram_type = vram_type;
+		adev->gmc.vram_vendor = vram_vendor;
+	}
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 50208a3456a15..c54d2d10a8caf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -597,3 +597,10 @@ void gmc_v12_1_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gmc.vm_fault.num_types = 1;
 	adev->gmc.vm_fault.funcs = &gmc_v12_1_irq_funcs;
 }
+
+void gmc_v12_1_init_vram_info(struct amdgpu_device *adev)
+{
+	/* TODO: query vram_info from ip discovery binary */
+	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM4;
+	adev->gmc.vram_width = 384 * 64;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
index 67ee5f7fd9b45..2f08f4b8cd99e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
@@ -26,5 +26,5 @@
 
 void gmc_v12_1_set_gmc_funcs(struct amdgpu_device *adev);
 void gmc_v12_1_set_irq_funcs(struct amdgpu_device *adev);
-
+void gmc_v12_1_init_vram_info(struct amdgpu_device *adev);
 #endif
-- 
2.51.1

