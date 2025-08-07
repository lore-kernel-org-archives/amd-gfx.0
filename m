Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D8EC87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 20:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26D3F10E48D;
	Thu,  7 Aug 2025 20:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D7OwLkc9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4FA710E48D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 20:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLf7zvTVcWMiabT+CeLwkg+hWvZZdDO4pc1hKte+yksTiWVr8hL3B1mfa14avUQNOyvSg9vDs3z6A7ELdenczyDhDhbeeRqf3ljvUYWQyAuFYQJsuiPKu/flFROrC4yCkZmNXNTs0FrabPag/1oKFKy8FcIE2iyLa8WrNdevBpMZGz3spwxrGiJUX0oo01D7+VfWKJlsA6iBh1916kKdHBytwINzNzJ33trq1W+pt39Owa2+5y1D1EwG3dEhJWYumofXxv+ZIVQnKEge7oslQrZ4wyg1EuHdNitxRlSQC8LLegQalSbE4bTyTi4otMGD8z5133YdTAnJdflcCFJ0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8rFKS6uPUhQSSAs1djqXfsfBTgu08+SfhEg3yKwnDk=;
 b=nLLytft5TSJTq4jJee0gaU5lpZcbiqFYu45bCLuGXaVU8sFYrXnyT+/N0BDyAYKl2Qi3VNqQWvgFR2VvnKGypeuELaBPx6djwuRaHXAc7s2qBCzaNFjVvEaVceylazva11Nx5O3L38FrlyKhoU12j8WKqUYrUsWX7RHTiWsXs8WZtHEy5x6KWX5JhMRZt94v6dcRzWsuHBe9cxD541+tqJpE2Nn6eJGu0uxWDgTNZNIubVOLSChcm80KG5TJWdvKIiO3ucsN21TKUXxzYV6IkMyFIragXSHZSs2v7omeGYj/fhgOnu2YrXfxGsiajDW7IeUMMwfnwAhQ8OJl4AsfPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8rFKS6uPUhQSSAs1djqXfsfBTgu08+SfhEg3yKwnDk=;
 b=D7OwLkc90rAmn/5/685csDmPn7oifKb8PyHvv5qr7YbdBR3HiugyDTHzl+uN6Ebz5vG5hlzYhaOfiGEAYZ8HwSGUIJxLGzxcbA0eS7oWSq5fjgdVZ7hOcJ4mhnELxJjWlKtpruEA6jtZUX6AQ20Ia37YKRU0eKviTxiJAF4CEO4=
Received: from BL0PR01CA0019.prod.exchangelabs.com (2603:10b6:208:71::32) by
 IA0PPFA8EB66EE9.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bde) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 7 Aug
 2025 20:23:10 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::d8) by BL0PR01CA0019.outlook.office365.com
 (2603:10b6:208:71::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Thu,
 7 Aug 2025 20:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 20:23:10 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 15:23:08 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v11 1/3] drm/amdgpu: Add ioctl to get all gem handles for a
 process
