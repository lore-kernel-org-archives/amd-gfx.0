Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05373CCF2E3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 682D110ED17;
	Mon, 19 Oct 2026 13:13:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A875710ECEE
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:46 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Os063305548
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6kR0wYJi5BkqYMmIt/Uxs5VhTS0LKD7uaMFFExvkTAc=; b=ptesDcJEX2PKVdZR
 TBcA/OlZg+1cKIHDRqJSeHN62glL7/MQSdw5NDGvKAQ//+lAzxPgn/2TpmM1Csb1
 sm1N2m72uIWygPsOLN+pZVPgCGMz7D868OXYQWxLPXjvYOUvHHM19qamF9aSocEz
 Sa2d/zqtsc9sc/dV/0WK3IccU83lL+bDQ9CAclo/p09NKRfOXUKvAaV7bqEsrSQ9
 HHZAw15T9mKGu4YJBDtVZSIbEZvIRQwWVQXMazX+MzhGT5Xl0pY61+rn544Akzo0
 ZIwaxb05SFOsEJE67DfT0tYd44Ge1FCucDcrtBAmJ34h4B5yok6zHwGTOllRWH6u
 fSbfuw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47h85b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1e62510cso509372585a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415565; x=1793020365;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6kR0wYJi5BkqYMmIt/Uxs5VhTS0LKD7uaMFFExvkTAc=;
 b=MITrjcsdA0kQcHAvw6tTcOxyvA0zLPbMeJXpWFfguF6wNQ55Yr5OLt92xjwosro14p
 XVKSdgJh1BiDGn9c46lTpQT0gnW7e9N5FRmYBMT0d6FYfgzpUlFX5v7Fl05CLUGHdS7Y
 9Y3k2Jr6RHqpCmV/eqDlgcrDeEOEVm/Ga7dhXYeAbe1P5KndMLMUH7O4gQEQfsonAmzH
 lmMDrVMDE7s4wRjR1nd+SVqt8oIzRkDDGUnlbWOziY0ylNvUw1TNJyUSNKJ0qlYkxq70
 YrvEoCgZz7U6cGuQkMJOnLfpKPI2EYWvnSfxJ7m+cBoewTb/Kb42/FpcOtf13+5smhQu
 d6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415565; x=1793020365;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6kR0wYJi5BkqYMmIt/Uxs5VhTS0LKD7uaMFFExvkTAc=;
 b=aPY1dO3BD27lCWNeF2favv0IMiOoht26LMZIMVpT48ktwixlT2F0V4DVIT4jkWtQ2/
 3F5sXoimOOYnO9+IfutFpN1he7XIZDubVilcMfZxM+3j+R8PjFeX7LD4bjHT6zeyThHK
 yW5a8/iZrmaspZjggyBzBIhgFKJGXlj+uONcHcyGXNhZvqqbrZ/peuntiXgZCv+NuObg
 BXZxj/naYV31gIYhrGO50RB1OdojMzTyhyAAtRBTh54ww5MKJi9aW0CyeuZ4mOg3rooM
 sHzhrbPvHpiCqkaqZyDUXpSg7my14f5oGfyDMn37ZpmIcABXEPWzMb2mvNvVv3rv6RaD
 zcuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNWwtHuH3o++ySBRlE+qDnijVRw9PktUrkz3Z7XW6kRgStjR3FFb2O8BqavFAe+h9rUB2XZDDM@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKT6lcVsZy6ZRofpO4ArEDov+7V2gZZHX0R6e4bezIvxdVcOsch
 epyoUAHGRaohjZ3wcT9MXiBXLMkgJBkJalHxwQlE/FHN0k1VBZ0GRu+kRHRECOM/0+FopY2rmN3
 MeNoO7tEid8fkl85b+sIBBeIccdYZAMCovJW+No4jN2aHwyAhWKNzo//5/hhP8CMrRskA
X-Gm-Gg: AYBFou23Ycvj8BFDj0znBqX/nK6IErb/CW0lnLrXSZjSqhrgUJB563Mgh4GbEjgWW+P
 NJnQGvRTswznjrmnJ6xWJg9hkKCBhgy5fwcQH+gUWwBMO6ETeQsBSlsRaf69F7esygzMWBSVW3J
 HTYKWcml8R3BQLUNNscMAd5zpRjL52zYOEBMucSsZLVk8hrTHP2+D1QkCIelMcmeAnq+V7HPFLQ
 aJUBLNzhfZP9i0rkLK+8gYEOx1IeVHskhjKRTxovfjtes9ooBG8aVowmZItuSj6sa/YcbKXKmXM
 YTsdvntmeBcUPGH8YtF8VrNT2PXsOZiHXc+Z1jvmc7AEJHy1zV4/6wa9p5jIMrY5BL7/QFs4PzJ
 W9OD4JxHEoaeH74xJf15kMLKiaA+WqdImSG1do8criCMjK4BwzkeCoOtrz7EwU5xKC92mJzd36Q
 ==
