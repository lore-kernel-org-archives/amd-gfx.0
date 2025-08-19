Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EB0CA0EE6
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 20:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870F610E683;
	Tue, 19 Aug 2025 20:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hkRl9LDi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BBF110E685
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:33:17 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JFKtnb005480
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jvX092/V9dwE/NzPX2FObQHrrP1GpzHfFltQW2JSWGY=; b=hkRl9LDiymd2qGpZ
 Cbw4FW2f9rJF0wEieQzqe8TG+Ys7gFFG0JZaGsKgR0sfPf77GWV7Nm8yaraOwlyH
 Kq6tr1C9+J5z2Ty4C/sqb9rtyrRIeFQcmlK3zTL9Na3RYWLHpncroFVikj5Rh5nY
 6FM8FFtpTX8kcdOW6Vb8l4gUCDCOvGmjFPioVnU6l37NjsUmAbJji9+PelgXAjUi
 w4Q9mQ9PRYgWdsLoc5GumltwCBTYnkp5rqgjh7iwial7dBsaaY/N0WqAGiGilQdU
 /tGqZ0doGVxCYSBZR1mQ8DU6SReReQ0PKMsCwCQ8RErzO49Wwau9JMrCMqYriOeI
 YxdHoQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48muu0gwu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:33:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-70a9f6346f8so123345096d6.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 13:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755635595; x=1756240395;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jvX092/V9dwE/NzPX2FObQHrrP1GpzHfFltQW2JSWGY=;
 b=KJTfz5FjgBk24u5InXyPunYvd5N2R+O54gjogtuphhnuWkA64AAA44QjbGAT9ed3Tb
 ng0wXk1Ho8ucnPwQDWN9krmsy62cHCvJRRc1DQ4sAmHqzlIw5RtYH6QK25hg3M6KAaA/
 nmDOpt67ZIl7Ktyc+bdsZSxafYTP9FSzewI00EOAIGj8+nJfRyQ/nMYWh+B90ueZruWw
 a6NT1oPhggdk9JBSpPnflce9tgENJrdSUCYxzReb56XMcfmrpvv2GOuH0QfOjdRVQjan
 XPHvdnwb7eqxuJLZw2DDopnezNpc4wr1E8tt67KJ/qrwIc5rhzZBXsKnYxTB8c/K3Til
 7zyA==
X-Gm-Message-State: AOJu0Yw87wjm2CE+l26b3FsIKAaGoTHOLC0SfTC5trvMi2zRVeGKC7a/
 zaInSm9rNAUCNMGgSAgJ7uB4t+o7MWXX9+drCPJBJkDxzbEkvsjp+QUvvblJaZbrWbsniULnH/B
 ZfR4TcECEMQr8i5Y6Qx20t97w9gm4ee8C6uWiDC10VQjHLm2xtaepdEHItCew2sSwX5g3
X-Gm-Gg: ASbGncvIjWJujGkxkxOG9izrRUy/PVI96H9Lnt5YP36S5HFdE3oMO8jy46JFidlt3vZ
 5/FUhNEX4UQVVtFk24b8ovp2EWEpbuIVAgYE7YJdc4q8vPjc+cL4fObNBzmBn2TPdoR+doyQNKw
 guhbhY7FCRGUzi+S4hnhJHmEQBKc6EzWPkXpKQBHD6hNSJMhc4wT+vJV1hNB9VjUTCL71cxfY2q
 lolKv6Del9/299gY/OzLi2S9yPRruHDzg4N8I1vkvnc0HYV1BdfFJpCcxC5IEMAmmxSJj3aOTBQ
 7gwF+PhmfPkOyUMejqKPoYFPQJzaOi08Th4kzeTriZhBrfCSfHVWC2++e0YsF5KTisUohYGfSB2
 PNOu0jvvwy+RHKJqz8Ze8b7HmLZVRHYHD7+uEGzU3jjyvWI/i+BEZ
