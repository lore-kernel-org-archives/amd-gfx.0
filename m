Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676B0CCF2DB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D332E10ED19;
	Mon, 19 Oct 2026 13:13:15 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2D410ED00
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:02 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P5Qk724621
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8uYiD1zR8PWqA+IXJr4jAlo8whu0RLGrHQ1RLoD/ipQ=; b=Mled32G6JjyaBNfj
 AyyWTfqwWr3YUkUoQWm7vVykiG9KY/+2Ot1APmujhff4/bo9wMq62WXhaS0Kk8xn
 4h7xGyC9vZpwUgGVRenliwAREGESf6eb/pMR3ZlfbXC/laP4Nv778VKbDtwo1qDH
 I+vbY6Nuau8q1Ed+qIINX7Gabn6UZ7SgrwDZFv4981sTzFbZGfwaEAJuKj6q9Eru
 dd61cdPdUENiRc4XyD+pGZ/U/Y35VCta8W4sGWEfFynWCiL2YvSQUeigZ33GNPcJ
 YylvuBR3l3DeMQbTqZE+3B3dlwI9+gFjA89/Kdsjo1BwFxTo+eunJb7aflik4q5q
 p0JjIw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65h7au-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so426974185a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415581; x=1793020381;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8uYiD1zR8PWqA+IXJr4jAlo8whu0RLGrHQ1RLoD/ipQ=;
 b=TukXY0Eendn4N8bPBG1dc+EZqSbZ++KVmUaSgGvgaK+Gn/U8LzA+GN2V1nz6/yHpqL
 nE7zVcqkGMBs0F6ZzdcdxqG0o/RLQikyx9+U5gxtSpF9FPghvV+n+Uxk6DsY/OrouIQz
 CpYHkpYIcQXQT4lA0HDXnSiyfk1onDPf8QVnKBTno9S+Ji4J3He/J86ydj/7S+IJBZBQ
 tDcIKBHwc+Kmyq1ShuYjHxYPqMZiLhRN22rH14Xj4AtYP3xxyT7p4Ca+lrGTrnKug1Xa
 d9WMpbFQJXgZsIqq9ndMVv4ep6KBIS0HozUDDKfYRbGDm3Dscq4JgVJ2qG1thup6wSu8
 1xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415581; x=1793020381;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8uYiD1zR8PWqA+IXJr4jAlo8whu0RLGrHQ1RLoD/ipQ=;
 b=zQTJH8vq/CVdK0dAJYr3uUBxH4g3FURqqaCV/c2n7Q6C/VM/M7LtLosEgfPFrcvuKI
 f72azGKqAT5djCIlP9bJPFzEITQMvkO4wT3ZUKXUXgmuPNP/O9XpA0esVu1CQFtujXhO
 N66oHOUCqwmNxocEo2iZYtu9w/3wNaHmgXeBYHXzCI4sucZVVQ13mgxNl5urA2EHsJ3l
 2jFlkJwrI5xoDw30WL5NkbWBxDAiaGzWo/wlMkaBQgHh53qwflfojnCFhaGarsRGXsmv
 ChhogBN00+utZ//Yn215ZCUFXTPCa1YFjWxqqEEVXVuKRzCeBWJICMeEIYcAwibLjBJ+
 mWWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7qO8M/cOeCOxTnuxTV11DeRBajZDHQ7x2wPyigm2JzbjSyiMXxfIDLQFghh6HC7oqwlLjfdkr@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIGNBJT71ukioRle4AkqMN46z9xiWKxRcGIowtaXJtFfeX/jYSe
 QbJEkkETPU6Fy56ghL1wYk6YKijknDmjQn+lSHpdBWMyDnhm0lH8rdB6tWB5cqZQoflLkZDS/yU
 kopFjDnlTp+/o40quCtOtZcH3zaLkYFrvpxSLSNvBMiHIukLyNtHWGzFRZTj3FLzdmmi+
