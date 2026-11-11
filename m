Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D710606A32D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n2hRQDiy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q8mPFuSk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAB4A10F87F;
	Wed, 11 Nov 2026 00:43:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C707B10F87D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:30 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB0FS3d1689182
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rem+nrfKD98GZM8ZtF/WgXdv6SPv/ujdk/JlCqHr32o=; b=n2hRQDiy6GFShLEd
 hSU+67EAvYYb1h6YchOYKSuTjMCeNR8TqEIQks2zfBEz1Jp4K2zLdG2d9BFxRZMu
 XFgBc9G3dWDpHFjhhgGhBZ/24BkgGmyeucBoZSghmMEtoa4y3ckvaBuqsji39c1w
 imS7ZEyUFUxuPadtPthUCleyU/NiaBGireIIDsjtQ54pF2QHPjWnbqnVyjbD+LjQ
 gR3DnrRYVxeb9qKc8lPDqsLNVd1HmRbCTBGzqd1xFDypA2yH3knNgUg6qi0Z4YqB
 dN73YKI5uSkYqO6cXwzk0gCPwZgXWNUs84VSNI0YxN3h8YwErxm1wQt29QICBhhk
 MZWgug==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnp02m5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:30 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91e987a4099so54766516d6.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794357809; x=1794962609;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rem+nrfKD98GZM8ZtF/WgXdv6SPv/ujdk/JlCqHr32o=;
 b=Q8mPFuSkKJtBGYrNY1n0S8X6Y6F30nVl3lr/GIQA9ytEH26FHeopH4c3x9WgaDrAoz
 b0zAnrTxI763G/d+cHGXn+kwpHyOiL9Bs4RuIPrOHt6s5HaBiPeYXI7X9oG0Hc6EC8eR
 v7E4BhuZnBf0eM66G1l8xJOfX3SOAsHu1HPAs80k/oFzjdM8CaLJXoQQ5YhtdD1KoziS
 L+7URgezSnxotTKagxoe5iBK/A4ou97OSCcoyfOBT3nLDAWB1m+fSSZDdM9/yRAa8yLd
 WD79iPncM+rN3DlLQtDRUFK6q6rWlplskeunOX3peW4hJEDQo5wAyPGFgXkd7phjXedj
 R7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794357809; x=1794962609;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rem+nrfKD98GZM8ZtF/WgXdv6SPv/ujdk/JlCqHr32o=;
 b=hLQW4FwfiC2PMqY9yTnIxPzujNydlWb1+TU80p9gYn1LLI1JUcocmZBynP2B9+H9Et
 ER+mhQU4Ob8mcu0pZKWpNaG+trwsk7hulm/QVJEuV2rg4toqK8XRLKLSOHN1068InfeC
 LIELHpdOzxNN6Arym3l0QKi3bBrB89wZWfVe94asYjX6XvmGVAHEbX0q4tTrY60kZbfW
 ZKS+Vonm2chfuZ7w+XYyGx0H9mwrYG3BSQXhCTlAEcROqrqha3j/Lk/gazwuIbT1vbva
 G4GM9ZsUyrjrTAcTbNyLjS+XG5cnY0TP6vrqocrWoyPEmYR1rkyl9TxTcuK50P5M6nwW
 JcnQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEbeBrLgeAIW4DmBuDW0NouhlyParnFBo+JsL3Xj0no+gcrL3NOOymW5qs0IBYN8TiVH40MfE2d@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9FILJYyeWffrDFtwNVJ3jASK3/m3DxjXtYCjaEixzu3YyDnPZ3
 5mt2dJ+jo9PiWwawTnF70DMSs7E7Ref87npR0a+WvbOU+69gdohLprw7/sSjrnVq2RnUG4DnNmX
 qn7/GNi8HIymEHbQradPmsxSBrk8QWapgZARyUzHuMJmQXEVYg8xjMD0XzPu0MyEuzNq3
X-Gm-Gg: AYBFou1jAsNZrTPftVvc5HswI80p/0OUJwJPJQlOmgYHXPJLNxMg3zPJxhdfMxmc8n3
 mx3/VaDrELTYvhdcT+EWN2tQv9W+moy1zcozcwpMeefDnG2+4fzEkQP5sJ5qyel+AaaFLR4S6XY
 l+F2rPkAbCmifdfOEeHlb6DuFG/487Qecsx1jaKh/YFsKn/wnxtp1Ypo1WNsBLrsZ0nFKlgzm5s
 TdzFxsPauA5PPsaFVg1oNv9dmPD3AR64CkOKg0l8Jc3qTAWy7iFNQ3oYq5Vmw++KzqQ0KirVEZS
 ZuxAkC2/byiZQ7VrwCLOaYaGAFz6snRV72COOmJtLVyMluJv4W26wOzLkwUKdJlHhsL9VnynhMH
 Hulc7uD2M48IbmOjz/TJPbWHZPCKPRRNENkLlfq1/2/+2R4twWnBHtTbu/Crfon1znh+ABxXFL1
 z91k2h/OEPIsjA4qIZhWOKI6E94KbIARxa9BXLRL9OOYMbxAYDFiQ3uR+XfR9XDg==
X-Received: by 2002:a05:6214:4109:b0:91e:8cb1:b842 with SMTP id
 6a1803df08f44-91f0416afc3mr18114136d6.49.1794357808952; 
 Tue, 10 Nov 2026 16:43:28 -0800 (PST)
X-Received: by 2002:a05:6214:4109:b0:91e:8cb1:b842 with SMTP id
 6a1803df08f44-91f0416afc3mr18113656d6.49.1794357808309; 
 Tue, 10 Nov 2026 16:43:28 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092896d8sm7499011fa.32.2026.11.10.16.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:43:26 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:42:39 +0200
