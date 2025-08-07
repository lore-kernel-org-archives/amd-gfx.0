Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C822C87FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 14:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE0DF10E856;
	Thu,  7 Aug 2025 14:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1L4iaTra";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4C6810E856
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 14:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRrfzxd5RbNsZa2N4+pGtJJ+LS/AMhh8uftg0wTwpfjGXVvNCeFlwc+gHbBipjkYDds733H33hXuHNmA/WY17kYF+hHRgX/hqAXanZT5z6g7eidAhigy8cfOAHYDudZS/xpjvBLwWxydjeaknRKKkv/JEEVNHUZJc8qZQXcKPZXL8Bg0Zj0Vj09jfCgVN75n2osnuo03MgMZ1lf4I8qHpTISDnUhznSbS17dqsxtdFwZXJE/e7y2FoJRkCQqMNb+YzN4g3zR9BiwtvDVyepKqsuWEvvvtHSFDwn8jUtHpgs8pyLzgJ0F5khsX8q3ARzJc5jUL0cwILcDM5f4TqufLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLHt3/SrVuUeGkPN7IIHtnAwsmb+v8mH0O3+1uLW3/k=;
 b=mJ7zeogxM3prv+fE7HMdshumbbYLBnoYOfGMUqwc2a1ET0ACGP7QDneGeF9rxyVuWq+PCRyQvUlBiiKc4hFfiVh7NssJQ2KX8ASCWCeamQCMtgiTHxe+XXhE5+HyxzJK7PhPR8p/HtQ7818ysjuhz2Rxbo8f30FKgr8McyUhlQQjGA5ah9eSk1PCshNCLwJpx7i9kfN3YjoUWcqvI8UyNAjhb2UfVM9tmWlmCT6kncX8bVh9IpcM6fY68INwocTFNccudVqkRosB4AybG8L6ik3bKUrrcrYvvDUYsfmYsR+yZcYgeS/u/6meN2iro3N+g11Sz61wr/i4jZtry4/oTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLHt3/SrVuUeGkPN7IIHtnAwsmb+v8mH0O3+1uLW3/k=;
 b=1L4iaTra0Wl3lgvTvaxXFrOfHPEjFjlG91vzhkJ7RIhWKfLSIaI/syVkl9azWpuT+ncVh3CWhMvhR+OUSP8wmxpKnExn2B0vrYUJEgU1CPcoaEAxisytulYIF9r8jtYwKpPNI1e5W+D2CszwP+aHot5Qf+lQEd+8t4Z67KZ+Th4=
Received: from BY3PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:39a::7)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 14:01:10 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::39) by BY3PR03CA0002.outlook.office365.com
 (2603:10b6:a03:39a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Thu,
 7 Aug 2025 14:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 14:01:09 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 09:01:07 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v10 1/3] drm/amdgpu: Add ioctl to get bo info
