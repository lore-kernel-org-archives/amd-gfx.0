Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6BAC25B4F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA82112409;
	Fri, 26 Apr 2024 13:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="legKSDIx";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69AC9112407
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW0yZHG77Q39r09FPlZa7/vgnL/Qq0zmrxdMF3TUsT025j4C4sRF5r1UVjE7WVTE0PegRSJ5TOgh17M6yZ6q88XkU66p41hCdjm05IYbP/I74QOg2hA2OFZrJpbkJVTnMlhYiIouKnrM4yV52pLJICSNoFV5DlwWqLXQjG/X5+rhyqT3cS/M0VN4ftG2NEn7dk0KqWoDUCn0Al6myHUVY3MyBOZHLbMwEEOEGMwDoZZnT04+ML96Rr4+kmMVp59FkqniLiARrVpIjlTKje2lG0YyeZuzOfMQ6W4Qp41zSghRPaphltZtBjPM/M2G6vzKUnFY/O6csX7sYX4kkeZ36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2gQ0frJatuJfMqYiDdCu/tjx80XLsv4qachY156iRI=;
 b=m3T8R5jJ8pBSq9AIwxu0tSMJJcFP4CktV8L38cmU1Z3eGzOeZXVBA/NKtf8Bi6gHvY5HR5tBV/k56jM1OCvzxDfLgVKmTWY+pAykWUlXjVHwEdbf2/OjCoX+rQ6wH5I+IKEVkK0ycBC4V86iIXKim/3VZFA06ZnzyW7NzS2PGl3g/HW/x88+F+R06ss46c9DbmFSGpm+SUUDSTu80X4du0oMJDpHor+t5PiMhdV9aFFPAxf9huSXhTe7BslYDv1Ib7uTwZSGVil7MSnWjqnXH0FDcJPadhMOkWiePKzXq4Q89DT9wHaupqaJGU967IBCAP8Pciq2tTAyaPukQwRmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2gQ0frJatuJfMqYiDdCu/tjx80XLsv4qachY156iRI=;
 b=legKSDIxoBBG6EYE8WxuIC12icDaDZy7+4vRaJNQWslJVeM/59xxcimbGhNqmJuqN5EGk5zLEBMpd7g8SkEkXdSn7XXtSC933dF+K/Ls7HMjFEuHacpXB85M51deDimUr2mz5RK/CTdeC1huKVGKPhWQvZaxlrQ7vPjP31leU98=
Received: from CH0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:610:cc::18)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 13:48:43 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::f0) by CH0PR03CA0073.outlook.office365.com
 (2603:10b6:610:cc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:43 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:41 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v9 04/14] drm/amdgpu: add helpers to create userqueue object
Date: Fri, 26 Apr 2024 15:48:00 +0200
Message-ID: <20240426134810.1250-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 92abca54-dae8-4bde-5195-08dc65f79658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?APGY0Zc6xDH/2niPpJ9Ab6t5mBFznBpU06nNLWEiFkr7bpomib3APk/BVJ8Q?=
 =?us-ascii?Q?KuIHUTUeTyi0zitnD2s8ib3+5hLABXXSgy7oigGiTCbFq/lREQ6bUmQypVR8?=
 =?us-ascii?Q?UHmJmoE/Ia6uA0F2rWeQ6/nRSZ5UMiO8iq/S62w/2rtfImDnxFCdGwKj/j8D?=
 =?us-ascii?Q?I6J3fjvLIrwSXWiPZLC0/cC03kWNklOVEE6ny+jlzaB9L5Bd0AxWUcNZR/Cj?=
 =?us-ascii?Q?h5bsx9ltFvEY28zizjb/TLY7PoqNXG6BFAKUTVCM7iMfwIdGmm6CD0jihNF7?=
 =?us-ascii?Q?1BuWTGyaZbLlyQU7UBes1wVJfYATe4qbc/ckFYvwqZ5Sl3n4KYSF3SsqOBG0?=
 =?us-ascii?Q?VOWudaVW7ET71ZNKz+czeMn0Cu3H64Q6JgkZVS1c0+mNyVdfxfnQBRAgZzvM?=
 =?us-ascii?Q?xSEWVRPPMZVUnolRV+Sowl6cvKD1b61bwdJUB7H+Y5UVZXocJ6JyCOgQSc1W?=
 =?us-ascii?Q?cWRgIka2zJAzAJJwKmF3J2yNA9hxULj+mGAbVNM4GKv+kRRAXEoCmWwPGQev?=
 =?us-ascii?Q?Cn+rHkhmqUst3L2wnn4+cjfPu+knhz2r24EMR7DD6zZ15WMTHCr3y8IqkRpz?=
 =?us-ascii?Q?Vks1CHkH9yphdLb3bKfHD5Wo/prpQOM++siN1SwyOykRyGCOhNVrccScCTs4?=
 =?us-ascii?Q?l/1G1pLPNecB0KLvxxiy+s4zxQa7hAHODA5lQl+ZR15xTP+ds3cxjq10rkAi?=
 =?us-ascii?Q?0VVF+a4n6Im//TR9QKIG/D9SYqpqikkLORYuU57A2jP7TwiebnqqoUht+TKG?=
 =?us-ascii?Q?bCZ85XcvK4S/mdi9KJNtmIYoX7jr/lMMUZzLIG0ky6xg74yGzzNL8F3LDMPU?=
 =?us-ascii?Q?12DSJXqdkiehTGmLt452l4crWZJGK5SHki3Wf8xja/keyJKdA8bOUrrm4e4A?=
 =?us-ascii?Q?2LLCrGRpetS1xSMeggG6QZmcR0DRQMa0vMSXpOG1z2iaWXzWFfxjfLi85DiD?=
 =?us-ascii?Q?GqFELqwM0ByjRiaAGXtjqnvLC/LRDGrdt7/Z29M0aJs17ihVTl8ofUfVEAKB?=
 =?us-ascii?Q?R1Hsj9ipivD6pjVSdzUadPiiGdJDoLUkLeDZyn0n2dbi8hWYD5j7a/keCTCL?=
 =?us-ascii?Q?2eySrz8ib/dWTrWTjoBd20nrTpDcl77+zM/8D2CGnYorRbhkT9Sr8I6cHDIU?=
 =?us-ascii?Q?u5DKks8f9XA1TZMUBhch1CNeGSxgcSFvsGNh2yqyBXV51Mf//AvDlgpUOq2/?=
 =?us-ascii?Q?EFCKHQNgb2/RcJHYRK0mUuLs2B1UgynjoEc2mzqXrcTdtHkjmAxN4KLwm2IC?=
 =?us-ascii?Q?e5+DPYpNq5fvDF5ONlwDbsQc938zS6SQu3cqjb9qcGGMCvEFZUx1PKadhifW?=
 =?us-ascii?Q?9O9fR3SKkiFZ4NdQJBfkTZRwKTphxZra4ov+4gbDFEWdXmXJEtHHt1HE9vAI?=
 =?us-ascii?Q?tXhRgKQgd9rrqpemJ9aVEWPqhn8l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:43.2371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92abca54-dae8-4bde-5195-08dc65f79658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
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

