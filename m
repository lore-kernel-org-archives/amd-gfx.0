Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9CAC7EE2E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 10:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0377B10E1F0;
	Mon, 12 Jun 2023 10:29:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C6C10E1F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 10:29:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBWW4tig6vDxaLY4E2o888ZEXdhCLTts+gBuSuw3u0GiusHagjvgpf4gDaPMH2pNPfim0iMAQtcs8oYDLW+j/USG08otMl2o6OhCpWEXDcbbowM8y+8vzQ3Vysxhtv2m6gXfmnc2zPA3MgCyF0XnJeoLfpcXtL7oDIUpuR6nCXmD+ybF1rEjTnsDSNCcL75Y69e8u9Yf2fVWpVWyxxOoTsb78MhfGAkHGu72pE/BxZ5EdMUhom2BEDflx7Bp05lwVx5WdJrnRRWaLjHmTpyUZeYF0Og4wlIgm0Kf5PVq+5XOnmi2meUpzVfuu8LLl8kkdXxte938tk4g75QsXUdzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23d9byNd3P0OiSB3sOwvdvsZGtcriQfLcge9DCyHB2U=;
 b=DtAT9Sj6FEssAuJE0ZbZqwNEa4IkfRESvJFBqDTxedgLgqhh6pcUFHZyrDnzYDJ6yxms+EesVG6sCkPP/ck1Y1s2LbauP0zcNVkx66T5xIwmnb0Ik8w3+/bhi7tA80MMokgVsuWlVw/ac+jUqgSxStP2AZfZu9FJoTojlvSNs5MJNr5VPIt2YpvVTzAlJunWSnVTAeA6EcQ160svih/C6RwB1DoMCdJS5a3GBUfnSyWiWt8RH2a2zUh5DFGe/5vQqsnKtDuDUh9CuDLyde6jxDwOWuOGcKoI6T45mahFnCXBQKAi7iLhAqMGDUyU5Va83MBwIQVjXcB2hCt9c2iiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23d9byNd3P0OiSB3sOwvdvsZGtcriQfLcge9DCyHB2U=;
 b=4kTDz8DyIdpA4A8lmB6fa79KCTx96CCZ5GPpQ7UWK1eo//OqoOyYYkFjD4EBCfJ81jN2Q21x3OrYkN0xRU6iPr/Jfna3FdtAYMPu8qkrRRSFtb9jAEtBwJdW5a2Whyy/AqaRbPHkGj78sGu/ZCHc4nMAh/AabbWMJAyNLQCou24=
