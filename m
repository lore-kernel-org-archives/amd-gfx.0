Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DA3C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 09:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82BB10E30F;
	Mon, 16 Jun 2025 09:39:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gO87TQzE";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6DD010E30D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 09:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPir+7aFbzgmebWpmonxmWSQJwSJ2lboXwXBsX2ZZ1KL1Lvr5v7kGKSkfslOrk7MM/UqZNcl/9AR+K+6B0/x8px5C47TGvUlKh8gRTYMLNs1lc5OTYPbYPRG1xxVLyYWZyuaqb1tDetRRYBt7cOFMkGWWtvw8mW9hhL9ragvXjzhkrX3GiKZc+Qp328f/EbJfb1t9JkfM1vrLJjGjCnFUFI67Hm6hzg884QAG845yXURWHd4sWG+lwuX22AeT43/P3VcwdvnRWlOaCL+P5if8SwNhOf2FBxA72SGtVFWUIrDKh3Y7DlJFNpZ6fVLyHjsAJO0Zh8VMuCM3TMcAn0Msg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCtcStWVmjKFIlip8yC1zE8+FYm0lP9mIAsL2V0wF3I=;
 b=tEwh8+dISaib3XYGIkjI+/f3IdgsDFrmx/BWdy3DRga8CSJdtRruUI7132fjii4nrzfI8kaD41f+Zh7qIwakbkVvLVmpZdBP8oJzoKkSEh5wrac/jTrrUjcgpWrNAgeoIL77sJ//6t0dAna02CstdN8HeRQxBccxaAP4x/sEMqfmwH0Y43WM8x1FF2klc2C/b8A5vJsB6Vurfch8PYtroL4T/lu3D/tyMUz1P9rmqD56bderpz1vrOG61Pbxuor5rEIgvrC22cP48H4kvzV65/H3SWUM2DJVtP/H+UwjSbu+4d9gElUtJoI5CvVEUZc8SVV7AgQgtev64NwDda9gpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCtcStWVmjKFIlip8yC1zE8+FYm0lP9mIAsL2V0wF3I=;
 b=gO87TQzEHyicA9fhy/38o4xIqAHKna+vBoYI4bp1Am22yxVBcjjkZ8bVotlVxb19HU0lsNc/kcwDL2gsVsQNXnkPSt788DYfqbNIocI0BH6XINIb0qy/pOTisl0ZXXRLCOqEhxM6bVbkLQoPRoSP2FRXNidHBgueWLfMnlax5OA=
Received: from CH5P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::11)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 09:39:04 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::d0) by CH5P221CA0020.outlook.office365.com
 (2603:10b6:610:1f2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 09:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:39:03 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Jun 2025 04:38:58 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Le Ma
 <Le.Ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 03/10] drm/amdgpu: Convert select_sched into a common helper v3
