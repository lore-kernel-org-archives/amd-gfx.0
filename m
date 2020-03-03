Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE31CC3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD26320716
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J1Qy/f+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD26320716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6773D6E0CD;
	Tue,  3 Mar 2020 23:27:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A956E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XivxnT7cZOyXowKyXjr9/utU2M0BalQf7P1mn41tulRnqaSyrKvqQxOncIuHxRS5UZBGFZOLz/moR/J2W5LqMfNbp07DblXhLAGn5YNLw5TSLx3Q3BbCeW8hdIcGxKo1Wk4OHaFIRMG22rY2QYw44uia0kDRVzV4CehQNWv1MoAbBWfXMqSI9+k5rSiJIqo6iZGIX9ycmPZRMVKtb99SYEUndZUTKYKS3OfUNVnaCKQcQyhTy7La4OSTOUYFiYvKOUxGbIXIrcFpv52CMd6c0UHCW2RfUxK2gKzMs8Z5yEsYAeZbiBifdfO1N4YBlLNkQHAtq1CDgQhG2V5yWPsDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fntfUf9AiZ3tITZYR/+WD2/hvprVgdIG+Eoiar5j49E=;
 b=Bs7LcG32PKzdzPDywmDj0qSz5Ye7v2Qxt9c8fK8rRAzRb5PboBK5YFikvLPMHrU12lpBg6Fz5/m1MFtk/olJywr4Vosc/8NjdE6PfB2FpG+WWhlTnwI0Ou4EKqIUJSYDLyalRz/HApCLW/570SCp+JKf+vF+CpwTLJD7L/IFZ4bXI1U1YFeCxHE1uiz7Xi6x067kH4AKFXd8/GUnqtR0iN5pVvgS0IcJloZ3Qw4XFWtERdCgcpFTZz4D6KZ0wHdprqM1lr+sjhUhzaUrOatCbF28fUcW/KM9kHX4XRdKesjU3nqwluUTdtmF5MP3Tq1b5R8gRvmmE32T5/gx3MQy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fntfUf9AiZ3tITZYR/+WD2/hvprVgdIG+Eoiar5j49E=;
 b=J1Qy/f+ONqXd1ka5cliB6zIKxQsm1RDBRDKDZbEIb8rIc7k61gDoW3uLmxHqdcyJK0mMDeKQWhKRFnnrJDn0fEAjV5L9i7nXGttT5sv5mH1FZkQ6Cmso+ElHuwGnt0dr2Z0rZFZwYdRWlejq0XMQNuvUSBKaUiCnX2gzrwV70So=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 23:27:34 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:27:34 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/12] drm/amd/display: update soc bb for nv14
Date: Tue,  3 Mar 2020 18:27:07 -0500
Message-Id: <20200303232718.351364-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
References: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:27:33 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a2fbb7c-1999-4e43-ac4d-08d7bfca73cd
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:|MW2PR12MB2441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2441A465FE0CE16D6A1D79B598E40@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(36756003)(6486002)(8936002)(54906003)(52116002)(7696005)(81166006)(81156014)(316002)(4326008)(6916009)(5660300002)(186003)(66476007)(956004)(66946007)(1076003)(478600001)(86362001)(2616005)(8676002)(6666004)(66556008)(26005)(16526019)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2441;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rP3HVpQr2dLUiMJbbM1q3rFq19KntW1CVpcOXdqq2EECMXtJGIyJCouNYxACM6JNg9MIjLgQ+oNiP0TQ9QP9Ds79HtnpLp/+1N4RBrbeexaNYYQ2vhJz9H4cPuWLOeaA/Sw5xEatEO5WfzirnvyUEawoDRy9NQ+4eNcw0kqikwhSTQ3yFbxWXxG3XqYtVGkMPS62Y9vSyPcmF901N8pOGmOubikD9vIE4Y/L8t97TNy/tqWjuDs4WQziw96a51VBidP1ajCg9f6U6XeoMdH23zpCY+rctavf3A2S9QNxbNw7WemewqEnKYrwDCrIOeCw/+a/TjOLTbJDQtP7uBvzZ/1634UNdgQTw98dytynYOjRKjL/QIvjZMZ1Sc/ShKBhVbaaDHXWzLTTT1JGG9Bdx6I2GDij/PbJDHUEtg8R7eyEgXKMXuaL7HqZFy4KLZ86
X-MS-Exchange-AntiSpam-MessageData: f+EXh9UUXTryaZjpsviwIg+awk+QzIiFpp3nrDnUAdVsvGfcJB5XMnjOemy/vc3n4JVKl2zx/+ZGfXRDWJAeUuuL7daJxFOJFC1jxTMSNCVUWb4qHd+X+nLe1K2YXiAnePfKtJnQhTph45hWryZcDQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2fbb7c-1999-4e43-ac4d-08d7bfca73cd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:27:34.6310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwaKYIRhcjhJfl9fHicFtd3mCLbdSaqAnYoJYy/iAxsQVYtZczWBP/6YA8APnMw8vZDDI2MOusAhuPfsnXG5QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2441
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Martin Leung <martin.leung@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[why]
nv14 previously inherited soc bb from generic dcn 2, did not match
watermark values according to memory team

