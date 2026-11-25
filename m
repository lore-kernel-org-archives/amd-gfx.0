Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1281606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l4KQfzU9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q44UMVEt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6901D10E238;
	Wed, 25 Nov 2026 04:54:15 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518CC10E238
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 04:54:04 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP2B6tL2625899
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 04:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xR7RhWJqTr/aczzO3EIq1crgEudqfPhwaC9mSHTF0TU=; b=l4KQfzU9Rc99lK+V
 nzj0GpWMR9ZTrp+ng2TtKfpbVTLmMGKE/7Xq7JL3KIUBubUG0ACAJZPToxrlD+sQ
 3pu0vOv/lBWMNfHDGgTxkN8BfGVxREQMD0OuGmohCSHRoKMQTZuiAPq0gBmZhBq7
 HaqCbfXV7EE5oD2cuyNMP4ASZKI/yI2lKoGExHLw46voeEF6SD8pn4/BaXB1V+HC
 uhBUkk0IIflK8NedFUpB8LMPsI9fKiTlDRLZo3QdFV/FuT39GETZFrRu+BCSnnFl
 McRY2fZiqlknjN0ZviKBt1NVNPsj0B49N85i8UkpOtdO8I+l8aXGiCBWbTzIFzJ2
 OTi/aA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mc28y74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 04:54:03 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-92114c39cadso100233526d6.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 20:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795582442; x=1796187242;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xR7RhWJqTr/aczzO3EIq1crgEudqfPhwaC9mSHTF0TU=;
 b=Q44UMVEt1dr4mkV32C08BswrVUUFdZLd+qt7GQODYt4GRNsV8ikbPSB8sbRtpqUXn3
 q1wpzh/Pkx+vWzjsX8d1Rww06h/Ts0Wb78Ae3tDPCaw8lov2eHpqFEKl+PehN1lz8FiZ
 g1rVjV4kEq1htWPTV25l/wUEuASBo7K9khwPsrBBzpsUTHfzpGGbyNZPWyJwsfst0b+G
 tTX/puvPy49GEXhrZ9UqXea0G1PPN48vjhQfyoL0DNDBC3/tkSNoUEXSxitHo9pduo3M
 Mra5YyE49eB7hCAewVj6Yfu43soKPqufZFraALPm/M2Y9my6aVG8lIQg3iSg2yxZzvDv
 WkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795582442; x=1796187242;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xR7RhWJqTr/aczzO3EIq1crgEudqfPhwaC9mSHTF0TU=;
 b=N+6UB4FlLuUPWNUGZL5dkie6Nau/ixNS3fmOojp9oJcKNdjmiYhWeQrivieE3g8GCs
 wtuBZEgMvzQdIYkwBYKXZ9UVb2qwzj0R27cqlj5RTNvOPO+aZZrwRGv6NT+MZkZdE90a
 d1TaxbQ//n7K6RZ/hZx2GRn3rI/CX+IrcSsBGcxJWHLgiQUPo3TK9fOQNEGYjI+DkvIc
 TK8ENf7dO71klfce7ppGwvCfKMmCVvW14ORMziIFsLx1qjhQzYiyLaBSY/kFyVgEmcXN
 twlq6enN6s4fdQUJKlz2X1sFp1TABE9+K9TtPCj5nujqG+g/GFKQ2d3qnpH+fwSEgapR
 xAaQ==
X-Gm-Message-State: APuU4Z80bKZxbAfuDh4MvgtsgRR8zIOfEU+/OMKL6igkZJVCOScmaI/3
 MWMFparjvhTehFmy3TZ0hheVCsAp1Pr8ikbCYeRBO0zj6gPzkaA81f6pd+whMA4GoFo3nUDiscb
 PDHFqj9n7wBGbMZB6kQZ7edJjz7rF9rpG0dAnjSuadc853Zdkb+VF2GdOld6+hS96q+KE
X-Gm-Gg: AZFdTZd8zkwChPwHpjtpcPFv8wH5Z6Vg0zUSIhja7plEuD3gO72+aT9x8gqmncOcojA
 0CrAYHDorHrVjBagJFm/bi+4p8vxRyh9PTA+KsvNKL5JsUCRkY8hR8ZtyOrIvPRJi8zXU+xqoV6
 054587+k1aKw7hExEgDR0NYm2NL7smFDvFVgjCDVnq2adXdhkl1FXFXpvNvY/I0M6dDr544VCKU
 hRrExM3HctoZWzyVAL0vIQBo29Auhp88lfZsr+L7Z/FbgQqx4x7nRwTjgZNzHtxHwKhgIZFKdTp
 1LObu+vkNke1gIAwmo4XkMTzxSkFxKY7dxg07Z0psC41Kc6HCHd08Sv84Gl/v3GmWPaj2OCmDtB
 9m775DpJ0qy7lGRi3eBITAVu2odts6OUx/dMzKLrUApAeUFomu0MtnQVV50usjo/n7YlnXsq5x+
 ep/crEVZZcHvuKdVYkCpyjj3XyZYh9aIQHnUwy5rzs+GhEt5QPqydKaH9FqHs38w==
