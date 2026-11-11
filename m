Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37720606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pYZIMJu8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N438d2lO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E4410E0D0;
	Wed, 11 Nov 2026 00:43:44 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B222C10F863
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:15 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAMKcCw3060879
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g2Ef44+u2+BvWMLecS2zSyGvijAfiGu+XblURBJZ3vM=; b=pYZIMJu8SCvI0zGn
 v1MmNj3pK+ekhtK14G9CYcRKhud3pXTN7CSw/9qzQcGdmYOdLzk2MS1IHDBJjQaH
 W2VYq/HIKDQVMd9Sz6u6g76JRnvmLx6hGmofgcnf1tA3QSKEy6oR41EUUd46X8Q/
 tJETz0+Hgf/DauBbtGciOnhtN8PTHU7ssdpgG/Na0rTg6PtkY9u+na49Geho8CLk
 Fc99MxG32XZvrLqZ5Mmw+U7jHwfVx9Bj0AZcClnlD2OxNvZ/i3hmWXvn/9p/qxBm
 TUYlZYBe93JK0772CKCnlJewU1nd04ixO7/Oyi+y7+q62wpXuZCVIL4mhzW84xoO
 89tcBA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b3130m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:15 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c7bf2d734so56440696d6.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794357794; x=1794962594;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g2Ef44+u2+BvWMLecS2zSyGvijAfiGu+XblURBJZ3vM=;
 b=N438d2lOzhQuWYo42pnOl3ZlLfMlmt0hZyf9GLs/j+jDARzw7IrRm077imLaEbbO8A
 /MhobRF3BQ399HFEMj9XYeZDBkWhl9LC36KwLQa4WPhSV/x/6vdj8bBzUaiMMyj6vEO4
 sB/DV0HitsZqG8hzVlTWrtxEUYnI+iXPJHlaRYUyEQGbMUPuQXHpl3j/neNs/CSsNXz5
 Xml/Miwp7sSrM8bB56uXBuEYVRs4oC+Pz6KNbD0Pegpo0N5UCelOcPV+8meEMSRFeIBm
 GK98MX3ggraxKPqblYzIcpJ15duqnHTPVPJ4iZYDMCKTgOMejzPU6ilnJ06/imZT8AlG
 pbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794357794; x=1794962594;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g2Ef44+u2+BvWMLecS2zSyGvijAfiGu+XblURBJZ3vM=;
 b=nJFTyLpoO7CrmpLkYRRSBNmcch1VWkH15X8SlfyDAJLZxwdVf/3Lgg7JMPhqUTAad/
 RKVjX2HNz2E1AQggeHA6996/Attgh7xpNheiNZHVpAGHhPl+sEpTAuyxVF2ZlX4/HXXs
 +qY8WzRQD8R4P0KFWstL7dADOFmht4H3DhNCHrKCUwWVyHvEwAeJAebcCsmdzzwRsTHz
 KsxAK/kjxvrV77+KOqydyS+4gm17/Dy2/11DF9CSms9NPgqERISX5F2HSccrOqW+5ba2
 33iM/sAVUdBe3KC8JonFyRlK9YPSiYW7J/WUtRi1B822hi8byx+FZKS3MkE6n7VZiKko
 FqIg==
X-Forwarded-Encrypted: i=1;
 AL+hErH7Huodb1mLEWaXIr1Zkrj8mUqHlVTckkt/TAvH0seeNOfpGY8zxbpToCReeTxYdst76DbAmfjn@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ZEjwec2DYcQ9xT73magQPNssM8oFSuhStYYiegQIfN2d6jk//
 o0EiFNwa6m/23G7MeIy1Iax+tcduzrqB+AgZ844hDvPyEYWBMwn58D3k1KHgGcdQmDlVulJDktE
 5u7j+3DJrJxxDcCssyq8NXDSqhwYpxhvXes1VOca/lKL/ONSLcDSj1y90PkwAnv+ShKWM
