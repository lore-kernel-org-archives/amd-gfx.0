Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3173C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 19:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F5E10E48E;
	Tue, 24 Oct 2023 19:21:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF48210E48E
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 19:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoG0WVygyNxj+pEAMJ0FC6iOGbm+oB6PBc3ud97hAn/S/dptjifuT0I4Y6u8hCNSvywLiM0iQ6rFfjp01tLOWB7Fx9Taci71xKR1H5P0ACmJ3a7vYttkTjmWG4tuyig5240AaeuEfS1X+UoT4PhAK23gURTusKzHvdBbo4LxgKbR/oBFtTbAYK+9A8Fco3yLYKtr7j2HobUwKrodL4DZjvORfWdfldYzKamGm0PtDr3jRc+07mJe83S0nfFq3wGISH1sPgFcNldLUZqXCSCDkZxw+wGxG/BdyR18N04HczsZyew+B33MrOMhvm4SCQH8eALJEjAGW74fl4qVdg6LQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/oSfa4t+mT/6/lNzxsxTKLoOrjtdGzi88ga3i04elc=;
 b=lYrfIW7ljThBgpNSgNpLn8Sh1+YDsyVMowEvz2fZ61kWGB5p6mlzPO24V3Rj1J3YriArP6nx+bDpkJQcJnd7a6QsCWBvnOpkwfICuVJPBuXPqUT63/9UhP64A3yN0ehpt7LZFXc3fkBUEuWOgiOy2MxsOyiwaRe/xwcR8ztU22gpuxHkW4Rd9mGJ+Akx8W+VtJNU3alPExYEL/2a0lS1InL2VPkiED3XKnNyb3w2dKbnl/XE/tuVYSGfXb86uaoSm63AWtqkH3079e+nM2GHrU6zmSnHmzYc6V+92k0IpzuJHSmw+VVM3ygGI31ugKw9JkVzD8u/BHmmKsREhOuNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/oSfa4t+mT/6/lNzxsxTKLoOrjtdGzi88ga3i04elc=;
 b=pyhKC5MfZHfC2g3+eD9oV/LN00KnsOGbaLv+55Ec2Qov7TgiHe25W6LsuFZ4GJwt4sSz0UTOopATmbJxjcHK4kak9BmV15SXR03ri+Osev7p2+PNkc8weeVmzObuCfSZCvUaHm+iegtkfWZ9wSQ+ANKzs2xQ0iYyYRzj8vpK95M=
Received: from MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::16)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 19:20:58 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::aa) by MW4P220CA0011.outlook.office365.com
 (2603:10b6:303:115::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Tue, 24 Oct 2023 19:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 19:20:58 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 14:20:57 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/2] drm/amdgpu: Acquire ttm locks for dmaunmap
Date: Tue, 24 Oct 2023 15:20:42 -0400
Message-ID: <20231024192043.400319-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: eae1dd52-72c6-4712-c8bd-08dbd4c65a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVU5uNyuTts8ECPcpI7ZSqcjck01XqHt8JYN/L1V7VpWrAblzRUTAjSKMHcnudpsCq/XlbZ1tlJHYyjMh36t+xTraKhdEnEB4ENL5VTnqSYbU1BdCKrTfQJ33lltg3OcniatWxnXr0FoM1ZNQiVgLxYmZwVzkCNt6IYzarabsTzjmg2hsUfZ5HsSKdTwlbs9acoNFo2lyvEEOUCwtSWfSab9SZ6ZbsK5FnV4thaFmaP2MNJ6ZoqiB41fh33HW02mC6VYXm30IwCNmWC/njIPYhNUNzJWiSIFg2+dLwsyPdV4bmbVrznPSasA65Bl8RqMR0N4gevsvGVh9Zflw97X2CTQE1WBOlSRC8c9zXYLT7NwLs8DOBUf0g+cCOSRiOFinPTg9hSB6bDv6yFdLVF18onXsiCHpCwiGDBWpvDYnMxuDX3+mhcGwP7j921fzp8PzzNGTcLKKRP3IZoPsajogr1Xzop/kfX8KTIbc4a9N2CfLIUKtk5r7fDIMV5D+n56X+KnqGeBwRP42jcTmOJzGeMD2e5WbXFM02KkQApWQ6IYNlgdDTRMynKQwaQ7d4uEp8tyqVcw1oYN4D4vnihLXz+8C354R/ZcgwQYW8frjikWUlT+kej3sXAeKdOJM/orwXd16QuDxgo6pzDvE2qqP4XpbnIbWHGBZc+AFQfyxD+AdJiLCKIN5xdZGCaDds67qUwy/wPt3gK2uPzBmVvWS4nEQjGoIbSxK7/zXWVxku8FxreCgjjZ9N3MVNbBQKFWM60Q1zxClRnnoP//qRC96w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(36840700001)(46966006)(40470700004)(83380400001)(40460700003)(40480700001)(8936002)(5660300002)(70586007)(70206006)(41300700001)(86362001)(6916009)(7696005)(316002)(478600001)(6666004)(36756003)(4326008)(8676002)(81166007)(36860700001)(2906002)(426003)(356005)(16526019)(2616005)(1076003)(336012)(26005)(82740400003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 19:20:58.4146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae1dd52-72c6-4712-c8bd-08dbd4c65a40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723
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
Cc: David Francis <David.Francis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dmaunmap can call ttm_bo_validate, which expects the
ttm dma_resv to be held.

