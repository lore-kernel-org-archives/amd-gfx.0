Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0D8CD98D2
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6B710F604;
	Fri, 12 Jun 2026 18:30:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oRWWBt6A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GMe066MY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE4DD10F647
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:37 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGVerb4112808
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EaIMgG/IEi5Ad5NwXbrOlQk4Ovs4qDGmtqlsgR815SE=; b=oRWWBt6ABEqt5eXm
 crjECfTbmZn3hmv5zjdzfkecPBLuWdzAsMuK1dvbN9+4HEx4qoON0XSGX/thQhl4
 FyW/EmTg8fdQ8PqTuKFQtilSnf54Rt/j5teGI7/rTy4p4hO8YHrhZi9m+kWqlexa
 3jbOfFvYxLa1hz7XrbcFcUKIAlS0psOKYvSQAdB/+GVB+UDJUJ6KbYaffXC2Q9R4
 /CZsJTzCnVEKd2nty0p7DZ7kVUOzNV2EUSPltDGnuvT80hmE/LPKnVIKJueVq3wB
 ILlcMdzhPT9MPmSLNvWDCv2BoJLG6kopu7HZ6vGka+HIux2UfrYpmo71qUaeehEX
 nlvHXA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er30gc2qa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157a31ac37so188552485a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289036; x=1781893836;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EaIMgG/IEi5Ad5NwXbrOlQk4Ovs4qDGmtqlsgR815SE=;
 b=GMe066MYgRaxVJN2RhqE77xy9zcCJN/LD2TBn9/2jgNNshfuecYbtKr5TGAtCBA02o
 9GcOTcj6j73zRXXfY1U/h6UpUygcwqV7PS6SYBk171KAQHnPFwJHLpHD0En13sH8PSQY
 J0P1ocRKlSF3a+WNhzHjh6rolgzgwa/tfEzurzVszxIOlO84gWaiAiyM+RUAef4fRRjb
 hv2lYMM5q28r+7lClRxQr57S9j0Wkxo3Ogcs2ypuuvOo0UP+K9Y44sBWjv9h/q+aBxj0
 PB7KVVZ5lsJodWnAcMn9SjSt7s23PbTGnd+VqP3mMBO+ZlwGGwjOgOZkKHOgamhuyQRn
 jY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289036; x=1781893836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EaIMgG/IEi5Ad5NwXbrOlQk4Ovs4qDGmtqlsgR815SE=;
 b=NFqunw8TDne2RRQtd7Ib5ExCWn30PdFwLYgYV5wNYrIv0xPcn5uZxDq4QjLgxEA5O6
 LVeDHBFBuuWg+R8WSzxdsSxkYZC9IAgtqjzt1D6sTWV/P6x+kEA/tDNQH+Yg0iOJMIUK
 +W/Jay9WoeaSGUfnD3W2kJP1hW5CrAOg9ijR6DqcmOTt09zhbHEwKPruSnlCzzj4UlL/
 UKuFAgEr1O61X0+4hpNnAN558XpTG48yk7jWrj5nrM8uKPljYEPFHbmosgBj4Bn1/LhN
 xOKZkWvsG6wLWE6p6CWt3aBJJ5fiV+LEo8CYZaVWR7VVL7bydrvyOM4Ljf4MPLeYnWuj
 JfMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ97iRrNjE2Bz18tU8pfAuoKX6rIaarmclAc6qpHuW8NGKz1gcrH9W0l70PveNKmh27Zkm5Hoj6h@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGbOUhZX9NNVWQSDyox2HSkuNWlRNdqaSWHeE02F7GF+0cHHuI
 wsbxFV5U4/L/I8rSzDiLvoRzCtdU7pXwxtQ0IzUAGpnPzqrAwtCRmJRbE2pB0xhQjZILBCmB/X9
 IovcklIn2Mg5lLuX/7wlTG306eMp8X9OHI/oOJcQtDqaQJ4wfqGlSOlhGbd+L9g1DupWX
