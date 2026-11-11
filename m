Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F4E60A5BCA
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qu85sXKk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f7hVNob+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9F610F862;
	Wed, 11 Nov 2026 00:43:25 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A7210F85F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:14 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAMKg7F501853
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tYkh+z66tNbAJ8FVwlggHZ2adHY5L3co1eCKtyvHahg=; b=Qu85sXKkU9xLdMSG
 0GdQTJjN/yjDowV2Yq2N76Fxh1YoihQsvJ/NRt+FRmlw2PvQv2FJTUY1FZ4hXq+K
 Wmq7XofYgmHzeA4hqPpyK127tENK4iIGI/wDTZsAJFk27BWTC65ehkEilO8bGuSy
 SkLoFNZS4QmULEvNZ1NNRpX0sRQtL9ojDC2cQua+/WqjelIw0KwPVjjR7hbP+BuJ
 +6UBzfqtPb4iGmOAJe6SDuNMJOXNEjeOY6y4Is+ST9rPIGkHHPA1t0lXIlKZbMH3
 SGm86B7aTK3Gc4A77iV+JtlpCThVTpVJaFEcGB28W90CUBSvgvCEL/2s1Mtj/ZWG
 PWg9hw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huy5dbstd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:13 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91eee6fa56bso20354436d6.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794357792; x=1794962592;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tYkh+z66tNbAJ8FVwlggHZ2adHY5L3co1eCKtyvHahg=;
 b=f7hVNob+E5PvDh6T0HVae4kqzFn6cZQgRqWkl54jkSdp1vJWWyFP/CWL8Sj5qmx5R8
 71QwrYmqjBHJE2XVXVzmxCdiaVCfjunrg0Xz8l0DcfNPFLrK6lq2dEscAJwZx1V7Acue
 azTE01bKy+H2c064KfTBs5EwpHa1ZZvhJmIFrvBcwOUYIdBSQCoGfTrQYPery9NImyJR
 tVHsRWZGHVr7WzrbYp5Sj7GFm1YBog9dncuTjAQJ9z2Vd5H4kytczlulTOkNmzdjVlwF
 xMnpYLg5DyC8S4wIzrEYtl/ksS51ssk6OSIZWBi/i0hWWt5hKbvIdfnKRxi+JGfob9eP
 arng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794357792; x=1794962592;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tYkh+z66tNbAJ8FVwlggHZ2adHY5L3co1eCKtyvHahg=;
 b=mhQagHYDNtSOpt/qqXggq26NPPzFIbtiqJpNIjRq3noJoxCGMyPP71oYH+Exrebu5E
 W1eU49rTiPRT7P2LaQaVV2oX2+UnAv6gWNFte9oMIV9YA91+0PBvGfcqvFn4IJUIA452
 DQSsNGkF8csbtQ8J3NeiiO0Qj3xVkbAkEz4XgR2RPQJ2GWhLOndUzOQXtNGlGNQczAUd
 tvJmAIuXgV4NwzVT5IVLmhNydvlsHkzTYwrgYhK3rTLzyNC4PCJEIdxkgpFYMNjN4+7z
 VptZzul3x4evs5E2SBZR7OBvtVi/LjXkaXHXPZhtvtZSXa5acobZi3m/OS85Q5kz6FQf
 hkqg==
X-Forwarded-Encrypted: i=1;
 AL+hErECvbyLVF3EdAjyq9pJO8uN2FSpL+6jIdoTRD6ErwYGEMEinjrJXmSUG0JyCo177rdNYlMkE7Vw@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/R8jT2wAZD06wqcvRJuJF/eSNxiu5btG+QLVS24PRGEIVmgJzE
 9KE42CNxFv+fLEv3eBx2xXM0ZiMqpxXGn0Ed0TbWiDgHXOLL4bx4geOawfExzpZZ1GaHpb5OUt+
 myflQ0Wx+vy7SeUnzWC9j6fjLXv4Ta3My21dxBmCjyYmHWHsTTgNPtjGYsklL9n+Jp/L0
X-Gm-Gg: AYBFou16eSTBkL9Yuv2QpFuaMb/nBtLkkVO2BeaOr32iJsu0IJSt7ZrS0f5QfmCd9u8
 wk9LQMJYLDetyUAmSY1ebw+MKIgVSdHQZpbYXP02BCpJXqje+I99S6l9IXqSu7Y78m1GlqMKVxr
 JNTAR/IHzR4esk/0IbmzZZPUmmqbFG6M3FLz01Onp7DrlSe6h41XG7d3mGJjEer2Vo710dJPbmo
 gDUhulxG/ARxpHQVAsL4C91Z5w8cBuPW0RKGWGwZ5Oliuh/55Ixl5+8Mj9MIefwPlTIy03qf1Vt
 HE2xcdXOLNRHdEhhSoAmBcS9qXzNL3RBaYHEM0dIZu3skswn6gAfrmB6I2zNFCRH0UA7yqAX55e
 njWLz1NcFg1bf2JdkUz2RYJjTsf5Dh1ZBqbx6HX91YnEO8OGKrMmQr/2WRT3SY6S4FBkw9Mo6FX
 FNldZXkfWfmJVoP0/AToScsCBRuirFOasiMVEiiAFjEJF/4XZprQ7qL3zDv4/oDA==
