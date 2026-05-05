Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38E2CD342C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 00:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661AE10E8F5;
	Tue,  5 May 2026 00:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+r1w5Fc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z+GTPZ8Z";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C08410E8F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 00:25:47 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644JhhYN331121
 for <amd-gfx@lists.freedesktop.org>; Tue, 5 May 2026 00:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IGPbsFRj9AcR1JhiLP6QveYjBGQn12/jz6nJ82TmXuY=; b=E+r1w5Fc2T0hs60s
 cNktpi4aZrq20ghx+ylb7uEN8/txOPRbTfbZeykzOQepXSe1dnnn71jCxqXKncyM
 bGyni6FW2vBRohz4rgQw4qIJOFm3F4KuyZ3KggFuWWefz6xIpTuqJcc3fZUpDLYf
 NJCQEXtW84cw1b3BwbseCxyIz8iU/DG0+oNjflW8+TFFZ0Cn8aesJvXR8nARQYHW
 Lo1YhQH3OllZipvbbz6vdQWGxt6KUtLmNDJS2A1rLpP1gYU4hdF4rZdLUsa3dvQj
 b8opRDVa5Uc6RP4Ftv3sEdktaPp8GTnywYb6qBl/8CnzJ17YaGA9bd9b2wu6wbHS
 YV3ZzA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvr1a50q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2026 00:25:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50f13da9684so58874441cf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 May 2026 17:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777940742; x=1778545542;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IGPbsFRj9AcR1JhiLP6QveYjBGQn12/jz6nJ82TmXuY=;
 b=Z+GTPZ8ZkvtSiEPapGTQlb/S+WCu2YEFTeRykj/Jc7vgoCIfmH/N3HhkbB3FTEyoFU
 V45y25mIeBg8RbCbcxyF4I5meSjGaRgip/05OxuZPlStmzo8tPvYQPDjDK/RSo9bwQou
 rEVAIus5tIWuWUGGzjNf5Fr4YOKzRuMyEjxRvCI0tUhNIofHzK9Pwt4Zm/XYKmmyVs//
 HPo875yT53AaXMKCBvwGG7ywupQyr3xK0Un90k0bCSNmU6UBFJYSE7ZyVaenO1JpygxB
 PUb+DzvsGj4IYAP5n3P9dk42P798I+up9DQC4GlUzoS9HEeaS/u0tayCeOppe25JH149
 QDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777940742; x=1778545542;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IGPbsFRj9AcR1JhiLP6QveYjBGQn12/jz6nJ82TmXuY=;
 b=jQsLKqhJdfdybQNmSaseOPgMmiJ3k0paafzDZ3uEnBdcmLuSPm1d8FiYAua+FacfAe
 4XIpgIXVTAQrrYX1eQYH9G+mFsvFWL448ET8dNzyj/GEiBBnyk9La/aqq61p9HQYLflw
 jd0HxbcYUKQTR907S8FWQ6418238mebUU+G+faN8vruSQb0sN8zdZPNi1YHmdpXkWLgi
 9fTTnkZL9Nxjc4yp01WBfMzQSLCmq7ESVBlBxiwYWCXSyzmlJF8PTzmUeFXQIw7lEWMd
 TQiwxM+GlF5+8JWn+mXT9oRaaMx88BTSPT/tmebBwOzFxFWOIvT2n+9+1oxsE4N25aXQ
 6Ifw==
X-Gm-Message-State: AOJu0Yzhmq4HbzmRZ8L9u3fbCqMThO7WRGKOm1PwdIyykE7osaMQo+HR
 hLLH3fcKsseiaPOGK//gc2G32jx6gPge1h4EzguK3avQgsp/leQrLb7ctDzLTL8fWgHqsAhNkJ/
 i3rY1RtqW36J/uDHyOOpO0Z7Z7YcXbbBEQlCTkRunOIo/eKFlQbvGpht9h26LZ20P47de
X-Gm-Gg: AeBDiev4XOAz9Nev1o4XjE9lwsWSxFc+aAkhgszlMR71WX4Dz0EYFs8tkR1MG9l06xe
 RNpbfPjeRorqbZnxley+wyj4pMTLMzjc6vru3BzULl5rQW549/BT+VOiKP4k0InPWyxleJLzUSm
 aUz6AhUyxzPMIskOOqMZCQWdyJUDbNchBwKK+eztIK7QODJs5SgDjKS9LkRVqzQ5jNL4PP7f+ha
 RCXfpzRxeQLMQ7A3bgfBrPWmvCju2PvhEf8ZcXxwuPwbxfBgPidtGJlAKStUZ3zy8AhMFbQ61fn
 zcIIWeDYkV5qF9Qdg2OnUb42volG3A5s2r00rmmQqhcFZ2X36uBC9y/9hg2+rVl3Fp95nGTtr9Q
 AnChDi32ku1WUH8YpFlRqw+S/CtPNb+08zFIoRMpM2YFGaLO5Ewmx84lCl++3JjJdte/Q2t9//x
 Sq/hSRN8ay1x1aT3f8MMPUsAb6Y3zMO5iah5CevqmL8rI8mg==
