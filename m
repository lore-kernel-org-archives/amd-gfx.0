Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85393C4725D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 09:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1223910EBA1;
	Mon, 22 Jan 2024 09:09:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E3C10EB94
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 09:09:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVJU1CW2nI6h3Sj8Lt8Dtp0GRlqQueCp5MqGcg8GqwtdM3OF71JGwYR4HPOIq0wifZGIQYMJB1MDL57wsF9nod/aEcMFDwUIIOo0czll9oreg2crvu6gekWH/5/1VgRH4E08NIZGNSYPxjwhjM8hu57B0x2hydX2HkcmWSMSTb3lHoWXKMIH/p+KR0nSMGqfDtC+J1+92Qt2/m7nS0+qOE98pCJyzYWlXcgxXoIqDwlMFlzju8IVwghWCbgghE5Cv5JVd2q65zydoP+Z0UIS9m4pZo1R3G925RnD24M8O2ISdjTHnVGYkbNik/C4XF9vge7EpHjGNZdp7ADd/BKn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZWgNORLMDWyzz04uEytpVSJ4Ji4toj5xmweQswDnEY=;
 b=AtuB3HGTrclYRQudMDlMJQTfsdI2lc9Gd1oTGfmCeWzvs/AfhdKp5MC56DNRDKRzJ2yJJ0nS7eG+mfG/3CvgF+iJzdhkTIcmIiX7WweaFZPG8/qFCgb8UiEaiL5PKoOp9qlKbtgBoi85et1xFkywEjz9MXxrEvgzczNn/IsEfzhxgECAZvwa1QltWlSlCYkQlH2HfqSf8vC4YB/dykWKLe03Af7GNqY0mt9bpeHVS0rr3Xz2cDJnAlSiyPOTm/AK5pskcdsoxP8OdftHKmT+ycw42eAn821etLq65/lKrGIdUaODzgwno2c/tg0fdROyOVaHl543yYQmLgiB/4iUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZWgNORLMDWyzz04uEytpVSJ4Ji4toj5xmweQswDnEY=;
 b=tHe+ce/E/Pl16cS3ch7mD9ejMRe2v4RLrzuLuek75BczGdLDuWPC4M+oNd/vl99E0kiiahcgZlsi+/Lv5B6RFmdIZKRVVFOiErHPIfc1UpIAT+FGnbHVktyRhls+FqpWbXOu8nd7e++JjcJTfwOZ7/2dJJxPtmMg23kXN4XA24g=
