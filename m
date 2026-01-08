Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC58D1D467
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1EE10E774;
	Thu,  8 Jan 2026 14:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PjEBjcZq";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011049.outbound.protection.outlook.com
 [40.93.194.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDCC10E780
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUb3NIhRZu63W9LzfX7RZAuIbC3IKviKBZMbLd/+IEanVwkn6X1AbHQFOJd87XbTkIZJSXzTk6krzg9YlEGdhleOnUwX41ND9j1tXLIu0KC1pAczOL3kcdcHv2fH9acfRer0MdpHTzXny1nLaC2TIai+xWCfievW6zjJdcIuOLzGbIsQ2/2XfMWY5Idt7UYuhTiMdHxS0tbgV383oRjgEpsQWtqwkwKunZ7m2058e/6Ph/nl5veZnGvAwqLTG0cd3Rp8JAR0WrmUmUaWLP7c4MR16Xg8zD80tsCVie6XIRH1ijdEs+/2pqCKlyrQLYsQKUM+a7rDY3fJ0FelwLe0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAohy/O/9iJANmpd8hUv6ZjagscF70VIGTBVqqkh9ek=;
 b=jR2JS2Y02aZWmy3ngedj8foO1Be09b9+EfDMlV+gLVMTrS5gXnQH8YF0Qvl9f1yYfMo2u+bsoE3XgEfNqqzRSqmPj+9nibifzwaJkmgGexJmhXMBdgvxT8xFXw9CcKz3usR/if2JepgQR2Qyh8qd0jUe57rQy6OsTFGBbMjyWcuNJ50uuam6WqTQHrW56EkyP//WO4jNHTcYsmoThm2wgLMDSN5+6jr5A9CLrE59R33YUnH60lBteNtcNj2cxjxnc2upbdpOtGP16ZU/24Gnl6y8zEgOWIYJdl8nDODNexPC6LpFDVSeYwMovgIIw9W0qa0rJbX+1inGXIgVBE4/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAohy/O/9iJANmpd8hUv6ZjagscF70VIGTBVqqkh9ek=;
 b=PjEBjcZqrXCj0/tIyp5XamVKs5POz23rliPIMlz2QNqQck4lFXPUJxib7RIpnME5HsgsQUPgAmklb9cOZ+dOnb8LQrGlSxJXRma62M5oxbm14S8TCslMAURTg7u0LOXyCDrBgWz+cJM7AFkM1GonB5H/VlDm0YZz7lp16d0BUmc=
Received: from BYAPR02CA0040.namprd02.prod.outlook.com (2603:10b6:a03:54::17)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:49:13 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:54:cafe::6e) by BYAPR02CA0040.outlook.office365.com
 (2603:10b6:a03:54::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:04 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 06:49:04 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 32/42] drm/amdgpu: change function signature for
 emit_pipeline_sync()
