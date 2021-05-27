Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED9DC4708B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 14:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAAE611AE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 14:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAAE611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735AF6F3F7;
	Thu, 27 May 2021 14:54:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBFF46F3FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 14:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjTZVCo2SQI7AqWSZ2Vfbn5KOh6kJAXiPBppCAF2F4gjMzORYcEGPeChdiDczceeCXQoz2eACdB2Try9LM/K946KvxOdXAZmreJWOh0E7/PQDdgX+QbB9+RSha02TBOH6QQ0YfZINc0QpYp44VruHcuya+udl0ZIrtcqxqXWhcviWTdUxG3bdtE9ZeHtga8ArqBKowjv6hly4zWqAw/lTf8pGVYVJURAgjwcT3QYQ2NaUCn4S9zkiAyikmNzqd6n0ergzwvLi0GCephJzvbmzufQpGzOI1lAtxya40iF2GFniRDXDB10dU8vjJtG6bXOZf5CPhqxNpyoVwldbz3nDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WRumpFselNp5N9hvNvRngx+6yMV+mcy3RlH9jtLYwk=;
 b=OMcsJvbaMiuSLHG+IHe579hqSgdqyD7OtvctRa4ixh/s5O5FFbhn717QVhzLgXvb+g2PXZ/qtG6zjnZERZp536HZgUmDsOykgPboOKfp0+jPOQepWnY93vivvkkvFQfmsXJPFFC8qYTZmIt3DAUSOjdccKwxfCXErNBnOHtEHre8KfDWMmaNEhze2Cv9hqSAVnD+WR+AqOMFPLqooNY7W/18htlqvKmjr61n0+1i57Yw2vM0/YpOjGv5EqQYVniRqKmAS/nK76el8dVaQ6d9un1Ji/HkDjBVmRdJK8cggU10WUy1HsYJUY2fAdzsNuC0GMRCUAPo5rTKqK1fCKKo8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WRumpFselNp5N9hvNvRngx+6yMV+mcy3RlH9jtLYwk=;
 b=3fQQ0UH6DbihXJngN9Ri/V94dBwO+r9aYHLJJYEYHx7eD6SF+SE8x5/sWiT+/naSabuyxU5p4EjuX4UQ5+nmRuttpS6TI9H17eYMm+8x3TuZAWvcx7dxzQcx47apCLfdNQM3SKhTHCiz9VOad3o4e714jizxo8PFdlnDGcm5flk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 14:54:44 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 14:54:44 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: convert gtt_window_lock to a spinlock
Date: Thu, 27 May 2021 16:54:25 +0200
Message-Id: <20210527145425.18161-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.111.109]
X-ClientProxiedBy: PR3P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::33) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.111.109) by
 PR3P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 14:54:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1cf94bb-450d-48aa-cc35-08d9211f5d46
