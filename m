Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE9DFD0070
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Mar 2026 16:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4250810E3DA;
	Sun,  1 Mar 2026 16:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S4WFzvr7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N/kiVMmr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CDE210E3D7
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Mar 2026 16:49:12 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61SKhiBE536909
 for <amd-gfx@lists.freedesktop.org>; Sun, 1 Mar 2026 16:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=dSllOkKEfDtkPszOpUxSs26w
 5scwH7eQoWJUjkkZk+0=; b=S4WFzvr74n+UOsusIQV8vroIg+2n/ZWGqD6P5I8I
 2QnM8/qHBqWY7ILgw/yiAvzWx2qubCHOnQ0vsX5ZwC28cc3zn5dc/5KewkUHerbV
 QZZW+NBsVHblGZuFL0vr0vV4FBjPUbU65Zeg+xCL7ugVV5oZZpgnU0KHM+4rP4T7
 RzUxQUk59lKRg+E0hMuAkjfRNqBYMlWRSO1Es3UCGXt0OChZJrGKGFssr4tyDNqg
 OzXVptZm/MnRSTytiWYP9Xpe4HPms2u9CWCNhehNOtxetcz8Ixh1CZGH/mcLael2
 5065GNEayH87h4/uFtcHDWZcrDtLuJdAzC8C101bS6eCaQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksfytwtj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Mar 2026 16:49:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c71304beb4so2516962285a.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Mar 2026 08:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772383751; x=1772988551;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dSllOkKEfDtkPszOpUxSs26w5scwH7eQoWJUjkkZk+0=;
 b=N/kiVMmrXuU6Yj38mqMcQlw5/JjJyucmTi9NzXsRsCbrWQ38kuJatEJUjIPQiUtM+B
 YY1wEUTBTr3dFzlzF281SLZKIcqNBJaE55sinN2m3z1rQih3RvclCOKcmx7i0uVBqkc2
 Ff31hDtYm0qHt3hfhCnxkXN2cLdxlzIsidESrMT16yAmeq2j6anCO2N0fZgQROq1WK6s
 6nrbyZ3Dlo0492ziku876kogagP38GerOJirp7RhNVbQszaEOeTvRlxdfGgTwIC+2EZn
 8lWd2fEw42UD70W35/fAlU4oxRztGqeo7Zq+2btAJMEjNxSoJpRU2yKMFJDz/r9wGj/i
 Q3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772383751; x=1772988551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSllOkKEfDtkPszOpUxSs26w5scwH7eQoWJUjkkZk+0=;
 b=rhlVCRjosat7MiA3AorzTXR7FFwHqv2aqoBHkOwAL4iAx3G/C2ONJAv7sEDVIp9eFP
 KsSa9mZ0CJBkr6ng80KPLWulMK8+moiovmNvm8oWLf//vdwziEsaOapNdrAtW5oLw9Sm
 Yg/9NUgZkfhnkXJ2FmKrmz/XnXnuRAjCFEM2B3fbucqoKfuS0spqf16w3sA9SjDJggv4
 kOIcOAyQG/aF0vcTsnCG8qpHM6WexKaZ57HDDgx4/aNhXe2NZjmdp/Y0j21oVwkaYnrJ
 d8IN/uL/WbFFuNGI7hZ8U1HnhFa/TSgVuTWV4Mh58Qd77YckuBDppd2o3MySxMd2pgdI
 1NfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsshoT5fwd+KpZe3PPdBi8noImA7yl0Ksu9t8KE1+lhg1QUCl1xmPliyr9AkGFWBmp1g0/2ePX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhkzMZCgm3H/kWeGRAxxBrHuBJNobOGrbYNIlML/aD8t7O8LeN
 88q3lTpOj6ceI0YVFtyRaNXtb6vw5D/ENVXAKUDSM2vV3fyXuuMgIFbwOi0lZoJm9xjSYD5lRAs
 KADOp358CD3SCcWVGMWrUWBK/qz1ocOHCVFraplKxi9JI5l3TXiZVQbEdB604TLjWQV5R
