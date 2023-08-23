Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC64EE49B8
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA5310E45B;
	Wed, 23 Aug 2023 15:52:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C3F10E444
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdCXhDhJ1dUJjOWPgnKX+EKsLmPng6wISndLH0sn3iwYPEMvg3GGjI+AXQoG8BC8L/H2beMeu8fKpjKHT6SA2hkmlgzcVYl/niMzoRnsaCGwf+VhBclNBRxaOQfVuMJ5a3AgEOWVY8i3RuL8Uc2nDtvMOt+pdqgLGlPnqKIuxNZPw2/6Dg9X63ElUPmP/2d/8nQ8x24eal/FZNZ89kFQmgQAqskNogOGfkPy4rPtrYcrg2w3sgXfjkL/jJlhISB0LUw7TPZWflkyybYSaVbXHDqFpW5sFzvrTi+Ksb2IZxhX+tCImQjui3ZN5VS+gKO9elec4j8uG3wnW98YBw32GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PSvkaZ2OWPvTMv6rfZD7i8xxTWpGiBu9QwnLdpnSmk=;
 b=P1dIYQAUp+yq9JHoPLbgbGAfYrmJ/f6CXwcgXXgKM02tlDIG9ySAkZ0CucNE0Jc5sACo37XKqggaXnyl6oul35IbxNg8GMJK9ALW6+aqEkuH6WoDYYPERAHPAqWW6ZJ9DjBwFlmmKBVVBuIuBjf6sfnW9rk4i2enHv3ta7bbe29rAeYgp95KE2MDxoRF4TzQk33TytE49/yBWH3kbRA757My02fxfDig2Sc3qU+A+cmb1YRAxFZeOAZg7lLIuiqo1eSoQde/NUnNcTl6EcfduCK+IZg0y7/uS7tk+jc9VZ77oHkQFv3DKCVUuNys0kITxNkrsGSKDk6Seo8xHmYERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PSvkaZ2OWPvTMv6rfZD7i8xxTWpGiBu9QwnLdpnSmk=;
 b=yt9L1gGpZCSJCYi36mc5KrllxaVi2A5jdi7wJgZ12Sh+GIAOHrGdiiWESl+fBJv9TBX4KkGXxYAZKLf+g/p8ooYIAjuo9it7C/z9e3w7qice0GHBng1NncU34zk4vb/hTPyhdjv++u1uJNVfHqhskBfiH95rMyqnhWBpcImoHd8=
Received: from CY5PR18CA0039.namprd18.prod.outlook.com (2603:10b6:930:13::28)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:25 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::55) by CY5PR18CA0039.outlook.office365.com
 (2603:10b6:930:13::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/35] drm/amd/display: Add DCN35 IRQ
