Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4D2EB2700
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E53010E603;
	Tue, 10 Feb 2026 21:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VOn0+j3X";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D8110E5FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iv3M4yZzml9pWxHZyttAetWP3WK2GBKeC+ytO0Sa+P1Qa3wBHP37y/v61ZItLZl0knRPsZ9XD5/jIdDc/1fu7TDhKTAecQz0bI08jRRkzNRrxFkWuAIzoXmklxL8LYjxNcfOIVezgsWGiW85k6rKOgb9fhxnvT2vDVOjDoZZxHUc4/dGo0+MYhki2ow+xk19rc64hCq/9fWIH8BE1BNjIXbwe4yLpfp2KST9d3NWdSlzR2GcEjQmDXCPsf6lALfIW+s8JZoOwgR+82+fiFDNypjpU4R9Vgc4oQGSCfUCfemWWTS8BkvX7jJSLwXh4kCWlSxrrd9UHsXOrftFeo0QqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unchyOht6pr+mQpwrvoNXKuXsgvt7sl3ocfWltTogXE=;
 b=wKkKeoqeGWZGLLj6qXp3QlbcltmD8Po0qk65qCY5RldCbCX84SZ5XhGa78xdetQyOy7d4QfHdPp1fqXhV9OZaivhGaA1juVTuiuuwHWkVCNWPPspW5dRvHBrADALgvfOdZPS2saicp1IH9DtziyK3pDDRtNTlMPuLp3+IZMG4FAgsjCHH0aVsKUxmVGQa7NY9JKLuz6QeeQs0kal07PVfUzfq6jWchVZpJZLd5cfTOTq/PJIgsoyNzTZ1IHKYxZrGIN/vaoVj/++QniB8GlMTpB9gAdG/Xf6F1IIapRWm9xP17R0Dp/K3Z9utjABDAA5bGtRsbCU9DTJzFBDQBczQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unchyOht6pr+mQpwrvoNXKuXsgvt7sl3ocfWltTogXE=;
 b=VOn0+j3XVzYUa2R8tuqLNNN8zPPM/cxHeL3V9oQUoAFfWTAKipJvKE1x35SEX2mLDpwATZqgVibpHRASoErs7xCOH2mBQY2IT0w7kVdn70WoCsejaxQZ0nQG+yYn3hgamPXiL5r4JSBT4ZYFGEGtWd+wTFIAoFSQ/cRkOM29CZY=
