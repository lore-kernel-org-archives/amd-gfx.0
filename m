Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4D5E9272A
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Dec 2025 17:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05AD11AF8F;
	Sun, 28 Dec 2025 17:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYHaLFlD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yf3e3YoZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62AC611AF6D
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:48 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BSD2HZB2931551
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eDPUkbWaxp6KrkSFA85zDg6sVbEErv1b26+6ctk/jsk=; b=kYHaLFlDC35bkGHD
 OdWJbpsrEG4tXDjd8ZRlG78SP0I0IfEgHKtIOOXDXX8RQCV7YuIpU6KhrMDdHURl
 DN0+OTQmmUVx1FKwoiXsL0aW19RGu027RVFBeYo4cbLU1rUE/LgQO/kDkPahXNt0
 X8PO37DDjeAp7GE7oSBEkvggk4BgJG9jXhToSnvBS078IBzdedw5F9G+VTV0sBPF
 WDnEHHGzZooWUNtI4RgS09T6oCqlRp+6ErXP/0sRfqIyBA7Kxm9qxiWZgj9gWsQF
 uir8ymMHK3WcE2WC+VFV/3pfWbSZZSTXhs3cWObTZDgzdtrvPhPAkGeCdy2r9Ok5
 gOXxXA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba7hsafw5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:47 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a32bd53cdso330269936d6.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 09:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766942507; x=1767547307;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eDPUkbWaxp6KrkSFA85zDg6sVbEErv1b26+6ctk/jsk=;
 b=Yf3e3YoZY/ibgx6e/xZ+PWxJhaISzuHNCqEPkS7PsWbo/5/Bf/H0RzaZe0od9VsMrK
 9H8suM3FtEww7dlm2FQAA/w2D6tDmhFJ+AxGYqwJHGxy6MYobHZ1E2frOQmpgPCxPp4R
 XP53sLfqZ4sFw5UwpIgu0seSTSsd7e9RLCH2M9tZSjgFv2YEm64H/ni1cKeurtX0aCou
 7BVKzuXfToiLe3KDwTCHk9DFIT7Gg16IEjoFXnTj3yu7pH0KHnDOwgvi4oTKlAmbMIx3
 FInsW6sn9kh7ptYJ5GWXjwltWYr6JxCGGa7l4tecvoliYOuiIy5ohKrkBobreaatpaWZ
 E04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766942507; x=1767547307;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eDPUkbWaxp6KrkSFA85zDg6sVbEErv1b26+6ctk/jsk=;
 b=S1iVSSV5GGy4ImnOOY4PFYcB9HdQZTRoOFFRPYtQNBZeFyhxXscRE73kG5EbpS0p0F
 joLCQzS414PYIyZY+687t3wrQgcldCpcNX+/tdKdFU/DPAU5lZOnuZjlCtx9bdG5wBhX
 rK+lwRDN63EZRBg9pNPIoZDDyPUh8nByqYMQWN+gvMOKRv1iyIWY8z7v0y1t8WBwSZWN
 62xvhAGqFCfzIPLylETMQa/UulVCIiddHMrmduAnwOpN2gfOGGLVngYLua3+PlkfAZAT
 NN61pQsVY7hemDBUiX4WN5cZw7CmvebGvF25ELCqFPYVf80Jmz8zmmYYtkyJFZVd2Tn6
 h4Bw==
X-Gm-Message-State: AOJu0YyDrG4DR1ORbrdXgRCGQby8F1sDH5a2BuWwNyVmIHbxDp1sZ6ij
 j3wa7mrVCdCfU+KPKPig55vpsW/QjwhoWK9e1P9E4ss/8s4U7GbkSwV7o7wSCNAiabETIgxrLJF
 lVR7C/1hOxtPJUYdZBejKQDlk5lGZI0xDAUOZZdeW2Wb8X9UyN7ecoQOQRZcZmYiusugH
X-Gm-Gg: AY/fxX5hOb8oQ5XhUOM+HehfPc0GQ1dB0jCIpoJA6QKq9tHZzaRTLdxBYCT5NvZ0e0V
 23xOIXfZX1xx1d+6Cl58RFKUFVuTaNFEFU771ezD1mQbp3PjSrpk9tbFmxMA5mfWNPIJShXz/yZ
 efP4AII05In/udUGszMb3Z1IkOxj8vmJJpCGrrWPDoa+VjhmyKGsDc/9LbDU5qHQw4VfyRAPd/q
 vqx6nvgkMWIFjb5CKYdUcvBFzLhsCCkj98zzJdhdJZ+Hx39iSU6nvObayVDGdY6PJ/NblEhGGNa
 pjuAndNhpEK0KnfD6V/wf11Drl5g6k4g/LsPyqEJK+pGKg2bnauTZbYHQc1JF2+r87NPVNJ5T2S
 d1sWKXyEQKwGa890u5WkfSyHqoXq0B7g4l4jAcpLGDjUEzPPS4ur+s5UTrRfIZV2rU2ArFqpPro
 Pkhm0NXg3aMCEd7JQFfHrmnxw=
X-Received: by 2002:ac8:7f92:0:b0:4ee:24e8:c9ae with SMTP id
 d75a77b69052e-4f4abd80862mr441188671cf.53.1766942506995; 
 Sun, 28 Dec 2025 09:21:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHf5aTkXX2NRIiLpAzpQc0et6EQtLYn+LiKPc7DpfXcCxPaXlFr5U+z+AsfAIGACL8LJu3LrQ==
