Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6BBCA0EEC
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Aug 2025 15:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9A710E3A3;
	Sat, 16 Aug 2025 15:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KTXDNvBy";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FA410E3A0
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:54 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57GE0IGd006058
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jvX092/V9dwE/NzPX2FObQHrrP1GpzHfFltQW2JSWGY=; b=KTXDNvByviHGc56b
 FFnLd5kClgulAetW2DC3S4SFHby5ZtD0KJ8fH2EYqSj8lT4tNyLzChcnnYOIuf27
 38IOkOJRsOCPQOKyWC0oWUtidi1RTxgm46QvGJfd89HjYiynmGK4i9Xwl+AddU3Z
 iJpGSM1j+msRnnFeq2eDcX2xTeWJJQEClNyiujfeUIRyvHm0/i4nBgmy0ykbudK3
 eXO97sLRNQXIK+PFhbv9zjfd6GOVokQhZiuWaSKn2nNgdoH2iB8MHxoix7BcxLsD
 mzskr+TkfcIbOoLfPiMHri9q3IgBKB6J98kaX0AUi52YuR0YvfKDQYDGWNet47VC
 VRa5TA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhjy8v3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:53 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-70a927f4090so62322706d6.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 08:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755357593; x=1755962393;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jvX092/V9dwE/NzPX2FObQHrrP1GpzHfFltQW2JSWGY=;
 b=E1mMXJEvInXub0rq3TLIthfODSZm0yFcy/Y2HYEqww39zjvva8qNBucziQ2Kp7RAVp
 qqwAcWgM7ScfzLpW0/a2MduXD5iqXexg5COJYjg174hjwQMy/XAw5YjHie0JghLUKyVH
 ZrEtGAf3jpcIAsHN4iTr75ppQFH1Wn3T7HrXpZdvmc1Z++EIQ2YsvVBNcFFN4G4PVv65
 Kr2zRLqZYzJMhABLt8psw9+v79JK++q3ED0kE64U6bfSl/tarKQ2K1iD45rqQfMFeaFl
 1prbMAJ4+0KxFBUISSQdVzfumCFIunpHZkTWTAwl8K8qF1xCOwYG+B+U2VL4GhpI7zc1
 aP/w==
X-Gm-Message-State: AOJu0YxzCrScM2OYopoThq2TKsQf6GS563Rz7OGCE8K7E1RoNG7m/dlp
 H7GLlteZ3zzO6aKR8bS5YOsfRP22J2+HGQk0UeG0wu+oly1fuDNeXc7pOYh96lBnbSzIwVQJ2GR
 IobYk1d7wTk0qwJ2thVnhGmWOrIsyb1X9y/8ETmHjM/NPhkl/80DJEK0B3KkYOoFVMbrn
X-Gm-Gg: ASbGncsTPD964RGerK2m/i9Cw4qRbcSf+0akcl6q7sZhzIltXP+KjbfzD+noCeyHkxj
 wmAM4xFN2GfZDHJkNo/4/Qi44OzmFYYjsDChoPYIxOpybUvaqVSGuY8m/TafDDP7X3OejFBCH8d
 rCLUV32OnzciqwpbcYEN+2+x5p1xOK1eclv9F2ImKG/uxuRGB1TWPQw/NlByoU/2Bikif3vTghp
 dURs9kfKRfKLkRw4waI29Wgq0ocSKQPps0m6aEJCJFNoOUsIxqvGz1jJr1HVRVquIIKZ2EVju1L
 jdYdH4xm7xAwMLhFgh+eA5WXF38UTReJChgTEPWE6oHEjE6wDtY/ioVsRoR0dcStLbGzU/e/q93
 b1RI+DkoRR6k/GMq+MB77Q7v+JRG30dBQENuGQAgVMa1sXpiLMZEB
X-Received: by 2002:ad4:5cc2:0:b0:707:56e1:4806 with SMTP id
 6a1803df08f44-70ba7c0c266mr68069136d6.26.1755357592738; 
 Sat, 16 Aug 2025 08:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6wpmas11TOgM/lOrBnDaaa+ZNv9CM9o5CoLSNrvXvzguwCyeZq+xByyKZu7mpxQXzAs6ZHg==
X-Received: by 2002:ad4:5cc2:0:b0:707:56e1:4806 with SMTP id
 6a1803df08f44-70ba7c0c266mr68068676d6.26.1755357592140; 
 Sat, 16 Aug 2025 08:19:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55cef35965fsm907579e87.37.2025.08.16.08.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Aug 2025 08:19:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 18:19:41 +0300
Subject: [PATCH v2 7/8] drm: writeback: drop excess connector
 initialization functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-wb-drop-encoder-v2-7-f951de04f4f9@oss.qualcomm.com>
References: <20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com>
In-Reply-To: <20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooKGJEY6eTqDPaJVKRsqidLF7oxfl/QKqz5sJg
 wIuVrMnDceJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKChiQAKCRCLPIo+Aiko
 1awiB/9V+Wqv1GRqu/fY8y7enzI9KgxziG2fiX1GFmYXkgNtnapTor0nvb79mCc06hn7Js5AOKV
 ZD4DC1TE/rb5LA9V2C5miTmsrZRAiuNzE2+Q+R1FOjcZERb4/h7VhNT/IoQyw3CJue3YjUpl5du
 EXhHOfAsh43jFZaE7HFBomNNVcbnAgcMQtxElaqpIeg+9Au59RNUw/cQLDyTq+5P+3785UHchWz
 s/0eDtcW50jpqRXgY1bBIs5gdTeWSPalphDVtxWIIOBK8iFpNOyQU0PwfWnAjzTYkQh+qm0gipx
 /yqL7HrrhBLPlZsJMCschecIah/fB7Wo87n0ij2ZLSm+C4CA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: ky9Lyr-YuBSPVUQc42DenCi6l9h6gt-p
X-Authority-Analysis: v=2.4 cv=ZJHXmW7b c=1 sm=1 tr=0 ts=68a0a199 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=3owybDqXPaZAjLikVYcA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: ky9Lyr-YuBSPVUQc42DenCi6l9h6gt-p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyOCBTYWx0ZWRfX4YEsDZPGs4Tx
 fJbst1eNw52ADc3yPfnIFvrwIPUU6vURDc+0w6beRc/Zbf+yhbejXEylbYo7F2vLc0H6N6iafaQ
 z9/aIIckSl1N7tWI/+iZ4EYEEnJ5dXzUtcpnU6YdGZU8LIE7JaHi6KoVvHrZi7u6d6X/90ZjAj5
 EECmLw1xPUzoK36tvY2WuUiwDQCE4JJ7oaG+MBaKvUyAgN/JrhcdeLLBTAy+NIB4TUrrE4rOGP3
 +pZmfGvJSqqTVl+82hKI16T/95Jusa0AHR5ivv8r3rQIWqGzS7T5oLzRR/clISaCiKKFff8ZWdj
 paa1jOAhg2mmmDAv133Hgvq4qWZYtA2WesPL8n/FJDyrk97J+6tP/ymbj/z4m1iU5wuLNlIi+T1
 ilAeKMSK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160028
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

