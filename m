Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DE0CD98D2
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63CAE10F632;
	Fri, 12 Jun 2026 18:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j1kCkMsT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SaZcG+PB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45C6E10F62B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:27 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGVote4113371
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jRi4QyMfJKJttBAEFdi1P15sbORxIAP33IpeK1RT27w=; b=j1kCkMsTOh3LWhON
 0QAKPzpA3acIfOXO/MvUweopgToy0P2xRi9aznHifE0+rqx+rgwxVa+amb51jiNS
 diq2pHZ3HdNXpLnuH/Y8YbB//wDxYLxd6pY0VEa6WNOA99OPxvS8iSEH3xtDC9up
 PoX4jX9sE5Vt6RQAkyTnGFs7JCsBrS37IDLHQPt/dsnc083oBVyOpRJUeGdP8ZKp
 Qq4EL7EYdFL6G6928vhzHGg7B3DIG3td+WYA9nEVqEAACrJxoWyf56n/pKwxPLti
 7K+ENyiNIW9Ed/7pTcKcHCxJHJz7oQI4oBDmb0ax0667GojX8TOl4NPEYVMSq05v
 eL/I9A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er30gc2p4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91598af506cso130603385a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289026; x=1781893826;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jRi4QyMfJKJttBAEFdi1P15sbORxIAP33IpeK1RT27w=;
 b=SaZcG+PBQ8JYYh84GImx18eozv22Tp5F819RrWUoC9w3wduMjufw0bglinp660lFom
 nSc2aZN5sINmfv4WAPRZ0JcofCxmLiSOGDjfXOzrq0xb/Il43Usz+SWzjnFZ68pHHjzg
 9dNbSCLrQqY1tJJizDrDEqJxGVR8s2Z+2ef0F/+M6I4fu3bihIO7q61EdMgPJL0iFAIu
 PYzGjFrlMdQ7NbSJB2oRZ43oVzdCxogUXdEAnLSqzPyDQKwkihOgyXnaW++CRyxfJ/oc
 2t9Y077nzrdex53saG2P1/9X6uc4evG8XrNI7ToeRmb1q7rqkYtTypv/MdIvnENa905q
 WWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289026; x=1781893826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jRi4QyMfJKJttBAEFdi1P15sbORxIAP33IpeK1RT27w=;
 b=DIo7h4N/NjqgG6TWs84tNxqSFopPohLDuEsnfo5oeM/45kCmrfHx5StlHQon8Crx/n
 LoABPLhvhqj3B0ws75LGEttT2Hx/Pja9aicz7Nuko59w85/OsfpWyV0ZQwLcct5bwK6M
 sLlioIhM0TPryMdEqDcVZENkPr8X5b5kpLO7EgRy3htQ3DEHeFiZlUC2N0D8FKIdFhMO
 hMIAERWIOfrkyBMNvGU4mK74FY1vUi+gWzjihZogAfrgBH7I5Z2hWxvenMBq+0fJ45fp
 VvLp44AltAqKEfGAl/0mQLb7kqyFpLElDCWUn4/5HI98x4kLe+Y9exgz9+0ihri31ryO
 oGDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xedbwXhfjlWS9T8nguRrFANxp1HnY87rGaL05qnR/BrDNn9mIR2jGhDPA24PL/y8DhO25ltVq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoNONZlKSQkxXuRgtyfT7Rt+4+MmMApJcG/JLIxecjWKTuUkAs
 /v15Y9ue7pfXUmbdSX1c5nQ2QnFyPu91VcmvJKsVeLOBKD6RMYE4aadeLQ0VnZVaLJojDcuu0Sj
 xR3CfxHjToZSQKLfOMEQK63765QyNQr7aYVf/YcuT94x0lPCKFt7HCGy+NrDIYCB0NpsR
