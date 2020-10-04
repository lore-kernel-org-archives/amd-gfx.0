Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03A9C4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A442206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lJIMwfkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A442206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10ADB89E26;
	Sun,  4 Oct 2020 17:19:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770054.outbound.protection.outlook.com [40.107.77.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF7F089E26
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mldic/k7ht8GmGqRrKnkO7yBweGYBfFwVMxspjL7YmPacplaEMbeAngAyfsxbHP1zb8hmnwUOYo6QYdEGAyS+UTHhE0QlmFhQL10cZ+rM0KNFIf97CERUEvazpXlJxie2f/kawEcJG2gutLxSvdpuevrr6KnGPgmH4pHPqck1gje1aQEtnHJx7xZshIHZKLrB8IGsaD5OQCZx4I5xWHwfKFafzVk7NxwVqDjsEJ1vORfxxJ88F4rz5qbzjXRhjXXKRsXK4EE40nLN1HS9aLL9THsPKrKwD12/LJNqceD3qsACFly+GUYWWYBV/STV1y4GZR+B4StXB9ZtjjO4E8j/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiwDOaHaF4BHcBdzckbcwUNy/F8b9jjm/jAvITUQq1U=;
 b=dChKqiTpZ+m9uN7nDTFMfWgwtY2wpfMK3EwICWI5i2wfLjptyu6bny5UIdy28JoWIkxwK9M5MxaLp5srMxZPR7oceh+6HRykPfyNWNOFi+FxrgMG9LtczvUl/5810c242fa8G/9KDosdNB1O+aRphY6BZ1mRI230KOcsWxUx0EeSr04iE9Jw9O0dG2BtPzkPSyrJdiwGqp37L6NCNWsAjDOfJI6dnWlogUZnttojXq9UHp2Hp+Ru8wM2Wh18gsh9fCILmOgOAd/dFO8oEFUqntPFc8eUpNx2iChwDGdYmMDlP0eqPleOZBDHCUBwTzT8vYqLAgNTsUQbwhPJxALC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiwDOaHaF4BHcBdzckbcwUNy/F8b9jjm/jAvITUQq1U=;
 b=lJIMwfkFT234ZCVazuczPV9Ba5qMRQELbMPaxEnegti6UqqBgT2bR9HiXUJqAAObMR6fVPzSIXg0m1YdQQFAmTXyzr85zInVLjKjRCvniky6XPhDGpdTc43pNB4eDnXkzoC4mEUdGKxQ7ZKFKYe+6bMarafH9Abs0jjNmBp0Tz0=
Received: from MW3PR06CA0013.namprd06.prod.outlook.com (2603:10b6:303:2a::18)
 by MN2PR12MB3551.namprd12.prod.outlook.com (2603:10b6:208:104::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sun, 4 Oct
 2020 17:19:48 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::10) by MW3PR06CA0013.outlook.office365.com
 (2603:10b6:303:2a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Sun, 4 Oct 2020 17:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:19:48 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:47 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:19:41 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/18] drm/amd/display: HDMI remote sink need mode validation
 for Linux
Date: Sun, 4 Oct 2020 13:18:05 -0400
Message-ID: <20201004171813.7819-11-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ff8813e-aead-4fad-9d2b-08d86889b22f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3551:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3551987A9AB65B515E768E12E50F0@MN2PR12MB3551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JZF1hJZUojP0mSMDq+l1o1unks8xPJRtzuvXtLdetPP4uSJFn+zyD/8NFUGX+KSV9D7nG9ymvmjsMk1HPGcQ6sZEZxAZzZlZ0MK9w7SmCNfVCWPDayUdJ84n/0jJhGRmD6WkZpIYAWzqUNHNuHrtOnhi2C/cgBNjl60sKKMyA1WZw8MdSBNedmpT3p5KUPEgkUFNWW4czLs1D5XP9GIhZ8LYXTzJ+LM7ncK3t7JbzRqq+lj1cVdGii/AR6h0QWT8ndebnMIn6kXSNGX9KrOXzDcN4Cxj8W58XWCGa6L2hqdZqQAxu55vLh6LymnbN0wJ3GFuymm+r+5GrEF0kN2W4uyo6eVv1RJvBC5V6OaXGHWw0ePoOfZIyYdRG1tQia+P5GPkhVyldlhu6EnFSu/hQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(376002)(136003)(346002)(46966005)(82740400003)(8936002)(82310400003)(186003)(6916009)(6666004)(2906002)(426003)(86362001)(36756003)(336012)(8676002)(44832011)(47076004)(54906003)(26005)(1076003)(4326008)(83380400001)(316002)(70586007)(70206006)(5660300002)(81166007)(356005)(2616005)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:19:48.0419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff8813e-aead-4fad-9d2b-08d86889b22f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3551
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why]
Currently mode validation is bypassed if remote sink exists. That
leads to mode set issue when a BW bottle neck exists in the link path,
e.g., a DP-to-HDMI converter that only supports HDMI 1.4.

Any invalid mode passed to Linux user space will cause the modeset
failure due to limitation of Linux user space implementation.

[How]
Mode validation is skipped only if in edid override. For real remote
sink, clock limit check should be done for HDMI remote sink.

Have HDMI related remote sink going through mode validation to
elimiate modes which pixel clock exceeds BW limitation.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f13396254b5d..fec87a2e210c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2441,7 +2441,7 @@ enum dc_status dc_link_validate_mode_timing(
 	/* A hack to avoid failing any modes for EDID override feature on
 	 * topology change such as lower quality cable for DP or different dongle
 	 */
-	if (link->remote_sinks[0])
+	if (link->remote_sinks[0] && link->remote_sinks[0]->sink_signal == SIGNAL_TYPE_VIRTUAL)
 		return DC_OK;
 
 	/* Passive Dongle */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
