Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A1ECCF2DE
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA8F510E5B2;
	Mon, 19 Oct 2026 13:13:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F10C910ED00
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:48 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8PDj42193402
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S7nJSSePe19a+M+g6PxMBInmxs8mUq4HTiTkNQcAnA0=; b=DyAgfWMKSzCiuNiL
 jxBH1qF2fgWAoPvlIHVI2vV+Vwwm/HyIEudioyHkcvJcuRZwTBwQbRb7UsYLHVN0
 3G/O5bym3ff+iN0CVhhlmybGoTxsrTuxJDnE9SCmfZhHOkHfXPTdGXwOznRSTaGo
 eIlv9qbe1EYPb5KSGFRaC6ZpZ+klf2NJKsRE99LmJFSJFuGQjjZWL7n34zSWKhG0
 OlQy8R37oxSW7ofDrE9S9urdhc6LIyw8ND6xY5jBFGy52RWYkHZMuB1XSk7aUezX
 kD2wu3QyLhX4uss495l7K9Om4J7FlgiLph1bBXYetwGlK23oizc6Zmc/tC3IRj4I
 aV8oQQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w1aua4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb93c874bso579390185a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415567; x=1793020367;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S7nJSSePe19a+M+g6PxMBInmxs8mUq4HTiTkNQcAnA0=;
 b=jgBabCJ9OUvnIdt55iLJAorHMxHwqjq6yyjvQ0JPFgx1LoD8RH5t7Tcb4MtSLvjQ9G
 fH6oWFAGD0FpBJNd0tF6gPP3nvObtRL31w4GRj0HU2kgPxYd17AcwwnO01wkrYxoSYqt
 jvuqu8TNVZwHKWrwDO/Ujmw+b49vDEjzHNgfMtDcTeOzAMeYflonJXgpeZVMO7JKVTHq
 hI8eJZZsST3bYvfj64RKorFYkb4B35cWKgfGh2nMSa1ZhVkUYbTdq3Y5HCmfKw29PkEk
 BBMMNhhDGh8QKiYx5HbyfIhaMQCH56h1+2HSIan6u19J2avtRhYfULCMs17CKtCkOXMI
 lTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415567; x=1793020367;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S7nJSSePe19a+M+g6PxMBInmxs8mUq4HTiTkNQcAnA0=;
 b=pCHgSPJr9C/+Pr9LnB2HB5sThqJ5vQMk0FvoZfhXsIAFVI85KdLoLqXD6ZBtaMgw20
 lY1UCLJR7dCWZrABI0yVOw+Zujy9a2Ee5YZdVw0419B7j/4CXzNI9bF5Ue6df4n0ic1a
 oHKxWJM+EMr2wwGHSFEGSlAYDGZOs3zB5dy4ONafkP6JMVxd9SAqzPI/4dNBJ0sTSrmZ
 628C+EzHm0xOjz0GKyBvejnmYOkkvflUCnlJSZ8IiIE8exdSyxYC4Jr7tl1//1XBlPvb
 oao71VsD6Rl7Z5hrv8q54+oNf5B0RPIMYDPzsI1LkjYt+URKHQ0DJPKX4qpCBM30agwZ
 PZdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVgve+nLncrdv6d6H0mbWN76vecqxUJtz6gN5JdCrwh3fQMQwJY5+DpmCsbr/8ZTAZunCdh3Jp@lists.freedesktop.org
X-Gm-Message-State: AFq9FYId26sQX1NGX5kzOP0y+PjwaZq9KUtjvBc4L6sSa/InAVMagRnK
 kaVRuk/t7oUIcjkLQ154FTwfQzN7YMPFO/eOyBObkVm0w7c/paJCoi9o3AYrOVH6dql5giCyfGE
 WB13TeckgIJ/t/UJKPEZ41LecYkozRGD2SRMM1VrLvjHekwEGmpDSD1AgazO5nGc17Wp/
X-Gm-Gg: AYBFou2nZjXTvRNVStoaVSEipq5gIi6heir3artyiE7ovApn/xUWRnhcwjjzRitSkdX
 XYx6hymjSW4sWuM8tEOgcEK03PCN9PExBBq+9DKQJqRBN7VyngJVEWled92hmJAnPUyJQubzJ/p
 JZCh8wp40aOiSK8cOmC4sWkt+CLqSg0lzpBY1J3H1r456SwhnpR6SNqc+xlJtUqqy1fJik5tZbr
 /+KpR3kqP+w/eMJwFRXSQDlLUrt1sjH1A2Hvssb1OAAXRqDDCn8u2dDTrKae90PugCikgYwwtSd
 cGQlGSw0t6t1RhsDk1V27upz3ikPrIvQ+VNiCTXAYzAnFar5iuELEp9zifnZCj0D2LNliz+oaeT
 /lp4upbSB9lNeNWV5f+R1fboQG/yVMLE0POCrJRz6QdPbYnI5jIp4wb/LzxAjQ0JKEa/sNx44Jn
 aR/c0h2Ba9btZ2
X-Received: by 2002:a05:620a:a2da:20b0:93f:2571:c317 with SMTP id
 af79cd13be357-93f2571dc9dmr860032585a.28.1792415567071; 
 Mon, 19 Oct 2026 06:12:47 -0700 (PDT)
X-Received: by 2002:a05:620a:a2da:20b0:93f:2571:c317 with SMTP id
 af79cd13be357-93f2571dc9dmr860029985a.28.1792415566587; 
 Mon, 19 Oct 2026 06:12:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:28 +0300
