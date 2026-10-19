Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263A3CCF2DE
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98A8A10ED21;
	Mon, 19 Oct 2026 13:13:09 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B86710ECEE
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:58 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8PVmW2236788
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jDY4R6k/Nm1p1S0xEhbA3aSwiXunRz/voblMx4e/CvA=; b=adOHELmuvYRzRZ9i
 Tw2UQQThdT5kHnHFUtGCbgVNyWMhVfnmuNiOvJ4jfQ7peT3GUgn21K4MdsqlTrK3
 BepVjbg77yFm3daWLGfy8zr9FDr8BqcZRLag4NFlcnzIFPeKBnmncfft8rfmET8y
 tYXrPZs4DwQ0xjeEjcv0Do2ym4GkaN64zeaquqa0EfByTZCeR2KKCZ/VgguS8bXg
 K81jYSSecBPRLKNFb3L6oKMuwZkvmTFEK988wRopCUyOTyMFL9yav6dNlueUZS1T
 4LDtz93jFoQ3KYw1tx5GuIQj2sTEhy1ZW5ZOsFQK7sbyBZambDTBFVqw3M3UoRPg
 kDGU+Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x986v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2373e9b4so221431985a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415576; x=1793020376;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jDY4R6k/Nm1p1S0xEhbA3aSwiXunRz/voblMx4e/CvA=;
 b=jAe5l8we0FELes8FQ5hO+2RB1aSk913iXR3/L8KvzoiA5j7wSu2uXWibi0UR4pSvH9
 e8E8lYqUBGWL+hteAYRANv/ODRd8lFElEwGljahyo6yvZ3J+WRYzYEfcLIwZRN+Zphjy
 +iqweSTUQYP5FPkH/0cMmWRTPCwMKCTw6DJQblJtirpXW8EFndn5k3XkABlK04kLL1CL
 1yzL9nCiMNISPXOlWjZJePzIsZTVhrrB6qpxtoS9G7IuqtKqz4NoedSGi2xbE+JF2vcD
 yq/PWG43zlhJgldGaSLKbVEnvoiOtgx1NEG2BYB1vLOQPJmKAaJU2NhRniRoCGkXJVZi
 Mfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415576; x=1793020376;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jDY4R6k/Nm1p1S0xEhbA3aSwiXunRz/voblMx4e/CvA=;
 b=xJ3xRTICIYCHLJvADPq/2miWTbCWjzJyXD6DzZvvYw/V5/7nL14Kg9+ivSit+qMbpj
 oCTWi0PwUjQ8XsQpKkvEJehmApZflSagSNhX5154jM6TAyMemVGWSY+kS8fKtkldUrpH
 +cfiLdajDb2HDAS7D+gbVwtocsCjoMYp190LmsXgLfgMmT95U4Xg56z1uuB+abOcvy0Q
 J0ZI4gKVKWm8+5E4bp05XZa2hYDPojqoD+ZIsDjy25VGKHAGPlmDV/dWumu+W+oshUru
 WaD6DXN+2DhUV3YdNOEZFBM4KxUK0lWaaFxr2ikPWd2M1AUCDILVizOWsNHCwGRm5hj5
 jAXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsvOw23D74hUHenMMgOONFc9y2/DYtsY7d6BAlbj1dS9ZoDSwgTTr7LDTsLu//GQbf1YQ/1lcZ@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLYq1Y36ZYKObBjDpjBWJIFutmKMWdOPhsU/RFqOe++wLWjTO9p
 dOxTQ2lta7Rph2cCe8wIJuchD3Zrpyjaaj+P2IoRWmSNBt1YBaPtF9cyqor+S87eCQhOp+/45DL
 4e7PNqpSoVeRxpgqH/Qez24mIFy46M7vk8oSpOSjluYpZuEZu+rDq04CMUTPbYh474cVp
