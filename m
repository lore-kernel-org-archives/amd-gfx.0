Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24678CA1002
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 00:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C65C610E549;
	Tue,  2 Sep 2025 00:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e1SPBjhR";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB09910E549
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 00:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfLYDF/vgb/ihR9z5yUjEX005RpEMpG9JNwu9I+CGrl3fXiEsxt5YUFL3d+mmx5K7zXqzWss1T/LJjfIKIIEmGYvhS35ZH2l0lwT7VZ8SBKeZzJO7hakWylkH/iZXCmXOijZVLqfqRQQIbPfiE9cJjKIsnzrpmUMKkn8idnw7LdFfObL6xz1yX1YJJ9Ra04sZcI2k0+k6yxhC3p27m7058bdCgz1PHJyAH7NO+0U8HEn60AW6Ny3zcoVmm9iyobqlWI17pHhWxBKwPtjWrM5j3sJiKj0kDuoAnWQVrg3ZFLjaLekdBgrSvgOIH1tEv7VTuWVwyDbMAV7JplLjNQ44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYVmc02H4nemKhf+77o+oi+hJ0yfMYGQjsjvQ6u8hjo=;
 b=dXxX3BDNpo8j1sgmGRxJ73uAOiKuSkE3MGrk8uvB06BqwUO72mnuDYp83w1ixFjzsBq2fUrlEDFNJWiD/pt66HLGlrb2w73wy4Oyugo6cbdJhbETLwIsJbDZaCvztzvY9m+sq/PuiwIpYQKJbcvsmcCoY40TFarygyoTEeedfNddVgid/Ngt/NNfJlFTx2h/4IKvJMRfx99Qn2+g1QmQKuNXoujugw1wWR+Niyhq2zSt44TOTfkHuyTZOtSx6jlIQQKvPVw8mvs0cZX9DhdiR8QywfJP0Txe7say8j7t1GDmXfSi2vlcT+holabCxKflhcmMsVwAJj+xu4sumaoHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYVmc02H4nemKhf+77o+oi+hJ0yfMYGQjsjvQ6u8hjo=;
 b=e1SPBjhRzKo2rJXUVEPlU8hZpljRfhcBKcUCFPiP7Mq/gwqSR/a481EVj/X6ZhP1CW3x1scKzf0y4nbtrZQEqy+ZK1mJlkKsOYRZYymCngLMTe7Hi1D6WbroRHMbVYns+k9RDxrObej0YoSeR0uQKQDCj6vdmz0HMdsWinrEdwc=
Received: from CY5PR15CA0190.namprd15.prod.outlook.com (2603:10b6:930:82::8)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 00:46:34 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::31) by CY5PR15CA0190.outlook.office365.com
 (2603:10b6:930:82::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 00:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 2 Sep 2025 00:46:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:46:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 1 Sep
 2025 17:46:33 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Sep 2025 19:46:28 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 06/11] drm/amd/display: Update dchubbub.h for hubbub perfmon
 support
