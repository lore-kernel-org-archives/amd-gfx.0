Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FC6C5B549
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 07:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C6310E7DF;
	Fri, 30 May 2025 07:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JcckCMjl";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E62C10E7F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 07:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRzogs4UI1iOvIrb/wiH2PCduOBCkRvlLfcPCv/s/ZoUpIU67M0Uolz6J08/tH6DVIOEApBnURcl0YoNwMU/DIfW9Fw4zeh8lM/2rHdnf8GNBx2cxS7SK6xwzvx7do5i9eyfBvu4fKBCZCfJ/xgPxvUuCwsY+L7ze2dD0cPgsVgL3VJezNc8vLrpKNw4o1Gpa8klOPtTP969KRCDhSsV5XgtDIZq36zik8lNttHrwIDJkEuKqvdLXjbmSgtdUYmyzMJ8RkRl9lNP4hA36x2eOTPeBsQp1xJNdMB+s2gXYzb7m3VCeT2ZX0k4NrrrdTChCVW35HsIdlEOrdn5m2dB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDie3mbtWCUHm00XKJ6QQ+perA2+ljuydTe+ymKUJ0I=;
 b=uZxtGHQcBP6ZosN5683vuLyWtot0mSjGNmeMMa54dFem1RWZrrQMFH+kJpmg2Uju7V7L+WU45DR5pwYBCu6u/KheUNebfMePsQFW5AZ3wxfy0oHgjT5QrYCXk+l/N4ToVFzr46NKp//J/aglsfQPktqnWCy1on3KOOwJ76UYKkYc0O44B1OEK0F09P1kHgA9oaPBMa+c8PBZPHsrr2IqlU4SNRoThWcEorllLYnOswcyH95163q6eOnDH9xCzRCKEylYgwDFfihuYU8VBtpQHdspvi/ae9NtH1y47kIASOs5As6f6weCT6IthPeYoApaJT2CwQv8fHGj6iuAVozbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDie3mbtWCUHm00XKJ6QQ+perA2+ljuydTe+ymKUJ0I=;
 b=JcckCMjlaHo9yYNkNOqharHnu2rNRnPLlCpTYWR9UkpFwHyOD1SxYeGnkIfgOtyoq7EjMdHHRUt4DCv8Ww0NSV93pQqlapLeShJvwu8nq+Byxk9caEnBZSo46wk27hob8ga1bfddD9tFgnOW8HGWLah5P9BSXImzySgBLWAnNAM=
Received: from MW3PR06CA0008.namprd06.prod.outlook.com (2603:10b6:303:2a::13)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.33; Fri, 30 May
 2025 07:55:27 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::1b) by MW3PR06CA0008.outlook.office365.com
 (2603:10b6:303:2a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Fri,
 30 May 2025 07:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 07:55:25 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 02:55:22 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 5/9] drm/amdgpu: add userq object va track helpers
Date: Fri, 30 May 2025 15:55:01 +0800
Message-ID: <20250530075505.882004-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530075505.882004-1-Prike.Liang@amd.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab30002-9e0d-4e1e-aae0-08dd9f4f562b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LpVBquUgg8F2pzJV7bIfz1zO2h2seL1S3sd3w0nK/4KgXXudv2p6avHTk0Zh?=
 =?us-ascii?Q?PRKzjrxM/nzVDgS9GDsCA5UX07n5EF94LPTAwUcBBYk2tGqt6T9gcolN4A8T?=
 =?us-ascii?Q?2l8RAvISAxQNQ0ORjof7q/G3LbjaxKJ5fP4izG2MTgHEJF5FWnsElezWEajM?=
 =?us-ascii?Q?kH4xHzNHX2TG6w5Iz1ZA7tbkzz19wcs4vxCDqAWttJEQyfK2tKRX/NCXzcZL?=
 =?us-ascii?Q?iT4VsOBNIXM+e3YzRI+ShGfMZRhHbij1A6j7TjAbsCKQkmN2jR2Er+C0Brig?=
 =?us-ascii?Q?1qTlgliVexeCfjS7MpglhT1TWWF56LIKB3YA2oeq2eTjFb/DrOq7JoUceywx?=
 =?us-ascii?Q?8hGxoqw34YtXGH0O5Q0xqT858//HXgZV8qC46omgUXJaXpKS6KdAa1wg5CW2?=
 =?us-ascii?Q?ciM9I0+AwySipgeL8exzRY43brsobeCEF2AYERRTbebFQk9vFULyg0NyGw7l?=
 =?us-ascii?Q?heQutsWcJkd+Ks02En5F5whqD+EhMHxrkBBLLrBcw5K8o6jxiV37PDp4Hsnb?=
 =?us-ascii?Q?trnAr4JV9G7raVuOkbetOXLl4no9tRnpxDIfMyHRvNdejoHIySfH55uCicDA?=
 =?us-ascii?Q?JLm0Gk/sEeQJe6LObAOhufDJK6IZ9Dtx3R6uZH9AmWEkwkXveDW2diNFPG9X?=
 =?us-ascii?Q?MUJH77UrR+R7jePC76XNnMPbTqbcFITTlZYWpBEZKkIsadUbCMjWsbXw6pRg?=
 =?us-ascii?Q?aUmizwfEQ11/gU2O30ZXHQrHiP/Ix/23kGX2/h8BYSReg1S55kA3cJnLyH/q?=
 =?us-ascii?Q?mHruERbIKLhZ2i7hJi2hakKPNpIMPLVKmz8kHnrU9W22CJXXAAILmlUEHH+1?=
 =?us-ascii?Q?QdXseZicKmr4oiDYTutD4L1dvigVc7+zyn+8tkGaBLNRgRvrsnK574dr8/jC?=
 =?us-ascii?Q?ae/TuNH8obCZHJFovVUlrWTGCueQZ6o3O3ew/9JXKBwWKEqodhpgEBJ1M/Gb?=
 =?us-ascii?Q?98uJ6PBjLCmsj7jtuPppUIbd9qjP30IYHmcEiCfvXtQ8LeWKJR8QAJ4xKN/k?=
 =?us-ascii?Q?FNHpIY4Le10Rd84YHtcPIYyazX417fTAfYIHL5NeviMhdBXqmVzJ/hAeoOI3?=
 =?us-ascii?Q?/b99nKKmUfH38UFaozRX7+OpKhnXYc1oF33Hy9EHo4KtqlgI9BNOaTOLpcTV?=
 =?us-ascii?Q?cQq1LoPDsRT3pMNyMg+cH3eX1MWoAzOnXosX4n/vo7qGc/nlIJUA3EdJoZY+?=
 =?us-ascii?Q?3ilQs9vMgE+Sut2XEMHYwtXwiNL3T1QHDEaFSc5KygFwlVA3GcboRq0aW5W9?=
 =?us-ascii?Q?k1pHgVki1GUhuAxRVShgx9svQol354Hmkhu2XZG6TcvjU5HhycfXzTYGc58W?=
 =?us-ascii?Q?TteAurLhCegTBE6sYd1aU0F3WMrJTXQXpsuV/TBA7F/GlFI4/N98QaUFH5Wi?=
 =?us-ascii?Q?Q0QaFvej5yh9ag9ceRo1V8Rcvzc9haSLmeRALZCJ81e3TEdOvtP9if+J2Oxh?=
 =?us-ascii?Q?HODfmPxP+SL6NT+sqV4wnQFWtaVnNyB2P+SRERDOY7oa1XoJNFlMFFvygBnX?=
 =?us-ascii?Q?tFzZTkZZmt646++efcvEzIB9XixmdkYUXueC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:55:25.1914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab30002-9e0d-4e1e-aae0-08dd9f4f562b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
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

