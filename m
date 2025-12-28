Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E610BE92725
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Dec 2025 17:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C3511AFB2;
	Sun, 28 Dec 2025 17:21:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uf/tp21T";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kp7awoqH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2942A11AF4A
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:46 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BSBuvYh2919933
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CGyPL6KHRYRMQ39eO9G7zyY0TeTIkBgeR3+nmWeanBE=; b=Uf/tp21TzmBWEvgP
 Ggk1niZyXxbf3GCIJK5GcXRvaAkv7i15eT7pfYRdqlr+bTqB4vqzeGeFWOsLhWqi
 5TWVSKDykWL7DoizFvJHUYoviNu7DsrrYV1ELCE8T/aiP2xhE2v3i24MxhDUvc61
 BoK4EoM+GkX+OyrS8tQg+geE1N9uzYEut/MxxrFuFJvfVys8oYCjRk5O9jfXB+om
 ZdKQKF7Autqrftsos78szIQt9s2xwHC0eeMn7PLgTZ7CbyCvNuZdnwzboCHZjGWI
 3VT2PqngpmzH5liozgleHWSiYMDgm0OeBDK/MtqJzEpK79/QThu/ObH/qINGTsQy
 2SKz5Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba7u5jexv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4ee09693109so170510891cf.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766942504; x=1767547304;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CGyPL6KHRYRMQ39eO9G7zyY0TeTIkBgeR3+nmWeanBE=;
 b=Kp7awoqHK0sTf7olXB5dIFN4RdDXxe/OvAyWBl4YdhOkqTJreSnPaEHuvPUNgEZTU+
 UneBV2vW4qkAlfxyFj/E+h4LQNG2WeqYZlqCGzqTpwPqWO1SvIv4oOkqL72lvuasfE+B
 VA9gcBFHva1dDxb4dSw7SDSGurpefRBeKAcgp9fi36INt+rh6XMMyPYg7lmRWO9AszJr
 bCyz7JcauE3iXIz064jfiIqvrbf+KeSGm9bj2uOa8/U2/Lg0X0zTp3XjxOttJPuczhV+
 dcTu7E2vCpeug/o9J0kKopwixpM8Ezx8U5heRV6RrfPQoxJkGk/uVj8Y+BOT58zhkCbt
 Q6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766942504; x=1767547304;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CGyPL6KHRYRMQ39eO9G7zyY0TeTIkBgeR3+nmWeanBE=;
 b=xItxCL5z0SjVo46Zdp9zTD9VcSwKUR9hm2xfKAprj15EWJ+12z6SWP02+nswHqPtwv
 pKuxmYCfm/V3Z5aB38+H1nWZW5C9oi+fC+A3CnlTdlaJiVobxSX5vmNWlyhOwnJESUGp
 2BvtYX3zY0pkRdlqACdfWpdTe0x7LsO+clP0Fh5HDpHgsTAFYeorRtZEYJCBaGuy6AR+
 YyWod9DNh6i+uGKhUrBwfA9bPoIORf+oHp8lCv5jrg8hYtmltNLHAP4Lj43PJqyaLuiH
 OhyN2hH0bStSeTQmXOBjw1HdQeEAlsO31dskSzxdjbZfiU/rbFRVJnpSVPrmdLvCNLlt
 gtvw==
X-Gm-Message-State: AOJu0Yw872SdlK6ckvtOmwB/o/G9D7Z5UAwmO6HPHZEcvs4lC1z3uhz9
 Xl70ew8YabhHGPp5O1RwekTNQCOmQOb1J9cUhE5mTd1joUzJvlKGJBu8WpyxqJxiymiJPfAkhSQ
 9bcc0m40qmrwbtivn2zT2+jZdJQ1tcesiMzQwU+ZEWXKsy5g7a7A5dRkTJ7reZwR+NPT4
X-Gm-Gg: AY/fxX69SEsNArwD6W1OmbFyKdQqJxJDhrhm3DH9qbATc040R6AT1+w5nXoqczQTacs
 rxy5z2eteggv3BNaIy93rB8U1M5yRo9Cm1AdA8scVWkkxcQwbLe3npxLj2qdD+9NImqhD75tsBZ
 S77SOfb9dfiJXX29QV4QCTEN7Wl7THWfBkfxRyZHjPlT1HEdxIzvt//tl2espqP9Rk3gTugSJWl
 Li38AO3vyqyxR9Xlssc6LeY2PO69GynM0trY1xYqUdJSTId76l2F135nMybWOdOoz1jBYSB5SSx
 e5mMB4/Zj3yXSyy8o5TU8v1fOisLUK8lY5mFzLYNJz00dK/bW2RD8fII+ZcuybyUFTJsaZ1MxJ7
 8Ao/M5j9D1D0vA1eE6PNVz7asrVgGJnBqmj/yeYtH6BFSEUhWfESMTE7Mwrhc0M6FwTqq0AQjw8
 6u+odV1uCh/mysFarZdAo7/EY=
X-Received: by 2002:a05:622a:180b:b0:4f3:58e4:a35a with SMTP id
 d75a77b69052e-4f4abde3e12mr414053101cf.76.1766942504530; 
 Sun, 28 Dec 2025 09:21:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECq0Qmt0XAxFswq1cu73NAKtByntaPjKWodblDIcL0xgfkkSH03R1wkbkJ182GBH0vNXPH7g==
X-Received: by 2002:a05:622a:180b:b0:4f3:58e4:a35a with SMTP id
 d75a77b69052e-4f4abde3e12mr414052511cf.76.1766942504089; 
 Sun, 28 Dec 2025 09:21:44 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3812251cfffsm76871031fa.19.2025.12.28.09.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 09:21:43 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 19:21:35 +0200
