Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C2DC43217
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB9010F2A7;
	Wed, 25 May 2022 16:20:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F3310E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5n1CX0bRwRxucO5UXZxpBywWMneiUSSlP6kaN+WDKpMQftlT02m/4uv+yXYnaUuJLcF6P+EM2Ohwi5dHYL8vf7D31Es3/2vIBwj2LYmzDP31KFfaW2B6Zbpz7gt+i6TIvkTtzUJyG0Ds3B+dQvKrw08h+TD8GtPRPPym6uZp+UcwdTFiVS7te/ATs+miHDJHtLAA5I9ldUkpep7ZW2+m+RBpKe2rjqymRv17sRdnK0XsMpYIv7Z2T56O5uw7sHwcEsxOVzj45OtvQkdLpTncAGzEINqSln+0xkhFQ2TMnrUuYuvFGrangBurA12W5JVM22zv9CJg+qxU0Gdspph+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FA3tcIgsTGWTW2eGG7lii9yYxNpl6JfKXH9/M6GSBQs=;
 b=WhY6yGl6nRJgujfvGP0XlAB1JTBaUbMDmcgjDknE9HLiU7PzuN8fIrHoE5lwkfvXhFc4kF/3Gl8/UooYDgMZTGDaiN8MAy2wgbeBnKLbS0Iw/UEdvzi3+p9pJoVZtJd+OhVmYxpRpakrr0EuZz3w/2DOMZEf1lI8+5nM/0J3dCGMEFUixj4YdDdEkK4YRoS5Bi/GLht/jSeHhPQgRyHMp2jdlRTRHvv0AG1DF5NduN6UffRAw2Ambe+latlxagKadHXaBdmdRK/kEaHdGkK9k2dsc2HqgQCQSTBLqwPYM+QJ8Bxkw0qX0IErxeIoEQThhkOPHvFy5p1ac2cUbhNpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FA3tcIgsTGWTW2eGG7lii9yYxNpl6JfKXH9/M6GSBQs=;
 b=oVaKcaN7uVaHvZE/+iCYxnPlixPh42mhchN6DmE161Nh/li+jCfZ2OV5DN27AcxK219XasHoQ7hJ8c1bmzp6bxkbGKnOrLFzoxpeJpZcQYox6oyG4ldgKVa1wQH4ggOYWIQjuYTC/CZoTr/mSbXUsEFSCUK095LYDEbpTazpg2w=
Received: from DS7PR05CA0096.namprd05.prod.outlook.com (2603:10b6:8:56::28) by
 BL0PR12MB4706.namprd12.prod.outlook.com (2603:10b6:208:82::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.19; Wed, 25 May 2022 16:20:15 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::f9) by DS7PR05CA0096.outlook.office365.com
 (2603:10b6:8:56::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/43] drm/amd/display: add missing interrupt handlers for
 DCN32/DCN321
