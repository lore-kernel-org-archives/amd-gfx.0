Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF98C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB00D10EF06;
	Wed, 20 Mar 2024 06:37:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hUFnjDD5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81BB10EFEC
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOHEvLQJULlLwLlsZ52HL9zLvyupu8Egg2qK2hCOdoiZ13+ZXGYo5Iuxhxg//zLBP9xXMz7CzhmIcNBY8Qua9zdmmjST5irn2ly97OSXIE084T6V0zf3Zn7/ux5uKO73f1NhY5SVDU8OpCwq4KiDM6Q2LEAUSr03bAgZwyjrlTHi8/rkZfhvfsInGTSCEEEGqFrT5/GLEtYUYGp4qbelGcimwUXooYe2XJj6vxxx/XltabRKPsyPS8KL8lVyZJNXn+7V5MJkem/R9rutIzsW7CcdjNQXYrhyOs+XK8dg/RvrSv2mEqckr4dye4IsI498LWUzcka2Id6QAIBAJLJSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NzYean5WdqnaV05LxNGwnoZMC0mwtldcjGCbyeRqeU=;
 b=j2EEmyfiHrH/JgYH0fOk68J5kJd3gdTakIqZBdjGLHKC61Ru5zY+RwsgyBYlCE/hROsFWZ01E2wXQXB0XvJjxqf9j996PemEh3LpzfG6Dny0+hI2hud4/m9vILJ21h0RNPgqdqyEEtItxoLf8+4sdI2JkJ6RxHQXE4iFVxG+3xjJVrhcQxyJmfD6xchovP2BlyMQTnLVKhFYg4QKlS8KAnNMFaoVFlzGayJ9u9scqWltcXk8sH1JHFbVAh/X133USGuAvXhuWHlRqrDQ5xu06e8OytNJRVX/2BVIef0zHoiR8MlUrsCOABhZI6SoYroqyT5NkQurRnBfDNjgq4R0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NzYean5WdqnaV05LxNGwnoZMC0mwtldcjGCbyeRqeU=;
 b=hUFnjDD54p0S4rESfD3PUYUMj9MH2DorKwBxsdkKQqX7nIYg44p0EX3hS+gxU2rtsU7CbH1KSCXo/z00XQxj7l5Z/PnqQyExpkqBcW2U3xpEK829B55dmg9Ix2Ok0iCyxe6nJ24MKSLnpsKqHm6DUGaqAZVAPlFGKxKXtkrsTNQ=
Received: from BLAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:32b::26)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 06:37:25 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::e3) by BLAPR03CA0021.outlook.office365.com
 (2603:10b6:208:32b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Wed, 20 Mar 2024 06:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:37:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:37:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:37:24 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:37:21 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 20/22] drm/amd/display: [FW Promotion] Release 0.0.210.0