X-Gm-Gg: AYBFou00rPR15E9+Ayru13+Ttb++k81b7fXIVxGNNNLkU5gTlp53MkgTcwfr3Dv+0Ty
 qi+/ibF9NiiXR37rX/Nhzk7BUCRuPiyYGlEWyo5cNagkWJkN1S0UfMbem8pu8IcVyvYxwgQVbYT
 4g6Kr+G4fYaXHRDrQ8DX4Y4HaSiATTlCuSm5KE0QDXQy8oVa8plXnu7m+MW7A7SSrem5h3BlB2K
 VjGnkk2ZcwtqFLQQVhXpVj4ncFlHDmMgg6NHqdQetc9lvyDdQPveT0kfoPaluQAkARopsgG3dWL
 /rLIaR1g0zliljJxImYUBJFKjxSdNJ1OTvLdrw0LZezGfM1MBvLLTkj/GXHNgLzzcoQsrAq9Zed
 6iS2lLtScLWemjKXmUnIsAtEpTHJWjQmRdEwd9nzgWDQDaLIPH2YCn8Re/HowSt3Qc0yyJAKaAa
 BJpwdhfPl+hWUkIkJBscfZr3+xjmY4AKsZnsqoxNF4OgIYzGyqFCi4d5aBNEaMYw==
X-Received: by 2002:a05:6214:226e:b0:917:aa8e:474f with SMTP id
 6a1803df08f44-91f040d0e12mr17091196d6.23.1794357793864; 
 Tue, 10 Nov 2026 16:43:13 -0800 (PST)
X-Received: by 2002:a05:6214:226e:b0:917:aa8e:474f with SMTP id
 6a1803df08f44-91f040d0e12mr17090886d6.23.1794357793243; 
 Tue, 10 Nov 2026 16:43:13 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092896d8sm7499011fa.32.2026.11.10.16.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:43:11 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:42:33 +0200
Subject: [PATCH v8 04/10] drm: renesas: rcar-du: embed the writeback
 encoder in rcar_du_crtc
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-wb-drop-encoder-v8-4-62948ed87d13@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZSlizkHBUXN8nDew7m6LYl5yzLb4zNCOIibe7gX2PeA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq87oJflkjyS2l7Tu9VWxRnlVFgQGzVHoPPIAeY
 j7nNVp6JpWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavO6CQAKCRCLPIo+Aiko
 1SchCACQzn6uSd3HLFQMP772rOcAkgW4rhLJSa5A9i1KcT5t39kj3lQjEgUdItypDEsYxvs6RWT
 lcc6NQ5EjQOcALrZHzlbhpSQsLqTPkWfZIo2oOvcGYt1Fxe1iJC+3BKmLfCFG1Gr/0ekLPmVuxV
 jeYA5aZsDu6bUhzOXh8cmYWQWGTxXFNYclDFUrZXy+BSEVUa1qL3VxARRt8pQMaSX1n8IiZjxOz
 PYHzryzi7x8L/f8zdibA4u6iadeudXMFNg0LQU9pQU1abNwis+swWpst1rTA3rF7mJ6FSiHGMRU
 ncF5jXYdpJrS4IpOYT5fNebXGdk4sY6ym0tEuI0NWcikzXuI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af3ba23 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=_cPotY8_OL_z5XV9VKUA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX+PwZNoQmHiUC
 c5UzcCFRAP/RUSjgtVWKljSQDfQiyAPobQ7zRhEfVlPOoB7Vmf2awOOEDPKS7FSceaIdLHoydhc
 mSFW9l74KTljVXI9JEAp9jDBWW0Q6SYEhJDzpGspAr7N8/7+7mS2xO9hKYgHSuf+grIh/DrjWA1
 LqjSUxpj0lzzdg/1UJSENbklvGPkQ1EVnuQlYn4ffTzhjz93OP7T7mlqUfjnWIXyAO0LLJC2Nxw
 FNLW1ixY0kJ+F+4TEH7B9cjoTXtklWMZbeEi/bauhZ29SBDroDQwjK/vmzOAwa521+SRBIAmGWa
 8HhNWrXaqWVD6kJpVxu5ppWD+IOXfjTc+88nBG2ZY5ykROLcz/dt7L9np89s3SJctuA4uCIDeV4
 dAU6jpOvvjQXYm1qRVZOVf9T1Vq0TMzhAGXe/4E/yNDcBySXmoGuGaAvas1eOpckduT4UP3XUMj
 V3CkhaAGaKeMuAkfaCA==