X-Gm-Gg: Acq92OEdSUrQsDlwALOTr3usHNRyAlJqOfC6uRlokkbZW75nj4ibA7V7unbmvPgdF//
 vG2x3K5ry2bbDH8b7jhkzc+iEf07F/QZtuPohL3pFP9Axx9TVAunktJKMx67w7PFgrPMFCqEkcr
 0LN7WehDTWqMo4IHUxJlIwyAKK0o1fSzeUSpMBWnHj6NUyKJI3yfdSUswWN2b1VpC/IvcCYqJUY
 pU8fwgxSbxUYbUf/WRBm+6+yRA57bjWo+8T/FY2PuBq/ED7M5MUiM60ErUdNP523zMXL89m6z7a
 7lVL34xAVbCGsKSL2xeTqeF/eKbzZFYhAaMA+/I0ER6TFiftIVGW8SFJ65vG88vWT38E2rkx4+q
 EuU6ZcawSX2l8aZl+hXjt65ecrLvy+eVUIBFlr1idcsvifX2Hn8/O4UYYzc9KZ6lfNH/jI0zOKs
 uPiN4gAtca+mDOm49dKSanhFe8ZE+WJBCJvO8=
X-Received: by 2002:a05:620a:2714:b0:8ef:ca26:dcf8 with SMTP id
 af79cd13be357-9161b954533mr612526085a.0.1781289025585; 
 Fri, 12 Jun 2026 11:30:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2714:b0:8ef:ca26:dcf8 with SMTP id
 af79cd13be357-9161b954533mr612513885a.0.1781289024928; 
 Fri, 12 Jun 2026 11:30:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:13 +0300
Subject: [PATCH v6 3/9] drm/amd/display: use
 drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-3-9f3a54f81310@oss.qualcomm.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3286;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=MbaRBOLwFT+ETgHAVWF3UBcaA1Q1ln0hWBI7tVGYbZw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqLFA2TF8iWOsdGp/XNhFFMMbJIh1AWUGAs9E8q
 XZNuCdRYNKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaixQNgAKCRCLPIo+Aiko
 1edSB/0VjeuYOMaO2KkI6CX4me4o/IauFy8eyB2qW0cOD6x73XUrx6wzyhhmPiEQs9KITW95Aux
 vOlO1OGm4WTd10dda61ZQYwFQCxUQCr7hUhOhpYfjLILW8d5w6LcrB4e/y4VO+m9yt89EgCxZ84
 m8nTMxnSfypw3OwMZya9EzwpgnFKQI/emxXRCB8fJh3mYb69roMD5FzqMiPiMJoG4uQMv9uPEea
 UQC3upMrVgAG8LSU+oom9Leb8S4NQuNZEWgRfKGNF0fMB+9rQvKjr7Ga6EL6VshD355ZdKH8cNv
 KCLIdEljpwWS5Cc5UowFwL+muSXLb74Lh/zEqFv53Rdxr5ax
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX7WpBo6PVsQTG
 2/mtWLDdp9MGDstXgus1ZHOrmrCtJk1txAtK/7E5Yz1PNrSMPYaxv60Iik+0K9IU93kAhKidmYE
 +5vcBaVO1e4iqOkSpjkrWQRnm2lER2A=
X-Proofpoint-GUID: SGghbkR9jgvU9O9rEuxytEuCze1xMw6s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX9PKQ0vRyBHkL
 yY6cZVG2JIR7bvDr0RSpsnW+qMWP7Lfge7sbaiVGPiBzti0mVYCTqSPnG9zOzkEHF0bvywe2C33
 +KArfJJW83/5q3i0HcJ6c/X2834IHa9iV9VAU63oJxP0jcj2Kc75qA5tlCgr9I6cl71Nb9Xqvc5
 6mER+HN9WaTMgMxsHezy2KC+eWUEIxSS0dS1I+4T/cxfdnZepm4ljBXYSFUd2JdyLekcI5TAdPZ
 v03KGZIN0dhLiFFZd2jH27mEtcYzHw+HSP81akLrLfH9L4xndyIdk+BrwOmJ7f6DWbChqsXjt0v
 UE/y+dV/fLAo2Sl7mPWOsLcn4p7MNkI96U0YvTvQAdWiHz36AcvbiGLw8Fhhqe4B8DZifbxgPoN
 hBVsD3iN6Ne2/usoSnHeeH/628IybCaPLxdzD3+afNEd9pz+H/typVcCuJ0w+tIwJh/f1BEV5YB
 cmKZhnfWpXmPTWfCgdg==
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a2c5042 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=P-IC7800AAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=M-qvw7r3wQx8XY5Jx90A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: SGghbkR9jgvU9O9rEuxytEuCze1xMw6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120173
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
index 436562e32e63..066ba6b6ef76 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10996,7 +10996,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
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

