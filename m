Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB15C87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 13:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8296F10E87B;
	Fri,  1 Aug 2025 13:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eXVQ9LVF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C3410E877
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 13:51:35 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718v3Z3006881
 for <amd-gfx@lists.freedesktop.org>; Fri, 1 Aug 2025 13:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /+B92RCJ6sUHTgOKCSTnvICSpksHijR6GnMpjqqV4BE=; b=eXVQ9LVFhvEmF8lP
 p9sioUtRWNt9qlqVfwKTdPd1dZALSuCSCvuZW72ZEejYAPH5sWUFPxZdU4BkUHY6
 R/8s63SNsGc607WfI7Cd2xNxJYTgezciEz7y1mc6Ne+7LgSYkC59/ssXEcgOShbc
 kRZKCH/4jd4WbuTIdT4Gy0mFisGvULyws82hWZ2gWBevfGFN7msYcdVI1ZS9EMUU
 /Z/L70BgzcNyrTIsgpte9+9Do3S/Xvewaot3JKueUJjFszQxfsCwoUHbQ468TZB1
 dvk90tLfShZfp5ruHToipUTTXme5/zz/XdnyGXhwvVVj3A7Pwxwp3YC34lf0pdVm
 4/xV/g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcrm7qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 13:51:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4aeb8b6acd1so17008781cf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 06:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754056290; x=1754661090;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+B92RCJ6sUHTgOKCSTnvICSpksHijR6GnMpjqqV4BE=;
 b=XT/6FguYF/G1nBZOpSibssLAo8RpyrVf6hX3d27HSp3yfcuF6vc+LAqgs+DgEUKhOG
 sJPlb1mSSoLb7TVPn2MHk+d8X3ttGNCp17up+3J3Dz4nbkW+BrUAT7f4jXmPVDsZSFJp
 UT55nFhpuQIUMb8wO2/TTUhkgk+25pQm32ebFtolsj2Q/1+qaRDm2L5FumoouLVBry/e
 RYaxwunqHvIA7fNv5c1+/PtS5BuVHBeCRT1DFzk9CRTWlAqZRcM4F9MRNXHBMMTQ/jSH
 0ppA3EbsKzlwBKAutLIxFetsSnxHVuQdYyOyhKn0PpjWqYJe+xLW5WCoo3cECB40LlLk
 CFlQ==
X-Gm-Message-State: AOJu0YzItckNIFk5vNpHd0AX0EislWD+olq7FPteIEDIvnyuLZ5GdPrl
 qhSLQ5Ad/7xTHpG9qy5e/fRohLD3KZGLXUX7lbW2tsE1TCN8feFtB/7ShNaBWlWbRcjK0hqpDdU
 AWdVmgZ6UB+tfqA7LtgFrQ7WLzJx3bY3mM486L928+x6nk/J+v33F8KMp+EGu39aMBsVN
X-Gm-Gg: ASbGncvGpXateUvgRZSOF8bkbt5NagFlwqyN9qYJ5BYfyL3FqqR5XPVt6EzzVdwUqG5
 t21kMpgm43G4QKicKZRpOkG9UbrX0FQPSNrwR62MtTJJZ+VjE4m1Md9BnwYgJ/eVMflLYzzgObG
 S3jeNLCKmojId2DMi0p1hmLPHLnIo6Fz1ELIH61q7+YMp7sQOl8d2RUdVpaLVl1XOQU0It1Khdn
 55/RkmA+fXK/+SdfrIf29TXpYSgjMhhGWylKy22TdznwZFkwSqZY++Fuvj3dWjr6lVIwZjRrhvE
 ayHukC1u1+BOlza/yMUkn+eJ3YyQr3vHG9+iFdRIVBCjfwCLNulOYAgwjKz0TxjUwCj4HBHRFPX
 lTtdukeeBGjdVTmzOyZQiOTzMdtvKmCVVJfAFweuPbjS9Lua85vBZ
X-Received: by 2002:a05:622a:a20a:b0:4af:c21:41b1 with SMTP id
 d75a77b69052e-4af0c214570mr6065191cf.55.1754056289643; 
 Fri, 01 Aug 2025 06:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbygvQYA6zDq+LhVmG3CR/4GN/47/XqDWnOK52WBf4RbtBM6/jIq15Eol7L7jNRSofKyA/8A==
X-Received: by 2002:a05:622a:a20a:b0:4af:c21:41b1 with SMTP id
 d75a77b69052e-4af0c214570mr6064831cf.55.1754056289082; 
 Fri, 01 Aug 2025 06:51:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-33238273006sm5917801fa.9.2025.08.01.06.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 06:51:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 01 Aug 2025 16:51:16 +0300
Subject: [PATCH 8/8] drm: writeback: rename
 drm_writeback_connector_init_with_encoder()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-wb-drop-encoder-v1-8-824646042f7d@oss.qualcomm.com>
