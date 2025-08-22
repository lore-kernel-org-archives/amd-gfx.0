Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC0CCA0FE1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 19:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8A310EB96;
	Fri, 22 Aug 2025 19:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MNn9USKB";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBAE10EB9B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 19:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7gagg0mo1onZMhuX3ZtIy2tuuDNjjs4+E/D0ZlMGtSPpqqJMuibWECCiJAJa82L+uF2l9+fARdNfJUEem57CPuzXtXZOq7TROcIlNMaaOqgg/iCLdIEuXgkILc6K2hbV3AEiGvv/gJzjVVfcnAN6GjOPcw6oDQXCr33fhrFOxZdXDNz/xqeo6wJEOBjlQbwCm/1btwSJKvJR43uSTBbNIgozF5p6Rm/aW2lx72UEJdLFT0YjmaQ7MtsKRQiHmSChOCeQ+kx5/XP6cfQDVqQYS6NK6aP/Bh8tj0b1ACELKZ6aWDTG/LNcSV0+c6y8LaF1sbFXfJOpBLexHsTbZ/zqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLa27/91Fx5LL1qRkd3bXL1I4ItkHKb+fI7gTi3JLdg=;
 b=xhiDuwK2lAZPG+qxo3mgZ11CbbejSxeYMiwD9HyvWQPoeDHvRxpboEOcVqiRq/+wdue143VPZ5fipEotWZqM51gcMVBGFG43qsLnTnd04FJ8dJJz7LIFv9Hdk0ViiqRNKWuUKbcX8EgFiUonc7wayPjPbY0GWsJaxwDoJ4gX5llAHlPga4xlzphW3SY7QVIXArM7c9uLmI9dfaBdlvVRjsCDPIksYSVK2QHg7iN4pKjvtnv2EPLi1CDvJinsK09o69Ox+aNbp31ekBITP7vDMlZV2+1wlsX6zSzC11iVNY/3RTPpwT0jJCXjzQnBPJAFounWWZGmRYN+c3xhcDv9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLa27/91Fx5LL1qRkd3bXL1I4ItkHKb+fI7gTi3JLdg=;
 b=MNn9USKB08eaXOncTm+klQegc+1WDMSlKBIQXKvbP7A+TR2JDNfZR2pDWTysWyjt92ai4Ez7xHVlZiLr+Q5GBnCN95tUuLh0jbVQsgR590pzOwr1r8c0BSp9CEJxn0OJwNVAOsMgONaDqPlZR6D49SDdErFCHEIHWTEsRDT9FPk=
Received: from SJ0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:33b::31)
 by MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 19:48:14 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:33b:cafe::7) by SJ0PR05CA0026.outlook.office365.com
 (2603:10b6:a03:33b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.9 via Frontend Transport; Fri,
 22 Aug 2025 19:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Fri, 22 Aug 2025 19:48:14 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:48:07 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v15 2/4] drm/amdgpu: Add ioctl to get all gem handles for a
 process