Date: Thu, 7 Aug 2025 10:00:49 -0400
Message-ID: <20250807140051.2377470-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807140051.2377470-1-David.Francis@amd.com>
References: <20250807140051.2377470-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b28765b-6e76-418c-1d2d-08ddd5badca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zx4OSgfwAiC/7YonHetbrs8Z7hzJz5NmIiUFmj6G1h6TxsaTZXn8+4pinNl4?=
 =?us-ascii?Q?QyF1au2htdVEDWp3kNbKcT5RQuTmEBw3UOFpvSZRFlei3uKs9D9Y7qxggWQZ?=
 =?us-ascii?Q?jMBUzK+zKBRQAZfYhDoQojNOOEXHr5vGfY7A8HU98x9iB6b/5mYYiGl6CCjE?=
 =?us-ascii?Q?1wSrPKxtCAGwU4z3+oIunO3Sm109LaRcr+MpqWDTpeIPBeqOQDgoKWE/VUqs?=
 =?us-ascii?Q?EPSwllcXk8R7aT1vabvmIKbWP93Os1Q4f0+jwz5fuw8GEWuQ+JeBgcrRTSA8?=
 =?us-ascii?Q?pw9gL2Gu75SUmQbk3tstqNAGtRCErXVa1DEi6xMGSqH7cuy6ESe3/RAmHsEU?=
 =?us-ascii?Q?Abr+UniS9CEigpHD0vFKhQqthnDZYVcxd76SdgpU5gQc9dr29ut61VRAYvrY?=
 =?us-ascii?Q?88zmXhlGe1GNoXnKzYF0/WwVHNAg9J7Y3eRmj0cbTcqDTP7/BIYl9efzJ4NR?=
 =?us-ascii?Q?tmDeYLnj+5NWTGan/AOUIl0xMkq14oAfV3wTYKHwOapX07Kn86mv1ImL/nO6?=
 =?us-ascii?Q?CbhOxgkovG+PDNSdsnl0vJDtBp1FlRwKJcwXpzlpDce/6JU1KZSOUcVQc3VT?=
 =?us-ascii?Q?Qk1P5aW+P+nMbt52V32ebKDf4i4IWNTZ9pLQV5parJ04+2fnOZ35u97Ifhlf?=
 =?us-ascii?Q?9x+1i0sGhpLV9we64/eCTo9Y1o1+rjpWApxv8lcC7e/jLIPeVxISncm2mO4t?=
 =?us-ascii?Q?vk3LIgjbq99xbUwg06sCTv/aD5HEBVl87ZkUAozpabeplOhZgtG4ios02iUW?=
 =?us-ascii?Q?qfksVx7YEwO6JpbhxuwXHqzUOuHavU8HIy/dLzBnrRoRGdzkIONEKFpORr6x?=
 =?us-ascii?Q?AYZZyaaaM2pa5+wmNP2jgJNbhKJ9iv9iF4lUZ+19rpsd90Rq1uxNmx4iUI8+?=
 =?us-ascii?Q?jwzA0w7jUYHe2pn1g5seVDrv9TQYKDn2t8uYqvrXQ/o3DkAgIO6eLMfW3kef?=
 =?us-ascii?Q?fcQ37EAecwJv3+58cvdTvIrrldHCiI9JyOkJyAR2GxufX5WhfUBlxabFZ/jP?=
 =?us-ascii?Q?cUcRe8/0ZSxdaCFG7QUR38U43u/uG850zcjhRddtuv2g+MHh5BsO7ZbOCWI5?=
 =?us-ascii?Q?IupnqNZdbGmnjfOemSp+Tm9UfdtYJi/WH1oRhxoFfJxrcyIAUC7Mey1tQCaP?=
 =?us-ascii?Q?XI0RknlIr3slsSu0eqOWfoQ4FuvkhIWn15NYHWFi0YFqnxMzzARn/0tBErIV?=
 =?us-ascii?Q?jh11RgV00TeibFi0uoZy9VdZp7uGit2Q5PGZJz3wFpw3KmAkJ1GQ2jHG3TQg?=
 =?us-ascii?Q?b++5fYAiulsEKKEjG7dmvEHv3Uy0XcW2QSmv5eKzO3FY/n/BcXQZM4xCFojC?=
 =?us-ascii?Q?9MTVnomfeIvPBOIgASMveEW3Kbb21YY7YAQUGvBtTg6RM2ckT7GHUdXRobg/?=
 =?us-ascii?Q?sVpPK6w0yXcOoua2zRyrpvOK/9o+5V20JB7glCdF3G4P/l0+QFsltZlVGwcR?=
 =?us-ascii?Q?2WerNx5+wgCC3M4Y4KpJlezehN6o8xdMvAN3NMinlUgW5dXem/EheL+201CU?=
 =?us-ascii?Q?wQPtGypA9h6EtJxs+ZFuHytwJROdoMAl8brQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:01:09.8172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b28765b-6e76-418c-1d2d-08ddd5badca7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
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

Add new ioctl DRM_IOCTL_AMDGPU_GEM_BO_INFO.

This ioctl returns a list of bos with their handles, sizes,
and flags and domains.

