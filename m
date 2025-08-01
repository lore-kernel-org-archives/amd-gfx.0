Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D90C87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 13:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 263CF10E872;
	Fri,  1 Aug 2025 13:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bj6cMkpQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8EA510E873
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 13:51:29 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571935Mw001408
 for <amd-gfx@lists.freedesktop.org>; Fri, 1 Aug 2025 13:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mLmvIm7aiVxs6oMFsxxhFeeRx+tZKZlR89XtVnuV08M=; b=bj6cMkpQ1CVvcSbF
 fWDc1EgzCf9Uy42mi859BDmHxMGZLuGWKQ0511T+iMZFf3FBw34+kmvRM9ZwZ2T+
 hqSiWO0SElelynghmVxziCRovCRsIoOp0DPCMhhygCXadGqFTBMY31fmCzil56hn
 TwN1uWP4dvOa9eW9/rLfqx5Hxzi1t9g/fc+EQhci4F7kHScRoMm18OgCxPA/IMJJ
 Sn+1TZEAkO1SA4NpsS9qT97FYO17Vd89PNXRC1ZFsXpnqbmMpUiqBr4iute12eU/
 HjisHaG7kQRnXCTRalQhsczTLaXyaZfligHAJKqA1HEeCralZm5qQxCRbtItymku
 3B47hw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nyucg5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 13:51:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ab60125e3dso20315871cf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 06:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754056287; x=1754661087;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLmvIm7aiVxs6oMFsxxhFeeRx+tZKZlR89XtVnuV08M=;
 b=CYmMsKTNcw7Wu/dEutxFjwZAKA3uwtGEAmlM/dJhvaJP9FSbhoSjayAnKy77npw1gg
 cRY6dQYgoNheiunL/Ob1zG3Dcd75zLDwFuSx5F9r8RH5AVSEnjfqYQv+IOwcoaQLst0t
 gbnVIzNo0Q+VfHFOGIyo7EsM3raM1TEsSM2vbZ/dAy7+qf94AvDqVh5WTLmzCBIJpY2x
 +F4zoSMr/veSLIW43yZL6Iwt9WSJH/2qWlTqe3hC1TGMwLzjTPuGn08TMIsvCS12nLeA
 LK0nfwxd9cyf3nlm8tH+2Mct5V2Q0FjDFifTKlcUSPg915gHcIMesmHLh/3639p6EowI
 xCsg==
X-Gm-Message-State: AOJu0Ywxc+7jN5emZkacG4b8OTJrEYucE1AAMTR3Wjsp1fsC9JM0QHeH
 OBS1/2E/4kEW1MVs/vwSNHwPSMABV/5aZz+iFiryGGS8e06IlW4qgWXM2AZjpraTGG73aUkJref
 TtjBAu5t0bpWze3agB27df2DtjTIHor6Qwkd2PTsZCEt8GGbsiCqmdrUJ281ttDMYjiZ0
X-Gm-Gg: ASbGncv+h26F2TZPGUcrAKuRO8RSzBszrGaTo9vi7fdVvxfBtgyBEn24cmpgRqjcLoo
 ATYM/o5NxcbNLB26Ed40M3865vYWDKgE7Zxh3oHC4m9Sabn3bVzYCckslMDGynJTdchlkOQGhGJ
 brPwIXIfRNtMqY9nk4eLmIxqj36yJHaUUJ60KOEaJXmGRkQO3n+NHHEoSThhTPZ5Z8T4U4QKGZx
 itwxF97Tvi+Oj9OHkKAwpMvK/Z9/wByst9tQw4VhWOeP5zvF6DK5/ZEW4R8t/TUecAgjNH3aKZd
 XpZavtVpxomUBdjREczzrZAam0gNZsOhd5/E3+WqO0gqW8fkoDo/T38DiF+FTIv259m45pmUzYH
 ggodbBaV9rfFdUKxAPbbzOZtt8ETTCOUBCACo8nJuNraRkdHQrXTi
X-Received: by 2002:ac8:7f0d:0:b0:4ae:cc29:829b with SMTP id
 d75a77b69052e-4aefc3aa90amr71546881cf.60.1754056287142; 
 Fri, 01 Aug 2025 06:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2viD7HCKu6xS/QJRV2/S6eN0H8AL2SA3fKo1xo5upDmFhtIUjZt51hysctMnmpx05ndtrSQ==
