Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED5FCA0EEB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 15:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C658410E42E;
	Tue, 12 Sep 2023 15:29:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FBD310E42E
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 15:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOhCKc8tPwxzQI+m7Dhgw/tuY65Ab++LRYRwcbhy2jJGw5R6nsjvUmY/mbkqc2/W6iOcna5lyUF5WcY6GjI+FHAB4HFpygEe0q6coU6ITgcR5HMqRfkCO7eSZUot+FQIxVOkqI+coNQ9GhWYgFh4EqDgOvjSbN2A9RGd9jDA2uSCvn23x5zMYoXg7svuvvtPl3fZfqiOnfBCz/O66lWuBPM73gu//LLP2r3Nl7IwMvBjQx2KCj84AqkiLO8GA87YFNM4s8Am4uK05gzErhbXR+s0g4tYybUa22ovetmAO5X2Maq77v/JL+UgxgIZO0SeD6QNbeRCKIhBSHVj0pYr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND6OhQ3QfOSKDTh8vhcT5sNi5MLjgfcP0NIKWMqufa8=;
 b=c3s5lVzQWj87QiUlwoqDnCu60o9UvUzRXevh/5VopJZjHLBtrXBAbEKAUrFZcGYdK53SQMBHu7wAFgoMcUQz7BtWnwbu0y2JJ8pN6073hY3nMsRe237eg52H23M2u9ItrsPJM1sF2ocTVYwWxz85r95IGejWFx+Xur6vHo7Cg1sqlxalh5QOFmmT/bg82XrsVcVnR775gCCN1XOwyQi/cBC33tEmmRWJ8/X/x6v2sMYYqKpKDYe2JfwwEwpzy/elxfA/eisRkHmUyOaBx9Kit5iB4LqeFT82qPjeViIfcHNd4QlTCb3E6NQXHW7uWdtPBPlkjVy+/I12taNt85frGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND6OhQ3QfOSKDTh8vhcT5sNi5MLjgfcP0NIKWMqufa8=;
 b=PhXLb9tZ/79fVrGOFaCDmkCTPAYSQq6fwVGjRwHxna9PBg1igf2gVsEiBhv9CMsCwCiq0mL5+Lxxr5C8SExgY03QFmVA3QpuEXfYE9FZ85sIpjsBS5qgQyZ+lWlFrVx/4pbWmmOh89pZY5ZP8nfV8nlEYclqapVrSDsczvONvrU=