Subject: [PATCH v8 10/10] drm: writeback: drop the drmm writeback cleanup
 action
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-wb-drop-encoder-v8-10-62948ed87d13@oss.qualcomm.com>
References: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
In-Reply-To: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
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
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 John Harrison <John.Harrison@Igalia.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2573;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=zFchQ2Tm6mpR1tJxfS8Ahms9paw4/2N65BwMaqhRGdY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq87oXF36VJi20ypSJvvq0dMWU2n97wmd2BNuWU
 te4JTfo1TuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavO6FwAKCRCLPIo+Aiko
 1YW7B/9R958+trlT+7V42rGUF2nKBhOCM/QjmDp20lI1gchwVYH/MyskiElts+RvZ6vF57MfsF7
 s2GB6G8nopGMASP96cG94rLE2QB9YR12H427s6ulj21GBbzS9PNLYekGjpLwHxOWbAzhL/Nz0nC
 fdMwFIwlEzLwQgKnWLX9aRAaRdObJ4UTPD2sE8lrGgn3CYnGMlL6HoIatUuOHEidXdfjcHmxgGv
 0i3n6pgfNBPZwruEmZp8pZNdd9wq4OWN6vg2M/gJ0bf8JI/glC1xcvJJm+ljqyn/UTNqFw87cLD
 aRfnet3H/pMM9TfanUoMF8hT8roQsmUP1X97qRM4ryneWyKp
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX84tN2LP9mWtG
 Wc+pt0Z6fmG9XbTP/sQzLrDIJ+HWbRTQuJuYuSlhmO2gB4XHE6cCVc7fzEgdHM9yyoNsVQpzhsc
 sgmzcm7f1FuJmcQiNfqFzRrDYxy0JvRH9u4RqqClJpRpOBW9w8tydhR7kIeNWrGUXtAQaMhQ+6u
 eDG0VZoZ0vEADPW7k8LpQV1paRPBVn4ZT1JULiE+gJBfYpTiNRcyiHntIGFuOFlVk1z7aXUZWye
 XvwSEzmRk4Qr/7oDp43L2m1S/NgtlFGdJgBee8vsey7v88NnYDrnd2CVmCgz97WZ+v+piha8ogA
 1BtVfFLPO2dCymmN84c8eyDFtL0K3ZcYhGf62dzczA9YSKkgypqW/PKGTCZEH7IO7REQ8RQgqOZ
 fIGsYd6gKkn/lYY0+b68/xsf5nQtrQatcQ9hns9Wp9s5UEp3wd58BQqAANTEHwNL9Zw69fZtDOD
 qAEXDwFpxN46efcRdwQ==
X-Proofpoint-GUID: nmw4ggxXBcazuMF6LASFgdF3mFCfAyrv
X-Proofpoint-ORIG-GUID: nmw4ggxXBcazuMF6LASFgdF3mFCfAyrv
X-Authority-Analysis: v=2.4 cv=NK1AaE6g c=1 sm=1 tr=0 ts=6af3ba32 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=V2sgnzSHAAAA:8
 a=EUspDBNiAAAA:8 a=jfrLVL6Nzc9eZwqZ98kA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfXw3mmdCVNhNV7
 UqXkV74kny/4lD5bMKIt1zh8CDij+EIACcrw3v5SsZ/FJGo0ygKdDdzQaitYJH5LONxFXp9PSJ1
 VrGB5bCMBe6IZZutWSmKb7xiJH82S4I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110001
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drmm_connector_init() already registers drm_connector_cleanup() as a
managed action, and that now cleans up the writeback state too. The
extra action registered by drmm_writeback_connector_init() just does the
same work a little earlier, leaving drm_connector_cleanup() nothing to
do. Drop it.

Reviewed-by: John Harrison <John.Harrison@Igalia.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 6ea3e55a1962..097d480d6187 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -16,7 +16,6 @@
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_framebuffer.h>
-#include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_property.h>
 #include <drm/drm_writeback.h>
@@ -308,14 +307,6 @@ void drm_writeback_connector_cleanup(struct drm_connector *connector)
 	}
 }
 
-static void drm_writeback_connector_cleanup_action(struct drm_device *dev,
-						   void *data)
-{
-	struct drm_writeback_connector *wb_connector = data;
-
-	drm_writeback_connector_cleanup(&wb_connector->base);
-}
-
 /**
  * drmm_writeback_connector_init - Initialize a writeback connector
  *
@@ -326,7 +317,8 @@ static void drm_writeback_connector_cleanup_action(struct drm_device *dev,
  * @formats: Array of supported pixel formats for the writeback engine
  * @n_formats: Length of the formats array
  *
- * This function initialize a writeback connector and register its cleanup.
+ * This function initializes a writeback connector. Cleanup is automatically
+ * handled with a call to drm_connector_cleanup() in a DRM-managed action.
  *
  * This function creates the writeback-connector-specific properties if they
  * have not been already created, initializes the connector as
@@ -349,17 +341,8 @@ int drmm_writeback_connector_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	ret = __drm_writeback_connector_init(dev, wb_connector, enc, formats,
-					     n_formats);
-	if (ret)
-		return ret;
-
-	ret = drmm_add_action_or_reset(dev, drm_writeback_connector_cleanup_action,
-				       wb_connector);
-	if (ret)
-		return ret;
-
-	return 0;
+	return __drm_writeback_connector_init(dev, wb_connector, enc, formats,
+					      n_formats);
 }
 EXPORT_SYMBOL(drmm_writeback_connector_init);
 

-- 
2.47.3