X-Received: by 2002:a05:622a:4cc7:b0:50d:a56f:6085 with SMTP id
 d75a77b69052e-5104c000210mr174309861cf.43.1777940742380; 
 Mon, 04 May 2026 17:25:42 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc7:b0:50d:a56f:6085 with SMTP id
 d75a77b69052e-5104c000210mr174309381cf.43.1777940741886; 
 Mon, 04 May 2026 17:25:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393610ba09esm37132781fa.10.2026.05.04.17.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:25:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 05 May 2026 03:25:03 +0300
Subject: [PATCH v5 6/8] drm/vc4: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-wb-drop-encoder-v5-6-42567b7c7af2@oss.qualcomm.com>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
In-Reply-To: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
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
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
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
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=behk6Tmd7pmo6mRIbuSh89UzpPSTMpSIp59mKcXVLLY=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+ZPiztPJkmE97W+e+LKVL3eX/tHS8K9KXwCspM/Py2PD
 3xwcff0TkZjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBMREOH/Teb8FaWgNg3Tkw7
 RfgfGi1h272T4ff3+AoF322LXy7SEe7+Xr3paDRbyT32HIuj93W+Fp7ye6qwbFevRHjRkwM1mx+
 sTY7iuXvpo0TSPdUpv+bUhn4WEVprKuEZoc6YUrCCKc6mn+G82yr39Yb7ipJeNSr8tD6xyVVxgl
 7V1w3e6amXpe+84V162jB+8wvHSy17lHl4Lmz28ZUxt5uV5ykYfXadk+E9LWctrYoDX86+zY6Sr
 fm3/0SVX3wYs6+HgErvpvrcQK0t91QDn3Vc8z73XU3Hr2VXo2T7BR31zBvtOotmMct1OF233Npz
 besv8adfMtoT1KboFsTGZFpLl1p8Px+x/On9KGe/r+0vAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: Xf8uXkBM1OEFG6JedLLJ_g0wcinVors5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMSBTYWx0ZWRfXzOzskttMfWlV
 KqCy4BRdP+LiA8RI5i0KGocjBITsgcZSZnjvzFmTUtXlIu+9SR0ffHFCHjTfJKFVGiOI7BJ7eg9
 Qa3FveCh8wQpCcJXGYRwBn6SPAmLIheGIkeYMFpLcRDumfy+1mnSOeGxq+0E5Rn2ip9PSNlaGWl
 TsZjOyNdgVjfiuIRil/9mkFt2QrxdU63p45F/W7hWGkGeX640EBPjlPo9ndXvzMZ5bWAwytU0co
 UVgx8ackNPijGtV7gnxdjWltEsLXnljXIr7ckuiJiR0sbZQj2SqVxF5Ro869wGPbZcqpIH8fn2E
 Qtq5RmCu5myBZrPFIzSc5jfjFddX2XoH1F6jCNLMMDb/7UcOySuCzafNUvrGQF/8gnXWWkQUCZQ
 q2/Lls2EfSAapXg5t4PPZ3fP623ZNj9aLUG68PLcNqym6+BeSx+mY+bXc+Vr9Xwc+ifSeqAVbEh
 oSRpMoNY6DwLDcnYYTQ==
X-Proofpoint-GUID: Xf8uXkBM1OEFG6JedLLJ_g0wcinVors5
X-Authority-Analysis: v=2.4 cv=RvL16imK c=1 sm=1 tr=0 ts=69f9390b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=P-IC7800AAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=YDDQE0DzCl7hcZedIR8A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050001
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

The driver uses drm_writeback_connector_init() instead of its drmm
counterpart, but it doesn't perform the job queue cleanup (neither
manually nor by calling drm_writeback_connector_cleanup()). On the
contrary, the drmm_writeback_connector_init() function ensures the
proper cleanup of the job queue.

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
index 9082902100e4..befdb094c173 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -378,7 +378,6 @@ vc4_txp_connector_detect(struct drm_connector *connector, bool force)
 static const struct drm_connector_funcs vc4_txp_connector_funcs = {
 	.detect = vc4_txp_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -602,10 +601,10 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 
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
2.47.3

