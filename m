Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1ACC3DA61
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 20:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B03710EB10;
	Thu, 18 Jul 2024 20:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tzNr9Dd5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5951910EB10
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 20:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efLILtyUYJ9xrw2IBqe5IKSgLhk57lKoCdIxLjhtGvuGvI/3LuYf8p/zbHTg/FutiLxS8Q98JYvoHmM+FwvG2bQH3pEkDL/tA4qJ6Boxn6CEQwbKXt+M0jldeRR8Y8Ltfbm47z8CrPqjxRAgyGloZ8NA8yFB0PYE2JEJoYaGFvlj5xp+IwKKLKZ/dmz3OcfZSSbnD3TxfHw8R+FQpg0/V8gCIWzcZk6joQ2j1jHfT/UgHZp39Aw9cY4VxWWKoPJ1PkIYfejH2sOPWzyNv+K/u6B4dwFBZ4YLyPS0yUEIfex3SkM3vSlXHdwRODO4LEgeUoQh44yteI1bZnvsMXllFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJPbRKiidqh5Ebxc5CuU3mTupL0xOJoWbJ/H6cpDtmA=;
 b=MWjikNQ//+GPJSkWhEa5DD7bRl1RTM792UtAlVfLVed0ppBl/ypmBOi7rhf7JgIkLPxunOXBKWeSQAxCRka1X8xAlFuA/38D9VBfFAk6i5o8zkREG3a8Y2CNmRszh/lTkF54c+h3Un/sEPAswrOXqzKJwrGaOlDllZtNWXAz8xoeF04kUwBSyv5U6D218ruxPKHuwPVm4Y3A0TRxQuEeu1mzGQ8YAN5O7p3v2hUZo0P4o2iIAeByNHbh9GGq4DIL8LNRTgjkgbp9XdRM7+yKKleZZSd+1Q96IIei9ASuvj237OWCQf4D3Ytr0tC8qj5QRsDbltN9+Bg9eXD5+LMJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJPbRKiidqh5Ebxc5CuU3mTupL0xOJoWbJ/H6cpDtmA=;
 b=tzNr9Dd5D5osVr8seUg7d/g9Xl7W4jvK8ZTfO8IGFmzxy4/xjxLf1EIkSx0cKD9jhsEAgYPPo+kDK5HZxqH9DlsXFrRdTT7Lln+Cf1AwWA+kgurudUsYPJyMKyk18HA0afKNWlvezGP9o1HSyXqEwtCqHw+nC8K+nksqajJ/39M=
