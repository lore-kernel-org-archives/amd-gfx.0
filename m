Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39551D1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD92510E4D3;
	Tue,  9 Dec 2025 08:58:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xk/bDiCz";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013037.outbound.protection.outlook.com
 [40.93.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88FA610E4D3
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:58:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLzO6GBEFMOE/DT/8s0R+wnm9hd6hoe7olHoYu7RT09jVDmUDK1P1tyrDN3lKxckj/CnuOPgpq7yRohVZnF3W/lZrYgRVUwEnL1JTMiPH8BoW+Ygw8EbgnjIhf5EFQUa/mSj3qf8EMisi3P/3PEqHFjGrJ+3JPhaP3v6XeCSPveCnNIkm56N0zRUvOb3QbmKNokR7p/wlxnl8ANojMOfGRj2hYDhyr7arzXwM6TUJFW1E+H34Tt2RBdWiDQi9ceX9HIOkC/rq2mmPi3pvrjngc2B6B8X6SAAmimiKHGGNwcO3iEwUs6bgx3cdEJYxQnUBG7CwopF5oeCgICbLH0bjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjXa2i7djHMOCtwyGNmfcWEitBWn5xi56dE0bSDSy58=;
 b=kuDFAx88iCj0JV0tlPZ6VlUjJUKBbTujOfJU4iNoy5Xj3TdC66V/evE3EecoRxX/G+tgnGDnlRsG/Hv7y17Gt9GR9DV4MBcMbw5J1/B+/XNapByXYREeksP5J90aL/GdrWYjm+FV8DCTJi2IOoF+UT8gxUMSXRv+nJfyH/vCfAOLSLtreV8/c7b2UvWT/sm3MUnqDmUG3qt7+0KObdLABGwMaRBXMFQGilecgYy5aqQYQaLuChWVA2JzAsX4IU7rf4YIdWYlVnZlizpnMR3Q9rd3Y7sD9rdWnExBY9/IBaZbhdHWFoOGjhLovnuPy69sM46QntbFCJoFrCP4X9C/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjXa2i7djHMOCtwyGNmfcWEitBWn5xi56dE0bSDSy58=;
 b=xk/bDiCz5T+MexYmbkpI7y+8bA/hVuEPyq/WwzG9KiYB6+ZcoIWA1QPduJP8K0NShzt3sc/x1iZqSbMmz7ckQy8tArDqrzJVTb3EH9HPVn3mg+czhjxxOnkKdp+A0J0X56O+KHowgy2N8z0UVUt31B9R1fpEor8ML08l1K6dNi4=
Received: from SJ0PR03CA0082.namprd03.prod.outlook.com (2603:10b6:a03:331::27)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:58:09 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::ff) by SJ0PR03CA0082.outlook.office365.com
 (2603:10b6:a03:331::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 08:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:58:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 02:58:07 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:58:04 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, weiguali <wei-guang.li@amd.com>, Robin Chen
 <robin.chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 08/15] drm/amd/display: Support DRR granularity
