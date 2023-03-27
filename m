Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7D6C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 23:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B83610E418;
	Mon, 27 Mar 2023 23:36:03 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 062F410E413
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 23:36:01 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id bj20so7707138oib.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 16:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1679960160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1STa2/pWkCDUQgTVLH0svd7MRisCAzPtmwfg6lpY0tI=;
 b=qPr+/DvkkL35CXSg4gE7/ktKUvTDyUTO7/IL0lvUrUhq8xvT+h0HhqzQfjWn1sHUfq
 En1aRSU2RJDmigFYzTkS8EzveTOuSZurTNaXQXuMC6z/L0zjjcJ8pOP/RAK6YNbcQw4q
 N5w7bZZE64NLFvAe+hhsuZfaHKcZTlvPLUVB9WGh8vWvbT6Bw4YEgTBixKkzkX8laK7u
 c3mserAVKXZC8U5cNFsmkDDulr/6NVBOx3crHKcKt03a7xXztRoIGeA5RCQKYfaqLqZm
 P+MTr26pEMPaE0/LT8tYpGLXoDohT7fYS5w7xLTwM+j6dYp92VoQgWbJwQ7Uly27Grox
 qGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679960160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1STa2/pWkCDUQgTVLH0svd7MRisCAzPtmwfg6lpY0tI=;
 b=chLG+3hjS2BD8osBtP/kgvQBpZ7YFU2Em5AsVIYC8v3whWfOn+It0XZCUN7vO67Jzc
 wIfKI7yVKoIuknywZ1ZpfOF3V5LSxQL/zZPsKhF+2u32o2w7N54MD9JiqclxthrajtWV
 ZhgEfslEkekgFpS4BvbYfm0TSCzm90TC/6ZnHfXNlaQ1ISJYAEk30mLpezUtlLInM8VL
 m8FrsvPqn62nARRoiBEnFdPaNYqS5JoXynDuTdJXZfdb1jgxhpmgNdHtwTOW+YVqeWUL
 ESOPpY7tmTTVL43rM2R7JM5ZvaOzPLdUFiDwg7CkqcOC8L7Jhp33TyCuJbyBgAklgUFy
 kwVg==
X-Gm-Message-State: AO0yUKXEYjkgBxW2pNdkWbDN7iq9MaAOr3kv6crAmhFDycFbnm7zwmwq
 4Xvs17e36P6yPE9kr95osqZO4Wo0shD3JYjx7XUMqQ==
X-Google-Smtp-Source: AK7set8j4D0nhypplSsU3HBthDUICnrtCgmJYFcK94O5rdy1CxC8OtORoO7uyBWCp1vj0T0Q4dZCWA==
X-Received: by 2002:a05:6808:659:b0:383:caf3:a30e with SMTP id
 z25-20020a056808065900b00383caf3a30emr5533117oih.17.1679960159943; 
 Mon, 27 Mar 2023 16:35:59 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
 by smtp.gmail.com with ESMTPSA id
 b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 16:35:59 -0700 (PDT)
From: Caio Novais <caionovais@usp.br>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] drm/amd/display: Remove unused variable 'scl_enable'
Date: Mon, 27 Mar 2023 20:33:52 -0300
Message-Id: <20230327233353.64081-12-caionovais@usp.br>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c: In function ‘dml_rq_dlg_get_dlg_params’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:905:14: warning: variable ‘scl_enable’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 .../gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c   | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index 35d10b4d018b..2244e4fb8c96 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -902,7 +902,6 @@ static void dml_rq_dlg_get_dlg_params(
 	double hratio_c;
 	double vratio_l;
 	double vratio_c;
-	bool scl_enable;
 
 	unsigned int swath_width_ub_l;
 	unsigned int dpte_groups_per_row_ub_l;
@@ -1020,7 +1019,6 @@ static void dml_rq_dlg_get_dlg_params(
 	hratio_c = scl->hscl_ratio_c;
 	vratio_l = scl->vscl_ratio;
 	vratio_c = scl->vscl_ratio_c;
-	scl_enable = scl->scl_enable;
 
 	swath_width_ub_l = rq_dlg_param->rq_l.swath_width_ub;
 	dpte_groups_per_row_ub_l = rq_dlg_param->rq_l.dpte_groups_per_row_ub;
-- 
2.40.0

