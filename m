Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E100BCCF2E7
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A99410ED0B;
	Mon, 19 Oct 2026 13:13:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38C810ED1C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:05 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OqlV1348106
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GjY7yAp2Z8nvcjzi2objk8Dg2AFP5I6RCbBdptwbxXw=; b=Xg/1YfD8EHqVjLCd
 cSTkcv5ymULTNWeLesqGwFCM3jFTtjmgbly01/uvxugyYBVOsWxKY25puQT98Q9J
 2c93BPO/NmMV5VAmxi9v9Q4OIY3fyJiHVt52FQRslRJolMqPWhwpN/0+qxKkbwdX
 9rXp+O+uCKD6+g/l8I/342rKjvR+y6iTKsB9TUyKzN7Shzutsn0NWXvAd+nl23tR
 SqwG39qcdMwa4ntlLHoALZLa/Aq8+fkYz6JWHyLodWBMPMfxfSgJJrqx3bZ31WZ+
 sjKo+qLiXOiPhIn1bFN1kbe4K+3hkfI/PVEN0YaRse3InRiXjC5kQLSnM0BSM7JC
 THInwA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rh79s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f322ef7d3so344148685a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415584; x=1793020384;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GjY7yAp2Z8nvcjzi2objk8Dg2AFP5I6RCbBdptwbxXw=;
 b=QhHpZqIQuZRIdVNq52PVCaGxh3OaQuTmVS3dRl+n3LXLEnu7ThugAO4mwsseNmuie5
 +aWsqJ3PZFbvXS1QLdaHgK9N47Hi5IuDwufl0LF8Cmb08XaYpLEkif8eZdqc10et/tPH
 qpMf1xEWzYG0Ryxt6nio6PVf/Zfk+xmI3C/p7WoZmNnqM+IPBpUa/eBAszXLEKOrAx9T
 wNA2rRob+YS8yyrjGvX6ZccMr1T1NtcDL94V6LrewdMTKEgQgJhjaxFasvcbEXLPLc8I
 CXqoaNv7VQ4L89eFV3eJ1tngOsD953DpiBNIUAIJ2hva47KHdYDsaJbvKA0yriPE6auL
 dBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415584; x=1793020384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GjY7yAp2Z8nvcjzi2objk8Dg2AFP5I6RCbBdptwbxXw=;
 b=zC4DtpWEeJvC8mHpAN5E29HC9EghQENYI5cNFkcST9cbQ7GQMoBr/GlDxyXe/gURiL
 aBjqfyosEDCGIQP4YCaclHp/mdXe4QSRcat6rnU1LGvfok6cyCZCPMfG0NWF0eLv/5Zj
 mbjGy2zlLqMIUVwNigZPflZTIo77F3G2jl8X1LO4MwMvLxhlrDsuNA6oqf+H/nsPai8x
 fRDOcNw2I4XHU/9h8cOkbQj8AahB+z7SxgCrMCA8QGhG4WsJx9rTBeO4o9YzAESbdBtf
 jPdg8otxlIC7GrCsgu0hozA+9Tp13mMlxtULXhlCGOQuSVTsma4f7Yzg02hSt3nI2p7i
 Ml6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7kE2MHIjq8XMQcElRskPtSmMMa+1cZkLGK8jN3uxvGl7axdkamJ8r7ATbMuzTd5Ng60qk3iNk@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLtwwBNrwqyteQWt61e4JNjRR+kRtjHb8g26ADBZ3Sarp3TLI/o
 YPxPZcXf9OrTt5G/hldmz2ez1QyxC7KV4g6As0MIqGJvYuTKVhBDCpDvAofkumsdFnu3orvXjTA
 0pVgW1x+1jP62rel2/vHEUOY400fqDKBXTAEsJDjXVXsK6rh0tLEJf00EdpU18ozN0Ayr
X-Gm-Gg: AYBFou3GHftUDuWn0G2FenCtUAC0IXFiI7JXiBnRnuV3+2T0QVPrKgfZ10W05L+APf7
 5NrBnSFWdvesrI/A+xVYbfDxdX+1xqgy+dkEMlcYhYrPy3bUqgHH/WYx8Z00D0xl6DbdipaiGJK
 Yi6kvRRfY6pNIovU9VfSGDmq2KvKvQDGVvWovX/Ds4vdRCDtvdykgfTGuWP+mhxIhEG7dbEcRUa
 nM6KYMssvYIE8KbidPQ3VfOMKTxd/p2HWjof4Sc/aREN+svxta8b76EtkuBxCTAHrN5ELH2EwXH
 0knOLS+hURNGP2iEgu//qtWOs0eLIryZ+HcX3ieHdcNlNnLNmU4Z8c7BarlHpthEYdm2et3slcM
 aPcm/4gFspXT8k4/V9UTZi4rThB7/5joEeUDBW9Y997mOLspAWisk77rxvgZjZuOnrO1uprffXc
 J3r3ij9G05tFjE
