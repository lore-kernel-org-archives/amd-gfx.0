Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BD0FD0058
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Mar 2026 16:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E728F10E3D5;
	Sun,  1 Mar 2026 16:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9k43y29";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U0J88eFO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1EA10E32B
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Mar 2026 16:47:52 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 621Fue8g2176071
 for <amd-gfx@lists.freedesktop.org>; Sun, 1 Mar 2026 16:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=23yFjRakNDMv9z7eHrnsMfwG
 zCe1oBIgBUxRG3B4w9c=; b=j9k43y29AY/jcOBaZs4hjILMyf4NJhXj35Ds8fPf
 WOCMUgc83CYIceqbax3lqKhzX79Ko+iYQC1kKbPZDfsyqOkPtQI1g5VEsX7Lu/qL
 AxtlMsFmktCzVSbsiJI69w0rNrE7ejK0npefurmC+7ixrdHK1PUZe8EUs5aAClT2
 0dCCX8KR5It6Pr5VJ5vpuJH+eFms1e653wLTIIoz6kdz/S1wGb/5T+JN6GgqOTHL
 S+SDKd8+NufyC2a2lQuyvzgeT7eO/Frd6HF6ueEq71KVMYEsRIOilY3LgMv7z3FW
 WkVeV3lPmX4qJcZAkupTCrsicOZk0I+o6inqX9bWQ9NUlw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckshd31c6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Mar 2026 16:47:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb3d11b913so3144885885a.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Mar 2026 08:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772383671; x=1772988471;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=23yFjRakNDMv9z7eHrnsMfwGzCe1oBIgBUxRG3B4w9c=;
 b=U0J88eFOqs2NSSV/+ivaYNcqJkyO8OLP99X4QrpTQ28pbgb1EYGL45q7vpZyNIxZsv
 RvwA4ZrLlPFJ5/ks6oywSts6FfdROKT5W810Dn9hM41pko1Zq+0Il6j45PmqSNKzsN4B
 NvOlirmgbtJGcNzl7zWDd7MMbYnJjE0T5NSCAjhQKoZRsbeXpJWLbjsksQYBntNsXUH6
 AgWJ0cVBBb+Txu3A84C+s+LZPUz4zHy3tx2aiw3YSBULMQiZbuP5Pz+cxQwPR75KgLdj
 XIDsWISNTJ/zbHT6g3+2N0VXkcVaHLyq0/L8Hr0P4D5eobAKgfyx9lpwDf6u5wPqx+Jv
 14nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772383671; x=1772988471;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23yFjRakNDMv9z7eHrnsMfwGzCe1oBIgBUxRG3B4w9c=;
 b=jvz7rkx4hdq1HNNZcOfbSPWR6AF0RHG1JvFaok0/qO8y67DH9K1NNtOx5g+W4wi88a
 e+4OxIOP0JQ2kjgAmH025kDnPTpyhG6Jil+KucpWMVa+VwPZuSiOYMLT0MYGEZ7jJBNq
 oZQoxmhAFPGqG3AZXsIGKUBP1UP0Zr4eZ+BPAu6NW67/vSciJl6aMxHCSOIrsu8MH8pJ
 e6ahe8jhFo1dLLTVgAv48JmHDVqGeyimh3pobiMwB/HquSSMrxO+6NTLAXRispGXSh85
 DvtCmSIuqPwFCAvd2oXe/HhLMg+BeB6dnhJJ9Xy3qhf9q2UsZRbo/9yOEhkJakjAcbRt
 5spQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU/UZvx3Z2xPI0oJRWTbHlX/s7bnKclVL+9VO0unW34d5D+qMoRRxBDOR/mO6ng84pkD+zYbdW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNoGjYejS2u9eCU3Mn/7IHMMINHmIaH9ulof81jzQkzH8hWDNQ
 AQ9rGNKZauBGWNEEEtrGjnk8PAqmar93x7N4HQF1CxaRvLWzq+157VasQ9fWNlOEyOMIdOMOUh5
 N/iLWEWy73AMU34z2QoXTy36TzIeGpqUkOHH3H8u7PKpiqjklr0wftTS+9v1t2PpMU9qx
X-Gm-Gg: ATEYQzxwlckM/TpvysS2fIw/NFi8IFH9N9aB5oroFJjo2JQ1GICSg7XH0SW8ZCdahmv
 JlV+3fG9iQFaKAiuvbjfIGeHrV8YU2qILhi45LCqXJ8Cvujt0RimQJXVOk4HO4vxRXitN/dH7sg
 jyYB4fDK6d0MNEJ8Mw5/0f7vylITcnnc5EyOcJzS9Xg4Mh78A756tZr6YwnvomIFxnkuBXuYY23
 bv8m2FHPZ9eaIqm3unR3A6OU/11KoVY9ODf2zh7GjLuubs3A1yseQBRh3eBsS1ZQrln69Rlkcxm
 uQM7ud/yOfCyUUbVu3vv/EGqdxdDGgiIlURsriDIiQhEiLB3vDR8jdvNpf1qqfdilqlsRInKKc0
 VtUQeVCphVN8ES1h02ZZOczRM4cZGFHS8sFyqpaEAsC+RBhcsvnJq2JYx7wK1Nc0IfwdaAhIc9o
 Ouv6JxjWGO7V5rh8Rh88TFh+BI9pD3R1f4gH8=
