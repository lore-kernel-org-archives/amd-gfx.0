Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D483EFF885D
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Apr 2026 11:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A9510E19C;
	Sat, 25 Apr 2026 11:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="buxnuiWL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IQtrilPm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A4BF10E19C
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2026 11:03:48 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63P3Qsn4470917
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2026 11:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=NGyE7KsIgE1iCIP7BFttRF0t
 KByHvA43U+zOtPNKwNs=; b=buxnuiWLQj2/Up9fdROOm92md/+ciO6Vm5XkOt00
 bBiFLPIEta5evStIw1TWwS3cQox2DW8qE1rvDaOJ3G5rbEO+CPyV9uW/NqCy3rq2
 NxW6VyEUFmaZntlnlgL3G2iCEkfn8ynKqlQrPc4ut8FZQy7JPr+mckAf/BtohmQK
 G2MUjUwP5Ob1v2vgrr0AdKirLo0DrUu+SZsN/DI0JU7GX7k+FCrTY4JilBMmT4eo
 Nq/Wwav4JPuYvldw418/mpwjLsTyVhP3HP9LnjuLnD4kLtAyGyCb0x+PYbZkpakR
 2jPJXqZnLBhAWmJiGZ9wcieiQKA/SNG/XbjdMeRT6MtCHA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnq5rrc9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2026 11:03:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50e136aff17so161682591cf.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2026 04:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777115026; x=1777719826;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NGyE7KsIgE1iCIP7BFttRF0tKByHvA43U+zOtPNKwNs=;
 b=IQtrilPm2LmK10HMfynBCeF8jIjVHjfw1/PfhkmivDP6wukQjaCK9q78M7uMeG/FZC
 hZmXP+qgdrA/jSEJSDX1MkODB8JD+4fxcv5+3P0dkwdE6PXLBpgWWQeR6uDszVmQpf+J
 mQ+fkp9giS1nnUsh/oaEN5Nj1xJIeMXTMS2G9xmeimZneuk3ibeN5TFWQGFM7Yh0KEPy
 YfSRGcW5RPiGGojr3vi0wYcG8VGBm3eEvMcU7o+jVNMsBQX+UWk+WT8fncoV+SqKvBPE
 ozZIe7Dt/7QehVbTp82NBqYLxgHNBBvXy8CftafSSuK2deNOzQcZ/WDmPcY1f8iT1MNc
 KJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777115026; x=1777719826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGyE7KsIgE1iCIP7BFttRF0tKByHvA43U+zOtPNKwNs=;
 b=lHUUalHQrgLqPA2xGi8f7TIJPRHb50doColidEKAASGwne38hJULhIAUnhsk5Lnojw
 UStOzKPw7ua8bq8+FZ/3ytEuQFTLrOs+Z1YFpNC/Qea7/b/eAYz25RILmZ9w7uGaCi2S
 GdFt8eVsh2gXDbYbp0nO4ceJvFMDV6tkTiQf+lXvWnI6O9/GTYK8VHO9y9Tu4d9p8R+D
 nLK4FA3O5Ey0nFPDHjryhelA05TUVLAf6SuFtWN8fKNIndpVzQ41BXjy8WYGNsTdATQm
 VHCjp6FrfSp4XZbXGVABLouG2nHqf0lFrQalwknWcEB5s1rVtRLURLyDEeoiVCdFCYlQ
 Hj1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HkNQIsWhkdN45QenucsvSox6PuXnVpR7J3IF5oImD/lkSZLYp/R84wSn1DC+Jxdly0J23oOCo@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQxZ4SRCWQqZmHLjrGMvG3eSCwDxsK7Yir0B5DoJKPu3E6Nbe+
 V6PLDD5J2a+JeDYk/oOPNhKc/R2k7JcdOf/oYHrmMxw+7L/TI60P4pin0wsuxIfJx7PfKQNEm92
 eob5ELs2TP1lrevTaINFKLit8Csw/IAAXfDv/hRmq/+feCl+8McuSITb6HtzPwBP0iIhW
