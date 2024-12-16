Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736F7E77180
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 15:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2973C10E6CB;
	Mon, 16 Dec 2024 15:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M7NnomM/";
	dkim-atps=neutral
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C88D10E6C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 15:12:21 +0000 (UTC)
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e3824e1adcdso2856406276.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 07:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734361940; x=1734966740; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2ffQGy2TMqwM/P0ea5bqOaj/0Pbat+9jyPLZz6qR+vM=;
 b=M7NnomM/w4/0mJaaprCVRm9lS45FLGSJzJjV6CI/qNfyqdCZByQg8IVLArVWe1rxJ+
 /gYk2RDlsdyD4MFoG2iPXYcGNC4LfWiHpQSenpezPTafWGytN10M33LWvKzR2QZp462y
 C1Q0ggwydzPH3ruv0+9Un1BN/kzNgmrtXBZn3G+UeMAXpUsO1tJrUcpeHxdaW3FiJdN+
 VKErcafLgBVoOU9+vOzyYZGJnGP7r3gyAmbpLLx0jbmq08RSJFxP2+Hz94w4jW6/PRNV
 A+mRXmsE5jSiVxKrmLcCCYLRa04yeHgac58p6L9Y055FOrnUQQ5rQQuNviumuT47R2Xi
 Hhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734361940; x=1734966740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ffQGy2TMqwM/P0ea5bqOaj/0Pbat+9jyPLZz6qR+vM=;
 b=V1r2NC+qgt+LvJqcGsQUP/s1FWXz9iZBx49V26nHTymGj71BEALg7OpjwyiAxHy0Hg
 amlo3qlWBssykCBiBYdY5ylJP1AVyP2shjZyrLZJMRvPBjPAxkrtcivQQlS5VcQfpZvm
 b/ITJvU67LptrpJdZzF6gjIrtXrqkm02HAKzf3O0sSADV0i47Br9MNNODNXCs2BAVd6Z
 7e8q2I+0vR4WL1sBB0d8yYig1lJ+hNasBtkLbRdBRi8jdwraVyXoIoHAfdlqT8Yj/jGz
 sw3/5N3z73OB2bpwBIeiEhPABA1DT5eLkwgyJ3ajeqJDk6kxjeS1oDVh/E/HgRrklxjH
 QUhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHaPkCtOUpzoEAtfG5Grdhu39auE0w6ydrskF+wcci4VI6nPc9EVDZ3s0RejrZo0NSAFYp3ZQI@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8jSFSaXRd/h3sWqkSlq8XDh28aMWG+TvOJs6r4HVTWjFh6rRJ
 e7PLv54rfEJb/pgAwLQNJbikleMKn6rIRoVZJZfXzIBQAvic/74blxoVjQ5rgL0nmirqdWirtB6
 5pndnFc9XcqQIe9VGC2dZEEfm6DiysEfgONM/Ag==
X-Gm-Gg: ASbGncs0lnGQ9iWBDaP6aSrvjFqiqYZIEhQQbhz/7cJsIlNVs8gOdCkujHMaCNU2SjH
 HX40hSqooGZdyqi2XSEyQjO6HVuNaY85d7DRRK9wxISk2s3hzNymA
X-Google-Smtp-Source: AGHT+IFkMt1zHDB2S3QiYdScTiiPg+ltfkwwZwvvoVehY7huEV6zK2tbYbYSsx3gC5GsnfCaH/SlaLvHa4pCCl1Vu/Q=
X-Received: by 2002:a05:6902:3301:b0:e47:f4e3:8804 with SMTP id
 3f1490d57ef6-e47f4e38da5mr5451800276.24.1734361940405; Mon, 16 Dec 2024
 07:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20241206-drm-connector-eld-mutex-v2-0-c9bce1ee8bea@linaro.org>
 <20241206-drm-connector-eld-mutex-v2-4-c9bce1ee8bea@linaro.org>
 <pgi7p3aemxm3db2k27vi5euh6q6ppayrw6y7tcfeq4g5z23hzr@xousag2qhobp>
 <fc8e80dd-bcea-4515-b446-158649719569@amd.com>
In-Reply-To: <fc8e80dd-bcea-4515-b446-158649719569@amd.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 17:12:09 +0200
Message-ID: <CAA8EJpoR8HYq9ATDfmR5ksSnttBzj=DY+BKp5=OuVNF1WDJ-fg@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] drm/amd/display: use eld_mutex to protect access
 to connector->eld
To: Harry Wentland <harry.wentland@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Phong LE <ple@baylibre.com>, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 16 Dec 2024 at 16:53, Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2024-12-10 16:20, Dmitry Baryshkov wrote:
> > On Fri, Dec 06, 2024 at 11:43:07AM +0200, Dmitry Baryshkov wrote:
> >> Reading access to connector->eld can happen at the same time the
> >> drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
> >> order to protect connector->eld from concurrent access.
> >>
> >> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> ---
> >>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >
> > Harry, Leo, Rodrigo, Alex, Christian, Xinhui, any response to this one
> > and to the radeon patches? I'd like to be able to pick the series for
> > drm-misc and these two are not reviewed by you.
> >
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 19a58630e774029767bf2a27eb4ddf17e3c21129..04c68c320252b5ce9647f0606fb86fe57f347639 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -1037,8 +1037,10 @@ static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
> >>                      continue;
> >>
> >>              *enabled = true;
> >> +            mutex_lock(&connector->eld_mutex);
> >>              ret = drm_eld_size(connector->eld);
> >>              memcpy(buf, connector->eld, min(max_bytes, ret));
> >> +            mutex_unlock(&connector->eld_mutex);
>
> All of this is wrapped by the adev->dm.audio_lock mutex. It might
> be safer to modify the audio_lock mutex so it only guards the
> aconnector->audio_inst access.
>
> But I don't see any way these mutexes would otherwise interact,
> so this change should be good as-is.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Would you ack it to merge it through drm-misc? Or would you prefer to
pick up those two patches after merging drm-misc-next once the rest of
the series lands?

>
> Harry
>
> >>
> >>              break;
> >>      }
> >>
> >> --
> >> 2.39.5
> >>
> >
>


-- 
With best wishes
Dmitry
