Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8920CEFC21
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 15:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FECC10E580;
	Tue,  8 Oct 2024 15:30:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pAWzn27N";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EE7B10E580
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 15:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sq+C4VGVm7Sbo4i8ScKPS8QVmfFuYzxURjvxM2BzO/m0YJew1Duraat4L/MfZqZQ7wq+pOhGbdfyac5dtAbL71Exq8f3iBCJjnOl4TyOiEFBEjfO3O+K89igiTvudF2I9eZXzwlatpma2A7X3MsfavqFpomG28HFQtQEhTQbLy75w57twA4FKjiZk/YKgxJSeSwqIc/pvD8xpcqPj0ZdSYKLtXyujj53jnvQshm9cKx+wa3jvHBAN31NhC752/QC/7sjDg+sdiN+N31cJ9MTDViqmm2JUjy2ZPqoeD8+ylijIrDhcJFMp6xuiRGHDUuNmL6nQs7T5OaUkxYiPsG5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zI9xN5kr+0NmipQowsRgtHuK854YUiGD47+bL1J+QJo=;
 b=OL8cBGeE+dKJINh7+4zxfXKbnzC4MMnJA4PQLL/LlRqEyOnGvoejxji5XMwFhC3L2uOELjeEq+gWQQ32RmvNTgoV67zzLUvP0e1SLruH4OIGi198QKoB8alJH2NMbdPMngVdu+AKgHOD3xeTVwkSJLdmwRGpAYyJzsos4n5N60Gyf1CjODS6No5oEh7dpOpAepYaK8TtzlWhJbA/pNh5xI+nL5FVzkW97p3kDA74Rnfzr7Gpawgzvw1Mx/jdWPC6dgltVRKlCNnyhr9AuA9b5hUSzDgT5kkgZlNvOosKQjTZekxcF4aEsm+i+IV7cWZKciCFBCtRIllldfgVlnWsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI9xN5kr+0NmipQowsRgtHuK854YUiGD47+bL1J+QJo=;
 b=pAWzn27NaI3DjiDcrmTleojo9m9I7w8La2rCP6YFZcJpTAVdVZ9Sex2lUDxSvSNFGS+jqY5DcnIVeROWwTIJshyQJe361ZGQ2DZZR7qVPuki9RdwGxvIwTfcvqHAJP9BZ3FbdlgKu+ktwjm1nndo+IIWozrlteerO76M/SXe7w4=
Received: from MN0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:208:530::21)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 15:30:07 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:530:cafe::35) by MN0PR02CA0001.outlook.office365.com
 (2603:10b6:208:530::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 15:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 15:30:07 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 10:30:05 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH] drm/amdgpu: add new AMDGPU_INFO subquery for fw objects
Date: Tue, 8 Oct 2024 17:29:29 +0200
Message-ID: <20241008152929.734-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 84552338-58a2-4d94-2cc8-08dce7ae16f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hMy/cxLst8o1oM8i/URIAbD+XYw+yyVkrRTmRw1twl+olBe7uv5BxPqZGmdX?=
 =?us-ascii?Q?9OiuzmXhCFG2Z2aD1ad42fR4ngw+VQvXiSX/RxvICR6cda0worUY6cgZ1jUZ?=
 =?us-ascii?Q?z6kESKLZTxXsJ6yazEsiic21jO0HzyVEBZnIaAFP1AM/yoIcxsqrFqBOm2i3?=
 =?us-ascii?Q?LdoNqfl0SaDLx85u0mXrnl2vnXxgNxF2WmdWX3uqh37wBTDFcYM0w9Qt0hNU?=
 =?us-ascii?Q?9x/n7Wotq6eUeJLbZDGrOeIHrWMtyz7wmNaMslMhn83igc+Wkxn3VyRzCLON?=
 =?us-ascii?Q?Xd5NOl3vG4gQvqeEjHGa1yASkL8+4XIzIiRwGXmNS5JltUjxKOAdPCDaL70V?=
 =?us-ascii?Q?JLCnugEwgvJzQNE9niQk7tc7DAC2mjJsyVj8DWWfOCwXzP6NwvGlky1geP83?=
 =?us-ascii?Q?DO3wusDVMdqirDD4TpRvQfLNwg48OQALLP+9FEB+HTTSz2MD2yp0f5wGhIz1?=
 =?us-ascii?Q?GQqcYZCCOyiHoTS45Z1any3QzH0L6g6NjjuNELU8C1UNHAJQMC7bPhE7t7W0?=
 =?us-ascii?Q?E25CfmMn15OxHsI60saCsk/g3p9j98guT2c/9uxREMyBov7VOrKLsylVAgXS?=
 =?us-ascii?Q?7RWCsr63JMd+m17Tw5pMbHLr3dASy1gnCkjmTv1qKdtnyHA3sZjGBhWDzFhZ?=
 =?us-ascii?Q?UjMsyHPCGKlbbF9k55oAn3zGLx26M82KqeN2Dq+us7X17KvI4EL5g8ImkG8t?=
 =?us-ascii?Q?+XBzQ1tnt6hgGUOYwYd07g/R/2sQ9x/aOCUvvU9HYI2Kx9uRxjvMzVsQCdY2?=
 =?us-ascii?Q?ZabdNPVW8K0EdXZHetHTBsgRVqwE24InUZCnPm9fMLqbWxK1yg+ZFvayC03A?=
 =?us-ascii?Q?qgSDl/PKYRRX+JRJbuKqyz9r0nAiDGT7ANbkQndLcwktY4mVICorwV9thTQb?=
 =?us-ascii?Q?MvzhwcE/MV1UGkPGDmQ4Vp4Fojat6E21vNLBpGA4XrcI0ZLNnfzeoPD8XX7T?=
 =?us-ascii?Q?gaoxTWBqtbhFX06vjgOlVrweDVc3ysd81S+yCMnWuo6m3t3HKV7qqGsTgFgY?=
 =?us-ascii?Q?RImt6mysEUxo+ZRhHSP7rTXzKBjTRgidzt4i0GoEr9nTxpiSDwm5vFEnSi23?=
 =?us-ascii?Q?WCn8yI06TUJqP88U5lHP7jNDqaTofhmCACJjPR1C7UPEfUw3nHFDfjyAZ/NG?=
 =?us-ascii?Q?LJt2XiUSiEJp53yifeqnQqY9ddVisMbpifHBzusy4kNPH5ofBs/VlCd7gBni?=
 =?us-ascii?Q?NXqV7C/auNI9ops6M8fkzIXl7XvRRmw47XW45VmwIMI5IRbOsHo0J3b/LenV?=
 =?us-ascii?Q?aMrP7OBBbd2VKgkeC71aSiTOBVIGLTSTtXzoIiVO98kr0JsIwzbWhyVRuxVd?=
 =?us-ascii?Q?bN9eUdQ0v55PPR1nI/6/IxHmz6dUeC1uhXM7kD7ZcmHMRM9qMdwqS2RLGKvH?=
 =?us-ascii?Q?muCe9hpWkODZHN51nG+zCBOAkmlD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:30:07.4740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84552338-58a2-4d94-2cc8-08dce7ae16f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261
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

