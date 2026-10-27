Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ED9606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JLK10uF9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 588A510E308;
	Tue, 27 Oct 2026 12:57:29 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3B210E308
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 12:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wh/iGqRo4aYI0gDvuhmAtvakg+CT5b8YkSF5B7jYTfVoaq0E4VW3w/SlfbkdtHWVMs431qbJFLr8YgN6/WEV72m/0wwbkFSZ34DnM9j55cMy6iQyKfmQq2Tqa+w+cXV1CMqo+HCTqjd9CxKjYPywUIDHn6BDgI7gjgSwPUATu3b+koZU+mDuDVN/nm9N6VJQIYeqI7PBzYwJylmA9rPRSJS5GPAz1IqzuTvvMOJsg5TPKJLhpbigUrZGn2Wr4PQ1P/WRcAiCsNZ5YH5JeOk3DxXtuuwaxH6AacqA/RKCl/KQhDsAu/7Z8CIUGX+R4To/rGHJpYhgrpQMR2njusGtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S95jtO4X842MCXpuRaWOHU9NWLW+7jm/k1vf1RB9vQ=;
 b=VMh487pj18WFw11+I1ISkQ9sn4BBZHHH8Fq/aUH3wwkdjM6cjCeLss3gtFrTmCO2tE7I0PWnELIY6ELTC39ZGMHBEMuLtJJxbsvUw7q3daXNR24oK0sXd7yqOe0e5AXZc7lnyqy0mpW1sRXpCAxdCF5QUPZ4DJoMnEsoLPvN0bo3Sr4HyO/8WRtswlgsB3qER2UdCzFatrHbCPF5BzVGupyeYcEmDKrLPoBJ0Mu667ZdoYCLwfwvk690Rg3J+iFH1qQj8sWP/yPyFBoUKoxr3gEXcbCrjrd6Ni1aRgmLLtupfjw9Pnum3cjlaXcqzlqbEodxSnziDs86eGiDraLDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S95jtO4X842MCXpuRaWOHU9NWLW+7jm/k1vf1RB9vQ=;
 b=JLK10uF9gcmCY4T06VaA4YAGGJdyrbhFKHjVGuJD8rAJfatNMNCNN80lT8kVkUwvGRddU5yjezRdqgfQuudnHUOIpgxWlo+raUVVUGVXqpVwq11mGkOTkdMJgbvv/rxbKWhrfPK+3fMMwG/V55GFMgFiA9g1FVL5Cc4mxVfVhas=
