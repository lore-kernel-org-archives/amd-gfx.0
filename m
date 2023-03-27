Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6322AC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 23:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016C510E7C6;
	Mon, 27 Mar 2023 23:35:33 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F0EF10E7C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 23:35:30 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id bi31so7683414oib.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 16:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1679960130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUkta+0S5SLkoZECV+gOZOOKUmxnKipm+UrOigNAFFk=;
 b=swJb8KVfeXLvtuIhEIeBE9NbxPQxoD9VVnzPlKqChCd6u3oKt2nYGhQip4wsSdXnlJ
 jy4oScaGOmGE/uhRqfkOwL/RWknbsB9S60gJG298OwojfzpZLrOsoRlH61rPhFFJiuta
 dWDWYo+kOd572NhZl5aYIYYGL+W6RhDlZ35j906H/+Z9GMS7nlX0Pp4ZekMwTH243tt4
 qNZJ81RkxI5g0r/vzzlr5AyIQBJPAaKi6tl4vRxYEsirvujARmH8IpruV76ntFA4ulpd
 xGjd2XZWA6to4BdtnP5AQ7pR6fKMoFnmiF6PkqqmB5flk0x1JZ0JvTSnf2XLJamsuZBL
 hhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679960130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rUkta+0S5SLkoZECV+gOZOOKUmxnKipm+UrOigNAFFk=;
 b=Js5UCSUsCRuPVX4hLdruW2dHzJzKxB6m9yPUUrg8Pp7Uz8U5theOsSGJMHRFA7lENC
 v9LF0ONYaW/n15IiGnZLOawz17M4qQoUm4mYHYwVFuiL5jOr4L9v5z+ZNOlE63uxit/r
 Ck3G6/AD9k5KeBbnt8ZWIcMxPX2dUj7mxUjCkvKrajau5+yb+CA+yJjCnRCO/mDY0ftG
 m2QQUxXoDEr2AGvbBKMy3+NSucuRgGL6davKUcfZK6T9d5CV4qI38tlJQQ5vjvVMpJAr
 IOW90KZOaRrieGMsyn6BayEwRUhhdJYQZBLTmCCGznJqXbwSwwVVbzKxxNj7puixF8dy
 3R8w==
X-Gm-Message-State: AO0yUKWkdSOBujUUHWGdSFtQ/hB3dBywuGeNMn8N8jT9Xi8ok9yi5IHC
 ifVpioHwWWSdlnuwnjQBGFSH34MCXsiw1YLbOp0TpQ==
X-Google-Smtp-Source: AK7set+QyePXkuvYL4djaRZGrEn+bFJpxBVjzKR7R2A7NNFYEfpsX+JwGBSrTo3Ckjv7Q5X9M18xqQ==
X-Received: by 2002:a05:6808:634a:b0:383:febf:2a97 with SMTP id
 eb10-20020a056808634a00b00383febf2a97mr5828896oib.11.1679960129822; 
 Mon, 27 Mar 2023 16:35:29 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
 by smtp.gmail.com with ESMTPSA id
 b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 16:35:29 -0700 (PDT)
From: Caio Novais <caionovais@usp.br>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] drm/amd/display: Remove two unused variables 'speakers'
 and 'channels' and remove unused function 'speakers_to_channels'
Date: Mon, 27 Mar 2023 20:33:49 -0300
Message-Id: <20230327233353.64081-9-caionovais@usp.br>
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

Compiling AMD GPU drivers displays two warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c: In function ‘apg31_se_audio_setup’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:117:18: warning: variable ‘channels’ set but not used [-Wunused-but-set-variable]
and
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:116:18: warning: variable ‘speakers’ set but not used [-Wunused-but-set-variable]

Get rid of them by removing the variables and the function
"speakers_to_channels".

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  | 39 -------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
index 24e9ff65434d..e94d0ba915ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
@@ -72,40 +72,6 @@ static void apg31_disable(
 	REG_UPDATE(APG_CONTROL2, APG_ENABLE, 0);
 }
 
-static union audio_cea_channels speakers_to_channels(
-	struct audio_speaker_flags speaker_flags)
-{
-	union audio_cea_channels cea_channels = {0};
-
-	/* these are one to one */
-	cea_channels.channels.FL = speaker_flags.FL_FR;
-	cea_channels.channels.FR = speaker_flags.FL_FR;
-	cea_channels.channels.LFE = speaker_flags.LFE;
-	cea_channels.channels.FC = speaker_flags.FC;
-
-	/* if Rear Left and Right exist move RC speaker to channel 7
-	 * otherwise to channel 5
-	 */
-	if (speaker_flags.RL_RR) {
-		cea_channels.channels.RL_RC = speaker_flags.RL_RR;
-		cea_channels.channels.RR = speaker_flags.RL_RR;
-		cea_channels.channels.RC_RLC_FLC = speaker_flags.RC;
-	} else {
-		cea_channels.channels.RL_RC = speaker_flags.RC;
-	}
-
-	/* FRONT Left Right Center and REAR Left Right Center are exclusive */
-	if (speaker_flags.FLC_FRC) {
-		cea_channels.channels.RC_RLC_FLC = speaker_flags.FLC_FRC;
-		cea_channels.channels.RRC_FRC = speaker_flags.FLC_FRC;
-	} else {
-		cea_channels.channels.RC_RLC_FLC = speaker_flags.RLC_RRC;
-		cea_channels.channels.RRC_FRC = speaker_flags.RLC_RRC;
-	}
-
-	return cea_channels;
-}
-
 static void apg31_se_audio_setup(
 	struct apg *apg,
 	unsigned int az_inst,
@@ -113,17 +79,12 @@ static void apg31_se_audio_setup(
 {
 	struct dcn31_apg *apg31 = DCN31_APG_FROM_APG(apg);
 
-	uint32_t speakers = 0;
-	uint32_t channels = 0;
 
 	ASSERT(audio_info);
 	/* This should not happen.it does so we don't get BSOD*/
 	if (audio_info == NULL)
 		return;
 
-	speakers = audio_info->flags.info.ALLSPEAKERS;
-	channels = speakers_to_channels(audio_info->flags.speaker_flags).all;
-
 	/* DisplayPort only allows for one audio stream with stream ID 0 */
 	REG_UPDATE(APG_CONTROL2, APG_DP_AUDIO_STREAM_ID, 0);
 
-- 
2.40.0

