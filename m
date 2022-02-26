Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF29C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E87410E2BF;
	Sat, 26 Feb 2022 15:42:34 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F150510E2BF
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma+1zoq1+BOd+1zS78IuCoj+Hb4pqp2prwq7X1vVYF+5f89Zyblg2bWL3+ngm5o9l5UNHHcW70xh/QvIpYNjJCnVAYEg4tInYFy8J1WVRJjv08SFzUqgGZUeamy0nv32zESCBwdVPhLJTqnlBu04E7/e5Dj61y+7OF1lHrKT0PY31y6QVGkHQbmjBHMsAUlRY3W7whSwa2OmSfpGU+anWdeSuPGHSx6+UhhFUFZJZW7bMSfWe/oTUaEWf4zYshWJBnbGUgMYffZebXJUhl6yMeXR2BfyjHXfvveFCSdkUsB8g+UlRInKwF6K8QBgrlq9+SClTtS3ZHNXcIVaExquMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+QqAyNOWxNvcbBFyBvCJwG9oLO3jP8OSwQXNRGY/wQ=;
 b=bBEZpC+x4Js48gqKzy+fbyRkikvi7J2fIhlSOXkyv1XLrBVkPwsdulpqvTJXieTVKrKNbSkOfOcRYCZoq5H/96ofGNJAOgMTu7GsjNmeia87n8NppN/358gcateIOsKChdX5P1IR+AWbu52sAIfpINMsXCdplLbqpLqYMEEIClRpLsvZl9gAV3V+/EDziKQu7eEU0hRsu6BQlCoOcW3wBb1dp58czSxDJcOTqzkrVtjyuAQIoL+GHLmu88PbIvcRFWRgOKjHB9XELHfh+c3OKqmyDp816UR6c8WEaHxsZQ0WwaxvSUJFnk1ZJAPUBjcvOg/etg6h+Jytqhtx32R66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+QqAyNOWxNvcbBFyBvCJwG9oLO3jP8OSwQXNRGY/wQ=;
 b=crvJ5GBOpwIWvReFSACt8kMj68QjrFllgqnNZt90W/IZssPj3oUVnhGT7l5GgxWOG/92pMArZlCoZj9PZ06vdBuGfDot0/vWPZGzEyKKMgaOeG1M+I+p0X74l3LMSrHFskbckQrxeTzVWMtAy4M3Up0KcP1gr8QIiKkzfSmI+Ws=
Received: from DM5PR07CA0039.namprd07.prod.outlook.com (2603:10b6:3:16::25) by
 MWHPR12MB1181.namprd12.prod.outlook.com (2603:10b6:300:e::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.26; Sat, 26 Feb 2022 15:42:27 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::59) by DM5PR07CA0039.outlook.office365.com
 (2603:10b6:3:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Sat, 26 Feb 2022 15:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:42:27 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:42:26 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 07:42:26 -0800
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:42:22 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amd/display: refine the EDID override
Date: Sun, 27 Feb 2022 07:41:14 +0800
Message-ID: <20220226234117.3328151-12-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58291322-2560-4c4e-b6c2-08d9f93e9787
X-MS-TrafficTypeDiagnostic: MWHPR12MB1181:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1181E41988FD980E5B049E49F53F9@MWHPR12MB1181.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PvLMaX8EnSZI8PJtcCfgxQZCaFLFQXplfUbBIJ1YQ8NkptQ3BKsFOJkw/0+ElBJBq5Cta6FXsy0yyJjcyrnckc5TWjhVSCaUVNNScgkDBzye49/g8arLpx7tc2zBPCaxVLCBqTdTY7AaAZgM/PHahWtJbEC2R5dIzQcTq3x1o7F4KbFtEUENW0APb+uyZHKIv4wdbxaMfcMlQiGCsMhWV4S7ma5xsTeIkVG/hFj8V+AkHh2xyXj6L/qvf0A5hUbKk6vzHgmFncRoN/ZcGtJfR2SLHMviV8guHqWCculdMGl0T69ZWZe6tSvOODFvEvc6ZAysZB+mdNjzxCMlBX5wpj+bfZNzGae8lXizVm1LusVoU0lAgXYxHXEJOieuRpAPKfNQ14BZ3a84ug22pXCvOje6i1DM4P4dSBFHtE+zanPoLMYJPgTTzJ/MFMAcIAxTcOcougRTOs3URFXzP/hUfWxe8R7eRirSuE1cpXkIDjmuUPtKnSSOiy7fimnZDJzySVav+QA7gDOJhTX4pStD0e8imOacsTzM3gW1QYDJCUG24DMYLtNA+/7KkAK6ELzI3svRzye/ZgqQWrOTGlC5dhiPinOqJp+AjDtUo5mFXajHe4MvaaPPNQk0lYYkzDgSmroBsj8hbaN1ugEjrQ4A2JOxXl3JaSkhrr3xYih9kOBmd66yYVN3/HxhxFwDO7ag2Ce0Cyf6KlXonjJh9QKa9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6916009)(54906003)(426003)(2906002)(508600001)(36860700001)(336012)(1076003)(47076005)(8936002)(2616005)(5660300002)(40460700003)(36756003)(356005)(316002)(7696005)(70586007)(82310400004)(70206006)(8676002)(4326008)(186003)(26005)(6666004)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:42:27.4240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58291322-2560-4c4e-b6c2-08d9f93e9787
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1181
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, jinzh <jinzh@github.amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: jinzh <jinzh@github.amd.com>

[Why]
We already get the SBIOS EDID via ACPI on KMD,
but after that, we just use the monitor EDID to set it HDR caps

[How]
Make the SBIOS EDID override to read_edid()
That can change the read EDID caps from the right EDID

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: jinzh <jinzh@github.amd.com>
---
 drivers/gpu/drm/amd/display/dc/dm_helpers.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index b71b5fb894e2..31109db02e93 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -184,4 +184,7 @@ int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
 		const struct dc_link *link,
 		struct set_config_cmd_payload *payload,
 		enum set_config_status *operation_result);
+
+enum dc_edid_status dm_helpers_get_sbios_edid(struct dc_link *link, struct dc_edid *edid);
+
 #endif /* __DM_HELPERS__ */
-- 
2.25.1

