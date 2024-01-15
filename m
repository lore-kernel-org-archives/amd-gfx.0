Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4D9C3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 22:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B7610E393;
	Mon, 15 Jan 2024 22:02:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B2410E393
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 22:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h65/jgHpcTbRlAd+gsAaDsrVr+29Q2Wjxsh/Xpz0IhkCiCkHW8SI4nzVcDWD6R4elngjE+eBo3JseNcPDJEheyxVKO9/vvtGvnWwKalZkh/PLhfXqO/8PvP6Fx+8cN7DWBfALx7sIGgFcpjuuqmKoGcO/3DY9WXSDrXnp/BtJncS6uzW8kOndkpGvcDsLNujm0i+Z1QqXpxDgvG9JRzfEJS5goZYuINiGbmtdHgEprydgWxmHs1HPLGsZooHmepVbn08IEK4eMz8pHYazgKtWAJDZt1zO0idy1JxZN41r/tshpnwr/LLXuPp7PjnAhANvakZohqxiOiyZCftYAFYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tujUHVTSP4A2dffnw6DpB7R2b8WhbzyLKra/kWV+gJQ=;
 b=ZYrpt8ntPFm48Xft8bJO3N6bTJcuX+k/TLn8EaKk7iZ3sxuiQQ5mO8dSDsmpLlr4T+KdLA7hUFH19R3YAd+mTcNQakVKXE/b2xVwNmREfshIX2pHnPujBRVFCZ8gBEbyyU/BEtbMX7w5EcwJ9i5iXAl+4ydF7Ox063OC7ukHAM0bsw45d84tVxfF61Why07czdCr9jqo+Cbo3Dj7GXMOhZDBkQrGZzkmyxRmvd4lHoBqYwsd52uxijiEs2xB+e76NKPLQCNk+hKZmNskwa9XryxtrT8YBVaIiWs166n8XCnxYCc/21YZWeQ10l/i7lFBcm3EYi3lK6i8W1ATXmTLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tujUHVTSP4A2dffnw6DpB7R2b8WhbzyLKra/kWV+gJQ=;
 b=h8/DMY/J4C6tJacub+sbBhg9iZye9EbBw3XXNxt3LJINZQP0o113rt7hPoQ7/angJ9ESrcD14UPNB9aJFJFYILQzhWmpthHNvXAhgwi2kGytWMGvRKv77ET8KHZP9mq1MSQbNAThIXULj/WU507NOqEqlwxLmnU33yiGjwN7Ods=
Received: from DM6PR04CA0015.namprd04.prod.outlook.com (2603:10b6:5:334::20)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 15 Jan
 2024 22:02:51 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::ba) by DM6PR04CA0015.outlook.office365.com
 (2603:10b6:5:334::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Mon, 15 Jan 2024 22:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 22:02:51 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 16:02:50 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amdkfd: Set correct svm range actual loc after spliting
Date: Mon, 15 Jan 2024 17:02:28 -0500
Message-ID: <20240115220228.12824-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0468f5-b50a-4b4c-bf60-08dc1615b7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gw4OeMipNQ1Q3mlGZs/9HLhRLVX2f9UJWlw5/Q6WPQwYa0Ph7l8JhsKzYAO5A+6MHwTFIQcpgIfnc3ey5dCiND7j+EhkLrddi8FKMFxX0ltKEzU69dl2teYlM+ntSlMxC6NbMHdTkphvafC1XRcAK1qTxaXKK/6LbFrwiNbupVF0JonLOqzVTbaYqeUllo+4uQ0MS745RufIBN7MiDv/pTjiXC5RVpAkYQrlbw7OpGzXW3/+0U4T4xROUNIgauQl/vCt3DcV+MXI8Ju0jVhbXNBLokPctg90rumdcxHgxeHGpk1jc+ECMyAwcoAmNjwQmxODjSxQTLtYizlmT2JPVi9BPSCC061w4ju7NrpeVlZOe4HHOzeEeHX7k2O0YEnxWtnbtRtbY3KWwJSQoaSqUQv4Nx5SsQThaXR3mAcZ+P1qwuATowDtrPQZiVbwko9joJiD8eePAapFCiEfDb8ToATtMBPZEWOu5gBZJXqjNZr2voPBuUWD+79zcxoKCVaCGsy/KhIRFTwjjcrm4FGcVBDy/hpUZuxTnUjlTbAmSDSaP9le/6OHpPdR0pegHrNaxPpVaMFAXeKlhUl/sLl5Qw27sE953NM4MCpsYIHbV//+D+mM4SnCiyY1BO5mDfpNZWKaX2zK9UwqHoUc2lkfORWFqo5lrjrfjPOIpkfKZ27ay1uhREkLwmEc7UaErq3uwJVujRQPuxxGKce5EYhkPnLcEO7s43pF/YIgswEoffBIUwfhCE307HVJR1bDIZhOO/zOJ4Qo57gSmOtIEpQV7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(6666004)(70586007)(47076005)(86362001)(2906002)(5660300002)(8936002)(8676002)(36756003)(4326008)(2616005)(316002)(54906003)(356005)(70206006)(82740400003)(478600001)(6916009)(36860700001)(81166007)(26005)(426003)(83380400001)(16526019)(336012)(41300700001)(7696005)(40480700001)(1076003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 22:02:51.4045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0468f5-b50a-4b4c-bf60-08dc1615b7e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
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
Cc: Xiaogang.Chen@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

While svm range partial migrating to system memory, clear dma_addr vram
domain flag, otherwise the future split will get incorrect vram_pages
and actual loc.

After range spliting, set new range and old range actual_loc:
new range actual_loc is 0 if new->vram_pages is 0.
old range actual_loc is 0 if old->vram_pages - new->vram_pages == 0.

new range takes svm_bo ref only if vram_pages not equal to 0.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  8 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 42 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index bdc01ca9609a..79baa195ccac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -564,6 +564,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			dma_addr_t *scratch, uint64_t npages)
 {
 	struct device *dev = adev->dev;
+	dma_addr_t *dma_addr;
 	uint64_t *src;
 	dma_addr_t *dst;
 	struct page *dpage;
@@ -575,6 +576,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		 prange->last);
 
 	addr = migrate->start;
