Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431C1FF885A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 00:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFBA010E8DF;
	Tue,  5 May 2026 00:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a6xjJCq/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SM6Oxn+w";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C1810E8DF
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 00:25:21 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644JUuat3467670
 for <amd-gfx@lists.freedesktop.org>; Tue, 5 May 2026 00:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E7lYNft/WMRlNnP4xWSfKA/IuNz2ut4KJmCGdJbOpww=; b=a6xjJCq/WGW1/FEM
 AdOoV8K8FXhR0RZB/vBwjxGX0g2ifoQWb9yrZiO0XgSWdU1NCoiOPoFvScJr5hpF
 ITM67h3/DDvA2kacUeU42bEvricMPNX5rNHpf7jA6kKAIxz0yRwwgRmABn8SjP7u
 YdVqXttMYNs1ODYuZ+L9abxvXvE8vie99PuFh7IKpGrFfNiyYgG9ZyxdR3YV7EQV
 tnX1vY021ex1AcqzTIlJ/+kyJk5c5HiOZwVAUTspB5oK3kLXGndx7gKef/K9wAqO
 9dIxCh6h/H5vw6Mbg59JY1rj7i0X2vFQPRfeQrK4ypYDK3jGJAVxT5rQbkQKtd/K
 vdI6YQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvtjt4kq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2026 00:25:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50ea1a7a5d0so119724701cf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 May 2026 17:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777940720; x=1778545520;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E7lYNft/WMRlNnP4xWSfKA/IuNz2ut4KJmCGdJbOpww=;
 b=SM6Oxn+wqlXo+ZH24ZPkWs8+KDI9pplJ54TS0e/3bZvNK/OTQW1FXl7sT4SLgN2o/6
 rSxOFxN77DuhbkmcvzvTkoPevnHNlH8oGVLehxNdjpshKRYGvBHuPUHVgip0aJJ+yQeu
 hBFp8oWSh8kgi3szbFK2gxmN4C/tw1jnBOEXeee9d0ZU6Fw9p9MCdFGbC1+p4gCMtZ67
 4Q4MAXJklymAo/NZ+7ViXK76nUvY/CvKXxKxSPIphrnld3Hd3/J8tAwE134GFtOzWJhJ
 PYgAqTlc83c+sxXoDYYGDqt0z/yRgR3X+Tu5802o8NM4E9PV+PpV78EDCWm6ZuNWBfxt
 H66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777940720; x=1778545520;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E7lYNft/WMRlNnP4xWSfKA/IuNz2ut4KJmCGdJbOpww=;
 b=pIrzWu0Kufm7jmQDjnuyzNHuu1q7vtk0ci02lqhBTkbbfEb5fHvhCF7oByMwGiOzKG
 MArcq5U+wnX38IDGJdT6ah9PBB2+AEpVEIJj5WvPHDHbgl4Oq17RcjkDU+BuACO/Rs9u
 IT466Ut1HMe+iqm1m4dEA+xyMvJQITg6anFH9x0QY5l1mdRhF8UNNVFhIq2r95Xd+4Ba
 /N3Zw/bfMVQZppRPLgNzBqpf1Qp6SCK1Nv5PPc1jk99b5TmT2dbxxJ8DWzysQCfeL9He
 yvAnmpPKRMOX4nXHD0+dXbQCRUUNc1x+wknHyAlnNwDzUs8g+UDxv1X+Z17rBkLjtwFZ
 8cJQ==
X-Gm-Message-State: AOJu0YykfkkEexJQ8nOqdx9VoshHaFRXD6uebsHBuikWiPVBSOK4rhWD
 +xA8KVGOSRlDi038seS8UPeozrTuzkS0onbSSwcLe3GNqc2V3obnB/jPM8C3udkko9XJiAZRehV
 vrkOOuaBJBrzb4+iyVr/b+mR9Ej4M0tcwbXtbehnifyu+p0T5oKi24H8Cfj9ipbOlHdpvenbhmv
 FP
X-Gm-Gg: AeBDievEoQTjgnpAwT6VVqJF1Ivbcoa16KZt2fZec6YCNyh+VWrNrKucN96zhMHaMUW
 EGEL6b8FqRN2e4o+Hj83mlNp8YFS2I7Sq+97t2vMkCK3gwEzm4M7+y2Gvu6hJUPbELhvepSUQXD
 U1eCPWIh9Kw0TblYk/RuR28Fx4U3Bqqdd+7IHbmU5ActyFLmnWNY70fdQmLhFj6FXZumgtSJnPq
 rGxqC16f8YjIsOUHRt3bE/YCUyLEKsPXU+IZhYTdL8BypZCLSOJIGZOrpUnQxWDd3pM0+4lstjV
 kzJddRsSBJCP0BB8bIM2ZqN9eAa3ceMTjWyC1ft4LIHCF4NZhKvxg5wGcvPFojcPqPBXR9rvUI5
 M14E0KtXM22jHhCDj5EfEZL5oE7LYuINfty6rtOAV1pf3eabZy9mlDLkQaAmw9RWsjMjPwDpRYu
 N1PIXTpv5dCsTzNTa7udB89qv5HpLgmX7scV1MCVgEEGtUuA==
