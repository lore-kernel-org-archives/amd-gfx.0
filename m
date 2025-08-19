Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373FBCA0EEB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 20:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECBEC10E674;
	Tue, 19 Aug 2025 20:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SjU+1JJl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C7910E672
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:33:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHSfCg018032
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3LiTGbp3yrZlb6BdgcZ8Qpq6CDIhRX/Qyb9HMEmTyzM=; b=SjU+1JJlEMN5h9Lq
 moBhgBbX7sVHFtLKHhg1uDJF+cObpbBG1wEVxbYP1yKWK8vYKsKnNLAl/eBnBC+o
 h77RKV8DW2ANEg1sBVNkx0PbDgc3asTaQv9UeGnJNHu4QnWT8RFv+T9xJRyeL+PE
 RBX27Qu3PLDQBXT7lfmo6AiRpdwuTsz0CikBraO/amPvw4feNj5Xb7/foe/kDxJ4
 VuP07j7pin7nS5EGCHJRGDDmTM/T/PSRgnQ3kusPhpsd8NlNT8qfCvXS+5YrXzdX
 EEFT7I3RhLOKpPQaW9oEhkt1UWrykB63FA4/onp3niGnghnM4488Hl5m2ojMXfII
 OtRueQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhah1u1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:33:08 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70a9f57f950so123708146d6.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 13:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755635587; x=1756240387;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LiTGbp3yrZlb6BdgcZ8Qpq6CDIhRX/Qyb9HMEmTyzM=;
 b=LJ5kbFAwPualtyz0QI/oEV5Le9LCoqjETwgJd5Lcv31zhVnQFP8CL/5lD45tRaxP0X
 ynBnYGEec6sYl6AsZ7RkXqG7avPKY0+Ct5KAdOl3Lyz6/QUmE3LfruYJtC9vMkJ4Ykyv
 vQkMle5rupfwpLATqDfR9CBwscE2I+xZbaDdWAElxNaWPSggxqMzTuoQnGh7XmdnaeT3
 cNoiKSrUU6FITZLa/x1mgv6Prb87MSmLtNnm/QeouKOuaCBaQz+NxNOZAzPUDB6Z7jqP
 IZUkA3lOsJ27Ipb7Ud9wXLCfQyvScWCRH0clYvcpvZE/HJ1dD3h1HApGVM9E1ii1xubp
 t+CA==
X-Gm-Message-State: AOJu0Yx7CuDLJwbhRQ2k285mwLyvwm/usVuBevAtiWhIudKuHahnU44/
 mYA6sNeHKQdTFp2wsTzjI7H2iEQUXanoI6w9RNfEjW0YadpNPfnzorLYyijQK99q2P93DJRt/ZV
 ovKUaQXOdxfSxPFOiKyCUXhdOPV3dHlX+OtZfizECVWFP4eWP497iZFEWOVMdlfy+8eb6
X-Gm-Gg: ASbGnctzOZdbc/hrbVzva9JQMaGwSrX9Ocd5LPRV6bYsfq8u/Qpn0+/lt30fsSzqrZz
 jm+oojyAx9V1c3lZXwP1y4mPqvaM0BTixaY3N+M5xE6KetJKpHHf898LdqI2J2P1+36fM1DntV1
 tLnCaQHgtnIx+IE4VRFO6uV+JQRlAaOkEOIXdtIUOn4JhnTxuduBeqqvoSq5rXfV7cbHk34Q/FV
 3qnPqflgAHyY2G3H3mpoqUBhN9LqNJJi7cWLoY8zih3xAYfcO12TnTGVuEzmZoCPG6DlpwrosSo
 Qdcu3bkTYIw1jrpHbThiF7RVveDkCB2Q2yAh2MjB/6OPeLKOMrIQsJINfh6N7QcQtPNheu9VH3w
 m/ZVwrZJ4FwKlFfCAWpAfK+WhYqypnuD1Io95pKXkjVP6U4yPLDN9
X-Received: by 2002:a05:6214:d42:b0:707:4cba:124c with SMTP id
 6a1803df08f44-70d76fcc6d0mr3925236d6.15.1755635587373; 
 Tue, 19 Aug 2025 13:33:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXbzwbtPTMthExC2v/jPPGR0U6e77awEra/VfApnsoPxFWnQVPM0TA/4e3XCxu/atusvWn1w==
X-Received: by 2002:a05:6214:d42:b0:707:4cba:124c with SMTP id
 6a1803df08f44-70d76fcc6d0mr3924596d6.15.1755635586630; 
 Tue, 19 Aug 2025 13:33:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55cef351806sm2212969e87.13.2025.08.19.13.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 13:33:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 23:32:56 +0300
