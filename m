Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992D0ECE587
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441C810E68C;
	Mon,  9 Sep 2024 20:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hLzSMHtl";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E3DA10E68A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhulN84gmVL/hl39CrPZQcl0kHtrsAz+YV9ZDReF83uNgddE9zXZcWbCbMApRjqYl0ncpLyOrJ/FZp5rKiVq60H9CMeuxvdRwfdnRjDNDEOo5LHj+l4qUO9Eiz2w/FGKPD7XC5XbZymCr1ZjZQgbDVN5k1izrwT1gKVgudBNTdNpW8wY8Kll9hGJidOAsQyDVHKnaRB9q2zAxAbxoIQUPuBPD5OlCqm4ptq3yEQjYFlMuqeQ5ESWTFFS469DmVjqjubsrjwxmwj/XW77w/lHa7QJtdAJ2nsjBInk3oM+eNBYlz+UZJ00CM/4hngidIGv/rfKn6/+Jifd+K7Or9YERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkVfe9HYPjkdmmoIL7yUrXb/VrAy5xdGVAk5B11NkO0=;
 b=QrWWFXRxnrC2w9U/DOaxX9rcFjxu/TKQk2PaHJUzZ0GTYUNUmVuwU1f8VDR6o6/0tdeBTZ+NCvDvLAb7zZ0BcKCN2ISUpAWimA8STDO9xAM40L3fRrPxpm1kB4q3JOi/MXL1f9b9NSe2AdSR9qVLKSFZjPMdIcl1IatmG3rSRIVPWTELyXedDBJAGtMDR1MpRXb+uaLDcbswDJv32Q8WqQXWKhf4G8KFUHH4hkAC3FrpnV97p7fgVkrJXajeVfH12dKPxkJ0Ixv/zwOyhxVz9wM7H9N8rxWoDQYn6mdPBk1AApdBgVu5HwvddycDBiXyEfJTk6bsOdm3RKgq3rXcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkVfe9HYPjkdmmoIL7yUrXb/VrAy5xdGVAk5B11NkO0=;
 b=hLzSMHtliWuWn0iOtfJqErzKLNIaSl3dkNS0fhtRHhE7l+BJfvNF4DJQRZSRhcGkGMEFzF8DR0eWFLrkiGmbwuTJQG10qq0WXqaPbbVS79aZ/DmsyL4GbwDLq/MJQQcdpmi1J60e2ZBJ0w3EwIAIDK2aua5rei3iUJ5lQEL1v7k=
Received: from SA0PR11CA0040.namprd11.prod.outlook.com (2603:10b6:806:d0::15)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 20:07:15 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::90) by SA0PR11CA0040.outlook.office365.com
 (2603:10b6:806:d0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:07:14 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:08 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH v11 11/28] drm/amdgpu: enable GFX-V11 userqueue support
Date: Mon, 9 Sep 2024 22:06:02 +0200
Message-ID: <20240909200614.481-12-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 930a3d6f-8104-4a88-973f-08dcd10affb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qag11TklyV46WWbqQaxk17fvIaGG30SBxD1UwsOK4Chd6pSgBLtoqjMVkLsP?=
 =?us-ascii?Q?bWb4BY10qsp4b57rvHf01KYO8vAKP/FcDUNdJNDYeZFlytO25HALQmdhlDXZ?=
 =?us-ascii?Q?Uba/uAGPA/W9AWSWZ4ziMuxiQPQ+Swam/Afkd5R7M+QMFOOUNt/wR1mdqdYT?=
 =?us-ascii?Q?t6dsNNOSFcw++7l+ijWoR0VQesHIaTNzzZcKST4+R2HEc0jDpBXBoOAXJjoV?=
 =?us-ascii?Q?GCS13RozjbWYacCS7qWF4YujdfqJD7RlVzCKxYnhC8N3NVwgEqPHRvQLx3ol?=
 =?us-ascii?Q?3tkEwk8eUpJp4yxWbT32Apcm1CZGOil56wbDiU2CYD7zwv1iaZ4Sk7VLrPw7?=
 =?us-ascii?Q?uLkzfUf3pzNY9RrBpIQOJ+0LNjEGzXnY7fV7hme3Ikh/vNxrwDq9/fBgAua4?=
 =?us-ascii?Q?n6+QDYOUND0KREar3DicL2BqMoOu8H8+QOKUGnudk++9Eeut4wbAR+FhovoF?=
 =?us-ascii?Q?xqkAU73K7pdA8uGEVI5p8NRgkIV12sAzKkdCX9YNvHC2UApVWRrUTpam6WlB?=
 =?us-ascii?Q?L+SN29Uw5hC0q3tphBgflenam4mZYg8lVXFi4Tkk7CnDUSLI/7t4nrEXPSzu?=
 =?us-ascii?Q?LMuxhF1HLTqNDvnoQh7IOQoexXnsG1ycd6GNg2pjWVaRmuYdqHOFSieaHLhO?=
 =?us-ascii?Q?vjEvmPnug0CocFsnhAlZdppIJEmdvKl09GZogW3+N73+eXoipQhpTdGlY9a7?=
 =?us-ascii?Q?j7zppVsEh+o4FFOVnY6Z5y4gi2WijRXDqQe0iZ6Zm8IDOn0mV8i9CzkjR9m9?=
 =?us-ascii?Q?Oq4BCllKVNa0O/U+UpocgSADjDPeaTtTA/knHN5CSddZzDEsjwB6ViV7CfOw?=
 =?us-ascii?Q?CGR2uu2I99JSJXs/rkqf9DftPM/LIgB55llziVXY8sXboA0qhSDM3u+JE3Qu?=
 =?us-ascii?Q?DB/khEd04plgPMT4WmJB3/G7XFeY73qGASso/ORhFpvgvr0TIp8VOeg3526J?=
 =?us-ascii?Q?c7j0cI5mOMX8t2ubCaNFfkYt5DB3spPOWGJaaqtt2P4qN+2vbl60Q2FLKhb6?=
 =?us-ascii?Q?ZPrSvvqGtnftdH9DYgcuXWtXB1De7P3/aDpQo/PuQbCY03A9zyP55ibdEVsF?=
 =?us-ascii?Q?4wa+ttioQ2ZGxGdItGRW5WlXVwHrxhHclsBJUsX035oHJPpi/ZvXxbFPWe1T?=
 =?us-ascii?Q?J885wyTRFw7HWZiEvJiM1g359xMJMLugXqu0hGHNPt3FRh757q6J+vJxGw9X?=
 =?us-ascii?Q?vGZUQJbxA3RTQ2s8L4snZ6whdMFFKnl3ksh7bdg0huNXHoOQVHRD+J9M8GW1?=
 =?us-ascii?Q?7qbaj7eB4pgcDKEP9xUCdajl7x9AJapwOdz/bdHh6TjCbANBouCpWnVEV3EH?=
 =?us-ascii?Q?pSMqXkzNUnBXiH4Huj8Zl8BA1SHMDF8Q50vOHHqaMhMSOXqBTP4QN2B+EB03?=
 =?us-ascii?Q?Kx/UeV1j7/YJEYteWFizqI9XAdnUw7CrWgGSMYO3J5nc1ALn0lGPH/aZi78K?=
 =?us-ascii?Q?jTbVIgDTjPJupoLTYF1DIUEugM30dK3E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:14.8955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 930a3d6f-8104-4a88-973f-08dcd10affb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902
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

