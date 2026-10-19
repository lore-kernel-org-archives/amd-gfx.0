Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EFCCCF2DB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71FC510ED0A;
	Mon, 19 Oct 2026 13:13:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6503310ED0A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:52 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Otll2752271
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qnQs2qSt8cC/wqbL3vnbFklmJgszfebQtqNB+FXPcw8=; b=BsbDlBmjlguLUMMa
 tQBrFin2yVFc6rFvxHU/4OYX7vcwxU6i4szUBfbLxUoeI4QnHUS9c+lsozdkbMPr
 Cp04AUrmejpwfTOM1zZOYGuwaG28cqXcmeOsDNXPf9tFUDNoGaltM2dGlTMoIlSV
 AP8VW4hNIwmF5E4SUUSytJAf3CNASzw+Cq5Z9kLH0ktzmJZkHU1EmKIhXUA4ZJGW
 4igAoihNFOF19SRm5uRNnOvZ1xpfZmMiK/wC3zQGFenNleleFgZ0r2zTuHX1yXIU
 EwyGTPWsU0tOIYk0NO5OxaL9mXs9DjXnjKoRcit7wTdGonRp97KRFpXWV7i6YFKm
 5LS/Iw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48h6y5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ecdc701a2so241092385a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415571; x=1793020371;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qnQs2qSt8cC/wqbL3vnbFklmJgszfebQtqNB+FXPcw8=;
 b=YSIKf0cq3WzLDZtRV4ceYwwlAVaU8vI70hZ+mSE7alrU33oOUPiECi4EKpC5SXwNX6
 /TCgXoxxn4OhSbA1AwBH7fbWCgqhUg05zur8bz0Jo/XEXUyVzHj4c7ewkepO4aTOC9CB
 xsSd6PzmOJChLCc9HuK5yq2IKcBS+lK4hGVWr3XaQaGbwbdOhBd6Quagd1ug/sEETs4I
 wdL6EwjPZcJ6NVCl3Efvw2pqAtvSojsTTTBZ9NK29dmhQzzvHDXQlO8GHr5hXnATcjeU
 iDftVechi1F5MKI2LM9k39ZfYTQunFBUrtM0gou7CovtNrAKzd15xPDutpIyiESjLl/7
 GJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415571; x=1793020371;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qnQs2qSt8cC/wqbL3vnbFklmJgszfebQtqNB+FXPcw8=;
 b=h0RGLQxES5azV+A+8QlTIWN5nhHDpbXiAGwLqbqfVASLT/+zrSXRoWsLm7TxwqFV3n
 /+HySqoZrh9+9GKSZc34PokWfqNOezg/BZTQoLlNcLLBfKfMKXFvgBxe749BmkH2vuhv
 /4YNzRjGxT/TxJviXY8C3tvP5CmI07RlRDTfujIWNlkP7dVo5Qa1I+dXMf3q37ijFimh
 IuJBGrQ+T5vupCYClRxgD3Oso7dt2fk/yxMkK1BBF9idyEkys6OQOG06aiDmoCIxU7Pq
 dcsBUWrnxSjal1e1z9Yup284CgsTZw83gv+h702g16qHDnAPc+xRAZsKKniJtb9jJ2Lk
 N32A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxk2JSY6HbY/UJ4pxU+wvKX3/lX627JAa2KcHsO857llB/LI0GRlCTfHqdo1r0wv4a1wLwbMjq1@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJHVIK8V195wxGKfBR6u/Imd8aDqBfxUVYbCvmu7wEYMgqSEL81
 6LlpPgngGReF487mjjdM6cR9IWtKPdJQbt81TQGJFrXNE+Wx0B95cOOajKejzcXFMYBhu7Eycc6
 7sy7LUadhNwr/UCZ2+Pxy6JMQuoFd1EPhBybAKw8YTa9J39FlVZfHcaVEsXJEAroSRLHi
X-Gm-Gg: AYBFou2Uu9sncSUs9prGm5qVgii/ygR/pAAjJug1na5+hF2+korSWRYBxO4G0/YPUh2
 SIteMwR3LatyL80NfRxa9fINNFH2yHJW96G9/cdZ92nC9ULUlVNrOYwCUKge7kUH8VkmGgu0PAM
 dvOPP7fO+aBoT0+gDcWdZ12opN0kKriVu49EjLNzYsRe8ZMArMWwt7z37uKcUsksBsp6KJi70W7
 W/DNfhWwjqOtSo0ir6Klub1WJOrfO3zJgI7NZ0OEOsZpDX6Qm8dBT1RfR7QZs8Y+eUY0gC7cIs9
 80dzl7mFcYbGYszUDNuPdhrBlruI03+Z8Ja+aHvuHQtaktEqB6VtNpbn8jPBu/UHKy84kU79Fsh
 Zx7XlmQfNVioGcKPiPcDXkto0MCvah/3NMtbQeFSJ/+3kA5qkFCD3A+Sjeg3SwC317wigTKkhwl
 CegKXSZw2njA4/
X-Received: by 2002:a05:620a:4547:b0:937:675e:2903 with SMTP id
 af79cd13be357-93f29cc8308mr1353836685a.14.1792415570512; 
 Mon, 19 Oct 2026 06:12:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4547:b0:937:675e:2903 with SMTP id
 af79cd13be357-93f29cc8308mr1353828385a.14.1792415569919; 
 Mon, 19 Oct 2026 06:12:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:29 +0300
