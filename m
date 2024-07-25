Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28938C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC4C10E85E;
	Thu, 25 Jul 2024 15:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oSqnhDUq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD8210E850
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp4kybJA3i/QyxSV2W8CN+53LtFjaVa1LYWBimRkQWPvVlF5yjdlI2WE+3CUFniKgS8etkx43AiEc6eWIZ2pNnfcN9zSfB88dZZXraB9V5W2Oe8z0E0z8/OqPHLPdUrjYhBnQtuB8/zKN+bJUiShIGZ1N1kPV7bH+39ZrmB5qfWWUg6HkHs+Vy+0lWd2flVC+7vXtXdUW20WvA8Z1z6EYjgn3c6Bm6jh0M4nPBmaIVHb8Sy8xxihD72xOs6cejT8LimEP4Bs+M8dS83wdxSLnHyQbvB8TUB0JEbxgPLK/J37zAvZ/BNu6/eZLWKTqJ7AJC0vTE/XVsRt7AN0UaF8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNI3QYMKoWFuXico6TfM1mA047vlsr5dPr0gZfXW7RA=;
 b=BD+TpFSTDIDpsU/AXKFlUVHKqD8Pl0gFJo1j1Ei7BaGWdtbLwSqPPxzneDuJrIfhBgx3TwBOSjKOu2ZWHPMIwpo7UVxLhD2QeceMnLEWjKkSdc2SUO4aTuXI8snsChQig/EuMFOUnwMOQWAzzH38y4qzTIuy9/AiKlqMI3/T11ZZE4ZBUIWDAnS7IUiD96idBKQs8+vc0BmQ/xZ4KR3lZNwfdJDdY4d5Wd2U38TZ96LI8YwNu+82D77rIgWizc7U9b+bLkXSRFKJT+nhxNY2+1Hq6AT6wySD/5p3k51QebTLatG7ZpUzhaUp2qK/1GQpbN66iRtOkVX5EFxD4OqvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNI3QYMKoWFuXico6TfM1mA047vlsr5dPr0gZfXW7RA=;
 b=oSqnhDUqAF5vihDxBDcTq5L8mfNEPpmntNLjyhqiXiALymkaOkVR/g874rt2+FEdnF6BNNU4nlnunri9oHg2ekEXB9JALsJY9eoRJ+G8IXt1MNiQp8gQ9bv2H+3tPmzrn0Rtt8pXiKpQ9yzwFeIp8MkqpD3PKwy3uLOyPBShbwg=
Received: from SJ0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:33b::22)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 25 Jul
 2024 15:01:21 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::70) by SJ0PR05CA0017.outlook.office365.com
 (2603:10b6:a03:33b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/53] drm/amdgpu/gfx10: add ring reset callbacks