X-Gm-Gg: AYBFou3KEYlmCfNWZXnhiD03C9j1/cyQccMAtDF4IQyhWZHQfZtYyAvTs3KRYRmm4WG
 +duEVErCUsax/RW4H3gA0y4ZbDuiyi1fjJRi/aakkEEoMeWLqGIw9U7GWBOUwDSj6wTnTAp+OsD
 5UyKFbGoYFtyWHwhrezkN6atFv/qKXd6DItXgZ+wfIevkCXA5bZip9bATj9x04BDGCc+jGbe/nt
 IwvW1+mlAqn2NFp6XwevL5alvPwOuN529TlJRqUQBhdNWKbm8fnoka3egIklXYXwA83IEOVsj1B
 iEk5hK9uIqx3JCDnTNMtLrFTvVz3Xyvvo06xmkdTKPLv56AO0hwnKG+VUGdiZm1p5IwHmyPA+yM
 YeGGvS352ysUQ4meivH+JslPPPx7CFazAKrTM/hVCOWCqVVStz4a9qHs7lXkeveKfhdXTLJTNyE
 DMMnqZmC2Pn4tR
X-Received: by 2002:a05:620a:258d:b0:939:6dea:374d with SMTP id
 af79cd13be357-93f29d813camr1296667385a.49.1792415580367; 
 Mon, 19 Oct 2026 06:13:00 -0700 (PDT)
X-Received: by 2002:a05:620a:258d:b0:939:6dea:374d with SMTP id
 af79cd13be357-93f29d813camr1296657885a.49.1792415579701; 
 Mon, 19 Oct 2026 06:12:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:33 +0300
Subject: [PATCH v7 7/9] drm: writeback: don't destroy the shared writeback
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-7-d4288a26eb54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3846;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2Zej5O7ExLkwUTDnTxc5Jd78WTqAYj7NBjmMvIp3tPw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1hdGkXVsaMk0ehYPLXxFiA1cFN/d3bH+A07XC
 lUMPwYZynOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYXRgAKCRCLPIo+Aiko
 1WRbB/9NUG7CeTReAc0FKzhz0MyBz7QbY4MrFFfNvvhBum3bU9bVXSY5lLvDJOv+eQGrRIEYr0A
 Wht3myxvsT9p4KA7FuHBbypT8dTUkTfqvNAfunta/L0EVopF3LYYYE8sAwOoIoNiRj7QMvg5yHN
 w+IN7FNEg/mvYIsj/jNPTeEZMw7BtIk8Ex2i75SW3kK96lgawPa8tYPyBtldA2HpSrigCiCEmKZ
 P7Of6pFxZ+sjstB3mRZZTSYAsbwrJeXjNgqFxgLC1Fk9rUeFmFZ6peE+SaGrNRaWt9/bXlyskFQ
 3vAbovOYuH1p8/8YJ7ETKN7m/xoesebwhyCz5//xFdYixyUr
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX9qnbSzUujhft
 B9uH6Wouk1Qcjn04DZlcGLvILdoqI3hexDkiA3WNvN8ZHYpvpug5p5b6eV6RCk5s6ImrGSeqU0A
 q0JoJC/CKJ7CtXjfkfmLRKU78ushQXU=
X-Proofpoint-ORIG-GUID: wmltvsrxOxGFIF4kZxGDBvSVgSOwMZnT
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad6175d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Brd4iQZBKng0vAjXyHYA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX1LvxYaW1juJ6
 h7cO5/+E/CBzTyjrzGeXwSSXbfuhBGNZB3a9G3yvS9a+lT5N7nZExgnfhv1Bv4t2lZBA64CiwlT
 Fm8KcyRFGtuOGkE0ka1a6WEfVeKMg272Wu8pr6ragtcyXpwy7HsT0dTK2NhqVs8xOlk6Cp7aYew
 eaGqZdHdXYU9E3zvp0L7dW9C6Z85vJPKRQ71PdhuDlt3sbeJH1dpsTXc7ZfamtUZm6Q647UqNiy
 zsl8fwGmmx1L41ufc4N8X6TbAgAadFxNhz/AASsQP2exxUCPyAs69GVowexzLGyp443DYEGBJVQ
 FhqPznGdKCVnxOtZ8qdg9hl01A3YEItmnOfQI+PuA2AYr7lNb4iBUrIq3mpbEXX2NvncF0JXS1y
 a1B2MksMjO9i1HR8W1tEhesz5mOrqmLKw8uJ6Uvx6NSXP2Byj+diF8+XgMtqP8x78q0ncPez0Ap
 Ox1yV3xjxtt7pjVRBhw==