[how]
add nv14 specific soc bb: copy nv2 generic that it was
using from before, but changed num channels to 8

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 113 +++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index c629a7b45f56..c8b85f62ae95 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -337,6 +337,117 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_0_soc = {
 	.use_urgent_burst_bw = 0
 };
 
+struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv14_soc = {
+	.clock_limits = {
+			{
+				.state = 0,
+				.dcfclk_mhz = 560.0,
+				.fabricclk_mhz = 560.0,
+				.dispclk_mhz = 513.0,
+				.dppclk_mhz = 513.0,
+				.phyclk_mhz = 540.0,
+				.socclk_mhz = 560.0,
+				.dscclk_mhz = 171.0,
+				.dram_speed_mts = 8960.0,
+			},
+			{
+				.state = 1,
+				.dcfclk_mhz = 694.0,
+				.fabricclk_mhz = 694.0,
+				.dispclk_mhz = 642.0,
+				.dppclk_mhz = 642.0,
+				.phyclk_mhz = 600.0,
+				.socclk_mhz = 694.0,
+				.dscclk_mhz = 214.0,
+				.dram_speed_mts = 11104.0,
+			},
+			{
+				.state = 2,
+				.dcfclk_mhz = 875.0,
+				.fabricclk_mhz = 875.0,
+				.dispclk_mhz = 734.0,
+				.dppclk_mhz = 734.0,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 875.0,
+				.dscclk_mhz = 245.0,
+				.dram_speed_mts = 14000.0,
+			},
+			{
+				.state = 3,
+				.dcfclk_mhz = 1000.0,
+				.fabricclk_mhz = 1000.0,
+				.dispclk_mhz = 1100.0,
+				.dppclk_mhz = 1100.0,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 1000.0,
+				.dscclk_mhz = 367.0,
+				.dram_speed_mts = 16000.0,
+			},
+			{
+				.state = 4,
+				.dcfclk_mhz = 1200.0,
+				.fabricclk_mhz = 1200.0,
+				.dispclk_mhz = 1284.0,
+				.dppclk_mhz = 1284.0,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 1200.0,
+				.dscclk_mhz = 428.0,
+				.dram_speed_mts = 16000.0,
+			},
+			/*Extra state, no dispclk ramping*/
+			{
+				.state = 5,
+				.dcfclk_mhz = 1200.0,
+				.fabricclk_mhz = 1200.0,
+				.dispclk_mhz = 1284.0,
+				.dppclk_mhz = 1284.0,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 1200.0,
+				.dscclk_mhz = 428.0,
+				.dram_speed_mts = 16000.0,
+			},
+		},
+	.num_states = 5,
+	.sr_exit_time_us = 8.6,
+	.sr_enter_plus_exit_time_us = 10.9,
+	.urgent_latency_us = 4.0,
+	.urgent_latency_pixel_data_only_us = 4.0,
+	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
+	.urgent_latency_vm_data_only_us = 4.0,
+	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 40.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 40.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 40.0,
+	.max_avg_sdp_bw_use_normal_percent = 40.0,
+	.max_avg_dram_bw_use_normal_percent = 40.0,
+	.writeback_latency_us = 12.0,
+	.ideal_dram_bw_after_urgent_percent = 40.0,
+	.max_request_size_bytes = 256,
+	.dram_channel_width_bytes = 2,
+	.fabric_datapath_to_dcn_data_return_bytes = 64,
+	.dcn_downspread_percent = 0.5,
+	.downspread_percent = 0.38,
+	.dram_page_open_time_ns = 50.0,
+	.dram_rw_turnaround_time_ns = 17.5,
+	.dram_return_buffer_per_channel_bytes = 8192,
+	.round_trip_ping_latency_dcfclk_cycles = 131,
+	.urgent_out_of_order_return_per_channel_bytes = 256,
+	.channel_interleave_bytes = 256,
+	.num_banks = 8,
+	.num_chans = 8,
+	.vmm_page_size_bytes = 4096,
+	.dram_clock_change_latency_us = 404.0,
+	.dummy_pstate_latency_us = 5.0,
+	.writeback_dram_clock_change_latency_us = 23.0,
+	.return_bus_width_bytes = 64,
+	.dispclk_dppclk_vco_speed_mhz = 3850,
+	.xfc_bus_transport_time_us = 20,
+	.xfc_xbuf_latency_tolerance_us = 4,
+	.use_urgent_burst_bw = 0
+};
+
 struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv12_soc = { 0 };
 
 #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
@@ -3298,7 +3409,7 @@ static struct _vcs_dpi_soc_bounding_box_st *get_asic_rev_soc_bb(
 	uint32_t hw_internal_rev)
 {
 	if (ASICREV_IS_NAVI12_P(hw_internal_rev))
-		return &dcn2_0_nv12_soc;
+		return &dcn2_0_nv14_soc;
 
 	return &dcn2_0_soc;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