Date: Thu, 25 Jul 2024 11:00:18 -0400
Message-ID: <20240725150055.1991893-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: a19356b0-708a-4d55-e7a9-08dcacbaa500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ipokKJOuDM4AtpHaoLTIL4Rgia8yr9QW3ARnHx8ffXL8cD3EPODIPLznSAml?=
 =?us-ascii?Q?pbdZODeygEgUWbKcrv/z++4A5u8NUv/q7jTcutcc3CoAD5oY8UXRB4oFQvep?=
 =?us-ascii?Q?6dXHMIsr4GDzlCWuisbVmgBcwRFTqfyFhs0EXdgF2FMzc0Mfkm+UDul/Cib6?=
 =?us-ascii?Q?W2DAyW8e55R562G1gtP8/mj5fIyC5xEHA5DOeDMIdWSq2If4b8qlEP0PeZ1u?=
 =?us-ascii?Q?EGAUtHcECe1jqKhHNKuWC3A/PmoRH+ix/MQyUezwlT6fSVrcuidkiiSJc9gl?=
 =?us-ascii?Q?hFwKAm7QSlTlpE+ZBQTEcdpFrxMuvmyS4cb5xNBevioMoKZSvgyrqfFrAMel?=
 =?us-ascii?Q?qBe4wASmNGAvkcQg6Fx3Ic29sv79qQRnOMIxxcG5f+S7uVRnjn3Yfrfj6Xot?=
 =?us-ascii?Q?jCnpKca2GP1CvTM9ZwZqOrKmwSNvQtDrIB7yiPhxLNVu9TzhyDmXotG8pVnZ?=
 =?us-ascii?Q?Q+m9BEXdUlJ2Bn9F0SW7SC8BmJC2+9MY7t1Yfvy6tzfBaA2nm1GW5MGz7qfU?=
 =?us-ascii?Q?CnGLpU71oHqfqI+XZn5wSbEidH5Y6kriYiD3ZTy6wn6Gfv/hCtydUPHdvyAm?=
 =?us-ascii?Q?R5BfXrI+yyvbf6qy9MYGc/7jBqs0jxEewDr3W5GdKaZamnwkXbbIPcA4t6cd?=
 =?us-ascii?Q?lR5Gph8wR/jBoJBUacKB1yoOHGb/mQFkjLWNCZdv+Ch5tdHiaNonPylLnW39?=
 =?us-ascii?Q?GRQUuUqPzVh7pokDt7nAJLsb31EHbBD6nSLssUZXTsqAUBbAC3XZf25rJVcI?=
 =?us-ascii?Q?fKuP9gE4CjDq+/0e4oqMBuet99KKMana1sZqrDyeGGmZnBTeXWoQIqwHf/Lp?=
 =?us-ascii?Q?hztZDJsJPG1HqvpQAh+Pk/oAS2vzz4pDcaIUwvJyrU3xs/TBzFtjJIJ2YCoD?=
 =?us-ascii?Q?JMj8HNrUGQ9CkRDL5nsehAZUcmXQyomPPySvBchlHr2ElFxHTFSHKwI7G4L6?=
 =?us-ascii?Q?YuTTIrsQFVclexnEtGO2qdI7hKKiP98IXaWxN8QcKfeovhDevhI4Kk51QsDu?=
 =?us-ascii?Q?ox9iu1fyDX/vXKIKD1gMEg6vXwRjRAsYvdXAFu/4REyKkBCDDQpycc5OlPeF?=
 =?us-ascii?Q?uvAs+qbg4/Fg1ggahZZz24/ppFRVWj9qoXM72tAUBuFXLBagbE84m6lQHrqY?=
 =?us-ascii?Q?kBGT0vIdvX3O9CDLWq4qxiazIAj8BYCtycFVzvCzcmJ4/FhEpeu+Zqa/uC+h?=
 =?us-ascii?Q?5MmfQ/JuSZVM07aYazOuXICwioum0yBvj3L+jGUCoglbsrHDGN/d+prmdAbf?=
 =?us-ascii?Q?zrXC+aF6mCvNzo143YbtwIAtv90dQ3L8Mtg2RPojqSflcLVEftFz7Q78Qd6r?=
 =?us-ascii?Q?fXywnFv2yXGm88TV5ocmtbAfbY9g//YEcgV/7Cfa373ndgC9phb2Z3+oJD7k?=
 =?us-ascii?Q?0Dl4igEtO/OYoAL2xKszjj03fU2LLaadAnIqmzpAhEGd3yeC0w4nAsMs06Dp?=
 =?us-ascii?Q?JYPs6O9f95MsUlEYdZsdA+hg9I0MDsha?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:21.1181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a19356b0-708a-4d55-e7a9-08dcacbaa500
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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

Add ring reset callbacks for gfx and compute.

v2: fix gfx handling
v3: wait for KIQ to complete

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 91 ++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e3f9a5fb4151..8cc701cf9e17 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9454,6 +9454,95 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+	u32 tmp;
+	u64 addr;
+	int r;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7 + kiq->pmf->map_queues_size)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	addr = amdgpu_bo_gpu_offset(ring->mqd_obj) +
+		offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
+	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+	if (ring->pipe == 0)
+		tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1 << ring->queue);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE1_QUEUES, 1 << ring->queue);
+
+	gfx_v10_0_ring_emit_wreg(kiq_ring,
+				 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), tmp);
+	gfx_v10_0_wait_reg_mem(kiq_ring, 0, 1, 0,
+			       lower_32_bits(addr), upper_32_bits(addr),
+			       0, 1, 0x20);
+	gfx_v10_0_ring_emit_reg_wait(kiq_ring,
+				     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
+	kiq->pmf->kiq_map_queues(kiq_ring, ring);
+	amdgpu_ring_commit(kiq_ring);
+
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r)
+		return r;
+
+	/* reset the ring */
+	ring->wptr = 0;
+	*ring->wptr_cpu_addr = 0;
+	amdgpu_ring_clear_ring(ring);
+
+	return amdgpu_ring_test_ring(ring);
+}
+
+static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
+			       unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+	int r;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
+				   0, 0);
+	amdgpu_ring_commit(kiq_ring);
+
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r)
+		return r;
+
+	/* reset the ring */
+	ring->wptr = 0;
+	*ring->wptr_cpu_addr = 0;
+	amdgpu_ring_clear_ring(ring);
+
+	return amdgpu_ring_test_ring(ring);
+}
+
 static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -9657,6 +9746,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
+	.reset = gfx_v10_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
@@ -9693,6 +9783,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
+	.reset = gfx_v10_0_reset_kcq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
-- 
2.45.2