Subject: [PATCH v3 2/8] drm/komeda: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-wb-drop-encoder-v3-2-b48a6af7903b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3013;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=FAStH94G7STx9dmih1BwY2moi+ekwJevO6V7oZLap5U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBopN98pXeI0YI5rMMU0cfAZCQzyHd5SV6fCosRp
 2k4DpPn0m6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKTffAAKCRCLPIo+Aiko
 1apAB/9Wed3uT8K4J7VbxZQYRdgbqkXEWuchv9h23rqen6qeVxtKb3hxBGlgSJGYV9xreUNSJnt
 kycaE7r7dHO6njLoIlrsEUjSpp8QhzDrdB3TkUHQI/qXhPZRO6jFnnNiIze3++SQeVxeLeQq2PZ
 2rFLFqfPI2FY5msigg2DlqPrvKPoUNuVNS7pdu0UY/CvuGxBWQi4zhvckEkyL9Hux8vTpJPyf/i
 6rhXGOI0GDWURVYOezbaytNWfpchR77qNdCUgqGdCF3fhHq8AI+avLEXbs+dyFKUqhzUgbLepqT
 7umscLV59LLEPrJSAUSBGxAHsDU9svqZIx/JOZbeay4TJd/a
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a4df84 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=EE5oNXVUeA2ILyHCr4wA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: rN21Pe6ku3u5Ehw0WfTc1oMhUxxLiV_O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfXxVfwisiaYdyN
 s/CduHyrGyId5rheGPc7zsI2GwpQjrodPc1mOADqwQ6WL25RPO3uPqTUBrd+hClnxFt1SkGiBoZ
 iKH3rgDyogkKQPsgP9LD8fLKP2/1pAf/wCVgGtRu5lUmsn5ZYZnDEU2LBxUW62LlCz1WgMjKTJK
 u2/M5ImlI9jUGBmYpXDN/wKMk3/VuWoPvT7igHDGzurhIL5vzK165hDmM5mDHbkpE6ktzcqL0x+
 5qx5wAx/mi+bMdGBJ4YL6s2Uc2FNFlASYVaUoK6jKUJywFT42vsEHgqZUe75kg6Firp83ZsqZy/
 wih2q3lqKlBacAxO0ewY+iLR4JbaZWtqIulYGSqiM4ZLlBIElEVt54JoCfZ6viV+XaeUKCjcc8q
 EmP9hJ0l
X-Proofpoint-GUID: rN21Pe6ku3u5Ehw0WfTc1oMhUxxLiV_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024
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

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 30 ++++++++++++----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 875cdbff18c9dc97e736049feaa8a1fe1bcc82ff..bcc53d4015f1f27181e977272cdcfa35e970fa62 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -5,6 +5,7 @@
  *
  */
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_managed.h>
 #include "komeda_dev.h"
 #include "komeda_kms.h"
 
@@ -121,17 +122,10 @@ komeda_wb_connector_fill_modes(struct drm_connector *connector,
 	return 0;
 }
 
-static void komeda_wb_connector_destroy(struct drm_connector *connector)
-{
-	drm_connector_cleanup(connector);
-	kfree(to_kconn(to_wb_conn(connector)));
-}
-
 static const struct drm_connector_funcs komeda_wb_connector_funcs = {
 	.reset			= drm_atomic_helper_connector_reset,
 	.detect			= komeda_wb_connector_detect,
 	.fill_modes		= komeda_wb_connector_fill_modes,
-	.destroy		= komeda_wb_connector_destroy,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
@@ -143,13 +137,15 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 	struct komeda_wb_connector *kwb_conn;
 	struct drm_writeback_connector *wb_conn;
 	struct drm_display_info *info;
+	struct drm_encoder *encoder;
+
 	u32 *formats, n_formats = 0;
 	int err;
 
 	if (!kcrtc->master->wb_layer)
 		return 0;
 
-	kwb_conn = kzalloc(sizeof(*kwb_conn), GFP_KERNEL);
+	kwb_conn = drmm_kzalloc(&kms->base, sizeof(*kwb_conn), GFP_KERNEL);
 	if (!kwb_conn)
 		return -ENOMEM;
 
@@ -165,11 +161,19 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 		return -ENOMEM;
 	}
 
-	err = drm_writeback_connector_init(&kms->base, wb_conn,
-					   &komeda_wb_connector_funcs,
-					   &komeda_wb_encoder_helper_funcs,
-					   formats, n_formats,
-					   BIT(drm_crtc_index(&kcrtc->base)));
+	encoder = drmm_plain_encoder_alloc(&kms->base, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &komeda_wb_encoder_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(&kcrtc->base);
+
+	err = drmm_writeback_connector_init(&kms->base, wb_conn,
+					    &komeda_wb_connector_funcs,
+					    encoder,
+					    formats, n_formats);
 	komeda_put_fourcc_list(formats);
 	if (err) {
 		kfree(kwb_conn);

-- 
2.47.2

