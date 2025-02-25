Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7FFC021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 088D710E547;
	Tue, 25 Feb 2025 06:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y8sYxnSk";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B2910E547
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWfU7B4NZycg0eB3PIcGZPT4oXrHq+1TPyG+lx3T9Fe36Qy3R9Exwhsx55OjrcGgVsva3KJPA/S0wS1X3QP9ukGVmAWZS3byFrsr/3P06Yeg2sXRlO3i2XyzS4H8QO8hlJ/MNo5mlZCTB7s/lCZAhJDJ2nQjQlhwCibTb6dAhhWplOO4ltN9m++rNlwC4MmIpDwaK/cCbHCy6JW5pdE2ck/xCsInUQ7LF6GxxIauVPSux86mStz36T0ndsB2YJOmD7PvRN+SdfTSKi+eAd3Y2VfsZa8ltb76JkSYn6N1XVUqUBU5aiC+QdpcnWtFlVqwNtSilWpWxVrqvh7JxB1L4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbJmVFEjcgj0wsfuQ8VfcNHkjFJrhSs0DgFirjzE68I=;
 b=dr+F4MOs2dw8kbZnDkstBo2CU+bYfUcbIu2u+90QYhp2Tt0GEs3QSQwLM1895xnlX1vfQVl2917j7DHEp5AaWTVCA1AYO9/ig18lTgilqj7Javqro+ln4H74fODY2xseGndOSf6GSvP0fSOBOYYo7Zhlq6VyYkoC5zSvqzG3ywywW2pBuccg2By+EKvgpqTsREgVuyyByXEBcAmmqRgoDzBSisCuw3JGaXFyRsmzrbUsE72vPTmbWvLBFtkmsbw30RyQ1EpCl79lfihv98KYaKyafiRIuzp8efkBPAjQtteNmRPZ6TPOZh4gbtxoih1SbsEFX828Wp+3xYqRkwln5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbJmVFEjcgj0wsfuQ8VfcNHkjFJrhSs0DgFirjzE68I=;
 b=Y8sYxnSk/DMe/COZ5D2fLFgFve20gRvZSlorZox6iPscj1X9EJXU125WoO3ySW6aQ05JXUSzP03XW31+UBcZOWuyoNg3tg4zq5VNEHp1pgx7yMLFJ38/mpeGPv5qlUTFydssUMCGBsVyMWF0rMc452W9LFC2nx3pVXB6DjxczOQ=
Received: from BN9PR03CA0980.namprd03.prod.outlook.com (2603:10b6:408:109::25)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:36:50 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::b0) by BN9PR03CA0980.outlook.office365.com
 (2603:10b6:408:109::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 06:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:36:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:36:49 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:36:45 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Hansen Dsouza <Hansen.Dsouza@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 04/27] drm/amd/display: read mso dpcd caps