Subject: [PATCH v7 3/9] drm/mali: embed the writeback encoder in malidp_drm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-3-d4288a26eb54@oss.qualcomm.com>
References: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
In-Reply-To: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Harrison <John.Harrison@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Brian Starkey <brian.starkey@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2750;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=A0wfyHFOzQwCKryCN1GwVCfzf30IhVdazkuopORoCc4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1hdEPEImUSMcnrRjUjk7IDgo42ntW9qMBrC7d
 3tG/h41nFOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYXRAAKCRCLPIo+Aiko
 1YE8CACaMMZouBjtqQ/KT+MNhbDcKLUXSgyW5PxAnAifLGe6PVkV5NDaOR+8BMd8EJX2J/Y+L3b
 0VZq+zV2XcWpHseoIJDke6YAcMSY2Z5NXxRrHwe4jimqwDftI6ubRIxigZCuBLwdzfuIJccjME8
 j9n/Ieln/GBRABTnxDlhuRJbpbalAfqkypE9tYBk4hYwdzfJjsgg01nzJq+dg3PZ8K3W27hTKBS
 m9Xw6LMHnXB2ztge2jNQS2ExqsNymPRWxIH+7qBPVJjc0XDMOII/63KVI9EONPJ+ZL8MkEWwIaP
 JwONLNaQXNg+QKtS9vq7mQAU8Zqtg4L17PHmDlmD2FHosfJi
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX1cyyt03zRl8O
 2irA7xkKJGelgWTHehy+TjEWsPx8PBOfRaJOtIwJW0bZUFeLMLmsPfODiQxl78Uv/0a2ZYsDhsF
 NHIdyDC3Cd6+PeBSo2rKB+kY9Kd7+Bvr54jtvBxOedwSFGuC4FA5Q8YrvCHWgdlg5GELqUSzP0Q
 NsGM92q+c/8/+AKbYz4O3RUnoGOQFfSZIcYQfV29c7N52UootFKYP1ef9eIIZ9/4wHd+R1PeEJW
 l4LK1raLLnOFRlB7+NbPkCxXbnYzNCbgixWTJ+znSKlmt7pocL2tcazl74m1I8GfK6lQrzz9Xxp
 zJfuHoxWFHX1KY2+mBZiA9H5dAw0Dj5isCwoI7/HIwSEQguXheCuZ2geIVJ+GNb+ObZo4U4g0O4
 3PC019lsma+AKJKeajaas+KyR4j4HIqpk4wtAGTbonXV6LT65D2vTOa3Aa+Ky6kANkICT95ZyrX
 IDt9IYMhvduXbegH8zA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXwTMcf8/vrc9w
 MoWfgF1VNSu/OOnX9Fr7neQKcKF+HA/9e2xNPuA+wpipV6ewNVi7HQPvCbUc0EVSEzIKg9NtktK
 8Ng7x83M09ZTDujMCA8smjcJMfD74YQ=
X-Proofpoint-ORIG-GUID: dAcl8tdUT-PGNIjTJ1FhW8kOGeFh3_no
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad61753 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=eAXNdYJVcktrDQ6TNNUA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: dAcl8tdUT-PGNIjTJ1FhW8kOGeFh3_no
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190052
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

drm_writeback_connector_init() hides the encoder inside struct
drm_writeback_connector, which is the only reason that structure carries
an encoder at all. Every other writeback user already owns its encoder.

Embed the encoder in the driver's own structure and register the
connector with drm_writeback_connector_init_with_encoder(), so that the
encoder can be dropped from drm_writeback_connector.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/malidp_drv.h |  1 +
 drivers/gpu/drm/arm/malidp_mw.c  | 29 +++++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_drv.h
index bc0387876dea..64610f2d23e2 100644
--- a/drivers/gpu/drm/arm/malidp_drv.h
+++ b/drivers/gpu/drm/arm/malidp_drv.h
@@ -33,6 +33,7 @@ struct malidp_drm {
 	struct malidp_hw_device *dev;
 	struct drm_crtc crtc;
 	struct drm_writeback_connector mw_connector;
+	struct drm_encoder mw_encoder;
 	wait_queue_head_t wq;
 	struct drm_pending_vblank_event *event;
 	atomic_t config_valid;
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index f8be65119e3b..7f5e25adf999 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -110,6 +110,10 @@ malidp_mw_connector_duplicate_state(struct drm_connector *connector)
 	return &mw_state->base;
 }
 
+static const struct drm_encoder_funcs malidp_mw_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_connector_funcs malidp_mw_connector_funcs = {
 	.reset = malidp_mw_connector_reset,
 	.detect = malidp_mw_connector_detect,
@@ -224,14 +228,27 @@ int malidp_mw_connector_init(struct drm_device *drm)
 	if (!formats)
 		return -ENOMEM;
 
-	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
-					   &malidp_mw_connector_funcs,
-					   &malidp_mw_encoder_helper_funcs,
-					   formats, n_formats,
-					   1 << drm_crtc_index(&malidp->crtc));
+	drm_encoder_helper_add(&malidp->mw_encoder,
+			       &malidp_mw_encoder_helper_funcs);
+	malidp->mw_encoder.possible_crtcs = drm_crtc_mask(&malidp->crtc);
+
+	ret = drm_encoder_init(drm, &malidp->mw_encoder,
+			       &malidp_mw_encoder_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (ret) {
+		kfree(formats);
+		return ret;
+	}
+
+	ret = drm_writeback_connector_init_with_encoder(drm, &malidp->mw_connector,
+							&malidp->mw_encoder,
+							&malidp_mw_connector_funcs,
+							formats, n_formats);
 	kfree(formats);
-	if (ret)
+	if (ret) {
+		drm_encoder_cleanup(&malidp->mw_encoder);
 		return ret;
+	}
 
 	return 0;
 }

-- 
2.47.3

