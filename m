Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FE9C54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E765D10E10E;
	Wed, 28 May 2025 02:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ju9JRBAn";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723BF10E10D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ub3lbbzsKQNYIm/FBMFQvFuFwLesmlmZjAc0VVPC9fpmSkDSxRKaSZBmxnXljterIafBjXBC2hm5WfzyxdM+En5Fz2W2DR5AOtSKb4vE7PAP0jds+lMgfcOhyBp3vqtqPps0fuIsg1gFiry6cKtruCrtCtXCMkxMN2tXWBYNfCzVNutl8UuJMP8H3c9qT9tJj0oKuQ0Dmwr22jCGZdNA/81HNekzzUSRt3qR74OfYDchi5RbYdSzD3agjJrNVAU+zGSLBQSXL2RgIdUcLP1SEGQY4eNLJxg+zY4/CH7wffOuLomFmXA3kO/tR1R9cqo7VqFsn6bB7p6WpHjvhiJQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dErhDKmkmTUCU3N8h9TaytOBWEMt4Fd2ewLU2sl/UFU=;
 b=r7246vTiX9cuyhhbD29SvOcD7eFk/0RpEPr0Edkh3kCNoaNqscbKj+I7tWJF632KhuzOHqY8EiPoY/JaTPwyYhaRFMOE1W+xcG0PUzSrcvz27dL7vz28eYshK5Zuq67b2mG8Ffwe1Mn/08lAGCCPINXpWxk0lqSXF0lJg0AIlj2Ji/zmuxRDYeehCz8Vyq2oUNZR/4m95J3GdQsBfvQXzcDt241qT4EOCDZhFxCo/FFiLo7W4OBPLYjDxPmq9BDI4xmrJ1n1L5ovH9pIGt84Dne7mpyhhORw9VLV8nbSQdo1zqxwFMLh0R8mG7Gx+6riKeliVIqwwxvQwZ8rHYDzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dErhDKmkmTUCU3N8h9TaytOBWEMt4Fd2ewLU2sl/UFU=;
 b=Ju9JRBAnEPqZLAcNdi1EjQggujAtXj/Ew1/CXsIB7rclOFX+1WaeDrC3h05UACntnLu4Yhhix5JvHRFsCVS2cSMir2LNaoUB4/TVSwQZLEYqfEqEuDpoxAGW1fZsL13eDfbvMLlmkGXvqQRN1SMJHI2Pcj5aKDM56klkq5UhYtY=
Received: from CH0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:610:e6::16)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 02:52:32 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com (2603:10b6:610:e6::4)
 by CH0PR03CA0281.outlook.office365.com (2603:10b6:610:e6::16) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19
 via Frontend Transport; Wed, 28 May 2025 02:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:52:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:31 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:52:26 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Austin Zheng
 <Austin.Zheng@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 03/24] drm/amd/display: DML21 Fixes
