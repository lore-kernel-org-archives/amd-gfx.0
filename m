Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17884C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A04113FE5;
	Fri, 10 Jun 2022 20:53:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95DC9113FCB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbAWV8bX0plTpm1Ns74KxaA2/idC7oy7GPwLg92fL+5O0TwueFg/UMOvsJKh7lkuEf1+STzr47Ps+VNm2jFT1+XeJx1VDbrmF8KK4Gy1X24e5dxBfKFHLbLaWIQSnViENZ7nPTlKeXi3EXkg1OogEcYJPSjPXyEEMTXIc3ZS2qY0A8ND1DMwqGIbz/EeVnecmjDyiPwYb/ObsHmMvuc3AGJdIFATdPj7pc1zwKX+/qETnvD09y8BbgR6+48w+UQmeHf5whYNNikGbno9H6fAb7xoXhLIpSdfP+GZnYK02b3qjka3Ib1/2QAZxQqE6XTC7aoqV31+5uj7s3jZNVqbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaddDvVPTJzUoYzFv3CDX7PehjS9Sp7nE6YXCPzA9d0=;
 b=f9SWeo3keyailSeJbWbP6HSPJRBuuNlK7BUjlasTHr9Xxl4JEvQH/CSdjgIyV+WUJH7qOL1twMYneyP8NAaTvWeMWq0qiUvXQmJhpRM6eUHcCannCA2wFMIpahMwfLhwPR4p5oxvaMIxQ5TxaE7H/mVaJMHOKK8mG1JxRmaCSXqtQKIZpmyOK9KbXo/DyiZ7AYvhg/buazQZYo+UNQFKlSVtjIIE2L+q9i4zUwlb//8tvWQgNGu0rO5DMdV+nk9bwrBWkZSPlEtl0DknfSsAyiHLXdL7ftVyIEUByWq6AZfcPmrIvKI2HDgJCUm+zR8i8RFtj4lBjOy5zp9Q7Vh10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaddDvVPTJzUoYzFv3CDX7PehjS9Sp7nE6YXCPzA9d0=;
 b=Ol2pfSQOLIajAIIXpNTqdLdppeie0eiV9jaIPbYvjTd6BGk/vgnm/1KpVN3bH2V4pZfs0uVT9F5EXeFgp3tTTasijs8kWJ4HJpLFptZcWfCsLrvigpRRG3nuTcEQnOb2xtzQm9AD5GcaDDWwf2OeCQD83OniAxdZaucTJHr/zgU=
Received: from MW4PR03CA0154.namprd03.prod.outlook.com (2603:10b6:303:8d::9)
 by CH2PR12MB5532.namprd12.prod.outlook.com (2603:10b6:610:6d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 20:53:25 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::38) by MW4PR03CA0154.outlook.office365.com
 (2603:10b6:303:8d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:25 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:22 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/23] drm/amd/display: Fix comments
