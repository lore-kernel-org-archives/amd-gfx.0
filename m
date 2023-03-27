Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817A4C761A6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 23:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CC4710E7B4;
	Mon, 27 Mar 2023 23:35:22 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F7C810E7B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 23:35:20 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id l18so7675148oic.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 16:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1679960120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIwazwlkbXfr/mhs4ygPSCHkxMgXqhz2v9oIbK7e01k=;
 b=TTy7nMwv8iMo9KYVcMt30TmODMyElVifkej9lEeLYbHgK0TUC3YmQlbcg+Xo46YJmz
 PYiDPL6xk4c/s7E6SmIBKoazamO9F5A6s5w8jMtY+oTyZhW3eEnO100xmx22j7SDJZtP
 6VsCIUno/jksYrlZ4XP3qSFj9Rm6alVqr8qpzlU9CFbwS4sL9mfnoIPXpCJolwmgjbec
 FqTmiiFznHEg0Ddqp6e4A3sJMsba+tXsBaNtiwGKtPEAF0nk1OARrZNSGtGNt0fS4gbn
 9S1YXKcidghXj5K610oyihoMZCyGAk9I/eY8AXEE+1iuCHHW2VWqcqvzcS54KAC10+rI
 MiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679960120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIwazwlkbXfr/mhs4ygPSCHkxMgXqhz2v9oIbK7e01k=;
 b=ggQKuIFg7oLyUwFMSm91ApUxMUODTL1bxnzYf5FcRqSQB+m9Jt1ql8XrgbIHhtiWh1
 O4cBNKqf9QflnFo1z1KtGpS3LsQQ/yGPU/lZ8/uywJKkSeHTmTejixSe7afIQtV0WpQB
 5Q1YPuRmDW1N+ZfEZ+SUjUeskfTBy6E98ck53OTA1T6iFD4FrpuLBdMxSHkhoIhm3Hut
 XKps5yYOkwLs91tC56PxzqjwOp5VXoyv6MfqZZkt/AjdfhE6ueaN2evQ40nK2+J48+Bg
 tc61P1TKQody74Bh8Wti79ozB4AjCzC3KTcDPd1ESUWbsMG9ze+7s/chQUmDSPAH8U1h
 jU0g==
X-Gm-Message-State: AAQBX9fRq3PA8a6o2ZG7FnIOhqo7gcpa9Ux5uRwtTKRgwrxFjWnNNVRG
 eSaocdAc4jDocbJtLGjojTSBvcQ22f8o2wpK7xY2hQ==
X-Google-Smtp-Source: AKy350aybt0Fe2KHw7h4hdkKAaCWXQkSMi8faLZ2/V9VaQBsYk7eWBNPEMr15jlKWRpkhkGERzjJYw==
X-Received: by 2002:a05:6808:21a0:b0:388:edc5:3373 with SMTP id
 be32-20020a05680821a000b00388edc53373mr5891957oib.14.1679960119763; 
 Mon, 27 Mar 2023 16:35:19 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
 by smtp.gmail.com with ESMTPSA id
 b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 16:35:19 -0700 (PDT)
From: Caio Novais <caionovais@usp.br>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] drm/amd/display: Remove unused variable 'optc'
Date: Mon, 27 Mar 2023 20:33:48 -0300
Message-Id: <20230327233353.64081-8-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: In function ‘dcn30_enable_writeback’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:326:34: warning: variable ‘optc’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 3b4d4d68359b..6ef85e71380c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -323,13 +323,10 @@ void dcn30_enable_writeback(
 {
 	struct dwbc *dwb;
 	struct mcif_wb *mcif_wb;
-	struct timing_generator *optc;
 
 	dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
 	mcif_wb = dc->res_pool->mcif_wb[wb_info->dwb_pipe_inst];
 
-	/* set the OPTC source mux */
-	optc = dc->res_pool->timing_generators[dwb->otg_inst];
 	DC_LOG_DWB("%s dwb_pipe_inst = %d, mpcc_inst = %d",\
 		__func__, wb_info->dwb_pipe_inst,\
 		wb_info->mpcc_inst);
-- 
2.40.0