X-Received: by 2002:a05:6214:6591:20b0:91f:2f6:75f7 with SMTP id
 6a1803df08f44-91f0402b509mr12798326d6.19.1794357792049; 
 Tue, 10 Nov 2026 16:43:12 -0800 (PST)
X-Received: by 2002:a05:6214:6591:20b0:91f:2f6:75f7 with SMTP id
 6a1803df08f44-91f0402b509mr12798036d6.19.1794357791417; 
 Tue, 10 Nov 2026 16:43:11 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092896d8sm7499011fa.32.2026.11.10.16.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:43:09 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:42:32 +0200
Subject: [PATCH v8 03/10] drm/mali: embed the writeback encoder in malidp_drm
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-wb-drop-encoder-v8-3-62948ed87d13@oss.qualcomm.com>
References: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
In-Reply-To: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2801;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=E8fyyRc1CUF7FSoEm8fh0yWXyrNQOVyyvWVqx7oX1Go=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq87oHuW8SCWzKcZcT8xTfb4OdrADN2PwQ4aNlT
 eNqGbQohZuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavO6BwAKCRCLPIo+Aiko
 1XVWB/95Fm8C0b3IbmcoRzt1brzZIQcMhBStgGGk9rF0UfIzfwbnxXo3Ho/Yv5anFOpvp7ghDDc
 /XveR5mbKD0lhwGgC+HdhlLQm0szbOY/secPillX0Ya8j9UOFdreJYhv7XpOozMI2DufOWFJbm8
 YYlFT5m8kHwLcqqoBbRkwuQ0iUQK2AHCZkeAtYKtYIL8s9tmZhbTxCwL/60XBSKXodgn0aNV4Ry
 Yk3QyHvm81b5nC4GYAVxQpaHreE7EEcN9diCiZT2aMiO/j2Hm/ZKP79hLIxwQGO9K8FudG9rssf
 pjHrio9g4ZJylmbr8GjnA72h1BOQIfq4Ep/mo2qkpM9/reXs
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: H0faDj5xs_FS9yL-1M4cGGSDMD4racE7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX1DlIE/PjiyvA
 jllybeCTiAq5+b+QiTsN1lYynPXIDoBBNwdMqiookaEz/X7rXA0NyV7YgeeQyOaDQiPXsEI0V4d
 z3tW4rjFzLtz53XrXFfSUJBVSwS1m3Y=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6af3ba21 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=eAXNdYJVcktrDQ6TNNUA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: H0faDj5xs_FS9yL-1M4cGGSDMD4racE7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX9dNrffJpE3v9
 2MDi02hmnZALSZXi540XOOnUXGGG/Mibdq2QQ7PBDYOL/38ExL0CcJ+j/MaTV3VEstqy2pvGI2x
 nk4MSQ6X+zZOPSv8ldmwmt1WR/y+yniDu4qmJ07RpS9U3se1/Us1y63RboseJkDjNgvkQjBOX06
 iuymPMzQKZuifw82HpiC6TArmlnmVwlFeuxckCbMIwAF08MJKtwdKH1zwaBwbln2TDXSGl9tnnX
 VDouaiFds0XLyvjfcvBtaMY7ODJBnWtBFShaX8V8wESPjI6Jmf7yDtgeK5A4NhQQVa8RUoYmv0g
 mS324hnT07vBjdGpAfi73AII+YQp8nlvq4VXjcc1ShTZTWV+CZQxXpFo0na8vsyCPf6nMR+d5Q3
 NnadMBGjLg5Q+6eV53TKfh323prtX++qA0429Yq1qMpWfhWvuD4NhMwCC769+r80pZpHN5dl5mH
 Ruu8x+CQC1pnBSu7wAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110001
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_writeback_connector_init() hides the encoder inside struct
drm_writeback_connector, which is the only reason that structure carries
an encoder at all. Every other writeback user already owns its encoder.

Embed the encoder in the driver's own structure and register the
connector with drm_writeback_connector_init_with_encoder(), so that the
encoder can be dropped from drm_writeback_connector.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
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
index 8d1e1e3a6deb..889d0d1db85d 100644
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
 	.atomic_create_state = malidp_mw_connector_create_state,
 	.detect = malidp_mw_connector_detect,
@@ -223,14 +227,27 @@ int malidp_mw_connector_init(struct drm_device *drm)
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

