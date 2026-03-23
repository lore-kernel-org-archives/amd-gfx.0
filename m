Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53E0D58CD1
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA6410E370;
	Mon, 23 Mar 2026 04:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ozc6CeFD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GdTrAF8A";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA3E10E366
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:03:13 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MIjn2m626959
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZjTWTO9LGKbNJnCdQR2t56Ga
 qKq39XkGtlvuZ5fybUY=; b=Ozc6CeFD6p1fCbrn7gsfAUtdjoYHKvbceDQNVeNL
 gdGiq572M53A7ankXVia7Q9sS7TX+Qu5iMKQjqtSw93u/AJzb2beekF0AydNlzh9
 W2SbJM4tROlHH2oUhRrdishXFoYahYu3BPMjSSHJca+vwzSbKmC8inVkmD/zcq05
 8inmKT5xjBX66/Pda5BYtqNzP0gLZMC5NlCLIt5NcEDdAnmabFiyp/YBPUQCcdDE
 rgWB1SvrJ9EsA9J3Mxy70Du2SDeI6qLM0fgsIUWErTgvZ0zp7FmeMkxRnbPrHW/H
 OCkQ/cwWHQ11kLfWcLankx3x2yH2KW6w4Kjo+PzgcEcMNQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1j9rbnr6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:03:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50917996cfaso36295841cf.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Mar 2026 21:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238591; x=1774843391;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZjTWTO9LGKbNJnCdQR2t56GaqKq39XkGtlvuZ5fybUY=;
 b=GdTrAF8AQ0GdhQdCU798KcEVonfkYPD9kM5mElBMm1PrNAct+FKhANgFxjVpkDgcRj
 ptLtzqg8QBk4J6RpEeq2+4oTWkzu/dJnujMq9NInqjkPG5CzurrB6zA29e8Zmk2SxFCU
 YZHKSDmk8l88L6asn+BX+AGT2lxd55gMzLBnx0Rg1yPkmMNxFQ582/1ZHp84edVDVJRN
 V+FOycdoZHimAT3L5G4MDQ4eLR+on9SO50RpqWVZXByIYbSXq9mRr6KbGfXhpLKdd6ty
 l6FcU+o+9FlL7e8V9rVDLTkuKwKDw0pKBd9vNmW+8JDu3vwmeRCggIl2oGLFdADnyRhw
 okjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238591; x=1774843391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjTWTO9LGKbNJnCdQR2t56GaqKq39XkGtlvuZ5fybUY=;
 b=Qt6A+ScLy9D+KN08IGx4uJkLo3uDoMxoH37BCthkPfWNInAJGqX5y0jhLyjm6TCf3w
 XLizLq9wLHxkwHiWoa3jrEOFtZDY9pt+ESuzvZ+wxGR22RMvRewZw9DBovzeBYzVl40O
 B4fu7J1ipy7OZAa+6/tvfa4vMn8jHR7Sropnn1MPIt1H96B0KYrcaF8yLUR93uv5KQhx
 JLgBlHGrnTrCjovNT2SpjGq9p0TMUS1UZTDOBg204Vb3Wy4yUOMSBMCSGy66o2yNCsEX
 +xGLWerGtSslVmkILH47Eet+7bGQFeb5U/7HfWS49m11A9ve/VCtj2Rex7/QDFe5RajG
 Ii4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkGU2uBfB+DtIy97kOCxNvHyrFy9uhKa4M3EKbMMnZ0fK9blSGdXgO0r/W4UElcmQKxozIdeN1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1c8Yhrcg9HpCGnFu/Takg03fG67q0ONfr7AlMs+BSP+nH+p57
 FI4pVg/fVyleUYzAWqMGWXxCp515IvqoEuCuA16Ab7eyUvqbFJlmv6shqxHBvt0S6IEVigvJh7D
 KyQkJ8RSJaYDksJDHTtpX6lmtCSEMTKP03alXdcrFe0ujXJLzjQg/GhbPJW+Ogdzlnf+M
X-Gm-Gg: ATEYQzxiMruVPVkk2VzZpW3ovnuIEO4Ds21kdO1yGAobycicGCnLzrMe1gRnkMlCD9C
 Q0vL61ps/5whBLwoQaCucgmEWpQU4SewvuRPuzfHRdq6CkiqZRK0SAIcYOD9NEpbbp2ToM3ulJo
 dNHyqkU2NASLsxt+c6pJPvbOKBN/ODQKNU9Nv542U+vRcnohS5XYxMLcd3oD2H0AN7RZJ0KHOm7
 hbAsZyhhJsXIx0mMA+VBcvmZisQeuO77Aa02nISUhvCBriVObEzNpkXh/hfiW8qz1CkVU7V4Pdc
 2tYSloss8vFA61AZwWgbe5NuCaX5waIMvfIf2Wtk4q0CizDTFoXqyeihZVAUm/e1fvMwLIJ2ufb
 8EE0DBXZVpjPIKwPu8SDYreve3n2iqcU2ksqUo2wxfZcUloxnE6TgJjCwizq6Ir4xBvjQq3YgL1
 KbAhTPPivM/0NABtFGctoEjng4qTr3pM679tE=