X-Received: by 2002:a05:620a:4801:b0:8cb:4066:7acc with SMTP id
 af79cd13be357-8cbc8e4b74fmr1215343485a.50.1772383671060; 
 Sun, 01 Mar 2026 08:47:51 -0800 (PST)
X-Received: by 2002:a05:620a:4801:b0:8cb:4066:7acc with SMTP id
 af79cd13be357-8cbc8e4b74fmr1215338985a.50.1772383670575; 
 Sun, 01 Mar 2026 08:47:50 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a115bca083sm1146993e87.31.2026.03.01.08.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 08:47:49 -0800 (PST)
Date: Sun, 1 Mar 2026 18:47:48 +0200
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
 intel-xe@lists.freedesktop.org, linux-doc@vger.kernel.org,
 Andri Yngvason <andri@yngvason.is>,
 Werner Sembach <wse@tuxedocomputers.com>,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v9 02/19] drm: Add new general DRM property "color format"
Message-ID: <y5ybjitphwydvtcjdtrmpcx7t7hwevjszpktcnmyvjqkgzinmu@hoitkl7lghxh>
References: <20260227-color-format-v9-0-658c3b9db7ef@collabora.com>
 <20260227-color-format-v9-2-658c3b9db7ef@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-color-format-v9-2-658c3b9db7ef@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDE1MyBTYWx0ZWRfX3bsXAh+zY/Nz
 RUNtLFRLIW3NgGvlLUCNmp/i3xMuD0D79U8MSVU1n5pbjneFMq4spXwYNyrxIIGuSUEdcixJCY6
 /oPIt86I0Lx5mbH/ysIWnM/BMI+aBK2LNnnTGgt9Xvgh5xlCT7lE8vhHDO3E7655wa8dVzcEPtH
 JAQW5h29kRkqWATG5kUAKuxmSWo7puSMM4cFO7SCUueugsJBfPZE9F85As+ty9fKTEaFMiYBm1z
 MyPikb5jEcPytHgdMrStHBxIQU7mHn/oN2bmiCGI6FLdTX0dCjTJHACKBvlr9XnYZKXN7omthgM
 3p9GfigU6uR/aEvxe4GXqFl4XZzPsmUmhZY2yFzxwdWDuIxXUscCLJARTgoGz6jppgFpaJ1QiuY
 5W9hn+qvMNve6gAmV/asBHIfJTFyM8COAhqGTj1HyR+qpcu8AqUmBOETnxDVsR9GJsIpH2L/SAQ
 ixj/n0Pf+6ZKTi4Wm4A==
X-Proofpoint-ORIG-GUID: 2Bbf5pOiybppsXop-6cQbQsssQOIijlE
X-Proofpoint-GUID: 2Bbf5pOiybppsXop-6cQbQsssQOIijlE
X-Authority-Analysis: v=2.4 cv=COYnnBrD c=1 sm=1 tr=0 ts=69a46db8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=yDUiu3_GAAAA:8
 a=QX4gbG5DAAAA:8 a=bDwM_fcg3tGIVG_HqXcA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=gafEeHOdjwYkg5oUpzAY:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603010153
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

On Fri, Feb 27, 2026 at 08:20:07PM +0100, Nicolas Frattaroli wrote:
> From: Andri Yngvason <andri@yngvason.is>
> 
> Add a new general DRM property named "color format" which can be used by
> userspace to request the display driver to output a particular color
> format.
> 
> Possible options are:
>     - auto (setup by default, driver internally picks the color format)
>     - rgb
>     - ycbcr444
>     - ycbcr422
>     - ycbcr420
> 
> Drivers should advertise from this list which formats they support.
> Together with this list and EDID data from the sink we should be able
> to relay a list of usable color formats to users to pick from.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Andri Yngvason <andri@yngvason.is>
> Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c |   5 ++
>  drivers/gpu/drm/drm_atomic_uapi.c   |  11 ++++
>  drivers/gpu/drm/drm_connector.c     | 124 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h         | 103 ++++++++++++++++++++++++++++++
>  4 files changed, 243 insertions(+)

It seems and feels that the common code to be used (almost?) everywhere
would be:

if (!drm_mode_create_color_format_property(connector, supported_formats))
	drm_connector_attach_color_format_property(connector);


Please mention somewhere the reason to split that into two functions.


-- 
With best wishes
Dmitry
