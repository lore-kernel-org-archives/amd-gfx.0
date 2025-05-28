Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393ABC61CE7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACAF010E548;
	Wed, 28 May 2025 04:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5noZA+sI";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C9210E54B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxk1TbtuMhYV/nwNXxGkUWnLvPOPBwCNUGBPNRzuXozDF7dZTZhbxIlT7ob+npQ45EmL9cskmyZYv3ofEX5AO/mYGXJpQ60J7xrLtNl7qbQ4MGkuKVqbVJjEqRpOkZg4r9lNlituONK9f1Xt/P8FsJ2rzMyyMcI9n0f89SGemMKSkJxGhioAHtpYA0UEZmfHRJ9xNAk1Pq+w2GFGIpsX7NwZnlD0NoKyIq//kxpI5H0YjhYJf+zKobv4986691CC9dZeI6K4IAemAsCD2Dvq5ZeYxP2ClRPVpz6I8zBvIMsL1dVQrKcdW3s7kFYAV+9h5pfhhIbGMXz7cbaZYv059A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuK+vebQqAjliYeuF+anP6psajusU8+S8+h1CABjC18=;
 b=T5gFZ+hHtrwVy94Imrfz89EgD4wraP1yoerkMqTA8mHNs9A9f5ytHVnC6R1r0D8YvCgqbjl2dwnh2erf0HV2KsRKgFNRgIuPdQnvf4oPXT58BwmrLKJehjAwtxUjFzriSsHO2J4HVb5s2wAH1ZKn5Nj5Qg23cl22nn7+5NXq+SdRxg+uiFNO7D9aTQcbMCrS93lkBKd4nlnTq07ixKtEIMPyK3eEZ/Lj8aQJ7lsgJFSgXHgHievo0X92/y5xRx4pNPq9llF6Bit8yayfCRkQGT3sdhoXJhsznMeYKQW8nR8nx1+mAZ1XvYoXK4eRtXrBPm38BGgCzJPJbxBZo9m0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuK+vebQqAjliYeuF+anP6psajusU8+S8+h1CABjC18=;
 b=5noZA+sIJEGOMeYWnjcM84Z0AEj4oz7Z+Sr/t5mR1E/hF7+mQH1/7WxVVSN5UG6rAjAyRWm3z6XOXhKsHpjh3fxd48XcBz5OpUmOYD6MyQwVHhn/UasUf8GB8w3BJx+DBjRwH5aIUq+bWWeN6i6g41rcfyyHame9KzSect39X1s=
Received: from DS7PR05CA0035.namprd05.prod.outlook.com (2603:10b6:8:2f::18) by
 PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.27; Wed, 28 May 2025 04:19:39 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::74) by DS7PR05CA0035.outlook.office365.com
 (2603:10b6:8:2f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Wed,
 28 May 2025 04:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/19] drm/amdgpu/gfx11: re-emit unprocessed state on kcq reset
