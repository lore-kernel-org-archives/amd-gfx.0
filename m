Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26593CA6010
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 07:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E72210FC8B;
	Thu,  8 Oct 2026 07:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ybNWK3BT";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BDCB10FC8B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 07:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tum9aTJd/ozI0WKYyxdsAEt1Lyq0SZfdeOurVSSwultUR3OQ6D+VNWZJIr6wuUxvJds5x63sUmBgdXxzkidnJXPivm7YfI7p17UAlI80E9B5dTPRZ0XfBwj8GsOuB2Ffy+i2kb9rUKYi3gSKZAkywcUfBvqP7MkwNpTENuNbJUgD+fNoMJeLZfeXTSZAapa92tiH8fsAhmo5qjucKp3j1LS4Axb0fJJ9A+ysE/VUHQ4zK0F7dXGnKyzMqYH2IHiUQ+zbj2Fg8LQ+pYxD/47rpE8rRTgqC75o+d+7UrKgnZEIgaydEHX18MDZRWCpPYxt3Zzb4/2RaoP+f4m71hMf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3swgJJwcs+MMsQx5WSUFloC5MyTADbsGGTiLoWt9sYI=;
 b=Eby5SuNlXLef32ej08IQWB2zBwhqLOqCs6j3DMHhejtOx7HGFvjUlftsA/HtM4lFWgabQWODZ/uWt+oKdC2e9bHRO/Bw26FpoZ39awD+8qk2cHBaPpxSYq2QQ3G1QtJgvGYdEjlWkjtg8NtakJ0fV8pxVe8RU7PXb604onaNG6YWzKfgA7s+tClpLfRFYboFrTP0T0WzNLmSheXTekvXdf5rL43lxP5mB7sVA9GkhE8zMgcq1BYnhhAc9XWskw6Ntu7TJATVNs2tfF0+6EQkLhS6+8FKeEpgzV5iYRxCNclsjiYu/kFIbl3h6dHBBDck0L7gdq3A4eHRlnUTwidU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3swgJJwcs+MMsQx5WSUFloC5MyTADbsGGTiLoWt9sYI=;
 b=ybNWK3BTRgnk2bWBIXn7wgVkqZO6uRE0CS+InP9U9FCGqtF3yWIcbx03UkLo/9fwGZOVNqHEfN+LdjE84HN0VLz+zg734iChkkaQJp1gFElJCAYVQcmlG+mkl8+EpNasEMvUo6gKFfUDcmbTrDUvhQSqLeFkozNOJGX7lIggnhE=
Received: from DM6PR01CA0020.prod.exchangelabs.com (2603:10b6:5:296::25) by
 IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 07:06:19 +0000
