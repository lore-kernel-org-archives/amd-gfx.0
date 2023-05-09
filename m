Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FBDC77B7C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6725F10E3FA;
	Tue,  9 May 2023 22:07:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AEFE10E3F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:07:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhGpdZRMwgylDhfYwvEsuVScfY+d1cFuuPSA+jjn5ckPSHWVLBECFXjMeOt3zInIquTAW/Fjch1C7GDm157Q0yAcJoPgCLKIWRFfdCGTBfwUJusTZy7PXb+hZyMBoWlnNtMcYt0Suw9BpdIg/D6wpBD1pDGY9fYouYAmfKd3ZZog1OeqBhtOTFtO0n9VUMT50cjqVfj8WkHKERqTpN92dCKq2HW4YD3qbOJ5PBGzduybqhKHKb+hMgRpucG2WkpHErKEFLc5MRsuSMk6F86qXp0kXLFXCUAwWZhNMwbqUYzyJSBgnvwpDojauEYWPml01QbR9t5lFROuKDAqIkQGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLDQIZlt+I0pkEBkwkjiE8TrN/MzNOUFupXIrtNVq80=;
 b=PnxreWvPGmchC7O71q64o3/9lyXcVj6vRGCiz2yFr3N7HoJ2fXAw1AYupqQp1Qa+olsCfpTmupm9t5qPdIfXJW/CaQdM/VEKJFQI+r/PbgjvGXYcvU/eB2/xpp3D4Ku/mOkdyvjquV4TJbKHs72o1OYQxEVL4JLB9eJ6C8FF2+XmkW/ai0LaVOyLmwOvV2O6XwjvaJ5mEgQRJaI1VHyT8iSRG6OVse9Dmd+hBOdTVR5BpxQsqW4feT36djIFM5kUnuu1uXF/26+p7jbHc2y++nnF8csZFt3ln/HdnSUz50IM92oeCmocUd9xwoZNXo4HW9qKogM0TTsnjWvVZqIRiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLDQIZlt+I0pkEBkwkjiE8TrN/MzNOUFupXIrtNVq80=;
 b=nYfr59o6S1yDO85ai6FzScMfASlvtfWC67qLSKwZIQFdMNKar/C530tZAz9ez0LYezFNGyxysjb1l1UVlG/ZRP7hkSI3JwmNYkWTGnC4IBwd/H5LuL5yNeBuOKZVeAXCqsQ8WTqcJtcqCicwRaAgGB34M/mkmX0swaKcNVpTmdc=
Received: from BN9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::32)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:07:28 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::7) by BN9P223CA0027.outlook.office365.com
 (2603:10b6:408:10b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 22:07:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:07:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amd/pm: Update pmfw header files for SMU v13.0.6
Date: Tue, 9 May 2023 18:07:05 -0400
Message-ID: <20230509220714.475369-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220714.475369-1-alexander.deucher@amd.com>
References: <20230509220714.475369-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|BL1PR12MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cfe18e-4897-41f9-c553-08db50d9c761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phC7T5YTV+DFoiNtQPHxkurm8VLe7+LEusmXrewxxZzbhgW3IkXofSxohCTnD7TVyEUVJHPd4lRJdNnlfOFqrSgNp6U5AJTg9x8gCOWkdJk0yxYSmjLm412hR8y+lKcfMWN1UtsaqXtyepSSCs+Mfdnv7ZRUBGaVZO0grqyN/OY6u3/9ARJRLA2hPdhu1CzeXMTiBHedmAJp6jYpaZvIUkESF+KOyeTTduPtgezHCCmdo9fV9hEOQMvJbC4XqWp7mi/n1ylGDu2egL5aOdsxQ8JELvbp97KRG47EV8M3gaaqZkLf2fgTV3x2pfT3iErgAMMhUGGKI+yH34gf3cXp2XR0KcGywnPdWhe1ggmY6TKepStilCdxyElELty4qLOXhP2iplq2w6woDKtbigRpWD5K+F161o8enIINwxZWNXMFdwyIe8RiIB7iOcCA2LWF+HLyLyFyUG5HnMBBj3Zq7t6KIi3ruzDZIpRd1H2Ksc5xyAHWAkGE5hNsxMx2Kk4FW8wQfjvWIdTRJ1ibkX95G2tuO505tPNgFMXuJAEg9/NOhOQ0OlJ0ucUvoChKGKXoaSyKk0n2i3y7MWySS3VJYFdn96DcxSBozAis62sRnutgRfzU/buN8Juhq3xhWpkbaBVNfnVj6rdIgCT3mK78i7aTDFgqC/vkLeE3Am0DZnMSZVO5TM+vZ2loFctla7xkI3BJ4mvNtSfclNWXWyqOBamNLgelI05d65BPqS3Ut9/IXiQk8wFbtRGvKxqsCjcuXkd+4Bk/YXP6KnWW/9oABw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(6916009)(4326008)(19627235002)(70206006)(70586007)(478600001)(54906003)(15650500001)(5660300002)(2906002)(8676002)(8936002)(316002)(336012)(426003)(86362001)(41300700001)(40480700001)(7696005)(356005)(82740400003)(16526019)(26005)(1076003)(36756003)(82310400005)(186003)(36860700001)(81166007)(83380400001)(47076005)(2616005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:07:28.5943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cfe18e-4897-41f9-c553-08db50d9c761
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Asad kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Asad kamal <asad.kamal@amd.com>

Update driver interface for SMU v13.0.6 to be
compatible with PMFW v85.48 version

Signed-off-by: Asad kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h   | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c |  1 -
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
index 370c6125d718..8b7fa0fa59c3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
@@ -121,6 +121,18 @@ typedef struct {
   float    minPsmVoltage[30];
 } AvfsDebugTableXcd_t;
 
+// Defines used for IH-based thermal interrupts to GFX driver - A/X only
+#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
+#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
+
+//thermal over-temp mask defines
+#define THROTTLER_TEMP_CCD_BIT     5
+#define THROTTLER_TEMP_XCD_BIT     6
+#define THROTTLER_TEMP_HBM_BIT     7
+#define THROTTLER_TEMP_AID_BIT     8
+#define THROTTLER_VRHOT_BIT        9
+
+
 // These defines are used with the following messages:
 // SMC_MSG_TransferTableDram2Smu
 // SMC_MSG_TransferTableSmu2Dram
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d0c49e8883e7..b08608caafd0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -175,7 +175,6 @@ static const struct cmn2asic_mapping smu_v13_0_6_table_map[SMU_TABLE_COUNT] = {
 #define THROTTLER_PPT_BIT 1
 #define THROTTLER_TEMP_SOC_BIT 2
 #define THROTTLER_TEMP_VR_GFX_BIT 3
-#define THROTTLER_TEMP_HBM_BIT 4
 
 static const uint8_t smu_v13_0_6_throttler_map[] = {
 	[THROTTLER_PPT_BIT]		= (SMU_THROTTLER_PPT0_BIT),
-- 
2.40.1

