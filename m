Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B41EC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B33360C3E
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B33360C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF286EC45;
	Fri, 19 Feb 2021 22:16:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFFEC6EC63
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqagDQDQbrbxZx32IdgFGC5d9C1QEVNHuAkbbQ0UtKGqepErt4DqW0FHcwpmSiJyZEzy/+7dZtUuRPUbpRFqutBugNw2Mq76EOVnucbNtFvN9WGIceVREPl7pFD8DfNRXbxg90VAlxb7baPpHl7yAstVqSE7mnm2m/kVqzzuKzn3odx7KfVYYOT/BZSGuknVPNvciZ6r9PXzcg2oM4BTOaquuZfbXLeDWBtKziiGg4KYYUOqn/JIAJC9rWSn1BoJzhVpaaQCsQVqmX3bZvLJtg/C6XwDEcFp2PggJbMURbmJ5RYzvB6L+SzdGLacAhEIE0jyRZQSIy5d5k8RXwyAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9aMP+J/sDKcVRmqB9SrHf/956a/cBY4D4qFL4AuYs4=;
 b=R0TgTHk1S/vp6IBvXSay0H8l62VT2aMU9AynYSwuvxT2WryyTABgeexv8XaurMD5uFaTPGeNDPfI+XXYgSiywnMBeTwxO655PhYEJTYGIlYXLnNLBLlBzI46cxYacYPO/oHsrDN/UQ+X6ccUgz+4Y7I7FzPqzVAtPPUGPdSuHyJYy+ukpXRVIApQAKhDogZI4kMHwVuGoMgW7Rsq3KAOk6n4enI7+iOlBxR3kObG8MUC4fzdI7EJSx3coiWwdxRq8agvP3NadzpTD4BURJ/Aqp76z06xsKajdA0CAU3iIeLUGzbDyvDVBBCBRv6eiGY2eW1rDJGaFCB5OOJtdui++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9aMP+J/sDKcVRmqB9SrHf/956a/cBY4D4qFL4AuYs4=;
 b=Qk5gIcZFarfcSNCHyBvIw2Q7r05cLaMBqzp19BfY92i12Dvo6TWYJyHJI6aTHVXXeVDrXVCAs/nxjopCUeBrDSLLD5cdba9ZsA3DvXoSzqwMscOa5xKbdrwzUorhXUW2ZCqSw6K1TMxhUwLVBjmviHKp83uA+pD9W37qkAv6LtY=
Received: from BN6PR11CA0052.namprd11.prod.outlook.com (2603:10b6:404:f7::14)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Fri, 19 Feb
 2021 22:16:56 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::66) by BN6PR11CA0052.outlook.office365.com
 (2603:10b6:404:f7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 22:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:16:54 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:50 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:50 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/13] drm/amd/display: Don't optimize bandwidth before
 disabling planes
Date: Fri, 19 Feb 2021 17:16:08 -0500
Message-ID: <20210219221612.1713328-10-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54f5d4a6-41d2-4e09-83fe-08d8d524108e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4420:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4420AB95CAB4283A12F978A8F5849@DM6PR12MB4420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OM5XhE+Ghj2L7/VDjHWFU2w7QCwvQeQeLF+PwrjLuiuVakHPprNseiDvQXCMTA7O8te9DHw+Za3NSnGUZ51c8PZWCIfOTQ7EWZ7nvwb3aitUZKjyON9WLBn2SGc9EPPEjMAZYEkVirUsnuxV8snWXD1OrGnLM8infu+bvvKdlbmRUbD1+74v0CwoYX+pH0w5NqGvx0w1bTMb4Ebba7BqKyb97bzNHeF+DOpIGfCZjf2pbRTv0dFk4Xs2LznHq1nuUrKrO/apOWUk7UqY37hjk9FSQG/N3wM54vjOshR+fXx1h9mJJFFto5Fi390EqhXuoWRv6LExtmapX7JcRauHtAoFR17IM/M+fovaMYtIG91eErwCWrQVD0XEVZYjGs/33IwmhQT4rgRqniG6ZHMSrJj5OOfppfwsGN5vTKfanta3p1Pq8duWj+wyGvv6ZZ49FP4wrCu2xuIdWI886cCYQ5+c1voe8pne2FhQA92ghQZyljYNsx/syl/TRGOQ8y4Vnf6rTH6K41lCwCmUQo6v/8tAqAseGQi8uPi2L8Q7p3HUSwB8ewVl1QOjNvo+/BDf6Wwp0wSq5foW3B+Jqiq0mXY9EF2UhOcnQBdB6V5Y50bfhdfFABYkPCIrXtmeN8w4P4cEazIBXDvLjcffZmupqEeW6D5M7I8XXTZ17fbh8lSQyGPRUb+3pdC9/GcUUXkS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(2906002)(336012)(6916009)(47076005)(426003)(26005)(1076003)(356005)(86362001)(54906003)(81166007)(83380400001)(316002)(186003)(70206006)(82740400003)(6666004)(8676002)(478600001)(70586007)(4326008)(7696005)(5660300002)(82310400003)(36756003)(36860700001)(2616005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:16:54.5789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f5d4a6-41d2-4e09-83fe-08d8d524108e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
There is a window of time where we optimize bandwidth due to no streams
enabled will enable PSTATE changing but HUBPs are not disabled yet.
This results in underflow counter increasing in some hotplug scenarios.

[How]
Set the optimize-bandwidth flag for later processing once all the HUBPs
are properly disabled.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 39df5d2c0108..4df26a67e570 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2413,7 +2413,8 @@ static void commit_planes_do_stream_update(struct dc *dc,
 					if (pipe_ctx->stream_res.audio && !dc->debug.az_endpoint_mute_only)
 						pipe_ctx->stream_res.audio->funcs->az_disable(pipe_ctx->stream_res.audio);
 
-					dc->hwss.optimize_bandwidth(dc, dc->current_state);
+					dc->optimized_required = true;
+
 				} else {
 					if (get_seamless_boot_stream_count(context) == 0)
 						dc->hwss.prepare_bandwidth(dc, dc->current_state);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