Received: from CY5PR22CA0094.namprd22.prod.outlook.com (2603:10b6:930:65::14)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 10:29:19 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::41) by CY5PR22CA0094.outlook.office365.com
 (2603:10b6:930:65::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 10:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 10:29:18 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 05:29:15 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/radeon: Fix missing prototypes in radeon_atpx_handler.c
Date: Mon, 12 Jun 2023 15:58:59 +0530
Message-ID: <20230612102859.2215988-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a483ad-fe55-4613-cebc-08db6b2fe120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wk6GN+iCj8rBsadcLaHTI+I2U50EY6DlIVlWTc3LieRsSnW8CjoIqWeVFTuXl94Rvy0gJwp3vbDRsGzRtWiHbpbHEnkOkqkek57fo7tGN5cCFGvrQ2MXsqQH46Z4IyLZZfowNoyTz6/TZLhTWN0PGJ1ayaMK+RpQ7C+pxXdb8tVz6zwrscWibA+O68ZAq9gFGwEVOE8gNO64XWy8V/SE6ARNXdixQ1mRschW9q208GQEniT6dZf4ZhPsNL04eA+ihH/qAaJAdzeh+GyMDNYlx2dBKJMOl6VY7VMHijVbq1nOIif92/pgrKDztBYvUspn5LB+Q+hwR6TilNEaCtuYQJH04UyH5nXQ46gvpbH26AlCbk+dt7+dsGfPDVyMw6CQ6Oi09WnQHhwv0qSR995byNDtlsnE8URZp4UQISG5C65QR7WY4YdpWm2q+pl7hacq+5Xio2qYVPrKtoLyjtui6IC8czKtgVFjdoWPEKM4qorIo+tRbJVPSJBItjU9Mq43V27C4ioiabjbpp6H1LB7E6Mn7nKi1zNmmWAdxD3rohr5/vz0wWEDW8CTi+QAtcnKdinnvfOERcLmVT1bs/4UqCmvDXm/m48ySG9eor2+tZRTzv4uLU3wX1q3PTYC7iVAfPfWz6NVAp8SkqcI7pB8z+ZiEZZ83k5ozwMzdHVQcuqZfRmT/GJA11Qae+Ohi/DqHbuGw9A2U8oHxwDiBRLjTM1Kl6u0a8GCjHvYiWoePvOrdKmySpf9/C3RkK6oY4fbqzoXiiRAQ/2v5038iaqLGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(47076005)(7696005)(36860700001)(186003)(16526019)(83380400001)(336012)(2616005)(86362001)(426003)(356005)(82310400005)(81166007)(36756003)(82740400003)(1076003)(6666004)(26005)(66574015)(40480700001)(316002)(54906003)(110136005)(8936002)(70586007)(4326008)(8676002)(70206006)(6636002)(5660300002)(41300700001)(44832011)(2906002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 10:29:18.6622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a483ad-fe55-4613-cebc-08db6b2fe120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

drivers/gpu/drm/radeon/radeon_atpx_handler.c:64:6: warning: no previous prototype for ‘radeon_has_atpx’ [-Wmissing-prototypes]
   64 | bool 4(void) {
      |      ^~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/radeon_atpx_handler.c:68:6: warning: no previous prototype for ‘radeon_has_atpx_dgpu_power_cntl’ [-Wmissing-prototypes]
   68 | bool radeon_has_atpx_dgpu_power_cntl(void) {
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/radeon_atpx_handler.c:72:6: warning: no previous prototype for ‘radeon_is_atpx_hybrid’ [-Wmissing-prototypes]
   72 | bool radeon_is_atpx_hybrid(void) {
      |      ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/radeon_atpx_handler.c:77:6: warning: no previous prototype for ‘radeon_atpx_dgpu_req_power_for_displays’ [-Wmissing-prototypes]
   77 | bool radeon_atpx_dgpu_req_power_for_displays(void) {
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/radeon_atpx_handler.c:596:6: warning: no previous prototype for ‘radeon_register_atpx_handler’ [-Wmissing-prototypes]
  596 | void radeon_register_atpx_handler(void)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/radeon_atpx_handler.c:614:6: warning: no previous prototype for ‘radeon_unregister_atpx_handler’ [-Wmissing-prototypes]
  614 | void radeon_unregister_atpx_handler(void)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/radeon_atpx_handler.c:159: warning: expecting prototype for radeon_atpx_validate_functions(). Prototype was for radeon_atpx_validate() instead

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/radeon_acpi.h         | 9 +++++++++
 drivers/gpu/drm/radeon/radeon_atpx_handler.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_acpi.h b/drivers/gpu/drm/radeon/radeon_acpi.h
index 35202a453e66..974fbb4ce2c2 100644
--- a/drivers/gpu/drm/radeon/radeon_acpi.h
+++ b/drivers/gpu/drm/radeon/radeon_acpi.h
@@ -453,4 +453,13 @@ struct acpi_bus_event;
  * BYTE  - number of active lanes
  */
 
+#if defined(CONFIG_VGA_SWITCHEROO)
+void radeon_register_atpx_handler(void);
+void radeon_unregister_atpx_handler(void);
+bool radeon_has_atpx_dgpu_power_cntl(void);
+bool radeon_is_atpx_hybrid(void);
+bool radeon_has_atpx(void);
+bool radeon_atpx_dgpu_req_power_for_displays(void);
+#endif
+
 #endif
diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
index 6f93f54bf651..d0b450a06506 100644
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -147,7 +147,7 @@ static void radeon_atpx_parse_functions(struct radeon_atpx_functions *f, u32 mas
 }
 
 /**
- * radeon_atpx_validate_functions - validate ATPX functions
+ * radeon_atpx_validate() - validate ATPX functions
  *
  * @atpx: radeon atpx struct
  *
-- 
2.25.1

