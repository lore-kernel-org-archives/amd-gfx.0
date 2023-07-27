Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0525EC00528
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 18:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BDA510E5E1;
	Thu, 27 Jul 2023 18:11:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018A110E5E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 18:11:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzC2moxPiiDzX91t1RyJ+nG7gr31/CeSjOIeQUp42HW/zI0hFAF4Pj+icwXwlGm2/9m7R2cEyVe+HOqBMyvlLnyZwlVCrX7JHR2sygSqszGCsDnMFZhIvnh9WMoruhapEBMnheLHvUgldpGd1KT0Jm0CNdSVQwyqDpDXgDKynIxLV2NyeT4XTSmjNmt+8vWZSjZfCBmxWYiLjzea09ZQ1QnDoZz2ybjxry02P1al1a+wgzrtwEVCN5kdEMjMnOQzTrgVI1/XwA5fevQWXKY+G/METWiQ1HM7mPs+VK+xCAdBzgPXJVl3mnL6MA9OvuhJQLrmPNNhMSuYGyKHmtSSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpqZ5CR/pmn5eEfo0qXk38hTHSrGj1TBa6DZ5pc0Nno=;
 b=dg+Xt/LloDEuJC+54BKNS5k4hENDvwKPNhwTWQ4Pc1FNcowf+OrCQj69FUP0xpl9myltP8fn7im2kbZEEp+cw+ZIeF7uC0TkIpAcCg+1qjV9wWcschIMYGe91VzAsW9DY463jhvl/y0rmXeVW46gh4krZUgOsgc8nHBmxcsuhMgCQWf+YYL4s1Y26Atw1qHJh58IYkLebDsKcN26JSYemkR+vToRQQfkPkU4cJxluu7P3FEI9Zdp0Nt4iNoHGQibrNa33/zPAEDswQA0/JqiaWEvQuma3bEIuPi6s0a5+YTizw2xYA3jJu+lkVa5MMntvp5EylxCnaVzFxq5WjB9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpqZ5CR/pmn5eEfo0qXk38hTHSrGj1TBa6DZ5pc0Nno=;
 b=eCWzhUohNDCypTJgCye+akHS1Ang7vO7iXtGFIOEWQXPNJ7dxwhvOBVdhNHVTDIVOQgFVbdAgANoZm1eS0hsz0DPBJUaNI/lTqpF2gDrrAG2Nb/5+DCFsRUaJYTtj6v+yDeE8XuHQi3I5B+LL1mASzroExF9vEEJL5jZgXwHd8o=
Received: from BN0PR04CA0065.namprd04.prod.outlook.com (2603:10b6:408:ea::10)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 27 Jul
 2023 18:11:21 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::a3) by BN0PR04CA0065.outlook.office365.com
 (2603:10b6:408:ea::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 18:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 18:11:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 13:11:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: add new INFO ioctl query for the last GPU
 page fault
Date: Thu, 27 Jul 2023 14:10:47 -0400
Message-ID: <20230727181048.1222388-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727181048.1222388-1-alexander.deucher@amd.com>
References: <20230727181048.1222388-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7780ad-95cf-4c3d-7cfc-08db8ecce16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7lSLmLOE9PM0zG442OMQlJaJthaj0zcv4ZQmd6gJLpcr8KDXh9zmkG8I+c5b6Q+bdT++cuWTSvKo46lG9szL7G3+L57bDdOyCUccBpleJn9D6nXE2oCeXwSw652I5+QrKZr+v3JSY14HBxBNMtpS6Gl+fYD/W6jmYloWslw5u64ssDuTgoK4fspDXkpn/Bei+Y0viLvY9W+rzIgbXoKOWv/VmKkw5zsJh1qfgV5Pu6cjIN4mdrKYpOLoXM44wXacY/ihpCxwD2wC4wnivTLiv2WGxwY8cVt3aWDWLG1RaoK3nXGeL60bnvzVwXMBmlQylZ7isjCF1TTee2yzE1Y7rAlSt6q6glfmLIY84SZ955pMCONZV2ap+BL+1bLyRqETeMc+p2o0UcRpSwIH8fepGwwBKZUwvSjgmgExy9h+69a8LNVf500MOY1qimoyYTu2MWRnh+IGI+GCD/nLFj+h5EygTCt03qsU4AQ6xzJknRTCIHMrx/EoCKpan6pSyGhlYJ2Hnpn84QnPYlCNM7P/ogB6bBkRLE0d/BORFp8Rpy+ezyNQMXjCGPmwdDUDFYvsZAA1Y+64gl6L5UPfZ+QAJXvGW+9kL+aQl/6+Wfw0fv49anZQzVeX8ci8v1A0Zm/0U11hynZP+RVMoKhToq9fe+RYzsAUxHrL1EO204/3wWP1OtevQomhkofxuJzx8JitB/DFKli0j2LZeHAR/R6KaS5EVkegkWKwXsV0P+m1YSTIJkH+LLyk/Bg62fhtdpX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(336012)(40460700003)(186003)(966005)(7696005)(83380400001)(6666004)(36860700001)(81166007)(2616005)(36756003)(47076005)(356005)(426003)(82740400003)(86362001)(40480700001)(16526019)(1076003)(26005)(54906003)(2906002)(6916009)(70586007)(70206006)(8676002)(316002)(8936002)(4326008)(478600001)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 18:11:20.9135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7780ad-95cf-4c3d-7cfc-08db8ecce16b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 samuel.pitoiset@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a interface to query the last GPU page fault for the process.
Useful for debugging context lost errors.

v2: split vmhub representation between kernel and userspace
v3: add locking when fetching fault info in INFO IOCTL

Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238
libdrm MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238

Cc: samuel.pitoiset@gmail.com
Acked-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 13 ++++++++++---
 include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
 5 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d944e4aa17c85..247252a8f64d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -113,9 +113,10 @@
  *            gl1c_cache_size, gl2c_cache_size, mall_size, enabled_rb_pipes_mask_hi
  *   3.53.0 - Support for GFX11 CP GFX shadowing
  *   3.54.0 - Add AMDGPU_CTX_QUERY2_FLAGS_RESET_IN_PROGRESS support
+ * - 3.55.0 - Add AMDGPU_INFO_GPUVM_FAULT query
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	54
+#define KMS_DRIVER_MINOR	55
 #define KMS_DRIVER_PATCHLEVEL	0
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 631c5ab3f7dc5..c6cbbd9441095 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1168,6 +1168,26 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return copy_to_user(out, max_ibs,
 				    min((size_t)size, sizeof(max_ibs))) ? -EFAULT : 0;
 	}
