Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD976CA5FC4
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 18:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C05910E284;
	Wed, 30 Sep 2026 18:57:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FysbeKaW";
	dkim-atps=neutral
Received: from mail-ua2-f42.google.com (mail-ua2-f42.google.com
 [74.125.226.234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E116110E284
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 18:57:30 +0000 (UTC)
Received: by mail-ua2-f42.google.com with SMTP id
 a1e0cc1a2514c-986e0b83340so3596043241.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790794649; x=1791399449; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2ZtFG6FaQjG/i5XO1LEXu5NyAdlTlgZvpK3ElwDNrH0=;
 b=FysbeKaW79acKTSakAf0YnHUHrYP3ahO36gGCycfIYHyu2+vy58ZvkZxGGKZkwSHuL
 dvyCIgN0HYU6XNiY0Yrout/D26iZsCq8ATswWngPkIF4L3RqPp07LsesmMsbmNHhTEUK
 JP4OjMTp6DSwF1JLOrioEWD32kLRXQCZfETb/qUoStPfhKrlGuiymOq8OeoAVhXxfmYG
 6RsXZa5GGJBe2ecfrALLS9bKDNYwC5qa/O8Uf+SqkKwUc4e3zKkdxx24+jHQjKd1ReTF
 +t3lkxR96ijyPL/+4Gx5sXbkMknCNeVAqV88nQvfdsEtGsI2MYBSF1MQcJ4CVylPe9Yb
 noNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790794649; x=1791399449;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2ZtFG6FaQjG/i5XO1LEXu5NyAdlTlgZvpK3ElwDNrH0=;
 b=J0kLv+GOqHgLRhJ36kmppPBfmoKC4Qn2Dub8Kli5vIqn8tU5ORSpYC8HkiOfswECZU
 YX2T7PchKOVVlGobtEeLG7UySZepbg/b/QAlLBqTxmK/j/OseSWhGcY0yLhkPyMlR66b
 Q9jvSYWQ1D761YynkGjy46QbG3f9HwMszmdRXD7ebbanCVYsN96KzfiSfsLN/FS+jvLH
 jTP+AqyttbrGKPBNzgHngL6i/6hvux/jBevD42Xylcz7udhE0H3eBu617PlSHv8/bpnn
 CEb7+D6ubPvs0GL95eUplwFyE3kYZnbzRjrp5qWOJQRe0tYDiaXj3NPwHggweu39a1+k
 3zYw==
X-Gm-Message-State: AFq9FYIivM4oab0d3zQWk+r1mhVm466vhpsSO49kuHybqHGWDGAY6Y9g
 gb2feJr+H5aBm/OcjWgzdc8AigEjtDPKy2XipEH0r8WVF9HygkNnRz5zxxYDJQ==
X-Gm-Gg: AYBFou0kUPw+RyBPYhOtt8xepb3C7wX1mnluN8vqyHaZrNufbkV9OHk4WuE/ZK5+svh
 qoF7eX7nm+mrwNesfWUwqy51bU6E5/n039JAdKI+JAgfXcrdlR9SepYpat2iu30y40Z2JPGs/GP
 nc9GvkdrrzkqNVdQpUyZd42rSVYJlcBLkX9/zPSp5Hm3h1/PXg8bpfedL24xTm2qiGqtWC/pFWX
 4J/+8hi86yUoBxHOw51uLwOwRQREXQ8nXD2HzGQwY21ICq02A+ffdcYe6TsmWJAhp4nnPw8LOR/
 XYo7+ljpIHNf3PP/FDV6+JiSpwjwM5p9c9MKjVlsyZ9h1b/RWW3y/MZ9/o8fApZyNy2bQagQr6h
 Zx1dHIxe4M8hYk84DgPfGOKfrxiD5xOQNB4GIsQNw8GogCSj+Y3cnEhp6cemxdp0lKksVOkpQip
 rX9eL0MMsgfZvMWOHhdP4wi2VrU6IvEXwdPK+yFr0mDI+Oup5pRXsdecJy+Yb1cGpzeHGEuVGfe
 Coc7I8ETcGF7KZ/SPh8b/J3c7BvHSlptgw7/1AwXguyJnf19I3ixt60gAh4hyM7ttrOcH8XdNFg
 CIy9Sqfl0Q==
X-Received: by 2002:a05:6102:6448:b0:7a6:c647:cf50 with SMTP id
 ada2fe7eead31-7be72eab3bdmr763211137.8.1790794649316; 
 Wed, 30 Sep 2026 11:57:29 -0700 (PDT)
Received: from timur-max.localnet
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7bfa70d3ec9sm176452137.11.2026.09.30.11.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 11:57:29 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com
Cc: harry.wentland@amd.com, alex.hung@amd.com, chiahsuan.chung@amd.com,
 ray.wu@amd.com, Leo Li <sunpeng.li@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: disable self-refresh on tearing flips
Date: Wed, 30 Sep 2026 14:57:27 -0400
Message-ID: <4c1BfmguQ8O9e4vVyhq5cw@gmail.com>
In-Reply-To: <20260930163222.557757-1-sunpeng.li@amd.com>
References: <20260930163222.557757-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. szeptember 30., szerda 12:30:52 keleti =C3=A1llamokbeli ny=C3=A1ri=
 id=C5=91=20
sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
>=20
> [Why & How]
>=20
> Immediate (tearing) flips breaks self refresh state machine assumptions,
> so disable PSR/Replay for them.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Patch fixes tearing updates on Strix Halo.

Tested-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c index
> 6e5dbe0bd82e5..d4c814eeb56d6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3764,6 +3764,13 @@ VISIBLE_IF_KUNIT void
> amdgpu_dm_enable_self_refresh(struct amdgpu_display_manage struct
> amdgpu_dm_connector *aconn =3D
>  		(struct amdgpu_dm_connector *)acrtc_state->stream-
>dm_stream_context;
>=20
> +	if (!acrtc_state->base.async_flip) {
> +		amdgpu_dm_psr_set_event(dm, acrtc_state->stream, false,
> +			psr_event_immediate_flip, false);
> +		amdgpu_dm_replay_set_event(dm, acrtc_state->stream,=20
false,
> +			replay_event_immediate_flip, false);
> +	}
> +
>  	/* Decrement skip count when SR is enabled and we're doing fast=20
updates.
> */ if (acrtc_state->update_type =3D=3D UPDATE_TYPE_FAST &&
>  	    (psr->psr_feature_enabled || pr->replay_feature_enabled)) {
> @@ -4218,6 +4225,18 @@ static void amdgpu_dm_commit_planes(struct
> drm_atomic_commit *state, spin_unlock_irqrestore(&pcrtc->dev->event_lock,
> flags);
>  		}
>  		mutex_lock(&dm->dc_lock);
> +		/*
> +		 * Tearing (immediate) flips cannot work with panel self-
refresh
> +		 * features. The event is cleared by
> +		 * amdgpu_dm_enable_self_refresh() once async flips stop.
> +		 */
> +		if (immediate_flip) {
> +			dc_exit_ips_for_hw_access(dm->dc);
> +			amdgpu_dm_psr_set_event(dm, acrtc_state-
>stream, true,
> +				psr_event_immediate_flip, true);
> +			amdgpu_dm_replay_set_event(dm, acrtc_state-
>stream, true,
> +				replay_event_immediate_flip, true);
> +		}
>  		update_planes_and_stream_adapter(dm->dc,
>  					 planes_count,
>  					 acrtc_state->stream,




