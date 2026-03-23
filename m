Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBD1D58CD0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D4C010E3B3;
	Mon, 23 Mar 2026 04:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d1R5o6Sc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="el1bs6zC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43C8010E3B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:08:11 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MKenPG194123
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=AqeC/roitS7lz4atrPMGBHkG
 fv3MPIQwtd12I+kF8Sw=; b=d1R5o6ScrRpvUSm5twz1BpFPnyTr0nJI+3j9WZjW
 hauYc6RhhGiqd+eNOVlzr7CAZVGa7x8+3pn0dZP+a22f64h1IVM2t7WminprqPl7
 RHOpEQS3XEmmJiZ4Z2+lqufwyhESST5agXuk8EfBE00yytBbnZnQ6k0u09eo/Ic9
 3qVS96LHmLZFbHfSXr5GM6ssgvlgL8Ayw17+6O2sg2GqQN7jVjhYjs8S3NwJYO8h
 BvmS48hH80OR5xzCb7XjLCdOEZUQQgCGVIYKKrTpOREmP2onis8Dz3+/TUkzNarq
 szGpXPPh1RkCsb+Y0Z9k+UKIRga00lpmIy9X+lEYgm0crQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1kj1kjdp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:08:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50917996cfaso36632721cf.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Mar 2026 21:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238890; x=1774843690;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AqeC/roitS7lz4atrPMGBHkGfv3MPIQwtd12I+kF8Sw=;
 b=el1bs6zCqqJtMw/3/wskGilK+afpXnkGDAUB98x7YJWqXY8M4/57bz+A1Z0+tOWvJb
 V165WROktds3nsxAX+IhqR9dXXQS/V6sT7gS/yf9/3n66vkH3paAngkdYtxzryoQkjj4
 MHJcXt4cBWniNcdHSr6o/yxPibk9wbh7pkBcs/16fz7L/yXozH/kGrjoN9mmU9hTF0le
 0ekFaETDHDM21FOiZhMnjkn5gKYfXBkIkA9q23f99meTZGa8mD32CrDR54ItSZ/YA8Zy
 VW6jV4HatVcUdvsPQi7HPPlp2mpS2fSYXDuFgX9yaBrGSEtBjHcfkIm2ItP/Y2/S/PyN
 vRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238890; x=1774843690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqeC/roitS7lz4atrPMGBHkGfv3MPIQwtd12I+kF8Sw=;
 b=FlZ6+jx2no+Pp2BMw1P9d0qQlM8W9udlqiAV+XZtmjEfz0CGx6lOAhhR9fJ9iCc+pO
 agPvFt010Ti/rbmHk/Oz20ZtR2Rzvm1okcxjOvT4JACyUV0a4k/YvzJaDxH5oD8udTlQ
 rhFjUvUhfWZZqaW+FvWzM/Tjz2PVw4NrdnbNMjF2jBANPLArqRQJF2FX0IDAek552HTW
 212KRMr0q0iv3c7YRCfoGVOnk4s67T6s6vZK20tlAG8K08eo1FmXN19R0Jss+qN2Wk9c
 +nqZjbmzB2zDrm0RfYmaU4eYkf5gY5xXM67X3tN7tkMQJY3FCJn9mReg6yxnL6Lk6V7f
 2swQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/wfQlJ8KCNCag4R2F0Jd0sq+XWTUHjxsaXXNnB/48L6uIRAU0Lp7ccEu0XLoydQgFJbRmDbzL@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz45i1NPr2XblUoI1sKNBsfURAdIeU4e1IS+Shlfqm7EznBjcH6
 +4VgRXFlzPpy+BDkmzi7Od8aXvtD6KtXfkxBEkVn3WMaDZQSvizY+xplhUT8AAMGGkRh0tDeGnO
 BIwxquSixEPh43r9aIJjocz9KD3dEtsXHykEB97vVxjs2exnnSRTfPcEH7BsVX/1XY3FS
