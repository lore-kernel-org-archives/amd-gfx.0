Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED98ED58CBE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672DF10E3BA;
	Mon, 23 Mar 2026 04:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i7kecrEV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eh7JdEO0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC5310E3BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:10:29 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MAjW6C4045054
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=sQGEJXGCGP1VT5nokRdn3QZg
 aBAAwrlU3lx1pdI7M98=; b=i7kecrEVBLxO1WNf+l5nmTc2n+Uzo/nysllO0FnQ
 hbeqyVQsO9lmxoRPFiatAESTJXCA8eVSpw5OfaSJbcdhkTF/N1TPrtV/f/q0FEYl
 VlWbN2Ms4pzCJGQp0A4A0hnIfUhYvgig+FROqZ3fKWWu8EjxjsKBg7+fzAaBis03
 GEkWpvszzEevqzO8lVdYQMInB4zOdGLjJgW7M8nsg0VsQnzLtoIKQz9qNccJz67X
 9j0TO8uUebepnxQM4MMlABNs6ApY1DEps+N15UmcVqtj2IaOXoHw/MG8hWlNRAfT
 vOekq4oJi59jpYJwBZnCYkszmNMG9AtJDnL5BsKdqUB9yw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1kq5un6a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:10:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b5f675be9so69248841cf.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Mar 2026 21:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774239028; x=1774843828;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sQGEJXGCGP1VT5nokRdn3QZgaBAAwrlU3lx1pdI7M98=;
 b=eh7JdEO0KPPJWhZprpOjyrooia8zk7Vq+hghFXYU+CBPDG99Wxu+xse77iA6e1nmrW
 vyrF3N8txNb/zMHFCUGHXO7qvKV6pDMIZ4yKlq1rvQMVfGYOF9tJo31IC8iWgs9rvkT5
 TSouGhda72d5Y5wbklc9mPxq5q829PjX4erHKgF+G3QrunjpokdMzlUmzkRtA2Et0RIq
 P0j6c3F8C/x6nWQtXA2z6dQmzAPZDnL0+cmpAkN8NROrMKtkVyqcuKz5R62wYPU9gTAp
 eguVv24/CVlnVh3epu8vI+ZVKMRXRrF1356FNMh4orNGHTK3/kmAopT0FH95vg0rMrez
 HTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774239028; x=1774843828;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQGEJXGCGP1VT5nokRdn3QZgaBAAwrlU3lx1pdI7M98=;
 b=qNpM6Uw861cUJaX2MwQM6arY97kSJrWvtIZ5BpLL425wwPMgk2f28qXdMy1Lp5+se6
 plPhQRJfGJICL42qSYjIoDzRVlkIv8kX1sX6QmmxQI7Dxa0mFQ+sHs9OudfMoDK3Tb7S
 6JwYI1zGlSRIYM1Al+iV9KQJwjAIQYiG0KYqiPJW1RZMPqYNASMbJhEoKRf8Pk5a2+2H
 j3XLPRJbCrWOxo8Q7Pr2R3K0ZKoBY9jDzqMhbe9i18eso3aSjLhDClTkj1hdfNnrfgXX
 pxpVahiO7gm+qX8bseM3wpUeiA8QxlhT42PN0MJ1lpPF/M9krI47c3zmVo0Ie7nOeWSe
 wwig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLvE9b3OkZrVeeIX8JgUfjzbfjQ0aCEOHEADkQ4IDRECursMW7jKV40q1mAMM39URQcvinNS2S@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGICMzS/9uexjq10vKry6qfzWyFNZNYn7WqowIOQoIovyZUC2J
 dcu7VArd+HUn5dK8haoFQ9SZnfM0/G+/kgxadqJjgAR3HLIaYvyoO7GJQD4zjp5vfEUnelkr1XN
 zKpkklsSNJmGzZDp7zcjzX5TTL4p9N4gvza6bKrcd2JOEzdO0A1y7qrLSwH0mC8dr/m0u
X-Gm-Gg: ATEYQzxXxD/lx5Xfe1szoR3TnJ2MWZZV5iKtSx4Xw3Z/b6DQ9yM9J35k9LJic1TwRPW
 LGRe23J3TNGLzpVI8o5Kv01NZ/yApHXhUAW10RcUvcBTV8A3twJ3Og9lGUu6rAxBB1yxt947QNs
 bGinrWdx+MbMdlHf3P9pCj1h4vgkwKix+BU9C6EqsZuJ0whVYsh+PhdE5rJCORwMIcMbenFmUds
 kwV5QG6ZvlCSm/gefekomWCXZMo/dDUhz5RzWpeVTiwNguM9DjJsLLLltps6ODQ3QuG+ruUfHpE
 Rf7EA/aTpiTuBearDl69V4lPSCtyJYkKgyLIcJYchtSnaSqjaKXYFxhPhimR6mvgUXhJ/Yc9Aqi
 PHDA1lZoeJufh08Y5J1nZNhzL5lAlDj6ufOyIQdhFDE386RcxTleS1+7Gj2R/BEpfeg2ooc2Ulp
 iVT64QOVErvd+sdHUuaGmRIHJ/0RXc2EEzhyQ=
