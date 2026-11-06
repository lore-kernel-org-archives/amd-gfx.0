Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E3606A31B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QXe2KAKk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C5D110E195;
	Fri,  6 Nov 2026 04:51:34 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E6010E23C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 04:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LW24JH/SvOLj/sF/RYPmY19oV5uzRsKUj9u107xeMQAYmGsW8nqXi2iEmbTflzHAh+nFrvUH4G3AhqAYRZow5XjN2VP3kqopfxXXkMIIhphFB2kkDdOMVl+Bvl86cpww3Bm4W1m6w868qoEM9+cLnEMFbY6cUQFDPuEUZRhgi90BKGJMRT+c09PgtDWwi/hri5mbRQ4LIPIyam2L+EwiBbRw6iSEV40X6YcCTY6PCnZbjE1K1yWoZ3yQagvMmyvojOq82G+r4dU5HixNQdpwgqxvIeSMSxp3BrCxVIZIgVfPqhnbV4idzNelccFwLlBGedbeXatAdPrZU0ADYoZjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uslKkFLUu8yKHR7dc4eSwRxArhcXahqt+4I4C20U3x8=;
 b=ueTEy0zNUvT6w2aS14gh3Yyum6LcseSOST5rPwfTWVHT/AZjvbBQmFmr2JDI+Kemilm7KCb07dDiZAgPbB7QO8RIjXXkHyVcXYMVOOc18leOIbaxtu6xsMzwp9zjej/JhfR9jlByETOJNZtnShT2nRW65DadwyYmTSGO3g6f5md2NQGpK/9KILFqcNIA6lHe1juBGNXJ+IqRsdOZoiSWj5Gy8SwWLNjvfbev6L55wku9xxKfdZExPQfzXwUuKKrskz5CyL3QzzAHoUoLvz/qCv2fkKS6D6//FZQsrYC/9wzlwuyaYBr8QyAgCz83O8iXyKJGhlssg9aHu0395aqDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uslKkFLUu8yKHR7dc4eSwRxArhcXahqt+4I4C20U3x8=;
 b=QXe2KAKkzH8BjymnPqvG4ASeczGjRHNqE44bR9dS9FREiLAk3vpcyI5cwkBcRhMeINwMzL1KVSuLWci7s3cHxXSSKJSyw218BA+bmjeNIsaD6EmOz/UgxRZqTZTvOEVc3n/8/G0KzY/ImL6DBjo5meuaUS9UbRHwJE+juWnMKZU=
Received: from CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::23)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:51:24 +0000
Received: from CH01EPF000BE942.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::7b) by CH5P220CA0024.outlook.office365.com
 (2603:10b6:610:1ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 04:51:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE942.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:51:24 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 5 Nov 2026 22:51:22 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v4 3/7] drm/amdgpu: Add CWSR userspace interfaces
Date: Fri, 6 Nov 2026 10:20:57 +0530
Message-ID: <20261106045101.1562366-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106045101.1562366-1-srinivasan.shanmugam@amd.com>
References: <20261106045101.1562366-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE942:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ff1319-423e-412d-b468-08df3bc19c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261026140227099003|261021123027099003|261028144727099003|261026121527099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: RpGYtn/rENTTz0v5r2GxDMW5muCzFQt2AWaUx/+F1m5PILNw5eOXn0k3Fo7ADxQAKvljGnxoffHuWWYoVV1Q9AndjVt5vKJdeE0MJP7A04eFlsOWiolLoEJbJnsDf8s23d3AUSU7dk2MfUfp1F27RqWMuxywuxYu1eUbSVkRAKyo1oxFyaItqjbOwpwsoE6hanMH9DvsI7aUJpUUlhksgxkgT2nJ8t8TNaWlV0xKmq0et+mkoufU1L5+lo2tP/m2yrwd6FBe7ZUY67F3KOhxbc2FaF+fVcY+kVLcBvI0Ig8/8EHYmCsCaqeuj7LdgQ3mpg/stwBpVY2M/7ZTzdXSscoNV9OUoRO32Zcw62KvjszdA45TyAwR2mJe6LM7JgGCSGgRFfYUnHEF/az8nFwzlDAVGlwVe46NaOhVyo1DwlniiNHKxMWLbtm1bPdB7ObKUeCujiE0vFpfmZJzQjmb8P1fFbreVy0k0sfWbml5qoBzSj4m1aNGXaz2UeSQLaoVPbDsnwTWGapJYbrazzfjh6InXdviNkfhjXxoesFkL9bSpPjmheGxXeR3X9V/r0oNGuSwFqhpQiE7dMU58ZSdZhn9eMHoRgQSdXMQSZiV4eOVpVwZ9d7JnBDkpEdUMrqX+FwVosJXe7GImzcV3c9rkmDr3whmDWBHu5cF5UC1Ul08/TkzFwetP8SpjvPQsH4wDxjYa3Q1aJK2LWClGKvmTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026140227099003)(261021123027099003)(261028144727099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S1mTOPNw9Sb+S5n5BnaJbEkk6VnFPHaHkB1JYMD3K0ZI2MLIamV7rbTe8y3rkDVzhxRPKaeRuh17JHn/FowkoIHBenksYvQr5fCOE2PnOVthxd9qUMxZoLVCu8PT6yT8cuwcm45Z/hMf3EIHvDzuY/4vvMFDK3XD4Ewwq7LJy+27K6haG0mNO9rH9KN0DEFq8m/+kcdrtEwypMVN0dpmD5aLZu0iWe1DmJXFAR9piUpUcr6UKlfkVW2EEI93xTsDDOCjFQ+zMfYApe4PL//VGtJfF7kCYVpZbvcFo5poDPzG+gOfqOdrffcwndHfVFECxch5xB1rsdOJrdqQLKvTcv60Gj2nixkofXjFyP+R8L3y14/gEaiYejutWPkCUxUBj6zpSRjBUbbXrYB/7GcuB87YVBrZlx+0yLWQPezstOp80dmg6Fn6R1/zLT7nlzF8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:51:24.5106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ff1319-423e-412d-b468-08df3bc19c39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE942.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lijo Lazar <lijo.lazar@amd.com>

Add an ioctl to return the size information required for CWSR regions.

Add CWSR parameters to the user queue ioctl so userspace can provide
the GPU virtual address and allocated size of the save/restore buffer.
The parameters are supported for user compute queues.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 21 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++----
 include/uapi/drm/amdgpu_drm.h              | 27 ++++++++++++++++++++++
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index fe5e505c6f2b..eedace58eaf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1455,6 +1455,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
index 108dced28f97..0ba672ce7e55 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -466,11 +466,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
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
@@ -485,6 +483,13 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
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

