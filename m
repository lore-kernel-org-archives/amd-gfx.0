Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C56EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD73010EE24;
	Fri,  8 Apr 2022 17:26:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB06C10EE21
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhsCiozv4/JONgpBj8gnQ46HJMUo3FDwiYT8HA7tR3Lhf47dvsoco1Yvjyxrc4dv9b6F9BTRtte8s3JqXqpTkQt2cbY2ypXH2h7UuqUOOmaVZIqPssBw6YILMlXnvv7qM5i1Vr+XFPG4TkzCvKssQ/NaVpitb21U2eu7jj8kJEqrNnoIFSTGa17b8CHKPk6JQYLKom6T9nsk09zU11HgZAglGW1R0me/SlQEg4/ff/qBe+/CntFnyEcS269UAYbbCuYvEJsNv3EYPK3ORE4j8X/N8im1yyFiKHJz4CI1kmvjk53kS/j2xbi8R+VoWZdXV8PTXQaoZ670izRRGEEi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VumjKf1sY00vWDCvesfgBUVYAAYgR6VilaO5cJJy6PI=;
 b=GXcU42N9d+rBj8KL5OVu9xeZeWtdhljJUcemCIS2GeYbqsJMaA0ongardq05Jnd82UkxGPMsPl5XKWiQy4Kn10GuhIlrGuclr7+ZMaWaTSzWrGLwDThk/vJZnkMWKBAFzACz41ERYK2YXiCJHvLK2Q6meMxqJkyYCZJ0gFimatEWT7Sd2aKpQZWJVZuH6ydUa5tCCNlZAizesFlcDpr+uPMXlGTYFrnW1Fl0E1COC+qn2h6kIJi72VsjMfBK7FV+/zI0JGqCxHadZ5rcTxAhI5hthfhXkegNwAl9bVJKuBPXM7OSo71+Fm2dBszPTwEdxQlyQZAly8J9Xx65rjGmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VumjKf1sY00vWDCvesfgBUVYAAYgR6VilaO5cJJy6PI=;
 b=k2zGcGlpwe9KK/oBh2s2pQ1GSKqLyweP9VpII0zab2J84uNFIXw8CHsj/sx8Yygx633+iCZLYt3t8iXZVXcxB+wWKnaFde0JwPg86n5ku+mglOgCMLGtxuTVBeLkcb8zeTVWvTvXga3H0W7gq62wPmxkW13FQwOzIxc10cf9YeI=
Received: from DM6PR07CA0042.namprd07.prod.outlook.com (2603:10b6:5:74::19) by
 BL0PR12MB2434.namprd12.prod.outlook.com (2603:10b6:207:4d::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.25; Fri, 8 Apr 2022 17:26:18 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::d4) by DM6PR07CA0042.outlook.office365.com
 (2603:10b6:5:74::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25 via Frontend
 Transport; Fri, 8 Apr 2022 17:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:26:18 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:26:17 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/20] drm/amd/display: do not wait for mpc idle if tg is
 disabled
Date: Fri, 8 Apr 2022 13:18:53 -0400
Message-ID: <20220408171911.601615-3-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ba9942e-68bb-4120-a3ed-08da1984e486
X-MS-TrafficTypeDiagnostic: BL0PR12MB2434:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB24342E4E6F9D861BB163199DFCE99@BL0PR12MB2434.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBoWgmc6hKvtQe0sxdGEbMEzToYXGKDDhLYUkhnVpvWf9wcQvCgwDpil/69TcJQaXuD9grcOAQ+MXjaJsOWm/bwkSGEiEcgUjLJfnGs9fx4Fpukb6jZHsSTknT83jGlSSYaj7bbsO0NOzAOU4wGA8QLoQPC1uTqkoxb0EEhWOMw2w2RPLSB+eQ7HHXbgMZuXLYqdS4hWj1EYPhdmcsqxRZXHEW35peLyIk5C7X4gdb9xGI3pxKWtjYaQolEYXX7wILk5KpYjKJnaK47W7eI/JX/PALol125niPV301yAPgQgzKLDmRUNqQPNkZk1/nh+giNpBzPxnuvE4I2ROMHOYsCaH/X1eKUd1y2MoK8HJJtcltlJSx1N31uNNSDl7O2UjkrCw91dJj+EAwmedj8a8Ggx6Ykiu2X8TLm3B4dC6ejOXhACV93eh5toFAGNry9wShfco8q/hQRsP1al6AXY1qh8orcYb1h/ziaEg3AxXMrNhSGiAfGix3CQYUbqozvzNbtvY2/16zE3f2JNGR38O2vkl84MOPKMP1+4B7/whyQ/7Y4eLeT2dmOqsGZVFpVFoBVDFnZGt5PnU5DvdVYzLOwGFvC3b7VKyp56IUHksBs8me9EF+byh984C62t60wbF1cmc14X00xGAWgVzmhRcEAkoj7LM68ErM2IvYoCISN6Q7qLjFMrkvVBZeK76EbB+HxIW0h7x2hA1CXP11W6bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70206006)(6666004)(70586007)(47076005)(36756003)(82310400005)(4326008)(8676002)(36860700001)(83380400001)(356005)(86362001)(8936002)(40460700003)(6916009)(81166007)(54906003)(316002)(2906002)(5660300002)(336012)(426003)(26005)(16526019)(186003)(7696005)(1076003)(508600001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:26:18.5659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba9942e-68bb-4120-a3ed-08da1984e486
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2434
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
When booting, the driver waits for the MPC idle bit to be set as part of
pipe initialization. However, on some systems this occurs before OTG is
enabled, and since the MPC idle bit won't be set until the vupdate
signal occurs (which requires OTG to be enabled), this never happens and
the wait times out. This can add hundreds of milliseconds to the boot
time.

[How]
Do not wait for mpc idle if tg is disabled

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 50820e79d3c4..2d3d870f0bea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3185,7 +3185,8 @@ void dcn10_wait_for_mpcc_disconnect(
 		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst]) {
 			struct hubp *hubp = get_hubp_by_inst(res_pool, mpcc_inst);
 
-			res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
+			if (pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg))
+				res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
 			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] = false;
 			hubp->funcs->set_blank(hubp, true);
 		}
-- 
2.32.0