Date: Thu, 8 Jan 2026 09:48:33 -0500
Message-ID: <20260108144843.493816-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c81498-c17e-4e47-1826-08de4ec5171e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ScK69RT7qrZ6GjhRcACHRtu5/G2GsLDt+zz7321Y/abLGYC73IVKzWhu+R4p?=
 =?us-ascii?Q?5ge4cqjqQOP//PNZhaS57ifQ8S9WHTcBYBpMI5elTM+NMqHEFkduPueTjz1g?=
 =?us-ascii?Q?nfkDwmkfQ8q3MNUB0xUc7fyO+6Us5IN93CiT1YoFJf4VGG5qzffoVOdVv20f?=
 =?us-ascii?Q?Hz8xpqL9PAvW+HpAC/7bDb77vgwUpMCAn9v8cPK6ifjYEbFbCIc39W1CgHim?=
 =?us-ascii?Q?yxAfMeuoHeYPnDoCk/F3mbKBE/9bqvscJWBxY1BASTsXP1jkkAdS6v6Wqbnp?=
 =?us-ascii?Q?9wmNrLmYrWsnM2h0LtL4T79IPQwJ8WJv17LJqQd10wSqnm1KoSoiviViS6OU?=
 =?us-ascii?Q?F55HiQfUnc726CujkRKNm5/FocIq944RlBLhuHFawWAWdQX2Bnij9ZlAVmwp?=
 =?us-ascii?Q?UhPSlzvQktsE5IxrOXTklsyhszylTEbHJY4vvds3vWQjdMphy6VJg8ziXIkm?=
 =?us-ascii?Q?bRbYClM4CZnwbgujCL2mr+xf11PQXTIfY1fh0elq5w9Gtnn/o5FDqTUSywA/?=
 =?us-ascii?Q?gGWI745u6XZtVFozfeSIyYN6fy7iCQCF0EVm2wG1XszIE4wqcwa5rgU9ief8?=
 =?us-ascii?Q?x40+uQp9qw7W9nGGulo9Gr1ToEih0i0buQ+WeJihQwXTSgLFwQ7UyrnZkmNc?=
 =?us-ascii?Q?Cb+s8WJR2IAiTMAJR8I89EjNmfJrccAyIBxi55PRTmLwtkdVM5XbeZxmNiC5?=
 =?us-ascii?Q?95vAoI80+zmKxzl6oW3NjX69psFwCJy7+ZuNMkdq45yZd4rhwM/D0y8H/bIJ?=
 =?us-ascii?Q?GeTHUjEXQM/akTKarhiFxgW//NtQJ7AXJd57xFbl9URTw9XHiljPnA8bPoS0?=
 =?us-ascii?Q?QjeWRwIkgbjcbjF2ApoAdys4ip/Icq1E09W10DsvL6uKsZk6UwWvRzSv31rd?=
 =?us-ascii?Q?oKl8gksJp5ePBQ64/pKLYgAF3/KwY8/7YuiYg/BfJrib6pZ7BFYdWk/BBHDR?=
 =?us-ascii?Q?97H4HrjfLvXFeB6Lxjbxch9lDO/1+Ys6FZHPiVUkodD6xjDbID5eloWs92De?=
 =?us-ascii?Q?R5ajt7Ob78pvdlC7K1AXtXEfz+et2f4/v4b5uxTFNoDawrJOU+przu7w4Wq1?=
 =?us-ascii?Q?VMRpgmz3yfvTaD53XFgJ24jd5FQv79x7kdoGEVK07CEoZoALCDDMc+TQEEGS?=
 =?us-ascii?Q?AuCvHgZwyTs89T1vJXCzh0K+KFuQrTAIj99tnELnQsmgjg/CeQWH6GLF2jAi?=
 =?us-ascii?Q?fSGZuWA8iUOxa22CT67eJjsvOiksBe6fLkBbcCpXbcKPKHNPpQ4Rz4OF6ZYH?=
 =?us-ascii?Q?iAY6ZP+mT0YcgNTfBZUyZIWjKVvB//i4onPlt2qgJ6gJtWRdbt7HyQKCcA+k?=
 =?us-ascii?Q?hcHH9EXtIZdoJJO0hvnKHT7wvYgQ6hSlAB/j2aLTBYBOzMyibvz1uIve0hAT?=
 =?us-ascii?Q?EyyWxDwB/JxWX8lnhKDlc4zqFFu0XI436Kq6sPVwSqxApzA+sAykbfR9Xm8X?=
 =?us-ascii?Q?IyDofcR+wMsCTH8Qz7gVbMRdHU6QcrSUlO97Pn/QxqBM5/xNVvtVdOjc0GZU?=
 =?us-ascii?Q?JHcWTGQ8Lxy867wzky1yemsz0BFUSAdLfk8BcYb/+4c+T3q5fI5GoogTrmch?=
 =?us-ascii?Q?5nx2iNSdqwsbLO0rxP0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:13.5204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c81498-c17e-4e47-1826-08de4ec5171e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
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