This ioctl is meant to be used during CRIU checkpoint and
provide information needed to reconstruct the bos
in CRIU restore.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 73 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
 include/uapi/drm/amdgpu_drm.h           | 33 +++++++++++
 4 files changed, 109 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4ff3a2eaaf55..9ee4644b508d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3031,6 +3031,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_BO_INFO, amdgpu_gem_bo_info_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e3f65977eeee..ec80b751e697 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1032,6 +1032,79 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+/**
+ * drm_amdgpu_gem_bo_info_ioctl - get information about a process' buffer objects
+ *
+ * @dev: drm device pointer
+ * @data: drm_amdgpu_criu_bo_info_args
+ * @filp: drm file pointer
+ *
+ * num_bos is set as an input to the size of the bo_buckets array.
+ * num_bos is sent back as output as the number of bos in the process.
+ * If that number is larger than the size of the array, the ioctl must
+ * be retried.
+ *
+ * Returns:
+ * 0 for success, -errno for errors.
+ */
+int amdgpu_gem_bo_info_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp)
+{
+	struct drm_amdgpu_gem_bo_info *args = data;
+	struct drm_amdgpu_gem_bo_info_bucket *bo_buckets;
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
+	if (args->num_bos < num_bos) {
+		args->num_bos = num_bos;
+		return 0;
+	}
+	args->num_bos = num_bos;
+	if (num_bos == 0)
+		return 0;
+
+	bo_buckets = kvcalloc(num_bos, sizeof(*bo_buckets), GFP_KERNEL);
+	if (!bo_buckets)
+		return -ENOMEM;
+
+	spin_lock(&filp->table_lock);
+	idr_for_each_entry(&filp->object_idr, gobj, id) {
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+		struct drm_amdgpu_gem_bo_info_bucket *bo_bucket;
+
+		bo_bucket = &bo_buckets[bo_index];
+
+		bo_bucket->size = amdgpu_bo_size(bo);
+		bo_bucket->alloc_flags = bo->flags & (~AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE);
+		bo_bucket->preferred_domains = bo->preferred_domains;
+		bo_bucket->gem_handle = id;
+
+		if (bo->tbo.base.import_attach)
+			bo_bucket->flags |= AMDGPU_GEM_BO_INFO_FLAG_IS_IMPORT;
+
+		bo_index += 1;
+	}
+	spin_unlock(&filp->table_lock);
+
+	ret = copy_to_user((void __user *)args->bo_buckets, bo_buckets, num_bos * sizeof(*bo_buckets));
+	if (ret) {
+		pr_debug("Failed to copy BO information to user\n");
+		ret = -EFAULT;
+	}
+
+	kvfree(bo_buckets);
+
+	return ret;
+}
+
+
 static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
 				  int width,
 				  int cpp,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index b51e8f95ee86..d33b19fd1488 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -67,6 +67,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *filp);
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp);
+int amdgpu_gem_bo_info_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp);
 
 int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bdedbaccf776..1b3d2ba2f556 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -57,6 +57,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ		0x16
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
+#define DRM_AMDGPU_GEM_BO_INFO		0x19
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -77,6 +78,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
+#define DRM_IOCTL_AMDGPU_GEM_BO_INFO	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_BO_INFO, struct drm_amdgpu_gem_bo_info)
 
 /**
  * DOC: memory domains
@@ -811,6 +813,37 @@ struct drm_amdgpu_gem_op {
 	__u64	value;
 };
 
+#define AMDGPU_GEM_BO_INFO_FLAG_IS_IMPORT	(1 << 0)
+
+struct drm_amdgpu_gem_bo_info {
+	/* User pointer to array of drm_amdgpu_criu_bo_bucket */
+	__u64   bo_buckets;
+
+	/* IN: Size of bo_buckets buffer. OUT: Number of bos in process (if larger than size of buffer, must retry) */
+	__u32   num_bos;
+
+	__u32 padding;
+};
+
+struct drm_amdgpu_gem_bo_info_bucket {
+	/* Size of bo */
+	__u64 size;
+
+	/* GEM_CREATE flags for re-creation of buffer */
+	__u64 alloc_flags;
+
+	/* Pending how to handle this; provides information needed to remake the buffer on restore */
+	__u32 preferred_domains;
+
+	/* Currently just one flag: IS_IMPORT */
+	__u32 flags;
+
+	/* gem handle of buffer object */
+	__u32 gem_handle;
+
+	__u32 padding;
+};
+
 #define AMDGPU_VA_OP_MAP			1
 #define AMDGPU_VA_OP_UNMAP			2
 #define AMDGPU_VA_OP_CLEAR			3
-- 
2.34.1

