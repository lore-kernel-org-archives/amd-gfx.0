Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7FCC35FF7
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 09:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083DF10E99F;
	Fri, 14 Mar 2025 09:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hGho4CJj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC0010E2E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 06:00:02 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DJP8lV018566
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 06:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ugx4av2Bblczqdq51yvv9QisQbSYAgbAPKVnJleCLeo=; b=hGho4CJjr/KOBibe
 eJ1Xw9kydGPqBDQKqEWeGaMLrdgMAKWz57lDF+cQ087DC1YI1y6ch+rNpxNEKTBw
 N2dVr197yQwvbtpTSwKMt5nTGs1h3QWtam42rPI8zG3JJtBI8lM1OaLGr6Z2Yr2C
 bsruOMXffOgob/t0ckIVuTjvA40zVJ5ovpfKvLUEYAkBPAMr7angMMd03pk3rqm2
 8XhzMuVyy64ByEiGrJjINXh2ZkaUTelosfd4TzDxn7gtPA/4kQC61pnbyJV0Nweg
 7/TQXTsN3plrDIGNhbyVA1H4V03T0qKndt0iTIpDhxqWOuAmFXurBtboQxGfs9s3
 cbYPZQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2p08fa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 06:00:01 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e2378169a4so35882856d6.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 23:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741932000; x=1742536800;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugx4av2Bblczqdq51yvv9QisQbSYAgbAPKVnJleCLeo=;
 b=LGFEB+DWJiNxaaShy3LaoTNhI5tNB+dAV3LgDqGGJrFijkhtrQSu2yw7rH6AONWq1A
 hoWnTG21N9XxghtcDHQzQF0tJVqx2EBMAik/LA/XhNUpZDtGJKEP02cYjgu64A/KoooW
 M9z6wl7dREomGD4bkHTZe6a0fJILMXf91T5Z4jkCekoUXjlijTxAagAdzscNK6v/B/rE
 jMoy6Vd77Q/Gt9Z6yQ+wVLW8iH0rVwk4XVFSaSGLpolLGXJCqjnva1aEZqALruQEKl8u
 KR5Dq2f8EEvzN+dB86+YsaoVgfYYX3ubCqk/FIy+JVSNhM5yEDTdFgNe3+q7hTVP8+59
 j0lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF4bjBc3MOGDdZ1zC8ye60V3bJsN1OO7WPzKACTt5RPQpbYNrADmUPa95p2oIeyLHtwGBchJK1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDxOj8C0ExVUjlz1djH8D7Q43fR7DkJM0YAJycTrm4aIEc1xDU
 weYlifCX5qZp0kMoXuzzmMnPYcqX4LgswNbZ3YvW+Cx8SBSyZrr/Xx9PEM1P9jcBEau0PGbS4if
 EkH5M6uXbL+LHjUcP4CjePRY+9aPgb+9gq2KYmCG1z6ccYjd7XXzIzSzsVK3iNMwu
X-Gm-Gg: ASbGncsP+urpsdy4iMVHlDC2mb7wQKEUbzg1NvBVfAi845NegTzJDscQXdDt6D1um/6
 TNi1z7A7NeT1FBe+AFg8UiP8fCiGgTU+PNrA4r8zJZAdlwAZ18ZpgUbPshjOhWz3ZQ2JcK3pZrV
 zR677KGtoO3wCi6NdzJuqnPc0bHdGK/e28vKQq8Iw0zv4tK70z8JbNVsU31iyP8r1gjaFsyVEMD
 lvQgcUwP1CPoff22l7y56vHeePoLVm6uG3hQ1qplFdUwyJ8Ay04vTzJ/XNdx9Q77WnJ5WiSXeIb
 Mzx0p1sq4ZAz8K4Amatpau6pAhB4P73ZbUeR9lcp3DRFLb+FXR44W6WRxWuSXbz8AWIWNht/oEQ
 g6TqxJHUOju/DR4u3E9FTceRpRGqw
X-Received: by 2002:a05:6214:5097:b0:6e2:497f:1ec7 with SMTP id
 6a1803df08f44-6eaeaafff86mr13945986d6.41.1741932000445; 
 Thu, 13 Mar 2025 23:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzJ3grBfkPGn5evRNuPJKqK/SdPx0yO1Uibhzm1nNT/G7XrRBNiFV4aSukq9DzA4rYPS14pw==
