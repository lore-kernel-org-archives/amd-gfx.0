Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7204CD98E4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 12:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4377410E9DE;
	Wed, 17 Jun 2026 12:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uhaQ42P5";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0EF10E9F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaPP7BsIcnvAKHKpAU4BvhNX58YV1o+aMBxDqZMKvzDgyi75+GeMs+7OeoH+ghRGnRBb3yD23ogLquQkrOfbh/wS/pepxQszq3XP9rH+WMzpu751WAQoC6nktEQyNvZgyiMkaquTGQWZpEHOLHdaIKT8D8g4Gk5FMbgtWh2n49Z2AOjgNjeNh4JCWqRBmrHLm87lFiLlGHCl9Uy9R9OwuFBmucLhxJ7sznWJpgiZD1gQ16KkrFYzp0m5PXqk4Ev2d2BY92alb06Fe/MDQWeqkiBsi9jEoMlbeyvxwEkzHF3H1b57rdazxPEr3/XF+KOJV/SPzYPXIA+ZBRH5d04J2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARUOH69a3Uc2qgP17xyS/80US0j6gb1vb5ysnabiJZo=;
 b=s7b84atib7MJpJcjcGswx7irqlqS5t0KbCO8MNotFCaffsgeQMpSRMW9qhtKbHXTq1nbfxYer8f2sJO9g6vPxL4+ovjuJYAK78LbbdnVN00C4y3+JK6xNA1J8sN0R71a5heeLJUUxL2VV9NmGUF4slDpzkvr9DiuytlvJnGTJRMKdAagHofEH41YMfPOOzyrABxYcUy8ygoe1Sw3sRb+j+0oT/ljyAVkIzYhhcSABjHpA+LdGPscTbctvg5vx7X/PizZtkWre/L9wDmyNjULMu20Nguj7pdRZ72zaT1PJtIwvNLHd/nTGw390n4sxU+4w0pFX6IJJYbVJDzYDE4IPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARUOH69a3Uc2qgP17xyS/80US0j6gb1vb5ysnabiJZo=;
 b=uhaQ42P5eX8I3nfAt/Ig0BgaJiESE21g2xYhIRdaySs4zphobi6EXPtiSZ+TLUSjycIA803b4O5TM3vwhFhBGnI5pI7ctypYjVLmsHEMG71YglFQGE1Vgrp3C3teyHHedq+IHwAZn1lbhdFpP64aXDX4Q7SEEahg9gDZKb3hOtI=
