Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB81FC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48184112C0C;
	Mon, 22 Apr 2024 15:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qrJK9/WS";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56E7112C0C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:32:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYH1/UNBNaeLu0OyLMsSvbeCXRnB9TrS4QDImV9L/z3ADcurOQfPixO3KchK1Z57T1xfXtqYT+TzrwgemBB8x/snY2V/F9fKlJtPk4pVGVVmRGq9hZYt561CIF+IXAYKSWrlavT4xvleX1IZqc9q4VXRWKqLCJMAbcpPzcS+wICjkcqlpSTcpO2Q7Z8VtrO23BjbwJG1DYyFuXaCfjElWPj2x8/HD8/wAFX+LQobNsfrzERRr6JM3ahPPruCSeeihsdkyRZ25lmvtxpaI5EXY6hYlbhT3FOewVWPqXMkPcGY/rpKw7GgXkK6S//Sp7RDmyQ4kddcRwhdtKksE7B4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzLrntLrlBbq8iNFnYYGot6S6/ZOoBmaUXMlYQvLTkM=;
 b=gDkrE5TtYEBLziStUl4aJO1REMdBjOjA4jhN6uZULEKj2DYBDdzH+MwssKVpm+xMvZb9FS6tdfYkEBn8bGzymdbrUKmmXm1vMRKxliINpMkAJyiqhcglohqkEPYcw4ejSNyQYbJKbdaJJrDEIkmV1/wqRF6aRCmK1U9Q+v3QDT+H0M8r76kAn6wu7HegYy/2QE7/TJmS+Uv2qTwjE5E41wZDf5g6sXmFAdel3ymNqBnmT8g6Fe+WVo7ARoLfUiHkAfZRVGLfj8VAplQqoumOS7aldn3C2YAX6fjR+xKozNiaEM8QXduka2OpLD7ie+J3G8nCZ0qjFSjzJ/LmIPCp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzLrntLrlBbq8iNFnYYGot6S6/ZOoBmaUXMlYQvLTkM=;
 b=qrJK9/WSGlouAp3IHWqOP5ZLQxG95WLrR5ugxVvhc2NSc3S0lKdM1tgpuRxsEF+JTVy47qJeHlPQzq9TP1W+ijVzTMxw3hwLIjyK6WHVOsosxP6NkFcCPS7ALfuKFFHELLnmhLz3Y3c7yenC8PU0f/X8BwlJitY5Y0xOPoPpmEQ=
