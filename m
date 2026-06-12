Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8799ECD98CF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2862D10EB0D;
	Fri, 12 Jun 2026 18:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fFyj2AKo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WeDuU5Wm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3332B10EB0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:25 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGVIRL047494
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 49OPqlKhqHIeEAhBZzcXi+3lZ4PA+n7d2F3AhuDo47c=; b=fFyj2AKooKHoOJKA
 NJgTtdivW3JLm+klRZc4PpTlm1VQTdUOBgkHjpNv+opgjkfzFCbs/xXVHNoIb8IP
 tIY4D0YKYKra6h+5juTT/O0WTaHR67EJ8J9eZpI12fu03EjveSnXBiJXWkJnotN8
 BdHxG7ipbukle14/tTq9WSiXQCQUTi+u0CK0zUnFql52yCXNdoNswkDV6/5bc4w3
 3cUFwu5KE94MOEUlr6lGn10HTuHcGo+wfQfcqerphjxnbSWG7LPtvgR/XM5w+7vZ
 D+ZXrEgYUErJiDyl2MUJrkd4VornswnCb0xo0hjn6So7K1550uobZwDtjyCuJpC6
 oR3wgQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2u440mw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157f1be083so216136385a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289024; x=1781893824;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=49OPqlKhqHIeEAhBZzcXi+3lZ4PA+n7d2F3AhuDo47c=;
 b=WeDuU5Wmp4zwK0K2sEmfKOw47rzScO0aJFKEpiXYu9uuQN1LHyg9vx5YH1KjhEhXP3
 0kwuRUn1xfy0GD2iace/wRnPlqq0JeBWu+K1eLBBvmSLgHbwhvVFhuuczwCUjkLhVY8J
 QWClvvc1ZoUzOq28nlUPb2ierKyBwuUDsBnPZsJRap+JLcOaE2Y3yWMtKRBK2KhfvERJ
 JsGexio3Qt7S7hggxqoFaV4+JQ5cBG6ddH5917b89sE/bX2qByn4BSEjj1j4xMRAk7de
 Kuz/10ldVEFZcv0XCHzMJ4Kuh1SPTz38tqjGzKmEmja8S4wkBwCoywkcQc24RgzY5NM0
 HoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289024; x=1781893824;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=49OPqlKhqHIeEAhBZzcXi+3lZ4PA+n7d2F3AhuDo47c=;
 b=Z+h1m/4phRyq6Kl3yO6DLVTvBbaChzqiCWm6uaLSunBfuXo7I7RJdNZpMjYKyiO1GR
 SNmQD8XDkHTvyJ732FcT0u8YbtQolrbApYFAOqryJWWjTYLwf0M/1OBeHJp6FDFrqzmq
 AB72K9HT2ITZRiPMHH7dTQOcEZ3ySxIgm7h7RNNg1nWrpsNWvTQzsrTpCc07mCqi3i0o
 zXHy66/rMH6fI9EhtHJ99s7tFsQ2zve7yIQAuVV1biygFsVxT6dSdkyfokgQdUWwbT3z
 ks2IVoBspgYhH6xi2n1XSY2LVz3q4/WS0s6ixnIVIOdaRWxoPck5cOGo3+bJRyjHA8d3
 5raA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1P+ImmxMqC+TsT+ZmUxeW6U2nk2jmbWitEDDwlDRbWMJYJIuUKPpCv9JxXRtkGNR0LtkIvgvk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjL69zYvX28DFo3xakMg4luDHzNGQEtcU1RqBAqIMVMMK8jbXk
 PEHKWFL+6T09cKhUeP9MYHqC2wnaT9lqlR5nC4+1s/hSjJrVlfh+JR2p8xMTtnDtvRFCtBKi7Aw
 PAusJNPuaoYvswFpz4NUNjr9786YNU4fwKlbIiJGfdTfx+I/rTDShzHWsaSmzBPaOWeQH
X-Gm-Gg: Acq92OHVg4jxCs6UyZ2j9qaPV5rEovKrqMn9BFwY9JrDIrvgpFW3EYr74E5oYDKEtu2
 9nwPbeZZokvEniYwG02WxKfgiGpP8RlosWNfFCzYlV6V5efZrcQy6kXdXWOmRcPdWJwzlU5yVOG
 ynWqI5a2c/lJi0nkP11eoktB9f6nL8hAU2c92pt/AiiSzviImRaeTlkhT4jBrtKX6Hymb26wC2P
 6fqFdzk3OZ/gEQNf7CEiWn++/K4wfRzU9bzKS5GxV10TDVyEMXPjWmS1Lz489POZTidO+l1tPTr
 qFnGghPFIn8fcq02P3VRd5Nks1dk7yGI0xfZduWLZQ17sqwKdLUAAyisY0gcYxMvNYFtf6E5nAy
 /rKpVw/WJ8kDzE4Y0w1gtqLdCHUZ/lV431QR+szNsBxnb60gFXOs67Qy3zkB79o2DVTbnjsBV2d
 C0I8L45qdMt0bkZqX3rADAoQolhhgWuJjawp0=
