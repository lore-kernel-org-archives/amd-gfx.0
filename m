Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68A1CD98D2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 21:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 776BF10E85D;
	Tue, 16 Jun 2026 21:17:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hjOSzXJj";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DDB010E85D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 21:17:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRw02ZKD6n7iGHpfVL+csULqnicKlEXIMMdfmfV6hfArgek6oqFkFpJjE4eF1yMhgIZwxw1pGE2fwo2M6qrnboGFKhFy/MIXE1b1KgFdvqgt6AhQoAYsQDdMIID5m3sFxJ70WqR7Us9pHinJJUnmSFM+7r7luOWMQmhBaOsoZ439WOyi7IPHerlZAqhb9Lmp22TJlqi6+yMW02e9KOLlzaPoDcXngNs9HBC7xCDncnP58fGurR6szNuK1gd26APf/A+p6GDPZy42cOdvD8JXeQqFoEzoSOgqj1tIIZxrcxL7b/kcOo6IsHgYsEV2CGiJKn6v1ZF5a/dN3P2/O5XZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkO9Y0+Rt6R45+kz3FwQaF+YThGMKXVtLpiY0NW5zL8=;
 b=ykVIi7GnbJPK8xNZBN6xgVmawdYzY8073HSPgARJuiZcTBbq6JDRGcsIBJxJ7jVTn0eK84xXoEWbDYyZ1piX060t8q8lP9lvp/S5uxdLCfHXinfpvVEVgRW6K5mZzz8+UkEh+fmn/gPMBusYWjP4X7tKF8v0svHzTl1trbx3TsuHq0mzrNJxZAsWeVz/f64m7APJX6//Nco2SJGQ2H3zAVIkd+HDneraZLQakOXQStgUmyf513P91FotntYFH1O4+7IXCF8nbo7Z1jw/gxJKwJ3t8YbbsuESFyGpRTtM0uh7HfkuwNAySS0wvG/q7DOkB/EPURNN3pGeSRTx9ZxS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkO9Y0+Rt6R45+kz3FwQaF+YThGMKXVtLpiY0NW5zL8=;
 b=hjOSzXJjtKOx6e6qV+i3G49LwCioF5KuVLnpozpLSmTJpx1pa9oxhORzG3ZyTV/KR9P0nzSIzpePodUdkaB60pcXix/mun64hDHfDBecypYq8qacQFncAWlG3Z8e/KHQTNbZCJoHUcXSH1SHDN07I9EDaURJOAnKqcgUg6uJ/pU=
Received: from BL1PR13CA0317.namprd13.prod.outlook.com (2603:10b6:208:2c1::22)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 21:17:27 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::5a) by BL1PR13CA0317.outlook.office365.com
 (2603:10b6:208:2c1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 21:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 21:17:27 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 16:17:26 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Amir.Shetaia@amd.com>,
 <Kent.Russell@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Drain retry faults before SVM range no-access
 unmap
Date: Tue, 16 Jun 2026 17:16:52 -0400
Message-ID: <20260616211652.1962285-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616211652.1962285-1-Philip.Yang@amd.com>
References: <20260616211652.1962285-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a110b9-74da-4254-f9d3-08decbecab24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Y5VzTbAs4U3LpXCVpIA/axlou+osuemiGho40NLWZU1jOazbVv7qgLDZM/FGspOWFEhttoiCx0Y9vyi7H/+auUSwS/U07W3mDSWzKFwcH5FTFcgaPpB5shoWb9xl5LvvhSrZhqP+HFmcg7t/w0h/3YxDO8+Mqm/NmaOOrO2xlg4ObYap2F3oK3SPCjwmdlnzQ6NDgzdvyjdZqgSDdl2uxTrG0Zf1DR/wRRYwBNgGtUUxhuXK3VmmR6qT9oo0uivqYgYMDstrjDhVUnYUMCm+IvqA1ssgYI1b7jRUgnvDZIlbTTGQdo4v7uT3Bxl8aSyIIG11s4We+JKvIb/adX+2YJwCMrNGgkfi2DsNdu2rdJEKvLXFfbt6na8QeoHDHtORlFrOy5Juub+rsavvJPndlAW9iS8XYCz95UWpH+/TYG3Dlqv+WdVtOCAbuJKxpIQByBp5vstAgiPAzyok6rXjiYyNce+HXBQdkvsE3NkWMUw9ArqK3LSr2sYLuuKk2oiBsUQL4ykwlW6860mdu+hprNRpWLpBpCSNUCN5sTnRDCpeVVlTBKBB/dWAbcmQOvT5pjfmY1KlVDpcLnbe8eplUp1pKWwBQlzXaH5nH3oe6KZYqN9g2/DgPrgpAek51RfnK+wRDtnvLw8K8w0TSAhHEKcLTl8r/+4o/B3LX52PyNGwZCrKyms4hnytnfB8nsb8xug5egViyzl0i89SD81xX+fr5PdP27jRyUQty70lQs8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /9qvPC8sL1ssACQo/TxFvSxgcL3DEdh+gIbOBjpniQSf3HPAXr+3+LsuEZJJedXITO0+J9DjUHe2XV3V3mouWCd4lgK5FsDuf9C+zBqHTGDws9QwiZschZbmLFLhb352ChyTX91DDU+fPl814/N2OGFstbxBnmCOm3x2fBZLC0Ht/KoKW/528Dz0PbOHUWEN4g5uaTGEfFt5wX4Fh6V+tGrxedTWEv3vPaHG21SC+CjsWtWLoYRaKHy9Iwhh0d5t/04J7/iIe7OnMjR57ADjNDvFF8QebCZ/6wD3+3A4eIRbibNBWGL56xl54y+3sCsE32RvwwU1wdxtiIXVd7TxHc0RTuYUSjW6HSDsEYukTSP3N1mRQaQoEftcBGXE+yqf6WxEMItTZUrpabCeYYrcQZfIhzPrv4Fgs18aQ+UfZ7K3VUGNKpSR/rbWg3Nvopt3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 21:17:27.6802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a110b9-74da-4254-f9d3-08decbecab24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
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

When svm_range_needs_unmap() unmaps a range, retry faults queued in the
soft IH ring before set_attr no-access was called must be dropped, since
those faults arrived before the app chose to revoke GPU access and should
not re-map the range.

Extract and add helper svm_range_update_checkpoint_timestamp() from
svm_range_unmap_from_cpu() so both callers share the same logic.

Change checkpoint_ts in svm_range_list from uint64_t to atomic64_t so
svm_range_restore_pages() can read it safely from the page fault handler
without holding the svms lock.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Acked-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 85 +++++++++++++++------------
 2 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f00c522fba74..d3dcc3b8d546 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -893,7 +893,7 @@ struct svm_range_list {
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
 	/* check point ts decides if page fault recovery need be dropped */
-	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
+	atomic64_t			checkpoint_ts[MAX_GPU_INSTANCE];
 
 	/* Default granularity to use in buffer migration
 	 * and restoration of backing memory while handling
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e039b6f2942f..acaa364244d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -759,6 +759,48 @@ svm_range_check_attr(struct kfd_process *p,
 	return 0;
 }
 
+static void svm_range_update_checkpoint_timestamp(struct kfd_process *p)
+{
+	struct svm_range_list *svms;
+	int i;
+
+	svms = &p->svms;
+
+	/* calculate time stamps that are used to decide which page faults need be
+	 * dropped or handled before unmap pages from gpu vm
+	 */
+	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
+		struct kfd_process_device *pdd;
+		struct amdgpu_device *adev;
+		struct amdgpu_ih_ring *ih;
+		uint32_t checkpoint_wptr;
+
+		pdd = p->pdds[i];
+		if (!pdd)
+			continue;
+
+		adev = pdd->dev->adev;
+
+		/* Check and drain ih1 ring if cam not available */
+		if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
+			ih = &adev->irq.ih1;
+			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+			if (ih->rptr != checkpoint_wptr) {
+				atomic64_set(&svms->checkpoint_ts[i],
+					amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
+				continue;
+			}
+		}
+
+		/* check if dev->irq.ih_soft is not empty */
+		ih = &adev->irq.ih_soft;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih->rptr != checkpoint_wptr)
+			atomic64_set(&svms->checkpoint_ts[i],
+				     amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
+	}
+}
+
 static void
 svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 		      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
