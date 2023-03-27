Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4612FC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 23:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCFDF10E7CD;
	Mon, 27 Mar 2023 23:35:51 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 828EB10E7CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 23:35:50 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id bi31so7683899oib.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 16:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1679960150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1xhDxA3uWDRifG4IvLBAoRIIiYm0r4QC9LLNbKp2X8=;
 b=hvoaJX2ufI+udaK8mtxiLI21DzeH7JurXG/B43jOARKu83aSms5p/jUB7lwFs6omfL
 C3MvJEbwKrp4+zN7nS9bwwLJRstOf0GeeBnUjX0wuSPeyXQ2hqrkBQek1SQGMIiX+KCX
 /4ZPrhOgZvJ0MEOfcTm3nKfKoZUGeUiv8O33K6TquSH+CmZVXyqzo50twDCInP4i9q9l
 LtUwMM4WfNHC2cmc/CLIiaJJAaok/ssG3j/4jAMDz7SP/mcITFs8jlPilmDmUbIu1rpa
 S8HtZoIjJX3ZkBhEtr41i+hLJVS4ef1KC5FtF535WpCQQdngJk+XZwGB3Wp0bFrZvPsJ
 rcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679960150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1xhDxA3uWDRifG4IvLBAoRIIiYm0r4QC9LLNbKp2X8=;
 b=X1j75KgE9pLHgQH5nzCJSKx9XxGSntl6tayRZaQWkPpOa6xZcUgUImyqw3TkvcCzyT
 mZAxM9sQo3g0HGlsLKoKi6l6bRM1lN4Kz+2qp5EcO9EygIrqf/e56/CZ+z1ntgTCYpl5
 mHdT40ZkV4svuGY7vQj+Yrbm1UK0KVvmejePnlh0e82k86fOY99vM0EzcWapT8zO1ytQ
 vGTNBJhH2o7e1ySBLDBWEmEJ1Y0E0ZPGZFGdFYomVs8YBsAr6lTgFARks5fhFMtST584
 58PtZm/76DJcJDPRXwB5B0Fqejw4HXI1U9I2sK4PMRXHJS5LoD6dDNmmF5gtPH5ufUBe
 2bIQ==
X-Gm-Message-State: AO0yUKUE5ReiHOh70TAb5fQJfPASC7/w5ff/zhX4dZiU+GctApJPTzZy
 tmIp9M/GajGF33NZLa7MQAfWH2bmAjz/Bkrv02fauQ==
X-Google-Smtp-Source: AK7set8NiGmgJV8HERS4O1DEMBfqAEeV4IytdUJ48dLagBB0+Hq6qQQfvpgB8IkKbofF5pTimWiQAg==
X-Received: by 2002:aca:6507:0:b0:387:3239:61fa with SMTP id
 m7-20020aca6507000000b00387323961famr5553985oim.30.1679960149872; 
 Mon, 27 Mar 2023 16:35:49 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
 by smtp.gmail.com with ESMTPSA id
 b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 16:35:49 -0700 (PDT)
From: Caio Novais <caionovais@usp.br>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] drm/amd/display: Remove unused variable 'cursor_bpp'
Date: Mon, 27 Mar 2023 20:33:51 -0300
Message-Id: <20230327233353.64081-11-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327233353.64081-1-caionovais@usp.br>
References: <20230327233353.64081-1-caionovais@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
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
Cc: Felipe Clark <felipe.clark@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Mario Limonciello <mario.limonciello@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 David Airlie <airlied@gmail.com>, Charlene Liu <Charlene.Liu@amd.com>,
 Gabe Teeger <gabe.teeger@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Taimur Hassan <Syed.Hassan@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 George Shen <George.Shen@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Chaitanya Dhere <chaitanya.dhere@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Alan Liu <HaoPing.Liu@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Jingwen Zhu <Jingwen.Zhu@amd.com>, Guo Zhengkui <guozhengkui@vivo.com>,
 Leo Li <sunpeng.li@amd.com>, Melissa Wen <mwen@igalia.com>,
 Le Ma <le.ma@amd.com>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Caio Novais <caionovais@usp.br>, Martin Leung <Martin.Leung@amd.com>,
 Ryan Lin <tsung-hua.lin@amd.com>, Brian Chang <Brian.Chang@amd.com>,
 Sung Joon Kim <sungjoon.kim@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Dillon Varone <Dillon.Varone@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Zhan Liu <zhan.liu@amd.com>, Roman Li <Roman.Li@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <wayne.lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Joshua Ashton <joshua@froggi.es>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Compiling AMD GPU drivers displays a warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c: In function ‘dcn32_helper_calculate_mall_bytes_for_cursor’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:62:18: warning: variable ‘cursor_bpp’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 3a2d7bcc4b6d..a616cf078cf4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -59,25 +59,21 @@ uint32_t dcn32_helper_calculate_mall_bytes_for_cursor(
 {
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	uint32_t cursor_size = hubp->curs_attr.pitch * hubp->curs_attr.height;
-	uint32_t cursor_bpp = 4;
 	uint32_t cursor_mall_size_bytes = 0;
 
 	switch (pipe_ctx->stream->cursor_attributes.color_format) {
 	case CURSOR_MODE_MONO:
 		cursor_size /= 2;
-		cursor_bpp = 4;
 		break;
 	case CURSOR_MODE_COLOR_1BIT_AND:
 	case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
 	case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
 		cursor_size *= 4;
-		cursor_bpp = 4;
 		break;
 
 	case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
 	case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
 		cursor_size *= 8;
-		cursor_bpp = 8;
 		break;
 	}
 
-- 
2.40.0

