Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B69C761A6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 23:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF28E10E7BC;
	Mon, 27 Mar 2023 23:34:44 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A1510E7B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 23:34:41 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id s8so7715275ois.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 16:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1679960081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1IwF6Kj9QYhpJPxCrtGOCcjZaHDRHTEbDHEOQ0Q0o5c=;
 b=jfYnm0x5boN6VyBUnMWPRzz97xGu/bVZkk8ot1nSNhbtqM525wpnumuPPxj2g6SBmt
 iqmmB2Tb3gG2gIqDlHDVBtcb5bLSyxASg2JlHy4W5rzyjFd0wER0kSIGXZ7mUjS5562+
 4imgqjAZwoauhGi0X9/tsjF17nKL8f44lyAP2Z9q8WVM+VVX4Mrf8rvcYLk8k6Yypltz
 55syccSk7F6t6/C4ZpQlbrqQ+AQDGC3FjX9vijwQatYhvkvfGErtohIi3PnBdcogv/Fr
 i1LAISm1WjJdeH7GRdOWbnkEjnvTOG2OW2321C8y6x5FfqRTcO49qcGEIHuN8EzxTkpx
 KDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679960081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1IwF6Kj9QYhpJPxCrtGOCcjZaHDRHTEbDHEOQ0Q0o5c=;
 b=JBmXK5LSNHT2dyJMfcAiRN4Zr8pun7VeOv6bALZzWsWwwkFpzPg3HMo5qJ3pe7RgdS
 DbQmm//s+5paP0vAmIkoLjAzBAasb60I+ZyJQDxLJiXYcG22hx7U+ChoO04uGEzMeoGF
 MwM/i13KHgnLrbD0D1NszRxINw5Or+pTV50+xjxJf3qVFpIr5gOpUmKwcyfjy9rlD0gw
 +UZUXeQRQd0G0YoWsxMqbPk4KFDDwqD9Pn8XxXCJqTeYg/mcDvw2AccxslS2S099+8K5
 P6kq3C8DA3JZvGcVXCq6Ll67PF0LF9X2sc0zE9xJiiYAPRCVDRw1jlWNA4XaigOfN8co
 SDyw==
X-Gm-Message-State: AAQBX9fmsx1RDyZOS5lIpewZ8H90mFO7ITG7QSAybiAq2T3mXBhi1bCf
 M9h/I2Y3v6S8xQ4hpfHmBiPLsg8oPmeBzoAX1BWeOg==
X-Google-Smtp-Source: AKy350amlW4hmJ5oi6zfnFlDhNs8qcwQpjdMENIe7wdz31yjBqJqQIgig25+IFqaAxHNxlomgZLO+Q==
X-Received: by 2002:aca:2b09:0:b0:389:4f27:9e0 with SMTP id
 i9-20020aca2b09000000b003894f2709e0mr676851oik.26.1679960079586; 
 Mon, 27 Mar 2023 16:34:39 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
 by smtp.gmail.com with ESMTPSA id
 b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 16:34:39 -0700 (PDT)
From: Caio Novais <caionovais@usp.br>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] drm/amd/display: Remove unused variable 'pixel_width'
Date: Mon, 27 Mar 2023 20:33:44 -0300
Message-Id: <20230327233353.64081-4-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c: In function ‘dpp201_get_optimal_number_of_taps’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c:188:18: warning: variable ‘pixel_width’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
index f50ab961bc17..f8ffc06593b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
@@ -185,12 +185,6 @@ static bool dpp201_get_optimal_number_of_taps(
 		struct scaler_data *scl_data,
 		const struct scaling_taps *in_taps)
 {
-	uint32_t pixel_width;
-
-	if (scl_data->viewport.width > scl_data->recout.width)
-		pixel_width = scl_data->recout.width;
-	else
-		pixel_width = scl_data->viewport.width;
 
 	if (scl_data->viewport.width  != scl_data->h_active &&
 		scl_data->viewport.height != scl_data->v_active &&
-- 
2.40.0

