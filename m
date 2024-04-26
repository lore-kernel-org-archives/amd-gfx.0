Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A243C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0FB11240E;
	Fri, 26 Apr 2024 13:48:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mwdSUKcj";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4085911240B
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjW/OW3UUuKYXSUim7gT2iuJ2gkUv6pOJ2wfMpv8niJpkT9ZUwf+5JCHFrR+bZhlS7IA8SQdQB+qWSXaQ0vnGNQeb7W9MOb3OV46V91cDbG9fmlUj0cmlP7TzNuCZt8DcBJ38CtHVOX1SoeNAc7JpJPlJ15ukYXeEKszURLAagdE9wiElQC6k8y51Zsj6KTTNHw9JZoV1AN1SIruHTqPeV4zPEE8QaG+JwId5edvdW3ysBUDHu8BkBri7rLw0XJyf0bfhQxkT2aTysksmuv8/5vENoCwY6gTumbyDnxHyYorTRlzrSy4CDfGiUS5nHbZz6ZCTpggg70vHAc3wQpaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxoqzYHkKmb7LmsuH6wqzJr2VsnuVGYUGn41PdhoK7o=;
 b=gn9FL/tYVavySFewH/p74x45a3Jhd70GotTT91+laFLu55Uu1nrSPMGFCk+C+iyzYdPMVGAg80Rt0EbtM30yG9TOsi5itQMFVI2L3x3Ytjfprm8iURgZogO1wj6dX6ApvS3KpEIWnC+Z09YziDGOp3boz2DPsXKeAipGMIWbgeYy2QPwBRjLRmTfV8BIMEcwTqxOg6vx/mysblqDmppP4cLbebccgUZwi+qRCJOSnibwNxknu/ZhbgS3A9npEo4zs/BYYJ3nG6Rugq8siQnhjuL1mkzdeTr5hW/EQDKzgE8o8HKXdSYqhTpEVAMeMBO1k9Or/qXeo4qlgvzoSULVDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxoqzYHkKmb7LmsuH6wqzJr2VsnuVGYUGn41PdhoK7o=;
 b=mwdSUKcjXSYvBbM+heNGWHMn5u+B+afz6QiPyiaTDTpmSUDKd2lpiNEtWY0WFbDxxIV0Bfr/gmBKfKs+123POhoSIUnjZHgWA1eP38UUO8emn5CZRigc7wet0NSKFt1SnGELR8vZn5cxWvy8QtSJbem/GfRX0ert5+ZYTVrWMgA=
Received: from DM6PR08CA0007.namprd08.prod.outlook.com (2603:10b6:5:80::20) by
 PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 13:48:49 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::ee) by DM6PR08CA0007.outlook.office365.com
 (2603:10b6:5:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:49 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:47 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v9 08/14] drm/amdgpu: map wptr BO into GART
Date: Fri, 26 Apr 2024 15:48:04 +0200
Message-ID: <20240426134810.1250-9-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: b66c7627-06cb-4586-a325-08dc65f799fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?agnNeKeN2477bMjZ/tctiwjU6qQLhsI8cBUzLVHdDbxE3EV1kQ5U5a7cl99s?=
 =?us-ascii?Q?XbK2U+wtY1IMeK35KcgQOUfUGqJItLrpU39XlhWwLk1kXbwsc0ca/vwzXpX2?=
 =?us-ascii?Q?HlW0gxrfk3kni2hMdPlE7pa6vA8vbTF7f0R3+2umEQhNOb0ZepJFNs93c/m4?=
 =?us-ascii?Q?HeS0hlLR5p1auHbKU9Aky0CKqwHBIfixjA6Xo4h5FWpXxoioQmnTP1RZMenc?=
 =?us-ascii?Q?nXQOn6sy6DX6IdkLt2qEIk0mLIYJdNFKwgfBi+K5SHjRqF0EJWtoCW0ea+eW?=
 =?us-ascii?Q?C7ePMbMYamNuWNzjFYY2j4HHoIaKxwGMQngErP4bFAqwS6ljLBFv3vos/H1G?=
 =?us-ascii?Q?ztSY9ra9YreRW4brofNk2ss8C1Hy/GHOYk71TI7pEjMkLay47JKsmIfYpJwU?=
 =?us-ascii?Q?c1yzFvucT3ot42Id0mGFUTnusV9cEuoWm7LCEHMvqvFLW19wC/UEa4Gm4+f1?=
 =?us-ascii?Q?oC4tNG5jURJcEEyT+1BpR/vKOed55Gy8s+TNjYEERwaHxmV1hGU8HN7cdGa0?=
 =?us-ascii?Q?psptubO4uuymkepJdoSEpxZn5KBE7tEI1zc0t8BOZPKqs5ESTwlh31443met?=
 =?us-ascii?Q?KgFHT0uYwcYtVfStSDgRLR2QjVYSfmCdZ4KnIP7g1f/vq9SSPgn4e515F/N4?=
 =?us-ascii?Q?UL+abi5W+WMsL8PnmCjTGkgl+3Q2M+umETZUWJbNVauTENA/BDkgOeQ25WD8?=
 =?us-ascii?Q?Dhr7BcjwteBDKW+8Nx1At7N3ZlJTViqmEjuJA/NkMwXg/w5dJgzHJ5z6PjzE?=
 =?us-ascii?Q?rP1NKS2Y8PDU2CRuthP/22fhwBmW3SjVCdhv314ZetmmxTsJVypdWc0CW0bB?=
 =?us-ascii?Q?BZ5gfBnKFdCUp59Z8ZIJgoK/TmIMvC4RgCRztpVctyYBD3Qgy0f8qgmvlHaH?=
 =?us-ascii?Q?Jyf0XMIHirBg8iPCBja4Vspm6Y4KojJqnh0+4G9PuVVUl4ulsZeESlELKQNq?=
 =?us-ascii?Q?/xo/pUPlGIGAD4hDn496byj+7NXI2koYlzO0+KUGJ4iLxdJ0mu2YqKcm0PgB?=
 =?us-ascii?Q?7NJgeZTZZgPzpbA6PWqj70kZ83qcFUHirEIhNlShwRiiDaI4jRqoL0XpWnE0?=
 =?us-ascii?Q?SMOHRNFsTWX4eydo60FqXA8Gz4e0XjIyaZmuvPWUlggjOJoc9U/RIDIY7V3R?=
 =?us-ascii?Q?o5uxW557rCZD4nOi+XyLR+fWlFO/007SBp+0Ib/3KNrgbdFgt4o0ngxhnipl?=
 =?us-ascii?Q?731R8MYEcihihVZca6E7afLPYhfs98m4vJo6LabNXoPySvV5ag6NKzNo/ANh?=
 =?us-ascii?Q?P0X41QTt9hDRauxzg1snZB3MxdvFYF1CK0Bw97TQcz4HITS4MOIlWe2RsZRH?=
 =?us-ascii?Q?4YG4jIhST2jhV8pukfGEdrUTgzC33WtXy2dS5f6eXH2y2t3v2BmgOTfGaYPS?=
 =?us-ascii?Q?JZd7JYM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:49.3603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b66c7627-06cb-4586-a325-08dc65f799fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816
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