Received: from SJ0PR03CA0273.namprd03.prod.outlook.com (2603:10b6:a03:39e::8)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.31; Mon, 22 Jan 2024 09:09:00 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::2f) by SJ0PR03CA0273.outlook.office365.com
 (2603:10b6:a03:39e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31 via Frontend
 Transport; Mon, 22 Jan 2024 09:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 09:08:59 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:08:56 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: reserve the BO before validating it
Date: Mon, 22 Jan 2024 17:08:43 +0800
Message-ID: <20240122090843.1540732-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 362b91d7-3ba9-4c62-5fe1-08dc1b29c4f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9jRB6P/lPTRm3vKtvLarDZWLndl0hWr0T6vNxCEQGyzohwk5CE8kY2lrbcQvOaQDAfKR8c2VeGKrP/jWoYH+QwIH8NYYmbLFkj3GhleFwcmg2tsWDcD6PzQZv4KJ6Hv40AGs88oNj7jhB82iQB8qC2wpUm6vjI0I+VfN/W5dxRB3U442q7TZG9ydHlmXZirRP/aAyCujrUaU1d9XD68/X7wFRiL0kbK5rhj6ScKjqBAqGeOKiw70nwETtfQN4R90vgCRy49tYPzg474twZkiWsRa5fZ98ixwIHgmpp408xjGBylC1EMovtg6I/wrW5BGlESNGguxFfh56lWL2Qckh9+53RbIi8JaYD9PUoUiHIxgJFFropdPu6IuFkZK5TnNDUPYAoAUM9MXODv9mDO3m5V9dqeeqF5iAhIcJ/sPGe+jg9CaVPRXkw5FUidrm2ZdLEjsNng7pZ6B/vqiXnmv/W1WSOv3AI0IjsLaE1mltWAcJSt0AzqbyHrRFZ0a7CdSfBy2KRa7PhdxVSofaBfUPiio/8KghlZbiQukC7aX2VT6HNbJcOPxf5h+xy0o6OJ+2Fkois74xFmwYPmymo/kPqdrEssLB+a3hBQw1Z9udZCgjSUlavMhMCUmkI2wKn94gv4OUYJgILRaN0v2CA3rsDFzIDnPIqfx68Vl60cCJRrQ6hq/Dq4LlZEMljYMQcW3wCQHqhqDdJrgthSwHk/n0tVZ0HtX1IhRHaJ26VXhS6ecn4MaBJf2ytJfUow9ZSqWDojremzpl/ZhfXEGZSXP84F7OJZ7MOXO4bxQo1MmGl1TWhcqpBwD19q9YZOJ5VL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230173577357003)(230922051799003)(230273577357003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(6666004)(478600001)(8936002)(6916009)(316002)(7696005)(54906003)(82740400003)(70586007)(70206006)(47076005)(8676002)(36860700001)(2616005)(336012)(426003)(1076003)(26005)(16526019)(83380400001)(41300700001)(2906002)(5660300002)(4326008)(40460700003)(86362001)(40480700001)(81166007)(356005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:08:59.0123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 362b91d7-3ba9-4c62-5fe1-08dc1b29c4f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Francis David <David.Francis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 410f08516e0f ("drm/amdkfd: Move dma unmapping after TLB flush")

v2:
Avoid unmapping attachment twice when ERESTARTSYS.

[   41.708711] WARNING: CPU: 0 PID: 1463 at drivers/gpu/drm/ttm/ttm_bo.c:846 ttm_bo_validate+0x146/0x1b0 [ttm]
[   41.708989] Call Trace:
[   41.708992]  <TASK>
[   41.708996]  ? show_regs+0x6c/0x80
[   41.709000]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
[   41.709008]  ? __warn+0x93/0x190
[   41.709014]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
[   41.709024]  ? report_bug+0x1f9/0x210
[   41.709035]  ? handle_bug+0x46/0x80
[   41.709041]  ? exc_invalid_op+0x1d/0x80
[   41.709048]  ? asm_exc_invalid_op+0x1f/0x30
[   41.709057]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
[   41.709185]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
[   41.709197]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
[   41.709337]  ? srso_alias_return_thunk+0x5/0x7f
[   41.709346]  kfd_mem_dmaunmap_attachment+0x9e/0x1e0 [amdgpu]
[   41.709467]  amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x56/0x80 [amdgpu]
[   41.709586]  kfd_ioctl_unmap_memory_from_gpu+0x1b7/0x300 [amdgpu]
[   41.709710]  kfd_ioctl+0x1ec/0x650 [amdgpu]
[   41.709822]  ? __pfx_kfd_ioctl_unmap_memory_from_gpu+0x10/0x10 [amdgpu]
[   41.709945]  ? srso_alias_return_thunk+0x5/0x7f
[   41.709949]  ? tomoyo_file_ioctl+0x20/0x30
[   41.709959]  __x64_sys_ioctl+0x9c/0xd0
[   41.709967]  do_syscall_64+0x3f/0x90
[   41.709973]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 28 +++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 ++-
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 584a0cea5572..41854417e487 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -311,7 +311,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
 					  struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
-void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
+int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
 int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 6f3a4cb2a9ef..7a050d46fa4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2088,21 +2088,43 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	return ret;
 }
 
-void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
+int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
 {
 	struct kfd_mem_attachment *entry;
 	struct amdgpu_vm *vm;
+	bool reserved = false;
+	int ret = 0;
 
 	vm = drm_priv_to_vm(drm_priv);
 
 	mutex_lock(&mem->lock);
 
 	list_for_each_entry(entry, &mem->attachments, list) {
-		if (entry->bo_va->base.vm == vm)
-			kfd_mem_dmaunmap_attachment(mem, entry);
+		if (entry->bo_va->base.vm != vm)
+			continue;
+		if (entry->type == KFD_MEM_ATT_SHARED ||
+		    entry->type == KFD_MEM_ATT_DMABUF)
+			continue;
+		if (!entry->bo_va->base.bo->tbo.ttm->sg)
+			continue;
+
+		if (!reserved) {
+			ret = amdgpu_bo_reserve(mem->bo, true);
+			if (ret)
+				goto out;
+			reserved = true;
+		}
+
+		kfd_mem_dmaunmap_attachment(mem, entry);
 	}
 
+	if (reserved)
+		amdgpu_bo_unreserve(mem->bo);
+
+out:
 	mutex_unlock(&mem->lock);
+
+	return ret;
 }
 
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ce4c52ec34d8..80e90fdef291 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1442,7 +1442,9 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
 
 		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
-		amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
+		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
+		if (err)
+			goto sync_memory_failed;
 	}
 
 	mutex_unlock(&p->mutex);
-- 
2.25.1

