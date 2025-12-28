Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214B2E9271B
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Dec 2025 17:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9066511AF01;
	Sun, 28 Dec 2025 17:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JEih0MQJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ex6o8Y1t";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C955611AFB3
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:56 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BSCNUfJ2857841
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M990uSOPBnzSQyXKdb+7ZT9yeTvRXfVYC9QFNhhhHfQ=; b=JEih0MQJoOeD/dP0
 6h70r8Oejwzp8CNd2hman62RK6uLIxo7z2CKaj/HxKVt+r64Xusv1zB/iSx+CmZo
 hdhUQtT4P3IckCAHmmOTPHD1D5z8qQHCvP7MqBaqE+rrkXOCfiPDYQG4SDhYVM/w
 Bz3HJzMLJVvI8/YNNMJpbDYO57srM/rfrCuVPTLD7ov3aG4ehTE7zNiw11U0ZVRr
 BcnuXEu27tfIXlas0c+C2jY58VMbjtsO0LllKdrlf9ctMk3pNKVdGWXWAsdr4suk
 5r+nsg6p2aeG1DtjcaidznjhQt+Wk/Ug4EGYjSpxy+X//cM24jKmvaV+XLBhku4c
 fSfR1g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba7hsafx4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88888397482so260058886d6.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 09:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766942515; x=1767547315;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M990uSOPBnzSQyXKdb+7ZT9yeTvRXfVYC9QFNhhhHfQ=;
 b=ex6o8Y1tzilkf0FjNtl4mQfVum7j8Wu3DNQJV662Yi6Q2lQnLtIA/ryAuzO8RtcvPT
 YbjfiW/VLunPVeYBYR2UF+68G/E0ALCJ194xpMEZL5Hk/uoE7rzIb8sGQhiezbJD1gII
 EwF4WZ+9B25YL7t37VVlTVLE/Oit99ebO9R/dR0wgyHRN/+spu4mAEP89XOnrMf9tmd2
 N2K+zUNwcSHLSDmsU4aPno1bmx0vtAKa2uYB58uyChAL8laiLOOD/4tv+6rz8InCM3t/
 gZsRkqyYqrVvH3ea7BPXk6Qlx8K5IrgbzK2X5mOKWluYr6t9h49oxDam4F3RgRoiZA8L
 WXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766942515; x=1767547315;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M990uSOPBnzSQyXKdb+7ZT9yeTvRXfVYC9QFNhhhHfQ=;
 b=iJygWNE8/3Qx0B52+j5dpQKq2q6UUT6pQLD80TaUS7XNJ7kO/28nmm/RbpArt/xYiq
 HPTJP8bFeNKoR9WgILLl0aNNbHQUfzrKvN9734/eN2MEsMt+DDKUz9d5VGJzDmWwFSHb
 fK7ZvpRGq0uiB7YHmTNPbUL//F20ckh8c7jrUXwapb9SNcwTaetT15ah2kWkJUJRU8RP
 vBjYmO0M1l+iTyNa+VDByswXRPZqKu7ZuUSVgOZO8NNj5jUngKmQ6UsTVuPW+vgJrK99
 tpxuPg5fV4KsZ7WX3/CM0zBL5V6kkDmRYiGPHlTWfHkZ2OFhf6uiwobcmaA8a6jq62o4
 /yaQ==
X-Gm-Message-State: AOJu0Yy5EiF2P0rW65ZVLYv8HbPwALZVfHYi/PjDDaw+EF+AlZEzdwNa
 xo4uSBlO1iTbpC6DXPffxLWxpiv4oJvPMEpeLS7ZYlPVnrUzCVk0JW/xowRLTmmRxkREs9C4wF3
 GghV+8UV/qkAwylANWO/OooS6fFUiOPyFl7u48jdSkphRNzwSOLhPTLC4MemUchQKOJAt