Received: from BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 12:51:48 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::e) by BY3PR03CA0025.outlook.office365.com
 (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 12:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 12:51:48 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 07:51:46 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: read back CE/DE preemption state via a
 per-ring CSA pointer
Date: Wed, 17 Jun 2026 20:51:20 +0800
Message-ID: <20260617125121.1838486-3-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617125121.1838486-1-xiang.liu@amd.com>
References: <20260617125121.1838486-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 74953236-ea1f-4cd8-3dc1-08decc6f31e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 7rBqR/zdsVUPOHT2AmyK4RZTzkbSpgNnwyrK+PH2hlXnHS/Xvut7p8pr+JXfiXZFjaPkszNxTzWbN1QLh5yY93fwS5Un40rkszMiQaMuvy8KjagfsDQutbVAxdQAXyc2LB57lkoxm5Xl7UXMmGqWsIP8WMgn5ilOBd2ONpqCotPqvY50F1RLDq7MT/KYwmnC2krySYnUDavxyOJ103lZ+yub8hDQ4XPp0Bwp5n1j9yih4ZJ8TqwMF584seZHS8OQaGtP9GBLGgGsOwH9GE3yfODq+gibRkobQlVENnbcBTe2bbNOZkBvnTVT7thW90WCKilESw3D3WF602t0EaRYAEDwbpkw/oMoIsVSzRc1ygD+WT9QpF0UY7nk93tLCbNEYenhkG3Ig0v9wJmDfALuUJAeq6KIhonw/SVzxItnXTmdzh/6Tk8bTZS4fvgKlYrdTa4FAKjCFAwz9adZvTZxgkoNy+nh4FZG6fRre5bk6WmxHgwXIroEkTqY8d8J7BzP2kLsAoF1KKK1108vJVBFj3FfhsY/pLRCa11tCPtcTd096eTqZsmiviFPADQ6Ox8Iu2492QjYpaLSqfMleXd5SW0kXBiFaEpR37WzwmVp2CbH9u2Qa5p9LLveGBIumzrnlOPJBSioSS4/BrfK5uWrMmn5gMrjaQQvNCVAvzz6FBTJh7VRNEUx9/c6gzOK42ihrDqWSCSdxbypOit7aADWPxC1UXnOQTPNRcP8tXFmPME=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OZJhMPoeFbCQi6++8FmJdKggDk7UTXWE1TwuJNT+jMcFj2GTK2Oznt1kq+2m/xD3Xd3inOXqm7PluQhuU0avcYQ6jDQSf6eESSisxo+QVHJhiT37UUntMo7Ndta6dCXNsvpZtw0dlsnoSWFpchTzD3BAvfLn7jjdxIGRGx6DCfTenao2yBMZkmFN9Pe48E3Z3Uyiy37Zo8g6xaq7W8w7HcPf5bkkMD/g2wcn8eBGGTq4VdzWKFdRnh013lpN81xmukD8CtZvMqRdT6gdLUFCTCJt7NAKgfhr6vWR+81TWOs/v8RrlDdQf/+lsuaxAGCJKG5bAE3aesNZabRAHN3WMlO3ZR31X7fX3Np9YTr6gp3J27gbVLHmWQs+Ai2knyAFVhxENZve5aL1LfNOWC4d4llUvsvarDwMuODKw8KLq8QyeysRQo+2hTHKZtalu7Wg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 12:51:48.3116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74953236-ea1f-4cd8-3dc1-08decc6f31e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485
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

The MCBP preemption resume path reads back the saved CE/DE payload from
the CSA kernel mapping. The gfx9/10/11 emit and patch helpers hard-coded
adev->virt.csa_cpu_addr, which only works while there is a single
device-global CSA shared by all processes.

Introduce a per-ring csa_cpu_addr that records which CSA kernel mapping
the state must be read back from for the jobs currently emitted on that
ring, and set it in amdgpu_ib_schedule() from the job's VM
(vm->csa_cpu_addr) with a fallback to the global mapping. For the gfx9
software-ring mux, carry the value in the saved chunk so the deferred
resubmission reads back the correct CSA. Convert the gfx9/10/11 helpers
to use ring->csa_cpu_addr.

vm->csa_cpu_addr is always NULL for now, so every lookup still resolves
to adev->virt.csa_cpu_addr and there is no functional change. This only
prepares the readback path for per-process CSA buffers.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c       |  5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 11 ++++-------
 8 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 3099379af0b29..bec2fe6b35968 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -150,6 +150,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	/* ring tests don't use a job */
 	if (job) {
 		vm = job->vm;
+		ring->csa_cpu_addr = (vm && vm->csa_cpu_addr) ?
+			vm->csa_cpu_addr : adev->virt.csa_cpu_addr;
 		fence_ctx = job->base.s_fence ?
 			job->base.s_fence->finished.context : 0;
 		shadow_va = job->shadow_va;
@@ -166,6 +168,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		job->hw_vm_fence->context = fence_ctx;
 	} else {
 		vm = NULL;
+		ring->csa_cpu_addr = adev->virt.csa_cpu_addr;
 		fence_ctx = 0;
 		shadow_va = 0;
 		csa_va = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 8f28b3bd70106..6d675a08df746 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -424,6 +424,12 @@ struct amdgpu_ring {
 
 	bool            is_sw_ring;
 	unsigned int    entry_index;
+
+	/* CPU mapping of the CSA whose CE/DE preemption state must be read
+	 * back for jobs currently emitted on this ring. Updated per job.
+	 */
+	void		*csa_cpu_addr;
+
 	/* store the cached rptr to restore after reset */
 	uint64_t cached_rptr;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index 7e7d6c3865bcd..ba8c8ed778d33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -107,6 +107,7 @@ static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux)
 								    ktime_get());
 				if (chunk->sync_seq ==
 					le32_to_cpu(*(e->ring->fence_drv.cpu_addr + 2))) {
+					e->ring->csa_cpu_addr = chunk->csa_cpu_addr;
 					if (chunk->cntl_offset <= e->ring->buf_mask)
 						amdgpu_ring_patch_cntl(e->ring,
 								       chunk->cntl_offset);
@@ -456,6 +457,7 @@ void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *r
 	chunk->cntl_offset = ring->buf_mask + 1;
 	chunk->de_offset = ring->buf_mask + 1;
 	chunk->ce_offset = ring->buf_mask + 1;
+	chunk->csa_cpu_addr = ring->csa_cpu_addr;
 	list_add_tail(&chunk->entry, &e->list);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
index d3186b570b82e..e41e49ad7ddc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
@@ -99,6 +99,7 @@ struct amdgpu_mux_chunk {
 	u64                     cntl_offset;
 	u64                     de_offset;
 	u64                     ce_offset;
+	void			*csa_cpu_addr;
 };
 
 int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index a1698fb41c4af..5c85c38588374 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -361,6 +361,12 @@ struct amdgpu_vm {
 	bool			evicting;
 	unsigned int		saved_flags;
 
+	/* Kernel CPU mapping of this VM's private Context Save Area, used
+	 * by the MCBP preemption resume path to read back this VM's saved
+	 * CE/DE state. NULL when the VM has no private CSA.
+	 */
+	void			*csa_cpu_addr;
+
 	/* Memory statistics for this vm, protected by stats_lock */
 	spinlock_t		stats_lock;
 	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 07659f039f804..a8a9d54649eb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9011,7 +9011,6 @@ static int gfx_v10_0_ring_preempt_ib(struct amdgpu_ring *ring)
 
 static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
 {
-	struct amdgpu_device *adev = ring->adev;
 	struct v10_ce_ib_state ce_payload = {0};
 	uint64_t offset, ce_payload_gpu_addr;
 	void *ce_payload_cpu_addr;
@@ -9021,7 +9020,7 @@ static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
 
 	offset = offsetof(struct v10_gfx_meta_data, ce_payload);
 	ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
-	ce_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
+	ce_payload_cpu_addr = ring->csa_cpu_addr + offset;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
@@ -9049,7 +9048,7 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 
 	offset = offsetof(struct v10_gfx_meta_data, de_payload);
 	de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
-	de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
+	de_payload_cpu_addr = ring->csa_cpu_addr + offset;
 
 	gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
 			 AMDGPU_CSA_SIZE - adev->gds.gds_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1941bfbcbfbff..68030391aa17c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6252,7 +6252,7 @@ static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 
 	offset = offsetof(struct v10_gfx_meta_data, de_payload);
 	de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
-	de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
+	de_payload_cpu_addr = ring->csa_cpu_addr + offset;
 
 	gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
 			 AMDGPU_CSA_SIZE - adev->gds.gds_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2152830052ef9..f8e9be9383140 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5556,14 +5556,13 @@ static void gfx_v9_0_ring_patch_cntl(struct amdgpu_ring *ring,
 static void gfx_v9_0_ring_patch_ce_meta(struct amdgpu_ring *ring,
 					unsigned offset)
 {
-	struct amdgpu_device *adev = ring->adev;
 	void *ce_payload_cpu_addr;
 	uint64_t payload_offset, payload_size;
 
 	payload_size = sizeof(struct v9_ce_ib_state);
 
 	payload_offset = offsetof(struct v9_gfx_meta_data, ce_payload);
-	ce_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
+	ce_payload_cpu_addr = ring->csa_cpu_addr + payload_offset;
 
 	if (offset + (payload_size >> 2) <= ring->buf_mask + 1) {
 		memcpy((void *)&ring->ring[offset], ce_payload_cpu_addr, payload_size);
@@ -5580,14 +5579,13 @@ static void gfx_v9_0_ring_patch_ce_meta(struct amdgpu_ring *ring,
 static void gfx_v9_0_ring_patch_de_meta(struct amdgpu_ring *ring,
 					unsigned offset)
 {
-	struct amdgpu_device *adev = ring->adev;
 	void *de_payload_cpu_addr;
 	uint64_t payload_offset, payload_size;
 
 	payload_size = sizeof(struct v9_de_ib_state);
 
 	payload_offset = offsetof(struct v9_gfx_meta_data, de_payload);
-	de_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
+	de_payload_cpu_addr = ring->csa_cpu_addr + payload_offset;
 
 	((struct v9_de_ib_state *)de_payload_cpu_addr)->ib_completion_status =
 		IB_COMPLETION_STATUS_PREEMPTED;
@@ -5793,7 +5791,6 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring *ring)
 
 static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
 {
-	struct amdgpu_device *adev = ring->adev;
 	struct v9_ce_ib_state ce_payload = {0};
 	uint64_t offset, ce_payload_gpu_addr;
 	void *ce_payload_cpu_addr;
@@ -5803,7 +5800,7 @@ static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
 
 	offset = offsetof(struct v9_gfx_meta_data, ce_payload);
 	ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
-	ce_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
+	ce_payload_cpu_addr = ring->csa_cpu_addr + offset;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
@@ -5891,7 +5888,7 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume, bo
 
 	offset = offsetof(struct v9_gfx_meta_data, de_payload);
 	de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
-	de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
+	de_payload_cpu_addr = ring->csa_cpu_addr + offset;
 
 	gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
 			 AMDGPU_CSA_SIZE - adev->gds.gds_size,
-- 
2.34.1