X-Gm-Gg: ATEYQzzomXh3CUSJRunQNd6zqGoMb273E0ZzvuhHdrlSLsImeJjpr1X9rNvD2VB4fUQ
 ajpiUK3df3Glwm8p6uSJ7FtLycJcm0JiC911NDnjPyfoDKfonH3f/y7g0G5XBtVCiJlJ4dBDD9/
 fn+ITnpJAE9sbJ9HF+qLtd1n1UKtIRYW7f89I/rJxMhFtraCzkcw8bQwlK8tgVX2Q9sfggEKx0i
 kTsdIxaxxAYEZkHRjiiCX6+gq8rajNVlwkDqmDbzY+bUngLsDx868ZRZKBahhbX2fqYztWcroIL
 K5iUqMNzpFKpyIQow6Ypi6M+G9JiaTzK5rxrU9Zm+TOL9pG8W1WxDmIbN7UzbmQiFeYN1ezdEt7
 ytON9b5gI5XXOkNHkCUJZjzxBZXpeZUoA68QhhQkfnfZbCRUUq/DS3KU8jw8RrlQ0ajnwja0mqY
 cTGEpVq7o3YkuT153Sn+0mQt/JAwjHfVbitug=
X-Received: by 2002:ac8:7fc4:0:b0:509:2ef7:7034 with SMTP id
 d75a77b69052e-50b37538e75mr168613671cf.50.1774238889746; 
 Sun, 22 Mar 2026 21:08:09 -0700 (PDT)
X-Received: by 2002:ac8:7fc4:0:b0:509:2ef7:7034 with SMTP id
 d75a77b69052e-50b37538e75mr168613281cf.50.1774238889243; 
 Sun, 22 Mar 2026 21:08:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf99820ebsm21316001fa.20.2026.03.22.21.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:08:07 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:08:04 +0200
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
Subject: Re: [PATCH v3 06/14] drm/bridge: analogix: Convert to
 drm_output_color_format
Message-ID: <rf7nfbpyc7ce2t4c23melurn226egzqfhk35wt7q7yaurkgeeg@yu4qhmtblpit>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-6-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-6-f3935f6db579@kernel.org>
X-Proofpoint-GUID: hdknTWedp7zchoDQDYZ0Dxy3mj9Sxqgg
X-Proofpoint-ORIG-GUID: hdknTWedp7zchoDQDYZ0Dxy3mj9Sxqgg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOCBTYWx0ZWRfXxfPiBT/ImAvE
 yYjwzV/XIajg5FKFjPa5ujdi/fOxpZrIjlZuhHNaFJ1b6pnw3odVtZkOwaqJxhMHmqPollAXQyg
 iuavSvW2IKDLHeDCK98zqtZktmuu6m2X3QDQ1MNcIZ6dL6JxIrNXQ8vZK5tk+5yVMo523m4Uppw
 8Z6FaUR9qmvwAUQYYZ8+dbcw1prJqrv8iK3McNWp381Qw2+LKudi8H0J8y3TcbOHQTMmQjKdBqR
 FQTcQAL+5Scs7lR6fxmZMwS1CXCG4VFjL8ZCT/D9bfbEm+5wq/SZIUFEC4eZYFFl7vqC7VIOJMy
 n4xlUQjW5tYRP7F7zxxs37fJQYh2B13eul/++Pc38TJ17jFPViLQcsjb+fHc9vdrXc6unbcvPTs
 7gdAkjQogLZtnf2v3jPsIsy0++/jhsJHd9LqCRDXjCCrX5Wlji0OYVODMrd0rXDkP3l2rzXG8E1
 WX+sYBSKcGPyJUMhg/Q==
X-Authority-Analysis: v=2.4 cv=dYiNHHXe c=1 sm=1 tr=0 ts=69c0bcaa cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=O2P03feSXV0Fh_yUmGcA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230028
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

On Thu, Mar 05, 2026 at 10:04:58AM +0100, Maxime Ripard wrote:
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
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
