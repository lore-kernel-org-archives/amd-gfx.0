Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDC8C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B7B61373
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 44B7B61373
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54606EA02;
	Mon,  4 Oct 2021 14:43:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E4A6EA02
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OieDQkxV+ecnO7O8E2IEPt+WVc3a+f5URZjNhwGoJKTCYcbW1aJAxfB0g9UWyviAMD+e38G1qNjaZDDL6N2wBwOKGn9CFVWqHLmx5pC7lqkVQO3Gk4UM8Qi5xWyvcq8RlEMejLoVIBX8SOwsS6PzKbcsIlX41Pdvs5izKqm3+r/v9ls4nnyXyKZjfwTymGgvahEYTlnTxCErQ+0gDtvAlPDEtkVwXSWEL85hf5//TLU9fj00cZx2mS94mFVN+i4ZSwIAinapaAIQCwWy8jwutEOvEcTI0zPg2JlP7h8vwuzawTlLFcsnQrxYYYCrOTQw+HqYWwvRIZptsVuDLnNJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkoA7tpwCR/c6RZtZi1tQ5LtvoyTCKmkl9E01MzKp40=;
 b=gmB/lLmU7ZRYV/0B2EQNrmc3jjkeOFcKyXU5jAKOvoYl91aD/YhH1wZaXxQkNh4HO37YI/Gd8G+5LrxB6AFoCxbCKXkghQK4lHSgqWXLkidE3Hk7N35Xxf2f8OtBv7Z46VyvZQoe3Gln7DEvIdz5qY9uo/KJ0V9rxnwKE9a04aTB3dcxZ2s9s6KVxXmaGwooYJW9t+quq3QRY6lR3Uy2LPxFu+26CptdmxtqjqgKrI+8xNFCr2/ipRk5AzEm6R7khoOhsJk+yT5g91aUg1gVslqa9rUiV0mBiz7vTzDgTrrR2wJtD4ScG+xoLXxOLKscfFCNbbjXgAwBI4uA8SQ7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkoA7tpwCR/c6RZtZi1tQ5LtvoyTCKmkl9E01MzKp40=;
 b=3KH0evwRzFelNafcfIkqAng5c7ASpGTl1zYrA4U9TFmu5bBP7HeuIh1OL0+oCbPnfYiesEdJ3rXAIFtwN/3uTMlUAmO85xRHakUq3SNaWbARV4WgA78ZH/ZUQNs1mi65v2uG5fF1yqPeny+UMpuCw1xXiQ6WYJM15HN6y+AQVr8=
Received: from MWHPR02CA0022.namprd02.prod.outlook.com (2603:10b6:300:4b::32)
 by DM6PR12MB3292.namprd12.prod.outlook.com (2603:10b6:5:18c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Mon, 4 Oct
 2021 14:42:59 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::c4) by MWHPR02CA0022.outlook.office365.com
 (2603:10b6:300:4b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Mon, 4 Oct 2021 14:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:42:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:42:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 07:42:57 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:42:44 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 08/23] drm/amd/display: Support USB4 when DP link training
Date: Mon, 4 Oct 2021 22:40:35 +0800
Message-ID: <20211004144050.3425351-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7fb730f-c66a-46e5-9834-08d9874542bb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3292:
X-Microsoft-Antispam-PRVS: <DM6PR12MB329265733301851064D42B9CFCAE9@DM6PR12MB3292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lvL6FbDSNWRwTW+0CHlcfM448HuA49mk9paa8+dz/WYCgwTXySTbt7gtLNgB3J3wICjZpqC9rRrVdZppx57oODYwS/YYjnN0tWgfWvfgreLnLcDe1szljjDK18D76xMxT1Ow89Wlvd4/8lT5qG0c2IDE2M4v8IRZ4p8xYu8kcJ81th+P3M6Hqw6pngxhtelTqKTmk/xraEmpPPYF6kP5kXGiRMQLl0Q0k7bDU0LchYk7gI+BNQ8WtODIo9hP3Omz/WYeL8uYp8+XMoKns8q7R4PGD4ZpPgVoVSF2sxNm2kPUB8JWfvqTiB5HJy5h+zN+UtVPj6YXmlduBRYq2GejLahvI9naixB5ZGqfjncHDi5pHjFwbwoAZ8rVKTRtcIe/sSvbQrIMENzCTKQFA8X9YaB56eUY+tchvI8DWXveg+lg2B+pOkSpYrQ7/A2Fr0j1vw0VU7h/5Vs5TukHcjbn0HsgD0NXLNS1rULjoiV2pgQBdAZnbAhN3bosPyNgEQwAi3Tpw0X73pPsTd3+9lvc1xwlHgqlc1xWnf7yBUIa5/QAEjiM/GMrrxVzTY4mWeBGYVf5soGfDy+YIJTiLRWlcofV7iwX+VzKnmUPOLwWSWS4zyx5hdv6YmIPaU3z/fhPgLTm/FD3ZlS3a+TzV5nLoJKZrBa9lgaDq69IsMn6gVE/b/0RUODC82glxM29F27anzhZZT8FUlz2JddX6+8ApNc9qMOs14OYUswVHIjWp4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(47076005)(2616005)(83380400001)(1076003)(8676002)(316002)(26005)(356005)(4326008)(5660300002)(86362001)(82310400003)(36860700001)(81166007)(7696005)(336012)(2906002)(6666004)(70206006)(36756003)(70586007)(426003)(6916009)(8936002)(508600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:42:59.0170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fb730f-c66a-46e5-9834-08d9874542bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3292
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why & How]
Add codes for commit "822536713066 drm/amd/display: Add fallback
and abort paths for DP link training" to support USB4 DP tunneling
feature

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c    | 6 ++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 1c397d5551ba..6b5ddf0a29c1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1862,6 +1862,12 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	/* get link settings for video mode timing */
 	decide_link_settings(stream, &link_settings);
 
+	/* Train with fallback when enabling DPIA link. Conventional links are
+	 * trained with fallback during sink detection.
+	 */
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+		do_fallback = true;
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (dp_get_link_encoding_format(&link_settings) == DP_128b_132b_ENCODING &&
 			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index dd1d0262ba40..d7dddc0998db 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2408,9 +2408,9 @@ bool perform_link_training_with_retries(
 			dc_link_dp_perform_link_training_skip_aux(link, &current_setting);
 			return true;
 		} else {
-			if (link->is_dig_mapping_flexible)
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
 				status = dc_link_dpia_perform_link_training(link,
-									    link_setting,
+									    &current_setting,
 									    skip_video_pattern);
 			else
 				status = dc_link_dp_perform_link_training(link,
-- 
2.25.1