Date: Wed, 25 May 2022 12:19:19 -0400
Message-ID: <20220525161941.2544055-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 839bcbcc-d61f-4cb6-7307-08da3e6a73be
X-MS-TrafficTypeDiagnostic: BL0PR12MB4706:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB47061B2AA14B9231F0255439F7D69@BL0PR12MB4706.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zsCN99iTFX+DYmTA6W+bhzeX/h9OHSNp+t8xnl8S9g/5V4z3ADrCGdsravzIOHWABQiZQXVo5Clz9kBBQCNdUShiGCm0c8ixmtqmszi0RVnkfyYzBWE6AZBrT7BN5te0eqchfdzLI53h5E4RdZvF65ofEp82pKj+WQE0B8gtw7YSNGONgZr2t3R2CzRPtXhiJm3y8CPJW+cz7jK0/C2RPczRBdoXEn05qfFvK1XMw4eec1vlNm54V1vvoOaic0773XSzu4xbWS0quCxYpikaIv+WtSIpzmfRjPNzdPdqX29HZ35iuPIHOYqnbh0o5Hkwj9WcDxMTGFKHBIlKxzGHJK1uATMoxxM6MQLdpiQT4Hs7Tc7b8SW2KDjLWzuL4Kp+1mSHVCRcaabp5OJ6s+jtXXfNjViJSqMLHtrnKiML5mzjXJ9bFaI2tfy4JLy/QIMRwzJrHZviHpqZGYldKUV0LXozByV1M8AApM41U0vvwdrNtTvD5mPlADTU1DGN2ZQsdatCk6uScAJrAACnRGz5U9c0smN5SJx2IWe9zWPkV6eBrN+wbdCpX/ikIYlgcyJGgrBM0gOf4KFrCgYW+POtzqQ8rp5l339yE/2K9EPJDxEVTcIJP6GovrPjMiwz50XkepciRGdkb45wpQ/ls0c/Xa6TjwXNHjHFbFxyFQ8ysWufhefiWTRIBr+HuQNgYMui9r/unoADNoTB4kR9+7SWng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400005)(36860700001)(81166007)(7696005)(8936002)(40460700003)(5660300002)(2906002)(86362001)(70206006)(508600001)(356005)(36756003)(54906003)(336012)(83380400001)(6916009)(26005)(8676002)(316002)(1076003)(4326008)(16526019)(47076005)(2616005)(186003)(426003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:15.4569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839bcbcc-d61f-4cb6-7307-08da3e6a73be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4706
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../display/dc/irq/dcn32/irq_service_dcn32.c  | 65 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
index 3f9d6531c563..3a213ca2f077 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
@@ -54,6 +54,18 @@ enum dc_irq_source to_dal_irq_source_dcn32(
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
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
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -78,7 +90,8 @@ enum dc_irq_source to_dal_irq_source_dcn32(
 		return DC_IRQ_SOURCE_VUPDATE5;
 	case DCN_1_0__SRCID__OTG5_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
 		return DC_IRQ_SOURCE_VUPDATE6;
-
+	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
+		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -168,6 +181,16 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.ack = NULL
 };
 
+static const struct irq_source_info_funcs outbox_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
@@ -179,6 +202,10 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 	BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 			reg ## block ## id ## _ ## reg_name
 
+#define SRI_DMUB(reg_name)\
+	BASE(reg ## reg_name ## _BASE_IDX) + \
+			reg ## reg_name
+
 #define IRQ_REG_ENTRY(block, reg_num, reg1, mask1, reg2, mask2)\
 	.enable_reg = SRI(reg1, block, reg_num),\
 	.enable_mask = \
@@ -193,6 +220,20 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.ack_value = \
 		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK \
 
+#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\
+	.enable_reg = SRI_DMUB(reg1),\
+	.enable_mask = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	.enable_value = {\
+		reg1 ## __ ## mask1 ## _MASK,\
+		~reg1 ## __ ## mask1 ## _MASK \
+	},\
+	.ack_reg = SRI_DMUB(reg2),\
+	.ack_mask = \
+		reg2 ## __ ## mask2 ## _MASK,\
+	.ack_value = \
+		reg2 ## __ ## mask2 ## _MASK \
+
 #define hpd_int_entry(reg_num)\
 	[DC_IRQ_SOURCE_HPD1 + reg_num] = {\
 		IRQ_REG_ENTRY(HPD, reg_num,\
@@ -237,6 +278,21 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 		.funcs = &vblank_irq_info_funcs\
 }
 
+#define vline0_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
+		.funcs = &vline0_irq_info_funcs\
+	}
+#define dmub_outbox_int_entry()\
+	[DC_IRQ_SOURCE_DMCUB_OUTBOX] = {\
+		IRQ_REG_ENTRY_DMUB(\
+			DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX1_READY_INT_EN,\
+			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX1_READY_INT_ACK),\
+		.funcs = &outbox_irq_info_funcs\
+	}
+
 #define dummy_irq_entry() \
 	{\
 		.funcs = &dummy_irq_info_funcs\
@@ -339,6 +395,13 @@ irq_source_info_dcn32[DAL_IRQ_SOURCES_NUMBER] = {
 	vblank_int_entry(1),
 	vblank_int_entry(2),
 	vblank_int_entry(3),
+	vline0_int_entry(0),
+	vline0_int_entry(1),
+	vline0_int_entry(2),
+	vline0_int_entry(3),
+	[DC_IRQ_SOURCE_DC5_VLINE1] = dummy_irq_entry(),
+	[DC_IRQ_SOURCE_DC6_VLINE1] = dummy_irq_entry(),
+	dmub_outbox_int_entry(),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn32 = {
-- 
2.35.3