X-Received: by 2002:a05:622a:7c0f:b0:509:3c8c:2405 with SMTP id
 d75a77b69052e-50b3744f6a9mr130275961cf.28.1774238591439; 
 Sun, 22 Mar 2026 21:03:11 -0700 (PDT)
X-Received: by 2002:a05:622a:7c0f:b0:509:3c8c:2405 with SMTP id
 d75a77b69052e-50b3744f6a9mr130275571cf.28.1774238590919; 
 Sun, 22 Mar 2026 21:03:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2853055bbsm2240569e87.60.2026.03.22.21.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:03:08 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:03:06 +0200
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
Subject: Re: [PATCH v3 07/14] drm/bridge: cadence: Convert to
 drm_output_color_format
Message-ID: <h5giabamrwbtuumue52iu45d2jiybcwbbw3r53modge2pfe5k4@ijprwzi2qx4f>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-7-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-7-f3935f6db579@kernel.org>
X-Proofpoint-ORIG-GUID: JBfo3-7VbFam3G1oz_yQH44cuXgaAKvk
X-Authority-Analysis: v=2.4 cv=ZPDaWH7b c=1 sm=1 tr=0 ts=69c0bb80 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=CFmvC39ClzzmkW9Sp_QA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyNyBTYWx0ZWRfX5PpzZPJ+i4P+
 M2OuvxUkioSOIaHFJ85Hg1VDizyHQT7RcEUXMJmU0pVwcnEm4U0//xVUw+mcqNqH5/pyvX88z7T
 Dpr1SQgmZDmMA9Uh9ZQEIKLlPdfwByL0t+kJ8rACcntHTJkF6SZ6uX11/UtTrkzsSxbwgQ6i8Pl
 kcJinIQJEnsdHgWPMOq2gFOfPv9ifuPLbJEGvp7ENLS3UfDxhI4QQ4/arnF9W6q1oW9BDRPkx1G
 tR7q8rdm/3YcpN2k5EUd066QyzljmTDwtDgnP5vIdnxMUs1tNY325mIRWexe/aCWXjkJnoZM+pJ
 9Rtw6BxdQOXB21lKc+T0C6voWVeR3efCB53bfMqHb2oRKYcuZDUTeBSsADWn0CVNA8P4zaohkvR
 lf7BaCcPWXqPn+L8aPSvbWmSde+neqUfeXTiCU3P9XD+wdJXzoiyenJVK+tdqdi5g7yH4IED8SH
 AXsWLtzeWn4n58NDX6Q==
X-Proofpoint-GUID: JBfo3-7VbFam3G1oz_yQH44cuXgaAKvk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230027
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

On Thu, Mar 05, 2026 at 10:04:59AM +0100, Maxime Ripard wrote:
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
>  .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    | 24 +++++++++++-----------
>  .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.h    |  2 +-
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
>  	switch (fmt->color_format) {
> -	case DRM_COLOR_FORMAT_RGB444:
> -	case DRM_COLOR_FORMAT_YCBCR444:
> +	case DRM_OUTPUT_COLOR_FORMAT_RGB444:
> +	case DRM_OUTPUT_COLOR_FORMAT_YCBCR444:
>  		bpp = fmt->bpc * 3;
>  		break;
> -	case DRM_COLOR_FORMAT_YCBCR422:
> +	case DRM_OUTPUT_COLOR_FORMAT_YCBCR422:
>  		bpp = fmt->bpc * 2;
>  		break;
> -	case DRM_COLOR_FORMAT_YCBCR420:
> +	case DRM_OUTPUT_COLOR_FORMAT_YCBCR420:

Nit: where are those values being set? I see only the RGB444 being set
in the probe function.

>  		bpp = fmt->bpc * 3 / 2;
>  		break;
>  	default:
>  		bpp = fmt->bpc * 3;
>  		WARN_ON(1);
> @@ -2479,11 +2479,11 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>  	mhdp->link.rate = mhdp->host.link_rate;
>  	mhdp->link.num_lanes = mhdp->host.lanes_cnt;
>  
>  	/* The only currently supported format */
>  	mhdp->display_fmt.y_only = false;
> -	mhdp->display_fmt.color_format = DRM_COLOR_FORMAT_RGB444;
> +	mhdp->display_fmt.color_format = DRM_OUTPUT_COLOR_FORMAT_RGB444;
>  	mhdp->display_fmt.bpc = 8;
>  
>  	mhdp->bridge.of_node = pdev->dev.of_node;
>  	mhdp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
>  			   DRM_BRIDGE_OP_HPD;

-- 
With best wishes
Dmitry
