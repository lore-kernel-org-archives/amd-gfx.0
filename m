Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EBACA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D89810E102;
	Wed, 10 Sep 2025 05:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oIcZ/Hej";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B38E310E102
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxJPtFl4zTRJ/uvlLqMx3Q+6cbWsBkZ+vr3d7tWslXNl//0bFgZblETAzQiEBk+z+a35NjwaRafaNi3RCsQ8x1RDqoIYtphxk535GYinz5kvkL1e0RNrg3VFCK/BcnXaGRcEObPfPjsHvirIK9buFVkJxLG5hTEPhLjioD/nxcWc/FlqeplbT+e/wH5WP+LdOQ3ZeeLdtcSH1IHu8nhdWB9DiyVgptOH0nbM0FURW9DvaoSip8sSYLcGuk4GAv+7WjY3bwIj+D+DX021N43vL2hBC7TIu0PhHUUG+U9IwX+ilyUpPwfWyPJk20wH81VIUWk5V5EGJOjY/L6y47QCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYicqyiCxVmCVgCzL22UT89btPh/kgdkLD4cF4ZZ6qY=;
 b=aXh7E2QYgzRkRTV+FrkazBXpMWBHbrOg8z4cmoRcksFojxKzzbRpQbq3cUpzCSRcdmKxrl1CB2+KCwJTaQ442jBRdu6zQJLaexoA/ESIpxVHhbQcu/aCFUkn3lCpvMNU0JolsaHMEk2yq14ohjHgHYu3YgJ5nsiMt4kr55cnxygogL3bbJjcHLAi4TRJr/5sLk50cL7fvOMLhEtCjiYi0btt2xCycAXEjNvQ43jeOEa7m/uA0SZsFm2km5zQSsWg2SscqM4J8HKk34iDAm10788EOEhVhBNP96HxkAB/12CmFIxW5QC72B8iMF+DX3HScJFhF2O9aFSMXpCxAD3JZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYicqyiCxVmCVgCzL22UT89btPh/kgdkLD4cF4ZZ6qY=;
 b=oIcZ/HejnXaQCJXgCGsl1rkWJi3duYuxJ9iimvl5oIgA702I9s6vR7AG2nUAeFv1tgVgrcfEr/VNNDOAivpf1YY8q4QICwMevLzwUrwQRQESyfkshKwCQ0SqBIGYqiNEl9lnJ9zAncdZUKmyfEiB1JZMp0KE/nSm+hOIbiFqBEk=
Received: from MN2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:208:134::43)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:26:44 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:134:cafe::d8) by MN2PR16CA0030.outlook.office365.com
 (2603:10b6:208:134::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:26:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:26:43 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:26:42 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:26:39 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Zhikai Zhai
 <zhikai.zhai@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 01/15] drm/amd/display: Modify the link training policy
