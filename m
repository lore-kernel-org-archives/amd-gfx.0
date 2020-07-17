Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3476C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CE920737
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JCOq2eDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CE920737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 148E46EE1C;
	Fri, 17 Jul 2020 17:38:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9535C6EE1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 17:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZIusxRQx5gxWY20uh5pVdcHwiOv4AXEY7WWvZ6Vc7/oeYq64Bl4EJOHEwEzgJmrSJj43oqsjNLRURh8APpyAG/RG/uRGOtKrwg6b/7xXTOcoYgLl9hUw3F2WxwtcwW/YZ/8Mkij3cexBz6DoOXJnc4Olh/HDE0NHV5RnTQJL/SODS8wr0N19OFlffBfg0nHWBq5/IY/MK7E/M7gU8ms7WPA0GGBquWIXJ+2xJLIk9H1Lmujvr7EgvQX2QAs2z9PLn9xRdpGEeMqjVO7G5LGAAv1+ote7v4P3efKfNNI1dcKEOQwk2TAEigtNSo2+IQKH7HHLzEecL/m0xeEzBj2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT4/E6cMVuMwSZRB1mztvSXzw15eAPVa7EP+3j59lyA=;
 b=eQIU8gQ+flD+x/b2unNeXsGZmZy/xu7Wnoxio8D54PbMIFex9WkKMpdkXgtt26dfktHJkuDdwBmhaH2tzQCAmmMfaT88o0OjoZM/zKjjFvK5kkJWmyxX/ATIKv+WAuqqDIRtISg0KAf8epxblAc6S73ss9rwkExBD1y4w+KKCt4E2f23nTZBjv3Kv6YwMG2EJn5fLwIdYzKgdZVuBKfD9yuii4qfrMUniz39q3w2wSSt4e3mo98BzKjwBNPB8DHwgFw1lFbiPSsVIwrXIpXvd/DRYSzLDSf644U2VSSn2DcjmQ9PtccC4CJaZAI4mdzJjqiDywfio3OPLAwXAkucRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT4/E6cMVuMwSZRB1mztvSXzw15eAPVa7EP+3j59lyA=;
 b=JCOq2eDXa+kCXfRlkKb4jpYhm9gzL35niud2n/RULbDpfCLsaGufgqhIlPeD15YamALD6J27HRta8+P2RwJpZAK5ix+UVZi6xDywV+Omxo2Yqk1vjSuqOydosyGT4Y5dE6hNu2TFH7C35PyA1y8rfqKtZFtfdW8NyEZQ1niyWHY=
Received: from BN6PR11CA0041.namprd11.prod.outlook.com (2603:10b6:404:4b::27)
 by DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Fri, 17 Jul
 2020 17:38:25 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::94) by BN6PR11CA0041.outlook.office365.com
 (2603:10b6:404:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Fri, 17 Jul 2020 17:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 17:38:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:22 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:22 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jul 2020 12:38:22 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amd/display: rename dsc extended caps as dsc branch
 decoder caps
Date: Fri, 17 Jul 2020 13:38:06 -0400
Message-ID: <20200717173813.11674-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717173813.11674-1-qingqing.zhuo@amd.com>
References: <20200717173813.11674-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(336012)(478600001)(44832011)(8676002)(6916009)(82740400003)(426003)(2616005)(36756003)(356005)(82310400002)(83380400001)(70586007)(8936002)(70206006)(81166007)(47076004)(4326008)(86362001)(54906003)(5660300002)(2906002)(316002)(1076003)(6666004)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b92a8d43-dfad-4e31-9e77-08d82a783419
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2359049A080CF189FB92E610FB7C0@DM5PR12MB2359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyyI0bkiE3NorAx+6+YgFkTl3hw0UumjPFqqAI3gT2k9n3PD+xDrolSZf0/4rd3lEFy7dMy3SeW3O4vKXlWgvyjs3tyNW1WMXDoOy3QPkkYCZsL1Zx6DSC2/PTKQ2BB6EnQLxI374cXdHJCSL2dzS9JXiZfwrIa6yQzTH7Y8MZoOKGeh2/lAHScWt4jmFiQemcpS+C6kJUmj1T1/QeY0f1TfrqXyCYAE/k30wV+wObNpjnWMJY6xB+djgKgkSaj7h4QFJTJrJjTiWH0E29juhUPmQ/W8MrwYQ0VL+BEmUvsOkdI7FSfkdMagLdWiOJaOfNGNvgJK2soodCfNyOgPjMzUw7B6AImsAvgAz4fiHNA0UDXs0lvxgQJARjqhcwtav5NT/5k7O2n/8r6n8PmjvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:38:23.1021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b92a8d43-dfad-4e31-9e77-08d82a783419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
The capability fields are reserved for DSC branch
only to report the capability related to the
branch's DSC decoder.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c  |  4 ++--
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h      |  4 ++--
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c       | 10 +++++-----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f46db2f3c620..7d78205d3604 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4621,7 +4621,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
 				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
-				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_ext_caps.raw,
+				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
 				      &dsc_caps);
 #endif
 		link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 31c0b35bab67..277b29590fb9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3519,8 +3519,8 @@ static bool retrieve_link_cap(struct dc_link *link)
 		status = core_link_read_dpcd(
 				link,
 				DP_DSC_BRANCH_OVERALL_THROUGHPUT_0,
-				link->dpcd_caps.dsc_caps.dsc_ext_caps.raw,
-				sizeof(link->dpcd_caps.dsc_caps.dsc_ext_caps.raw));
+				link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
+				sizeof(link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw));
 	}
 
 	if (!dpcd_read_sink_ext_caps(link))
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index af177c087d3b..a8a3b0643505 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -726,7 +726,7 @@ union dpcd_dsc_basic_capabilities {
 	uint8_t raw[16];
 };
 
