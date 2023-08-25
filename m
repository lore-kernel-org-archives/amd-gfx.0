Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED82FC71133
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 06:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B245310E101;
	Fri, 25 Aug 2023 06:44:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C207A10E101
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 06:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh4Oa3221y9mKPedm4iUnXWsGPuzBkAFqxUJoE29n0hwXENv4PSNE0DJxSU6dgyNpF0mejjtTZSn2UFymyA1pansAvDOjKW6ZOd66eWtaiTj+exHm7MGfgSau0sasS2nLsxew54jLMwxnDGP2gQrWQMVX3CRmMCSLEiwyCyJ2IZrZ8ptszHJs1W/g06HB2B3+Ff2gbfKCHlIliFsF03pcvOjNyiBF1tG80JmMbve4bG/DVXP8Mr1Apv8BHSkyCbF+9t0sHNCwTQHxfhvKxL2g23oTNU8HLlkGzTqc/9O5P9ggYt/HAMaypQo04tan+zOKtY4MzkJRfYaKPx7mZtS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqXjAo8OvvA0FfYYjZjYrhYZkhrNLVLTP6F5sqhwjfQ=;
 b=lcbKmus8lT+elBc5YkyZcisZeN6kuJ88F7yq0d+RJ6mlD2rEuP4Ur6dAFYcHlV5FimhoSAFULKS/bQdnVVLPw9oZ4ZX9Top3trbg/7mYUe1VZMJqe6E2qRs9oy5OXppmUkM6cl79MFoHEsCpRQHqGWePD6OFPJ7gcbfsAMPk11SWaUrGQ0IVB5DwJyGSXsFmcv/3l7BmnpUiV3BapspYMHOmV71FADgx0+UIG1XnIiRlFA5EONT3ElRLcuoJCFqqlPNNzILW7v707L/eQVUi9aZ77a0ZBsuSVurRf0Iy8nZApUW6oa9mLO5YHFhGszf3a4C3Hu7juoK31quYAJMezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqXjAo8OvvA0FfYYjZjYrhYZkhrNLVLTP6F5sqhwjfQ=;
 b=O7weIwW6ZSdT29zLVBQqyOWEiRMiRM2p27QKDko5PD/oWDZ/+uRhOvnbcFzxHED4i4bPh2e+OdyT6zNYYhqse4Wd4PLhvoGN9HdFRbonqomHNP48cbfZheanHTIAwzbfjrSMiGN7YrcPk/9NYp5GoaqEp8aJ9irHDwN8yR84Rxo=
Received: from SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::34)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 06:44:14 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:26:cafe::c5) by SA9P223CA0029.outlook.office365.com
 (2603:10b6:806:26::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 06:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 06:44:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 01:44:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 01:44:00 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 01:43:59
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add umc_info v4_0 structure
Date: Fri, 25 Aug 2023 14:43:52 +0800
Message-ID: <20230825064353.23079-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 05679dda-b49f-437c-304d-08dba536b245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QRLGjNzsXS5D43LgoANP9sJ7muZ0iLmSzYPt3+Z5zmz7H6mI6+5nDxSyZjZpR+TWHNYdrNA9InCD62zx2zn1eP92M7vhcVnG/DFOnlgcoIv+Ihnylh2F4L44v/nKKt0dmiBQ+qqDSyGQjYpwSZFgoZyj47GbHZ92mzZe6lJ6R8cOJ8GWSBd4Pk6c17SbkSFtxYZs1V523zByetLSDrbMRLlowPWhRiMwh6uCmNpBtRrhKDIHnPUvsnmMmPDr6pG3f7ReuahYjcM2o3Ratyaf2DsdDsvLNT0tC6nzeem7QOo2dYlO4GDioNHUHbsetEql0UtX9rpfJvSfXDDIN4gtdnR9r0Ma+8gTqJ4t4KYOJ2T8wN9j5k2bDDn7L+/UtCnzT/QRcauk/1jtGsMCPvgdFen2vh3AbJEaMncgEWqiaMIhrBNRME09XzfaYK1A7Lw7Cgz7aQs7WHoQWUezdeVRYHYT6iLDH4/z5OHXPkqLLRkizAsOVNRGa5qWyRv72pZUEGdL/Ghkofzz9nq/ZYLAY41BrHReYOAn9HHiontDSR6UMWaF0NP3+iAVIos2Vw8IwEt6H7oLjsPWc7e5rclA6G4GO8sH5fVEe71dGKXU7xCyKC3ycPcW+aGVEHtZg8kaV/XEKB5YhMf1pDnY+aufnSGUjJ3jQ1tKS8FrJ2i/n6f9mQ+C07S6AhmkjKIRtmrLuGGFY5Moqy2LGC+Pjwq/HhxxbjhbfzS4ZxDdfFxwKD4+UE242qemduu2qt/YUl82FXenEDuEvGBV4tWwTsI5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(1800799009)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(1076003)(336012)(36860700001)(26005)(478600001)(47076005)(40480700001)(2616005)(5660300002)(426003)(2906002)(8936002)(4326008)(8676002)(356005)(82740400003)(81166007)(40460700003)(6636002)(110136005)(70206006)(70586007)(86362001)(41300700001)(36756003)(7696005)(6666004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 06:44:14.0127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05679dda-b49f-437c-304d-08dba536b245
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To be used by aqua_vanjaram

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index e68c1e280322..fa7d6ced786f 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -3117,6 +3117,24 @@ enum atom_umc_config1_def {
 	UMC_CONFIG1__ENABLE_ECC_CAPABLE = 0x00010000,
 };
 
+struct atom_umc_info_v4_0 {
+	struct atom_common_table_header table_header;
+	uint32_t ucode_reserved[5];
+	uint8_t umcip_min_ver;
+	uint8_t umcip_max_ver;
+	uint8_t vram_type;
+	uint8_t umc_config;
+	uint32_t mem_refclk_10khz;
+	uint32_t clk_reserved[4];
+	uint32_t golden_reserved;
+	uint32_t umc_config1;
+	uint32_t reserved[2];
+	uint8_t channel_num;
+	uint8_t channel_width;
+	uint8_t channel_reserve[2];
+	uint8_t umc_info_reserved[16];
+};
+
 /* 
   ***************************************************************************
     Data Table vram_info  structure
-- 
2.17.1

