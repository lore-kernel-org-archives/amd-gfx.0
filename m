Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE09C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 02:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E7864DFD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 02:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E7864DFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 825AE6E3AA;
	Fri, 29 Jan 2021 02:50:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0147F6E3AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 02:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEpOF7j3UwSIqsCpJmOyvwuIH8sGt9LQKh0KK+d3fpkzWslv3WAE5g736brEc/n3tqXrUMuD3wDfhGlavOqZIRUHUsPi9mZJBL2bFkc6hjQ40pr4Bc1ZhFkRZZ5f1acoIPpjrH+cjxRQiZxGcC7/ax2Q0i6ajbjUSCEdzNhrtTGnOjNVN4amXwh7qsklAL2oT8iJVq1GaLhDuRIALqDGjmH4zTbPsT1Fxq7zijmu1v1hA59mbnSR0XC8rcopkkZdlhKY4yCCUhfqReS6j+UuOi8FXkgTNn98rPCwU45fDuHrsgQEehKDHVNrySM8eiFxfuvuE5SBykvVJ5EGhNqUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yoo85Fx3gdEqtFO60uKqfe2JAU3+M5pztJkDqOh2qgE=;
 b=mltR+odNdN/emyLQ2QqcLT0wvl4gQ0QwJOBJ8yLhqgX/aJje6dPtBwvjgp5oYeQvPf+lt/pWwT2rtJRvpRimc2S2/DYeKichUOc+m/Bqfltny3ur/8k4GHwn0znnSqNB5z7MrSrbHay2btg/oxZBWCT7U9l9tYFFv59psX+X+e6E91CHBT4oSscPU3vHP7hn8Ik8EFo6x0neXy+TYJ7DSuuOg50ubbQaYag3FwWR+O/AEt/ZhS2y23+lgrQiUTcT/yLVroHeTEESjPoNoM4C/kMHLkjn54huBtxfsNYkfrz42wrnsYMRl6nHFC92Bo/PgtLlWuQw0da2Suo4uAj+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yoo85Fx3gdEqtFO60uKqfe2JAU3+M5pztJkDqOh2qgE=;
 b=dJU06ahL3plHcce3b4LoJNIGAKqWbDbpVmAMuMr0niI/6sHgXbNu3pHhQYK4zfAlqtRVlOCCoHvK4ZnXmOxWJEF/XusrojtMYIVT6Sc5y5/pZ1mahJy2oejyi5VlWdWG/9ZoT4BBn18MUpmeoFcNiDEcYktVoF08o0EEsRSpNWM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN6PR12MB2608.namprd12.prod.outlook.com (2603:10b6:805:68::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 29 Jan
 2021 02:50:15 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::f1c5:dcb5:37df:ac2c]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::f1c5:dcb5:37df:ac2c%5]) with mapi id 15.20.3784.019; Fri, 29 Jan 2021
 02:50:15 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: Update RDMA implementation such that
 get_pages() only pins memory of a BO while dma_map() builds an sg_table from
 the pinned memory
