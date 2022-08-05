Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F63CC00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 16:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B2EB8773;
	Fri,  5 Aug 2022 16:46:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF033B86E1
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 16:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVkO1ObE7VamID/Ze3cqEzkqaEKLOXxUncT56s5OgB7dIWAvP4wXHgBzrL475zSL62SGKRDeeoDXBqW4DVjewmDhT8qKuIjB6VmQXC/WhidUNLokaREx1eYqqCXKk546kKDNBllKG5nY54HK+X2bxrUIHq3K1BV/Oym0DAA9VHh668J6N5oeZWXnw0UkNnQafGeNW31NSJX1b7PZ9J8xXQIo9/cRg40w/DOdZOmdJCHJNup1NVowEMhx2q+mfuWRbHCLrxwBmiwZ64UUgD9Fb1WqrsdFrGm8DJFJr9YmrGBXt6NNkWjsrmpF5YZPaSrUBgYyEcJbl+Fv93zcY6pmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1bR+c1O8Mv6eHMECXUb9I4pmyS2c09RpJkkgVjhafA=;
 b=nFN5bUm49AigEPnwS8/08gSTLFQEUs6qf3PSejkCwDrjIJPWffFStjrd9BCV9VatRx88atrs5fQ/aZ73fOKWcG8mbS2cdzT7Xy1Q1A56tC0dYbpa8Ctcw3gvtx+wCOpLJzZhQTWknShcXVOwuV+qmCJn/Upa0brpBhdJpJsYqW8dVo5O7XtGxxGugbuxSluZWK0Uosld8WZZEJnL9WYgjUlB+S6hqTg3azpd6DN3a2FK0gJhCJx1SdfcC+gIKGgpnhcOM2JOFwWQnuMSHQPnGbfB+J8s1I9ahk9yn9Oae4ujZBcrKMGT3F6Wq9wLGc9LSmUwA/y4J6ZSNh+1Cr0JwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1bR+c1O8Mv6eHMECXUb9I4pmyS2c09RpJkkgVjhafA=;
 b=jJzQ05YQCtyjmpa+p2itv31p6aSIv1m7Ju13xwkud3W7zrzezmc92D4IqvsWdJa0OdDvkBTss6F1cXQbgwuHtAlNHI1aoCA2k/noiX4GmE/1bS5WsjC+XpV5FJ7zSAMG2BoBARzh+wxQuA498CmuvbmpETtDB+RSXZYBjNAJAFM=
Received: from MWH0EPF00056D04.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:c) by CY5PR12MB6156.namprd12.prod.outlook.com
 (2603:10b6:930:24::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 16:46:13 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::208) by MWH0EPF00056D04.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1 via Frontend
 Transport; Fri, 5 Aug 2022 16:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 16:46:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 11:46:12 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 11:46:06 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/32] drm/amd/display: Use pixels per container logic for
 DCN314 DCCG dividers
Date: Sat, 6 Aug 2022 00:42:58 +0800
Message-ID: <20220805164329.2988533-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805164329.2988533-1-chiahsuan.chung@amd.com>
References: <20220805164329.2988533-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d32a446a-1b92-4eaa-c4eb-08da7702020a
X-MS-TrafficTypeDiagnostic: CY5PR12MB6156:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFcXG15MLeyiFKXWUcPqWJbUQcXBmB7HJgBiAlCkWjyVc7BwaYpkNWmc9CR74aTSC+ySXUcwT9py/YNsNeNgncANPL7Y17Ipw0b7dh15beetWLcFzAXW5pWw6GSy11Edlyj7rwbOySPaGw8IZvbeEpYvc7SdlNk0W7+0dEIcz4jJXtdYM5BoClxiShcKlo/UqV69zWAXu/xtjH57h5/Z5CTL2TjW9IwO8Pw+ZPTyQ54s1OnK3I2B/ZqEK+33N4i6rCpGaGIISzWycH05xADnHFkLbG1f5sBe6C0dVoNudkXzWUzz7iRFz6uVCogC9w7V0AKOXsHdFZN++O09vNqL4PqgtfinSTyctzMbrsDcB72U0FYfstypOm+6+lec2Y24QoHOAmtmNBQE/MWN9+BEEDnASOBEfvjL1C83nHNXy5c8PB//dKnqeTSCfEf3sIuX/irQq85eO5xeQhL6X8zuz6NOtjq8G3CagaRlzyok0HBPcP8KyDBPdJORu0HZ5bjDwYvMKMfVcV7db6F7wEtWIehiePMp8GGaa2LkDr+Gq2eljMfPczu0/HnB8PQ7dh6x/b3wFuAyUdA5v+K66UQpUxo8fHuZCLCmS/2zpKeptu/o7bd5LIbPeElCQu9LDwWJZg12U48LKmhA1jJW332QvMwCs/+jJGWkzazu/yFrQfwj8/Z77hd0WD8aMUMjii6o+Vd8UNISci0DpphJ+SkX+XUiXu60WKmN2mwfqHrfBE4+kfDsuBYc6VeMBc6jsdc+oTjcfTaNbi00Tiik7rfuzt2LuP2wCDgNMJHGKVpoeSb20Xs7UnvdOvdLwSpOi9oHtCW5WNcRjwfWhAj1Z1NFKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966006)(36840700001)(40470700004)(2616005)(82310400005)(8936002)(1076003)(36860700001)(2906002)(41300700001)(186003)(83380400001)(36756003)(26005)(5660300002)(40480700001)(82740400003)(356005)(47076005)(81166007)(6666004)(6916009)(478600001)(7696005)(336012)(426003)(70206006)(4326008)(70586007)(316002)(8676002)(40460700003)(54906003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 16:46:13.2371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32a446a-1b92-4eaa-c4eb-08da7702020a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156
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
Cc: stylon.wang@amd.com, Daniel Miess <Daniel.Miess@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <Daniel.Miess@amd.com>

[Why]
DP DSC YCbCr422 not working because dcn314_calculate_dccg_k1_k2_values
does not account for two pixels per container

[How]
Replace the contents of dcn314_calculate_dccg_k1_k2_values with the
code from the function dcn32_calculate_dccg_k1_k2_values

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Daniel Miess <Daniel.Miess@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c   | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 755c715ad8dc..452f4a9bf251 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -343,7 +343,10 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	unsigned int odm_combine_factor = 0;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	bool two_pix_per_container = false;
 
+	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
 	if (is_dp_128b_132b_signal(pipe_ctx)) {
@@ -355,16 +358,13 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 		else
 			*k2_div = PIXEL_RATE_DIV_BY_4;
 	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
-		if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+		if (two_pix_per_container) {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_2;
-		} else if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422) {
-			*k1_div = PIXEL_RATE_DIV_BY_2;
-			*k2_div = PIXEL_RATE_DIV_BY_2;
 		} else {
-			if (odm_combine_factor == 1)
-				*k2_div = PIXEL_RATE_DIV_BY_4;
-			else if (odm_combine_factor == 2)
+			*k1_div = PIXEL_RATE_DIV_BY_1;
+			*k2_div = PIXEL_RATE_DIV_BY_4;
+			if ((odm_combine_factor == 2) || dc->debug.enable_dp_dig_pixel_rate_div_policy)
 				*k2_div = PIXEL_RATE_DIV_BY_2;
 		}
 	}
-- 
2.25.1

