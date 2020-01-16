Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2E5C33CB6
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9861206D9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q7YTkWuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9861206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7BA6E47E;
	Thu, 16 Jan 2020 20:14:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0546E47E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9mxrDxu+9Npk+jxNjZeebfR4oBt+ToyOx2tfGxBeg6cW7RJgdI0xcN2LQwS2qrPTq18IHSG2VEu03GDH+iFaNwAbc0dbnb3wUnVsNy52KYsSqLjdpSXy5N8qWwERHDOXRzpwBg3lurV1QDZYw61W/C3+QlXMjpEhg8hHYwPZgk52mt9xeKAdHqIhd9DZWyWsLCEbVO2Fid2TmJVQFMevc2HrguQG0xFIKkD5ntn9fvp/4PnqAb+Ij4iIu/gC6voHNrdz9M9LB1xXTX92+KG+wtY74xeZFs9rd6XREbJQc5AOwNTgkyTHtH8/JYy9zCbRTj23rGcy4GxSR0Nwf/zGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afeZhL2/J2tHx4TtT6uV2BPSrvQ5NKgWvq0w9r87Nnk=;
 b=Lq+xbGhbM2UvpBVWKd+ZAtIHXyvnR5hmc3EGKzcEx80pgkYVLJ8YU/Ki75FXPzeu0T+RyfmQ8ZmNKqnVoHMwx+i3GbxogcEbRcupHqxomIHJojj24BqsYWxKsNKsN0TRItRaM0pRU+TMRs2sEE3kqV0YBqiKni7dVfsdINdC389vY1N7fZ6rhkJeAaDZGkyPpq3bahlb+9XeAyJLkWp02LsGQqHeAv0ZzdQrGw20cAIWBJkp29Cxkl8Nn2lvuIDm/cxR03fRtv6LgwBXJ9/lPqJA1SFsRyrvxsEcuaj2U4qcvNW4p7E8Id4DTflGFOxxoF5Hu9lsGJO6B/w05KlI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afeZhL2/J2tHx4TtT6uV2BPSrvQ5NKgWvq0w9r87Nnk=;
 b=q7YTkWuBlVt3LTETK2xMwGK/agJPDAQmcS+67Lx2SVGjDSatxoPIvTU2bpwwhRJkZk8TtTbMNzhV6BlP/c4cWPn7WH1ENRuTk3GV9dDL929s90jSCoX1PiYgcSlJ/txPqEe5m5SWoeoT1pGdVM9t8YF5xePoTiMkkjHZ5RInQwM=
Received: from DM5PR12CA0010.namprd12.prod.outlook.com (2603:10b6:4:1::20) by
 BL0PR12MB2481.namprd12.prod.outlook.com (2603:10b6:207:40::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Thu, 16 Jan 2020 20:14:38 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM5PR12CA0010.outlook.office365.com
 (2603:10b6:4:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:37 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:37 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:31 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:31 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/22] drm/amd/display: support VSC SDP update on video test
 pattern request
Date: Thu, 16 Jan 2020 15:14:15 -0500
Message-ID: <20200116201418.2254-20-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(428003)(199004)(189003)(7696005)(336012)(6916009)(86362001)(5660300002)(26005)(70206006)(186003)(4326008)(316002)(54906003)(8936002)(1076003)(81156014)(478600001)(2616005)(70586007)(36756003)(81166006)(6666004)(426003)(356004)(8676002)(2906002)(15650500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2481; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb63e2ec-8dd1-4ad3-386a-08d79ac0b646
X-MS-TrafficTypeDiagnostic: BL0PR12MB2481:
X-Microsoft-Antispam-PRVS: <BL0PR12MB24818B60EA0579A88DB029E3F9360@BL0PR12MB2481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pIvUfAP23Za0UwJjqfx3ZotcF0bGf8K8VQqReI5dPKHMz+ZprFglm9aVDa56+mSXMWqRktab6oBsocLBTSQ3zxS/4/53MGiIv9jSGETl9wr9DYSI6wCaTYoXXkVZhXkgRgTCE2btHt41sWjWWuiSZPNaQXPvoE2ffG6x3dG08Sxpcpfuw90KPwykOABB9tmDYLTg701WvM+/B4q5iWYguoykGShxznBt1+P64jCJzQt4/WlBTt+9U/L2oAzWqcbS0ToEvbqEaYIHZdF4PwbyVq8At654Xul/IM6oeECtNV5y+StZgH6Ejs/8WuSmTNyONLTOAhKaOuuNlfCoI37polzrQU4K8w+Oyy5zTyhxIS5IpCKiwaNGAu6QGav8kW5nTLLhwFzA0N9feJMkET6JDncXEMhuMIsikTM+qNAkx2T7yHhgekOijzQPOrMLjD1a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:37.7637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb63e2ec-8dd1-4ad3-386a-08d79ac0b646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2481
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[why]
MSA will be deprecated in the future.
Need to support VSC during DP test automation.

[how]
Do not disable VSC during DP test automation.
TODO - need to add VSC update on DM side on test request.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 3bb1b481451b..a53e8fed56f3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3926,7 +3926,6 @@ bool dc_link_dp_set_test_pattern(
 		}
 	} else {
 		enum dc_color_space color_space = COLOR_SPACE_UNKNOWN;
-		struct encoder_info_frame info_frame = pipe_ctx->stream_res.encoder_info_frame;
 
 		switch (test_pattern_color_space) {
 		case DP_TEST_PATTERN_COLOR_SPACE_RGB:
@@ -3951,13 +3950,9 @@ bool dc_link_dp_set_test_pattern(
 		/* update MSA to requested color space */
 		pipe_ctx->stream_res.stream_enc->funcs->dp_set_stream_attribute(pipe_ctx->stream_res.stream_enc,
 				&pipe_ctx->stream->timing,
-				color_space, false, link->dpcd_caps.dprx_feature.bits.SST_SPLIT_SDP_CAP);
-
-		/* disable vsc so no need to update it based on request */
-		info_frame.vsc.valid = false;
-		pipe_ctx->stream_res.stream_enc->funcs->update_dp_info_packets(
-				pipe_ctx->stream_res.stream_enc,
-				&info_frame);
+				color_space,
+				pipe_ctx->stream->use_vsc_sdp_for_colorimetry,
+				link->dpcd_caps.dprx_feature.bits.SST_SPLIT_SDP_CAP);
 
 		/* CRTC Patterns */
 		set_crtc_test_pattern(link, pipe_ctx, test_pattern, test_pattern_color_space);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
