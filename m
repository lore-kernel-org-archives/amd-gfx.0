Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0094CD342C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 00:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351C410E8D7;
	Tue,  5 May 2026 00:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b1dGjabG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y9+aGeUR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE9810E8D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 00:25:27 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644K5nvr299348
 for <amd-gfx@lists.freedesktop.org>; Tue, 5 May 2026 00:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rvUq8Kk9vuSdbxC2mnaQWgVoYwyqvsDFVMNCLtB92nE=; b=b1dGjabGKyCNTbxD
 yLDHiPiPeFvVWtTCkRJYDrg/dp/nU2DyCcAL/+dYSlOjmTsGeufe1sG3LJv4X6KI
 6nFt9RHqTHrleZsnidTesSppQ/GDCRv8SSRtzGAmf4GtMS7jWQjAFAE5r+Cp1tUT
 sA9whihcJKSdWmkvHgm7/CV0GG1bEMNR0W1R7KsZIG1E2hOiz8dYEFob+dDInPzU
 kwVhb0roTk/XPiVKqgvrAkqFgLoZrFRwQEoIFX5MqdvevQ4CuAKOqaSTtSce1L/V
 cdVodcjRpMIBljUL2IuiNzYaYEuW+EcOSK67DMaakYd7jompYkuPW6Q7k+DEuZkQ
 3UPZ8A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvnda6tg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2026 00:25:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fbc70cfbdso117431661cf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 May 2026 17:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777940726; x=1778545526;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rvUq8Kk9vuSdbxC2mnaQWgVoYwyqvsDFVMNCLtB92nE=;
 b=Y9+aGeURBhQ2tv76QCxS3uGvMEiQ6BYPi7C5Zr2FTt4KF2CbvBbWkFLEVj8fuVDlSB
 zULZ7XByu3EY1ltNeI+fyJ+dvIprEw3E3i9AwVn98XfjG3dwwVzlhF0xgixEMkiDT+V0
 XzAjXDNg7sHop9Whv0jZdiShOcU4MufZczjJr4CnpKnEFXtZ/+DyMkCzfqEcdAD9kXx0
 HkXJg8Gm+J0uAic+bBdj+8YDw3FceGDNU3DYtfYED1+InovA9SUJRY/ViZiFsCBtE3Em
 FiLVE976ydbjSohdXEatfWAvcN9QdrNxnv+ruiCShAwh/Nv9pl788NDZO0+/g80nrU3n
 2ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777940726; x=1778545526;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rvUq8Kk9vuSdbxC2mnaQWgVoYwyqvsDFVMNCLtB92nE=;
 b=dIuRIWYHRsswjFdh9nezP4aqpwayiKSw871T/6JLYVWKr5UK5aTGGfXXEHmKp0r3Vy
 5AJmtv+u4b8JTilT6OzDd2RFs09PbVJPWTew8W6g+m5b9AQ6FKHptYwHuaVdbOQTFygQ
 3yh9YNyf9Vbykbd0moeo4fJxi42owzaVEAiw3qGA4I9BsugihoCtwuZzm/igWvXuj0R0
 LLxEttGX2KHYTEjEjQYNZVQpnGzlIzGYnhd6Ng+lGaIElW+m3u4746Edw64CoKcCSyAV
 wsDe77P4VLbeWsFihPzn2XS7HlbtAxpVOy1RhVQ4Njrb36TWJIa6xcg1pdmusZph42sA
 sOxw==
X-Gm-Message-State: AOJu0YyvQNsSg6wyeUygCQ0a3ywMrMw3KK9PPmjc+ath9YDV+1tji4Qa
 2iZa3rEsWlmGahttvvgRt7pD0XtffPIMDocgJVExCsRFxiydpnujrjqFz1Yuo7Jb9P1bhJXXgy+
 eaYGWwd+DZRhhVz666JBhm5UHoFdS2p0DeykF89D1Nf0g74LcBpA0sSmoMfYUDLjMhrE0
X-Gm-Gg: AeBDiesVnG3v5uSujGH30p1RYvFaZJSYeTingEdBH50MqX1dIXeTx7GcYMhF9Y7xMQQ
 BWqETlqPD65eZST5glvEonBmbur7Sacca60b9p7xJ+tdY3cfuiRLvq+YH+OvOWjZANkpDtMlo1q
 M1Tg/OZbwesZcKG0+CseCxijoXUzut36lCtKMZHmlwda/SUDB/vxfIpIElfBE/aJ9qx+VK26AS4
 Yg8Qp4JUaAK/cIcLlQkPyQzdhZUpAnWhMW/x4C+aRbVoa9XYqJoYikkTCSd0w5s6hhiXCEqw6+l
 cu6CQNNt1N14/VGojLKPMQT4o/+Q/aAxqJHtlsxhpyWxfyGO7lFcx4PkV27BGbjD4yIJeXngMPQ
 BwjWzkup39dRFSn1D2DyyNBH9nxJjCEiixj+DcfsXhmkaDFQTZbgUIWIOxuOMSNZDCeMmngXrfq
 nh8+NgvghnuhDeYSIhUVnrvTSwFwOXwYCI8TTchi0c3FcbeA==