References: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
In-Reply-To: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3016;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pqburrqLe4QINUtvUHnD5bh/z2B1X5GNCfeW27TyBDU=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ0bPsZDobW4vfKRTTQ7I9IreLqleOCt7nltN8yGzxgf5O
 5s8egU6GY1ZGBi5GGTFFFl8ClqmxmxKDvuwY2o9zCBWJpApDFycAjCRC/rs/4z+eBz0TL8iMp9x
 23dr/dQ1Qe+samT3Pm8yl4y0nTyTneN5y1e1HP+LUzWNVyv+fP3yw47Ygqk7Ou8KBvubXv/Z+ml
 v6wkr1itul793iittLc1Tu/GGfXu7OrvKnYlPZldYVMr+u7XGR1zk4Kdk5R3r3i04My1iUb1tpe
 al6ZesUs2YWnZ913bV2Ht0+8fsj2yFrhqx1Yq7uRgU6hb8DGpoC7ygm9C57ENL87bC+itts3SfT
 V7+Qe5sIteVwprDjHtjy//v3cXwTWnjW530O8VerTGKwX8P9fW/3xkWmH/WUDaWM25a/fba0ozp
 +QyFjHOYhBljH9fvkjvlXJ7d6jF3q9kRH6/lpiqmoY+4AA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwMyBTYWx0ZWRfX0TRmOsmiE2Zk
 hyAsOkJ6Lg/+7fT+PiVauRv1olTaUNXUdOcFrAXj+Rtz1XZ9+AyVzFDrEnABKHKOlujsdWbGTIH
 lSsznDbuBCnU5VtVFlK9YDpuyWdHA9PyduBF/Ct//vT+P2vQbzSKz1orcsDY3ss4F+zjGti1aDV
 NbPBKD052vJVqbcBOyUJmb6EW9yCExP0LlwjTxyRMsxo5GPZOA3apymUCfWHZkcZomzCyuywQCH
 KEg3B4BRuxhWI6RmgrToNjF6jSy2MGz8fKOdpg8HyRlPbkMKGUTvbwWgr54pGPZ3UJuEZVdoi0R
 IDbfjuyG2ZBBjqpoK5UFK6EsmkJXpglfVSd9PrY/N93mNZwM0Mrs4cq6PvghLpBDMJjHDMCw+zE
 8Md5KWExWlLeRaRHNCRPMXALs4rVeRzci0O8hL2dehXPq5IHt0iGznAPtf3KMCdUvyW5nHhH
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688cc662 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=By2WwYRBACVvdXAjiroA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: q2R7kFLnM46KCGVhPTfpNQ4X180L-DZy
X-Proofpoint-ORIG-GUID: q2R7kFLnM46KCGVhPTfpNQ4X180L-DZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010103
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

Rename drm_writeback_connector_init_with_encoder() to
drm_writeback_connector_init() and adapt its interface to follow
drmm_writeback_connector_init().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 14 +++++++-------
 include/drm/drm_writeback.h     | 10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 1a01df91b2c5868e158d489b782f4c57c61a272c..ec2575c4c21b7449707b0595322e2202a0cf9865 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -235,7 +235,7 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 }
 
 /**
- * drm_writeback_connector_init_with_encoder - Initialize a writeback connector with
+ * drm_writeback_connector_init - Initialize a writeback connector with
  * a custom encoder
  *
  * @dev: DRM device
@@ -263,11 +263,11 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
  *
  * Returns: 0 on success, or a negative error code
  */
-int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
-					      struct drm_writeback_connector *wb_connector,
-					      struct drm_encoder *enc,
-					      const struct drm_connector_funcs *con_funcs,
-					      const u32 *formats, int n_formats)
+int drm_writeback_connector_init(struct drm_device *dev,
+				 struct drm_writeback_connector *wb_connector,
+				 const struct drm_connector_funcs *con_funcs,
+				 struct drm_encoder *enc,
+				 const u32 *formats, int n_formats)
 {
 	struct drm_connector *connector = &wb_connector->base;
 	int ret;
@@ -284,7 +284,7 @@ int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
 
 	return ret;
 }
-EXPORT_SYMBOL(drm_writeback_connector_init_with_encoder);
+EXPORT_SYMBOL(drm_writeback_connector_init);
 
 /**
  * drm_writeback_connector_cleanup - Cleanup the writeback connector
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index 879ca103320cc225ffb3687419088361315535fc..958466a05e604b387722610fc11f9e841316d21b 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -137,11 +137,11 @@ drm_connector_to_writeback(struct drm_connector *connector)
 	return container_of(connector, struct drm_writeback_connector, base);
 }
 
-int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
-				struct drm_writeback_connector *wb_connector,
-				struct drm_encoder *enc,
-				const struct drm_connector_funcs *con_funcs, const u32 *formats,
-				int n_formats);
+int drm_writeback_connector_init(struct drm_device *dev,
+				 struct drm_writeback_connector *wb_connector,
+				 const struct drm_connector_funcs *con_funcs,
+				 struct drm_encoder *enc,
+				 const u32 *formats, int n_formats);
 
 int drmm_writeback_connector_init(struct drm_device *dev,
 				  struct drm_writeback_connector *wb_connector,

-- 
2.39.5