Date: Wed, 28 May 2025 10:48:58 +0800
Message-ID: <20250528025204.79578-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: d108d463-6b62-4607-03d2-08dd9d92b12e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kayBobsys+gVFBxIKtjNudt3ff1qdQpvHSbJodIq2bu4tCot+ce4kaGxTHbQ?=
 =?us-ascii?Q?5iLOX0O1jO+yfQocZjBQ9kwuLMQEE2i2FHNtOXPz3E9X23SUE7UXuvTlS4UM?=
 =?us-ascii?Q?4Au+24VI3UqO2i7e7oiLA5BcBITOpp/lAfbgn8jFFNJzF7T0Q1tnCPpHcZzq?=
 =?us-ascii?Q?WP4PQgYnVpuQt4XrHOmOjK6SVqkoWkn1OZ+v1juNHDvkawN8Jh1fQ+gpj0Wi?=
 =?us-ascii?Q?8guuzh6sGjYhzerYTppArfu9//6z54VIpggQSHH7cOqn91oLURj382fo+/aO?=
 =?us-ascii?Q?9wro3T/HOr1dJgTSAOcOn2eUUq5YaCFt8gOgtiO5hxcWiVSuJK9SqISxLm8f?=
 =?us-ascii?Q?vKcNR/hxlsR+A06m8JlvQwct9bjkk0hfq4JCRm6wyvkbZnMxeNWopmoHBrnV?=
 =?us-ascii?Q?CecTOJ0u/dRiPU0c+YqIfbEi3tYkwHp81jwwAGcJ7ho9ETooiGFUr+7/+TsV?=
 =?us-ascii?Q?7yXE7G9CNwbSL5r55X4kiykQ4+l3jdISxoviWjFs7P6OtBrG6+14dSKbbhsd?=
 =?us-ascii?Q?sLESh2j26TSCWAm8vA/SdKa2/CBBE6PCgmVCvFKV6BhTd1I2lE2l+pVZW7hW?=
 =?us-ascii?Q?odRgpgKWXtIsnR1l5wDsMtt0BAuvDFSW+AO4p8t2OBDtq8MDAeES5WK3FEft?=
 =?us-ascii?Q?VJbk3FymUAvNtWqgC95U2ep3DVaaZe91AEcTFZlQ1IKZKhPz6Loa0isQ59pD?=
 =?us-ascii?Q?xV7/8KfHMa8WYgppsqNS21cwBgBKfYGSGzbW4qo9t+wPt1SbkqHJRZ16y/As?=
 =?us-ascii?Q?vj7gxFVZbw5rHQQ+HqFJ02UZDsrtCjAlmC3s1KySXFuj/5dw1g7JDohAC03r?=
 =?us-ascii?Q?BNGMMNytEjyMjIE68BoQxmmIrECFCaHeiW6dqBNTXcPGQMeZGHHf6D+mFDKt?=
 =?us-ascii?Q?ecv7qmVeycFh08WSJrk86fHFjoTsdgGESxqJfbsNDGWSaycjByj8lkdp9RqG?=
 =?us-ascii?Q?iUzHpjwDWgBN1pfvqp5IguM4nt4TO1kvobDiBMLaImJBm36PKrhRPjr5ydQL?=
 =?us-ascii?Q?g+RGFMyWJ2k5vGNFwPgvfoFN7dhHUxQGVIDYEXl/BVK/UotRaBKdRjhrfDRZ?=
 =?us-ascii?Q?4dEgY1AsK/Uj9yGjKKd6/JGV3Fpryds8eO+5xeoAOzHBkSpqmN9Rf2TKNvNj?=
 =?us-ascii?Q?ALNIeWbwpD/GecpgYGLUbVCu7D0+pZxsWVAPuNLL89fHLNVlOYTBrpjhwrnW?=
 =?us-ascii?Q?lGypTT4Z6ayCLvAwmHJHfc0+jlczfG1/fqFz22aBjxTP/yU6oc+2x9+dA5DI?=
 =?us-ascii?Q?sjks1wdjXR1JxEqDHGM4l5QL/dvH1BRaUnu8xbtg07YRQFTxQ+BAanAlm0NW?=
 =?us-ascii?Q?/yrzKXcRd3Vr85Ykq1xKjjgjOVgXAMFqmK6LP+ykPXdp3YhTxJKdRo4Oqd16?=
 =?us-ascii?Q?vrQDhhD1vNafiyZVXM+7ysIh94sIjtY3sW21I/0fiuk4lbhn0CHNAgz/QUhc?=
 =?us-ascii?Q?IK5+Lh9UGPfPBTfYwPkIAVRLnvv997+kz0MQEn6plaMQ5Rebzg3PXelT8Fqt?=
 =?us-ascii?Q?upu6sCKAQwaeQKNOSdzF995jWL/eRYDnM5/s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:52:31.9291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d108d463-6b62-4607-03d2-08dd9d92b12e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
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

From: Austin Zheng <Austin.Zheng@amd.com>

- Store state related info inside mode_lib.
- Fix bad DCFCLK deep sleep
- Update FAMS structure in DMUB header

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/dml2/dml21/inc/dml_top.h   |  1 -
 .../display/dc/dml2/dml21/inc/dml_top_types.h | 10 ++-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  7 +-
 .../src/dml2_core/dml2_core_shared_types.h    | 82 ++++++++++++++++++-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |  3 -
 .../src/inc/dml2_internal_shared_types.h      | 10 ++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 18 +++-
 7 files changed, 116 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top.h
