Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FA8C54FB9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 09:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB1A910E107;
	Tue, 21 Nov 2023 09:10:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95B810E107
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 09:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6wo2fvH9YfvA2Hzu+aAi10/zq/t1xrtKW/XdnjoSg2UIA7Xi1LckLh9S6cf216dWWG/LiGRRRp3/e+B5DZkHydpkxC5puUNcdzX8SBkdMInF5HmdhHr046DHqne7jqhGeR+vapGqt75wFGkaZLzfyCJysWHqeZv3RxQpRU8jh61DW0DSWJBgIjW4KTH2lhg92poTiM5to8DgRKnfM17sB3SWXIgmGBrpznthkscI+98oiB4qDiuUbGuzkknhfgbmop+HQr4LwSHTud2VNhAyw6/oLMfM1wiUMo8vBAn8AnNbaf5v9NYxf0Qde8nJfhx5DYJulE0wL0+fV7XmhX+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lJWsK7mxltlHqAxieXaa9XigLQK7EP42czNXUq33HA=;
 b=kIX55d6XaaI8nnM5xd1X8aTBomXQrl2NGEjJkKkULvf8OxK8XEOQH8yFN2W897ec2Neij85CkON/SaxQCw1bePsjyJG92PXwSdkkDu/rkCxFTSU0eHhMewaP9NQr50P5jHEwvkGyME1Cyvnc16FGlWD0ARV3WhVNjpwGsAJGKWOZ6DtoDuBBfTSxFvWY/O1Yi+uFdfZxetz9c8naEL1HKqH1v/8jg+S2pugOgr55EReLM5Lsuq/FFGlDd4cwqS0gdFCaXlcEECvosuRaZoAlWR3+bU7g9eb5kJiQgEHrb+9dNUf8Vx342qoEwMjASHBRZ9VCMk/e9rmfLCCe6aSnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lJWsK7mxltlHqAxieXaa9XigLQK7EP42czNXUq33HA=;
 b=pRsdcrDkVYiep0EUILgS8/2hxRc5KvDGNehzJDpltiLcli1729ilBXZiiFdlOy/GRWDotl4r8kZo/sZzWixM03JYnwBwVqfzphQs3cffbbhWNUgGvxcC1ZkhUyNdj+0pCBow6HGOpi2PJNLanxqa1tmk/7FcuYBmyCmKB5nXbcs=