X-Proofpoint-GUID: 6nieYWUTGoqVuoRBbKRYNn54UX_Zd_Y7
X-Proofpoint-ORIG-GUID: 6nieYWUTGoqVuoRBbKRYNn54UX_Zd_Y7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX8UxBaHW93ZZt
 SKLHmCjQJlcpkdAbps3F6WQxaGXjdGMDNvGvVn3IlbHrpdh7wasw3ZKdimE0c/A7eNS+QF4YSBe
 nqUzzxf6rCEs0AZMM2o+3VMlP37jAIg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
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

drm_writeback_connector_init() hides the encoder inside struct
drm_writeback_connector, which is the only reason that structure carries
an encoder at all. Every other writeback user already owns its encoder.

Embed the encoder in the driver's own structure and register the
connector with drm_writeback_connector_init_with_encoder(), so that the
encoder can be dropped from drm_writeback_connector.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h     |  2 ++
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 29 +++++++++++++++++-----
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
index 8857926e109a..d8b1dcab8dea 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
@@ -44,6 +44,7 @@ struct rcar_du_vsp;
  * @vsp: VSP feeding video to this CRTC
  * @vsp_pipe: index of the VSP pipeline feeding video to this CRTC
  * @writeback: the writeback connector
+ * @encoder: the writeback encoder
  */
 struct rcar_du_crtc {
 	struct drm_crtc crtc;
@@ -74,6 +75,7 @@ struct rcar_du_crtc {
 	unsigned int sources_count;
 
 	struct drm_writeback_connector writeback;
+	struct drm_encoder encoder;
 };
 
 #define to_rcar_crtc(c)		container_of(c, struct rcar_du_crtc, crtc)
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index 0a3108965591..a1271fec9874 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -172,6 +172,10 @@ static int rcar_du_wb_enc_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
+static const struct drm_encoder_funcs rcar_du_wb_enc_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs rcar_du_wb_enc_helper_funcs = {
 	.atomic_check = rcar_du_wb_enc_atomic_check,
 };
@@ -199,16 +203,29 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
 			   struct rcar_du_crtc *rcrtc)
 {
 	struct drm_writeback_connector *wb_conn = &rcrtc->writeback;
+	struct drm_encoder *encoder = &rcrtc->encoder;
+	int ret;
+
+	drm_encoder_helper_add(encoder, &rcar_du_wb_enc_helper_funcs);
+	encoder->possible_crtcs = drm_crtc_mask(&rcrtc->crtc);
+
+	ret = drm_encoder_init(&rcdu->ddev, encoder, &rcar_du_wb_enc_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (ret)
+		return ret;
 
 	drm_connector_helper_add(&wb_conn->base,
 				 &rcar_du_wb_conn_helper_funcs);
 
-	return drm_writeback_connector_init(&rcdu->ddev, wb_conn,
-					    &rcar_du_wb_conn_funcs,
-					    &rcar_du_wb_enc_helper_funcs,
-					    writeback_formats,
-					    ARRAY_SIZE(writeback_formats),
-					    1 << drm_crtc_index(&rcrtc->crtc));
+	ret = drm_writeback_connector_init_with_encoder(&rcdu->ddev, wb_conn,
+							encoder,
+							&rcar_du_wb_conn_funcs,
+							writeback_formats,
+							ARRAY_SIZE(writeback_formats));
+	if (ret)
+		drm_encoder_cleanup(encoder);
+
+	return ret;
 }
 
 void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,

-- 
2.47.3

