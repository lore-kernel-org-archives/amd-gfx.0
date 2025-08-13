Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EECCA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 18:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2966D10E792;
	Wed, 13 Aug 2025 18:50:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zf/1OOf2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D9110E792
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 18:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aY4q2asS87zaJ/lCxfHel7ZWQvfN848iGEJ8/nt743d0+yXg6ZiX/AGx/g2lYDK0Qey+YFsYTiVHfvPB93Q69a+Ox/8lDvMiNhG0qyFhzlrJhIQxyMjT14MiZIbaay8EutHrGZ53vujmhk2PMJWDP63guN/vFcgiF8+6bPH5LUqJxf+dUGA9LzVGWz67sxbU0RU96MBIRqTjblkTybdOjZh0n0ANnvpvo7HaqsHzg9KOOUhh8i0BMcl71WZBroGc+SAQYTFTIB0fNssUsi7xVvTEEJ1ib3ECkAgcIVgERHmU4nmvVnEmEOOLdSwEITb5EXgTcp3NA/TpbAA6ANRExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fda+qZP/TfrAcKpOWn0RVPkdJLJuupqvy7HVBmr3Pio=;
 b=DsaB/5ekkD/Uz+S5ruOJ7PZY/QYkQL4u/MKtvtYNcK86/tgZgqO75Ciq7mF0ssu25CUiJZc53ZuKoXN3ztgnkWy0Q/sFiAlYSjyZ9DZbl9m42cVb50hdoJHDet3L9h1cKi89+RSXX57N791Qrj0LvIiy8roLRh9v2s9Vt9QuI/MKCXAiLLShhZ8dOpBZT6UwSPGWWZGevMM+5rC/aeiTh9pDb1mUSEaFlqzFJksM/prziNrknYCg4NgngpH7C/3S6M+/cfaElVQHGxRGBtmc27CoWdfSW6p3j07yAmbfNA1YQn9tAIiN7NXNzuZ3+QzWmrAPRHjlx1kCzYDxqbJRFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fda+qZP/TfrAcKpOWn0RVPkdJLJuupqvy7HVBmr3Pio=;
 b=zf/1OOf2K5FiHbSKWdpPmXDTxFIX+myQVSZz67QSEjDcKdmEMS5YYklVVynw66/YfMUBA8yxa02wuApfb+e5hnmESRyLHgNmzklQ6eK8jKawhMw1FEqvEH+hnQ89QgmAyepT06qSyqv85Xq8h5JjucKGaUqjDXvdbCpgQiKdsQs=
Received: from SJ0PR03CA0343.namprd03.prod.outlook.com (2603:10b6:a03:39c::18)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 18:50:12 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::b8) by SJ0PR03CA0343.outlook.office365.com
 (2603:10b6:a03:39c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 18:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 18:50:12 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 13:50:08 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v14 2/4] drm/amdgpu: Add ioctl to get all gem handles for a
 process