Date: Tue, 9 Dec 2025 16:55:11 +0800
Message-ID: <20251209085702.293682-9-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d06596e-f00f-4eb4-9600-08de3701135b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N7tZPPtWlY7Rv5cTRDxoWJe0bvy4jApHQqu482Em5nunOyXjTP1s9D0CuPfE?=
 =?us-ascii?Q?+pI/xOO5DTmBhtuGmGKzArzuzVDbHx9feeZUq0D4oC96u3H6pogTnLiJ8uyL?=
 =?us-ascii?Q?YQIGCW09oDMRgd9UVqZNPBUy1gK/xlgbnAJa19jyJ6bNC07CHJL9kGPVsmlo?=
 =?us-ascii?Q?66q69akDqpxOJ8pXP6DngyrXEm0t8Xf2i+PEPNoKyXFdys3JwS9fughFFaRg?=
 =?us-ascii?Q?9knfIHqbnViQyrr6jFFpG9YbIyBm7D1iBCLwPcr6JW08ddp9ugGT/BBUnkWB?=
 =?us-ascii?Q?SaULobyUu8JFVBHX99N3E4ePxrmgdqXyuQPLihlCc56iggQHoCFhdPZrTLPB?=
 =?us-ascii?Q?NvaQejt3UcqOK8z7gzLUle/9lhbQi2cvu2uT+au4BOojfEhG6UrNMl/NlmA+?=
 =?us-ascii?Q?bLkTlch/f3uylV8Z2849kVwx3xwfW1V9kZqAlvtsLCzKfzeoZbHOi9YQPiWs?=
 =?us-ascii?Q?b/TokreEuzzoT0z2F3LQAKsy7ggJE5j6iGwYl6pakHqvFfaUTrSAcY/Wa4wU?=
 =?us-ascii?Q?jz7pDDJHmZkvuXGtU8tfyyiNqxGX4RJ2xBVYNwwzwXkJMerygnTxDa5hLsCS?=
 =?us-ascii?Q?8xoNCeHbHsDyYJosnTrYoM++MGmEsnZL7fMgn+fV6Zqkc4wQmDTDyg3WD2+R?=
 =?us-ascii?Q?5XvnP2suHkUuDHfpWCaYszCqJarGAz53w/7JWLOhrxEzxBP2eqYrLYDjiyW5?=
 =?us-ascii?Q?DzAelXXwEvPBaQb9srgj+8n2A+BEk9+dkrVAgOslca6urkuk46RIN8K7NAk6?=
 =?us-ascii?Q?EGOYWVMWJ5XZxRJjBdA94LJUgJ1mSQF1J6JVybK4Q5BmJK9a+F0mBi6RMBdH?=
 =?us-ascii?Q?+RqiPX8eDVXEmDw2UvwJz5qvXn2LOl4zWqMX+iQ3xOAcgAUCIgcibNPCyBSp?=
 =?us-ascii?Q?cYP5CFvylaEIjlNojIzgFVtux+xRdlx7FqYXB4/JLYtoWG3AzZrntiE0S5QX?=
 =?us-ascii?Q?SV07JwPdnmdc3ENRFtrGgSdna7lQjU7K89qn2+Otcd2UztgMH6j8olRK+ivK?=
 =?us-ascii?Q?cBYT7mS9zf3xHFbZJPIGgGhNK5yReb/66CPfkH5gk6LRceZDNYKBOKwRPi2Q?=
 =?us-ascii?Q?2lp67qGpGf3e+0KTXeL9FpWBaXowbQ8+Tm0tf8ebCmh76ROhstpqgldQ61Yb?=
 =?us-ascii?Q?ru7htsEWKyOXHQc6aTE+8uzGKwNNSKkalBQEVKFqFJmBjN6VxifedIGCxJOA?=
 =?us-ascii?Q?/WHTDzsYoYr9qGWid2plA0TF5fzY6Q8JrsiIC/46O052Rxn69ERre9kMZsAZ?=
 =?us-ascii?Q?aiIbyDpugWgs5UYw1uY2rsSW4F6pr+jN3IMgYEl8PkWTSWV+Ijb955vmIow1?=
 =?us-ascii?Q?tXDx03yJ6ylAXTY13eWYWQR6PVSV8nlbKOzUX67hOj7D+srqQI0oI9kuEF3N?=
 =?us-ascii?Q?jsmCMSZDfzuaIPbrLGL37Mq9NOscgzTQBQQx9E/lspjzH4ishigOFY6+UtpL?=
 =?us-ascii?Q?+zN4c29JIOqohFpC+k6Q5i5HlloWNx9lKzdXEs4A4xg33tyIw9s1zPipJSon?=
 =?us-ascii?Q?tYbU+ArIM6FaUF994nn6uRJFah/eOC9MA4g67Ghjt4XTuaMZqyzbPnjpn/CM?=
 =?us-ascii?Q?vcbdwC1I8btyPyDDh0A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:58:09.1119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d06596e-f00f-4eb4-9600-08de3701135b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
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

From: weiguali <wei-guang.li@amd.com>

[Why&How]
Support DRR granularity for coasting Vtotal calculation

Reviewed-by: Robin Chen <robin.chen@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Weiguang Li <wei-guang.li@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h               | 1 +
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c | 7 +++++++
 drivers/gpu/drm/amd/display/include/dpcd_defs.h            | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 79e1696def63..273610d85438 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1296,6 +1296,7 @@ struct dpcd_caps {
 	/* Indicates the number of SST links supported by MSO (Multi-Stream Output) */
 	uint8_t mso_cap_sst_links_supported;
 	uint8_t dp_edp_general_cap_2;
+	uint16_t drr_granularity;
 };
 
 union dpcd_sink_ext_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 3884851e2a9e..54c417928b61 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2219,6 +2219,13 @@ void detect_edp_sink_caps(struct dc_link *link)
 				(uint8_t *)&link->dpcd_caps.edp_oled_emission_rate,
 				sizeof(link->dpcd_caps.edp_oled_emission_rate));
 
+	/*
+	 * Read DRR granularity
+	 */
+	core_link_read_dpcd(link, DP_SINK_DRR_GRANULARITY,
+			(uint8_t *)&link->dpcd_caps.drr_granularity,
+			sizeof(link->dpcd_caps.drr_granularity));
+
 	/*
 	 * Read Multi-SST (Single Stream Transport) capability
 	 * for eDP version 1.4 or higher.
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index 07b937b92efc..8445c540f042 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -188,6 +188,7 @@ enum dpcd_psr_sink_states {
 #define DP_SOURCE_BACKLIGHT_CURRENT_PEAK        0x326
 #define DP_SOURCE_BACKLIGHT_CONTROL             0x32E
 #define DP_SOURCE_BACKLIGHT_ENABLE              0x32F
+#define DP_SINK_DRR_GRANULARITY                 0x33B
 #define DP_SOURCE_MINIMUM_HBLANK_SUPPORTED      0x340
 #define DP_SINK_PR_REPLAY_STATUS                0x378
 #define DP_SINK_PR_PIXEL_DEVIATION_PER_LINE     0x379
-- 
2.43.0