Pass the seq as a parameter. No intended functional change.
This paves the way for future improvements to queue reset
handling by making the sync point explicit rather then implicit.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    | 5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 5 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 5 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 5 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 5 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 5 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 5 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 5 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 5 +++--
 drivers/gpu/drm/amd/amdgpu/si_dma.c      | 5 +++--
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    | 4 ++--
 25 files changed, 63 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ce095427611fb..da437c349aab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -252,7 +252,7 @@ struct amdgpu_ring_funcs {
 			uint32_t flags);
 	void (*emit_fence)(struct amdgpu_ring *ring, uint64_t addr,
 			   uint64_t seq, unsigned flags);
-	void (*emit_pipeline_sync)(struct amdgpu_ring *ring);
+	void (*emit_pipeline_sync)(struct amdgpu_ring *ring, u32 seq);
 	void (*emit_vm_flush)(struct amdgpu_ring *ring, unsigned vmid,
 			      uint64_t pd_addr);
 	void (*emit_hdp_flush)(struct amdgpu_ring *ring);
@@ -436,7 +436,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_get_wptr(r) (r)->funcs->get_wptr((r))
 #define amdgpu_ring_set_wptr(r) (r)->funcs->set_wptr((r))
 #define amdgpu_ring_emit_ib(r, job, ib, flags) ((r)->funcs->emit_ib((r), (job), (ib), (flags)))
-#define amdgpu_ring_emit_pipeline_sync(r) (r)->funcs->emit_pipeline_sync((r))
+#define amdgpu_ring_emit_pipeline_sync(r, s) (r)->funcs->emit_pipeline_sync((r), (s))
 #define amdgpu_ring_emit_vm_flush(r, vmid, addr) (r)->funcs->emit_vm_flush((r), (vmid), (addr))
 #define amdgpu_ring_emit_fence(r, addr, seq, flags) (r)->funcs->emit_fence((r), (addr), (seq), (flags))
 #define amdgpu_ring_emit_gds_switch(r, v, db, ds, wb, ws, ab, as) (r)->funcs->emit_gds_switch((r), (v), (db), (ds), (wb), (ws), (ab), (as))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0eccb31793ca7..c05a9f80053d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -820,7 +820,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 						   ring->cond_exe_gpu_addr);
 
 	if (need_pipe_sync)
-		amdgpu_ring_emit_pipeline_sync(ring);
+		amdgpu_ring_emit_pipeline_sync(ring, ring->fence_drv.sync_seq);
 
 	if (cleaner_shader_needed)
 		ring->funcs->emit_cleaner_shader(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 9fb1946be1ba2..54ee78c034cdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -564,9 +564,9 @@ static void vpe_ring_emit_fence(struct amdgpu_ring *ring, uint64_t addr,
 
 }
 
-static void vpe_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void vpe_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	vpe_ring_emit_pred_exec(ring, 0, 6);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index e2ca96f5a7cfb..21b3a815bf2a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -821,12 +821,13 @@ static void cik_sdma_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
  * cik_sdma_ring_emit_pipeline_sync - sync the pipeline
  *
  * @ring: amdgpu_ring pointer
+ * @seq: seq number to wait on
  *
  * Make sure all previous operations are completed (CIK).
  */
-static void cik_sdma_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void cik_sdma_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					     u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	/* wait for idle */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 496121bdc1de1..e0e125eef9ac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8736,10 +8736,10 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, 0);
 }
 
-static void gfx_v10_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void gfx_v10_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					      u32 seq)
 {
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	gfx_v10_0_wait_reg_mem(ring, usepfp, 1, 0, lower_32_bits(addr),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5ad2516a60240..cc9ac87c5be02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5966,10 +5966,10 @@ static void gfx_v11_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, 0);
 }
 
