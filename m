Return-Path: <SRS0=UzQs=3M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05519C33CB6
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 19:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D341A21D7D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 19:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L/EKgxrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D341A21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 912866FE46;
	Thu, 23 Jan 2020 19:46:07 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5F56FE46
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 19:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfsUIAVD6Eq8b2Qde8CtJwcr2P4e6ZwUtFG0ZsoNjjaUGu4HINGI28OerWYPmb9aM54Pah1FgBlLGKv3801FTWKtxE69IGDLfTa3mop30tLiPHPA7rxDuzIkdFrQkIDhKDzqUTss8AXwF6UGEBq3Y/A6iyyqagPYU2D4UmvbiZduAI88Svfy698W5s4LEhxTuJY0Km63f8z51EKwv5+uG88gHBu5LPVD6/vrxMpnqjgEAB1BHGwgFWuhdqoK0q6FVv0tp1DBEl5AC+xdoMwf/+Epag9krYcezCFjVq7hQx3aXBGIDA7c/sZcwXDkjBl3NhMOgE/9J4fslYfQ4TydvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61bcECVCDoWk4wLykyPCCc48owDIya1H9txwWlQL600=;
 b=nEVLUInz0qZH9DTBqmdf+bxaMXrImlhYJuJDC2gDU+xaU3w17nNF44OWmKmukyEeVFUeta3AlfR2X7dtJuFcAL79V6AY1xNUn8lJo8xBluD6DKqr5dOQmptQ7MMsk2DupemCMUFdjT0BqepV5yFQlCmJ+SYbwITsqsCYN2Q2IJDe1Mk8BnmEI1L1VVuwzGfBkDKMO6fzYP67PoQRFGxFCT6GLKer16qd46dLtRVCSAoi1TdcylAOoBTr7mPQkYLp1WPgwN3VjL6dqJSsckLqcbjnLWOhu3M4yGSS2dHfd6WWU3ENT6fBkaaS4a/YiLdVduVUQ1hPIEB8raPEUNA34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61bcECVCDoWk4wLykyPCCc48owDIya1H9txwWlQL600=;
 b=L/EKgxrChe/Bc5BJzfQ9iXcKvMwBoXfu6s0esspyyoqRgEKvOJ7TE7xATFWzciXm9xxgHyH/lulJWEl0Ct6lx81LKB4zAZo5xDek294jb8n/jvRSXxcCmB2nBFYuf15MTPQiQl+FD5SgxIjt3sunTKSfEmCu+oxKAYy8Ev8ze/0=
Received: from CY4PR1201CA0011.namprd12.prod.outlook.com
 (2603:10b6:910:16::21) by CH2PR12MB4279.namprd12.prod.outlook.com
 (2603:10b6:610:af::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18; Thu, 23 Jan
 2020 19:45:34 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by CY4PR1201CA0011.outlook.office365.com
 (2603:10b6:910:16::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via Frontend
 Transport; Thu, 23 Jan 2020 19:45:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 23 Jan 2020 19:45:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Jan
 2020 13:45:33 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Jan
 2020 13:45:32 -0600
Received: from hwentlanhp.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Jan 2020 13:45:32 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: Retrain dongles when SINK_COUNT becomes
 non-zero
Date: Thu, 23 Jan 2020 14:45:25 -0500
Message-ID: <20200123194526.17967-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(428003)(199004)(189003)(7696005)(6666004)(36756003)(356004)(478600001)(5660300002)(70586007)(70206006)(86362001)(426003)(336012)(26005)(186003)(6916009)(8936002)(54906003)(2616005)(8676002)(1076003)(316002)(4326008)(44832011)(81156014)(81166006)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4279; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 622477da-be83-43c9-8140-08d7a03ccfa2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4279:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4279DEAC342C85FEF0BE2DD18C0F0@CH2PR12MB4279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 029174C036
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcCQPv2Kl45ClfkS+EXf3/gm0o1eWPZb6Y9eZkZ4IRa4YZwloGj+8aDKgcBURJre0ZynVoDUEkEz+1QTnuA+ijFP1ntj77nl7ULKOy0OkXkXOaDfRBveQhkEVDx5u+dw+fgZASY9WU+9QbEeUKb8sn/CeNUyPI7k0qg6NEFyA2SzvlM1Up937VNKDb3nrQ/si1Br+prYdqyI2CTvDSN2PiCe89e+/8VQGWeaiTcQbztxK/CJuBW4rxOpfbQxGNja/KgqhGvTH8iSgbcVbpc/95nX5oLtIPSyAft87OtdLXH268ff36uQ8iTdh53p5hyPem1tN9G6pdfdicS6lyuYRGE9KpyvS33U/l81KkUtbidUTOrvr7J6VjxKwUHqzDnZi1AJWlZuTi41upBaVWQ4JJc0eRBNMf2Gs64iP/w18uH69BRBBT+xAJz/JeFdB24U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2020 19:45:33.7259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 622477da-be83-43c9-8140-08d7a03ccfa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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
Cc: Hersen Wu <hersenxs.wu@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Eric Yang <Eric.Yang2@amd.com>,
 Louis Li <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
Two years ago the patch referenced by the Fixes tag stopped running
dp_verify_link_cap_with_retries during DP detection when the reason
for the detection was a short-pulse interrupt. This effectively meant
that we were no longer doing the verify_link_cap training on active
dongles when their SINK_COUNT changed from 0 to 1.

A year ago this was partly remedied with this commit:
80adaebd2d41 drm/amd/display: Don't skip link training for empty dongle

This made sure that we trained the dongle on initial hotplug (without
connected downstream devices).

This is all fine and dandy if it weren't for the fact that there are
some dongles on the market that don't like link training when SINK_COUNT
is 0 These dongles will in fact indicate a SINK_COUNT of 0 immediately
after hotplug, even when a downstream device is connected, and then
trigger a shortpulse interrupt indicating a SINK_COUNT change to 1.

In order to play nicely we will need our policy to not link train an
active DP dongle when SINK_COUNT is 0 but ensure we train it when the
SINK_COUNT changes to 1.

[HOW]
Call dp_verify_link_cap_with_retries on detection even when the detection
is triggered from a short pulse interrupt.

With this change we can also revert this commit which we'll do in a separate
follow-up change:
80adaebd2d41 drm/amd/display: Don't skip link training for empty dongle

Fixes: 0301ccbaf67d drm/amd/display: DP Compliance 400.1.1 failure
Suggested-by: Louis Li <Ching-shih.Li@amd.com>
Tested-by: Louis Li <Ching-shih.Li@amd.com>
Cc: Wenjing Liu <Wenjing.Liu@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Eric Yang <Eric.Yang2@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a50768a7ba68..cc2e05003595 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -969,8 +969,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
 			same_edid = is_same_edid(&prev_sink->dc_edid, &sink->dc_edid);
 
 		if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
-			sink_caps.transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX &&
-			reason != DETECT_REASON_HPDRX) {
+			sink_caps.transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
 			/*
 			 * TODO debug why Dell 2413 doesn't like
 			 *  two link trainings
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
