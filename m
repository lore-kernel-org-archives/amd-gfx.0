Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA5ECD98D6
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B3910F634;
	Fri, 12 Jun 2026 18:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivZnQjum";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RhyQ4sX7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7573110F62D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:28 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGVrvw4113453
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VAc5Ikptycwe+SAdBBV6cT/v4cLIQIAkYHbY8Re0nJ8=; b=ivZnQjumAYn2ffrl
 Is7Sqx+bhSIzdvC7QxA7pmrNJEMhayWPE0cI+oG5wiLKNDeGlQayknv61BqZtUEf
 67MjnN7JcLD5O8FfZ+hDb5kLXtfidZb6E6gg1YmI4eFOmmjuc2UKM//YSgSWs/R0
 +seWyK/ZwXEJhtPfySsS6VMAkDWHI7Q4SdFa+SIjW/wY0aF+LEuO4M2bFJxRXjfa
 y12GojzejfbWsQSiK5GYXPfHPu+OOJTAxo11p2LznsRppvPat9ihKmXDafdqicG0
 g1AhstVX2RVdddrKeSIhnvNsk2BxVw6kF2SD+uqShvJaTNzGfGk5hI7sBbs1feBs
 RuRDVQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er30gc2pb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9159bc52211so181385185a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289027; x=1781893827;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VAc5Ikptycwe+SAdBBV6cT/v4cLIQIAkYHbY8Re0nJ8=;
 b=RhyQ4sX7M4ohz1zG3P8q+wesKnp3ujSilqLXcIDsYFQGPCBm9K0Xb7MX+7egvJw1WL
 x6ZNfaWbFtCtvuWmTLZQKWurREQooKy3H6CqkEspFD/So9HVRX2s8YURbXOrDpKGwnYq
 lBgsD3yIgu5zEiHkySawrFj98hzs/t9VHkeLe4nxoKCp6joa1JaBWBo9hMoDCnl8zfoa
 uzWZWYOWFnddzcr8a5vZuFx601mQcS4oEVKoEqfLQWSeX7LhaUjUNgJZmOUKd4s/HwnK
 4sjMjTH0sZbcVG+LtOIwLSz/k4ZexqEwYD7FXV7K8kbzFV6qExQY0Br9VyviBbRsbek9
 29QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289027; x=1781893827;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VAc5Ikptycwe+SAdBBV6cT/v4cLIQIAkYHbY8Re0nJ8=;
 b=qtGCRB+GzohsphobXyUNWLY4es1/K3M8dyz/W1J/fUUYpQ0aehS/oBBjRdqbSInlm9
 0e7zFPi3gZO+IOjGXZTYDnJ2uC89Qyoy8fQxBC7sPD9N+uVgwkfDEwoxSgv4cr9mMHrr
 YdXju6BRW7V95yyrYJzl7Zb0llbwg83ElKtIQJHTJEVV4toOCfK4443ivXdAT9MSTcqE
 8gl0ShT8x4I67DnALOro+uNA4KiCHCz8k3AtAFgAem52uAWEfJTr0JOl4V7n8xMQ+fMG
 f/wQbQZcygYh40hVpdScnEu8RGl/0+eBvAIwfyseI8dRhFxPFjMUrYA+ATEM6m2DlTjC
 zjlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1pYVizX+rnB+nXDyJ79kl0650QUKAXuSRJuqalQtUHVKdloFE3Qfl3TW9NRWp1/Z5TP+OsJo3@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9BbKySWdcmBRupnzXyW872sfrvD7XgT54bbZSAwTtrtuoExOV
 Uqi/kHD8QYQbQKt/u+tRkI1kqtuSUIiZwbji98wD/ByuqfkJ6KUIEH6pVWqXCBmbFvsa/su7RAl
 k2FDUm2LxEKyZr68TUnC7vyIzeBrmX6b7GyzsGfjpNthfUYm0IHSD4z8Qa+8inwTKWhWD
X-Gm-Gg: Acq92OHqblsNkysyGUCfwyQeI7vjtvj/HMbVSMCQz9HKCXSdOLyKf23YID5O+UoprFF
 VyWDqbbmi5SSXJthbpud0iTcEe4BD8450P4AsCNiXVe3InnS2TF1gXIa+f0D8TSNqr/4/jKpXy0
 7+EMuhXSnvBygjoLZ1WNjNmHKf3MTMP7N7eZoAjk5WKNPZuaYCDnGEXuR+AR+EIEUKduBpj8gmu
 lRAk5OTSwDLcF7YfbVeU+odO0TvPBztDZv8HmHulb+SBOGKvjGOzIbfr/ZM4AH+OtAdbrJrgPAF
 JUPTX5ec6bCNPlmeZ1D54NLvWQm5YJkrtKYWq5edKwzcNeE0P/fuhMlPn5qsgKK19My0yJfet8E
 21UfICzsETCS+PQcf9jpXLLQPQW4li0jt+GlpXkBo92+BEpSuwGT+RZXnRcv7QpW6wzeY0FQYDv
 1CrsYjMOURD6ihz7QZGOWHe9Q5rZK7nxjcqAk=
X-Received: by 2002:a05:620a:bc8:b0:915:a73e:3544 with SMTP id
 af79cd13be357-917f1c56720mr144563285a.56.1781289024544; 
 Fri, 12 Jun 2026 11:30:24 -0700 (PDT)