X-Received: by 2002:a05:622a:4287:b0:509:f36:497d with SMTP id
 d75a77b69052e-50b374a7a76mr157306471cf.30.1774239027591; 
 Sun, 22 Mar 2026 21:10:27 -0700 (PDT)
X-Received: by 2002:a05:622a:4287:b0:509:f36:497d with SMTP id
 d75a77b69052e-50b374a7a76mr157306021cf.30.1774239027086; 
 Sun, 22 Mar 2026 21:10:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285192b44sm2215746e87.5.2026.03.22.21.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:10:25 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:10:24 +0200
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
Subject: Re: [PATCH v3 14/14] drm/display: hdmi: Use drm_output_color_format
 instead of hdmi_colorspace
Message-ID: <gcl34au4vrbew3gtr7z3ui5tpkiehiatiicrawe7ls7ulq5vk4@tecy3vwgihcr>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-14-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-14-f3935f6db579@kernel.org>
X-Authority-Analysis: v=2.4 cv=GNoF0+NK c=1 sm=1 tr=0 ts=69c0bd34 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PZBe32_PtwNt9AllZ3gA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOSBTYWx0ZWRfXwycYutA0/8cI
 d4Hj8UhSynExv9+VEOC9UHcY1idCp21KYIlYP3l21+kFv2wX8z6bWEVJ7nPNFG1eyF6WLU7nHOa
 yGE6RNkQXu74Ex8gBwRD0jinjMPwiSZnW7RLlKKui3Hs8Tb8aCc5jyu+E6HwnftuOmJTyf35zid
 4+LJQmxE6JXV8mY64rPF8elrmlM14I3nQPobE5X4Do7lrHSXRyUt9wg3czV5Yoj8TlcKDFAmTN7
 CobtJVbHFE2UxkHVksUrhOVIyA8bVQDt0XAL+JMYQGe+d7K7Jt997HhIBZspr13RAVYL8/4sGNu
 Hz/9RGFHz2ryHM+yQlxPGsj9ZSgfRxWedFUHpMqvRsg9VbyM8HsCFyM1Ewna21AmW9hUjUwvKpV
 uipeLBPijzRiaFzPkmF6ZFeA/ltCeD+VDJDhqqGVZKYKZ8wLe/8BKlON++z69I5cTU+Tu53a6NR
 +tPeZDzh4HqpkAaBRNg==
X-Proofpoint-ORIG-GUID: XBafLv1tbTm82r_TMYFAWrqv1co7y0_t
X-Proofpoint-GUID: XBafLv1tbTm82r_TMYFAWrqv1co7y0_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230029
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

On Thu, Mar 05, 2026 at 10:05:06AM +0100, Maxime Ripard wrote:
> The hdmi_colorspace enum was defined to represent the colorspace value
> of the HDMI infoframes. It was later used by some HDMI drivers to
> express the output format they should be setting up.
> 
> During the introduction of the HDMI helpers, it then was used to
> represent it in the drm_connector_hdmi_state structure.
> 
> However, it's always been somewhat redundant with the DRM_COLOR_FORMAT_*
> defines, and now with the drm_output_color_format enum. Let's
> consolidate around drm_output_color_format in drm_connector_hdmi_state
> to facilitate the current effort to provide a global output format
> selection mechanism.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/inno-hdmi.c                 |   6 +-
>  drivers/gpu/drm/bridge/ite-it6263.c                |   2 +-
>  drivers/gpu/drm/display/drm_bridge_connector.c     |   4 +-
>  drivers/gpu/drm/display/drm_hdmi_helper.c          |   7 +-
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  52 ++++--
>  drivers/gpu/drm/drm_bridge.c                       |   2 +-
>  drivers/gpu/drm/drm_connector.c                    |  16 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi_v2.c             |   8 +-
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |   2 +-
>  drivers/gpu/drm/tests/drm_connector_test.c         |  80 ++++-----
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 182 ++++++++++-----------
>  drivers/gpu/drm/vc4/vc4_hdmi.c                     |  18 +-
>  drivers/gpu/drm/vc4/vc4_hdmi.h                     |   2 +-
>  include/drm/bridge/dw_hdmi_qp.h                    |   2 +-
>  include/drm/display/drm_hdmi_helper.h              |   3 +-
>  include/drm/drm_bridge.h                           |   5 +-
>  include/drm/drm_connector.h                        |   9 +-
>  17 files changed, 213 insertions(+), 187 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