Date: Wed, 23 Aug 2023 11:50:40 -0400
Message-ID: <20230823155048.2526343-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc99af2-a9a0-4bfd-d48c-08dba3f0ceb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dAYOBFpphpErGpXQ40d/Zb2wwraxGgYNRo0wLPtBu+Jdnu2h/e/3eV6IZjGtpKqqYrxxSkIrNvQc36cthm+xQnGbQX5GlPL7MVBZFt139TQetkNbbxmyg7HdKboRdpQNyebjzbDUWoc1mLuCwzxdH6p41HY0Qp6uQ38xTXeIFPeWqRzosgn8ERWnH6T9lCgpLIhdUX6C1Ikdwq2O9IJkIIIbKXucZOrQ4C6jyALKR1L4Fb99fsin0vStyXt0U7Kd4mco26Q9okZQLkxk7cWKd8CKtL7b0o+CY2xMpgocVMn6Yooq376WILULeuPaKfIXBTXNPxCAyw2laQe0gPS2aXXH4ETt7f4fEKso7KZMjWJE40olqhzSXomnA1TNOsyRBrYDI6EB2GGP1eczyc0jxRd467FxKG8ruwBo5jf4Yh09LJWw79bFsZVtdP/sRGU1b0CpU7eUp4WqoheNDEWG5DhkxVaE4fCcENHncUPE4Hk+0CHd3Ekusd5FoB13geJgmx5Rq/BMjDSTALBI/pvBwZcrtRiZngLcEDMnwM96joGmhcb+/s75ruH1ORVrWgJuzuvU3gUzqysrq7HJfWrNK6a3bf72ROUUtJXmpITt7UGHl1F35oSQoDhf7QMbmNuSzeADyXeIU8jb9vPXjRGD1ZfBAr776u29BSqN5rhpVD+A++jaAVZoGatgDg2kb6bDrDSSCpVyeyTun420fBm+c7QABDgRNj0k/mLpEws+whuNcOdCiQc747rIv2mL6X2yQDWLtg8wkBPIXFI4/y7Duw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(66899024)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(30864003)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(26005)(16526019)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:25.7727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc99af2-a9a0-4bfd-d48c-08dba3f0ceb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
- Add IRQ handling for DCN35
- Update IRQ files for other DCNs in accordance
  to change in irq_service.h

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |   9 +
 .../dc/irq/dce110/irq_service_dce110.c        |  12 +-
 .../dc/irq/dce120/irq_service_dce120.c        |  12 +-
 .../display/dc/irq/dce60/irq_service_dce60.c  |  12 +-
 .../display/dc/irq/dce80/irq_service_dce80.c  |  12 +-
 .../display/dc/irq/dcn10/irq_service_dcn10.c  |  14 +-
 .../display/dc/irq/dcn20/irq_service_dcn20.c  |  14 +-
 .../dc/irq/dcn201/irq_service_dcn201.c        |  14 +-
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  16 +-
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |  16 +-
 .../dc/irq/dcn302/irq_service_dcn302.c        |  16 +-
 .../dc/irq/dcn303/irq_service_dcn303.c        |  14 +-
 .../display/dc/irq/dcn31/irq_service_dcn31.c  |  16 +-
 .../dc/irq/dcn314/irq_service_dcn314.c        |  16 +-
 .../dc/irq/dcn315/irq_service_dcn315.c        |  16 +-
 .../display/dc/irq/dcn32/irq_service_dcn32.c  |  16 +-
 .../display/dc/irq/dcn35/irq_service_dcn35.c  | 427 ++++++++++++++++++
 .../display/dc/irq/dcn35/irq_service_dcn35.h  |  34 ++
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |   2 +-
 19 files changed, 579 insertions(+), 109 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.h

diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index a0d86a154a98..076f667a82f6 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -162,3 +162,12 @@ IRQ_DCN32 = irq_service_dcn32.o
 AMD_DAL_IRQ_DCN32= $(addprefix $(AMDDALPATH)/dc/irq/dcn32/,$(IRQ_DCN32))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN32)