X-Received: by 2002:a05:620a:bc8:b0:915:a73e:3544 with SMTP id
 af79cd13be357-917f1c56720mr144477285a.56.1781289020618; 
 Fri, 12 Jun 2026 11:30:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:11 +0300
Subject: [PATCH v6 1/9] drm/managed: implement managed versions of
 kzalloc_obj/objs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-1-9f3a54f81310@oss.qualcomm.com>
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
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ns6ZF2Athx6EXhPPsCUzdeEz8OHVy14bl5aTVdNnAU0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqLFA2BP6d00ejrEHxJYdHp2X9IJejczYLfY75d
 jXdts+qMaCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaixQNgAKCRCLPIo+Aiko
 1YyuB/4/+1uiqA2fryPtK0Q7ctr1kG3ePgcUSkHFnblElLxP9p5KAV0NVSrsZu64PP9Uw8QhEHn
 eku5gVTB4fteWoAdmRV6MqED5jUCgtzKxXw31I6q2yE0HMzROPxsuZqjck649m6vQ+6gjWPoIYP
 tSvCAE8vpvPK2pQ8s47BDO71QWO174Xdq0Kyv6QPCsjDT1q5muBBfuIckdqMamMRRmXbJArYrNK
 GKbQ97M3DoUAW3s0S8dCBmtmiaDK2EvYKKZZ6xfYMjkleX/ieanilprQ/xFXxojPr8xMZnF96Zd
 t+bDLo/Q7QnIlQtPjN+RW8IeT2wx6PpYUovOoPNAnHFW6kFr
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX6BmdqArQCBLS
 TW5DZa7TlfLQWlmuaI425bfAYU81z/2YAI/OOmTPjZTXVsyCpnkXw4TVVGqeMtFwcmTxgzDx+j9
 CvGxb/7n039kSDA1s8gEo+5b46xRVMI=
X-Proofpoint-GUID: wk2p1WP-ruD8wCMwW16A49v5Jdbjg6dZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfXxj+k8fmq5K6Q
 F9sqyfBH1KsKC08/v0RSrQJ+Dn+ay5VVoDPZwkTc3oB2ur3ib9WLmrGFSwNvXB68XLiU/aZEVSB
 /6m1OzVV34FwvBfnVyXz69ccR0RYhf9e/Gm4/9ZYUEv2Dn+zzY/3O1Lj3Mf4s6tLyvjEkjoZ4r9
 gB5D1LhHPJBLvIBUM7CLqHJJcNzroKMUasy4EJUWCfPNC2L3Zs1DjS8D2I0QlvzjWRfjO91FXBz
 jk6LboViUlwHVl17PUutuvPo3J4I4Ux7H/J/S/JKmtDHl93eVWi6TQfe5cw7FeH8keqsXHVnbij
 BurJR0wJTod0Gt5JiFTM6+5zUvJouAeIe1WUKFZVnxF7xoMq6qjFQH8+k09nEToFD4Aun6r4dp9
 p5GfRlKeFfYwQQ84kt4dYrEUCD2ILLr0O9kolqmlXWNbj1fuGz6R3iLE1XLA7rcDDgzMLEbGoa4
 YmhjRIpTNlKfntswElA==
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a2c5043 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=6OF_V-VfZv2apoI2bYYA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: wk2p1WP-ruD8wCMwW16A49v5Jdbjg6dZ
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

The kzalloc_obj() and kzalloc_objs() functions proven to be useful and
widely used for the reset of the kernel. Implement a drm_device-managed
versions of those macros to mix the nice interface with the automatic
freeing of the pointers.

Note: the original macros accept optional GFP_foo arguments. They are
skipped for now, making all allocations use GFP_KERNEL. If necessary,
support for overriding the GFP type can be introduced later.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/drm/drm_managed.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/drm/drm_managed.h b/include/drm/drm_managed.h
index 72d0d68be226..79049bec277d 100644
--- a/include/drm/drm_managed.h
+++ b/include/drm/drm_managed.h
@@ -105,6 +105,28 @@ static inline void *drmm_kcalloc(struct drm_device *dev,
 	return drmm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
 }
 
+/**
+ * drmm_kzalloc_objs - &drm_device-managed kzalloc_objs()
+ * @dev: DRM device
+ * @p: Variable or type to allocate an array of
+ * @count: How many elements in the array
+ *
+ * Returns: newly allocated pointer to the zeroed array of @P on success, or
+ * NULL on failure.
+ */
+#define drmm_kzalloc_objs(dev, p, count) \
+	drmm_kcalloc(dev, count, sizeof(typeof(p)), GFP_KERNEL)
+
+/**
+ * drmm_kzalloc_obj - &drm_device-managed kzalloc_obj()
+ * @dev: DRM device
+ * @p: Variable or type to allocate
+ *
+ * Returns: newly allocated pointer to a @p on success, or NULL on failure.
+ */
+#define drmm_kzalloc_obj(dev, P) \
+	drmm_kzalloc_objs(dev, P, 1)
+
 char *drmm_kstrdup(struct drm_device *dev, const char *s, gfp_t gfp);
 
 void drmm_kfree(struct drm_device *dev, void *data);

-- 
2.47.3

