Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69086CA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 00:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D891010E54A;
	Tue,  2 Sep 2025 00:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nN87YBR6";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 222C210E54A
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 00:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbckQPS6kOXO/65O6Ycqlj5SjRHTxznOZ3wrkgT36RkUjzvjIWg4qWLIEO4FCsj6HXP1FSMlEHQ0WF6rI6PLWFjj4ZrT8vlmWaRbTv+tseI8FWK4FWLl546Pn2XyWjdzgN17dOAFWS73A/c9lcZHM/wX18DwTUrk3oMj47utImDOovpTSNIe7h0Sq+566UlArvALSznvUdINO5y/YTMAVv2kDZNU9tXKpdAT+eZxdDbjveQQ4iePi9YAayU58RVEb1tDhE51cSnV7Tv0PIBhCzBt78Y82e86avUhxW5k+g+GGNq2Kp3iLYzGD0cXMN0O0EkBusZvvuse9kIZs0m4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFfek4QlLFXMed0Y6v0IFNBcGnOsm7QkaMWlA1kIPiE=;
 b=vShPUpiqv7vZnrOdZbWdk1pzQS+6sJcf4Q5PBddzzAIwP1bUn2uWN2c7jAIQKveDxRx4Nx5JE6zjfE5pjKejoBFx+EP9xQ2CkuRq4ysLjYlvM94a/KyhGxsROQdqoCn1j8wttXmrbaKOf9UoPsbkcSdh5adNZkBNSO24fAZUL0KRoOmL/qR37OaAvgMJ0cQmagQ8PMWEek6YRvu7+UdILKmCfTSSYkGoLJBF2A01tn0nmK8ziQl8XhR+cKytXask05mdKhlgkxj2v2IP2xopjKOGUhj4/ZH/aJaiKpqa+6df5qnNqR+J8Ja/IIiUuflzYUExFqDPL2zSvMNgWNbOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFfek4QlLFXMed0Y6v0IFNBcGnOsm7QkaMWlA1kIPiE=;
 b=nN87YBR6/ipR1083zk7pntUa0Y9D9nCouGC/28lJ8T7VLnyEeWcebkIoJcO1wzszcFKE8wQboj2fSjW9xGc6YmE/1DaN8N1W46jTflOREf765/WWMlhY3c/IvSVUIHh/CauQQ7GctPDB6My0JRdMWqoLWE1C6dYS72zkySFCVnA=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 00:46:29 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::ee) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 00:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 2 Sep 2025 00:46:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:46:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:46:27 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Sep 2025 19:46:21 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Allen Li <wei-guang.li@amd.com>, Robin Chen
 <robin.chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 05/11] drm/amd/display: Read DPCD to obtain eDP capability
 information.
