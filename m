Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CB1C8303F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 19:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A4D10E540;
	Mon, 25 Aug 2025 19:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a7DFpWAk";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A0D10E540
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 19:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7mA7zrX1fe+wQBwxWDaNh8jL7+iwig+CM/m6unW2hYcMQN0qLEa0pX6PDch4UzOvjsFpqFn51IABVaxFbT92aEH6Mw1sK7qBNc7ba9QYVsA0LqxC7IWVW225SDoQtr+v+UTnb84Qh60Dun/mBtH+1Jbfga9nK5e4w4fD5NPEdf7ugmFVgLXmgKI71HuInzh5HL46ElLWLglxgt3OQ54iquCN9fZ/6sjpjKFoiqkWCuI159Fd/ZsBCuixmf/8AXtDw/nJE4oTEurz5m7nTtVJ2HENTLKMpakh+LRhaEaucnzwmp86NmVetYM2K0LsOdAgTaTDVKmToSVKbGYGMlZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlp5Tb7PNWxo6I59G9qinDpCYEDaXIWnD7WkFzd8RzA=;
 b=m/PXuyMsYP+wdzbhPa+wCQ9w9YeGdI/ZOSCVJU9hFJFOXZmPA8CWSS7LaAbIGsS2dhTY+f+QkP+81aM/jCZyjmRmFvJ03exuy8cP+X/yyVnlY/inyc+wBOKSEFI5m5zDwjfzrT/CQwph8vSLkNBrNIN2YD61MVps8tpEen6fsrNvz/+i8ajKKu2KGEtc7lTS0VOPf22z5MSk59gUGs8n68YFyY3Q5MF4JAGungj/1e/wGngA9odAwWCpLrcYSnmv+n/Ido9M+wnOlP5ZP1bZNzSRaTHfJXARisOzRe51PwITBSh+aNpvTk/X9vRADtetXS/JlJaZ+wzB1GnC+Rs59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlp5Tb7PNWxo6I59G9qinDpCYEDaXIWnD7WkFzd8RzA=;
 b=a7DFpWAkbfOAlwyyvpp38qnKchb/hxZQzR8gy9uAEZp1XoEy1ZdZHrQ0X1T3QbRz4G8C/LxS1qVbZYaQ0XGyhslUr7gZt/gKdgGBWWmcx8BgBCXFNCuJR2e707KkYbImmoPQoKeKT4QFvVIqWNiU/O4FmxhQ0YGmjdHDbkSY1Ac=
Received: from BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37) by
 DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Mon, 25 Aug 2025 19:49:58 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::87) by BYAPR01CA0060.outlook.office365.com
 (2603:10b6:a03:94::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 19:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Mon, 25 Aug 2025 19:49:57 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 14:49:56 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <simona@ffwll.ch>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, David Francis
 <David.Francis@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v16 2/4] drm/amdgpu: Add ioctl to get all gem handles for a
 process
