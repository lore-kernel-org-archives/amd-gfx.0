Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AF6C36011
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 11:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53A310E31B;
	Mon, 24 Mar 2025 11:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E33hlGXi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FB910E2FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 11:51:36 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PSOF015754
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 11:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cbVY8Zk+Bw747ivKpsWKnew31zOXihiyANI1TT91neA=; b=E33hlGXiVATQrshM
 FVfIbT1LYmJkeD80CGXjTlky87mDggWTcQ12wK9stj/qqRBmPKL7qaJyqBCXyM23
 31vdxqbUGBzIXpZkDjAqPVzuwmPMamLyHsMFzp8xGS5AKLYa5YZblENHrg71gi7Z
 2+lg5RsDoyK8NA3PI3tO/wk7fbKmNMwSBsKLruG/fkvhglfVxk+eYHFOcgmwdBNJ
 j4GCBID9fHEwAucaUVnFHivvGfvRMQk55VJYdbPCiW4gKFCZth++2++nABqEOSDx
 NIttderiKIInB4thKMbKZWTUKtGJT3Vsjf61+2EPFBlXzzM731zxPJR31ccWfxDb
 WgRr9Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hn9wc7n3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 11:51:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5c77aff55so411955885a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 04:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742817095; x=1743421895;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cbVY8Zk+Bw747ivKpsWKnew31zOXihiyANI1TT91neA=;
 b=a2fVtoeAZaWOaQZdYkukWPWfyXXG8BNzmU9WuNsUcTg2Cj78y9ZcUuw5Qg2LV/jNiE
 OzxEjBvt3EMzOGkQHplHeLzh38KDqwepFw7TSzWo5WgZ3Et8qHi2lotFXJxrUA2mdpRj
 DhKhD4Gnl638SDZGrewbyoko1Wgft5UKHSnMhHj5omSIllvQ9i+3v7+eaB/dOPpU7fiy
 BDWY5P0nEOBWm8q/ZyU46HusdUy68cn+bppei1gR0JL6D0y/uVrjY5PANQhHAOxNoGrp
 Z+NSlu5JiOX1ySIAryuixE2QB76dJ6Ol93syKBdlBqF7kwsWChUYiQalhPQulaRVImyk
 lXgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdPEprlv5tAEFulzI7JX+aZ1PXws8ergRW3f1MZ0iUR17+r60wA0Rb5O1ifc+5uJ7fRI4rT5Xj@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsbEVy/go1NgF+tmnY2fu5+TDQ0LbmVsgGLjPsDVt/+/ShsHDm
 zED5dofn4nWU3aUXoz4aCM1EctxqEp1Z6n4Y1kiWJSYwqNKHtrimRZY0bYKXeQ0YuwyMz8a6UYo
 pLP22e9sSr7RH1NWXTqZxZWZ8VNvtcpc8Imks7d01wZkPtBCTBA2O+4F+LcAmz24o
X-Gm-Gg: ASbGnctc+sbtYC0RIGSUwBVAqj4KBC3hLMYR+3clexAgAHpjEt8cBfw+utggjMui/EO
 OZztZ5OUwdWHAKszyM0r6G/qzJqD0sFzCNW0NXQB6GsN3/b/XivQHIDDSVyp0RG9Hx9nJw/oYGQ
 O3WD4LW9tmQGZAgzFzgFV8oG8hX5g7xlbjmJNtdmqevHwQGfKB6MK8ZCgA5qQC84euT4Km97RMD
 WXGVNdk6Ui+VGlattSLIkWoBQ2UH2FQF9i9TBGzuQm73PcGxzsr3eJZ5pL/2z+v8vOn3tq2yIs/
 IyfNYhpWfGof4tKGKRIiWJrn7BpKPyp7L6zNiLQtO6vne295qnHEW27XgJ5hGSRVzGHvo7qu9n0
 //ASNoMkJUayOx8EWWvQFe0N6Rmf+
X-Received: by 2002:a05:620a:31a4:b0:7c5:3ef2:8c40 with SMTP id
 af79cd13be357-7c5ba13371emr1765958085a.12.1742817094551; 
 Mon, 24 Mar 2025 04:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg0k94jmPD+RxovZl/zqq2uTWR2GTxdEZ29Cc9DCcLMRxUjW46zVufE6pscz39TWnXIul+EA==
X-Received: by 2002:a05:620a:31a4:b0:7c5:3ef2:8c40 with SMTP id
 af79cd13be357-7c5ba13371emr1765950185a.12.1742817093974; 
 Mon, 24 Mar 2025 04:51:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54ad64fbb51sm1142907e87.135.2025.03.24.04.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 04:51:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 13:51:22 +0200