-static void gfx_v11_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void gfx_v11_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					      u32 seq)
 {
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	gfx_v11_0_wait_reg_mem(ring, usepfp, 1, 0, lower_32_bits(addr),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 5862b5f60a6ee..cbe175145286b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4483,10 +4483,10 @@ static void gfx_v12_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, 0);
 }
 
-static void gfx_v12_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void gfx_v12_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					      u32 seq)
 {
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	gfx_v12_0_wait_reg_mem(ring, usepfp, 1, 0, lower_32_bits(addr),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 7d02569cd4738..b7e1d7546267c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3381,10 +3381,10 @@ static void gfx_v12_1_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, 0);
 }
 
-static void gfx_v12_1_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void gfx_v12_1_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					      u32 seq)
 {
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	gfx_v12_1_wait_reg_mem(ring, usepfp, 1, 0, lower_32_bits(addr),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 2f8aa99f17480..fcc1e75146e90 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2287,10 +2287,10 @@ static int gfx_v6_0_cp_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void gfx_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					     u32 seq)
 {
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index fa235b981c2e9..4ffff8ad4dc83 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3096,14 +3096,15 @@ static int gfx_v7_0_cp_resume(struct amdgpu_device *adev)
  * gfx_v7_0_ring_emit_pipeline_sync - cik vm flush using the CP
  *
  * @ring: the ring to emit the commands to
+ * @seq: sequence number to wait for
  *
  * Sync the command pipeline with the PFP. E.g. wait for everything
  * to be completed.
  */
-static void gfx_v7_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void gfx_v7_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					     u32 seq)
 {
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 4736216cd0211..f88cfef175c0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6176,10 +6176,10 @@ static void gfx_v8_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
 
 }
 
-static void gfx_v8_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void gfx_v8_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					     u32 seq)
 {
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 36f0300a21bfa..07fe959abe0d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5606,7 +5606,8 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
 }
 
-static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					     u32 seq)
 {
 	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
 		gfx_v9_0_ring_emit_event_write(ring, VS_PARTIAL_FLUSH, 4);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d78b2c2ae13a3..fb731e877c99c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2904,10 +2904,10 @@ static void gfx_v9_4_3_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, 0);
 }
 