Date: Mon, 25 Aug 2025 15:49:34 -0400
Message-ID: <20250825194936.899825-3-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825194936.899825-1-David.Francis@amd.com>
References: <20250825194936.899825-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: ac62c50f-be67-4050-413c-08dde41091df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkphMnRIZVR2Y0d2OGx5QTdldzZjRERGRVhKeGZ1TVRCQWxPaFA5akx4WWYr?=
 =?utf-8?B?SFBYUEtyMHBqYzJaZDA3b1JVNUpLUDh4aldQYzlnRnFMaGREaUVMYlBYYnJ3?=
 =?utf-8?B?Z1pOU2E1QzZ3N1RkaWNsMVlralhJT2lxRTlLcHlrSTRQRm82akJHaGkzU0xC?=
 =?utf-8?B?MUtWdEtmRjRLZWdwSng3VGU2ZXl1MFdFNVNYSTB0TnZqcHphSjRkZ3ZOejVv?=
 =?utf-8?B?dXl2NkM0K0tVZmpqb3A3UEtYMlY0TEt1UGQ1OVo5K2hLTlBCd3lFZU5idndj?=
 =?utf-8?B?NWk0QXFUdDQyQi9GWTdqTHFlWmVhZDFUMi9CdFpWWnN1SGJjZUJGNHczbWto?=
 =?utf-8?B?djYvQnFTSFR2RFpheEd0R2Uzd3NLNEhadmRLWnRtREc0T0QwSk9WVjhzNjly?=
 =?utf-8?B?ZnZyMlA2YkJROHNxaXBaL25YVkFKNzNOVUdOemxWdGRKZ2M1aFFoT0lyWVlD?=
 =?utf-8?B?eTJjUXVWSnFCd1JKS2o1WUhCcU1hbW9MMitrV28vWVJseEZZNXBzd05lajlY?=
 =?utf-8?B?ZGdvbDBaR2dhdmNQS2Jzc1ZETWdjQXpqZCtHcWJvbUJSTFRaUG5tYTd6eTg3?=
 =?utf-8?B?VDhBVGtwU0hLNmpLeWxnSFZpSmh1NkY4aGVwYklybTFlN2ZZT29sSll3UVpr?=
 =?utf-8?B?S1lvSnA3VGRaeHA5QUNKUWpET3h1b2h1dGVTMXk4azd5NkovR0ZRUUFURlQv?=
 =?utf-8?B?MTF4UWR1eXcxUVBZMjBOUmJVeHNFL1lVNmFLUjUyR1IrbUM5SlRwTEJlSGtl?=
 =?utf-8?B?VGFKZUQ1b3lHZnh5czROeUlKRUhSRi8rMlpoSXN3Z2ZPM3pLZ2h2cW9LV2Y1?=
 =?utf-8?B?MmRaMmRaWnNJYWhrMUszWE9uaDZZR3hSbGhPZTdTMjlrV0JtVG9YVG0wRVlO?=
 =?utf-8?B?dVNwUjMwSEJzLzlwS3pzWkZiZVNKSUZWTWxjd0VRQnhlUHJETzB2S1ZhWjVX?=
 =?utf-8?B?Q2gvVmVtMm4zeUxQOGlvUmh5RUlMWUlObVoyaXV0M1dCc0xrc1dGMDlDaGFw?=
 =?utf-8?B?T1BxVnJsa2ExZDNKaTBaUVlDb1BvbkdEZkVwU21JWWtLZEt1UlRRTWdKWlIw?=
 =?utf-8?B?ODVOVlFpSElxaDlGYUtJMXZtZlRwdzRUNTVycnhXREc2dnovSnZhbEVMeW9E?=
 =?utf-8?B?MmkrOFM5UW9OSUgzSjNaS3duUEZ1NmhENGdySEZzODV5aEQ3WVlWZ0ZsdlU4?=
 =?utf-8?B?VkltQlcybkJCRDZnZlRGVVRBeVJuVnVPMmhVWHN5OWtYdzBGUk5JV3dBbU40?=
 =?utf-8?B?TFpUTVJhRWpJTWRHemdMd05ZR1pBU1lSV2FJYlV5ei9zSnh3azZlc05CUkor?=
 =?utf-8?B?ZUhFSmtjYnhpaDVFaTk0WEJvRzhUQ3VxUjFlc1M5S1lTS3U1S0xpRmdXUHJG?=
 =?utf-8?B?bE1pZU5SaFdkZFc3Wnp0andFbDliMml1enFhSmNqRzl4aVFIUWZ6cHRObURs?=
 =?utf-8?B?VDJnWU5JYUcvQUwydWxiQnhqVFRTbUNTdC90UWhrMXNQVi9iL2tYT0JKYnNr?=
 =?utf-8?B?OWNJdFhGOVAxY1JwWkZnQ1BzMkdzaFFBZ0xrc2F5SzZsMzh4VTArRjdsN3JJ?=
 =?utf-8?B?K2xza0REd09pV0dnb2VNZ0VXN2ZpMEJMN3hTd0Y3ZHhsZTJwbVZFYkJkRTl2?=
 =?utf-8?B?cXM3a3d3RktPbUc2SmI4Q0lJaEFiaE5oZFpRREliM3RnSFFVRVVvVDljYm8v?=
 =?utf-8?B?SkhiUTdpb3hKeXJDaDVmVGdBRkE5ZGhUbmtVUWNML2IxaXo4UVpMZnhJODVk?=
 =?utf-8?B?MkNMRHNYZTJZL29DamJIbi82TnZFUFpCRStCWUZGMFg0Sk5nTkdwYjU5Q1dl?=
 =?utf-8?B?T1R5RnZpdlkvZFdoYnlYRkMwZ1htU1JEU29EQ2xTS2pVNVh5RFZ5b0ZsQ1BN?=
 =?utf-8?B?UkN0ZHNiU09wSzRtbWlhVDBncGUvemFDVFR4TGdPeUQzdHBXeVk1MVRHS25t?=
 =?utf-8?B?ckw3S0FVaC9COHgwUENzWlJ1U21CVXA3Y3liRFNaSEprTkxYZnd4c0dlOWRP?=
 =?utf-8?B?anZ2UndXclovVFV4K3Y1VHcvUUdocFlNWWk4STNaTVdXZElLb04zcWN6LzR5?=
 =?utf-8?Q?uM96r4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:49:57.3064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac62c50f-be67-4050-413c-08dde41091df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
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

