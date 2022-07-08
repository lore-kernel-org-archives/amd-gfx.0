Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A369AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 16:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC4610E281;
	Fri,  8 Jul 2022 16:36:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D97F10E281
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 16:36:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOCtC6pVTOnXSAUYo1uNNY1UGf2TOfRKlRMb3uhPl4v+6H+X0ePtkjgLvRJFGawkF+1ihiPjXh2EgUQWP4YgB7QxyccSXaoeVMMkPCXb70xCtFga2Jn79D6XbMJpY85R3cdd78pfOOIohqFG7moqhfwztP62ojbWcMxnk+jZn34Cc3wmRnFBtqTuY6zNUyZ2/RJfpORjk7Eu+boelwCVdSiyi/yJkrGNOfNp1MqgKNnzcp5uFK8+InOs/cBfs/l44jvZufHxzHtHEur0Qw2Xw/fD+5siDJaRhnwJOj9abzUcTsIDbccffJxVw53I5p4y78OsOJ2HgwoT6s51xhliUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4imw/lBqLhrt79ISJJSpfyLwsbZimdkTBf5YE1SrXmk=;
 b=SFQBWMSwkEIHWJy6L/airo9GBgt8fogpvpQtis12p99/iwcEvaiWCXxlaNsH22yh0V0SoqXwks1U9RuN+EhyQ3QSeVrLLKXUf11viZzrXwSo1hEF9USzfeu/feXuxArA8wt2/vGBlsWalNyQxQ7Myxa3J1gnZlqhJ4j6MzacM1/2BgVZAI7K0uPQ6ssckqQM3a+lHb9D0/YsiGee9NpUxbiUzeNuxvRWWrXecxSEBzYpPMJmg/fHxdM4ekDJt0SAs8GeLRVsoqNl4/l0dkRgbHYfRI6TZhrTV9cv3oqbNGGgeY9EauUo6cD191lOQmPe3T9GEFQ6NjYG41biBW9nrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4imw/lBqLhrt79ISJJSpfyLwsbZimdkTBf5YE1SrXmk=;
 b=F4dcG0OYin1T5sgjCn7drUtbof3mJSQSgPU2nyJWtvXha6rF7HJ2Z/gPd57EvXSsvdDLAno1Lr7GK3QLIfVF3tiRKe7YeBggbyLsPlBB3VyU8Af0TXqYHpAWO/B2tb8X7E6qxCU2mQbZvubATJ+rEHydEc0QDtVT5+hPtjSVQFQ=
Received: from BN6PR14CA0031.namprd14.prod.outlook.com (2603:10b6:404:13f::17)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 8 Jul
 2022 16:36:55 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::83) by BN6PR14CA0031.outlook.office365.com
 (2603:10b6:404:13f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 8 Jul 2022 16:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 16:36:55 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 11:36:50 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/21] drm/amd/display: update DML1 logic for unbounded req
 handling
