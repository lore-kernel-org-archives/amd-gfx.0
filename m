Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A716EC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 18:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E6720760
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 18:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Gl66AJpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E6720760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CEBF6E077;
	Thu, 15 Oct 2020 18:21:14 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F75E6E077
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 18:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnaDefgS90S0N7/NoocntbGjz6BARkB4Ph//ArYO7zQLhRTe18/Mkr0Ckq/Fcek3w5UywiBmAICHyDEIuwv4VCvMc5evxXPFpjWP699JBRA1/61UPA0qR1oPWRA/pE/z1ksVFrxo7Ag35icqvbighxl7XrS0IWJUQpkMhzYhAU2QHPqgDwizgLrfxntsLZbVF1d0gz4c0/avlZlLJvN1rsPv/FMvkw69EBvk7qv72tTZb2TnN2rThnPvmbj3gC27KayKmCvAyZXo8iGTy/rZiL/PyCo9ioY9xUuZXktetWk8YzyRk1CulQmXNFkPof2XNVB2s5Y5sVciGKr7OQY7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/DqYuAcixefQihW5PcZyttz9XlCyORUFMsKPM+IuXQ=;
 b=GBslPuWAngcu/3IN5EDahznjVjhwFuxxrpz4u/jTTZD7Fzr/AQgOasU4uI1MVkCOAodZoHZuHUx+7luxYTkO87W5EObtAh7BJc/ZCPSacCcfNrCcPROjJu6ORfCIItvAUSmmzNxZ/TPUYRyBmhfatDvuz+aKLd4lF7sbN/Y8fddTo8f3CFETQ+wka+d/6Zb3rm8lVwQJrvhz+PFOM5SUaKGeLYR0rjFsPsoaJ1Jx3E3g2mTEkXMUZrI3K71IsOXgnfIUb0cmPPrsnHLpyPPnoT0cAPzYHnfD6uSP3puz+Z90eIfplhz2JX0FfaKNhB5XqzjdnRMlTX1JyKRH7YtdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/DqYuAcixefQihW5PcZyttz9XlCyORUFMsKPM+IuXQ=;
 b=Gl66AJpt1mQcbdkSTnBYOnkicu1umWNZlMLzRkLuqskes3egadevpkUjGWs7+5Txkr9dnoHG5vbEQOt3HLGAocQXEjvLOcxuO9opsEbJy7pgCjI6stbGntPzPF6ZnSoV3+5fmtkeQYKHRcSch9TOGVKSgSq8xLv6vS5Pp00IRb8=