X-Proofpoint-GUID: wmltvsrxOxGFIF4kZxGDBvSVgSOwMZnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
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

The writeback properties are created once per device and attached to
every writeback connector. Nevertheless, a failing
__drm_writeback_connector_init() destroys all three of them. If an
earlier writeback connector has already been registered (komeda and
rcar-du create one per CRTC), it is left holding stale property
pointers. The drmm cleanup action likewise destroys them as soon as the
first connector goes away.

Leave the properties alone. They are on the device's property list, so
drm_mode_config_cleanup() destroys them together with all other
properties.

Fixes: 2f3f4a73631b ("drm: writeback: Add missing cleanup in case of initialization failure")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 89c36f1414ce..2f6a7b50336c 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -148,22 +148,6 @@ static int create_writeback_properties(struct drm_device *dev)
 	return 0;
 }
 
-static void delete_writeback_properties(struct drm_device *dev)
-{
-	if (dev->mode_config.writeback_pixel_formats_property) {
-		drm_property_destroy(dev, dev->mode_config.writeback_pixel_formats_property);
-		dev->mode_config.writeback_pixel_formats_property = NULL;
-	}
-	if (dev->mode_config.writeback_out_fence_ptr_property) {
-		drm_property_destroy(dev, dev->mode_config.writeback_out_fence_ptr_property);
-		dev->mode_config.writeback_out_fence_ptr_property = NULL;
-	}
-	if (dev->mode_config.writeback_fb_id_property) {
-		drm_property_destroy(dev, dev->mode_config.writeback_fb_id_property);
-		dev->mode_config.writeback_fb_id_property = NULL;
-	}
-}
-
 /**
  * __drm_writeback_connector_init - Initialize a writeback connector
  *
@@ -198,20 +182,18 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 	int ret = create_writeback_properties(dev);
 
 	if (ret != 0)
-		goto failed_properties;
+		return ret;
 
 	connector->interlace_allowed = 0;
 
 	ret = drm_connector_attach_encoder(connector, enc);
 	if (ret)
-		goto failed_properties;
+		return ret;
 
 	blob = drm_property_create_blob(dev, n_formats * sizeof(*formats),
 					formats);
-	if (IS_ERR(blob)) {
-		ret = PTR_ERR(blob);
-		goto failed_properties;
-	}
+	if (IS_ERR(blob))
+		return PTR_ERR(blob);
 
 	INIT_LIST_HEAD(&wb_connector->job_queue);
 	spin_lock_init(&wb_connector->job_lock);
@@ -234,9 +216,6 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 	wb_connector->pixel_formats_blob_ptr = blob;
 
 	return 0;
-failed_properties:
-	delete_writeback_properties(dev);
-	return ret;
 }
 
 /**
@@ -295,8 +274,8 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
  * @dev: DRM device
  * @data: Pointer to the writeback connector to clean up
  *
- * This will decrement the reference counter of blobs and destroy properties. It
- * will also clean the remaining jobs in this writeback connector. Caution: This helper will not
+ * This will decrement the reference counter of blobs. It will also clean the
+ * remaining jobs in this writeback connector. Caution: This helper will not
  * clean up the attached encoder and the drm_connector.
  */
 static void drm_writeback_connector_cleanup(struct drm_device *dev,
@@ -306,7 +285,6 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
 	struct drm_writeback_job *pos, *n;
 	struct drm_writeback_connector *wb_connector = data;
 
-	delete_writeback_properties(dev);
 	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
 
 	spin_lock_irqsave(&wb_connector->job_lock, flags);

-- 
2.47.3

