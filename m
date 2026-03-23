Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4421AD58CBE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D61A110E3AA;
	Mon, 23 Mar 2026 04:07:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zw5SVhqk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BBeWqa/C";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DE4210E395
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:32 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62N0PcAp3647197
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=W5rwiOXF2FFDG/kdjyCGCZaP
 JLF8PoP6ImoKwsa95hs=; b=Zw5SVhqkPq2/cw3ADnBJ5wgBRbhd6YTXpPGmORtK
 L+Tm1dVCL2518ekIBX8K7LtOeS4wZS9pEig/W4AJFNe3Imk0sxFuh6st7w+CKMK9
 AWI7rERcfwXLEQMjLCzdN9cNk5WWl8SvuE4pgOyb5YQ0AjsxQlWyZQaFFoEKfHSa
 YSt6n+fVlQsmvAisWict0zJSnVNwpn5puup+flKkn7Y0GoOKdLjxqwv1lb0o5TV9
 YNyCil28mxaA798c2WvD6qRBObe8+XRZgFlKBNFRS4Y1QDhxC4+0Ps9QhnrdihZU
 m1tnxlVkDv5GVI+IyRuavtp5B2C8JIubTyevpXEnYAIf/A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jng3p0n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b323c43fdso24981391cf.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Mar 2026 21:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238851; x=1774843651;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W5rwiOXF2FFDG/kdjyCGCZaPJLF8PoP6ImoKwsa95hs=;
 b=BBeWqa/Cn4j/eQe/quN5KwOsgJ/RWiXaQL68h8NhfRBeWcKow9sl4L/q5v8RiWPw/3
 rRnDhPlkQwTjeN3CZ4/NGfGCNp3js6Uo9AV+cQIcSsAQ0eLJw7c/XlKuobHsiGyx6vMg
 zW2/kbp/PypcQMGNb3VXzE849//tvtLfmar7nA2xY/+bz5qXwLXfOnEdYjEzadyTCcAd
 SoYSKt9oDV/vsvkoLoGzefzCpoLzs2rISVd9JuHiolNL2oiStN2+6Hr/TpqqGsKXdEE5
 RGmeqXYUBAAkpE55V8pW2Gfi6E9bFyIm1QyucSVhP/JFaMRre1JPYat0FspoehxWnB3b
 C6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238851; x=1774843651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5rwiOXF2FFDG/kdjyCGCZaPJLF8PoP6ImoKwsa95hs=;
 b=BURc8KYiPMGih7HBzEnus8BvTo9IY4efhh0BuM/gMk1JUTpBzvBFvfgTy8P5bjYdHp
 CLYDAzm3OAW9d32uM+HbC/KcaIfujtBh2XhAbW9USeEQmPTKtxO7NniWAlKvxsqLD6vy
 +m1QsrzlPywLj3/VmdyYbdiRl7+ga6oiU06EC7JxjRmlNM/LbSiCtKLuekVFvdpzYLR8
 Fn1HQ4ejw+Y0g/8mQpsX8hXU8e3cy5BkHD8vUC2+qLapKT8I3YirZQ5gSvJ/7gzgQAgZ
 D2cZ5AZvI0LlrMBwIQMls38FNKtTVEEjQI8Yiy0t3pms05vsjsgjxWfa8NzJsW0N/QkG
 WiLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPwxLzv0U0Lc3Z5y3LPE7aJuj4DHAkx9ywh+lL/g/+lvYvAKp99VeNqgRpjQIJ0f/QIANfTTUf@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5JCcQLb2SWudQX9OXOPoiuB+DPC6Z55DzkEOA/5RmVb34JxMh
 7wVksSlf3TJpxFaBvLVxHXLAO9uBsuSdoDyK4evE76jOPPJEbX0eKa3frX8kIen/seKMsoi3zvJ
 8G2ly4ew3ITyyyMC+zA+huzMi2VZoAXhohQanIaTHXp+GSw86q8HEUk/IRC1/cwkrTptF