Date: Mon, 16 Jun 2025 17:37:49 +0800
Message-ID: <20250616093756.16200-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250616093756.16200-1-Hawking.Zhang@amd.com>
References: <20250616093756.16200-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cdf095b-8f57-4133-d998-08ddacb9a185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VEYQaLokkxDPm5o8HmIsHwKUXjOBFCh1IparzeiYhK7KVASnJnATNty1Zr88?=
 =?us-ascii?Q?nXaOs3ybpW5FUJ1Ub0TpPcs9dSASYpqh9nqCaFKZsYxDeRbcoqj7oUshXooc?=
 =?us-ascii?Q?eDNHW9g8FDQmJ6FObdQ01KCBvl2pgb8iYWcjZGMuxVBQqHiN0n01BwoKuh4W?=
 =?us-ascii?Q?JRyOL9xjUKdOuCkXuSry4v9h+Wj92PriYgHSqCQ0ei8taEVUe3gGg8G7rTDp?=
 =?us-ascii?Q?GBi71jw/wcEMn0qsyPNzRO2ywITIJRmYyxz9T8XoCY0ir5QaMlJdnwRLKDvf?=
 =?us-ascii?Q?+3dibSlv7QwrTPZML0L/GKmfDPbfQ2lL4BAC9d5DpIuvnWtM90fQ/M1gPEZr?=
 =?us-ascii?Q?zrE0Usn1StfHCUbp9HQWxT5RmMPwnev8ismwVziC/gZTt8oUFf+hXo7bwQAB?=
 =?us-ascii?Q?HcXW0HLkSvlsFoQWSz8ZHvPy7f9oXJ6/80B5Ug8KcJeiAsVNzvG0JIhxcSe9?=
 =?us-ascii?Q?VwJZRE19D2sdUpMNXFTYlQOhCftDKyknV27CbrvO8Tdfgva9EuVfRJx+wJcv?=
 =?us-ascii?Q?YPWOgBSjUvKNAwDMrsy/G3ERq9P79sYm4WEqw2dxlFSdI8zUh5L3BUCeG85R?=
 =?us-ascii?Q?13I07gX0YBrrmunn/4klC2cbC6BN+qBTUN6yqXhCnDggpCmXUfufna0f6Y09?=
 =?us-ascii?Q?CWxvtEY0V7YPPU5sb6LTgUcgIvlWpp0oX3+FQ5K14sdVzN+966js0o6nTND4?=
 =?us-ascii?Q?rhSh+2Z651iwqa6wSqzJCIRpZxYwndWcx4lTsN74ccKZvxU2BCLa5X9H44Ri?=
 =?us-ascii?Q?z6Dct3DBkMQiwPyFZcawnWZLzNUhJ+V52E8Dg/lYcFJSUs4SzzWcXiQt8Gr/?=
 =?us-ascii?Q?LYyn4riCwz03pZE2hRpfF0zdCrxdfFhJ2qlW6QiCVk+yphn02UR/s2IG08n0?=
 =?us-ascii?Q?WB69w/LnLAYmv8Q0Pmg2yaCFKgjJJy4wkfaJuQHv2gQDtVgy9J6VIj0llaS+?=
 =?us-ascii?Q?ZWhqiKG0zgyALcLrItEP+ZWAEj28OpoU+Qse0Fy0JyyvwiKLwVQ/LSvWJn1t?=
 =?us-ascii?Q?09TWaylTX7xq8PNoE/EyLW2u06FzEOL9VEKUcKW6CbTTW0gtcKu6IU2yRKp2?=
 =?us-ascii?Q?o291QlfZ4z5DVVZHdcFihyuIRdU/aXhkfDd7DOOWP49me7BcGsQFWZ9buC3z?=
 =?us-ascii?Q?zGDgIPE7g8KZxIDQQfbyO9TOzFUakeUW7t27+UChiMfjkgsGzE2GC6EQBWqe?=
 =?us-ascii?Q?IksoI7wpoVYBMmHbYXWmh+a49Iy7GrSw8hQMBuFygdU97/S+qb5xbwd8DdqV?=
 =?us-ascii?Q?vsxmqUv0ti6OJhJb33wteOL+OoVylvDxvWFB9VUK5H7vi9ok1SVRRb+xQLJ8?=
 =?us-ascii?Q?uzKYJ5i4g/ex7KCJYCnhPgEutYovGaVLiBSuXIKJo/ZNxZYVYKJVnmW26e35?=
 =?us-ascii?Q?Vnm/IieESntpAY4ZWD9vk9IELFGYyAjlJTlEbExhoxJu4czcoDBNcYwOhdUz?=
 =?us-ascii?Q?PJAaUtDEck5YRaCRZVh2Y17y43w/cNp70rOXlOeR4xtkeuVrDFiLhe+1N0br?=
 =?us-ascii?Q?8H/oNDIHXawb4exsU1JSMpG7XmmJFJYmb9Ro?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:39:03.4489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdf095b-8f57-4133-d998-08ddacb9a185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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

The xcp select_sched function does not need to
remain as a soc specific callback. It can be reused
for future products

v2: bypass the function if xcp_mgr is not available (Likun)

v3: Let caller check the availability of xcp mgr (Lijo)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 38 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 13 +++----
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 41 ----------------------
 3 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 322816805bfb..5530166f1b23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -445,6 +445,44 @@ void amdgpu_xcp_release_sched(struct amdgpu_device *adev,
 	}
 }
 
+int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
+			     u32 hw_ip, u32 hw_prio,
+			     struct amdgpu_fpriv *fpriv,
+			     unsigned int *num_scheds,
+			     struct drm_gpu_scheduler ***scheds)
+{
+	u32 sel_xcp_id;
+	int i;
+
+	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION) {
+		u32 least_ref_cnt = ~0;
+
+		fpriv->xcp_id = 0;
+		for (i = 0; i < adev->xcp_mgr->num_xcps; i++) {
+			u32 total_ref_cnt;
+
+			total_ref_cnt = atomic_read(&adev->xcp_mgr->xcp[i].ref_cnt);
+			if (total_ref_cnt < least_ref_cnt) {
+				fpriv->xcp_id = i;
+				least_ref_cnt = total_ref_cnt;
+			}
+		}
+	}
+	sel_xcp_id = fpriv->xcp_id;
+
+	if (adev->xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip][hw_prio].num_scheds) {
+		*num_scheds = adev->xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip][hw_prio].num_scheds;
+		*scheds = adev->xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip][hw_prio].sched;
+		atomic_inc(&adev->xcp_mgr->xcp[sel_xcp_id].ref_cnt);
+		dev_dbg(adev->dev, "Selected partition #%d", sel_xcp_id);
+	} else {
+		dev_err(adev->dev, "Failed to schedule partition #%d.", sel_xcp_id);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 /*====================== xcp sysfs - configuration ======================*/
 #define XCP_CFG_SYSFS_RES_ATTR_SHOW(_name)                         \
 	static ssize_t amdgpu_xcp_res_sysfs_##_name##_show(        \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 454b33f889fb..0ae4f14293bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -144,9 +144,6 @@ struct amdgpu_xcp_mgr_funcs {
 	int (*suspend)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
 	int (*prepare_resume)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
 	int (*resume)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
-	int (*select_scheds)(struct amdgpu_device *adev,
-				  u32 hw_ip, u32 hw_prio, struct amdgpu_fpriv *fpriv,
-				  unsigned int *num_scheds, struct drm_gpu_scheduler ***scheds);
 	int (*update_partition_sched_list)(struct amdgpu_device *adev);
 };
 