Date: Wed, 20 Mar 2024 14:35:54 +0800
Message-ID: <20240320063556.1326615-21-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6a52fb-0a54-444c-5373-08dc48a834ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rH8UbaW/SJW/Zm5wslRhW2z5gIxKORmP/OJwItCx3YYd+/EParZnmVVgoaM6GrcgVsyFDohDX/Gz1Fv7BjOW6anIQC69T2ilscVJ4Ng+5vWkN4PSGRAEx0afQ2Dah07SgfuS2WtqPzL+E7Hea5VGwjQCyVPsRfwmMvfWu0/LDFH6VI37nTz8aWmB+fI3tubvbatV2W9+vU9czYdZm1SrY+9Dg/iIbUDRu5r52Iti5xJPBt4DWkCyUlj6/u7Aj8Mpg0yblPg0I7hkAB12Hdj+pyC7Vxhg8RWX3esBoc1K2RwCC0/7wNgdEQiWeU1HxhEcyB+OW5Xuo6IZFOUj7ynLFCZ71VVbKF0PvA10aGW39+HgIUa+gIfPE0Cs1R6TchMCb0D/tZqHXfuiXJ7J8GrWAfXb9ZxX5rA7i5p9Pz+ROf1HSyCPkLp1dFnGMpbvUnDWhh/+u5Muv2JBnd/Kg0Fq0Ml0iIAdF44g6s+OQUzZpiO0qs5GBSThvXiEct+8xmhlcTnf39Hg/SvBhDXVX49CCxKf0BbhsSjcypkINUpD0YWNXVIGyBXIjwYL/vm7F3J6axtYr+9RlQlnbzEzTNXv7hTlYB/RAOkXuMZuOTsg6C55nfuzeJTpSv4mZgZCenUeLpI6hSzLYGXwZob0FkdM9hVpzMYRFNOAb9a5J3mgnNHttkMkhk3FkZfvO+umuGu6X+56zix7iVgaeKM0jiVlly/I7EfmcCz8ZhK+X5nmDRcTGcXx2cUxawK4r1o/jjq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:37:25.4647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6a52fb-0a54-444c-5373-08dc48a834ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

 - Add Display PHY FSM command interface for automated testing

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 995a54459335..3bd9911b6f3a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -824,6 +824,10 @@ enum dmub_cmd_vbios_type {
 	 * Query DP alt status on a transmitter.
 	 */
 	DMUB_CMD__VBIOS_TRANSMITTER_QUERY_DP_ALT  = 26,
+	/**
+	 * Control PHY FSM
+	 */
+	DMUB_CMD__VBIOS_TRANSMITTER_SET_PHY_FSM  = 29,
 	/**
 	 * Controls domain power gating
 	 */
@@ -2345,6 +2349,7 @@ enum dmub_phy_fsm_state {
 	DMUB_PHY_FSM_POWER_DOWN,
 	DMUB_PHY_FSM_PLL_EN,
 	DMUB_PHY_FSM_TX_EN,
+	DMUB_PHY_FSM_TX_EN_TEST_MODE,
 	DMUB_PHY_FSM_FAST_LP,
 	DMUB_PHY_FSM_P2_PLL_OFF_CPM,
 	DMUB_PHY_FSM_P2_PLL_OFF_PG,
@@ -3494,7 +3499,7 @@ enum hw_lock_client {
 	/**
 	 * Replay is the client of HW Lock Manager.
 	 */
-	HW_LOCK_CLIENT_REPLAY           = 4,
+	HW_LOCK_CLIENT_REPLAY		= 4,
 	/**
 	 * Invalid client.
 	 */
@@ -4188,6 +4193,34 @@ struct dmub_rb_cmd_transmitter_query_dp_alt {
 	struct dmub_rb_cmd_transmitter_query_dp_alt_data data; /**< payload */
 };
 
+struct phy_test_mode {
+	uint8_t mode;
+	uint8_t pat0;
+	uint8_t pad[2];
+};
+
+/**
+ * Data passed in/out in a DMUB_CMD__VBIOS_TRANSMITTER_SET_PHY_FSM command.
+ */
+struct dmub_rb_cmd_transmitter_set_phy_fsm_data {
+	uint8_t phy_id; /**< 0=UNIPHYA, 1=UNIPHYB, 2=UNIPHYC, 3=UNIPHYD, 4=UNIPHYE, 5=UNIPHYF */
+	uint8_t mode; /**< HDMI/DP/DP2 etc */
+	uint8_t lane_num; /**< Number of lanes */
+	uint32_t symclk_100Hz; /**< PLL symclock in 100hz */
+	struct phy_test_mode test_mode;
+	enum dmub_phy_fsm_state state;
+	uint32_t status;
+	uint8_t pad;
+};
+
+/**
+ * Definition of a DMUB_CMD__VBIOS_TRANSMITTER_SET_PHY_FSM command.
+ */
+struct dmub_rb_cmd_transmitter_set_phy_fsm {
+	struct dmub_cmd_header header; /**< header */
+	struct dmub_rb_cmd_transmitter_set_phy_fsm_data data; /**< payload */
+};
+
 /**
  * Maximum number of bytes a chunk sent to DMUB for parsing
  */
@@ -4558,6 +4591,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__VBIOS_TRANSMITTER_QUERY_DP_ALT command.
 	 */
 	struct dmub_rb_cmd_transmitter_query_dp_alt query_dp_alt;
+	/**
+	 * Definition of a DMUB_CMD__VBIOS_TRANSMITTER_SET_PHY_FSM command.
+	 */
+	struct dmub_rb_cmd_transmitter_set_phy_fsm set_phy_fsm;
 	/**
 	 * Definition of a DMUB_CMD__DPIA_DIG1_CONTROL command.
 	 */
-- 
2.34.1

