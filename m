Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D162BC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 08:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BE2D10ED54;
	Thu, 30 Mar 2023 08:59:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E2AF10ED54
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 08:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRRsJS/JWgU6H6qd9wfBPgocP/qkS4P/aLtkuCAMejhiPEgvITK4hQ2a9rs6cBGeVq/zcP6nJddXqGQ0wYFL4WaBFaz5Zpmd5GOopuQ85sLITcTL+5Xd2KomrIG9QgjCJZHxf9zSWiQp5kYa+OEJFSFFrII3jenhH76yeGuSrm2DE3oNw4tB/jI5QhHAa6a53hsLNtu9GJwrSS+lwVUNJznqWV5JSrcRD/ummztjBaJdk5V5/Nj90jCzJ9G1BcLivV2ICO2LrD9qgd8z4AzxYZdqBDTrAwWWwN1joMDRioH+mXDIFrTrnWPTmC+KniUT6rh5g+95GNTd6PvAcevlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYfrEsupzNsAzpN5z2OAmBPsHtDumQLXyhQhmF4QSNU=;
 b=SnemaHFKnTeN06v/5go8a/v3x8BZeCmHTsCRqR4TV8zz43oQaLKho+95LiHScoPPr9zdXB7V5ky0KO19dKk+/8N8hUg1/HYF6/20ujQTJnFatIU1y9uhxtyi5NbWsCmKTmZrWBord6FeQ5Ru2D/azXFHMju/CabmPGJ2+9hlOwTSEu/MrxoCoSJ006vtELlbmltA150uZ4uzsDzn9qWTJNyHnWRTx4hFAY/s1cLwxk7te9LM4YAxodrmVMzCzdiUftyHiAI+dFgUkpDu3BoRChbBAdHMqliGx0AfDet8PsbGUA6lZr2BM/i5yLS4R9i9Fx+SdvY92QfXwZMtFlCwnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYfrEsupzNsAzpN5z2OAmBPsHtDumQLXyhQhmF4QSNU=;
 b=BT3Fm0vsZk++080RTRVekRYXyycTviRtEw0ilhuBeFGTGsz6huG8BSIi1JSFBxAIylrageDgr7tYptoexa0yrAFqGLO/QN/nNIB8VO/7QGBM2RCyN5Cdh75MnpsvphXAxvR8Eahite05ZtCNhz1G5K9fr82tvtARIMlPNYeUFLw=
Received: from BN8PR15CA0046.namprd15.prod.outlook.com (2603:10b6:408:80::23)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 08:59:46 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::45) by BN8PR15CA0046.outlook.office365.com
 (2603:10b6:408:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 08:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Thu, 30 Mar 2023 08:59:45 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 03:59:40 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/10] drm/amd/display: add dscclk instance offset check
Date: Thu, 30 Mar 2023 04:57:17 -0400
Message-ID: <20230330085720.3863-8-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
References: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b675b9-4e6a-483c-5a64-08db30fd1bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IU/bLt8MNfW2CJWQMOAc0FgHzbGmFkKzpOp+XTkZELz3iQNvzpgyZA+cVZt7d6F9kh+DWqehc2VRg38abmW7czalFeRCXHdRw8ln1J+RyUEddgUf3TbwIHINm2dUl1vTYaZc2XIAJI4C9LlV3WwdiLGvUP9sj5MC17yvUGG7MP/YKJ8NyB+P3ltt4keTTFGYUXFKewTqk4Hct/KSCAprcovReR78NtlezObVmXzUxBdpc2p93YwOXZzfI/rTSsA30OtmustAhjnFDB7PsfDzxgx3dLIfUfaYP+2ma7pL0g4UjPLTgfRcLqAXhXrGu26oqzJlxTzQc45+R7UQbb3UZylLPRwKcgR8YTOBZs18/T3tHniPgoaYDstHj5MAlg26L47YUBYs1WpcCZYil4WA5tC8JYInXM2b31BrK+Vru0wyiIdLLAWpscSCrbOwTNG2hVpmbUUV7Vdh6lnRaqNn8sknGcPvlN/dSUKR84BHEiaQ2fnOhuNpXNNavqzyH3qqTWrqlo5TOPnED+x03BOrk1EsHC9K8icMmbDydNdr9FG0w7xFCVKdu2YT84EKK+B9MVG+ckimtOskM18Wc7bDnzcZC+RXxBGGiLcC+17y10r+O2gqxm0c4847/t1xzhLrgUEU4/ZL+d/1VcH0MfrqARS136uUpV8YLUVMGHrNp74gNQfZj9gz7DiAdalQXTcjFclB+pMtG9YNu8ofVqFOnCIV+8yK6M/gfUt28nSDEGE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(336012)(83380400001)(47076005)(36756003)(426003)(2616005)(186003)(16526019)(1076003)(6666004)(82310400005)(478600001)(86362001)(316002)(54906003)(36860700001)(26005)(6916009)(41300700001)(4326008)(40480700001)(40460700003)(82740400003)(356005)(70586007)(8676002)(70206006)(81166007)(8936002)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 08:59:45.3497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b675b9-4e6a-483c-5a64-08db30fd1bc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
based on dscclk instance offset check conditiona program dscclk

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h  |  8 ++++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c  | 18 ++++++++++++++++++
 .../drm/amd/display/dc/dcn314/dcn314_dccg.h    |  4 ++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index 893c0809cd4e..7bdc146f7cb5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -205,6 +205,11 @@
 	type PHYDSYMCLK_GATE_DISABLE; \
 	type PHYESYMCLK_GATE_DISABLE;
 