X-Gm-Gg: ATEYQzyCPRkufzY76m+/1xj0FCKfEtcrad+9Bh84aTd8fZq5txu/qWIqYk09tJgTx/K
 2yS63JWJRhrMkEbtZa40ra6FvQo2KjGDiL6WwBpvWiww0Y0MccHWy3FMuv09k48PmdZ1mDtM/iy
 ZxrwdmiWrOdfYUNRzlHgsO2G5vujhd5qfCTHSfJOhIKmVSTCDpqZHvDnnQowUTn/j6CXkomjYl6
 6fogjDVvc4WsQdj47a8pAeXolpwVeaTjaF4EvlYLVdWHSnn3+UC9/L3lKliuyQJrEX1kWfhfiZB
 K6tzMVeM2hmaFz2PwmZsAD6bM9QMmZvQP2y/72TWdGfGoTD8rUqAtfzsMSWu34yLhxAuNBVzEZZ
 bpnZeq4uUhJEWr+jbRRcesvk7rSiLVMxCWTPIyR3psBUFUsdBqeppDR4LxM655wl5igJnxwnxdv
 nHoJbYPOzijxAN4r2jP8c6/GZQggyt4FFytMA=
X-Received: by 2002:ac8:59cf:0:b0:50b:2f1f:ffd3 with SMTP id
 d75a77b69052e-50b375682d1mr166637581cf.59.1774238850823; 
 Sun, 22 Mar 2026 21:07:30 -0700 (PDT)
X-Received: by 2002:ac8:59cf:0:b0:50b:2f1f:ffd3 with SMTP id
 d75a77b69052e-50b375682d1mr166637111cf.59.1774238850280; 
 Sun, 22 Mar 2026 21:07:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf9981ecasm24919121fa.24.2026.03.22.21.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:07:29 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:07:26 +0200
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
Subject: Re: [PATCH v3 02/14] drm/edid: Convert to drm_output_color_format enum
Message-ID: <xip6aoymudbdakietc6qrt43irdajp46jrsdi27m36dfqfzqnz@y4stxqdxdjix>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-2-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-2-f3935f6db579@kernel.org>
X-Proofpoint-GUID: jognC8pI-vzLmKSZp-53kkG6YZPVCXlF
X-Authority-Analysis: v=2.4 cv=Q63fIo2a c=1 sm=1 tr=0 ts=69c0bc83 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_wym5JX8MKgHMASIHSEA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: jognC8pI-vzLmKSZp-53kkG6YZPVCXlF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOCBTYWx0ZWRfX4pPQ2V3aQUao
 a11YMf7kG3eB1kAJ3D7EV6uMG7qF+LOALaMLus9h+EaXGX9VQ3EnmV4/nT+bc5KG220Ur1iirbx
 j0AQ9BewAm0/RJyXFL7OzPm65ir2ujXdWqtfHW0cr5TyxL9jAoMz7cLIwqzV3/uDnU3oQ5YXNaX
 CNr7Deyw0JYJzTL8MpOoBpAhIqKohr/+WiNk8ruh8PUX0hWj3TZE57TqiuGHELgTyHthzdFiOpK
 UVwj5hgUmxmwnAI4AKIXn0ipEeccgd2pQbb7V5KzNYVZ9sKoyUC5dsb0O1kaWMFxj1ntuAFKgny
 m90qWWjncl8RVEQ7mSfB1P8rulCsGCfdqfDlb5QXHR86gZj4oQ2A/LNjOJyRqA025S9dod2M4bs
 aDE1o3oRa0F2Z7Zr0rn0ewnJOrq8tW+0e9Cdf6j9MnPdTyRDr9O/JiylSKP/Z72KvOvI418eU1f
 EIkgv2qRX2w6BbRMTdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
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

On Thu, Mar 05, 2026 at 10:04:54AM +0100, Maxime Ripard wrote:
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
>  drivers/gpu/drm/drm_edid.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
