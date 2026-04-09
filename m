Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7A1F364C8
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 22:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F23410E099;
	Thu,  9 Apr 2026 22:09:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kNv/mPHE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gCs2zZQ/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B0510E08B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 22:09:05 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639J07F8780106
 for <amd-gfx@lists.freedesktop.org>; Thu, 9 Apr 2026 22:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0HMFaKZjpgyXaau/0X9Mxm/w
 GN/42VWp/aAAASGyGoc=; b=kNv/mPHEw/tFjVBnkayEOYmjoDA8xsri9s1Fx5AI
 j1rghVQSftnAm0tVvn+YyX5kR6NxS6O3dSqWEcQ/9lSZ+hrdwdG1+gilPhovXIoD
 gNr0mctsDpiBtOOepvYk2JQV1iPFChb/nlhXUGmm85iCETuMErjbBM/gwSw4nRtJ
 TuhcWuPxw7Wm3KU5go4mRE9Jh4bmK3YUSGd4dmcq9UXo52BVx7jxPFeFAqhdLoqA
 hqNgGZhxbOWpGXFD2ueRY9MHdyKwFe7ReAxa1BSeJFtvdMjnD+rEtIyQTkwTnTcs
 gX/v09P9lvNyi4ZmJgZQgtoEGgqdjnNr002UF6Z1Acb45A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dec8ht25p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Apr 2026 22:09:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d8dac6233so29308951cf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Apr 2026 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775772544; x=1776377344;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0HMFaKZjpgyXaau/0X9Mxm/wGN/42VWp/aAAASGyGoc=;
 b=gCs2zZQ/dKXGFc8GVlCZey88L827VSL0Bc9wr7Il6LJjhJ59Byvh6Vl6b4ChrkKsMa
 pVi0Djql+zbMt42DROSI1EED01QdJh0C9oABbTCpLkdmQkpwN2a/+bb40+O9QVKGux4W
 u47nexpPnZspdocH1hzJ6KRv13y43KA2tH2FdFssLtyvWdyzovuHS58zwLx8KYPYTrIk
 zMG4DcH/ZChGn8UvukEgUiyamsqVoGA9rH/0ZuaY/2r6rxArxWKIf0Vcvx8gtiQv3kY2
 WJ7/I2woIEdq2HBijh80VBmokcVYflARBmrcglLp/KlBA8Cg+sUNiSv1mmMwEQqmZ3/5
 Q63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775772544; x=1776377344;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HMFaKZjpgyXaau/0X9Mxm/wGN/42VWp/aAAASGyGoc=;
 b=KYmAo3GwKwX6qxAbjVtNrysfcI1kmrgGDPkwoXt13faxMknoTHqGZFe5jcKoXc1XIp
 /chsdYZgC6MPYxrEvRuEOd7vJpnOx3FLnacQB5L8dx96/mN8dLYXU2C1RHg7BYPGmKiv
 CaKGZDKCHuNoAQ6oUpIiWo6v0kI4UZN6OXh+LzYqueH1JXvutyJUHEMZm3TsVu6AH848
 dVSA8Fu7C/ME755kA9JToDOnkn3GSsGzhC41ajkuIwWsbiUlCcl8+iTsk9UZkYBsgCZN
 +yhtQNOIYksdVRv+dUc1XQ+QCFuD3/tTaplQRz7JtqK3dRQyRGRF/x+OZbcE8a066SNy
 f6Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQWVkI1UCZtsZBwVprPs8XzF0tTgGoPQD1aesXnzr/am4I2UxXcXv8q3nQT9dwfunJZatHTCPR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKndwJezqWuTGmdSMVaTHB0XopWqJp1g7VmLEbmTYa/5ZJdQvO
 n8o1tLJ8Su3Y1bYXqUcTiwTXp8kKB4VnLySqaYHDfNu3IanCdNN7UZB/kMrjcWNyiB0JCN/pZ25
 esoXC+0VCIJKHHZNuXfh6bBH1xoMACDs/I+IeWr1uYl4HLWU5zcsou256eVe8mGglzeRB
X-Gm-Gg: AeBDieuzsuLMJ0IzMqJKrgySYpc2vtIsRN7dbr5MwB7fycKJe7KM+2bLUlOelMkfd+D
 LlLGVEvFtJj5kaoA6S3cnElZf6id/ieL2DlGkTvwtqA+NFR0qWtkKoG0TZhVKHkxDta9MqPVYrY
 KnloLKTimipgHp2YiYC0XebvErfJ5sATedAXMofoeKkvIw0th2U8iw67Qcf+C82/FJTdVncVW/d
 /oiBR3fRZepjhCq6dTgXo/oesS0n/OOTYfoD7WrdVfD47CrE/KdCDEAjJ9DpB07BBjsj3EXiwUA
 fi62emYn3+MiQzrqq1O+GrV1l2omQ7gaGp2VVqnIDJ03XUhyT9bemYDYevGskNRkqnHqF0K8FGw
 qRdg2ERynL++Oa10ahVOnJPINugSaEazONafDmHZSCMeeZSU1kb/Ohq4bczHJVJU4vwQqQvcgLD
 9nakYE22CfmIo+VF9FLDTQThXkkTsARpayMGA=