index c047d56527c4..a64ec4dcf11a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top.h
@@ -43,5 +43,4 @@ bool dml2_build_mode_programming(struct dml2_build_mode_programming_in_out *in_o
  */
 bool dml2_build_mcache_programming(struct dml2_build_mcache_programming_in_out *in_out);
 
-
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
index 0dbf886d8926..bcb99a155011 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
@@ -279,7 +279,10 @@ struct dml2_per_stream_programming {
 	} phantom_stream;
 
 	union dmub_cmd_fams2_config fams2_base_params;
-	union dmub_cmd_fams2_config fams2_sub_params;
+	union {
+		union dmub_cmd_fams2_config fams2_sub_params;
+		union dmub_fams2_stream_static_sub_state_v2 fams2_sub_params_v2;
+	};
 };
 
 //-----------------
@@ -674,9 +677,14 @@ struct dml2_display_cfg_programming {
 		// unlimited # of mcache
 		struct dml2_mcache_surface_allocation non_optimized_mcache_allocation[DML2_MAX_PLANES];
 
+		bool failed_prefetch;
+		bool failed_uclk_pstate;
 		bool failed_mcache_validation;
 		bool failed_dpmm;
 		bool failed_mode_programming;
+		bool failed_mode_programming_dcfclk;
+		bool failed_mode_programming_prefetch;
+		bool failed_mode_programming_flip;
 		bool failed_map_watermarks;
 	} informative;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index c4dad7164d31..0addef1f844e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7905,6 +7905,7 @@ static noinline_for_stack void dml_core_ms_prefetch_check(struct dml2_core_inter
 
 }
 
+
 static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out_params)
 {
 	struct dml2_core_internal_display_mode_lib *mode_lib = in_out_params->mode_lib;
@@ -11880,7 +11881,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 		}
 
 		//Maximum Bandwidth Used
-		s->TotalWRBandwidth = 0;
+		mode_lib->mp.TotalWRBandwidth = 0;
 		for (k = 0; k < display_cfg->num_streams; ++k) {
 			s->WRBandwidth = 0;
 			if (display_cfg->stream_descriptors[k].writeback.active_writebacks_per_stream > 0) {
@@ -11889,7 +11890,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 					(display_cfg->stream_descriptors[k].timing.h_total * display_cfg->stream_descriptors[k].writeback.writeback_stream[0].input_height
 						/ ((double)display_cfg->stream_descriptors[k].timing.pixel_clock_khz / 1000))
 					* (display_cfg->stream_descriptors[k].writeback.writeback_stream[0].pixel_format == dml2_444_32 ? 4.0 : 8.0);
-				s->TotalWRBandwidth = s->TotalWRBandwidth + s->WRBandwidth;
+				mode_lib->mp.TotalWRBandwidth = mode_lib->mp.TotalWRBandwidth + s->WRBandwidth;
 			}
 		}
 
