Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A64FF885A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 00:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2761F10E8FA;
	Tue,  5 May 2026 00:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K/BMwJAm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jcC0VKkq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B4FE10E8FA
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 00:25:56 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644JUMEC299982
 for <amd-gfx@lists.freedesktop.org>; Tue, 5 May 2026 00:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y4rDxNdRWU+aebNlPWMdizg27R+flJppZJLNZrroSxs=; b=K/BMwJAm1EgVSC0H
 /UWzYKdQV25HgaWN1Q4EQV+EWf1k0+1xWKtDFu0zA4XvWIKudYzQPzuUMyMNQGAT
 B28V8AP0+tBOW+9QVWOsipLRjRxm3a3OOHIYdWUsjM7RrEN6icFVmBZlqz9bnUee
 SGuyVjqaJVXiVgWvpGkZjMOFORmoZCcOZGiulvf7/ucCdUjyDfC/SpaSFv0gl+Vw
 0lAH0nDaa2wXgyieqauqp379JNwrKjNkkXtDwWZQ/Fi3W10gc6+OLGx3+qDuWywT
 yuvZD8xlcTTl6hhjUq5xojyHScJ96s054cF4AlSBHDlJOk0wlG0itxB5Xyq05dcv
 e32h3g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvnda6w5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2026 00:25:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fb3c7b989so86999171cf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 May 2026 17:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777940755; x=1778545555;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y4rDxNdRWU+aebNlPWMdizg27R+flJppZJLNZrroSxs=;
 b=jcC0VKkqMOZz5v5E7aY6TrJEAyNW0DvJP8BkLJbNNeDzvzmnv+Nc5eYAzhJS33OAEx
 OksK7QgvUgEZqTF1bYGOo/kqmLfor9fNAu0XOLSlHZzMamWYB2watM7lbtNV6RNB4AbR
 RK5SpdkIuCOptaI+HqDnryoA7Ppp3TE7lE0UtNXuknYeSqY7TbjBr4HA/3+8grsT/G48
 NI0TCWqTi6DTFcNqcO5nGVjW95Ci5VBj6jejm4q1p0F8Uf5mOJ2gC6i7a79D5k6la7Jp
 CWlJUBI2JLi59KZJIbSYblPyN65pLCBfvM6RXqveoUG5QAOYqwCx1mvWFAPIH6ddx4+X
 GNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777940755; x=1778545555;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y4rDxNdRWU+aebNlPWMdizg27R+flJppZJLNZrroSxs=;
 b=tIYxD/jcptSsMA3m1G5KvDlWuD7eU4acjoMq0T8TxokSTDm2Vt/4g0TOnJmyf5yHlB
 Mij0no8zQC6xkKLCHmeENB7AllxP3WTn2hoYCL8yXHhtb5ywqe9Icle/zw8WxSEooMZl
 H8mDXDMq+ZTai9mIo1j8Wa65ZnN+I2U5flIXNQox2oHdAwyspGBQzVqRHQsCgNsckRY2
 QnQsekeF7MEwy+o6j4lGrS9wuEhRsXVQ9U9LT4RZcOMsZneYLgksOfQYktOW0DiJbIeM
 Vgm67pNUMdNDPaJQNNyb1k1+/4EiIN4Czni2ZSwF1A0MG0Po/y3/r/k6yZrusPrMe1QL
 0hNg==
X-Gm-Message-State: AOJu0YwC3/d0WJjvKj7ZMqFu+/pO5F1rQdNwTMRE8+EY505+vqNl2itS
 4jg89ATHsSNsPiQ8NxX0JVskiFQoNWV/2Q941iIv8bqKMgQ1oVrYO+CI+yF5tklJ0G61Yc0PTlc
 LciAcquTPdqGL9jODYbUTyxQn3DdaU2d3xbjWtC1fGSbLOSRoWVDEfklnb/BTHEg2rjeC
