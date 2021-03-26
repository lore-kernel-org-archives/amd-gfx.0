Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681F8C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A6F619FF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A6F619FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAAC56F4C1;
	Fri, 26 Mar 2021 22:06:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70FD96F4C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvKXHFM2KcCy1R5xwoPqiCQRoJRR63mNnFd8/Sz/9FOp8Av6jQTq0XOfIE5zAgb0UGDF95TRGadqZBqw93Kn8+YS9Vwl20TTBteLIAg1YCx8ZW8law6oeQSHCocGhQAxjXru8Zy5mQKuq+UTroBBELxK4kOwkCou4E9UAeNvwt4/vw1HEW41z/MrOcPV72hvkUfcTjY2G1RoMS9pNQhSlTS4TlVyJVAbcE6KbGc4VofpsF5GwvqKLEwSX6YTFfPneb9g2wDXX5EOqeUfM5P1H5lNc2UrzVTpywcVN3pQL66MHEH+kMreB0rZuZH8FLorCFSW/zSNfdduken60TFywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/n+XXXakbzrbqFUsUqTP293qQLTqTg0Qx4Vpjo8Au4=;
 b=Wyz6lcZfac9iEre9PjeovhcqDAhgkEG+XSQO58F7hCX62ZuiQGfAY+0Zcy11p3u1SYOniHM+HEijW12sxAHlSwL7EeoaSG1BVcYBh9BH7W+JE1Ssfnw8+yKhty1jcviBagHxmA4iZ4DfSmLgpbbU7VzJGRdVC3CCs41q0g3JqIz3TE5MUFB5aepsvG9GxUKLhj67d+f9Bdt8SlMFR1Zdo/5iwCmi1F3m9nHfshBlqoIHCLbcS3d9/aF6HnH2Dhx/cUPCY/aj5FmiIG1J0YBTz6IOka0LWElJpXOEji3/NSVhMF3+8vRePeDnxhn8iQA9xw1hBwqurv1+hHsDctL/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/n+XXXakbzrbqFUsUqTP293qQLTqTg0Qx4Vpjo8Au4=;
 b=FzvsXbEiNyqgsViObwWdnb4hPVOmoQOl2peT5ucZprNedNLnlA/SRCTehLPd8F7awJBdzJNS+LlfRkBeOu02KDJh2PHkpZ+5NWPjglFrvP+YZDjUKV2ldjCB9cKT8S+vT3T99JzP4akYVII8/tKmLHh/fU9rN9o45LXe3pijnek=
Received: from BN9PR03CA0401.namprd03.prod.outlook.com (2603:10b6:408:111::16)
 by MWHPR12MB1311.namprd12.prod.outlook.com (2603:10b6:300:13::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Fri, 26 Mar
 2021 22:06:24 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::c9) by BN9PR03CA0401.outlook.office365.com
 (2603:10b6:408:111::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:23 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:06:17 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/21] drm/amd/display: add log for automated test
Date: Fri, 26 Mar 2021 18:05:31 -0400
Message-ID: <20210326220534.918023-19-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33c01c48-8901-4b5a-2b2c-08d8f0a3650f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1311:
X-Microsoft-Antispam-PRVS: <MWHPR12MB13116C29B0737DFBA50A087EEB619@MWHPR12MB1311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywNcwf/3KY0yFVLXdtKe7X+icHej9koq8fcJIE1k8mTISNldND5mWhC4l/w10PTr3583XdfwEvwSb3PneihX6bEATNNF52Al4WU6dgtEycsNu6wG8RYvkiFYun3xwjy4a9AQ2vLWwkwoNIma5VEfOAheXpSZBahJsSGEyciE7ytF21M6f7vCcWXJn6pTFyjDmEz2eculFVG/Elt4PqVEOjbMiuC+Dnm9DIlLhj8PeajQ0yR3uQTOtd9DyX+KiRBu23UxMXNtn6/TGWz0Gx5ltsYeFdzft/NWsvJdkA3QtqoILVq+lmy5mMKKpB3B3TxKaWXW09SJTyP0Cym6jUL2+d8jatCb+XsXo6Qy22EpEcTJymyB3fywUiNxKs0jWWYiHOsPgM2WBuog5JNiXbIUt6KcISz1elrS55VWFs44cFco4a193yId4uSVJokBICSbwF7WeKCY1nmdUG1HGUuUbFaHyTYHrzoglt/WZnu/wFIvVYcAF4kkRKC42kipkvG6MqNkraaWDfMO3C9qJqKblbIR3KBwtkbx22le1H+sqaM7309jPLaJEMMy5MHeJ/kKrHGN4kJDRz1ZOyN7nqIsbhg3b/3aJ6thn0tIC60BuDHum9YYYUDqfq0TZN7oKGkBr2ysgpNk+ER8W91DAs5h/qrScO7S4eG8zo4QfQYfk0uGb4q5Q/Jh/vWfGSYu39Xv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(36840700001)(36860700001)(70586007)(82310400003)(186003)(81166007)(36756003)(82740400003)(7696005)(8676002)(8936002)(70206006)(4326008)(47076005)(83380400001)(356005)(86362001)(478600001)(1076003)(5660300002)(316002)(2616005)(2906002)(26005)(426003)(336012)(54906003)(6666004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:23.8313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c01c48-8901-4b5a-2b2c-08d8f0a3650f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1311
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
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why&How]
Add log for easier debug purposes.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 0b8082a15e24..7d2e433c2275 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2902,6 +2902,10 @@ static void dp_test_send_link_test_pattern(struct dc_link *link)
 
 	if (requestColorDepth != COLOR_DEPTH_UNDEFINED
 			&& pipe_ctx->stream->timing.display_color_depth != requestColorDepth) {
+		DC_LOG_DEBUG("%s: original bpc %d, changing to %d\n",
+				__func__,
+				pipe_ctx->stream->timing.display_color_depth,
+				requestColorDepth);
 		pipe_ctx->stream->timing.display_color_depth = requestColorDepth;
 		dp_update_dsc_config(pipe_ctx);
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