Received: from BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 21:48:07 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::6c) by BYAPR02CA0021.outlook.office365.com
 (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 21:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:48:06 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:48:00 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>
Subject: [PATCH 08/14] drm/amdgpu/userq: change
 mes_userq_create_wptr_mapping() to be common
Date: Tue, 10 Feb 2026 16:47:23 -0500
Message-ID: <20260210214729.80964-9-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea0d131-d845-434d-efb8-08de68ee134b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SseAgvgnt/KVUpPnY8quIG2OUijTrBgZp+kkNEg7/kXKQcj7cYF2Popi/+Vs?=
 =?us-ascii?Q?zSMDZh0uXpchI1T4v5j21m/Htw1Y/kWbxJtMDTTRfh27A3UzuMhaTz0WIwa1?=
 =?us-ascii?Q?JIejLsGeLN/8vfQKxwcvQQvX8pFEcTRk9BxFaoOR8K8dnJb7y43KnZkvK1bw?=
 =?us-ascii?Q?uzkzAOadi70sZ8RUamzSere0KGgU2GZwTAhSkuq4H1E3LzVXNga4wT5dk+t/?=
 =?us-ascii?Q?8vpDiO3RspLwLNUxNDDwo2P8GIigYVHuhli4kXyBoV3QDiZiEVwvfE3FhUh/?=
 =?us-ascii?Q?z1FHFX5WurZoyGnSQIxgVHH3of+s1ObyaEua4zklEyH8vViAZbGyZT5LAqZO?=
 =?us-ascii?Q?KISA/0DrLTgg9p22Tj8cur5qfT9IBw9VVgmbxuvWHhrnulOd3JZqMJk9Zfeh?=
 =?us-ascii?Q?RVIojQpBY0cIUMFIK0xL0L1F6Y1C96yFpeq9dnNciueFC4PIZZThqD9Ln/7V?=
 =?us-ascii?Q?Rw9pHQYtEJk2CpnjnGu6asg9odMl7wfAyeHhVPpLWHpZKK5v9EZUQYsTltAJ?=
 =?us-ascii?Q?SSs8qD3jSk0QGhERxAUH8/yp2sWfv7m0TgIKDLKi1sTfHBL5oHgY1JLG4o+x?=
 =?us-ascii?Q?Hp6nI54+798GkVJu1eCb3tHz1qHetlfd2CdkBGDzSstBM76mQGKo5sD+tiJp?=
 =?us-ascii?Q?Ug30RrPlO0GYCb03e2tp+WPY6hT6FACmn+vv2ZxGOgdC9lqvp2p0ZaKd191U?=
 =?us-ascii?Q?ofr/a1xxax+6dPR9qWcDkDCxXo3P3UpV9q8+JN5yrrLdm0tatGjDlksSARgo?=
 =?us-ascii?Q?oKK/ya6JgHvZ9AR/osBFmoWOXeqrQfBB+P4D3XWp/I3PPtOnAJCcrNpQ1U7L?=
 =?us-ascii?Q?vQAak+tA8UAsHCo5eppgCStHaguusxPvtNqAPfCz7h/ll7OY2uXsEI0g7KOe?=
 =?us-ascii?Q?pMcNlXDzSDZB6MXUNGwZnBBGDUyWw4NWTR3IAJdVFR+2MU7d/k2AG05iYm85?=
 =?us-ascii?Q?SzrmH/n+HF7VQEtgdD3hF6k708i6ev4cvUVh/0c77aGRcXcLMavBu3q17vwR?=
 =?us-ascii?Q?a1ic6vfF7/JfdUXcmS/9dyhCae2WIWNXd+oB3/T/xrHUreOO0ofKTzwm6AcR?=
 =?us-ascii?Q?ODifrz1fAfONjbUrC72jeQgAFtb7y9BSGofdmnJBogUFme/I5dDrUfLu5Mi/?=
 =?us-ascii?Q?HjSmyFMzFJp1UMMSJT1g2RW0q8scLydbibyeSyqU48MkydKTP9yyrDbYBMbp?=
 =?us-ascii?Q?KrCF4A0xsY1BKBnftgttyFHX+Z3vpNVJiS4FtpeMe+wMb25JMGERSghOqB82?=
 =?us-ascii?Q?i6qYuuwb7p4w8SFt63vwA5+D7b6J+dbszK2+6Aeiz3MTPItK16f8VExPaAnc?=
 =?us-ascii?Q?Ne4W5zxfXe8HExqJsy3dSy1bbdRdc2eNSVsd4eWe3IHL4Yak+iFC/Juz1oKu?=
 =?us-ascii?Q?kyWusn6om+SgKcTK87AJp07ONwcNyjp/un/UvqgpkbN2PlU3KCRVbGNCmZvN?=
 =?us-ascii?Q?8WHMJ+6Dn0/FBEjB58wpeXTgmzHtEuTuqyWQWhOiF85scwa4zWxL3WUe6RF7?=
 =?us-ascii?Q?SZxtYtptugo4dSph2KoAu1r4reOgmUpDTAUBnGKmVmRdgT63ZqHL5l7ms1W0?=
 =?us-ascii?Q?oZcfbMbxcXXyJ5xcFo3xESwRvl7maL+dgFeOf5QBbZHPT+DG+xeUrUqC+Khg?=
 =?us-ascii?Q?2LUU6NbsyWZ3OdZX45FV5rI6DArUHQQupnmdiQAjRMKoaft97qa7U4JxyW0B?=
 =?us-ascii?Q?YlSGnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cr5wBypycjDZBX0qVzIVuwEDTmv2NFNSJ9tp+BsHpI/QANjjoQTVrNHUc4m825sEoAFD9agdjI8xb+YtFksRAcBr2C0QShLhdjKw8sEUN+uL9H0jO2M9mwSs0u83fmXnKrHiDR35/3ES3UyP1awEOkwL9Y124tpbcx5ZvqR9N7ro/Hfmx/BGyrKVKDb6qJ5hYNDO75Bxc/CfMG1Z5oXPmPbb1fErBpHaebjITneja6Juv0LmBAftwLOgIbjwk+FdBvxUdurN4u7pGcYbAXsB4/CIySJVzaHvs2zTwM6G1HV3OLvNTv3e12I6sya1/Jyi+6UtUNM2OgIeKh2zqCgqAqeN16EHpX24SL9N+VjRBZVdfX7A9piFnjsg6/ODwtfWQl1qmAXNNgFzVE3rMB0ykR3A7+C12WTmw9fFy3ioSQ7jMQ0f6P3hCNavKGeU2SO3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:48:06.7094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea0d131-d845-434d-efb8-08de68ee134b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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

rename mes_userq_create_wptr_mapping() to common function so
it can be used by umsch as well. Also replace DRM_ERROR() with
dev_err().

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 87 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 90 +---------------------
 3 files changed, 91 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index dc9000b25be4..ebb0d8a9967f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1572,3 +1572,90 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 
 	return r;
 }
