Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0754CC761A6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 23:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFF110E7C0;
	Mon, 27 Mar 2023 23:35:04 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C77A910E7BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 23:35:00 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id r16so7610443oij.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 16:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1679960099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZvChWzT9y/5zLeIHf5uAQzD/BtvkDRJ3FwyLW2ZaHk=;
 b=wm7ahbRIhc9RvuZcZDoeymhlv3zgD7q8vtlddoiFgyPuYrCF2UQHw1qVFatPY38lbk
 L2MDcqf4eFfFC9CD4fkQf+dipCiiaXWG8ig6gj/1+WLjtVv9dPoPoWUW0OdVyljtevBj
 P1tAYeCjhmjGlaaJoO3h1AsREJwGADm4oAyEWnyxhNQmZEp/yuGqEhppic9GwJ497+6m
 cdfMze0NchXZo6iFtJ+LC4Uj2Wt37hP+m0Yhw2h11qHaiAf+GKNcfNcWz6Vr8UPFQ20/
 qqdrotLRu9N+cgoUH8F8M74KXSdu7eKJD2CI9iaISd9WZdaUnoQcd733g9l1a2Q1kQib
 AJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679960099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZvChWzT9y/5zLeIHf5uAQzD/BtvkDRJ3FwyLW2ZaHk=;
 b=2Xvfn5zARsHwxBGHqrURr7PCFdT1kW2r1hwj/SA4luu7jhkj1eiNfYJRwBxNfMdWr+
 CXbIUyNweQWWBrelxrozeLV7wm4HAFIATIar5UTIcRpxiNADpW1RtcSbGnpTvDA7iyGh
 gR7j2+q869654icOQsAfNPHY2ejKNQuhAXxd4xYHskv3Y6GiOH71Gt3jR5b5nEuzJHZm
 CDW0SvYtSUwGTWkay9Ncj6gHwYIDbrirlYcquhxT7jcJpsO8pdUdEuY7LcdVt4vlc3/Y
 PZi2d41c8IqWenwBY3fE0P+iu0coVKYVNqTG4Q0LvlSAAtkbjYzDeN0YlY1tY8XQ/TmT
 T9vA==
X-Gm-Message-State: AO0yUKVBJWmLoS1R9LpUnOOYbQT2UgfokqyMITKd9Suvs1y0S+mQlPAV
 iwk7oHGfB+TxGRwwtXzs5BsMp4gzAv+SPSi/j4VxWA==
X-Google-Smtp-Source: AK7set/8tjEH59vf8bLWrjpQFwfi5OJxvuo18LnQL3tRmSwfL7lkONT3v+KQNmF/JKJ6LyaDvpfYzA==
X-Received: by 2002:aca:220a:0:b0:387:3a49:4733 with SMTP id
 b10-20020aca220a000000b003873a494733mr5203770oic.59.1679960099653; 
 Mon, 27 Mar 2023 16:34:59 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
 by smtp.gmail.com with ESMTPSA id
 b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 16:34:59 -0700 (PDT)
From: Caio Novais <caionovais@usp.br>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] drm/amd/display: Remove unused variable 'speakers'
Date: Mon, 27 Mar 2023 20:33:46 -0300
Message-Id: <20230327233353.64081-6-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_afmt.c: In function ‘afmt3_se_audio_setup’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_afmt.c:126:18: warning: variable ‘speakers’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c
index 95528e5ef89e..55e388c4c98b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c
@@ -123,7 +123,6 @@ void afmt3_se_audio_setup(
 {
 	struct dcn30_afmt *afmt3 = DCN30_AFMT_FROM_AFMT(afmt);
 
-	uint32_t speakers = 0;
 	uint32_t channels = 0;
 
 	ASSERT(audio_info);
@@ -131,7 +130,6 @@ void afmt3_se_audio_setup(
 	if (audio_info == NULL)
 		return;
 
-	speakers = audio_info->flags.info.ALLSPEAKERS;
 	channels = speakers_to_channels(audio_info->flags.speaker_flags).all;
 
 	/* setup the audio stream source select (audio -> dig mapping) */
-- 
2.40.0