Received: from DS7PR03CA0309.namprd03.prod.outlook.com (2603:10b6:8:2b::7) by
 MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 18 Jul
 2024 20:39:36 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::bc) by DS7PR03CA0309.outlook.office365.com
 (2603:10b6:8:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 18 Jul 2024 20:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 20:39:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 15:39:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/gfx9: add ring reset callback for gfx
Date: Thu, 18 Jul 2024 16:39:19 -0400
Message-ID: <20240718203921.50563-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 381a0c83-3e9c-49da-e8e0-08dca769bd2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7WG6srksbqmOgZ3vy7Bi+kMiYXoSul7RPll5nX4smwdJdGYnpfXTZF2Co3WZ?=
 =?us-ascii?Q?VipoyVcZIZM9PDx8iY9F55pVpqsCKYlzItQsHVPEVd7mwBHoUOqbCNluePlL?=
 =?us-ascii?Q?zcWA3nLaEsyGNXnH4n1jeRtHs9tQffp6IQdmR0H2Y+x1UlCUoBq0+cZ46Iqi?=
 =?us-ascii?Q?/pzj8EoKV5MekWSo9l9fpZwbVrnxWayh0dfKWNLJlnOYybqT2QGSBASEU3Fj?=
 =?us-ascii?Q?YDDaAnY2rADj3rzKA/aAnhGKLsNOUg417ctO+M0nmRtNxoqNoteEngCk6PNB?=
 =?us-ascii?Q?0O6BNNSsDGVgCrKkC+LkQ2LJ1QcoODbIYuYBvOf95fbIO5jzUwRkt1UAgR7Z?=
 =?us-ascii?Q?Cva+Hffoqo+h/00uIY6W9/FDUi/BdWS7YiG5FSQa7W0OHcLPf1S/G6B3MuLw?=
 =?us-ascii?Q?rTdjsRNIimk1NE1P1R24IW26ZQRTHWospTleQmUO9aEvqw4o+ZzlCEASki9T?=
 =?us-ascii?Q?05hMGa4kb4zI6Waxd0ektH57l7nbY9u3jJVx33C2E58o+rmrA2JAqVA2qNDN?=
 =?us-ascii?Q?xFdd0LQXRm/IYtrn9I4Fb69cNsL3p0PzsCAedDojDXCZoV1siVdTd3pSBYf/?=
 =?us-ascii?Q?1cK3OQivL2G8uvaWDQzwmVK99x9jvKy0q1qlvB8615KvWcnCpFVQ2gKj2pzu?=
 =?us-ascii?Q?aOj9npbzb5+IJnkMpwGlQbnD47IGUSQIeZ7LDeXmFLTZLciSTQE1H9M2CwXf?=
 =?us-ascii?Q?rRqdhWu5BEKttCKYLJ8ZkdH6coql5097p61zhzjgLkAYiyoXq+KhdjNCkfMR?=
 =?us-ascii?Q?PVUnVJAO68MTHdm4StNW4g6MP1pfrZu47kBI21ZgvUZfG1fhaxq3ZDDkaPmX?=
 =?us-ascii?Q?2TdUs84QsCdsE2nus+i4T/R66qM0bzWxkcIyIReagRNLRr3OZ6qChY29wxqv?=
 =?us-ascii?Q?3CQwRviJUbSofEn6gvnVMogieRpgPVaU2qoq9bxoaY1aUCHp37rhQF4hcsOm?=
 =?us-ascii?Q?ucGc63ylMtJalLQt56fLM9LnPIQmBjC12Igy/xG1G8eKCq8mEv0DOMEmfJuu?=
 =?us-ascii?Q?k+8JEHSgrrzFDydDi2ibR1/2N4N34UCW2/W7Xs9jj8dh3xj1i1/Ept6DriSo?=
 =?us-ascii?Q?C/hZsXkkZVX34uwI/5GCTRTYD896TfZwVV6D6s+Ii1Cu8s12LvZRaQo3YpCK?=
 =?us-ascii?Q?MPrCP4d1UxQdLHg1iH8wqQSiz6pqKb9yz3lzvp+F+IfJTzulkSuULJmoq++P?=
 =?us-ascii?Q?1bb9pjqGnlHpJDDilnedyOrXfGq0nULy1MBfYI7cUlVcnXp+lmtMd4LvLFnh?=
 =?us-ascii?Q?DWR3u9l8f4illndQhqeoGvrTNKXrLYMMSaNu6ELmbnPJvWYh9rMvmVXskQXM?=
 =?us-ascii?Q?adMVOXejTy2aiSWiIjNltL0ZAfIHc/0M3xWN/lHCsoWst7nHVVLUsjSWl9Ci?=
 =?us-ascii?Q?c+g69MtfUgLw20fOLNdc1qo8bDmIC5EdZ+bgG6SbE+VeFw+mBgFltVS+4RI4?=
 =?us-ascii?Q?iecSF4nTntE9G3uoXr8Y/LWTJYgq0XGn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 20:39:36.5331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 381a0c83-3e9c-49da-e8e0-08dca769bd2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198
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

Add ring reset callback for gfx.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ae23a7848237..5c4b0c8669b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7137,6 +7137,52 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	}
 }
 
+
+static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+	u32 tmp;
+	int r;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, 5)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+	gfx_v9_0_ring_emit_wreg(kiq_ring,
+				 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), tmp);
+	amdgpu_ring_commit(kiq_ring);
+
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r)
+		return r;
+
+	if (amdgpu_ring_alloc(ring, 7 + 7 + 5))
+		return -ENOMEM;
+	gfx_v9_0_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+				 ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
+	gfx_v9_0_ring_emit_reg_wait(ring,
+				    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffff);
+	gfx_v9_0_ring_emit_wreg(ring,
+				SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0);
+
+	return amdgpu_ring_test_ring(ring);
+}
+
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 			      unsigned int vmid)
 {
@@ -7372,6 +7418,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
+	.reset = gfx_v9_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
-- 
2.45.2

