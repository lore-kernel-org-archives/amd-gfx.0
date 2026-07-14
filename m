Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12E2C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 07:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C0210E00F;
	Tue, 14 Jul 2026 07:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CCvDYTXL";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3A310E00F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 07:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRgujWikz8joRbYZ5UBMcK997xGdqGJWWYgEp449v0hGJWxlwEGdtakxzkvvFWUJ3PMwReM99Wtvid1kZRB5B/DiPlvAGZuPl3dY5DHYGGAuHYjPk/ZKreNWbCGGbUBPZLj0rx2RyYY4143/qv4Ujr4nbc7gal4WgDj7p5YZ18t5diC8NMDmCWH0A7fz/FwHuktZzFt0Coqb66M0+g7nokdjkQ8cTj5yVQEy1jxwGTZGSDt8jZOeq5leWp6Di2vEPyQhJ6YXIhZrTC2amxuqlEwI0eOHnWkXO6rkqxEsGRNZK7210raUinrNPuxI+4oqIO5F25mxFe2ZPdhrRCBrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdWcfl2tx4OnOpVtSPabY8bngNef+YVljGad5La7HxE=;
 b=wAbQfvRu6QYVD2v/hS4A8AcCB1/I9/3R8ShzytaNCSggEm3DbAMjckbdIRbe5+nvtuvJv9OBhut0476z/uRtl52XQUgfGICvLDrNxAtK3J1UjaMeTxlzbDNEufCxuiJjHfsYEs+T4TDAO2PnrJbb3KNkTlpsvgpCMsA4/h+YG+PZU/7fjk4gtKoEDg9w7gRWlUBLDvbRmkx1kdFI5huNOlggmKC0CH0kLMF9izwylYSr96QUUgUNikfYwtN2gzcy0e1379Q1Ih7iy9Nsa8uTo06hNXGbqhIWmvZlmpLXAhUGrofaRtE3aNxVamcGgHgInLMKeHPUraE2YkQcDStccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdWcfl2tx4OnOpVtSPabY8bngNef+YVljGad5La7HxE=;
 b=CCvDYTXLJR4ajQaK+rRa4HRQYexJPvrYYGwAV5KU6VUo643VNsWv2E/t+puKLsEoq1E1j5uqJ2HQEHQ0Nogc9xz2x9ZbpgqJNv7SP5fCRcsyukCVymNYxYUYlE52zuMEsOxI2PZioAwV9fCpDhOBmpyd/8wcNmRUKi4uaUx8UD8=