X-Received: by 2002:a05:620a:a0d2:10b0:917:fcec:cfe0 with SMTP id
 af79cd13be357-917fcfc208bmr80222685a.33.1781289023482; 
 Fri, 12 Jun 2026 11:30:23 -0700 (PDT)
X-Received: by 2002:a05:620a:a0d2:10b0:917:fcec:cfe0 with SMTP id
 af79cd13be357-917fcfc208bmr80214285a.33.1781289022999; 
 Fri, 12 Jun 2026 11:30:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:12 +0300
Subject: [PATCH v6 2/9] drm/amd/display: use drmm allocation for writeback
 connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-2-9f3a54f81310@oss.qualcomm.com>
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
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Alex Hung <alex.hung@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=hLu1cwKI2bwQjArWh6mX4nFC7KW8Gok04gwgDGIykRs=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5ZOgNlx2RvH1rmncgWo3DgW+vltmevq93dm7mxf+Ev8u
 rbv61fHOhmNWRgYuRhkxRRZfApapsZsSg77sGNqPcwgViaQKQxcnAIwEbuv7P/965vCjkxfXj1Z
 UqjpR6ueWrD5vk8ixa0SSz5WMc8XTdxVdIpFd45lkOOtyH1s6ZwvigtCTzD8fhQZfGuZeX2NUCq
 jmUp84FsuuWjFjMrJO77/tTW6rmfIOl34nbv22bvT7/Dc//0o77D/+iLWy91JDV08gkb6s9lfTW
 VNm6U5rWI3x6HVK/ReKMvapE1RNnNg+CSurmvqGlGnONeQZa6/z4+jq6umiH9n4PvAu5/3Q8KN1
 W9MOYN1eZLy/2icMarpbZNht9+lvoApLGfRMod9v/TO1drvk6y2Cj3qeNzSJHICi9vs7BbRTRoF
 aZuU0ta+m+y9gUWj4lbMr8edy14G3DWIM5qz+Ob2RttTAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: JQhDsuVrKD8RQvFv6_BFF3TKBLVARKYE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX5e3xD/sK4CWe
 lYfLE7qHzvB+izyFU8Y6tBWiKzMjRuQmWURfdCNWN14rUEGYmIyeEFWdVekFoqIX3aJ9evhnU8N
 tCirWJHNyyAIJqH5bnMK1S0+MGljluM=
X-Proofpoint-ORIG-GUID: JQhDsuVrKD8RQvFv6_BFF3TKBLVARKYE
X-Authority-Analysis: v=2.4 cv=N94Z0W9B c=1 sm=1 tr=0 ts=6a2c5040 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=zd2uoN0lAAAA:8
 a=EUspDBNiAAAA:8 a=6a0IvY6ZUD0qJKO7u2MA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfXy88vhvs9VAmZ
 6Pb5x4Sorfx98exIc87TUcwgGKpyl5Z5zSVAo/Y2Ci7mhz6zZbcd5P60kIGR9DQ96XjD7PxuR2J
 H72wmY7uB6zV5rwd7zMgfGa64aKa8onN2U7oprKUAeWXPsWOTBpWBxbKbDBY8pth/EbcLj8Co2H
 Dguo4Wyw9Ya1NjVzQijJvK2x1vl+eulf9CtfpVTIDCEK7wV0qr+UkSkjO1dG/M1u7fgSy6ZrRfz
 O6UK3XLF+GgqYUwxUQadiC1sHVLO/FKg8Z4hVfCHZWkzK8mhhhUo+IIBWMFN2N1tNx0A8sSuKJ6
 w+Ma0q7NZeetX4D0no7D3ECFea2A2cGoJzu3zZwPpcGgW9FEwwIRtYeTtIExy8Q7Db3jTBWklRe
 FdkWf+51ZySAoc4Y1xdZAHcfob/pt2d4fyVhvLKXHXsUTTkN31jA3MLsedcPgdY8nxRBSGw/v92
 2lVGKWnK8NcXoDWKmxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Currently memory used for writeback connectors isn't freed on driver
unbinding, leaking the memory. Use drm_device-memory allocation
function for the writeback connector, making sure that the memory is
freed on the driver unbinding.

Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Suggested-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ece581609cf7..436562e32e63 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -91,6 +91,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_eld.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_utils.h>
 #include <drm/drm_vblank.h>
@@ -5807,7 +5808,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		link = dc_get_link_at_index(dm->dc, i);
 
 		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
-			struct amdgpu_dm_wb_connector *wbcon = kzalloc_obj(*wbcon);
+			struct amdgpu_dm_wb_connector *wbcon = drmm_kzalloc_obj(adev_to_drm(adev), *wbcon);
 
 			if (!wbcon) {
 				drm_err(adev_to_drm(adev), "KMS: Failed to allocate writeback connector\n");
@@ -5816,7 +5817,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
 				drm_err(adev_to_drm(adev), "KMS: Failed to initialize writeback connector\n");
-				kfree(wbcon);
+				drmm_kfree(wbcon);
 				continue;
 			}
 

-- 
2.47.3