-union dpcd_dsc_ext_capabilities {
+union dpcd_dsc_branch_decoder_capabilities {
 	struct {
 		uint8_t BRANCH_OVERALL_THROUGHPUT_0;
 		uint8_t BRANCH_OVERALL_THROUGHPUT_1;
@@ -737,7 +737,7 @@ union dpcd_dsc_ext_capabilities {
 
 struct dpcd_dsc_capabilities {
 	union dpcd_dsc_basic_capabilities dsc_basic_caps;
-	union dpcd_dsc_ext_capabilities dsc_ext_caps;
+	union dpcd_dsc_branch_decoder_capabilities dsc_branch_decoder_caps;
 };
 
 /* These parameters are from PSR capabilities reported by Sink DPCD */
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 0c7f247bb7de..8cdaa6eef5d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -747,7 +747,7 @@ static bool setup_dsc_config(
 	return is_dsc_possible;
 }
 
-bool dc_dsc_parse_dsc_dpcd(const struct dc *dc, const uint8_t *dpcd_dsc_basic_data, const uint8_t *dpcd_dsc_ext_data, struct dsc_dec_dpcd_caps *dsc_sink_caps)
+bool dc_dsc_parse_dsc_dpcd(const struct dc *dc, const uint8_t *dpcd_dsc_basic_data, const uint8_t *dpcd_dsc_branch_decoder_caps, struct dsc_dec_dpcd_caps *dsc_sink_caps)
 {
 	if (!dpcd_dsc_basic_data)
 		return false;
@@ -818,14 +818,14 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc, const uint8_t *dpcd_dsc_basic_da
 	}
 
 	/* Extended caps */
-	if (dpcd_dsc_ext_data == NULL) { // Extended DPCD DSC data can be null, e.g. because it doesn't apply to SST
+	if (dpcd_dsc_branch_decoder_caps == NULL) { // branch decoder DPCD DSC data can be null for non branch device
 		dsc_sink_caps->branch_overall_throughput_0_mps = 0;
 		dsc_sink_caps->branch_overall_throughput_1_mps = 0;
 		dsc_sink_caps->branch_max_line_width = 0;
 		return true;
 	}
 
-	dsc_sink_caps->branch_overall_throughput_0_mps = dpcd_dsc_ext_data[DP_DSC_BRANCH_OVERALL_THROUGHPUT_0 - DP_DSC_BRANCH_OVERALL_THROUGHPUT_0];
+	dsc_sink_caps->branch_overall_throughput_0_mps = dpcd_dsc_branch_decoder_caps[DP_DSC_BRANCH_OVERALL_THROUGHPUT_0 - DP_DSC_BRANCH_OVERALL_THROUGHPUT_0];
 	if (dsc_sink_caps->branch_overall_throughput_0_mps == 0)
 		dsc_sink_caps->branch_overall_throughput_0_mps = 0;
 	else if (dsc_sink_caps->branch_overall_throughput_0_mps == 1)
@@ -835,7 +835,7 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc, const uint8_t *dpcd_dsc_basic_da
 		dsc_sink_caps->branch_overall_throughput_0_mps += 600;
 	}
 
-	dsc_sink_caps->branch_overall_throughput_1_mps = dpcd_dsc_ext_data[DP_DSC_BRANCH_OVERALL_THROUGHPUT_1 - DP_DSC_BRANCH_OVERALL_THROUGHPUT_0];
+	dsc_sink_caps->branch_overall_throughput_1_mps = dpcd_dsc_branch_decoder_caps[DP_DSC_BRANCH_OVERALL_THROUGHPUT_1 - DP_DSC_BRANCH_OVERALL_THROUGHPUT_0];
 	if (dsc_sink_caps->branch_overall_throughput_1_mps == 0)
 		dsc_sink_caps->branch_overall_throughput_1_mps = 0;
 	else if (dsc_sink_caps->branch_overall_throughput_1_mps == 1)
@@ -845,7 +845,7 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc, const uint8_t *dpcd_dsc_basic_da
 		dsc_sink_caps->branch_overall_throughput_1_mps += 600;
 	}
 
-	dsc_sink_caps->branch_max_line_width = dpcd_dsc_ext_data[DP_DSC_BRANCH_MAX_LINE_WIDTH - DP_DSC_BRANCH_OVERALL_THROUGHPUT_0] * 320;
+	dsc_sink_caps->branch_max_line_width = dpcd_dsc_branch_decoder_caps[DP_DSC_BRANCH_MAX_LINE_WIDTH - DP_DSC_BRANCH_OVERALL_THROUGHPUT_0] * 320;
 	ASSERT(dsc_sink_caps->branch_max_line_width == 0 || dsc_sink_caps->branch_max_line_width >= 5120);
 
 	return true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
