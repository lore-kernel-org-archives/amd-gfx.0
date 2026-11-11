Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57831606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RpxXNdvG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=diskk3kd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C308210F87C;
	Wed, 11 Nov 2026 00:43:40 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC3A10F867
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:17 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAN8kY9570325
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jDY4R6k/Nm1p1S0xEhbA3aSwiXunRz/voblMx4e/CvA=; b=RpxXNdvGJNyU4xIK
 Yn23v4rvrdzJEam9XSUDSFW44xiRf1LyML+rXyR9eoxnqBhbDw6hg1kgqZiqvgTz
 6P5t4O4ixOBNE0E5HqVjTkgFBgjtsxo+0iJOmtmeOAYoOrjd/VvG9yWWlVI+MiTk
 wWXmrMOV6MLxuWeRNDQQLZS2Bzetp2LKAUSsksgrkAOdbWnA8MaVf7Kf8nf041Uz
 3dZbLT7EGlK6XIsuuE9HOMLNwkV2znTO+5pn5saAwV3t8i9eh2YXQNagP+mXQ1gi
 deG3MTm0keigBQeadD+AmDfEal82BJmpKrMGSd6uLchz0kVczbR9CwJNlpa0i29o
 gbbAsw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvcpeg8x5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-944138ed63fso467750685a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794357796; x=1794962596;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jDY4R6k/Nm1p1S0xEhbA3aSwiXunRz/voblMx4e/CvA=;
 b=diskk3kd7iYvNIO9TvQJP1VvsVewPxdZbUhKd+EcttoVRhrzCg/Ryies7pZwr5pjoR
 DqMjB5Jn7ZVJNJTvmwzy7HNTexsEeM7TU812Itm4MulCik3VIkKK4iwjkkf4hzHKChmG
 Bm0Kc5eoj5yslJsH8fThey3fmbpIKYaQ9k9wYJ3A27i/Qlp2hv4a8tRF/TMfHvlSmo7i
 SE674tfkTK8L4U3zNUL6VWfZFoUHPR0EAZx5ao2rwAz0JEDhAYNAirNK6ioHDony8p73
 puroae5msjOOewxRGEIs0184/rfmkse7O54RJNnHVT71y3MHQ13m22Af3YCPjh+jb0ny
 0sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794357796; x=1794962596;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jDY4R6k/Nm1p1S0xEhbA3aSwiXunRz/voblMx4e/CvA=;
 b=RBl9x5F91wlcEgSaYXfvYm7uAF1KKcHBfmGIG6sEf28IGJK0zsaRFfpfsBzzangNqf
 b80SKFfZj7auYueKLjtJRSuV1fQ2prKZYfLzb62rfRyj6UHI1DTGClLEfKROIY0kHJb+
 jLb/bCuAG9gKbp7oJTAFs9fm4fw0KPX4wnw4hIqtcG58jIwfnpNsqhOXm2o2Zxn2Li9l
 TUooTVNkJQOu/8+1gsM9CiPQqTzsW+4wDoKRP61AKtFlx/Sg/8aAtQ4dAxg8JolK4LAT
 iwI0mLbKmm6jGjlCYEFjUAjDdJLubDDv/wJznrUf3TbfoApNfUV1VKMH5fy+zD0EQtuP
 J7Ww==
X-Forwarded-Encrypted: i=1;
 AL+hErHBBKMMiAHtiCz+hmrGD78vLsjU4AvHJpmpTLA+0PhDUGb6uUMw0nVyWXrMYmsodskGrYjZJMNK@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+PzMmsRzsILKLn9pIWdIjHthuo4ZHhB+yKix6+BLdqiLkwGnyZ
 Zm++pbqIUmNGtqy8xJGgfHyuHvsYlymQtXZBvbS4JLAZj6eXlkMnaEI29NZfQZaM1G4Qzc9dtNh
 77dxgYhAP5Udk/rQC/CucZkRlku7QNKZdgN1sNSK68mu6KBRNXYg5kKm3KvLmuFmH4LIL
