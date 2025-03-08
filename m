Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252C3C28B28
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Mar 2025 00:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0699910E0E7;
	Sat,  8 Mar 2025 00:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qxfqLXGn";
	dkim-atps=neutral
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2834D10EC52
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Mar 2025 00:00:31 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-30bf7d0c15eso11508061fa.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Mar 2025 16:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741392029; x=1741996829; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AEwMiLzCyICEunJ5u9SkRaghHLUa2TZbSRFS1CMQbNs=;
 b=qxfqLXGn9y/WjSWkyNIBD4GGTZ4shSXhq6NUq99xu6C85uuURdghgpDvN6Q9VkCVWZ
 uu0v0yRM8xSCUcOWOr2/J2FL8uY7/t9+TqbJUoeGJGxnf9oREkXcIFCxgqwuL0ljWAOv
 0awkRvip1B7xcO2qmmYth7hay0Nkdzvjwsfdfu5qh8jNaUWRhpglIKN7YhKs03T+I2N+
 rmF1pnqzr1xrErkRK6OpXPoyzD4q5o9IpWL4p1vBZOA7yU6Qd4v9aScm7dXCgKmZD6EU
 NGoXGiA864nXpPb7GiYMlv4rUsSJSdQ2fkzO+HhSHJvm2UjSBSOoPNY2J8cHkLfp3kh1
 OFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741392029; x=1741996829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEwMiLzCyICEunJ5u9SkRaghHLUa2TZbSRFS1CMQbNs=;
 b=ekt74YR+gqJ3MOQpakgdAIdXQDk1aY2w8xrqDQ9WXo0I608zAoeL2VUyU5cfr87nNr
 lAMGQt1gA2vllWbq+ZYee2NSVOoPjW/KGqPVOK3fvd8l5dz/7O3F3bTnUo3tMfvXfX9u
 gZUNsm7stuTU/TPaMsQxvRuOcGV+Oi1sbsXr7Ow1/Mi9ems810BXB4rNx+0io31PPc9v
 kqu134+PFFUHAjv1xnxq3hos4+EWmQs7K31ZAr2Ll1ZYXk5u8Q9zzPKVCvmcD77sVDvt
 SoSP2ctVUs3o2bOfHp/fMcG+npegZF+OHFt0MOePRSokGeuyOmZhA9tGKRe64zlTpBgE
 9WCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWJW/Ykx3Wbchm46owpgg3NjoypwCjjhkvHppqAKbl0HgtPx3yZNwUQapNaMQDpCGUfYSh6vB+@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyk2ZF64IMYhJgpRHQlUYjgoeV60dh70kC58tpkkxm+5Ym2cWT6
 HQJq6kLf1eUkhO7PRz9C2mxCV53VjUonGY9Eiolr/KlbAEmUBOrTpvaH3k/wpWw=
X-Gm-Gg: ASbGncuKSHk+iial6eKIYpz3xChoDXkY/nzUxXSXUeCOEHVLEwgXlSfKBuM1J4CyH+P
 yWMB48St9/VDXgusJXhCzc4RECC7qLRHbvpBO0K1A9VLxwjh74HhapLBLiTzTqTbmjuJ+C7b6bP
 BBdv5kBscUhIpCDQOcktUzyc/8m1R5O2gH+4BynDoA55nUTllIorDuLIKV9OBZzOoCkdsaUTce8
 v7Q0e/N5EmjYTPgu1sjfHmQ82IndKlosbB0V3aFREa1jrGNrDpCiYW9ofNeQOZysF/sKtV0cnqX
 q8evFYV4H+nsJLj8KO0PzGJ/8aRbjTNm4aeuC9dGS/6218t3VgJ0p1xWTot8ZfyxbRy2vpEumb5
 UBkj97blQ6ZS8ZUWwtI1I7IOp
X-Google-Smtp-Source: AGHT+IHp+tbCuGTMiQOtkAJeNqJU+GLHRyHQrcNbiQ0L6CepcDGTgtUgqeherQpSU3yjAqkm/DxJgw==
X-Received: by 2002:a2e:a78a:0:b0:30b:c3ce:ea38 with SMTP id
 38308e7fff4ca-30bf43b45bcmr21229201fa.0.1741392028923; 
 Fri, 07 Mar 2025 16:00:28 -0800 (PST)
Received: from eriador.lumag.spb.ru
 (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30be99c815fsm7131741fa.69.2025.03.07.16.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 16:00:27 -0800 (PST)
Date: Sat, 8 Mar 2025 02:00:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Lyude Paul <lyude@redhat.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH RFC v3 4/7] drm/display: dp-aux-dev: use new DCPD access
 helpers
Message-ID: <ytsczbxfokt4yz26w5zl2rxtuagrirdpi6uyxnt4itcllrowuk@wqqcgkr7b52k>
References: <20250307-drm-rework-dpcd-access-v3-0-9044a3a868ee@linaro.org>
 <20250307-drm-rework-dpcd-access-v3-4-9044a3a868ee@linaro.org>
 <3284acdfa43fa62e7230355b4ed2e09ab75f326a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3284acdfa43fa62e7230355b4ed2e09ab75f326a.camel@redhat.com>
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

On Fri, Mar 07, 2025 at 05:53:38PM -0500, Lyude Paul wrote:
> I thought we had agreed that drm_dp_aux_dev.c was one of the few places where
> we wanted to keep using the old functions here?

Hmm, I thought I dropped it.

> 
> On Fri, 2025-03-07 at 06:34 +0200, Dmitry Baryshkov wrote:
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > Switch drm_dp_aux_dev.c to use new set of DPCD read / write helpers.
> > 
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/display/drm_dp_aux_dev.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 

-- 
With best wishes
Dmitry
