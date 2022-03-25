Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07842C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01E910E303;
	Fri, 25 Mar 2022 22:58:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 982F610E303
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGHRnQ223aDMd8J2majBEBHRfGe8gfWMMzabhQfT0IgvmC+Q2NrOdorDGza37ayi8WtXScbG3BPOtgpKsJOIcuKFOpqgb3gySe2vsmF1J1J9ck6z9rAF7mVV1s/ZAnyaTMqVqxWAMHHFrnDTx78Zm6OTfZCZLPm2gjHSsU6adrOfXnJwge3GV3WUSt4ovIMwqsD85ZTHG/+F2oz4CzhJtL2zxD2PfCHkYBAOiiZ1n4OoTDJKb18hkL5Po1ZWZR1uOPs5AISup8Jfns4dI6NgM1HoFKS2lgAhQ/XolsUlraRcRo7f9RnqmtGDaH7bI8N2VnQDZHTGXVRtiybe8a8GOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AdjSgYBrbb57pm8JG7n3JnYwG6wAvpKSjDn6RA9sNM=;
 b=L66mFIu84HogFArggDqKKEdNk4duRg7vTbpEiunhpwZI3X1jlukdtTvyFhC5syzoJTszKAL7eV60ebFlXGPcqDu51SrsS/bt1RVRpibVL3iY4MniyjmJtLOU5cipv6D95CI/fLf/B/fODRgcyzfhaKbydRXUDJiMu68LNyz9CfB/0lnT+XaKDKGAUYpbtqr4WD7bQI9uABmqnWE0TdTMNeavgvLdw+Xpr8zPKp1tEuXLd4t4OGtkYLzk6kjsiE5J5mc9maoZwbhbgn5AN75TR+e6pb0qk0J+PxtwyIDCkQUdeo6EzJsf+YN/rpaACl1fDPx3Cs1XjgKrONQ+cjuedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AdjSgYBrbb57pm8JG7n3JnYwG6wAvpKSjDn6RA9sNM=;
 b=4Pm+F5ehtVZEbiqb+XU5IDzGddIKmhFJ51HguD27yk6s9CnU4dw5hRxYiI5OO5pQMgTLvOLXyeQo8mgHgr3E1848WK22PEPovwGFZZWWqFSGHO5hBUHOrRfrb4x9ZJjw2/gs8+xwJKnzbwgmU7Ck++5hp88ibP1R4tH1vJ/iJeg=