Received: from CY4PEPF000392D8.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::80) by DM6PR01CA0020.outlook.office365.com
 (2603:10b6:5:296::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 07:06:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392D8.mail.protection.outlook.com (10.167.247.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 07:06:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 02:06:16 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: Add CWSR userspace interfaces
Date: Thu, 8 Oct 2026 12:35:38 +0530
Message-ID: <20261008070542.1111149-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
References: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D8:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 557b4402-d0e9-4ec9-628b-08df250aa6e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|56012099006|3023799007|260925022911599003|11063799006|260925021911599003|260925021311599003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zRwZ6zm3wvD5LAt4G+g63vl6cFC5msRNbbqAtCprOwaSsaVcK1eCYcdjXV9Muy05jB/1lMeR0hAa6jNiYDfBhyuSIiK7FyAHhsX3/hLy8uhfWYU2/ruTvdZPB1HRk4blaL1TNRdgRopp4qfQjPhl6tJbswISlPdZSpCIhItT1QpI/4qeIssEqd4UCbB962IsSDTGGxDYQJ5XF3YdhATafQ8+e3QFk642H5qAKqCO1PaYpdoK8E2QqDYaHX8+A48wXWm0+ckTijm8ccx9c0Ci/RgKmJ0LBSS1hWKoqXbhPzEYjcecw3Ucm0sYyNjykYnh3wmss+z5WYYnWEcowTS8szvSqKv7UGnry5uo+xTkbQDzEGHJKa9idXbtG9IQfg5/aaLOs8y391PIwWGw12OA46jz1TzVHfC6qM0P7+LLOPf51GVN7cTpn231VnK249ZhJvoSgM+QMSbyryfDYOZ6CpmhYOWjEbuNoRRJK+Jt9mQwfW1to3Pzo9IAl+ETHogC5uer/EiDlFBWqqyX1jeCB6t8ve2oWmtDtuakcStzHK2wDktemCRS8OldoPfzNITgf8GAY5AFL2n5mj4o9wxshDwvx+ADA/WC/Nr6Usp8JJsSOf4A6IoJL32Z/d+QXqONiK9CGRaf/dyBEqSsyWuzwKxhVBifA105nBqghm7opHOEq7UCmhY0lbdqKExWA+jD9z714HLfVg1CNXWQLNKZhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(3023799007)(260925022911599003)(11063799006)(260925021911599003)(260925021311599003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0swVdxM3UXRy5mirpMseaGb1Io+s95KURYVnleQmxzUM7srVypAOHp3Tkj91J2nQ5k5/afwW/m5UUfkPF3vTeR7+L5X6OjTc7HsuwkadC3nj7cjjWobHQNz+//GWm1tbcXr2HsgsO0WRpr0V96u4S64MW+JyMEjbeuTAjXDL6RHIwMfRmxjCdbvfoOEAzgbl0CZ07m8dL53sdM6fwGS3cRP8W+wf8g4BKKqdkPhHCgPF43WOxBuxrtPfxysraR/InYb7UqRtaiOae3+Dq3U0B2hDXGkHOFWOf3ZSR8oIlBjEtHSVG5auG6D0BWf1Eo/dBIwgeVVjZB+5ptqD9F4jAlWmzFtnJe0rJWsNoioPkYlTTgGd/s1tJZRbRMclvj/j5mzJbpP5Y9u6DeTwOUARyG54b4aQPufdpz8ZC2Ltx0EovCLIzIrV916XNCe3UdOS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 07:06:18.9497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 557b4402-d0e9-4ec9-628b-08df250aa6e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add an ioctl to return the size information required for CWSR regions.

Add CWSR parameters to the user queue ioctl so userspace can provide
the GPU virtual address and allocated size of the save/restore buffer.
The parameters are supported for user compute queues.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 21 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++----
 include/uapi/drm/amdgpu_drm.h              | 27 ++++++++++++++++++++++
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f3945b3988d8..147c0bd02731 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1429,6 +1429,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_CWSR: {
+		struct drm_amdgpu_info_cwsr cwsr_info;
+		int num_xcc, r;
+
+		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
+		if (!amdgpu_cwsr_is_enabled(adev) || !fpriv->cwsr_trap)
+			return -EOPNOTSUPP;
+		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+		cwsr_info.ctl_stack_size =
+			adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
+		cwsr_info.dbg_mem_size =
+			adev->cwsr_info->xcc_dbg_mem_sz * num_xcc;
+		cwsr_info.min_save_area_size =
+			amdgpu_cwsr_size_needed(adev, num_xcc);
+		r = copy_to_user(out, &cwsr_info,
+				 min((size_t)size, sizeof(cwsr_info))) ?
+			    -EFAULT :
+			    0;
+		return r;
+	}
+
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 3b7a1479fbf7..5311e1ad0201 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -461,11 +461,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
 							 fpriv->xcp_id);
 			cwsr_params.ctx_save_area_address =
-				userq_props->ctx_save_area_addr;
+				compute_mqd->ctx_save_area_va;
 			cwsr_params.cwsr_sz =
-				userq_props->ctx_save_area_size;
-			userq_props->ctl_stack_size =
-				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
+				compute_mqd->ctx_save_area_size;
 
 			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
 			if (r) {
@@ -480,6 +478,13 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 				kfree(compute_mqd);
 				goto free_mqd;
 			}
+
+			userq_props->ctx_save_area_addr =
+				compute_mqd->ctx_save_area_va;
+			userq_props->ctx_save_area_size =
+				compute_mqd->ctx_save_area_size;
+			userq_props->ctl_stack_size =
+				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
 		}
 
 		kfree(compute_mqd);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 29009f6aabde..9317018330ec 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -470,6 +470,17 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
 	 * to get the size.
 	 */
 	__u64   eop_va;
+	/**
+	 * @ctx_save_area_va: Virtual address of the GPU memory for save/restore buffer.
+	 * This must be from a separate GPU object, and use AMDGPU_INFO IOCTL
+	 * to get the size. This includes control stack, wave context and debugger memory.
+	 */
+	__u64 ctx_save_area_va;
+	/**
+	 * @ctx_save_area_size: Total size (in bytes) allocated for save/restore buffer.
+	 * Use AMDGPU_INFO IOCTL to get the size.
+	 */
+	__u32 ctx_save_area_size;
 };
 
 /* userq signal/wait ioctl */
@@ -1289,6 +1300,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/* query CWSR size and alignment */
+#define AMDGPU_INFO_CWSR			0x25
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1668,6 +1681,20 @@ struct drm_amdgpu_info_uq_metadata {
 	};
 };
 
+/**
+ * struct drm_amdgpu_info_cwsr - cwsr information
+ *
+ * Gives cwsr related size details. User needs to allocate buffer based on this.
+ */
+struct drm_amdgpu_info_cwsr {
+	/* Control stack size */
+	__u32 ctl_stack_size;
+	/* Debug memory area size */
+	__u32 dbg_mem_size;
+	/* Minimum save area size required */
+	__u32 min_save_area_size;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.34.1

