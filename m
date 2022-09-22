Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A13C32771
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B2F710E9EC;
	Thu, 22 Sep 2022 00:18:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED9410E9EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhAbqLas2rhBAWwsNvMBJxpsBOgD9S0miUyff3g83I0p+YC3e0Kr4AUBMh21bQe2gaBykA4eMfGsF3bBPXtDCyvv6SQfKiyn3W9MELduFUYdcWWJPFWrNgydgnxfLReGyRxmFCF7yazl4VNCugb3r4DSV6p3tFO+Y8Kh/sOWt18INd7cXDQ7Uk1Sc73eEq9cuPeAIMawMdM3xLIO8N3/u3GKxTWRsRnc1kjcu3fktDdYnDP/eTYksUGyTOjkN/x4XWUOnDE+9bBb7AqrwMqBj4J/QBeXum3n5Te/Jd4rcgYpzwWvP2Y3G2L/QjjbizHBxPFQ9uOuMSArw32cX5suPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/C/M2Z7V5ro//YxIjq2IKMBOdPEsBvybxPV0oK6PSk=;
 b=NY73Tp484JVdu6ByqXbiaXNLcZgL4+kZEmd3jfv0tWx/nkrfBP28ubIeT2XOqk+7fZyrWXt2rAeu6TK8RDuADr49luaCMQSkt7+nQb5Mx6LuV7+7+KkDZWiDzNpnXPhDMUWZcyxGSRwivOplMmuLjH4MX9gjtuYV9kiotWzeKdGPeeWiv8Y2wfui8wEAVRruU+2EIWNxqvWRCDT07vAZoaXo/g7/DDfKZNx8IL3rkSwB6Gp6Cv9m8uKh9msX19ZpWp3glFxWczwCdo5Kg0mx7BfvH9M7Le/uIuiikfeZNK/jYhT4mDOix9Tt42poofX72z0Cf3kEOZGTe+tGzg8XHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/C/M2Z7V5ro//YxIjq2IKMBOdPEsBvybxPV0oK6PSk=;
 b=afDek1Q5woKiWDHrPyB1JwFP+okuPb0HJPT+sT+4FteFz2Y283pzMLyicH3Xng4Anz9FzAasX1Cw8DXsYOf+5DvuWdf3/uFa0Dw8Eatetun5wkjNFwoWEH3ZKXFdL6B17NbfeJnGW8x3peBY4VlDmnhmk+1ecAc1msp0AXynkGY=
Received: from BN9PR03CA0568.namprd03.prod.outlook.com (2603:10b6:408:138::33)
 by CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Thu, 22 Sep
 2022 00:18:50 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::cf) by BN9PR03CA0568.outlook.office365.com
 (2603:10b6:408:138::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 00:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:18:49 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:18:48 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/31] drm/amd/display: Avoid avoid unnecessary pixel rate
 divider programming
Date: Wed, 21 Sep 2022 20:17:55 -0400
Message-ID: <20220922001821.320255-6-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT061:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ba9e32-067e-4705-0f0e-08da9c3005fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFFcxvkkuZhcBYq2KMQApSkC+OydlxnHiKUOTdk4nQB9s0+WDuc/QUBXX/XtijtS+0bHDYD3HACDmqGMYbAM4Nx8XkV1dERiCHk55Vm4E5ZEY91GAajMMWysyiEn/FzZlrmCqie4FnrGB2pxZUFRVGuKBOff3yOlpqjVT+VkOCOX9PfL30H1ii8bUlvMkXnB0f1uDnvcgLFEKzgpxPNuVW2yIqQ5YOOzusllvA/6TVg53rIl8r+tiDQ2XHknFN4JKpW+BW7CxVAvGq1aPMn5bFihR6uiVAG+PegqvimVvUGMlRG71iI0X5jYxPpLbKSIFgI6DVHyUqDIwWi/StOl7aTAwbO0IZ/PEL5YC6KXMNxX9Jhkb/nRxC/MWMW9KpIwn+CJEhdI4MpOXoN9cd6Y9ZUFAgswBLndvHGBFEvF001B+KaqBsm4x/SGb77N6Yk0beFXkLODdmjv2Ul5frWQQys60TDB8NWK8+SdUzcVssAJxQvIeEw65XnXqnmCBJNtComFPl8yvX3s7XPBF28x31mugalVl+SW5NBDtWpwM3yNyhya2+byvNvzs3YBo2v/w8dqa2PYE9Ta9a/w1nO84d3l2IZVvP3RweRdWTDqErU2NwkqqW/tO4ON9oUp15zVCqjSwBncxAZpid5oOOpe2I4g//+39fpkKka8q5Z9HMK2idwzs8H0smhanGVcg2sYbP1xYAVyez1Ycy0NdoAJkOtFgR3rcFA79FDF4iz6hxlhNzhC2ZRusY/BvdOKIfxCxBldQQYKj+2a5zHcbdJ402wP48DwX/ymf4yeFkVE9R8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(8936002)(316002)(36756003)(47076005)(36860700001)(478600001)(6916009)(6666004)(82310400005)(26005)(82740400003)(2906002)(40480700001)(54906003)(5660300002)(1076003)(4326008)(40460700003)(70206006)(2616005)(16526019)(81166007)(426003)(8676002)(336012)(41300700001)(356005)(70586007)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:18:49.8489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ba9e32-067e-4705-0f0e-08da9c3005fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why]
Programming pixel rate divider when FIFO is enabled can cause FIFO error.

[How]
Skip divider programming when divider values are the same to prevent FIFO
error.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 36630d532c18..171e1580291a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -45,6 +45,48 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
+static void dccg314_get_pixel_rate_div(
+		struct dccg *dccg,
+		uint32_t otg_inst,
+		enum pixel_rate_div *k1,
+		enum pixel_rate_div *k2)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	uint32_t val_k1 = PIXEL_RATE_DIV_NA, val_k2 = PIXEL_RATE_DIV_NA;
+
+	*k1 = PIXEL_RATE_DIV_NA;
+	*k2 = PIXEL_RATE_DIV_NA;
+
+	switch (otg_inst) {
+	case 0:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG0_PIXEL_RATE_DIVK1, &val_k1,
+			OTG0_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	case 1:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG1_PIXEL_RATE_DIVK1, &val_k1,
+			OTG1_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	case 2:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG2_PIXEL_RATE_DIVK1, &val_k1,
+			OTG2_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	case 3:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG3_PIXEL_RATE_DIVK1, &val_k1,
+			OTG3_PIXEL_RATE_DIVK2, &val_k1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	*k1 = (enum pixel_rate_div)val_k1;
+	*k2 = (enum pixel_rate_div)val_k2;
+}
+
 static void dccg314_set_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
@@ -52,6 +94,11 @@ static void dccg314_set_pixel_rate_div(
 		enum pixel_rate_div k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
+
+	dccg314_get_pixel_rate_div(dccg, otg_inst, &cur_k1, &cur_k2);
+	if (k1 == PIXEL_RATE_DIV_NA || k2 == PIXEL_RATE_DIV_NA || (k1 == cur_k1 && k2 == cur_k2))
+		return;
 
 	switch (otg_inst) {
 	case 0:
-- 
2.25.1

