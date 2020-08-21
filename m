Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DC6C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3769E2067C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x8irObXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3769E2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD536EC1E;
	Fri, 21 Aug 2020 22:58:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E7876EC1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 22:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVqL/PpDVJK+FQ8ZCvDxhCSsCpF+8OqpBjHtlHIgjGAFI6M9YWOwLmQZXQUS0BRJWoLSjOCVCwjcCvqm3uA7aW0OlTlVv3nAquKGTarDoO4xYHEaE/EJeNK6Tez4NWWS5H+J5JmtUK4TFo/nimriIpD23M1HUorJPFh1PVBsy2075pnxUmMVRhb27GRbCGOsHjxxeljOWXe2OG1uM0TWZ/cSYJaeNW63X0tJOHIVq4HAiVzIifd33ioBSjr75luDCDvo1g+ISbSe6j0SYbJY/5xBLiwqZU1DoFSvwgTCjinMR2Mm9WLbhU5RUJWudxEUMTUM0bxLuCaQdfA5Qx47kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9rJBjvpHZtIvltj9hf20W3ZEOXoH0gvLUjK1XMmsPg=;
 b=LSXWhGjIdDsKaJiVwVOt8Ks0xmKMLdCtrD+Q82Ss0Xsg1JQwy0iIIz6DEmeH+omHzM5brPAjKVmAxILyPrjSGA+mNWSgwDViseQMZ0CCHDuAG0u2X3vE8/GcpGQw+z1WBQ954mIklI2/j8agc4lP9u09GXlWWwPxxL++SiQFeodEYWPbQIj7GCCmmzO8PsX6p9TKMXTJt/T3Tndh8koUPGt2PeqYZO0KRJpDNQRN600EE/+we7BKlqrAWIH1AbjNyEOtVa4paXBeLwt5+pKfUc6ClpEuH5mguEA3hztrXPcSRCbv9Fc5vCRGM7nW7pvjel9oXLKDf4NYO9gFgmPS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9rJBjvpHZtIvltj9hf20W3ZEOXoH0gvLUjK1XMmsPg=;
 b=x8irObXASUBD+0hK7nHTsboeSTqxYwOArabtcNZ8WHyTH3qv6JEsEevJpp4MRTlSVCNKF0dYQDh6X9O4izYbfQ5ErFeWN5hYoTHUAurGjUJSqM7fY6NugpDIpYRGjWpdYetGgjUqBTX7iOVf8EdiK1+0rRBtbcagqboiojR0PW8=
Received: from BN6PR21CA0016.namprd21.prod.outlook.com (2603:10b6:404:8e::26)
 by BYAPR12MB3080.namprd12.prod.outlook.com (2603:10b6:a03:de::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 21 Aug
 2020 22:58:41 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::48) by BN6PR21CA0016.outlook.office365.com
 (2603:10b6:404:8e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.3 via Frontend
 Transport; Fri, 21 Aug 2020 22:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 22:58:40 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:58:40 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 21 Aug 2020 17:58:34 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/9] drm/amd/display: Fix passive dongle mistaken as active
 dongle in EDID emulation
Date: Fri, 21 Aug 2020 18:57:08 -0400
Message-ID: <20200821225709.136571-9-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821225709.136571-1-eryk.brol@amd.com>
References: <20200821225709.136571-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70a4da47-0a3e-4b46-913e-08d84625bf18
X-MS-TrafficTypeDiagnostic: BYAPR12MB3080:
X-Microsoft-Antispam-PRVS: <BYAPR12MB308095F8AB5B7770A5379B80E55B0@BYAPR12MB3080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUfPhb/Ihyz3V7ETNAXZmbnikx9IfXvmX63VsoziUJ7QT6QqZ6KXqzygtC10OFzBlIVfCU5zjCNSuyJGKEZWzVv+GT6a6DugJ6lxrdzrfrdA6twVY2tV7RB3PhiT8+pVFfXxDF6R2YBkpC5pdLjZ+iS5YasdU8jCEO8spZoxui+uC9+pMZUoyCGOwFQgWCvZQaprJf+VNXffphhIaVQkK9bIj8VkDVtOhUuG2N0qzeliABTOX8Gi6OiUJm0pxmJ6srwWTThVAa9hO8/JD9riqEF58iWpJLlUvAcIc8uwqcpIp0XwwA3AQxIZosJEoFJEhIUQFqIZYVaWcWZROl9EmvK9kRD1fcgjHOWBMd/iWICVG0aG3ZDb6RQNcYfn8Yz+deLws2VsBrtzEpbsYPBaGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(336012)(6666004)(4326008)(70206006)(478600001)(86362001)(5660300002)(36756003)(1076003)(70586007)(26005)(8676002)(316002)(6916009)(426003)(186003)(47076004)(356005)(82310400002)(83380400001)(54906003)(44832011)(2616005)(8936002)(82740400003)(81166007)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:58:40.6288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a4da47-0a3e-4b46-913e-08d84625bf18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3080
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
Cc: Joshua Aberback <Joshua.Aberback@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Samson Tam <Samson.Tam@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
dongle_type is set during dongle connection but for passive dongles,
dongle_type is not set. If user starts with an active dongle and
then switches to a passive dongle, it will still report as an active
dongle. Trying to emulate the wrong connecter type results in display
not lighting up.

[How]
Set dpcd_caps.dongle_type for passive dongles in detect_dp().

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 405452b736e1..437d1a7a16fe 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -763,6 +763,7 @@ static bool detect_dp(struct dc_link *link,
 		sink_caps->signal = dp_passive_dongle_detection(link->ddc,
 								sink_caps,
 								audio_support);
+		link->dpcd_caps.dongle_type = sink_caps->dongle_type;
 	}
 
 	return true;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