This patch introduces amdgpu_userqueue_object and its helper
functions to creates and destroy this object. The helper
functions creates/destroys a base amdgpu_bo, kmap/unmap it and
save the respective GPU and CPU addresses in the encapsulating
userqueue object.

These helpers will be used to create/destroy userqueue MQD, WPTR
and FW areas.

V7:
- Forked out this new patch from V11-gfx-userqueue patch to prevent
  that patch from growing very big.
- Using amdgpu_bo_create instead of amdgpu_bo_create_kernel in prep
  for eviction fences (Christian)

V9:
 - Rebase

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 62 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    | 13 ++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index df97b856f891..65cab0ad97a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -32,6 +32,68 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 	return idr_find(&uq_mgr->userq_idr, qid);
 }
 
+int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
+				   struct amdgpu_userq_obj *userq_obj,
+				   int size)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_bo_param bp;
+	int r;
+
+	memset(&bp, 0, sizeof(bp));
+	bp.byte_align = PAGE_SIZE;
+	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
+		   AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+	bp.type = ttm_bo_type_kernel;
+	bp.size = size;
+	bp.resv = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
+	r = amdgpu_bo_create(adev, &bp, &userq_obj->obj);
+	if (r) {
+		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
+		return r;
+	}
+
+	r = amdgpu_bo_reserve(userq_obj->obj, true);
+	if (r) {
+		DRM_ERROR("Failed to reserve BO to map (%d)", r);
+		goto free_obj;
+	}
+
+	r = amdgpu_ttm_alloc_gart(&(userq_obj->obj)->tbo);
+	if (r) {
+		DRM_ERROR("Failed to alloc GART for userqueue object (%d)", r);
+		goto unresv;
+	}
+
+	r = amdgpu_bo_kmap(userq_obj->obj, &userq_obj->cpu_ptr);
+	if (r) {
+		DRM_ERROR("Failed to map BO for userqueue (%d)", r);
+		goto unresv;
+	}
+
+	userq_obj->gpu_addr = amdgpu_bo_gpu_offset(userq_obj->obj);
+	amdgpu_bo_unreserve(userq_obj->obj);
+	memset(userq_obj->cpu_ptr, 0, size);
+	return 0;
+
+unresv:
+	amdgpu_bo_unreserve(userq_obj->obj);
+
+free_obj:
+	amdgpu_bo_unref(&userq_obj->obj);
+	return r;
+}
+
+void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
+				   struct amdgpu_userq_obj *userq_obj)
+{
+	amdgpu_bo_kunmap(userq_obj->obj);
+	amdgpu_bo_unref(&userq_obj->obj);
+}
+
 static int
 amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index b739274c72e1..bbd29f68b8d4 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -29,6 +29,12 @@
 
 struct amdgpu_mqd_prop;
 
+struct amdgpu_userq_obj {
+	void		 *cpu_ptr;
+	uint64_t	 gpu_addr;
+	struct amdgpu_bo *obj;
+};
+
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	uint64_t		doorbell_handle;
@@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
+	struct amdgpu_userq_obj mqd;
 };
 
 struct amdgpu_userq_funcs {
@@ -60,4 +67,10 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
+int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
+				   struct amdgpu_userq_obj *userq_obj,
+				   int size);
+
+void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
+				     struct amdgpu_userq_obj *userq_obj);
 #endif
-- 
2.43.2

