Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1A1C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F67961A28
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F67961A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E8656F4C4;
	Fri, 26 Mar 2021 22:06:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF836F4C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXCiDe15gH+lfD0cPhodXyGkCYs6mkTHSVt43C/kZNECzMsHlLBttZPxuIq9B0DubuA/L+IEdk2PTugIZd/uW9SX6COICKS03Q4SiPSujnK4jedxn6MZ6w/FqQs3e5g0V/5gYcWIZwVzjBhWxO4xbcJHSB6qbSizpyh478LW4Mq9f9S7wo5K2O8uvkhRE+ay4RJ6mzZf9gidrSb5vo4oWxh5qTufPKlJZAjcBNEglNzJVogZpid+o6IGdB1tSjNQ4MMX+GA1nYpb1+4gLAvjxXBy5mbtN5TL3zRr9brV4X/67lxuE7/0DaF9vRjZPRU+nmVzYecdL10Mnnz2su6JuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zPckaSBDysdCQp46BcH7o0inWG+1oF3HIlYC0EHBrQ=;
 b=jkhzRFMOCEvMLSdj0FnOTn0Kid3WIPBA7EM8eA0TDvHRSqD8abA7p7OxYOkQ+3Oc9+3+suK8bLFl4BjVxMEydzHQxl90s6GO9JGJgHZ0uU6vbNj3Avm5iS25xDgc27hT+p+fqlCGr3jOIYX2vPWmFd1V+PevJociOPBIPL/AzRopTXMewU0za81X3Hz2rq5vLuM7yZyqLE6A0CmibUjtGCIDVwv8qVd3hrUdnlWbwt3cexOLjRw3HWfnk5NvwFt3xmd6vjE+QBrpz6bDKFHa9iCSD363Va8wV+lBG2xGhmDgjFxDfQ7fYEsnV3db7CG8y6BCUUhfV3jqhAulCAINmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zPckaSBDysdCQp46BcH7o0inWG+1oF3HIlYC0EHBrQ=;
 b=uVew9NTp75WJ99SoxOSbmgmDIDrMKvPcH2lkCJ/7XQ6cjzBXXjbMWFWuEgi/vcVTDvGCo1hbIlwI9LXPr4KpHTxc2MEJln3xYWFxKX+tDDVqlXyovQxed6oZAR3PJuAOvVDZbxmoL/TdnzmPgDsjDrVYPCMDcJRjuGepwLNxo/I=
Received: from BN0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:ee::30)
 by MN2PR12MB3071.namprd12.prod.outlook.com (2603:10b6:208:cc::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 22:06:16 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::31) by BN0PR04CA0025.outlook.office365.com
 (2603:10b6:408:ee::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:15 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:06:14 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/21] drm/amd/display: New path for enabling DPG
Date: Fri, 26 Mar 2021 18:05:29 -0400
Message-ID: <20210326220534.918023-17-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83f0044a-9f94-48b6-9ba0-08d8f0a36083
X-MS-TrafficTypeDiagnostic: MN2PR12MB3071:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3071DEC6C6C4BC93A84E5A22EB619@MN2PR12MB3071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:198;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FSswaYdMlgsKWQzmhWhhW3n/OmnIg3bY76kP2loZFxoz9wXET8J9/53yygPa/c4f7wwgDkywATFeJQD0A6y1jNiZT4aBreoy9g/e7OHHyGOMdGQho2ByqigKg5R4Cu26PWYHtBo8rvEME2FW4RAh90Pl7uPIq9NoFfC/oZKrEFz++M8oOsDNQtlU8cIbYUVgCd8dfssM1G9FBdPWPDUWejxP7dwHlcQw3+nGRQpu1WTlRG1dkUaQQIo/+pKUESaPA+WPtQ1kMAXFTHgpY89iIgGROkzdtbcmLxC7d3A39RN2d7HvgQxZYpX42XuL3Sf3iQUt/mFyUPFmEIS8yU+CqHHaqy7ito2NkBRib6pDSO0z6RA/MryeXGOniMGRVXAOpOX6RR/35b+TdZNcqE76oHzyctx0Dy4+0mNkL4L7eDzwJOLZ+5HWNkl8+Fk6kZs+cBbraTfyibbmHU8tOCdMRdzU6nbdcqhy/hKcaOTR3SPkyeEeeBndGol3eiZPnw/hKdVLCVsccxrW7heafBzvm6kJnPybM8xQZTiez4rVO8Xz0sjLY01KKFjgZ43TjNw3UeTXLzFj8ksDzTPvKDi04nF1GT3TEL03A9e2DGLhEe0MiJMUbznn9Sbq5RdiGLmjpaxXJlt66IEEI1OaSj9RMymQXU3XfdaKgqax27iYSLtFtUFZxQ0J0NVGha4Lr4N
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(36840700001)(47076005)(316002)(5660300002)(86362001)(36756003)(2906002)(336012)(1076003)(2616005)(8676002)(426003)(186003)(36860700001)(70586007)(82310400003)(82740400003)(83380400001)(26005)(70206006)(4326008)(7696005)(478600001)(81166007)(356005)(54906003)(8936002)(6666004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:16.2048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f0044a-9f94-48b6-9ba0-08d8f0a36083
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3071
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
We want to make enabling test pattern a part of the
stream update code path. This change is the first step
towards that goal.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c   | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 12cb95c5a1f9..7a0f5057f0ff 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2394,6 +2394,8 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->dither_option)
 		stream->dither_option = *update->dither_option;
 
+	if (update->pending_test_pattern)
+		stream->test_pattern = *update->pending_test_pattern;
 	/* update current stream with writeback info */
 	if (update->wb_update) {
 		int i;
@@ -2489,6 +2491,15 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				}
 			}
 
+			if (stream_update->pending_test_pattern) {
+				dc_link_dp_set_test_pattern(stream->link,
+					stream->test_pattern.type,
+					stream->test_pattern.color_space,
+					stream->test_pattern.p_link_settings,
+					stream->test_pattern.p_custom_pattern,
+					stream->test_pattern.cust_pattern_size);
+			}
+
 			/* Full fe update*/
 			if (update_type == UPDATE_TYPE_FAST)
 				continue;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 2bc057e0b447..b0297f07f9de 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -130,6 +130,14 @@ union stream_update_flags {
 	uint32_t raw;
 };
 
+struct test_pattern {
+	enum dp_test_pattern type;
+	enum dp_test_pattern_color_space color_space;
+	struct link_training_settings const *p_link_settings;
+	unsigned char const *p_custom_pattern;
+	unsigned int cust_pattern_size;
+};
+
 struct dc_stream_state {
 	// sink is deprecated, new code should not reference
 	// this pointer
@@ -231,6 +239,8 @@ struct dc_stream_state {
 
 	uint32_t stream_id;
 	bool is_dsc_enabled;
+
+	struct test_pattern test_pattern;
 	union stream_update_flags update_flags;
 
 	bool has_non_synchronizable_pclk;
@@ -268,6 +278,8 @@ struct dc_stream_update {
 	struct dc_dsc_config *dsc_config;
 	struct dc_transfer_func *func_shaper;
 	struct dc_3dlut *lut3d_func;
+
+	struct test_pattern *pending_test_pattern;
 };
 
 bool dc_is_stream_unchanged(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
