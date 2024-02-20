Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E442C5475B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 19:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 448C010E517;
	Tue, 20 Feb 2024 19:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KcW3LLmV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FC110E517
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 19:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+pGD9znfEopzEv3kVnEBDoVqsL9IWK2ogh/PT2XsP34ybkKACamXEC8G/fOK2eJR1d9edkBwZlsJD7CF9lU/KZRIZ9SdXqgPl66nW5R23+L3w5TPbd2Ks1+7Mk75lhXL3ZwDVopmIq4oWE7pxMfcMnCWEhWUix1IW55zIoSJ56v/WMgbAd3mPV15WZ4a1jhX/A6/PQvIibml1QI4kifAPwbQ91oVMs+tZulNvWVC6H8PnFmKwSr8381LiGLgHbBE9zwcwLDHP99YikK3NlFTgJ0eC3Zenhe8r865OqK7yym5XJp9UgTmt1XGmUjH/Kjwxtu9MLdGH4qKu2jRMi5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAotOTSn/vW3wB/CMmQG7L/iJu61dxVfKT3piGnRk+g=;
 b=GdEJxp5oetqLNqbYOW+TtJ9NGotVp8S5Z4aHxwm57KImhpQ5+jRASsy4j8EngBJW9r7RZ+9PgAitYonMw492e7Dc5B3bg8OKiGXt4vShAeKUv/Gatvu6vvVtHP1gmsE/MqWXwhWMgTE3B0HgUR54K2jHX/ssjfQWMaNiATUgcVFGDVbXQ5vxURXc9w8dWEneg3vUlYTqbJAD6ECxS07fLIrfknT83fE4UKWRFaWeViWPF4m3xqacoaZtKfjh6UIfSa3KlFnsBFft5y/EmdkiMmQEfRnQtdOgTCTdCdXJBRHyK1goxZrBP+ha8/eSy/Z7v2UQ9nlLio+f6QpKj+JJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAotOTSn/vW3wB/CMmQG7L/iJu61dxVfKT3piGnRk+g=;
 b=KcW3LLmVVsehm9tAwPqdLxLeLfRGdEJN4995sQqehu6psVCPMh2kwHtTLQPiOiMhwurwxvKTrDPGmDfvWrnSqh4NDTudXL5iNxVrpGjDAodqvCguYXepiK1d3hB1LaBX3e9VIxEhqWc7DpkC1QU5gYrrXUZklf/sA4kjRav1tMk=
Received: from CY5PR19CA0072.namprd19.prod.outlook.com (2603:10b6:930:69::14)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 19:20:31 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:69:cafe::ec) by CY5PR19CA0072.outlook.office365.com
 (2603:10b6:930:69::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Tue, 20 Feb 2024 19:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 19:20:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 13:20:30 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 13:20:29 -0600
Received: from 10.4.12.207.in-addr.arpa (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via
 Frontend Transport; Tue, 20 Feb 2024 13:20:29 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd: Update atomfirmware.h for DCN401
Date: Tue, 20 Feb 2024 14:20:21 -0500
Message-ID: <20240220192021.431356-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac17265-4eb2-4050-b41a-08dc324900e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8xUh/N9wEEQgOg3nT2IF0ooSJzKIoLGolD/9zA9YvBEW0KFRR+D/jj0NT7T0IWtthIWeiasT+3fXySfTppFH/rvLnSrxLjTJZmYwMZnom4+kAsW975blYUQOuPx48a0vSoUFUI2/eopRybobI4bNw21Vk4Epe3zm+tyerBClZzL/KP5zhjJFGAbbP+GrLbxCF2NwDcN33M0uFFgmFCb3jEP6ZMpGZlhONuuvVGu0bYxmV9IDqaN1F8uYa5kRIilgwyiP0DTgixAbABTmE/XwR97jyAGNtUGIL14lv7ueWo8u/KetBzZwt7ma7mSXJNBt+ONe2b+S8EtdpPP7uKodRvbYv5biBvufPUdiZp05E0SZSa/VNqUO+fxqJvgW+8bRLnltJ+Rl+Dnp8y/AIQMAKuZ0yLLZOXoV2Or1jwDfTigKVvQjxhnZ/8a/567erKctcd3z2lCbwk7FfAexfnrP2khFuTt/ohk6+LUu3F12HzJ/bP/WDRA2tlDkDJv41VzY5gWz3MCb7Gh2ZgAaEJlyeK+0phKLzMlgHv1rG3NH3zsnD8R2DWAhNo/OS8oXzPId4c/jMl4XNwlG6WVHVrwwuaN48TTn2Z4/eSt7VyclUvfLb5ev4VYkbyhXWG6AukTk7Hh/G22Sr6mMzLweaYaC4n1oIGK5Llc4wLqA/ISLgE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 19:20:30.8147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac17265-4eb2-4050-b41a-08dc324900e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
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

Add new firmware header definitions reqiured for DCN401

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index fa7d6ced786f..206c8a025f9e 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -610,6 +610,39 @@ struct atom_firmware_info_v3_4 {
         uint32_t reserved[2];
 };
 
+struct atom_firmware_info_v3_5
+{
+  struct atom_common_table_header table_header;
+  uint32_t firmware_revision;
+  uint32_t bootup_clk_reserved[2];
+  uint32_t firmware_capability;             // enum atombios_firmware_capability
+  uint32_t fw_protect_region_size_in_kb;    /* FW allocate a write protect region at top of FB. */
+  uint32_t bios_scratch_reg_startaddr;      // 1st bios scratch register dword address
+  uint32_t bootup_voltage_reserved[2];
+  uint8_t  mem_module_id;
+  uint8_t  coolingsolution_id;              /*0: Air cooling; 1: Liquid cooling ... */
+  uint8_t  hw_blt_mode;                     //0:HW_BLT_DMA_PIO_MODE; 1:HW_BLT_LITE_SDMA_MODE; 2:HW_BLT_PCI_IO_MODE
+  uint8_t  reserved1;
+  uint32_t mc_baseaddr_high;
+  uint32_t mc_baseaddr_low;
+  uint8_t  board_i2c_feature_id;            // enum of atom_board_i2c_feature_id_def
+  uint8_t  board_i2c_feature_gpio_id;       // i2c id find in gpio_lut data table gpio_id
+  uint8_t  board_i2c_feature_slave_addr;
+  uint8_t  ras_rom_i2c_slave_addr;
+  uint32_t bootup_voltage_reserved1;
+  uint32_t zfb_reserved;
+  // if pplib_pptable_id!=0, pplib get powerplay table inside driver instead of from VBIOS
+  uint32_t pplib_pptable_id;
+  uint32_t hw_voltage_reserved[3];
+  uint32_t maco_pwrlimit_mw;                // bomaco mode power limit in unit of m-watt
+  uint32_t usb_pwrlimit_mw;                 // power limit when USB is enable in unit of m-watt
+  uint32_t fw_reserved_size_in_kb;          // VBIOS reserved extra fw size in unit of kb.
+  uint32_t pspbl_init_reserved[3];
+  uint32_t spi_rom_size;                    // GPU spi rom size
+  uint16_t support_dev_in_objinfo;
+  uint16_t disp_phy_tunning_size;
+  uint32_t reserved[16];
+};
 /* 
   ***************************************************************************
     Data Table lcd_info  structure
-- 
2.43.0

