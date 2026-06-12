Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28389CD98D2
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4F410F637;
	Fri, 12 Jun 2026 18:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JDjJywkl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NACSwdSw";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A40010F63C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:31 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGUqHi045987
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QBJeYuGqe22P6k7nEfBN02fWJOuRECh3h974+RTUQts=; b=JDjJywkl573Oppgc
 a/m3TBe+6a2JfecT9b3uIzacmtAK1q8qhgZtpoimZPEHqTfkTmpmVogPPmbYys90
 cAwU+ANkYhc6AwLv7Pj3Ahz56Thyb+tH+qBa6uT/nEm32ARE/RlGwuSJ5Pdoa2ts
 P63Xf2JKBP6W12t4s6guCx1pTC0JZMeRAXjiw3M6Q6l5l8XPzmrA7p++0Qnjs/LO
 bvfOVyOu21xR7Avbo3pHgk+B/WgXUj8fx6YQy7EoFRZ3BkkfxkZhNgJgXqtfcb0E
 qrn8c7Aot/kKThewvIPHA97mqjq2zdeuZdMglDGJ8eSUA/tqJwHHG418RYVPp8QU
 tp/B8Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er76ek2gn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:30 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ce9de04835so31234736d6.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289030; x=1781893830;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QBJeYuGqe22P6k7nEfBN02fWJOuRECh3h974+RTUQts=;
 b=NACSwdSwBc0mUg5dhzpEbS8wsjrmbMVD2NBgTIzfN14f9hPHGfqis2MufGhJgAdDmW
 GlquRy6OHLSi8v7B8q9Go9/9OZZe8SMtfLhvnwLuSdvOhlWCPpAfCLTUneTF/A9fGJXJ
 jwNzuggJlOYNZQyi+G8h9vmFVaJMPo6nmBUxzwPWhBjq+SNXkx579F+j0PsY5g8sYeiP
 okJXn5fYE2LChNBFX7W//xMKkJQg9xunI4eEi0FmL/Bty0lx/jxpzG7fKarPEUujx2qW
 0Ap0o1mh0CjUGoy0l4KemzYOX3z/r/nl5u+y/LNV5+Pi+v7k7GwokHgjcWN+mp/zoICg
 n1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289030; x=1781893830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QBJeYuGqe22P6k7nEfBN02fWJOuRECh3h974+RTUQts=;
 b=eb0v1qLr8FK80T7wIcKd6egtAa6sRnvuYwWSkw955t8XIUZ3fMGp+ReEh1wqfHbYAj
 JNonZNWeiMi+69eBJtslShBiMIMn3pTW/AVHGjaXnwULyMjhlbkZe6cXN26BV+Apkg7b
 f08EmiZufdOlCJHAObvnjvwHbOdtouZpooqNyGtaybQlUa5cItdlbNgkV4NR3kV53iBq
 s4LjLkp48EISgpeGOk3zt3/J8snUBWYM8KZCYW5RmhnPH9ZLctLXu+MabXMk3dFdZiV/
 XDYmUdMcpU/x34tKRNIoqqvDdZS0rPQoEfcP063EpS7J8ZZlBYDhiJMDgyY62s++bnJ5
 5ACw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9c3irIEBpyC7khoP3y2F4Y1KAFsFDtXyReiLN/fuTWpmXxKM0UYvzPAOeKH4Yxd1cjT+9QpA8q@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwH9MWzw/pOQO4VK5nc+JaH4RZl+eCBcdBwfoh+DShhDFL3hy/a
 hECAR7798EMmo7uftnTHeq1d5J/vxa27sunkdXh9ytWiD60MAGDjFuPb4Pgc+V9fS7hLu4ez/tI
 feQZNWWDv3uFRJmR1o65IYFBwxi5stentKxjPf6+GC8/ejAfgx7rPC8bG74uWGYE58gN8v058Wf
 dy
X-Gm-Gg: Acq92OGZYc3jj/vn9nakRfWGYDwP1ShrQXgSvNjXXDq54d8hZPcNlaGEqkv++0vgfja
 idNIn2Td98iqiMubzhU1/qh+RIXfDBgW+vUnlEInoBmagSXg74VGi4H0uEO/C+CZNz/+cildtWb
 uOoK9XRJp/xvpSW26h7nYBBQTCD21Asx5eGOwIdVBFTe358ZFEyn85dpJYm4LS0p/yerOaiV4o5
 uwyl1GGhdbeuITMVePhku8ldFTCUh+NAXr737j+gTy0Salgbh6+pdTtISdv7+oJQGPBB6nz9Ena
 FkVIzMt3sX+Z4FXwUqYXtDtLsWp5HHZEZHrVo3p+DiFKDDKg8Jt3LB/jxCATk7sVZVMHf30j0SC
 iZJUzyfK2UJ+JuX38NDfg74tBTj+0KzUta30O5i7EJ1kwzJzeZp85ziWtTBAwuLqRIYGE+V4ADb
 DSohUT/B4RLYen12WGLKgBQF0c7SiS+qJ/nsc=