@@ -784,6 +826,8 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			gpuidx = kfd_process_gpuidx_from_gpuid(p,
 							       attrs[i].value);
 			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
+				svm_range_update_checkpoint_timestamp(p);
+
 				bitmap_clear(prange->bitmap_access, gpuidx, 1);
 				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
 				bitmap_set(prange->bitmap_needs_unmap, gpuidx, 1);
@@ -2560,7 +2604,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	struct kfd_process *p;
 	unsigned long s, l;
 	bool unmap_parent;
-	uint32_t i;
 
 	if (atomic_read(&prange->queue_refcount)) {
 		int r;
@@ -2580,38 +2623,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
 		 prange, prange->start, prange->last, start, last);
 
-	/* calculate time stamps that are used to decide which page faults need be
-	 * dropped or handled before unmap pages from gpu vm
-	 */
-	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
-		struct kfd_process_device *pdd;
-		struct amdgpu_device *adev;
-		struct amdgpu_ih_ring *ih;
-		uint32_t checkpoint_wptr;
-
-		pdd = p->pdds[i];
-		if (!pdd)
-			continue;
-
-		adev = pdd->dev->adev;
-
-		/* Check and drain ih1 ring if cam not available */
-		if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
-			ih = &adev->irq.ih1;
-			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
-			if (ih->rptr != checkpoint_wptr) {
-				svms->checkpoint_ts[i] =
-					amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
-				continue;
-			}
-		}
-
-		/* check if dev->irq.ih_soft is not empty */
-		ih = &adev->irq.ih_soft;
-		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
-		if (ih->rptr != checkpoint_wptr)
-			svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
-	}
+	svm_range_update_checkpoint_timestamp(p);
 
 	unmap_parent = start <= prange->start && last >= prange->last;
 
@@ -3121,8 +3133,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_lock(&svms->lock);
 
 	/* check if this page fault time stamp is before svms->checkpoint_ts */
-	if (svms->checkpoint_ts[gpuidx] != 0) {
-		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
+	if (atomic64_read(&svms->checkpoint_ts[gpuidx]) != 0) {
+		if (amdgpu_ih_ts_after_or_equal(ts,
+		    atomic64_read(&svms->checkpoint_ts[gpuidx]))) {
 			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
 			if (write_locked)
 				mmap_write_downgrade(mm);
@@ -3132,7 +3145,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
 			 * to zero to avoid following ts wrap around give wrong comparing
 			 */
-			svms->checkpoint_ts[gpuidx] = 0;
+			atomic64_set(&svms->checkpoint_ts[gpuidx], 0);
 		}
 	}
 
-- 
2.50.1

