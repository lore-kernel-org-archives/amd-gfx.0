Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0904C87FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 15:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D34310E4FB;
	Mon, 11 Aug 2025 15:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hWq2bRH5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6438D10E114
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 15:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5rIyrKyEYuit9K4ndCqSK6Jn8f1fp/e9pWjJsxq6D7i3v6MkR8Xeu88Ix7Exc3pba7x/8ApsW6+B8rEVflsWNMA8Ux0MzIb98rdco/3gHpN7rg3JhTOCJs6rg38veU1C0STqT+pC22gUqv8t+mDxyq1C32wRJA7vTGTtG5XZauBYMQ+i78JKbrVbXEbE+H1o7BPvztGBICMQYu/aHVeIXiOj67CgOyaN+BenrZ70s2Y0t71AkNs/pvaZi05M6PnjxxX6drCRzGQtDe5/ucJ7nh4JSpXYw+UIarh/rFGeZbMp++Zbwl/Dib6shNaCqH3dHk0tpi6eGz4lreYdFtyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qloid16LQIWs4kX2mvkaYBVlXN3wNMUM1zBWO+eZwNc=;
 b=u/r36/PKLh0phZQ3YteiVg4ToPvMJtbN9PI5L2zJE8As0ewu3NgRQr9VHB0uwmLVCajnGuR0fzE5DKUNT5nOOjDGYwEmRxOaCcH9H7iCE/wKwWb3H2JX1/VCjE5312eMBYHnY4iH3t6mKZs0xvafG+OHwfTgW6f3a7WHVrZT8GfywBjU7aKJds7FQgbZHSm1QdrUdZoZSQIQMGpufNpa2v6D1jIFZ8HNuvN3iR4287vrq0G0h5JnhP4mVuLA3f/KRAZ5nQCiwRsDAmmt6/Xju5BDpGCUqq4Inpr/KmpQFSS3GkC22CNifvDM0X0pHtNNsuRVFmmRNsTpX/3ASB9zzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qloid16LQIWs4kX2mvkaYBVlXN3wNMUM1zBWO+eZwNc=;
 b=hWq2bRH5KzqBNn/hrHquk52CfM8ZCxQN3+My9/+3dg7Cia4PP1+wLNVx/a2SPkbcDcGZwAlGZ2Mwebh6Ar0FRPsRN9SNRtdUxvWEYq8Z6/zEGo0SzaJqFHLB7mk809G6sSTCSqnrCYL3eRpUF4LURbQ8j2TMu3tFBBQMHFGoxOM=
Received: from SJ0PR03CA0148.namprd03.prod.outlook.com (2603:10b6:a03:33c::33)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 15:05:53 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::1e) by SJ0PR03CA0148.outlook.office365.com
 (2603:10b6:a03:33c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 15:05:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 15:05:52 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 10:05:51 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v12 1/3] drm/amdgpu: Add ioctl to get all gem handles for a
 process