X-Gm-Gg: AeBDiet7h9tPuUSdFKtMKhdJc1aukJaPXPlkd5CZzokMTdGvuHCDhXem7SrjYnYLyV4
 uslgbnbgz+4oHNZ92oYQWbmpFurU2juzi4Rf6D/+4k+m6ZPfCDRg7TTO6zGC+LaDxj8iR58X6Av
 WdRvuIaIAT2ZPUesxhYoDTuMB3Ebcl0E745Azr6EYZh/rcJjRkOBDmDSOSS/QzCpvAyj+J6cqab
 JOoeJ0w49ZvTEZWYrrj5bj8ZIYBLNefExDuIp73129BwFFzZtCmLb04gAV3+tBtZi+/CXJFu6As
 hIZRh0IP3NeImtoUzKNwZNIHRlpZJSM9XLCWGUZ9B0pI5Hq7OrInmjDJf6Sb7uMlGzdpKpV2kp9
 HvTkmCKpfBcuxTikF3ZRsu0kDmMLQ5ZX+u2WFuZC+BZA3pSrbXX6jshpkSnRTjiO95hkYfYRfz9
 E9HMKUiTOU77ezmMfYCcZS0ikYX0XW65AT1cyQcvleE95xtA==
X-Received: by 2002:ac8:5f4d:0:b0:50f:135e:d68 with SMTP id
 d75a77b69052e-50f135e1259mr360464701cf.58.1777115026561; 
 Sat, 25 Apr 2026 04:03:46 -0700 (PDT)
X-Received: by 2002:ac8:5f4d:0:b0:50f:135e:d68 with SMTP id
 d75a77b69052e-50f135e1259mr360464161cf.58.1777115026099; 
 Sat, 25 Apr 2026 04:03:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a6335ce587sm2078590e87.70.2026.04.25.04.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 04:03:45 -0700 (PDT)
Date: Sat, 25 Apr 2026 14:03:43 +0300
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
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v14 06/28] drm/bridge: Act on the DRM color format property
Message-ID: <e3lpzsodpfemx62ye2rshiq7xnexiihzwxtj5ouqddxip5xnxo@q75ujeicb5p5>
References: <20260423-color-format-v14-0-449a419ccbd4@collabora.com>
 <20260423-color-format-v14-6-449a419ccbd4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-color-format-v14-6-449a419ccbd4@collabora.com>
X-Authority-Analysis: v=2.4 cv=QNxYgALL c=1 sm=1 tr=0 ts=69ec9f93 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=zO9H7474j3G4b47APuEA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: _k-Miy-JIDEqpmPdvZwP8JEZewkt-rS6
X-Proofpoint-ORIG-GUID: _k-Miy-JIDEqpmPdvZwP8JEZewkt-rS6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDExMCBTYWx0ZWRfX3NC5Wv81r8Y+
 8XXJPlAe43kRzBrlQNQUO7SUfFwdWX3suXXpV0f/+pZ05/yViljS2S5tt9Q8OVjUYSBVHDU+Nf+
 7XWyD8aF1rAU3OrHKHafbYQ4mtaq/O7N8ioEDifOCOqXqWf6PqxkC1mse1jS4esRJjM0Dd3k6Un
 Z48CSZl9wmUekpEJPO6nlPjuCMJqcQ/7g2h9dWnP/nk/cwjYQGktyS33oqvt4ETK7voPtojN/oX
 zgM/eTQK2ZiUW01sZliXbw9OE/leCjQip1fASO1om1sJ5yNCBzpgSZI50ikTolj3bR2ztxhueK4
 vTJLVWpZIc3Bfa3nNfbL4B1hk93Xo8bNBTdf5oZFzOq21FUV1M4LXwqUhspgJU6nHnBFnfuoMbg
 cCDGvltv8mG2Or3KewVrEGnJNyJC2zXmOTuVJ0O62p7Ut1LKO+8cUkCHFJ7IiSms9D2l45G6K7f
 aS25VP528RBKHVWDLpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604250110
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

On Thu, Apr 23, 2026 at 09:03:29PM +0200, Nicolas Frattaroli wrote:
> The new DRM color format property allows userspace to request a specific
> color format on a connector. In turn, this fills the connector state's
> color_format member to switch color formats.
> 
> Make drm_bridges consider the color_format set in the connector state
> during the atomic bridge check. Call into the connector function to get
> the connector state's connector color format. For bridge connectors
> including an HDMI bridge, this will make use of whatever the HDMI
> implementation set as output formats, and AUTO will never be part of the
> rejection logic.
> 
> Reject any output bus formats that do not correspond to the requested
> color format. DRM_CONNECTOR_COLOR_FORMAT_AUTO is always accepted as a
> matching color format for a bus format, meaning that non-HDMI bridge
> chains will end up picking the first bus format choice that works, as
> has already been the case previously.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 64 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 

Nice, generic and easily reusable for DP!

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
