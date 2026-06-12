Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CB8CD98D2
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7064F10F644;
	Fri, 12 Jun 2026 18:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCgfg1hi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q3Nf7gKm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02F710F64A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:52 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGWE8p019985
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y4rDxNdRWU+aebNlPWMdizg27R+flJppZJLNZrroSxs=; b=UCgfg1hivTnuWEjv
 nioBWrIUwJRrqQ7jqClIPM7Q9GYwG0HQ7iDh8MAi0XjxAVvMqTyoEbx8KK/TIL3y
 vqjX7Rvr8tZ7E9ALoeN+8V6TSaiQUZ3EWRoKcR1R13mevpluMOzlrgeNrqcVQpg5
 sBrUTk1uTzm2v0AP//5vx4kISvAxP7Rm7WRRSNQHBb2rEjHbae0bNQ67GMPV/GBk
 lI579hdewc4qZOzJT1FAnZWNBV2OWdHak+EwLedV+VXZE+mFynZmpx7f7TXmqhtd
 b5TCpsU79jhUL3L3pGUHnRxQ6y/3aa/h2ik5gFKkR7c4kQMG2ITTkq30i2qTU/Rw
 MBQNtA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1cbmh3m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915d1d4fc5aso214172985a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289051; x=1781893851;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y4rDxNdRWU+aebNlPWMdizg27R+flJppZJLNZrroSxs=;
 b=Q3Nf7gKmH5j+J/+pyQkW1GAUWHamjoTtC+BnjO0XS/rYU53rZMjZ3Vhz2wjc0+SaYE
 Mqqo41DXIKvD9kV9nPcJHJc09zopZVIQT4ew+L3O+9jwESOyTEmtQidgu92W8SdBg9yH
 DLueqB/S69s3/w6APLsV65fP5IFhCnQZEASGZRJHc7vsJB5/mCu/ZkkYJd/SsXX0LqMn
 iRGibq+17AnM0qIXa1LbmcnD8lPoPfunXy0GqfXerxxWcXd6BzkXThPwITDA3J8yd6sr
 lMTGoAp9Y6BEyX8GtJcHCvjjIwkgo8NOh7rM5hUyJo6wPtNTqTWbXMdi9Dm4z930eYlT
 xcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289051; x=1781893851;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y4rDxNdRWU+aebNlPWMdizg27R+flJppZJLNZrroSxs=;
 b=es54KiFhtw0/4MVD2d74H8Oa9CQwfRxH2SQZ6aBa6ZmVgG21Vyx161J13gV5R48s75
 LdXnCHQYzYwiKpIXJLTJnPZJsS1F3+PoraLWgxSlqE7PtYZ0kdxHNnuGkDNIqTM6Ij7f
 CI33j///DI0JPdlbAdDS5qsvq7Nhf0eBGMsKndAGccaGaWV9prvFoiFOjIzPvxHOKPxP
 rqoWKDJBoNOtPiPgQxpR4fbFTLF5RgB9gbg4AfFvm/x9zUIcVQc4LxdW2HPA0JjH07Tb
 PdsC6oN6G7L/6GUiXaeVeA9DwNkfCPa/DUTtXbpymJclXIjoK96+80nNtWBfXqf49z7j
 MqGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8C4gsPiCHCQ1xHaETW4b8sRKvLZjTzgwoEWorwUwiZncGenjufgZtiUyWNoRMSD5RB0POYjm60@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKgvIM3Wfy1jAniqMYlMNl4rGO4SaNEh4cGSvb/R52t54xL7dS
 WwiuB98lw61xk51fDUfGFyikgCEP3iLj8//jpeUeh5LjYjyk21meZQW7mlNUyw/N+/T3VPRnASD
 7M1y6gQyVT1/0L43GLr5Q2d9qeeYiLqzq09TZBWk7gF/d+czVf350iS1rgvb0I2mPdn0x
X-Gm-Gg: Acq92OERNbFJE3dQUKjSDm1EKsQvdLlaqKENo1DDeNgH16hSfZpvG98Vfzu5Lz17Muj
 YHa0kxdtTuwy51azn7n4k92XedUU08V7L2Bm0lQjfp7VDNm1FznvW5OHmHZu3pRwVQ0SDEeazub
 m8UPRxhzENSpCYQUpyoOaZmmaBfsiWFU8anFEqgGQusF5O7iFlq7l2tivfZUipKUaqKgzU4cf6M
 LfoYDbx9QLISXMVHYto1BcLwM0FFetzpE5IrUzRwp2E8WuwMrXCMEHOI/5VMzwQvr3JrMDPih8V
 AqLq/RD4YjkhuC1YckPhVmIrbD78fRYzEgR9FSrr7KyJsSIZXYwRjCa9M57Dsg2sXfximTcWMWD
 qG9qp1IpQG/VwbSjK/oB1sWpg+jUKM1PYajdLstGw863biO3FH+shCfPLSRT5VjVkXIt5qYnwPH
 RDvcfNi1zVM3LJOGqhG3mQm5gDqToG6ykkTTs=