Date: Thu, 28 Jan 2021 20:50:00 -0600
Message-Id: <20210129025000.3411-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN7PR04CA0196.namprd04.prod.outlook.com
 (2603:10b6:806:126::21) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from RErrabolDevMach.amd.com (165.204.77.1) by
 SN7PR04CA0196.namprd04.prod.outlook.com (2603:10b6:806:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 02:50:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3bddf4a-7b4a-4628-9aeb-08d8c4009aba
X-MS-TrafficTypeDiagnostic: SN6PR12MB2608:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26080500A998FB1ED701DE3BE3B99@SN6PR12MB2608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lj7R1OF572BP39R4NioeX5PaSLXQ5c3J8wr3AjcbrjxO7+sk1Y1SOq/oq6RMRydlF3XKJoZbnGgVYU6ITKLWSPppCoFKR1L4oFZ1KGvo9LJO1Gmy9/wqEqg8b7f1NnKHDgoh3dJppw5y14EbU0JVZXvRzsjHkKYBUN1loj+M7hgnQNMu9aDNDDuqBerQ8jpOLq5P4aRcHJR+/v+8skmgzlCxAT6fv4zaWf8EXwt01VATJGxFO6IGaZYCucRaie4CDgJ1C5QIZWM/CBHmu+m806vN9G7Q2N/XzQVpHHb0adFyKOu8H+kdYieUHN0XiKTUdsCH7MlC6eTPbDZQ/rC60mF98Fgmx6RqyaUwO0LjXSOcJmvTDOUeZnV/6f8lq2PxKCyvW3PJcC5VTZRu1710EnEFm1WGOXc84NnZh98gLJog9rEMcntPjHhudHj6gMTX2PQ3eF6FBUczvBgZEzbXnaufNDKVWq8fBS82w6zH6oCF5NO6RSj9SS6Gz/7WOxgVM91S4uVRUemeLRW/+g11eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(2906002)(52116002)(8676002)(86362001)(186003)(16526019)(26005)(956004)(15650500001)(66946007)(7696005)(2616005)(36756003)(83380400001)(1076003)(478600001)(6916009)(66476007)(6486002)(6666004)(5660300002)(4326008)(66556008)(316002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QrGuT8UVllyYZWPCJimwXfCYjFq7/YCxaa07ZQKPI3CjjK0H1T54M1ZFyZl5?=
 =?us-ascii?Q?LXHpMCuLqdD7mHEprFagZjrYGocDRdAHBUDK4IbYs6zt0Jsnnm87Tvokk7CY?=
 =?us-ascii?Q?/AGFXI9plgvyf3ML10BFWUUi2VeF92OrRulNBkyI45lvDhRDzNi/+eiY25t5?=
 =?us-ascii?Q?gh8ssyA0v6R3+/5OwcPhPf4h8plQ7tKNSV18Lk7bE72YYW/bJ4zjSgKoPH8R?=
 =?us-ascii?Q?SNAol4OJG6mq/MaAL8CD3kETt4oPDQhigu9xxtCM0Dh0uevjGduoBA5RmR0k?=
 =?us-ascii?Q?zbRE6ufWRHIK4S/e+y1CFyQacvEinWzoSzZ17pFHGG9gETVMNpzWrAZFp8Z6?=
 =?us-ascii?Q?pn7eHBwiXEoCldBh9MvUs28UUm/TIRVzD4qwQsLHH06SOXW72l2504srdYxF?=
 =?us-ascii?Q?WiiLW0SmdKJ+iB+0HJaVuaqvIZA7KXYNA0PRUGhS8MaPZwNAYV/BrKBCArxw?=
 =?us-ascii?Q?vFzaX4zCa5W2xTH9ayUsF+u5Lh3cS443VgxEa/urbCSAvePpvsDMUE6U45jl?=
 =?us-ascii?Q?wruEfgUTRJ4u9QJLsim/EjZw3LUElPI1i7Cxz0K6nUpVCoFYuwo7OGd8j2xJ?=
 =?us-ascii?Q?bAdNVMMP+UHDLUPICkyvDVv9537ppOr6xgeSdPHYu3RbVZVh4nH/pmch4u8Y?=
 =?us-ascii?Q?ly+dFQhXWM7aDn3T/IdSzRTmb8WvJoA5TGeCGTMDoQs8yWZPpWNNEFyl1Mnj?=
 =?us-ascii?Q?Be6Q+a6/2QEx/kPSailwXAmzKdDCHhiYdP7FLvFTje3HoHz9CRHqHth1tEMu?=
 =?us-ascii?Q?Fvw425Gr4ePWLTjfRkIgr2CGpP83q0M5/dpxVF9Hjo6B2lO9pSuBZ+9u//+z?=
 =?us-ascii?Q?2BR+67J/WUFGr50659Pv8sJ82UTRYVtaKNlYc9hTlBazPPNePEHyZaBjOChg?=
 =?us-ascii?Q?HtmBcn2lKYb/RHfpY60O3YvXS4DhXNq2OkJxaKM1I8sbXY8e9VKAa8UdCl7q?=
 =?us-ascii?Q?HT41fiVe6ynnUv18Psm2IK87U3H9QNwNH5gLS7KC9VcYKTV9arzga7uJ7DDL?=
 =?us-ascii?Q?cgB8ZznIbOVx5YSzIkFaKRm1PAmpDZJTUIxQ9A/FPsldV3fEYwqOtZ+LkDMn?=
 =?us-ascii?Q?5KZ6KDFB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bddf4a-7b4a-4628-9aeb-08d8c4009aba
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 02:50:15.1277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERbWkVFwAjTjgDYUr3kBmTScy0ER1/TQJl1HwQW8biwGiXZJpTNdBjWQh/AgVZ8NcDf0VV93GLRGv00cVYbzZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Enable RDMA service when platform has IOMMU ON. The handle of device
to DMA map is available only in dma_map() call context.

[How]
Update implementation get_pages() such that it only Pins memory of a
buffer object. Update implementation dma_map() to use the handle of
DMA device in building an sg_table off of the buffer object

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c | 47 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_rdma.c       | 26 +++++++-----
 2 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c b/drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c
index 6d7340b101ba..86b4ee710629 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c
@@ -54,7 +54,6 @@
 #include "kfd_priv.h"
 
 
-
 /* ----------------------- PeerDirect interface ------------------------------*/
 
 /*
@@ -281,6 +280,14 @@ static int amd_get_pages(unsigned long addr, size_t size, int write, int force,
 static int amd_dma_map(struct sg_table *sg_head, void *client_context,
 			struct device *dma_device, int dmasync, int *nmap)
 {
+	struct sg_table *sg_table_tmp;
+	struct kfd_bo *buf_obj;
+	struct kfd_dev *dev;
+	struct kgd_mem *mem;
+	uint64_t offset;
+	uint64_t length;
+	int ret;
+
 	/*
 	 * NOTE/TODO:
 	 * We could have potentially three cases for real memory
@@ -312,15 +319,33 @@ static int amd_dma_map(struct sg_table *sg_head, void *client_context,
 			mem_context->size);
 
 	if (!mem_context->p2p_info) {
-		pr_err("No sg table were allocated\n");
+		pr_err("Buffer was not pinned\n");
 		return -EINVAL;
 	}
 
+	/* Retrieve the handle of buffer object embedded in amd_p2p_info */
+	buf_obj = mem_context->p2p_info->priv;
+	mem = buf_obj->mem;
+	dev = buf_obj->dev;
+	offset = mem_context->va - buf_obj->it.start;
+	length = mem_context->p2p_info->size;
+
+	/* Build sg_table for buffer being exported, including DMA mapping */
+	ret = amdgpu_amdkfd_gpuvm_get_sg_table(dev->kgd, mem,
+			offset, length, &sg_table_tmp);
+	if (ret) {
+		pr_err("Building of sg_table failed\n");
+		return -EFAULT;
+	}
+
+	/* Maintain a copy of the handle to sg_table */
+	mem_context->p2p_info->pages = sg_table_tmp;
+
 	/* Copy information about previosly allocated sg_table */
-	*sg_head = *mem_context->p2p_info->pages;
+	*sg_head = *sg_table_tmp;
 
 	/* Return number of pages */
-	*nmap = mem_context->p2p_info->pages->nents;
+	*nmap = sg_table_tmp->nents;
 
 	return 0;
 }
@@ -328,6 +353,7 @@ static int amd_dma_map(struct sg_table *sg_head, void *client_context,
 static int amd_dma_unmap(struct sg_table *sg_head, void *client_context,
 			   struct device  *dma_device)
 {
+	struct sg_table *sg_table_tmp;
 	struct amd_mem_context *mem_context =
 		(struct amd_mem_context *)client_context;
 
@@ -339,6 +365,19 @@ static int amd_dma_unmap(struct sg_table *sg_head, void *client_context,
 			mem_context->va,
 			mem_context->size);
 
+	/* Determine if sg_table construction was successful */
+	if (!mem_context->p2p_info) {
+		pr_err("Buffer was not pinned\n");
+		return -EINVAL;
+	}
+
+	/* Free sg_table and its elements including DMA unmapping */
+	sg_table_tmp = mem_context->p2p_info->pages;
+	if (sg_table_tmp != NULL) {
+		mem_context->p2p_info->pages = NULL;
+		amdgpu_amdkfd_gpuvm_put_sg_table(sg_table_tmp);
+	}
+
 	/* Assume success */
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_rdma.c b/drivers/gpu/drm/amd/amdkfd/kfd_rdma.c
index ec6435aa33bd..67a9213a40b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_rdma.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_rdma.c
@@ -66,7 +66,6 @@ static int get_pages(uint64_t address, uint64_t length, struct pid *pid,
 {
 	struct kfd_bo *buf_obj;
 	struct kgd_mem *mem;
-	struct sg_table *sg_table_tmp;
 	struct kfd_dev *dev;
 	uint64_t last = address + length - 1;
 	uint64_t offset;
@@ -99,10 +98,9 @@ static int get_pages(uint64_t address, uint64_t length, struct pid *pid,
 	dev = buf_obj->dev;
 	offset = address - buf_obj->it.start;
 
-	ret = amdgpu_amdkfd_gpuvm_pin_get_sg_table(dev->kgd, mem,
-			offset, length, &sg_table_tmp);
+	ret = amdgpu_amdkfd_gpuvm_pin_bo(mem);
 	if (ret) {
-		pr_err("amdgpu_amdkfd_gpuvm_pin_get_sg_table failed.\n");
+		pr_err("Pinning of buffer failed.\n");
 		*amd_p2p_data = NULL;
 		goto free_mem;
 	}
@@ -111,7 +109,6 @@ static int get_pages(uint64_t address, uint64_t length, struct pid *pid,
 	rdma_cb_data->amd_p2p_data.size = length;
 	rdma_cb_data->amd_p2p_data.pid = pid;
 	rdma_cb_data->amd_p2p_data.priv = buf_obj;
-	rdma_cb_data->amd_p2p_data.pages = sg_table_tmp;
 	rdma_cb_data->amd_p2p_data.kfd_proc = p;
 
 	rdma_cb_data->free_callback = free_callback;
@@ -140,24 +137,33 @@ static int put_pages_helper(struct amd_p2p_info *p2p_data)
 {
 	struct kfd_bo *buf_obj;
 	struct kfd_dev *dev;
-	struct sg_table *sg_table_tmp;
 	struct rdma_cb *rdma_cb_data;
+	struct sg_table *sg_table_tmp;
 
 	if (!p2p_data) {
 		pr_err("amd_p2p_info pointer is invalid.\n");
 		return -EINVAL;
 	}
 
-	rdma_cb_data = container_of(p2p_data, struct rdma_cb, amd_p2p_data);
+	/* Determine if sg_table been released */
+	sg_table_tmp = p2p_data->pages;
+	if (sg_table_tmp != NULL) {
+		p2p_data->pages = NULL;
+		amdgpu_amdkfd_gpuvm_put_sg_table(sg_table_tmp);
+	}
 
+	/* Unpin pages of buffer object */
 	buf_obj = p2p_data->priv;
-	dev = buf_obj->dev;
-	sg_table_tmp = p2p_data->pages;
+	p2p_data->priv = NULL;
+	if (buf_obj != NULL)
+		amdgpu_amdkfd_gpuvm_unpin_bo(buf_obj->mem);
 
+	 /* Remove callback info from list of callback objects */
+	rdma_cb_data = container_of(p2p_data, struct rdma_cb, amd_p2p_data);
 	list_del(&rdma_cb_data->node);
 	kfree(rdma_cb_data);
 
-	amdgpu_amdkfd_gpuvm_unpin_put_sg_table(buf_obj->mem, sg_table_tmp);
+	dev = buf_obj->dev;
 	kfd_dec_compute_active(dev);
 
 	return 0;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
