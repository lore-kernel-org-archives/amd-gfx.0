Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80134E732D0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 20:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D553C10E6A5;
	Thu, 28 Sep 2023 20:06:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B2F410E3E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 20:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeXexfKNv9xRrXTznDqba4K/5EX0mhTrMQ28hbMlZWgicaiEHIekRoOCiB6PTu+0guSG7cG49/7V1Pr4pairp5zGcLuS3cundK/mfUplOE8vBI6QHCVsGexOcmOKg1S/pVDJJ3EwuokyEob5GXAm10kvBllRrotbholAdCXPbTl7V0RBTMMHXcp1Nx5AwGITn8m+991u8kzmtSAKdE7pgSwgNY90C6PntYbbhtb5g1Oq0wPLMkmZ/m7rg/QQBxK6hbXeWu/tLnsUXsBWxcUnMhCbhJWC0vpR/zpfleiXQhu7329WTSR4LpFm6NkxOsy5zMkcrcRjr6Jnczk+9iNnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaAFL79q1EQ6+aDFl09+UVITSTKJhMmnooanUkYDPnc=;
 b=HxeroboRzH8iHi7nDzp4wSGduj0tbSHjzOO80GL9x5y6uBg+H0SmTsEsA6Z1AV5HkvZlFkngMzsMUF4BSZvQ7h7R3VQnP5PXwdaz5T2tiQN6o+rB1EPPNQXHLwy/vf8EPDFdEw9rRUJMWfUQ4y7BMQ8atNc7oXYBrXSWZIT8QzRTrkjL+D1mcwBdMSftasXisHgGUhz7bp6Pdo3aAGOACsQbn92DPnPuJ++kz1Wo9sX8xqxQnctyH6eoCR6XlB3dNusI5J4qVDXRKRicFb9APeFA55+oj/K4KgH0s/jp1SwODFIFL92fUoxkmaTD1tg/V2Rvbbj2IKL4QakHxERoZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaAFL79q1EQ6+aDFl09+UVITSTKJhMmnooanUkYDPnc=;
 b=ohDVxREO7GI26HgPHJDDobyQI/nqZdWcYyHQB5glNuuMOLsAfuxA+KoCC8O2M7+DUnAx7EYJysecgdNmM+HwsYNoFP5OmpBQwGsq6jkbOYNorPh8lmRmvdZGjFQIwBEkLvL+Gz3Exx9UbGgiTDfW++K6+iZDMeInxuSk0MVrOvk=
Received: from MW2PR2101CA0001.namprd21.prod.outlook.com (2603:10b6:302:1::14)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 20:06:25 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::4e) by MW2PR2101CA0001.outlook.office365.com
 (2603:10b6:302:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.13 via Frontend
 Transport; Thu, 28 Sep 2023 20:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.25 via Frontend Transport; Thu, 28 Sep 2023 20:06:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 15:06:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: add new INFO ioctl query for the last GPU
 page fault
Date: Thu, 28 Sep 2023 16:06:07 -0400
Message-ID: <20230928200608.2857534-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928200608.2857534-1-alexander.deucher@amd.com>
References: <20230928200608.2857534-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: aa751bad-3df7-48a8-8d3e-08dbc05e6489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWjVhG3ko28WpnzmQiHdBZgtPxVWclyZLkG5LWvDgoeOyAoG17Cb+BBIl64AS884+D75bu8shAGWAxnoU24fWGvcKL5uEiofDg1r2oCGq8g/U1zw0ClTRRCyoPkiMjQ0iyzVd45aUNYXQEWKAgeVCnT5XRZsrdbTkZ0xoxmafqxQ0J1jiROwAy/NtqX4fPGV9pFvFi2Wkf3im9iDFgKgwBSwCB+wk00IOJA7kahV/0aRiEk/FGbjJrs29mU6VFyoyASfd9QW60HPz9OfpSbZy0Qhko7Q4AvekaZ69bgakhI00PArfHE3XMSAWjCYq/cgxF8IoC9A/iovkFMgn4LTIG8uFXEDWHMnWgOf8rxZokUlRDuZuE6Bw2gN+1M25Drhuph9sSnQ/csr4PrBmgPMhpkKiO+4Kl/Whf67b7LfLO163pENext8ZSYEMOkuSSjlZb0AVXgaOhHDxog2KY5eQvrW1vwvqARBEK4rWkFe2ylCsNbMiwSybAm9vMOkg+wcKSTtyYvkzGX2mKte2nPwQFeGLn0Eb9szn+6zwYsSNzHE4fB88vIuh+w9wLe+SIQcu17+K1L+lWMeNSRBr3SdBbQRfdQV7CcK1SadFS+ioo3pTKoJ5WCexkQ86gcxyHVGz5LYFbVey/M3hZp+dujaRcdiD44t+GWLfSGmPFg0GRGphcU5OYxj7zJs26NqBCrkY1v2QobgMkOxru3Ya+dbZXj5iH1ba08eTWHjXa4AjR6IWxRlviYRqgmyvcv7vbeq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(316002)(6916009)(8936002)(4326008)(41300700001)(54906003)(8676002)(70206006)(70586007)(966005)(478600001)(6666004)(7696005)(2616005)(1076003)(16526019)(26005)(426003)(336012)(40460700003)(83380400001)(47076005)(82740400003)(36860700001)(40480700001)(86362001)(81166007)(356005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 20:06:24.7846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa751bad-3df7-48a8-8d3e-08dbc05e6489
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
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
index d9052475f2fc..d2cf1c39563b 100644
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
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 081bd28e2443..6cd77c21048b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1224,6 +1224,26 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
index 91e36b0ad062..4058ed49e5a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2756,7 +2756,21 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
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
index 2bf328d9e04b..411d42fecfb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -124,9 +124,16 @@ struct amdgpu_mem_stats;
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
index 984fc16577ca..d627d0c6ac87 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -906,6 +906,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
 /* Query the max number of IBs per gang per submission */
 #define AMDGPU_INFO_MAX_IBS			0x22
+/* query last page fault info */
+#define AMDGPU_INFO_GPUVM_FAULT			0x23
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1231,6 +1233,20 @@ struct drm_amdgpu_info_video_caps {
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

