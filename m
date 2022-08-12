Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679FAC00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E4AADD4F;
	Sat, 13 Aug 2022 02:13:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0295AD2B7
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCvZTrGtNyXTGLydwciEOmz7F5TzDah8ALKhCEb96mkUvwGru8IWL0Rdu1+4mHao/k7kfJY5Z3nS6yzUFFe1eCWyzP1dYTVxeYPpWKxbHQ+LH7wOSDrW/t86m6JQzW+NHVu4Nor9tDyYT4w/R0U3isnyhFqvcoc8DC+pS/UzkmcIt13NsGRaAsI5T5WsFppsWrTG70QUofwVf2d/mXoiOzp/CeA3woGbCkkj48U/vEXr5xrZ4SA/WDW/X8086LGOGYmEpOfl9Z6fjtBxQMdWuKq9Ea6XtME7ZVNpkUV8JR7PzPBELiAuhOl7TW/bOYTCdf4ymxt5J0P8hZnBGgs1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwepBwI691ew1d+5GW+6fk7ZCo1sI8TJgWXxewUck0Q=;
 b=Fg/5h4QZ+rs3ABka2w/T8zQsnykeO2zk8f3wglAugqqmtOqx8OG0j4NyBFA7WDxuCcH84UXB+MohjcD1Xnz/1flSui8a+OJC6wwBSUvDXdydOWRTWIsDw/rn9WfFUgkoI2tZxPeIE7xiMcuYROhFDYYJjyUxCZanMoA7NIBQ91AWyLhHOZmJlw1VEyDsZbeNLoNHwS6gnclNtsFScg2i/w1tv/GVukkkPcUsatwIA8fS79DCTQmtIHNdJf+5yYv91tD+oiceZNgcw/l+80J5u9+0dME7nfwD86m0OA55veN3NBAQQV3aFBDAQZm3CgxYTlqMZQm6GRRBH8aXmcIj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwepBwI691ew1d+5GW+6fk7ZCo1sI8TJgWXxewUck0Q=;
 b=fLQTMwgDyBNpZRaKp/u4pv04UAOrjNhwW2XEqskQNEs9GRVul35slCwiQfQ6NuozTxFSnDHuDpKZehqBO+cVkL9tX3AYnGF8W6xyDVCKkfmnJMuYiqm3D0rYkohNzssW0Oh1JTspCCPITc7E9paKVTKvehWfbXeBUtcvFphkSto=
Received: from BN9PR03CA0107.namprd03.prod.outlook.com (2603:10b6:408:fd::22)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sat, 13 Aug
 2022 02:12:53 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::7b) by BN9PR03CA0107.outlook.office365.com
 (2603:10b6:408:fd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Sat, 13 Aug 2022 02:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 02:12:52 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:12:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 19:12:23 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:12:20
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amd/display: Fix pixel clock programming
Date: Sat, 13 Aug 2022 06:12:11 +0800
Message-ID: <20220812221222.1700948-4-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35fedd8c-0970-4f0f-756c-08da7cd1540e
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6100:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMuZA1a5K+JIbod+zbYgYqBJ4m3T/4WIUHmUbcqCZOEdznqSerL5A9k39SlsLSylRWkTC+D5XemTNep0OR3E3Wzz5+XLsEW2LHDngN5CQJp4Qpeu7Fb19SdGSQ43BMpH+JNY4oVbxfojQLWcP+L2yYcjvNMly6PhTCyev1SJZ4qWHWzgoeDLFG7e9KTJBXy+UoOEfIn3RSM93pbJjXUJTi1kC4Bipa3wvq6RCAOjKy7wJb3417j3MKeOhH6GgvSYenWRKZ7nGN0OWSUWsTW4WtTWthMo4OEdCNG6qWUi3p3DRn+Fl9RSssCq4vwpWv6AjmVNv28Ln52sGy8SMiDQd7ze+0fi9Ep9Ro8eH0aLKpAz8H6N71VNj3y4GLLhZgMzjEcFS7lEMOyN+E0k/H4zz74RNLQD3wsfZgECztlWwxKsWrMCLussy4TAik5E0AFbA3U2C7+cwo7wNK3dAmP2Z6H78oYgbUW37Zmx/MMPdPFy3rSljLln+uGPgooDC3Fzu9AV8DSqayRSKBf+b7sngQYKMAqqw+J5w1ziYFeGL0kwKTXefdhUQDrS59zqg+q7eyCkkY/dVYFciU20HRSHdkWEqDXGzSeKVPtEChIc3dL9Z21Pm/qdT6SAMP3uNWLbX4qV19iv8f23e4TbRAYi96/kJcuwYa2XZvTOSLiishzLfyPcvO0FdG8B51jT/IqS11jHkC9XRrqxkNZVkKnNgIeU8rHRR944xQ5C5waEE4m2dfy0+hnDmzOk5lF8CXrQYQE8zjooLPjw/zqYPpDwhA7BrlivQMThRwhdJuJ0xpAoZbqv9Vn7SIcOyI69bC+Q4MnN0WtRQSYReMeJLJ4YTMVKdoZpy5YPwLxbmPvKsE0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(40470700004)(46966006)(356005)(36756003)(41300700001)(478600001)(7696005)(26005)(86362001)(81166007)(2616005)(426003)(1076003)(336012)(186003)(47076005)(6666004)(83380400001)(8676002)(40480700001)(4326008)(82310400005)(70206006)(5660300002)(316002)(6916009)(54906003)(70586007)(36860700001)(82740400003)(8936002)(2906002)(40460700003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:12:52.5808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fedd8c-0970-4f0f-756c-08da7cd1540e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Brian Chang <Brian.Chang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
Some pixel clock values could cause HDMI TMDS SSCPs to be misaligned
between different HDMI lanes when using YCbCr420 10-bit pixel format.

BIOS functions for transmitter/encoder control take pixel clock in kHz
increments, whereas the function for setting the pixel clock is in 100Hz
increments. Setting pixel clock to a value that is not on a kHz boundary
will cause the issue.

[How]
Round pixel clock down to nearest kHz in 10/12-bpc cases.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 213de8cabfad..165392380842 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -543,9 +543,11 @@ static void dce112_get_pix_clk_dividers_helper (
 		switch (pix_clk_params->color_depth) {
 		case COLOR_DEPTH_101010:
 			actual_pixel_clock_100hz = (actual_pixel_clock_100hz * 5) >> 2;
+			actual_pixel_clock_100hz -= actual_pixel_clock_100hz % 10;
 			break;
 		case COLOR_DEPTH_121212:
 			actual_pixel_clock_100hz = (actual_pixel_clock_100hz * 6) >> 2;
+			actual_pixel_clock_100hz -= actual_pixel_clock_100hz % 10;
 			break;
 		case COLOR_DEPTH_161616:
 			actual_pixel_clock_100hz = actual_pixel_clock_100hz * 2;
-- 
2.25.1