@@ -176,14 +173,14 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 			   struct drm_file *file_priv);
 void amdgpu_xcp_release_sched(struct amdgpu_device *adev,
 			      struct amdgpu_ctx_entity *entity);
-
+int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
+                             u32 hw_ip, u32 hw_prio,
+                             struct amdgpu_fpriv *fpriv,
+                             unsigned int *num_scheds,
+                             struct drm_gpu_scheduler ***scheds);
 void amdgpu_xcp_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_xcp_sysfs_fini(struct amdgpu_device *adev);
 
-#define amdgpu_xcp_select_scheds(adev, e, c, d, x, y) \
-	((adev)->xcp_mgr && (adev)->xcp_mgr->funcs && \
-	(adev)->xcp_mgr->funcs->select_scheds ? \
-	(adev)->xcp_mgr->funcs->select_scheds((adev), (e), (c), (d), (x), (y)) : -ENOENT)
 #define amdgpu_xcp_update_partition_sched_list(adev) \
 	((adev)->xcp_mgr && (adev)->xcp_mgr->funcs && \
 	(adev)->xcp_mgr->funcs->update_partition_sched_list ? \
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index c0043a553b7a..8a74b954855e 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -180,46 +180,6 @@ static int aqua_vanjaram_update_partition_sched_list(struct amdgpu_device *adev)
 	return aqua_vanjaram_xcp_sched_list_update(adev);
 }
 
-static int aqua_vanjaram_select_scheds(
-		struct amdgpu_device *adev,
-		u32 hw_ip,
-		u32 hw_prio,
-		struct amdgpu_fpriv *fpriv,
-		unsigned int *num_scheds,
-		struct drm_gpu_scheduler ***scheds)
-{
-	u32 sel_xcp_id;
-	int i;
-
-	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION) {
-		u32 least_ref_cnt = ~0;
-
-		fpriv->xcp_id = 0;
-		for (i = 0; i < adev->xcp_mgr->num_xcps; i++) {
-			u32 total_ref_cnt;
-
-			total_ref_cnt = atomic_read(&adev->xcp_mgr->xcp[i].ref_cnt);
-			if (total_ref_cnt < least_ref_cnt) {
-				fpriv->xcp_id = i;
-				least_ref_cnt = total_ref_cnt;
-			}
-		}
-	}
-	sel_xcp_id = fpriv->xcp_id;
-
-	if (adev->xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip][hw_prio].num_scheds) {
-		*num_scheds = adev->xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip][hw_prio].num_scheds;
-		*scheds = adev->xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip][hw_prio].sched;
-		atomic_inc(&adev->xcp_mgr->xcp[sel_xcp_id].ref_cnt);
-		DRM_DEBUG("Selected partition #%d", sel_xcp_id);
-	} else {
-		DRM_ERROR("Failed to schedule partition #%d.", sel_xcp_id);
-		return -ENOENT;
-	}
-
-	return 0;
-}
-
 /* Fixed pattern for smn addressing on different AIDs:
  *   bit[34]: indicate cross AID access
  *   bit[33:32]: indicate target AID id
@@ -731,7 +691,6 @@ struct amdgpu_xcp_mgr_funcs aqua_vanjaram_xcp_funcs = {
 	.get_ip_details = &aqua_vanjaram_get_xcp_ip_details,
 	.get_xcp_res_info = &aqua_vanjaram_get_xcp_res_info,
 	.get_xcp_mem_id = &aqua_vanjaram_get_xcp_mem_id,
-	.select_scheds = &aqua_vanjaram_select_scheds,
 	.update_partition_sched_list =
 		&aqua_vanjaram_update_partition_sched_list
 };
-- 
2.17.1