Date: Wed, 10 Sep 2025 13:22:03 +0800
Message-ID: <20250910052620.2884581-2-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 9502ef99-8e12-47a9-b60a-08ddf02aa0e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UhW6w0FzBPB0WBG/lCVEWWGCuBUjRWEzmwnzkNNElT98XPv6okwmepglinoP?=
 =?us-ascii?Q?ihbfOovxhvhBPVqR5aCk31FxHLaDItknCoMTHYQapDHqCXfZk0qcLRxI7kN/?=
 =?us-ascii?Q?m0PZXFOVFt4NrwOs0bG9i0KRppYglJ5bbZpIjoMZtb9Zlst+a1ehfKiRe9jO?=
 =?us-ascii?Q?BvYfha6gIyLN/4IRMBKp3kLSKAF0UJggrhn0Ivl5Br9MdoCZj+snrZ5Ac0AG?=
 =?us-ascii?Q?YF7kIH/WNzMY0FR5NA/+fDUPlfJK2mXwr3q72+iINlkC6DxHQcO89gkrK3Ye?=
 =?us-ascii?Q?/sYIgI8odFZ8f/+Gw2RfUzcDuoPydQBT1rE3q8CQexgqLFHVGqib6mCK5Ix5?=
 =?us-ascii?Q?+sLHck8BQXCUuB0K2befHreQwBsYV7sUXjAgNFvomwmlk+nQt8Tph60pku+c?=
 =?us-ascii?Q?v1/s0bkN5imeZ62V5YZ3d0oYXkuRJCFa+Z3VW8qVcuH4UPFlH6yO4sa25NvU?=
 =?us-ascii?Q?mdQsuyApfS2riLJ5hbz7hDKf0zdXSgtlliRETMvDVVtQjEcb3/e9r8E3Sl+c?=
 =?us-ascii?Q?uGW9/v8etx6XkbHeHmT/inqbCa+z7AaTc47CaMBH9Zncd3I79yusZRUSzio3?=
 =?us-ascii?Q?tQfWxSw8ZnFevX+XH6pquGjDKhQ9peOLHP3ItyqTapWyr3ZMSytzyHumJpXr?=
 =?us-ascii?Q?EIshMyHFxbmdPdnG44sQe5M3H8lrYo4ehgm+FpKUXp8VHQu7sIRfg+mTNntN?=
 =?us-ascii?Q?G8svWQIyEzTQ7yRYYG/VY+iDnhig8MUVxUpwmU6Yb/ATkfxmSF/lvKF8efPS?=
 =?us-ascii?Q?woE1aoSFtOhRJ1aLHBBuXF4koMx5//wQU5aLn4PNr0CBMVGR0BHW2x0B9hnD?=
 =?us-ascii?Q?YzrTViucp70UAnbHcn5OR36gXEX4j89osybb+eDyL50O2n009KS0xw6Flgfh?=
 =?us-ascii?Q?Nke3Gsd+B7y0ACQRn8MSXlnbhGXcCJwx4gNfh1S74y01XxMfwmpRA7rfdNxu?=
 =?us-ascii?Q?n3pe8DXmRi0U5xuLk8AC5BXMuL7vBeKQNZK1X4vjWVEa4nJTVlOsuWgw9tmz?=
 =?us-ascii?Q?M2nquZIgc1txPWDUJIvJdBXK7EtOotmbK8ixgTxp1U5Fvlbs8nS2r03iyD8d?=
 =?us-ascii?Q?3CCEcQP2NLhBeOR04xFH8A8FP//o0ZTVw7bqNEBqP1VHtBRY+k9iS67HjJjS?=
 =?us-ascii?Q?fzhT1T+UYsrbpIJ5ugFdKGyC1N5Qmw5LDttBjryJ/ELau2zvJcpT875uWO9v?=
 =?us-ascii?Q?7jKyGjf3K0VuI+eeHxXWIkVfMub9PcjF0ucyj8MTkYK539MwW03yUCuVU2yT?=
 =?us-ascii?Q?cjEne3Kc7lX5O5Fs1S1XrLEEJVyq22KL2z71wiXAvNRII4eyG8pUNFbAxzYK?=
 =?us-ascii?Q?0E6hZ6a7yEtIpp8BKCIpIoRajrBN4n9hV0RMePHZXpHTuFjHM1xj7/2633iT?=
 =?us-ascii?Q?ht2h2ctHA3SqBjvsUUb+j5OZSg9OOatkEPd+EdYgoyycwgX7wVpTxQOo7zkC?=
 =?us-ascii?Q?xIMwWvw+uKNHqBG28IRjyVCDIL5giCU+VrQi8JZ2Py6qlre/NrGoQLPS35DM?=
 =?us-ascii?Q?TSqHSFCOpdhJcjWs4HP+/jvutUvXaLvnMZwK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:26:43.4437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9502ef99-8e12-47a9-b60a-08ddf02aa0e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679
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

From: Zhikai Zhai <zhikai.zhai@amd.com>

[Why&How]
Currently fallback to low link rate if the link training
fails once on USB4. It may cause the bandwidth couldn't
satisfy the requirement of streams. Modify the policy
to do training retry in the previous few times, only
do fallback at the last time.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_training.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 134093ce5a8e..08e2b572e0ff 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1729,6 +1729,15 @@ bool perform_link_training_with_retries(
 				break;
 		}
 
+		if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+				stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST &&
+				!link->dc->config.enable_dpia_pre_training) {
+			if (j == (attempts - 1))
+				do_fallback = true;
+			else
+				do_fallback = false;
+		}
+
 		if (j == (attempts - 1)) {
 			DC_LOG_WARNING(
 				"%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) @ spread = %x : fail reason:(%d)\n",
-- 
2.43.0