Subject: [PATCH v7 2/9] drm/komeda: embed the writeback encoder in
 komeda_wb_connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-2-d4288a26eb54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3153;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NrouW+lVauNgON0jHseun6cAAxKf6ZXGanxiaBIsFlw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1hdD1DCtkA+u6NCRZ4TR9cfpMtSBKJoh68S5B
 5WR8CKWtDSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYXQwAKCRCLPIo+Aiko
 1fXhB/9ueb/k6E6h5LRWhJ/DwQxRqBdV5htWru57d+0lMYqSjcmijqPs+FZP0q9YXQds03fXB4b
 TfDAdzNVIeBJbUVpEHobAVDjg70zFwtbRgm2XVOUZBwT99umeLuU4Svk18tl90BRqdKmtPnm2y/
 z1HXgJitz8eANW4yE63Z/VCTngNgXcn/HFqj3U7LheWzUKeNZFeYxb4PWsJnM3qCqgLf/IIksTb
 /5SbNXJBEoLb2X4RWfvbSiImpfOkiznb6pfitjNpsQf2QLIzFCkvzWmEKX1d3t8QcrcuyOyWaf1
 CB4Bamk7lyQeGc6kpH/F6WedLX4owP8WHJEzNtDXMS8pPI17
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXwbqm6QYEROuj
 bHEnz5pxnqdN5vULIWc/8qDpSTk5rlsbkAB+GoqpThEQp6ZuTU2vACGAUEsntVLxaE0EliDAb8T
 nyGh09QOnqjrWv7MMiRtgYtqN9pk9H8=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad6174f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=eOsO5XS9GAZRO-ePzeIA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX14JTs6Ke3Crc
 bq6XGAgx7JoSc4aYw6KFKJlv+xf8osXGbZ8t4EoO4j60b5Yoid33rmlnSicMkq9fWzBOywVILVb
 jKunkklgg/eL1CLcaWY97mEj7VECKiI6m/LOg5x0w01nDXwMatx8NPdHuiGOyzCqSkQsCYC/ap8
 05NnNBFCp9du6tNeo7kQ0xsXdlXcGtmuIy525wtzqZuLl4mFXSeIEMAqAhe+zgPvGojn4tLmzTZ
 rbO1QxR6ufbdEXCEzmN+jzEj8izHfT+isc2cNLjXGs6b4vw/7zoL6S9/HCx82tanbRu1HyBYPH8
 8lmjq9yQTdSjfo2tEUJ7oVbuUwrsXEPVs5iMJMxCUUlsqRxQjbH8svXqvkX/ODtS9SbLKsITIze
 xZKUuCZsxUgxSXIY88tYf+QwtenofPHc8I1IoFf+QQE8BaBGxBmw1uHsZimXXel6qhP29i2YzQ4
 6Sk63qOa/zhlV6JRnIQ==
X-Proofpoint-ORIG-GUID: s-F06g5cF4xOOLfdptT79oaA5ZvbXa2P
X-Proofpoint-GUID: s-F06g5cF4xOOLfdptT79oaA5ZvbXa2P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190052
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
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |  3 +++
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 28 ++++++++++++++++------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
index 83e61c4080c2..4d41681a834b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -56,6 +56,9 @@ struct komeda_wb_connector {
 	/** @base: &drm_writeback_connector */
 	struct drm_writeback_connector base;
 
+	/** @encoder: writeback encoder */
+	struct drm_encoder encoder;
+
 	/** @wb_layer: represents associated writeback pipeline of komeda */
 	struct komeda_layer *wb_layer;
 };
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 4872253a2449..77aecf4d3f09 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -127,6 +127,10 @@ static void komeda_wb_connector_destroy(struct drm_connector *connector)
 	kfree(to_kconn(to_wb_conn(connector)));
 }
 
+static const struct drm_encoder_funcs komeda_wb_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_connector_funcs komeda_wb_connector_funcs = {
 	.reset			= drm_atomic_helper_connector_reset,
 	.detect			= komeda_wb_connector_detect,
@@ -170,18 +174,28 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 		return -ENOMEM;
 	}
 
-	err = drm_writeback_connector_init(&kms->base, wb_conn,
-					   &komeda_wb_connector_funcs,
-					   &komeda_wb_encoder_helper_funcs,
-					   formats, n_formats,
-					   BIT(drm_crtc_index(&kcrtc->base)));
-	komeda_put_fourcc_list(formats);
+	wb_encoder = &kwb_conn->encoder;
+	drm_encoder_helper_add(wb_encoder, &komeda_wb_encoder_helper_funcs);
+	wb_encoder->possible_crtcs = crtc_mask;
+
+	err = drm_encoder_init(&kms->base, wb_encoder, &komeda_wb_encoder_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (err) {
+		komeda_put_fourcc_list(formats);
 		kfree(kwb_conn);
 		return err;
 	}
 
-	wb_encoder = &wb_conn->encoder;
+	err = drm_writeback_connector_init_with_encoder(&kms->base, wb_conn,
+							wb_encoder,
+							&komeda_wb_connector_funcs,
+							formats, n_formats);
+	komeda_put_fourcc_list(formats);
+	if (err) {
+		drm_encoder_cleanup(wb_encoder);
+		kfree(kwb_conn);
+		return err;
+	}
 
 	/*
 	 * The writeback connector is associated with a single CRTC. Make its

-- 
2.47.3

