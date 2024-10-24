Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0664CE8E7A
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 14:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F8410E28A;
	Thu, 24 Oct 2024 14:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f33l9bTR";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 019A810E28A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 14:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTOzMb+VOdsTUbf4dWPpZRiXfGVmN+PXmRO++fe9i/6wmwD2EZYAj7Bv1bVIdE0BoSToBIN2uwZgjisrSW2gYiOuWBy492iAky6HAZcum/7gQ7s7xyxFQEflb/U9iGnb/Sgik2INQ3Ht2PwS1y6yRtpWaVvVjPNB3SwRivX2PVecn60Un3cdU+PXghT46yexgLV2Fip8hLrp0IW4okP73ML+XQUUh7G6Fxtnqh/JcV4TmUUibd6jrNNv50d2rWTvTSVFnN1vDIbUUHtD/SgToWBCnCdL9FqF5N9+wNYp73tshBYY7gVKZ1krk0nyr6G21wQU/m5tok7UU9oYpVfQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP7kkoZYcfumPGnmgY+iEDNiDGlkEvlRf1ml6ogbHZA=;
 b=ZMiF5xQZZjN6x2yrJTSSwd7oGn3YdNeGTSsMc4giH/asreQVMXYSzKIRLz7DAl32X7jajfL1R0/J/n+njoV8eFHgM5Z94BiAjrjbe/DXSPMf0El07Y5z8Tm/ECyQbEyQzi4nWUTGnUNTNER70Sfm+TVthp7jpPWLIzEkh6bakAY+BCOyWr7vPb0JjiMOb9xsj5fHXJceMqHL1zgSe2Ph9VBsfyzjQ6qDd57CIk4HRFeS3yYU8WdTaDOEdJJRGVGkj6JmmZzj78nlcnJmZ12UcFta3lrFaqjTwt6mroxDat2AbyPXGgnuI1IsMcw4BI8FN7j/7l7X0HkigHIhlH9ODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fP7kkoZYcfumPGnmgY+iEDNiDGlkEvlRf1ml6ogbHZA=;
 b=f33l9bTRAHaSh+WPrVHD8N57ErFx/SHmHazD2wlTYMgWZHB3fqrttka4ORtgwHwU8uj9c1I7Pwewna/oc8q2zghb/qowEJW0HAPjAVIEBRRPQgHLFAup64gvsqjiyz2Aos2cpHR5dKeDT7OXPu9F7lsojY7VGLkrChsT3WXNywQ=
Received: from CH2PR19CA0013.namprd19.prod.outlook.com (2603:10b6:610:4d::23)
 by DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Thu, 24 Oct 2024 14:03:58 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::cd) by CH2PR19CA0013.outlook.office365.com
 (2603:10b6:610:4d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 14:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 14:03:58 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 09:03:56 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH v2] drm/amdgpu: add new AMDGPU_INFO subquery for fw objects
Date: Thu, 24 Oct 2024 16:03:31 +0200
Message-ID: <20241024140331.398-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f5d288-8ba2-424f-a46c-08dcf434b494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SaMwvK8SgURa6TDzT96pkKFnQXIdskMmuzlkNMnlG3VJHWgJCDF2B18vFCM0?=
 =?us-ascii?Q?K+0LuK8xZHnPGObF5puCdyr4BKKWAMkwpIkIU2dowZGrPxAdTQzprLY8wx5X?=
 =?us-ascii?Q?4GGHX6nHVjhh8F/26yaTtIoME+uz+jnIdrMTGM9OpS+MHyS+m16MhD1vUSmh?=
 =?us-ascii?Q?2tMqEuwsNluNgPH8fMB5PWaRI8VLKapz4Q948PaFmAKb9pWnLhxgHtxGN7ZD?=
 =?us-ascii?Q?8q6TRnGbT9Z+zjURvXv/KEM0PL5eFOeJcLsPC7eShYADDQHumMU6j3immWH4?=
 =?us-ascii?Q?rO6NNz8bhQrF6ldEPFHoJZv92f9l4SI2kt9TXLtXaVBTrubIzZEDynop0UfK?=
 =?us-ascii?Q?Wl1J8UOwthAzyYGnhrOiXvCVsrsJWGRHJDfw80TcsDXVSTj9abequFMwr75S?=
 =?us-ascii?Q?2YirWtdJLStc3EGKRqNt0qkANxW65YWL3G9LmFC+6FcFqn3PuxNo+ebiIk6+?=
 =?us-ascii?Q?3wa17TN//BRDNq41tWl7UILNxLRXhwtIBnihtH3Du0orihcwKHxSc+BrFx1z?=
 =?us-ascii?Q?PYJsDEMjTPDaDr2MeyKLd/8hdwPIXE4K8kSP/lAFq6DLrpnviWLvZMi9ESoA?=
 =?us-ascii?Q?bFffutEK7D+zSVf4RvL/aTxA4+p9CXyCOWjSgrHgkhKMpMl4KmsDL0GoTddu?=
 =?us-ascii?Q?htCxYjS7cpUsYIUqs7cjn+fGnMAjokO57SEmh71YzecWOXE94i4BTltTUjAO?=
 =?us-ascii?Q?og/SwjujQKB5zmnARnXs16NmI13sn1muZLjEcjQGmEOn+7+dq3Y81g9seQGH?=
 =?us-ascii?Q?UvzF3WKXlXHIB0ilekdFfzCz3gbxVu3nZUCLlU7VUzP46Q4WJetd25but0vP?=
 =?us-ascii?Q?CGeXu+PrcFvvdrVkxnmeX/sQAfWBikuAz2tXQGICHRzaGrUbis2lQXZoi1lM?=
 =?us-ascii?Q?ZZt1lCiSjsJMEQs//yEQ6HEM+SUFpD3s0+CMlSEvzubg7EEqSr82CQ3s8di+?=
 =?us-ascii?Q?zr/o5YUd65UcJc6TLZhp/zkXTKov/KLWg4k5EOWVhQpuW0Rfzg0yNh31X4hT?=
 =?us-ascii?Q?Q2NQuQMp8AFgBtYJaIn9bhxac4qzSGjeZ+4KcQQNYSqFD4Yoo/GfVyl/OoWC?=
 =?us-ascii?Q?QL6T3Jns3Avb1mdnauXKNV70ZB7JgqW1C7GQbbDiDNptmxRTfm9fA+c2hNOT?=
 =?us-ascii?Q?wc+jIDsxKXi4pHMO3LF/3ezrrj6upYvNm1C3zDOrd6l2tw7tAgFSdcXR0xpd?=
 =?us-ascii?Q?yRa92iXHjX0Sl59JtJwbofwSvmqwM+mEEvlTrU1LDCFkeIibajo4aSzh0IAW?=
 =?us-ascii?Q?FRAVTAQc4LoAomjC0F/nIeaQRJzXq/R/P8fuSCMjSsGIqN9LctEMS7sR8yn8?=
 =?us-ascii?Q?VhJm9NRS9RO6U7ktF3OqXlXAayhAA75XUEHq8o8EbEB2HXKrPgHfRsHO11yC?=
 =?us-ascii?Q?l1Gtja4XNMGThLZ0oTPgSHoUJG3IMPQugQC1IAAp3iGDWdf0Vg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:03:58.4103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f5d288-8ba2-424f-a46c-08dcf434b494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230
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

