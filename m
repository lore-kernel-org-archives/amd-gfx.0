Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53F1FD0058
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Mar 2026 16:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7621F10E3DF;
	Sun,  1 Mar 2026 16:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mBjnrffD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bJEuhTvG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA1C310E3DF
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Mar 2026 16:56:13 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61SLGcSB3604999
 for <amd-gfx@lists.freedesktop.org>; Sun, 1 Mar 2026 16:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bK9Rayioe0UgWRcACzhZoK7I
 9TYxOeFDSz/Gu0Nylic=; b=mBjnrffDDHvSCmAVgxFFuKtFmYIuk6135iS7R1sa
 d62AmumryokGk1gEDgvyDte2rkIz16lW88SVM+gS11Q4Q969cpNiKFz/FanyPAFJ
 ygPSXB4j3xoNMHKwnKlwL58ywMYPOFYmC253/4AgwN277sOnSw+ZaUwf0As4P5q/
 6cuGmkwIJMWnEumD8+ERFq+iS9AoA8bKJlnnFgLWJx9AfCwdBQrJHRP914lCmpPj
 J+MJCp0F8rdxZwoISkLcapOSOcjA4PONIlMFUAwG8humnOhcl6ADnctIzHZLVE5C
 QNv4ikVgM1coU7Ge7vQ2V/bjPT597E+erkxI3g9XSzHvOw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksgq317u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Mar 2026 16:56:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c70b6a5821so2658643085a.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Mar 2026 08:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772384172; x=1772988972;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bK9Rayioe0UgWRcACzhZoK7I9TYxOeFDSz/Gu0Nylic=;
 b=bJEuhTvG9AP4Dn6rCB1LFzhBhk4x488RmVg1ASp4N607FRO6Kyj7k4BeJPyanOccx/
 h3Y353Ee8bx9ohMYjwRd3u7CeWCfsquDAa5FfhWKcZxXy+N4QJpSwRmzT/2CyZhAA552
 ONHqEeUSPb4Uq2a1xeRTVHGo79nJI4atCUAV7F3toLl2KmW3WPKllFtj/6eMdbctkwAX
 8XwpupDLRfFb9C6+BWm0iApBKdz1FRzKKTmLuLihVxWpSEueJtzfxChQM2hZaNG3TUGx
 GlScbZlVKAkaHsYaOAV2DBiY6iPUrfJNgBqLJGSO9X+zzXq4PBHX7H2gPr7ot2q7WW7k
 NasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772384172; x=1772988972;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bK9Rayioe0UgWRcACzhZoK7I9TYxOeFDSz/Gu0Nylic=;
 b=jT7hKS70c7XorXtQ5CTNRmwBugNGbWzLFQjs6Hxus6PJ0VZbzSfOiMa524vamrXecB
 WEni0LqoGMAHUmdEzOc5ELS0MyV9kpZqd+RPXjh6WnJ+QzZ0azr42sI0l0uwDjyP7WSQ
 lMS6POcLUX5hMUz8EFcGfQ+CcdcMe5X+zZrsSqaX1v6dAthg7R3K2VfUcihcZAQWqSxs
 rmV/vjuk02WlNN1AQ8LsF6A1CvTazGEPvzwbwTTPQjsyrgkKuO3ygKnXQeJ+PBQH1Av9
 wsJAVUQuDqh2uvz4rmPPDdmHYBbjJ2chDSR6P2eTuFa6WwayQwIVRRV6i25uUPb0RWXb
 etTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1GQJjuj1SocPksqgZgVh59TjcPqZaMvtkk07CCzTFrJz5OkslDq+rPrwzaY+ltaAm9dYPRYIc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbwnDdUqVj7ex/z1yHjAiOAnUoQEWh2TQdaSCKuEVFzkIR9V9y
 I4kdpXtnmeLHkgDRsA99HEypqrtGIXXGV1wgL5LmcyahjfL53z39uT0pkKcd+dzyG5ETZT0JWmS
 b9J2RJNT/wA3Fxiir/UPvZgw+DayVH2D4Im99mzPAh3It5pDZIk5w364IwrVXZ1n+TLX7
X-Gm-Gg: ATEYQzwIcUMriLHSRABDQ2JrvOVMVxX4y0XMh8s0XTdl4VEwcUXbLCbUw88HTENVGvz
 NFDpBNnUKCIk5+c+sEiFp0iyWmFSqPKGzr/pwhHBbCvDsOWdhjMq/0gtQi3NOYArktLZHMvCB6T
 8+AelIl2gyWrMlGZkz3U2rs4xvElt0drIcQWbooBnOuBcmVJUfLDJqPShxpuX4uBVACyRqbu5iQ
 Z+l1Mn1xCybgYSsd9avIBuVC/QuiAfUPDp3r+66t5GBnlDCLBgamcgwzVf+gIx7ed0JRE2aEV29
 X2kROctCy34VL/+czNVbu653I7tut1ZwztTdtAhhAEXN8FhgdIGu413pC7Rm8rqD+yC/cG9C895
 rENDfNeSIlOKLLXLyoUmSxet2ZmyvzoKz+UovvJtOzFiayYX46zLXuUDL7Np6Ib6TZN5iuDvBIK
 ZuHaCr61HUsbriYg+02VGFfcElnhtBi2PINDI=
