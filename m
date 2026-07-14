Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E49C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 06:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 521DC10E010;
	Tue, 14 Jul 2026 06:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tucsjWEl";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013048.outbound.protection.outlook.com
 [40.93.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 400DD10E010
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 06:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MN7Ln38W94yGZmvIOv+XI69I5r/nwkp32AyHYsxysO3NrYtE2DSUT8kLAZsQam0Zl1GbkNs6UZG6nL+XXuPJstWReluKi3dIpzM0eFS2d0ljl5HCeg1P7CiaH+fyIS8FBzpejOPTfMGv8HoFH8LQDRocPxD3rJBxqyuTnaI5efL8Wm7ii/fF6iySgO8zgn0nGRMTBWeqUGFQQCwEtMd+V11FTWw0ErOqd3ZIF3IKb4rA275HAQsT/7Lyk1yf6vasNj8kxeD78lxwzwFEizq93Hrw+8kuKHgveVelBz/hzoZ4+Gw/hdISjAe9W87w5/yhf4JxschTZq7DaOOjqHUS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5KzWw7h83+os/wwuCnCIHLkNn8q1VgrsSibnsk2+GY=;
 b=OxAK8OVE9cOPrMo1vLoKybZeBxEZVEV8MRRwe5wU+htufSJSKP4/FBM00ChaabmUW4Cl0eesBXv9AIa7JDP5HkNROAGeO3PK7gkEvd/0tI+U1vadDXIZE54jy0n5Wt6pfe0+/QqB7x76aMCmn8pjybZ9JENgFy59lmj983NS9axl3fUSprf1QKcyE8C2QojTWwEcN5hmmjxI8MTz186N2W6V+3HicX8ZCOKHINuJnfT8BJNXfmgXpHJ88cdDbYbQXMX1twGLiBRMVV9hnQtz1npo+lPVNUc4GocWFZbbw7AYe/tCnEh6QwjG7HHjeIIbpVlW0OqJD+Rf/9XYXjmTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5KzWw7h83+os/wwuCnCIHLkNn8q1VgrsSibnsk2+GY=;
 b=tucsjWEld9xyALrBJBTZfEm2PcQ9sXwVaMCRW+Qqh0WqZq3KyHLpb/K63Th1TQgCMEVpNF8Rhtq55lf/G5qxA6k+7/yejFAOjqidyAxgADYptrSc+sdwkplCrUvs4SyY3YD8ddU7PsPsmok5pSwiTJnC/t+odcmdyJrZv7YNFYs=
Received: from SN7PR04CA0191.namprd04.prod.outlook.com (2603:10b6:806:126::16)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 06:28:16 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::19) by SN7PR04CA0191.outlook.office365.com
 (2603:10b6:806:126::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 06:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 06:28:16 +0000
Received: from suresh-X570-AORUS-ELITE-WIFI.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 14 Jul 2026 01:28:14 -0500
From: Suresh Guttula <suresh.guttula@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <suresh.guttula@amd.com>
Subject: [PATCH] drm/amd : Program MMHUB ECO SEC LVL for vcn5_3
Date: Tue, 14 Jul 2026 11:57:57 +0530
Message-ID: <20260714062757.3039106-1-suresh.guttula@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e158ad-6228-40b0-73ae-08dee17116b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|3023799007|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: PVdLkD7sMd/9hn1ygbCehSpdLmxxf/jaX2WYrsK2ZINEdYyLDBTk4SDZ4Du22OglG5cWT6zgWZXP3K56EYxQx5dEPi4u0ccB9GWWan7EOxfrvZgAXPP1rsEJDy4wjC3/uczFHEX1BMkcyHsQXPQQueXBQOVxZMliIjLV9rYbedMExFhtGA6Y3PaSa8Ep6IqEjYNOVBC0KVnvOG0p0IO4YZ/8QXYoDYHx8N0w0ZCdp/tv6HAbptijn9rdYWhOnGeaoHbROuFXdXRSidNwURVYnEcuYpZakL2ghI/sVlhN8pEM6anKG30MIFN7JW2QduzglEwgeivsu5uCWzWRlMUAwTUW5yYjYDrJ8PqC3AZ9SEbQxtZ7iLRiTbienhnlnN6rw7fmhHUK2lDVukcB9c/hVowZu1FgBaOoMN56sACyfCgRFzVrWtR7zURWgFxM1ptFirwi70vDutbu8itKI/DoZVYSPsMoxS/EGXX3AyfiyekJcQpi9geGMLl2vcBkLqlA3QxwcpKts0+JnHEnWbtNhELLuGI5nW8iK+06RPIqz+3+cMdqqYxd5+AqHrLqCtNczuvv0l0WdsjqPFN5+byHbBgU6uG3G7D2nSuxPqpN77T+sKjqUel5z7TaGr04GUpfu+LEbdHHinRgEmAgtIz0/QjiwoZIS6Q5ksCx1q94ZislP9su0S/9Kvra3zKzhVlIruAEzlBkqMHp7uCX+UR/og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(3023799007)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XxJNf7KhTgEzTTNbYx4NNYDp0JDGv3IjP9SB+p+LMo6cUNk8ij1AcoR+Mm7/dyZl/1QOFwOPf+zGMNO+ZCMQVjqZF944pojfN1T76bkKM8X1zqUrcCZqv2OE7rCjP5TZhy2vY8p6/RO17ZGWuxsn1xOi/MV/Pb/UIOlYZSHDkai+Dny/GOb0kErXtxm0MtNs/nUCyDY1uW+3gudktDsbIWJu26D410zQt6bsLgpTu2eCv9xntQzn0ZHrn5e2/CsZjRMbtZEucL5NeudzSWmJs/oOhO8aSynFc522cx8bT9WISECfqbtMwOlliiSaeUbh4grLfcCt6GDuG7HhHNozsg6jZhTcz7VYodlU5XzXV4UWLmQsewAUSjBr2t+4t3VdfYZmZtOX0S2EgGx4KOVlLhbAxBQ8DDXHdSaa5MmSUxbNGldmFhJOqmufdVcCJfg4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:28:16.1019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e158ad-6228-40b0-73ae-08dee17116b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 24 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c      | 29 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 31 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h       |  2 ++
 .../include/asic_reg/vcn/vcn_5_0_0_offset.h   |  2 ++
 .../include/asic_reg/vcn/vcn_5_3_0_offset.h   |  2 ++
 9 files changed, 94 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a36cbfc1f6f1..aadbd89f5747 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1222,6 +1222,30 @@ int psp_memory_partition(struct psp_context *psp, int mode)
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
+	if (ret)
+		dev_err(psp->adev->dev,
+			"PSP request failed to set mmuhub eco sec level with ret=%d\n", ret);
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