X-Received: by 2002:a05:620a:a408:10b0:94a:889:5a41 with SMTP id
 af79cd13be357-94a08896148mr24608885a.71.1795582442592; 
 Tue, 24 Nov 2026 20:54:02 -0800 (PST)
X-Received: by 2002:a05:620a:a408:10b0:94a:889:5a41 with SMTP id
 af79cd13be357-94a08896148mr24604185a.71.1795582442056; 
 Tue, 24 Nov 2026 20:54:02 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bcff6e32sm4243023e87.17.2026.11.24.20.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 20:54:00 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
References: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
Subject: Re: [PATCH 0/8] drm: writeback: clean up writeback connector
 initialization
Message-Id: <179558244050.1572056.6952667613622271304.b4-ty@b4>
Date: Wed, 25 Nov 2026 06:54:00 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Authority-Analysis: v=2.4 cv=aPJlOr9m c=1 sm=1 tr=0 ts=6b0669eb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VUr37Z-sP6Vbzkouko0A:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: MUAKh_KAjBhylp5fFOdlNcTzuYvzxMG1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAxOSBTYWx0ZWRfX85g00zud0jFM
 peVz1elInOeBGpNW2sjo1zgogJ2r9JNP6pEwYGK1ozUm/4zj4WQJb7FBk45wocA3j6ItSVsEKL+
 VDjf+kt7GSWu7QGW4n300bX5r3Hqz1QDc4t6VcYp+II5yFwrS6TfR0GxuzB223Cxju2z1Oo8jw2
 QMmXZVlumAVGrFJKfmSPFb8WsmroYlP8D6eotFFqp+ViwnKl0yQaz7KtYU/JF344sp4I36y4MTb
 QWi66plntK4YGy1YUcL/kimevGQAgXc3KIsLRwzkJttWdpMYr9EpfpFtSkeXasvjTSxjKQIPub6
 lAH9rA1W+1ULEBWXLTe5tvCMLABeJH0kd+W1CcJYvCsfbdgVSY8H740hAojq7MeWv1VqxBlAXoa
 tcuA/DJELFaM06Ml6FqDxxfiBfyp2AK5QA4eZryjG8duI3QaiTwXP41fgnzZKhioGpHhTgsVbmq
 9GrEJz5/BtwI9MM8aYw==
X-Proofpoint-ORIG-GUID: MUAKh_KAjBhylp5fFOdlNcTzuYvzxMG1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAxOSBTYWx0ZWRfX9Xdo+tSaqC6r
 SS1GnExd8uQZlZ9kv9QjlPAKeubq5wPEqlZgOkbxtagSnxolosc+HZIJNDdrF5Y8bf4Z4QrhP23
 sSfEkhn/WMrBYqQT9wIPd3oQNIDASZo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250019
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 01 Aug 2025 16:51:08 +0300, Dmitry Baryshkov wrote:
> Drivers using drm_writeback_connector_init() / _with_encoder() don't
> perform cleanup in a manner similar to drmm_writeback_connector_init()
> (see drm_writeback_connector_cleanup()). Migrate all existing drivers
> to use drmm_writeback_connector_init(), drop
> drm_writeback_connector_init() and drm_writeback_connector::encoder
> (it's unused afterwards).
> 
> [...]

Applied to drm-misc-next, thanks!

[1/8] drm/amd/display: use drmm_writeback_connector_init()
      (no commit info)
[2/8] drm/komeda: use drmm_writeback_connector_init()
      (no commit info)
[3/8] drm/mali: use drmm_writeback_connector_init()
      (no commit info)
[4/8] drm/msm/dpu: use drmm_writeback_connector_init()
      (no commit info)
[5/8] drm/msm/dpu: use drmm_writeback_connector_init()
      (no commit info)
[6/8] drm/vc4: use drmm_writeback_connector_init()
      (no commit info)
[7/8] drm: writeback: drop excess connector initialization functions
      commit: 7bcb37603df095e56e87d6144201179fe911e4dd
[8/8] drm: writeback: rename drm_writeback_connector_init_with_encoder()
      commit: 81f61b4e0467ddab3695be58a94fc322c8bd559a

Best regards,
-- 
With best wishes
Dmitry