Received: from DS7PR03CA0328.namprd03.prod.outlook.com (2603:10b6:8:2b::30) by
 SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 21 Nov
 2023 09:10:22 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::56) by DS7PR03CA0328.outlook.office365.com
 (2603:10b6:8:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 09:10:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 09:10:22 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 03:10:19 -0600
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add init_registers for nbio v7.11
Date: Tue, 21 Nov 2023 17:10:10 +0800
Message-ID: <20231121091011.3283118-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f31ed0e-0f77-4a5a-e9ec-08dbea71b0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HlWAiLA7UY4G7tQ+YCz4AQBTRArjFIladgulBbxwHuivNiTQWES4TIp2zgSIXeM3TuuTKyZQiaaxNVlew2VYlgJtX8M3hYB2rAkZ9XE++YroS0qV9sJ+KdWHiziwDAsvJ9fUDnlxrvv8L3o0OZ/bchXSy2LomWNirqUG+IbMkQU+bQznBoGz6XMxXSDHDlZc0AW5JbLFNyVB9kCHaTLvnaqLOfPr9+RfrCqIO0YhfnDwiRYuB9j+gZOvuWWB8l6fZXYRg5SKNgU/m97M2svmh7BBYtRR6YvCYBCEaJJ1UI4iBkuaWZQ87XGYqU5/V5+pUzZXgEnOMPj4fwpJbi4m1MW18PMTG90tEuI+iOy/JEQYX6+oKlzwvkKcBQa3UysogEXdQp/XtLWQgOwp0uVTTV3ETvohC7y4p6Z831FA2xBX3Wok3ffGNg8rqQAkXRgZAbtps24VT9slYvkunausVn2v6aJr7GsA8UKsvd4QIaEM0C98N5HQeMF9W0vZ6WQpV5myuqNmPLBd6bAeu3cjMtoE95qg2QacDmvJnXIMwGeej50OhJnZ7aM2TPsLpQKGmRLr2XeWbIqL2Fbf2a06dl0DzOmmBAZzuqlg9CpyMEyC61I2tHW8WBIFuIoYKaynxR2kLWjZB5xuOl6/nQx/cr6K0oEpamQdo2hfypGaW3IW8S4aIW0/9ChB5KoCrr+3/crKLay79aC3NG58bmhE/hRWAXcNS99GaqfOOcjrC1brtaezpP8XsMrTkcnctDutm4ybasuRkBfQZFtIuB+dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(81166007)(36756003)(336012)(426003)(356005)(41300700001)(47076005)(36860700001)(40460700003)(83380400001)(8936002)(2616005)(86362001)(5660300002)(4326008)(40480700001)(8676002)(7696005)(44832011)(26005)(316002)(54906003)(70586007)(70206006)(6916009)(2906002)(6666004)(82740400003)(478600001)(16526019)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:10:22.1904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f31ed0e-0f77-4a5a-e9ec-08dbea71b0dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com, lang.yu@amd.com,
 christian.koenig@amd.com, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable init_registers callback func for nbio v7.11.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c       | 18 ++++++------
 .../asic_reg/nbio/nbio_7_11_0_offset.h        |  2 ++
 .../asic_reg/nbio/nbio_7_11_0_sh_mask.h       | 29 +++++++++++++++++++
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index 676ab1d20d2f..1f52b4b1db03 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -259,17 +259,17 @@ const struct nbio_hdp_flush_reg nbio_v7_11_hdp_flush_reg = {
 
 static void nbio_v7_11_init_registers(struct amdgpu_device *adev)
 {
-/*	uint32_t def, data;
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3);
+	data = REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3,
+				CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
+	data = REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3,
+				CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
 
-		def = data = RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3);
-		data = REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3,
-			CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
-		data = REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3,
-			CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3, data);
 
-		if (def != data)
-			WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3, data);
-*/
 }
 
 static void nbio_v7_11_update_medium_grain_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
index ff30f04be591..7ee3d291120d 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
@@ -781,6 +781,8 @@
 #define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2_BASE_IDX                                              5
 #define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1                                             0x420187
 #define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1_BASE_IDX                                    5
+#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3                                                  0x4201c6
+#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3_BASE_IDX                                         5
 
 
 // addressBlock: nbio_nbif0_bif_cfg_dev0_rc_bifcfgdecp
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
index 7f131999a263..eb8c556d9c93 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
@@ -24646,6 +24646,35 @@
 //BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1
 #define BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_MASK                                  0x00000001L
 #define BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN_MASK                               0x00000008L
+//BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_PAYLOAD_SIZE_MODE__SHIFT                     0x8
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_PRIV_MAX_PAYLOAD_SIZE__SHIFT                     0x9
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_10BIT_TAG_EN_OVERRIDE__SHIFT                          0xb
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_10BIT_TAG_EN_OVERRIDE__SHIFT                     0xd
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__MST_DROP_SYNC_FLOOD_EN__SHIFT                            0xf
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_PAYLOAD_SIZE_MODE__SHIFT                          0x10
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_PRIV_MAX_PAYLOAD_SIZE__SHIFT                          0x11
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_READ_REQUEST_SIZE_MODE__SHIFT                     0x14
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_PRIV_MAX_READ_REQUEST_SIZE__SHIFT                     0x15
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_READ_SAFE_MODE__SHIFT                             0x18
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_EXTENDED_TAG_EN_OVERRIDE__SHIFT                       0x19
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_REQUEST_SIZE_MODE__SHIFT                0x1b
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV__SHIFT                0x1c
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_EXTENDED_TAG_EN_OVERRIDE__SHIFT                  0x1e
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_PAYLOAD_SIZE_MODE_MASK                       0x00000100L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_PRIV_MAX_PAYLOAD_SIZE_MASK                       0x00000600L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_10BIT_TAG_EN_OVERRIDE_MASK                            0x00001800L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_10BIT_TAG_EN_OVERRIDE_MASK                       0x00006000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__MST_DROP_SYNC_FLOOD_EN_MASK                              0x00008000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_PAYLOAD_SIZE_MODE_MASK                            0x00010000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_PRIV_MAX_PAYLOAD_SIZE_MASK                            0x000E0000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_READ_REQUEST_SIZE_MODE_MASK                       0x00100000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_PRIV_MAX_READ_REQUEST_SIZE_MASK                       0x00E00000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_READ_SAFE_MODE_MASK                               0x01000000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_EXTENDED_TAG_EN_OVERRIDE_MASK                         0x06000000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_REQUEST_SIZE_MODE_MASK                  0x08000000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV_MASK                  0x30000000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_EXTENDED_TAG_EN_OVERRIDE_MASK                    0xC0000000L
 
 // addressBlock: nbio_nbif0_bif_cfg_dev0_rc_bifcfgdecp
 //BIF_CFG_DEV0_RC0_VENDOR_ID
-- 
2.25.1

