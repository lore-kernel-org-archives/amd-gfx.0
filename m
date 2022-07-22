Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F41BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E35490F8F;
	Fri, 22 Jul 2022 20:43:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E114C90F04
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMKHrZnKfj+5/M8QnNrpFoBMIneuV5cW1u88ZKk9IF9UugvxKdzq3/sb4su7m5DOJHnQsK8z+nPGy8w3BVIkdKWiWAJr6ZmrzAAo6Goy1tq3QHFD+LT0M6BQ3w0CQY+mRgD0EJdyYJeNltjtg8dRpAHIDt3cViUUmalcRCzezJ23OsE/evG+H/C/WaNfi0TC4tw8C+QQDiBlR51Lrigt3Vu4OsN5vU9T5EFOIP6r/YHNc5jgeRNENxS8sla+cP8MUe92rjkacXAOKzk2iaFFs5J6OJRadtSntk7zjAzde1K25K/XqLLyGa3TxDfABLHDnkRbzcthOZnctyq8AOZHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctdqJoWsQSDhtYSH1xGaL99PvQ+I/veeVe4qb9e8a5M=;
 b=Gs1ir17/lBlmpXgnZHrYxRE+JFdf6PKVRrI6tWzyo/BE1cGD/CU34ZB4ZCBiQ23AYv4Tkwg9KBPFBZSEnZ6cOyzDbFh0KZY6MpVY8aFUmNA9bgKdwuiC/zQmDLTv84/J/BUoyDwWbT7emYVYl9hBuVBlC8oP/v4sW/7deWVl7UtRXfvDzK9pW9UyiApIF0V4neiTXRpUhxLyR8lp9xMSxe5YQ1HLCM1QMhxlaTIhYCKWsDUj7WJyYfsmIHQoOb9F+DEiX8ua1MLbnykNta9uhdYxwHGjNerKQ4txXDuF9wKdxl3usISW2mkxVr4i9oL0vnOkSlDnK6hOK4CzWJ3ITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctdqJoWsQSDhtYSH1xGaL99PvQ+I/veeVe4qb9e8a5M=;
 b=BR+sPIwbzVMATRP1ZLrr4fO7VtfD5T5pzMVVbINxP3E5bvRPoqSj2cAB1q8D0z8he8jQiIT/T7T5zkbZPGb0nbCcI3BiZyXT+9aSqFKJgqOqWSBVOO1u6U3eiXFUdINc0I/r/KC4BG6nEb5222IVYCWNTXCZjtX7p2/vFxVO4WU=
Received: from DM6PR07CA0102.namprd07.prod.outlook.com (2603:10b6:5:337::35)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:43:30 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::28) by DM6PR07CA0102.outlook.office365.com
 (2603:10b6:5:337::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21 via Frontend
 Transport; Fri, 22 Jul 2022 20:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:43:30 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:43:27 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/31] drm/amd/display: Add missing ODM 2:1 policy logic
Date: Fri, 22 Jul 2022 14:31:33 -0600
Message-ID: <20220722203137.4043516-28-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a93ef24-a716-4f72-69e4-08da6c22d632
X-MS-TrafficTypeDiagnostic: BN9PR12MB5273:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLb9LSH/5gVS5UN33FyunsPoTDmstZwB3SJuzkizn+9XElBOXsFljvpARHKFvfvoGCkf1j5JNi/snksPm7hHzCXcmTKImc3xC19bHD95lu8cCkKV0PYbFiysZAGvl61nVBm1M4vtsWgJ0EPRDOA98h3Xy+JrjOOcnjSyZC7MDlM2n9c78MQx2v7vPl07yOgF9RQzCHuHnAVDChULlVfTeDevhz44KTRt0QubS7ezY5XtAtHZjbT1gjcVIXZ6aDUv6CRSL1wheHfwuTT185VSmeeWrzlynTCV9fCKxJdLvvY9COqUGTR3Wi/+Ow12VyKlUuHNmehQLDJFexDGnVv1MI8V2hEbf5KXIoSQVENcXG82jMLSR+m/QF1qxVewU86BbmoAvolcgPtC0JiS/X9PT96w1jg+ZVeGYf9ous2HdNeoWscdo6Y3lUkHRfD20gKUuJWMBeFRjf0SayGeOKl07/tVYdt8JeRTyhy/3EeogPAEEV4EXUBE40o4ggQBbe8c2A1xJdCe9gf+rHPajEopt3XP8hyc78W77dMLzHBOKc5RpCRgRqXUcPuRU9ly9fMv0QfBQm1jRr+CygGh6bnoy+kAHyk7E+NKdnNBjJ5Eq9vo29UZI3SCNmPJxKiK6fTms66vXp7ff7j+dhPKpI3lfg5RRaIi7IiwiBW+zhdAGYAq4KjkiufZCd8JU6CUJFaynKECDOIavq7T8Xyijz0iXO0d1DBNzprzk/pt8xt6Rfx1noQHzaZDkrHGBadttXaaf6pikSzuqNbi1ah0X+f46yis7YMjnfIWg3fMNx17obDJLr522oazx29mTME+HLlQ70fMQ68Qa6JD0CFr2l+x/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(40470700004)(46966006)(36840700001)(478600001)(5660300002)(86362001)(40480700001)(2616005)(8936002)(336012)(47076005)(426003)(6666004)(41300700001)(2906002)(1076003)(26005)(44832011)(16526019)(36756003)(7696005)(186003)(40460700003)(83380400001)(82740400003)(82310400005)(70586007)(356005)(70206006)(36860700001)(4326008)(54906003)(8676002)(81166007)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:43:30.3568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a93ef24-a716-4f72-69e4-08da6c22d632
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 daniel.wheeler@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

Phantom pipes must use the same configuration used in main pipes. This
commit add this check.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 1 -
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 621767e994bd..8224b9bf01d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1269,7 +1269,6 @@ static void get_pixel_clock_parameters(
 		pixel_clk_params->requested_pix_clk_100hz /= 4;
 	else if (optc2_is_two_pixels_per_containter(&stream->timing) || opp_cnt == 2)
 		pixel_clk_params->requested_pix_clk_100hz /= 2;
-
 	else if (hws->funcs.is_dp_dig_pixel_rate_div_policy) {
 		if (hws->funcs.is_dp_dig_pixel_rate_div_policy(pipe_ctx))
 			pixel_clk_params->requested_pix_clk_100hz /= 2;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 1f845e9ac406..be2e3b9e971e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1084,8 +1084,13 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	unsigned int odm_combine_factor = 0;
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
-	bool two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
+	bool two_pix_per_container = false;
 
+	// For phantom pipes, use the same programming as the main pipes
+	if (pipe_ctx->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+		stream = pipe_ctx->stream->mall_stream_config.paired_stream;
+	}
+	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
 	if (is_dp_128b_132b_signal(pipe_ctx)) {
-- 
2.37.1