X-Received: by 2002:a05:6214:e41:b0:70d:6de2:50cd with SMTP id
 6a1803df08f44-70d77151247mr4494116d6.58.1755635595137; 
 Tue, 19 Aug 2025 13:33:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9xDEb9rwYCS8WqAgM9AnhKQP8F/GYNkS59+4ktlhzxroNIvOhQps/yxg6kZP/FfKY8Ql/4A==
X-Received: by 2002:a05:6214:e41:b0:70d:6de2:50cd with SMTP id
 6a1803df08f44-70d77151247mr4493396d6.58.1755635594371; 
 Tue, 19 Aug 2025 13:33:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55cef351806sm2212969e87.13.2025.08.19.13.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 13:33:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 23:33:01 +0300
Subject: [PATCH v3 7/8] drm: writeback: drop excess connector
 initialization functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-wb-drop-encoder-v3-7-b48a6af7903b@oss.qualcomm.com>
References: <20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com>
In-Reply-To: <20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com>
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
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4592;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Tfx7muI07rte1gs226Q+hRYOArvmNBAMe2ZWuhmuISI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBopN9947PbKAu+7+CUIfGx9WMCXm/z1B78epETI
 hPM199Q9DuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKTffQAKCRCLPIo+Aiko
 1RGOB/wNXkcFoxuLAJNkeEum/4zloQY+WG6CED7BLahxiCH2kQfFQcxOuvNWMMXaEqDQL216LeB
 ZbOWSqy6HJ00dZsO1O7ipqK579LQ2XUJM9JlHUUL5y8NLvDuuUM1EKCuQj3zWwYEohl48fG1V4u
 CNoWUsQx7aLwvlokBWFasOGAN5IcJJ9+fg2SzVYvrV/GyXVlnUiNQnswjOEaFmEeWw1xN2a+5Uk
 l563zrlaIZwEhnOsazuHd9AvOzqe6Kia26+XvPFLL0G5M6Y9B4ADOhKRUWcVskHr+k/Kz+mHAPc
 k6+bOvRAGUKJIFEgKO3F8YUgxmulZrA6UIchfRB4kSFKOWt0
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: -Is7StM86DIi2Ts7_UsLwzW7elCm2G0y
X-Authority-Analysis: v=2.4 cv=YtYPR5YX c=1 sm=1 tr=0 ts=68a4df8c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=3owybDqXPaZAjLikVYcA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE0MyBTYWx0ZWRfXwJq5b92x4BOW
 otgWQ/znOIYUmapUYS3DikoKHdpfFViHZE+t4Paq1hRwIiDSiM/FSQiUc9mjqiqYm1RpUoU9uG3
 odh0yTO1kgfT8Jya5TxcRJCobirkA5hPP7IdX80RxKCjqdBCH51I3gtapunK+r4SYMjtG9Pptsl
 kMs/A1rC46JPmMlam2Vv2+NqZhds9VBEbxx0Cyhw7089Zs+w6etKE3Ks5xLRTgKjaG7JUqUTs+W
 7P18Eet+42hnMDYEs5YGxZkd/AqtSIM6oNSqhE0WIRfmM2rED8vTKF/VD96mTa/rH9I1EZkMfpj
 MlyXhr1AlP/hNVjUEd1BcwvXKvERGTEp8G2e+IJ2b4fjFTVBB4QYZO3zBSQXApQik9hMAT10xY8
 mn+XO9++
X-Proofpoint-ORIG-GUID: -Is7StM86DIi2Ts7_UsLwzW7elCm2G0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508190143
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
drmm_writeback_connector_init(), drop drm_writeback_connector_init() and
drm_writeback_connector::encoder field, they are unused now.

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 55 -----------------------------------------
 include/drm/drm_writeback.h     | 18 --------------
 2 files changed, 73 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 95b8a2e4bda69230591b50be15d14d0b3692373b..1a01df91b2c5868e158d489b782f4c57c61a272c 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -142,61 +142,6 @@ static int create_writeback_properties(struct drm_device *dev)
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
index c380a7b8f55a3616fa070c037d5cc653b0061fe6..879ca103320cc225ffb3687419088361315535fc 100644
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
2.47.2