+#define DCCG314_REG_FIELD_LIST(type) \
+	type DSCCLK3_DTO_PHASE;\
+	type DSCCLK3_DTO_MODULO;\
+	type DSCCLK3_DTO_ENABLE;
+
 #define DCCG32_REG_FIELD_LIST(type) \
 	type DPSTREAMCLK0_EN;\
 	type DPSTREAMCLK1_EN;\
@@ -237,6 +242,7 @@ struct dccg_shift {
 	DCCG_REG_FIELD_LIST(uint8_t)
 	DCCG3_REG_FIELD_LIST(uint8_t)
 	DCCG31_REG_FIELD_LIST(uint8_t)
+	DCCG314_REG_FIELD_LIST(uint8_t)
 	DCCG32_REG_FIELD_LIST(uint8_t)
 };
 
@@ -244,6 +250,7 @@ struct dccg_mask {
 	DCCG_REG_FIELD_LIST(uint32_t)
 	DCCG3_REG_FIELD_LIST(uint32_t)
 	DCCG31_REG_FIELD_LIST(uint32_t)
+	DCCG314_REG_FIELD_LIST(uint32_t)
 	DCCG32_REG_FIELD_LIST(uint32_t)
 };
 
@@ -273,6 +280,7 @@ struct dccg_registers {
 	uint32_t DSCCLK0_DTO_PARAM;
 	uint32_t DSCCLK1_DTO_PARAM;
 	uint32_t DSCCLK2_DTO_PARAM;
+	uint32_t DSCCLK3_DTO_PARAM;
 	uint32_t DPSTREAMCLK_ROOT_GATE_DISABLE;
 	uint32_t DPSTREAMCLK_GATE_DISABLE;
 	uint32_t DCCG_GATE_DISABLE_CNTL;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 7d2b982506fd..4c2fdfea162f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -360,6 +360,15 @@ void dccg31_disable_dscclk(struct dccg *dccg, int inst)
 				DSCCLK2_DTO_PHASE, 0,
 				DSCCLK2_DTO_MODULO, 1);
 		break;
+	case 3:
+		if (REG(DSCCLK3_DTO_PARAM)) {
+			REG_UPDATE(DSCCLK_DTO_CTRL,
+					DSCCLK3_DTO_ENABLE, 1);
+			REG_UPDATE_2(DSCCLK3_DTO_PARAM,
+					DSCCLK3_DTO_PHASE, 0,
+					DSCCLK3_DTO_MODULO, 1);
+		}
+		break;
 	default:
 		BREAK_TO_DEBUGGER();
 		return;
@@ -395,6 +404,15 @@ void dccg31_enable_dscclk(struct dccg *dccg, int inst)
 		REG_UPDATE(DSCCLK_DTO_CTRL,
 				DSCCLK2_DTO_ENABLE, 0);
 		break;
+	case 3:
+		if (REG(DSCCLK3_DTO_PARAM)) {
+			REG_UPDATE(DSCCLK_DTO_CTRL,
+					DSCCLK3_DTO_ENABLE, 0);
+			REG_UPDATE_2(DSCCLK3_DTO_PARAM,
+					DSCCLK3_DTO_PHASE, 0,
+					DSCCLK3_DTO_MODULO, 0);
+		}
+		break;
 	default:
 		BREAK_TO_DEBUGGER();
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
index f62631ab53a2..90687a9e8fdd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
@@ -68,6 +68,7 @@
 	SR(DSCCLK0_DTO_PARAM),\
 	SR(DSCCLK1_DTO_PARAM),\
 	SR(DSCCLK2_DTO_PARAM),\
+	SR(DSCCLK3_DTO_PARAM),\
 	SR(DSCCLK_DTO_CTRL),\
 	SR(DCCG_GATE_DISABLE_CNTL2),\
 	SR(DCCG_GATE_DISABLE_CNTL3),\
@@ -149,6 +150,8 @@
 	DCCG_SF(DSCCLK1_DTO_PARAM, DSCCLK1_DTO_MODULO, mask_sh),\
 	DCCG_SF(DSCCLK2_DTO_PARAM, DSCCLK2_DTO_PHASE, mask_sh),\
 	DCCG_SF(DSCCLK2_DTO_PARAM, DSCCLK2_DTO_MODULO, mask_sh),\
+	DCCG_SF(DSCCLK3_DTO_PARAM, DSCCLK3_DTO_PHASE, mask_sh),\
+	DCCG_SF(DSCCLK3_DTO_PARAM, DSCCLK3_DTO_MODULO, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE0_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE1_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE2_GATE_DISABLE, mask_sh),\
@@ -184,6 +187,7 @@
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK0_DTO_ENABLE, mask_sh),\
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK1_DTO_ENABLE, mask_sh),\
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK2_DTO_ENABLE, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK3_DTO_ENABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYASYMCLK_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYBSYMCLK_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYCSYMCLK_GATE_DISABLE, mask_sh),\
-- 
2.34.1

