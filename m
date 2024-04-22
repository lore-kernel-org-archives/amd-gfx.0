Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51AEC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 352D4112C04;
	Mon, 22 Apr 2024 15:31:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BfXhmYQI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D581B112C04
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:31:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS2OFuHTf2zX1wqWgzQLA0ZA/RMEs+NZdkH9Ffb0jRW44O1B6E/hD83woR5xV08GCgwzjdMYumRa6oKvWL37oTPAiuKE8i7+SVMxsVT4TNqn767zZIp47ECCw3xBafhu+u2buEiUcAxbarh+BzVx+VeatVwEgvn+i9E19TDpDsQrvwxsT4N7Vd503fow33OqG8kuAk3l99EJrrKF+iPs7YnoVm4K+KsdSqU17NSDKgDLBN3kv4MpVVQvVlynUkubG/AJTZGApmKPmgMXNsOt7GuOifAHoztVc7I20d864zn5XAuZYjhFQYWSEACZEqB0dZVwfD4EgAw7vk42ozNboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfvPpGyJg2qOZkcBiip0xmVFRr3Cp1aHYCtxntzF6zc=;
 b=hNRLz6OESsGUsafg/VofNWe8y+ag5xlb89NOU6stxiZCO4F+vusJTjjPJR3rKSn40ANeL1fUz1CU59MJna1Xv1Ec32SgDq1e4dTke0YNRF+r4Yodv3BAlF+juW5YwjQpNLJ0BM1OJuju4q8o9c1usXt/WVI6oMJDLu0AUcZXmVuUH8CgacENCPZwDVD7UIG/zlaqVvLPXLBhV3qNrGi7ITXZWd0kdPyi0EnPABhdyinXaMLA06MdZ3i6O75MqdrdCxTb9khnNqkj4irDsmMfdpnn9O8PdY9dfIXdZJ0OZmdOCYcrK6iQ9q5mb8joE78E0Vo3rXlatk4ceu0VZK4mUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfvPpGyJg2qOZkcBiip0xmVFRr3Cp1aHYCtxntzF6zc=;
 b=BfXhmYQIoVq1QOUfF+uuCk3e/tOOHYaOnpNLoWwAWUlbsYIbIcycT4lW2ugSYLiYkYlCh1w6ahq0oi+dtU9UPP54nYJ0s3LayNwnSdgZmsktBwQ99S3fJ6Z8pU5iiD0Jz7fd29OdorJS8Hx1MCrDRy5GSpyoowuaSyCcGI6RI1o=
Received: from CH0PR03CA0352.namprd03.prod.outlook.com (2603:10b6:610:11a::21)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:31:21 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::f3) by CH0PR03CA0352.outlook.office365.com
 (2603:10b6:610:11a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 15:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:31:21 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:31:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:31:19 -0700
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:31:09 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel
 Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 30/37] drm/amd/display: Set cursor attributes before position