X-MS-TrafficTypeDiagnostic: DM4PR12MB5263:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5263DC21B4C31FF87B83A19C8B239@DM4PR12MB5263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JE/SrAsaZw1WSgPvNc+Bt1JI50se8zs8XfGK1u3VeFwLrPeGzwhfhB3b7Tm53iovDd/Zm69NSvHsIA5wEk5BwlxUwQLNVKJEO72O7u6SJ1zeHoxGTIli4iPSnwa9rF+wz0P5k8zkFZSJY5umEvYvqjvukgHNM0/B59EfxSo0UrjOcRYzNN8N7VPMU3y5FTOnYb7fupYmAuS/wFMC9l7ciZ38mAmcc/7Y2quZoLQEWkEnC2pnRUGCwaWqN535nrv7EmO0jnbQLeHEA/o2ULJ5ZpcVziqncA9cMlTQ/tRXVVdp0WlUXhshSnO+sC6n69utnBnjRPa5yZ0HVaTeXpK1KRuqxQuC6E8/UYhXpxbSziUuWf5/Z+jWfbWgJsC00Y9uW3jLURre+Ng8rDvuX3XJS9HFfvEMBU6/VyVwCwm2HVhiX5PzGuDhsWu1ccnhH8v5+UWjvWfWQ5IntwTqOfnDst4ZvmnomIkY1qWhAJbaDozTEab+NFisb4oFmTxRGEtryolH4G8TS7hNRDOslCJMOvv2xawD2/C2hqyHhgooLlEc5r8CEeoYDbr/kQLeS/0z5xvaTXVT52rRlZZYH6TXcn+LqfPL74q9AY/+PMoT6uaMBv55pn3q1C5SSx2qx25UQqAi+jlyREctZYu43IJ/t1oQnUP3NJslNsLf4wnHHYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(6512007)(26005)(44832011)(83380400001)(186003)(16526019)(2906002)(86362001)(38350700002)(38100700002)(8936002)(8676002)(4326008)(6506007)(6486002)(52116002)(6666004)(66556008)(66476007)(66946007)(316002)(1076003)(2616005)(956004)(5660300002)(6916009)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ji1iFtXA5RyP8WoHIsIOhfm8lLHOusTRbxCJsIX6KGk1bWFJDKhwT5SE9hZc?=
 =?us-ascii?Q?fjNI0xo74GK5z0y11M0J7LZ8OPTrmCuKJCY59vIF5Wkk0+EApyXFrFlgtXXn?=
 =?us-ascii?Q?EMouXgC6aylpTL7NPwruMiAKGILmWf7cw7hJEjA39xb5pA8YpWP+sfOsw26J?=
 =?us-ascii?Q?x5d0wU2h8UUl/DEezggADOH5AF4j52sNZs4NJS3qllvzEvwJYtxkr93+gysj?=
 =?us-ascii?Q?5TqwXSOq+s9jfmTp6pFolce94QfRg6Y4tk1SB5DpBHxph7yJqYpEeJaDH/5y?=
 =?us-ascii?Q?ICi8xEBMqycfspggKr8+qdS2O9frcgeSZov+vmi5FFCy9LsU3A9esoYenloc?=
 =?us-ascii?Q?r72Ztec3NIlCio2vFC+55uCe8pXNCWn2E/48J9iHCyDR2iAb7iId9JRo+il6?=
 =?us-ascii?Q?y4041Gp3wwgJfhRUGsDVZx+lQbbqhP4J6BBfQw7XMTj17DECtq+J2HFeWEOJ?=
 =?us-ascii?Q?ZOSKqZfxRZ8o310d8JKf7FaJJTh/KiUXrJti9b7Xsots5URaB3+aDJh+FY44?=
 =?us-ascii?Q?exP3CmgFxDzvBSZB6B9qEib/wt+TxcyP1lo02nQNqsTY4CYVXcVqWFnomOeV?=
 =?us-ascii?Q?zIPKN0r6jbZFdzC4bV715ks1K295XRAv/FNJNuK4B0fJ5B1OCkaWwFrukluX?=
 =?us-ascii?Q?U7uuAJK+TiyIpqtkt4Bc0NYwwZhmFTgny+3lc/IwL+zhV2nyhglJ3MwKpZ0U?=
 =?us-ascii?Q?AXXefoNbSnjVZTN+hm4f1rrkjOp+hAZBiInpU1fbT7Y1f4+ouuvCmLinfySw?=
 =?us-ascii?Q?Z7WxEJNffXRnbf4Na3IgTXGcrzULpjB90PnOjgVw8hkr5Ypd8N44Siq9AatA?=
 =?us-ascii?Q?a/+he+zf6C1gxyOgGaD309pvsTPgeVFBFuxk0gToM26hrxO8yZHzSLokpejO?=
 =?us-ascii?Q?4F79VeBV6Ua0wodr7CsyuOlnjnv3MallDQpPnYTjSGMKaKKDKsZQnTKKL90C?=
 =?us-ascii?Q?UyuEuFWmNPCv1pu/tte5q3x3lAikcVBKXM8iJ5CDRJOS82tKod7jPZUysqdV?=
 =?us-ascii?Q?kpkt8TvtQZIQAvc3Zt8yGItrPyAoOm3sRkwID7yEfOPy0vKZZWGSlEpDuXUq?=
 =?us-ascii?Q?xB8YZTL+D0VfPY4jYJQ/hX9bJpMWRxD6VW6YtMf5JqkyuhAusd9cAw/o9fzm?=
 =?us-ascii?Q?0ciC3LNrDw7rRMAV2ejAmfp4xyK5Izi5TxTJ6GsKzfUxyb0angM9zV/b+TYM?=
 =?us-ascii?Q?gKe4Kiu+nXDOKuoSL2mUZJNerGOb8Bwimyoa46NtnS+ThThDvq5ukbGQeUVf?=
 =?us-ascii?Q?Tml3xZ6dEWfPctVySdgcCaplnWWwwZ125UyT/V2TR6EAoxw4tkbqkxnm5cs7?=
 =?us-ascii?Q?jDXxBfZTBkqZOaTbQ5y/d0cD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cf94bb-450d-48aa-cc35-08d9211f5d46
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 14:54:44.3135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NwxXcl6pojKu+nyS3DpqoCZi2/dl4ioUrmmn7znOSj2yI7wLR+6R77MXDN57eF+27ekpPJoYQgD7MUn5Lpo9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_device_gpu_recover() will eventually call
gmc_v10_0_flush_gpu_tlb() with holding a spinlock, which
puts the process in atomic context. Sleeping in atomic context
is not allowed so convert gtt_window_lock into a spinlock.

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2662, name: cat
Call Trace:
 dump_stack+0x8b/0xb0
 ___might_sleep.cold+0xb6/0xc6
 ? gmc_v10_0_flush_gpu_tlb+0x72/0x2c0 [amdgpu]
 __mutex_lock+0x45/0x820
 ? amdgpu_device_skip_hw_access+0x3e/0x70 [amdgpu]
 gmc_v10_0_flush_gpu_tlb+0x72/0x2c0 [amdgpu]
 ? amdgpu_device_skip_hw_access+0x3e/0x70 [amdgpu]
 amdgpu_gart_bind+0x7a/0xc0 [amdgpu]
 amdgpu_ttm_gart_bind+0x7d/0xd0 [amdgpu]
 ? amdgpu_ttm_recover_gart+0x2e/0x70 [amdgpu]
 amdgpu_gtt_mgr_recover+0x4e/0x70 [amdgpu]
 amdgpu_do_asic_reset.cold+0x90/0x1c4 [amdgpu]
 ? amdgpu_device_pre_asic_reset+0xa8/0x250 [amdgpu]
 amdgpu_device_gpu_recover.cold+0x7bd/0xa23 [amdgpu]
 ? lock_acquired+0x210/0x390
 gpu_recover_get+0x29/0x60 [amdgpu]
 simple_attr_read+0x69/0xf0
 debugfs_attr_read+0x40/0x60
 full_proxy_read+0x56/0x80
 vfs_read+0xd1/0x1d0
 ksys_read+0x68/0xe0
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 10 +++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c0aef327292a..4cb8fd193b6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -333,7 +333,7 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 	amdgpu_res_first(src->mem, src->offset, size, &src_mm);
 	amdgpu_res_first(dst->mem, dst->offset, size, &dst_mm);
 