X-Received: by 2002:a05:6214:5097:b0:6e2:497f:1ec7 with SMTP id
 6a1803df08f44-6eaeaafff86mr13945486d6.41.1741932000055; 
 Thu, 13 Mar 2025 23:00:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-549ba88332dsm416136e87.181.2025.03.13.22.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 22:59:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 07:59:42 +0200
Subject: [PATCH RFC v4 1/6] drm/display: dp: implement new access helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-drm-rework-dpcd-access-v4-1-e86ef6fc6d76@oss.qualcomm.com>
References: <20250314-drm-rework-dpcd-access-v4-0-e86ef6fc6d76@oss.qualcomm.com>
In-Reply-To: <20250314-drm-rework-dpcd-access-v4-0-e86ef6fc6d76@oss.qualcomm.com>
To: Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6708;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QM+eu1I8aF02p2Or2gRwLpTXBfv2/4RXGbOyoJVHkoQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn08XY76ngDwaa5WbbrdnBPCrij+LYZ6UJ9ScWI
 ZBKCV7VVm+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9PF2AAKCRCLPIo+Aiko
 1XWCB/9wWGxU4kR6XthOtq7XncKAUuPSbsaARThdOcFHINweGF7C6Wa2lV6einYdmNCuwSdK+qm
 7fxF0f/No9p3981YbAVJBAW5JWJtkV9YuZUGz2y21/Sn74OKnQovmxFt8V+5SOmTFfpDUQH5xhB
 l+dSgrNXyy7lLq2MeB6Ncl7hsky4L3CnlC9SsU9dY+dMhXKP+6drMiOGNba7G9BVAkQm36yA+yJ
 rAeE4LStO6w/0SzJig17D8rJRhMBFnQYzopZJ2LEld/bI7gHzeLFukCPlCAgB+JpTAkB33rMPi6
 Df94J3JekD1yuiOAz9/B8JBFs/IJhJS6vcGKoxVpSYe2dFJL
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: QOL8auVnuSAUaORAmgnatGoxLYyT54Ib
X-Authority-Analysis: v=2.4 cv=Q4XS452a c=1 sm=1 tr=0 ts=67d3c5e1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8
 a=Mcyz43guUpAUgyxYx7EA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: QOL8auVnuSAUaORAmgnatGoxLYyT54Ib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_02,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140045
X-Mailman-Approved-At: Fri, 14 Mar 2025 09:11:23 +0000
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Existing DPCD access functions return an error code or the number of
bytes being read / write in case of partial access. However a lot of
drivers either (incorrectly) ignore partial access or mishandle error
codes. In other cases this results in a boilerplate code which compares
returned value with the size.

Implement new set of DPCD access helpers, which ignore partial access,
always return 0 or an error code.

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_dp_helper.c |  4 ++
 include/drm/display/drm_dp_helper.h     | 92 ++++++++++++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index dbce1c3f49691fc687fee2404b723c73d533f23d..e43a8f4a252dae22eeaae1f4ca94da064303033d 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -704,6 +704,8 @@ EXPORT_SYMBOL(drm_dp_dpcd_set_powered);
  * function returns -EPROTO. Errors from the underlying AUX channel transfer
  * function, with the exception of -EBUSY (which causes the transaction to
  * be retried), are propagated to the caller.
+ *
+ * In most of the cases you want to use drm_dp_dpcd_read_data() instead.
  */
 ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 			 void *buffer, size_t size)
@@ -752,6 +754,8 @@ EXPORT_SYMBOL(drm_dp_dpcd_read);
  * function returns -EPROTO. Errors from the underlying AUX channel transfer
  * function, with the exception of -EBUSY (which causes the transaction to
  * be retried), are propagated to the caller.
+ *
+ * In most of the cases you want to use drm_dp_dpcd_write_data() instead.
  */
 ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
 			  void *buffer, size_t size)
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 5ae4241959f24e2c1fb581d7c7d770485d603099..21e22289d1caebe616b57a304061b12592ad41ea 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -527,6 +527,64 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
 			  void *buffer, size_t size);
 
