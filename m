Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3D0C87FD1
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 04:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A757210E46A;
	Tue,  5 Aug 2025 04:58:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kzt5V+6x";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7467110E469
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 04:58:14 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574Gmwmd011524
 for <amd-gfx@lists.freedesktop.org>; Tue, 5 Aug 2025 04:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZJk8ZPcKnOpx2SNNbdPGbHCx
 Lccj6TZBqXskHVjiVyc=; b=Kzt5V+6xQ4sPGQZHZZzOITFZ/wk0ZUSxsrZL0Vnp
 Xx1l01K2Gu43cr0/LJFnlvqqBsMZVzzkKApUXwa+gkvaZyfRb+LckZUXlnS2xeaa
 gc/UB7HiQAMs0jcn35W7ZNKSvcBqC5D8Zp+uQY50gOwxMCyxWylqdHi/tw3PlD0/
 6nm/gR0Az9SnA620lLuc3hPNoySvKw54dIVv9M2lSBDJYEK/qwWd+ngG4jL75hL+
 u0qjloA8qwCPjIkElxnwGXW4gnzohY/0A2PdtmqjoE/Aii48Ik0TGNxr1tonRnNB
 pLAkMIuntt06gt4WqMEXjC7JW5w3W8VkvRnUnkVbU+OinQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489buqq75u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Aug 2025 04:58:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7e6857795eeso1100640685a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 21:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754369889; x=1754974689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJk8ZPcKnOpx2SNNbdPGbHCxLccj6TZBqXskHVjiVyc=;
 b=tPY+tSgWrjBj8NyE/usqNXuagSSASwbJJuf8eGIeTLnOLUteK3CRHaHxjK00jijRCe
 Pz+lWwPWvl2xfeIkm+cnYcMchwYoXnRpEGqXkj4INa3exwU9gPORmK4GuJVqx1Ckzwzo
 u7NCdRbj1KxGruoi3bIKrG7HwoqkyHvTBAD0nNWCS1XXCucCS7CpMNlPtGNBKyDgFGKa
 8PmrpRs51gt30fBMiNlpwfgov1zF0AVQY6NJYvycZrysEGQr76NhGfOz6GV8K7jw9pZ1
 OOEzA/rL1AMfk3ZvZ3/OveYkIx8BbO+EAOyYVf0qDyRZRVEOqR5ZLl6cmZk9BceebeA+
 kaNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVykuAb2qbLdA7VrRyxVrE938S1K2EfZeTb7U3xglyKwkkX/oIACKG4y1kzk2ckzOf4hGO5WV38@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIW2Jz89RIE08dNxoFIqvsVEjzYN8zwSUmSacKRdHynk2gw5xS
 PGn3seMeBQ3620WaLPFb4hXIViiZi37xfc0o/bmCe1zY6xW7JathXrhx2PgOUDWKxL8iX141Rqj
 2ehxsG9PpK71BIs2/INvjqx23eAv5OtME2uOk3jQNCHc98XSONU+rUyvodpq2CMKryWwt
X-Gm-Gg: ASbGnctRD+cNggl5jcwYqBEuL1UM7EtJeNlKjKf127H08TpJEFiG2m+26Hv4UwLqQAx
 ymlcZ2ZB+29rF+EGK8nnHcYBDsXSbmHGfQCyG2G0S5/s8q6Tu16BOiT4jJRdOnXt5WLxgbEJ0KV
 emQgCmYs+40D3hE9Ofsxgo+0PntGm+iQulTK/KWoF6SeXQ3nSvkOc8Cgbyr3KNDytW6ae+szlwl
 LHD/k+JTOMspkWJamDWvFR2+0uB7G1rI8wY2r+nq5Ipi6IJ3GY/z3yudDNsfPehtaP6Zx6yhmNn
 SrWODqAOiJwtwqTGnJVgc3xJzvSWKe/F0fAUA4VX14rqMkJDuUqrFJHXC3qVw87mNLYXiTYyl0j
 YuaMnAGjkU6EvUdt87xHAVgVTVCUGLZLvua/+yPedTQJy00P60qdU
X-Received: by 2002:a05:620a:a512:b0:7e6:5ef5:846b with SMTP id
 af79cd13be357-7e6963b8367mr1194540685a.65.1754369888912; 
 Mon, 04 Aug 2025 21:58:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsXtKxDheFJG11QuYaCVPiIu+728m5NKJMdNbg0+TAMsOq+9gDo86NZhO5c8LUFYsWbjmH9Q==
