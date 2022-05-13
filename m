Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DD3C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 20:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0F410E98E;
	Fri, 13 May 2022 20:51:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E25010E955
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 20:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmDHgZnZYrqz44tpjNX5/BEqxXx5Hq35/7imz7AX06esb6aJrnQtX3kV5a7/VnzXvh4Yx6d7OZjDwu3OEQut/OAs5ZVpWghfgecxNobkEYJiX5+6+CZXsreMjg9EwEbB9K3lLh/47lVDb4EPRVHYsu/xHx+PpIRHHEghp9yCHdsBr5ebTt0dIWUNTJs56JCfND/eWL9Ar75y4T4X/YuUNKBlNh3cQun2VbDlUJ9AAFio+p1ov4KbBhEgC+kqJ3aJyyriXAjkJAG1wqqLvJwdczUwn8C/gYRLls5sq8ltcszXxAcE8K+URDEerjGJz8QH8jVqgju4aQmxPC7Ohtovqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7M+bFN68Vm9HIdCODdCAs7UKGi4Z0PYK0mfHIJ7yBk=;
 b=Nwy9qfqy8kHkrdWqUd4ZX7+r9DF7wK0ZEb7Y7pBM92/ewFATEd06zC3JR0me+SW/XuErYM1iDDUxKV5mqbP8R8UCWRe/b0D70HzLWy1qez7J0CXdTMnLe9T/iumOEQG9veBiNmeCju04XHAhzTfVMpFhfkDZgFeAc3TFblOZNSqOz5iyvweR8ppwKmiKvuOjtk4N7oswYdPHmyafT2CdC7YOHbgr3PH4ol741wAJV1kel9XAnPf6oEnNVdotON16hLgZU5Ra0E08zSnfLXaoZX3FhSu1BEiN916VWYsKF9yUYqq90IDIF0k4o0vUkII6Rfu5AnqHsRSD6PX0/P9IdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7M+bFN68Vm9HIdCODdCAs7UKGi4Z0PYK0mfHIJ7yBk=;
 b=YQ3q6vMqny+1H5YRembSsoI2G2kPA9JjE4lzVmYVSZTGNWSyQBi1RHUkeIlQAPmF3MKBz6988iDA7Ho4gwWxuEpypTHRWsX2glsOB/hoPvlV6XLzpp8zCZ4HfxSwCOUttuTWG0XFlUflh5o/ihO51oqc04yMX+O8XIbUuMuQ04A=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by DM6PR12MB3836.namprd12.prod.outlook.com (2603:10b6:5:1c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 20:51:31 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::d7) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15 via Frontend
 Transport; Fri, 13 May 2022 20:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 20:51:31 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 15:51:29 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/11] drm/amd/display: Check zero planes for OTG disable W/A
 on clock change
Date: Fri, 13 May 2022 16:50:37 -0400
Message-ID: <20220513205041.1311639-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
References: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 403946dd-ae50-4e04-6ed5-08da35225be4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3836:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB383640766FFBEF29B649E232FBCA9@DM6PR12MB3836.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhEUths2Th4yJJVkjZ6zGNwYPIA5Iq1xshb8XmK1cB4hUwJ7GQFy0OS3uMKq1cx39lcDyjTGrc21ECsSUl7gz1K3JhtLDvQ/rBXY4U9nYK/onpNLMBkY8s3h0xxsNKGx/bMedZRG18nrxsY1WVIFrVDH5uyFZN7BsyhcFfIzfFa08/uibOAf/2R+2ZU4xqPn2MEND5/yxqItatRNzF9pBPtcOK+aeqD8x5nY7LKQDDTnEj82aMk2oAEspXzdGyxdue4MVPG9MEye5j578BYyvQEHdy3cZRxeSna6WT8N4tIOnXA65NwNk9/ZqLl0eeqhmMRsmmrFcXJdGiD3UvwgrnyU8CJp2Yg2VQo+Lc8IfWI6j8msd5Zr9AlINr9vP7H0D+8m/cs7nAYiHmPXe8AcOqK5Za1OrJJgvRIp5mjhaI/X97rOUrz22x9FPoH4lqrjHspp99PEaQ9BesRBqnB98QshS08hqyV3BsuwQjJwymsyuNMyxYQNlWKEzqFmQoqeMSiu8eJhbWwnIxo83vjEcHUEfOPLwEetWOwik2JOoIsmdkrZqo8YIWGuQ9fQhQM6Tq+GNYFnB4vovCVGpgefJ3egVgygEnUDr0UdRf2Yia3LjalkCDGyK8/OdnCxjq4J1B1oCr1x5XyDjKhnEeM5zWow916SjF6Sxv5BaEC4QB+bsRJyBTVrPvgRoX6kMnom+i087loKM+sPstfyNZMPLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(16526019)(316002)(36756003)(2616005)(2906002)(186003)(40460700003)(6666004)(356005)(54906003)(82310400005)(36860700001)(6916009)(8676002)(4326008)(336012)(70206006)(426003)(70586007)(44832011)(47076005)(26005)(5660300002)(86362001)(508600001)(8936002)(83380400001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 20:51:31.1329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 403946dd-ae50-4e04-6ed5-08da35225be4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3836
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
A display clock change hang can occur when switching between DIO and HPO
enabled modes during the optimize_bandwidth in dc_commit_state_no_check
call.

This happens when going from 4k120 8bpc 420 to 4k144 10bpc 444.

Display clock in the DIO case is 1200MHz, but pixel rate is 600MHz
because the pixel format is 420.

Display clock in the HPO case is less (800MHz?) because of ODM combine
which results in a smaller divider.

The DIO is still active in prepare but not active in the optimize which
results in the hang occuring.

During this change there are no planes on the stream so it's safe to
apply the workaround, but dpms_off = false and signal type is not
virtual.

[How]
Check for plane_count == 0, no planes on the stream.

It's easiest to check pipe->plane_state == NULL as an equivalent check
rather than trying to search for the stream status in the context
associated with the stream, so let's do that.

The primary, non MPO pipe should not have a NULL plane state.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 27501b735a9c..a2ade6e93f5e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -91,7 +91,8 @@ static void dcn315_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
-		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
+		if (pipe->stream && (pipe->stream->dpms_off || pipe->plane_state == NULL ||
+				     dc_is_virtual_signal(pipe->stream->signal))) {
 			if (disable)
 				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
 			else
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 3121dd2d2a91..fc3af81ed6c6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -122,7 +122,8 @@ static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
-		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
+		if (pipe->stream && (pipe->stream->dpms_off || pipe->plane_state == NULL ||
+				     dc_is_virtual_signal(pipe->stream->signal))) {
 			if (disable)
 				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
 			else
-- 
2.25.1