Date: Tue, 25 Feb 2025 14:35:47 +0800
Message-ID: <20250225063610.631461-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 8746e262-2258-42f0-9bd0-08dd5566c920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hRi9WtxfJoJZackLzsrB3RVgh2p7tCfcW0DccfTNPDNvmkMPYjQ7LpaP2yQU?=
 =?us-ascii?Q?QpvuHOR2RRkOmPjXHH6fVn1qC7XGoaQatqOZB0ZycbaHi74F0cBxVvCfKN+S?=
 =?us-ascii?Q?C/MrpT2rN4M9n9og6bPu11WLtO+3VkRu/85pU775upWgWqe0Qy2yq5ZJs2lY?=
 =?us-ascii?Q?SJT/1C5kIiXo955anfrxpKGcX3JhomNibwbOKrBaS6tN/JvLGqlqqHtbTv9y?=
 =?us-ascii?Q?MyUZmxCFH7M+y+pUcXztzGZ8tZunaFfC/LkM51iDju2vhzprgz0R2hWhaeJK?=
 =?us-ascii?Q?uRAE10ou7Hon+QxnF3fZNLmrmK0UhbZeNNTJxivL3p4PbmB/v82xhvXu5HEG?=
 =?us-ascii?Q?kG2wOMptj+PoUGI75uq3pw+zpxWa4gSjhRl6ZRFy12PhiTOGU7ewqv1oHQ9W?=
 =?us-ascii?Q?4F/LR59OVQURQ6I7orYMFlpetqh74s66wA/VzKABEPCG0XRYzy4GGc9iCnCU?=
 =?us-ascii?Q?7uGdplaCkKudZWx3HvsHxCs3P+vwMXs0qw2oermNOCYXDrfNGMUUgVN4khfg?=
 =?us-ascii?Q?cQEIVyyAyvjp2VRMgGKj6Yb0bBZxZtZhy5Zu118t/BpH3QuszIrW5i0pm8as?=
 =?us-ascii?Q?ZnlGBArHkofWK4XbttArkKSznHldBo00N1zv9MaplWhB308yWTznroDvLxys?=
 =?us-ascii?Q?R/HMfqQF0WtTt9wRFP4eQ8KkZf1W5VO8z3iVscXB6SZ0MdygSmDzPcmgpUUW?=
 =?us-ascii?Q?LZZbj+aC3VPgkn8XUIrzUvuTSbVBYfJ0IR/Lk0WDngEYNNi0enLyt9pWuxv1?=
 =?us-ascii?Q?A5eaJ/vq/ucy193z33PMz+0hZzdbpQENA5K/Nd+5QNAQVACuTYxTP6XTkUzH?=
 =?us-ascii?Q?D3W3ozpiOOHMa/fMMaQOSmg0eCyGq9JY3n1FFdTOhmUbLkSvJZKAbG++KMl+?=
 =?us-ascii?Q?X87t/7dwh2ouZqm/6VhXkDEVqE21tYalHlnizKex0GTw+mTX28giVNfjKz0Y?=
 =?us-ascii?Q?yCqnk4q7pO5LOnaLIY9g4Gg0HxhOf7KpE7Z1JxhrSt+lok39uga3l7nrA0FN?=
 =?us-ascii?Q?CUyq5VFe6ELuUmQ2P+EwT9lrHPyA6ntvoW6ibaUIqPOO7AHs4uZkey761Dx9?=
 =?us-ascii?Q?xjBIgl5+NJIx3xHf7PUNbwm0M9cq7txCrmCFDEIZCiM+XcI7r/EK+mx7iLlF?=
 =?us-ascii?Q?CYpHNRMYQPaNFGc/8/ktD1fJM2Zl6DMfXmebdVi+yxafp3ino6dzmLmgstdq?=
 =?us-ascii?Q?6sS9d7I2SJ1mY442dm0DBPaqesRzkBDO1oPLx/+1ns42FQLEphARo1Ioz3Jd?=
 =?us-ascii?Q?fdJcRe9zJIO67QN5vvbSi1XejZ2nd7WwlrP8PzGZ+wic1O2Kw06gVrHxMNdu?=
 =?us-ascii?Q?MKL5wUTu3sZxi8k420F59UNIA5tryfir1l0OU8ZuliOFzeR0uj/1N0+YKkCY?=
 =?us-ascii?Q?WSLBmZz6hopjq/K3gRjK/JF7hU+ZIvAboIXzEjS/iTA9S1ZB5atmCIH3frdT?=
 =?us-ascii?Q?k0Y7Lc6fzAZv0ullNONeRxAqkTfbVpE+RTpyIe22gyb0ToTq4Yda+w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:36:50.5392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8746e262-2258-42f0-9bd0-08dd5566c920
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
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

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

[Why & How]
Read if panel support multi-sst links

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h          |  2 ++
 .../display/dc/link/protocols/link_dp_capability.c    | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 8bb628ab7855..22c2173c687f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1220,6 +1220,8 @@ struct dpcd_caps {
 	struct replay_info pr_info;
 	uint16_t edp_oled_emission_rate;
 	union dp_receive_port0_cap receive_port0_cap;
+	/* Indicates the number of SST links supported by MSO (Multi-Stream Output) */
+	uint8_t mso_cap_sst_links_supported;
 };
 
 union dpcd_sink_ext_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 0785c030f6a6..da19f6a3b42b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2100,6 +2100,17 @@ void detect_edp_sink_caps(struct dc_link *link)
 		core_link_read_dpcd(link, DP_SINK_EMISSION_RATE,
 				(uint8_t *)&link->dpcd_caps.edp_oled_emission_rate,
 				sizeof(link->dpcd_caps.edp_oled_emission_rate));
+
+	/*
+	 * Read Multi-SST (Single Stream Transport) capability
+	 * for eDP version 1.4 or higher.
+	 */
+	if (link->dpcd_caps.dpcd_rev.raw >= DP_EDP_14)
+		core_link_read_dpcd(
+			link,
+			DP_EDP_MSO_LINK_CAPABILITIES,
+			(uint8_t *)&link->dpcd_caps.mso_cap_sst_links_supported,
+			sizeof(link->dpcd_caps.mso_cap_sst_links_supported));
 }
 
 bool dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_settings *max_link_enc_cap)
-- 
2.37.3