X-Received: by 2002:a05:620a:a512:b0:7e6:5ef5:846b with SMTP id
 af79cd13be357-7e6963b8367mr1194538285a.65.1754369888391; 
 Mon, 04 Aug 2025 21:58:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b889ac54fsm1866911e87.62.2025.08.04.21.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 21:58:06 -0700 (PDT)
Date: Tue, 5 Aug 2025 07:58:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/8] drm: writeback: clean up writeback connector
 initialization
Message-ID: <pwnrvebmf77p77z3pn53kzivy5t5qglh3ngdmj33f7i7v5r4jg@sseokeuqindn>
References: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
 <aJDHAF69VOEHwcKO@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJDHAF69VOEHwcKO@e110455-lin.cambridge.arm.com>
X-Proofpoint-GUID: 9XITv37_0m5ygC0r-Y54VrOOfs3wvFa8
X-Authority-Analysis: v=2.4 cv=VZT3PEp9 c=1 sm=1 tr=0 ts=68918f64 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=DSBK3S_xfJQIu1nZ6GAA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDAzNCBTYWx0ZWRfXycIXdnObNEc6
 IQ19inLkaVun2RL4qxb/Sa+XKaO6LvbEbo+yFybyz25GMGRxwE5yW4mALxBxIjE9qG1itc69YrD
 JFtKNkB6YWJ1tRA4uINSdI3Fa+1DQEJNgjT5uh0z5CBG+erSEfvM5zbEhD8Pxt9OA2Ks4NyRljY
 675g7vzVRp4APlto+mn7wKC1dPHKC6xSvgyG8K7q94/obPNGUclYosL53kpL6SFFf08snfsgr9z
 KQyP0xghSyUPNpZB+zrkToFdZPEzSSUUsKxhZaUPmBM/aYhQ8+wljBDYBBNwx/L2dGdtJq8VK6M
 4q0jXL8MaKFogofqBC0fisHrhFnmkeD+WNOBk4W90ZusoNhjgyZNN0dHKbI0r1dGVRqn+3yR7Yd
 Tf6ynJ0IZP7QvhTKsOCdfmT50IksiLdjaYclxsL0KFsGBKEDP4O7GzuIy8neIzsIbFZi9MLB
X-Proofpoint-ORIG-GUID: 9XITv37_0m5ygC0r-Y54VrOOfs3wvFa8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050034
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

On Mon, Aug 04, 2025 at 03:43:12PM +0100, Liviu Dudau wrote:
> Hi,
> 
> On Fri, Aug 01, 2025 at 04:51:08PM +0300, Dmitry Baryshkov wrote:
> > Drivers using drm_writeback_connector_init() / _with_encoder() don't
> > perform cleanup in a manner similar to drmm_writeback_connector_init()
> > (see drm_writeback_connector_cleanup()). Migrate all existing drivers
> > to use drmm_writeback_connector_init(), drop
> > drm_writeback_connector_init() and drm_writeback_connector::encoder
> > (it's unused afterwards).
> > 
> > This series leaves former drm_writeback_connector_init_with_encoder()
> > (renamed to drm_writeback_connector_init as a non-managed counterpart
> > for drmm_writeback_connector_init()). It is supposed to be used by
> > drivers which can not use drmm functions (like Intel). However I think
> > it would be better to drop it completely.
> 
> The intent of _init_with_encoder() was to be a special case for drivers
> that use their own specific encoder and the rest use the generic function
> that creates the virtual encoder inside the call. The API for
> _init_with_encoder() was actually introduced 4 years after the original
> patch, so that should give a hint.
> 
> drmm_writeback_connector_init() is more like _init_with_encoder() and
> I don't remember reviewing it, so I'm not sure why that was considered
> to be the better behaviour for the managed version. Now you're moving
> all the drivers to the managed version and you have to duplicate code
> in each driver to create the ENCODER_VIRTUAL encoder.

This follows e.g. the process of deprecating drm_simple_* /
drm_simple_encoder. The drivers are expected to open code empty encoder
handling on their own.

> I'm not against the changes being made in the series, I just want to
> see a better justification on why _init_with_encoder() behaviour is
> better than the previous default that you're removing.

This was triggered by the discussion of Intel writeback patchset, see
the threads for first three patches of [1]. We have an optional
non-pointer field inside drm_writeback_connector, which can be left
uninitialized (or zero-filled). I have checked and the drivers are not
actually using the embedded connector for anything after linking it to
the drm_connector. So, by removing the encoder from the
drm_writeback_connector structure we are tying a loose end.

[1] https://lore.kernel.org/dri-devel/20250725050409.2687242-1-suraj.kandpal@intel.com/

-- 
With best wishes
Dmitry
