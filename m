Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC4CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105B860C3E
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105B860C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677F76EC27;
	Fri, 19 Feb 2021 22:16:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 386BF6EC19
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:16:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqFg6o6xwT5zUdlZLEcuk8gTn+cNAEcfTxq33OLR4zuZ34jPypJQF14DqG8zw+jQKP2xHSbtN4dA43rT8tVZTfBQtyyiMMDnfAcmgKvy/vPk/zQl/2YQY0SZUzb0kfDpZm9JoE8tSJkMb7u5a69/twh8lR3V6hs4lzd+aT1pXRgEfY70sNPsXCj95CgjBT0/JG8OCrysHk7CTMZHDADCfxaMOEUiFDb+nS1ObRCrSBlJeC7XBAxzBJq9uYrCAUw2UfaHw9hTl5AM3MGnZnsT/wGlXNfbC9jeTbJXU50buWgqojkscB772UCzUQpP8iFfCihRpz/2pSRjVvZGIkiTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSza4NX769AEtQUC2+V5yBGh18Rpj2SOrXTvaFR62fE=;
 b=lHHDRGPzeNqi3V97JyPbwlPo3d7bk4j618wjAVIOHykmuEEnDzhYJ6acr6j5Wu7zkqodesw7og6f1vM2cwC2kD7EaMY7SZub3OCQMYKU9Sm7WcPxF1lrwMe8Nu7kIlmrhQ2eB11LXlpWHnSaRfs4AHTxHd4NUzhOc1VAroyMUieZRWALL2E2/nPSUxn1XWcFaKa5BEPRn1yVumLs3E9Ik60SegFET5b+nShIh3oe0tRqoZLCB9wWT+GI5DP05yCTZ/ArKK3dmALEbzAv0yv6RYLz0zQC1t7crZW3/RsCM37UpplFA7f71ETefLhCtoWn2lOdNCog8qu9cGVF76fk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSza4NX769AEtQUC2+V5yBGh18Rpj2SOrXTvaFR62fE=;
 b=VDjW3l7o8SCSlnvXk4+HcSUmsLUqnkfsc/cxkxaFqZayZtiV6NajpglnS5Uxe/dx9hxuiftrRF8LCt20FeJhCzZErSACpflOtI/+0Oty8pkzLnNXhZgUFiZd1gbYtrH6Cni1ADJA2xesZ4QfU2jZ5h7hE+faBiT8m/WM89BNOb4=
Received: from BN9PR03CA0560.namprd03.prod.outlook.com (2603:10b6:408:138::25)
 by MWHPR12MB1885.namprd12.prod.outlook.com (2603:10b6:300:114::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.34; Fri, 19 Feb
 2021 22:16:43 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::b6) by BN9PR03CA0560.outlook.office365.com
 (2603:10b6:408:138::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 22:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:16:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:40 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:40 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:39 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/13] drm/amd/display: disable seamless boot for DP MST
Date: Fri, 19 Feb 2021 17:16:03 -0500
Message-ID: <20210219221612.1713328-5-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd88b891-f09d-45a1-8e33-08d8d52408d6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1885:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1885F07B2E47F8E20AAB0D0BF5849@MWHPR12MB1885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xe9z9MprwjAc68bdQ1fr5zwXPy1V9VywJKjTL9zVmW5mLjFQi7Ro3gtcqZFxrva6HnlFxR0erVwN2a42AHvVywhS21WaV+ZsmUPiZ5hRP1hof1rol8fEJzrbVaf7IoLVP77603R2Zzu5ufoRBdkOzOMLWomJcLN9wfFmjX2UNlpuzy9dP+MQwFCIlWnrqp4R4MznBBLWo6W+whjvZxwm/EzPYSKXkEgp5e2kffFjKa2X6Bc3DW/ULeA6sh3ly4n6eL68d5XHADwwTYjSq/c7QthDbRyxEONYxvjpHs9byMqUsMF/BahmfLHczBVvmi/2sn/wCKiHF0FWni57xQNCS7NYkJ1elfBkQDppxoVrQSD5ZmxLrZKjfrlOGzHhTzeeqjXyGqd5xMbe65qwZ5dH4mP57NWjSdVpLcofQNz+GNdIFV0OocDsQDmc6OSC3qXD9AyXfkxgjmXklFd4T2+mpljyetm8RKI6Ei51A/ff/tSEz9mQ7QcRayM1Aktl9aOtevVZiSzOWeRIiD2wRTwoTQoseB4dQbjLEc4BeBodpXRkuqP1LbujMzBIEsrLZwlHMAZyCF+QjvRvNaudkua6XraxMavd1m/r0iFed3CM322nl4cuZh1ESvVZErJ6KQwjcybsKQcCZSvopQlGzyrNmGo5iojuuTm1cJWvYKVzPmVatehDPLB8iILxZx85AWFD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36840700001)(46966006)(82310400003)(186003)(26005)(478600001)(4326008)(47076005)(36860700001)(7696005)(2616005)(5660300002)(6916009)(70586007)(81166007)(83380400001)(1076003)(82740400003)(8676002)(86362001)(336012)(426003)(2906002)(70206006)(316002)(356005)(8936002)(6666004)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:16:41.6293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd88b891-f09d-45a1-8e33-08d8d52408d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1885
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
Seamless boot over DP MST is not POR, but is not explicitly disabled.

[How]
Add check for DP MST and return false in
dc_validate_seamless_boot_timing.

Signed-off-by: Anthony Wang <anthony1.wang@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e2cc1a141131..2f56fa2c0bf4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1213,8 +1213,9 @@ bool dc_validate_seamless_boot_timing(const struct dc *dc,
 	unsigned int i, enc_inst, tg_inst = 0;
 
 	// Seamless port only support single DP and EDP so far
-	if (sink->sink_signal != SIGNAL_TYPE_DISPLAY_PORT &&
-		sink->sink_signal != SIGNAL_TYPE_EDP)
+	if ((sink->sink_signal != SIGNAL_TYPE_DISPLAY_PORT &&
+		sink->sink_signal != SIGNAL_TYPE_EDP) ||
+		sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		return false;
 
 	/* Check for enabled DIG to identify enabled display */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
