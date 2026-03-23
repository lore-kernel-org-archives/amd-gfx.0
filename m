Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B307D58CCE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D92010E3AF;
	Mon, 23 Mar 2026 04:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QgFuGqQY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bc8toqOc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7264F10E3B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:59 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MKenPE194123
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0ieE8/etbiGBriPXk9aLuLM0
 adGVcwwwVV2c9dNbcDA=; b=QgFuGqQYpMk/v6+sTtS2E6AyyL6NO3xR8buOH2KD
 I3JgL+cLyjr3rD+QRimtloHVuf84G7DYRVfjZc/Qxf9yfzASQhU9ZBd16DDsgBO6
 vaFOhHq3zID9O+Ha5ORB1e9/Wua7BqsCXQHRipSHX4TG1eXT+w9VP/d1upa2ziJP
 ddhAHSVS3NzQAcUyIA0yvDZM019E1fuTODHJUMC2DRD23C4ba90Gx/VhTxXEv8cP
 Ji0TYJVfBHZR6KCpef/ctsORGlbMTjsWeK4J3pEai57inymGl2dJRY3fK5149XRu
 AA2Xsdw0/jLjQIpUTSqF+CyzbyH1vkyaESJ3DaUDrWCBxA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1kj1kjd2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b5f675be9so69043151cf.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Mar 2026 21:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238878; x=1774843678;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0ieE8/etbiGBriPXk9aLuLM0adGVcwwwVV2c9dNbcDA=;
 b=Bc8toqOcGGKU0UVHJqH1c/DoGUvkdRPwcrBU3gLz5DbsdIkj3rY5WN+5w3lmNMdFqA
 T5/MUB+1l/MNr6RtlxgHqZxxMWZefDcITa5VRZgrDKoByGtweH0Zbos2Y56v3tOEQX1F
 ZVOeX1lKpl+jEcQeIuTgmNyJEdhDE8KL86J+hE5g5e3u7t8CsohZwDbLdv5mwwb6dWW1
 yBMFEPVa0uGV1Txq040xK8ZH+eV3dUw2RflVZiFuSQ3iogG/mlEJZxADtE2vzsKLnXYD
 gUV1VcSwg9f2nMWBS/4xuE8+27dmTWBitHK4gfSpyEfrIZabBY+tgmNdhvmR2xdjDgxx
 +wDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238878; x=1774843678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ieE8/etbiGBriPXk9aLuLM0adGVcwwwVV2c9dNbcDA=;
 b=PbYgDVK6xwamTzf1LSdy1bdClsfC6aItRfrWMpN4HnV9+qlrIJfx7qCIZmtMeEHHkP
 jmpSd0mCW7mvDLJ6hUva6JwaPtK5DRwtQ7ZvrF8ImOzxi10Ia8fNRm1t1oqPVZKEwbom
 zw/nq++Y+DKJ5yB38J12oufEYWWJMGVt+OWvQCTibgsoV20UpvPZ2fveCwWEgZJcX+S1
 oC7av72VXXKGbYmjzH5BFQpNAml9E0N9FdOZC/c07iLlxXfFnx9j+Wrp9vpzE4bgV5dS
 3vi8yRaelpMctiy1Djtjx8+J/htJRrp6dMIQELtR91GnyDbHYma0NNJ0Ku1pa3acy0Ca
 1gZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjIZt5c4QfSgK8R5zVpJdrx2n0sGzwccPZZe/sWVxEGbU378xBeEVStOs43iS9/Xvd7BcECwy+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIJdHoS2yGOyjQzVvMbiyTZkLTsi9KBTZzh3BCTLrxiefxl7wb
 DXZJYhDnAUd/6gAIP8BrfvZ3kxdFs3T3Ig0jiG2B0BtBf/hMrmHMoawBreabJX2BM4yqfXQ/RoG
 vW8BiHMfclHWoYwkl4tq/qyJZj5D9nm3QNy6dmCQMB4d5qLrfQffbqvCImPVS23O3NQ+9