Subject: [PATCH RESEND RFC v4 4/6] drm/display: dp-cec: use new DCPD access
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-drm-rework-dpcd-access-v4-4-e80ff89593df@oss.qualcomm.com>
References: <20250324-drm-rework-dpcd-access-v4-0-e80ff89593df@oss.qualcomm.com>
In-Reply-To: <20250324-drm-rework-dpcd-access-v4-0-e80ff89593df@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5086;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=d/g0s+1RbkEZsu0cFrspMKQl16Oh0pnUASV91YvLy1M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn4Uc4qY7c2KAxUD5W9eg477Vs/ZegX4vkSQNj8
 MEzvsWNoiyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ+FHOAAKCRCLPIo+Aiko
 1ZKJB/9fjUpYke46Wsol0rc+zMKNqgf3P68MvK2G+RUyxuntyFuvFAcQCCXZGZk7Xij5w1MDBMP
 UZeulEkuNwt9D1Met6H71wl8L8SvhmZVIlFhAs+CTGA0WCh1w2ZeID47mf+FuqqI0MTvQoTpvtX
 ukAPtLT0uS61M/IPRpwpc34YM83bbxMlxBCo/qOI++60KOmQCkiGKmwIeGSzsCJkkkd6jNP/gKG
 RUwWvSklDyqZoAGFAHa0k7WPtmsNo4bBmMdtrnJX1UJoPaENZOjX+YaQwbLSkM36cINZbA/CXsk
 NsFv8VNJLSZEkxX0whPBJaBEO6k9lfnirnzKgormGFQDBzeN
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: -S1SvglJmt4zUC9mn5w3tJYj7M8AeeYm
X-Proofpoint-ORIG-GUID: -S1SvglJmt4zUC9mn5w3tJYj7M8AeeYm
X-Authority-Analysis: v=2.4 cv=CPoqXQrD c=1 sm=1 tr=0 ts=67e14747 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=Bz2Z_qUYR0Plbu_cxIUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240086
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

Switch drm_dp_cec.c to use new set of DPCD read / write helpers.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_dp_cec.c | 37 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_cec.c b/drivers/gpu/drm/display/drm_dp_cec.c
index 56a4965e518cc237c992a2e31b9f6de05c14766a..ed31471bd0e28826254ecedac48c5c126729d470 100644
--- a/drivers/gpu/drm/display/drm_dp_cec.c
+++ b/drivers/gpu/drm/display/drm_dp_cec.c
@@ -96,7 +96,7 @@ static int drm_dp_cec_adap_enable(struct cec_adapter *adap, bool enable)
 	u32 val = enable ? DP_CEC_TUNNELING_ENABLE : 0;
 	ssize_t err = 0;
 
-	err = drm_dp_dpcd_writeb(aux, DP_CEC_TUNNELING_CONTROL, val);
+	err = drm_dp_dpcd_write_byte(aux, DP_CEC_TUNNELING_CONTROL, val);
 	return (enable && err < 0) ? err : 0;
 }
 
@@ -112,7 +112,7 @@ static int drm_dp_cec_adap_log_addr(struct cec_adapter *adap, u8 addr)
 		la_mask |= adap->log_addrs.log_addr_mask | (1 << addr);
 	mask[0] = la_mask & 0xff;
 	mask[1] = la_mask >> 8;
-	err = drm_dp_dpcd_write(aux, DP_CEC_LOGICAL_ADDRESS_MASK, mask, 2);
+	err = drm_dp_dpcd_write_data(aux, DP_CEC_LOGICAL_ADDRESS_MASK, mask, 2);
 	return (addr != CEC_LOG_ADDR_INVALID && err < 0) ? err : 0;
 }
 
