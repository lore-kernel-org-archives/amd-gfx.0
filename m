Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7728C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BAF110E839;
	Thu,  5 Jun 2025 01:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i3WVzojO";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6ABC10E7C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgAntj6C8/6gMdTas3ZkjVbAktpIAEN/coIGAKabG8kiuE9L7h7EquN2PNXK8LJmbd/iQjTc1WII6kQ8KFVPUUY44zBp/8SaZx5jkDMxa7TWGAS3UjvpNhWJvnUONlEKWjZ3oYXMV2IuqVvqlTa0cFm/L1JJRJmV2x/C5AamMWaHVzeaUJq/tQRhiH3xlR2DWw9eSbxPpxRWL2Ez7qT2lk1cVutJWJqQHzSSGxfXGOcJUtDNwEsnAH6OVmr1AZYIINvWPvsTFYV6JyhYkUuMeBcT5G/MKfsd4jqRpeu6Vq/ycGh0OwVRDwU+2BsTlUx8jjuUMYbq/eSrcCWO7Yi6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnMzzMwwAC4eriUtOfxS1fRgUIDBXUQ+9Z1KOtck528=;
 b=hmncIH7bFluGw22+qm11Ym3QC1oJ4NZx+0lqofXuzeL4Q7xoQ/5njEjcaRfLdQzMjcKjYyWiz9kJD6QzDa7DZTp8ccreqAoiDA8VCbFo5e0pfDpTYmb01GFYhEKBxhasgtBNSDj6Da218ERIz4L1KoTxFcW2KQya1H1Os7dK/tiYsLfiCG1uEf7vcv5ah/jtOVWxHHxKI/wPbQkjO4D4AbfoxDTa0ix77aTKoSWVOzF/NylfPeoFQEYQl/N1I258kAelWF02eH04HPRxtB7aD+tB/9QXMUHTm1gE/oWHslMOWmrtXup0O5jKnlWLNW87SJVxrigqnqr5yfHV14g4pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnMzzMwwAC4eriUtOfxS1fRgUIDBXUQ+9Z1KOtck528=;
 b=i3WVzojOTCDX7UwpaxeHZKC1SpT3Rz/jnx+FxBdYhvimk9mYV4Uvr3OlFhVzADT6WaOHGAumJAGihbNMangYIXWmNA8eV/MtabphSAeMaygmqnVXYjzXkr4UHZZL/vzVXmKU3cmgzwonR+8zkvDKlYu5eT0hLUYyBHEaNRlXuWM=
Received: from SJ0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:a03:39e::13)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:27 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::ca) by SJ0PR03CA0278.outlook.office365.com
 (2603:10b6:a03:39e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.27 via Frontend Transport; Thu,
 5 Jun 2025 01:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/31] drm/amdgpu/gfx10: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:40 -0400