Acquire the locks in amdgpu_amdkfd_gpuvm_dmaunmap_mem.

Because the dmaunmap step can now fail, two new numbers
need to be tracked. n_dmaunmap_success tracks the number
of devices that have completed dmaunmap. If a device fails
to dmaunmap due to a signal interrupt, n_dmaunmap_bos tracks
the number of bos on that device that were successfully
dmaunmapped.

Track those values in struct kgd_mem.

This failure can also cause the sync_memory step of the ioctl
to be repeated; it is idempotent, so this should not cause any issues.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 ++++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 23 +++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 19 ++++++++++-----
 3 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 3ad8dc523b42..c60564ec4312 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -86,6 +86,10 @@ struct kgd_mem {
 
 	bool aql_queue;
 	bool is_imported;
+
+	/* Used to track successful dmaunmap across retries in unmap ioctl */
+	uint32_t n_dmaunmap_success;
+	uint32_t n_dmaunmap_bos;
 };
 
 /* KFD Memory Eviction */
@@ -302,7 +306,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
 					  struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
-void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
+int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
 int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 54f31a420229..c431132d7cc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2102,21 +2102,36 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	return ret;
 }
 
-void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
+int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
 {
 	struct kfd_mem_attachment *entry;
 	struct amdgpu_vm *vm;
+	int ret;
+	int i = 0;
 
 	vm = drm_priv_to_vm(drm_priv);
 
 	mutex_lock(&mem->lock);
 
 	list_for_each_entry(entry, &mem->attachments, list) {
-		if (entry->bo_va->base.vm == vm)
-			kfd_mem_dmaunmap_attachment(mem, entry);
-	}
+		if (i >= mem->n_dmaunmap_bos) {
+			ret = amdgpu_bo_reserve(entry->bo_va->base.bo, false);
+			if (ret) {
+				mem->n_dmaunmap_bos = i;
+				goto out;
+			}
+
+			if (entry->bo_va->base.vm == vm)
+				kfd_mem_dmaunmap_attachment(mem, entry);
 
+			amdgpu_bo_unreserve(entry->bo_va->base.bo);
+		}
+		i++;
+	}
+	mem->n_dmaunmap_bos = 0;
+out:
 	mutex_unlock(&mem->lock);
+	return ret;
 }
 
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 06988cf1db51..66dee67ad859 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1366,7 +1366,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 {
 	struct kfd_ioctl_unmap_memory_from_gpu_args *args = data;
 	struct kfd_process_device *pdd, *peer_pdd;
-	void *mem;
+	struct kgd_mem *mem;
 	long err = 0;
 	uint32_t *devices_arr = NULL, i;
 	bool flush_tlb;
@@ -1400,7 +1400,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 		goto bind_process_to_device_failed;
 	}
 
-	mem = kfd_process_device_translate_handle(pdd,
+	mem = (struct kgd_mem *)kfd_process_device_translate_handle(pdd,
 						GET_IDR_HANDLE(args->handle));
 	if (!mem) {
 		err = -ENOMEM;
@@ -1414,7 +1414,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			goto get_mem_obj_from_handle_failed;
 		}
 		err = amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
-			peer_pdd->dev->adev, (struct kgd_mem *)mem, peer_pdd->drm_priv);
+			peer_pdd->dev->adev, mem, peer_pdd->drm_priv);
 		if (err) {
 			pr_err("Failed to unmap from gpu %d/%d\n",
 			       i, args->n_devices);
@@ -1426,7 +1426,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	flush_tlb = kfd_flush_tlb_after_unmap(pdd->dev->kfd);
 	if (flush_tlb) {
 		err = amdgpu_amdkfd_gpuvm_sync_memory(pdd->dev->adev,
-				(struct kgd_mem *) mem, true);
+				mem, true);
 		if (err) {
 			pr_debug("Sync memory failed, wait interrupted by user signal\n");
 			goto sync_memory_failed;
@@ -1434,7 +1434,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	}
 
 	/* Flush TLBs after waiting for the page table updates to complete */
-	for (i = 0; i < args->n_devices; i++) {
+	for (i = mem->n_dmaunmap_success; i < args->n_devices; i++) {
 		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
 		if (WARN_ON_ONCE(!peer_pdd))
 			continue;
@@ -1442,8 +1442,14 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
 
 		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
-		amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
+		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
+		if (err) {
+			pr_debug("DMA unmapping failed, acquire interrupted by user signal\n");
+			goto dmaunmap_failed;
+		}
+		mem->n_dmaunmap_success = i+1;
 	}
+	mem->n_dmaunmap_success = 0;
 
 	mutex_unlock(&p->mutex);
 
@@ -1455,6 +1461,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 get_mem_obj_from_handle_failed:
 unmap_memory_from_gpu_failed:
 sync_memory_failed:
+dmaunmap_failed:
 	mutex_unlock(&p->mutex);
 copy_from_user_failed:
 	kfree(devices_arr);
-- 
2.34.1

