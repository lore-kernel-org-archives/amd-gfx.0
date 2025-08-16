Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6219CA0EE4
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Aug 2025 15:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C8B710E39F;
	Sat, 16 Aug 2025 15:19:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AqY31cXi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA25210E39B
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:52 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57GEtRLE016797
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ndEz2xbpBNb9n5L2RWMR2nJPekvJ4u9Qsxz7tSzeQZk=; b=AqY31cXiT6LNE/Wa
 gfDPIHid5llWAV+6h/L8oaVxSgGk7ykXtRHfxq9ITeYFd7x+h+dOgXww8mpMSWEB
 EOMxUY6YlNQZqiPz3Mb63xp0Y91aavwQCqk6BPtt4/xXxE+IcYxMQX//pXGgAsKx
 jqRl+Fa+nG3TjKdzeo1RGfYrwc8O2bMaqK57GtZARGvuVa33M8GoCdAb4w9qk9d4
 po9G9mEOb/Al0+GzrZgcnDO/BZwhGoeZ+XTD0TUoNCGSTMjJ7dKgZa1qY116e6iC
 zC7aacZZHGrzVPCxcFRNtNcv+0TQyBelKxl0Z72d7IMZV26/X7h5NIYGzSsNSZC1
 AsHgrA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh070w5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b109c7e901so77748331cf.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 08:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755357591; x=1755962391;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndEz2xbpBNb9n5L2RWMR2nJPekvJ4u9Qsxz7tSzeQZk=;
 b=ENRwBPtbOdJ8rl5frCDyNFNNQvrYAdIX41AsxuQz7SQaTr0GOopxEpq4AsRm2nyGiT
 se42nrCXkLYl1YzFL55LIibO1Pv+OtNGuSXO2aBm8FPLGTRV+OMyZD9UbamkNct9O9Jz
 6AT0khOnZIaSC0lb6dawf5X+EyWY758nWUBVkYMI2KkCQRUlgUqPBqkDQkjAhPSEQYaZ
 2Pim+90k9GM0fVbKSo5v5gVdtkYMmGoZVTl1Vi8yWmv93Vu8xz6i3U+06ZYRUjVVoH6i
 Tsl6pmkyqH62IR03YZfVqprymWFbatx5NbwzTjlVC8UibsaujOPTofA2GFecS9W7dFLR
 Jpcg==
X-Gm-Message-State: AOJu0YxbsVUQ7n+TfirvgfkP9Tq1i+4/MxpO/n3smUc0qaB0H19TDHHc
 n0PpIuU3epwCvi5OKtOirMo4ExSPYTufHA4CzfqapqkvHaKs4KXzpXaM3klXXowio/uIrqvvFPf
 y3DznaTd2UjX43yWSN0LSy+T43EurM8jq59qp6bb8y7WaIs5tvowsWUYe3uOh8RcdWplJ
X-Gm-Gg: ASbGncsF7W6BT+ajEuZy8tAaIs6hqBowgsaL7GKYQuIJMImCJrkoud65gQvbCKnIj9t
 QfmVO3mmKT8X2ah+OQ+4LxsWEeBIiuLZ/hJLXIBXDkXr4LG1jVd6YToW9FylDLycgcXV7msyld7
 7hIg9eoQBj0LZSmU/x08jPVBC7X4km7v4Sca0uwKADpRjxwZbH4XSUOsfh1LajPKnuo4CMo6eF6
 FMctTVKUocWZ9KdAo/z2532JN10bnqhFr7pbF+bP9UpIF5Aq21vLbCZ7FgvkUGw6w9JiF3xnUsV
 2mou/5Jdh9uzEA1HqUBhn1ijuWo0/d8c3YGL/381/Lesbjo9/ks/9jNQ4AY6BormgHKEdDIHcBO
 12mYw6p7ZtbeNdyLZitnZHZJ4mNfuCgSotZZY5NOfw4zQntv9ETPC
X-Received: by 2002:ac8:57cb:0:b0:4b0:69d6:85a2 with SMTP id
 d75a77b69052e-4b12a72d48bmr37236081cf.31.1755357591151; 
 Sat, 16 Aug 2025 08:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKh/+i8IQ8KfC/PGtL5WbCPyvf0DWbyUBL4UoteG6uU57Gcw4lUvCyN3nBm4+guZJlXMKsYA==
X-Received: by 2002:ac8:57cb:0:b0:4b0:69d6:85a2 with SMTP id
 d75a77b69052e-4b12a72d48bmr37235531cf.31.1755357590637; 
 Sat, 16 Aug 2025 08:19:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55cef35965fsm907579e87.37.2025.08.16.08.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Aug 2025 08:19:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 18:19:40 +0300
Subject: [PATCH v2 6/8] drm/vc4: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-wb-drop-encoder-v2-6-f951de04f4f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9kPXh1enzh44Jx+JV9Ql6fG94nEVIAR8Tv81e1DfnG4=;
 b=kA0DAAoBizyKPgIpKNUByyZiAGigoYmi7Z2qV4qHuc0EhD2k/N7ZfvDfuxN8wZARRRVrlbSLw
 YkBMwQAAQoAHRYhBExwhJVcsmNW8LiVf4s8ij4CKSjVBQJooKGJAAoJEIs8ij4CKSjVHcQH/3sm
 ploBZcGyn9igFEwOb7KK+duurcQL+8IUikUxpNTsSBzPUpiPsu1e2gHAun/BzV28c7qAbGwav92
 TaclcXxDkLxqc9FMEZJ1M3OC0myfyvBNMomGmZNtKq8+WdLN/tEfh2JO0Vl3yUV8wOs6aPtLZ/H
 l0C2G+hwInuwe4NU0htEWKNERFlXfSTW6Z8j/+rMDxp5WjrESKCLI+Pd4iHWfg/rVESJNzH52G1
 NmBfh+DTMCXVvLwtvWMwgN2QdOVl9O0pFeflRZX/gd04fcYREOyi3UzGvHdVXPgAoYpkiHw5mqi
 LABSKrPzJMFKH49LcYJDRuJcbaGH+5TXRmkLwzI=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: fNl1H4qr5A7BoypQrOY5p2AkSxrltUHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX/ZWSMmNkROcT
 apkpqIOR8/9GG5IIyOGIcIBz9KAiNwI+yw3r9g2M8fzf8Oi1WGTjuADwWvZjmHL+R42Z+f7dpJS
 +2exxVXRHJwQhD0O4tD4DNUnGdzb/+D7UCzEoi9jNsJ0KT2B2OyZbEVsr2P0sndWBHvGTQFdSg7
 mzs/ewhtMoKpDFpFFCQGiTvFPzSsZ06KUwPFQQ1EW97VoERJzDNqe+J6Fa6sTN0ZppdjrlRoToH
 ms5eZLwohTPMLG/3RzE+yc+IhUzoga7x9X92M6icbSBbcZeOb3J74YOnSOqJXQsg1HiIyqcT4Av
 riyOC9RfkvQOnnuHQP0S8LyALSyfUnHWKPFLS2uUpkv66wgT1fl6dcAf2legErwI5syEwOgccOp
 fmBD7cE3
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a0a198 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=hRdDZflY9wZGYtDLNskA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: fNl1H4qr5A7BoypQrOY5p2AkSxrltUHs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
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

