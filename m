Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37525C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFEA910E4BE;
	Tue, 30 Jul 2024 07:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g/35MH6Y";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AABEB10E4BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfBmiEovdZz9iK+n3CZ6123yi9rEA65qEtthcsQFAamQC4NwHOdXUay+tiMlNeP6ssaXmaUDt2IHZVtbrgdUAtpCGswCqDtX/1j4E0j/xrp/Bmz39wEhDJTw6ujn0s7NCctdsJkk4LnpinA+LxpmEhHjfbhiUn/XetiQBPkQSiD8yy0JkfrbWaA/djBOWAjNTFooIAKwiRYMBA2fo28UM/WB4JBfeVYzy0Le+t7c/5NSr7sA3hD7uxaweFG/lHrtcheI97Es1599GDEUucw5VosebUGCz4tWmJAy3T9+WIM0TBOOq4ZFdYKDnKyj1drHWZi6U7HKvFqm14ANhjzFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dq2TqKCzzCz32BayATwe2PBzWOZBzyRmCmCxBAvRrzU=;
 b=s4vm1mLgefgsgsFNd10nVLF+C3BnGPmKPs8CayWmjQxhiaythR6aimCCub42/aqaf0BjevYLvy0oi6DEfVYQha6XaJMnYuG22Qke2bSSYg23Wj/eb8eigT0Ti9TW0w8KRO5u8Zp0XMmo65wOzQLi6hcheVbeQRsCQbYZG8WTt6aCpSo8kKxctt8Dryw/5CAdIR5O3ujiL1PA2+pDEZhj/0HfVyhP44MkAbo6CqOCo2N7ApLWRhf3+p80vG6jDlAEIo3z3+vyHLgLC8bqKJg9GIwGXX6IRHHeBJwNBqDmuCwXCyrGC0cdZIkoaYFhA4as5T53wDpp/hmph/K3SkgUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dq2TqKCzzCz32BayATwe2PBzWOZBzyRmCmCxBAvRrzU=;
 b=g/35MH6YmHdPbUFjx1/ag5lPUx9S3e0zXF/8TXCeft8xG0Wr9aBPUNPwvhzORyzAyibgswxP2j3/PDZJoq3WJ+9O9RjngKcxH24P83bd5fePxHa9T9/zqcjrJmX44OV1Lla6d64sJKy6lYGpFtpSGO/M9cc4qw718VDPFqk7dp4=
Received: from CH0PR03CA0301.namprd03.prod.outlook.com (2603:10b6:610:118::11)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 07:20:51 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::73) by CH0PR03CA0301.outlook.office365.com
 (2603:10b6:610:118::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 07:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:20:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:20:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:20:49 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:20:32 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Fangzhi Zuo
 <Jerry.Zuo@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 10/22] drm/amd/display: Print Pcon FRL Link BW in Debug Message
