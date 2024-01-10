Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10738C47073
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD5210E7A5;
	Wed, 10 Jan 2024 21:55:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E1010E7A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:55:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTN6u0wSyXBrGEW6uwCAgCNN5aX109saFZPlGFsd5e0ne6kvIm9bc3oDQrCvEs+s4wxXkzo9/RkkZRRmBKIJ/Api6LNPtezzcEn/83qf++kOAR7dq8edfGGqwfqUz2gdQ2nMdGLcZV7b8/86R6IRLVcSDPM2gykfHPN3kmYIk/hKFwo2p7x0dudC/4WMmO8EjzkUOwoSM3gKOA5MSgBogT4h7C5UWMdCXKEflM5RsMVPlI4K54k5HWTj/mF55SbJAm8NZzKtQarWKp4z0PNViWr4NYiGTi8UKOnN6/QvNkGfn1DSiZ9PYi1u1CTWnKnnkCAx3k7ADV92LJAqMe02tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYLdqgc802PLEi4b64JFICvCy+ogdf1cYAOgjJ7puCo=;
 b=VQQyhgEshxISF+AfwFHW21ztotb7s+Mq6ZajGVCkSFJy44CSP5xZIBJ2Is7jEwLecKPpiP9Rk0ngeNZmyyysZ4a6pMcnk9kj2EMaUPLNOkuIqH6sUECvPCo7AWgT6bNbeDEjc9suBbv6Runu1CX1F1Pq1UvyG3qhbdkAfYrgmvG2OEbF2qD/k8juJOJiSEOdJxyHuDxf2UtPaKA0Vb6eGRMNOcEj8IgmeMMdj3/lC+B4LpeJBOwI577IMYr76vVaw9Y5nY7dEMcmiw55WqtnsdbtJCd1t3EHtbFLA0VJpYF62xsWq0LTluFzmrt2BtT+Id1wNIOgid7mWgAmain4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYLdqgc802PLEi4b64JFICvCy+ogdf1cYAOgjJ7puCo=;
 b=MpUXvHJYAKSQwN6BXJC7yvkM4pGqedMCwTsql+pJTibXxzUSO6/68Be5q8TU4M9Ihif8r33Y9Vcp7eAI2wcz3SQBp6bvzHh0b3bbTXuCLGY4uqbgTQxKGEOsSB1fm5jiPmmW6rIH4/6YgwqPTMYxR+455gutTs6dxX9eeZP/6LQ=
Received: from MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 21:55:46 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::40) by MW4PR03CA0022.outlook.office365.com
 (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 21:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:55:43 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:55:41 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/19] drm/amd/display: Reenable windowed mpo odm support
Date: Wed, 10 Jan 2024 14:52:52 -0700
Message-ID: <20240110215302.2116049-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f27ee94-629e-4ca1-e53e-08dc1226e4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JkFklv+YSSEzBTH3ySi6/7tHWHxgfLsoN4rDaf8p0oQ1kN4U7iS2KEr8S1ap7CqB9Dd3B3rD4uhJfp0xX2pi3YvD8A30/3bbZvs5UL7/1LQva/8cGoLWNC3yohMK37KnuWfdAEVvxSERthAiJLdPrNnYthnK0pf4ZeZbmkMOhWoKBNJzvBorzRIepXYawVnLBk2Quof1CgaogIJy/bQM5i4GU+QwFrfUtGsKb2DreoS0HpbCnxcc3LMLhqO7y6Dswb9qswK20mckQ4YoMp7pDxk13MBKo9z7zFVzy0kSwVwYM4Or++++2SZLhriCEIztCv3tMktcKCBKzFnzn9eCrFmOI1Eo67Lr7LLZcHk+KLBTe0FpzFN1WeyLnimN3NjS1lcyVLnhoRjRlus3xc8OJszkxHAljBbqcD7SDC/8GZDnvMpNg4zB3hEVwdHXUkX30ilCVUSFOapok/l+LuK/3lAtjpZNLbzNIPRJNsRWgt0Sv1c0IOmofBXwMGcWyOjGFbv03FZuxyTwTx6iTXorcuYeGopV2UJpyvkwCZj0fyCayosQFWQIbJqn4Z2Gy80wXNg7E5lV2edhbTl4aWjXK3+10h4CJcmR/sQd3KbgNjGeHRzRNLv77JPsZjo7CGStcp99yXXggN53RE8tpoi1a1hc3pdz/xGQ2+aK7XpC06YvQPJVogv2Xz0W7oDC0P7JY0kbI9k4YJjMrWTe1uQ+TABdZ80wGxg0cuNKxPfMNmVFyqkJLLKoAxeciKNeNchGNGKoha8E89XuX5CoNMA5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(1076003)(2616005)(336012)(26005)(478600001)(426003)(6666004)(7696005)(36860700001)(47076005)(6916009)(83380400001)(2906002)(41300700001)(44832011)(16526019)(70206006)(4326008)(316002)(8936002)(70586007)(8676002)(54906003)(5660300002)(356005)(82740400003)(36756003)(81166007)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:55:43.6624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f27ee94-629e-4ca1-e53e-08dc1226e4e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Martin Leung <martin.leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alex
 Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
The feature was disabled due to regression found during testing. Now
that all the pending issues are addressed, we are reenabling the power
saving feature again.

The feature optimizes dispclk level when user is using MPO capable
broswers or watching MPO capable videos in windowed mode. The feature
achieves power optimization by utilizing free pipes to process incoming
pixels in parallel. So it reduces max dispclk requirements for each
pipe.

Previously ODM power optimization will be disabled when MPO plane is
present due to technical challeges. This is mainly because ODM divides
pixel workload with respect to stream but MPO plane position and size
are arbitrary with respect to stream. The pixel processing workload of
an MPO plane is not guaranteed to be evenly distributed across DCN pipes.
For example if a plane is moved inside single ODM slice, all the
processing for the plane is distributed to the pipe in the current ODM
slice, while the other ODM slices don't need to process this plane. If
the plane is then moved to the middle crosing two ODM slices, each ODM
slice gets half of the workload. This is especially difficult when the
plane itself has a large source rect which can't be processed by single
DCN pipe. In this case we can't enable ODM power optimization when the
plane is only within one ODM slice.

[How]
To overcome the challeges, new pipe resource management is in place to
make sure a plane is validated with ODM power optimization support if
it can be validated regardless of its position and the same pipe
topology can be used regardless of the plane's position. When the plane
is moved outside current ODM slice, we will set recout to 0 so the pipe
can be idling without the need to update pipe topology. When the user
resizes a plane, it may result in downscaling ratio changes. When the
downscaling ratio is above single pipe's threshold, we will seamlessly
exit ODM power optimization and applies MPC combine to support the plane.
when downscaling ratio becomes smaller, we will seamlessly enter ODM
power optimization again. All these pipe transitions happen
automatically and quietly when the conditions are met without any visual
impacts to the user.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index c4d71e7f18af..5c24a769ce60 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2104,6 +2104,7 @@ static bool dcn32_resource_construct(
 	dc->config.use_pipe_ctx_sync_logic = true;
 
 	dc->config.dc_mode_clk_limit_support = true;
+	dc->config.enable_windowed_mpo_odm = true;
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 74412e5f03fe..b356fed1726d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1760,6 +1760,7 @@ static bool dcn321_resource_construct(
 	dc->caps.color.mpc.ocsc = 1;
 
 	dc->config.dc_mode_clk_limit_support = true;
+	dc->config.enable_windowed_mpo_odm = true;
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
-- 
2.34.1