@@ -123,15 +123,14 @@ static int drm_dp_cec_adap_transmit(struct cec_adapter *adap, u8 attempts,
 	unsigned int retries = min(5, attempts - 1);
 	ssize_t err;
 
-	err = drm_dp_dpcd_write(aux, DP_CEC_TX_MESSAGE_BUFFER,
-				msg->msg, msg->len);
+	err = drm_dp_dpcd_write_data(aux, DP_CEC_TX_MESSAGE_BUFFER,
+				     msg->msg, msg->len);
 	if (err < 0)
 		return err;
 
-	err = drm_dp_dpcd_writeb(aux, DP_CEC_TX_MESSAGE_INFO,
-				 (msg->len - 1) | (retries << 4) |
-				 DP_CEC_TX_MESSAGE_SEND);
-	return err < 0 ? err : 0;
+	return drm_dp_dpcd_write_byte(aux, DP_CEC_TX_MESSAGE_INFO,
+				      (msg->len - 1) | (retries << 4) |
+				      DP_CEC_TX_MESSAGE_SEND);
 }
 
 static int drm_dp_cec_adap_monitor_all_enable(struct cec_adapter *adap,
@@ -144,13 +143,13 @@ static int drm_dp_cec_adap_monitor_all_enable(struct cec_adapter *adap,
 	if (!(adap->capabilities & CEC_CAP_MONITOR_ALL))
 		return 0;
 
-	err = drm_dp_dpcd_readb(aux, DP_CEC_TUNNELING_CONTROL, &val);
-	if (err >= 0) {
+	err = drm_dp_dpcd_read_byte(aux, DP_CEC_TUNNELING_CONTROL, &val);
+	if (!err) {
 		if (enable)
 			val |= DP_CEC_SNOOPING_ENABLE;
 		else
 			val &= ~DP_CEC_SNOOPING_ENABLE;
-		err = drm_dp_dpcd_writeb(aux, DP_CEC_TUNNELING_CONTROL, val);
+		err = drm_dp_dpcd_write_byte(aux, DP_CEC_TUNNELING_CONTROL, val);
 	}
 	return (enable && err < 0) ? err : 0;
 }
@@ -194,7 +193,7 @@ static int drm_dp_cec_received(struct drm_dp_aux *aux)
 	u8 rx_msg_info;
 	ssize_t err;
 
-	err = drm_dp_dpcd_readb(aux, DP_CEC_RX_MESSAGE_INFO, &rx_msg_info);
+	err = drm_dp_dpcd_read_byte(aux, DP_CEC_RX_MESSAGE_INFO, &rx_msg_info);
 	if (err < 0)
 		return err;
 
@@ -202,7 +201,7 @@ static int drm_dp_cec_received(struct drm_dp_aux *aux)
 		return 0;
 
 	msg.len = (rx_msg_info & DP_CEC_RX_MESSAGE_LEN_MASK) + 1;
-	err = drm_dp_dpcd_read(aux, DP_CEC_RX_MESSAGE_BUFFER, msg.msg, msg.len);
+	err = drm_dp_dpcd_read_data(aux, DP_CEC_RX_MESSAGE_BUFFER, msg.msg, msg.len);
 	if (err < 0)
 		return err;
 
@@ -215,7 +214,7 @@ static void drm_dp_cec_handle_irq(struct drm_dp_aux *aux)
 	struct cec_adapter *adap = aux->cec.adap;
 	u8 flags;
 
-	if (drm_dp_dpcd_readb(aux, DP_CEC_TUNNELING_IRQ_FLAGS, &flags) < 0)
+	if (drm_dp_dpcd_read_byte(aux, DP_CEC_TUNNELING_IRQ_FLAGS, &flags) < 0)
 		return;
 
 	if (flags & DP_CEC_RX_MESSAGE_INFO_VALID)
@@ -230,7 +229,7 @@ static void drm_dp_cec_handle_irq(struct drm_dp_aux *aux)
 		 (DP_CEC_TX_ADDRESS_NACK_ERROR | DP_CEC_TX_DATA_NACK_ERROR))
 		cec_transmit_attempt_done(adap, CEC_TX_STATUS_NACK |
 						CEC_TX_STATUS_MAX_RETRIES);
-	drm_dp_dpcd_writeb(aux, DP_CEC_TUNNELING_IRQ_FLAGS, flags);
+	drm_dp_dpcd_write_byte(aux, DP_CEC_TUNNELING_IRQ_FLAGS, flags);
 }
 
 /**
@@ -253,13 +252,13 @@ void drm_dp_cec_irq(struct drm_dp_aux *aux)
 	if (!aux->cec.adap)
 		goto unlock;
 
-	ret = drm_dp_dpcd_readb(aux, DP_DEVICE_SERVICE_IRQ_VECTOR_ESI1,
-				&cec_irq);
+	ret = drm_dp_dpcd_read_byte(aux, DP_DEVICE_SERVICE_IRQ_VECTOR_ESI1,
+				    &cec_irq);
 	if (ret < 0 || !(cec_irq & DP_CEC_IRQ))
 		goto unlock;
 
 	drm_dp_cec_handle_irq(aux);
-	drm_dp_dpcd_writeb(aux, DP_DEVICE_SERVICE_IRQ_VECTOR_ESI1, DP_CEC_IRQ);
+	drm_dp_dpcd_write_byte(aux, DP_DEVICE_SERVICE_IRQ_VECTOR_ESI1, DP_CEC_IRQ);
 unlock:
 	mutex_unlock(&aux->cec.lock);
 }
@@ -269,7 +268,7 @@ static bool drm_dp_cec_cap(struct drm_dp_aux *aux, u8 *cec_cap)
 {
 	u8 cap = 0;
 
-	if (drm_dp_dpcd_readb(aux, DP_CEC_TUNNELING_CAPABILITY, &cap) != 1 ||
+	if (drm_dp_dpcd_read_byte(aux, DP_CEC_TUNNELING_CAPABILITY, &cap) < 0 ||
 	    !(cap & DP_CEC_TUNNELING_CAPABLE))
 		return false;
 	if (cec_cap)

-- 
2.39.5

