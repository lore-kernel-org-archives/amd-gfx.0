Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44A2C48BE0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9FF61263
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9FF61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 641646EDAB;
	Thu, 10 Jun 2021 16:29:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FF66ED93
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6NzO+YTBAuQOWO7zSRsQhslwG+XyxDbGp4wj9HbUVxCvkZ/xyniMrFriljgGCXAkJZMR3O/IhXBmDM5Kfn4OJgggK01z0yh/uvpewg75WzZ46zZ61lao5vl4AwZJrWdGMQnEJ3rJ3K1cN+9AoJid9QlNTbkUix+3l9i1mQHl96S4NWGaIaRFBP/hInvGKBIcJzpx0iJFx8FVxd8H5C2KbY7HYHQNe8C2v2suxR4UEbx0fJDX8ShyWUyGshpyG2agulwbbd2KMUZcHj/tl/jWjZjMi4M0SS54r1TUQfuK3fY/ID7h3rYwdA2r8znqtB+sdopPx0/ulpq2cmWOmyKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqyVC/B7vgqqNwjhKsqy1NiXt9GKyVBWp0YQPZwEFOg=;
 b=MzNQ3A3DbzYJgXwLF/rxFbbM8sYVzwl2txQgECKpSzcOmpsMX4OzDJPbvPgORTYaohDCwqdl0HeFkH+wA7t4A4lrEIlKdGo5KbDnQnFJQ4Xz4gRDEMpRDbpGoMqwkGoFu/P5b6Fv+v/BCqHJwapJFvUcN7JYZDNYsGKZIXpcBNeZ8cp//UmtHjoc486vXhoWrtWee4sx4y7wr1qoneaHPDQmpNEUJZ7ejN1NfDCTKJLOMdcU+oLDVtYukpUfGpix9/MFbFq6pDOOFF54fDPL6IUZ16kmR+2pWrwVuxqgRnlcHkpvjV2YN0k72mE2uBSgwusriZkGVPJ9l6C7tkCSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqyVC/B7vgqqNwjhKsqy1NiXt9GKyVBWp0YQPZwEFOg=;
 b=S3RWrhG3wdA9y2f7BRyHlebsnQQKPLEBzpTP3dWLzzVQeLiceChAFX1rhK6osEPbnUzg4V3qoLhNOaoU8FGtBHDpYJ77HPhhQmVyB8/rUMtgAWTGvIs4JCVtqg0WiOY+95W9CsjuHsiuFpxvUfwJ5DoMNmEBoryS8uAa2ONAfX0=
Received: from MWHPR15CA0025.namprd15.prod.outlook.com (2603:10b6:300:ad::11)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 16:29:29 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::69) by MWHPR15CA0025.outlook.office365.com
 (2603:10b6:300:ad::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 09:29:27 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:26 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/24] drm/amd/display: Move LTTPR cap read into its own
 function
Date: Thu, 10 Jun 2021 12:28:26 -0400
Message-ID: <20210610162838.287723-13-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 213ee0e0-bd90-4896-6286-08d92c2ceb5b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42834C44F8CA0ED4039B0E9AEB359@DM6PR12MB4283.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NsGqELhHonrSVzS4bj/LC/OajA2MISRaYUKi6+kR+MjwzpOcvrcKBYub6UXAFzCDGDOM320MeA3CpRs1EbyvdWQsv4uuUHX/TUwcqJCPLH5bKOMwOcODzuI+0VisT7kNCmuT45jNm2Am9/HgAAwa7oKtBuQeGxgjbevUZRoh4H/0zk78fGcNZZlG0q04sJKvDLrHYqXJUu5cF+6g5A3QgJsoB06q/BxtZodEsKRe1yuEZO5X4kv0xtbdT6VeJecvKBdEf2ZzqOUU/68az65IbtqbnA2zoPSsUAgfN/G7aVzxLzAFbXYwMtJdVPJCpTYD2zYOWM5rWWgqVCnpjBdqSR3DyHnG7Tl2/IchDkgZc3tiMBfxrqIhjtzkPBx1DIFJ+Ior8DXQADSNcYX5I48QMTaM3/8/q38vkNKNHqqeckSgRquhgDNm08ftEt5yJIWYlzWDMxz3VkJuHhBMaKGYMF9g6b5ig1Vxm6FOL0nWvpzL6BaI6z3BJJRTKvxFMKVBYWdc3JQZUBEW1AFgNdWH1vLgV4Le2b7crQRWoEEKfVN/hjeB2uIS970sSks7UMZH/+E0NZ6Ebe/9L7CBroQNqbs+WCCTp3E7pV1WIuyzeiiBoX8mQVugNeXJ1vrr0kO7JmbmdZylJD31WJmUucrEK6IaJADUqlQUZ81e/A8ysh6tL8igVn6kApfZ8Izb1bgr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(46966006)(36840700001)(5660300002)(36860700001)(478600001)(82310400003)(426003)(336012)(4326008)(47076005)(8936002)(82740400003)(2616005)(83380400001)(8676002)(356005)(81166007)(26005)(6916009)(70586007)(86362001)(186003)(7696005)(70206006)(1076003)(54906003)(2906002)(36756003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:28.6924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 213ee0e0-bd90-4896-6286-08d92c2ceb5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
We want LTTPR capabilities to be readable from more places than just
retrieve_link_cap

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 75 ++++++++++---------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 0e2741cd5f26..38fabaff51ea 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3619,47 +3619,16 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 	return true;
 }
 
