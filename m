Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D40CC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 19:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E42D310E046;
	Thu,  8 Dec 2022 19:25:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185DC10E046
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 19:25:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuuA8qjeOGcDVefOBaofaMR9zWoprwrhUiH+/hdictJFFQtMlekdQ+wVX/mkb4gtTQSo4Miiq4p9N/eG+F+n20KVdCf7/4YbheSDYdsXEm/FU+jZMQo2tgVPJU8rbjlz0Qpk3ATAPW/n1fRYMO5K31g5JKSdaRf5teranblqFGd5TMJuTfukpjSsOJwhgqI7BymDe14X7DoETI5dh9IkeP4rRz7Me5Omu3Gk24QY3bDMIpFtHRjWrKA1apwYv3XtXrODQ7/7M5mWc5qTt3xX0Jeld2d4imIKGSkjkUcmc9UAZoRjP1k3uyX4dzR5gVPCPeY94jYzXrkd7sX58FuRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcC6dAC15RBRrpZT7ztpdNtrsuJCPqxfUXonsn7Eais=;
 b=n6azuEcoTV2mwoBihpm172HEz2ydZXZb5FvsNYJk7m8fHzHacezKI/mPs2+sMgwxiqYfi8035Um9kCF3kJPahjAQaDcnj6oWtaVMupUvpU9GVl2FcjuQQHjBuLv2z7TpNSaUw9WzQVOH8jnTHE9irMLVzL6LGuWoTuJrqkOch2ISjjaimiRtlhDN3+9IFgZ83XTH0JLvPVRuP6+rw0alny97X/QOM58WYVh/8AABRf4j+9i4GQhXmorF87cBO7Po4EZ8MpXBiJHvPTJZdgIY2L2IbLWr80bZYDa0GcG1LCCYRaTVqSQ/eGz39Wibxk+Ts289+QcXsmBtmSUG2+UiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcC6dAC15RBRrpZT7ztpdNtrsuJCPqxfUXonsn7Eais=;
 b=rNhl8tSTL1q83GCor3tG7krAfFpOgzOO7LHxSrj6Yf/ZdN/6dvbFASjDww/anZ9cGTSYP09gT/8a57NB03L1mkooS1WVYBAG9ClPu3ssLN8qqdWUknL0/8xVrC6mdoPBdgd+Emv/0WbKZL9wxPzY1jDAO8NVHkzOedsnU5RxWYo=