To support oversubscription, MES FW expects WPTR BOs to
be mapped into GART, before they are submitted to usermode
queues. This patch adds a function for the same.

V4: fix the wptr value before mapping lookup (Bas, Christian).

V5: Addressed review comments from Christian:
    - Either pin object or allocate from GART, but not both.
    - All the handling must be done with the VM locks held.

V7: Addressed review comments from Christian:
    - Do not take vm->eviction_lock
    - Use amdgpu_bo_gpu_offset to get the wptr_bo GPU offset

V8: Rebase
V9: Changed the function names from gfx_v11* to mes_v11*

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 77 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 2 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index 8d2cd61af26b..37b80626e792 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -30,6 +30,74 @@
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
 
+static int
+mes_v11_0_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+{
+	int ret;
+
+	ret = amdgpu_bo_reserve(bo, true);
+	if (ret) {
+		DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
+		goto err_reserve_bo_failed;
+	}
+
+	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
+	if (ret) {
+		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
+		goto err_map_bo_gart_failed;
+	}
+
+	amdgpu_bo_unreserve(bo);
+	bo = amdgpu_bo_ref(bo);
+
+	return 0;
+
+err_map_bo_gart_failed:
+	amdgpu_bo_unreserve(bo);
+err_reserve_bo_failed:
+	return ret;
+}
+
+static int
+mes_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
+			      struct amdgpu_usermode_queue *queue,
+			      uint64_t wptr)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_bo_va_mapping *wptr_mapping;
+	struct amdgpu_vm *wptr_vm;
+	struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
+	int ret;
+
+	wptr_vm = queue->vm;
+	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
+	if (ret)
+		return ret;
+
+	wptr &= AMDGPU_GMC_HOLE_MASK;
+	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
+	amdgpu_bo_unreserve(wptr_vm->root.bo);
+	if (!wptr_mapping) {
+		DRM_ERROR("Failed to lookup wptr bo\n");
+		return -EINVAL;
+	}
+
+	wptr_obj->obj = wptr_mapping->bo_va->base.bo;
+	if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
+		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
+		return -EINVAL;
+	}
+
+	ret = mes_v11_0_map_gtt_bo_to_gart(adev, wptr_obj->obj);
+	if (ret) {
+		DRM_ERROR("Failed to map wptr bo to GART\n");
+		return ret;
+	}
+
+	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
+	return 0;
+}
+
 static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 			       struct amdgpu_usermode_queue *queue,
 			       struct amdgpu_mqd_prop *userq_props)
@@ -61,6 +129,7 @@ static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 	queue_input.queue_size = userq_props->queue_size >> 2;
 	queue_input.doorbell_offset = userq_props->doorbell_index;
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
@@ -187,6 +256,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	/* FW expects WPTR BOs to be mapped into GART */
+	r = mes_v11_0_create_wptr_mapping(uq_mgr, queue, userq_props->wptr_gpu_addr);
+	if (r) {
+		DRM_ERROR("Failed to create WPTR mapping\n");
+		goto free_ctx;
+	}
+
 	/* Map userqueue into FW using MES */
 	r = mes_v11_0_userq_map(uq_mgr, queue, userq_props);
 	if (r) {
@@ -216,6 +292,7 @@ mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 			    struct amdgpu_usermode_queue *queue)
 {
 	mes_v11_0_userq_unmap(uq_mgr, queue);
+	amdgpu_bo_unref(&queue->wptr_obj.obj);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 643f31474bd8..ffe8a3d73756 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -45,6 +45,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_vm	*vm;
 	struct amdgpu_userq_obj mqd;
 	struct amdgpu_userq_obj fw_obj;
+	struct amdgpu_userq_obj wptr_obj;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.43.2