X-Received: by 2002:a05:620a:28c2:b0:8ca:3c67:890f with SMTP id
 af79cd13be357-8cbc8e1b535mr1288641585a.76.1772384172037; 
 Sun, 01 Mar 2026 08:56:12 -0800 (PST)
X-Received: by 2002:a05:620a:28c2:b0:8ca:3c67:890f with SMTP id
 af79cd13be357-8cbc8e1b535mr1288637485a.76.1772384171446; 
 Sun, 01 Mar 2026 08:56:11 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a116022215sm1093411e87.52.2026.03.01.08.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 08:56:10 -0800 (PST)
Date: Sun, 1 Mar 2026 18:56:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, kernel@collabora.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 03/19] drm/bridge: Act on the DRM color format property
Message-ID: <unfsi4t4t4wl74zudkq3oeiryvm2xgyiplugcaxhyvjmtn7s2l@72xhl5vrtyt3>
References: <20260227-color-format-v9-0-658c3b9db7ef@collabora.com>
 <20260227-color-format-v9-3-658c3b9db7ef@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-color-format-v9-3-658c3b9db7ef@collabora.com>
X-Proofpoint-GUID: MawQzC2WuwHhc2QCR30-_5Aq83Ei9IWD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDE1NSBTYWx0ZWRfX8urKQgnrMfKN
 ByPPSPaLuObbYHyOEanNR+tLKqSf1J0lnFk2nqjEwQFynX6VbglE1CG0sHbYpnxG0oMAf1dtUC5
 ce8Y+vTk/4q6u4zRMRPOc8YvBvGma/tgjFzjLzeJ6IekVzk0IF1YtFHPo267PYh+XhFpjNE0Pak
 N7X/lbKa3dBFsqyZtx2ojsR5svKZXK6CbAzgt4UtzPGAbmttn9T3UwQaVP0KUJI4g4kufJCrIAN
 XJlLPin49FKy4saegK0UkoOrKpEESCRu9Mql7+NSTNKWkPbdpygARwSzMx7psDKLqpwkgqJsMwq
 JFzost5gtWqHnJ3EMFyPR0nRpodnCcs2D/L979aHjruuWkshh+iym0nOjBvUaIuetKvXzag2AdO
 D0XnKdm7blzMBzJMmV0yQI3gFP0QGD7ezgL+3BzfpYfcLmuWE1+31ckqqMWQaGkcvvwhdyw8eAn
 r4ZVQZuyBYtgfT68Kcw==
X-Authority-Analysis: v=2.4 cv=bdRmkePB c=1 sm=1 tr=0 ts=69a46fad cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=QX4gbG5DAAAA:8
 a=yKAVQKaA_AwziBLyn1oA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: MawQzC2WuwHhc2QCR30-_5Aq83Ei9IWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603010155
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

