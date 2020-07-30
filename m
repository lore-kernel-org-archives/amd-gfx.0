Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138BBC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE126206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EPtfabBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE126206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A79576E95C;
	Thu, 30 Jul 2020 19:12:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EA2C6E95E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnj3kry9kf2nzNNxXP/DCF1ZsOyoVm9N+eaWKkeTtwNRSFNcDTR2621oWeLrW5v4ErD1b7kEikwLhUD1DkHNKQ20ioE2iLIaYFQltD0YPnavoCr+7bvJio0U1w/nrmcFDFBDibw9UaZOjoZsKbGO+DVxAC5tbapl/7deccb8VWVAG/v0sIxCqmfGzeSwGgD8Wx24HGUEqYZkiXTc8yEly012KPguV/7TMS8jgZogIN0DDv5hapiiqfjcb1Wdf6lkgrmIY+ZGbKr0IdQBNkZzTEN9yPgT2i8dEI+I8IcwFPgscviLO8k9XfL3ESwJcqqUamLNT8io0wjXaoYGPq8JNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2/AXw4QCr+suTyvn8dKDzG1AhVDF9lvtAL/aHr+cRg=;
 b=DWYTZx0x2K+yPBLPSXXe8V2fzCxus2c3khYXLXzg1OJwk74Yj+Z9lfrXrfowZ+2hEGpSpoqFKZISyOeV5KsIm48DCeWYULEyDwFkezQWLcwxzqbuEGwD2Hzv+ebU381aDBLwhV3d/NmvO12ySVDRmcnBIeHJgAj4Csidjl7UawLe8V7rjqUFjiwJzNo1mCEnw9HBAgpkvlgZOHML7BPsQqQ3lom1xmJnkClCXXZUSSSM4lDZa/PRE94yEZcLsJqFo984ED9XD/eAhcBXpunTSv8rhOMR3RtmB8kXPzPjyLgFnFahBW2yW9S9TS6IOHlAxxIBh2lELw89NWSaSHbdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2/AXw4QCr+suTyvn8dKDzG1AhVDF9lvtAL/aHr+cRg=;
 b=EPtfabBvdajL84xI+Zd97BNCEBXf/9HATb7RDm2A5SfqpZs7CWvGeOUO+ff45eWn2jvY67OKpS4XN7lKRZEHEVpMubep7EnxEKLb7OvsLlVA7hHWRSXjsIpAu6NIubW1WLm4ahNdlNCeS24T6iSC4lSnvHv27EPB9q1tpylijRI=
Received: from BN6PR2001CA0034.namprd20.prod.outlook.com
 (2603:10b6:405:16::20) by BN8PR12MB3554.namprd12.prod.outlook.com
 (2603:10b6:408:65::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Thu, 30 Jul
 2020 19:12:32 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::83) by BN6PR2001CA0034.outlook.office365.com
 (2603:10b6:405:16::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.20 via Frontend Transport; Thu, 30 Jul 2020 19:12:32 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:31 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:12:31 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: Use helper function to check for HDMI
 signal
Date: Thu, 30 Jul 2020 15:11:40 -0400
Message-ID: <20200730191146.33112-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59627ea4-c7b7-47e3-6414-08d834bc82bd
X-MS-TrafficTypeDiagnostic: BN8PR12MB3554:
X-Microsoft-Antispam-PRVS: <BN8PR12MB355417EF5B01A99315030BDD8B710@BN8PR12MB3554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REABVZgU1bEDh6Kw1Ry5V8BjosPtrY/JJ6gnCzkJgBEVSCuRY0xZTRBorf0MtWj8xaxmFqj36r6RCVsWg1YY1+iRMJzzHk+t5DR2PMNgf+U5hCUDt6/ZeNcPVkACezzpEesKEmrkKQki7RBYH7zx0MYSfYzC7rZuygZ/tdwycHUatoh7pKtuKrca1eJj1KvndAXwLAS/4HGICat4kRFt+RzUMvaMgvFRLQtnh14xzwXJ/RMWNNM+AYEj0xDgk8DOfNhue+WeId4bdjnbmsN6cVKANki50ukop3xPwF0UQ0OnJvDoIXDJbrtdxSFCY7HmHKZZJb7DMKFYPUFoVpVZAsZS26wgyYrvA0HWYECHC1TUMWqiFDFfQUmBAp9uDKT13SfOR7uHMFaxdvXVPoq2bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966005)(336012)(7696005)(186003)(316002)(426003)(81166007)(83380400001)(8936002)(82310400002)(54906003)(6916009)(356005)(8676002)(70586007)(70206006)(6666004)(1076003)(82740400003)(44832011)(36756003)(2616005)(5660300002)(2906002)(26005)(478600001)(86362001)(4326008)(47076004)(4744005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:32.4441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59627ea4-c7b7-47e3-6414-08d834bc82bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3554
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, "JinZe.Xu" <JinZe.Xu@amd.com>,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "JinZe.Xu" <JinZe.Xu@amd.com>

[How]
Use dc_is_hdmi_signal to determine signal type.

Signed-off-by: JinZe.Xu <JinZe.Xu@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 071c7b32b282..4bd6e03a7ef3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3282,7 +3282,7 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 			dc_is_virtual_signal(pipe_ctx->stream->signal))
 		return;
 
-	if (pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
 		core_link_set_avmute(pipe_ctx, true);
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