Received: from CH0PR03CA0348.namprd03.prod.outlook.com (2603:10b6:610:11a::23)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Tue, 12 Sep
 2023 15:29:52 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::e7) by CH0PR03CA0348.outlook.office365.com
 (2603:10b6:610:11a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Tue, 12 Sep 2023 15:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Tue, 12 Sep 2023 15:29:51 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 10:29:50 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdkfd: Move dma unmapping after TLB flush
Date: Tue, 12 Sep 2023 11:29:17 -0400
Message-ID: <20230912152917.28928-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230911195517.8548-1-Philip.Yang@amd.com>
References: <20230911195517.8548-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|MN2PR12MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c82dd7-1a16-4d42-3418-08dbb3a51b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHsSxrRTiPTDpAdKtkNBbBaAwuBBvR/do3S1tZDuDxb1+cl6l2CM8LdgL/Y16WxkbBX3uvio1SRjT0oChnKghu+Y8TwdQMKh3yDzl4r3r/xskefeaZxKBlLuVjjLofYyltbAX7yuMWtoQZucZ3jb0Bck9kIC2dqpiuqsspiNSPLCkmENPYG98YIYIVasBp2DIITtYQjckzj5tmwk6Pm/H9j54nhhI9C0qJMcRfB/Sa3lwDjzY++nAh85KUTX4iuTyuhw2mzgqe4hcsMi7KNxGO9+yJkwBftWKp/kLeqzotXcMBq/Jv09l5viA2xg0Ugmlb5iL0DLowj58s3mP6fAhRdLY9BHIGWYe+mIVcd2oBt1SBX9Al+dgwuin+QxCw9YWObxIs7JZS2febB2OWMU/uVvOFVuAMLRR2WqzUQaXY5AxpxkmRqt4o00krHSAJmwM74QOdSVYbtMzfd+MN6YKS2YTnL/+sLzam0kw66ErjqfWlIL6RVoc8A/AqNk90E0mQcOXaE4fjO008n9qqgEtjjzxi/jLa2nMKYG0mpp2sRInohx0u9h65XOeQ1v5hkfZvqPHih9so4PjAfdULgu8y2s2caa4Jsp+wXgG36qA4DkauoikHNxL2eeYiLiQtXFUnuFozuzBHCMPK0fQ0bLB69J85YWGf9mE4q/tg9+AGJEH/Hk3gqFqs1HfJpQfnznPorRlp9RRvD4S8ikxgTgAP+p2MPO7jIKPb/9jvHv9uIjZUp9CaWgEb4ZtzqzfB178qRYU60A9oWdvPQViCXtvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(4326008)(8676002)(8936002)(86362001)(40480700001)(5660300002)(40460700003)(2906002)(36756003)(478600001)(336012)(1076003)(426003)(26005)(2616005)(82740400003)(81166007)(7696005)(6666004)(83380400001)(16526019)(356005)(47076005)(6916009)(41300700001)(316002)(54906003)(36860700001)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:29:51.3983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c82dd7-1a16-4d42-3418-08dbb3a51b76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise GPU may access the stale mapping and generate IOMMU
IO_PAGE_FAULT.

Move this to inside p->mutex to prevent multiple threads mapping and
unmapping concurrently race condition.

After kfd_mem_dmaunmap_attachment is removed from unmap_bo_from_gpuvm,
kfd_mem_dmaunmap_attachment is called if failed to map to GPUs, and
before free the mem attachment in case failed to unmap from GPUs.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 26 ++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 20 ++++++++------
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 559f14cc0a99..609a6fefd85f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -304,6 +304,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
 					  struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
+void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
 int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b5b940485059..7177cd884fe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -731,7 +731,7 @@ kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
 	enum dma_data_direction dir;
 
 	if (unlikely(!ttm->sg)) {
-		pr_err("SG Table of BO is UNEXPECTEDLY NULL");
+		pr_debug("SG Table of BO is NULL");
 		return;
 	}
 
@@ -1249,8 +1249,6 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
 	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
 
 	amdgpu_sync_fence(sync, bo_va->last_pt_update);
-
-	kfd_mem_dmaunmap_attachment(mem, entry);
 }
 
 static int update_gpuvm_pte(struct kgd_mem *mem,
@@ -1305,6 +1303,7 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
 
 update_gpuvm_pte_failed:
 	unmap_bo_from_gpuvm(mem, entry, sync);
+	kfd_mem_dmaunmap_attachment(mem, entry);
 	return ret;
 }
 
@@ -1910,8 +1909,10 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		mem->va + bo_size * (1 + mem->aql_queue));
 
 	/* Remove from VM internal data structures */
-	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
+	list_for_each_entry_safe(entry, tmp, &mem->attachments, list) {
+		kfd_mem_dmaunmap_attachment(mem, entry);
 		kfd_mem_detach(entry);
+	}
 
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
@@ -2085,6 +2086,23 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	return ret;
 }
 
+void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
+{
+	struct kfd_mem_attachment *entry;
+	struct amdgpu_vm *vm;
+
+	vm = drm_priv_to_vm(drm_priv);
+
+	mutex_lock(&mem->lock);
+
+	list_for_each_entry(entry, &mem->attachments, list) {
+		if (entry->bo_va->base.vm == vm)
+			kfd_mem_dmaunmap_attachment(mem, entry);
+	}
+
+	mutex_unlock(&mem->lock);
+}
+
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 65d2b9ae16bb..06988cf1db51 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1432,17 +1432,21 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			goto sync_memory_failed;
 		}
 	}
-	mutex_unlock(&p->mutex);
 
-	if (flush_tlb) {
-		/* Flush TLBs after waiting for the page table updates to complete */
-		for (i = 0; i < args->n_devices; i++) {
-			peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
-			if (WARN_ON_ONCE(!peer_pdd))
-				continue;
+	/* Flush TLBs after waiting for the page table updates to complete */
+	for (i = 0; i < args->n_devices; i++) {
+		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
+		if (WARN_ON_ONCE(!peer_pdd))
+			continue;
+		if (flush_tlb)
 			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
-		}
+
+		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
+		amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
 	}
+
+	mutex_unlock(&p->mutex);
+
 	kfree(devices_arr);
 
 	return 0;
-- 
2.35.1

