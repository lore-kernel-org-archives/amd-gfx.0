Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52298C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 09:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E657510F85D;
	Tue, 30 Jan 2024 09:47:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB2E10E466
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 09:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUF7D6Ccsdu7JImm4N59o5ccXkAN8QjPJVmVQ822pYfgsJ+8C+nzFHjDb+JQChX+zuxT7stD8xRS+ayRioy5+Qu6wXbheq0HqYwiisQ7kX/TKSga5W4MXc3LJNScBXHmkafC23/cpomuhdOsZcp5jDDaygIRVWzKNGi4dDAKRyWYxwRDhQ2H2ZoRFUTH/SLaQY9cr4pTxpQhzWAhSHKGBcaicSX6PcRzkb0o9L/1a5CDJXvwK3m2rvnDpdxI0LiSmz4Rx2eRJYhj2ljUUDqfNTTGI9Kod31tHRr8p/VR/th9XRb2s2ZYbuXHiAsTMX8HvgZe+bAhAG6JmeL+iIbJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDdslU3DUAqjfvoNMmbI9af7iwEdq4GtZM3pntI6+Yo=;
 b=VB74MN9BuwPujta1GjUYn7ihoRw9ztaN3SWtsesJAxp/D248abZSkog9JUdCcomyr2stJ+q/p7NyxaAXHRnMKgCPCA6OXPX8TZkqZ8Id3fFQOj/frxL/6H405MtiOB4dNtARERDl8qhb71Q59K8A1wfjaOjn47sPJMqtefGNf0LOoU3xlLLAPvPgS8S7ytc1z3XLDI4fkp1uFPR6oUt0NADAo+nigHHlHN/me2WKvOrHKFpc6Kfg1ifHq60ft0Y9FKsiqsTfc/E5wdfYm5kWMtDaJFDJEktXMELOFj8zWfFW5uOwelhedxYdWYc/fPTVZHsK/8RPNmKLXQjzy2mDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDdslU3DUAqjfvoNMmbI9af7iwEdq4GtZM3pntI6+Yo=;
 b=za+Kr2vRFNZqzorFV25YSYzjXM7ETWNheWil9NPETP5eiXci+idaIJvU1U80moPk1EI2h/TeWvf3M40hWa9KsST23iLBkx9FQgxqGyYpA5XT5vimhHOnEeDlpuSIePzp+i3KrXpmHVSUmSCdnePX5rx2BRdcBpx6OInAAJ1uLUI=
Received: from BN9PR03CA0598.namprd03.prod.outlook.com (2603:10b6:408:10d::33)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 30 Jan
 2024 09:47:04 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::c5) by BN9PR03CA0598.outlook.office365.com
 (2603:10b6:408:10d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 09:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 09:47:04 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 03:46:16 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdkfd: reserve the BO before validating it
Date: Tue, 30 Jan 2024 17:45:44 +0800
Message-ID: <20240130094544.176209-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c008b69-cfb2-4cd8-03c4-08dc21786a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4aXof0XEYg6jMDS3mb7/QlZ86U5xOdaQC0eDv+FN+iNhuh7lQHLFWr+2BBBy7WkKy/BGh9EWKjR4hyzZmoP0DwJKGe/MttnhEQ07TbkMUIjVTNgJQi5DATHGhP0HbI0xC5r051FWWJdcj5VF9TvujOo+2Mk83qqWFmyDFI7L1PHoYvK05dkFDR3GZbm1uIPardm0PRWke5LiRMCgnezsMceBJN1+F3RMJS3NyCglGz6RPX7xoCGoz9ysr58YcosW8qqWjol9tY3qhnnLV+xa5sXtMZf20DdezQquPEODvCezgNfpoK9KORFR+N0Bm6BrWJgpzU1WexbG2WuRxlzOBnrd6/UR561zrPF68eLTczFJjSEHzKHRRCfVU6aSREAmFzd/w7UUZl4NXbEnU2eG8SL66mgSHBJ4S5OBuUjeCEfMgWUG1fiR7aKVxjQoh+sQJYwMgXClB/aEkI3rlCgIvx5ieJFbpF9GA+1bmabnHv5FxvXZbglexqBphisd8+hzSs9bRZwQGVxRtKj+uNi9jZKuNTvN4u0ABm+14TKQc2Om4B0T8O/65beYxy0yJ//wC+6HFrJf3U8Cu/i815wDCA7HEs9/pzxFWANsIdXaZIrofvUPmKU8suG2nxP6uaHRVl4ZivpSLrBtc/IAvkjQBVdWwcoSNKF0J82v5Z77RrFAPrPIXDx7gLXqI7vGDq4JlGxNEjzqEXjH7ZnI8EbMtDivpvgpmGQL68NklxrtyefWgUTfudkfMkRSVZADWcT+/oodcGVZdGzELyNvEYXWkFxFVNcVkP92ztY8afIiLlD7hiDKVGFlzQQTlA5DOHcU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(83380400001)(86362001)(36756003)(356005)(82740400003)(7696005)(16526019)(36860700001)(81166007)(1076003)(47076005)(26005)(426003)(2616005)(336012)(6666004)(70586007)(8676002)(6916009)(478600001)(2906002)(70206006)(316002)(54906003)(41300700001)(5660300002)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 09:47:04.1434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c008b69-cfb2-4cd8-03c4-08dc21786a3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 410f08516e0f ("drm/amdkfd: Move dma unmapping after TLB flush")

v2: Avoid unmapping attachment twice when ERESTARTSYS.

v3: Lock the BO before accessing ttm->sg to avoid race conditions.(Felix)

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
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 20 ++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 298fc52a35bc..e60f63ccf79a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -313,7 +313,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
 					  struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
-void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
+int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
 int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 6f3a4cb2a9ef..ef71b12062a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2088,21 +2088,35 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	return ret;
 }
 
-void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
+int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
 {
 	struct kfd_mem_attachment *entry;
 	struct amdgpu_vm *vm;
+	int ret;
 
 	vm = drm_priv_to_vm(drm_priv);
 
 	mutex_lock(&mem->lock);
 
+	ret = amdgpu_bo_reserve(mem->bo, true);
+	if (ret)
+		goto out;
+
 	list_for_each_entry(entry, &mem->attachments, list) {
-		if (entry->bo_va->base.vm == vm)
-			kfd_mem_dmaunmap_attachment(mem, entry);
+		if (entry->bo_va->base.vm != vm)
+			continue;
+		if (entry->bo_va->base.bo->tbo.ttm &&
+		    !entry->bo_va->base.bo->tbo.ttm->sg)
+			continue;
+
+		kfd_mem_dmaunmap_attachment(mem, entry);
 	}
 
+	amdgpu_bo_unreserve(mem->bo);
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

