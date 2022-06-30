Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE779CCA47B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F8511A20C;
	Thu, 30 Jun 2022 19:14:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 457AC10EC70
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H95L86sgHsuxr9v9qF2sLBxhh0k+9bcgW50ftIeZ16qB+oQ8sNp+OCE7M81oAvCp8e0XKHObX5Q1pP8YMVG8EjtXEOLWuv/MhkwLxSqH5fBxxz0HPgM31lALTPzMUepw2WJQokODjBkJYD11spQLAwN/mo8H0/zur0GUoS23TrvL2vvwrWimpDK2ovnxJHgwW0VF61GKnkIps6zwaa+nODsawcOAL82ggKe+N5QrWrtd8XMFxzfIK5h0TZ8ewq+zw/p9J216MlG1HS6iKbtj7B4rwcK2Ms2ymuprncFdw2FAca81hJ5LzZKINLroJ99hUCj4goqzAOiqdOMSXOzoag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8aOJ/M9urLmDD/t2z1KH7YMSzXM4RbHRHmA828Lsno=;
 b=YhvX7Gc2NiuOBftGik9x720/dZ8Wa+hvHweqpVF4rRC8fYulgc3uxd0qqFj7JH4N809kOMWR0Zu0Oy9/f3vvNukDSjgZvarRsbng+Q886hSrCX7QTRhfUXL944GbVKh9+RtUBWYu5bSfoJz12ZYu4y6pYiaAgO1/SaRBch+/f3ZS05JnVKWerhz13sQwDi/P9gUtqxoQdnwlsnEjWCDvYVtoe09YSVh1JG7Y/9HsnnKsv5HXZz5GrlKftKoOU6lSOgFjerySV//g1zF11qWfD4rqpoV4zWqZ66cTbPbsZpop8pa01I+dEhMw0xMnvna5Mrcho93kVYdpkpY2lUNwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8aOJ/M9urLmDD/t2z1KH7YMSzXM4RbHRHmA828Lsno=;
 b=m3myPb1YChYBVA8R5aB402majzUYyTeIA7j4qUGMKf+Y0+phW6OnasD2dxSP6uJwpwyOjRux4TIHL9NvgmRNqeeyuTfKtmWcnHeh/6ZO0LSCYAJSJbS9cSlxaD7u5tYkKUL5yVu7pdoTv/IxBBjLRUbcTWuEXZx76htcHeeSk48=
Received: from BN6PR17CA0060.namprd17.prod.outlook.com (2603:10b6:405:75::49)
 by BYAPR12MB2823.namprd12.prod.outlook.com (2603:10b6:a03:96::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 30 Jun
 2022 19:13:53 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::ee) by BN6PR17CA0060.outlook.office365.com
 (2603:10b6:405:75::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 19:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:13:53 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:13:51 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/40] drm/amd/display: Prepare for new interfaces