X-Received: by 2002:a05:622a:418d:b0:50d:8172:714d with SMTP id
 d75a77b69052e-5104be0ecb3mr192101641cf.13.1777940719389; 
 Mon, 04 May 2026 17:25:19 -0700 (PDT)
X-Received: by 2002:a05:622a:418d:b0:50d:8172:714d with SMTP id
 d75a77b69052e-5104be0ecb3mr192101041cf.13.1777940718915; 
 Mon, 04 May 2026 17:25:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393610ba09esm37132781fa.10.2026.05.04.17.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:25:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 05 May 2026 03:24:59 +0300
Subject: [PATCH v5 2/8] drm/amd/display: use
 drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-wb-drop-encoder-v5-2-42567b7c7af2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3286;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=VXYhbpIFMk+a+YB6jZYpq3ZZlit2Dn3QcOteP6AnmKk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp+TjbsYlM9JoBmtnVDGJmGqEqnq7lq33TSJtIg
 fTudvo5ePyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafk42wAKCRCLPIo+Aiko
 1QxTB/9Aa3eYPFv5Q5FBjOoEneEfa9E7vysKWQgDGcnuDOOIME+jIw5me0iDQ1TEa/4WOWWmwPI
 NHwxxo/GLd7CVVbYW8Y4rWuxFvlKoiiDI2OXKKOBSQbwdPcvSzKBSlRWUQh7sPliGuqZyb7nGFN
 igTh5bAOSsXDN5dINbSbqKQxg+p6LAx+9RvNaftKq77283JdnlFC6mzlZLAmyLWlPyjH6Nc3vu5
 6ej7HjsjMluWP5p2fqZxHuQSKKsEc3gTMKc7daHdFY3MlXj/UdzgBa19tQGge9K9imb5ta9xdp9
 Owf5c4Sf2/QkVE7onaa0l/6vZ/VxAnTo7WfujqfsdQ0ofKOh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: hgXAawq1iQUjX6oGyqm2KI186pgYTtwS
X-Authority-Analysis: v=2.4 cv=KuN9H2WN c=1 sm=1 tr=0 ts=69f938f0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=P-IC7800AAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=M-qvw7r3wQx8XY5Jx90A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMSBTYWx0ZWRfXzBUXusZTYIRj
 3l1AjqlDDnoYGcLcXnYConzlyuoz9lhIsZrECwCyV3Z1CAWyLxgtih2d2dcOgVumZrD+K53Psj2
 VET+gWucCbtfl4W8F8tCl1oOPAIjKgi+EJGdmFS+NM+yVnDx+tb9fzEFvmJbVxkLYi3aLhbM2dQ
 sBGHbAGsAhgLxDPcqjMHLIIwtojAuTIqDFpTDlhtQiOkbN13OqiSKdOoWynXYlR7V6MHjwMTMF5
 jRcK8kfZkoXfUZN1fcM1abqqU7FC5IBu1caLDQMMuBw7h4Nm7Sg454i96m1B/XTHr5B7uZ4fKon
 njyrbWa+n5ErzicsuEsRb+IlbAv60zefCm4AkJviDGaV0N+P/5sL7boXfGNy8rfM46IkkRuzIut
 IdPC3qQqit2sA0aN9n+4TtemLmitBn9faraHLa/DtO7tbYOnF1nvyQ6DwAGCzqIEuRyHF3Ukhg3
 hldIPyuhkQ9jzubJgdQ==
X-Proofpoint-ORIG-GUID: hgXAawq1iQUjX6oGyqm2KI186pgYTtwS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050001
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

The driver uses drm_writeback_connector_init() instead of its drmm
counterpart, but it doesn't perform the job queue cleanup (neither
manually nor by calling drm_writeback_connector_cleanup()). On the
contrary, the drmm_writeback_connector_init() function ensures the
proper cleanup of the job queue.

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e96a12ff2d31..2ac64495cdb7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10683,7 +10683,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 		return;
 	}
 
-	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
+	acrtc = to_amdgpu_crtc(crtc_state->base.crtc);
 	if (!acrtc) {
 		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
 		kfree(wb_info);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 110f0173eee6..fdc3da40452f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -169,7 +169,6 @@ static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs =
 
 static const struct drm_connector_funcs amdgpu_dm_wb_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = amdgpu_dm_connector_funcs_reset,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -188,17 +187,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 	struct dc *dc = dm->dc;
 	struct dc_link *link = dc_get_link_at_index(dc, link_index);
 	int res = 0;
+	struct drm_encoder *encoder;
+
+	encoder = drmm_plain_encoder_alloc(&dm->adev->ddev, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &amdgpu_dm_wb_encoder_helper_funcs);
+
+	encoder->possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(dm->adev);
 
 	wbcon->link = link;
 
 	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
 
-	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
+	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
 					    &amdgpu_dm_wb_connector_funcs,
-					    &amdgpu_dm_wb_encoder_helper_funcs,
+					    encoder,
 					    amdgpu_dm_wb_formats,
-					    ARRAY_SIZE(amdgpu_dm_wb_formats),
-					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
+					    ARRAY_SIZE(amdgpu_dm_wb_formats));
 
 	if (res)
 		return res;

-- 
2.47.3

