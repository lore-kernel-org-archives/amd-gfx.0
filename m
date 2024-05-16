Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D9DC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A61B10EDA2;
	Thu, 16 May 2024 19:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PMpOQ1ao";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B63E610EDA7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALna0EAWHyT6w7saqzvnaIL9sRuAEmeK47wP374KJk7SgnKb01HpmaYsApErZWKSQs4a9nhrxIXj0I7hoRlWWlDFbfiUU4CHpQtyFE+M/qB3WNwX5qQptNvpMpN+1WLffwW8EO6RVENCdG8R8rabr0FhuFbYaViP4Yf6CevB4uZ0ESRPZKAkuWs38QpQELe1WyWH/Of05PwgdGPIWw0w1srL8rqascWPWyT15OHhhz86ZmvdSXmosiLIh3na4e+CVKIOq1PCpcLUTdoiFx00EbOe5PPONfu0ebgsM/pC+khrxlZtB+84QD10/H2Zaxw9404uFzk6jVaPfP6wIiGw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pANHrDFZnyy0CVdizrL3heINpL6TKC2QR1OHm6bYZt0=;
 b=BE1msmWeHTRBvms8H4bCGBOZIGGsI5qvp+bzpWzOfFtW7RLQxzmM8wtZ6WpWRxo9G8Oo1zCYyPqK+sQ5Psu0TJ7ipmcWKQk5Y/CBN9ijB0p4eM/Z0HEmCYAHCFeaElewID3FRDSVKlMSbaT981zGtB/x+3npdYoTN29SLiwHkiD7jRM3jkftRKOgo9n7bZDb5lATqi6//eVlwLBbposcaYoN7f2PifJepBSJIdk6eZ6eYl5beKz6ejaUjECxHRlkUTqbPdsh2gAsV6FIX7l4Cz5F/B34ifwybgvyDRveU6FitmsW24fX84uttGMNSeE4D+uQpFVPFJUjj0ig06Rjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pANHrDFZnyy0CVdizrL3heINpL6TKC2QR1OHm6bYZt0=;
 b=PMpOQ1aoE1IjHgs+N+pDGUIBSv+2PxL2pxehKVN1qSdO3rnI795OxwEbTyEkLSRK1fxKkX4hV4YEjmPdPuNAu3mh/bkh8w2ioYB9qQq/hWGt9ESQuQq4lyR7AOc4TtEP+CyBX13jpMUIF3TvTqLoiTt1W0QB7vLcoZilKxftIOw=
