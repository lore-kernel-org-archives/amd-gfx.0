Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672E8C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 21:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C077110E562;
	Fri, 13 May 2022 21:17:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD9810E562
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 21:17:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOTtVUGVdQSKXKLegxvq2LE6ga1YFgJz8XJwGXyAwCdeahptCwHpg80xByJVWFYJERvvyJlMlMD2fqH49yt7SfxoCqvKQocOzUw4Ubw8MMDR3tSQC+IvqAnZRtZ02UD+YiZCc0WPtKKnyUGru6mD+1R/I8HxzJX3GD52zgLodGo0QHHry8VOeifonzsn23Js2Kj3JKxd+6RFF3f+K/94A2RbMt0PVrw1ePuVvL+O4xG25I9xr+tWvW6tuGzMCdgfIMOkJYbi+3niH+aN/Go0NRWPNHs6G6DeRkGJI4e9qZKkmGHHFf05q45o4/6AFM+d5hbYamxwn+i4bwep+XEzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7M+bFN68Vm9HIdCODdCAs7UKGi4Z0PYK0mfHIJ7yBk=;
 b=BiI8DUf2hoFW628zUrsk6fdObuzcHFnapQMQ8Ob8Hv2jGzXhmICUSjaCStyQbNRcYxDGMS/J7+NS6xmZnc4MdSWxXwiWaPaXDbWb4GqV6xEBeZryvRRFG6p6qFsx0lK9iNU7KRBGqWhXlYDxjbjZZnfWch8TEPPsg6CPqeuwVN2t0skR2PqiBlDL8YGZhDFwTUw8l5vchPOh7TZqIIp5kFaYGHE9qPTUz9QJvGfjeD8p9FMWuZ9NiOqLEMLzag43txviR0a729RV7XvxLpsekN8m5keSbdWhyH93SJw0e8J2Qesje3bMKgKDnaySuM+KPnAACIIXuMLbFAGN8R8wYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7M+bFN68Vm9HIdCODdCAs7UKGi4Z0PYK0mfHIJ7yBk=;
 b=eh/uZquR94uVhqEW9QJ/UVBbcznK6JaA2sCwqilFc62BCFB/zusSTp9k9XxwtL+nrJSppxCMV8KedsKW+lHITIOZdDtV+315/d2xU3DRv+URJK9O0qwTvi14BLL3wrn/WOq3X+YLcxs7NyE99TPNptbg6mKbwZWlICLEbOa7KkA=
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by DM5PR12MB2535.namprd12.prod.outlook.com (2603:10b6:4:b5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 13 May
 2022 21:17:26 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::37) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Fri, 13 May 2022 21:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 21:17:26 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 16:17:23 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 07/11] drm/amd/display: Check zero planes for OTG disable
 W/A on clock change
Date: Fri, 13 May 2022 17:16:47 -0400
Message-ID: <20220513211651.1312846-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
References: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 988e409e-f299-4efe-4384-08da3525fab8
X-MS-TrafficTypeDiagnostic: DM5PR12MB2535:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2535222FA7482E0BBF3D2C05FBCA9@DM5PR12MB2535.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7huQBu4DL+WxAXgTinCjJ7lAj48xyVUTlKGfNwD3IDDX6Gf0aHgb9QIUZqwrLF9WrWREq+PSZfbcbs1f/6yhUpmx/hYosHR9jNj8AJVS3y1OxqFr7OzVz0mUI57KiP8jgOCt7wG0RK/I6+l+JLzm05fmSC3BouqlTReEyBD/PHXrsf3yiz1b/hZOVOz/TJmtVncq7p7YcAWyZ+QNcBKeXXkDEippxq6pUuDXbQ7+4F/m0/QYZ/s4FRUy55G0kG06Y18yNqjDvIJxdRIQvqglJCwEhpxf/EhkEr6blNAawsu0QL/Vo4NdGiWGAheXw4JygK+PEd626s4HjWxgk0DOM/iDtMSj9zT4xnSUfsVhRkbHOhSVtRNWEM24rJHs4T/I8uaHEVloyoT8P8jcZWVbi3JwYHCK7/nj11xp/4w1WkxUtMbzk+YGKHhdYaobGs60ZM1gkZ0tq21cfSw1kAyVohSXkizwcApW4uypfTTGWUOvpFoHZWoGcpiCy0VkyvYrMEitUbx71wkEJkdgIcVnXFmTEZAjS4X3a3h5V9iRlNoJmUu+Xw5JRoiY8B6NdLzYk1G/5Qi46vax9gdxa6nejbDdUarwldAlVNl1A4Lsx+WvXrq05wobRu2q1otm17842K7yNlJv5Ij5UfP/iTIYp/7iT/+ARsmo+zuxu7tvDUn99bKTN7tKlr+T/gAd+cHMWhILljQPxTT7feBdjhGV6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(1076003)(2616005)(2906002)(26005)(316002)(6666004)(83380400001)(47076005)(186003)(54906003)(426003)(6916009)(336012)(16526019)(86362001)(40460700003)(81166007)(5660300002)(44832011)(36860700001)(36756003)(508600001)(356005)(70586007)(70206006)(8676002)(82310400005)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 21:17:26.0913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 988e409e-f299-4efe-4384-08da3525fab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2535
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

