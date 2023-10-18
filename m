Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9619CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 05:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3445E10E382;
	Wed, 18 Oct 2023 05:27:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26FED10E380
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 05:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNpQXcVVauO05r3p0mkRjuyIs71pwrofCbJIFaewkWVLewFKlJ1pcSF1aZEBeQIym5UvkFY/AyTarVcq94fdisQKXLgcjPCuhUe5JazIMaMTT4GoGIkDYnr7rFRE4PdXNYioxYpv0N48siBInLlAHfEylr34CbfxBvH4IsAueSXMNyH7n8mTv/6A4vJ/3LSHJEfm7QBdpQKFU4juS4zb7zZmYB1yGtj+WbjL/RdD3AoVMe4CteAFPe+xTdaoDY/kq0C/rW+XHEqBLPS4IVB7FIJADCx4h5nAWyNBcUl8uiNUc6+q5t4I1K2oLpHa0PJR8FMMzor72kwviHK95XKDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iqukbeBvAhi1gdToQKTGAb1qu1755Mfs7EWSs+gMNo=;
 b=BFYyDW8G32q/DI5MfI/2WB2FXz8xu513JKVlEAdCIEQ5nq7Ch0recuokP7IG0wViGme2eN0IuXGKePEdhB78mi2GqS6G7M3RklJFkEPZuKxPySj/WCOBbFikunq7W/dn1UHZwMmYPWF5NC17EHWm5iKwySYF0wbQrk4F7zWWVAccHxtNV4AZGY2j+SixfhCx/DO2qcE0V2RFXaNiv25qfyH7Pzf+r5heTkNsL7oPa25GMsge/LtmTHV9BIlF5XL0clai8lKpHsCZnyPAiet8dlvPGS/YoKP0KV5kYiSune27Igud4xo89P6YoSQD1Amj/k+OtkjSttMn/y4cmxK6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iqukbeBvAhi1gdToQKTGAb1qu1755Mfs7EWSs+gMNo=;
 b=XUW1FFH9nrkC52h7gRh6RF9KRv0Bijn7yTRB/dNoaUve4FbhWuZGlW+EN0KgZC5CBrSePBPDab4eZ0tjTnPWrXIbQ4EtikhVRfHtVyaRLXNKM0QL8+WaRj5UH/VF8IUF3SKPPd8EGZ+Oxzbc7oS1qMh6a/L3sz+7tFWQL0FeRNE=
