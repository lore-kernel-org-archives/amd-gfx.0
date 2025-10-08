Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4976BCAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A2610E8C6;
	Wed,  8 Oct 2025 18:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="da35/zeg";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F3D910E8C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYsJ8423gDjHUcCBd8IvTZWnM7lm3AeK73CYgJfgQ2F38Njl4gWE6SqAt/ZCs2kQ0SUb0gl7VXOlSBrwgeVaEWLPrPZChBXFUu9m053L+zPHQPSmRK5/iz/fHneRW6efBEx/e5k3IHEdyGyrJWEx2OeGUAsA01nt9uKXzCqDjdr4P4DmlsYZ3R0m+GXBtKfiUud4nqRAmP8QlMQTRniuxK6JgXRzjKetIMPEUW4uEHxKnxw7f4Rl5REiLAN0du3eDwAiEPhtieYrJNwwNpez9w/hveOVqjL/OT66/IoemXQ+COtFLxF8jwENqUcJWuhp77grJ3mWccMVBAE/XYeBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00YnCNTr9xggomaMxzWwe6+LSkB9WZBdk6kysYu8bKw=;
 b=v/x521NqpahKy4FRfDyEG6YFmQfJXuS2O9c/2wXBP/jyXkICzR9RXcye6pa2gbndScXx1FIc/zzRWzUMbJslefDOwrCB3GMNiyeRPEHpZYBEULsfSCwNkwmcvumMvO8cmur9B3QD4o6uxn96m0tJ0f7HMT6mET0VzmnLF7P+AiYh/SwSsn7HYso50196rLIz7NVosHTrsB9GREKYoevn+NDmZdCOgYeu6/B++D/K18F74RHcdfllZogkrLzaYg9kg5ttmT4yLBxZO6CrUyhUau0KHjHpvTO7H8GgBjkoKxvJbJA4n+cdsQgs86Ke1YrQhWnUG9ZixKsnsRDRt1/wfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00YnCNTr9xggomaMxzWwe6+LSkB9WZBdk6kysYu8bKw=;
 b=da35/zeg1NcXz9j2v6C+Ytf4sCIabqlMbXGcdYxKt+qwLnBLPIqG2wzeJ2Weky7H6V5NRGVIRy0cf7hfp/wcy+NeSpunCn1L2jxeSIsIxqphAi0hH9kqrtP9RwhZNeXfRVsB5Spcd5SjCWWnHd1xI+FLJ8u0i0GmVyUt+a9a1AA=
Received: from SJ0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:a03:33e::13)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:49:18 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::a2) by SJ0PR03CA0038.outlook.office365.com
 (2603:10b6:a03:33e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 18:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:49:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:50 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:49 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:49 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 14/22] drm/amd/display: update perfmon measurement interfaces
Date: Wed, 8 Oct 2025 14:47:08 -0400
Message-ID: <20251008184839.78916-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 35795dc7-58e0-48df-05d3-08de069b629f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7bgn9g1vLc42lpXS8OOaflZzLWvFa+RdSsgTq9NLNkG3NenJf6a5+PPuvaa3?=
 =?us-ascii?Q?AEakK83bhn8RqRZ4vQlKX1/JXhSBfiDn4cgN4QeZrBtgEC/WpNG9WeufisdI?=
 =?us-ascii?Q?KNCanSguz9Wc6qrqQtasWlsPlaGLd1sX2zBu5LpuQOT2srKsPVkgPtT5pgAY?=
 =?us-ascii?Q?Ds+Kaqf3Tzkyv/3iRk+RJgG9x7v9GgqfHEVUDUzvnIkoX/SSQAydwCmAcQqE?=
 =?us-ascii?Q?8ok4BFRFIFeY8NCeS0Lcpu51vF4zJkMC1WrcbZa8H2Yen7qEgFC+8rnqF34n?=
 =?us-ascii?Q?sEnioLdLzlKv8OfPgtzVWZR3Z5CLYUz7lljNDbHHWTnwQyU/W+HcRHQOkWq9?=
 =?us-ascii?Q?Z4ACj5fJgQG+dklo735JWRJz4iMufiFnj1mbejdG85+hmY9QJlJ2VxftbEd6?=
 =?us-ascii?Q?NsgSlEBSG61yvZn+YCG9DujNyyC5P3i5yCpLBsgnHRiH5D10SDe2CRzZk9Qa?=
 =?us-ascii?Q?NYd9yhk/hhSuxOJ8cdWGvIuoibefcv1BYhF2H8Ln1IRKk4ySx2oj1g3U7Yoe?=
 =?us-ascii?Q?/GHEqPw+eUjv/aSNKPBZEn8VqVJbOB+nZUbArItkB+mEcQZWfkgNZmD9yyd+?=
 =?us-ascii?Q?YR6TibdHefgOc/SD/uCVs/1Bn6W0xdjwKGp7RQaVb7EB8OPxOeiJHu4SnTlP?=
 =?us-ascii?Q?M1AAJNXKN7BEIl9Z9WGvazRVFcMD99yINyOoUTTzx0H2Z8LqeRerRvgDI/yL?=
 =?us-ascii?Q?wm3btanu75vxbJoVUunU3Kbu6K2h0jXvJXsDmslfj3W2ExQ0tMmupKpzyZbY?=
 =?us-ascii?Q?zVhby5WWwdhz9AAqKzrRQ3DDTAFj/nk4GiPaKIpXCOHUpjvZiV5bvVk6o+QO?=
 =?us-ascii?Q?cpFsXAuRqG4O9A8m6d53nOguTTgt3Fowj4rxpp74OoC7gMR/1sYwINL6fQZh?=
 =?us-ascii?Q?8x8k2UEzQzIEefLhgLLhWSvvY/XBsUnP7vhX5sknMF4S507L0fu9CkX6ukzI?=
 =?us-ascii?Q?k9rLh2xaK/dEWq9gV+XUayDbcv+zWVujUy4UHruTnH6FXM4SsqwgO7ODjVog?=
 =?us-ascii?Q?bEtb3XX43LZTAvRUsNqrjADotao+AYhhFkhz3rVgnlcrgquY4YBMexesdllF?=
 =?us-ascii?Q?1UyCvNJwu7F4GKsdA6FZwXPOcPXeFaOi8GfNxlkN2AEhQivfQTxGEGHPMmpq?=
 =?us-ascii?Q?AkL7CENNMFMOsN2ePvU6/qF3ptawOIWHx/4N6p3X606in0B0E4f1rHpBC/x8?=
 =?us-ascii?Q?jvBYy/dGk32NkBWcgCwiFgxGhDQnyDrnN72bY8V/npA3IX6myOpBqcn0wQB4?=
 =?us-ascii?Q?VQJ2He6Utjw4nlnFeSNZtkqUfLS0FjjZLr7U8nDJiZ41F3Rkhv5Rwh/SEB89?=
 =?us-ascii?Q?S6zoWvTP0h8UjOy5hJQ4hfKPkigN0HMU4Q66WcIT6qYLtIc1/uUUNN463GQv?=
 =?us-ascii?Q?ZgIiy06It5rV37IkRKOUkczV2puGouSvQOPAsveNJC9NK8fmruLAnxWstNJd?=
 =?us-ascii?Q?Ut6cnl7HhXmRMDLSr3BwftYUiGS7GRbPWntIQ8yxWLClArGQco2uRzkEPvTB?=
 =?us-ascii?Q?q/bD8ThGJLpNG/UK0SE720o28bpn/9Tn+sF6e2KQUWOaEk0JWWwJBnuGCchL?=
 =?us-ascii?Q?1l73y6q6r0T61adRLyc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:17.6138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35795dc7-58e0-48df-05d3-08de069b629f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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