@@ -13243,7 +13244,7 @@ void dml2_core_calcs_get_informative(const struct dml2_core_internal_display_mod
 		out->informative.misc.DisplayPipeLineDeliveryTimeLumaPrefetch[k] = mode_lib->mp.DisplayPipeLineDeliveryTimeLumaPrefetch[k];
 		out->informative.misc.DisplayPipeLineDeliveryTimeChromaPrefetch[k] = mode_lib->mp.DisplayPipeLineDeliveryTimeChromaPrefetch[k];
 
-		out->informative.misc.WritebackRequiredBandwidth = mode_lib->scratch.dml_core_mode_programming_locals.TotalWRBandwidth / 1000.0;
+		out->informative.misc.WritebackRequiredBandwidth = mode_lib->mp.TotalWRBandwidth / 1000.0;
 		out->informative.misc.WritebackAllowDRAMClockChangeEndPosition[k] = mode_lib->mp.WritebackAllowDRAMClockChangeEndPosition[k];
 		out->informative.misc.WritebackAllowFCLKChangeEndPosition[k] = mode_lib->mp.WritebackAllowFCLKChangeEndPosition[k];
 		out->informative.misc.DSCCLK_calculated[k] = mode_lib->mp.DSCCLK[k];
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
index bdee6ad7bc59..5f5b15b478e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -329,6 +329,7 @@ struct dml2_core_internal_mode_support_info {
 	bool temp_read_or_ppt_support;
 
 	struct dml2_core_internal_watermarks watermarks;
+	bool dcfclk_support;
 };
 
 struct dml2_core_internal_mode_support {
@@ -350,9 +351,11 @@ struct dml2_core_internal_mode_support {
 	double SOCCLK; /// <brief Basically just the clock freq at the min (or given) state
 	double DCFCLK; /// <brief Basically just the clock freq at the min (or given) state and max combine setting
 	double GlobalDPPCLK; /// <brief the Max DPPCLK freq out of all pipes
+	double GlobalDTBCLK; /// <brief the Max DTBCLK freq out of all pipes
 	double uclk_freq_mhz;
 	double dram_bw_mbps;
 	double max_dram_bw_mbps;
+	double min_available_urgent_bandwidth_MBps; /// <brief Minimum guaranteed available urgent return bandwidth in MBps
 
 	double MaxFabricClock; /// <brief Basically just the clock freq at the min (or given) state
 	double MaxDCFCLK; /// <brief Basically just the clock freq at the min (or given) state and max combine setting
@@ -473,9 +476,19 @@ struct dml2_core_internal_mode_support {
 	bool RequiresDSC[DML2_MAX_PLANES];
 	bool RequiresFEC[DML2_MAX_PLANES];
 	double OutputBpp[DML2_MAX_PLANES];
+	double DesiredOutputBpp[DML2_MAX_PLANES];
+	double PixelClockBackEnd[DML2_MAX_PLANES];
 	unsigned int DSCDelay[DML2_MAX_PLANES];
 	enum dml2_core_internal_output_type OutputType[DML2_MAX_PLANES];
 	enum dml2_core_internal_output_type_rate OutputRate[DML2_MAX_PLANES];
+	bool TotalAvailablePipesSupportNoDSC;
+	bool TotalAvailablePipesSupportDSC;
+	unsigned int NumberOfDPPNoDSC;
+	unsigned int NumberOfDPPDSC;
+	enum dml2_odm_mode ODMModeNoDSC;
+	enum dml2_odm_mode ODMModeDSC;
+	double RequiredDISPCLKPerSurfaceNoDSC;
+	double RequiredDISPCLKPerSurfaceDSC;
 
 	// Bandwidth Related Info
 	double BandwidthAvailableForImmediateFlip;
@@ -538,7 +551,41 @@ struct dml2_core_internal_mode_support {
 	bool mall_comb_mcache_c[DML2_MAX_PLANES];
 	bool lc_comb_mcache[DML2_MAX_PLANES];
 
+	unsigned int vmpg_width_y[DML2_MAX_PLANES];
+	unsigned int vmpg_height_y[DML2_MAX_PLANES];
+	unsigned int vmpg_width_c[DML2_MAX_PLANES];
+	unsigned int vmpg_height_c[DML2_MAX_PLANES];
+
+	unsigned int meta_row_height_luma[DML2_MAX_PLANES];
+	unsigned int meta_row_height_chroma[DML2_MAX_PLANES];
+	unsigned int meta_row_bytes_per_row_ub_l[DML2_MAX_PLANES];
+	unsigned int meta_row_bytes_per_row_ub_c[DML2_MAX_PLANES];
+	unsigned int dpte_row_bytes_per_row_l[DML2_MAX_PLANES];
+	unsigned int dpte_row_bytes_per_row_c[DML2_MAX_PLANES];
+
+	unsigned int pstate_bytes_required_l[DML2_MAX_PLANES];
+	unsigned int pstate_bytes_required_c[DML2_MAX_PLANES];
+	unsigned int cursor_bytes_per_chunk[DML2_MAX_PLANES];
+	unsigned int cursor_bytes_per_line[DML2_MAX_PLANES];
+
+	unsigned int MaximumVStartup[DML2_MAX_PLANES];
+
+	double HostVMInefficiencyFactor;
+	double HostVMInefficiencyFactorPrefetch;
+
+	unsigned int tdlut_pte_bytes_per_frame[DML2_MAX_PLANES];
+	unsigned int tdlut_bytes_per_frame[DML2_MAX_PLANES];
+	double tdlut_opt_time[DML2_MAX_PLANES];
+	double tdlut_drain_time[DML2_MAX_PLANES];
+	unsigned int tdlut_bytes_per_group[DML2_MAX_PLANES];
+
+	double Tvm_trips_flip[DML2_MAX_PLANES];
+	double Tr0_trips_flip[DML2_MAX_PLANES];
+	double Tvm_trips_flip_rounded[DML2_MAX_PLANES];
+	double Tr0_trips_flip_rounded[DML2_MAX_PLANES];
 
+	unsigned int DSTYAfterScaler[DML2_MAX_PLANES];
+	unsigned int DSTXAfterScaler[DML2_MAX_PLANES];
 };
 
 /// @brief A mega structure that houses various info for model programming step.
@@ -548,6 +595,7 @@ struct dml2_core_internal_mode_program {
 	double FabricClock; /// <brief Basically just the clock freq at the min (or given) state
 	//double DCFCLK; /// <brief Basically just the clock freq at the min (or given) state and max combine setting
 	double dram_bw_mbps;
+	double min_available_urgent_bandwidth_MBps; /// <brief Minimum guaranteed available urgent return bandwidth in MBps
 	double uclk_freq_mhz;
 	unsigned int NoOfDPP[DML2_MAX_PLANES];
 	enum dml2_odm_mode ODMMode[DML2_MAX_PLANES];
@@ -684,6 +732,38 @@ struct dml2_core_internal_mode_program {
 	double TCalc;
 	unsigned int TotImmediateFlipBytes;
 
+	unsigned int MaxTotalDETInKByte;
+	unsigned int NomDETInKByte;
+	unsigned int MinCompressedBufferSizeInKByte;
+	double PixelClockBackEnd[DML2_MAX_PLANES];
+	double OutputBpp[DML2_MAX_PLANES];
+	bool dsc_enable[DML2_MAX_PLANES];
+	unsigned int num_dsc_slices[DML2_MAX_PLANES];
+	unsigned int meta_row_bytes_per_row_ub_l[DML2_MAX_PLANES];
+	unsigned int meta_row_bytes_per_row_ub_c[DML2_MAX_PLANES];
+	unsigned int dpte_row_bytes_per_row_l[DML2_MAX_PLANES];
+	unsigned int dpte_row_bytes_per_row_c[DML2_MAX_PLANES];
+	unsigned int cursor_bytes_per_chunk[DML2_MAX_PLANES];
+	unsigned int cursor_bytes_per_line[DML2_MAX_PLANES];
+	unsigned int MaxVStartupLines[DML2_MAX_PLANES]; /// <brief more like vblank for the plane's OTG
+	double HostVMInefficiencyFactor;
+	double HostVMInefficiencyFactorPrefetch;
+	unsigned int tdlut_pte_bytes_per_frame[DML2_MAX_PLANES];
+	unsigned int tdlut_bytes_per_frame[DML2_MAX_PLANES];
+	unsigned int tdlut_groups_per_2row_ub[DML2_MAX_PLANES];
+	double tdlut_opt_time[DML2_MAX_PLANES];
+	double tdlut_drain_time[DML2_MAX_PLANES];
+	unsigned int tdlut_bytes_per_group[DML2_MAX_PLANES];
+	double Tvm_trips_flip[DML2_MAX_PLANES];
+	double Tr0_trips_flip[DML2_MAX_PLANES];
+	double Tvm_trips_flip_rounded[DML2_MAX_PLANES];
+	double Tr0_trips_flip_rounded[DML2_MAX_PLANES];
+	bool immediate_flip_required; // any pipes need immediate flip
+	double SOCCLK; /// <brief Basically just the clock freq at the min (or given) state
+	double TotalWRBandwidth;
+	double max_urgent_latency_us;
+	double df_response_time_us;
+
 	// -------------------
 	// Output
 	// -------------------
@@ -697,6 +777,7 @@ struct dml2_core_internal_mode_program {
 	bool PrefetchModeSupported; // <brief Is the prefetch mode (bandwidth and latency) supported
 	bool ImmediateFlipSupported;
 	bool ImmediateFlipSupportedForPipe[DML2_MAX_PLANES];
+	bool dcfclk_support;
 
 	// Clock
 	double Dcfclk;
@@ -1028,7 +1109,6 @@ struct dml2_core_calcs_mode_programming_locals {
 	double dlg_vblank_start;
 	double LSetup;
 	double blank_lines_remaining;
-	double TotalWRBandwidth;
 	double WRBandwidth;
 	struct dml2_core_internal_DmlPipe myPipe;
 	double PixelClockBackEndFactor;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index f486b090bbfc..22969a533a7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -389,9 +389,6 @@ static bool map_min_clocks_to_dpm(const struct dml2_core_mode_support_result *mo
 	if (result)
 		result = round_up_to_next_dpm(&display_cfg->min_clocks.dcn4x.dispclk_khz, &state_table->dispclk);
 
-	if (result)
-		result = round_up_to_next_dpm(&display_cfg->min_clocks.dcn4x.deepsleep_dcfclk_khz, &state_table->dcfclk);
-
 	for (i = 0; i < DML2_MAX_DCN_PIPES; i++) {
 		if (result)
 			result = round_up_to_next_dpm(&display_cfg->plane_programming[i].min_clocks.dcn4x.dppclk_khz, &state_table->dppclk);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
index 00688b9f1df4..d52aa82283b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
@@ -202,6 +202,8 @@ struct dml2_core_mode_support_result {
 		} active;
 
 		unsigned int dispclk_khz;
+		unsigned int dpprefclk_khz;
+		unsigned int dtbrefclk_khz;
 		unsigned int dcfclk_deepsleep_khz;
 		unsigned int socclk_khz;
 
@@ -446,13 +448,17 @@ struct dml2_core_internal_state_intermediates {
 };
 
 struct dml2_core_mode_support_locals {
-	struct dml2_core_calcs_mode_support_ex mode_support_ex_params;
+	union {
+		struct dml2_core_calcs_mode_support_ex mode_support_ex_params;
+	};
 	struct dml2_display_cfg svp_expanded_display_cfg;
 	struct dml2_calculate_mcache_allocation_in_out calc_mcache_allocation_params;
 };
 
 struct dml2_core_mode_programming_locals {
-	struct dml2_core_calcs_mode_programming_ex mode_programming_ex_params;
+	union {
+		struct dml2_core_calcs_mode_programming_ex mode_programming_ex_params;
+	};
 	struct dml2_display_cfg svp_expanded_display_cfg;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 202904af4682..346d843b45bf 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -104,6 +104,14 @@
  */
 #define DMUB_MAX_FPO_STREAMS 4
 
+/* Define to ensure that the "common" members always appear in the same
+ * order in different structs for back compat purposes
+ */
+#define COMMON_STREAM_STATIC_SUB_STATE \
+    struct dmub_fams2_cmd_legacy_stream_static_state legacy; \
+    struct dmub_fams2_cmd_subvp_stream_static_state subvp; \
+    struct dmub_fams2_cmd_drr_stream_static_state drr;
+
 /* Maximum number of streams on any ASIC. */
 #define DMUB_MAX_STREAMS 6
 
@@ -2021,11 +2029,13 @@ union dmub_fams2_stream_static_sub_state {
 }; //v0
 
 union dmub_fams2_cmd_stream_static_sub_state {
-	struct dmub_fams2_cmd_legacy_stream_static_state legacy;
-	struct dmub_fams2_cmd_subvp_stream_static_state subvp;
-	struct dmub_fams2_cmd_drr_stream_static_state drr;
+	COMMON_STREAM_STATIC_SUB_STATE
 }; //v1
 
+union dmub_fams2_stream_static_sub_state_v2 {
+	COMMON_STREAM_STATIC_SUB_STATE
+}; //v2
+
 struct dmub_fams2_stream_static_state {
 	enum fams2_stream_type type;
 	uint32_t otg_vline_time_ns;
@@ -2091,7 +2101,7 @@ struct dmub_fams2_cmd_stream_static_base_state {
 
 struct dmub_fams2_stream_static_state_v1 {
 	struct dmub_fams2_cmd_stream_static_base_state base;
-	union dmub_fams2_cmd_stream_static_sub_state sub_state;
+	union dmub_fams2_stream_static_sub_state_v2 sub_state;
 }; //v1
 
 /**
-- 
2.43.0

