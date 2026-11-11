Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E821606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h9zqxJjF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DKs5OlGs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA87110F886;
	Wed, 11 Nov 2026 00:44:01 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE5710F87C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:28 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAMKdKG1113749
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SdrgOO1kZ/LJgG/yaXawlqaJ5/GwT+jqCvdWQyL4krg=; b=h9zqxJjFYhD28UvK
 Ij1h7eXNmw3UsK6AJTLnInELHhMXwJV4xlb5zOl7B0hwd5BQUQVMFEm3m+6hKpAm
 PgoplbjppNcWr0Hma8+6CyRL9XWbceQW5EHbX/4uGZW6DT9fMcNpLd1G/qA1Rzt7
 0ZA8eGER2mgnTZkIc+/Lj6Rpke/j/hwkD80D5tjMoa98fSC5LGBwjIgAUR8duttr
 vriHmTxpxCbOOONW94S7mTbSuC9YCp04TzdEgPIDdtdVVp6U88RMZag48Ny4dA88
 B2n8s7+LCLRufK69P4G65o8EVywqZtEYW9+mJ8TutVO2mLi6qW1vbhAII8928jR8
 TgkXAA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97c955r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91ec6cd898eso49940166d6.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794357807; x=1794962607;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SdrgOO1kZ/LJgG/yaXawlqaJ5/GwT+jqCvdWQyL4krg=;
 b=DKs5OlGsM2oRymJOxpEoE45X7zLrMoN7Ajf83V8p/VWQJ5jD+7RtRfUSnSuxApURTw
 jYmE6BJYsPakZzmnBsYAu45xjVptFhx+KcnKGrrVvaESaTWvFr/F84yYp+wOYsoUn5QC
 WMAu8KaFsmnd2kAPPnfv3ogPLjBVqFM6kJNbCAlCfQWDkLw1JoI12CSxPYhNYY8Lu88G
 IJ2w1aaKzY525iU7OsMWdU20DFKz9bWXtVT7rz7Yz28R/frMMvr8fh2VyG1upfyS5p4j
 12YnlUl3mYtd0ZD7jLX5AB1sV/4D/p9RidyJoWqiEhUkpJWY5tP7lcECNvZt++cSv27h
 54nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794357807; x=1794962607;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SdrgOO1kZ/LJgG/yaXawlqaJ5/GwT+jqCvdWQyL4krg=;
 b=Y9kQyLz8HDMWbfzjD1NdtWUr8IQX7OYGSxWlUhirP46Yce0yazXpOyc9X3i5nRjoDJ
 0NtnCXw/PpDKJ/HyZ9RwC6PSZAgj9rxftn0D16n84LQVEmoZSoRk9E+LLuJxI560mwcZ
 dtV1foVuKukVZ4XD98V0iumi96ppm1RoZ0H1Nrg/WyUpsh6SIYwddTKTa7y86y1HY/Zm
 W/DzJ3a0PR27rvEHw6iJ71x3pfBdSCYGWzDbqwODhi5z4uMavkCAZCf+/bkKtgsh/9ow
 QkItaaZ1H/ci9Ia04Xfm2sWUFJWOBIlsw4OPQ+e1LmYF7UIbKCCZ5lIy22omsc1hek2o
 5r8w==
X-Forwarded-Encrypted: i=1;
 AL+hErEGfZp+wE22rukCXYxGOXpNrxmgArVc/XZP7OKFPVbEBG9CwZOAINxdQ01BVTDY3NqZv2zbIYDP@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8L1E71xJ7/y7P0QrhOZ3UQ/EqvQ32zp9YmC7avcYVOxnKizi+7
 4kvFkLHAZO+Wlej0JBUDc0u7aRhuyvS2RlIDu2WY3e6c+7YKAAxEOCZSDYAdt9L9mhcgPLo7qHP
 fSSEocr0jIRsLTpZLf5UVp3meB52xONiPG6kkMhwLuaqOBorhAxGhCxl9dC59/t5RGGce
X-Gm-Gg: AYBFou1EzHDtKsm/thM4xQj8f7/TuYR7dlGuKGbCvbf4YUMG/2zTsAchUSik+agX0Ql
 2gf9LiiLaV6H2s3oz8jj6naA5wqdz0PUXk3lxiN5fKUYGS0bsnhRLABSS4cl74DSWqGBq0n2x/z
 tVefXtlFZJ7DPJQM0bZ+7owUZRhTxHgHXdebcpTg9lbpC5pBQDZSIrvx5ScA0TiGMyWqDHs/LgW
 x4xZL3GwA6v0yCfAbgicgix/RT4T3NgndOl86knZeGZ8Y3+qXe8bBf6vE5GwqSYbLYq2aGXNig1
 hLdVubJ6LMCFGBqZ/NRsbFRqW4X8wok0TpeE07R9p5/Xp4w3r56T/yFxvMd05vL74FNpETMI91P
 ln1L6fRQuYGXNxmVBfVfFLPf5Z6x430oRvIbnjHzMF6O09mcZF1d50iVuhgkMIGxec2lz1Dpix0
 a9AAPmid4ZzT4iL3k7nmxZqmPAK5AUJ+H1YkoiFEeyEZkSpYbAQDRx8/jCI4ZMBw==
