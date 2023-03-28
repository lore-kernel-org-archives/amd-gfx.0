Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0CDC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 22:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA80410E992;
	Tue, 28 Mar 2023 22:10:04 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31CA610E9C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 22:10:03 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-17aceccdcf6so14304295fac.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1680041402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dENL6Fxh5VQz27gw9oq+gG40WY6+FnIBbbcwaGKgL9s=;
 b=TeGGZ62mzEJyrUfX2ccRVZT3lPsNRHD9em3zwi4/mVr57wvmJPnxMVbCVaDDnwBq+R
 0JlVMx2YMAHbMeDCtDSmZ2G3ZR/AwgySjiUjUeAdwq2e7KUotHbJp3Z4yVXKqOgPTlHs
 hSTVwV19mvw1ppeuvuL744Z9QHua2JZOGhyIiQr3xYCrTcm9uC0GbtCe7ESiajbDsOmy
 9V2QALBsInqyI0JmYh69SXZknkNXiLEWXwCNnYA6iB1idT7eGTGdhMeujRblcrSPHZvx
 t28AyK5xmtrASoQ/MHUUVdoZ1BGTwRWk2gxQRR64RUTKeKPSHeIVW7fp8y+8FeR3o8bQ
 AxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680041402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dENL6Fxh5VQz27gw9oq+gG40WY6+FnIBbbcwaGKgL9s=;
 b=Aiz1IPOAn1YcTzLsnoGePu+YWNVt/dscuD1TPSCa07NU5kptjBbG0Ic4TiGjaGeqQ9
 +8acw13GWU5GNqUwb4kAxt3LPPBQTcZNNiHUkJ4N10oapy799cKmZmletpsazU9LeAHU
 x2j+kn1k2B6yw0o3LgYw2LfJcO2htX323qwlP+0O0lm7ZvjFrU5uyU/lq8l1C2kHRbSF
 7Y7BHMFfW6Lo+q7GVW3GZUY0KiD8CCwQae12lhxaJmlgxYbhwc/SSCqsnvQKWBRA4kBn
 xUrchNC//lih95GjGiZJ83flierAJH3DODcPGPOFz58SNIt9GbxrljbePHfk2tiwpAzs
 KpuA==
X-Gm-Message-State: AAQBX9fl1xPh2S0eUcpdd6Pa1miIwsR8cuy4BPmBy8/LEaIlbx+n0HQ+
 EwxkBD/H7zFknKaJ6AqYQAX65zHxG0opF/5rWSpz0g==
X-Google-Smtp-Source: AK7set/9hzzNUuU4Kkf2sFIlf9BTfuvoZJiOF7XASZcYaJwHgZ1p9n84Nr1VJ/l7iON+8pPL6KWGDg==
X-Received: by 2002:a05:6870:32d3:b0:17e:cb7:29a3 with SMTP id
 r19-20020a05687032d300b0017e0cb729a3mr10510460oac.15.1680041401995; 
 Tue, 28 Mar 2023 15:10:01 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
 by smtp.gmail.com with ESMTPSA id
 ee39-20020a056870c82700b0017299192eb1sm5400446oab.25.2023.03.28.15.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 15:10:01 -0700 (PDT)
From: Caio Novais <caionovais@usp.br>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/amd/display: Remove unused variable 'scl_enable'
Date: Tue, 28 Mar 2023 19:09:46 -0300
Message-Id: <20230328220947.108188-2-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230328220947.108188-1-caionovais@usp.br>
References: <20230328220947.108188-1-caionovais@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Gabe Teeger <gabe.teeger@amd.com>,
 Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Deepak R Varma <drv@mailo.com>,
 "Lee, Alvin" <Alvin.Lee2@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Caio Novais <caionovais@usp.br>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Compiling AMD GPU drivers displays a warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_rq_dlg_calc_314.c: In function ‘dml_rq_dlg_get_dlg_params’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_rq_dlg_calc_314.c:991:14: warning: variable ‘scl_enable’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable 'scl_enable'.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 .../gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index d1c2693a2e28..ea4eb66066c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -988,7 +988,6 @@ static void dml_rq_dlg_get_dlg_params(
 	double hratio_c;
 	double vratio_l;
 	double vratio_c;
-	bool scl_enable;
 
 	unsigned int swath_width_ub_l;
 	unsigned int dpte_groups_per_row_ub_l;
@@ -1117,7 +1116,6 @@ static void dml_rq_dlg_get_dlg_params(
 	hratio_c = scl->hscl_ratio_c;
 	vratio_l = scl->vscl_ratio;
 	vratio_c = scl->vscl_ratio_c;
-	scl_enable = scl->scl_enable;
 
 	swath_width_ub_l = rq_dlg_param->rq_l.swath_width_ub;
 	dpte_groups_per_row_ub_l = rq_dlg_param->rq_l.dpte_groups_per_row_ub;
-- 
2.40.0