Date: Mon, 11 Aug 2025 11:05:34 -0400
Message-ID: <20250811150536.3394262-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811150536.3394262-1-David.Francis@amd.com>
References: <20250811150536.3394262-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c394f4-7fc9-4fe8-1d3e-08ddd8e89096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c5jUILwfmZDgoxZLSmS5/WmXjvXa1cLGBKtTiZwtyI+A02wvJBN7rpR8OO68?=
 =?us-ascii?Q?64aydgW8fZjfx6v9QWiawvQyGo/eGsh8jRrbCH+idySEfY7p6b2gvUuWUBck?=
 =?us-ascii?Q?GWzzcNKppy/Ajzw6VPZTJYacXCh6VPE6O9XyqQHjv+Wdsgcyx/GYn8vFK4GT?=
 =?us-ascii?Q?lZYfUS/mGaC4UyGpBbz+AHjdbzMbLKtY/3wa8hZTTASvfhzyrlaApSi4hfxJ?=
 =?us-ascii?Q?H//XnWJcfkU7HzhIh24tSK/3Q0G4S4FPC708nc5WubH+3Gh2cRqKN/Z6hVX3?=
 =?us-ascii?Q?DXrffwW6Byhf97N6VGvUjbYmc3s2sGYHBagIZ7Encs6IJzzdubn5tpkv/JWo?=
 =?us-ascii?Q?BHha6rJrbexddI/B28vZ9UzuGiSknjV3nX3+rQ8+Fe0rySVy3TAUeOf/u+kY?=
 =?us-ascii?Q?EhwYSgUP0O8IkqW6/MyBgbBRnraH+Hjho3WNN2ljLOpFzyFXE+KX5X1zhx/v?=
 =?us-ascii?Q?ueKfKUWM6JTZJPYx4dGr8fgs0qInoXE5JJQuYolThNQ3ezM7efhznT/3JuDN?=
 =?us-ascii?Q?kw0WtRv1hZyY21l4SaBfITCP6XMuOs/kyf1hRwPrRGLSP8H870/7QYJBofWL?=
 =?us-ascii?Q?macZNjejl3JP2b+j7hWl+GLY6rNx3HC126B0RhosThwPfQdv6zqCOxcyTkAg?=
 =?us-ascii?Q?C6zRv7LJa8KrEn5TepHpN9jGEw3dCg0DSxl/x+g29o/TDZ+0H/4zCAlr55Tw?=
 =?us-ascii?Q?tkC1o7cZoS62FxD4va7qWiE8OQbjSRzyMW+srYFgDtMfsSBEb80oqv16YIck?=
 =?us-ascii?Q?tEFJ34kSsNBvUh9gzG3QpuLf9cSGJHWqzgfQyOVoZf2M3cIcGLMO0XYyP5Ko?=
 =?us-ascii?Q?HKzIwjUfSauj+DIotAbIfilPXP0cyXXs+MTT9JAh1PekzAqyL/TZuu0VdNBI?=
 =?us-ascii?Q?UF6g3m66MRzmJVGTz7JJbsd5AzX4h7MNSis270UqJcjqL2d4W8gOAXbC0hfR?=
 =?us-ascii?Q?ItFYo9na5R/DiopPIxQ2mWkgKkZCf6o5dBZ9XT3GhnWHfepPgfHH8S8U71Kt?=
 =?us-ascii?Q?yN8UTk2HFE8pFRZXXBf4zOd6vZNt0jez6K05Y9+VEjsFEpBn+EFtqLqel5n8?=
 =?us-ascii?Q?6bOO+6kafOCoj54KwFpAQDV8caO4YHLMNGWkT1Fqz3V/xdTsISCMtVC5220W?=
 =?us-ascii?Q?HSAHDtTZZpa/MbnMKuv+fIij8vEbb6jZc678tsFQk1gw1WX4KNSEoEuF0tot?=
 =?us-ascii?Q?/NSTFTdnNQRFO07CiFdf3d1wFUmcPmqUz4I8iLh7peF5TVLg+qODlbCJ13Ji?=
 =?us-ascii?Q?R+j2I62gPhW9yjpdGm77almAKb8JA006ixBE0VTVZHPhCLa0FkFkAIAmCsRz?=
 =?us-ascii?Q?fQyLPkZJnWmXuUwsxUYZqx//gjpLPY9Zp/9msiPm/R0rP9vl4uKIGjg2nhJU?=
 =?us-ascii?Q?vXyMUf0LM/Jjp8AAE4cAxmZwpxI9JsyD+3VbC+mgx3NUQhKQgLlAserQUWZY?=
 =?us-ascii?Q?21VxBW6yvlA/ExebgDJnxWYNLesc+fxxQO05GWUpN8DWTLUrX23CvWSBTU3K?=
 =?us-ascii?Q?YRNBKS0lFVmTvDanzUEy1PTU1rsLHYT/hKz7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:05:52.5506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c394f4-7fc9-4fe8-1d3e-08ddd8e89096
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 83 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
 include/uapi/drm/amdgpu_drm.h           | 31 +++++++++
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
index e3f65977eeee..3873d2c19b4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1032,6 +1032,89 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+/**
+ * drm_amdgpu_gem_list_handles_ioctl - get information about a process' buffer objects
+ *
+ * @dev: drm device pointer
+ * @data: drm_amdgpu_gem_list_handles
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
+		bo_entry->alloc_flags = bo->flags & (~AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE);
+		/* WIPE_ON_RELEASE is set automatically in the driver; it is not permitted in
+		 * BO creation. In the interest of giving the user exactly the flags they need
+		 * to recreate the BO, clear it.
+		 */
+		bo_entry->preferred_domains = bo->preferred_domains;
+		bo_entry->gem_handle = id;
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
index b51e8f95ee86..7cdb6237bb92 100644
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
index bdedbaccf776..59b423883e91 100644
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
@@ -811,6 +813,35 @@ struct drm_amdgpu_gem_op {
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
+};
+
 #define AMDGPU_VA_OP_MAP			1
 #define AMDGPU_VA_OP_UNMAP			2
 #define AMDGPU_VA_OP_CLEAR			3
-- 
2.34.1