Received: from BN9PR03CA0260.namprd03.prod.outlook.com (2603:10b6:408:ff::25)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29; Thu, 16 May
 2024 19:27:04 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::58) by BN9PR03CA0260.outlook.office365.com
 (2603:10b6:408:ff::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 19:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:01 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:00 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>
Subject: [PATCH 10/24] drm/amd/display: Add missing DML2 var helpers
Date: Thu, 16 May 2024 15:26:33 -0400
Message-ID: <20240516192647.1522729-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 466b939c-20b6-47c9-5b45-08dc75de2ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZXbclYMsuMkQieGLKD09WrwSSYiFMBYlFZlVPABVPwyJ7cjrHwK/4UZktrk6?=
 =?us-ascii?Q?313x1P2VSnEiyWlig4f4hwPp+2i+IRBDz0De0dMQj+K9V6QinuWIn1BS8EYb?=
 =?us-ascii?Q?aeoS6YQ6tr55/OF7BjMH+ynRSqgHNiOGGSU3fvZPSbghfWSLHwh0NSLYhw/b?=
 =?us-ascii?Q?q2nN9m8hlL7YVy90zMrtMOG78YG1WjNOUux//XOVLAcqSyKxphpdro1cNer6?=
 =?us-ascii?Q?P7a7ZzoysVYcSs81erdF5sS1/wLeDBNyFiUqZbpNB7QZHTFRTJ+u8v0rDdzd?=
 =?us-ascii?Q?HvewIYHSL3m2rpbSHZGaDkVJPoug+bI0fTGd6UaxxIHJ01+JVPP3vgdONSFU?=
 =?us-ascii?Q?oWVdy2xvxrjFHbaODRRocehCY5fH4UC+/fpo6TLMvmmE7giBxVDGVDoF36Kg?=
 =?us-ascii?Q?6yki4/zIcFzfJ1I4t0olXl2P5/+Wc7+DdEHARY3cDYnRRq+5EIaXvLm1nO5P?=
 =?us-ascii?Q?I4bWXuLQObFQuSnFnHSI7eh9nNZUWO7L17GPIg3jM4iCJVq+iYOMYrqNXU+s?=
 =?us-ascii?Q?k5lQbYGFDDV+22QIwYBASJxj041u/Mels4MItalQf62aFRoRifOyvG09Ixk1?=
 =?us-ascii?Q?uTXC+STCNAJzIFI8NZQdE0mMeT7y+lg2+cTAUes8iJGCU0NrWOpeMjkG7Bf0?=
 =?us-ascii?Q?XmbRmRsU4MzyRp00duvl8jyWp7ZId6SBEB3dlNXJcvqTZ/YGCFF8KRA81PGA?=
 =?us-ascii?Q?XH0hm9eaplRuF7gbadobrtNabi8SAzyqD+0M9mcfPDShUml32fEaqVUQbAsr?=
 =?us-ascii?Q?69bCpxDgx5Hcr9xzTuCDg8pLzu62LIKsJqiyp1icrS0pwH7amm/PrFyN933e?=
 =?us-ascii?Q?A3lNM+1iLfFBxhChYo+SDYmc64NhC6yeZxYRhvptHuhZCM0YIDj1PRAy1h+5?=
 =?us-ascii?Q?7zHesk9mib8jhDQw+xCPTck0c+gPHJKFuGLmVXSyV5mb6y4l7odLcMji2m71?=
 =?us-ascii?Q?evPbA9a3l70+k+mBQXI5coJ0BH4SStLGJAMoGDFGj/Hl+hoYBK6iInYE28KD?=
 =?us-ascii?Q?eq+JYMwsVGCr5HV7UvzdHsq8jlKGg5ysVTm5cYKVBUDgGGJ1k68F6w/38oSm?=
 =?us-ascii?Q?onhb4/T25aw4/D6KM4T2B/UH6Lr/CGFNt87PAuCyhaCMN4RnpElKyeNr3+le?=
 =?us-ascii?Q?+jwZyoRhr5s2ZTJ3GT6HINIs0nZ+VmnoJJYHy0OfMabfjZRaTrfRGco7p+TT?=
 =?us-ascii?Q?bONxIm0XueAAi2W0siJkooUX2zFYgqCtPK3AR07+G439/a291mVL4Q3pPuCj?=
 =?us-ascii?Q?94s3wZX1NzYRI/5J0c2JnPziW8r37t0KXyzCND6U7SUAVF/aIAcUOYSZNLz8?=
 =?us-ascii?Q?3C//dKr1rxvMhLtsvIgiqdSfYoXMtjESPRYX+NiPRb4w8ESHLCNCiWrwgsWZ?=
 =?us-ascii?Q?ML0i30vzBDUj40STVddR4oztXpe8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:04.1376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 466b939c-20b6-47c9-5b45-08dc75de2ad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index c054c22cf305..ff2adc9eab0d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -10226,9 +10226,11 @@ dml_get_var_func(stutter_efficiency_z8_bestcase, dml_float_t, mode_lib->mp.Z8Stu
 dml_get_var_func(stutter_num_bursts_z8_bestcase, dml_float_t, mode_lib->mp.Z8NumberOfStutterBurstsPerFrameBestCase);
 dml_get_var_func(stutter_period_bestcase, dml_float_t, mode_lib->mp.StutterPeriodBestCase);
 dml_get_var_func(urgent_extra_latency, dml_float_t, mode_lib->mp.UrgentExtraLatency);
+dml_get_var_func(fclk_change_latency, dml_float_t, mode_lib->mp.MaxActiveFCLKChangeLatencySupported);
 dml_get_var_func(dispclk_calculated, dml_float_t, mode_lib->mp.Dispclk_calculated);
 dml_get_var_func(total_data_read_bw, dml_float_t, mode_lib->mp.TotalDataReadBandwidth);
 dml_get_var_func(return_bw, dml_float_t, mode_lib->ms.ReturnBW);
+dml_get_var_func(return_dram_bw, dml_float_t, mode_lib->ms.ReturnDRAMBW);
 dml_get_var_func(tcalc, dml_float_t, mode_lib->mp.TCalc);
 dml_get_var_func(comp_buffer_size_kbytes, dml_uint_t, mode_lib->mp.CompressedBufferSizeInkByte);
 dml_get_var_func(pixel_chunk_size_in_kbyte, dml_uint_t, mode_lib->ms.ip.pixel_chunk_size_kbytes);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h
index 3116b88e99dc..a38ed89c47a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h
@@ -105,10 +105,12 @@ dml_get_var_decl(stutter_num_bursts_z8_bestcase, dml_float_t);
 dml_get_var_decl(stutter_period_bestcase, dml_float_t);
 dml_get_var_decl(urgent_latency, dml_float_t);
 dml_get_var_decl(urgent_extra_latency, dml_float_t);
+dml_get_var_decl(fclk_change_latency, dml_float_t);
 dml_get_var_decl(nonurgent_latency, dml_float_t);
 dml_get_var_decl(dispclk_calculated, dml_float_t);
 dml_get_var_decl(total_data_read_bw, dml_float_t);
 dml_get_var_decl(return_bw, dml_float_t);
+dml_get_var_decl(return_dram_bw, dml_float_t);
 dml_get_var_decl(tcalc, dml_float_t);
 dml_get_var_decl(fraction_of_urgent_bandwidth, dml_float_t);
 dml_get_var_decl(fraction_of_urgent_bandwidth_imm_flip, dml_float_t);
-- 
2.34.1

