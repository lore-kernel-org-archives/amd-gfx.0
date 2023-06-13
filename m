Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF79EB64D8
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 15:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3883A10E39D;
	Tue, 13 Jun 2023 15:07:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E2D10E3B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 15:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6ty4SGINefunn14JzH2dNY6bFXYcXfjCRsHRRwQGztktssqZ0mAoDzUYSHYtJ97PXLoBeu5SCr5MjJjyoemoPQoaoL5CtoCVeFy+mCHd8cXpZUvmjPI6vVHULCnW9zPPR4Ok2XfLRbKnDepi40R4858EnWAMMkdMn8rTeJKa8xhh0VB3d/0xgzoh+6KFMS4Ze+ak3K/fNjryuidW6bqFUabkSyZ9U8QgyUgZboOhLGLBJb9vShFEJadtpy4dnUz79hHerhUfwJCFGYw+eCWJ+/czI8CgnCbjzgXD8/uTPZFipzfhnqqsiWwi3hvjOz6yigqaDyXxPyIshX251DQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/1KrZ3VOZ+LbzCiN2Kx//vDVIzibCTHAz17m9eZopk=;
 b=IsQ0HRZqVmwCLmcEIe0opO1FCKGkWSsIvMZtizGFKKDERTQhGZyLsdImDQpzZc2qC9LJ4HnSdiWRpoWwJ3vBoNYid6tdOKVg7aqaldhLuHR3tiJ9GVlOlJ98RfWidXwRoTucHTgKbbmYhAywt0wBp65I0WRJlaaV6MTg4cafmR0hQnNATIONEwDOWSwSWK4deevwxlzz6U0U+0IH3Qq0kTBjRkIkQ1EJzbG83Tl6DHakiyM8UDKaU55uQxbcElmt7geO/BoyCE1zCZuQHiH8mGWHaU0tFfZIAuejV05B4SBbEP+49YLUcA9ZpJrfpdzKxLHWxHHBGlZGjdgcbsORoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/1KrZ3VOZ+LbzCiN2Kx//vDVIzibCTHAz17m9eZopk=;
 b=fFkB4I7mv+2JMryDb/d49Zodup5n5CiCqMDfy+gjRic/W6t/JeSiRaQUJOb3X6xo2GWleZFgHbn+HlCgxMlSVusqcL1nkInwSrnN6/eI6SkRY9BHh/Zh0KhVPhMZnVBLbnpXsQgCkExmhwIZhUgYA5UEXRXdbkIkP0u4uW/Eohg=
Received: from BN8PR15CA0014.namprd15.prod.outlook.com (2603:10b6:408:c0::27)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 15:07:47 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::d9) by BN8PR15CA0014.outlook.office365.com
 (2603:10b6:408:c0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 15:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 15:07:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 10:07:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: add new INFO ioctl query for the last GPU
 page fault
Date: Tue, 13 Jun 2023 11:07:12 -0400
Message-ID: <20230613150712.1703987-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613150712.1703987-1-alexander.deucher@amd.com>
References: <20230613150712.1703987-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 27eaa7f6-4442-4f02-be0a-08db6c1ff29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHVHvp+7n4vIYzStpn31/4gHR8NzV+UbrOSyfz5zBhobp5pFsZCTqITovd3iXxGQMd95Thw3Cl92hA8ZrCucxVw2cUYn/cMNu6oASdBOJiECWBKTM6gCiqOmhyy8lD6wWLvZwCXSBE8HEenY687Jk0+Slhdb5cewhQZ+22lV6B5IX6ZIzjnKP24D80rIh74XGVy7DfWBuGv9r3LJLuk5yUWhn1E25JeF19bs6E76QBIHVVEfcVp6flUoFKRSCC8tD6AmtkRFXaAkxtIG76/d58NCL5UPhAHdE//Pr4gaAueEFedCOKyQeURxgQ8IFttuAB0Zgx6mU2XKUERP1JKUALPgAJ0QwsdtJFLZeS9A+i4A6oix5+DpiajsJy9CcXP7oy4hroR++iS5oBVh/NQYStr4Xj5JJDJoa1qVozEy8jM+qtPk2Yj6ryRcAYhjXc5dxoQGQbkjAUGN3nxqdr5Yzg00nxC62OdcR3idpvxlXRYtiok5AlzSpwFqLXPRFX/EZkQkkLantHvG7SlTdoDG/YwT9EmB9dR7RjjZNKTvHPF14nyhzOsoN07qQ86A16tt8K0yYaZlM6e4kXbbTWq8SFz5NeMnsrlddmhvZ0fQ3tL9xqg2vPXYXcTfScHD2aTZsiXDW9RkCbbS7FOvy64CsjTLj2xbGVWQyvGKv52ArjTRaau8Y/eTdmWHXn39Jb3IvuQry6K0/SAS1BPN93vKmxqQG8PD0fgLtepIpi5iUgw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(336012)(426003)(2616005)(47076005)(83380400001)(36860700001)(356005)(82740400003)(40480700001)(82310400005)(86362001)(81166007)(36756003)(40460700003)(478600001)(54906003)(6666004)(7696005)(966005)(4326008)(8936002)(8676002)(2906002)(316002)(5660300002)(70586007)(70206006)(6916009)(186003)(16526019)(41300700001)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:07:47.2889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27eaa7f6-4442-4f02-be0a-08db6c1ff29c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964
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

Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238
libdrm MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238

Cc: samuel.pitoiset@gmail.com
Acked-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 13 ++++++++++---
 include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
 5 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 999d008b6b48..6b053bab799c 100644
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
index e3531aa3c8bd..2289f8eb3d1d 100644
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
index 5423f66a9ed8..2c1106855492 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2666,7 +2666,21 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
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

