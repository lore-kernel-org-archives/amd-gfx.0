Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9B7C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 17:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3DA410E2C1;
	Fri,  5 Aug 2022 17:58:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4842B3E43
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:58:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2pLbwRjT95GIqtE1183UQ2BhcYDYE9bgcG27fENEvA6HdI5Zi3lQJ2k2dDsHfN/zWto2LuK8FrzME2lQS7PmU4H5aZrNYPdaMrj50eCchd104PL/QRN4t9xzMx/tEpRqtvtNOKawYPaAuzbmJ54FsnBpu8PmiN9WV9qDE0PFj1uWPtyN/c2q/PDegruNoUUKto41k2N+SpUwvF7jF0fermknCoKMwJtrVN6j3VCJY/dyC1D40zgvfI9EhKnpQbmHjbg201Mvm1DgUvSu49M2AEGMDA3rqXXzGwU+UANhnCwyBO7B/BrqtEZz2eoRESljhaoHdBdgEdSZBJukoVxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1bR+c1O8Mv6eHMECXUb9I4pmyS2c09RpJkkgVjhafA=;
 b=iVIRMv0mSnB808mpLn54vgM5QxeJvhIIcdVBBGSP2b6e+7IvjlTy3Z/rioDW3DXpKZVrhP6DutMttL1aH9mKtTGyF2dD0r8/WxWgpM7QMdSoDRz0P7ECTBvvTL5hpJHPd+oRcqID7JAhEyMk6uYHpq+zV843eYm5ABBrFwIOifI8d2TOEX9tcQwn0g8Ol0Tww4kIbFM5TnuFXr/hBwvSAPXweexHtwhC+arFAVmT+wuqE4T4ek7oB0zZr3OY19rkv3xJ++JPyazCHTx7YBoUiD/cftlR0XoeLGUENEo63wr9bngQoeWvhToTYflNT2COeAGnBC6k9S8gm9qsNXJ1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1bR+c1O8Mv6eHMECXUb9I4pmyS2c09RpJkkgVjhafA=;
 b=cmB1Uqsapvh23gqkTunc5NYGRotbj+EuqrLunHslXb2w+Ri6z0gIcWazWb4sUvbcgJ07tU6k9vlBp0JzUo3B+E6uvCIX3zbEwwpVZp3OK0Wp9XuN+RuiYMT02SIlJU5sG93GHDyL2Cl5JwG2w8FApLuFpwCkiAxqO2dO+lAjOIk=
Received: from BN8PR15CA0063.namprd15.prod.outlook.com (2603:10b6:408:80::40)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 5 Aug
 2022 17:58:43 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::a3) by BN8PR15CA0063.outlook.office365.com
 (2603:10b6:408:80::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24 via Frontend
 Transport; Fri, 5 Aug 2022 17:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 17:58:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:58:43 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:58:37 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/32] drm/amd/display: Use pixels per container logic for
 DCN314 DCCG dividers
Date: Sat, 6 Aug 2022 01:57:55 +0800
Message-ID: <20220805175826.2992171-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b90f1de-f447-4a66-8c6e-08da770c2305
X-MS-TrafficTypeDiagnostic: DM6PR12MB4217:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDU2xAoqZSi3T/M2ShTpD2E0vZfXEVEuk3QzvS71CVcux7InkonTGI8JQ3HSgP1dgzzFhA0ReyykDHIfRjzYs8ZhgrARNp/KdFDs4ssnEIf6N4yw8L7ZbNF77PjW9hfgX0EduRW9FCkkIZCvdzuzGziqwN7s6dccy4JCyGX22IusidkIOa/c1P7vRvEpHwp4u1k6i19lRRLHUMVWKafUL+hgwthDjuFmlvCZXC+RdLhltDN2dZNRCzx61hnmm5kqGh2vCgj6RIf0avqFgCYkC+Ak5CNXdFrF6tuix4CAOdlPA5BSNpWFkitB1lcLiIdPxZhJw/d47QD5DRuvV2eegwx/Z1HlyzAGEO5lFt1euIWBD99+fmqoibB3A0WW2g8Paq1qRc+U3QySPqLc9jXcmo0KqVHo9N0cnbL+L+QfFca1UdaZ1V50e6CU1GVQAAfqPB+chm3A8CAFF9q+8G46d/+jZJnF1OnELWiRZ3fURB7r+5U8er0UKd3uX2M3rmbRITIczCqH1jGP6O/PRotxvmf85KQLEIv6UEqBILUR++9nw2wl+J3FjeB0ViS6nNWC1sYQvCJ6RMFafCm8F2GUR3aSAJUeaA3BXDpgtrk2NNDgK7rUsl8wiVfGF+diBN4bn3MjBJhnhvVdJnM/Ub7DVaypPk+wRzl+s0JVAj/uxJjektlOAeelZieMoAMHNPjJMGksLaK0QdRn5npjGaa3r6RtWM4KmCkRLLxtLCjH+uQkA8vY7nunG1Nx07txG2sEV22FLW10LmfcEzGBRaU0CWuSR+T6v3lzxTSl0slwzKdERLVpJBIH+BUb0aJoxm/d9QET7okcjiXYltlnrq5+mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(40470700004)(4326008)(83380400001)(70586007)(36756003)(478600001)(70206006)(5660300002)(316002)(40460700003)(8676002)(8936002)(54906003)(6916009)(36860700001)(2906002)(7696005)(2616005)(6666004)(86362001)(26005)(41300700001)(47076005)(426003)(81166007)(82740400003)(356005)(336012)(186003)(40480700001)(1076003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:58:43.6600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b90f1de-f447-4a66-8c6e-08da770c2305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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