X-Gm-Gg: AeBDiet4wskCa4I8FPm/TJYteNCo2iNB6itJ/auUW4ALfyP/kyDw602xZGHYucg+A4z
 I6OmAGkooJnYOCnEyvDiuV3jHRKgiRc5lKuKhG/Pv0cXDBVuolPCLspXdHehQrTFexrMLLzGOSf
 0gYwaad1BG/XNgxkpn5uqft7Cr2XGUcTk8SZ8IfMaUM+crxtpA2mFC6M2GPtd1TJyY0C6G2h4uz
 xfBw50f8htMtdMXFqBbUEoVN1qnJeTDmxz2UZUTFw7DkSWi4jh3OdT/gtZD94eUc7l3wrg6157z
 uIpE4P+2aCXpw9ziUZdQwAxZTz87vmfq32CRP0q9Qa3ZjAJQuOELy1SQ7xC/7ZaWYW7PBbZ/9Ts
 HyPnmT9uJbttArOEptb3jf5FBmcVEbm010EJeNYbNyLPcKLvOo3lvOwMjlbSU178GP5F4PtPyKK
 nlU6+4Jp7mRsOE8xb+hJgEtMA8lSELORke1noWT9IxOJGL4A==
X-Received: by 2002:a05:622a:4c83:b0:50f:b4c0:62ff with SMTP id
 d75a77b69052e-5104bfa6b9amr166831121cf.54.1777940754419; 
 Mon, 04 May 2026 17:25:54 -0700 (PDT)
X-Received: by 2002:a05:622a:4c83:b0:50f:b4c0:62ff with SMTP id
 d75a77b69052e-5104bfa6b9amr166830581cf.54.1777940753775; 
 Mon, 04 May 2026 17:25:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393610ba09esm37132781fa.10.2026.05.04.17.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:25:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 05 May 2026 03:25:05 +0300
Subject: [PATCH v5 8/8] drm: writeback: rename
 drm_writeback_connector_init_with_encoder()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-wb-drop-encoder-v5-8-42567b7c7af2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3014;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mE50BYUB/UAw+zq2VOqPPalyAMn1gAB1RtsYcBWwgx8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp+TjcXTDEmBL/PifKO5n4u9XdLzRyirOofSZ0t
 R5jHaCLw4uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafk43AAKCRCLPIo+Aiko
 1fRrCACGOoHDQH4QaIwa/GwT9MrEbWmX7l37G0lci0xr/0cZZGn7Xbv1H5YVaHy6Jy26K8OsEKv
 S1oFOWhfiWWmPop4LiH2xFuCDz445YbGw5v9bxZiZXLtNlN205+VCu6A1bTdwk/tZAQTCwt/hxY
 IIExi09aX3uRiJsDHR829mUb96OKDFC+vddC2WLqFsb7j50M4INLuMHhJqKqEcywPNc7D7S/SK0
 1vtK25FJGIvjReowOwc6NBiilcdlB9HAjDCzR1ne8Jkg02DObvbQ3PEIOtNJFcQDRfdCBH8J3sN
 s1qv0znAaU8Hh2jKuzUPWrKL35p3EJV4cPleldHBAY1yYn0z
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: AB__rI0RrCxDymAeW9qCqEf4QCcVAKLI
X-Authority-Analysis: v=2.4 cv=d9jFDxjE c=1 sm=1 tr=0 ts=69f93913 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=By2WwYRBACVvdXAjiroA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: AB__rI0RrCxDymAeW9qCqEf4QCcVAKLI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMiBTYWx0ZWRfXzw8JT0esCspO
 Mxedzp1mystB61+Z+6vXZH9rN4wdbvK19FBepR/Qx+xyjUn5cGtTNLypUMoQVQ4d5HiXND7Hcje
 WoB7wzb0W+g5Tfc7qnjrxdyX1A9wPLp1HLNFlqMgu2OlmxnTIlpvTC+YGiueZQSQKXUBCJa4Ajs
 LAuXGzkyOIH1GKvPE0JCLrTtHMoa5E2SrYUbgWc/2Xn22QK1rkscjnN+W38gpLUmnmZiweZvUg4
 WkhxiPJlarygwcqT8V0LqeQeGXxDwOI2WnduGknwJzNSFk/et/jI6nLt0kYjfd+F3LvAhHPM0BC
 Yu3wzDgM+6Sh/GzJQxnXmQ4TVZfDmBDGY92TAYvrYfSU9IQjPDfAjUwS2OEelgA3CTse37pVxj0
 YRZWbwF6VRX31l3u1BPMwCb/t3TKkwXBnOjRXgn8KGN05UGiXIQ6Wsth6KrwGQjfRxrF/PiWVIz
 l2afPy7x7FELAfRdMjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050002
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