Received: from CH0PR03CA0331.namprd03.prod.outlook.com (2603:10b6:610:11a::22)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:32:00 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::9a) by CH0PR03CA0331.outlook.office365.com
 (2603:10b6:610:11a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 15:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:31:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:31:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:31:59 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:31:53 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Anthony Koo
 <anthony.koo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>
Subject: [PATCH 36/37] drm/amd/display: [FW Promotion] Release 0.0.214.0
Date: Mon, 22 Apr 2024 11:27:45 -0400
Message-ID: <20240422152817.2765349-37-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: ee624861-fdc7-4653-dc08-08dc62e15a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mUfR2nlAIKJPF941Wft6rhkB11M5cySAtkZ3MoCHvOZBx635vF/bx8cgFK7b?=
 =?us-ascii?Q?duR2bOcFl3e6Kkf+fWSfYydwYPIH6YQ6bTirBeWBjcmiJyOP+M/iqgZJBSAu?=
 =?us-ascii?Q?va4v5JVfCxV3cBiTA3b6aWe/wjs6lJn0jHGwPGHXWqKYjmGstqvaacPUMjWD?=
 =?us-ascii?Q?KUH2qCR3s1zaOnnQ4S0+5bG8LaOXd87JDwbQUkUcRZJ+v8JdsyIg4qZ5XvTa?=
 =?us-ascii?Q?J/8VT+1FWS6PUzrJMQtOzP/oywCrDC+K+1B2v6phOKNoxQ+ZQKab537N0xAG?=
 =?us-ascii?Q?/bKNSCVrVwjG75YMHKZ9RPpgjv3kyBm4AUNpGXKGfaNzqk/aUZjt/QGQ4ykH?=
 =?us-ascii?Q?/5J7nqHpHaz6ekA4dRYMGETtWkU7OvyEHSWQ2zeDYlDSk2lNaNQUcjINare1?=
 =?us-ascii?Q?F7aKjwli4KYhr86OXP3YCemj/3b71uQewuh6572Po+ve7Uv42cI4sVAXJyoa?=
 =?us-ascii?Q?j74URkbdbslxGHxUMp08HtWsPufMlS55BhMHJAhG1r5H4US4i5neQLIYQxS7?=
 =?us-ascii?Q?cG15KDYImd0uMVJYbyOyqnds5dm247qfilDB0VyybVhtO388t9Pz4X33Uavb?=
 =?us-ascii?Q?RYg6Ff1czG5IcBfqjwvMGgHOM9f27TuWHrSXsdadbCzU24y7b6deq0gZ8Kd3?=
 =?us-ascii?Q?+323Pa2BNq3LSAckJvuHNC3YvLqFXGBguW2Z4fmuGZLk2l/A9hYJcFQZ1M4Y?=
 =?us-ascii?Q?//zt2t1rD77R8PGNp2WU2uquQ43M5gPNnUa0CDBs5dG1BXS0lriogW2suy/T?=
 =?us-ascii?Q?2hzXqwhlkmnS7WhqH99Uwj3y9yTGvtBAygZw2pv+TY6IwJVOwXbNLO5mjzgK?=
 =?us-ascii?Q?Yje8nRnlKC0lUPaOrEn+bwRoqzeXTD1SjJr9PYzUB0nXYnlQgDDF5lThP5Kj?=
 =?us-ascii?Q?rw7kHBnBhSAXWwQcQLCrkb9W3x+vN7g1GPKOXxDTXoNLrF808T7nKzQzPX3k?=
 =?us-ascii?Q?Ql4nhtOmX0MLzc2aLFC+fnsfpb/uQ1zufQPrKuPgLvN71ERP2T9Vm6PGGhtx?=
 =?us-ascii?Q?ZL376KNcWBL9dw7G727mGQZ13QJ9ocsUeAgoIWxlgUNH0lFY/yhzsNg53mK0?=
 =?us-ascii?Q?NXm402n2X/ZP9Ab5fLUhzlS77S5Wcwf7wAKrdHZ/8Y/py6ZoT+G9Iq/qe6EN?=
 =?us-ascii?Q?8PjLgT2Fx4aFkSW9N2CQBxfSsZAghHkTDMkTitK/VWNWhwi0+0X6XyEeISIc?=
 =?us-ascii?Q?hadAk+pXjJWRfSJmwUPzY+mJCe/cL8mHSR2YStnsUhJSWnx5Ahqi1Y3hYYwN?=
 =?us-ascii?Q?EY/Ip2c0ZWW9AZ/tMyNtWXMwKRwmHF8jeFjLIDTKs6RmYs0TXvRLnYb4eNvF?=
 =?us-ascii?Q?h4YHQz0pCSpbKgmJFOSgeCTYGzYggyTvHEVN98rvyp7hHPa999t71iuOpOPF?=
 =?us-ascii?Q?70rj3VX4QnUL1hT2YX7Eoo5JE3Md?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:31:59.9785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee624861-fdc7-4653-dc08-08dc62e15a35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
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

 - Adjust the dmub_fw_boot_options reserved bits to be correct

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index bb4aed329393..7a0574e6c129 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -655,7 +655,7 @@ union dmub_fw_boot_options {
 		uint32_t ips_pg_disable: 1; /* 1 to disable ONO domains power gating*/
 		uint32_t ips_disable: 3; /* options to disable ips support*/
 		uint32_t ips_sequential_ono: 1; /**< 1 to enable sequential ONO IPS sequence */
-		uint32_t reserved : 9; /**< reserved */
+		uint32_t reserved : 8; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
-- 
2.44.0