X-Received: by 2002:a05:620a:4888:b0:93a:10b0:aee7 with SMTP id
 af79cd13be357-93f29d4d901mr1300123185a.44.1792415564698; 
 Mon, 19 Oct 2026 06:12:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4888:b0:93a:10b0:aee7 with SMTP id
 af79cd13be357-93f29d4d901mr1300116785a.44.1792415564088; 
 Mon, 19 Oct 2026 06:12:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:27 +0300
Subject: [PATCH v7 1/9] drm/amd/display: embed the writeback encoder in
 amdgpu_dm_wb_connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-1-d4288a26eb54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6137;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=RQQTV6F8Gho50u3pkasrI5WHU3//8mnfLirnX/eGUEA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1hdDDoGN72GSrxZ+UIvVOsBEeFks6m+TV715q
 SXH7R4jTHGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYXQwAKCRCLPIo+Aiko
 1ZHRCACKVigu2OyQSC7weKOsx7VpYKUWBAeSxrZkrlX4ibao6F76CXxYbwJ7x4xP/aQMKDNwEcq
 xoaOfJrF35y4HGjYuHNEWV2foSgAcPRXGDqofJlDHh5aakKKJ76WUWq3qUrWtxEMpLWrVWBPHOD
 zykFJWy+R6wSZE/VaX1oibyX8FgMjmPfr/dhiST/e0SMCmm3+R/p+GijH675g7EiQv5sbNR2NQE
 ENyfYR/wsLgah1xDAzJHi06dDITzeh3rUHeHAhnESnA8K45ZCpd55XJ7JDuXrco4xAHLHXDV6Hg
 bSmJwL7AGAO/ClKNDsiOKFSFP++i69y9ueJgJSquIUPlcQFi
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: SRZdTgAnMk_qDPyc-a-0LVChpQWRDy0Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX4YIJMiPuca33
 K75/y8g0rHIcV++ncfkyS+LbcsiylCNnZKVXM81uENf2Wo30HswEuoF2X+N7el+9gy8atUNAhrZ
 2B0FviasX4qOIZ7wFco09QEHJ1t1kFfXaDYHzBIzYE0j+SG23yft4klfP4yc5aPtduhZo7RjZXL
 pw+wMMvg98zpwGw15ap9uyu77ic0YjfwBLdDTrcLoLGBOcPCnYrEDBMwScvk+4LisHBPNebEOcZ
 qWLnO/kx9iY7sDx1uZmjLON1ciA0g93Xx+Go3032nQ9dKrbwh0Vi4oRAE3iimEWPYBTJzz2/eN+
 aDjMYOO/tTohtP26FVYnaLjX5kosWpOW7Zip48toWzEm/38oHLC4OfPAPqV3ukMH6tFGyZdV3cQ
 SbNVth8x1ORUYwzT1l4OsLvMnJfaRMXgM23R/UcqdYL+PcYYKaNRPR9QD9UYdSzKNJkcyu9SPdL
 gGH5XqtPItUKf1Jz6oA==
X-Proofpoint-GUID: SRZdTgAnMk_qDPyc-a-0LVChpQWRDy0Q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX2GLV1Bdu+CFQ
 LCS82OODxfzR4YQ/FTOe+Q8F6XdRsq3TTE09akmpfxiJInGRHru5/E3T95FjTFhplsRlrJIJq2c
 xxqpNUo1ak7UULkoUvXui2uyFE2r9Uw=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad6174e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=_MfM8nSJvC0osUG94L8A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

drm_writeback_connector_init() hides the encoder inside struct
drm_writeback_connector, which is the only reason that structure carries
an encoder at all. Every other writeback user already owns its encoder.

Embed the encoder in the driver's own structure and register the
connector with drm_writeback_connector_init_with_encoder(), so that the
encoder can be dropped from drm_writeback_connector.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 29 ++++++++++++++++------
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |  4 +--
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |  4 +--
 5 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5e106b65034d..07dd69b42e83 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4805,7 +4805,7 @@ dm_set_writeback(struct amdgpu_display_manager *dm,
 		goto cleanup;
 	}
 
