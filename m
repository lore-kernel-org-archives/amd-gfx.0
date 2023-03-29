Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F09C761AF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 18:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CADEE10E17F;
	Wed, 29 Mar 2023 18:05:56 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B2E110EBE9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 18:05:51 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-17997ccf711so17122547fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1680113150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dENL6Fxh5VQz27gw9oq+gG40WY6+FnIBbbcwaGKgL9s=;
 b=qNdPr3T0VVdr5XsrImYxl6M5mYISWBJYMUVpySQaJmLrp1n0HEXIkbs7mD+7nCUiSp
 ENNG3tu4CDNcZ+DpyTBJZDFodUGb4K1yFLrp60aoqGfGdvW0Dmsvq1k9HJ/N6Z5QvPTu
 Ygb3up24v4GYEu7cvd4/V5uZkfb8Wb5oms7YjPsS3nlLz0oF80AVbw7Zt5p/KBGcfFnC
 NNaFo4Eu+4dGrn1PHgq8lAQ/pNE5MYd5pAmX0OXfbRy3u8sH3JC2mgZq+BceIbzvN1PE
 zmWe0CAElijV4k+CORZ8rpFYnUpxNihjsnBZOXRTPW3RoWA8x511sKffG1CbXwVUXlRd
 TvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680113150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dENL6Fxh5VQz27gw9oq+gG40WY6+FnIBbbcwaGKgL9s=;
 b=bsgURlij+K0HpvUtbLyIRAF7otCwkLyNKB/ASroqQKB9L+PcZkhTXVs8ZEHuZDt0XL
 bp7Mg6c854GsJBrCiBtJsj+gr7qqQH9gykvGIEuqD01R/uZ6unwF3k0Qitk74JmieTVy
 P8pVm9tn/ryl5lhprQ7RmMZCyW1HzOhCCpPnCLGSgHoAvyTvq6ti+kcLpzM67qQvbV9c
 98StK8ax8HcyWAwBFOaOfsnNDlPPFpWK7siVvywkFiQ5WMt0rx7tAVShUPBFkXKN7bjY
 X9MDadUilSaNjofVAYo/GxmvAoGAtzpswjt09YbyWtEiuBIc+ej2kTlbiws/3UJ7zCKU
 bkzQ==
X-Gm-Message-State: AO0yUKXYtC0vjaK9XIWH9/GaHHUGXEr4rH9iKx190MQnmEXmPxE7haMl
 zcwZSAeFKKclI5zkX7doKyY+y9i9JL1LQnEs4grkVQ==
X-Google-Smtp-Source: AKy350ZFzKCHQwib2AWl++pfIuersKFdWtVFGHv0D3aPWMLgI8OfejXGuKK3kkzECOOmF8Pq50ZmJw==
X-Received: by 2002:a05:6870:1d1:b0:17e:c403:a046 with SMTP id
 n17-20020a05687001d100b0017ec403a046mr12133932oad.12.1680113149906; 
 Wed, 29 Mar 2023 11:05:49 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
 by smtp.gmail.com with ESMTPSA id
 yo7-20020a05687c018700b001777244e3f9sm12098767oab.8.2023.03.29.11.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 11:05:49 -0700 (PDT)
From: Caio Novais <caionovais@usp.br>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/amd/display: Remove unused variable 'scl_enable'
Date: Wed, 29 Mar 2023 15:05:33 -0300
Message-Id: <20230329180534.99151-2-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329180534.99151-1-caionovais@usp.br>
References: <20230329180534.99151-1-caionovais@usp.br>
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