+/**
+ * drm_dp_dpcd_read_data() - read a series of bytes from the DPCD
+ * @aux: DisplayPort AUX channel (SST or MST)
+ * @offset: address of the (first) register to read
+ * @buffer: buffer to store the register values
+ * @size: number of bytes in @buffer
+ *
+ * Returns zero (0) on success, or a negative error
+ * code on failure. -EIO is returned if the request was NAKed by the sink or
+ * if the retry count was exceeded. If not all bytes were transferred, this
+ * function returns -EPROTO. Errors from the underlying AUX channel transfer
+ * function, with the exception of -EBUSY (which causes the transaction to
+ * be retried), are propagated to the caller.
+ */
+static inline int drm_dp_dpcd_read_data(struct drm_dp_aux *aux,
+					unsigned int offset,
+					void *buffer, size_t size)
+{
+	int ret;
+
+	ret = drm_dp_dpcd_read(aux, offset, buffer, size);
+	if (ret < 0)
+		return ret;
+	if (ret < size)
+		return -EPROTO;
+
+	return 0;
+}
+
+/**
+ * drm_dp_dpcd_write_data() - write a series of bytes to the DPCD
+ * @aux: DisplayPort AUX channel (SST or MST)
+ * @offset: address of the (first) register to write
+ * @buffer: buffer containing the values to write
+ * @size: number of bytes in @buffer
+ *
+ * Returns zero (0) on success, or a negative error
+ * code on failure. -EIO is returned if the request was NAKed by the sink or
+ * if the retry count was exceeded. If not all bytes were transferred, this
+ * function returns -EPROTO. Errors from the underlying AUX channel transfer
+ * function, with the exception of -EBUSY (which causes the transaction to
+ * be retried), are propagated to the caller.
+ */
+static inline int drm_dp_dpcd_write_data(struct drm_dp_aux *aux,
+					 unsigned int offset,
+					 void *buffer, size_t size)
+{
+	int ret;
+
+	ret = drm_dp_dpcd_write(aux, offset, buffer, size);
+	if (ret < 0)
+		return ret;
+	if (ret < size)
+		return -EPROTO;
+
+	return 0;
+}
+
 /**
  * drm_dp_dpcd_readb() - read a single byte from the DPCD
  * @aux: DisplayPort AUX channel
@@ -534,7 +592,8 @@ ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
  * @valuep: location where the value of the register will be stored
  *
  * Returns the number of bytes transferred (1) on success, or a negative
- * error code on failure.
+ * error code on failure. In most of the cases you should be using
+ * drm_dp_dpcd_read_byte() instead.
  */
 static inline ssize_t drm_dp_dpcd_readb(struct drm_dp_aux *aux,
 					unsigned int offset, u8 *valuep)
@@ -549,7 +608,8 @@ static inline ssize_t drm_dp_dpcd_readb(struct drm_dp_aux *aux,
  * @value: value to write to the register
  *
  * Returns the number of bytes transferred (1) on success, or a negative
- * error code on failure.
+ * error code on failure. In most of the cases you should be using
+ * drm_dp_dpcd_write_byte() instead.
  */
 static inline ssize_t drm_dp_dpcd_writeb(struct drm_dp_aux *aux,
 					 unsigned int offset, u8 value)
@@ -557,6 +617,34 @@ static inline ssize_t drm_dp_dpcd_writeb(struct drm_dp_aux *aux,
 	return drm_dp_dpcd_write(aux, offset, &value, 1);
 }
 
+/**
+ * drm_dp_dpcd_read_byte() - read a single byte from the DPCD
+ * @aux: DisplayPort AUX channel
+ * @offset: address of the register to read
+ * @valuep: location where the value of the register will be stored
+ *
+ * Returns zero (0) on success, or a negative error code on failure.
+ */
+static inline int drm_dp_dpcd_read_byte(struct drm_dp_aux *aux,
+					unsigned int offset, u8 *valuep)
+{
+	return drm_dp_dpcd_read_data(aux, offset, valuep, 1);
+}
+
+/**
+ * drm_dp_dpcd_write_byte() - write a single byte to the DPCD
+ * @aux: DisplayPort AUX channel
+ * @offset: address of the register to write
+ * @value: value to write to the register
+ *
+ * Returns zero (0) on success, or a negative error code on failure.
+ */
+static inline int drm_dp_dpcd_write_byte(struct drm_dp_aux *aux,
+					 unsigned int offset, u8 value)
+{
+	return drm_dp_dpcd_write_data(aux, offset, &value, 1);
+}
+
 int drm_dp_read_dpcd_caps(struct drm_dp_aux *aux,
 			  u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 

-- 
2.39.5