Received: from MW4PR04CA0160.namprd04.prod.outlook.com (2603:10b6:303:85::15)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Tue, 14 Jul
 2026 07:20:16 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::2) by MW4PR04CA0160.outlook.office365.com
 (2603:10b6:303:85::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 07:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 07:20:15 +0000
Received: from suresh-X570-AORUS-ELITE-WIFI.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 14 Jul 2026 02:20:10 -0500
From: Suresh Guttula <suresh.guttula@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <suresh.guttula@amd.com>, McRae Geoffrey <Geoffrey.McRae@amd.com>
Subject: [PATCH v2] drm/amd : Program MMHUB ECO SEC LVL for vcn5_3
Date: Tue, 14 Jul 2026 12:49:51 +0530
Message-ID: <20260714071951.3088212-1-suresh.guttula@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: ce81c4bd-7c8c-4147-df3a-08dee1785a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: WKzYKBdJxSrZbdlILZ278fyWtIH3+r/Dn+rUwcO2rFvCWQTO/3AoP4LzC+bgrDbOxlQsS2ZKVHM++3JASR9NCZY+oybYWPqwQRaQ5Y9bX4SWZdMCoAXzsnCL8ToaHzQ7Ez0IhbotDPTIa+UwCCEGdCu+FVwxSVUeiJWG010C+z9SbpG7DPTMpyrEGSGoITptoTcZZkay7q+sjBNC15F1WaoXLMaKQF2XM6PNTiypgot39C7I026+Xwqy/gxzMBfL0sO7aZqzP8ZvCQRgonmIF3XeHTPy0lLKFLfcTrCzTbehAAO41u7texKHWpgh+fmjdckI0pIepX3T71s0qX/h+Cz7l9c5GI61h4ou1ywEdyimbTnFSSAmU8W7ry+ym3ArZWNwHiWnnA77zc8NoXFKZDFftmM0sN06KFsStLRjPagC8tXnTs7IEU+cElREJ8Njb3xDSMs2Ztg5Z4VanWfoReZvL63/GSfW/AllIKBAdSsm0N7AiqoiDWhk1FbNE/OusqWaj7x8P7uGY3G6+ERlWqXo4pjR4P6zyiBEKIF7odwM5qIG8KMjVK1iOiQhJBqKreZFhrCy4hgtcCf6VvbgvNgzzJmld7U0u/pBJz3C+VUXSbmbYc1o5sqpRhHbb/XdaUnf4AE8bkZb2y48Wu5yPTtiW+CqI3XJy+J0RdOrqt08Fx2PeKvix0zVrI+FtK+WXkQ57IxSjigdELJ1fWpz0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TmeNxBw5ZE0s3iOrYeg+ZT/A9ZZe8gyaUpMT9Xsgisq7OCQrhqVJI8fNfT5/+7wJuVk2s6ksVvZubquZnELFBQWcHnctmoLx3cmARNnZMeMgnLaUpjqzzRi977LheK+2q6l6rIWVq+f8NC5WKq0meRp3kAoSfp8odDT9kHjZ5VC0UfyAyJDe8gcV8aOzk8ORUpKmBGdG41wQfXJEbOGTfcXw3+xxPZo1CNHzUfvdgmJ8l+w4KGzEL6SSFTsDGxn4dNKa3WXAnuHJncTH9Ykbg1bVc93Z3jNyM7hlZs/r6E14WX7dv5s6q1QT140g+PS2kwoX5GHiOuRqhkOrcY2QAK9eAGR9YOCjn+47QB0+t1wSJe4KSoim8UlqcdRq2v6DVVrl+BbtNODrAwIIMOUStTvQ7nGtUClDRNCioI/KUmw0FbUqWU8KPM/pqcNsZ994
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:20:15.8704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce81c4bd-7c8c-4147-df3a-08dee1785a45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514
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

This patch
 1. Requests PSP to set UVD and JPEG SEC LVL reg incase of
    fw_load_type is PSP_LOAD.
 2. Set UVD and JPEG SEC LVL incase of backdoor loading and
    non-secure-direct loading type.
 3. To support this, PSP implementing new cmd id :
    GFX_CMD_ID_SET_MMHUB_ECO_SEC_LEVEL, vcn/jpeg will call
    this cmd to set sec lvl.

This will help to resolve jpeg/vcn ring/ib timeout while
accessing mmhub.

Signed-off-by: Suresh Guttula <suresh.guttula@amd.com>
Reviewed-by: McRae Geoffrey<Geoffrey.McRae@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 27 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c      | 29 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 31 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h       |  2 ++
 .../include/asic_reg/vcn/vcn_5_0_0_offset.h   |  2 ++
 .../include/asic_reg/vcn/vcn_5_3_0_offset.h   |  2 ++
 9 files changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a36cbfc1f6f1..64281553c6d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1222,6 +1222,33 @@ int psp_memory_partition(struct psp_context *psp, int mode)
 	return ret;
 }
 
+int psp_set_mmhub_eco_sec_level(struct amdgpu_device *adev)
+{
+	int ret;
+	struct psp_context *psp = &adev->psp;
+	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
+
+	cmd->cmd_id = GFX_CMD_ID_SET_MMHUB_ECO_SEC_LEVEL;
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+	if (ret) {
+		dev_err(psp->adev->dev,
+			"PSP request failed to set mmuhub eco sec level with ret=%d\n", ret);
+		release_psp_cmd_buf(psp);
+		return ret;
+	}
+
+	if (cmd->resp.status) {
+		dev_err(psp->adev->dev,
+			"MMHUB ECO SEC LEVEL command 0x%x failed, PSP response status: 0x%X\n",
+				cmd->cmd_id, cmd->resp.status);
+		ret = -EIO;
+	}
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 static int psp_ptl_fmt_verify(struct psp_context *psp, enum amdgpu_ptl_fmt fmt,
 						 uint32_t *ptl_fmt)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 2d838b1b2b11..3d7744d60fac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -656,5 +656,6 @@ int amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
 void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
 int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 			   enum psp_gfx_fw_type *type);
+int psp_set_mmhub_eco_sec_level(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 66d4c487eee5..9468b4541b5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -399,6 +399,30 @@ static void jpeg_v5_3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
 }
 