Subject: [PATCH v4 3/8] drm/komeda: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-wb-drop-encoder-v4-3-58d28e668901@oss.qualcomm.com>
References: <20251228-wb-drop-encoder-v4-0-58d28e668901@oss.qualcomm.com>
In-Reply-To: <20251228-wb-drop-encoder-v4-0-58d28e668901@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Suraj Kandpal <suraj.kandpal@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2957;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=eBzpPbb7DQH4mV13wWJlrn34m8m6zEyV2uFIH/bk69w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpUWciAKlQsujWkOpLqHFrKD2XVuk+2pZawHVG4
 1UF4s0FzrOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVFnIgAKCRCLPIo+Aiko
 1Un0B/9wVD3LDimX5fzl+PflgjNQGNawH3LkDsOTuXS6mmAMJoOmVBnrZPVZmArDidHcXXPDeRQ
 8L712inmPVorbB+TBGXSGmaOjgkijlxEn4yrVivkSySd64MuuYqFe9fCR/0h1pzO5Ah/fhgDG/H
 NhtHHzJ0PSJsRjGwjplpouC5WpwouFW8FP3+Ow29Cw0LfLlTjzohyH28PwIrOy8YKDF3wBpFmZa
 klWf9iaFvj1N9WY2IZoSXXmrXNcuce8p/EVkjV2hsRb82YJX9P9Y4iZNXVKGkwMcHtP3Gp2P+w1
 OpGRCWk9mpNvLaUoTirYlk2vfUZrrS/pK+A5WUQwDR+Rvf9Z
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: haCpnXO5Vkqqm3hfHhZ9XpWjDLP40EXu
X-Proofpoint-ORIG-GUID: haCpnXO5Vkqqm3hfHhZ9XpWjDLP40EXu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OSBTYWx0ZWRfXwMsNWbbDbKae
 F7PTBA5GNb+2pvkg9ongWMaTV+A9LIbvum2GuO9lG3/5yarB/bn21GL9W+gEYsM0SP7q/t1wHyN
 brplHsEkQ1LrPth3luVUoTPpZBJM7AcAkq5LX0ZD1suCzoE/31iih+lYRbBrxnCTievtN+OgCUi
 HJdQHXawIvsK18J4ocPpS8AZpPH837IGxda8bD+v4GDqmWb1hyCPDr1HzRBQ4tJNlMrQggU8s/u
 izA2u8IYbme7/6JJQ1nL9wAOPRvR7l0xmVc0PBaQCJHyeReS7c5tjyIYlsiy3RH5Ji/O6wqaixv
 Blns48YZbEQv2Z2V3KhG5/bzw5Xx7D8AFavHceCFF7PhT/OOsN9PmfztEHCMCaM3Y14zurr1TnZ
 W9TOxY5MpUTIB6ql2BJ2bVwram0T3tA+OU5yRvNgmbySvp2h4hs5BDCF1DZv1Ufe3lXgYdHlR7L
 QumnHJi7i3RujnlksYA==
X-Authority-Analysis: v=2.4 cv=DptbOW/+ c=1 sm=1 tr=0 ts=69516729 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=EE5oNXVUeA2ILyHCr4wA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280159
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 30 ++++++++++++----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 875cdbff18c9..bcc53d4015f1 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -5,6 +5,7 @@
  *
  */
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_managed.h>
 #include "komeda_dev.h"
 #include "komeda_kms.h"
 
@@ -121,17 +122,10 @@ komeda_wb_connector_fill_modes(struct drm_connector *connector,
 	return 0;
 }
 
-static void komeda_wb_connector_destroy(struct drm_connector *connector)
-{
-	drm_connector_cleanup(connector);
-	kfree(to_kconn(to_wb_conn(connector)));
-}
-
 static const struct drm_connector_funcs komeda_wb_connector_funcs = {
 	.reset			= drm_atomic_helper_connector_reset,
 	.detect			= komeda_wb_connector_detect,
 	.fill_modes		= komeda_wb_connector_fill_modes,
-	.destroy		= komeda_wb_connector_destroy,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
@@ -143,13 +137,15 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 	struct komeda_wb_connector *kwb_conn;
 	struct drm_writeback_connector *wb_conn;
 	struct drm_display_info *info;
+	struct drm_encoder *encoder;
+
 	u32 *formats, n_formats = 0;
 	int err;
 
 	if (!kcrtc->master->wb_layer)
 		return 0;
 
-	kwb_conn = kzalloc(sizeof(*kwb_conn), GFP_KERNEL);
+	kwb_conn = drmm_kzalloc(&kms->base, sizeof(*kwb_conn), GFP_KERNEL);
 	if (!kwb_conn)
 		return -ENOMEM;
 
@@ -165,11 +161,19 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 		return -ENOMEM;
 	}
 
-	err = drm_writeback_connector_init(&kms->base, wb_conn,
-					   &komeda_wb_connector_funcs,
-					   &komeda_wb_encoder_helper_funcs,
-					   formats, n_formats,
-					   BIT(drm_crtc_index(&kcrtc->base)));
+	encoder = drmm_plain_encoder_alloc(&kms->base, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &komeda_wb_encoder_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(&kcrtc->base);
+
+	err = drmm_writeback_connector_init(&kms->base, wb_conn,
+					    &komeda_wb_connector_funcs,
+					    encoder,
+					    formats, n_formats);
 	komeda_put_fourcc_list(formats);
 	if (err) {
 		kfree(kwb_conn);

-- 
2.47.3

