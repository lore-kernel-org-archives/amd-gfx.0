Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AB1CA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 20:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84EF10E21B;
	Tue, 19 Aug 2025 20:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pcI7/53i";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F1EB10E682
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:33:15 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHXwVa002499
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ndEz2xbpBNb9n5L2RWMR2nJPekvJ4u9Qsxz7tSzeQZk=; b=pcI7/53ilcL/mke/
 pFPxcZ0iyDVn+aikqejKPYNI5M4gwpQ7Tcs9PHfZQKBYdpBLpCxatL+NffQnrg8F
 QEM85eoyQmp2/gTLmZNXcEOY9VWDtXSCE6t33xwfm2whXkLX+BEVU+12pF0OtL6L
 au9pE5/8IRHhA6h1udBdAG1dKXRCIEpev9TM31QSDWxgxx9VcELviP/dOu3mMS5k
 lo6t/TZV/YEUFSSoaS2Y+Pd9eoE1kDWuoY6KAIsj2SHCTbaS8ohFK/3a+Jxgf430
 4YNNdUUPqTfKazvmDW9a1TF303UM+QQZnc3uqpkMdVxW1OdzDyK0peAv49EEEGgX
 v/i8tA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh079vh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:33:14 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70a9f5bb140so191227306d6.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 13:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755635594; x=1756240394;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndEz2xbpBNb9n5L2RWMR2nJPekvJ4u9Qsxz7tSzeQZk=;
 b=jsyz8shLA/b0UWdfjYkP7UXv32iM7VqeVDO+J+NHe02EQN0d5s+2/TQDhJN/evWAbH
 eEzLj6OwJ5jyLmFAOP5ys8kFoWnAUI8cqTlO+m1ntue9YpTDSAGrhYFrwRXIbDqX3fEi
 7qRADQuCGqHro3b0BylewvsGZsPD+RlYbBmdR2ruDyOJaNOuZYmdpcSlgKCf1c4XTVjM
 BB7jDP04PM8pAl01Xc78x7SzrOga9pM7Rwzzq745vceusGdyqECU8vkQtl6EoSc32H6f
 uWCeLBlKBURwW8excQVFMS8qFx7f4Swv+aJ9wshJLvvL0Q5ZKeh/AbWQbQ7bDEkmDh0C
 QJpg==
X-Gm-Message-State: AOJu0YzTShyFKMOMRToDEx6fhVVAMqW7Y7ZMt3utaRrCuvd3nHX7o91I
 Qpr4ZJfNuoA4AELBpswHs+b8cNIvphq23A7l8dLgkUiySO5BrcYrORIgGHiDHzXUPzLGC7Upl/Q
 yDvwnRuKWj0fU3ByCBjpDEKUOCYwBVSVgTdmU5H2vxl/8ftV0LgtJA5pqCtOEIacQCPVu
X-Gm-Gg: ASbGncuJAs0EQyWYJBu25NFGnLPLCq+qSYKSoMWwQ87QE2TjccL+dm0eXXU7J9aUryH
 x+ffWnObItIV2ZhwVfjlsvVmTIhMB+rnPcJMF9m9jLFP7Wl+8lGeXK8zSoXru9zKmgG+AZQdMuI
 vK/xP3too4iguZtjaS4wVD8BmszzOw50Frh+45MnOFtmvLqE0PAtTyaKSp3uC4f7XGLGvzOUu7D
 /6xZWe0vnHsqY7Tr/jrQE+49hNsG55Kh/OPyfe1EanCl81Wn6pWkrMkqbPPVyvBFkiexL9cacOq
 DiBzLk2E7IxRNrF3CVCEcTLPjNHPGvALn0hXibJT/ZxYo0NqCt+PnNxbOHLbeqoVliPCDkDACE9
 GMWxK2GHty5qnvTLIQ4WgoiO6OPSehji/gdAA9okt/s48aeaM7Vlz
X-Received: by 2002:a05:6214:2526:b0:709:90d2:4628 with SMTP id
 6a1803df08f44-70d76f92bf6mr5416986d6.19.1755635593549; 
 Tue, 19 Aug 2025 13:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxihLKXa7JhuwwkeFQ0p5zKqK7B3jNVOf3qZbLFjzpePpJRXKGGlC8e34zDhvw9cZPJCBDjw==
X-Received: by 2002:a05:6214:2526:b0:709:90d2:4628 with SMTP id
 6a1803df08f44-70d76f92bf6mr5416336d6.19.1755635592861; 
 Tue, 19 Aug 2025 13:33:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55cef351806sm2212969e87.13.2025.08.19.13.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 13:33:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 23:33:00 +0300
Subject: [PATCH v3 6/8] drm/vc4: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-wb-drop-encoder-v3-6-b48a6af7903b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9kPXh1enzh44Jx+JV9Ql6fG94nEVIAR8Tv81e1DfnG4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBopN98FeUHqsRMxqI2y7bSGcGGmIQ2ngHpJlEtt
 7qfS9PHwcmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKTffAAKCRCLPIo+Aiko
 1aEoB/0S0UbRv6Cn22F8M6h9l8cAG1g8kwox9gPMNA16YkeVOr6K95UiTo3MMjJp7r9L+aqIiYW
 4VY008h32adgxAl6T4rztlv/gbNcK6wpN5EIJcGDsFjXYG6mcjcx1tPbG9kOmBqd3reRp4s1wOJ
 KAz5KS/AtmLz2CYVi6vPsL1PZXzn0Uc9Y1E7/ZG52uZtIAvqY2e3ToYbYtmTF7RKaLy/uIYmZMS
 2VVTZTlmjclBLLn02HJiSZDsiFI9KByjQEssXDY1vWz0MOTsCsts7Jrp8LWNtE7St9nwsiUNJWz
 E+fzSaHhOeKC2+ykQjdy0xhRKprf1e1ISuEYVrlH7d6pc9Tx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: bzbau9zFW_7sK9Sr9zhVfEhZws-gpxOF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX4PLCr+9nsIul
 8SXhNA4F7GlJ+P9HDbViVF9ir1nuwxPDNh0YpKpLaQ2JRdFTON6u5achQjDlnQOkxhiSS4UEdqc
 nA53AvgffbDSzoaH8PDy/8jfgcnGzFsKQWUCQMbeBpVXvuA8NHvbyq2dVqq/Ht4auj4TfdcUp+Y
 Fih7YAauKCMSB1eXC0uX40UfiNCHdtCT49JBd8oUAmNNE0gGHg41RbeOTZlrpyGAnDm98G2NeVU
 tqZ9FnShGlFUbXwyb5MMpo3b13dIS9DnByd4i0Q3RDAskPib3zwj/XpMZIrDBFxlBGhQMFEX3LM
 VbOlm5nPyc5jIiIkFa58ymJ4lxU9LEXJ0zl/BlZFWnoKizkBOjrO+Sbk0WG8xEE1K/1hSpV0qZT
 oh5wjxO5
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a4df8a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=hRdDZflY9wZGYtDLNskA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: bzbau9zFW_7sK9Sr9zhVfEhZws-gpxOF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020
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

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
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
2.47.2

