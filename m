Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE49C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C386610E650;
	Fri, 17 Dec 2021 21:24:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0CBD10E68D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVwH5qMUta8wQptf86vjMLhVHFGD9z9BONAut3/To+eKQK4csZtsbmJbDu//OK9vWhNLzZ2Nds62HtDitQuDrBzNn9ViY9vbTFaVt9MzhZAXXFBEdPTUCw6x+Aakean3KLtRaxRDbUr+sSbOfcinmVToy/qEmrhHZ7au8hW68T1xZNBvc1MbF9Urp0pjDoIHISAA4ODeQB/dlzywW+P6m8iJwpTSPfcC+umrsR4XxTM9m021H8auhhvItCQrcEEKlG8slGRS73zKPVMgqhd5gagkcbnMq4xRWaXzIFYZahazjokBPaJ6NKPeqomqPX/3hweeS06zIMKQ09SK20l35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5H6uYfKVs+oEvn3rCINkcG69STZ1JL8EukBhHe/ZOo=;
 b=WTHjPTOIb4mVaR4dWEwH7B42IoJcFJbpmWtkZtbtE2b6E+V0YDAAL1oGa0DCNwujiHrQvBLMm4eNzwQXTaUrfHLtxMkgJGYFsPFn97NEYsCgjLwcoQUKZJL0jrkKOQ8gKL/e7WnemG5ZNHPqIS/PEU2Rvp2Q1qEgH6oIOc8HedKC5mo+L+2I4bIrzpjsLEVWYPHgsQhePyc2Np9hS1dj/T3T/TO4eHw3FndueGh0/L+Xzi9Po0IucMCVx7yN3UIAdGD5djZ1LDGU0xWEwDTCaZaIZ7Kg6WAeJ0JPwm2SBiX493IbgoqPmIYVO5gY5Yitf5netmb2tKfV2/u29ZcK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5H6uYfKVs+oEvn3rCINkcG69STZ1JL8EukBhHe/ZOo=;
 b=xIQQv+gRy3ZWUfJOw8f4hI0LS6kPxkPo8+FS3EzJJtlgeP9mXMFgxEX06KntT/qUwcWXB94JtzojsqqpKR87mGE4gwEYuzgdh6VB6tOnJ+aTSRLbX6aa1m15wkTq3YsVA19e/25RqZFhOc0oNSPGI0OSP0D4RBcMq9w76Gi0O6w=
Received: from MW4PR04CA0249.namprd04.prod.outlook.com (2603:10b6:303:88::14)
 by CH0PR12MB5283.namprd12.prod.outlook.com (2603:10b6:610:d6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 21:24:36 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::55) by MW4PR04CA0249.outlook.office365.com
 (2603:10b6:303:88::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:36 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:34 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/19] drm/amd/display: Add reg defs for DCN303
Date: Fri, 17 Dec 2021 16:23:59 -0500
Message-ID: <20211217212407.3583190-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cbfbd4e-e5a7-48b7-475d-08d9c1a3a080
X-MS-TrafficTypeDiagnostic: CH0PR12MB5283:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5283F1E09230DF79863E54D998789@CH0PR12MB5283.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMxzJig1s/MNqtfoVIX8zkD2zsLqJSQQvUQt3KPJqkjW/ZSGpzkktBKF0Wsyeywz327bs7fTg/wx9d8r9Z7m/3foA0RxhTZO2WACsIYiH91v64E4c9mj+hPsAFHGEG8nwYAjP7FBIRQ+2A49TflCjG8xkgrEaOUC9lqejCDy0dcuh9122MEQ352CIubXZ7gwX7AON/iAZ5NhMCdIX2tWgSbMEdotxQ/QNlDEPzeEx1XmowlP7yJu2WTs/xjBKPkAUK0Vc5ssQhThtafghbxf8XLMwhAktZfxWrKn8RKJ9QIsq8fnk2J7EahxGphTjlXPEN05y+hd2TMkKnzY64z9jTN+tryN1Fl1o6IrrAVbT3yjx82xpJk1yLbbAkycbwakQmXlKDi9iXzv2oca24e5A+1MGCvgWduTvhcUKCT2Ajj7u5rV8cITPP5lLa2YAV7Dc4YlFy7W0vvZSiunn1UY3WxFZFufy6vfFLzJlcFJOEVcG9GflXk74dMQW6EgDz1t+BBIWQd0d2HS3RBtsnZWmljU/O6L4BTNrrHihy0cmxrW6PczXVqlzqNWZLehCwdupLa2fCj5gXOHs1BftMW572k2iWLmFTfMBhLQ1OfmKt96OjbwO63yY0kAm61WgzdxXFzGgOvpmVssJAqZkZzlThx82ny7nFBVeEbJzAXNQKOcKKi2iJsDCoAMkduzWhVxs4fp5Ac1AtkSVvrQh84xot+sjHYqVi7dgB5m1p6TmxIhXrXzNspUG88cEGmDjfOJstlGKz6rK5TR2bAqx6NpqKlxJu9lrfZyFTXdCl4m/CE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(54906003)(336012)(426003)(6666004)(2616005)(26005)(5660300002)(316002)(186003)(16526019)(1076003)(47076005)(70586007)(70206006)(6916009)(86362001)(8936002)(83380400001)(8676002)(40460700001)(82310400004)(36860700001)(2906002)(508600001)(4326008)(36756003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:36.4665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbfbd4e-e5a7-48b7-475d-08d9c1a3a080
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5283
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
Cc: stylon.wang@amd.com, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
These registers are currently missing from the DCN303 header files

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
---
 .../drm/amd/display/dc/dcn303/dcn303_dccg.h   | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h
index a79c54bbc899..294bd757bcb5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h
@@ -15,7 +15,11 @@
 	SR(DPPCLK_DTO_CTRL),\
 	DCCG_SRII(DTO_PARAM, DPPCLK, 0),\
 	DCCG_SRII(DTO_PARAM, DPPCLK, 1),\
-	SR(REFCLK_CNTL)
+	SR(REFCLK_CNTL),\
+	SR(DISPCLK_FREQ_CHANGE_CNTL),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 0),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 1)
+
 
 #define DCCG_MASK_SH_LIST_DCN3_03(mask_sh) \
 		DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 0, mask_sh),\
@@ -25,6 +29,18 @@
 		DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_PHASE, mask_sh),\
 		DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_MODULO, mask_sh),\
 		DCCG_SF(REFCLK_CNTL, REFCLK_CLOCK_EN, mask_sh),\
-		DCCG_SF(REFCLK_CNTL, REFCLK_SRC_SEL, mask_sh)
+		DCCG_SF(REFCLK_CNTL, REFCLK_SRC_SEL, mask_sh),\
+		DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_STEP_DELAY, mask_sh),\
+		DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_STEP_SIZE, mask_sh),\
+		DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_FREQ_RAMP_DONE, mask_sh),\
+		DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_MAX_ERRDET_CYCLES, mask_sh),\
+		DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_RESET, mask_sh),\
+		DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_STATE, mask_sh),\
+		DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_OVR_EN, mask_sh),\
+		DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_CHG_FWD_CORR_DISABLE, mask_sh),\
+		DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 0, mask_sh),\
+		DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 1, mask_sh),\
+		DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 0, mask_sh),\
+		DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 1, mask_sh)
 
 #endif //__DCN303_DCCG_H__
-- 
2.25.1

