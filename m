Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEB9C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 23:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C3110E7B7;
	Mon, 27 Mar 2023 23:34:52 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD0D10E7B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 23:34:50 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id l18so7674452oic.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 16:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1679960089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QsHyz7gKUkQwkVhf5pyg1KknFMPIvy4LcmMgDotpCM=;
 b=sx01gakuWa2Q5P6dcI4aIQRwIo9i+t9MKVEV2yp/xxLG+XXh5L4SKodd8Ib0rthkhM
 d229sHbxpl6ezpNSYIuE8NQG3fv4OcWLeqiVpughUBDCD6HoXLYQkjPeeOcHA6UVU8G5
 /J+jdLdjufxFxv955wirCwSmbuLxHyCqXYk0my/ciyXJCElao7c90x1rIa/Yh0yTCp3W
 s7+bZXZt1V3nUO4Bba4bODojyT+ct9iMtEBxRi58GmbNQ7mDBbPk1ey70ybCkLX6rMhK
 2vB49cK9mzSLuo9e7QPRVLEHJHwT0WQ6eKElBGY/NK8HFvBSQE8kDrnuupww2QfLMRTD
 Y6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679960089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QsHyz7gKUkQwkVhf5pyg1KknFMPIvy4LcmMgDotpCM=;
 b=3LCTLVbRnhA5H762E/IULQOw2ZW83mXfKakjzxFspClZoolfUuXMdFlJI5gS4JSSyU
 x5S7egxYar4+5z+wgKsVgntuhDuYZtGKrA4PdoHGYheEX3N4gBvOXSwmeRcG5MWhDCwb
 VYMR1AdY5HLi6ZhB8Qco4uZMkNWASOL5kOfLRlbf2rTFePBr1vElfCneZixD9BFQg/wH
 VE039undG8ivD8g8ooNVDFjK3iKVJJWll2m+AIjbgLDyHVCWNvMFpYaZmBsjUeVXnq49
 obxoRkuctK22i6Cpx2ZSSsXIf7AXx2wkweungO3SZ7ZzC9R/enwYtZzv8o8dYy7rDRkM
 80rA==
X-Gm-Message-State: AAQBX9dWauGMaFJGAhZX83J/v45wSFIMPDgHLqIXb94zrUuoW0HzPYQQ
 mSftWU6UyfXPVZ+GrIBzTzRXrJUYckqNGgFjkFXO3Q==
X-Google-Smtp-Source: AKy350Zf7TAyCj72D7dBxB05x85USmeaRH3Aok5R7Th4M199ri5mIqKovxSmqM4aYnXWp8ALjUMQfA==
X-Received: by 2002:aca:d0f:0:b0:389:f4a:93ec with SMTP id
 15-20020aca0d0f000000b003890f4a93ecmr2974502oin.28.1679960089575; 
 Mon, 27 Mar 2023 16:34:49 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
 by smtp.gmail.com with ESMTPSA id
 b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 16:34:49 -0700 (PDT)
From: Caio Novais <caionovais@usp.br>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] drm/amd/display: Remove unused variable 'hubp'
Date: Mon, 27 Mar 2023 20:33:45 -0300
Message-Id: <20230327233353.64081-5-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c: In function ‘dcn201_pipe_control_lock’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:544:22: warning: variable ‘hubp’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
index 61bcfa03c4e7..1aeb04fbd89d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
@@ -541,8 +541,6 @@ void dcn201_pipe_control_lock(
 	bool lock)
 {
 	struct dce_hwseq *hws = dc->hwseq;
-	struct hubp *hubp = NULL;
-	hubp = dc->res_pool->hubps[pipe->pipe_idx];
 	/* use TG master update lock to lock everything on the TG
 	 * therefore only top pipe need to lock
 	 */
-- 
2.40.0