X-Received: by 2002:a05:620a:4505:b0:939:6c9a:8f8d with SMTP id
 af79cd13be357-93f29ceec9bmr1248053985a.28.1792415584231; 
 Mon, 19 Oct 2026 06:13:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4505:b0:939:6c9a:8f8d with SMTP id
 af79cd13be357-93f29ceec9bmr1248044185a.28.1792415583536; 
 Mon, 19 Oct 2026 06:13:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:13:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:35 +0300
Subject: [PATCH v7 9/9] drm: writeback: drop the drmm writeback cleanup action
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-9-d4288a26eb54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2590;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=cJTn82pjvFTmv+adSTGav2SLcNIy0UXB7XKTHYaKc7s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1hdGrWE90+VGNNBzkJup8rA7qU3hQoX7mvzRl
 8wMEIYTVG6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYXRgAKCRCLPIo+Aiko
 1XcnB/4r2B/SnDa+KqzrY9qAJ+Lmba7KA8Op/9uFQB8E2ydzAXcTOqqgHiv4QFUYGKZ4B/Ra6Jj
 uDzpKki/dgdrqbghElst7BBOD9KgAcrauCvD0jhckc5uI7D9naEe7ld4JjvAXgtGkTQdD+XTqed
 Y5+ic4ZkIHQ/Ft9p92DnUsw9HyCq4LbEd+h16HozGCQOKLqF61cdBWLbIBbTrgZuNWXDtUIQU5Q
 DHLG2TdMuMa3kHgVXeFr//FpfmIS95T+IJnDUsyvTS4UgRQa8RnZVX/tlTEPn63rhGaIDhzCKBn
 BlvmeLAa8FjRjkTzflbzt6nAJQJNnv99VENO8gw8577fKCFc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: tP4uTE9hWWck-C-taPlnxUZgcvjkUvVX
X-Proofpoint-GUID: tP4uTE9hWWck-C-taPlnxUZgcvjkUvVX
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad61761 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=jfrLVL6Nzc9eZwqZ98kA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX2edid6T07VNI
 k9RC2bPsofBhIxJCv7ijwtaNmYj+BGgyLxxOUMCHNPeX3cbYb7S1xClKmjD5pT0ud33kaifzYjr
 OMy6rVmdTyTXy0bPJxYRXkybJpRN5OZ1f2g33RABY74o16fIsTt5ED8+1cqohp53S6rGjQy6Hbj
 SMzPPzl8Ki0bzfOFXc1uhuEFB0thhs5B2EPI0x2jsS2UTNx6h3gyxp1ITdL6fFE07BQ9LFl6jhY
 Ajr5XoPKgXv9rXnc/pZlaOBLKxHyEqVnBbY0p58HXhfNW0kB9s+gT4H6HH/5hBWBc8xMYc6xNtR
 GkQZoicVAPTFLAFDgYrUjFyOHyW1aaWR0ULsJdV60YmBx0TyAsHaiM7Afwb3d6L1dHAYhMarCwy
 ukAzEqYBp7x5vDQSxJRxBQXR2gVsAH7ZN9Yn1CuFJihuXq+9eEEa9vjym3wEo+ZscL2yAWBupiS
 UKnNYe52/EXjrAlqeKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX8rr1YPnqNqbZ
 rSVYj28x1YALkPgbV+I3D7P3epnh0+/MKJzIoK+GXRDLqgZtl7LEw9QYhRz9jq+xB3x7pgygOqW
 2v9ta9f8zUmCMdlLsc7UljZOfJqLrmE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190052
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

drmm_connector_init() already registers drm_connector_cleanup() as a
managed action, and that now cleans up the writeback state too. The
extra action registered by drmm_writeback_connector_init() just does the
same work a little earlier, leaving drm_connector_cleanup() nothing to
do. Drop it.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 272012a70efe..0c5d2fbe7a7c 100644
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
@@ -303,14 +302,6 @@ void drm_writeback_connector_cleanup(struct drm_connector *connector)
 	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
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
@@ -321,7 +312,8 @@ static void drm_writeback_connector_cleanup_action(struct drm_device *dev,
  * @formats: Array of supported pixel formats for the writeback engine
  * @n_formats: Length of the formats array
  *
- * This function initialize a writeback connector and register its cleanup.
+ * This function initializes a writeback connector. Cleanup is automatically
+ * handled with a call to drm_connector_cleanup() in a DRM-managed action.
  *
  * This function creates the writeback-connector-specific properties if they
  * have not been already created, initializes the connector as
@@ -344,17 +336,8 @@ int drmm_writeback_connector_init(struct drm_device *dev,
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