-static bool retrieve_link_cap(struct dc_link *link)
+bool dp_retrieve_lttpr_cap(struct dc_link *link)
 {
-	/* DP_ADAPTER_CAP - DP_DPCD_REV + 1 == 16 and also DP_DSC_BITS_PER_PIXEL_INC - DP_DSC_SUPPORT + 1 == 16,
-	 * which means size 16 will be good for both of those DPCD register block reads
-	 */
-	uint8_t dpcd_data[16];
 	uint8_t lttpr_dpcd_data[6];
-
-	/*Only need to read 1 byte starting from DP_DPRX_FEATURE_ENUMERATION_LIST.
-	 */
-	uint8_t dpcd_dprx_data = '\0';
-	uint8_t dpcd_power_state = '\0';
-
-	struct dp_device_vendor_id sink_id;
-	union down_stream_port_count down_strm_port_count;
-	union edp_configuration_cap edp_config_cap;
-	union dp_downstream_port_present ds_port = { 0 };
-	enum dc_status status = DC_ERROR_UNEXPECTED;
-	uint32_t read_dpcd_retry_cnt = 3;
-	int i;
-	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
-	bool is_lttpr_present = false;
-	const uint32_t post_oui_delay = 30; // 30ms
 	bool vbios_lttpr_enable = false;
 	bool vbios_lttpr_interop = false;
 	struct dc_bios *bios = link->dc->ctx->dc_bios;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
+	bool is_lttpr_present = false;
 
-	memset(dpcd_data, '\0', sizeof(dpcd_data));
 	memset(lttpr_dpcd_data, '\0', sizeof(lttpr_dpcd_data));
-	memset(&down_strm_port_count,
-		'\0', sizeof(union down_stream_port_count));
-	memset(&edp_config_cap, '\0',
-		sizeof(union edp_configuration_cap));
-
-	/* if extended timeout is supported in hardware,
-	 * default to LTTPR timeout (3.2ms) first as a W/A for DP link layer
-	 * CTS 4.2.1.1 regression introduced by CTS specs requirement update.
-	 */
-	dc_link_aux_try_to_configure_timeout(link->ddc,
-			LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
-
 	/* Query BIOS to determine if LTTPR functionality is forced on by system */
 	if (bios->funcs->get_lttpr_caps) {
 		enum bp_result bp_query_result;
@@ -3741,7 +3710,45 @@ static bool retrieve_link_cap(struct dc_link *link)
 		else
 			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
 	}
+	return is_lttpr_present;
+}
+
+static bool retrieve_link_cap(struct dc_link *link)
+{
+	/* DP_ADAPTER_CAP - DP_DPCD_REV + 1 == 16 and also DP_DSC_BITS_PER_PIXEL_INC - DP_DSC_SUPPORT + 1 == 16,
+	 * which means size 16 will be good for both of those DPCD register block reads
+	 */
+	uint8_t dpcd_data[16];
+	/*Only need to read 1 byte starting from DP_DPRX_FEATURE_ENUMERATION_LIST.
+	 */
+	uint8_t dpcd_dprx_data = '\0';
+	uint8_t dpcd_power_state = '\0';
+
+	struct dp_device_vendor_id sink_id;
+	union down_stream_port_count down_strm_port_count;
+	union edp_configuration_cap edp_config_cap;
+	union dp_downstream_port_present ds_port = { 0 };
+	enum dc_status status = DC_ERROR_UNEXPECTED;
+	uint32_t read_dpcd_retry_cnt = 3;
+	int i;
+	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
+	const uint32_t post_oui_delay = 30; // 30ms
+	bool is_lttpr_present = false;
+
+	memset(dpcd_data, '\0', sizeof(dpcd_data));
+	memset(&down_strm_port_count,
+		'\0', sizeof(union down_stream_port_count));
+	memset(&edp_config_cap, '\0',
+		sizeof(union edp_configuration_cap));
+
+	/* if extended timeout is supported in hardware,
+	 * default to LTTPR timeout (3.2ms) first as a W/A for DP link layer
+	 * CTS 4.2.1.1 regression introduced by CTS specs requirement update.
+	 */
+	dc_link_aux_try_to_configure_timeout(link->ddc,
+			LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
 
+	is_lttpr_present = dp_retrieve_lttpr_cap(link);
 	if (!is_lttpr_present)
 		dc_link_aux_try_to_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
