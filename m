Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DA4C25B78
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 17:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74BD410E18B;
	Wed, 22 May 2024 17:28:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eXvkqYU0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E795C10E18B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 17:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3OkCeucaUZWltruzrm1Azf+VuDnY5qAXmgl+4tfAwzWQWkzzblPf7W4GwMKmOr92R8Em5KbLopKQ+VZ5ceq62JKomxCkoHFiuvJnUQ8IEUi61ES1yzNe4i912lyYRBiWaQoQVEMJl8ZhzT70j9kuBFVe7UBJ74708lPGn622zf/TMe0F0HW9K+CcKtU1OgDTShjvNLijY9rVFkNVj0TTUP+w6Vum+MEB3IwdULUod4AjbLlwOT8xBLrvOCZJzuwNpdH61mIoJWnA3qLT7TfaQ1nptpH5/Oyx29OtQUOSGWJC22OEPvGMq9k9BhfKIWR5P4o5HAoIV3Yo5MeCA8l9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5ZwCR4TSBPVTtut+gkYg5nMNfgDWbn9nl67i3KPQdo=;
 b=VLeYf7JwsR9uvII9uLtOxhsJ8C+y0EcY8bEkKk5Lb65ScHZjm8kR3aoD0R3EIlqJm1/CkDz6c+0dlx0To4Id25MF1f082qIW8lJSOYgvll713xP0zT8XCVL8hM6z2JQC1t2jc+o1VLg5btMC9IUwKNaOUK4cv8SwqLpA4/0krnJ+Q80w7Y8lbFSOARUK5/cFbAElh6DYMZ9DXtx3/HCVmTWfhE0k6filXNssQgJftSBRlNLTxkeH2jQ4ZePxYztIbKNANQQkEPOxfrCmzfPShcRf2ZP9oZbmO5OPgGGikN5McQ1+sjprZmjfZehUhhpoh9X7MGjPZ5CJjmtERXbxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5ZwCR4TSBPVTtut+gkYg5nMNfgDWbn9nl67i3KPQdo=;
 b=eXvkqYU0kK7P9y5qnkGojj1y4xma4QKJEJ6tKwWsi0qo8UhxYYl8KDVLUDdI1EIyw5CZ/15zAKJPmMjNrDW6CAjA/LpI1mnsTAN4oZd/pEUMQq3xBZ+X6c762thOfwRZ8H0tYAB0KlaOk1cliZL2EGUOi2fOrHiqL5fkzPig1Jc=
Received: from CH0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:76::21)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37; Wed, 22 May
 2024 17:27:55 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::e6) by CH0PR04CA0016.outlook.office365.com
 (2603:10b6:610:76::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Wed, 22 May 2024 17:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 17:27:55 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 12:27:54 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH 1/4] drm/amd/amdgpu: remove unnecessary flush when enable gart