X-Received: by 2002:ac8:7f92:0:b0:4ee:24e8:c9ae with SMTP id
 d75a77b69052e-4f4abd80862mr441188411cf.53.1766942506525; 
 Sun, 28 Dec 2025 09:21:46 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3812251cfffsm76871031fa.19.2025.12.28.09.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 09:21:44 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 19:21:36 +0200
Subject: [PATCH v4 4/8] drm/mali: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-wb-drop-encoder-v4-4-58d28e668901@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2565;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Gak6kPX23KHHukq6jZcbolLHfiPNT+W+DhYM18BNpYA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpUWciDY6HHVs6gK21qEbheR3ppdMAcAcg1J1bT
 HyuUH3YU6yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVFnIgAKCRCLPIo+Aiko
 1bX9B/9Zu6zJxH8C9m/gvM/KNsj5PCPWdiWrODMBmBWvdZ0kS1Zzm5usg4fc68mBA3PeOEy4kLR
 HQ0l69wS2Y+h9iwJ9BayE9FBb/wQN8pzE7kVD8Drxw4TCjEbziAG6HN21N7i0laDyN2j6G2Z9mr
 QSK92QX3QgrGr+Krx9J9wX7b7qkNzuMaQk34CAn9b2RPV0U75LTpKkfFEufPXEgF142bA6taW7g
 DWeoeEI5Wvmbn57820/bNnAz4D+cyqwsf21H4zDvc+i+vIpciJwLuNigEBCTLW5gewsSF7UUAyD
 cV2GYEwZ3Qgrzw7WdMqOvqqe10L/fRWYeNaZ9KLEL759Utp+
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 1cOZjG-W7OcPonXYw5gXLzdrm1GsSNG_
X-Authority-Analysis: v=2.4 cv=O4o0fR9W c=1 sm=1 tr=0 ts=6951672b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=mhD89yN676IZukTL2GQA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 1cOZjG-W7OcPonXYw5gXLzdrm1GsSNG_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OSBTYWx0ZWRfXxCEDJT+UQSHy
 gKCNbVFz2n+E47eQaNo9iB/2VUkzvtpuw8wg3EmvIC+X62mD/CuoqD12GSWGaUlpSf7QyymTGlU
 aox+YY81NslWFfPuKjmSmbZCallSdppjcx4eZn9mvxoTtqoAsBHjXQ8TFYzILsW+RI0QjDvpi48
 ioJ8XvhcSRW8MiGWwcNGUPt2WBB5PtD2X1l6mAuBM20CVk0oQhq+VIljEEXTvYO4tqp0clLT9JW
 Q/WrQEqZNK2f4bK91BhTU6Krc9dhZgyDkbuFieN2NiwkFjJIda2w4LLWQlC9Ky06ticXN1vMqJ0
 lSrAwksJA5PIeevBHQgkm7lHOoYNIuZSSPpohLMXRGdmaIj6jb9Ukv97N8Jy0HaGsZ/yOtX437V
 ZeQYwjyXeQCrgfi24Nna+S1elQHG/pAdhXMdZDP2pRz3bBbGyn+YScQtIdXjkPUwH8J4sKJTlFN
 dfpJcIolHa+8j6QJM/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512280159
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
 drivers/gpu/drm/arm/malidp_mw.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index 47733c85d271..498db114ee9c 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -85,11 +85,6 @@ malidp_mw_connector_detect(struct drm_connector *connector, bool force)
 	return connector_status_connected;
 }
 
-static void malidp_mw_connector_destroy(struct drm_connector *connector)
-{
-	drm_connector_cleanup(connector);
-}
-
 static struct drm_connector_state *
 malidp_mw_connector_duplicate_state(struct drm_connector *connector)
 {
@@ -115,7 +110,6 @@ static const struct drm_connector_funcs malidp_mw_connector_funcs = {
 	.reset = malidp_mw_connector_reset,
 	.detect = malidp_mw_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = malidp_mw_connector_destroy,
 	.atomic_duplicate_state = malidp_mw_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
@@ -212,6 +206,7 @@ static u32 *get_writeback_formats(struct malidp_drm *malidp, int *n_formats)
 int malidp_mw_connector_init(struct drm_device *drm)
 {
 	struct malidp_drm *malidp = drm_to_malidp(drm);
+	struct drm_encoder *encoder;
 	u32 *formats;
 	int ret, n_formats;
 
@@ -225,11 +220,19 @@ int malidp_mw_connector_init(struct drm_device *drm)
 	if (!formats)
 		return -ENOMEM;
 
-	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
-					   &malidp_mw_connector_funcs,
-					   &malidp_mw_encoder_helper_funcs,
-					   formats, n_formats,
-					   1 << drm_crtc_index(&malidp->crtc));
+	encoder = drmm_plain_encoder_alloc(drm, NULL, DRM_MODE_ENCODER_VIRTUAL,
+					   NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &malidp_mw_encoder_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(&malidp->crtc);
+
+	ret = drmm_writeback_connector_init(drm, &malidp->mw_connector,
+					    &malidp_mw_connector_funcs,
+					    encoder,
+					    formats, n_formats);
 	kfree(formats);
 	if (ret)
 		return ret;

-- 
2.47.3