X-Received: by 2002:a05:6214:529b:b0:91b:8025:6827 with SMTP id
 6a1803df08f44-91f0411d3a5mr17363726d6.21.1794357806551; 
 Tue, 10 Nov 2026 16:43:26 -0800 (PST)
X-Received: by 2002:a05:6214:529b:b0:91b:8025:6827 with SMTP id
 6a1803df08f44-91f0411d3a5mr17363256d6.21.1794357805821; 
 Tue, 10 Nov 2026 16:43:25 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092896d8sm7499011fa.32.2026.11.10.16.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:43:24 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:42:38 +0200
Subject: [PATCH v8 09/10] drm: writeback: clean up writeback connectors in
 drm_connector_cleanup()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-wb-drop-encoder-v8-9-62948ed87d13@oss.qualcomm.com>
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
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6133;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=BrJAtr2wc8dHMLrCB0wAes1muKcDYhiw7YM4ATkNvko=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq87oUuxLWwzl7qKvchquyNbQBCvVpstIV7joS1
 cWcAHzvWOiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavO6FAAKCRCLPIo+Aiko
 1Wv8B/sGJZubZyrWIr8blvtjJMU8+jiAyHEiOmDkjw8ca+3HLKX5PXHhdcyvjOJV0zMGRqIsYjc
 QvO2VpNtsYZsGNufKKGpkIn2XxThPyValQg4HBWRAJO6QyKRisuON4TTSWX5tfJ62QiOFljnxTe
 JHXbO7pwXsDTEJTI0+ul5F3/NaPUs0AewITBLCbBYAolgEb1UJKRtxDQpFbt/iPoUp0crdAv/AU
 +ol29ENhA+qhWWYHzEM1GwZjozk5EvSxoJ6ggs8hRMAiNcJW3fhI+pWnmG3q7AaOJGpX32LYz9n
 cAPm24H35pLd6+L3IDtHQmYkBsDrpgm0Uh/8OTJgCQMXRulk
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX5fQw1kXOL+bs
 +L4PBnm2QqY4dF8x9DUKkpny4+osrvLCWZMe9dRe1GQeFhRkyl7axffOGw9ZXoGaMCH2Xa6qZUI
 3DaHMwZ3h43vvdiQmHaJePiZjF0TDt18AmY83XBKS5IcQHCLs/fOA9hLqJFKpit9qV9JDzNJ2oq
 4rb6Y9jXOXzOxdrmB1YhYNmdtzl6MMGHawBlZ6bMrNc2181xJK3vsofeZDqL1DlcoPvbqs1kQFe
 4Y++65T+n1Of44xD/i2Mj1J1Vw2lctHLc4T2ZG8HSdHER/mzL+q++2G/O9Xt7T9IdtceCsG8yb4
 5qu5KIihLjlBGlODs1UcgQ3sXmUHp1AVVZZwVk6x5I85KE3JndMf3/3HD/xBhkhCCXdAV1kc59f
 09o4y+Nutz0wemoSCreO8dZjvQ2Agk6drTBBbbWOAq2DVBScd1ApdKK7LXhsweJVqvIgSVALpIi
 uwvx3bHBhL/ynHj1B7g==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af3ba2f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=6GQbiVArWzZUabU3hp4A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: oKGret9_BK3XlK_nMwFZiJeczPZ-uMjS
X-Proofpoint-ORIG-GUID: oKGret9_BK3XlK_nMwFZiJeczPZ-uMjS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfXxJzZf84ONdCp
 OPEj83HXxOQa5eEvlnuXWSiIErp9Tx431GJRDa8BsEQCce1hfMz/02XKSs5lda5CqZ9fIHumudq
 njDJRzMrMozPqON7L0gYLP74+tZknJg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
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

Only drmm_writeback_connector_init() registers
drm_writeback_connector_cleanup(). Connectors set up with
drm_writeback_connector_init() (amdgpu, komeda, malidp, rcar-du, vc4)
never drop the formats blob or free the jobs still on the queue, leaking
them together with their framebuffer and fence references.

Call drm_writeback_connector_cleanup() from drm_connector_cleanup() so it
runs for both kinds of initialization, the same way the HDMI audio and
SCDC state is torn down there. It downcasts the connector to its
drm_writeback_connector wrapper, which is only valid when the connector
really is embedded in one. A plain drm_connector (or a different wrapper
struct) may be initialized with DRM_MODE_CONNECTOR_WRITEBACK without being
a writeback connector, as several KUnit tests do, so keying the cleanup
off the connector type would read out of bounds. Track genuine writeback
initialization with a drm_connector::wb_initialized flag set by
__drm_writeback_connector_init() and clean up based on it instead. The
drmm action now just wraps the helper; clearing the flag makes the second
invocation a no-op and also covers drm_connector_cleanup() being called
after a failed __drm_writeback_connector_init().