X-Gm-Gg: AYBFou1JbNYhuXwWw73gCdKNGdbIsatD1R/tv2cmlA6T6rxDOHI/j6oGhrH7Ee34ZkH
 3PNcub1TCfYTSvPJPptBfvT5du1EyqIOjuGobwYuHFInq+8WpYwpLDw3aWtBhiOoieA0clmGa4J
 WLphuBO71N6xwUwMCD48q5gpjG3D577hWv6F2xVHzM8xyr8fLOWS8T04hFEJo+OUIpwFI2t9Oo+
 bS3IYcK7XBzP1mNi5mg3ABCYz4cESt2jQfe5sgdmkg3usrZ+ZvDTE/BTy9T1Pmai2isCQfd93p/
 ConQ1tsNMqAaxz4rEjtl56NJlzGTNcy1sfI6CHkGUgTs3V8OAcwTiTupQxKUHDEVr4QXvnkSIYM
 zkhuObw6MQKOJaC3CWKLvWtM6MY3Wo30IO/G7dD9aJJ1yVkoXg269vSwI6oO2D/NQO+No/cLVPB
 UU5FmP60AJkimRwd/1QB2AiYGNXTiOtnBKPj/tb5TkDBzD1YnYiMXdXtsJPsUs7w==
X-Received: by 2002:a05:620a:4452:b0:93a:2e8:5aff with SMTP id
 af79cd13be357-947aff97f54mr127297885a.21.1794357796024; 
 Tue, 10 Nov 2026 16:43:16 -0800 (PST)
X-Received: by 2002:a05:620a:4452:b0:93a:2e8:5aff with SMTP id
 af79cd13be357-947aff97f54mr127295885a.21.1794357795520; 
 Tue, 10 Nov 2026 16:43:15 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092896d8sm7499011fa.32.2026.11.10.16.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:43:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:42:34 +0200
Subject: [PATCH v8 05/10] drm: writeback: drop excess connector
 initialization functions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-wb-drop-encoder-v8-5-62948ed87d13@oss.qualcomm.com>
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
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Suraj Kandpal <suraj.kandpal@intel.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4493;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QEKNuuMhXPGLAYB0Q++KZrnkiKauZVjWcJRHipLfbt4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq87oM13PxAyI1w9bgajKA46sMEgojpOcz29Dac
 FZ/7CEv9iyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavO6DAAKCRCLPIo+Aiko
 1cU9B/9UwbZgTFXDQaVSVNSllqahNLCWJgRpFNU+7Iiog9h+C/GQIabCL23UCJwXfsNB6SjPzRS
 MLaXT0agcTPNshHkhSLFC0w0JRAIVcghV6RBP6FVLX0NLR/U/4MLH4C/sEvX/pjfAMsMQgU5vZQ
 Ta9x/RX8m+DCAud8NxSzzPDewDXaUY1+oygjlsPpCPV/b9RuOfO/w831uCHn1EL7N57SrkQqMOP
 oBX383nwP/aUBhqT4XIi7x6OPH4StzxKATQp/oSF6XmYkq/EtQzUCFbADoUliE1+WCb3gJWS1Ul
 cnkMel2fRcQeVGefitJlHJBspLqie1TRY5EEROfVgsVgroM4
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX2CUyXqsbsYu8
 PdEWvGnkZk7BOvgpIFqS7zC/2A2ZLp0EmKJZzY4tDoyzrJi8YOQ+rNP8fO/Kl7qUJfQBZCi27Gr
 q8j4mSL9iqoSFR+dtqXelXCEgjPlI0kU50M6ChNeaEjlyRZBeUVeE0Ox39dW6K3YG/a9zg26dda
 GUx/jjOgdTq1qZj8hGW5nopqzaTYSRluL9usq6edBbRTPLJKnhTTYFIL7Y8EP2JijOvq3FPWYQo
 JZMp9NeooChg26r+KZ2GvAFlu5Ej1koConrLBsjQ7wiq2X5IA5ob2ZBeNkhsfaYBD4l0Tf1vzSS
 VQxa+v5r8+JREnCcCMiqyX8aMHgoTmVSgQg/3AHT7seYOcnL8ntt7spwQ93qEEct5pfYZ7mOpHi
 525NVSLE6rKJHzXpGmQ/4gHvDqkrmww+OMcZlbIHh30mW4WBJF1NWuvJ3zuSmMJW/uy4fhb7iP4
 Jszk3qqdNzOSXjROvcA==
X-Proofpoint-ORIG-GUID: pQGtUkwMM2V9_hfp245tvROWTo5K9d1J
X-Proofpoint-GUID: pQGtUkwMM2V9_hfp245tvROWTo5K9d1J
X-Authority-Analysis: v=2.4 cv=RfAFmFtv c=1 sm=1 tr=0 ts=6af3ba24 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=3owybDqXPaZAjLikVYcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfXwP5PkXq+x8pr
 PB3R5N4bJ1f0hsXe33CkexrIx8gZgimxUwFkTwD9hq/0RJCeAQOF/0biqIKjSnwfx5ijKJ9Rkqm
 DXeCHGKoLuTKBCmVKubxa3v0yq1jbLE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110001
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