Date: Tue, 2 Sep 2025 08:42:51 +0800
Message-ID: <20250902004532.1833436-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902004532.1833436-1-Wayne.Lin@amd.com>
References: <20250902004532.1833436-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f772b17-f9f9-46fc-37e1-08dde9ba2ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|82310400026|1800799024|36860700013|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SwvJVl+3tuwuLQvFyZG0sL5diNjTA+QDzghL3XHkcn0UHwloXM+71HlQbx+R?=
 =?us-ascii?Q?kMxiSkuJoTx6K9h1mBGa8ACSrWNyZTtrz3mUi4nKH8olaI1pOw5Ws9ORgiqp?=
 =?us-ascii?Q?msZKKgbWUSxwT9L6tPnaAjO9xzYDfjLmmgv4N7pXXJ1W+AHfxoE9ZlkqwYlY?=
 =?us-ascii?Q?EPjn/h6kapy21+/Kta7/lWfMo5058oPWL/9CExh6vdT69AE3xTPeg3hOIh4y?=
 =?us-ascii?Q?05A/MRbIMl+nbZuJYYI3lV9RlQaCGUTVjkSauBu2L/XAY69l/jID4IflbTf1?=
 =?us-ascii?Q?c3DTCUwKbeGTZ9IpMVSpJ5FWUa7QPD0lhQ4YleIeOG7YfmVTfp+2KaAYJJL4?=
 =?us-ascii?Q?5S8mTgd457CVuMfIvGn5iW0PT7tK4MXNzhuEdvd9sKvgUSjm3fOVe6SdLeq2?=
 =?us-ascii?Q?2A+O0f/A15U7GP6FfsclB5W2I8YFUPpahlaEBKJDVpV6071QANAk1DgLtwTA?=
 =?us-ascii?Q?WO9ktSokdEEt0YQ01I12Jx5yBwLua0g4FUwGhg6JKABqtCS+rDQcequhNVcC?=
 =?us-ascii?Q?yiiffjrqdMR863U8EnsJrMTlL/eCltrovZKwe0dZLZr80bibBlOQR9zq6GXB?=
 =?us-ascii?Q?MMwKRODaL2DBmbyL7g4EoaXz7H/HVhpilJ4+y6Q+MRpS280nY3tVQvW30mle?=
 =?us-ascii?Q?V/2Zcga6MPKmwo0sJPg4VgFN4YJ3lVMiXAjwKWB6m/+AVDSlLYFQwWqOcE8y?=
 =?us-ascii?Q?fLJamyZMaBu8nkUcu4JI5Ich2OGj2yhGYJJPXLMYZE+a2C7eQAsuMWfK6Igv?=
 =?us-ascii?Q?1Ei33tQQz1e4ntxeOO8OdYTZ9diMQZCsCyR3bDMa5TBmCZNm/Ddn6eJ05LBv?=
 =?us-ascii?Q?3tye8MVCJruNI0L/lWrLMRsx6fIJEJXRQpOBPXs3+vX6tRFPaAmCitzLVOTo?=
 =?us-ascii?Q?jlCXPq40dO0OFwlVcIjDQ7guzGoXDLXuzulA0oGFKqU3fnBhDqpkSbbDLx6O?=
 =?us-ascii?Q?4ZFV5zHv3SPSs6VC6BaV/Msr5oxc+PvvBffZGcGqSeeDZ75CvPBhb+meEzOx?=
 =?us-ascii?Q?tU80Ss1AOSuX6h64aybd/B4dyXZxKPSgUhLt/CWKn/ZpZ7GMM1/HL2uV4jJX?=
 =?us-ascii?Q?GZP49jjzJNqqWniXArI0+KSyxJ80/69RtM/ynzbdmp8BTxDSqwFPZ2SlK78A?=
 =?us-ascii?Q?HtlWVdCkBiG68Hc8VF5qdAjMp/qIW54/aUtg5xIhxx6/c0NLB2xRCnwZicSX?=
 =?us-ascii?Q?euGezcadb3iYv78ezBrYHbvszGYK/RMRcmEP//+K3i9OfPkmyJSsNef6hdt5?=
 =?us-ascii?Q?Wc1CVUsLdJAMqsqawukBunN/P6d+VAvF24qIRpawSYvLBFY2kUZKfsg2g4jk?=
 =?us-ascii?Q?moxGi9i2ZSP5pHOjhG0nGO0MCSzSsPG0zpj7Cw0AvVXBj7XFCxyYVFhPybKg?=
 =?us-ascii?Q?/YwIHznWUSNbjYEFQv3tuq7Iy9v/EQ++BBLgo2mMTEkHyCeKDpTeQYnKEmhA?=
 =?us-ascii?Q?kBR1/hcwAIN2WEMHzTavEkcubGOdEuCbAX/hHyUIe+c3MVR1MUlcDpLpmsvq?=
 =?us-ascii?Q?pwizBe+JEqHkTBX0Mo9q0OgyAlmWFdhZcNW+HSqNItuHxt7pPmGqjdnJvw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(82310400026)(1800799024)(36860700013)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 00:46:34.5544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f772b17-f9f9-46fc-37e1-08dde9ba2ab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
dchubbub supports performance monitoring for hubbub.
The interfaces define the performance monitoring events and their
attributes.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 9bee45b36629..843a18287c83 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -137,6 +137,19 @@ struct dcn_hubbub_state {
 	uint32_t dram_state_cntl;
 };
 
+struct hubbub_system_latencies {
+	uint32_t max_latency_ns;
+	uint32_t avg_latency_ns;
+	uint32_t min_latency_ns;
+};
+
+struct hubbub_urgent_latency_params {
+	uint32_t refclk_mhz;
+	uint32_t t_win_ns;
+	uint32_t bandwidth_mbps;
+	uint32_t bw_factor_x1000;
+};
+
 struct hubbub_funcs {
 	void (*update_dchub)(
 			struct hubbub *hubbub,
@@ -231,6 +244,15 @@ struct hubbub_funcs {
 	bool (*program_arbiter)(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower);
 	void (*get_det_sizes)(struct hubbub *hubbub, uint32_t *curr_det_sizes, uint32_t *target_det_sizes);
 	uint32_t (*compbuf_config_error)(struct hubbub *hubbub);
+	struct hubbub_perfmon_funcs{
+		void (*start_system_latency_measurement)(struct hubbub *hubbub);
+		void (*get_system_latency_result)(struct hubbub *hubbub, uint32_t refclk_mhz, struct hubbub_system_latencies *latencies);
+		void (*start_in_order_bandwidth_measurement)(struct hubbub *hubbub);
+		void (*get_in_order_bandwidth_result)(struct hubbub *hubbub, uint32_t refclk_mhz, uint32_t *bandwidth_mbps);
+		void (*start_urgent_ramp_latency_measurement)(struct hubbub *hubbub, const struct hubbub_urgent_latency_params *params);
+		void (*get_urgent_ramp_latency_result)(struct hubbub *hubbub, uint32_t refclk_mhz, uint32_t *latency_ns);
+		void (*reset)(struct hubbub *hubbub);
+	} perfmon;
 };
 
 struct hubbub {
-- 
2.43.0

