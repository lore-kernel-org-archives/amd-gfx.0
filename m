Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E399C3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 215F910E8D4;
	Thu, 18 Jul 2024 14:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O6y8zHMm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B1DE10E91A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctbcVNlj4c2pI6qW8qKymmzkF3SHYV8KT9SnhvzMsRTAXRJVdIsloE0dcCkoywKev+hVOuq+fT6bbylfN8gYK8rBPeS5P3XoTa3hYRYiH4lIc4It2WxfH5WbNv5rq9zi3+A9PGxVuevswjFUxv13vKqZR/g3+nA8gm0V0NmbDDThcvHBGcUH5dQaWtH4bwBkCE7A//vF4aui0Q0iFnSJjW66UHNipUajMc/sRaMZz4PMuIv87aoS7ZzEnPwRz3YG0K7rfUHiWcMbM+L0mrBahTJQ2b9wdBYBqo9gWTJKxehLMnRIvFYdPusD9kArAlbTq3UDtgYasxZMxj3ijaWs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRcP/kSGyBEh2HddMPyXhcnlbV8Gty2gsinK+xHOLW8=;
 b=ZG+sE3BlRcM/medPcyey3j0f2qVG0WZYeriZy78I+oyKxDu58bU3s5xRY2MUqChfi9HzcyH9NhMeU5TCw5eDu/QRPCDQT0lFBzKdpBimPOcBHgHZ0kg0H4stTq0bqPBFkP3QpzsDQMFBse7eDSglrjz4NRjPXu5yLifmHYAPzT1Ljy+EZMq/V230ChRRs3KSqACrv51lj9fFgk5mjAg7wCbhqLG1VTqfh61a7j4SBYQ30oI5P7qGFYiyxmCEe8xh2QRWWIaFcsgrPfaqDrUrVUUkGNwtp/3wJnYikllZj+AlLuDesp41FNocVkQiVuR2wh+v3Oeecwq7flxeSxTG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRcP/kSGyBEh2HddMPyXhcnlbV8Gty2gsinK+xHOLW8=;
 b=O6y8zHMm+Sbi9EDjg1GiW+9Kj5IVTuH0uv/7RzfI0S1vYXunsu03rsO+G2RjNVetvRcy9fb2od4b3zR+oq1Ikq8Lr+fVlQN1UaCMStGybUacHbK1/tdNMmOU5IadWuKakZxWKIjVUVEH780AzoBtMNQ+X+S3MDAsq4uRa48yDGQ=
Received: from BLAPR03CA0054.namprd03.prod.outlook.com (2603:10b6:208:32d::29)
 by SJ1PR12MB6097.namprd12.prod.outlook.com (2603:10b6:a03:488::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 14:08:02 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::3a) by BLAPR03CA0054.outlook.office365.com
 (2603:10b6:208:32d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/34] drm/amdgpu/gfx10: add ring reset callbacks
Date: Thu, 18 Jul 2024 10:07:13 -0400
Message-ID: <20240718140733.1731004-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SJ1PR12MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e739b5-ab04-4104-26e5-08dca7330992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tjfK1vCcA83gSil4Qltwmj8uXwOococdsJ3nPWkhT0PzR2QfesRqGBHgE1pL?=
 =?us-ascii?Q?GL+Q57x/0yQ9FvBZudQUl71uI2HYC19RA6FoiytFvtkbD2g2437W1Rr9yPm4?=
 =?us-ascii?Q?VaSSBVPnZG0BGuhJhnSuB+xDiVe7awB0b+Lk1n2EH5Ktk8D6iOIw/jb/mmwv?=
 =?us-ascii?Q?8OlWtQ/gguzQHe5LwIZwLridCwchEs3c49hLLp/kdqrHy3MnTuAmNNhz8v7l?=
 =?us-ascii?Q?0SBzPRTl2XwRvoGaZdYIe6n6G7U9Jtw7SbheLG9+GU0qP4zxKq64FhJGwVJN?=
 =?us-ascii?Q?UMZKeCOu4YJJ0ZuuvbsH6WDBPsAizxh8ENMy+UuJBcfglpPoiK3YMpmb/MJe?=
 =?us-ascii?Q?i+dmjYS5u+FZkaRdewsMlIVBD1DTYeq7GpqPtBkUjXlVuEqGYYilOZp0NMAo?=
 =?us-ascii?Q?H64dKvnLkO7YkukuE44o5HD38SAgCsj8CuALhBk4P8JNLo5E/Qva5BVOIdhG?=
 =?us-ascii?Q?fbM0o09EdiS6vy+YhD1CIPPSVCukRPPyM2pWW6iHWNK+V2Pg+U5DBPro0nat?=
 =?us-ascii?Q?JhHSiBBmLUVoWcPIuGO0cuphz7OO7+5Swgvw/9CgBz63lWJrop9EQrtH61Bv?=
 =?us-ascii?Q?0SHKxX/0SRDu9Ra+t9Uvvy4zA+XDr/zG9rfh9D+jcd30flKRrwmOmH/h859j?=
 =?us-ascii?Q?vPx8yid/cGsT0mnEYbElf9LdwbsjRyJRheUSe+33BzVmeq7ptDOFL4j46f6l?=
 =?us-ascii?Q?UMAYR5QNtL+GIgOJI24KFRNnSEfB+X4UXvL2nRnZt3/IdDafj0QU3l/UO+Em?=
 =?us-ascii?Q?3AwtPOheynO7tzDXxtpizEw7PKzbUGvSw5ognKUJ/NZLRgVrXf4JlpUwfo9V?=
 =?us-ascii?Q?x28r+O8tNKcwHjTtpEWS2RpckGr25kkIw0RIOE15/YyX66Y2CTtEWkeDMSDi?=
 =?us-ascii?Q?rWf+uWw2s+Rcv7CAgQpEJIXQfOzpEgK2InGNBA5xDyiGdHzn2U7GTt2RoLm1?=
 =?us-ascii?Q?5VY1NItb9NOP+w0U0NFjPNEZMIzXLupZ0gX3O4iME87e2M7yWuqLm6hYqijD?=
 =?us-ascii?Q?qTLKU7qmGU9mYQ7sYfmwsB1XmvVVHV8kT4RJUxcTmWrvE75VlnpEpfzHY5SN?=
 =?us-ascii?Q?6+okuAAGss4NqBF57n1yGHdepYu5ubrK5G7HgxpBm2No2pcXKo3J0tPJKHLf?=
 =?us-ascii?Q?DW1N84RA55c33hhBpmS0UeM8qr8S9t4PXewA+hG7a0dpP4/Ve3QumVUFLFlZ?=
 =?us-ascii?Q?SuJvc7zjtJtS/pyLTuNNJYyngfQ/WyZtS2+x0G1X+BPibqQlFDKYQ0tDmeg5?=
 =?us-ascii?Q?XsGDLdb3qdMhGtQZmA7mdW0+6nHVxvWrVuw8hZ3YOiPynwydHDnfxYx7Vhaz?=
 =?us-ascii?Q?ol8Nd3yZnrjsM96+qW1vu8ilwh5KaB7/xuqq0I2HWCjQXBMdcr0n/vWOHfW3?=
 =?us-ascii?Q?JaEM+OYfIUMARw+M/4UJOKtsclr6znqfJjFmfSAj2ZC+cO7X355UYVasR/gq?=
 =?us-ascii?Q?vNfAkVc7JDtBqDg+ssJ0eefL9hTWKv5p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:02.4886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e739b5-ab04-4104-26e5-08dca7330992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097
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
index 32c0cc52861c..3d0446337751 100644
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