Date: Thu, 30 Jun 2022 15:12:45 -0400
Message-ID: <20220630191322.909650-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71b6ada1-e634-46f2-464c-08da5accac44
X-MS-TrafficTypeDiagnostic: BYAPR12MB2823:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGw4dyU5YZGrUG0cJDVoSHz6eMoWtx3nkOenIbw8soaUecqvcSKj6oYwGh0JwtCxaB91vd8E35HhG3xosJ11XFBPn+/IQCK/MYySW7tRBSHUvNeAjccd+yR5EclGC8bkRauIzyqU9QuMxeLXbtL5p8ex3s6oy9tctiRoHKQEVpF8WFuiLRuXZSLHmTG38vmV2smNo3wCq6laHha/whhXqYHPALGloNOXE2LOI0VnTGb4evGIOUDZ0/XPMQfZ3cZSPob51C+VL9V27p9td9VpoDXecWYNWizty1avet29ZeCcQanvS4xM0IBzI30Rc8QCipDohA5y14FYuXpEd0ptImecRRrjEV4G22Eqk+ALPPOA54gPo+avPZGoiOZa38mzslhH1LV+hdqwGz/8PF2U0ZLdG5W+ZnTXHu2hVwvH4cW4V3N/Vg0Pu0Q2vE4NJ2yJLdx8ztGJ7ukNT38AkW+r8ng8UaKLtFpP828L2lR35hPDEu3prVKJrQiBYj8T8yIyLTRXqeo8FbJRQk4kzLG2/Vo+G/sTwxOxV7hnpnTgcfDRbBTTkqRT6R8aXfmOwHLZXHjcaEK/6S/iikgV8dXtOaGcYt4yuJ0wabjfD8JXOrK3j1Bvw2g46zgV2XykCNHPxMq83NX4IEN9dC3RU0FDF29Nh6m7yk5/DStXC/yRSmg5crB1Bar0M6wKXHL0Mn77k4mH/m7nD0gUvo7k2QtbNxMmEOp8VqxBYREgrTJjUCd0/FoSxNCljcMDUT09NdL7IG8l8CS81JwrLSXPaPwaguf0G/DUAfwkV3tsiOI+W2ABEUunCLysiw/ti0XAZZK4UFVIgL63Q4WeDh/koM7soseTSNjh56M0M8/nA4rHbqQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(40470700004)(36840700001)(16526019)(47076005)(356005)(82310400005)(40460700003)(426003)(36756003)(36860700001)(30864003)(336012)(478600001)(41300700001)(2616005)(40480700001)(83380400001)(70206006)(1076003)(186003)(6666004)(8676002)(8936002)(86362001)(82740400003)(6916009)(4326008)(54906003)(316002)(5660300002)(7696005)(2906002)(81166007)(70586007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:13:53.5549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b6ada1-e634-46f2-464c-08da5accac44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2823
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
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

[WHY]:
Lut pipeline will be hooked up differently in some asics
need to add new interfaces and missing registers.

[HOW]:
Add missing registers and hook up programming from DPP for pre-blend
lut.

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  | 106 +++++++-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  91 +++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   7 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   5 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  | 236 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h  | 117 ++++++++-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  14 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |  16 +-
 8 files changed, 564 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
index a4d8f77d43bc..c8a3a6a96ff7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
@@ -283,6 +283,7 @@
 	uint32_t MPC_OUT_CSC_COEF_FORMAT
 
 #define MPC_REG_VARIABLE_LIST_DCN32 \
+	uint32_t MPCC_MOVABLE_CM_LOCATION_CONTROL[MAX_MPCC]; \
 	uint32_t MPCC_MCM_SHAPER_CONTROL[MAX_MPCC]; \
 	uint32_t MPCC_MCM_SHAPER_OFFSET_R[MAX_MPCC]; \
 	uint32_t MPCC_MCM_SHAPER_OFFSET_G[MAX_MPCC]; \
@@ -347,6 +348,80 @@
 	uint32_t MPCC_MCM_3DLUT_OUT_OFFSET_R[MAX_MPCC]; \
 	uint32_t MPCC_MCM_3DLUT_OUT_OFFSET_G[MAX_MPCC]; \
 	uint32_t MPCC_MCM_3DLUT_OUT_OFFSET_B[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_CONTROL[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_LUT_INDEX[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_LUT_DATA[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_LUT_CONTROL[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_START_CNTL_B[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_START_CNTL_G[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_START_CNTL_R[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_B[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_G[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_R[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_B[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_G[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_R[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_END_CNTL1_B[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_END_CNTL2_B[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_END_CNTL1_G[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_END_CNTL2_G[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_END_CNTL1_R[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_END_CNTL2_R[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_OFFSET_B[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_OFFSET_G[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_OFFSET_R[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_0_1[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_2_3[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_4_5[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_6_7[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_8_9[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_10_11[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_12_13[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_14_15[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_16_17[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_18_19[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_20_21[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_22_23[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_24_25[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_26_27[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_28_29[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_30_31[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMA_REGION_32_33[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_START_CNTL_B[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_START_CNTL_G[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_START_CNTL_R[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_B[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_G[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_R[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_B[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_G[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_R[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_END_CNTL1_B[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_END_CNTL2_B[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_END_CNTL1_G[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_END_CNTL2_G[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_END_CNTL1_R[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_END_CNTL2_R[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_OFFSET_B[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_OFFSET_G[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_OFFSET_R[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_0_1[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_2_3[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_4_5[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_6_7[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_8_9[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_10_11[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_12_13[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_14_15[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_16_17[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_18_19[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_20_21[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_22_23[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_24_25[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_26_27[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_28_29[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_30_31[MAX_MPCC]; \
+	uint32_t MPCC_MCM_1DLUT_RAMB_REGION_32_33[MAX_MPCC]; \
 	uint32_t MPCC_MCM_MEM_PWR_CTRL[MAX_MPCC]
 
 #define MPC_COMMON_MASK_SH_LIST_DCN3_0(mask_sh) \
@@ -648,6 +723,8 @@
 	type MPC_RMU_SHAPER_MODE_CURRENT
 
 #define MPC_REG_FIELD_LIST_DCN32(type) \
+	type MPCC_MOVABLE_CM_LOCATION_CNTL;\
+	type MPCC_MOVABLE_CM_LOCATION_CNTL_CURRENT;\
 	type MPCC_MCM_SHAPER_MEM_PWR_FORCE;\
 	type MPCC_MCM_SHAPER_MEM_PWR_DIS;\
 	type MPCC_MCM_SHAPER_MEM_LOW_PWR_MODE;\
@@ -692,7 +769,34 @@
 	type MPCC_MCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET;\
 	type MPCC_MCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS;\
 	type MPCC_MCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET;\
-	type MPCC_MCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS
+	type MPCC_MCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS; \
+	type MPCC_MCM_1DLUT_MODE;\
+	type MPCC_MCM_1DLUT_SELECT;\
+	type MPCC_MCM_1DLUT_PWL_DISABLE;\
+	type MPCC_MCM_1DLUT_MODE_CURRENT;\
+	type MPCC_MCM_1DLUT_SELECT_CURRENT;\
+	type MPCC_MCM_1DLUT_LUT_INDEX;\
+	type MPCC_MCM_1DLUT_LUT_DATA;\
+	type MPCC_MCM_1DLUT_LUT_WRITE_COLOR_MASK;\
+	type MPCC_MCM_1DLUT_LUT_READ_COLOR_SEL;\
+	type MPCC_MCM_1DLUT_LUT_READ_DBG;\
+	type MPCC_MCM_1DLUT_LUT_HOST_SEL;\
+	type MPCC_MCM_1DLUT_LUT_CONFIG_MODE;\
+	type MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_B;\
+	type MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_SEGMENT_B;\
+	type MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_SLOPE_B;\
+	type MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_BASE_B;\
+	type MPCC_MCM_1DLUT_RAMA_EXP_REGION_END_BASE_B;\
+	type MPCC_MCM_1DLUT_RAMA_EXP_REGION_END_B;\
+	type MPCC_MCM_1DLUT_RAMA_EXP_REGION_END_SLOPE_B;\
+	type MPCC_MCM_1DLUT_RAMA_OFFSET_B;\
+	type MPCC_MCM_1DLUT_RAMA_OFFSET_G;\
+	type MPCC_MCM_1DLUT_RAMA_OFFSET_R;\
+	type MPCC_MCM_1DLUT_RAMA_EXP_REGION0_LUT_OFFSET;\
+	type MPCC_MCM_1DLUT_RAMA_EXP_REGION0_NUM_SEGMENTS;\
+	type MPCC_MCM_1DLUT_RAMA_EXP_REGION1_LUT_OFFSET;\
+	type MPCC_MCM_1DLUT_RAMA_EXP_REGION1_NUM_SEGMENTS
+
 
 #define MPC_COMMON_MASK_SH_LIST_DCN303(mask_sh) \
 	MPC_COMMON_MASK_SH_LIST_DCN1_0(mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index e865dafc3229..49dd9e0edcb1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -500,6 +500,97 @@ static bool dcn32_set_mpc_shaper_3dlut(
 
 	return result;
 }
+
+bool dcn32_set_mcm_luts(
+	struct pipe_ctx *pipe_ctx, const struct dc_plane_state *plane_state)
+{
+	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
+	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
+	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
+	bool result = true;
+	struct pwl_params *lut_params = NULL;
+
+	// 1D LUT
+	if (plane_state->blend_tf) {
+		if (plane_state->blend_tf->type == TF_TYPE_HWPWL)
+			lut_params = &plane_state->blend_tf->pwl;
+		else if (plane_state->blend_tf->type == TF_TYPE_DISTRIBUTED_POINTS) {
+			cm_helper_translate_curve_to_hw_format(
+					plane_state->blend_tf,
+					&dpp_base->regamma_params, false);
+			lut_params = &dpp_base->regamma_params;
+		}
+	}
+	result = mpc->funcs->program_1dlut(mpc, lut_params, mpcc_id);
+
+	// Shaper
+	if (plane_state->in_shaper_func) {
+		if (plane_state->in_shaper_func->type == TF_TYPE_HWPWL)
+			lut_params = &plane_state->in_shaper_func->pwl;
+		else if (plane_state->in_shaper_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
+			// TODO: dpp_base replace
+			ASSERT(false);
+			cm_helper_translate_curve_to_hw_format(
+					plane_state->in_shaper_func,
+					&dpp_base->shaper_params, true);
+			lut_params = &dpp_base->shaper_params;
+		}
+	}
+
+	result = mpc->funcs->program_shaper(mpc, lut_params, mpcc_id);
+
+	// 3D
+	if (plane_state->lut3d_func && plane_state->lut3d_func->state.bits.initialized == 1)
+		result = mpc->funcs->program_3dlut(mpc, &plane_state->lut3d_func->lut_3d, mpcc_id);
+	else
+		result = mpc->funcs->program_3dlut(mpc, NULL, mpcc_id);
+
+	return result;
+}
+
+bool dcn32_set_input_transfer_func(struct dc *dc,
+				struct pipe_ctx *pipe_ctx,
+				const struct dc_plane_state *plane_state)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	struct mpc *mpc = dc->res_pool->mpc;
+	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
+
+	enum dc_transfer_func_predefined tf;
+	bool result = true;
+	struct pwl_params *params = NULL;
+
+	if (mpc == NULL || plane_state == NULL)
+		return false;
+
+	tf = TRANSFER_FUNCTION_UNITY;
+
+	if (plane_state->in_transfer_func &&
+		plane_state->in_transfer_func->type == TF_TYPE_PREDEFINED)
+		tf = plane_state->in_transfer_func->tf;
+
+	dpp_base->funcs->dpp_set_pre_degam(dpp_base, tf);
+
+	if (plane_state->in_transfer_func) {
+		if (plane_state->in_transfer_func->type == TF_TYPE_HWPWL)
+			params = &plane_state->in_transfer_func->pwl;
+		else if (plane_state->in_transfer_func->type == TF_TYPE_DISTRIBUTED_POINTS &&
+			cm3_helper_translate_curve_to_hw_format(plane_state->in_transfer_func,
+					&dpp_base->degamma_params, false))
+			params = &dpp_base->degamma_params;
+	}
+
+	result = dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
+
+	if (result &&
+			pipe_ctx->stream_res.opp &&
+			pipe_ctx->stream_res.opp->ctx &&
+			hws->funcs.set_mcm_luts)
+		result = hws->funcs.set_mcm_luts(pipe_ctx, plane_state);
+
+	return result;
+}
+
 bool dcn32_set_output_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_stream_state *stream)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 170cf4ae03b6..494cb3a47435 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -47,6 +47,13 @@ void dcn32_cab_for_ss_control(struct dc *dc, bool enable);
 
 void dcn32_commit_subvp_config(struct dc *dc, struct dc_state *context);
 
+bool dcn32_set_mcm_luts(struct pipe_ctx *pipe_ctx,
+				const struct dc_plane_state *plane_state);
+
+bool dcn32_set_input_transfer_func(struct dc *dc,
+				struct pipe_ctx *pipe_ctx,
+				const struct dc_plane_state *plane_state);
+
 bool dcn32_set_output_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_stream_state *stream);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 643058d8ce4d..fb965d31e8dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -111,7 +111,7 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
-	.set_input_transfer_func = dcn30_set_input_transfer_func,
+	.set_input_transfer_func = dcn32_set_input_transfer_func,
 	.set_output_transfer_func = dcn32_set_output_transfer_func,
 	.power_down = dce110_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
@@ -137,8 +137,7 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
 	.dccg_init = dcn20_dccg_init,
-	.set_blend_lut = dcn30_set_blend_lut,
-	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
+	.set_mcm_luts = dcn32_set_mcm_luts,
 	.program_mall_pipe_config = dcn32_program_mall_pipe_config,
 	.subvp_update_force_pstate = dcn32_subvp_update_force_pstate,
 	.update_mall_sel = dcn32_update_mall_sel,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
index a308f33d3d0d..94141f5e6994 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
@@ -26,7 +26,7 @@
 #include "reg_helper.h"
 #include "dcn30/dcn30_mpc.h"
 #include "dcn30/dcn30_cm_common.h"
-#include "dcn30/dcn30_mpc.h"
+#include "dcn32_mpc.h"
 #include "basics/conversion.h"
 #include "dcn10/dcn10_cm_common.h"
 #include "dc.h"
@@ -64,6 +64,235 @@ static void mpc32_mpc_init(struct mpc *mpc)
 	}
 }
 
+static void mpc32_power_on_blnd_lut(
+	struct mpc *mpc,
+	uint32_t mpcc_id,
+	bool power_on)
+{
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+
+	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.cm) {
+		if (power_on) {
+			REG_UPDATE(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_1DLUT_MEM_PWR_FORCE, 0);
+			REG_WAIT(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_1DLUT_MEM_PWR_STATE, 0, 1, 5);
+		} else {
+			ASSERT(false);
+			/* TODO: change to mpc
+			 *  dpp_base->ctx->dc->optimized_required = true;
+			 *  dpp_base->deferred_reg_writes.bits.disable_blnd_lut = true;
+			 */
+		}
+	} else {
+		REG_SET(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], 0,
+				MPCC_MCM_1DLUT_MEM_PWR_FORCE, power_on == true ? 0 : 1);
+	}
+}
+
+static enum dc_lut_mode mpc32_get_post1dlut_current(struct mpc *mpc, uint32_t mpcc_id)
+{
+	enum dc_lut_mode mode;
+	uint32_t mode_current = 0;
+	uint32_t in_use = 0;
+
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+
+	REG_GET(MPCC_MCM_1DLUT_CONTROL[mpcc_id],
+			MPCC_MCM_1DLUT_MODE_CURRENT, &mode_current);
+	REG_GET(MPCC_MCM_1DLUT_CONTROL[mpcc_id],
+			MPCC_MCM_1DLUT_SELECT_CURRENT, &in_use);
+
+	switch (mode_current) {
+	case 0:
+	case 1:
+		mode = LUT_BYPASS;
+		break;
+
+	case 2:
+		if (in_use == 0)
+			mode = LUT_RAM_A;
+		else
+			mode = LUT_RAM_B;
+		break;
+	default:
+		mode = LUT_BYPASS;
+		break;
+	}
+	return mode;
+}
+
+static void mpc32_configure_post1dlut(
+		struct mpc *mpc,
+		uint32_t mpcc_id,
+		bool is_ram_a)
+{
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+
+	//TODO: this
+	REG_UPDATE_2(MPCC_MCM_1DLUT_LUT_CONTROL[mpcc_id],
+			MPCC_MCM_1DLUT_LUT_WRITE_COLOR_MASK, 7,
+			MPCC_MCM_1DLUT_LUT_HOST_SEL, is_ram_a == true ? 0 : 1);
+
+	REG_SET(MPCC_MCM_1DLUT_LUT_INDEX[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_INDEX, 0);
+}
+
+static void mpc32_post1dlut_get_reg_field(
+		struct dcn30_mpc *mpc,
+		struct dcn3_xfer_func_reg *reg)
+{
+	reg->shifts.exp_region0_lut_offset = mpc->mpc_shift->MPCC_MCM_1DLUT_RAMA_EXP_REGION0_LUT_OFFSET;
+	reg->masks.exp_region0_lut_offset = mpc->mpc_mask->MPCC_MCM_1DLUT_RAMA_EXP_REGION0_LUT_OFFSET;
+	reg->shifts.exp_region0_num_segments = mpc->mpc_shift->MPCC_MCM_1DLUT_RAMA_EXP_REGION0_NUM_SEGMENTS;
+	reg->masks.exp_region0_num_segments = mpc->mpc_mask->MPCC_MCM_1DLUT_RAMA_EXP_REGION0_NUM_SEGMENTS;
+	reg->shifts.exp_region1_lut_offset = mpc->mpc_shift->MPCC_MCM_1DLUT_RAMA_EXP_REGION1_LUT_OFFSET;
+	reg->masks.exp_region1_lut_offset = mpc->mpc_mask->MPCC_MCM_1DLUT_RAMA_EXP_REGION1_LUT_OFFSET;
+	reg->shifts.exp_region1_num_segments = mpc->mpc_shift->MPCC_MCM_1DLUT_RAMA_EXP_REGION1_NUM_SEGMENTS;
+	reg->masks.exp_region1_num_segments = mpc->mpc_mask->MPCC_MCM_1DLUT_RAMA_EXP_REGION1_NUM_SEGMENTS;
+
+	reg->shifts.field_region_end = mpc->mpc_shift->MPCC_MCM_1DLUT_RAMA_EXP_REGION_END_B;
+	reg->masks.field_region_end = mpc->mpc_mask->MPCC_MCM_1DLUT_RAMA_EXP_REGION_END_B;
+	reg->shifts.field_region_end_slope = mpc->mpc_shift->MPCC_MCM_1DLUT_RAMA_EXP_REGION_END_SLOPE_B;
+	reg->masks.field_region_end_slope = mpc->mpc_mask->MPCC_MCM_1DLUT_RAMA_EXP_REGION_END_SLOPE_B;
+	reg->shifts.field_region_end_base = mpc->mpc_shift->MPCC_MCM_1DLUT_RAMA_EXP_REGION_END_BASE_B;
+	reg->masks.field_region_end_base = mpc->mpc_mask->MPCC_MCM_1DLUT_RAMA_EXP_REGION_END_BASE_B;
+	reg->shifts.field_region_linear_slope = mpc->mpc_shift->MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_SLOPE_B;
+	reg->masks.field_region_linear_slope = mpc->mpc_mask->MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_SLOPE_B;
+	reg->shifts.exp_region_start = mpc->mpc_shift->MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_B;
+	reg->masks.exp_region_start = mpc->mpc_mask->MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_B;
+	reg->shifts.exp_resion_start_segment = mpc->mpc_shift->MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_SEGMENT_B;
+	reg->masks.exp_resion_start_segment = mpc->mpc_mask->MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_SEGMENT_B;
+}
+
+/*program blnd lut RAM A*/
+static void mpc32_program_post1dluta_settings(
+		struct mpc *mpc,
+		uint32_t mpcc_id,
+		const struct pwl_params *params)
+{
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+	struct dcn3_xfer_func_reg gam_regs;
+
+	mpc32_post1dlut_get_reg_field(mpc30, &gam_regs);
+
+	gam_regs.start_cntl_b = REG(MPCC_MCM_1DLUT_RAMA_START_CNTL_B[mpcc_id]);
+	gam_regs.start_cntl_g = REG(MPCC_MCM_1DLUT_RAMA_START_CNTL_G[mpcc_id]);
+	gam_regs.start_cntl_r = REG(MPCC_MCM_1DLUT_RAMA_START_CNTL_R[mpcc_id]);
+	gam_regs.start_slope_cntl_b = REG(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_B[mpcc_id]);
+	gam_regs.start_slope_cntl_g = REG(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_G[mpcc_id]);
+	gam_regs.start_slope_cntl_r = REG(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_R[mpcc_id]);
+	gam_regs.start_end_cntl1_b = REG(MPCC_MCM_1DLUT_RAMA_END_CNTL1_B[mpcc_id]);
+	gam_regs.start_end_cntl2_b = REG(MPCC_MCM_1DLUT_RAMA_END_CNTL2_B[mpcc_id]);
+	gam_regs.start_end_cntl1_g = REG(MPCC_MCM_1DLUT_RAMA_END_CNTL1_G[mpcc_id]);
+	gam_regs.start_end_cntl2_g = REG(MPCC_MCM_1DLUT_RAMA_END_CNTL2_G[mpcc_id]);
+	gam_regs.start_end_cntl1_r = REG(MPCC_MCM_1DLUT_RAMA_END_CNTL1_R[mpcc_id]);
+	gam_regs.start_end_cntl2_r = REG(MPCC_MCM_1DLUT_RAMA_END_CNTL2_R[mpcc_id]);
+	gam_regs.region_start = REG(MPCC_MCM_1DLUT_RAMA_REGION_0_1[mpcc_id]);
+	gam_regs.region_end = REG(MPCC_MCM_1DLUT_RAMA_REGION_32_33[mpcc_id]);
+
+	cm_helper_program_gamcor_xfer_func(mpc->ctx, params, &gam_regs);
+}
+
+/*program blnd lut RAM B*/
+static void mpc32_program_post1dlutb_settings(
+		struct mpc *mpc,
+		uint32_t mpcc_id,
+		const struct pwl_params *params)
+{
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+	struct dcn3_xfer_func_reg gam_regs;
+
+	mpc32_post1dlut_get_reg_field(mpc30, &gam_regs);
+
+	gam_regs.start_cntl_b = REG(MPCC_MCM_1DLUT_RAMB_START_CNTL_B[mpcc_id]);
+	gam_regs.start_cntl_g = REG(MPCC_MCM_1DLUT_RAMB_START_CNTL_G[mpcc_id]);
+	gam_regs.start_cntl_r = REG(MPCC_MCM_1DLUT_RAMB_START_CNTL_R[mpcc_id]);
+	gam_regs.start_slope_cntl_b = REG(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_B[mpcc_id]);
+	gam_regs.start_slope_cntl_g = REG(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_G[mpcc_id]);
+	gam_regs.start_slope_cntl_r = REG(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_R[mpcc_id]);
+	gam_regs.start_end_cntl1_b = REG(MPCC_MCM_1DLUT_RAMB_END_CNTL1_B[mpcc_id]);
+	gam_regs.start_end_cntl2_b = REG(MPCC_MCM_1DLUT_RAMB_END_CNTL2_B[mpcc_id]);
+	gam_regs.start_end_cntl1_g = REG(MPCC_MCM_1DLUT_RAMB_END_CNTL1_G[mpcc_id]);
+	gam_regs.start_end_cntl2_g = REG(MPCC_MCM_1DLUT_RAMB_END_CNTL2_G[mpcc_id]);
+	gam_regs.start_end_cntl1_r = REG(MPCC_MCM_1DLUT_RAMB_END_CNTL1_R[mpcc_id]);
+	gam_regs.start_end_cntl2_r = REG(MPCC_MCM_1DLUT_RAMB_END_CNTL2_R[mpcc_id]);
+	gam_regs.region_start = REG(MPCC_MCM_1DLUT_RAMB_REGION_0_1[mpcc_id]);
+	gam_regs.region_end = REG(MPCC_MCM_1DLUT_RAMB_REGION_32_33[mpcc_id]);
+
+	cm_helper_program_gamcor_xfer_func(mpc->ctx, params, &gam_regs);
+}
+
+static void mpc32_program_post1dlut_pwl(
+		struct mpc *mpc,
+		uint32_t mpcc_id,
+		const struct pwl_result_data *rgb,
+		uint32_t num)
+{
+	uint32_t i;
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+	uint32_t last_base_value_red = rgb[num-1].red_reg + rgb[num-1].delta_red_reg;
+	uint32_t last_base_value_green = rgb[num-1].green_reg + rgb[num-1].delta_green_reg;
+	uint32_t last_base_value_blue = rgb[num-1].blue_reg + rgb[num-1].delta_blue_reg;
+
+	if (is_rgb_equal(rgb, num)) {
+		for (i = 0 ; i < num; i++)
+			REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, rgb[i].red_reg);
+		REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, last_base_value_red);
+	} else {
+		REG_UPDATE(MPCC_MCM_1DLUT_LUT_CONTROL[mpcc_id], MPCC_MCM_1DLUT_LUT_WRITE_COLOR_MASK, 4);
+		for (i = 0 ; i < num; i++)
+			REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, rgb[i].red_reg);
+		REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, last_base_value_red);
+
+		REG_UPDATE(MPCC_MCM_1DLUT_LUT_CONTROL[mpcc_id], MPCC_MCM_1DLUT_LUT_WRITE_COLOR_MASK, 2);
+		for (i = 0 ; i < num; i++)
+			REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, rgb[i].green_reg);
+		REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, last_base_value_green);
+
+		REG_UPDATE(MPCC_MCM_1DLUT_LUT_CONTROL[mpcc_id], MPCC_MCM_1DLUT_LUT_WRITE_COLOR_MASK, 1);
+		for (i = 0 ; i < num; i++)
+			REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, rgb[i].blue_reg);
+		REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, last_base_value_blue);
+	}
+}
+
+static bool mpc32_program_post1dlut(
+		struct mpc *mpc,
+		const struct pwl_params *params,
+		uint32_t mpcc_id)
+{
+	enum dc_lut_mode current_mode;
+	enum dc_lut_mode next_mode;
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+
+	if (params == NULL) {
+		REG_SET(MPCC_MCM_1DLUT_CONTROL[mpcc_id], 0, MPCC_MCM_1DLUT_MODE, 0);
+		if (mpc->ctx->dc->debug.enable_mem_low_power.bits.cm)
+			mpc32_power_on_blnd_lut(mpc, mpcc_id, false);
+		return false;
+	}
+
+	current_mode = mpc32_get_post1dlut_current(mpc, mpcc_id);
+	if (current_mode == LUT_BYPASS || current_mode == LUT_RAM_B)
+		next_mode = LUT_RAM_A;
+	else
+		next_mode = LUT_RAM_B;
+
+	mpc32_power_on_blnd_lut(mpc, mpcc_id, true);
+	mpc32_configure_post1dlut(mpc, mpcc_id, next_mode == LUT_RAM_A);
+
+	if (next_mode == LUT_RAM_A)
+		mpc32_program_post1dluta_settings(mpc, mpcc_id, params);
+	else
+		mpc32_program_post1dlutb_settings(mpc, mpcc_id, params);
+
+	mpc32_program_post1dlut_pwl(
+			mpc, mpcc_id, params->rgb_resulted, params->hw_points_num);
+
+	REG_UPDATE_2(MPCC_MCM_1DLUT_CONTROL[mpcc_id],
+			MPCC_MCM_1DLUT_MODE, 2,
+			MPCC_MCM_1DLUT_SELECT, next_mode == LUT_RAM_A ? 0 : 1);
+
+	return true;
+}
 
 static enum dc_lut_mode mpc32_get_shaper_current(struct mpc *mpc, uint32_t mpcc_id)
 {
@@ -651,6 +880,10 @@ static void mpc32_set_3dlut_mode(
 	uint32_t lut_mode;
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 
+	// set default 3DLUT to pre-blend
+	// TODO: implement movable CM location
+	REG_UPDATE(MPCC_MOVABLE_CM_LOCATION_CONTROL[mpcc_id], MPCC_MOVABLE_CM_LOCATION_CNTL, 0);
+
 	if (mode == LUT_BYPASS)
 		lut_mode = 0;
 	else if (mode == LUT_RAM_A)
@@ -775,6 +1008,7 @@ const struct mpc_funcs dcn32_mpc_funcs = {
 	.set_gamut_remap = mpc3_set_gamut_remap,
 	.program_shaper = mpc32_program_shaper,
 	.program_3dlut = mpc32_program_3dlut,
+	.program_1dlut = mpc32_program_post1dlut,
 	.acquire_rmu = NULL,
 	.release_rmu = NULL,
 	.power_on_mpc_mem_pwr = mpc3_power_on_ogam_lut,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
index d4be3c89ec7b..61f33c0d8e59 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
@@ -28,7 +28,12 @@
 #include "dcn20/dcn20_mpc.h"
 #include "dcn30/dcn30_mpc.h"
 
-#define MPC_MCM_REG_LIST_DCN32(inst) \
+#define TO_DCN32_MPC(mpc_base) \
+	container_of(mpc_base, struct dcn32_mpc, base)
+
+#define MPC_REG_LIST_DCN3_2(inst) \
+	MPC_REG_LIST_DCN3_0(inst),\
+	SRII(MPCC_MOVABLE_CM_LOCATION_CONTROL, MPCC, inst),\
 	SRII(MPCC_MCM_SHAPER_CONTROL, MPCC_MCM, inst),\
 	SRII(MPCC_MCM_SHAPER_OFFSET_R, MPCC_MCM, inst),\
 	SRII(MPCC_MCM_SHAPER_OFFSET_G, MPCC_MCM, inst),\
@@ -83,8 +88,8 @@
 	SRII(MPCC_MCM_SHAPER_RAMB_REGION_26_27, MPCC_MCM, inst),\
 	SRII(MPCC_MCM_SHAPER_RAMB_REGION_28_29, MPCC_MCM, inst),\
 	SRII(MPCC_MCM_SHAPER_RAMB_REGION_30_31, MPCC_MCM, inst),\
-	SRII(MPCC_MCM_SHAPER_RAMB_REGION_32_33, MPCC_MCM, inst), \
-	SRII(MPCC_MCM_3DLUT_MODE, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_32_33, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_3DLUT_MODE, MPCC_MCM, inst), /*TODO: may need to add other 3DLUT regs*/\
 	SRII(MPCC_MCM_3DLUT_INDEX, MPCC_MCM, inst),\
 	SRII(MPCC_MCM_3DLUT_DATA, MPCC_MCM, inst),\
 	SRII(MPCC_MCM_3DLUT_DATA_30BIT, MPCC_MCM, inst),\
@@ -93,6 +98,80 @@
 	SRII(MPCC_MCM_3DLUT_OUT_OFFSET_R, MPCC_MCM, inst),\
 	SRII(MPCC_MCM_3DLUT_OUT_OFFSET_G, MPCC_MCM, inst),\
 	SRII(MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_CONTROL, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_LUT_INDEX, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_LUT_DATA, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_0_1, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_2_3, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_4_5, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_6_7, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_8_9, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_10_11, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_12_13, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_14_15, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_16_17, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_18_19, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_20_21, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_22_23, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_24_25, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_26_27, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_28_29, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_30_31, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_32_33, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_0_1, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_2_3, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_4_5, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_6_7, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_8_9, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_10_11, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_12_13, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_14_15, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_16_17, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_18_19, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_20_21, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_22_23, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_24_25, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_26_27, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_28_29, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_30_31, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_32_33, MPCC_MCM, inst),\
 	SRII(MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM, inst)
 
 
@@ -103,6 +182,8 @@
 	SF(MPCC0_MPCC_TOP_GAIN, MPCC_TOP_GAIN, mask_sh),\
 	SF(MPCC0_MPCC_BOT_GAIN_INSIDE, MPCC_BOT_GAIN_INSIDE, mask_sh),\
 	SF(MPCC0_MPCC_BOT_GAIN_OUTSIDE, MPCC_BOT_GAIN_OUTSIDE, mask_sh),\
+	SF(MPCC0_MPCC_MOVABLE_CM_LOCATION_CONTROL, MPCC_MOVABLE_CM_LOCATION_CNTL, mask_sh),\
+	SF(MPCC0_MPCC_MOVABLE_CM_LOCATION_CONTROL, MPCC_MOVABLE_CM_LOCATION_CNTL_CURRENT, mask_sh),\
 	SF(MPC_OUT0_CSC_MODE, MPC_OCSC_MODE, mask_sh),\
 	SF(MPC_OUT0_CSC_C11_C12_A, MPC_OCSC_C11_A, mask_sh),\
 	SF(MPC_OUT0_CSC_C11_C12_A, MPC_OCSC_C12_A, mask_sh),\
@@ -186,6 +267,30 @@
 	SF(MPCC_MCM0_MPCC_MCM_SHAPER_RAMA_REGION_0_1, MPCC_MCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_SHAPER_RAMA_REGION_0_1, MPCC_MCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_SHAPER_RAMA_REGION_0_1, MPCC_MCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_CONTROL, MPCC_MCM_1DLUT_MODE, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_CONTROL, MPCC_MCM_1DLUT_SELECT, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_CONTROL, MPCC_MCM_1DLUT_PWL_DISABLE, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_CONTROL, MPCC_MCM_1DLUT_MODE_CURRENT, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_CONTROL, MPCC_MCM_1DLUT_SELECT_CURRENT, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_LUT_INDEX, MPCC_MCM_1DLUT_LUT_INDEX, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_LUT_DATA, MPCC_MCM_1DLUT_LUT_DATA, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM_1DLUT_LUT_WRITE_COLOR_MASK, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM_1DLUT_LUT_READ_COLOR_SEL, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM_1DLUT_LUT_READ_DBG, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM_1DLUT_LUT_HOST_SEL, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM_1DLUT_LUT_CONFIG_MODE, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_RAMA_START_CNTL_B, MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_B, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_RAMA_START_CNTL_B, MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_SEGMENT_B, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_B, MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_SLOPE_B, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_B, MPCC_MCM_1DLUT_RAMA_EXP_REGION_START_BASE_B, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_RAMA_END_CNTL1_B, MPCC_MCM_1DLUT_RAMA_EXP_REGION_END_BASE_B, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_RAMA_END_CNTL2_B, MPCC_MCM_1DLUT_RAMA_EXP_REGION_END_B, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_RAMA_END_CNTL2_B, MPCC_MCM_1DLUT_RAMA_EXP_REGION_END_SLOPE_B, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_RAMA_OFFSET_B, MPCC_MCM_1DLUT_RAMA_OFFSET_B, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_RAMA_REGION_0_1, MPCC_MCM_1DLUT_RAMA_EXP_REGION0_LUT_OFFSET, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_RAMA_REGION_0_1, MPCC_MCM_1DLUT_RAMA_EXP_REGION0_NUM_SEGMENTS, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_RAMA_REGION_0_1, MPCC_MCM_1DLUT_RAMA_EXP_REGION1_LUT_OFFSET, mask_sh),\
+	SF(MPCC_MCM0_MPCC_MCM_1DLUT_RAMA_REGION_0_1, MPCC_MCM_1DLUT_RAMA_EXP_REGION1_NUM_SEGMENTS, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM_SHAPER_MEM_PWR_FORCE, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM_SHAPER_MEM_PWR_DIS, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM_SHAPER_MEM_LOW_PWR_MODE, mask_sh),\
@@ -198,10 +303,14 @@
 	SF(MPCC_MCM0_MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM_SHAPER_MEM_PWR_STATE, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM_3DLUT_MEM_PWR_STATE, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM_1DLUT_MEM_PWR_STATE, mask_sh),\
-	SF(MPCC_MCM0_MPCC_MCM_SHAPER_CONTROL, MPCC_MCM_SHAPER_MODE_CURRENT, mask_sh),\
 	SF(CUR_VUPDATE_LOCK_SET0, CUR_VUPDATE_LOCK_SET, mask_sh)
 
 
+struct dcn32_mpc_registers {
+	MPC_REG_VARIABLE_LIST_DCN3_0;
+	MPC_REG_VARIABLE_LIST_DCN32;
+};
+
 void dcn32_mpc_construct(struct dcn30_mpc *mpc30,
 	struct dc_context *ctx,
 	const struct dcn30_mpc_registers *mpc_regs,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 528f055c5ffc..9434eedde1bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -695,18 +695,14 @@ static const struct dcn20_dsc_mask dsc_mask = {
 };
 
 static const struct dcn30_mpc_registers mpc_regs = {
-		MPC_REG_LIST_DCN3_0(0),
-		MPC_REG_LIST_DCN3_0(1),
-		MPC_REG_LIST_DCN3_0(2),
-		MPC_REG_LIST_DCN3_0(3),
+		MPC_REG_LIST_DCN3_2(0),
+		MPC_REG_LIST_DCN3_2(1),
+		MPC_REG_LIST_DCN3_2(2),
+		MPC_REG_LIST_DCN3_2(3),
 		MPC_OUT_MUX_REG_LIST_DCN3_0(0),
 		MPC_OUT_MUX_REG_LIST_DCN3_0(1),
 		MPC_OUT_MUX_REG_LIST_DCN3_0(2),
 		MPC_OUT_MUX_REG_LIST_DCN3_0(3),
-		MPC_MCM_REG_LIST_DCN32(0),
-		MPC_MCM_REG_LIST_DCN32(1),
-		MPC_MCM_REG_LIST_DCN32(2),
-		MPC_MCM_REG_LIST_DCN32(3),
 		MPC_DWB_MUX_REG_LIST_DCN3_0(0),
 };
 
@@ -3737,7 +3733,7 @@ static bool dcn32_resource_construct(
 	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
 	dc->caps.color.dpp.hw_3d_lut = 1;
-	dc->caps.color.dpp.ogam_ram = 0;  //Blnd Gam also removed
+	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
 	// no OGAM ROM on DCN2 and later ASICs
 	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
 	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 48af91affb0c..644f00f2def0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -697,18 +697,14 @@ static const struct dcn20_dsc_mask dsc_mask = {
 };
 
 static const struct dcn30_mpc_registers mpc_regs = {
-		MPC_REG_LIST_DCN3_0(0),
-		MPC_REG_LIST_DCN3_0(1),
-		MPC_REG_LIST_DCN3_0(2),
-		MPC_REG_LIST_DCN3_0(3),
+		MPC_REG_LIST_DCN3_2(0),
+		MPC_REG_LIST_DCN3_2(1),
+		MPC_REG_LIST_DCN3_2(2),
+		MPC_REG_LIST_DCN3_2(3),
 		MPC_OUT_MUX_REG_LIST_DCN3_0(0),
 		MPC_OUT_MUX_REG_LIST_DCN3_0(1),
 		MPC_OUT_MUX_REG_LIST_DCN3_0(2),
 		MPC_OUT_MUX_REG_LIST_DCN3_0(3),
-		MPC_MCM_REG_LIST_DCN32(0),
-		MPC_MCM_REG_LIST_DCN32(1),
-		MPC_MCM_REG_LIST_DCN32(2),
-		MPC_MCM_REG_LIST_DCN32(3),
 		MPC_DWB_MUX_REG_LIST_DCN3_0(0),
 };
 
@@ -2052,8 +2048,8 @@ static bool dcn321_resource_construct(
 	dc->caps.color.dpp.gamma_corr = 1;
 	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
-	dc->caps.color.dpp.hw_3d_lut = 0; //3DLUT removed from DPP
-	dc->caps.color.dpp.ogam_ram = 0;  //Blnd Gam also removed
+	dc->caps.color.dpp.hw_3d_lut = 1;
+	dc->caps.color.dpp.ogam_ram = 1;
 	// no OGAM ROM on DCN2 and later ASICs
 	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
 	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
-- 
2.25.1