-static void gfx_v9_4_3_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void gfx_v9_4_3_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					       u32 seq)
 {
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	gfx_v9_4_3_wait_reg_mem(ring, usepfp, 1, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 46263d50cc9ef..42dca080e1dd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -756,12 +756,13 @@ static void sdma_v2_4_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
  * sdma_v2_4_ring_emit_pipeline_sync - sync the pipeline
  *
  * @ring: amdgpu_ring pointer
+ * @seq: seq number to wait on
  *
  * Make sure all previous operations are completed (CIK).
  */
-static void sdma_v2_4_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void sdma_v2_4_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					      u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	/* wait for idle */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index f9f05768072ad..b6e0d035c27eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1029,12 +1029,13 @@ static void sdma_v3_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
  * sdma_v3_0_ring_emit_pipeline_sync - sync the pipeline
  *
  * @ring: amdgpu_ring pointer
+ * @seq: seq number to wait on
  *
  * Make sure all previous operations are completed (CIK).
  */
-static void sdma_v3_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void sdma_v3_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					      u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	/* wait for idle */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 56d2832ccba2d..ae6b9f344e20d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1691,12 +1691,13 @@ static void sdma_v4_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
  * sdma_v4_0_ring_emit_pipeline_sync - sync the pipeline
  *
  * @ring: amdgpu_ring pointer
+ * @seq: seq number to wait on
  *
  * Make sure all previous operations are completed (CIK).
  */
-static void sdma_v4_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void sdma_v4_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					      u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	/* wait for idle */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index dd8d6a572710d..86b800e2b4329 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1287,12 +1287,13 @@ static void sdma_v4_4_2_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *
  * sdma_v4_4_2_ring_emit_pipeline_sync - sync the pipeline
  *
  * @ring: amdgpu_ring pointer
+ * @seq: seq number to wait on
  *
  * Make sure all previous operations are completed (CIK).
  */
-static void sdma_v4_4_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void sdma_v4_4_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+						u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	/* wait for idle */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 786f1776fa30d..c5dc727c7b448 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1259,12 +1259,13 @@ static void sdma_v5_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
  * sdma_v5_0_ring_emit_pipeline_sync - sync the pipeline
  *
  * @ring: amdgpu_ring pointer
+ * @seq: seq number to wait on
  *
  * Make sure all previous operations are completed (CIK).
  */
-static void sdma_v5_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void sdma_v5_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					      u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	/* wait for idle */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 49005b96aa3f2..3076734462d25 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1160,12 +1160,13 @@ static void sdma_v5_2_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
  * sdma_v5_2_ring_emit_pipeline_sync - sync the pipeline
  *
  * @ring: amdgpu_ring pointer
+ * @seq: seq number to wait on
  *
  * Make sure all previous operations are completed (CIK).
  */
-static void sdma_v5_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void sdma_v5_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					      u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	/* wait for idle */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 210ea6ba6212f..fbac29485d0c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1165,12 +1165,13 @@ static void sdma_v6_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
  * sdma_v6_0_ring_emit_pipeline_sync - sync the pipeline
  *
  * @ring: amdgpu_ring pointer
+ * @seq: seq number to wait on
  *
  * Make sure all previous operations are completed (CIK).
  */
-static void sdma_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void sdma_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					      u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	/* wait for idle */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 3b4417d19212e..bb9fae2c8dee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1185,12 +1185,13 @@ static void sdma_v7_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
  * sdma_v7_0_ring_emit_pipeline_sync - sync the pipeline
  *
  * @ring: amdgpu_ring pointer
+ * @seq: seq number to wait on
  *
  * Make sure all previous operations are completed (CIK).
  */
-static void sdma_v7_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void sdma_v7_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					      u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	/* wait for idle */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index d71a546bdde61..5efdb4dcbed97 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1182,12 +1182,13 @@ static void sdma_v7_1_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
  * sdma_v7_1_ring_emit_pipeline_sync - sync the pipeline
  *
  * @ring: amdgpu_ring pointer
+ * @seq: seq number to wait on
  *
  * Make sure all previous operations are completed (CIK).
  */
-static void sdma_v7_1_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void sdma_v7_1_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					      u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	/* wait for idle */
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index b67bd343f795f..3f5fe58c47165 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -428,12 +428,13 @@ static void si_dma_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
  * si_dma_ring_emit_pipeline_sync - sync the pipeline
  *
  * @ring: amdgpu_ring pointer
+ * @seq: seq number to wait on
  *
  * Make sure all previous operations are completed (CIK).
  */
-static void si_dma_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void si_dma_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					   u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	/* wait for idle */
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index ecd7ead7a60b1..ef9a822ec6701 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1089,9 +1089,9 @@ static void uvd_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, 0xC);
 }
 
-static void uvd_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void uvd_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+					     u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_DATA0, 0));
@@ -1118,9 +1118,9 @@ static void uvd_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 	}
 }
 
-static void uvd_v6_0_enc_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void uvd_v6_0_enc_ring_emit_pipeline_sync(struct amdgpu_ring *ring,
+						 u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	amdgpu_ring_write(ring, HEVC_ENC_CMD_WAIT_GE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 03d79e464f04f..4a6f16c8e9c1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -887,9 +887,9 @@ static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, VCE_CMD_END);
 }
 
-static void vce_v3_0_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void vce_v3_0_emit_pipeline_sync(struct amdgpu_ring *ring,
+					u32 seq)
 {
-	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	amdgpu_ring_write(ring, VCE_CMD_WAIT_GE);
-- 
2.52.0