X-Received: by 2002:a05:622a:40d:b0:50e:defb:9dca with SMTP id
 d75a77b69052e-5104bfece5emr172357581cf.45.1777940726032; 
 Mon, 04 May 2026 17:25:26 -0700 (PDT)
X-Received: by 2002:a05:622a:40d:b0:50e:defb:9dca with SMTP id
 d75a77b69052e-5104bfece5emr172357201cf.45.1777940725522; 
 Mon, 04 May 2026 17:25:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393610ba09esm37132781fa.10.2026.05.04.17.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:25:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 05 May 2026 03:25:00 +0300
Subject: [PATCH v5 3/8] drm/komeda: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-wb-drop-encoder-v5-3-42567b7c7af2@oss.qualcomm.com>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
In-Reply-To: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
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
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
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
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3249;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=MhO3rZwygKwYvVhbAVjitmlBMP9oPZA7uZa37YA1WtY=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+ZPizsaWSG++ua3XqdZxT4V8/nV/ol/R89c0bPvy9Qf3
 lvLEfS6k9GIhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQAT0eBi/7FXLqU1JluVYXnM
 ek7FCO7OM2kLzANuVBVN6F3g+c0rNvzj/w9/CroPP5Qxya3MiJO1j/S7mKAp8+HIUsWTyzh5PM7
 Z+GdqSh1NLF8v4TN5Uju7/TrRv3eEJzyaeanu8Zdol8sGG03WbTixIs/oTOdK+6SX+iprN62Pm3
 gtZBm3l1SMrpmi3GtBXU51M/M/+XP35866ZvohUE3PJoOtoCfgn0BvkfjByEtO1ct/vDxVsn+7N
 7c7Z2eNjQGTfbv1303fVcMW9m28Vx/F0Pq43vgk14Rcy1MbGhLOKGl9DpNKqjh4YmnPF8l7Rgpf
 WgOr+IwL71fOPSEeeUTI6hmD0KGVmncjd6t53GyrDAEA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 5l8vOMqBJtndYOgNqXP-fLnlqaKSK2OC
X-Authority-Analysis: v=2.4 cv=d9jFDxjE c=1 sm=1 tr=0 ts=69f938f7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=gYs8AAvg_5cFonjPjrYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 5l8vOMqBJtndYOgNqXP-fLnlqaKSK2OC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMSBTYWx0ZWRfX/nZF9gSJ2xKQ
 Yw6k1xGfSMgZK/2iKyxXp0l+pWJA7QSLNtpURcPHairCbDRQny8ChxCPLolL2cGygun4QxQPl0l
 ZTAD5IOdA83bC/0Nbe3AaZBXISWEfhSzfA3muDmDgupQzzcEqefzGDt50SkOJ4mL5B7q/fAnqtt
 op5rKKo/9nSWoguqtrWz3UmQZiMm9tgSSQWxL4GXHGHXFXLfhm64zMbEKSQIouLM9Pc1J3X0OQa
 0mUJdOgbs7AQyVHj9Y9ycs0BKlUf9E4g/F01bEbPuY/ukyYerh5e44DuBCEXHZfTNpUxE5SLZYO
 e7at27iyD03zpzG/O/Jk76o7o3F+OU4yAvoGBabGY4s/iFJqFHpCSriVs3imiJVTXTq8Ne1zpJq
 vn6e9MnIekBEPiLyDU7P9fCUJwVv1ZQiH1jbZ4ql3XffPKsmgwFMz/jqYtyVERkWnbUQLS/euw4
 FLF2Q5r7mHSrxY/zE7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050001
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

The driver uses drm_writeback_connector_init() instead of its drmm
counterpart, but it doesn't perform the job queue cleanup (neither
manually nor by calling drm_writeback_connector_cleanup()). On the
contrary, the drmm_writeback_connector_init() function ensures the
proper cleanup of the job queue.

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
index 41cc3e080dc9..bcc53d4015f1 100644
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
 
-	kwb_conn = kzalloc_obj(*kwb_conn);
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