[how]
The commit update interfaces for dchubbub perfmon meansurement to better
reflect our requirements.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  | 36 +++++++++++++++----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 843a18287c83..2ce47c403840 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -244,15 +244,37 @@ struct hubbub_funcs {
 	bool (*program_arbiter)(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower);
 	void (*get_det_sizes)(struct hubbub *hubbub, uint32_t *curr_det_sizes, uint32_t *target_det_sizes);
 	uint32_t (*compbuf_config_error)(struct hubbub *hubbub);
-	struct hubbub_perfmon_funcs{
-		void (*start_system_latency_measurement)(struct hubbub *hubbub);
-		void (*get_system_latency_result)(struct hubbub *hubbub, uint32_t refclk_mhz, struct hubbub_system_latencies *latencies);
-		void (*start_in_order_bandwidth_measurement)(struct hubbub *hubbub);
-		void (*get_in_order_bandwidth_result)(struct hubbub *hubbub, uint32_t refclk_mhz, uint32_t *bandwidth_mbps);
-		void (*start_urgent_ramp_latency_measurement)(struct hubbub *hubbub, const struct hubbub_urgent_latency_params *params);
-		void (*get_urgent_ramp_latency_result)(struct hubbub *hubbub, uint32_t refclk_mhz, uint32_t *latency_ns);
+	struct hubbub_perfmon_funcs {
 		void (*reset)(struct hubbub *hubbub);
+		void (*start_measuring_max_memory_latency_ns)(
+				struct hubbub *hubbub);
+		uint32_t (*get_max_memory_latency_ns)(struct hubbub *hubbub,
+				uint32_t refclk_mhz, uint32_t *sample_count);
+		void (*start_measuring_average_memory_latency_ns)(
+				struct hubbub *hubbub);
+		uint32_t (*get_average_memory_latency_ns)(struct hubbub *hubbub,
+				uint32_t refclk_mhz, uint32_t *sample_count);
+		void (*start_measuring_urgent_ramp_latency_ns)(
+				struct hubbub *hubbub,
+				const struct hubbub_urgent_latency_params *params);
+		uint32_t (*get_urgent_ramp_latency_ns)(struct hubbub *hubbub,
+				uint32_t refclk_mhz);
+		void (*start_measuring_unbounded_bandwidth_mbps)(
+				struct hubbub *hubbub);
+		uint32_t (*get_unbounded_bandwidth_mbps)(struct hubbub *hubbub,
+				uint32_t refclk_mhz, uint32_t *duration_ns);
+		void (*start_measuring_average_bandwidth_mbps)(
+				struct hubbub *hubbub);
+		uint32_t (*get_average_bandwidth_mbps)(struct hubbub *hubbub,
+				uint32_t refclk_mhz, uint32_t min_duration_ns,
+				uint32_t *duration_ns);
 	} perfmon;
+
+	struct hubbub_qos_funcs {
+		void (*force_display_nominal_profile)(struct hubbub *hubbub);
+		void (*force_display_urgent_profile)(struct hubbub *hubbub);
+		void (*reset_display_qos_profile)(struct hubbub *hubbub);
+	} qos;
 };
 
 struct hubbub {
-- 
2.51.0

