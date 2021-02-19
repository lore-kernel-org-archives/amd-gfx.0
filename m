Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B50C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800EF60C3E
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800EF60C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4DBB6EC31;
	Fri, 19 Feb 2021 22:16:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A786C6EC31
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvrIs4FksTLgWGxm7yzGkPzYqgYbLbHGTMkt5TtGyEWNW72tcNx8C95urgtqYYGkAGvKaKR00ms3Krbs6g9grC2rFFJcwh4trp3gHt3488cY+jxzEXd0BFDK4z/cersVeAoE8NZzknfiWY6jNMYEc9pZxSIqcAf7UwEtSqTqnH8K759dKxehhx+Avp0vaMtjyCKO5NRMgwvM33JWied5bQ0is+2wqEp2/Ml+u3BBNFYKDmgnHyVaw7h3uCfNYjFX9yZJnVfixdaYsZRBco6h+xs/Ljmq4InohckXagz43s+tLgza4H4N/tI1NAerVjWF3daE3lF56C6Apv424JoaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05KSJ0ezWkFsATVwIbzqpVr4wFuiFprD9dgziTiI3Qo=;
 b=cmbu1vXg4nsy8quQB425kyibR+AyC69S6zUPZ40v7p84V17qsd43EiZyEaT8f6S7XFTOEemxCaIEuK3BvgqzMI5KO4oMsCFKj9xCZuWi3Qtm02vd8TcR9bZKeLwlrh2Tf1PnW3tJOMUtnS3NddY/N6mZl/PcDyivDgi7bOx0poVYYUd5/XlVTSEZ1RNhNvhtaI3Ux+nejsQIO8hV9b6oTweZd/8ZBdWY6+iJQSRRlbNl/zi7D3ajInueN1Tz9qn4yabzi+MJSaZUUGkTKUQluNz3b4j0GvhnmVQtcVTNgtS2eupn8yVpnw3vBvf9oBXIACskOTxByRX75nzx8j6Pqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05KSJ0ezWkFsATVwIbzqpVr4wFuiFprD9dgziTiI3Qo=;
 b=dcjwJMoUkrLRbGOUK5E9ZN1uHkOB6SsBgEthVZb+CTcznSE7eUPQmtsmlGyIiHRiqBd+S1N6lXWQQZptIgYOneGgxldnHaFJa3q7baG+DqFnNJflj8lKHEpGy8WLhBWPd3GdVzERp5+O3yDv003unKdDN71CYJmHnmOUadmH5LE=
Received: from BN9PR03CA0856.namprd03.prod.outlook.com (2603:10b6:408:13d::21)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Fri, 19 Feb
 2021 22:16:45 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::a4) by BN9PR03CA0856.outlook.office365.com
 (2603:10b6:408:13d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 22:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:16:44 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:41 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:40 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] drm/amd/display: enable audio on DP seamless boot
Date: Fri, 19 Feb 2021 17:16:04 -0500
Message-ID: <20210219221612.1713328-6-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b557febf-53d4-4cd3-d841-08d8d5240a45
X-MS-TrafficTypeDiagnostic: MW3PR12MB4460:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4460C6F4B35F4D34F8BB39A5F5849@MW3PR12MB4460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJDqKfZYJ89DxQNW/hDDXkXMTSeo+R3ZGsoBrCrWRhXEr7GvwqJCj9GkiqBqb7pLvCgRVxtCot/QPApLePmrSVvTA+1D0mEOuhmM5tYhN2oDlgswtxDH5wTRp17dHLM6hurF3AkdQGitdIOzsqLhpnNNrVkzZWiiKnSsKDDnFR+/wmqiLKHhzeECo/lk/+XfsjqznybfWTccToWRFkpg7zO3PD/8xUXTX0TrMR+AI19HaJ1hRFO86bSpePS3nWTjt7h8rvsAZxMyVaf0tj+RZ2dtEYLr5opIkC/fvLWVxs/+ur4BsDmLF5DyPbtJJ+cnBqX2uUl34h4EAigYBnCB1e32Uu/Gefz06whLZwKg1g5/HncqcDe+gtSpe+vbg/2oVb1JD7s+XPuEj2e5bkWwyfpe3Fss9jvGvTReLBpO3O1JRcXdbpUxnYTLmc7eBbwXLICij1MFCJDTCs51FT+6T1mQ182Thtx5FJ4MStYANoZlZyNLTy0x7B8hsbEWkgLXt7Y0hipMJnzpMg0DNClqG/q+AnjVa5UhctXqrVZS/lCAVllpjptTgM7NjS1Q1MaaTezlMw2ejU2QERX+qWKWsw4CpXnbw5RdnpNcXr5bwio6KMSUfIcLPPcSgEjjuAoQp+vUxLbq0rOaZPtJKvNEJEiNJr5jtwyYMJOzb+/sNYdPt5MPYQtf0rky+sOE6er5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966006)(36840700001)(26005)(316002)(54906003)(70586007)(6916009)(7696005)(82740400003)(356005)(6666004)(2906002)(47076005)(4326008)(81166007)(36756003)(83380400001)(426003)(82310400003)(478600001)(1076003)(5660300002)(8676002)(86362001)(8936002)(70206006)(186003)(36860700001)(336012)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:16:44.0363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b557febf-53d4-4cd3-d841-08d8d5240a45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Anthony Wang <anthony1.wang@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Wang <anthony1.wang@amd.com>

[Why]
Some external displays with DP can use seamless boot, but their audio endpoints are
only enabled after hotplug.
On boot, these displays inherit UEFI timings without properly initializing audio.

[How]
Enable display audio when seamless booting with an external monitor over DP.

Signed-off-by: Anthony Wang <anthony1.wang@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fa5059f71727..81ad546b2098 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3258,6 +3258,16 @@ void core_link_enable_stream(
 		/* Do not touch link on seamless boot optimization. */
 		if (pipe_ctx->stream->apply_seamless_boot_optimization) {
 			pipe_ctx->stream->dpms_off = false;
+
+			/* Still enable stream features & audio on seamless boot for DP external displays */
+			if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
+				enable_stream_features(pipe_ctx);
+				if (pipe_ctx->stream_res.audio != NULL) {
+					pipe_ctx->stream_res.stream_enc->funcs->dp_audio_enable(pipe_ctx->stream_res.stream_enc);
+					dc->hwss.enable_audio_stream(pipe_ctx);
+				}
+			}
+
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 			update_psp_stream_config(pipe_ctx, false);
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