X-Gm-Gg: AY/fxX7jPk7TfXLefdssm2pYtK+caMF9yybXgW6eP8il/yIKhX9TEBulBDwNSFwgaZM
 viWZ37Afz6SDnLlg/N84BsSVlsa6QbGzwre6oyhdWesAAx84lym6kuSWZxM1hX8RRMtOw0MAwtL
 rzwp/DFJOGQ6048eJLeRIzGUbNX8S2aMrVFdhzaQZ7DhJk+wV7/WNu7a+8XCvinKKa+QY7NcX82
 OdMLTKAyPLLJI1ubdzspJl8X1dKKYKvU3oHze5pVOM1tIhpq9kkE/m7T4KGeamBigkee6ROOKMy
 eaI5vt3hTi67RVW3kOIRwSwt6ON1GtNbTRH/UXu+3kDp6pxNMBakIwCfLbJfhm2LElAZ/xQTR5O
 65YRM/NUvSPKuLFDYYFDKmPwfCAIsnPubQUcdiV39iDTIAWxJY3/TxMkjp3Ftk8mng6SDGwXyZU
 QxYZnuR3aglEFKjXzxsaJ4xKo=
X-Received: by 2002:a05:6214:498d:b0:888:81ad:16b0 with SMTP id
 6a1803df08f44-88d83d65945mr487316516d6.53.1766942515419; 
 Sun, 28 Dec 2025 09:21:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcvwcNsJxfckigfIUDZG6GhjNkeQtH1Am+DpUUIQ8I+HISHgd+uxyslQbQQtyZyzXMCQbCGA==
X-Received: by 2002:a05:6214:498d:b0:888:81ad:16b0 with SMTP id
 6a1803df08f44-88d83d65945mr487316036d6.53.1766942514996; 
 Sun, 28 Dec 2025 09:21:54 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3812251cfffsm76871031fa.19.2025.12.28.09.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 09:21:50 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 19:21:39 +0200
Subject: [PATCH v4 7/8] drm: writeback: drop excess connector
 initialization functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-wb-drop-encoder-v4-7-58d28e668901@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4480;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=H3BLuh7aucG+4twvP/0GQJX85YA5nUk09wN5sJ0vud4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpUWciJUZdvn/acE82l+E9R4nQ4JakRQmCYafIQ
 s1/38m2bxOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVFnIgAKCRCLPIo+Aiko
 1QADB/94vJUoLDr35ABGIIs+eO+dZA4cM5aet0Kwybz4Cjxp3N51brjCEaXdsDgsZ/90lPqKS0W
 b+f3i+yY8HvyVuJgS9YBnxcf9atoRGg8FzThjUU/oStVtsQ57eyRwG8DI125wLXdZsp23qPsGoI
 9XvypdYZSQ5t4C33IrSsOQMEFDw8piZrNPTp1bNE0W4vlz2GHGZIeTDYqMHRtUBWSVXw3NHwxLJ
 jGLBjX26NQPfhMfNzJVJOndj/8vSZedyk9Sfl3/5SKYZuUKicSdIb0f5pkEXuSiSRIGdDJtJw81
 tOc2aBGjkj95fKSJpzHX/TM82L48RAYFfNuvGKSYaw59kw40
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: vjzRuWDuImP5EBc3wW4Q4QMT5bJnkLMW
X-Authority-Analysis: v=2.4 cv=O4o0fR9W c=1 sm=1 tr=0 ts=69516733 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=3owybDqXPaZAjLikVYcA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: vjzRuWDuImP5EBc3wW4Q4QMT5bJnkLMW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OSBTYWx0ZWRfX7qSwyWsQqKQC
 uVmebL43q5Dr00arv9E+w87bmpF5d4fteinFCmj0ZTlFjAY0KoqE6L5Fln/emak1LmKtUkg37BH
 8Ez9KcOfnjBhLvccojcYmMly3xeLj3r6gVMoy5sWOVDQYwn9g0vnS2Z5wgUTbdR4EuO5GXdhnlU
 rh1frBE9GAbQqQce6VrRx5vu5JEyZI2K8m88TeuK6qPXqy8r27rdAExrCewSyP6gAArBDDZ8i3/
 yo32fTDwx4ON2PGincbrFw5Sxe1ZVKDjVq0IwK7L23In18UxX/diOeTNmHub4gZEdJy/oAZek1P
 bOAYBnCZPyot5RBxi0CPcarsQG3OyMjVlgKD5sYACXG48zC/1HSKJyquVdhk463ezeJyL79yUu6
 dzWr0ByQNaDaSV05aCqxAcXDgdOx+w/FgPbio1fC0paFoCHrd8/0/3r6WiTnBtxm5liDbX/AGs6
 sEGMhKRnh2v7IAXB84w==
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
index 95b8a2e4bda6..1a01df91b2c5 100644
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