Date: Tue, 2 Sep 2025 08:42:50 +0800
Message-ID: <20250902004532.1833436-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902004532.1833436-1-Wayne.Lin@amd.com>
References: <20250902004532.1833436-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: d72c5e9f-812c-47ac-07aa-08dde9ba2701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+1Z2lOyrdJ74AqMn63l6BIVKrNRFQ2f4OgrmRG2KIDVPpULhteMM/B/ilPyg?=
 =?us-ascii?Q?QfDUIGINDD/l80acHCMUOPrbDZAR6LSV58u7w77oVVT6BnnN5J18+JOTbnYV?=
 =?us-ascii?Q?OZnh2XuP1eK1WeqUlNpXjFAwDVI/hpD0vQCuziGAiz5vJ50wHbcP1FBT8yxg?=
 =?us-ascii?Q?2VL+LTPdcI9GfVHNiSxtjYWKe43z4JPdzG3PQ083Oy5sKhq9RJ+QI981+yth?=
 =?us-ascii?Q?nkl4jS1bOb7zN/t1w5EMiX1QGkz2sJsBDKZRZeo9GuH47RUSAyI5r9jTTo4Y?=
 =?us-ascii?Q?aRzt+c1bc7rioQQqvzITl1NQabBaSG5Xct/XU4eyH1uisi0WFxXYivb6RXbq?=
 =?us-ascii?Q?i8eGT4arPcSH9K4WkDWUdducGcNZd+aaSubKQ9TV9TPC7IAgEpFXeMSOa/rJ?=
 =?us-ascii?Q?8D9kJL7nx4pmC2ZPQ9dLrqdgc/IlMEeSVp92ERVDNOhIViLJC52VusMa6Doy?=
 =?us-ascii?Q?as60bVrLWCbJlKeRvnxSG3eyQ4i3NWq/l5mFAY9C6Z36koxd93MygX/94Ogj?=
 =?us-ascii?Q?tdNeW1QqMz2UgIokgwV9T7zUJvCjOr0MOqFi4A5RuRMqDgoaEgHX6A7vViKc?=
 =?us-ascii?Q?DNdQUUTYoUzlhSp9Jf7Irerj8nJC9l2ISNpZZHHEEtZig4rPTwpnbqZId+SO?=
 =?us-ascii?Q?nR/jOs5jJ+EtxUgtmCECtZLssE9GA3QcAgb/EaeDZK0fpjytzdkzN9c8Thts?=
 =?us-ascii?Q?U7dpvG0iv0diHv/S5NDN+scva8UJZWqanUNWDtbzUo5lcZNng3HhgRY16taF?=
 =?us-ascii?Q?/8aUneCBLH0uDP7ikdeoV/3kZKdKvVjYPuzvwN4MUa2fN4XPXp8bw7hhIVMe?=
 =?us-ascii?Q?SFwnwm9cU/dhjhiV0QfSu/aJLhPT8PrHAqCifFWZHDf7/gkb2k5U5UGVI8Tj?=
 =?us-ascii?Q?orgnUwftJOM+YtXzk0ruh6KEI9o2x/tzOXux0iQAcWT3FOcVtF1/IRwij9v2?=
 =?us-ascii?Q?mY0q6EPRXQQ01mijhEBFdtCBykI4EYKozGMP8BPGnBB0ETPE91IpEE4HTnt2?=
 =?us-ascii?Q?xAgapzUhededS4KfDkZS5t6P8J84U5RDcantRsIv4U3jqRIA44FsXJK0UBJx?=
 =?us-ascii?Q?sIr9W9PTUtDf7ovRnNWVkan3205uSAzOqwqWZ4TB3XxaJF9e2rIhdnmSSJ2y?=
 =?us-ascii?Q?STMBaUjnOt1d/y+7WBDWf8fs7de+8qAtdDc5gBSD5pgTztiHr7jQL3XIn4IQ?=
 =?us-ascii?Q?YsHyi/aMt6zMka6fmGCKw9Erxo4J+Ui1yW7choUpV6WKh9MCv4WeQmwVdsDu?=
 =?us-ascii?Q?aXB5XQGurPln214LgdVLnc4CXXHA5G5y5JSZbMELfJKIlgrzXfCUSqzCTYPA?=
 =?us-ascii?Q?6f/JsCErp8ohr5n4AFn+f3T+4zaK2jK/oIVmRUEVuKeC3Yn+c5z4YB893AQs?=
 =?us-ascii?Q?B/udfz3tKn6igc+/AiTaPRlfENcxHKagx9msWtxFiIatasSHHEM577Sgp1qE?=
 =?us-ascii?Q?2EuhHUIFqLu8PyUVSc27lm0CD9JikyP7dRxa27AVxebqzSSnb0Hp/TGLLpR2?=
 =?us-ascii?Q?BO7IVT12ac8/tIkTX8VC1VGY7YkhGuEfBS7QW3M1D8vHsIyyPxJ+bypBGA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 00:46:28.3167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d72c5e9f-812c-47ac-07aa-08dde9ba2701
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542
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

From: Allen Li <wei-guang.li@amd.com>

[Why & How]
Extend to read eDP general capability 2 in detect_edp_sink_caps().

Reviewed-by: Robin Chen <robin.chen@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Allen Li <wei-guang.li@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h                | 1 +
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 3a3ec38cdf8b..db669ccb1d58 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1284,6 +1284,7 @@ struct dpcd_caps {
 	union dp_receive_port0_cap receive_port0_cap;
 	/* Indicates the number of SST links supported by MSO (Multi-Stream Output) */
 	uint8_t mso_cap_sst_links_supported;
+	uint8_t dp_edp_general_cap_2;
 };
 
 union dpcd_sink_ext_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index caddb7dfb133..b12c11bd6a14 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2195,6 +2195,12 @@ void detect_edp_sink_caps(struct dc_link *link)
 			DP_EDP_MSO_LINK_CAPABILITIES,
 			(uint8_t *)&link->dpcd_caps.mso_cap_sst_links_supported,
 			sizeof(link->dpcd_caps.mso_cap_sst_links_supported));
+	/*
+	 * Read eDP general capability 2
+	 */
+	core_link_read_dpcd(link, DP_EDP_GENERAL_CAP_2,
+			(uint8_t *)&link->dpcd_caps.dp_edp_general_cap_2,
+			sizeof(link->dpcd_caps.dp_edp_general_cap_2));
 }
 
 bool dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_settings *max_link_enc_cap)
-- 
2.43.0