Date: Sat, 9 Jul 2022 00:35:19 +0800
Message-ID: <20220708163529.3534276-12-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81af2f6f-036b-4069-afa7-08da610011d9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5180:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RoSWkGh57yRTNGEgou5CZWMkKsq2IX/rOTSMqc6KbIAOSd/dPUVe0LnqvCbM/iHij/9HXgMQ10zLqQUf0sYjrGOUiImVgnkxmwGpishgh/O5BGM+BOPEckKd2kj1eHE5+VqJq+Q6ZMRx+XCQof6iUJ5igfKkzDM3xV1gk2ETEhNSL+JG3uLpwhzlcEFAs5uMAy35Ssc4MW7JuNOolNHG3GRrG4m8wx5r5/M2O0gAu3frgsk3SmWyq8nxQsUJyfC37jSyc+tXkflNNwSamX063d2TIqjeQkE5vZ/39j57Mole/JYDBjMYsvTp5ODITU+5zQx8NvQzcxkoHdgL29NCGmLw1o0uic0MntxVFIop4jQXdAOasQB4Suw+pKqhkSidW+2ncs02T480yiaNciN2g+8dX2dfD622wVD0/kpz/tfe+lSIyoftcIpnYvIOQi5Y4u/c1YAqnRv1XFKMiZAtE0lYNMTAC1R4qNQ5K99TF4/2hjEC6XsQ7BfAZDxzpqfrqMvNycFDvcGWowoh4ar4j+pJgW8ZGBEEI1FVePVRHXA18K9Uzsa5ShBYfAztFTSAtyZhI4nh3TqKbW72h3YcTaC0iP9NY4T+iy4d8qJHw33fmwwyfHHZEE3LTgpTwwwyiYSE1p259qbzT6tkCI+zBwOMDHIvwfbWePiLaK3xg7ZE6LK8sZIKpZyAAtJ2Bkw83azXnrVMH55XWxzBWixZy/FMqqRlWSSh0K1Fms1ThCrl+od+NRv2gFVLeFnLhL49FCz7qe+X/mAARgFq3bd2J2K8D7xmxnVakEyoQFOo7tuA9SysbJFJG1weLMr1nayVZOUsSUADQLVguFWPSK4MIOFPgKrSThRH/OJuZsCxrEE7AZnEhGRpK5C2gIrBO5L+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(40470700004)(40480700001)(2906002)(186003)(426003)(34020700004)(82740400003)(6666004)(316002)(82310400005)(83380400001)(16526019)(36860700001)(40460700003)(336012)(2616005)(15650500001)(47076005)(1076003)(36756003)(7696005)(86362001)(356005)(8676002)(8936002)(6916009)(81166007)(478600001)(70586007)(70206006)(4326008)(26005)(44832011)(41300700001)(5660300002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:36:55.3094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81af2f6f-036b-4069-afa7-08da610011d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
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
Cc: stylon.wang@amd.com, Dmytro
 Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lei, Jun" <Jun.Lei@amd.com>

[why]
Unbounded request logic in resource/DML has some issues where
unbounded request is being enabled incorrectly.  SW today enables
unbounded request unconditionally in hardware, on the assumption
that HW can always support it in single pipe scenarios.

This worked until now because the same assumption is made in DML.
A new DML update is needed to fix a bug, where there are single
pipe scenarios where unbounded cannot be enabled, and this change
in DML needs to be ported in, and dcn32 resource logic fixed.

[how]
First, dcn32_resource should program unbounded req in HW according
to unbounded req enablement output from DML, as opposed to DML input

Second, port in DML1 update which disables unbounded req in some
scenarios to fix an issue with poor stutter performance

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Jun Lei <jun.lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 95edca4c085b..607172542242 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -110,6 +110,7 @@ dml_get_attr_func(return_bw, mode_lib->vba.ReturnBW);
 dml_get_attr_func(tcalc, mode_lib->vba.TCalc);
 dml_get_attr_func(fraction_of_urgent_bandwidth, mode_lib->vba.FractionOfUrgentBandwidth);
 dml_get_attr_func(fraction_of_urgent_bandwidth_imm_flip, mode_lib->vba.FractionOfUrgentBandwidthImmediateFlip);
+
 dml_get_attr_func(cstate_max_cap_mode, mode_lib->vba.DCHUBBUB_ARB_CSTATE_MAX_CAP_MODE);
 dml_get_attr_func(comp_buffer_size_kbytes, mode_lib->vba.CompressedBufferSizeInkByte);
 dml_get_attr_func(pixel_chunk_size_in_kbyte, mode_lib->vba.PixelChunkSizeInKByte);
@@ -120,6 +121,11 @@ dml_get_attr_func(min_meta_chunk_size_in_byte, mode_lib->vba.MinMetaChunkSizeByt
 dml_get_attr_func(fclk_watermark, mode_lib->vba.Watermark.FCLKChangeWatermark);
 dml_get_attr_func(usr_retraining_watermark, mode_lib->vba.Watermark.USRRetrainingWatermark);
 
+dml_get_attr_func(comp_buffer_reserved_space_kbytes, mode_lib->vba.CompBufReservedSpaceKBytes);
+dml_get_attr_func(comp_buffer_reserved_space_64bytes, mode_lib->vba.CompBufReservedSpace64B);
+dml_get_attr_func(comp_buffer_reserved_space_zs, mode_lib->vba.CompBufReservedSpaceZs);
+dml_get_attr_func(unbounded_request_enabled, mode_lib->vba.UnboundedRequestEnabled);
+
 #define dml_get_pipe_attr_func(attr, var)  double get_##attr(struct display_mode_lib *mode_lib, const display_e2e_pipe_params_st *pipes, unsigned int num_pipes, unsigned int which_pipe) \
 {\
 	unsigned int which_plane; \
@@ -842,6 +848,9 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 
 	mode_lib->vba.SynchronizeTimingsFinal = pipes[0].pipe.dest.synchronize_timings;
 	mode_lib->vba.DCCProgrammingAssumesScanDirectionUnknownFinal = false;
+
+	mode_lib->vba.DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment = 0;
+
 	mode_lib->vba.UseUnboundedRequesting = dm_unbounded_requesting;
 	for (k = 0; k < mode_lib->vba.cache_num_pipes; ++k) {
 		if (pipes[k].pipe.src.unbounded_req_mode == 0)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 10ff536ef2a4..acb9434fb955 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -67,6 +67,10 @@ dml_get_attr_decl(min_pixel_chunk_size_in_byte);
 dml_get_attr_decl(min_meta_chunk_size_in_byte);
 dml_get_attr_decl(fclk_watermark);
 dml_get_attr_decl(usr_retraining_watermark);
+dml_get_attr_decl(comp_buffer_reserved_space_kbytes);
+dml_get_attr_decl(comp_buffer_reserved_space_64bytes);
+dml_get_attr_decl(comp_buffer_reserved_space_zs);
+dml_get_attr_decl(unbounded_request_enabled);
 
 #define dml_get_pipe_attr_decl(attr) double get_##attr(struct display_mode_lib *mode_lib, const display_e2e_pipe_params_st *pipes, unsigned int num_pipes, unsigned int which_pipe)
 
@@ -470,6 +474,7 @@ struct vba_vars_st {
 	bool XFCEnabled[DC__NUM_DPP__MAX];
 	bool ScalerEnabled[DC__NUM_DPP__MAX];
 	unsigned int VBlankNom[DC__NUM_DPP__MAX];
+	bool DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment;
 
 	// Intermediates/Informational
 	bool ImmediateFlipSupport;
@@ -513,6 +518,10 @@ struct vba_vars_st {
 	double StutterPeriodBestCase;
 	Watermarks      Watermark;
 	bool DCHUBBUB_ARB_CSTATE_MAX_CAP_MODE;
+	unsigned int CompBufReservedSpaceKBytes;
+	unsigned int CompBufReservedSpace64B;
+	unsigned int CompBufReservedSpaceZs;
+	bool CompBufReservedSpaceNeedAdjustment;
 
 	// These are the clocks calcuated by the library but they are not actually
 	// used explicitly. They are fetched by tests and then possibly used. The
-- 
2.25.1

