Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC87FD006D
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Mar 2026 16:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C699C10E3EF;
	Sun,  1 Mar 2026 16:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fkhYPumS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T5HtZ/1d";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F4C10E3EE
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Mar 2026 16:58:32 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 621BRYlt2815492
 for <amd-gfx@lists.freedesktop.org>; Sun, 1 Mar 2026 16:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yZjRbJ2gpSOpi4BD2wRxX0dJ
 2Njlip5bE4IRh4tsp0k=; b=fkhYPumSL/QAlMbXMLtEWChiX97tIzcJ8VeBIX4T
 7342qTqQUCnt0S7oDq9sQfzhyGpEUUJellGBOuoJYTfsmMFHgnXodEk5AC55z1iG
 c18u06r73+Pdj0npRxhtTGO474kenLYedhcwWpbRcBC3ivwUaTrgm50Dsqk4R6aI
 +2cwuKSHZdg1z1b9ojEBXDyD89t9uzig7w2KMFQb1bUwamY01WeikQvsTWQDMhlM
 wS7Axd8o1A+YDbnxSksJB4wZ0i060owQOeU4T2ACD8MJ4tYn9Af87F/Z+bjux2Vo
 fOz++88nKgW1Zk3CTwm94ccFlRFF5WRpv6fuV0NvlWcAeA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksf6jxmg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Mar 2026 16:58:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c71655aa11so4666652285a.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Mar 2026 08:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772384310; x=1772989110;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yZjRbJ2gpSOpi4BD2wRxX0dJ2Njlip5bE4IRh4tsp0k=;
 b=T5HtZ/1dr8xhlk5K5n2vsvGjj6cJVNlMgnZaFJ286RkQDiVgcMhI7DH+rXVapZ1r2R
 Lcik5RDe83oXJqKTPio3Bf5OkEZmeWAIYkrhstjXFlTpJuM+KOv1C6WmgpLHj7MfZMTy
 eqeLkjkXL9rAk00SK4smmodiSNDj/Shcha0NLmYs7ENXMQu9yBnag0VfbcA3GEwEd+bz
 daruiYD7DdmgCiZNVNdwtiWxmYsJmaYU7GH6U6Rln4fd8E4tin3iln2IuhZVKvK+v6J1
 Rji6TxGl08ZDo46Tx4XNjQ/aPX8yc+L/qeet2Sehj1TTWjt6rbr1op6BuhpQ9pZbFf0g
 rFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772384310; x=1772989110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZjRbJ2gpSOpi4BD2wRxX0dJ2Njlip5bE4IRh4tsp0k=;
 b=vFQeAnYdHvdUCMeOqsLgy0CgCBq2X/ji7Gz1knUTGvsgbz8pPrYHl6myiuEqChL55r
 W+BRF+VFQZnTDlFhxJe3GcAeJYKrdZYAtMCU4yhlCLDaxVqPcg8/PUKdaxbQ/KSVyiBY
 gk+BQf04wEwOB4FXTQaqeFdicEl4yTEkexRcWatEuXNytgh+CdJAeiNl7SqJ7Rahno0p
 utbCdZZUoLMCwJ38uaDNyMeH60anOGs6HbTBryWpd+sOg0BU4tsfz7pNx7ffxOT+vttR
 kZP2DFj56zKrBgx2K73HMKix4F8iG4NoE2fIi8lnf+q9PJ/CnDsZaHi98X3/RSR76867
 FSIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbaQABvL5ca6SgxqZVx+UrfzkKtOrGEfYIVWWONh5+Lz/ClpKkhRry42vJd0VuYxNLW17/4+UM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMKyfRqNWiHCG1juXkfbMyeqnUHesFSA5fo9tOxWHdefHaXRog
 0RCgMyqZdBbQBkyVR2UP82dkINLvYIT0xGumdnz37NZNgSkZSo93/dZ6djCPJL+fHTbBAXEM9cA
 FZ83HhAoZyy55YBozIsVaj1jUC6ugDhQVgZ49pF5yZ2k1kbVliBOuQ4lvWKlDnevjg5gT