Date: Mon, 22 Apr 2024 11:27:39 -0400
Message-ID: <20240422152817.2765349-31-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 273fde6b-115e-46c4-7da1-08dc62e14300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U2yyXoK9ZTOdrfnnK5N5PfGMNg68o9YF6q/8rAT8XgTQ59Wdu885SaJYqIjP?=
 =?us-ascii?Q?jo4CNK5B8QWFIMQ4dqaY9NiKigGNpJnjRnz4DC15gTo/v5xl5wrvj1Di5Z6B?=
 =?us-ascii?Q?oOqXXEceveX9YdZq/DWIltjT03ondD9s3OlxwrekNPsAJR9JrLiZgr0MZqJC?=
 =?us-ascii?Q?o2x9CwAGSohChYAM52d/j9KTiuKzjGHPn1FBsP97Uv31IwzdN1NjOchi2m2G?=
 =?us-ascii?Q?y8pIdx//UQek78qZXsWk+6us3WMQKdeBaw52OgzAtkFCYyBoGAtbaKnYNySY?=
 =?us-ascii?Q?sulqrbAmhoa9p+WHTSEQvWos1wDiUc8xc8glTsVhCuGkz024bdmu6ol96MKe?=
 =?us-ascii?Q?DvDigLgmDEDIlyqOz36kmQczMS/J+VaVixr+6VhcTQEtkfEuQssBs6r509GM?=
 =?us-ascii?Q?tZlZuiq4zIvDAPWmq+RU+/sI/3D7vRn+XuhJxTUNGLkCIsSrKHyNVeTnkUSt?=
 =?us-ascii?Q?7uUp8OfbMxrXM75F5DHf7MmM/NW72qNOlm1pNNx0LKan55y6Q90w1GIP+mSf?=
 =?us-ascii?Q?j338kGBNeVZq4I1zAsHJsxiKR8baqEdZTrq5sAK1h5bu08J5LxwIXu4zjvj+?=
 =?us-ascii?Q?3DlJgauZ3WkkEpI6lWnN3v43USlqXc5tTU5U896M2IyFF9j5B5Z4fPGuYRGu?=
 =?us-ascii?Q?WTXP3C8pl7lwJyNLVrQq8H7J1lg0SkTBFhOGKnqHPAaz2U8Q7N550NfriyVD?=
 =?us-ascii?Q?t3xVqI94Vc/nN3TtAft3kJaRjk0FM5TveOdrEnFi02snvhxgxNfyaGu3KHty?=
 =?us-ascii?Q?7d0ziF67GVgCowMRe5mPHkF2mFvU5fB2QjKNCZxElbL34BEeHahBwxjX+yxz?=
 =?us-ascii?Q?gdDEmUeye1R5qohofhqVJ2+CSDllkssDgYXsRCc8Kr+Cwt8Oo5n2b8TucABI?=
 =?us-ascii?Q?fhbCSJGTdjRsqRb52ckp6752ZJCfxzr6Ki5rwn61h5ddKrFtq9dmauu59dFl?=
 =?us-ascii?Q?eHuN6j1vqDM0ZxeDmFHWNbghcaRPwMpl9K/Dfd7FIl8759rIp/dDH9o5gETu?=
 =?us-ascii?Q?bODGmuI6ly9iMEzHR1GUwzCBn0pRBSq+PNZmS1l/81oyZ9J5fFFRe5/+2i4o?=
 =?us-ascii?Q?SqxxC3lGwQ397FrUVloXzObMBO3mIGsViipDNXUB7ymLIZ/fiiXQHGvDLBsq?=
 =?us-ascii?Q?cwjFuOQIhkmGQpwtD+bopXXnQftcG7E3svsTLhCWRXXfCRVprpAUg4SvRihC?=
 =?us-ascii?Q?weJOGgU5FruSez0X9Zz/aZafz529f6/ay/W0KRqgy/i6xCRPrPm8vMmMwxZ0?=
 =?us-ascii?Q?3n/5rTR6u/KpEDPHkhjuGaHYVdcG/ajyTDGOgmWRg8ymUsND8tRrgOp9uOZa?=
 =?us-ascii?Q?Tf5kmbxtcRx3hVnJS0GAuDXpR57arpDOyLFgCNwbGlKPQU0PapavrdIegolH?=
 =?us-ascii?Q?AP4VXs1f3pflYkcA4CpFMRoDbI3o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:31:21.0412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 273fde6b-115e-46c4-7da1-08dc62e14300
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

HWSS set_cursor_attributes copies the stream's cursor attributes
to the hubp cursor attributes. set_cursor_position might attempt
to program the cursor attributes but will program them wrong if
they're not set correctly. We need to call HWSS set_cursor_attributes
first to ensure hubp has the right attributes to be programmed.

Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 36f7b19c01ca..469f4a52f4f5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2886,8 +2886,8 @@ static void dcn10_update_dchubp_dpp(
 	}
 
 	if (pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
-		dc->hwss.set_cursor_position(pipe_ctx);
 		dc->hwss.set_cursor_attribute(pipe_ctx);
+		dc->hwss.set_cursor_position(pipe_ctx);
 
 		if (dc->hwss.set_cursor_sdr_white_level)
 			dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index b60ba2a110f7..26b19de687cc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1765,8 +1765,8 @@ static void dcn20_update_dchubp_dpp(
 	if ((pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed ||
 			pipe_ctx->update_flags.bits.scaler || viewport_changed == true) &&
 			pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
-		dc->hwss.set_cursor_position(pipe_ctx);
 		dc->hwss.set_cursor_attribute(pipe_ctx);
+		dc->hwss.set_cursor_position(pipe_ctx);
 
 		if (dc->hwss.set_cursor_sdr_white_level)
 			dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
-- 
2.44.0

