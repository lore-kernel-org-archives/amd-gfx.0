Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47A8D3B7E5
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Dec 2025 17:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E1A11B01D;
	Sun, 28 Dec 2025 17:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nHYPAMyU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R2mjuOxo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5A011AE8B
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BSEkYCB3483487
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 stPaTlDyP6pjIcLXxQYHh7Ugkri4ssOkoL6G6tZaLY8=; b=nHYPAMyUOg4sCsC4
 eB2ocb4P+RrJTbrr2y+1AnS4GWXykf+30iVKmKrxfhWMXN7G7naVKHSGHx/5gaH+
 Q/Qjm+FpVgVYXStDPg86nHoGVpaZe8s5N4+26SfuTnzB4XfduT9iKuavdpu2aLlX
 EAf1wOxVxh3fQv4KBwz0bVIU/hZF5h/fqhg0wOoAjk3R+ZemDHhRvM+dqeMmwiQS
 IY2ufqEuY2hAz9DkeWrRKpKwc6osNB5VY5wxro9fHx+ZcjGjkc+LG/9l9PMCQF7L
 Qu2ew0tn/y7tbJtB17mpXJZKvmoO6SXpKmndZ6KxVUDKubC01Fnp9pKxKx+5IMgP
 4dF9Ow==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6f62jc5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4ed6ff3de05so235952471cf.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 09:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766942511; x=1767547311;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=stPaTlDyP6pjIcLXxQYHh7Ugkri4ssOkoL6G6tZaLY8=;
 b=R2mjuOxomfSysPIvvPcJSvjHe459kOnNE0x9w+nPK7Zrs4ArhUYeA/4jLyQnbo5Fse
 WIFRmIjrYOltkRr+52Dkbcqkt/YhveEs7nS/4UibsBcKK5brQ46/yo5g2EMKco49xdMG
 CnE0wkI4KPVLnu57bPTOCDT64PTv+TRUvTzzst8wgslufrwpGjtkljJBk68Ztd6ta4cu
 uiT9mjv3yWkeCzTz6kpWsMVlDEWaVQg3XStv+ol7W+GLIoYnJ0Yook8r/V/ifHLt13Lk
 L2ztSd7X9drzgDsvRQMywJcaDzr92ypyTis9qNWw5fWXajB1VAtYFrZi59LTxD9heiBZ
 k10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766942511; x=1767547311;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=stPaTlDyP6pjIcLXxQYHh7Ugkri4ssOkoL6G6tZaLY8=;
 b=T+msLsndrN7YMxgkbtllhak3KDxBff8sIsJ92AP1Wxt0DeGLdJAtaVdWygVJCeQsiu
 rAwIZb5APnQecjmg7gvzD8XqQ817K2Ih5t+zQigRpp0NBxf8Vx1TOdlXrLphGBV96bvV
 DoxJcdfteEJUfLLUp8vR2AqO/r3nNfXUGwr+Wvn6p0vORiSVkCQ5VAYd23ysef0aXvHJ
 2IviOLQ8fTMdqHRjt2eJQKEFxS/taKls3zc9FiBNT3d4SFV/Tht7MsBAyW/etyicLSjR
 Uo1oQJJpmAQtrXaL9Z9QqxkpptsYzmzk6Vyvp3GWXgma5q9mnYfBgX0GMywzmuCnX3SW
 fmUA==
X-Gm-Message-State: AOJu0YwfesewoMv50lAvkrcB159FNWsi/Xyg6hNEOldlOfVz9U5a/NG4
 Rmo+UGcb9ccFiRGgw/O4bBgkpjR31unxcs61cg+ZEO9Etf5hJtSwuNYk217hF5keX211CTRICBs
 8FigdlIE9xcWzGw6ROJ7GtOs5vmye56BKHHeZj46dxA6e57fFDl89Gn92LSf3QnlsaR0Y
