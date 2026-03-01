Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEF4FD0058
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Mar 2026 16:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C046E10E3E3;
	Sun,  1 Mar 2026 16:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g7bYISNY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZZlrROWA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F2B10E3DD
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Mar 2026 16:56:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 621FMiv73558375
 for <amd-gfx@lists.freedesktop.org>; Sun, 1 Mar 2026 16:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=eOVsPPjRSHguluqilN+Kykf3
 N9M3bR0DVUL4ZH0XYBg=; b=g7bYISNYlH4zm8Xc8NmJw+M0K5jMvJ5cjPbQXgbm
 bGMeZQy7zp6MKJDjrHG1fpDIjml8NhjImDmfW+kEkNkuk8P3xFLHN90IqHo373cM
 RW5Ndm3pzApXW5silQHbujFxwqjOsi7o42PFypVLnjOlH32AAIGkMYcU1z4FAhXh
 n9bbyOltX81FKyM+Ec7S4fznCBe/RqQqafp0KNFl6kNigll5bQBsL0XwZxmm1AH7
 5OYkZGlfPKuqgshdIAdW+rO0jDOUncXt3YNu1bSO5WZY4Kl1DWo/wmKwpwLodB6R
 uuIKygv9NTamdvEIi7PH5LbqSED44L5RgmBIIQyUW0La4A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksf8k1ht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Mar 2026 16:56:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cb4e37a796so2908325785a.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Mar 2026 08:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772384204; x=1772989004;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eOVsPPjRSHguluqilN+Kykf3N9M3bR0DVUL4ZH0XYBg=;
 b=ZZlrROWA3fWA9bDFigL+iBEPASefvCxzGCqq3o/sJgRBYrxIOrK52Nw16MFf2WOHIO
 mgYBQ49UDznVeBx7jyMR0SjwqnEPSKH4At+NKAaGNbIhGoowAzrvzAaA50cetycvHRSr
 cPPR8B7Mz/c8jJ+uCQgXQ/AqX+HwZvPFQom0eS9pkmH4xinRYxZuKIzBYnl9bmfy2KH7
 sYEtnFcmUOktR+6bWSi3RBC+sC9Ub1+FUOFMWrSI2PaJMvOwA3OQxhh6L/s3C0rnlrLh
 K5wIlAKmYtw6ariwu/uHe1C8VZ34VUkKFv9+TrTKBr0UoTkK6+6YAmPEes/htssPJqJE
 dT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772384204; x=1772989004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eOVsPPjRSHguluqilN+Kykf3N9M3bR0DVUL4ZH0XYBg=;
 b=c8h74FR+IhLctB2YGM6IINnAqdA/0/LrH7e8AXdV1vlC+vT7l9MCFhQdIURWN8gUfM
 0N4PV00ERMazabc7GvGJ38Oye6E8QF8iyRklyD62vVmZ2Epk8tq0tOXDiCQ5+gLE4NlG
 TJzIZh7ieNbQsHDZmGaXJuwWyjn7uOeBlzOfXuRgAuiVQ5LxLRITUXq9hKF1SapKZ31c
 7WMM4hPAfdMiTaoStRSbdLd9XEwDCRlGOwJs5d7iMyxqlR7q9BqF95jpH38xj43prQAQ
 d2ol+Jd2Hd+Aay4Z0yr4UCInvorv0fMck0HfMQDcLtwvy2pecyVicR3xiEm9LzHcYIcD
 I2jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHWEBH64nyjJUFQ2kB4FFYOJqoZyz3jvLaxgYPs95w2ni4VKdgp3iR/KMysrzfxLCoxkHJ0mRv@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweIUATcuY6FV7yYGrjK4pAMen7Aoriuu1ZwqVNwAZvrA9/edqV
 w9c08U41Ak4Kmd0xj55mL65l5ssAQVLr7cAQQjP4Ij7JYmy/EUC/1dtJ2+ba/USlB1vdX2EY4WE
 138TnVPDeJUJMbsZei1HH4XFApNZ2vnfCBT+E2XOQuxHKiQNqThzkFFCYeHEP11YUPENu