Date: Thu, 7 Aug 2025 16:22:43 -0400
Message-ID: <20250807202245.2970262-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807202245.2970262-1-David.Francis@amd.com>
References: <20250807202245.2970262-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|IA0PPFA8EB66EE9:EE_
X-MS-Office365-Filtering-Correlation-Id: 99effcdc-e8ea-4370-bd30-08ddd5f03a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ID0I5winyYWBND+TGdLx06lMbih9dwkOv4TiPKa2sNzf1nwFZF0U9ff2KvYM?=
 =?us-ascii?Q?dSH6yDfQn1TIlULo0mTm4AEvxUFuEIBKX5SG73+FdQ9vWjl++uQSfJpWddrp?=
 =?us-ascii?Q?qh6Xf4H1Bl6pAs6r4yDD/OkI7JnrHk4trn4UmnHz0uwHY2SO7f+0W7jvrIsl?=
 =?us-ascii?Q?V91E8YEtDjgPMEVTVN2qwicxHHpsrthh++LBPtTLcGDDKPazatx1noAeVNPX?=
 =?us-ascii?Q?L9TkBhJX038jyQKryRIDkWzdZFT66nOcffccG0skAHGMMjTD9oRXQjwdK2UT?=
 =?us-ascii?Q?a4yF6f3ijVGQYw0GHzy82VoKDcSc9jGdyr8G65amyghsw/yxgbo4QZQVRpH0?=
 =?us-ascii?Q?cN01RWTNxYRuzyRsGWypGqdVp9kM3jr238NtZBIiilbPUBOQI9b/OpybH3Ts?=
 =?us-ascii?Q?SURGczG/Jc/0HM8L0Z79giJc8dVW5CqEt9NxDdkOE+XOIRsL04q+P652nWC4?=
 =?us-ascii?Q?73JlJOrB0xDEhx1YNeWU7eVvhdulo4WP2sUfpGS3XWAZGA6l79IBppWCXJke?=
 =?us-ascii?Q?mZ+ksYDtowy2iRrgXf+80CRXzet2xRF14HzRC18I28R//vs3P6obcIPNRL/5?=
 =?us-ascii?Q?wpcyBMv0BDBv4ty4AxjyJx5PrM/kdid69W/Sq/tPHjU1ItVyE9OBn87kGWAU?=
 =?us-ascii?Q?VtbxrOuZ7m1csQa/MS2uGEuKDU1/Et1UvkCdOOTEiV7Ns16QeC4RmOaFkz6d?=
 =?us-ascii?Q?NUE1FIYrUDdmlLdcmL/2nhofWuQIGy+OXSuCL5zAEiORKlJt/2XFgXjdDlHN?=
 =?us-ascii?Q?Gkf8gCiZW6gMwjlKnSaQIG4J5TE/3l/lA+GsHqSqZF6tNJVGeTleqWr4aqvS?=
 =?us-ascii?Q?Nbe9J0jSGvEt8E7lxasRJCaa/fSXrRxeZvGMXdiUCUxFgcofPsEySrHYq0GO?=
 =?us-ascii?Q?xNfdD3bIwvORhlzE6dLXsBBUrelq5H4Oka8K76uUbhG/oAZ3ajo7z4Ag+0JB?=
 =?us-ascii?Q?Ofc/iwoSEFAlooiohdx3Bv4aLLaUAq2hq/XYntkoa7QF2iyAT4s8D/NaU0fn?=
 =?us-ascii?Q?atU/PROC6J7+Ep//Rg2OrDO+PWownGZLKyibE6XGkZi/vWLjQEsgts1F3BBv?=
 =?us-ascii?Q?XVZpeuWG/3Sr6Fqw3B6w1LljCJWIllLxVoIIPOXDrbRgUGhJVZI42EL7WCKy?=
 =?us-ascii?Q?0RKeGZ8CPyQevxfYsI7LpL691RcLRJgMjqR8fHxYBG/QRQZHIp3ZfncNn9dd?=
 =?us-ascii?Q?Vd/c+gT80MZiNK8qHubAvx94sM9B+Rnr78ow6OykNs+DQp2Ff6sjvvc3qxiD?=
 =?us-ascii?Q?CjxR2X3+XypEzcHDVjAWlOTdmzTGgZgnq20bq4pgOlZjMzh/+4dYt65xndI4?=
 =?us-ascii?Q?7AnJHN9Ng1LpswALnRwM8FJJorphsKuFGDmMjm0g5ZJ99ABNeVFYixfXRWGP?=
 =?us-ascii?Q?9aKYnLu9XcpVI++1PdaEs+Pf1nZSgbCfC3Riae31sB6RzzMFDJuY1iqqZunD?=
 =?us-ascii?Q?JHr7EogCRPUB81fSWPSSRY6Inuv3ggIq7RCum+E3iNuyomXKTAI1G2t7JNvK?=
 =?us-ascii?Q?NFbjumsDf/7YXtBrGGOog9BI+Ie57JjYGrGn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 20:23:10.1979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99effcdc-e8ea-4370-bd30-08ddd5f03a3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA8EB66EE9
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 82 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
 include/uapi/drm/amdgpu_drm.h           | 33 ++++++++++
 4 files changed, 118 insertions(+)

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
index e3f65977eeee..7f55e3b7d8a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1032,6 +1032,88 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
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
+	args->num_entries = num_bos;
+	if (num_bos == 0)
+		return 0;
+
+	bo_entries = kvcalloc(num_bos, sizeof(*bo_entries), GFP_KERNEL);
+	if (!bo_entries) {
+		ret = -ENOMEM;
+		goto exit_free;
+	}
+
+	spin_lock(&filp->table_lock);
+	idr_for_each_entry(&filp->object_idr, gobj, id) {
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+		struct drm_amdgpu_gem_list_handles_entry *bo_entry;
+
+		if (bo_index >= num_bos) {
+			ret = -EINVAL;
+			break;
+		}
+
+		bo_entry = &bo_entries[bo_index];
+
+		bo_entry->size = amdgpu_bo_size(bo);
+		bo_entry->alloc_flags = bo->flags & (~AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE);
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
+	if (!ret) {
+		ret = copy_to_user((void __user *)args->entries, bo_entries, num_bos * sizeof(*bo_entries));
+		if (ret) {
+			pr_debug("Failed to copy BO information to user\n");
+			ret = -EFAULT;
+		}
+	}
+exit_free:
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
index bdedbaccf776..218a179818d4 100644
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
@@ -811,6 +813,37 @@ struct drm_amdgpu_gem_op {
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
+	/* Pending how to handle this; provides information needed to remake the buffer on restore */
+	__u32 preferred_domains;
+
+	/* Size of bo */
+	__u64 size;
+
+	/* GEM_CREATE flags for re-creation of buffer */
+	__u64 alloc_flags;
+
+	/* Currently just one flag: IS_IMPORT */
+	__u32 flags;
+
+	__u32 padding;
+};
+
 #define AMDGPU_VA_OP_MAP			1
 #define AMDGPU_VA_OP_UNMAP			2
 #define AMDGPU_VA_OP_CLEAR			3
-- 
2.34.1