Fixes: 935774cd71fe ("drm: Add writeback connector type")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_connector.c     |  3 +++
 drivers/gpu/drm/drm_crtc_internal.h |  3 +++
 drivers/gpu/drm/drm_writeback.c     | 30 ++++++++++++++++++++++++------
 include/drm/drm_connector.h         | 12 ++++++++++++
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index d66188521881..da0b16f25ac4 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -921,6 +921,9 @@ void drm_connector_cleanup(struct drm_connector *connector)
 	if (connector->hdmi.scdc_work_initialized)
 		cancel_delayed_work_sync(&connector->hdmi.scdc_work);
 
+	if (connector->wb_initialized)
+		drm_writeback_connector_cleanup(connector);
+
 	platform_device_unregister(connector->hdmi_audio.codec_pdev);
 
 	if (connector->privacy_screen) {
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 3492787c3697..f60216adcd31 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -329,4 +329,7 @@ static inline void drm_panic_unregister(struct drm_device *dev) {}
 static inline void drm_panic_init(void) {}
 #endif
 
+/* drm_writeback.c */
+void drm_writeback_connector_cleanup(struct drm_connector *connector);
+
 #endif /* __DRM_CRTC_INTERNAL_H__ */
diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 6487f4a104f2..6ea3e55a1962 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -21,6 +21,8 @@
 #include <drm/drm_property.h>
 #include <drm/drm_writeback.h>
 
+#include "drm_crtc_internal.h"
+
 /**
  * DOC: overview
  *
@@ -215,6 +217,8 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 				   blob->base.id);
 	wb_connector->pixel_formats_blob_ptr = blob;
 
+	connector->wb_initialized = true;
+
 	return 0;
 }
 
@@ -271,22 +275,28 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
 
 /**
  * drm_writeback_connector_cleanup - Cleanup the writeback connector
- * @dev: DRM device
- * @data: Pointer to the writeback connector to clean up
+ * @connector: Writeback connector to clean up
  *
  * This will decrement the reference counter of blobs. It will also clean the
  * remaining jobs in this writeback connector. Caution: This helper will not
  * clean up the attached encoder and the drm_connector.
+ *
+ * Called from drm_connector_cleanup() for all writeback connectors.
  */
-static void drm_writeback_connector_cleanup(struct drm_device *dev,
-					    void *data)
+void drm_writeback_connector_cleanup(struct drm_connector *connector)
 {
-	struct drm_writeback_connector *wb_connector = data;
+	struct drm_writeback_connector *wb_connector =
+		drm_connector_to_writeback(connector);
 	struct drm_writeback_job *pos, *n;
 	unsigned long flags;
 	LIST_HEAD(jobs);
 
+	if (!connector->wb_initialized)
+		return;
+	connector->wb_initialized = false;
+
 	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
+	wb_connector->pixel_formats_blob_ptr = NULL;
 
 	spin_lock_irqsave(&wb_connector->job_lock, flags);
 	list_splice_init(&wb_connector->job_queue, &jobs);
@@ -298,6 +308,14 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
 	}
 }
 
+static void drm_writeback_connector_cleanup_action(struct drm_device *dev,
+						   void *data)
+{
+	struct drm_writeback_connector *wb_connector = data;
+
+	drm_writeback_connector_cleanup(&wb_connector->base);
+}
+
 /**
  * drmm_writeback_connector_init - Initialize a writeback connector
  *
@@ -336,7 +354,7 @@ int drmm_writeback_connector_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	ret = drmm_add_action_or_reset(dev, drm_writeback_connector_cleanup,
+	ret = drmm_add_action_or_reset(dev, drm_writeback_connector_cleanup_action,
 				       wb_connector);
 	if (ret)
 		return ret;
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f656ed8324d3..07218ab26c9e 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2688,6 +2688,18 @@ struct drm_connector {
 	 */
 	struct llist_node free_node;
 
+	/**
+	 * @wb_initialized:
+	 *
+	 * Set when the connector is embedded in a &struct
+	 * drm_writeback_connector that has been initialized through
+	 * __drm_writeback_connector_init(). A plain &struct drm_connector may
+	 * be created with DRM_MODE_CONNECTOR_WRITEBACK without being a
+	 * writeback connector, so drm_connector_cleanup() keys the writeback
+	 * teardown off this flag rather than the connector type.
+	 */
+	bool wb_initialized;
+
 	/**
 	 * @hdmi: HDMI-related variable and properties.
 	 */

-- 
2.47.3