+	case AMDGPU_INFO_GPUVM_FAULT: {
+		struct amdgpu_fpriv *fpriv = filp->driver_priv;
+		struct amdgpu_vm *vm = &fpriv->vm;
+		struct drm_amdgpu_info_gpuvm_fault gpuvm_fault;
+		unsigned long flags;
+
+		if (!vm)
+			return -EINVAL;
+
+		memset(&gpuvm_fault, 0, sizeof(gpuvm_fault));
+
+		xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+		gpuvm_fault.addr = vm->fault_info.addr;
+		gpuvm_fault.status = vm->fault_info.status;
+		gpuvm_fault.vmhub = vm->fault_info.vmhub;
+		xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+
+		return copy_to_user(out, &gpuvm_fault,
+				    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 36908dfcba6e4..9294264b15745 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2760,7 +2760,21 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 	if (vm) {
 		vm->fault_info.addr = addr;
 		vm->fault_info.status = status;
-		vm->fault_info.vmhub = vmhub;
+		if (AMDGPU_IS_GFXHUB(vmhub)) {
+			vm->fault_info.vmhub = AMDGPU_VMHUB_TYPE_GFX;
+			vm->fault_info.vmhub |=
+				(vmhub - AMDGPU_GFXHUB_START) << AMDGPU_VMHUB_IDX_SHIFT;
+		} else if (AMDGPU_IS_MMHUB0(vmhub)) {
+			vm->fault_info.vmhub = AMDGPU_VMHUB_TYPE_MM0;
+			vm->fault_info.vmhub |=
+				(vmhub - AMDGPU_MMHUB0_START) << AMDGPU_VMHUB_IDX_SHIFT;
+		} else if (AMDGPU_IS_MMHUB1(vmhub)) {
+			vm->fault_info.vmhub = AMDGPU_VMHUB_TYPE_MM1;
+			vm->fault_info.vmhub |=
+				(vmhub - AMDGPU_MMHUB1_START) << AMDGPU_VMHUB_IDX_SHIFT;
+		} else {
+			WARN_ONCE(1, "Invalid vmhub %u\n", vmhub);
+		}
 	}
 	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index bab185c5eb128..19f5a261f6bbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -122,9 +122,16 @@ struct amdgpu_mem_stats;
  * layout: max 8 GFXHUB + 4 MMHUB0 + 1 MMHUB1
  */
 #define AMDGPU_MAX_VMHUBS			13
-#define AMDGPU_GFXHUB(x)			(x)
-#define AMDGPU_MMHUB0(x)			(8 + x)
-#define AMDGPU_MMHUB1(x)			(8 + 4 + x)
+#define AMDGPU_GFXHUB_START			0
+#define AMDGPU_MMHUB0_START			8
+#define AMDGPU_MMHUB1_START			12
+#define AMDGPU_GFXHUB(x)			(AMDGPU_GFXHUB_START + (x))
+#define AMDGPU_MMHUB0(x)			(AMDGPU_MMHUB0_START + (x))
+#define AMDGPU_MMHUB1(x)			(AMDGPU_MMHUB1_START + (x))
+
+#define AMDGPU_IS_GFXHUB(x) ((x) >= AMDGPU_GFXHUB_START && (x) < AMDGPU_MMHUB0_START)
+#define AMDGPU_IS_MMHUB0(x) ((x) >= AMDGPU_MMHUB0_START && (x) < AMDGPU_MMHUB1_START)
+#define AMDGPU_IS_MMHUB1(x) ((x) >= AMDGPU_MMHUB1_START && (x) < AMDGPU_MAX_VMHUBS)
 
 /* Reserve 2MB at top/bottom of address space for kernel use */
 #define AMDGPU_VA_RESERVED_SIZE			(2ULL << 20)
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 79b14828d542a..bbe3ae6dc546d 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -890,6 +890,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
 /* Query the max number of IBs per gang per submission */
 #define AMDGPU_INFO_MAX_IBS			0x22
+/* query last page fault info */
+#define AMDGPU_INFO_GPUVM_FAULT			0x23
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1215,6 +1217,20 @@ struct drm_amdgpu_info_video_caps {
 	struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
 };
 
+#define AMDGPU_VMHUB_TYPE_MASK			0xff
+#define AMDGPU_VMHUB_TYPE_SHIFT			0
+#define AMDGPU_VMHUB_TYPE_GFX			0
+#define AMDGPU_VMHUB_TYPE_MM0			1
+#define AMDGPU_VMHUB_TYPE_MM1			2
+#define AMDGPU_VMHUB_IDX_MASK			0xff00
+#define AMDGPU_VMHUB_IDX_SHIFT			8
+
+struct drm_amdgpu_info_gpuvm_fault {
+	__u64 addr;
+	__u32 status;
+	__u32 vmhub;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.41.0