+/**
+ * jpeg_v5_3_0_set_mmhub_eco_sec_level - set jpeg sec lvl reg
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set jpeg sec lvl based on load type
+ */
+static int jpeg_v5_3_0_set_mmhub_eco_sec_level(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		//Request to PSP to program JPEG secure lvl register
+		r = psp_set_mmhub_eco_sec_level(adev);
+	} else {
+		//Program UVD_JMC_JPEG_SECURE_LVL register
+		//During brinrup phase or backdoor loading case, updating register here
+		//to avoid dependency on PSP
+		WREG32_SOC15(JPEG, 0, regUVD_JMC_JPEG_SECURE_LVL, vcnipUVD_JMC_JPEG_SECURE_LVL);
+	}
+
+	return r;
+}
+
 /**
  * jpeg_v5_3_0_start - start JPEG block
  *
@@ -424,6 +448,11 @@ static int jpeg_v5_3_0_start(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	/* program JPEG secure lvl register */
+	r = jpeg_v5_3_0_set_mmhub_eco_sec_level(adev);
+	if (r)
+		return r;
+
 	/* JPEG disable CGC */
 	jpeg_v5_3_0_disable_clock_gating(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h
index c1e7537d0f18..ef6376f3a79b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h
@@ -30,6 +30,8 @@
 #define vcnipUVD_NO_OP                                     0x0029
 #define vcnipJPEG_DEC_GFX10_ADDR_CONFIG                    0x404A
 
+#define vcnipUVD_JMC_JPEG_SECURE_LVL                       0x22
+
 extern const struct amdgpu_ip_block_version jpeg_v5_3_0_ip_block;
 
 #endif /* __JPEG_V5_0_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index ac34bac3c839..ad618b78685f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -110,6 +110,7 @@ enum psp_gfx_cmd_id
     GFX_CMD_ID_PERF_HW            = 0x0000004C,   /* performance monitor */
     GFX_CMD_ID_FB_FW_RESERV_ADDR  = 0x00000050,  /* Query FW reservation addr */
     GFX_CMD_ID_FB_FW_RESERV_EXT_ADDR = 0x00000051,  /* Query FW reservation extended addr */
+    GFX_CMD_ID_SET_MMHUB_ECO_SEC_LEVEL = 0x0000005D,  /* Set MMHUB ECO sec lvls on VCN block */
 };
 
 /* PSP boot config sub-commands */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 45580e9c4e0c..1318e731440b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -795,6 +795,32 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	return 0;
 }
 
+/**
+ * vcn_v5_0_0_set_mmhub_eco_sec_level - set vcn sec lvl reg
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set vcn sec lvl based on load type
+ */
+static int vcn_v5_0_0_set_mmhub_eco_sec_level(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(5, 3, 0)) {
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+			//Request to PSP to program VCN secure lvl register
+			r = psp_set_mmhub_eco_sec_level(adev);
+		} else {
+			//Program UVD_MC_VID_SECURE_LVL register
+			//During brinrup phase or backdoor loading case, updating register here
+			//to avoid dependency on PSP
+			WREG32_SOC15(VCN, 0, regUVD_MC_VID_SECURE_LVL, UVD_MC_VID_SECURE_LVL);
+		}
+	}
+
+	return r;
+}
+
 /**
  * vcn_v5_0_0_start - VCN start
  *
@@ -819,6 +845,11 @@ static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *vinst)
 
 	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
+	/* program VCN secure lvl register */
+	r = vcn_v5_0_0_set_mmhub_eco_sec_level(adev);
+	if (r)
+		return r;
+
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return vcn_v5_0_0_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h
index 51bbccd4360f..9ae2bed990be 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h
@@ -32,6 +32,8 @@
 #define VCN_VID_IP_ADDRESS                         0x0
 #define VCN_AON_IP_ADDRESS                         0x30000
 
+#define UVD_MC_VID_SECURE_LVL                      0x22222222
+
 extern const struct amdgpu_ip_block_version vcn_v5_0_0_ip_block;
 
 #endif /* __VCN_V5_0_0_H__ */
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
index 72a118b2af69..a7e64e304ffa 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
@@ -1027,6 +1027,8 @@
 #define regCC_UVD_VCPU_ERR_INST_ADDR_LO_BASE_IDX                                                        1
 #define regCC_UVD_VCPU_ERR_INST_ADDR_HI                                                                 0x0035
 #define regCC_UVD_VCPU_ERR_INST_ADDR_HI_BASE_IDX                                                        1
+#define regUVD_MC_VID_SECURE_LVL                                                                        0x0037
+#define regUVD_MC_VID_SECURE_LVL_BASE_IDX                                                               1
 #define regUVD_LMI_MMSCH_NC_SPACE                                                                       0x003d
 #define regUVD_LMI_MMSCH_NC_SPACE_BASE_IDX                                                              1
 #define regUVD_LMI_ATOMIC_SPACE                                                                         0x003e
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_3_0_offset.h
index 1051a788c9d7..da5acac08ae9 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_3_0_offset.h
@@ -162,6 +162,8 @@
 #define regCC_UVD_VCPU_ERR_INST_ADDR_LO_BASE_IDX                                                        1
 #define regCC_UVD_VCPU_ERR_INST_ADDR_HI                                                                 0x0035
 #define regCC_UVD_VCPU_ERR_INST_ADDR_HI_BASE_IDX                                                        1
+#define regUVD_JMC_JPEG_SECURE_LVL                                                                      0x0036
+#define regUVD_JMC_JPEG_SECURE_LVL_BASE_IDX                                                             1
 #define regUVD_LMI_MMSCH_NC_SPACE                                                                       0x003d
 #define regUVD_LMI_MMSCH_NC_SPACE_BASE_IDX                                                              1
 #define regUVD_LMI_ATOMIC_SPACE                                                                         0x003e
-- 
2.43.0