X-Received: by 2002:ac8:7f0d:0:b0:4ae:cc29:829b with SMTP id
 d75a77b69052e-4aefc3aa90amr71546121cf.60.1754056286612; 
 Fri, 01 Aug 2025 06:51:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-33238273006sm5917801fa.9.2025.08.01.06.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 06:51:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 01 Aug 2025 16:51:14 +0300
Subject: [PATCH 6/8] drm/vc4: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-wb-drop-encoder-v1-6-824646042f7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NBwFx/yH904VfCprkWLv97gvBydY/VJ1MCw22/7DCtU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBojMZTWODg7Z0I052lkDGy5sp+gbJXRPPW3+xXz
 I8SasIVGkCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIzGUwAKCRCLPIo+Aiko
 1WY8B/42eKCXBjQZniwEwDivu+L77h8KSZkeqYYq+el8I39V5l9aHEmdvGRms2n+efNwV1ck0rj
 Jy1a9Cv67p7eEXrs8o1zTP+BGa3sKhKTs4lvZWHx3d6YjAcJr2Zg3df9INQWC7IsATuDKgfbA2E
 JhHLnz8c+tuCb07y0uqnRTHGpLB3UcVli5DjTVGH5gGQPYpegIYqh/FVxuacRujIWIvOW4qRCT8
 +FnwXJAsYkPA9arYZIm2kX8awv2FHs2ZTSNfz1ht3uGAjMo4BD1uCkmrqpvMEoLyEzE8gjHsSP8
 5aOgtKUcrk2v0+9aBgHAKiILYunQCCOJCo28SHY+jdKL58YA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: -tXu0aEn4otowciBS8ERidrZHPiHMXyB
X-Proofpoint-ORIG-GUID: -tXu0aEn4otowciBS8ERidrZHPiHMXyB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwNSBTYWx0ZWRfXwY6caVHf/G6A
 eDHSubJhJPech4ioo/RMEqlZcrkxEyPc7XAbCxvpdworUO7w2qN3BM/fyyky9F3wtCGJb4EY4Zq
 fD1MXeMtLvEnzfi87nHwasYpYmY+pDMFhrHtU+ogy54ccnw6LU7SNELZewMl21fJ5pM8mOAN3Nk
 tE9nTrpRBZfpMRBcTlwUo3lkpchye67vxoQuUX09bPMnqJYctHOTwleOL9KNEGxN9f957SXYj8F
 +H7Gj4qCPCWpKeMfFWj6e4aahhOdrMlM+fN8wMAnfmcaWKjFntky98jYXZAzGvgWwb2/pwWgUbC
 R3fz0UGejNUQKkVQ/jQaQerLoDr2xg0cm3Qjo7TNSiCtYvEXtVvPhztbdvy4Qie0VvqY507t3PX
 ihWEy17nqFLUhpa8PB54WqzjUzwShX/D/Wdplg/9oTL6UBkT/4p49LipKw1TB6n22fGQK/ZA
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=688cc661 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=hRdDZflY9wZGYtDLNskA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=927 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010105
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

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/vc4/vc4_txp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 42acac05fe47861ced226a4f64661f545e21ddb5..fef4e4ee47cf41d40de47c5201f0349dc36c56bd 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -377,7 +377,6 @@ vc4_txp_connector_detect(struct drm_connector *connector, bool force)
 static const struct drm_connector_funcs vc4_txp_connector_funcs = {
 	.detect = vc4_txp_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -601,10 +600,10 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 
 	drm_connector_helper_add(&txp->connector.base,
 				 &vc4_txp_connector_helper_funcs);
-	ret = drm_writeback_connector_init_with_encoder(drm, &txp->connector,
-							encoder,
-							&vc4_txp_connector_funcs,
-							drm_fmts, ARRAY_SIZE(drm_fmts));
+	ret = drmm_writeback_connector_init(drm, &txp->connector,
+					    &vc4_txp_connector_funcs,
+					    encoder,
+					    drm_fmts, ARRAY_SIZE(drm_fmts));
 	if (ret)
 		return ret;
 

-- 
2.39.5