Date: Wed, 28 May 2025 00:19:13 -0400
Message-ID: <20250528041914.5844-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fbcddb-b882-41de-e5ea-08dd9d9edd20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5SkoiBvl5ELiB/vaKPkdmwI2eWIPMqzfdPb2HZEfFfADZcTWnj6CxW+i805Y?=
 =?us-ascii?Q?8j3bocToZaIoUOcVvsAuU4LC4DHy7dWQapJSmXmpPlUX/kmoJEwYJmWuSQ1K?=
 =?us-ascii?Q?20k6mip+BQ3RM0XmlnJ7sbGXwdbD4ik2Ca6uPL11Mwr/I4h+1oEi+N6m30XR?=
 =?us-ascii?Q?ueL1UFmEU5brQaIi4Ex/ZzICKKQs+05hxeY0b20qqvMIGhfwXjeIKw1srHIl?=
 =?us-ascii?Q?R+t1b653j6bJFww1qh0hPRyaZjZ0jeDUE9UKRIxVZ9LmhpQBsq+OgFev77IH?=
 =?us-ascii?Q?6aTllia5RcKk6QVvf5RyOGKqP4XRH4FKGSMNV5x99+wz9FxNpIs1io6XYNlS?=
 =?us-ascii?Q?xZsqrxIEd//LyFqiKuL84qcm+Kw8YpU4kltaI6mZoYCrVkQ7Yv2xzTJDtxMb?=
 =?us-ascii?Q?DjRr+ekFx21TCfL7SinIMW79uF0Q5wAzg8fjYOCzHQsKEJERHgVdrn/fhd7p?=
 =?us-ascii?Q?DYflWXR1x3nGZKTQ0Vz52POi5Q4QM/L1jVeATwDlpm1ys0plSJzrm4xySfU3?=
 =?us-ascii?Q?I2Sz5IxX/4aUqofk1YsfOjmhf9BvyqnTAq+q2KagdPQAgvU1ZVEUw07rSpAB?=
 =?us-ascii?Q?vJ6Ie4X69qiQFlfap6dKbEt2u9dbnZKCfNWRkDyaldQypbzXAzWkGS3pNp8d?=
 =?us-ascii?Q?GaNau39wr0kQOBCepb3Zi1GLctFCJJLRT3Meymam8W+7xoqRmUcjKVur95b7?=
 =?us-ascii?Q?3FWTphGFi9iIcgLuRVEESIGWJikAYchzRRNocX95iv4r9BbA/HJ18lVrNlVL?=
 =?us-ascii?Q?1biatGzrP4/uCDxi8yl+ONhAvZWGWwEv8KiGHVMP8A8yLFrUHR181AcYSWsp?=
 =?us-ascii?Q?1Txq7jtDU7UcQU8GbYmpDRInxRx/5RFGVZ0vF9KgEjRhMIm5UFtVnSnTYKYW?=
 =?us-ascii?Q?y6G2X9cBSmkp5wCroLM5KLzKQKdqrVvyqFTKMr7cpKVOoxRmwcbjfJKYgfa9?=
 =?us-ascii?Q?Zx5MwaSvtCvmGvZv624/BeeDZOWsQNZ3WVLQhtfTsaul9CF0mpoosF1mEAuj?=
 =?us-ascii?Q?K30UrBHyvGaol4NCZKzoVNFqzvz6PhCubPJjDhex58Le+lVgEOwkNXEr9Trc?=
 =?us-ascii?Q?wiyF5E8AhdIp3H9GLKuCl2XufD/s7sED2Xp7YJJGPtLAFJh+MCfaXN87Tnif?=
 =?us-ascii?Q?CgMWkLwjZeDIJtMUkaOp3pGdkw/0OOQDjiJClMrl0DwCn31++yRTl6O2EMSv?=
 =?us-ascii?Q?Vjx2GbVvpfTj5YYRmC7PrQGyZDoC16eU5M6CdGTtL/QQAoT/fXrfk4Vs6lsf?=
 =?us-ascii?Q?x1m4PsQARyLV9ZX/XDfapGqV4RbWcvaChQOndGQdoVvHgZ8xTGxCfjIjCM3p?=
 =?us-ascii?Q?CRa2bnniyzxx3ZqcfvPglgdTE1VRwySp5Ss1pYKh35wIrgHVQXLWsmyhfYqD?=
 =?us-ascii?Q?1Zw34GioJOGLOl/AK8s6cHK9XdmmeNn3T93jkDKxzIUhMVMrII2wx1s9ffWd?=
 =?us-ascii?Q?xqOyswNq792naOe07uvD0qp5UjW6xDwoYdphkSpdkaZk/ynpAtCSIAGZr8LN?=
 =?us-ascii?Q?XHHHc2JnoWOjY5vo8KuTps1ls4rAkG39jDdv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:39.5991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fbcddb-b882-41de-e5ea-08dd9d9edd20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 28 ++++++++++----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b801cb0fa2102..3e7331b7f5628 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6287,21 +6287,6 @@ static void gfx_v11_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v11_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, regSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v11_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -6844,6 +6829,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		dev_err(adev->dev, "failed to remap kgq\n");
 		return r;
 	}
+
 	if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy))
 		return -ENOMEM;
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
@@ -6988,6 +6974,7 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
+	unsigned int i;
 	int r = 0;
 
 	if (amdgpu_sriov_vf(adev))
@@ -7012,7 +6999,15 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v11_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -7289,7 +7284,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.49.0

