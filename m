Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB64EECE589
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EBC410E680;
	Mon,  9 Sep 2024 20:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m95kbtU2";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7507A10E67D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6wW60BRrVjm6iJ4pkWnW8LJEgGN0ZdR/oaMTnIcvJBro0ESpQzZAFVORfu563eC3cvY0fExjDnAd7qPBnnlv7a+tl8McqsX2Ocx7HD12sP3mA90L8gY3wVyJxYsQJgYBTKMmiyaaOTVWmsyaMb/8h4593/NRvorMqjCF4mH10URdaFyAqZFXi3ZFywqAz1FFHINhotW2m0dmhAt/VdF04MTjd0z9eXJyGvVkqiYqOYJCpZ4aHXMzeSNg9dQJn60FPt7w6CZI2pBSRaBEwLTc/H8gtNm1d7dTlpmzf3NwHBcXQn3M7MUWYfabslXjMSYY/uJqjmJw1c0Wka2G6a98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PELzU2u1EyTcwHXNTcHq1tRhqAJ1oldiu1d2G1P3LS0=;
 b=e90FRcDXWuB3WcmjL6IOLIscvamsIjtE7f/Cs1SUUZNqxJq4edGyMYBBGNqiA1BJc86MIHdaZrjs+q4+y/Kg3dASnAz5msiYe5KlBOe/FBFPdrXSYr/Mr6Gq9D5NwyVLXaYW5IBhr6eVPeTwQ0UqCLZbupkSE7gwRs2pmyoaTeN74d4sRqm72MlhdwPdPBNYZ3prVUdqoEA2LSahj/5duuZl27fiJPEPrbrW+ceyAmNJpZ1e0OBuoYHav2rnGA+Jk9e7vtV3WlYBhHkkRo663RHgVZit5NPdj1YLb/ZqmP9HuZ6wd4Nnslrx73AJODOHU/xnbyx8kJgqW0cvnzQQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PELzU2u1EyTcwHXNTcHq1tRhqAJ1oldiu1d2G1P3LS0=;
 b=m95kbtU2eXZvaecqKJfdPkbbJ1ObsWZ6yAUO7E89ycTyuCs9uRdpGXu45mStBDAsX6JepxQwDm3QpETzhvN04tvcIi2Xdjr9ry12NlDW1WMUx+cPFHUka/1IjEcyyZAoFVyO18r6GNHzn2y1Dhs7dZl+iP/GEqGJtvhYvGSbcN8=
Received: from SA0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:806:130::18)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Mon, 9 Sep
 2024 20:07:00 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::ee) by SA0PR13CA0013.outlook.office365.com
 (2603:10b6:806:130::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:07:00 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:06:59 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v11 04/28] drm/amdgpu: add helpers to create userqueue object
Date: Mon, 9 Sep 2024 22:05:55 +0200
Message-ID: <20240909200614.481-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: afe666e0-c9a2-4503-4976-08dcd10af731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W/3Lig1ng1EAX5odTZqlp3OWZSZcP95L+aF9VeRsN73KDbw1GIhVCYtwK7fR?=
 =?us-ascii?Q?lHdyNvblv04ZCG64OdJNVVD/GCMs7HnYV0g/Ooc8Ffvqp1B7umovbs/oiMT2?=
 =?us-ascii?Q?LPZt/HB5GmBSzmMUrN+dQKEWDkvUb0cBCrAjq2ygba9PmB0nDGWUezlW/SZI?=
 =?us-ascii?Q?Rii/t8wqZ3iCo7UM6Osq44zSt35S7ibx3K/TxSkHwFzfod0KF0JSAAs+0NIY?=
 =?us-ascii?Q?l4og1Vwy+uOM5Y7UTDzP3cofRxL4L+6X9yKb9LAVTzW2WbawHoWsv+ioaMbo?=
 =?us-ascii?Q?+m3mZZYnCcP2ryMFTL3F8VLVg092N8NQHxf6fOPURSxzEN0OF77yTwIwkhzm?=
 =?us-ascii?Q?LM36w4x6hMU7coUyl70tXvBs3u6gLOCuqJnzMn9U+LNiBFsHABjPJcXyPfNS?=
 =?us-ascii?Q?GLaIZi092N2WUW6izQQ/f1hmzcq9jUQeDM0O0ExNbPnHGXOe2bONVfhi7eM4?=
 =?us-ascii?Q?5Ba8PgGAKNb7h5st3ffprYohv0QAvb3r50iTeKwMhFfKlhpG7TCeIfX3sfLU?=
 =?us-ascii?Q?biKuimxcHBxLfabPdQF94Jq//7GKxpo4mONnBe3OyGxScgG6clBJANdV7IdS?=
 =?us-ascii?Q?FN+HjVZ5IBZNiRQb3jaMJe9dZIGEgV2h1gl9e39vRIEnj1/RGAB86fUxaD6F?=
 =?us-ascii?Q?20zOUk07fDJfV4xVV2ruhLIgTgwWd4v+6RwYasfkU4R3yfWI0Ta51cl38nxJ?=
 =?us-ascii?Q?CS43QlXpVFtObCjGGCgnuGyyDVCFql6qFH7gMg3Dmfx7gPD+KrCwfrOJF/3M?=
 =?us-ascii?Q?0YV/CyXBheLt6cpbHhwOBySxXETWGThSysTGwgQEQNC/X/qjlxbbCZwNBTrr?=
 =?us-ascii?Q?r0rXWkL7orKqW//sn1wV94UALStYP/k026x/MKbPsRlO4Ixcp2lWNKpJc4YI?=
 =?us-ascii?Q?w+r1ocvoBngb+wKEVk9kxjHFuNF1Du18OoOLJQdybmP43LwZdPhLWpR/dkNC?=
 =?us-ascii?Q?EvVsl2sI27Mn1rOUn7KXisJ/4EMlUxMeZ+25un0Kbl5+A6jg9BBCdIu8VHA7?=
 =?us-ascii?Q?Vt6Fv+sk0pBu2YmACJPxLC3zu15JmooOHTuhc7s8wLAUZbsrOSj2JMxpyrFS?=
 =?us-ascii?Q?6VB5nJ20q6vTWVbXD+5Imu7RHjQX2qfiKW3o8oysjDvN/QAp71G7ofxwdSym?=
 =?us-ascii?Q?fi4YVBHPefPJOgQSFXWfCrrwh/3pfQnvQjLQRiag+lLClnpCLTeXq6rU8nEY?=
 =?us-ascii?Q?AfNKxOdfV3ThVea2fuslAqtk0n8E//uD+D/aFZquiOYtt9jfaZ4r5XZsqyIH?=
 =?us-ascii?Q?snap5I4QILyyomgnsUhP+kmY4pBdKRATyotcWjzx4JU0EovhsFNgayeDh7Pc?=
 =?us-ascii?Q?Np1yT3JTQX6lZOq2Vtlu8FtgW+RJx1DO4GUqVnaD1lLIAfCQqm6yC6Qs72GG?=
 =?us-ascii?Q?Ef2klFT8A7es216x+uZgDAxxOAuZvuKqhrkWbkJqsO991pJRvnaGMli8fxZh?=
 =?us-ascii?Q?4uodK6wxvHRwdNitc3hV5UhJurxWM1pj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:00.6067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe666e0-c9a2-4503-4976-08dcd10af731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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
V10:
 - Added Alex's R-B

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 62 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    | 13 ++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index cf7fe68d9277..501324dde343 100644
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
2.45.1