-	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
+	acrtc = to_amdgpu_crtc(to_amdgpu_dm_wb_connector(wb_conn)->encoder.crtc);
 	if (!acrtc) {
 		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
 		goto cleanup;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 1d256dce0e4b..d365370d9958 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -930,6 +930,7 @@ static inline void amdgpu_dm_set_mst_status(uint8_t *status,
 
 struct amdgpu_dm_wb_connector {
 	struct drm_writeback_connector base;
+	struct drm_encoder encoder;
 	struct dc_link *link;
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 6f91a992d43f..b5b186e4f81c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -218,6 +218,10 @@ STATIC_IFN_KUNIT void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *c
 }
 EXPORT_IF_KUNIT(amdgpu_dm_wb_cleanup_job);
 
+static const struct drm_encoder_funcs amdgpu_dm_wb_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs = {
 	.atomic_check = amdgpu_dm_wb_encoder_atomic_check,
 };
@@ -246,17 +250,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 
 	wbcon->link = link;
 
-	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
-
-	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
-					    &amdgpu_dm_wb_connector_funcs,
-					    &amdgpu_dm_wb_encoder_helper_funcs,
-					    amdgpu_dm_wb_formats,
-					    ARRAY_SIZE(amdgpu_dm_wb_formats),
-					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
+	drm_encoder_helper_add(&wbcon->encoder, &amdgpu_dm_wb_encoder_helper_funcs);
+	wbcon->encoder.possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(dm->adev);
 
+	res = drm_encoder_init(&dm->adev->ddev, &wbcon->encoder,
+			       &amdgpu_dm_wb_encoder_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (res)
 		return res;
+
+	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
+
+	res = drm_writeback_connector_init_with_encoder(&dm->adev->ddev, &wbcon->base,
+							&wbcon->encoder,
+							&amdgpu_dm_wb_connector_funcs,
+							amdgpu_dm_wb_formats,
+							ARRAY_SIZE(amdgpu_dm_wb_formats));
+	if (res) {
+		drm_encoder_cleanup(&wbcon->encoder);
+		return res;
+	}
 	/*
 	 * Some of the properties below require access to state, like bpc.
 	 * Allocate some default initial connector state with our reset helper.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index e27f6e504395..9d237f2db95c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -4535,7 +4535,7 @@ static void dm_test_clear_writeback_removes_stream(struct kunit *test)
 static void dm_test_set_writeback_no_pipe(struct kunit *test)
 {
 	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct drm_writeback_connector *wb_conn;
+	struct amdgpu_dm_wb_connector *wb_conn;
 	struct drm_connector_state *conn_state;
 	struct drm_writeback_job *job;
 	struct amdgpu_framebuffer *afb;
@@ -4565,7 +4565,7 @@ static void dm_test_set_writeback_no_pipe(struct kunit *test)
 	conn_state->writeback_job = job;
 	crtc_state->stream = dm_kunit_alloc_stream(test, NULL);
 
-	dm_set_writeback(&adev->dm, crtc_state, &wb_conn->base, conn_state);
+	dm_set_writeback(&adev->dm, crtc_state, &wb_conn->base.base, conn_state);
 
 	KUNIT_EXPECT_NULL(test, acrtc->wb_conn);
 	KUNIT_EXPECT_FALSE(test, acrtc->wb_pending);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
index 03036f906385..2711696f6b9c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
@@ -506,8 +506,8 @@ static void dm_test_wb_connector_init_success(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, wbcon->base.base.funcs != NULL);
 	KUNIT_EXPECT_TRUE(test, wbcon->base.base.helper_private != NULL);
 	KUNIT_EXPECT_TRUE(test, wbcon->base.base.state != NULL);
-	KUNIT_EXPECT_TRUE(test, wbcon->base.encoder.funcs != NULL);
-	KUNIT_EXPECT_EQ(test, wbcon->base.encoder.possible_crtcs, 0x1);
+	KUNIT_EXPECT_TRUE(test, wbcon->encoder.funcs != NULL);
+	KUNIT_EXPECT_EQ(test, wbcon->encoder.possible_crtcs, 0x1);
 }
 
 /* Tests for amdgpu_dm_wb_prepare_job / amdgpu_dm_wb_cleanup_job */

-- 
2.47.3