Message-ID: <20250605014602.5915-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: efda6214-0841-4c3c-6c23-08dda3d2c921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7x9DSmS3KnGP63mBqUFA9+NUZZVD8k235CZBlnLloT7hl42oyv8s0qeJ269Y?=
 =?us-ascii?Q?p0t05inm7sLVjvhG+A/MT7tfj0ed/CqljmlSgWru+edn7LGk0McKKgmNuDmn?=
 =?us-ascii?Q?wfgtea0ByD2tMItkIgvazqnFrIokrzirU7BkvGGlXUlD5hnhC+MsDvpsjEHA?=
 =?us-ascii?Q?R/Xk1exgXhW2XYgfYr17I/0+3TX8FFfyCa4+DnTnf4ooIpvObUXC64cwG1Ay?=
 =?us-ascii?Q?QuxJMVoeCRcLxdpO0gohI95NlJte1n193o8boPupuOXslmuDWoZKYzbUP16O?=
 =?us-ascii?Q?0NaFZS9UB5xflaPNNsdfrFVnlq5S9i7qgX18IaqKBgwYostlk0Co8KvwTv4k?=
 =?us-ascii?Q?94/w1q/ltD9zw7cnR5nwBrvsU5lQpyfnpx/TVGnu97fMouOVxL3RpzXpR4pm?=
 =?us-ascii?Q?6gvth6UVokRlq/HKMYYTivhbbhgtAtcFzsch+mAe7PW/zG4V+R9VVCx0phb9?=
 =?us-ascii?Q?+8FdVVWDEJS8F8SkKqqcfG4vK0NCYUvZDPlY5Goj3cFf6OOMGo5bFK3Bc/5N?=
 =?us-ascii?Q?z0tn0viS57IVXydGKuz7RZeXhSiuEGNW887PiOvFKnZTMAj3U8Kjc8sEXVib?=
 =?us-ascii?Q?mSwL6lKxj5OC843BS7nHvBGGp6KwdW18buRv2mYRpiAGkLA02ssy9FhPLXHY?=
 =?us-ascii?Q?IRUAo+DMWownnndHL1voWzZa4rFVmMDMmKdjNRzBH0jGx+QdwYPk0hOIaS1Q?=
 =?us-ascii?Q?HWmllj4RvVIAlrEfLpchUPl6QGDAri+gDKzIcDpOowJ3zexYAan4WwWMSKS5?=
 =?us-ascii?Q?b/eZqWhZrqOPmjYM1hq7PiHN+c7LS2wI/EO/gG7jfrSz5GyZvIvxOvTj3CL4?=
 =?us-ascii?Q?Fyvxwaxk0Pj46T5bnOpcRbAE3ZQA0/KZlZvXrYPVyb3cjSF+l+IGDE2YQ92/?=
 =?us-ascii?Q?bIP6vUlqW3Ne1CTqYLFlriNsVPCRigV1rBm5LQoUKw2wGfineZSNFgGaqenh?=
 =?us-ascii?Q?26/9OlM4XPES8JRkPHajA0bS6+4MWVo8R0Y+OIcHF4uv8OVOB5LI2gUl4Wgc?=
 =?us-ascii?Q?6qEy0wLUdJ9uTFpPXWswPd+AowHg6lENYMbVjLuNhdJQEqR7KxMprtBHBA+H?=
 =?us-ascii?Q?jhA5C0vt9NwbGU4NBjjr6dEkyLIiIfNtlqJSZ8JjDdxz7bPBMcHrqL1ZT0XY?=
 =?us-ascii?Q?UINmxv6sMmi5rn+bbj7rVFyz0gc9i6LMuTaTjmXLReMqiiLzJcy3Rsce6qkJ?=
 =?us-ascii?Q?dbBN3/QeNVn1+gTKKoCmPZtoLARYVgWYoJhJ74M5rEJVPJCRzNm7+zYYH9X7?=
 =?us-ascii?Q?X61dKJQQPINL82fUgxwxj5Tem5QFhoGRmnlj6Fl2JW4nE2K6MUtNktmzJ9RG?=
 =?us-ascii?Q?JU95EEDOOeZaTqByFkgfc+nB4QLSY3twD++om4mVfQKcVOLZULFCe2FJYjjv?=
 =?us-ascii?Q?4qpYy52sm/3z37n/EUuVDubkntw95YjvVvlQnMd8dcCtHjHNRXboUc4f8HB/?=
 =?us-ascii?Q?r5F675nKD22sMaJZCF34Y0YeAaA4ZT/eCkJPMqFHROIxfF2TuFXKvSxtB5AE?=
 =?us-ascii?Q?SnTDQfY1+g4fUTvLzbvE/YqJz4VBiN1Po//l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:26.8596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efda6214-0841-4c3c-6c23-08dda3d2c921
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 31 +++++---------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 75ea071744eb5..18ca21d719d2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9046,21 +9046,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -9562,10 +9547,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 				     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9575,7 +9558,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9603,9 +9586,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9641,13 +9623,12 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
-	return amdgpu_ring_test_ring(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -9882,7 +9863,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9923,7 +9903,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.49.0