Received: from MW4PR04CA0065.namprd04.prod.outlook.com (2603:10b6:303:6b::10)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:13c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 22:57:55 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::e9) by MW4PR04CA0065.outlook.office365.com
 (2603:10b6:303:6b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Fri, 25 Mar 2022 22:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:57:55 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:57:52 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: [FW Promotion] Release 0.0.110.0
Date: Fri, 25 Mar 2022 16:54:00 -0600
Message-ID: <20220325225402.469841-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e91f49fe-72de-47b3-aca6-08da0eb2e60d
X-MS-TrafficTypeDiagnostic: PH7PR12MB5688:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB56882A38A47B3F4E195E5F3CF71A9@PH7PR12MB5688.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1CcW/KakyDUSZAY0oGae4b5151Kkh+7TCT8wtsS4x/bARNpVYm7oVllCXwlWSqipbYJbjYGHOd6GjzjSGY84mpSQCVWHmNAEvaVT6ANvcg6t2VgoNI+dnCJdOfrUQzr1m3HTBoPntRyQIWfzD33VS3KmJIZGPEv5tt+S5QlKJNnhnZbWfs+tsPqU3FHV0GIgbzkkPf6FNbqGYlMuWR8CN+XZhzB9XQ4+RboJnFIvPMwgClDCIKTr97ngfrxG2T4dfM6gE0DSVN4e3EaNn8Yif9Ot8Z2XLhz9UDzM7La2Y0BDF6TEomC+nilvo7Lu88Cx/gGvTKsqx6jqT/gCHkisWwqmfk1cEMjQX84Wz2MFzhbZFlV7QgOlckWBCnC54+pG4T3tUV99wtBqIYt/i/JXb3H/6lg0uMkDOgHYRYvk+uc3uw3a5grriNnsMp1YSpruNXmTi8LDeEZUnjdEAes638g4ojrhlJMkSveHuYeI8YE9b/aFL6a+rbBGJgjRd0V8OnzgIWzaIP52fY1nvKAk/PG6KXJJLfEB/Me1PY6vYSH2lUwGWhFDAhBVTNk8XTXDIMWOJO9wqDhJDON85VHJQJl7oHykcjTemEPWTNKPhfZSnIekeiskDksNDZXG45tVr5rSOR6Zjz9udRXD1YQuM/nyP1XfD3sYdLU9CBly9ASzLJDvryiAIGEYkeyfS6J/vbOhfWx+loGKHwBtsTI4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(8676002)(5660300002)(1076003)(8936002)(186003)(508600001)(86362001)(2616005)(16526019)(26005)(316002)(70206006)(356005)(70586007)(81166007)(426003)(4326008)(44832011)(336012)(36860700001)(6916009)(36756003)(2906002)(54906003)(82310400004)(47076005)(6666004)(7696005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:57:55.1095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e91f49fe-72de-47b3-aca6-08da0eb2e60d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

 - Revert save/restore PANEL_PWRSEQ_REF_DIV2 and
 other psr phy optimizations

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 90 +------------------
 1 file changed, 4 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ce773b56a778..9b5db16b2619 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -46,10 +46,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x51b95a35
+#define DMUB_FW_VERSION_GIT_HASH 0x19edd13d
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 109
+#define DMUB_FW_VERSION_REVISION 110
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -1450,81 +1450,6 @@ enum dmub_cmd_mall_type {
 	DMUB_CMD__MALL_ACTION_NO_DF_REQ = 3,
 };
 
-/**
- * PHY Link rate for DP.
- */
-enum phy_link_rate {
-	/**
-	 * not supported.
-	 */
-	PHY_RATE_UNKNOWN = 0,
-	/**
-	 * Rate_1 (RBR)	- 1.62 Gbps/Lane
-	 */
-	PHY_RATE_162 = 1,
-	/**
-	 * Rate_2		- 2.16 Gbps/Lane
-	 */
-	PHY_RATE_216 = 2,
-	/**
-	 * Rate_3		- 2.43 Gbps/Lane
-	 */
-	PHY_RATE_243 = 3,
-	/**
-	 * Rate_4 (HBR)	- 2.70 Gbps/Lane
-	 */
-	PHY_RATE_270 = 4,
-	/**
-	 * Rate_5 (RBR2)- 3.24 Gbps/Lane
-	 */
-	PHY_RATE_324 = 5,
-	/**
-	 * Rate_6		- 4.32 Gbps/Lane
-	 */
-	PHY_RATE_432 = 6,
-	/**
-	 * Rate_7 (HBR2)- 5.40 Gbps/Lane
-	 */
-	PHY_RATE_540 = 7,
-	/**
-	 * Rate_8 (HBR3)- 8.10 Gbps/Lane
-	 */
-	PHY_RATE_810 = 8,
-	/**
-	 * UHBR10 - 10.0 Gbps/Lane
-	 */
-	PHY_RATE_1000 = 9,
-	/**
-	 * UHBR13.5 - 13.5 Gbps/Lane
-	 */
-	PHY_RATE_1350 = 10,
-	/**
-	 * UHBR10 - 20.0 Gbps/Lane
-	 */
-	PHY_RATE_2000 = 11,
-};
-
-/**
- * enum dmub_phy_fsm_state - PHY FSM states.
- * PHY FSM state to transit to during PSR enable/disable.
- */
-enum dmub_phy_fsm_state {
-	DMUB_PHY_FSM_POWER_UP_DEFAULT = 0,
-	DMUB_PHY_FSM_RESET,
-	DMUB_PHY_FSM_RESET_RELEASED,
-	DMUB_PHY_FSM_SRAM_LOAD_DONE,
-	DMUB_PHY_FSM_INITIALIZED,
-	DMUB_PHY_FSM_CALIBRATED,
-	DMUB_PHY_FSM_CALIBRATED_LP,
-	DMUB_PHY_FSM_CALIBRATED_PG,
-	DMUB_PHY_FSM_POWER_DOWN,
-	DMUB_PHY_FSM_PLL_EN,
-	DMUB_PHY_FSM_TX_EN,
-	DMUB_PHY_FSM_FAST_LP,
-};
-
-
-
 /**
  * Data passed from driver to FW in a DMUB_CMD__PSR_COPY_SETTINGS command.
  */
@@ -1772,16 +1697,9 @@ struct dmub_cmd_psr_force_static_data {
 	 */
 	uint8_t panel_inst;
 	/**
-	 * Phy state to enter.
-	 * Values to use are defined in dmub_phy_fsm_state
-	 */
-	uint8_t phy_fsm_state;
-	/**
-	 * Phy rate for DP - RBR/HBR/HBR2/HBR3.
-	 * Set this using enum phy_link_rate.
-	 * This does not support HDMI/DP2 for now.
+	 * Explicit padding to 4 byte boundary.
 	 */
-	uint8_t phy_rate;
+	uint8_t pad[2];
 };
 
 /**
-- 
2.35.1