X-Gm-Gg: ATEYQzxpXGq2TMff4dBUT7yPEJEmp4FGK6/Eg8iXfWTZBD9N5+MLrkEIX/NIpQtqIgW
 ODaO4bY5AMvadjhi3SIx762e2l6ODE33+KgEhf0IJQF1kSjUF7KDgArCEGvvJq1Hqkeu9nA/FMg
 BNl5Fse0zqXSVT53ocQaL9grTUHuQ7LCYjuDAaVHMrVDkLqYWZwuTi5oQCekCFa1xPLfSpFBWNN
 70GnlNi4DFDiFacAlTFJnZ3xkimIExU6jpnl4L0Wac1enuMs7k3bzl1IygWmoDQ6T0L0QmEDAPq
 fOCO5/NZcHPkH7c3hW1qlx+GumWvEXny1fUAE11kQ7tvbzo2tI13wLsdZNpmPQ8ndtkg3OXZ2WN
 DhADxK4B55CBLhuhVhQsszpm5FX36DRnp8IpGPCkUo0alNzBTpZh6BnbCAP5CyhynyNzGAB5gsp
 EIopMfaGU6VN7vG5a8ePfkGGpryhv0IaDgmso=
X-Received: by 2002:a05:620a:2901:b0:8b2:598d:6e66 with SMTP id
 af79cd13be357-8cbc8da8ecemr1218260085a.22.1772383750680; 
 Sun, 01 Mar 2026 08:49:10 -0800 (PST)
X-Received: by 2002:a05:620a:2901:b0:8b2:598d:6e66 with SMTP id
 af79cd13be357-8cbc8da8ecemr1218255985a.22.1772383750077; 
 Sun, 01 Mar 2026 08:49:10 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-389f301788dsm21899311fa.35.2026.03.01.08.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 08:49:08 -0800 (PST)
Date: Sun, 1 Mar 2026 18:49:06 +0200
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
Subject: Re: [PATCH v9 05/19] drm/display: hdmi-state-helper: Try subsampling
 in mode_valid
Message-ID: <lw2tdcwu7yathstby4a5tx3ys6rruzeg3odvnsjsgc75sqycun@geoqspu2sfpv>
References: <20260227-color-format-v9-0-658c3b9db7ef@collabora.com>
 <20260227-color-format-v9-5-658c3b9db7ef@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-color-format-v9-5-658c3b9db7ef@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDE1MyBTYWx0ZWRfX+eUiqNBDmOsh
 Yp0a06ZoZt4gtiL16hr8o2jcyB7TrgyBJtLRP4H3OQszlArKPNCbSp+RhiUwuVHCnf7D5VQJIgG
 Zq9NVN/+5li1flMkoeraZkVHjb0RKglUfAjBLmLgMDzM0CZsfXWxHHCHoHCSPsUwcyEhsFZ5jFk
 aggEVLEYlTSNbQkhEj+reT5HVO7TSDklfM/c9vY6Cb32vaHQKI2n38ee56nJcbeKjJ76+cYILxY
 G4C2rYKava4nXJBG8Dzj59r3UTZeHs8PrcCcvBiuGnO4Ie/5RxgJ52Mlrlb6iYqrY1k5f4XiijB
 VrxkTSWAOjfdvObj1+e8IzKKYTeYmkClQTczG1Zfw7qHmBAbhjfVoVYXYjL8yLimxRNZ35zIidD
 RsyrQJ5MCFbKjjeNUEBAZNmK+14N0+08AdYKsoz1+rpW69WuN8HHWfY2Q26zIUbhZDzN5xgqc5o
 lJucVv0oX6ytl1G7Npg==
X-Authority-Analysis: v=2.4 cv=avS/yCZV c=1 sm=1 tr=0 ts=69a46e07 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=CpXNCzN6O6rfykjMCtIA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: euaExOKOX_ezy07yFPAnrmcF2eG2xc7m
X-Proofpoint-ORIG-GUID: euaExOKOX_ezy07yFPAnrmcF2eG2xc7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603010153
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

On Fri, Feb 27, 2026 at 08:20:10PM +0100, Nicolas Frattaroli wrote:
> drm_hdmi_connector_mode_valid assumes modes are only valid if they work
> with RGB. The reality is more complex however: YCbCr 4:2:0
> chroma-subsampled modes only require half the pixel clock that the same
> mode would require in RGB.
> 
> This leads to drm_hdmi_connector_mode_valid rejecting perfectly valid
> 420-only or 420-also modes.
> 
> Fix this by checking whether the mode is 420-capable first. If so, then
> proceed by checking it with DRM_OUTPUT_COLOR_FORMAT_YCBCR420 so long as
> the connector has legalized 420, otherwise error out. If the mode is not
> 420-capable, check with RGB as was previously always the case.
> 
> Fixes: 47368ab437fd ("drm/display: hdmi: add generic mode_valid helper")
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