+	dma_addr = svm_get_dma_addr_for_page_count(prange, addr);
 
 	src = (uint64_t *)(scratch + npages);
 	dst = scratch;
@@ -623,6 +625,12 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
+		/* Clear VRAM flag when page is migrated to ram, to count vram
+		 * pages correctly when spliting the range.
+		 */
+		if (dma_addr && (dma_addr[i] & SVM_RANGE_VRAM_DOMAIN))
+			dma_addr[i] = 0;
+
 		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
 				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f84547eccd28..78b4968e4c95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -362,7 +362,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&prange->child_list);
 	atomic_set(&prange->invalid, 0);
 	prange->validate_timestamp = 0;
-	prange->vram_pages = 0;
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 
@@ -965,6 +964,24 @@ svm_range_split_array(void *ppnew, void *ppold, size_t size,
 	return 0;
 }
 
+dma_addr_t *
+svm_get_dma_addr_for_page_count(struct svm_range *prange, u64 addr)
+{
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
+	dma_addr_t *dma_addr;
+	s32 gpuidx;
+
+	gpuidx = kfd_process_gpuidx_from_gpuid(p, prange->actual_loc);
+	if (gpuidx < 0) {
+		pr_debug("no GPU id 0x%x found\n", prange->actual_loc);
+		return NULL;
+	}
+
+	dma_addr = prange->dma_addr[gpuidx];
+	dma_addr += (addr >> PAGE_SHIFT) - prange->start;
+	return dma_addr;
+}
+
 static int
 svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		      uint64_t start, uint64_t last)
@@ -980,9 +997,14 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		if (r)
 			return r;
 	}
-	if (old->actual_loc)
+	if (old->actual_loc && new->vram_pages) {
 		old->vram_pages -= new->vram_pages;
-
+		new->actual_loc = old->actual_loc;
+		if (!old->vram_pages)
+			old->actual_loc = 0;
+	}
+	pr_debug("new->vram_pages 0x%llx loc 0x%x old->vram_pages 0x%llx loc 0x%x\n",
+		 new->vram_pages, new->actual_loc, old->vram_pages, old->actual_loc);
 	return 0;
 }
 
@@ -1002,13 +1024,14 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
 		new->offset = old->offset + npages;
 	}
 
-	new->svm_bo = svm_range_bo_ref(old->svm_bo);
-	new->ttm_res = old->ttm_res;
-
-	spin_lock(&new->svm_bo->list_lock);
-	list_add(&new->svm_bo_list, &new->svm_bo->range_list);
-	spin_unlock(&new->svm_bo->list_lock);
+	if (new->vram_pages) {
+		new->svm_bo = svm_range_bo_ref(old->svm_bo);
+		new->ttm_res = old->ttm_res;
 
+		spin_lock(&new->svm_bo->list_lock);
+		list_add(&new->svm_bo_list, &new->svm_bo->range_list);
+		spin_unlock(&new->svm_bo->list_lock);
+	}
 	return 0;
 }
 
@@ -1058,7 +1081,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new->flags = old->flags;
 	new->preferred_loc = old->preferred_loc;
 	new->prefetch_loc = old->prefetch_loc;
-	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
 	new->mapped_to_gpu = old->mapped_to_gpu;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 026863a0abcd..c6df930366ce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -185,6 +185,7 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
 void svm_range_dma_unmap(struct svm_range *prange);
 int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
 		       uint64_t *svm_priv_data_size);
+dma_addr_t *svm_get_dma_addr_for_page_count(struct svm_range *prange, u64 addr);
 int kfd_criu_checkpoint_svm(struct kfd_process *p,
 			    uint8_t __user *user_priv_data,
 			    uint64_t *priv_offset);
-- 
2.35.1