X-Gm-Gg: AYBFou0BB/qQLc+trTGuewVRAhF4/wG7MSjJ01FKjue0FVo0aHPuudRMx3OQRHjnPEh
 FeBg0316eplgLYp9eZsLyzbjw0GrXZnn1FNBWMyrl/ACt1mjhA3hpXKR+EViEjb1kjv0PqBzVp2
 oAJmhCwRAeQB3FVoynzQLOCXL1t5LNFRtZlmK1q4MXEGlOkdWc6vCvfvaf/rTx/NXD7alwOpyCo
 IvJCgg/Rh+QcLx5lDc2LgmtFzpeTKLs7gQtDyw3uKDz5XJ5J/r3Ny4jVinFO7aMMhY6NsR3b6fF
 mg0hAHFXTcJkNHl26kb+gqofsXnpnc6VesPZs/yILOM0OqWh0IvkolmFsqgXXWUE7rGksfz9Uj9
 2pRJZwIhFGVwAavu/tzxIYmRUHsIuCiECqn9r5doqhEZpfm5niKOjho4ffEudzLheK6mf0jarZA
 mlqijzxfdv14sd
X-Received: by 2002:a05:620a:1a20:b0:93e:a71a:5de0 with SMTP id
 af79cd13be357-93f29cc7983mr1348473185a.26.1792415576371; 
 Mon, 19 Oct 2026 06:12:56 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:93e:a71a:5de0 with SMTP id
 af79cd13be357-93f29cc7983mr1348462685a.26.1792415575701; 
 Mon, 19 Oct 2026 06:12:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:31 +0300
Subject: [PATCH v7 5/9] drm: writeback: drop excess connector
 initialization functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-5-d4288a26eb54@oss.qualcomm.com>
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
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Suraj Kandpal <suraj.kandpal@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4493;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QEKNuuMhXPGLAYB0Q++KZrnkiKauZVjWcJRHipLfbt4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1hdFkCB1I0mJpJakqeGM2PCp6MQe20cpN/1ZI
 prHiqRY8pqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYXRQAKCRCLPIo+Aiko
 1X76B/9WHBADywt3zJKdEWe7Q+mdyQgpR3U2HGDdQp2sC3yDHaRZpQy6ejouNHEitQaWAuJNEz5
 bYlUPNFzeRIBEoagUceaCcfEdBCvPHTQ2PM+RkP16t4MoWeRvERwOQNtnO/Q15L6q0rDM1POQOV
 hmM7RVVECywRMAqjvoXw6E2QCgpuYzqXuwJU9u81hSfHu9YlYDNWQPaGMf4OUtLEubJXz1/86FK
 d2J0f93x7H6R9hC4NLoAaJHlchceIMBtnt1mkwv+r19tIJ9IMIT90Na9bkYs/+Fbu7uiKsNXjxH
 Z7xZf2tg7P+QtxspdCaNbMEucndaLXupgnlsnXEy8+PyZr8Z
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: eLDhr1SY9I7IoHWO0plADPw6wHPSR7Y1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX0CIHlY32pMto
 CVtZR/fLyU7DQ17A/D4seu1fbm95T9X0tKu9v4Ko3J4B1extg5BJtNoI/RTyUPcPBIH4N2J0y89
 HH7HED59DcGf+hHpiR2PGJLR+fyLUHk=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad61759 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=3owybDqXPaZAjLikVYcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: eLDhr1SY9I7IoHWO0plADPw6wHPSR7Y1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX8q6+1eVo/GSh
 eOlI9+JvKrciuJa5QNZAmoPfvI917TqKHTyk/vENj7tyDR6WAW+1S/SRvC+FO4fSMIdltW7cEoj
 59sOyui3VJYeOcNsnZOjNkiVdiVhdE5gfQ/SqdO2TT1CoA6BSHjbAcdKUR2hQBOnQjIsJIK+Iz0
 z278dv9yNHg5Bb2o6aXIpUavPQHRSLpZ8mK4heKDrmgm2zB2maooFnrhyfwkPjg4nQhAW3lkZpA
 M4e5pSHbPq0fQijuyH2KrHjUAX2dCm4IsD/jHvgczCnuQpgwqWQMa9y9pcqDse+pffJeZENGVJy
 67H8q6PjQuQjF9x26fUTX/H6FVt/DbDujm24Q8UrScOkVFzM5kvzsn21XnjMJWuBnUc/wAIfjJO
 vYEJn3Ss1BT8tKRqgNTBeT28jiXAsOvLjU2X3SV/zqQbxk1j3toO6RCWKHBLJgypevzBJCLd5TJ
 m0h2Rb4ILA1NLOU+qVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190052
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

