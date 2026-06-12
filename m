Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EEACD98CF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67F910F641;
	Fri, 12 Jun 2026 18:30:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WR8zAQI1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UKsWwlZB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B4510F63E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:40 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGWEAN019984
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TPWo467A1KtBfknXLUhzGM05jfJhVUBGDG8kt4+2Duw=; b=WR8zAQI1Ce48sbsQ
 iko4kevADzRuNsFys/yUaT2wA08EO8kntUazpR3SYgJ8qEQ1mCbCrkD4hWZ7nnet
 QfCrCERbHHPoErM3ZXgBgnCCnNGEM7pBbrXhpn/cghbYrkA5K8CRcHrbbRV6fLry
 HJ82D6zeU4RQJc8MeriCpWHeG0iZm4CscGQjMvXbE4fLGj1WNnffM6lrsBWfaWvi
 KTylmWw4szOJRozfVJ51Wfi+XQ87hv7dCUCOJ13ulkBrhsoOjurLWd/VhjbAV4dh
 CKIFwJkRM1ZOXusNS1w5n0T24KqXqhEoGpp8pv8qsaU3VCum5Ik7ZtCop5gh8sKk
 DoE0iA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1cbmh29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915f7c37734so287073785a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289039; x=1781893839;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TPWo467A1KtBfknXLUhzGM05jfJhVUBGDG8kt4+2Duw=;
 b=UKsWwlZBuVCal/6+xOW1Nf9Efo+r6bCK6CxeQ2XaUDAOgQrZ98jmJMnqqZKJz/H+me
 hynbmEnFT8C2iQ/WmF4Uw9C7n3yfFiIUkNzBUO1juMp2vtDQpFg4/PbZ68Pj4+Ei9iPv
 KOWXRsM4Q0JVKHIpAZG70Ukiw4NNYofQCjGm+k9cc81/ObxFQzmRMY64pTbNZTk9aqls
 yJUkUs7CpvT9z20I2zAa/DvNAfQFnalvqEaMmCN5rZ0rBjgITmMy6J8Zu2Ol/VlYg2Zo
 OiVwpxxUXvByuEwSJUr78TMFZ7rhikbRtKsjwPnCDi+H/+A/ymOKH50i5XzKjmcPGJzv
 bhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289039; x=1781893839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TPWo467A1KtBfknXLUhzGM05jfJhVUBGDG8kt4+2Duw=;
 b=np1hpun7TQnWqeWDpb2trCD0cJPN2cCh+pZcI63ubSP7D4GRF58hWGp1Y6hzsEJ1DX
 EeRyAW1t+zv30Og114AGSJXsU6lgOgEGSMd2zUKZUR7/db+UoNuHbZvpG5NVZ8SMFlP7
 3rmrE7vpy1TWdIyu4S3Kwoc3q6GYxFXtDB+X6GPOWn66p7KZGKqNw/Nz2S26aEtX9Uec
 kSNx/2Eq4aoEYvTMSoEDInyaVWRY7mN/GmpDCbzA7DjDAh1QTnvZh66p6Yh/yudVmU7U
 /6x6rToGInnqFMWktQ8e1EQgEXaBmyyPSG4Nr+z9Jgkk8UBxiXfWOb9myvlePUrotrys
 gqwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+9SgN8Vu6OXEswlFX1eA+fl4LOqVl3SBKcNZYF1+Y9hwD3Kys92hpzQPQPjpg00vshJF5m6Nu@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+VzXsRzirtBCTAf/IrcRiEh6UX4rxJvdkbD6rTyeV4phWUHnu
 X0BTG1CXmfgDX03pu12jBMeOaxOe9Em1/btZnMUmS4qA3NQIFBJ7e/wM2LFoPtBRon0FQ6HgW04
 FnpSQbVtVbAv8kA3fBmriDgzmXx3H1xl1J+qblpP6OsqwPMPWaPbxpyAiRzxbb0V9mtiIwyqC55
 Ve
X-Gm-Gg: Acq92OHPdhoT+3eiK3PrbXsW0OVqOOvvJsypGmB3fD6sAXR56zfI6J8ZbAmbew8Hjtd
 IKxdY0y87W3ma7w3B5WtVMCnho4vknk9dtalyNiGiGLlxyX4yMKvNqbgmUZNjkmwqx6zNyvOYJs
 /nKkD2qFGmgrxgQUZNMeMjz1kVDjrCtryzwmuX298DwN+JAnn1i0wnJOXxhRNj1o1AXXaUHl9gl
 O3aT3cxRwYMwXCcavEiC2MeNnP8Nt+TlNp11Z/spHQTLxpnKo+LO0O8mhsuQA8kbwI9TkXxZ9k+
 9+ANbHgVZgHMQLMPGUAuR5Lzbt76ZD60igWmPj8eYRfLXOnrfP42be2JD0J8du9ly1roxHwMxIH
 KU9oz/ShLCbuw1rjjY5LpznlqyxfN/XjmtyGdiWsIbSXlUoi+HifedxeCQsT2eRfbOXS1iR3cZV
 etTFiIJg1GYEBGTnsz+RQJfaPBx7oMUSl3Acs=