X-Gm-Gg: Acq92OEEhhQPlzH6hbngt0FHkDZgv5MSqHG8BXUV5+65BbcS9qgIGfWoDITaGSYPNNe
 PodSzS9MqdE4otV//6L6EzCcM6rO28lar9HtbO1Z0j8d5yzQi6Yip5m5Pqbz7iSdsmBwZzMaufC
 Mf9BGotE+oRlOves19OZM59Gp1fg3YoTmb1fY4ovGKJKqOqvPKbEuEcuKjM/nAZdammBZ5BofV4
 IwFYiLXkrpniJVJ+JP7oj5p+La/ua3/+I8wWs6AFBVkGMJDN5kOYl57r9VmBK7lZlmXemCt/p2e
 CVenbPXuXV2TsmHAPyJssWqoWuJbcvty80xSA22V3xnuEB7kVDaBgdSA35qn9KeQeSMBBbHCpOh
 7DEnVNAWRVPbr+Ofn0iNVFV4stmcnvcvhCCuHT9AjvFk2IkveelQNPelgtg+vs9sEC4wS+RJ6bX
 3tMiWMppJMlc5wSOkvgh/6vbedbC1xrCr2DQ0=
X-Received: by 2002:a05:620a:6288:b0:915:9125:e63d with SMTP id
 af79cd13be357-9161bcec31amr573646985a.43.1781289035947; 
 Fri, 12 Jun 2026 11:30:35 -0700 (PDT)
X-Received: by 2002:a05:620a:6288:b0:915:9125:e63d with SMTP id
 af79cd13be357-9161bcec31amr573639485a.43.1781289035445; 
 Fri, 12 Jun 2026 11:30:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:18 +0300
Subject: [PATCH v6 8/9] drm: writeback: drop excess connector
 initialization functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-8-9f3a54f81310@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4480;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6KkNpyC526rgMVIeY0D11Z3gyU75WDlgdpp2dL9pdq0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqLFA3jhMYBxZuTwA5P8pC0iOzIEdJ7fr70b3ui
 c51TlxkhXCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaixQNwAKCRCLPIo+Aiko
 1daWB/4u2v+4zU23e3Xdhf+ZULhAcCbc7KPvw3poBWoSLMiMVcozrKDBfgSWbwSIQaYyWKcl/0G
 rGIMRuyDsDJ34XQRo4oLUBfA9Y2piTv49SnLjBpEXNh3YK6BuIm0hpukouPxJWhBYpFmRsmkxUr
 9pjBpnGdQDBbvDbPCX5DNzKxUYzMjoaULMuQ+yqa6fDQcsAhq9BcCp6ahC6z0whUx9BrKDtpc2G
 1P9N+IGrF4eJivzCB/LhONe9SJLkY9NRiNsgbfi5nJ9+n6e8uAsjeXmPXHIdw3n+aBUTb2e5vj7
 kTbZwrgAuTMpFWIQ36Q0w99dnWIe2bX9Fqir8Cebzr6dyOpm
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX41+I6h4+hNgz
 +3zQ115QNyxLyPZEqMMWG7hIp//o0mCd9Bb7QGaEJHBDwjpMx3iIdaccfKW7ChE74legj2i+lBl
 Gr7GxkY4vfT9P73vN2sTWvrjCA/ENh0=
X-Proofpoint-GUID: EuG0mHnONrnMK7XgagKKS1VaZTQ_rCxo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX+nRh9znjgs2j
 8vCRRTSZU5qG1zZ3NjjavBiFYllZS05Jb+Myk9uZR1+7+zOiiORs9BX/Ag196MgXz41tWbrLi8o
 MDZFXEWlqZp81SEs9GPpTywjxmecEz3bL9LkdFarTPQvdQXQoyJaeiX9YykUOjsDMTzlkYe/EJH
 TK8xcejjrG4uvaIuVmw7a2KXJGK+YjMyemmsm5Dcr/JLQoQxPqgJJowowEjuTOUeb9XzTr92VaX
 uszSQfIeIKGn6Qu7G/3khTCPUKxEbPdAuFiH648ae68to3BVDj8VrW4IVdVqJOLpHGesLWJhES3
 iwpqMn6hey7d+GXbAXtpZ8eaohxTzsqhHxgrdYDjG0LEouOqWOyVc+szRm1e7qDIaXI2qT50lsN
 /3HK3i4MjX1nUrIffU6/EinWjCshpggyEkQI9ZMErWB7RR2oeDyZIeanvnuKwyFB0yEeEjwv4ze
 ewkmuefd893vXPhlkew==
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a2c504c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=3owybDqXPaZAjLikVYcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: EuG0mHnONrnMK7XgagKKS1VaZTQ_rCxo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120173
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
index 4da5d6094721..9fc15168c34f 100644
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