Date: Wed, 13 Aug 2025 14:49:51 -0400
Message-ID: <20250813184953.3666821-3-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813184953.3666821-1-David.Francis@amd.com>
References: <20250813184953.3666821-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 29591891-745e-4977-ce6e-08ddda9a3bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NCzNDBwoIWW7PD7W0vcL7LKlME8EKASFzXp2g6i/F9bNSmiz1+k9Cuf9KFqZ?=
 =?us-ascii?Q?1BnYVOGEAtTsIXZehmPF/SWo2DLKmQgvaWR42p2tvMN1V4dFXuLoBb5UoAri?=
 =?us-ascii?Q?gkHZU6SIP+6xA5Ipst3ZUjnuMfphEIOLiBzgCIfuIuDtkU+BgmRnDRm3Ph0F?=
 =?us-ascii?Q?H4KTxSRPsWdgLUK3frer6C2fQbNAFYl+qYcdAKTD0FjNXuLmxSdJggRijsl5?=
 =?us-ascii?Q?6cxQncntA0TfSveGYec+ut7Kcz0HBAJU9WgzdhIkPkcpO72ebt6MP+rCzSGS?=
 =?us-ascii?Q?eMZ4pywrB/aRZ3J8j8tHOQiYYzEGFspAZtSvVoSB9rGYoNScgO+If6eMj9Pw?=
 =?us-ascii?Q?BQHBYydvACtGx4Aq4Jku9emCJFfM9Gq4e2V4i72N9W27/L7X0hsx5g58ENd8?=
 =?us-ascii?Q?CknXUQ1LRHrerhQod/R54IyVPyn7viWL94U7qbV1G4q7JqZrtdP6wOurbBdG?=
 =?us-ascii?Q?jEdpbzyQI3HOl+ivaY0IaPBoEH9bdFbPNMrwpWDNMnLT5Sqy0ii3SGYio/Pi?=
 =?us-ascii?Q?A2RoB1ayrrqdbQVMRhe2+e9i5fwCYtuoQDYwjJuw18T1dKnTkh2BGZ+1+AeE?=
 =?us-ascii?Q?6Npv+oBd1q15w0CpQ2RGQ3yyoJbUE2FvZ79HQRSE0vhIE4oABu1s2KyrLeHH?=
 =?us-ascii?Q?D68eMjFYlBknZ5AZrLywDm6IqLFV7PzTzLSSVQwAlNOQxklK+0gsUGuWdcal?=
 =?us-ascii?Q?pVPakWRhoIW66063His4k3TKXNaWdnQYY0E3r//LaI9RwWCE6KqPMuIYhzE+?=
 =?us-ascii?Q?ScFp/mRVrtOxUu+myWHBlodwQOvATJfskq62D0Me4f8O4SbfGpXDBxxiHpNQ?=
 =?us-ascii?Q?bc+YK2+8htBlVcVqIvFNgN4gDPVLEGKH6CNc7sJbLiNMDomzoKUFWPP9+T0S?=
 =?us-ascii?Q?dLSCdRsJvOuYR4BnaeIqv3s0qPsQcjPD8fyz8WyzMzkBmDRfAESpgx+HMY82?=
 =?us-ascii?Q?AqjcMN3TZ5dFhWJBd9nT0uaC9P0NjRYDnFIbGa077YItj0efgU8N+IAUnxdM?=
 =?us-ascii?Q?rIgI/GMiKlaSdAgm38CaR1p4BkL/Y7X5RlsZbqRgkcBpN6WUBJfzAmbPArjS?=
 =?us-ascii?Q?T8opbFZHsJkDtvZkulVl6SsFfcOjMdpqsFvzBFTaUjU5BHV4XxfE3RrOkp44?=
 =?us-ascii?Q?02rB+eyqgjuROT5l+HHEIrkoPHvOEP1dJNUfnj3Z4xvJtS8el/lmRnrHLuI4?=
 =?us-ascii?Q?s4eludK8DXVnbtY/SIcvjD6yiO+5osTX+yiyulAkLaYee+m4Q43oa711twsz?=
 =?us-ascii?Q?03ySFmRm0c0lj13uTHjHiPhSNbEoqkOkq3GeMTwXPkbx6dhgXWpZtuy3RY71?=
 =?us-ascii?Q?5pLXYRwJmqYLeHR1l+6tmeYV14M6wR0Tf1z2gTd6ijD1K0GDO5Z8CXyjoF25?=
 =?us-ascii?Q?6mdYTGbx9daxveY/Dz+LYsOSRAIQevPvz0weyjFioPaqWmdUjPArne7PmZ0H?=
 =?us-ascii?Q?vSdFebdEnkIN7HioulMMkJkVUwotv5RVMfWnb6qd6nQ1vurLyYOuPmksXnR2?=
 =?us-ascii?Q?H3th1nbDNhKHbISKafNnhJfvzc5kMpwdSpS7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:50:12.1891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29591891-745e-4977-ce6e-08ddda9a3bfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 79 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
 include/uapi/drm/amdgpu_drm.h           | 31 ++++++++++
 4 files changed, 113 insertions(+)

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
index aefae3a9e6f4..d17cc7ba66d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1024,6 +1024,85 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
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