X-Received: by 2002:a05:620a:6cc3:b0:915:a5bd:d82b with SMTP id
 af79cd13be357-9161bab53d7mr621082985a.9.1781289035518; 
 Fri, 12 Jun 2026 11:30:35 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc3:b0:915:a5bd:d82b with SMTP id
 af79cd13be357-9161bab53d7mr621044285a.9.1781289033033; 
 Fri, 12 Jun 2026 11:30:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:17 +0300
Subject: [PATCH v6 7/9] drm/vc4: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-7-9f3a54f81310@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=WHDRI+JhBcNuBgC+0OtPNMX06wOpYXQsdurLSHRrbWw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqLFA3w2eA8bVTfCfHWtbd+wRuk4WZ7UwSCELFb
 NxOkKpvyhmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaixQNwAKCRCLPIo+Aiko
 1Zs7B/9AUhF9TKQrWA7mEHSfv7WVuiuih1udWVrnH9RNj8QpmTWalWgAaq88xcqtqfZQ1rKIgyi
 0g9nwOMEU8kaWGhLFEbRXwS+0IEmVPcYdrtHtyILGIyAuThnCUQPQ85n5Pyko1tQY4J4AzY5gLx
 BO2pvW2aGpYAwpdiU5sipK7Wk6hcQnmS5tI7hYVq4utxYb761SSAMwC8E562cRt9Eodyi9aba5D
 xjvI7FKExDv/WlhOoJbXDAELkCQwM59yfhR2U+yn9b8sVAoGz9vceb5G8NgGI30BppAUwjAcJrU
 82zcn3Il4qxGFNUlheHmOwHsDcH96KoaQpAjKpqqd+4WzXud
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: YbZ4KFzJlHfPjufsCBfxBIXimfsZY6uX
X-Proofpoint-ORIG-GUID: YbZ4KFzJlHfPjufsCBfxBIXimfsZY6uX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX+xGueuyOS+td
 axvyik72Zb7JN8xjSFwThD1y4/R6ImpBHYtMTUQMztFdBDBWqSkLlNRFRTtnyIc0hmtQlaVeL75
 moFL6DRfahXpyZlm54C33bidZgN9HYA=
X-Authority-Analysis: v=2.4 cv=S57pBosP c=1 sm=1 tr=0 ts=6a2c504f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=P-IC7800AAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=YDDQE0DzCl7hcZedIR8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX6RO6FB9h9hgm
 7vufEFTBPq+J+Rl63UpFfNiipcnYB+NWOcpmqU2X+bi1ZUyj3o4N2ndiyw2Wyf+PNhDiHbUJ9eL
 aqvdoy9athypChoS1DdEso886KSkjoTTJ5xqn5BYS+tOScT8oP1l75nOEdKfDY0f6Qun1S290Hd
 EdxYoNen4BfqhfryPXKyDRAYOTAsDFzDEkTCTzA6K4IohZupdUdd0dxxWzug8h+nxGUgYIhBZKe
 N+miHlEWnevxt/77/KtiOwvA8PyhNUd2bbEiPxDALzNvgJ5RHkQ9hMLSXjLNSWeNQJesMOb+pDg
 dKJ5mkjb2iDkQmojvbgiaA8pNSVJOZamkM8BiBZ0ATb1t095dmx+4xdw7SQdJKgapw6ILvvh4RO
 Bn3MMHP2TvcLt4ZhPkwAaAxgdfxC3jouA1puxhDW2rOXeKeNbMhcln7e0oDGRfM2vKieIdnSY56
 HHlmkXaIc22/WPfcGoQ==
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
 drivers/gpu/drm/vc4/vc4_txp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 66b6f2acf862..3fd89fccfa10 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -378,7 +378,6 @@ vc4_txp_connector_detect(struct drm_connector *connector, bool force)
 static const struct drm_connector_funcs vc4_txp_connector_funcs = {
 	.detect = vc4_txp_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -602,10 +601,10 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 
 	drm_connector_helper_add(&txp->connector.base,
 				 &vc4_txp_connector_helper_funcs);
-	ret = drm_writeback_connector_init_with_encoder(drm, &txp->connector,
-							encoder,
-							&vc4_txp_connector_funcs,
-							drm_fmts, ARRAY_SIZE(drm_fmts));
+	ret = drmm_writeback_connector_init(drm, &txp->connector,
+					    &vc4_txp_connector_funcs,
+					    encoder,
+					    drm_fmts, ARRAY_SIZE(drm_fmts));
 	if (ret)
 		return ret;
 

-- 
2.47.3