Currently, the shadow FW space size and alignment information is
protected under a flag (adev->gfx.cp_gfx_shadow) which gets set
only in case of SRIOV setups.
if (amdgpu_sriov_vf(adev))
	adev->gfx.cp_gfx_shadow = true;

But we need this information for GFX Userqueues, so that user can
create these objects while creating userqueue. This patch series
creates a method to get this information bypassing the dependency
on this check.

This patch:
 - adds a new subquery (AMDGPU_INFO_FW_OBJ_SZ) in
   AMDGPU_INFO_IOCTL to get the size and alignment of shadow
   and csa objects from the FW setup.
 - adds a new input parameter flag to the gfx.funcs->get_gfx_shadow_info
   fptr definition, so that it can accommodate the information without the
   check (adev->gfx.cp_gfx_shadow) on request.
 - updates the existing definition of amdgpu_gfx_get_gfx_shadow_info to
   adjust with this new flag.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 19 +++++++++++++------
 include/uapi/drm/amdgpu_drm.h           |  2 ++
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f710178a21bc..efea172c41b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -302,7 +302,8 @@ struct amdgpu_gfx_funcs {
 	void (*init_spm_golden)(struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
 	int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
-				   struct amdgpu_gfx_shadow_info *shadow_info);
+				   struct amdgpu_gfx_shadow_info *shadow_info,
+				   bool skip_check);
 	enum amdgpu_gfx_partition
 			(*query_partition_mode)(struct amdgpu_device *adev);
 	int (*switch_partition_mode)(struct amdgpu_device *adev,
@@ -491,7 +492,7 @@ struct amdgpu_gfx_ras_mem_id_entry {
 #define amdgpu_gfx_select_se_sh(adev, se, sh, instance, xcc_id) ((adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance), (xcc_id)))
 #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid, xcc_id) ((adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid), (xcc_id)))
 #define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_golden((adev))
-#define amdgpu_gfx_get_gfx_shadow_info(adev, si) ((adev)->gfx.funcs->get_gfx_shadow_info((adev), (si)))
+#define amdgpu_gfx_get_gfx_shadow_info(adev, si) ((adev)->gfx.funcs->get_gfx_shadow_info((adev), (si), false))
 
 /**
  * amdgpu_gfx_create_bitmask - create a bitmask
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b53c35992152..8521b62cc136 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1282,6 +1282,20 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return copy_to_user(out, &gpuvm_fault,
 				    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
 	}
+	case AMDGPU_INFO_FW_OBJ_SZ: {
+		struct amdgpu_gfx_shadow_info shadow_info;
+
+		memset(&shadow_info, 0, sizeof(shadow_info));
+		if (adev->gfx.funcs->get_gfx_shadow_info) {
+			adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
+			ret = copy_to_user(out, &shadow_info,
+					  min((size_t)size, sizeof(shadow_info))) ? -EFAULT : 0;
+		} else {
+			ret = -EOPNOTSUPP;
+		}
+
+		return ret;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1d5c873876f5..e5f5de8804b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1034,14 +1034,21 @@ static void gfx_v11_0_select_me_pipe_q(struct amdgpu_device *adev,
 #define MQD_FWWORKAREA_SIZE       484
 #define MQD_FWWORKAREA_ALIGNMENT  256
 
-static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
+static void gfx_v11_0_get_gfx_shadow_info_nocheck(struct amdgpu_device *adev,
 					 struct amdgpu_gfx_shadow_info *shadow_info)
 {
-	if (adev->gfx.cp_gfx_shadow) {
-		shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
-		shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
-		shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
-		shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
+	shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
+	shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
+	shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
+	shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
+}
+
+static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
+					 struct amdgpu_gfx_shadow_info *shadow_info,
+					 bool skip_check)
+{
+	if (adev->gfx.cp_gfx_shadow || skip_check) {
+		gfx_v11_0_get_gfx_shadow_info_nocheck(adev, shadow_info);
 		return 0;
 	} else {
 		memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index d9bff1c3b326..ad35b41be250 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1052,6 +1052,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_MAX_IBS			0x22
 /* query last page fault info */
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
+/* query FW object size and alignment */
+#define AMDGPU_INFO_FW_OBJ_SZ			0x24
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
-- 
2.46.0