+
+###############################################################################
+# DCN 35
+###############################################################################
+IRQ_DCN35 = irq_service_dcn35.o
+
+AMD_DAL_IRQ_DCN35= $(addprefix $(AMDDALPATH)/dc/irq/dcn35/,$(IRQ_DCN35))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN35)
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
index 44649db5f3e3..1c0d89e675da 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
@@ -61,27 +61,27 @@ static bool hpd_ack(struct irq_service *irq_service,
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 	.set = NULL,
 	.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = dce110_vblank_set,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vupdate_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -225,7 +225,7 @@ bool dce110_vblank_set(struct irq_service *irq_service,
 	return true;
 }
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	.set = dal_irq_service_dummy_set,
 	.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c b/drivers/gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c
index 0a5e1a2a3c61..953f4a4dacad 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c
@@ -64,27 +64,27 @@ static bool hpd_ack(
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 	.set = NULL,
 	.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = dce110_vblank_set,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vupdate_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -174,7 +174,7 @@ static const struct irq_source_info_funcs vupdate_irq_info_funcs = {
 #define dc_underflow_int_entry(reg_num) \
 	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	.set = dal_irq_service_dummy_set,
 	.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dce60.c b/drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dce60.c
index 524481885fd0..2c72074310c7 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dce60.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dce60.c
@@ -73,27 +73,27 @@ static bool hpd_ack(
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 	.set = NULL,
 	.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = dce110_vblank_set,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs_dce60 = {
+static struct irq_source_info_funcs vblank_irq_info_funcs_dce60 = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -192,7 +192,7 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs_dce60 = {
 	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	.set = dal_irq_service_dummy_set,
 	.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c b/drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c
index 85f63b4a8b90..49317934ef4f 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c
@@ -64,27 +64,27 @@ static bool hpd_ack(
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 	.set = NULL,
 	.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = dce110_vblank_set,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vupdate_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -184,7 +184,7 @@ static const struct irq_source_info_funcs vupdate_irq_info_funcs = {
 	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	.set = dal_irq_service_dummy_set,
 	.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
index 532e506d027b..9ca28565a9d1 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
@@ -156,32 +156,32 @@ static bool hpd_ack(
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 	.set = NULL,
 	.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -280,7 +280,7 @@ static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 #define dc_underflow_int_entry(reg_num) \
 	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	.set = dal_irq_service_dummy_set,
 	.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
index 93c31111500b..e8baafa02443 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
@@ -159,32 +159,32 @@ static bool hpd_ack(
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 	.set = NULL,
 	.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -287,7 +287,7 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 #define dc_underflow_int_entry(reg_num) \
 	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	.set = dal_irq_service_dummy_set,
 	.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
index 3c7cb3dc046b..5171d04519ee 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
@@ -107,31 +107,31 @@ static bool hpd_ack(
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 	.set = NULL,
 	.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
-static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -239,7 +239,7 @@ static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 #define dc_underflow_int_entry(reg_num) \
 	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	.set = dal_irq_service_dummy_set,
 	.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 717977aec6d0..03c5e8ff8cbd 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -161,37 +161,37 @@ static bool hpd_ack(
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 	.set = NULL,
 	.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs dmub_outbox_irq_info_funcs = {
+static struct irq_source_info_funcs dmub_outbox_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -316,7 +316,7 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 #define dc_underflow_int_entry(reg_num) \
 	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	.set = dal_irq_service_dummy_set,
 	.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index 2aa74ee1502a..a443a8abb1ea 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -166,37 +166,37 @@ static bool hpd_ack(
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 	.set = NULL,
 	.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs dmub_trace_irq_info_funcs = {
+static struct irq_source_info_funcs dmub_trace_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -321,7 +321,7 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 #define dc_underflow_int_entry(reg_num) \
 	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	.set = dal_irq_service_dummy_set,
 	.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
index 40fd34fb1d5e..8ffc7e2c681a 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
@@ -143,37 +143,37 @@ static bool hpd_ack(struct irq_service *irq_service, const struct irq_source_inf
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 		.set = NULL,
 		.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 		.set = NULL,
 		.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 		.set = NULL,
 		.ack = NULL
 };
 
-static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 		.set = NULL,
 		.ack = NULL
 };
 
-static const struct irq_source_info_funcs dmub_trace_irq_info_funcs = {
+static struct irq_source_info_funcs dmub_trace_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -290,7 +290,7 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 #define dc_underflow_int_entry(reg_num) \
 		[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 		.set = dal_irq_service_dummy_set,
 		.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
index 1d149d290147..e09ca4594ec3 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
@@ -75,32 +75,32 @@ static bool hpd_ack(struct irq_service *irq_service, const struct irq_source_inf
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 		.set = NULL,
 		.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 		.set = NULL,
 		.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 		.set = NULL,
 		.ack = NULL
 };
 
-static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 		.set = NULL,
 		.ack = NULL
 };
 
-static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -195,7 +195,7 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 #define dc_underflow_int_entry(reg_num) \
 		[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 		.set = dal_irq_service_dummy_set,
 		.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c b/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
index 1b88e4e627fd..53e78ae7eecf 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
@@ -155,37 +155,37 @@ static bool hpd_ack(
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 	.set = NULL,
 	.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs outbox_irq_info_funcs = {
+static struct irq_source_info_funcs outbox_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -309,7 +309,7 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 #define dc_underflow_int_entry(reg_num) \
 	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	.set = dal_irq_service_dummy_set,
 	.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
index 37bc98faa7a0..e0563e880432 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
@@ -157,37 +157,37 @@ static bool hpd_ack(
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 	.set = NULL,
 	.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs outbox_irq_info_funcs = {
+static struct irq_source_info_funcs outbox_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -311,7 +311,7 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 #define dc_underflow_int_entry(reg_num) \
 	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	.set = dal_irq_service_dummy_set,
 	.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
index e722171f0d2d..2ef22299101a 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
@@ -162,37 +162,37 @@ static bool hpd_ack(
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 	.set = NULL,
 	.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs outbox_irq_info_funcs = {
+static struct irq_source_info_funcs outbox_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -316,7 +316,7 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 #define dc_underflow_int_entry(reg_num) \
 	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	.set = dal_irq_service_dummy_set,
 	.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
index b1012fa1977b..f0ac0aeeac51 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
@@ -156,37 +156,37 @@ static bool hpd_ack(
 	return true;
 }
 
-static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_irq_info_funcs  = {
 	.set = NULL,
 	.ack = hpd_ack
 };
 
-static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs outbox_irq_info_funcs = {
+static struct irq_source_info_funcs outbox_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -310,7 +310,7 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 #define dc_underflow_int_entry(reg_num) \
 	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
-static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	.set = dal_irq_service_dummy_set,
 	.ack = dal_irq_service_dummy_ack
 };
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c b/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
new file mode 100644
index 000000000000..ea8c271171bc
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
@@ -0,0 +1,427 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dm_services.h"
+#include "include/logger_interface.h"
+#include "../dce110/irq_service_dce110.h"
+
+#include "dcn/dcn_3_5_0_offset.h"
+#include "dcn/dcn_3_5_0_sh_mask.h"
+
+#include "irq_service_dcn35.h"
+
+#include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
+
+static enum dc_irq_source to_dal_irq_source_dcn35(
+		struct irq_service *irq_service,
+		uint32_t src_id,
+		uint32_t ext_id)
+{
+	switch (src_id) {
+	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK1;
+	case DCN_1_0__SRCID__DC_D2_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK2;
+	case DCN_1_0__SRCID__DC_D3_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK3;
+	case DCN_1_0__SRCID__DC_D4_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK4;
+	case DCN_1_0__SRCID__DC_D5_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK5;
+	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK6;
+	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC1_VLINE0;
+	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC2_VLINE0;
+	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC3_VLINE0;
+	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC4_VLINE0;
+	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC5_VLINE0;
+	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC6_VLINE0;
+	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP1;
+	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP2;
+	case DCN_1_0__SRCID__HUBP2_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP3;
+	case DCN_1_0__SRCID__HUBP3_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP4;
+	case DCN_1_0__SRCID__HUBP4_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP5;
+	case DCN_1_0__SRCID__HUBP5_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP6;
+	case DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE1;
+	case DCN_1_0__SRCID__OTG1_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE2;
+	case DCN_1_0__SRCID__OTG2_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE3;
+	case DCN_1_0__SRCID__OTG3_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE4;
+	case DCN_1_0__SRCID__OTG4_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE5;
+	case DCN_1_0__SRCID__OTG5_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE6;
+	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
+		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
+	case DCN_1_0__SRCID__DC_HPD1_INT:
+		/* generic src_id for all HPD and HPDRX interrupts */
+		switch (ext_id) {
+		case DCN_1_0__CTXID__DC_HPD1_INT:
+			return DC_IRQ_SOURCE_HPD1;
+		case DCN_1_0__CTXID__DC_HPD2_INT:
+			return DC_IRQ_SOURCE_HPD2;
+		case DCN_1_0__CTXID__DC_HPD3_INT:
+			return DC_IRQ_SOURCE_HPD3;
+		case DCN_1_0__CTXID__DC_HPD4_INT:
+			return DC_IRQ_SOURCE_HPD4;
+		case DCN_1_0__CTXID__DC_HPD5_INT:
+			return DC_IRQ_SOURCE_HPD5;
+		case DCN_1_0__CTXID__DC_HPD6_INT:
+			return DC_IRQ_SOURCE_HPD6;
+		case DCN_1_0__CTXID__DC_HPD1_RX_INT:
+			return DC_IRQ_SOURCE_HPD1RX;
+		case DCN_1_0__CTXID__DC_HPD2_RX_INT:
+			return DC_IRQ_SOURCE_HPD2RX;
+		case DCN_1_0__CTXID__DC_HPD3_RX_INT:
+			return DC_IRQ_SOURCE_HPD3RX;
+		case DCN_1_0__CTXID__DC_HPD4_RX_INT:
+			return DC_IRQ_SOURCE_HPD4RX;
+		case DCN_1_0__CTXID__DC_HPD5_RX_INT:
+			return DC_IRQ_SOURCE_HPD5RX;
+		case DCN_1_0__CTXID__DC_HPD6_RX_INT:
+			return DC_IRQ_SOURCE_HPD6RX;
+		default:
+			return DC_IRQ_SOURCE_INVALID;
+		}
+		break;
+
+	default:
+		return DC_IRQ_SOURCE_INVALID;
+	}
+}
+
+static bool hpd_ack(
+	struct irq_service *irq_service,
+	const struct irq_source_info *info)
+{
+	uint32_t addr = info->status_reg;
+	uint32_t value = dm_read_reg(irq_service->ctx, addr);
+	uint32_t current_status =
+		get_reg_field_value(
+			value,
+			HPD0_DC_HPD_INT_STATUS,
+			DC_HPD_SENSE_DELAYED);
+
+	dal_irq_service_ack_generic(irq_service, info);
+
+	value = dm_read_reg(irq_service->ctx, info->enable_reg);
+
+	set_reg_field_value(
+		value,
+		current_status ? 0 : 1,
+		HPD0_DC_HPD_INT_CONTROL,
+		DC_HPD_INT_POLARITY);
+
+	dm_write_reg(irq_service->ctx, info->enable_reg, value);
+
+	return true;
+}
+
+static struct irq_source_info_funcs hpd_irq_info_funcs = {
+	.set = NULL,
+	.ack = hpd_ack
+};
+
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs outbox_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+#undef BASE_INNER
+#define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
+
+/* compile time expand base address. */
+#define BASE(seg) \
+	BASE_INNER(seg)
+
+#define SRI(reg_name, block, id)\
+	BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+			reg ## block ## id ## _ ## reg_name
+
+#define SRI_DMUB(reg_name)\
+	BASE(reg ## reg_name ## _BASE_IDX) + \
+			reg ## reg_name
+
+#define IRQ_REG_ENTRY(base, block, reg_num, reg1, mask1, reg2, mask2)\
+	REG_STRUCT[base + reg_num].enable_reg = SRI(reg1, block, reg_num),\
+	REG_STRUCT[base + reg_num].enable_mask = \
+		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
+	REG_STRUCT[base + reg_num].enable_value[0] = \
+		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
+	REG_STRUCT[base + reg_num].enable_value[1] = \
+		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK, \
+	REG_STRUCT[base + reg_num].ack_reg = SRI(reg2, block, reg_num),\
+	REG_STRUCT[base + reg_num].ack_mask = \
+		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK,\
+	REG_STRUCT[base + reg_num].ack_value = \
+		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK \
+
+#define IRQ_REG_ENTRY_DMUB(base, reg1, mask1, reg2, mask2)\
+	REG_STRUCT[base].enable_reg = SRI_DMUB(reg1),\
+	REG_STRUCT[base].enable_mask = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	REG_STRUCT[base].enable_value[0] = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	REG_STRUCT[base].enable_value[1] = \
+		~reg1 ## __ ## mask1 ## _MASK, \
+	REG_STRUCT[base].ack_reg = SRI_DMUB(reg2),\
+	REG_STRUCT[base].ack_mask = \
+		reg2 ## __ ## mask2 ## _MASK,\
+	REG_STRUCT[base].ack_value = \
+		reg2 ## __ ## mask2 ## _MASK \
+
+#define hpd_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_HPD1, HPD, reg_num,\
+			DC_HPD_INT_CONTROL, DC_HPD_INT_EN,\
+			DC_HPD_INT_CONTROL, DC_HPD_INT_ACK),\
+		REG_STRUCT[DC_IRQ_SOURCE_HPD1 + reg_num].funcs = &hpd_irq_info_funcs;\
+		REG_STRUCT[DC_IRQ_SOURCE_HPD1 + reg_num].status_reg = SRI(DC_HPD_INT_STATUS, HPD, reg_num);\
+
+#define hpd_rx_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_HPD1RX, HPD, reg_num,\
+			DC_HPD_INT_CONTROL, DC_HPD_RX_INT_EN,\
+			DC_HPD_INT_CONTROL, DC_HPD_RX_INT_ACK),\
+		REG_STRUCT[DC_IRQ_SOURCE_HPD1RX + reg_num].status_reg = SRI(DC_HPD_INT_STATUS, HPD, reg_num);\
+		REG_STRUCT[DC_IRQ_SOURCE_HPD1RX + reg_num].funcs = &hpd_rx_irq_info_funcs;\
+
+#define pflip_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_PFLIP1, HUBPREQ, reg_num,\
+			DCSURF_SURFACE_FLIP_INTERRUPT, SURFACE_FLIP_INT_MASK,\
+			DCSURF_SURFACE_FLIP_INTERRUPT, SURFACE_FLIP_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_PFLIP1 + reg_num].funcs = &pflip_irq_info_funcs\
+
+/* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match semantic
+ * of DCE's DC_IRQ_SOURCE_VUPDATEx.
+ */
+#define vupdate_no_lock_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_VUPDATE1, OTG, reg_num,\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_EVENT_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_VUPDATE1 + reg_num].funcs = &vupdate_no_lock_irq_info_funcs\
+
+#define vblank_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_VBLANK1, OTG, reg_num,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_EVENT_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_VBLANK1 + reg_num].funcs = &vblank_irq_info_funcs\
+
+#define vline0_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_DC1_VLINE0, OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num].funcs = &vline0_irq_info_funcs\
+
+#define dmub_outbox_int_entry()\
+		IRQ_REG_ENTRY_DMUB(DC_IRQ_SOURCE_DMCUB_OUTBOX, \
+			DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX1_READY_INT_EN,\
+			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX1_READY_INT_ACK),\
+		REG_STRUCT[DC_IRQ_SOURCE_DMCUB_OUTBOX].funcs = &outbox_irq_info_funcs
+
+#define dummy_irq_entry(irqno) \
+	REG_STRUCT[irqno].funcs = &dummy_irq_info_funcs\
+
+#define i2c_int_entry(reg_num) \
+	dummy_irq_entry(DC_IRQ_SOURCE_I2C_DDC ## reg_num)
+
+#define dp_sink_int_entry(reg_num) \
+	dummy_irq_entry(DC_IRQ_SOURCE_DPSINK ## reg_num)
+
+#define gpio_pad_int_entry(reg_num) \
+	dummy_irq_entry(DC_IRQ_SOURCE_GPIOPAD ## reg_num)
+
+#define dc_underflow_int_entry(reg_num) \
+	dummy_irq_entry(DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW)
+
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
+	.set = dal_irq_service_dummy_set,
+	.ack = dal_irq_service_dummy_ack
+};
+
+#define dcn35_irq_init_part_1() \
+	dummy_irq_entry(DC_IRQ_SOURCE_INVALID); \
+	hpd_int_entry(0); \
+	hpd_int_entry(1); \
+	hpd_int_entry(2); \
+	hpd_int_entry(3); \
+	hpd_int_entry(4); \
+	hpd_rx_int_entry(0); \
+	hpd_rx_int_entry(1); \
+	hpd_rx_int_entry(2); \
+	hpd_rx_int_entry(3); \
+	hpd_rx_int_entry(4); \
+	i2c_int_entry(1); \
+	i2c_int_entry(2); \
+	i2c_int_entry(3); \
+	i2c_int_entry(4); \
+	i2c_int_entry(5); \
+	i2c_int_entry(6); \
+	dp_sink_int_entry(1); \
+	dp_sink_int_entry(2); \
+	dp_sink_int_entry(3); \
+	dp_sink_int_entry(4); \
+	dp_sink_int_entry(5); \
+	dp_sink_int_entry(6); \
+	dummy_irq_entry(DC_IRQ_SOURCE_TIMER); \
+	pflip_int_entry(0); \
+	pflip_int_entry(1); \
+	pflip_int_entry(2); \
+	pflip_int_entry(3); \
+	dummy_irq_entry(DC_IRQ_SOURCE_PFLIP5); \
+	dummy_irq_entry(DC_IRQ_SOURCE_PFLIP6); \
+	dummy_irq_entry(DC_IRQ_SOURCE_PFLIP_UNDERLAY0); \
+	gpio_pad_int_entry(0); \
+	gpio_pad_int_entry(1); \
+	gpio_pad_int_entry(2); \
+	gpio_pad_int_entry(3); \
+	gpio_pad_int_entry(4); \
+	gpio_pad_int_entry(5); \
+	gpio_pad_int_entry(6); \
+	gpio_pad_int_entry(7); \
+	gpio_pad_int_entry(8); \
+	gpio_pad_int_entry(9); \
+	gpio_pad_int_entry(10); \
+	gpio_pad_int_entry(11); \
+	gpio_pad_int_entry(12); \
+	gpio_pad_int_entry(13); \
+	gpio_pad_int_entry(14); \
+	gpio_pad_int_entry(15); \
+	gpio_pad_int_entry(16); \
+	gpio_pad_int_entry(17); \
+	gpio_pad_int_entry(18); \
+	gpio_pad_int_entry(19); \
+	gpio_pad_int_entry(20); \
+	gpio_pad_int_entry(21); \
+	gpio_pad_int_entry(22); \
+	gpio_pad_int_entry(23); \
+	gpio_pad_int_entry(24); \
+	gpio_pad_int_entry(25); \
+	gpio_pad_int_entry(26); \
+	gpio_pad_int_entry(27); \
+	gpio_pad_int_entry(28); \
+	gpio_pad_int_entry(29); \
+	gpio_pad_int_entry(30); \
+	dc_underflow_int_entry(1); \
+	dc_underflow_int_entry(2); \
+	dc_underflow_int_entry(3); \
+	dc_underflow_int_entry(4); \
+	dc_underflow_int_entry(5); \
+	dc_underflow_int_entry(6); \
+	dummy_irq_entry(DC_IRQ_SOURCE_DMCU_SCP); \
+	dummy_irq_entry(DC_IRQ_SOURCE_VBIOS_SW); \
+
+#define dcn35_irq_init_part_2() \
+	vupdate_no_lock_int_entry(0); \
+	vupdate_no_lock_int_entry(1); \
+	vupdate_no_lock_int_entry(2); \
+	vupdate_no_lock_int_entry(3); \
+	vblank_int_entry(0); \
+	vblank_int_entry(1); \
+	vblank_int_entry(2); \
+	vblank_int_entry(3); \
+	vline0_int_entry(0); \
+	vline0_int_entry(1); \
+	vline0_int_entry(2); \
+	vline0_int_entry(3); \
+	dummy_irq_entry(DC_IRQ_SOURCE_DC5_VLINE1); \
+	dummy_irq_entry(DC_IRQ_SOURCE_DC6_VLINE1); \
+	dmub_outbox_int_entry()
+
+#define dcn35_irq_init() \
+	dcn35_irq_init_part_1(); \
+	dcn35_irq_init_part_2(); \
+
+static struct irq_source_info irq_source_info_dcn35[DAL_IRQ_SOURCES_NUMBER] = {0};
+
+static struct irq_service_funcs irq_service_funcs_dcn35 = {
+		.to_dal_irq_source = to_dal_irq_source_dcn35
+};
+
+static void dcn35_irq_construct(
+	struct irq_service *irq_service,
+	struct irq_service_init_data *init_data)
+{
+	struct dc_context *ctx = init_data->ctx;
+
+#define REG_STRUCT irq_source_info_dcn35
+	dcn35_irq_init();
+
+	dal_irq_service_construct(irq_service, init_data);
+
+	irq_service->info = irq_source_info_dcn35;
+	irq_service->funcs = &irq_service_funcs_dcn35;
+}
+
+struct irq_service *dal_irq_service_dcn35_create(
+	struct irq_service_init_data *init_data)
+{
+	struct irq_service *irq_service = kzalloc(sizeof(*irq_service),
+						  GFP_KERNEL);
+
+	if (!irq_service)
+		return NULL;
+
+	dcn35_irq_construct(irq_service, init_data);
+	return irq_service;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.h b/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.h
new file mode 100644
index 000000000000..bf71b1887d67
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DAL_IRQ_SERVICE_DCN35_H__
+#define __DAL_IRQ_SERVICE_DCN35_H__
+
+#include "../irq_service.h"
+
+struct irq_service *dal_irq_service_dcn35_create(
+	struct irq_service_init_data *init_data);
+
+#endif /* __DAL_IRQ_SERVICE_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
index dbfcb096eedd..b178f85944cd 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
@@ -53,7 +53,7 @@ struct irq_source_info {
 	uint32_t ack_mask;
 	uint32_t ack_value;
 	uint32_t status_reg;
-	const struct irq_source_info_funcs *funcs;
+	struct irq_source_info_funcs *funcs;
 };
 
 struct irq_service_funcs {
-- 
2.41.0