Date: Wed, 22 May 2024 13:27:18 -0400
Message-ID: <20240522172721.14085-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf8362c-37ac-4cef-3f91-08dc7a848456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kLHuh03OYHsYoOzJ661uqURnZcLnjCYhK5pksCTL9//yiP+5SV4aJkjyqmLI?=
 =?us-ascii?Q?ulSnQLj5g+KwFhtJOMrUvrwavGyJoj74+LgAjS2L0mvsVcSpKn42LtLD4GTw?=
 =?us-ascii?Q?8lYuIdZAoaE7nn+xYF5sXoO2TWMP5xXQQt65cH+kgQlys++ED3BPZUmHBfY5?=
 =?us-ascii?Q?TWgWU8r5qpErSexkBfioeebx2CLfFFuLCWQ71z/AMPwXAhnf688ayzBP2GSN?=
 =?us-ascii?Q?OZmSX9TFU6/CtPFsc8Yb2FlCGp/a+gJRuVYvy7vlYiZFo+RqOixkU6md5TIp?=
 =?us-ascii?Q?8jW4wCweobUvbX9UpUJ6+DhqkL6iHhkBOzuBrNbEFLSC8ZuaHzw5EGEyngmN?=
 =?us-ascii?Q?kaCwe2mMmLWQJpTgqI3p9kCLT7B8TLMIZtuJguT1l2vUd9QkKTKSo5bRpOOd?=
 =?us-ascii?Q?WB+dcLPSiwbOc7W9oZysR7tkDpLN68Q9mHiQy+VcesLVwXcxtZAleHES63kq?=
 =?us-ascii?Q?wCEgZkQD93S7owzyHLhzve4lE+uwo/HsEgefT6iZzNXctYQq/+JSuSxGwLJF?=
 =?us-ascii?Q?W4Pz8B4SqqeSs+m9sv2Nk8e/h4h0/EW1be2PKlRX0qFVSnL2wr49fwb/iy+g?=
 =?us-ascii?Q?2DQiLdQnsT/Qm01cqfDhZ0srqw/tu/KkrZyKPjWiUXWJiZpkJOupJTn+otlo?=
 =?us-ascii?Q?8Az7J+LQUd5MPj9HgnGlaaeV0MrcUXzDX5CLG/nPripzSYoZArk4WTxNw1K1?=
 =?us-ascii?Q?8gnYFUDgRcPPADKHK5R2hWk0RK8teF/yj4mk7tDDNgk+1Wr8RrSy/VCnO4zv?=
 =?us-ascii?Q?6zLkbXjSUhtaOi2cJtMo6s3Bz4AzbR92nFwsxf3YlDsqhVc3cxI4oh9NwaFq?=
 =?us-ascii?Q?a8S0c9n1pwByUqzrr9BSPXirfXazf5A6AjU3Az2sIY/tTQAPsues8tw+cBi6?=
 =?us-ascii?Q?5NNlcKmYS/OiQH+RiFJ4NTEnmH57FWEdxCN+ECiOaqNc9n8hZql8ykaHVsv5?=
 =?us-ascii?Q?wcrFCOSX7uSLoBmMpxq6IVg/WolrGRtGJXLBq53Qz5moNB1frL3QgkQ9WVSI?=
 =?us-ascii?Q?JpJYlaGrzsJeMcCOHc9GP6C0LFGcA8gtqJmfuhMwXKn3LAQfDO+W9x7xps7s?=
 =?us-ascii?Q?PnYXP4bW932bEffnEanu3rrcZ057g7rTvGWf8wdbqHGjedIMtCmpwTAdX53Y?=
 =?us-ascii?Q?zpK1mhfgRtH42eOnlDF7yJL/bifNdLNFOai7abYedgPOAu721YbjtiRq+KdV?=
 =?us-ascii?Q?04oPtNM3VEge+MEspk7KHYWy+VDc/RXUOcDJhIzQbOrZyjpGIcxKK8TXWV8Z?=
 =?us-ascii?Q?xvq9EBI1znM2/zjYCBiinwLaCgRZI7DTxqZQ5umLvJmmqz9CZzJZN/xwPU98?=
 =?us-ascii?Q?YM2NF+H75pwNIMForj/oygpVf3Gh1sW9tjJmkb2U6U6g9cGvPUsN66wl3ZC9?=
 =?us-ascii?Q?cBdk9TZi01hzshKxJ5lq2WPSV6Fx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 17:27:55.3659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf8362c-37ac-4cef-3f91-08dc7a848456
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846
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

From: Likun Gao <Likun.Gao@amd.com>

Remove hdp flush for gc v11/12 when enable gart.
Remove flush tlb for gc v10/11/12 when enable gart.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 4 ----
 5 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e5882da8332a..f9932b063855 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4204,13 +4204,10 @@ static int gfx_v11_0_gfxhub_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	adev->hdp.funcs->flush_hdp(adev, NULL);
-
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
 
 	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
-	amdgpu_gmc_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6419f98e32b6..88ca252251c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3186,13 +3186,10 @@ static int gfx_v12_0_gfxhub_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	adev->hdp.funcs->flush_hdp(adev, NULL);
-
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
 
 	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
-	amdgpu_gmc_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d933e19e0cf5..3e0ebe25a80f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -974,9 +974,6 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (!adev->in_s0ix)
 		adev->gfxhub.funcs->set_fault_enable_default(adev, value);
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
-	gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
-	if (!adev->in_s0ix)
-		gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
 	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 527dc917e049..cadbe55f0c8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -891,9 +891,6 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	/* Flush HDP after it is initialized */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
-
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index e2c6ec3cc4f3..a677aca69a06 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -861,14 +861,10 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	/* Flush HDP after it is initialized */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
-
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
 
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
-	gmc_v12_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 
 	dev_info(adev->dev, "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned)(adev->gmc.gart_size >> 20),
-- 
2.34.1