X-Gm-Gg: AY/fxX5Srmub8CTDr/HKPB/Xzjfc4K1d9yFAFDxHVq5HZRu5/S0+X7zFd7JWVvhl4um
 9IYIhUUTbv0F5Gv70eCFEozzibi/QPCeL35B76O/JunXNT2i91eMfMDA71d0niGYcMIVZSejfJ8
 P08N6JAXDGSMmNyJobRRKqHCHgTAOwRUqVa3lo7dBloHahDR7LUnm0AK3/iYUXQVcQb5+2oXbAA
 +r9GRY9CQ5bjsE0d+2jcZ7yjEObsv9ei0BI4R8EZel3HrkdPwRUBOAqk1/SwJQG48IP/S325DS8
 LtqsuANrMqk3omvh3oPf9I/cSxwU/VXFDggr/z05JrgpKwbKK7VGVBoi+4c7Z/iwQzykZA/PLoK
 jcUj+N5phAat5z2zyOU5R7+BYWUnQM/mT+rr9WXJnOKOxLdrkPP498VzZluJNSJ2CBI7K2Povmb
 uxs24Zgf2tnRodcRrgZYtn5c8=
X-Received: by 2002:a05:622a:1f88:b0:4ec:ed32:c3f9 with SMTP id
 d75a77b69052e-4f4abd055b1mr480629871cf.29.1766942510574; 
 Sun, 28 Dec 2025 09:21:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE46X5ME/cJSAhXh+LJc/4rpNKJJcT6TLHe0qPrboYnIgch2/evOzlw9QUxO7vnvIRO7gsLtA==
X-Received: by 2002:a05:622a:1f88:b0:4ec:ed32:c3f9 with SMTP id
 d75a77b69052e-4f4abd055b1mr480629561cf.29.1766942510201; 
 Sun, 28 Dec 2025 09:21:50 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3812251cfffsm76871031fa.19.2025.12.28.09.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 09:21:49 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 19:21:38 +0200
Subject: [PATCH v4 6/8] drm/vc4: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-wb-drop-encoder-v4-6-58d28e668901@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=xzYTa/EfA8HI5QOy/2+R2YoV5rkgAh7n+QXK0lkObWo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpUWcimSXjC5I40z+YRP5l4N9Pd8rbhOQ57vQMn
 zZaKY2yKwOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVFnIgAKCRCLPIo+Aiko
 1R9HB/4mQmUa/OGajO4xKbD2IFdVvt+++OOPGvLicDm0j7FhJTr7p//We0wf1N+GA+QqJGZ0nxy
 V4ezDgOozgp4Uvx8QVOLOfZz1xUCjntHe6O4xTR8UBlaj/LqAjoRFm0lUyAdxxLMEyEU521iP2N
 ZbOLK1AC3yfLU5himWI3isf+GJ2dM/3dxP0Q1fOlY0QNu5wf6/qTsYGOUaKHuaiiVA6Di+FJC//
 +rGCKFkjOC/N5dGVyYL6EPg/z37Z0bKg7Niw01ZUka5FxAQFyR/SupZMD46M2HW1QCY2VYCZ2nb
 QUVy5ElbO6tShYK9+5jf+O7QjLkgOhuEc9COHlpUlxMEv6fO
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: icXomn8hqprp923BbA56XVoVM4aYe_b4
X-Proofpoint-ORIG-GUID: icXomn8hqprp923BbA56XVoVM4aYe_b4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OCBTYWx0ZWRfX/2a7nkTQ54+J
 3iSVhH4pOia+83ajxOg6Vi8mD7EseqbbzN2YokAoxyeUQ0fBZM0r92NO56eTuRKk/l/i313hMYv
 9sr3WSGzPnKt627IMmM6DOTexaUqnW5mrJVLBEAP06f2XncMgiITRcNGPpems+ikVxVrKmCmXhk
 tRQpewEUZLR6+nT45zNxA2f1eJVtf6IrOpNK2zDCNZR3HwjtMTPGE7C7yxABpUm0pKY7X+ShEJY
 b1PJey2u1GSbAGC2q6WDzWGdgVQqZvdx8/ZiBgwWrNKDDW1uzpu1UoJ8k2fmt6kao+LF8PkCm4d
 V39RT96UHAEVljelrxSPoq7dNq/Q8J1TayMvP65yIYKawsOx4wlaVp5cb3aeN7kxSOLH5/Lbqlw
 oprjb5XL7x3rCCmUTyG1Lew/YcGAM6vsrp3jRdmmf5nAhAjgyKOoqODkod5ZgZyeO3ZJcv3u/CL
 W1d45v0Fgh0QBT+7kpw==
X-Authority-Analysis: v=2.4 cv=YuEChoYX c=1 sm=1 tr=0 ts=69516732 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P-IC7800AAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=VKUx2AQ49gFIcjACzlMA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512280158
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