Received: from MN2PR04CA0014.namprd04.prod.outlook.com (2603:10b6:208:d4::27)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 05:27:33 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::8c) by MN2PR04CA0014.outlook.office365.com
 (2603:10b6:208:d4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 05:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 18 Oct 2023 05:27:32 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 00:27:18 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: fix missing stuff in NBIO v7.11
Date: Wed, 18 Oct 2023 13:26:51 +0800
Message-ID: <20231018052650.2553161-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DM8PR12MB5414:EE_
X-MS-Office365-Filtering-Correlation-Id: bef007fe-0724-49a8-8aca-08dbcf9aedf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /X/cxluiy6rsWZpjJGx2qkRXov9l/bl3/nvmeydVvKJ4GZnxU4dYjcAoU1gD+nc8z26JppFKEUKzh5n5O7lCIAJbvWA1DbDODJtzLd5Yhe0aE1ZYjFqBb63kzY0sTPus+fRHekfBGPJjsMSRU+qW28MdcPejPOM4Ch590VyiYoD4qkWRfuvrKDAFB83SD4nEJvKpz8wxcSrkDvW4VWqPSuU4lxvW951TdlIBvI87F8iwBJ38QD+YLy0ervO4LJ0rbPQvy7TYhTdzR8Nx+BF90xYqvp2qxecDv7YWgTGOKVHKyexKYc1UhQc9zHsssgvjJF8biFL+/1cE3tb7acgCyYgm9ZKmWUjqLZMeSv5g2z1SQnzmzCrlpAOKVo2ZXKycrY6GwcnI+da3hariXsU2m89piCssaGyj+c74onc2GzipHxswxZKvOCj+XRA/Kd1L9YFAksqZeOW4KmLtMnFZ1ggVpxCuul0k16kDFSWZW0HuknPaxm3zkfjUqu4Gt6MpMhvJDn2YLHDpZ/J1g1CLNCKcH1BJXWB+7uHCIfnbJOlurJ/kWG2VPvErWZWgqjI8hPMWE9+Cm1ARxRsLqR8lbDrerZiKDnG2RLZa0gLgfFJY8jSrogVRsTLHE6rklppuQd4m9YMkcOjbWOeqWo6ICM4OFg5Hr0ELA+lOUORRvj6+Hhy+DbGWMkR7lJ5d1pzNzD73rC/I5cNo8ZFtVDG1kF8cyC4Ul+l5sb/NiGNSwiJQxcWFS2YlcEyjTC6UMzzRpfErUEntzFevFmPKZJQBcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(40470700004)(46966006)(36840700001)(40480700001)(44832011)(5660300002)(2906002)(41300700001)(8936002)(4326008)(40460700003)(86362001)(36756003)(8676002)(478600001)(426003)(336012)(356005)(66574015)(26005)(16526019)(81166007)(82740400003)(1076003)(6666004)(2616005)(7696005)(316002)(83380400001)(54906003)(36860700001)(6916009)(70206006)(47076005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 05:27:32.6375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef007fe-0724-49a8-8aca-08dbcf9aedf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com, ben.li@amd.com,
 lang.yu@amd.com, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add get_clockgating_state, update_medium_grain_light_sleep and
update_medium_grain_clock_gating in nbio_v7_11_funcs
v1:
add missing funcs in nbio_v7_11.c
v2:
modify the if condition and add spport for nbio v7.11 clockgating.

Signed-off-by: Li Ma <li.ma@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c       | 78 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  1 +
 .../asic_reg/nbio/nbio_7_11_0_offset.h        |  6 ++
 .../asic_reg/nbio/nbio_7_11_0_sh_mask.h       | 13 +++-
 4 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index 3a94f249929e..676ab1d20d2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -272,6 +272,81 @@ static void nbio_v7_11_init_registers(struct amdgpu_device *adev)
 */
 }
 
+static void nbio_v7_11_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+						       bool enable)
+{
+	uint32_t def, data;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG))
+		return;
+
+	def = data = RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL);
+	if (enable) {
+		data |= (BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK |
+			 BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_DYN_GATE_ENABLE_MASK |
+			 BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_LCNT_GATE_ENABLE_MASK |
+			 BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_REGS_GATE_ENABLE_MASK |
+			 BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_PRBS_GATE_ENABLE_MASK |
+			 BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__REFCLK_REGS_GATE_ENABLE_MASK);
+	} else {
+		data &= ~(BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK |
+			  BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_DYN_GATE_ENABLE_MASK |
+			  BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_LCNT_GATE_ENABLE_MASK |
+			  BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_REGS_GATE_ENABLE_MASK |
+			  BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_PRBS_GATE_ENABLE_MASK |
+			  BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__REFCLK_REGS_GATE_ENABLE_MASK);
+	}
+
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL, data);
+}
+
+static void nbio_v7_11_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+						      bool enable)
+{
+	uint32_t def, data;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
+		return;
+
+	def = data = RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2);
+	if (enable)
+		data |= BIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2__SLV_MEM_LS_EN_MASK;
+	else
+		data &= ~BIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2__SLV_MEM_LS_EN_MASK;
+
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1);
+	if (enable) {
+		data |= (BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_MASK |
+			BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN_MASK);
+	} else {
+		data &= ~(BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_MASK |
+			BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN_MASK);
+	}
+
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1, data);
+}
+
+static void nbio_v7_11_get_clockgating_state(struct amdgpu_device *adev,
+					    u64 *flags)
+{
+	uint32_t data;
+
+	/* AMD_CG_SUPPORT_BIF_MGCG */
+	data = RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL);
+	if (data & BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_BIF_MGCG;
+
+	/* AMD_CG_SUPPORT_BIF_LS */
+	data = RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2);
+	if (data & BIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2__SLV_MEM_LS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_BIF_LS;
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_11_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_11_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_11_get_hdp_flush_done_offset,
@@ -288,6 +363,9 @@ const struct amdgpu_nbio_funcs nbio_v7_11_funcs = {
 	.enable_doorbell_aperture = nbio_v7_11_enable_doorbell_aperture,
 	.enable_doorbell_selfring_aperture = nbio_v7_11_enable_doorbell_selfring_aperture,
 	.ih_doorbell_range = nbio_v7_11_ih_doorbell_range,
+	.update_medium_grain_clock_gating = nbio_v7_11_update_medium_grain_clock_gating,
+	.update_medium_grain_light_sleep = nbio_v7_11_update_medium_grain_light_sleep,
+	.get_clockgating_state = nbio_v7_11_get_clockgating_state,
 	.ih_control = nbio_v7_11_ih_control,
 	.init_registers = nbio_v7_11_init_registers,
 	.remap_hdp_registers = nbio_v7_11_remap_hdp_registers,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index df7462cec6ab..7fe199560264 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -863,6 +863,7 @@ static int soc21_common_set_clockgating_state(void *handle,
 	case IP_VERSION(4, 3, 0):
 	case IP_VERSION(4, 3, 1):
 	case IP_VERSION(7, 7, 0):
+	case IP_VERSION(7, 11, 0):
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
index 846a8cf3926a..ff30f04be591 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
@@ -775,6 +775,12 @@
 #define regPCIE_USB4_ERR_CNTL5_BASE_IDX                                                                 5
 #define regPCIE_USB4_LC_CNTL1                                                                           0x420179
 #define regPCIE_USB4_LC_CNTL1_BASE_IDX                                                                  5
+#define regBIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL                                                      0x420118
+#define regBIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL_BASE_IDX                                             5
+#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2                                                       0x42001c
+#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2_BASE_IDX                                              5
+#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1                                             0x420187
+#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1_BASE_IDX                                    5
 
 
 // addressBlock: nbio_nbif0_bif_cfg_dev0_rc_bifcfgdecp
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
index 84242240f611..7f131999a263 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
@@ -24634,7 +24634,18 @@
 //PCIE_USB4_LC_CNTL1
 #define PCIE_USB4_LC_CNTL1__PCIE_USB_ROUTER_CLEAR_PATH_MODE__SHIFT                                            0x0
 #define PCIE_USB4_LC_CNTL1__PCIE_USB_ROUTER_CLEAR_PATH_MODE_MASK                                              0x00000001L
-
+//BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL
+#define BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK                                    0x00000001L
+#define BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_DYN_GATE_ENABLE_MASK                                   0x00000002L
+#define BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_LCNT_GATE_ENABLE_MASK                                  0x00000020L
+#define BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_REGS_GATE_ENABLE_MASK                                  0x00000040L
+#define BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_PRBS_GATE_ENABLE_MASK                                  0x00000080L
+#define BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__REFCLK_REGS_GATE_ENABLE_MASK                                 0x00000100L
+//BIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2__SLV_MEM_LS_EN_MASK                                            0x00010000L
+//BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_MASK                                  0x00000001L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN_MASK                               0x00000008L
 
 // addressBlock: nbio_nbif0_bif_cfg_dev0_rc_bifcfgdecp
 //BIF_CFG_DEV0_RC0_VENDOR_ID
-- 
2.25.1