Date: Fri, 10 Jun 2022 16:52:35 -0400
Message-ID: <20220610205245.174802-14-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2080abe-6303-4ff1-dee4-08da4b234361
X-MS-TrafficTypeDiagnostic: CH2PR12MB5532:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB55327BCB27E50EAB969E7F58F4A69@CH2PR12MB5532.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: innTxg8KtkeDkRGbYoyJEBb7pNpNqeiFfUqQ5qwcfgTHODxW/ptOLizUAF5DrJjei5b29f7Eex0NssExUZ/ZSrHh21Y9H24VWd7+TIpGkfOPE2tHMHFdrfkv6WwxXpaB7hWjWX74C48fEH0NvT/Gpe24d3eUhFEk2mDWJIXp+R3pCbMe7/vlUCXhoir3n8AEmKj50r3EX2M0lRo/haqhYO1PxeRBYOlYjjSaMHks/AkJr1X533bEJVZqL9Ydd1joLxp5yJe0YAQeJPjORZnU/kA3nr5idS9N25ekWW11hL1HT6MBjaSTt2d3hClZfn6F3pJk7jkFjaFlDI6cOR5PEsy4hYOiizdINJpxQdz7bB0/Lecjl5duM4H12RbDQdM/NBeJGkiA6k4qIHQJQplMpXscc2udmV3aNX+XJxHpMxQcPG9i8ZPRBaMAwysAod13BZN52YrGQ3e3SCVpBg0w7unKAF+TcfO9cWt3mZzhyzdw+0wW38HbuCgq7yiieuUbKWrh3zpRyfprfuGa/OdsT+itQyGnAXWECFd6FiJGMYjNaY4D5GGOQNXHO5S6WtnZl49eJEw358dogP9EV/Qy/LZQ3oHEyqqSWUowHW2oP6zjpUoZqmD78KEA8N8XWTIx4FHdgEzLeKGWTDNND9DCAkxvuJ7go/0e4lygcMsm5gS292mlkMPNiQmyI4G5syXFrNy7tqzPqkrF3iECg70k6ryzUrMuj0M4eUtV0sihF3vuzlHaSXCMivUiTk/oF8HK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(36756003)(44832011)(8936002)(5660300002)(47076005)(40460700003)(2906002)(81166007)(70206006)(70586007)(356005)(8676002)(86362001)(508600001)(2616005)(82310400005)(1076003)(54906003)(36860700001)(4326008)(316002)(6916009)(186003)(336012)(426003)(16526019)(26005)(7696005)(6666004)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:25.1053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2080abe-6303-4ff1-dee4-08da4b234361
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5532
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why & how]
Fix format and typo of comments.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
---
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  1 -
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  8 ++++++--
 .../dc/gpio/dcn20/hw_translate_dcn20.c        | 17 ++++++++++-------
 .../dc/gpio/dcn21/hw_translate_dcn21.c        | 17 ++++++++++-------
 .../dc/gpio/dcn30/hw_translate_dcn30.c        | 19 +++++++++++--------
 5 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index cac80ba69072..fb82e9f9738e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -436,7 +436,6 @@ void dcn2_read_clocks_from_hw_dentist(struct clk_mgr *clk_mgr_base)
 		clk_mgr_base->clks.dppclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 				* clk_mgr->base.dentist_vco_freq_khz) / dpp_divider;
 	}