-	mutex_lock(&adev->mman.gtt_window_lock);
+	spin_lock(&adev->mman.gtt_window_lock);
 	while (src_mm.remaining) {
 		uint32_t src_page_offset = src_mm.start & ~PAGE_MASK;
 		uint32_t dst_page_offset = dst_mm.start & ~PAGE_MASK;
@@ -373,7 +373,7 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 		amdgpu_res_next(&dst_mm, cur_size);
 	}
 error:
-	mutex_unlock(&adev->mman.gtt_window_lock);
+	spin_unlock(&adev->mman.gtt_window_lock);
 	if (f)
 		*f = dma_fence_get(fence);
 	dma_fence_put(fence);
@@ -1661,7 +1661,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	int r;
 	u64 vis_vram_limit;
 
-	mutex_init(&adev->mman.gtt_window_lock);
+	spin_lock_init(&adev->mman.gtt_window_lock);
 
 	/* No others user of address space so set it to 0 */
 	r = ttm_device_init(&adev->mman.bdev, &amdgpu_bo_driver, adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2877a924086f..afd905dc337b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -70,7 +70,7 @@ struct amdgpu_mman {
 	struct amdgpu_ring			*buffer_funcs_ring;
 	bool					buffer_funcs_enabled;
 
-	struct mutex				gtt_window_lock;
+	spinlock_t				gtt_window_lock;
 	/* Scheduler entity for buffer moves */
 	struct drm_sched_entity			entity;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ceab5ef50790..f4ce3eb4d7e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -341,11 +341,11 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
-	mutex_lock(&adev->mman.gtt_window_lock);
+	spin_lock(&adev->mman.gtt_window_lock);
 
 	if (vmhub == AMDGPU_MMHUB_0) {
 		gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB_0, 0);
-		mutex_unlock(&adev->mman.gtt_window_lock);
+		spin_unlock(&adev->mman.gtt_window_lock);
 		return;
 	}
 
@@ -356,7 +356,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	    amdgpu_in_reset(adev) ||
 	    ring->sched.ready == false) {
 		gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB_0, 0);
-		mutex_unlock(&adev->mman.gtt_window_lock);
+		spin_unlock(&adev->mman.gtt_window_lock);
 		return;
 	}
 
@@ -379,7 +379,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if (r)
 		goto error_submit;
 
-	mutex_unlock(&adev->mman.gtt_window_lock);
+	spin_unlock(&adev->mman.gtt_window_lock);
 
 	dma_fence_wait(fence, false);
 	dma_fence_put(fence);
@@ -390,7 +390,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	amdgpu_job_free(job);
 
 error_alloc:
-	mutex_unlock(&adev->mman.gtt_window_lock);
+	spin_unlock(&adev->mman.gtt_window_lock);
 	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index fd8f544f0de2..e1dad02d400b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -135,7 +135,7 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
 	uint64_t size;
 	int r;
 
-	mutex_lock(&adev->mman.gtt_window_lock);
+	spin_lock(&adev->mman.gtt_window_lock);
 
 	while (npages) {
 		size = min(GTT_MAX_PAGES, npages);
@@ -171,7 +171,7 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
 	}
 
 out_unlock:
-	mutex_unlock(&adev->mman.gtt_window_lock);
+	spin_unlock(&adev->mman.gtt_window_lock);
 
 	return r;
 }
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