Now as all drivers have been converted to
drm_writeback_connector_init_with_encoder(), drop
drm_writeback_connector_init() and drm_writeback_connector::encoder
field, they are unused now.

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 55 -----------------------------------------
 include/drm/drm_writeback.h     | 18 --------------
 2 files changed, 73 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index b4a002e6d043..683da368e339 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -148,61 +148,6 @@ static int create_writeback_properties(struct drm_device *dev)
 	return 0;
 }
 
-static const struct drm_encoder_funcs drm_writeback_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
-/**
- * drm_writeback_connector_init - Initialize a writeback connector and its properties
- * @dev: DRM device
- * @wb_connector: Writeback connector to initialize
- * @con_funcs: Connector funcs vtable
- * @enc_helper_funcs: Encoder helper funcs vtable to be used by the internal encoder
- * @formats: Array of supported pixel formats for the writeback engine
- * @n_formats: Length of the formats array
- * @possible_crtcs: possible crtcs for the internal writeback encoder
- *
- * This function creates the writeback-connector-specific properties if they
- * have not been already created, initializes the connector as
- * type DRM_MODE_CONNECTOR_WRITEBACK, and correctly initializes the property
- * values. It will also create an internal encoder associated with the
- * drm_writeback_connector and set it to use the @enc_helper_funcs vtable for
- * the encoder helper.
- *
- * Drivers should always use this function instead of drm_connector_init() to
- * set up writeback connectors.
- *
- * Returns: 0 on success, or a negative error code
- */
-int drm_writeback_connector_init(struct drm_device *dev,
-				 struct drm_writeback_connector *wb_connector,
-				 const struct drm_connector_funcs *con_funcs,
-				 const struct drm_encoder_helper_funcs *enc_helper_funcs,
-				 const u32 *formats, int n_formats,
-				 u32 possible_crtcs)
-{
-	int ret = 0;
-
-	drm_encoder_helper_add(&wb_connector->encoder, enc_helper_funcs);
-
-	wb_connector->encoder.possible_crtcs = possible_crtcs;
-
-	ret = drm_encoder_init(dev, &wb_connector->encoder,
-			       &drm_writeback_encoder_funcs,
-			       DRM_MODE_ENCODER_VIRTUAL, NULL);
-	if (ret)
-		return ret;
-
-	ret = drm_writeback_connector_init_with_encoder(dev, wb_connector, &wb_connector->encoder,
-			con_funcs, formats, n_formats);
-
-	if (ret)
-		drm_encoder_cleanup(&wb_connector->encoder);
-
-	return ret;
-}
-EXPORT_SYMBOL(drm_writeback_connector_init);
-
 static void delete_writeback_properties(struct drm_device *dev)
 {
 	if (dev->mode_config.writeback_pixel_formats_property) {
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index c380a7b8f55a..879ca103320c 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -24,17 +24,6 @@ struct drm_writeback_connector {
 	 */
 	struct drm_connector base;
 
-	/**
-	 * @encoder: Internal encoder used by the connector to fulfill
-	 * the DRM framework requirements. The users of the
-	 * @drm_writeback_connector control the behaviour of the @encoder
-	 * by passing the @enc_funcs parameter to drm_writeback_connector_init()
-	 * function.
-	 * For users of drm_writeback_connector_init_with_encoder(), this field
-	 * is not valid as the encoder is managed within their drivers.
-	 */
-	struct drm_encoder encoder;
-
 	/**
 	 * @pixel_formats_blob_ptr:
 	 *
@@ -148,13 +137,6 @@ drm_connector_to_writeback(struct drm_connector *connector)
 	return container_of(connector, struct drm_writeback_connector, base);
 }
 
-int drm_writeback_connector_init(struct drm_device *dev,
-				 struct drm_writeback_connector *wb_connector,
-				 const struct drm_connector_funcs *con_funcs,
-				 const struct drm_encoder_helper_funcs *enc_helper_funcs,
-				 const u32 *formats, int n_formats,
-				 u32 possible_crtcs);
-
 int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
 				struct drm_writeback_connector *wb_connector,
 				struct drm_encoder *enc,

-- 
2.47.3