This patch enables GFX-v11 IP support in the usermode queue base
code. It typically:
- adds a GFX_v11 specific MQD structure
- sets IP functions to create and destroy MQDs
- sets MQD objects coming from userspace

V10: introduced this spearate patch for GFX V11 enabling (Alex).
V11: Addressed review comments:
     - update the comments in GFX mqd structure informing user about using
       the INFO IOCTL for object sizes (Alex)
     - rename struct drm_amdgpu_userq_mqd_gfx_v11 to
       drm_amdgpu_userq_mqd_gfx11 (Marek)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  6 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  3 ++
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 28 +++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h                 | 19 +++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 64a063ec3b27..5cb984c509c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -188,6 +188,12 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	uint64_t index;
 	int qid, r = 0;
 
+	/* Usermode queues are only supported for GFX IP as of now */
+	if (args->in.ip_type != AMDGPU_HW_IP_GFX) {
+		DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
+		return -EINVAL;
+	}
+
 	if (args->in.flags) {
 		DRM_ERROR("Usermode queue flags not supported yet\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d3e8be82a172..e68874fd0ff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -49,6 +49,7 @@
 #include "gfx_v11_0_3.h"
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
+#include "mes_v11_0_userqueue.h"
 
 #define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
@@ -1552,6 +1553,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
@@ -1564,6 +1566,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
 		break;
 	default:
 		adev->gfx.me.num_me = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index bc9ce5233a7d..bcfa0d1ef7bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -180,6 +180,34 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 		return r;
 	}
 
+	/* Shadow, GDS and CSA objects come directly from userspace */
+	if (mqd_user->ip_type == AMDGPU_HW_IP_GFX) {
+		struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
+
+		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
+			DRM_ERROR("Invalid GFX MQD\n");
+			return -EINVAL;
+		}
+
+		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		if (IS_ERR(mqd_gfx_v11)) {
+			DRM_ERROR("Failed to read user MQD\n");
+			amdgpu_userqueue_destroy_object(uq_mgr, ctx);
+			return -ENOMEM;
+		}
+
+		mqd->shadow_base_lo = mqd_gfx_v11->shadow_va & 0xFFFFFFFC;
+		mqd->shadow_base_hi = upper_32_bits(mqd_gfx_v11->shadow_va);
+
+		mqd->gds_bkup_base_lo = mqd_gfx_v11->gds_va & 0xFFFFFFFC;
+		mqd->gds_bkup_base_hi = upper_32_bits(mqd_gfx_v11->gds_va);
+
+		mqd->fw_work_area_base_lo = mqd_gfx_v11->csa_va & 0xFFFFFFFC;
+		mqd->fw_work_area_base_hi = upper_32_bits(mqd_gfx_v11->csa_va);
+		kfree(mqd_gfx_v11);
+	}
+
 	return 0;
 }
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bd8d47a55553..895d64982498 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -409,6 +409,25 @@ union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_out out;
 };
 
+/* GFX V11 IP specific MQD parameters */
+struct drm_amdgpu_userq_mqd_gfx11 {
+	/**
+	 * @shadow_va: Virtual address of the GPU memory to hold the shadow buffer.
+	 * Use AMDGPU_INFO_IOCTL to find the exact size of the object.
+	 */
+	__u64   shadow_va;
+	/**
+	 * @gds_va: Virtual address of the GPU memory to hold the GDS buffer.
+	 * Use AMDGPU_INFO_IOCTL to find the exact size of the object.
+	 */
+	__u64   gds_va;
+	/**
+	 * @csa_va: Virtual address of the GPU memory to hold the CSA buffer.
+	 * Use AMDGPU_INFO_IOCTL to find the exact size of the object.
+	 */
+	__u64   csa_va;
+};
+
 /* vm ioctl */
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
-- 
2.45.1

