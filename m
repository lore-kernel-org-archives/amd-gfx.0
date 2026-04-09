Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5E5F364C8
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 22:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC2110E07F;
	Thu,  9 Apr 2026 22:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jnoN8bWY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DDmVIgAR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0CBF10E025
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 22:08:30 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639JPkZK779530
 for <amd-gfx@lists.freedesktop.org>; Thu, 9 Apr 2026 22:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=iETKg8FvpT4ZN+EK0fX3kJUj
 6Q9RbW2hQbNGtGbKoyw=; b=jnoN8bWYgZLnSIlM+agOuqFEkJaoTNQBwruxepLZ
 ThL5Y01ObekZaA0ik9yYlMgYYok1DneaOIsODX+1ov3pqpt19CexpFckhLzF+Xcp
 6kQMQ7motvxmlXObMXN6JJweuoIzjrG9IZMNxoT2/FhHV9VqtpdNzzfpkLDrceIg
 emXARy/bk37u1Vd2ai/VJI9nXcX0c1izxsbVM8mPRlmg3J/Sc4SkXxAJldYep4K/
 UxsfAljXcztQ8+87yGt11vKYVO13PmDJGtCKvdLAU+g50esSDcF1o859QmL24bHp
 UFjWeBuoPw3ee/PtTaBP6mRQ5L2/jSMmmR2uAefYF3I/BA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dec8ht23s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Apr 2026 22:08:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d812c898cso39539221cf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Apr 2026 15:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775772509; x=1776377309;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iETKg8FvpT4ZN+EK0fX3kJUj6Q9RbW2hQbNGtGbKoyw=;
 b=DDmVIgAR6eXJcaqQ6lMjBW88RlsnAQrh9uDzrzettPVVhf21GDzEbC0QPz1n9AyNhV
 XOXHKK6lULkCf9AH599s5cXgEhO0oa9obopPrrSwc716iqfSo+MCBBLxQC1GJplJR4LF
 04OM4u0hhLA7Q2bDKb0s1IKHeaFfrCYbp/yWEmhpPGTXDiusdGP1r5trvebcAMIhJWqT
 41bnWCI29a6VKZkWJPgYdxIHBBGetfkoCMh7uSnapOYT9wyy8ueLsw7op0nMXPY7RT1u
 8nGjQ9sE44d4nDRomxJK8TmAdVBcay1NnNRU2xeC4+WmJpudjfFgZcH7RDg3f0H0ncrl
 MFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775772509; x=1776377309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iETKg8FvpT4ZN+EK0fX3kJUj6Q9RbW2hQbNGtGbKoyw=;
 b=C/0fm85IMxRKWehnWo24wha9d377CQMxszahIsmNTUwfYQvEOQalNQDcyHxxXUdsXb
 f7/kiFULAeLwPfLUkBHUb0BP5pKliizYvOMOaUk1Y5AaXXOzyyJfCdM46G8YPdZamhPE
 QPed3JJslWmw08oMPt5jgVqqUzyiEwfXfZVQsKGk1Qy1uFh5L4qjTm5emA2/oE3EouFe
 yU2tNijoXHAY9ICTSpBihmGK2LN1LY6xSicsDjh4rEVG3NeJHmbbdyPbatR58LwxU+NZ
 VPVGfNRbzUoAHQ9OsxwxwRVmK1OgNWWXPBEi3vxmQ0LV4nJ6Bxgmf4fsQQpZsKddSJaN
 G+nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSpXhCb9pWAHzTU+U3CPekNrnZbi4EsxF50pYLMYPH/CFoC7oyF5rFywhM1vMXZsa9FKJY3U73@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKt3Oa14JyImC3xMKNhNVHGiK/+79meoNGOUmByBEzjBUk5eX4
 nf5OaUKG50kf14i8eLFNo/L/ijtOedXtgQ106dgGganJVCJ1o2AwLRedbbdZSHolEHlGCAlWg0A
 G8xd6XigyekYgNhOu4m6bukzfpkHj2W/WPUGsF67txrTRSE4Av3rWY5PRVl6yLaJXaOnj
X-Gm-Gg: AeBDievFz9SRMAFdOtwTQ5Tciw3meBuPD9BHodeucKilypRxTunWOi9BISA1xkpIpDz
 88borNUngtoGF/OUnaurTKicfUXnRdlJuxzNf55ApV0zvmMr6XpIMlP9AOS54PuDHo4XtStDVu4
 9mmtojMF+FPfKE1qLL2UIkE6NkcpdR8p0tB02sNB+wzHOl5Vqli2D5YwR2tIlRm0rtPuLDEoOYP
 NcUiQFBiDLTbr7kbB7aVrekx0jMOWr95YOqJTa/FvsMOo6Xb06joKw0xkKc58lTa2e3HEyu6J4t
 e5qBFpvS1hVgQXi576kpXOIvCjGPioIzhhmMkdBCPkguH1r3SSPqjL7M416IAR9KxqLTm5dvmtN
 yP8CuggiZpcJ6Hi2elWRCQNLvuIo9z6utT9IwLw6kvEGwm+vsBLhGtl+dGtqf1wrKmJl73hZF3+
 C8Qz0ESIXqlXn0XQuzCrkggEddXzP1arZXgnY=
