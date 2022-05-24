Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 09:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18ABA10ECCC;
	Tue, 24 May 2022 09:00:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C70B710ECEF
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 09:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHUfdJ/aYgKgFjpUoZGN+NQPfAjmnkat489lkZAomEmHCvZDeKjgWpud5pip2c/ThUmvDQwwn3h6r4pB5rk+ZqUoxCEdn5vCaMg8yZUmyUptYwl6adFcMkusj0Df8mVWptFXO/IUddKWVa5NTzkgh25wkQ4InfEZ3ouFoiKOF+cOFDlWeHswcGqfhqdA4A9w0IkDdpDSnurqAEVqBgt8HR4JRixeK4S7hjMYoc9goWK3n5HlckJuF3zrCoY7GDLyvaO2CxNAa1HFKKHabVFJlY2fnfOZx5+yyOEkdYEoNCTm6vE7aFX6weQe/wmbw2wFvhZs8Xue5LR+ACsBmVoD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coCIOfxhfKgAdfDr6ogvI6Bz9qeAtpfNU6zC93W4UQE=;
 b=AVo8jB2/LGYlXpoNSRGj280ZVsAGwsGgjrs+05rFTe1s0hp9pRO3SMtzkjY/GPDhZacxCua+zS9BAU0C9STsPpP4IKNKCbwCjnqDarObR9jXx43D7DABjO+0pqxI//K2WOWdb2aRDuiARs9bOrg0MYWiDRfCZBClIum4L3JxmlMZlCzpQHs0wUWKC8xlFQa1XB6mbSSA22G6LN5rq4FjNVtDNEAdDGmb0fzpCg75gOFa7ZMmk/p7v1Af2CnDAn+ZdPwjkujTOZu8HN0Ky7pYeBb+oJKXBJf6YbPvEhiylj+264JAmO3eMQA6JtHb2S4ojgC1HVFYHd9VVgADuS5Whg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coCIOfxhfKgAdfDr6ogvI6Bz9qeAtpfNU6zC93W4UQE=;
 b=WCNZugHwpPPYi/fAfFzNFrt1BKjKSbr/4TvfeC5KzrVagaVtRfYIHvErdzr0QDwxeSgW2uwrFkMZ5FfPckdvHp9affcdb8jVqvzDFdCNLvfM6vRO2YNbKS6SABbngojqeHVMcuD8R65+4u+HURL3FemjFC5qAoCqdFnciugLrGs=
Received: from DM5PR13CA0003.namprd13.prod.outlook.com (2603:10b6:3:23::13) by
 MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.16; Tue, 24 May 2022 09:00:08 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::d7) by DM5PR13CA0003.outlook.office365.com
 (2603:10b6:3:23::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.7 via Frontend
 Transport; Tue, 24 May 2022 09:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 09:00:07 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 04:00:03 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/pm: update SMU 13.0.0 driver_if header
Date: Tue, 24 May 2022 16:59:38 +0800
Message-ID: <20220524085939.33215-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220524085939.33215-1-evan.quan@amd.com>
References: <20220524085939.33215-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41358626-e926-446b-97e6-08da3d63cd32
X-MS-TrafficTypeDiagnostic: MW3PR12MB4444:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB444428F0CC71E00885C8A18FE4D79@MW3PR12MB4444.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aeJHSO7+vVJFxFzZNP5jcEsU4I9gSBELo+3CHJSa27/0TbMtFzZcp1bDlSEQWwrI7LBFb3M6TvzOCW2oFjrP6eP0KGAmmGEhymUA+Haln1FSSbSy/QPjpljQ64YhI/6rwkRH2UwC/TORgw5eswSc/voU4QnFDzfAAY2XMyPTvK5IVevKTCtQUTy58k6q4CdW8s7akWyKjaAn6QNp/jRZOIdFICYc5SwCbPQV9zFzG3b6flQn3sRd4yTZ2U4dIJM2KomdItgt5EMbcbMU784bYCgPy5jr8PKqlpTZit8ANd1j5oNNhHekI4njIIB+G7e3/F6VsJFdiGGlrd49AxSFu+bE+O+KCGbEe2m5zTh+l6VUQBRnOhXSvi2WqtbB4zwWEKCmACdBedABgnkHC/rztwPIealIKBbfgWd8rxH3psHWcLECZzqN8IodI0VA21lK/odvn7ssUAcMsHshvfzu9BgGtUh5d7uoOpeiHfoihsWIsjqEU3LqBugxc3Qpbb3ko/i4+Wk7G8+4xiYp8Dk6076uoz1eROhbYBAKu9FsCYBJWS7FKp1R0YFzJZ6FZeBK2zelhgu4HA2GbaFYpIXXJsK308QY5K52iii+ORtk6nkGDxsOyRbLqJBGE197wmI3Pox+Ug4rrV3S27KD48JYxHxVSVamt8f2xmt+FP6ets8AzRbC5sHz2Jo58DinErpGuSuS84N4eoemsH32+0LNug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(8676002)(4326008)(70206006)(44832011)(2906002)(356005)(81166007)(8936002)(336012)(426003)(5660300002)(47076005)(16526019)(186003)(508600001)(83380400001)(40460700003)(6666004)(2616005)(1076003)(26005)(7696005)(86362001)(316002)(19627235002)(36860700001)(6916009)(54906003)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 09:00:07.8485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41358626-e926-446b-97e6-08da3d63cd32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fit the latest 78.39.0 PMFW.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: Ie8280606729fa8b80a0abf1bc94f16c4b06191d4
--
v1->v2:
  - coding style fixes(Hawking)
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h  | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index 7fdcf29ea0ec..70eba1bfd967 100755
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -1362,8 +1362,14 @@ typedef struct {
   uint16_t AverageDclk0Frequency  ;
   uint16_t AverageVclk1Frequency  ;
   uint16_t AverageDclk1Frequency  ;
+  uint16_t PCIeBusy;
+  uint16_t dGPU_W_MAX;
+  uint16_t padding;
+
+  uint32_t MetricsCounter;
 
   uint16_t AvgVoltage[SVI_PLANE_COUNT];
+  uint16_t AvgCurrent[SVI_PLANE_COUNT];
 
   uint16_t AverageGfxActivity    ;
   uint16_t AverageUclkActivity   ;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index e858436664b2..fa544c551b0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -29,7 +29,7 @@
 #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x28
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x29
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
 
-- 
2.29.0