On Fri, Feb 27, 2026 at 08:20:08PM +0100, Nicolas Frattaroli wrote:
> The new DRM color format property allows userspace to request a specific
> color format on a connector. In turn, this fills the connector state's
> color_format member to switch color formats.
> 
> Make drm_bridges consider the color_format set in the connector state
> during the atomic bridge check. For bridges that represent HDMI bridges,
> rely on whatever format the HDMI logic set. Reject any output bus
> formats that do not correspond to the requested color format.
> 
> Non-HDMI last bridges with DRM_CONNECTOR_COLOR_FORMAT_AUTO set will end
> up choosing the first output format that functions to make a whole
> recursive bridge chain format selection succeed.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 89 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 6d8947419940..5938fba0a983 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1117,6 +1117,47 @@ static int select_bus_fmt_recursive(struct drm_bridge *first_bridge,
>  	return ret;
>  }
>  
> +static bool __pure bus_format_is_color_fmt(u32 bus_fmt, enum drm_connector_color_format fmt)
> +{
> +	if (fmt == DRM_CONNECTOR_COLOR_FORMAT_AUTO)
> +		return true;
> +
> +	switch (bus_fmt) {
> +	case MEDIA_BUS_FMT_FIXED:
> +		return true;
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +	case MEDIA_BUS_FMT_RGB101010_1X30:
> +	case MEDIA_BUS_FMT_RGB121212_1X36:
> +	case MEDIA_BUS_FMT_RGB161616_1X48:
> +		return fmt == DRM_CONNECTOR_COLOR_FORMAT_RGB444;
> +	case MEDIA_BUS_FMT_YUV8_1X24:
> +	case MEDIA_BUS_FMT_YUV10_1X30:
> +	case MEDIA_BUS_FMT_YUV12_1X36:
> +	case MEDIA_BUS_FMT_YUV16_1X48:
> +		return fmt == DRM_CONNECTOR_COLOR_FORMAT_YCBCR444;
> +	case MEDIA_BUS_FMT_UYVY8_1X16:
> +	case MEDIA_BUS_FMT_VYUY8_1X16:
> +	case MEDIA_BUS_FMT_YUYV8_1X16:
> +	case MEDIA_BUS_FMT_YVYU8_1X16:
> +	case MEDIA_BUS_FMT_UYVY10_1X20:
> +	case MEDIA_BUS_FMT_YUYV10_1X20:
> +	case MEDIA_BUS_FMT_VYUY10_1X20:
> +	case MEDIA_BUS_FMT_YVYU10_1X20:
> +	case MEDIA_BUS_FMT_UYVY12_1X24:
> +	case MEDIA_BUS_FMT_VYUY12_1X24:
> +	case MEDIA_BUS_FMT_YUYV12_1X24:
> +	case MEDIA_BUS_FMT_YVYU12_1X24:
> +		return fmt == DRM_CONNECTOR_COLOR_FORMAT_YCBCR422;
> +	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
> +	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
> +	case MEDIA_BUS_FMT_UYYVYY12_0_5X36:
> +	case MEDIA_BUS_FMT_UYYVYY16_0_5X48:
> +		return fmt == DRM_CONNECTOR_COLOR_FORMAT_YCBCR420;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /*
>   * This function is called by &drm_atomic_bridge_chain_check() just before
>   * calling &drm_bridge_funcs.atomic_check() on all elements of the chain.
> @@ -1160,6 +1201,7 @@ drm_atomic_bridge_chain_select_bus_fmts(struct drm_bridge *bridge,
>  	struct drm_encoder *encoder = bridge->encoder;
>  	struct drm_bridge_state *last_bridge_state;
>  	unsigned int i, num_out_bus_fmts = 0;
> +	enum drm_connector_color_format fmt;
>  	u32 *out_bus_fmts;
>  	int ret = 0;
>  
> @@ -1201,13 +1243,58 @@ drm_atomic_bridge_chain_select_bus_fmts(struct drm_bridge *bridge,
>  			out_bus_fmts[0] = MEDIA_BUS_FMT_FIXED;
>  	}
>  
> +	/*
> +	 * On HDMI connectors, use the output format chosen by whatever does the
> +	 * HDMI logic. For everyone else, just trust that the bridge out_bus_fmts
> +	 * are sorted by preference for %DRM_CONNECTOR_COLOR_FORMAT_AUTO, as
> +	 * bus_format_is_color_fmt() always returns true for AUTO.
> +	 */
> +	if (last_bridge->ops & DRM_BRIDGE_OP_HDMI) {

This will break the logic if there is anything after the HDMI bridge.
For example, if the board has hdmi-connector (yep, it's a bridge without
DRM_BRIDGE_OP_HDMI, because HDMI connectors don't implement any of the
HDMI functionality), then the function will go to the second clause.

This probably needs to be moved to drm_bridge_connector. There is is
natural to check for bridge_connector->bridge_hdmi.

> +		drm_dbg_kms(last_bridge->dev,
> +			    "HDMI bridge requests format %s\n",
> +			    drm_hdmi_connector_get_output_format_name(
> +				    conn_state->hdmi.output_format));
> +		switch (conn_state->hdmi.output_format) {
> +		case DRM_OUTPUT_COLOR_FORMAT_RGB444:
> +			fmt = DRM_CONNECTOR_COLOR_FORMAT_RGB444;
> +			break;
> +		case DRM_OUTPUT_COLOR_FORMAT_YCBCR444:
> +			fmt = DRM_CONNECTOR_COLOR_FORMAT_YCBCR444;
> +			break;
> +		case DRM_OUTPUT_COLOR_FORMAT_YCBCR422:
> +			fmt = DRM_CONNECTOR_COLOR_FORMAT_YCBCR422;
> +			break;
> +		case DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
> +			fmt = DRM_CONNECTOR_COLOR_FORMAT_YCBCR420;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto out_free_bus_fmts;
> +		}
> +	} else {
> +		fmt = conn_state->color_format;
> +		drm_dbg_kms(last_bridge->dev, "Non-HDMI bridge requests format %d\n", fmt);
> +	}
> +
>  	for (i = 0; i < num_out_bus_fmts; i++) {
> +		if (!bus_format_is_color_fmt(out_bus_fmts[i], fmt)) {
> +			drm_dbg_kms(last_bridge->dev,
> +				    "Skipping bus format 0x%04x as it doesn't match format %d\n",
> +				    out_bus_fmts[i], fmt);
> +			ret = -ENOTSUPP;
> +			continue;
> +		}
>  		ret = select_bus_fmt_recursive(bridge, last_bridge, crtc_state,
>  					       conn_state, out_bus_fmts[i]);
> -		if (ret != -ENOTSUPP)
> +		if (ret != -ENOTSUPP) {
> +			drm_dbg_kms(last_bridge->dev,
> +				    "Found bridge chain ending with bus format 0x%04x\n",
> +				    out_bus_fmts[i]);
>  			break;
> +		}
>  	}
>  
> +out_free_bus_fmts:
>  	kfree(out_bus_fmts);
>  
>  	return ret;
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