+
+static int
+amdgpu_userq_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+{
+	int ret;
+
+	ret = amdgpu_bo_reserve(bo, true);
+	if (ret) {
+		dev_err(adev->dev, "Failed to reserve bo. ret %d\n", ret);
+		goto err_reserve_bo_failed;
+	}
+
+	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
+	if (ret) {
+		dev_err(adev->dev, "Failed to bind bo to GART. ret %d\n", ret);
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
+int amdgpu_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
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
+		dev_err(adev->dev, "Failed to lookup wptr bo\n");
+		return -EINVAL;
+	}
+
+	wptr_obj->obj = wptr_mapping->bo_va->base.bo;
+	if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
+		dev_err(adev->dev, "Requested GART mapping for wptr bo larger than one page\n");
+		return -EINVAL;
+	}
+
+	ret = amdgpu_userq_map_gtt_bo_to_gart(adev, wptr_obj->obj);
+	if (ret) {
+		dev_err(adev->dev, "Failed to map wptr bo to GART\n");
+		return ret;
+	}
+
+	ret = amdgpu_bo_reserve(wptr_obj->obj, true);
+	if (ret) {
+		dev_err(adev->dev, "Failed to reserve wptr bo\n");
+		return ret;
+	}
+
+	/* TODO use eviction fence instead of pinning. */
+	ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
+	if (ret) {
+		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin wptr bo\n");
+		goto unresv_bo;
+	}
+
+	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
+	amdgpu_bo_unreserve(wptr_obj->obj);
+
+	return 0;
+
+unresv_bo:
+	amdgpu_bo_unreserve(wptr_obj->obj);
+	return ret;
+
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 4feeeaed20f9..758464203d98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -159,4 +159,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 				       struct amdgpu_bo_va_mapping *mapping,
 				       uint64_t saddr);
+int amdgpu_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
+				     struct amdgpu_usermode_queue *queue,
+				     uint64_t wptr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 9508709abd49..9c1a99f61472 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -30,94 +30,6 @@
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
 
-static int
-mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
-{
-	int ret;
-
-	ret = amdgpu_bo_reserve(bo, true);
-	if (ret) {
-		DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
-		goto err_reserve_bo_failed;
-	}
-
-	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
-	if (ret) {
-		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
-		goto err_map_bo_gart_failed;
-	}
-
-	amdgpu_bo_unreserve(bo);
-	bo = amdgpu_bo_ref(bo);
-
-	return 0;
-
-err_map_bo_gart_failed:
-	amdgpu_bo_unreserve(bo);
-err_reserve_bo_failed:
-	return ret;
-}
-
-static int
-mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
-			      struct amdgpu_userq_mgr *uq_mgr,
-			      struct amdgpu_usermode_queue *queue,
-			      uint64_t wptr)
-{
-	struct amdgpu_bo_va_mapping *wptr_mapping;
-	struct amdgpu_vm *wptr_vm;
-	struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
-	int ret;
-
-	wptr_vm = queue->vm;
-	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
-	if (ret)
-		return ret;
-
-	wptr &= AMDGPU_GMC_HOLE_MASK;
-	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
-	amdgpu_bo_unreserve(wptr_vm->root.bo);
-	if (!wptr_mapping) {
-		DRM_ERROR("Failed to lookup wptr bo\n");
-		return -EINVAL;
-	}
-
-	wptr_obj->obj = wptr_mapping->bo_va->base.bo;
-	if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
-		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
-		return -EINVAL;
-	}
-
-	ret = mes_userq_map_gtt_bo_to_gart(wptr_obj->obj);
-	if (ret) {
-		DRM_ERROR("Failed to map wptr bo to GART\n");
-		return ret;
-	}
-
-	ret = amdgpu_bo_reserve(wptr_obj->obj, true);
-	if (ret) {
-		DRM_ERROR("Failed to reserve wptr bo\n");
-		return ret;
-	}
-
-	/* TODO use eviction fence instead of pinning. */
-	ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
-	if (ret) {
-		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin wptr bo\n");
-		goto unresv_bo;
-	}
-
-	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
-	amdgpu_bo_unreserve(wptr_obj->obj);
-
-	return 0;
-
-unresv_bo:
-	amdgpu_bo_unreserve(wptr_obj->obj);
-	return ret;
-
-}
-
 static int convert_to_mes_priority(int priority)
 {
 	switch (priority) {
@@ -413,7 +325,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	}
 
 	/* FW expects WPTR BOs to be mapped into GART */
-	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue, userq_props->wptr_gpu_addr);
+	r = amdgpu_userq_create_wptr_mapping(uq_mgr, queue, userq_props->wptr_gpu_addr);
 	if (r) {
 		DRM_ERROR("Failed to create WPTR mapping\n");
 		goto free_ctx;
-- 
2.43.0