Received: from MW2PR16CA0071.namprd16.prod.outlook.com (2603:10b6:907:1::48)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 19:25:39 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::d2) by MW2PR16CA0071.outlook.office365.com
 (2603:10b6:907:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 8 Dec 2022 19:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 19:25:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 13:25:38 -0600
From: Sung Joon Kim <Sungjoon.Kim@amd.com>
To: <harry.wentland@amd.com>, <rodrigo.siqueira@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/display: Include missing DPCD definitions from DP2.0 spec
Date: Thu, 8 Dec 2022 14:25:25 -0500
Message-ID: <20221208192525.5763-1-Sungjoon.Kim@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|SA0PR12MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a5814b-67e5-4730-d35f-08dad951fda3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLkMJXKwRKvZnkWIngotB6WBywzJimZ0RpSLVKRqMtzEVuidqm5LCEadMr2n9HZ1RiTETLJ06mFeT3DdniHGEBtQlvGC80uH+lKhdNx9sxZc6m1xpCVGxkFQvAldGMOD5H2pWbAbgXHIwSgas5kug1rlP4o8wpJnvGG7lUV/mjxWxG7oMFvK6jHgPMrYk4Ko9isWlK8xGByshhj52Tgmsga4WTVGoTaFNJn8q21t6JmeXAUnvbDsjct+tXgdn0bgmhunPTeBD1XuQkqDN+0DYk/KkmI36A2BCPAamdNIEBP64o+323mYxVSeldD7/ec3pI6Weg3qOizFGPKYD8VVJzDvxH6QF39ZAm/iXgN5K1haSAZ4mkxVci6fdRRdHewkdme35w/zXz0IunHotjSEhpOeT2a43qvQT5N2PzGkRY7XK4um3l7M6G1pl32ZPBJ/lwxfmCY3m6AGNHQht8AgJ4cDDpDN4rSrj21MJBs+QmIrTei6xcod30O7Zyt9C/ZMUl5/Rq//61Ud1f8xFu7Qhf7qmyOGR8MRF1XLZSup0wAcYg0b3vJ4qI1oreu4LzFjolYC/A+9jSCfh8Q3dhiIZHvhLuX44ScHMxgeq2gta/CfMOhUCYjHHVIR+Gy8mKS2/yGa9LQQaXMFcrziLEy0U5Y1Kvv18jecYWSFMOncJqQtOUJqxHuOu7AHV4/JFXdl5lE8Im0GgFrIS8rHwad1KqlmpeBf5Q9DUMIELq76AkU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(2906002)(16526019)(186003)(70206006)(70586007)(36756003)(86362001)(40480700001)(41300700001)(1076003)(336012)(4326008)(8676002)(2616005)(8936002)(6636002)(47076005)(6666004)(5660300002)(316002)(478600001)(54906003)(426003)(356005)(110136005)(26005)(82310400005)(82740400003)(81166007)(40460700003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 19:25:39.5734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a5814b-67e5-4730-d35f-08dad951fda3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
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
Cc: Sung Joon Kim <Sungjoon.Kim@amd.com>, amd-gfx@lists.freedesktop.org,
 nikola.cornij@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The missing DPCD defintions from DP2.0 spec is as follows:

DOWNSPREAD_CTRL (107h):
	ADAPTIVE_SYNC_SDP_EN (bit 6)
		For sink devices that support Adaptive-Sync operation
		and Panel Replay

DPRX_FEATURE_ENUMERATION_LIST_CONT_1 (2214h):
	ADAPTIVE_SYNC_SDP_SUPPORTED (bit 0)
		Bit to check sink device has Adaptive-Sync capability
	AS_SDP_FIRST_HALF_LINE_OR_3840_PIXEL_CYCLE_WINDOW_NOT_SUPPORTED (bit 1)
		A sink device that clears this bit will generate VSync pulse
		leading edge of the HDMI output on the line count at which
		Adaptive-Sync SDP is received as long as source device transmits
		Adaptive-Sync SDP either in first line or first 3840 pixel cycles
		of the line whichever occurs first.
	VSC_EXT_SDP_FRAMEWORK_VERSION_1_SUPPORTED (bit 4)
		Bit to check sink device has SDP framework version 1 capability
---
 include/drm/display/drm_dp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 4d0abe4c7ea9..4f33b6aeb91e 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -603,6 +603,7 @@
 
 #define DP_DOWNSPREAD_CTRL		    0x107
 # define DP_SPREAD_AMP_0_5		    (1 << 4)
+# define DP_ADAPTIVE_SYNC_SDP_EN            (1 << 6)
 # define DP_MSA_TIMING_PAR_IGNORE_EN	    (1 << 7) /* eDP */
 
 #define DP_MAIN_LINK_CHANNEL_CODING_SET	    0x108
@@ -1105,6 +1106,11 @@
 # define DP_VSC_EXT_CEA_SDP_SUPPORTED			(1 << 6)  /* DP 1.4 */
 # define DP_VSC_EXT_CEA_SDP_CHAINING_SUPPORTED		(1 << 7)  /* DP 1.4 */
 
+#define DP_DPRX_FEATURE_ENUMERATION_LIST_CONT_1         0x2214 /* 2.0 E11 */
+# define DP_ADAPTIVE_SYNC_SDP_SUPPORTED    (1 << 0)
+# define DP_AS_SDP_FIRST_HALF_LINE_OR_3840_PIXEL_CYCLE_WINDOW_NOT_SUPPORTED (1 << 1)
+# define DP_VSC_EXT_SDP_FRAMEWORK_VERSION_1_SUPPORTED  (1 << 4)
+
 #define DP_128B132B_SUPPORTED_LINK_RATES       0x2215 /* 2.0 */
 # define DP_UHBR10                             (1 << 0)
 # define DP_UHBR20                             (1 << 1)
-- 
2.20.1