Received: from MWHPR13CA0044.namprd13.prod.outlook.com (2603:10b6:300:95::30)
 by BN6PR1201MB0034.namprd12.prod.outlook.com (2603:10b6:405:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Thu, 15 Oct
 2020 18:21:11 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::cd) by MWHPR13CA0044.outlook.office365.com
 (2603:10b6:300:95::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Thu, 15 Oct 2020 18:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 18:21:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 15 Oct
 2020 13:21:10 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 15 Oct
 2020 13:21:10 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 15 Oct 2020 13:21:09 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Use amdgpu_socbb.h instead of redefining
 structs
Date: Thu, 15 Oct 2020 14:20:03 -0400
Message-ID: <20201015182004.4079457-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dabd3982-c00b-4aee-29e7-08d87137180c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0034:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB003473B86799A727FB30B4A9F9020@BN6PR1201MB0034.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDdvZgp+pc8G2xYJBYD+JQJZ/PNvgukOHSLB68/LoA6++8XV52+1ezBvF8/kUm9Szg5fitRpVObgV8JpLSzB6PqvWZlUD5D2kDRwvbIw6lAVU+Lq83NNVKRiybiH/CfYuP+qkDhJDRak2jirHXHRy0esp5lESVes/P/PtJiIt+eoyf+Fmt+dpj+BHjA2PberZknecUv9xKjMYsipYBoj6GuRk7xeXSko8P0Si5EhvACw+rVQRVIEpZ7xljl8HyYC3YCcir5zJo6uUpz4AV/c97d1M1V2Gmz4W/TF5S0mB5cFAtIynxsTEEg+zsNnM53R1mlenvr0Xe9ZzTIbbBhUzpUhXyuJm3FwlQD9y1QlP7bpq9QPTAVZcshFIWWSs0Fc4Qf5yf+xPYpSR1weqvDXMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966005)(186003)(6666004)(8936002)(83380400001)(54906003)(82310400003)(47076004)(110136005)(82740400003)(1076003)(26005)(6636002)(70586007)(2906002)(478600001)(36756003)(336012)(316002)(2616005)(5660300002)(356005)(70206006)(8676002)(7696005)(4326008)(426003)(81166007)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 18:21:11.1826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dabd3982-c00b-4aee-29e7-08d87137180c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0034
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
Cc: rodrigo.siqOFueira@amd.com, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../amd/display/dc/dcn302/dcn302_resource.c   | 58 +------------------
 1 file changed, 1 insertion(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index b8b3152ec613..38e807f22060 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -65,66 +65,10 @@
 #include "dcn/dpcs_3_0_0_offset.h"
 #include "dcn/dpcs_3_0_0_sh_mask.h"
 #include "nbio/nbio_7_4_offset.h"
+#include "amdgpu_socbb.h"
 
 #define DC_LOGGER_INIT(logger)
 
-struct gpu_info_voltage_scaling_v1_0 {
-	int state;
-	uint32_t dscclk_mhz;
-	uint32_t dcfclk_mhz;
-	uint32_t socclk_mhz;
-	uint32_t dram_speed_mts;
-	uint32_t fabricclk_mhz;
-	uint32_t dispclk_mhz;
-	uint32_t phyclk_mhz;
-	uint32_t dppclk_mhz;
-};
-
-struct gpu_info_soc_bounding_box_v1_0 {
-	uint32_t sr_exit_time_us;
-	uint32_t sr_enter_plus_exit_time_us;
-	uint32_t urgent_latency_us;
-	uint32_t urgent_latency_pixel_data_only_us;
-	uint32_t urgent_latency_pixel_mixed_with_vm_data_us;
-	uint32_t urgent_latency_vm_data_only_us;
-	uint32_t writeback_latency_us;
-	uint32_t ideal_dram_bw_after_urgent_percent;
-	// PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelDataOnly
-	uint32_t pct_ideal_dram_sdp_bw_after_urgent_pixel_only;
-	uint32_t pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm;
-	uint32_t pct_ideal_dram_sdp_bw_after_urgent_vm_only;
-	uint32_t max_avg_sdp_bw_use_normal_percent;
-	uint32_t max_avg_dram_bw_use_normal_percent;
-	unsigned int max_request_size_bytes;
-	uint32_t downspread_percent;
-	uint32_t dram_page_open_time_ns;
-	uint32_t dram_rw_turnaround_time_ns;
-	uint32_t dram_return_buffer_per_channel_bytes;
-	uint32_t dram_channel_width_bytes;
-	uint32_t fabric_datapath_to_dcn_data_return_bytes;
-	uint32_t dcn_downspread_percent;
-	uint32_t dispclk_dppclk_vco_speed_mhz;
-	uint32_t dfs_vco_period_ps;
-	unsigned int urgent_out_of_order_return_per_channel_pixel_only_bytes;
-	unsigned int urgent_out_of_order_return_per_channel_pixel_and_vm_bytes;
-	unsigned int urgent_out_of_order_return_per_channel_vm_only_bytes;
-	unsigned int round_trip_ping_latency_dcfclk_cycles;
-	unsigned int urgent_out_of_order_return_per_channel_bytes;
-	unsigned int channel_interleave_bytes;
-	unsigned int num_banks;
-	unsigned int num_chans;
-	unsigned int vmm_page_size_bytes;
-	uint32_t dram_clock_change_latency_us;
-	uint32_t writeback_dram_clock_change_latency_us;
-	unsigned int return_bus_width_bytes;
-	unsigned int voltage_override;
-	uint32_t xfc_bus_transport_time_us;
-	uint32_t xfc_xbuf_latency_tolerance_us;
-	int use_urgent_burst_bw;
-	unsigned int num_states;
-	struct gpu_info_voltage_scaling_v1_0 clock_limits[8];
-};
-
 struct _vcs_dpi_ip_params_st dcn3_02_ip = {
 		.use_min_dcfclk = 0,
 		.clamp_min_dcfclk = 0,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