X-Gm-Gg: ATEYQzzhJYjQAhbd6UWQdQ53Esz4IcY43+gT6B/hJlIK2Fem9oqiIHaiTqd/UGiOzkd
 pD48+q9g7Rb83F5m79YXMmsor40GwBaPVj4FGblHiDnxRqRmv+ydOvnkBT3WIXTdNvSoDwZlMjx
 Ly3anL6k1xp78+Q8teNWgd+Ub0RjiL4iaMyWOmRL2mfi8JHhaKOWn5bRgOJIswCsxTz/n1lWpMB
 jTo2sGXxJkCiZ8DSQRLNi28lk17/hP80HO9CtkNkXhxTVlaCb8zE6jD3bwpsFmG7RfoexintJOv
 6+3Dn78jPc7IOd7TYx0ZHVh3BG/djaZ4cMir8Q84z1vXAUqTYyA8mdGx054ERHg/hmu49dslwre
 bBbdEnHkWpMLl58XU0exN90AVr3gLBcSO5RErogxvK0BR9CDX5iQfXgBCvP+gPwdNywimcSDi3O
 oq/UCabhGGQoMEMm+XTuWyvJe7Pa0nARyMDgo=
X-Received: by 2002:a05:620a:3952:b0:8c6:e8f6:2c7 with SMTP id
 af79cd13be357-8cbc8e4b725mr1252710785a.38.1772384310436; 
 Sun, 01 Mar 2026 08:58:30 -0800 (PST)
X-Received: by 2002:a05:620a:3952:b0:8c6:e8f6:2c7 with SMTP id
 af79cd13be357-8cbc8e4b725mr1252708585a.38.1772384309937; 
 Sun, 01 Mar 2026 08:58:29 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a115bca0dbsm1204999e87.41.2026.03.01.08.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 08:58:29 -0800 (PST)
Date: Sun, 1 Mar 2026 18:58:27 +0200
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
Subject: Re: [PATCH v9 15/19] drm/connector: Register color format property
 on HDMI connectors
Message-ID: <mxfdm4rrsizf3jzjbeoxosb5lhm2wrzqipn6rvly4ukrodltgp@vcu2fkgwagdx>
References: <20260227-color-format-v9-0-658c3b9db7ef@collabora.com>
 <20260227-color-format-v9-15-658c3b9db7ef@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-color-format-v9-15-658c3b9db7ef@collabora.com>
X-Proofpoint-ORIG-GUID: O0KNQKZnKbHhCP_D9JWUqmw8wOOOW8nA
X-Authority-Analysis: v=2.4 cv=JoL8bc4C c=1 sm=1 tr=0 ts=69a47037 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=QX4gbG5DAAAA:8 a=QnxT5sWzqww7kDut_5wA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDE1NSBTYWx0ZWRfX3DMWj1aRDOcj
 tMwDr4FN43l9ptJddWI3gYyvT37YIYPUTrLM1vlviXUaZ7+P8HMJA4W6PScoa6rQNIphoHXhkK3
 5IKEIK6mACiosWIt4MBKSlzu9IM9SL7Rx8c8KcLZUKC7iPA3j/jJ713wEucUhGzAoL3M9VD01wY
 MEf7D14IlCMPAUiZtbQSfb3nv36tlcZsFyBbjXB7GquXaTgjdkOX4ZgTyNQHGMyZU1dIYaXKcqo
 es2EAQJG016aD9/UGT2YW/iyRfnH9vDYU+D/uKFceTLOBSHIKd9nyHpSFgGPPvhgsrLLnsj4Gn8
 K96uAyC2CYtGDQFVdw1/hnCejbsKoIZvYMGraT0K5dP+Hp1pnGT292qRiU6LfmFwXwlsEmSZgbk
 9ngfmMJ47NWwJAr6Cr7hY0T+RBnepYIs172wvJAZZcL732uVicxcaQ0GK7wmdtGrME4pwI+Jdwr
 L+0YApbVnDuZTOHwE9Q==
X-Proofpoint-GUID: O0KNQKZnKbHhCP_D9JWUqmw8wOOOW8nA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
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

On Fri, Feb 27, 2026 at 08:20:20PM +0100, Nicolas Frattaroli wrote:
> The drmm_connector_hdmi_init function can figure out what DRM color
> formats are supported by a particular connector based on the supported
> HDMI format bitmask that's passed in.
> 
> Use it to register the drm color format property.
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index a4907e15dfc5..0f4e24446a9e 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -627,6 +627,9 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>  	if (max_bpc > 8)
>  		drm_connector_attach_hdr_output_metadata_property(connector);
>  
> +	if (!drm_mode_create_color_format_property(connector, supported_formats))
> +		drm_connector_attach_color_format_property(connector);

It really looks like:

   drm_connector_attach_color_format_property(connector,
					      supported_formats);

> +
>  	connector->hdmi.funcs = hdmi_funcs;
>  
>  	return 0;
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