Date: Fri, 22 Aug 2025 15:47:47 -0400
Message-ID: <20250822194749.362771-3-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822194749.362771-1-David.Francis@amd.com>
References: <20250822194749.362771-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|MN0PR12MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d043cb-51b5-4f59-796a-08dde1b4d525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GdckKnQkrivNT3E4bwpBoQJCNpSzggTJemiSTOusPaYdcihnrysh2drjBWxw?=
 =?us-ascii?Q?JjLiWQ65CFGUj5APhbfR1m+cx18x7CXBJ3/lQLUsEpH2p2XXLm9+hfXV38sm?=
 =?us-ascii?Q?Dh2b8mqMci9UMsn/3wDrty6esxXej87jb4Cbs4x3ACocnKsAv5fV6vqZVR+2?=
 =?us-ascii?Q?B4BLsBZuOs/neP1khpuhZui4Vx4aR7xQrKEHxVCQcJM/lUXNl3PqxgB/ublu?=
 =?us-ascii?Q?Osir4v5t42MlAYeZ3jE1StY6H+vL1HPR4tM8pw6iVSRCAZs3bmkRyZ4Jd83R?=
 =?us-ascii?Q?Cdv78YyvPincfWkxs1EMu/+DrSKZ8fclVZsERzrPuRydoRD+yT6Yhjrwx5Fw?=
 =?us-ascii?Q?91lpD/VOuFGAxvceHHDJZU54wWD0ASrTj4GiJyQFue+oPI2AlbN6rC/v1VZ6?=
 =?us-ascii?Q?g5D31YvBVLliFPV+mwhKY2Qe5QdehC8RNLJvz6PKfQNVjJghOe0Wg04+GhpX?=
 =?us-ascii?Q?X4qIghYQv8uNvr+Qz2AfpGhTF3Tz0n/JErOwTEetOaOdkQTmDjvR9L9N29P+?=
 =?us-ascii?Q?KtnI5eDDkyq8YZxCqPi343yCQ9d16ys4nZ/0kBMBZbWSf3s8G5Qq0ugM0+u4?=
 =?us-ascii?Q?Yi1y2uczdzcxwJ40zLaN81amyj1ydJAOza1vx1dBEwnnO+NbpjnUDICJfsA0?=
 =?us-ascii?Q?HoSK/YTl0GCW/ZnfG30ATOBP78JmG/aAQl1xTpwpYv4VUElxYzA825HA+8Ib?=
 =?us-ascii?Q?4++eQd3edssU0VVgYOX6VqXNTZqhfkfxeQyQOOz4/IK08pHPmqA4ij1yTYmj?=
 =?us-ascii?Q?WtzE+kejlpEUQtcX2VZkq6q/tGgOCm+iOiVd+vgBRA6dw4slQjDdz53+ixAK?=
 =?us-ascii?Q?jZffMLcezhsskRUKP4Ycx1+UFE5svWyT2GvkerXqZw7IDoWkQAcCzcBXtv/R?=
 =?us-ascii?Q?uvMRbikC7sI2Gix/GrO6q7eDOTvtjMvy/BDo0BC5BgzerJYnnwZHfYp5eGV9?=
 =?us-ascii?Q?1XubMRM4i+V/DT8exQCBHIcpNLFesuLwon6UEZ3tOCtMtv+ObhFq5KdUZY4O?=
 =?us-ascii?Q?3INGoLko9bNgRScYC5LdialCt6V94U4VO0zO0Wa8KdWRZpXQgLNmlxXD1v6b?=
 =?us-ascii?Q?/PGacZbu/YyyP7VcFkGj+8WeiGBVN2SEzXpUFJ+1z/MGOGjCcrwO+6r+zR3Y?=
 =?us-ascii?Q?q3jaPcmUOiPqFmbv+twIE1V8CvlFs4g9AXUNw/ewJs5W51ShMOdxx6LN1dl6?=
 =?us-ascii?Q?Qv4S4a9oyN4EVKg9t3SYTLdVdjwzl4zy03CYsELklhzOlFaNnRv4nXNkRDyR?=
 =?us-ascii?Q?2j7nH4FaOci1LQmrSDc6qkdJw/RULRPSb0cAjo+K5RWKgrpjEqr5KhZeTxgT?=
 =?us-ascii?Q?EqPuqeWgy1q55i6MIsm58+ZAtuOOEEqFv33dVSMsRTqjd4y7f74/xR6G9mHw?=
 =?us-ascii?Q?A/jVuuHGVbAkh86TAJCH46D8ZgHvF+tyenYNvnwOLOjMYYa24sdqQWtJdt+e?=
 =?us-ascii?Q?35IgcN712YmGeoOgP2xJ3hOBFyKM1ZGf01bK+2lE6t6Bt4sIXE26RT2S7Ypm?=
 =?us-ascii?Q?jzMewKS3FW3jpk1b+62fUbht4SE4+BadU0t0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 19:48:14.1500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d043cb-51b5-4f59-796a-08dde1b4d525
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128
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
index bdedbaccf776..e5d1c24cabcb 100644
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
+	/* IN: Size of entries buffer. OUT: Number of handles in process (if larger than size of buffer, must retry) */
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