Add new ioctl DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES.

This ioctl returns a list of bos with their handles, sizes,
and flags and domains.

This ioctl is meant to be used during CRIU checkpoint and
provide information needed to reconstruct the bos
in CRIU restore.

Signed-off-by: David Francis <David.Francis@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 80 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
 include/uapi/drm/amdgpu_drm.h           | 34 +++++++++++
 4 files changed, 117 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4ff3a2eaaf55..f19795dddf9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3031,6 +3031,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index aefae3a9e6f4..e6741d6c9a55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1024,6 +1024,86 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+/**
+ * drm_amdgpu_gem_list_handles_ioctl - get information about a process' buffer objects
+ *
+ * @dev: drm device pointer
+ * @data: drm_amdgpu_gem_list_handles
+ * @filp: drm file pointer
+ *
+ * num_entries is set as an input to the size of the entries array.
+ * num_entries is sent back as output as the number of bos in the process.
+ * If that number is larger than the size of the array, the ioctl must
+ * be retried.
+ *
+ * Returns:
+ * 0 for success, -errno for errors.
+ */
+int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp)
+{
+	struct drm_amdgpu_gem_list_handles *args = data;
+	struct drm_amdgpu_gem_list_handles_entry *bo_entries;
+	struct drm_gem_object *gobj;
+	int id, ret = 0;
+	int bo_index = 0;
+	int num_bos = 0;
+
+	spin_lock(&filp->table_lock);
+	idr_for_each_entry(&filp->object_idr, gobj, id)
+		num_bos += 1;
+	spin_unlock(&filp->table_lock);
+
+	if (args->num_entries < num_bos) {
+		args->num_entries = num_bos;
+		return 0;
+	}
+
+	if (num_bos == 0) {
+		args->num_entries = 0;
+		return 0;
+	}
+
+	bo_entries = kvcalloc(num_bos, sizeof(*bo_entries), GFP_KERNEL);
+	if (!bo_entries)
+		return -ENOMEM;
+
+	spin_lock(&filp->table_lock);
+	idr_for_each_entry(&filp->object_idr, gobj, id) {
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+		struct drm_amdgpu_gem_list_handles_entry *bo_entry;
+
+		if (bo_index >= num_bos) {
+			ret = -EAGAIN;
+			break;
+		}
+
+		bo_entry = &bo_entries[bo_index];
+
+		bo_entry->size = amdgpu_bo_size(bo);
+		bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
+		bo_entry->preferred_domains = bo->preferred_domains;
+		bo_entry->gem_handle = id;
+		bo_entry->alignment = bo->tbo.page_alignment;
+
+		if (bo->tbo.base.import_attach)
+			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
+
+		bo_index += 1;
+	}
+	spin_unlock(&filp->table_lock);
+
+	args->num_entries = bo_index;
+
+	if (!ret)
+		ret = copy_to_user(u64_to_user_ptr(args->entries), bo_entries, num_bos * sizeof(*bo_entries));
+
+	kvfree(bo_entries);
+
+	return ret;
+}
+
+
 static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
 				  int width,
 				  int cpp,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index b3047d73fe07..338fd6d6423c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -67,6 +67,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *filp);
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp);
+int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp);
 
 int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bdedbaccf776..902e30263fcc 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -57,6 +57,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ		0x16
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
+#define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -77,6 +78,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
+#define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 
 /**
  * DOC: memory domains
@@ -811,6 +813,38 @@ struct drm_amdgpu_gem_op {
 	__u64	value;
 };
 
+#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
+
+struct drm_amdgpu_gem_list_handles {
+	/* User pointer to array of drm_amdgpu_gem_bo_info_entry */
+	__u64   entries;
+
+	/* Size of entries buffer / Number of handles in process (if larger than size of buffer, must retry) */
+	__u32   num_entries;
+
+	__u32 padding;
+};
+
+struct drm_amdgpu_gem_list_handles_entry {
+	/* gem handle of buffer object */
+	__u32 gem_handle;
+
+	/* Currently just one flag: IS_IMPORT */
+	__u32 flags;
+
+	/* Size of bo */
+	__u64 size;
+
+	/* Preferred domains for GEM_CREATE */
+	__u64 preferred_domains;
+
+	/* GEM_CREATE flags for re-creation of buffer */
+	__u64 alloc_flags;
+
+	/* physical start_addr alignment in bytes for some HW requirements */
+	__u64 alignment;
+};
+
 #define AMDGPU_VA_OP_MAP			1
 #define AMDGPU_VA_OP_UNMAP			2
 #define AMDGPU_VA_OP_CLEAR			3
-- 
2.34.1