X-Received: by 2002:a05:622a:2485:b0:50b:50bf:5bbe with SMTP id
 d75a77b69052e-50dd5adbf6fmr15604291cf.22.1775772544447; 
 Thu, 09 Apr 2026 15:09:04 -0700 (PDT)
X-Received: by 2002:a05:622a:2485:b0:50b:50bf:5bbe with SMTP id
 d75a77b69052e-50dd5adbf6fmr15603721cf.22.1775772543912; 
 Thu, 09 Apr 2026 15:09:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee864a2sm196421e87.2.2026.04.09.15.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 15:09:02 -0700 (PDT)
Date: Fri, 10 Apr 2026 01:09:00 +0300
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
Subject: Re: [PATCH v12 05/25] drm/atomic-helper: Add HDMI bridge output bus
 formats helper
Message-ID: <47l6v3hxfnl75heek4o7fmhybafk44ewsrr66sdw55ahjv5oof@sku3nqbhg2tx>
References: <20260409-color-format-v12-0-ce84e1817a27@collabora.com>
 <20260409-color-format-v12-5-ce84e1817a27@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-color-format-v12-5-ce84e1817a27@collabora.com>
X-Authority-Analysis: v=2.4 cv=PMM/P/qC c=1 sm=1 tr=0 ts=69d82381 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=FnALt_FR2tA_ePdYDbsA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: n-ZDI9HRyzwDaPO_5-KwcvPpgLKUztck
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwNCBTYWx0ZWRfX6NHkNKkcaP8B
 K3EBNKbwbIrr8dPb0QiToF3PatVLk111jNT52JL2m36ywxnd8H4cOULOteSKNpRUhTo6/iUYO0X
 jaBUguxl3cFhrm18E1Z6Pvsktck+zLA2La48Wf2OK6Gug0Sji/10NFrC2+eMQCYWpG+uWMcEGTX
 nxb7Cap+t+fZuJWthehdXCfbKCRY84O3dbvI1I3fKbiCauc3PX1RjcbCSHljp+AGqIC0odxzD3d
 ef9WP1ZkO5DQzz2Wmhz8Tchp23J0E2/mz3tKOGei76mZUHLsHFIoG+AwmuqS23W118UPn/GOtLU
 xCUzwFIe6kerZdrvrSrea1z7acS4/nTOZ9ziOWSrMIlDU3DB81zf0twVmBR3NJ2FZBwP0yUBcnf
 5QKGQLvC3jak0O+sFEsH70KDABiYEfsSujoF0ZxHdYeTtGXqws9lA4IXBK5nJFogEXgKDDoO3Bk
 7GNykINGIybYT/7Qg6g==
X-Proofpoint-GUID: n-ZDI9HRyzwDaPO_5-KwcvPpgLKUztck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1011 malwarescore=0
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

On Thu, Apr 09, 2026 at 05:44:55PM +0200, Nicolas Frattaroli wrote:
> The drm_bridge_funcs atomic_get_output_bus_fmts operation should be the
> same for likely every HDMI connector bridge, unless such an HDMI
> connector bridge has some special hardware restrictions that I cannot
> envision yet.
> 
> To avoid code duplication and standardize on a set of media bus formats
> that the HDMI output color formats translate to, add a common helper
> function that implements this operation to the drm bridge helpers.
> 
> The function returns a list of output bus formats based on the HDMI
> bridge's current output bits-per-component, and its bitmask of supported
> color formats.
> 
> To guard against future expansion of DRM_OUTPUT_COLOR_FORMAT outgrowing
> the hweight8 call, add a BUILD_BUG_ON statement where it's used that
> checks for DRM_OUTPUT_COLOR_FORMAT_COUNT. The justification for not
> using hweight32 in all cases is that not all ISAs have a popcount
> instruction, and will benefit from a smaller/faster software
> implementation that doesn't have to operate across all bits.
> 
> The justification for not defining an hweight_color depending on the
> value of DRM_OUTPUT_COLOR_FORMAT_COUNT is that this count enum value is
> only known at compile time, not at preprocessor time.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 81 +++++++++++++++++++++++++++++++++++++
>  include/drm/drm_atomic_helper.h     |  7 ++++
>  2 files changed, 88 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