-
 }
 
 void dcn2_get_clock(struct clk_mgr *clk_mgr,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 7884530cc02b..199868925fe4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1379,7 +1379,9 @@ bool dc_link_get_hpd_state(struct dc_link *dc_link)
 static enum hpd_source_id get_hpd_line(struct dc_link *link)
 {
 	struct gpio *hpd;
-	enum hpd_source_id hpd_id = HPD_SOURCEID_UNKNOWN;
+	enum hpd_source_id hpd_id;
+
+	hpd_id = HPD_SOURCEID_UNKNOWN;
 
 	hpd = get_hpd_gpio(link->ctx->dc_bios, link->link_id,
 			   link->ctx->gpio_service);
@@ -1418,7 +1420,9 @@ static enum hpd_source_id get_hpd_line(struct dc_link *link)
 static enum channel_id get_ddc_line(struct dc_link *link)
 {
 	struct ddc *ddc;
-	enum channel_id channel = CHANNEL_ID_UNKNOWN;
+	enum channel_id channel;
+
+	channel = CHANNEL_ID_UNKNOWN;
 
 	ddc = dal_ddc_service_get_ddc_pin(link->ddc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_translate_dcn20.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_translate_dcn20.c
index 52ba62b3b5e4..3005ee7751a0 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_translate_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_translate_dcn20.c
@@ -150,7 +150,8 @@ static bool offset_to_id(
 	/* DDC */
 	/* we don't care about the GPIO_ID for DDC
 	 * in DdcHandle it will use GPIO_ID_DDC_DATA/GPIO_ID_DDC_CLOCK
-	 * directly in the create method */
+	 * directly in the create method
+	 */
 	case REG(DC_GPIO_DDC1_A):
 		*en = GPIO_DDC_LINE_DDC1;
 		return true;
@@ -173,14 +174,16 @@ static bool offset_to_id(
 		*en = GPIO_DDC_LINE_DDC_VGA;
 		return true;
 
-//	case REG(DC_GPIO_I2CPAD_A): not exit
-//	case REG(DC_GPIO_PWRSEQ_A):
-//	case REG(DC_GPIO_PAD_STRENGTH_1):
-//	case REG(DC_GPIO_PAD_STRENGTH_2):
-//	case REG(DC_GPIO_DEBUG):
+/*
+ *	case REG(DC_GPIO_I2CPAD_A): not exit
+ *	case REG(DC_GPIO_PWRSEQ_A):
+ *	case REG(DC_GPIO_PAD_STRENGTH_1):
+ *	case REG(DC_GPIO_PAD_STRENGTH_2):
+ *	case REG(DC_GPIO_DEBUG):
+ */
 	/* UNEXPECTED */
 	default:
-//	case REG(DC_GPIO_SYNCA_A): not exist
+/*	case REG(DC_GPIO_SYNCA_A): not exist */
 		ASSERT_CRITICAL(false);
 		return false;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c
index 291966efe63d..d734e3a134d1 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c
@@ -153,7 +153,8 @@ static bool offset_to_id(
 	/* DDC */
 	/* we don't care about the GPIO_ID for DDC
 	 * in DdcHandle it will use GPIO_ID_DDC_DATA/GPIO_ID_DDC_CLOCK
-	 * directly in the create method */
+	 * directly in the create method
+	 */
 	case REG(DC_GPIO_DDC1_A):
 		*en = GPIO_DDC_LINE_DDC1;
 		return true;
@@ -173,14 +174,16 @@ static bool offset_to_id(
 		*en = GPIO_DDC_LINE_DDC_VGA;
 		return true;
 
-//	case REG(DC_GPIO_I2CPAD_A): not exit
-//	case REG(DC_GPIO_PWRSEQ_A):
-//	case REG(DC_GPIO_PAD_STRENGTH_1):
-//	case REG(DC_GPIO_PAD_STRENGTH_2):
-//	case REG(DC_GPIO_DEBUG):
+/*
+ *	case REG(DC_GPIO_I2CPAD_A): not exit
+ *	case REG(DC_GPIO_PWRSEQ_A):
+ *	case REG(DC_GPIO_PAD_STRENGTH_1):
+ *	case REG(DC_GPIO_PAD_STRENGTH_2):
+ *	case REG(DC_GPIO_DEBUG):
+ */
 	/* UNEXPECTED */
 	default:
-//	case REG(DC_GPIO_SYNCA_A): not exist
+/*	case REG(DC_GPIO_SYNCA_A): not exista */
 #ifdef PALLADIUM_SUPPORTED
 		*id = GPIO_ID_HPD;
 		*en = GPIO_DDC_LINE_DDC1;
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
index 3169c567475f..49d6250037a9 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
@@ -155,7 +155,8 @@ static bool offset_to_id(
 	/* DDC */
 	/* we don't care about the GPIO_ID for DDC
 	 * in DdcHandle it will use GPIO_ID_DDC_DATA/GPIO_ID_DDC_CLOCK
-	 * directly in the create method */
+	 * directly in the create method
+	 */
 	case REG(DC_GPIO_DDC1_A):
 		*en = GPIO_DDC_LINE_DDC1;
 		return true;
@@ -178,14 +179,16 @@ static bool offset_to_id(
 		*en = GPIO_DDC_LINE_DDC_VGA;
 		return true;
 
-//	case REG(DC_GPIO_I2CPAD_A): not exit
-//	case REG(DC_GPIO_PWRSEQ_A):
-//	case REG(DC_GPIO_PAD_STRENGTH_1):
-//	case REG(DC_GPIO_PAD_STRENGTH_2):
-//	case REG(DC_GPIO_DEBUG):
+/*
+ *	case REG(DC_GPIO_I2CPAD_A): not exit
+ *	case REG(DC_GPIO_PWRSEQ_A):
+ *	case REG(DC_GPIO_PAD_STRENGTH_1):
+ *	case REG(DC_GPIO_PAD_STRENGTH_2):
+ *	case REG(DC_GPIO_DEBUG):
+ */
 	/* UNEXPECTED */
 	default:
-//	case REG(DC_GPIO_SYNCA_A): not exist
+/*	case REG(DC_GPIO_SYNCA_A): not exist */
 		ASSERT_CRITICAL(false);
 		return false;
 	}
@@ -369,7 +372,7 @@ static const struct hw_translate_funcs funcs = {
 };
 
 /*
- * dal_hw_translate_dcn10_init
+ * dal_hw_translate_dcn30_init
  *
  * @brief
  * Initialize Hw translate function pointers.
-- 
2.36.1

