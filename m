Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE78D58CCE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039F810E395;
	Mon, 23 Mar 2026 04:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YwKTM3sZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X2RAcwbr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C446510E395
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:45 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62ML94Q23294366
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BxISgP/fl36GplI+JqnlrwsE
 hA6Bu39iBYyi3QEp08k=; b=YwKTM3sZOJdgT3TAFMPt9LNyf5/D4M6suM8CSNMz
 BYaBOWI6dfGkap/oTUuKXyHdTV76LQO+9/j0vAZQ0jswoAyN+MEvvvLrMyl0BQ34
 rnzQUQ8L9DpbxmTPRdcUV/2nWH5zyvxSxuM9D/36mwIzddifH1wH3axnG8ak2HiZ
 1hagwh+eOOrVVoWluYEbH9ssQiyUwKI2Y4YQ7gjbNiieW1uFcgjBv2EKwnC8zZIC
 NWDuxi4fdO4w/70RMll+U0fRHhJrl3n+AwdViEiCZjbssrUd2kLXTXBxf//VrTXY
 1Nlif3WY1gBVNQgZnuiCrQznq6IuNnSYjdYCxjR8ySPuCw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d2ca8hkj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5090bc4823cso68114341cf.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Mar 2026 21:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238864; x=1774843664;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BxISgP/fl36GplI+JqnlrwsEhA6Bu39iBYyi3QEp08k=;
 b=X2RAcwbrDdjyar+LGObakTMDAaPl+XEn7KdQxasPnaN8GPNnjhyQHpwXkumHdlwZfs
 H0o72qNGC0OyUeragYoTvwf2gVwSRwQXgP1mqtBoBEzoW6t3zINcbE/BD27q9VF769+w
 dQ74yYMFipq8fZ7ZcBj2/VrCnfYyYkPoPouJ+qxLGbma6PfHoxkGgJCp3XUMX5DzHO+n
 TGrcf6py7oVldp7//NODLtoMC8L71Qm6GdeWkucfBQQaVpv5FcbHxgLG5zRLAxcfWZCm
 t/snkErZu86x5K2iAWdi1q40ENPZiFJmHN6BLDNGfxErof+/PFyoXANrh5wsEEUhkc6f
 A4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238864; x=1774843664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BxISgP/fl36GplI+JqnlrwsEhA6Bu39iBYyi3QEp08k=;
 b=G3A9YJkO2bbmar95I3+QDmQgWGsRw6MZfIfRFN24YWPWWFN4lKupgirhdZ7VzLMfMl
 wZg6Q32SeEVq8bSQ8N6a/9Rqn1wzdDfaJmGUZO4lxVrE6Cou3E4+rHTdyu2SK0/SFHad
 8wAgO1v2/o3ghOo+nQHa9Rmivv6X5rFN1mIeHceKfSFwOE7KkSyvc0B1IoAIQ8n1rQyT
 tjFNn78WPTOSzD0NpJ7L9otKsK91YpTAh2uvu1oP8dTTvK8WIPfigc9T5G72D24zglCT
 LV8Otjep2fUGhFCLZyaDEIS8pHfuCQSIowmJs36NfD1XcQl2+4nYho1PD0gwBCx82M1T
 +yDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyb0Glj0ST7w/WSBi794V5hga+hwUKQ0qtu1FcBrMTt8YqtJp4wTE9BxmQgCcbNGXgsUnFJzco@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+BtUE+1ClQBKqBWesSGCZe/P/EbYzzt5qDqbZrGMnY4dbw/DF
 r1aPZDd6y08X/h3Y+4Yp6YUjTnup+6EvVYl+DUJbjM8mgzr6rmdu1UWELHxLwIei9SKxuHjs6IG
 HpU2H9LietLf6TgkxZuTbtQ5ASoVpIH95xK6rCojjycd7ABvwmuoWMpffj9dVIQDHkW8S