X-Gm-Gg: ATEYQzwIEtBLFBTgiYBNrFTXCnJO6ZxPPKqZCKLQbU8gH1awzMKdGSZvQsSY8AqGrQW
 LEHzgUmf5SV1+9lm8Fmcc9cirTnPQuIBGyMxbmvFvYYqB9D4aR7slRlpj+q9hOrZL8PM7tSULRt
 vMWEe9f9gPdaWB91m+HnrWcF00GCa+M+wy1u4r5I44sMDm8UpXuLaFKTQeBxVX9kqMCI9VUy1WM
 UDGXA77Q0zTS4YqrE5zSCBFNkkCJ3p1usJ+LYrZZ8oPM9+nY3ACAmIw6V0mv7vHhUR9HqT74c5y
 gGvkeaIJGdVG4nvrrvyGZ07mNFLADu0akh6MDgaSfiApwPKsjPnpIrXuy+1RlQD+pvRYJGS0Gdg
 BQn6A8OXGIcMgn5CuMO1pFPQL00j5D/mMVOvcgpibDjFTjyg700ThSPNIkv+UWPHCsCGY8RB36q
 PaJJLVtSGgPi3T8g4ntOnG+/CRM/Nzl3y4Uj4=
X-Received: by 2002:ac8:5813:0:b0:50b:4e65:95d9 with SMTP id
 d75a77b69052e-50b4e6598f9mr88670821cf.64.1774238877897; 
 Sun, 22 Mar 2026 21:07:57 -0700 (PDT)
X-Received: by 2002:ac8:5813:0:b0:50b:4e65:95d9 with SMTP id
 d75a77b69052e-50b4e6598f9mr88670581cf.64.1774238877393; 
 Sun, 22 Mar 2026 21:07:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285192b5esm2239889e87.16.2026.03.22.21.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:07:56 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:07:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Liu Ying <victor.liu@nxp.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 05/14] drm/bridge: adv7511: Convert to
 drm_output_color_format
Message-ID: <orzixmg2drbnkygv4wz77ddlvbfbkmhg3hydt67b6xittdx3qf@2hghjym3ggon>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-5-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-5-f3935f6db579@kernel.org>
X-Proofpoint-GUID: 59Tt1EvgcV0CsS1d6CdV4x8TjofKbWVT
X-Proofpoint-ORIG-GUID: 59Tt1EvgcV0CsS1d6CdV4x8TjofKbWVT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOCBTYWx0ZWRfX/3ORZ5DnEasE
 Vx3MzpZFT6HyCu6Ws0osRjlgHfd7Uedwy3oTzDQzxhoq0KEBsPCLVXPToJdLON+vDdMHcAIeGEj
 tnXGgrmkOzaeMF/8I7An4nM27Iw9BMVt55oHdJl5li8o3mokPUvpkwjGn/EmcTmcDcXoXdkKF5Q
 DqnxPy555aNxQ/SgOnZ5AGEU+xTaPT0VsatiWRS6yo+QtDATMB7mINhvCo5S0oXccebP4cBaaM/
 D1QRlD32hIDq73UkIla9jLu+DG0vjw7wNnSWo8vf/iL/7CVguaUIGcU6NxE3+9sLjnOlhWAsUN0
 jW+TM3WoUt4Q9A3WLvIdz7pEyZAddDeUCkYHoCfB7ZzfKhYtTbgpassQwjEKT9png6nTsLGE359
 x560mS+twq79oNx93oS46dyJZZElCy42dc0w/uqQgUobhjgnBuTg01/Jqqkl727+7T+OBe0snyX
 L/cB6UzvLjbZrkOCl/g==
X-Authority-Analysis: v=2.4 cv=dYiNHHXe c=1 sm=1 tr=0 ts=69c0bc9e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=O2P03feSXV0Fh_yUmGcA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230028
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

On Thu, Mar 05, 2026 at 10:04:57AM +0100, Maxime Ripard wrote:
> Now that we introduced a new drm_output_color_format enum to represent
> what DRM_COLOR_FORMAT_* bits were representing, we can switch to the new
> enum.
> 
> The main difference is that while DRM_COLOR_FORMAT_ was a bitmask,
> drm_output_color_format is a proper enum. However, the enum was done is
> such a way than DRM_COLOR_FORMAT_X = BIT(DRM_OUTPUT_COLOR_FORMAT_X) so
> the transitition is easier.
> 
> The only thing we need to consider is if the original code meant to use
> that value as a bitmask, in which case we do need to keep the bit shift,
> or as a discriminant in which case we don't.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
