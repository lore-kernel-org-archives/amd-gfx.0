Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6D1C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 12:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84766A1C22;
	Thu, 11 Aug 2022 12:54:19 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0739113277
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 11:02:54 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id l21so7450326ljj.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc;
 bh=iwbijT25JOQabEJoAdZbUrL+K+nZlUlywCNjAPaRkPY=;
 b=Zwmv+zhwDMR2nSKdFJwP2quzKJ6loGMdS1t7skyjM7Np9UwvBEvxE06ihAie/nti4/
 diw7tb/KgC66OQQK6thMASgGBL0BBl5jJtfOlAFyaWnCzCsKUra2xCgo3eC6liJpPAlX
 iombHyCRKc/M6HnExt6By5qPTL9bSeEfccm4nS96YDwPAuj3qnRos8hU3C4VE09A+O0s
 OgyLJHo6Uq1ZGqoC+XdYzhesM/6b/GagdS7N6IYe/V3+fm5KMrMsOG5yrDi2RM6N4EU+
 ldv3wgvnqCU9DkoAzWQbGewePPsQ1LEKFFMG4HLp/o8Hmj+9EcuygvsNiQt0TNnN9ETn
 o7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=iwbijT25JOQabEJoAdZbUrL+K+nZlUlywCNjAPaRkPY=;
 b=oLNecQSkLixz11kZ3TytQR4j6++dp8mabaiZ+weCrDrr/ppVOcLe3SLS7v4gRgsiyb
 rayGh5PvHH91PpKt23iL+f5pkVU7HXu7jn/A8xrdapImOtjh5jBFnNwlnP+2Uw+hmsIr
 mwaWN/wXpKQTTwpauq7KbSAtLE714IisBfT7Wcn0jcbZLEzhA4IGbDG6i8c7l9Waki7X
 TNpvOSCq1xEhR5qs1kPALoVOZTsyhjDlclLhiH2Z1WhXKKjmS8Zf8LR7LD6zR6k40aQd
 71ksAZjxHqEKzzWbowNfBsnt5N5SVPX0AJFxQwigGV1Bsi9lQBWmfI8bMVbmgXPIUvCV
 Wptw==
X-Gm-Message-State: ACgBeo2rTxPKYVKJqneSz1xLn1yrvlWayi7nAkjKjmJeE2apHzvNa60u
 tve/Vxf4hlD37LRbLfskvUtWzg==
X-Google-Smtp-Source: AA6agR4ykeceqsDPELylN8UCyzrVw8F81lb8BHUuAicXDhJl8e5U6VRW1MUnNOJMxICZLpwoZ8cc/A==
X-Received: by 2002:a05:651c:3d9:b0:25e:505f:2355 with SMTP id
 f25-20020a05651c03d900b0025e505f2355mr10669447ljp.453.1660215772980; 
 Thu, 11 Aug 2022 04:02:52 -0700 (PDT)
Received: from mutt (c-e429e555.07-21-73746f28.bbcust.telenor.se.
 [85.229.41.228]) by smtp.gmail.com with ESMTPSA id
 q11-20020a2eb4ab000000b0025d75995a07sm781439ljm.24.2022.08.11.04.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 04:02:52 -0700 (PDT)
Date: Thu, 11 Aug 2022 13:02:50 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: Re: [PATCH v2 2/3] drm/amd/display: consider DSC pass-through during
 mode validation
Message-ID: <20220811110250.GA520@mutt>
References: <20220805211317.176672-1-hamza.mahfooz@amd.com>
 <20220805211317.176672-2-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220805211317.176672-2-hamza.mahfooz@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Thu, 11 Aug 2022 12:54:12 +0000
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
Cc: Ian Chen <ian.chen@amd.com>,
 Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
 David Airlie <airlied@linux.ie>, Imre Deak <imre.deak@intel.com>,
 dri-devel@lists.freedesktop.org, Roman Li <Roman.Li@amd.com>,
 Imran Khan <imran.f.khan@oracle.com>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Kees Cook <keescook@chromium.org>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>, amd-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@intel.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Leo Li <sunpeng.li@amd.com>, hersenxs.wu@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Claudio Suarez <cssk@net-c.es>, Thomas Zimmermann <tzimmermann@suse.de>,
 Wayne Lin <Wayne.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Colin Ian King <colin.king@intel.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-08-05 17:13, Hamza Mahfooz wrote:
> Add a mode validation routine for DSC pass-through. Both the link from
> source to hub, and the link from hub to monitor are checked, according
> to the current link training result and full pbn returned by enum path
> resource sideband message.
> 
> Pick up the minimum value as the bandwidth bottleneck for the end to
> end link bandwidth constraint, and check if the maximum DSC decompression
> bandwidth can fit.
> 
> Co-authored-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Hi,

Building an arm64 allmodconfig kernel from todays next tag, next-20220811.
I can see the following build error.

ERROR: modpost: "dc_dsc_compute_bandwidth_range" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "dc_dsc_get_policy_for_timing" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

When I reverted this patch I was able to build an arm64 allmodconfig
kernel.


Cheers,
Anders