X-Received: by 2002:a05:620a:bce:b0:90c:a08f:c5f0 with SMTP id
 af79cd13be357-9161bccaed3mr616314285a.33.1781289047391; 
 Fri, 12 Jun 2026 11:30:47 -0700 (PDT)
X-Received: by 2002:a05:620a:bce:b0:90c:a08f:c5f0 with SMTP id
 af79cd13be357-9161bccaed3mr616175885a.33.1781289037649; 
 Fri, 12 Jun 2026 11:30:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:19 +0300
Subject: [PATCH v6 9/9] drm: writeback: rename
 drm_writeback_connector_init_with_encoder()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-9-9f3a54f81310@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3014;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mE50BYUB/UAw+zq2VOqPPalyAMn1gAB1RtsYcBWwgx8=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5ZOgPm7hKVaN3b0hT6bcClZSGAmt9jj62VfnGUivxSkl
 FVM9wnvZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBE0nay//c/97a2SbnxVfwx
 od8Z9RozxE2/d3rfOSh1P0zje3yeaSB/S/XRfVc0gwKz1j4p+rh++94Wl+wgxd8TAkNsea+yRuk
 IzkpZFXNW2f/Zg8wPmw1neZh0rLrQlVETKHpl3VR5PfVNW16uC39wPqQnxifsyP7V/znnhfAU8f
 19MOXqHOZwNj8mX8a7OduLjdh/1QqcVFZQWWhREPJEaN6UF5xep5gyFXZbeHiX64vXxD6IMfQwS
 a6umKp2szu778CpkNkNe9qmsWueMrZnvzTvmvj93HkySrOP3JyWoKt/4CG/r2KBWtvqmXUH9zu7
 xsdlhL1pebleUHSPr0iMxOp6xdx2Hdk7Pz6Lsx63C/cDAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: vEXu8jsPtNLaCQpNxZB4GtGXQb10gd1t
X-Proofpoint-ORIG-GUID: vEXu8jsPtNLaCQpNxZB4GtGXQb10gd1t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX+OFHBpCxown6
 SZwIqV1k/W6k3ZjnVLs4jlginE7xPrmyhoy47tcENoBYm8cAIc3J/UMIMlj/s8ox8AO8WN3JcoK
 HnXIeW/GAy2wqM+WUUwUB1sSlgFbkCM=
X-Authority-Analysis: v=2.4 cv=S57pBosP c=1 sm=1 tr=0 ts=6a2c505b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=By2WwYRBACVvdXAjiroA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX1SEGBnSTseNI
 PevywgvuX3lT4K0wbi/UKq/IXuboCJ6xy9/uTonCRxYHxR1ZHPFEiutn8lcsXVuEGhwe0hows4W
 qFESJ3sjmd2zDwJLu4AMQZCYOlQ/HwvuMZ9RsgEUeONsJhs87v2ti5k46i62+69BEWEHknKfWxz
 pVvXhEWpwhv0HQTcWEME4Mt002Ek64kjStHveOajJdGTEDbnj0zSi1PHKe1WwVUnh8LfYw5uR6c
 OBrmSrAnlHIZUXaH3Mx8waAXceD1n2QR3IAawnMcED6XA2tdzt/Z4c4jPfGKf45/qKGChUjEF5p
 oWeBwN6r3OcRzIKcECU4FhN/KJphokclRUAYPQPCl0UtElhBhtRfpYRHEpTa9BORi8xUeFIxvSj
 3VTtOJfY05idspCn+7HFVV+WCv6C6OhHRIpDYulAc7c/+Yx/bQOxzAAVoo7qN/H2+hHgRs8zKnR
 RXJaXnVwC3Mn3ECi0Lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120173
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

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 14 +++++++-------
 include/drm/drm_writeback.h     | 10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 9fc15168c34f..68fdac745f42 100644
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
index 879ca103320c..958466a05e60 100644
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
2.47.3