Received: from PH8P220CA0035.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::7)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:56:40 +0000
Received: from CY4PEPF000392DD.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::6e) by PH8P220CA0035.outlook.office365.com
 (2603:10b6:510:348::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 12:56:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DD.mail.protection.outlook.com (10.167.247.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 12:56:39 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 07:56:38 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Zhigang.Luo@amd.com>, <Gavin.Wan@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: Extract PF-VF exchange code
Date: Tue, 27 Oct 2026 08:56:06 -0400
Message-ID: <20261027125613.6549-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DD:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6eb131-61d7-4541-a742-08df3429be2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|261021121427099003|261026140227099003|11063799006|56012099006|261022115727099003|261009221727099003|261009223327099003|261022105027099003|261009223027099003|261022113327099003|261009220027099003|261009221227099003|261021123027099003|10067099003|261022075727099003|18002099003|261026121527099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: +yasbkCCbrnrO/9sGbV26DmGSH6JivsLzIRTyTu49W16CNwtHgSmSHior7kilblM6jR3H8TUmEOPeTIICX+RiyvlFmbx1WTbd8sAoSts1AH8oLi+hilAR6McI0aFGp5kdZKXul4d5zcWZGkyvnQOwJG2TB3dKwflVMixIEtWx5PuLKGsHEouKekuP9IuvUx1OmIdjuyZ7+FTZIKqmp4+g0nZEQpvHKZfdeORhPhpx5ieOt7AeucSfA1ooUr4msl2XJ92oYUZ7C4GGC7wD0Y/ybZSFFSINdJBLgh/9XGPgujFlgtBZ2bihoiKfSqG10R1YjVNttkSOaGlNSGFtNiT7d4a69jJ480jmUpwdR00/umXF8ZrDTdh9wOKU2nZI+6ck8c3b2OO+fjFzO6Z64yhQWT1THHfMrAuXroQmYhmccAtaufAIFfKg7ti3hsJ1V6tfVAOT499jZDzla1xwCnPCm3MhvSE0idPj8MHPrke+UKWTUSGGvOJSO/D8MAqGWzWnZ1Wuzq7Gevdhjs2d3W4hiz4z7W5jcXxSrz/fNTJ0Bebzqqp37D7uZscK0CN4SBFrUeLElSuEzHCwi7ZLAGnRfdnr4FAxeEdDgBqQgVd+PolPq1RFzYuMKvpjyCXQ+2FvPXAz1D4OacMw5uFNyqR/7ODI8iWOxDdKeKu8C2CoherzLjEXxoUvpRRsYrH3b92HxNEbhH8w5J7djiq7MTWrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(261021121427099003)(261026140227099003)(11063799006)(56012099006)(261022115727099003)(261009221727099003)(261009223327099003)(261022105027099003)(261009223027099003)(261022113327099003)(261009220027099003)(261009221227099003)(261021123027099003)(10067099003)(261022075727099003)(18002099003)(261026121527099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D9EUnHaG9GSBl3MmmXDimXKNkQ3l4IU+yYwJVxkfCYYZc0glq4g3OlVc71V96GzqaGnUgdzsojsv18H+L1imVVPj8ViQ06MIHQlInMqYZzj6ssd4xRRj4aX4Wmak3N/XzOC/rlmg1/krZqFqNcc/pwzD7/pIz+MPXZTs21hGLMiOZphQK49qmRd5m77AWGeoP9OD3R1rX6g38r58CspxOLtDQ8JyGhhdWbucsvZRsqJ5T1ZOmJqHT2AeqNSXODzsV5xOt/ifiduTqRQjVUhJpcojDJ+MfT1GV3DAg6f8WWBlRVcxzINea1mocEJBmdgsHurvBpBM/n8P1L467EJT874+sOSwLxflbM7RUHGGBA/U9AVI2+PDPiUm/qQz/gBUnNB8+QUZ8nm5R6icXqKFWUYDAgvEnn1w+zQe9UDhCA3GEOmKjkZiRCTcoAWDUG7Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 12:56:39.7988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6eb131-61d7-4541-a742-08df3429be2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
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

With subsequent patches, additional CRIT_REGION version logic will be added.
For readability, move all VF-PF exchange logic into a dedicated file.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 662 +----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c | 682 ++++++++++++++++++
 4 files changed, 703 insertions(+), 662 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 8687afc00c24..3f49b59bb648 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -62,8 +62,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
 	amdgpu_ib.o amdgpu_pll.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
-	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
-	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
+	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o \
+	amdgpu_atomfirmware.o amdgpu_sched.o \
 	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o amdgpu_mmhub.o amdgpu_hdp.o \
 	amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
@@ -86,14 +86,23 @@ amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce
 	uvd_v3_1.o vce_v1_0.o
 
 amdgpu-y += \
-	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
-	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
+	vi.o nbio_v6_1.o soc15.o emu_soc.o nbio_v7_0.o vega10_reg_init.o \
+	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o soc24.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
 	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
 	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o nbio_v6_3_2.o nbio_v7_11_5.o \
 	nbif_v7_10.o hdp_v8_0.o lsdma_v8_0.o nbio_v7_11_4.o
 
+# add virt block
+amdgpu-y += \
+	amdgpu_virt.o \
+	amdgpu_virt_xchg.o \
+	amdgpu_vf_error.o \
+	mxgpu_vi.o \
+	mxgpu_ai.o \
+	mxgpu_nv.o
+
 # add DF block
 amdgpu-y += \
 	df_v1_7.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 4b1b42fee6b4..d8b7d02b4205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -40,24 +40,6 @@
 #include "nv.h"
 #include "amdgpu_virt_ras_cmd.h"
 
-#define POPULATE_UCODE_INFO(vf2pf_info, ucode, ver) \
-	do { \
-		vf2pf_info->ucode_info[ucode].id = ucode; \
-		vf2pf_info->ucode_info[ucode].version = ver; \
-	} while (0)
-
-#define mmRCC_CONFIG_MEMSIZE    0xde3
-#define mmRCC_HW_DEBUG          0x10c01
-
-const char *amdgpu_virt_dynamic_crit_table_name[] = {
-	"IP DISCOVERY",
-	"VBIOS IMG",
-	"RAS TELEMETRY",
-	"DATA EXCHANGE",
-	"BAD PAGE INFO",
-	"INIT HEADER",
-	"LAST",
-};
 
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
 {
@@ -340,42 +322,7 @@ static int amdgpu_virt_ras_realloc_eh_data_space(struct amdgpu_device *adev,
 	return 0;
 }
 
-int amdgpu_virt_get_uniras_ras_caps(struct amdgpu_device *adev,
-				    struct amd_sriov_uniras_caps *caps)
-{
-	struct amd_sriov_msg_pf2vf_info *pf2vf_msg;
-
-	if (!adev || !caps)
-		return -EINVAL;
-
-	if (!adev->virt.fw_reserve.p_pf2vf)
-		return -EINVAL;
-
-	if (adev->virt.fw_reserve.p_pf2vf->version != AMD_SRIOV_MSG_FW_VRAM_PF2VF_VER)
-		return -EINVAL;
-
-	pf2vf_msg = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
-
-	if (pf2vf_msg->header.size > (AMD_SRIOV_MSG_SIZE_KB << 10) ||
-	    pf2vf_msg->header.size <
-	    offsetof(struct amd_sriov_msg_pf2vf_info, pf2vf_ras_caps) +
-	    sizeof(pf2vf_msg->pf2vf_ras_caps))
-		return -EINVAL;
-
-	if (!pf2vf_msg->feature_flags.flags.uniras_support)
-		return -EOPNOTSUPP;
-
-	*caps = pf2vf_msg->pf2vf_ras_caps.uniras_caps;
-
-	dev_dbg(adev->dev,
-		"uniras caps: ras_ext_ecc_type=0x%x ras_int_ecc_attributes=0x%x ras_en_block_mask=0x%llx\n",
-		caps->ras_ext_ecc_type, caps->ras_int_ecc_attributes,
-		caps->ras_en_block_mask);
-
-	return 0;
-}
-
-static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
+int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 {
 	struct amdgpu_virt *virt = &adev->virt;
 	struct amdgpu_virt_ras_err_handler_data **data = &virt->virt_eh_data;
@@ -451,7 +398,7 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev)
 	virt->virt_eh_data = NULL;
 }
 
-static bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
+bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
 		const struct eeprom_table_record *bps, int pages)
 {
 	struct amdgpu_virt *virt = &adev->virt;
@@ -480,7 +427,7 @@ static bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
 	return true;
 }
 
-static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
+void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
 {
 	struct amdgpu_virt *virt = &adev->virt;
 	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
@@ -520,7 +467,7 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
 	}
 }
 
-static bool amdgpu_virt_ras_check_bad_page(struct amdgpu_device *adev,
+bool amdgpu_virt_ras_check_bad_page(struct amdgpu_device *adev,
 		uint64_t retired_page)
 {
 	struct amdgpu_virt *virt = &adev->virt;
@@ -537,406 +484,6 @@ static bool amdgpu_virt_ras_check_bad_page(struct amdgpu_device *adev,
 	return false;
 }
 
-static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
-		uint64_t bp_block_offset, uint32_t bp_block_size)
-{
-	struct eeprom_table_record bp;
-	uint64_t retired_page;
-	uint32_t bp_idx, bp_cnt;
-	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
-	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
-	void *vram_usage_va = fw_va ? fw_va : drv_va;
-
-	memset(&bp, 0, sizeof(bp));
-
-	if (!bp_block_size)
-		return;
-
-	bp_cnt = bp_block_size / sizeof(uint64_t);
-	for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-		retired_page = *(uint64_t *)(vram_usage_va +
-				bp_block_offset + bp_idx * sizeof(uint64_t));
-		bp.retired_page = retired_page;
-
-		if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
-			continue;
-
-		if (!amdgpu_virt_ras_add_bps(adev, &bp, 1))
-			break;
-
-		amdgpu_virt_ras_reserve_bps(adev);
-	}
-}
-
-static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
-{
-	struct amd_sriov_msg_pf2vf_info_header *pf2vf_info = adev->virt.fw_reserve.p_pf2vf;
-	struct amdgim_pf2vf_info_v1 *pf2vf_v1;
-	struct amd_sriov_msg_pf2vf_info *pf2vf;
-
-	uint32_t checksum;
-	uint32_t checkval;
-
-	uint32_t i;
-	uint32_t tmp;
-
-	if (adev->virt.fw_reserve.p_pf2vf == NULL)
-		return -EINVAL;
-
-	if (pf2vf_info->size > 1024) {
-		dev_err(adev->dev, "invalid pf2vf message size: 0x%x\n", pf2vf_info->size);
-		return -EINVAL;
-	}
-
-	switch (pf2vf_info->version) {
-	case 1:
-		pf2vf_v1 = (struct amdgim_pf2vf_info_v1 *)pf2vf_info;
-		checksum = pf2vf_v1->checksum;
-		checkval = amd_sriov_msg_checksum(
-			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
-			adev->virt.fw_reserve.checksum_key, checksum);
-		if (checksum != checkval) {
-			dev_err(adev->dev,
-				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
-				checksum, checkval);
-			return -EINVAL;
-		}
-
-		adev->virt.gim_feature = pf2vf_v1->feature_flags;
-		break;
-	case 2:
-		/* TODO: missing key, need to add it later */
-		pf2vf = (struct amd_sriov_msg_pf2vf_info *)pf2vf_info;
-		checksum = pf2vf->checksum;
-		checkval = amd_sriov_msg_checksum(
-			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
-			0, checksum);
-		if (checksum != checkval) {
-			dev_err(adev->dev,
-				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
-				checksum, checkval);
-			return -EINVAL;
-		}
-
-		adev->virt.vf2pf_update_interval_ms =
-			pf2vf->vf2pf_update_interval_ms;
-		adev->virt.gim_feature = pf2vf->feature_flags.all;
-		adev->virt.reg_access = pf2vf->reg_access_flags.all;
-
-		adev->virt.decode_max_dimension_pixels = 0;
-		adev->virt.decode_max_frame_pixels = 0;
-		adev->virt.encode_max_dimension_pixels = 0;
-		adev->virt.encode_max_frame_pixels = 0;
-		adev->virt.is_mm_bw_enabled = false;
-		for (i = 0; i < AMD_SRIOV_MSG_RESERVE_VCN_INST; i++) {
-			tmp = pf2vf->mm_bw_management[i].decode_max_dimension_pixels;
-			adev->virt.decode_max_dimension_pixels = max(tmp, adev->virt.decode_max_dimension_pixels);
-
-			tmp = pf2vf->mm_bw_management[i].decode_max_frame_pixels;
-			adev->virt.decode_max_frame_pixels = max(tmp, adev->virt.decode_max_frame_pixels);
-
-			tmp = pf2vf->mm_bw_management[i].encode_max_dimension_pixels;
-			adev->virt.encode_max_dimension_pixels = max(tmp, adev->virt.encode_max_dimension_pixels);
-
-			tmp = pf2vf->mm_bw_management[i].encode_max_frame_pixels;
-			adev->virt.encode_max_frame_pixels = max(tmp, adev->virt.encode_max_frame_pixels);
-		}
-		if ((adev->virt.decode_max_dimension_pixels > 0) || (adev->virt.encode_max_dimension_pixels > 0))
-			adev->virt.is_mm_bw_enabled = true;
-
-		adev->unique_id = pf2vf->uuid;
-
-		adev->unitid = 0;
-		if (amdgpu_sriov_is_unitid_support(adev))
-			adev->unitid = pf2vf->unitid;
-
-		adev->virt.ras_en_caps.all = pf2vf->pf2vf_ras_caps.ras_en_caps.all;
-		adev->virt.ras_telemetry_en_caps.all =
-			pf2vf->pf2vf_ras_caps.ras_telemetry_en_caps.all;
-
-		adev->have_atomics_support = pf2vf->pcie_atomic_ops_support_flags ==
-			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
-		break;
-	default:
-		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
-		return -EINVAL;
-	}
-
-	/* correct too large or too little interval value */
-	if (adev->virt.vf2pf_update_interval_ms < 200 || adev->virt.vf2pf_update_interval_ms > 10000)
-		adev->virt.vf2pf_update_interval_ms = 2000;
-
-	return 0;
-}
-
-static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
-{
-	struct amd_sriov_msg_vf2pf_info *vf2pf_info;
-	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.fw_reserve.p_vf2pf;
-
-	if (adev->virt.fw_reserve.p_vf2pf == NULL)
-		return;
-
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_VCE,      adev->vce.fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_UVD,      adev->uvd.fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MC,       adev->gmc.fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ME,       adev->gfx.me_fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_PFP,      adev->gfx.pfp_fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_CE,       adev->gfx.ce_fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC,      adev->gfx.rlc_fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLC, adev->gfx.rlc_srlc_fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLG, adev->gfx.rlc_srlg_fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLS, adev->gfx.rlc_srls_fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      adev->gfx.mec_fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     adev->gfx.mec2_fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      adev->psp.sos.fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
-			    adev->psp.asd_context.bin_desc.fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_RAS,
-			    adev->psp.ras_context.context.bin_desc.fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_XGMI,
-			    adev->psp.xgmi_context.context.bin_desc.fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SMC,      adev->pm.fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA,     adev->sdma.instance[0].fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA2,    adev->sdma.instance[1].fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_VCN,      adev->vcn.fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_DMCU,     adev->dm.dmcu_fw_version);
-}
-
-static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
-{
-	struct amd_sriov_msg_vf2pf_info *vf2pf_info;
-
-	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.fw_reserve.p_vf2pf;
-
-	if (adev->virt.fw_reserve.p_vf2pf == NULL)
-		return -EINVAL;
-
-	memset(vf2pf_info, 0, sizeof(struct amd_sriov_msg_vf2pf_info));
-
-	vf2pf_info->header.size = sizeof(struct amd_sriov_msg_vf2pf_info);
-	vf2pf_info->header.version = AMD_SRIOV_MSG_FW_VRAM_VF2PF_VER;
-
-#ifdef MODULE
-	if (THIS_MODULE->version != NULL)
-		strscpy(vf2pf_info->driver_version, THIS_MODULE->version);
-	else
-#endif
-		strscpy(vf2pf_info->driver_version, "N/A");
-
-	vf2pf_info->pf2vf_version_required = 0; // no requirement, guest understands all
-	vf2pf_info->driver_cert = 0;
-	vf2pf_info->os_info.all = 0;
-
-	vf2pf_info->fb_usage = ttm_resource_manager_used(&adev->mman.vram_mgr.manager) ?
-		 ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) >> 20 : 0;
-	vf2pf_info->fb_vis_usage =
-		amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr) >> 20;
-	vf2pf_info->fb_size = adev->gmc.real_vram_size >> 20;
-	vf2pf_info->fb_vis_size = adev->gmc.visible_vram_size >> 20;
-
-	amdgpu_virt_populate_vf2pf_ucode_info(adev);
-
-	/* TODO: read dynamic info */
-	vf2pf_info->gfx_usage = 0;
-	vf2pf_info->compute_usage = 0;
-	vf2pf_info->encode_usage = 0;
-	vf2pf_info->decode_usage = 0;
-
-	vf2pf_info->dummy_page_addr = (uint64_t)adev->dummy_page_addr;
-	if (amdgpu_sriov_is_mes_info_enable(adev)) {
-		vf2pf_info->mes_info_addr =
-			(uint64_t)(adev->mes.resource_1_gpu_addr[0] + AMDGPU_GPU_PAGE_SIZE);
-		vf2pf_info->mes_info_size =
-			adev->mes.resource_1[0]->tbo.base.size - AMDGPU_GPU_PAGE_SIZE;
-	}
-	vf2pf_info->checksum =
-		amd_sriov_msg_checksum(
-		vf2pf_info, sizeof(*vf2pf_info), 0, 0);
-
-	return 0;
-}
-
-static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
-{
-	struct amdgpu_device *adev = container_of(work, struct amdgpu_device, virt.vf2pf_work.work);
-	int ret;
-
-	ret = amdgpu_virt_read_pf2vf_data(adev);
-	if (ret) {
-		adev->virt.vf2pf_update_retry_cnt++;
-
-		if ((amdgpu_virt_rcvd_ras_interrupt(adev) ||
-			adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
-			amdgpu_sriov_runtime(adev)) {
-
-			amdgpu_ras_set_fed(adev, true);
-			if (amdgpu_reset_domain_schedule(adev->reset_domain,
-							&adev->kfd.reset_work))
-				return;
-			else
-				dev_err(adev->dev, "Failed to queue work! at %s", __func__);
-		}
-
-		goto out;
-	}
-
-	adev->virt.vf2pf_update_retry_cnt = 0;
-	amdgpu_virt_write_vf2pf_data(adev);
-
-out:
-	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
-}
-
-static int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data)
-{
-	uint32_t dataexchange_offset =
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset;
-	uint32_t dataexchange_size =
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10;
-	uint64_t pos = 0;
-
-	dev_info(adev->dev,
-			"Got data exchange info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
-			dataexchange_offset, dataexchange_size);
-
-	if (!IS_ALIGNED(dataexchange_offset, 4) || !IS_ALIGNED(dataexchange_size, 4)) {
-		dev_err(adev->dev, "Data exchange data not aligned to 4 bytes\n");
-		return -EINVAL;
-	}
-
-	pos = (uint64_t)dataexchange_offset;
-	amdgpu_device_vram_access(adev, pos, pfvf_data,
-			dataexchange_size, false);
-
-	return 0;
-}
-
-void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
-{
-	if (adev->virt.vf2pf_update_interval_ms != 0) {
-		dev_info(adev->dev, "clean up the vf2pf work item\n");
-		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
-		adev->virt.vf2pf_update_interval_ms = 0;
-	}
-}
-
-void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
-{
-	uint32_t *pfvf_data = NULL;
-	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
-	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
-
-	adev->virt.fw_reserve.p_pf2vf = NULL;
-	adev->virt.fw_reserve.p_vf2pf = NULL;
-	adev->virt.vf2pf_update_interval_ms = 0;
-	adev->virt.vf2pf_update_retry_cnt = 0;
-
-	if (fw_va && drv_va) {
-		dev_warn(adev->dev, "Currently fw_vram and drv_vram should not have values at the same time!");
-	} else if (fw_va || drv_va) {
-		/* go through this logic in ip_init and reset to init workqueue*/
-		amdgpu_virt_exchange_data(adev);
-
-		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
-		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
-	} else if (adev->bios != NULL) {
-		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
-		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
-			pfvf_data =
-				kzalloc(adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
-					GFP_KERNEL);
-			if (!pfvf_data) {
-				dev_err(adev->dev, "Failed to allocate memory for pfvf_data\n");
-				return;
-			}
-
-			if (amdgpu_virt_read_exchange_data_from_mem(adev, pfvf_data))
-				goto free_pfvf_data;
-
-			adev->virt.fw_reserve.p_pf2vf =
-				(struct amd_sriov_msg_pf2vf_info_header *)pfvf_data;
-
-			amdgpu_virt_read_pf2vf_data(adev);
-
-free_pfvf_data:
-			kfree(pfvf_data);
-			pfvf_data = NULL;
-			adev->virt.fw_reserve.p_pf2vf = NULL;
-		} else {
-			adev->virt.fw_reserve.p_pf2vf =
-				(struct amd_sriov_msg_pf2vf_info_header *)
-				(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
-
-			amdgpu_virt_read_pf2vf_data(adev);
-		}
-	}
-}
-
-
-void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
-{
-	uint64_t bp_block_offset = 0;
-	uint32_t bp_block_size = 0;
-	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
-	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
-	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
-
-	if (fw_va || drv_va) {
-		if (fw_va) {
-			if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
-				adev->virt.fw_reserve.p_pf2vf =
-					(struct amd_sriov_msg_pf2vf_info_header *)
-					(fw_va +
-					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset);
-				adev->virt.fw_reserve.p_vf2pf =
-					(struct amd_sriov_msg_vf2pf_info_header *)
-					(fw_va +
-					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset +
-					(AMD_SRIOV_MSG_SIZE_KB << 10));
-				adev->virt.fw_reserve.ras_telemetry =
-					(fw_va +
-					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset);
-			} else {
-				adev->virt.fw_reserve.p_pf2vf =
-					(struct amd_sriov_msg_pf2vf_info_header *)
-					(fw_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
-				adev->virt.fw_reserve.p_vf2pf =
-					(struct amd_sriov_msg_vf2pf_info_header *)
-					(fw_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
-				adev->virt.fw_reserve.ras_telemetry =
-					(fw_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
-			}
-		} else if (drv_va) {
-			adev->virt.fw_reserve.p_pf2vf =
-				(struct amd_sriov_msg_pf2vf_info_header *)
-				(drv_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
-			adev->virt.fw_reserve.p_vf2pf =
-				(struct amd_sriov_msg_vf2pf_info_header *)
-				(drv_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
-			adev->virt.fw_reserve.ras_telemetry =
-				(drv_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
-		}
-
-		amdgpu_virt_read_pf2vf_data(adev);
-		amdgpu_virt_write_vf2pf_data(adev);
-
-		/* bad page handling for version 2 */
-		if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
-			pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
-
-			bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
-				((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
-			bp_block_size = pf2vf_v2->bp_block_size;
-
-			if (bp_block_size && !adev->virt.ras_init_done)
-				amdgpu_virt_init_ras_err_handler_data(adev);
-
-			if (adev->virt.ras_init_done)
-				amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
-		}
-	}
-}
 
 static u32 amdgpu_virt_init_detect_asic(struct amdgpu_device *adev)
 {
@@ -1041,207 +588,6 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
 	adev->virt.ras.cper_rptr = 0;
 }
 
-static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
-{
-	uint32_t sum = 0;
-
-	if (buf_start >= buf_end)
-		return 0;
-
-	for (; buf_start < buf_end; buf_start++)
-		sum += buf_start[0];
-
-	return 0xffffffff - sum;
-}
-
-int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
-{
-	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
-	u64 init_hdr_offset = adev->virt.init_data_header.offset;
-	u64 init_hdr_size = (u64)adev->virt.init_data_header.size_kb << 10; /* KB → bytes */
-	u64 vram_size;
-	u64 end;
-	int r = 0;
-	uint8_t checksum = 0;
-
-	/* Skip below init if critical region version != v2 */
-	if (adev->virt.req_init_data_ver != GPU_CRIT_REGION_V2)
-		return 0;
-
-	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
-	/* Fall back to RCC_HW_DEBUG when RCC_CONFIG_MEMSIZE reads 0 on a VF. */
-	if (!vram_size)
-		vram_size = RREG32(mmRCC_HW_DEBUG);
-	if (!vram_size || vram_size == U32_MAX)
-		return -EINVAL;
-	vram_size <<= 20;
-
-	if (check_add_overflow(init_hdr_offset, init_hdr_size, &end) || end > vram_size) {
-		dev_err(adev->dev, "init_data_header exceeds VRAM size, exiting\n");
-		return -EINVAL;
-	}
-
-	/* Allocate for init_data_hdr */
-	init_data_hdr = kzalloc_obj(struct amd_sriov_msg_init_data_header);
-	if (!init_data_hdr)
-		return -ENOMEM;
-
-	amdgpu_device_vram_access(adev, (uint64_t)init_hdr_offset, (uint32_t *)init_data_hdr,
-					sizeof(struct amd_sriov_msg_init_data_header), false);
-
-	/* Table validation */
-	if (strncmp(init_data_hdr->signature,
-				AMDGPU_SRIOV_CRIT_DATA_SIGNATURE,
-				AMDGPU_SRIOV_CRIT_DATA_SIG_LEN) != 0) {
-		dev_err(adev->dev, "Invalid init data signature: %.4s\n",
-			init_data_hdr->signature);
-		r = -EINVAL;
-		goto out;
-	}
-
-	checksum = amdgpu_virt_crit_region_calc_checksum(
-			(uint8_t *)&init_data_hdr->initdata_offset,
-			(uint8_t *)init_data_hdr +
-			sizeof(struct amd_sriov_msg_init_data_header));
-	if (checksum != init_data_hdr->checksum) {
-		dev_err(adev->dev, "Found unmatching checksum from calculation 0x%x and init_data 0x%x\n",
-				checksum, init_data_hdr->checksum);
-		r = -EINVAL;
-		goto out;
-	}
-
-	memset(&adev->virt.crit_regn, 0, sizeof(adev->virt.crit_regn));
-	memset(adev->virt.crit_regn_tbl, 0, sizeof(adev->virt.crit_regn_tbl));
-
-	adev->virt.crit_regn.offset = init_data_hdr->initdata_offset;
-	adev->virt.crit_regn.size_kb = init_data_hdr->initdata_size_in_kb;
-
-	/* Validation and initialization for each table entry */
-	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_IPD_TABLE_ID)) {
-		if (!init_data_hdr->ip_discovery_size_in_kb ||
-				init_data_hdr->ip_discovery_size_in_kb >
-					(DISCOVERY_TMR_SIZE_SRIOV >> 10)) {
-			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
-				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_IPD_TABLE_ID],
-				init_data_hdr->ip_discovery_size_in_kb);
-			r = -EINVAL;
-			goto out;
-		}
-
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset =
-			init_data_hdr->ip_discovery_offset;
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb =
-			init_data_hdr->ip_discovery_size_in_kb;
-	}
-
-	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID)) {
-		if (!init_data_hdr->vbios_img_size_in_kb) {
-			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
-				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID],
-				init_data_hdr->vbios_img_size_in_kb);
-			r = -EINVAL;
-			goto out;
-		}
-
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset =
-			init_data_hdr->vbios_img_offset;
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb =
-			init_data_hdr->vbios_img_size_in_kb;
-	}
-
-	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID)) {
-		if (!init_data_hdr->ras_tele_info_size_in_kb) {
-			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
-				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID],
-				init_data_hdr->ras_tele_info_size_in_kb);
-			r = -EINVAL;
-			goto out;
-		}
-
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset =
-			init_data_hdr->ras_tele_info_offset;
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].size_kb =
-			init_data_hdr->ras_tele_info_size_in_kb;
-	}
-
-	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID)) {
-		if (!init_data_hdr->dataexchange_size_in_kb) {
-			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
-				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID],
-				init_data_hdr->dataexchange_size_in_kb);
-			r = -EINVAL;
-			goto out;
-		}
-
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset =
-			init_data_hdr->dataexchange_offset;
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb =
-			init_data_hdr->dataexchange_size_in_kb;
-	}
-
-	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID)) {
-		if (!init_data_hdr->bad_page_size_in_kb) {
-			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
-				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID],
-				init_data_hdr->bad_page_size_in_kb);
-			r = -EINVAL;
-			goto out;
-		}
-
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].offset =
-			init_data_hdr->bad_page_info_offset;
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
-			init_data_hdr->bad_page_size_in_kb;
-	}
-
-	/* reserved memory starts from crit region base offset with the size of 5MB */
-	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE,
-				  adev->virt.crit_regn.offset,
-				  adev->virt.crit_regn.size_kb << 10, true);
-	dev_info(adev->dev,
-		"critical region v%d requested to reserve memory start at %08llx with %llu KB.\n",
-			init_data_hdr->version,
-			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].offset,
-			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size >> 10);
-
-	adev->virt.is_dynamic_crit_regn_enabled = true;
-
-out:
-	kfree(init_data_hdr);
-	init_data_hdr = NULL;
-
-	return r;
-}
-
-int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
-	int data_id, uint8_t *binary, u32 *size)
-{
-	uint32_t data_offset = 0;
-	uint32_t data_size = 0;
-	enum amd_sriov_msg_table_id_enum data_table_id = data_id;
-
-	if (data_table_id >= AMD_SRIOV_MSG_MAX_TABLE_ID)
-		return -EINVAL;
-
-	data_offset = adev->virt.crit_regn_tbl[data_table_id].offset;
-	data_size = adev->virt.crit_regn_tbl[data_table_id].size_kb << 10;
-
-	/* Validate on input params */
-	if (!binary || !size || *size < (uint64_t)data_size)
-		return -EINVAL;
-
-	/* Proceed to copy the dynamic content */
-	amdgpu_device_vram_access(adev,
-			(uint64_t)data_offset, (uint32_t *)binary, data_size, false);
-	*size = (uint64_t)data_size;
-
-	dev_dbg(adev->dev,
-		"Got %s info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
-		amdgpu_virt_dynamic_crit_table_name[data_id], data_offset, data_size);
-
-	return 0;
-}
-
 void amdgpu_virt_init(struct amdgpu_device *adev)
 {
 	bool is_sriov = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index a2c1aa838737..8bd471e541fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -523,4 +523,8 @@ void amdgpu_virt_request_bad_pages(struct amdgpu_device *adev);
 int amdgpu_virt_check_vf_critical_region(struct amdgpu_device *adev, u64 addr, bool *hit);
 int amdgpu_virt_send_remote_ras_cmd(struct amdgpu_device *adev,
 		uint64_t buf, uint32_t buf_len);
+bool amdgpu_virt_ras_check_bad_page(struct amdgpu_device *adev, uint64_t retired_page);
+void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev);
+bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev, const struct eeprom_table_record *bps, int pages);
+int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
new file mode 100644
index 000000000000..7461ab07f6eb
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
@@ -0,0 +1,682 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_reset.h"
+
+#define POPULATE_UCODE_INFO(vf2pf_info, ucode, ver) \
+	do { \
+		vf2pf_info->ucode_info[ucode].id = ucode; \
+		vf2pf_info->ucode_info[ucode].version = ver; \
+	} while (0)
+
+#define mmRCC_CONFIG_MEMSIZE    0xde3
+#define mmRCC_HW_DEBUG          0x10c01
+
+const char *amdgpu_virt_dynamic_crit_table_name[] = {
+	"IP DISCOVERY",
+	"VBIOS IMG",
+	"RAS TELEMETRY",
+	"DATA EXCHANGE",
+	"BAD PAGE INFO",
+	"INIT HEADER",
+	"LAST",
+};
+
+static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
+{
+	uint32_t sum = 0;
+
+	if (buf_start >= buf_end)
+		return 0;
+
+	for (; buf_start < buf_end; buf_start++)
+		sum += buf_start[0];
+
+	return 0xffffffff - sum;
+}
+
+static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
+{
+	struct amd_sriov_msg_pf2vf_info_header *pf2vf_info = adev->virt.fw_reserve.p_pf2vf;
+	struct amdgim_pf2vf_info_v1 *pf2vf_v1;
+	struct amd_sriov_msg_pf2vf_info *pf2vf;
+
+	uint32_t checksum;
+	uint32_t checkval;
+
+	uint32_t i;
+	uint32_t tmp;
+
+	if (adev->virt.fw_reserve.p_pf2vf == NULL)
+		return -EINVAL;
+
+	if (pf2vf_info->size > 1024) {
+		dev_err(adev->dev, "invalid pf2vf message size: 0x%x\n", pf2vf_info->size);
+		return -EINVAL;
+	}
+
+	switch (pf2vf_info->version) {
+	case 1:
+		pf2vf_v1 = (struct amdgim_pf2vf_info_v1 *)pf2vf_info;
+		checksum = pf2vf_v1->checksum;
+		checkval = amd_sriov_msg_checksum(
+			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
+			adev->virt.fw_reserve.checksum_key, checksum);
+		if (checksum != checkval) {
+			dev_err(adev->dev,
+				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
+				checksum, checkval);
+			return -EINVAL;
+		}
+
+		adev->virt.gim_feature = pf2vf_v1->feature_flags;
+		break;
+	case 2:
+		/* TODO: missing key, need to add it later */
+		pf2vf = (struct amd_sriov_msg_pf2vf_info *)pf2vf_info;
+		checksum = pf2vf->checksum;
+		checkval = amd_sriov_msg_checksum(
+			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
+			0, checksum);
+		if (checksum != checkval) {
+			dev_err(adev->dev,
+				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
+				checksum, checkval);
+			return -EINVAL;
+		}
+
+		adev->virt.vf2pf_update_interval_ms =
+			pf2vf->vf2pf_update_interval_ms;
+		adev->virt.gim_feature = pf2vf->feature_flags.all;
+		adev->virt.reg_access = pf2vf->reg_access_flags.all;
+
+		adev->virt.decode_max_dimension_pixels = 0;
+		adev->virt.decode_max_frame_pixels = 0;
+		adev->virt.encode_max_dimension_pixels = 0;
+		adev->virt.encode_max_frame_pixels = 0;
+		adev->virt.is_mm_bw_enabled = false;
+		for (i = 0; i < AMD_SRIOV_MSG_RESERVE_VCN_INST; i++) {
+			tmp = pf2vf->mm_bw_management[i].decode_max_dimension_pixels;
+			adev->virt.decode_max_dimension_pixels = max(tmp, adev->virt.decode_max_dimension_pixels);
+
+			tmp = pf2vf->mm_bw_management[i].decode_max_frame_pixels;
+			adev->virt.decode_max_frame_pixels = max(tmp, adev->virt.decode_max_frame_pixels);
+
+			tmp = pf2vf->mm_bw_management[i].encode_max_dimension_pixels;
+			adev->virt.encode_max_dimension_pixels = max(tmp, adev->virt.encode_max_dimension_pixels);
+
+			tmp = pf2vf->mm_bw_management[i].encode_max_frame_pixels;
+			adev->virt.encode_max_frame_pixels = max(tmp, adev->virt.encode_max_frame_pixels);
+		}
+		if ((adev->virt.decode_max_dimension_pixels > 0) || (adev->virt.encode_max_dimension_pixels > 0))
+			adev->virt.is_mm_bw_enabled = true;
+
+		adev->unique_id = pf2vf->uuid;
+
+		adev->unitid = 0;
+		if (amdgpu_sriov_is_unitid_support(adev))
+			adev->unitid = pf2vf->unitid;
+
+		adev->virt.ras_en_caps.all = pf2vf->pf2vf_ras_caps.ras_en_caps.all;
+		adev->virt.ras_telemetry_en_caps.all =
+			pf2vf->pf2vf_ras_caps.ras_telemetry_en_caps.all;
+
+		adev->have_atomics_support = pf2vf->pcie_atomic_ops_support_flags ==
+			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+		break;
+	default:
+		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
+		return -EINVAL;
+	}
+
+	/* correct too large or too little interval value */
+	if (adev->virt.vf2pf_update_interval_ms < 200 || adev->virt.vf2pf_update_interval_ms > 10000)
+		adev->virt.vf2pf_update_interval_ms = 2000;
+
+	return 0;
+}
+
+static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
+{
+	struct amd_sriov_msg_vf2pf_info *vf2pf_info;
+	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.fw_reserve.p_vf2pf;
+
+	if (adev->virt.fw_reserve.p_vf2pf == NULL)
+		return;
+
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_VCE,      adev->vce.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_UVD,      adev->uvd.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MC,       adev->gmc.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ME,       adev->gfx.me_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_PFP,      adev->gfx.pfp_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_CE,       adev->gfx.ce_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC,      adev->gfx.rlc_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLC, adev->gfx.rlc_srlc_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLG, adev->gfx.rlc_srlg_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLS, adev->gfx.rlc_srls_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      adev->gfx.mec_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     adev->gfx.mec2_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      adev->psp.sos.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
+			    adev->psp.asd_context.bin_desc.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_RAS,
+			    adev->psp.ras_context.context.bin_desc.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_XGMI,
+			    adev->psp.xgmi_context.context.bin_desc.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SMC,      adev->pm.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA,     adev->sdma.instance[0].fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA2,    adev->sdma.instance[1].fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_VCN,      adev->vcn.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_DMCU,     adev->dm.dmcu_fw_version);
+}
+
+static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
+{
+	struct amd_sriov_msg_vf2pf_info *vf2pf_info;
+
+	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.fw_reserve.p_vf2pf;
+
+	if (adev->virt.fw_reserve.p_vf2pf == NULL)
+		return -EINVAL;
+
+	memset(vf2pf_info, 0, sizeof(struct amd_sriov_msg_vf2pf_info));
+
+	vf2pf_info->header.size = sizeof(struct amd_sriov_msg_vf2pf_info);
+	vf2pf_info->header.version = AMD_SRIOV_MSG_FW_VRAM_VF2PF_VER;
+
+#ifdef MODULE
+	if (THIS_MODULE->version != NULL)
+		strscpy(vf2pf_info->driver_version, THIS_MODULE->version);
+	else
+#endif
+		strscpy(vf2pf_info->driver_version, "N/A");
+
+	vf2pf_info->pf2vf_version_required = 0; // no requirement, guest understands all
+	vf2pf_info->driver_cert = 0;
+	vf2pf_info->os_info.all = 0;
+
+	vf2pf_info->fb_usage = ttm_resource_manager_used(&adev->mman.vram_mgr.manager) ?
+		 ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) >> 20 : 0;
+	vf2pf_info->fb_vis_usage =
+		amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr) >> 20;
+	vf2pf_info->fb_size = adev->gmc.real_vram_size >> 20;
+	vf2pf_info->fb_vis_size = adev->gmc.visible_vram_size >> 20;
+
+	amdgpu_virt_populate_vf2pf_ucode_info(adev);
+
+	/* TODO: read dynamic info */
+	vf2pf_info->gfx_usage = 0;
+	vf2pf_info->compute_usage = 0;
+	vf2pf_info->encode_usage = 0;
+	vf2pf_info->decode_usage = 0;
+
+	vf2pf_info->dummy_page_addr = (uint64_t)adev->dummy_page_addr;
+	if (amdgpu_sriov_is_mes_info_enable(adev)) {
+		vf2pf_info->mes_info_addr =
+			(uint64_t)(adev->mes.resource_1_gpu_addr[0] + AMDGPU_GPU_PAGE_SIZE);
+		vf2pf_info->mes_info_size =
+			adev->mes.resource_1[0]->tbo.base.size - AMDGPU_GPU_PAGE_SIZE;
+	}
+	vf2pf_info->checksum =
+		amd_sriov_msg_checksum(
+		vf2pf_info, sizeof(*vf2pf_info), 0, 0);
+
+	return 0;
+}
+
+static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device, virt.vf2pf_work.work);
+	int ret;
+
+	ret = amdgpu_virt_read_pf2vf_data(adev);
+	if (ret) {
+		adev->virt.vf2pf_update_retry_cnt++;
+
+		if ((amdgpu_virt_rcvd_ras_interrupt(adev) ||
+			adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
+			amdgpu_sriov_runtime(adev)) {
+
+			amdgpu_ras_set_fed(adev, true);
+			if (amdgpu_reset_domain_schedule(adev->reset_domain,
+							&adev->kfd.reset_work))
+				return;
+			else
+				dev_err(adev->dev, "Failed to queue work! at %s", __func__);
+		}
+
+		goto out;
+	}
+
+	adev->virt.vf2pf_update_retry_cnt = 0;
+	amdgpu_virt_write_vf2pf_data(adev);
+
+out:
+	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
+}
+
+static int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data)
+{
+	uint32_t dataexchange_offset =
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset;
+	uint32_t dataexchange_size =
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10;
+	uint64_t pos = 0;
+
+	dev_info(adev->dev,
+			"Got data exchange info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+			dataexchange_offset, dataexchange_size);
+
+	if (!IS_ALIGNED(dataexchange_offset, 4) || !IS_ALIGNED(dataexchange_size, 4)) {
+		dev_err(adev->dev, "Data exchange data not aligned to 4 bytes\n");
+		return -EINVAL;
+	}
+
+	pos = (uint64_t)dataexchange_offset;
+	amdgpu_device_vram_access(adev, pos, pfvf_data,
+			dataexchange_size, false);
+
+	return 0;
+}
+
+void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
+{
+	if (adev->virt.vf2pf_update_interval_ms != 0) {
+		dev_info(adev->dev, "clean up the vf2pf work item\n");
+		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
+		adev->virt.vf2pf_update_interval_ms = 0;
+	}
+}
+
+void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
+{
+	uint32_t *pfvf_data = NULL;
+	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
+	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
+
+	adev->virt.fw_reserve.p_pf2vf = NULL;
+	adev->virt.fw_reserve.p_vf2pf = NULL;
+	adev->virt.vf2pf_update_interval_ms = 0;
+	adev->virt.vf2pf_update_retry_cnt = 0;
+
+	if (fw_va && drv_va) {
+		dev_warn(adev->dev, "Currently fw_vram and drv_vram should not have values at the same time!");
+	} else if (fw_va || drv_va) {
+		/* go through this logic in ip_init and reset to init workqueue*/
+		amdgpu_virt_exchange_data(adev);
+
+		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
+		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
+	} else if (adev->bios != NULL) {
+		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
+		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+			pfvf_data =
+				kzalloc(adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
+					GFP_KERNEL);
+			if (!pfvf_data) {
+				dev_err(adev->dev, "Failed to allocate memory for pfvf_data\n");
+				return;
+			}
+
+			if (amdgpu_virt_read_exchange_data_from_mem(adev, pfvf_data))
+				goto free_pfvf_data;
+
+			adev->virt.fw_reserve.p_pf2vf =
+				(struct amd_sriov_msg_pf2vf_info_header *)pfvf_data;
+
+			amdgpu_virt_read_pf2vf_data(adev);
+
+free_pfvf_data:
+			kfree(pfvf_data);
+			pfvf_data = NULL;
+			adev->virt.fw_reserve.p_pf2vf = NULL;
+		} else {
+			adev->virt.fw_reserve.p_pf2vf =
+				(struct amd_sriov_msg_pf2vf_info_header *)
+				(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+
+			amdgpu_virt_read_pf2vf_data(adev);
+		}
+	}
+}
+
+static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
+		uint64_t bp_block_offset, uint32_t bp_block_size)
+{
+	struct eeprom_table_record bp;
+	uint64_t retired_page;
+	uint32_t bp_idx, bp_cnt;
+	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
+	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
+	void *vram_usage_va = fw_va ? fw_va : drv_va;
+
+	memset(&bp, 0, sizeof(bp));
+
+	if (!bp_block_size)
+		return;
+
+	bp_cnt = bp_block_size / sizeof(uint64_t);
+	for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
+		retired_page = *(uint64_t *)(vram_usage_va +
+				bp_block_offset + bp_idx * sizeof(uint64_t));
+		bp.retired_page = retired_page;
+
+		if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
+			continue;
+
+		if (!amdgpu_virt_ras_add_bps(adev, &bp, 1))
+			break;
+
+		amdgpu_virt_ras_reserve_bps(adev);
+	}
+}
+
+void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
+{
+	uint64_t bp_block_offset = 0;
+	uint32_t bp_block_size = 0;
+	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
+	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
+	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
+
+	if (fw_va || drv_va) {
+		if (fw_va) {
+			if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+				adev->virt.fw_reserve.p_pf2vf =
+					(struct amd_sriov_msg_pf2vf_info_header *)
+					(fw_va +
+					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset);
+				adev->virt.fw_reserve.p_vf2pf =
+					(struct amd_sriov_msg_vf2pf_info_header *)
+					(fw_va +
+					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset +
+					(AMD_SRIOV_MSG_SIZE_KB << 10));
+				adev->virt.fw_reserve.ras_telemetry =
+					(fw_va +
+					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset);
+			} else {
+				adev->virt.fw_reserve.p_pf2vf =
+					(struct amd_sriov_msg_pf2vf_info_header *)
+					(fw_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+				adev->virt.fw_reserve.p_vf2pf =
+					(struct amd_sriov_msg_vf2pf_info_header *)
+					(fw_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
+				adev->virt.fw_reserve.ras_telemetry =
+					(fw_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
+			}
+		} else if (drv_va) {
+			adev->virt.fw_reserve.p_pf2vf =
+				(struct amd_sriov_msg_pf2vf_info_header *)
+				(drv_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+			adev->virt.fw_reserve.p_vf2pf =
+				(struct amd_sriov_msg_vf2pf_info_header *)
+				(drv_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
+			adev->virt.fw_reserve.ras_telemetry =
+				(drv_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
+		}
+
+		amdgpu_virt_read_pf2vf_data(adev);
+		amdgpu_virt_write_vf2pf_data(adev);
+
+		/* bad page handling for version 2 */
+		if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
+			pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
+
+			bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
+				((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
+			bp_block_size = pf2vf_v2->bp_block_size;
+
+			if (bp_block_size && !adev->virt.ras_init_done)
+				amdgpu_virt_init_ras_err_handler_data(adev);
+
+			if (adev->virt.ras_init_done)
+				amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
+		}
+	}
+}
+
+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
+{
+	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
+	u64 init_hdr_offset = adev->virt.init_data_header.offset;
+	u64 init_hdr_size = (u64)adev->virt.init_data_header.size_kb << 10; /* KB → bytes */
+	u64 vram_size;
+	u64 end;
+	int r = 0;
+	uint8_t checksum = 0;
+
+	/* Skip below init if critical region version != v2 */
+	if (adev->virt.req_init_data_ver != GPU_CRIT_REGION_V2)
+		return 0;
+
+	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
+	/* Fall back to RCC_HW_DEBUG when RCC_CONFIG_MEMSIZE reads 0 on a VF. */
+	if (!vram_size)
+		vram_size = RREG32(mmRCC_HW_DEBUG);
+	if (!vram_size || vram_size == U32_MAX)
+		return -EINVAL;
+	vram_size <<= 20;
+
+	if (check_add_overflow(init_hdr_offset, init_hdr_size, &end) || end > vram_size) {
+		dev_err(adev->dev, "init_data_header exceeds VRAM size, exiting\n");
+		return -EINVAL;
+	}
+
+	/* Allocate for init_data_hdr */
+	init_data_hdr = kzalloc_obj(struct amd_sriov_msg_init_data_header);
+	if (!init_data_hdr)
+		return -ENOMEM;
+
+	amdgpu_device_vram_access(adev, (uint64_t)init_hdr_offset, (uint32_t *)init_data_hdr,
+					sizeof(struct amd_sriov_msg_init_data_header), false);
+
+	/* Table validation */
+	if (strncmp(init_data_hdr->signature,
+				AMDGPU_SRIOV_CRIT_DATA_SIGNATURE,
+				AMDGPU_SRIOV_CRIT_DATA_SIG_LEN) != 0) {
+		dev_err(adev->dev, "Invalid init data signature: %.4s\n",
+			init_data_hdr->signature);
+		r = -EINVAL;
+		goto out;
+	}
+
+	checksum = amdgpu_virt_crit_region_calc_checksum(
+			(uint8_t *)&init_data_hdr->initdata_offset,
+			(uint8_t *)init_data_hdr +
+			sizeof(struct amd_sriov_msg_init_data_header));
+	if (checksum != init_data_hdr->checksum) {
+		dev_err(adev->dev, "Found unmatching checksum from calculation 0x%x and init_data 0x%x\n",
+				checksum, init_data_hdr->checksum);
+		r = -EINVAL;
+		goto out;
+	}
+
+	memset(&adev->virt.crit_regn, 0, sizeof(adev->virt.crit_regn));
+	memset(adev->virt.crit_regn_tbl, 0, sizeof(adev->virt.crit_regn_tbl));
+
+	adev->virt.crit_regn.offset = init_data_hdr->initdata_offset;
+	adev->virt.crit_regn.size_kb = init_data_hdr->initdata_size_in_kb;
+
+	/* Validation and initialization for each table entry */
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_IPD_TABLE_ID)) {
+		if (!init_data_hdr->ip_discovery_size_in_kb ||
+				init_data_hdr->ip_discovery_size_in_kb >
+					(DISCOVERY_TMR_SIZE_SRIOV >> 10)) {
+			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
+				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_IPD_TABLE_ID],
+				init_data_hdr->ip_discovery_size_in_kb);
+			r = -EINVAL;
+			goto out;
+		}
+
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset =
+			init_data_hdr->ip_discovery_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb =
+			init_data_hdr->ip_discovery_size_in_kb;
+	}
+
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID)) {
+		if (!init_data_hdr->vbios_img_size_in_kb) {
+			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
+				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID],
+				init_data_hdr->vbios_img_size_in_kb);
+			r = -EINVAL;
+			goto out;
+		}
+
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset =
+			init_data_hdr->vbios_img_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb =
+			init_data_hdr->vbios_img_size_in_kb;
+	}
+
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID)) {
+		if (!init_data_hdr->ras_tele_info_size_in_kb) {
+			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
+				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID],
+				init_data_hdr->ras_tele_info_size_in_kb);
+			r = -EINVAL;
+			goto out;
+		}
+
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset =
+			init_data_hdr->ras_tele_info_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].size_kb =
+			init_data_hdr->ras_tele_info_size_in_kb;
+	}
+
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID)) {
+		if (!init_data_hdr->dataexchange_size_in_kb) {
+			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
+				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID],
+				init_data_hdr->dataexchange_size_in_kb);
+			r = -EINVAL;
+			goto out;
+		}
+
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset =
+			init_data_hdr->dataexchange_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb =
+			init_data_hdr->dataexchange_size_in_kb;
+	}
+
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID)) {
+		if (!init_data_hdr->bad_page_size_in_kb) {
+			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
+				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID],
+				init_data_hdr->bad_page_size_in_kb);
+			r = -EINVAL;
+			goto out;
+		}
+
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].offset =
+			init_data_hdr->bad_page_info_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
+			init_data_hdr->bad_page_size_in_kb;
+	}
+
+	/* reserved memory starts from crit region base offset with the size of 5MB */
+	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE,
+				  adev->virt.crit_regn.offset,
+				  adev->virt.crit_regn.size_kb << 10, true);
+	dev_info(adev->dev,
+		"critical region v%d requested to reserve memory start at %08llx with %llu KB.\n",
+			init_data_hdr->version,
+			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].offset,
+			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size >> 10);
+
+	adev->virt.is_dynamic_crit_regn_enabled = true;
+
+out:
+	kfree(init_data_hdr);
+	init_data_hdr = NULL;
+
+	return r;
+}
+
+int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
+	int data_id, uint8_t *binary, u32 *size)
+{
+	uint32_t data_offset = 0;
+	uint32_t data_size = 0;
+	enum amd_sriov_msg_table_id_enum data_table_id = data_id;
+
+	if (data_table_id >= AMD_SRIOV_MSG_MAX_TABLE_ID)
+		return -EINVAL;
+
+	data_offset = adev->virt.crit_regn_tbl[data_table_id].offset;
+	data_size = adev->virt.crit_regn_tbl[data_table_id].size_kb << 10;
+
+	/* Validate on input params */
+	if (!binary || !size || *size < (uint64_t)data_size)
+		return -EINVAL;
+
+	/* Proceed to copy the dynamic content */
+	amdgpu_device_vram_access(adev,
+			(uint64_t)data_offset, (uint32_t *)binary, data_size, false);
+	*size = (uint64_t)data_size;
+
+	dev_dbg(adev->dev,
+		"Got %s info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+		amdgpu_virt_dynamic_crit_table_name[data_id], data_offset, data_size);
+
+	return 0;
+}
+
+int amdgpu_virt_get_uniras_ras_caps(struct amdgpu_device *adev,
+				    struct amd_sriov_uniras_caps *caps)
+{
+	struct amd_sriov_msg_pf2vf_info *pf2vf_msg;
+
+	if (!adev || !caps)
+		return -EINVAL;
+
+	if (!adev->virt.fw_reserve.p_pf2vf)
+		return -EINVAL;
+
+	if (adev->virt.fw_reserve.p_pf2vf->version != AMD_SRIOV_MSG_FW_VRAM_PF2VF_VER)
+		return -EINVAL;
+
+	pf2vf_msg = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
+
+	if (pf2vf_msg->header.size > (AMD_SRIOV_MSG_SIZE_KB << 10) ||
+	    pf2vf_msg->header.size <
+	    offsetof(struct amd_sriov_msg_pf2vf_info, pf2vf_ras_caps) +
+	    sizeof(pf2vf_msg->pf2vf_ras_caps))
+		return -EINVAL;
+
+	if (!pf2vf_msg->feature_flags.flags.uniras_support)
+		return -EOPNOTSUPP;
+
+	*caps = pf2vf_msg->pf2vf_ras_caps.uniras_caps;
+
+	dev_dbg(adev->dev,
+		"uniras caps: ras_ext_ecc_type=0x%x ras_int_ecc_attributes=0x%x ras_en_block_mask=0x%llx\n",
+		caps->ras_ext_ecc_type, caps->ras_int_ecc_attributes,
+		caps->ras_en_block_mask);
+
+	return 0;
+}
+
-- 
2.34.1

