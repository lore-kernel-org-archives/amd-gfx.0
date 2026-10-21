Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64339606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g69qI+G8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0421F10E2CD;
	Wed, 21 Oct 2026 06:56:39 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB6710E2CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMKWO1PidmeskMVreIlKhyiTHHoFxmO+jkM5nVipmmp3VpfZmAFuUma0zSDcfAh7Ui9Smsrg0sdWBlnjJ7SzeWAzsrq+WxeyAxuW5o+WZI8vSkS+27KuCTBOkA7+AZqN457RKurXw7gEXnp1KwbiQvriGm5SKr/YV3NyIvnBoUkBgvACVUt8Pu6rQP5n3fusqZ1GNYa2mNoCizVrdRi6kADj6N0ryKc/yTCFx6wc3yXSThAI+RCVpwN6m/5/ve4v3faqWbqbVUvK7mipD4ajIaeYD7kUGP4Y58smI1M4hW+dF50d/iTuwcUrb7gp3t63+3oEgFVSdb5+r+EKz8ov+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rO/aI55rMDEiOPKGynWiLEFsTwj/osQ2LqFi+xqev+E=;
 b=WFKdBgGv0hPD/kE/eZ3oJTHtyy2/4UWTnpDpihAGa7/Oa4wHNUdBbnuqQy6cSoMFTLR7NA3o1XYeMLSEITVn+JW1dYQTj4FB5Zk8jR4VM8FzBgNCZx6vQ8dtwMeh6YwFQIv/r91ezSIxZ0gkXfQytuHo5+GXLDnCsTZ/0VX5zAIFzjRYSA0kd+CNDvRz6ZgvkoO2IyEwREqtSNcOujqXylBUeeZ8laH+tnGvPrUh+fHbdqSCw29XuTNl7FbOYsSb1SmwOjlq98b1JNv7zea20/Esvur8FVTSUZwXkb+reGyYl7iAuXoJ4emM/+DYEFp9s5JzITOlYfRvGssyo/+7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO/aI55rMDEiOPKGynWiLEFsTwj/osQ2LqFi+xqev+E=;
 b=g69qI+G8gyFuB5cLkVspWuIZjnMvX9Rby62M7nTKCO/bVXgrjc2TW6mGcG6zBf7zisSeK0Rj5Mz65F1eAk/tBxQlLt/vwcGCOegLEvhMFT6GVf2U4VEjUz5a3tp2rpcaFj/FgpyNfxtpM8RdUhPGREPK0Wov/HYGN/C43dVqVBw=
Received: from BY5PR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:1d0::21)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:56:28 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::89) by BY5PR04CA0011.outlook.office365.com
 (2603:10b6:a03:1d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 06:56:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:56:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 21 Oct 2026 01:56:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v2 3/7] drm/amdgpu: Add CWSR userspace interfaces
Date: Wed, 21 Oct 2026 12:25:59 +0530
Message-ID: <20261021065603.1329111-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
References: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8d7753-c981-4f03-d2a8-08df2f406e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|11063799006|56012099006|261009223027099003|260925021311599003|260925021911599003|260925022911599003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: ZYthmCRLYgpHAHSx3dJhSVYTgKlAyd84bM8nGBBrLYj6pjuSN5EKJu8U5+SpSvBMNUrEBqLrXCTj+i9QG+1Elp7G+uXyQjDNEMPEuPfzARD1iIFDSBSDA56zLXjM17DB4aMs3nLA3AZwcwfF3EF6oZn8Z2xIrLIEwKi1rkcWzlh9af0+IMrmmqnFxA1zvbamjdAan1FR35a8StMZWaG5QO5yw9OiMR+YsHaS9DvDmJmLJIXx8aB9LSN0ZsJwJ5yaQfCyMdTaxyIWqKBESJOcSRdKUu/d1kW//9bRxFu8bUqlAQMOiKpjGHjMhSB6vLovoS36K+uDWtqzl1R2tNwL8vNxgbALFwOk05pKfO1ofww421lxY6b7vPkfyqHNeI8MfkmHg4fUKgP1qVfK0fUr6I3VTyzSMCY1Z3nHvPmmeOrLVXWLfiFc6SH9zBe75xMfe+tJ2li7QeRtROS+jyUH43EKsLqgLR/yMZ7hKv6gwBrAKwv9oN7+cSdYSnOx+BDKKWRmbwXN5uY27x9WJEjDRFdZHvcu3HfudE/w9EUpEEolGgKeQ39b2+C3D88hwJkqRP1xGxIZJhVZ0DwHXwIB9gkqcuaL8zvLNlfM+BQZVCmTrHt11mZH/91PSjP8OSEijZ9/dAvaXENnSevpodRtKKrLOsr9IqaZ/OUcvB58WeF/y4NJlYuMQ5K9qEb2SmkhFAJyZkReTCKaKJNbZDJI3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(11063799006)(56012099006)(261009223027099003)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HHOkY97qTcnwKfd9Lh0YIS8Ad41DmUPma3+7r1yz/Wl1iWV6Njr06mm+8xOGwY8XNE/ntQ4oX2AFSQYwt91N0kaddEoQQgfwA60IdEoQFsfckxPyqR2NUwTREi2QmNuBpAAz4Nv5sVPNZ7z7ApICGVBYl94KQGdX0P2zLJs+okfztW0hJdJHrMGI8OLkNK3jnvEo7hBQOzIjwy+0GrK7WWsglDg0vAQ0FlNEH6NMZfRMcISAbXvx9nOjfcGyQL2KLANbBEo5N3xXPfKbm9itTi20SJhykojYh2gqHgBE7BPsDFcIX0PAdHQsgWJC4pzY4XR0KF0rTUEKCOJK0uGvkYcgKL9+vWDj5unPPdITOdmisYq7Z6qqyyBNyr9o14hcrdOTjoxv8UNxTKerDK0JF9QF/3mNbamHc8WqkZm+bFmsX8dNG72/R9aIGPuff2md
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:56:27.9364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8d7753-c981-4f03-d2a8-08df2f406e0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Change-Id: Ib264dfd71e070bdfdede298d8d79f70b7605ff75
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