V2: Added Alex's suggestions and addressed review comments:
    - make this query IP specific (GFX/SDMA etc)
    - give a better title (AMDGPU_INFO_UQ_METADATA)
    - restructured the code as per sample code shared by Alex

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 30 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 19 +++++++++++-----
 include/uapi/drm/amdgpu_drm.h           | 24 ++++++++++++++++++++
 4 files changed, 70 insertions(+), 8 deletions(-)

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
index b53c35992152..285149258882 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -371,6 +371,20 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 	return 0;
 }
 
+static int amdgpu_userq_metadata_info_gfx(struct amdgpu_device *adev,
+			     struct drm_amdgpu_info *info,
+			     struct drm_amdgpu_info_uq_metadata_gfx *meta)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (adev->gfx.funcs->get_gfx_shadow_info) {
+		adev->gfx.funcs->get_gfx_shadow_info(adev, (struct amdgpu_gfx_shadow_info *)meta, true);
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			     struct drm_amdgpu_info *info,
 			     struct drm_amdgpu_info_hw_ip *result)
@@ -1282,6 +1296,22 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return copy_to_user(out, &gpuvm_fault,
 				    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
 	}
+	case AMDGPU_INFO_UQ_METADATA: {
+		struct drm_amdgpu_info_uq_metadata meta_info = {};
+
+		switch (info->query_hw_ip.type) {
+		case AMDGPU_HW_IP_GFX:
+			ret = amdgpu_userq_metadata_info_gfx(adev, info, &meta_info.gfx);
+			if (ret)
+				return ret;
+
+			ret = copy_to_user(out, &meta_info,
+						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
+			return 0;
+		default:
+			return -ENOTSUPP;
+		}
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
index d9bff1c3b326..eda9b4cfdff6 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1052,6 +1052,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_MAX_IBS			0x22
 /* query last page fault info */
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
+/* query FW object size and alignment */
+#define AMDGPU_INFO_UQ_METADATA			0x24
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1123,6 +1125,11 @@ struct drm_amdgpu_info {
 		struct {
 			__u32 type;
 		} video_cap;
+
+		struct {
+			/** AMDGPU_HW_IP_* */
+			__u32 type;
+		} uq_metadata;
 	};
 };
 
@@ -1391,6 +1398,23 @@ struct drm_amdgpu_info_gpuvm_fault {
 	__u32 vmhub;
 };
 
+struct drm_amdgpu_info_uq_metadata_gfx {
+	/* shadow area size for gfx11 */
+	__u32 shadow_size;
+	/* shadow area base virtual alignment for gfx11 */
+	__u32 shadow_alignment;
+	/* context save area size for gfx11 */
+	__u32 csa_size;
+	/* context save area base virtual alignment for gfx11 */
+	__u32 csa_alignment;
+};
+
+struct drm_amdgpu_info_uq_metadata {
+	union {
+		struct drm_amdgpu_info_uq_metadata_gfx gfx;
+	};
+};
+
 /*
  * Supported GPU families
  */
-- 
2.46.2

