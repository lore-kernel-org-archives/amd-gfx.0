Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380CBC77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 16:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304AE10E6D3;
	Thu, 25 May 2023 16:52:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D803710E453
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 16:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmkG9fy1HtkTFtkvdvsMBiUrUSSUIaVawIkcnjhVAf2JxklXR2rJwppKBftjEBMjhy1O9B6lt7htBkxDTKjGsv7TgdcnUEtS5DOmSy+D+M1vOHlNKDxOR76Bw8mqL+NQfC/X7C99BZx2wb5w8+2s1npQgP5e47T7LI9RQ4q4eyn6DYSjOYeHkXCzAkGZvNFeRXzjz6JEPdeFt3szTktV0YCf408kGTNa9/fXa3RAYt4ZHlMcjdmezNSeii0RhZ/8ekXn899671EYd5REZM0OHCSuMakL/7d7NfssN7bwKKLe6GPu2nS39QOLG9fvVVx3eQP1Vj7p8hGkawjGEfp9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYALhLpPs3Pjvt6kzndse5UWuWY03E4qVODIvw/opTU=;
 b=VWasElnMPYg2HViEy0xQksQeTc5Vt/1fsiyQ18uw226VJfSaw2f2YVcQvhz/XXFnRfWLtWC6D6XJaIUKsZ2+O+KsuFk8YEqK8BmcwBFkDkV++uSRBLRL5KigEQISLJD6YYepc1tOa3M6NstX7xv7kHuKBEHVW6E1wzSSEnu5usKPB589cGSeWcRf3k8VAfJoKqVwp2wIQtmAqHKoXSxtPPPFEAiqwtLN31Dzxgr+n+k9oleQJimP4yqzibSIN9r83k+/z0Rap3oLAAxHd7Ct3vCaOTq7irZzpvu8YtFMk9aJjNKMP1XQHD7MtFPCo8C6GJCDJ2gFIdIxKS8T++ywpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYALhLpPs3Pjvt6kzndse5UWuWY03E4qVODIvw/opTU=;
 b=Pl9NHZ1peij8FPPZPGUD/jAleQZydnti8cacpNvQ86ZtS6Nk26mfofXTlBPrVDY8qOxV+cb13kHancrls1wPU2BXU2k1rb9FvXjbTS7gdS22r/wZvhfWnofggDfj1IiWMpAq59OYpu2XE0GPhEuu5hE+c1WAG0L+JGGoGvPQ2VQ=
Received: from BN9PR03CA0283.namprd03.prod.outlook.com (2603:10b6:408:f5::18)
 by DS7PR12MB8251.namprd12.prod.outlook.com (2603:10b6:8:e3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Thu, 25 May 2023 16:52:42 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::d2) by BN9PR03CA0283.outlook.office365.com
 (2603:10b6:408:f5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17 via Frontend
 Transport; Thu, 25 May 2023 16:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.16 via Frontend Transport; Thu, 25 May 2023 16:52:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 11:52:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: add new INFO ioctl query for the last GPU
 page fault
Date: Thu, 25 May 2023 12:52:19 -0400
Message-ID: <20230525165219.544671-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525165219.544671-1-alexander.deucher@amd.com>
References: <20230525165219.544671-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|DS7PR12MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa0f242-d112-4f51-b053-08db5d4074ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIvwrL+6HSUCdy/D2AXvMC7s/Rqs/bXIpH4hE68dhqFy31pdubD1gjfTFfCBWfqCYkFEOTJOnHudjo24e4KMGNof5DsX+01Dmtw3s8U8QHYIlI52a9JBJR/BUCORgIlUkJ8XbnmWk6mFLij4i+190UArgbz2IBJ+NAH8vOY0f0JtQYU44WLDCvsf52YkJAfj/HXiF7VOoBSMWmq5gV4juYI7mnbve8SshrERJv7I1DY49T+bCKsRDEBumHutnpa0P0z46V0+D36o4mwYgAPe7Izq87O5DvAm9MONRVlhs6eCgych7be0bc+TGwGD9hwUrn7u2WcJEAMCvCJKNFgA69uc6/EswO/epnw1PFA8E+ahkUv0uJTsuL/kzfHbhEFNsdtQO/loXp37dV6/TLHzGVNBSIcj3td+S/ioddgDuA9dA6cSNZAHUP+u1yMQQcOTlXGTb+9jhoiKOkNpaMObLHUymwo/d39l9BZ8Aw9PAzWFfmSOHZgd83tGjq+LsNl0gawwT9T3t87OA7Lr27ez/EmbYBektdVn8fo/Qy3JAf8L6BUQ6JBbtfBAThHZU9Y+BfuiuAaeIYMoVY8+sJfWH6mO5QZXnGJxE39iau7FaKtywrhepzyvKV15XUBeW/yqKnbPCOy6SHQJ3q4hpttYGkMJj52+OWtTfiWwaMZnArYCfpLZ4V4nTCZwNtfsXtaOY5BfK3KcLBRF3gXg6UvU5sRpTKFqyt1Tjdb2Up2XqtY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(6916009)(70206006)(70586007)(478600001)(7696005)(6666004)(966005)(54906003)(316002)(41300700001)(4326008)(86362001)(5660300002)(8676002)(8936002)(16526019)(26005)(81166007)(186003)(1076003)(40460700003)(356005)(336012)(82740400003)(426003)(83380400001)(2906002)(40480700001)(2616005)(36756003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 16:52:41.9281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa0f242-d112-4f51-b053-08db5d4074ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251
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
Cc: Alex Deucher <alexander.deucher@amd.com>, samuel.pitoiset@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a interface to query the last GPU page fault for the process.
Useful for debugging context lost errors.

v2: split vmhub representation between kernel and userspace

Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238
libdrm MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238

Cc: samuel.pitoiset@gmail.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 13 ++++++++++---
 include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
 5 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7300df2a342c..7e17b285decc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -112,9 +112,10 @@
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
index 41d047e5de69..bca2a56046ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1163,6 +1163,22 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return copy_to_user(out, max_ibs,
 				    min((size_t)size, sizeof(max_ibs))) ? -EFAULT : 0;
 	}
+	case AMDGPU_INFO_GPUVM_FAULT: {
+		struct amdgpu_fpriv *fpriv = filp->driver_priv;
+		struct amdgpu_vm *vm = &fpriv->vm;
+		struct drm_amdgpu_info_gpuvm_fault gpuvm_fault;
+
+		if (!vm)
+			return -EINVAL;
+
+		memset(&gpuvm_fault, 0, sizeof(gpuvm_fault));
+		gpuvm_fault.addr = vm->fault_info.addr;
+		gpuvm_fault.status = vm->fault_info.status;
+		gpuvm_fault.vmhub = vm->fault_info.vmhub;
+
+		return copy_to_user(out, &gpuvm_fault,
+				    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 73e022f3daa4..c1b0c5f3c1f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2657,7 +2657,21 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
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
index fb66a413110c..1a34fea9acb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -116,9 +116,16 @@ struct amdgpu_mem_stats;
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
index 79b14828d542..bbe3ae6dc546 100644
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
2.40.1

