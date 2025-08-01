Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4D1C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 14:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E0510E86E;
	Fri,  1 Aug 2025 14:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rh4XrDsc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDE710E869
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 14:06:13 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57197hkg001415
 for <amd-gfx@lists.freedesktop.org>; Fri, 1 Aug 2025 14:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=X5mYO9TNcqG6LvwHvkvNnoW7
 mrgbAWbzpJxMDANF+yw=; b=Rh4XrDscXyf2Oo02oBHA4UuChG3U+1dh+T7OZAib
 VOuvM1m8SWmIm9s0HizjkP+In4P+XyxFB4XZx7IO7Jk/zzYjW/kIu9MAoHDfanDt
 ZK6ZqoVyXjZ4oZ9aQZ//45SiMCQnN1Md4SWDUjpVylMLrsI6fDTO6e1lMPCbcul0
 oj45dL+plcwt4ZOUYWeVSm6+aXgBwJX1E3S9fNMRuKw5jxIHAfkXX8Cu7W2h2xE2
 KUNOSM2i5MN6SzVqn+zzuAD2NNXnZ3nFwYlKDBiFE8zuStZ6F5rYuv5nXO0iq51Y
 M0bXcC1Vu0z1BSpGM0cpy9kLcSbf0lYPsu/KiiErHey7GA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nyuchkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 14:06:12 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b42218e4a59so1326769a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 07:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754057171; x=1754661971;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5mYO9TNcqG6LvwHvkvNnoW7mrgbAWbzpJxMDANF+yw=;
 b=va4NfXkJFIYMUt4fI/NLN/PTDdo9mt9mYESSORa5gn405JGgpnlvOSxCJEBkQn9Yf7
 PgBop9yhLkoKxEl0RkIOGc5bO6trTq8fYrEsu3u5GesSKHGDmezagRu432wYwHn7+gS8
 BoQD79MIjQtponfSdNg6W69+Yq6UhRqazgbICripBC/ZW2X3XzaiNuXUkutO7kw9EUZ1
 NF9iZ+Xf21XoZuNiIuOlF96UhPlUY0g2DoVcifjVeWjZwYpzsqJX0TnPGG4Y/Ctd6BOp
 fYmqCVFugl5YB2nWSXJUYplGmGOZ8VdsFD47FK+rmBPbVWeLzKohpid+JR05rG48zikm
 8snw==
X-Gm-Message-State: AOJu0Yxr/bRU1E0utCsNAz6lvCEi+xsHuaNdB7CnuglCM/a4J09ioG4A
 f5Pt+D64uHnGMHtFET+JKb1V52v+QNzjIkdx54l7BHPSilTFuLWobi0r5YH8Rx+VvZJVBDSlYrh
 Devy9cb7t7XhVBopGcvZ7+/P0l0EWuODuc/Ia+FRfHnK4LuCgY0NjdFNvXaEESnM2ZZ4qAj+oxM
 mk
X-Gm-Gg: ASbGncvd/DUYUJAOEJNAdbZ3SAsdhdidTMq2PZzkeV30UCM2dG28wzFEGO3t2xMN3sL
 s4Hn0m10U5Ovq68DvH+YToAz+38djUyZoiL9GnVn+/KFE2bFzb/JPZ829qaFx7Eqg7B0cp9rvOg
 Q7rNoN8nEuZ0EJSWGOdB5GmYkEcRigQvUZGJYymsm7bqUdXePOyFLJmVlQm4gP9i0iK8jIagPRo
 Po82pP6hkB9IGGm5QtB2xFsot2k/GBj+aSMgKpg29qIQmOJC2Cb5F+O7lc1t/7K5RVWKO/5nVq/
 d35jl6e64GGaf1eK1xpmdM6owJf8vhXL1VmWnZHWi1qLxx+Kg2/F/OA1ZavYc8ke/v1ushULSTq
 DlEsALlkQEtXM+sh9+zvA450e7UhKJetRzpNrzuQ0EZ4rbfIrrLz4
X-Received: by 2002:a05:6a21:33a5:b0:239:29ea:9c97 with SMTP id
 adf61e73a8af0-23dc0ec463emr20483666637.24.1754057170875; 
 Fri, 01 Aug 2025 07:06:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGitYNtTnXOBq8raaQNZX9YeStN7g/CeoibFIFiLag1gYHl4anqkXU57qCgbVhM4DI8a/qNMg==
X-Received: by 2002:a05:6a21:33a5:b0:239:29ea:9c97 with SMTP id
 adf61e73a8af0-23dc0ec463emr20483562637.24.1754057170060; 
 Fri, 01 Aug 2025 07:06:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-332388fc7d0sm5621721fa.59.2025.08.01.07.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:06:09 -0700 (PDT)
Date: Fri, 1 Aug 2025 17:06:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 5/8] drm/msm/dpu: use drmm_writeback_connector_init()
Message-ID: <z4ewbwtrqnem3af2tuket4wpgsulo6f6vy54hnhxrcx56hdx23@i5nuuiw3j36g>
References: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
 <20250801-wb-drop-encoder-v1-5-824646042f7d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-wb-drop-encoder-v1-5-824646042f7d@oss.qualcomm.com>
X-Proofpoint-GUID: 9MccfodQefS5pe2X7b9lUgEnIx0s2hA4
X-Proofpoint-ORIG-GUID: 9MccfodQefS5pe2X7b9lUgEnIx0s2hA4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwNSBTYWx0ZWRfX2wZK2xhoiY2d
 x7dOh3EH2W7MgBPnYlU7QQRkJUSGleRKyRqDOy10+m1Z16Xq4iXQvSuGATvnW0LhRTv5rsamg0J
 Nw5b/LQPQUROfmggsASnmanU5JSV6zrybxdYinzBcDQo8AIeg1Qa21jOm+YpHu2v4RklZ6VmG0P
 yU7osKsTZWSGoFpuwah2PINknq7vx0LRWAhdU8K9Y6pbFKOa+LbfpAcOmhoUSAdfMPpFQArqHVW
 U9O94eOC3n6iOLcWVH5S4aXC5C7j5YV1rNC86dHN9xT3CjOszimgDgIELamrjdlJuJD8f/yrqCb
 RULTRf6OeacnLiQog5DQAYTkwgjZp8YuqzmvCnTKtHS352/Ub4ZRcGWkxEA3dD9JXjnTCZltlx/
 XmIQT7Nob5cJKzZKlzEd2eaigCJkZsl7aj0jyy2QjG7PDe7jIt4t7tIwqRjN5V1sjKKdpIbG
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=688cc9d4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=noEQxEA5MoPOL7h678AA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010105
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

On Fri, Aug 01, 2025 at 04:51:13PM +0300, Dmitry Baryshkov wrote:
> Use drmm_plain_encoder_alloc() to allocate simple encoder and
> drmm_writeback_connector_init() in order to initialize writeback
> connector instance.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 23 +++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> index 8cd37d7b8ae281cbc1fd8cbb243c621174517e23..9986a10e8114680e9da48986f4ca3ce6ec66b8cb 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> @@ -134,7 +134,6 @@ static void rcar_du_wb_conn_reset(struct drm_connector *connector)

And I used wrong subject prefix here... I will fix it for v2 after
getting feedback on the series.


-- 
With best wishes
Dmitry
