Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0F2C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C0F10E078;
	Wed,  9 Nov 2022 06:15:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA49110E078
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMWVuj2MDEpbxlsTPZjrMp7YvYLymDhZjAwBH+PFgJ6gH0Hh5r6tXKTX42inYzWeNbFgxosoRvNTzbON8vFPzLMg3SBmBvTfY8eMvCZAmoeId+EWGWOrlOuvKrqEOCaIXeHxbR7OrCMolXU1iMdAdAfSTPf+79tSOfcAOP1jVvG23atNBacJQp4iNZLl/F7ayai1xlObgs4GgQ+65pIGdub9nruGg53CbBno/YySVVTI2Iy9bhAoVo8nnvGcvz1HjEFm0XxI7l7880VjRc5QwgrSpsYdbIbO616Af4wZXsMFzEcokcXkXRgIMQB0koNC06SiiXglqEBa2mojXszGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90QKi2Jx0fOIVKzWx7emhW9h2iPt+cvFWSkzMOGWPoA=;
 b=VH1uJu+yQ7rCEyt05R6GAz0NHeK/zRKKFuBbXGrLvJxoTioF6iianYzWes5w5+Zxpf8/CeqA9dFBSD59v1Z2/XQiMgY4KadpIrXQASScih9pBzUUS3YxcCm3lsMO3Ot+QEfq2SkhgMTjGhjZ5uLdAhl2tmQDi8Pl7wDSaY7sORViU7d1Y3UXwXaFjj5PpjP6nt8g31I6XSyhk6XSDVngMktAvWT9SH68VPN+rtEicDw4WX7LCg9uegdZSYLMwTuPl8xttShdCUfiKDX32k1uRUocaBenarTujklfWl+RoNEi70okMgeb7paUjsh88k+eo3ZhXwiX9CMClsAWkSpl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90QKi2Jx0fOIVKzWx7emhW9h2iPt+cvFWSkzMOGWPoA=;
 b=EjtbYasdYtUFcTIG2TXW1LXcuCnoVu3+IUgZBqjeXurXuCv8456flyk+RO8Be//SRuU1zZKZfUpt71TgtciSAAzi+T3jZB887p51cq8OPrGqIeGiV25f4xhRufMth+yqMA2/9jTocmjjQslFYaC6138cNISacSquU536fyZGp+4=
Received: from BN9PR03CA0520.namprd03.prod.outlook.com (2603:10b6:408:131::15)
 by CH0PR12MB5169.namprd12.prod.outlook.com (2603:10b6:610:b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:15:07 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::2a) by BN9PR03CA0520.outlook.office365.com
 (2603:10b6:408:131::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:15:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:15:04 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:14:59 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/29] drm/amd/display: Update SubVP Visual Confirm
Date: Wed, 9 Nov 2022 14:12:55 +0800
Message-ID: <20221109061319.2870943-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|CH0PR12MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: f6198d77-b6b5-4658-8b94-08dac219bf18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTBKbCehaLjWQ4qXvUkri4cYfZ6ADb0hzJBKkENJLXZhiurdmbCkujbU67gOE5V9Q7Xzle5NGUOhcmofaPygGA31N5dcrHGzHPnJZTJwleV8Jx4mLBkjmYRjTIjWdVPJaGrBAUuxZ3YSLXc5xxdp60bS0oTJ5OzMEutICHXARmraWMGVVgKGNPwAr/drhJ65lRe6WIEqAx829ECtQlli6AXwKrTHmMsLssUP1j5NWY9e412wQ1kzoidz8y286ZrdKY3oYDaC3Vh+F+Vu64ht0f8a8ViowQiU1fFxMUcUPdeVGuUhreGKEYX9o07886kRBJ6I7/xzq7xBLTUtZQikLLoJEA2BNprVJ7jdvhyfTRU42yftAcF5PrmQQ0PPGkHtgBH2srq6L7JOETwhfEzOh8PWjpAULNRvPY50w/HblVemfojhbaTFEGWmRC0GsAHRhbdSLskYJtefYh1NPs5qOQnBhK5x5n97GEkJjqlfdFFKS7bYq2LMgLE8ljB0hYbf0lcHwvIbmQid9+ByiMXOz/fzJI42IPM5dWuQWnSn5R6Pt9geOc4rgNdwaa2EIbAHA+lHaoQUrKF77z3CXWpJQeFhZVHJij/E8q6LTReIE/cGnWtUuh9FX+wZj5qC8vvsUj8dD1dAyuf0fZiFRAapta7vNgPOZlWr7dWO5e399bCFr70K0aIrP3mdTiNGXjopNnaFmTpb9MQEZgOEOi+FjZ0PgXUoGTPQvDfH2j6fCk4WgZu9hCYJxnmFE2wf9lxRXqwTXGvhmJwRCTFh1IMjt2tUWEbfyNS1xb13dbSvuLNYHMr39qpogvWb6jhhvW5/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(86362001)(356005)(82740400003)(81166007)(40480700001)(40460700003)(15650500001)(2906002)(6916009)(26005)(7696005)(426003)(36860700001)(336012)(2616005)(47076005)(186003)(1076003)(83380400001)(6666004)(70586007)(70206006)(54906003)(316002)(478600001)(82310400005)(8676002)(4326008)(8936002)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:15:06.1905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6198d77-b6b5-4658-8b94-08dac219bf18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5169
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
Cc: stylon.wang@amd.com, David Galiffi <David.Galiffi@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[Why]
The visual confirm bar is displayed on all displays, but is only
updated on a flip. If an update causes SubVP to be disabled on
all displays, but there are no updates on the other displays, it
will lead to stale information displayed on the non-active
displays. An example of this is playing a fullscreen video on a
rotated display.

[How]
Add a procedure to update visual confirm color for all pipes when
committing a plane.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: David Galiffi <David.Galiffi@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9f42adc234e3..d90ab1867ed7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3481,6 +3481,24 @@ static void commit_planes_for_stream(struct dc *dc,
 		return;
 	}
 
+	if (update_type != UPDATE_TYPE_FAST) {
+		for (j = 0; j < dc->res_pool->pipe_count; j++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
+
+			if (dc->debug.visual_confirm == VISUAL_CONFIRM_SUBVP &&
+				pipe_ctx->stream && pipe_ctx->plane_state) {
+				/* Only update visual confirm for SUBVP here.
+				 * The bar appears on all pipes, so we need to update the bar on all displays,
+				 * so the information doesn't get stale.
+				 */
+				struct mpcc_blnd_cfg blnd_cfg = { 0 };
+
+				dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color,
+						pipe_ctx->plane_res.hubp->inst);
+			}
+		}
+	}
+
 	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
 		for (i = 0; i < surface_count; i++) {
 			struct dc_plane_state *plane_state = srf_updates[i].surface;
@@ -3598,7 +3616,6 @@ static void commit_planes_for_stream(struct dc *dc,
 					dc->hwss.update_plane_addr(dc, pipe_ctx);
 			}
 		}
-
 	}
 
 	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
-- 
2.25.1