X-Gm-Gg: ATEYQzw2+JC8Z4+qy8VnvoHTIbBg2le0A3rxHkbFhu/ZeSUsvIhriEgSijVViUBayK7
 Bf4WC1r943hHYXs4BibSMhHpohcfeHY/eyS6Bm6U7xvLEyvAst408OXsGQbniebDALtc3QX0vMx
 G2k2Wx9O76dHpdWe6NpyC2cl+84OyQMWsyG4g8sHAXnjMR+ZGkhzXviU/honHApRcaUuBgvqnFc
 2zVAd98pBedYeNgHR2wFdmuSXsttAaGskctBFBodUNGPjJCo4UOu0AagE2aasm7fVFLki2aFv49
 cNzUdQjrCQw/0HWJdzmydw4dnXWa2GiFBM4AVz0CvIUwnO82dKRCFsDH/2VTfFXEzgSduHVp5f+
 0jYHooYNYz0BOEquBwrR+HtIjqmUDmrvahqZXwmbb09UUMZ9E7rxTx+1Yr69TyjOJaxLAzkndcL
 FLwUNsa34pNmB+0xMI+FTUGLP3iIJY2cPxQt0=
X-Received: by 2002:a05:620a:40c5:b0:8cb:1c3a:90d6 with SMTP id
 af79cd13be357-8cbc8d6719cmr1207725585a.7.1772384203872; 
 Sun, 01 Mar 2026 08:56:43 -0800 (PST)
X-Received: by 2002:a05:620a:40c5:b0:8cb:1c3a:90d6 with SMTP id
 af79cd13be357-8cbc8d6719cmr1207721785a.7.1772384203394; 
 Sun, 01 Mar 2026 08:56:43 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a115bd9996sm1161185e87.2.2026.03.01.08.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 08:56:42 -0800 (PST)
Date: Sun, 1 Mar 2026 18:56:41 +0200
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
Subject: Re: [PATCH v9 04/19] drm/display: hdmi-state-helper: Act on color
 format DRM property
Message-ID: <ylcczadyx5ovc7lbb57ehux62x6zbawf2k2pd23ymkp2meaqci@fvrf5gserw7j>
References: <20260227-color-format-v9-0-658c3b9db7ef@collabora.com>
 <20260227-color-format-v9-4-658c3b9db7ef@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-color-format-v9-4-658c3b9db7ef@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDE1NSBTYWx0ZWRfX/Lf72M6PbL6J
 aX97wMEvsIOqqJm7pX949qvMK/aGhGHzHZQ5P2I/zm/m5G4wm71XnmEFy2vBmT0KpI3fN0QsF6L
 +q1gyErF3hsLcsE+UFLeLBkuJuvSScOv12tTZXp0JBwHD6cWZVb4yF8dIJ9VCroOUrq/XajAc0m
 OEQyN+Go3PIKhuVdlZdQCDBkn0DSyplTqdNQd8+jsE97zCiqjbUZ7uK7T2s0DCQMojmKo9u5vHn
 z0lFJVXqiYnt4iXCZEOuB4rd2TztcIn1HQuBpxRvq3Aw+yPrERY2jEu9WhC7SCOAyJev639XCYl
 +qC5E0PzdI8tSi/VTR71yoHkqkPkAi8gAL4QSyabMMllVZjBpkhoXCpVBuLmdf7kuScDyQAVfps
 SgSUW8T38VX3xt6PQdK5h8xkMAc/4X4TdclAPPRrcYPm4Nf6FoNETHTehOOnnbz8OmZ4baY90Ou
 cs10nAOhk9f+KK6pQ0w==
X-Proofpoint-ORIG-GUID: aN4x0sfxNjq7I4yLelBdwPW6iAoDJhxt
X-Proofpoint-GUID: aN4x0sfxNjq7I4yLelBdwPW6iAoDJhxt
X-Authority-Analysis: v=2.4 cv=I5dohdgg c=1 sm=1 tr=0 ts=69a46fcc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=RMrH-QTV4azj2PXgkmEA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603010155
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

On Fri, Feb 27, 2026 at 08:20:09PM +0100, Nicolas Frattaroli wrote:
> With the introduction of the "color format" DRM property, which allows
> userspace to request a specific color format, the HDMI state helper
> should implement this.
> 
> Implement it by translating the requested drm_connector_color_format to
> a drm_output_color_format enum value as per the logic HDMI should use
> for this: Auto is translated to RGB, and a fallback to YUV420 is only
> performed if the original color format was auto.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 28 +++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