X-Received: by 2002:a05:620a:438e:b0:915:2b46:eec0 with SMTP id
 af79cd13be357-917efac52d5mr130401985a.11.1781289029659; 
 Fri, 12 Jun 2026 11:30:29 -0700 (PDT)
X-Received: by 2002:a05:620a:438e:b0:915:2b46:eec0 with SMTP id
 af79cd13be357-917efac52d5mr130391585a.11.1781289029193; 
 Fri, 12 Jun 2026 11:30:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:15 +0300
Subject: [PATCH v6 5/9] drm/mali: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-5-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
In-Reply-To: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Suraj Kandpal <suraj.kandpal@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2921;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=EekG2aEhKLuUzGk/MefJaYhFv2SLpgTabnBvDlYdrFk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqLFA2/CqgW8HuyhGiu6mrDQOaZfrC3PXXYFzVN
 Bdfw2R9NwqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaixQNgAKCRCLPIo+Aiko
 1VKpCACMjzF++leJC1KZCPjZzLnYEoWLvNMfjha1yB3vZJDN+Gqn1YkZEgAJdK8jmV1tS9Rbjn4
 hGjhf1aRkpmRYnFRnV6o8k4JDpOyKwyVh4y/cx6eGcsJRA+wJ0s+JETrf9hdKaZ3b7NUiWYiYKC
 /4Elx9R41ZvK7BLWGrPzY7fn9MR2UmVTSulSrdceb0yoEapLzh1zKSNdtci5eKN3ejmx53WQIY1
 BWz66qjliBJVWDoYBfaYoKgEeAMDmoFgicMjFse8+5/M5vVq1bPshcIOVK0obX01xrE5zNmyZfZ
 UuQEkfMTQdZewSOEO6B0Dv6Knmy+ogKMWnz5CnhkeoTI0/rA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=O94Jeh9W c=1 sm=1 tr=0 ts=6a2c5046 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=rEXDA0v2x0ZtafRnR6sA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: WL4ka_YvMjF2lHKywrq8xCskJuq3HBPK
X-Proofpoint-GUID: WL4ka_YvMjF2lHKywrq8xCskJuq3HBPK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfXwqU5+frijLgh
 SZV5aZfxTnEY9BTnISCZmE1bK3CSnhiItJP53mqaDvMafKyICrfnCOekVdkV7RbNNF7m1WggtUI
 U3o1CwH5MFJbU2Fn5eqjMiRgNN5Pq0PzBjhzTX8dms7HUwRzNLYoSpE78nVpMGGZlpmVmUtS9r2
 ln0lk0oSknyb5FCzGPq1UufZNlB1EFb1iPO9Rv4G1xH/gjYK4MaD/uG9QkBZ4XTDW/lFpydmCbh
 uZAOQsDihLez8ICUhmCMUbPTbePxSjx74m62emupSpWGXo2pBDp6K1HHR9N/1S6AQBiw79vvKq/
 nJvJCZf3GzzDjk1ulLLzjGbUUCh01Pvs1YRstn4688pHUcFzBmF6eOBKWsAVw8WerjY8uQzquX9
 OoTH1Lo+Vt/AXPjtSv6XQCZbclyg/4rfdMvefyNyEyGE6pVhYL3+aGUzkY8W8bS6qRkc5poO6o1
 RSHX2uob2jVstDp3VCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfXxkBIy55edrJv
 WNMaBJIxHgvjFZMkruKCp+quo40K6RBSwBP0at5OEk0uOE/Gi/JAiO32qWluFYZeWlh8gpdjyda
 MhDxk8bmImDBViXShlaKeXOMdqctF8I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120173
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
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/malidp_mw.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index f8be65119e3b..cfb7300e3e95 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -84,11 +84,6 @@ malidp_mw_connector_detect(struct drm_connector *connector, bool force)
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
@@ -114,7 +109,6 @@ static const struct drm_connector_funcs malidp_mw_connector_funcs = {
 	.reset = malidp_mw_connector_reset,
 	.detect = malidp_mw_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = malidp_mw_connector_destroy,
 	.atomic_duplicate_state = malidp_mw_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
@@ -211,6 +205,7 @@ static u32 *get_writeback_formats(struct malidp_drm *malidp, int *n_formats)
 int malidp_mw_connector_init(struct drm_device *drm)
 {
 	struct malidp_drm *malidp = drm_to_malidp(drm);
+	struct drm_encoder *encoder;
 	u32 *formats;
 	int ret, n_formats;
 
@@ -224,11 +219,19 @@ int malidp_mw_connector_init(struct drm_device *drm)
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