X-Received: by 2002:a05:622a:4a88:b0:50d:8cad:2381 with SMTP id
 d75a77b69052e-50dd5cae418mr15903401cf.54.1775772509209; 
 Thu, 09 Apr 2026 15:08:29 -0700 (PDT)
X-Received: by 2002:a05:622a:4a88:b0:50d:8cad:2381 with SMTP id
 d75a77b69052e-50dd5cae418mr15902681cf.54.1775772508751; 
 Thu, 09 Apr 2026 15:08:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49567101sm2221331fa.30.2026.04.09.15.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 15:08:27 -0700 (PDT)
Date: Fri, 10 Apr 2026 01:08:24 +0300
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
Subject: Re: [PATCH v12 04/25] drm/bridge: Act on the DRM color format property
Message-ID: <edeq6wxmwzvovfoo6pvih6dybwszf3tahg7nvqkjrw3qxllbfd@jwejh2sgb5eh>
References: <20260409-color-format-v12-0-ce84e1817a27@collabora.com>
 <20260409-color-format-v12-4-ce84e1817a27@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-color-format-v12-4-ce84e1817a27@collabora.com>
X-Authority-Analysis: v=2.4 cv=PMM/P/qC c=1 sm=1 tr=0 ts=69d8235e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=QX4gbG5DAAAA:8
 a=NxoPbATI1rPzGprmJi8A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: rvvQA3W3hOqMZaAL4nW8LhQDqKAr9_yM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwNCBTYWx0ZWRfX7c+evzABBerc
 3tX3mmeg3KZyu9ba8ern4w8rhQhSufDkWJrmJHdeTQYni3vxyfRZZVW3kOEsX/ZlOKtu7j+Cy5X
 R7Nk7vUhGIrMeBBQszgWJjZiOnWv6puyLeUHUkhZN56ZerraMySu3v3+Gj4O/kFa7Z82l+uvC1w
 KpNR7xybz2JP8yG/oVgrgqRDf65nOXpNcDmUGMGOCoFCefGrp42buCeVmcCFTSieUPLOMTTk2Rk
 oqHrvbkGhLS9D0C3SEryVpVQ+UpQy2iwxwjBHf8YQQDUTf57qRIMSqheg9udU9E6pFov1mkVeBA
 o3HAQaYh6LgfXtXMEALbyoMaQIuRIgqDJfGEPFLTQn2JTLlpjmVCq5GNNSDyxDmn1nlAYZQ5JmE
 IBXHMchxuiWDtV4qK8MfrF3cLvuCJMSv4uaAaVMPdNseDsCzjd8IkHgFYwCNvZcpcYxUdcHL6gC
 QROj0AZFIdGD5J16xNQ==
X-Proofpoint-GUID: rvvQA3W3hOqMZaAL4nW8LhQDqKAr9_yM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090204
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

On Thu, Apr 09, 2026 at 05:44:54PM +0200, Nicolas Frattaroli wrote:
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
> index ba80bebb5685..7c1516864d96 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1150,6 +1150,47 @@ static int select_bus_fmt_recursive(struct drm_bridge *first_bridge,
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
> @@ -1193,6 +1234,7 @@ drm_atomic_bridge_chain_select_bus_fmts(struct drm_bridge *bridge,
>  	struct drm_encoder *encoder = bridge->encoder;
>  	struct drm_bridge_state *last_bridge_state;
>  	unsigned int i, num_out_bus_fmts = 0;
> +	enum drm_connector_color_format fmt;
>  	u32 *out_bus_fmts;
>  	int ret = 0;
>  
> @@ -1234,13 +1276,58 @@ drm_atomic_bridge_chain_select_bus_fmts(struct drm_bridge *bridge,
>  			out_bus_fmts[0] = MEDIA_BUS_FMT_FIXED;
>  	}
>  
> +	/*
> +	 * On HDMI connectors, use the output format chosen by whatever does the
> +	 * HDMI logic. For everyone else, just trust that the bridge out_bus_fmts
> +	 * are sorted by preference for %DRM_CONNECTOR_COLOR_FORMAT_AUTO, as
> +	 * bus_format_is_color_fmt() always returns true for AUTO.
> +	 */
> +	if (last_bridge->type == DRM_MODE_CONNECTOR_HDMIA) {

I still think this is misplaced (and misidentified). Consider HDMI
bridge being routed to the DVI-D connector. The last bridge would have
different type, but the HDMI-specific logic must still be applied. The
bridge must use RGB444, but it must be handled in a generic way.

Or other way around, a DVI bridge being routed through the HDMI
connector (thinking about PandaBoard here). The combo should not go
through the HDMI-specific color format selection although the last
bridge in the chanin is the HDMI-A bridge.

I think all these cases should be handled by the connector, which knows
if there is an OP_HDMI bridge in the chain or not.

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