Add the userq object virtual address get(),mapped() and put()
helpers for tracking the userq obj va address usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 120 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  11 ++
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 32e88064bdea..3854b1696d4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -79,6 +79,122 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	return -EINVAL;
 }
 
+int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	int r;
+
+	addr &= AMDGPU_GMC_HOLE_MASK;
+	user_addr = ALIGN_DOWN(addr >> AMDGPU_GPU_PAGE_SHIFT, 0x100);
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!mapping)
+		goto out_err;
+
+	/*
+	 * Need to unify the following userq va reference.
+	 *  mqd  bo
+	 *  rptr bo
+	 *  wptr bo
+	 *  eop  bo
+	 *  doorbell bo
+	 */
+	//amdgpu_bo_ref(mapping->bo_va->base.bo);
+	mapping->bo_va->queue_refcount++;
+
+	amdgpu_bo_unreserve(vm->root.bo);
+	return 0;
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return -EINVAL;
+}
+
+bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	bool r;
+
+	addr &= AMDGPU_GMC_HOLE_MASK;
+	user_addr = ALIGN_DOWN(addr >> AMDGPU_GPU_PAGE_SHIFT, 0x100);
+
+	if (amdgpu_bo_reserve(vm->root.bo, false))
+		return false;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va->queue_refcount > 0)
+		r = true;
+	else
+		r = false;
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+}
+
+bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue)
+{
+
+	if (amdgpu_userq_buffer_va_mapped(vm, queue->doorbell_handle) ||
+		amdgpu_userq_buffer_va_mapped(vm, queue->queue_va) ||
+		amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
+		amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va))
+		return true;
+	else
+		return false;
+}
+
+int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	int r;
+
+	addr &= AMDGPU_GMC_HOLE_MASK;
+	user_addr = ALIGN_DOWN(addr >> AMDGPU_GPU_PAGE_SHIFT, 0x100);
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!mapping)
+		goto out_err;
+	/*
+	 * As the GEM userq bo will be unmapped by amdgpu_vm_bo_unmap() which is
+	 * invoked before userq is destroyed. So if we want to reference/dereference
+	 * the userq vm bo, then ensure the userq vm bo dereferenced  before
+	 * amdgpu_vm_bo_unmap() or fallback to unmap the userq vm bo at amdgpu_userq_destroy().
+	 */
+	//amdgpu_bo_unref(&mapping->bo_va->base.bo);
+
+	mapping->bo_va->queue_refcount--;
+
+	amdgpu_bo_unreserve(vm->root.bo);
+	return 0;
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return -EINVAL;
+}
+
+int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue)
+{
+	amdgpu_userq_buffer_va_put(vm, queue->doorbell_handle);
+	amdgpu_userq_buffer_va_put(vm, queue->queue_va);
+	amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
+	amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
+
+	return 0;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -451,6 +567,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->queue_va = args->in.queue_va;
+	queue->rptr_va = args->in.rptr_va;
+	queue->wptr_va = args->in.wptr_va;
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -481,7 +600,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 375fba639c94..65f9bd91ac73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -52,6 +52,10 @@ struct amdgpu_usermode_queue {
 	enum amdgpu_userq_state state;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
+	uint64_t		queue_va;
+	uint64_t		rptr_va;
+	uint64_t		wptr_va;
+
 	uint64_t		flags;
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
@@ -134,4 +138,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 
 int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 					u64 expected_size);
+int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr);
+bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
+bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
+int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue);
 #endif
-- 
2.34.1