X-Gm-Gg: ATEYQzz0EcwytilR4E9/ldekERtM7zo+yS8jT2s9MRWny1dI/xXZv6eG8EsD9s6U3G7
 8m1wrdM8fbw7TeLOeohqVSYlVNb6MrXwgQcXFUz7M7WyjbNG7GdOAhqbUR4VQBgfq1GMjLEGyk0
 /aOSMoSH1AH3C2Ljxjy8elw8tzDycwZfmz5NABidbjCUmJ+00KJCa8QYocBw73pnOdYG//4J0US
 iUAJaqZq+vEg49ZaEPcaZGimKNPIZYuqr4VQUPNov3eGVjojh/bd9vMvWijBtguNZhlc4fU8n5p
 1IWCOJp+TLnAAiLcc3sgpjzeQnHr4W0OvuAiBizMPS6DhpcwE9Sh8Of+r8WH8STI1Uh0TLQAu1l
 vqG1YS47EJLmnmP0BVPRNgm4zw58clVk8ijxk4p8LXW+2cnyW+CKpWEGyEWK2olnMCUJ2rfJlwL
 mnqEqq582hQyHT7YvBcuCDQEXFB2HLE/tcR50=
X-Received: by 2002:ac8:7f0c:0:b0:50b:48e3:47a7 with SMTP id
 d75a77b69052e-50b48e34b2amr101887021cf.18.1774238864365; 
 Sun, 22 Mar 2026 21:07:44 -0700 (PDT)
X-Received: by 2002:ac8:7f0c:0:b0:50b:48e3:47a7 with SMTP id
 d75a77b69052e-50b48e34b2amr101886631cf.18.1774238863896; 
 Sun, 22 Mar 2026 21:07:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285206f73sm2204203e87.54.2026.03.22.21.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:07:42 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:07:39 +0200
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
Subject: Re: [PATCH v3 03/14] drm/display: hdmi: Convert to
 drm_output_color_format
Message-ID: <7duzhocpjyhpvoiw4xy2wlxmrld3sj74rqhozbnlpv2magmbta@c4rlwitio7p6>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-3-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-3-f3935f6db579@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOCBTYWx0ZWRfX14qPvEwWuwOD
 JaNYju5PuxIPiqDKPk24d+rcZJ/5Zi0NgFVpMuf7NcpDsP0xc8wZrPhPZ1ILpN6X3TVICNTiNa9
 TAgjAC0xl0062SfnM0MpUbypqDw7U1YZWuVGiKe5AnCWnC7XPoWkCMdK6kdWRh+M/qyrjZzVUat
 T0NcF5H/R6QIzxdaEY2SV0+Yq3AZ9LRvC4qoaBHbzqXzDBt0+Jx297TBQ7lcSXXziNpkT11ILeG
 qpdM4C5vfLyOQkb+65YeyKWX/1k3A40Z0Ovr4HyUcFXxwkwGDx2N4fSdHeS1HI0DN5sajgjOdJH
 8++NDozcXLlhdUGcpIAILaBQZlhlFbyAcf8zV0gTFnhAbqiB2RPM0NDDJFbwmEaVB9htUfQRTVd
 z8v9myjFemn8f5ZqH3rJ3b3CPrGTSAh2kVYdXdrBMO/9GqSh7cSMJ45ouOXMMQr2g6X0wZfw0AD
 l4Feapn7ZBYgAk0Gi0g==
X-Authority-Analysis: v=2.4 cv=cf3fb3DM c=1 sm=1 tr=0 ts=69c0bc91 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=f-rPyQLBH6VTMeScU9cA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: XawVldJtKZfPW4qpPzpg9-IrqItOu48t
X-Proofpoint-GUID: XawVldJtKZfPW4qpPzpg9-IrqItOu48t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230028
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

On Thu, Mar 05, 2026 at 10:04:55AM +0100, Maxime Ripard wrote:
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
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