Date: Tue, 30 Jul 2024 15:18:31 +0800
Message-ID: <20240730071843.880430-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: cf82d7fb-007b-4a2e-c7c5-08dcb0682418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/CqkpmClvPL1Lqx0Ar6OfLqOzdKN7j8BgIa2euP8vniXNFqz7L5u5r1lDFfJ?=
 =?us-ascii?Q?4cCcUJFKOTt446g0yBlSuS+a3Smdw5HHNGAOHbF3ysjjfjToDIKwh/e+0EqG?=
 =?us-ascii?Q?xkVHkHzseYiQZTBea1ZmNqbQpPB0vGNv23z2lgzuOoRhnKezXpWKsgaVXz6u?=
 =?us-ascii?Q?W0G2z9wGE0B3agmGcNLQXBI0X994c3abofCcAZRCM7VTSuhmzvIZZJMndwUz?=
 =?us-ascii?Q?yUTCJ7OyQKUViG+AebV17KdWr+T/p36ld+S3N7+7zQt05+mOSCwOzv8XgwRA?=
 =?us-ascii?Q?ZKx9uiv3kvwU679J5UtHkPHcXXDoSCuX8HkZbjit3QgkKw854/UH9Lj+7VaM?=
 =?us-ascii?Q?yRW4dY7U86ewIFBpZOdElK2PIm622ssSfc8VXQpZtkzP9TubA/8Y9ZXb22vm?=
 =?us-ascii?Q?yQaToMgKG1Q7bqglIT6HtP7w0SNgSvcTAJrFdYixqUSRhXNsOcrTdum0wujs?=
 =?us-ascii?Q?COqOyr32F8BYCl1VmRPyPcFCF915wOviEvfaoE3zbKTggZlH9JmRRr6bDKFo?=
 =?us-ascii?Q?YRnGdEM886Pc4MlIacGEIMFMdWHLU8rncbx+tD3LFHT0idUtPbnyCjtS+DhS?=
 =?us-ascii?Q?EGpmajiSfUp1/6OMDdY3zQ33ikYSeakzRtev1VfIWR/eGZP3Ee7+BrINFbFc?=
 =?us-ascii?Q?aNuCyZAp9A7Rpw+URfJr29yqq88Kex+6d6t+YPGtMFVHO9uvTwkSHieCPC49?=
 =?us-ascii?Q?eFeaawy40kw3zsFrYwc0SABvA+292dYQx5IS+9B4GUdo+HB/jjCbNLeKBD19?=
 =?us-ascii?Q?7fUlctrIMz1FWjEMo/V1gWLw2Ij3JZu+6y8kZeZFcOdRKeRmieK/AhLocpOD?=
 =?us-ascii?Q?hWCr9dBIgu8XHkh5DFJtqDqVUhcTLWrO1cyQGpGw44CSdK+aRFOIJIjw9mW8?=
 =?us-ascii?Q?ypbe/mTugiUBddwpSTW9C+chxaGRksn/XtZdamU4GShSbRc0aRBakKmO2tdG?=
 =?us-ascii?Q?o/YgXe1vPOP25Y5rG8cEXFtcMppO7rMR+xz4UruHmbi3aBiELSULQEyjXY4Q?=
 =?us-ascii?Q?yRUbLiP/oDCNPALco42mthBcglLe64oGBubNw9PXD5eKfv0h/kcGiFfWk5Ed?=
 =?us-ascii?Q?Y33mh6thJvnLFm0f5pmXQN1XB1a9ULugtKt3wV/n4/8AwLTLhYiRkRakV3bF?=
 =?us-ascii?Q?MKEh2KsXyGkywfP3cTRvtiB4gXfMC3qhrvGQHaHE6FHQ1Ianhzmjlrrg7M1w?=
 =?us-ascii?Q?Hs4jpPqfg55ao07zrk4bUx+vbOmLYxj0ENSPkKDqsekU6gciDD9//e5mekkE?=
 =?us-ascii?Q?0hvopXoFnlhVT4GIfteKvoF32Zi4yygXbdzLOhuueS4PedQ0z9XwZVshEeyz?=
 =?us-ascii?Q?HSkxML1fWRXkCUSOGuiSPM121upOgph7bxsoLdbozBx/YQpI1mgqdbOeccSG?=
 =?us-ascii?Q?EqHS+ybzbBXD/bEwqJQtJG+yuDOd5sg7UdHVJ3thKM5wmVln1ig2QKQHtwQa?=
 =?us-ascii?Q?VhcU38RHE+zOB5GxHWqFg6+b2foyDQtO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:20:50.7521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf82d7fb-007b-4a2e-c7c5-08dcb0682418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Under autonomous mode, source reads dpcd DP_PCON_HDMI_POST_FRL_STATUS
for the frl link status.

Without dsc passthrough, it serves as bw bottleneck on the entire link,
compared with the dp link from source to the converter where dsc is
available.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index f3b6d8936f91..59c9dde10885 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1166,6 +1166,8 @@ static void get_active_converter_info(
 							link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps = intersect_frl_link_bw_support(
 									link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps,
 									hdmi_encoded_link_bw);
+							DC_LOG_DC("%s: pcon frl link bw = %u\n", __func__,
+								link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps);
 						}
 
 						if (link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps > 0)
-- 
2.37.3

