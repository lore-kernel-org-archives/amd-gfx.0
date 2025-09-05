Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C06CA1010
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 17:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BBF10E30A;
	Fri,  5 Sep 2025 17:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CVTbItFy";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1833310E30A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 17:50:07 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-329e703d715so339446a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Sep 2025 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757094606; x=1757699406; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n00++ovb71M2DutWQ0Xw6FbHb91Ug7y+etWz6FrIF4E=;
 b=CVTbItFytLYOIIi/W1S5CIwPpAevHC6vACc6he/05zvGxL+VssyZHXBsTxJMpQJPDc
 x7Qtc32txZzGkDbHMzlWg4C4LbTHVufR0W3Q+Oov5SzpS82Rr7uFq6QOa94T3FTV0AQp
 H9RC9ps5ctooq3i3ds9D+6CwfcV3HF0NZFUlWqxVa1ayKw5RDmFGTYiDSjBOSTI0cnio
 1olFEP9KkiSGWMiBXQU+sTrKzoXR4QCf6cEvlWMkwoABtofOGV/IhI72NCYdNwfJtxAB
 YQi2lwcxW63hNfGz3LuxwOVqyeeUzHLVA45tFlfNvNM0aTpGTuxRyaX+1zwiey7n2jSS
 ExEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757094606; x=1757699406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n00++ovb71M2DutWQ0Xw6FbHb91Ug7y+etWz6FrIF4E=;
 b=wzAZ207fJN8KB+AyNTCcyeKYKVAQJ1UNSAnIIHHPVq/7EJx9UjxJ/WGhyny0/Z2B/6
 dXjKKjcQ/0uzunUhM46/ANhb+Z8hJE/U1/Nt99/jVjiCgBDdHwc/7DNBhBaZmYoioGm2
 IHItXR4LDnP1gvwUZ9v979MMlDau9PLFMG/DkXH9blIkCtEf89hOhzGBeMFOQukyfKDA
 xub2CpN8Kd0T5+OKvb4cun/vZ1xuR7U6lPTzVx+muS3lFrgpCC+hvYlUn/Qws4Vj2zS6
 uaiGIRbXFWUnX043oMVMTjVUVSjSyuFREke50Vv23HcAGXk2BifY9RfqYa+vYKocOTtV
 RBqg==
X-Gm-Message-State: AOJu0YyYd5Y3sQEDRrOGQZgvk0J0LprYpggXlGQ9nsHybvlmjP+SUO5w
 z9HqRExT+80LLjJnR4QdLDtt69VMoFZG5vD3GMUvUjaTE09zMEbNnflNson/T0M1ktr6a4uZQsz
 4J8W8Zc9Sp/hrzP6MKWxTtgQ13r1hSv95LQ==
X-Gm-Gg: ASbGncsmQniCB/i5iz0peokNiaEl3K//TRflIOXyCDAI6yVm9yNdfTs0OXz/rlPW/WY
 +eAB1OE4ubpFsyj4scXxmYZ5Ydsl72VaUD8BBPFUN9vVAQW56qRIa0zOjvpIdWBfqd98fi76lnP
 6DRjw5P4rHORYQGwU/Iz8MpSgzjqJ8r2oTs3fjNYxicFoR2xlBBbFGzD3XlQBjVdGJYLrx8laae
 O0PXk4VICwq0pXYaQ==
X-Google-Smtp-Source: AGHT+IGDUKR6dY8wwS5BDPdNyjhlLyHMa+vdj1VVCCzIMiDy/WxAxC43PXmjuk7TW5KL1F0j9H/rg3+AqqR3hdXUIhI=
X-Received: by 2002:a17:90b:4a52:b0:32b:92d7:5cb2 with SMTP id
 98e67ed59e1d1-32b92d75f3cmr5550209a91.1.1757094606346; Fri, 05 Sep 2025
 10:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250905174118.3493029-1-mario.limonciello@amd.com>
In-Reply-To: <20250905174118.3493029-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Sep 2025 13:49:54 -0400
X-Gm-Features: Ac12FXz4FOdXxfQy80sm3TMmCgXpeLKP8-ppcmFDOgaVwEtbtdIQWNL9IbwYkdw
Message-ID: <CADnq5_POMonCMXc43eJXOuAvJX1B_h-dVG5xpJCGrYKKa++Pkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Drop dm_prepare_suspend() and
 dm_complete()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 =?UTF-8?Q?Przemys=C5=82aw_Kopa?= <prz.kopa@gmail.com>, 
 Kalvin <hikaph+oss@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Sep 5, 2025 at 1:41=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> From: "Mario Limonciello" <mario.limonciello@amd.com>
>
> [Why]
> dm_prepare_suspend() was added in commit 50e0bae34fa6b
> ("drm/amd/display: Add and use new dm_prepare_suspend() callback")
> to allow display to turn off earlier in the suspend sequence.
>
> This caused a regression that HDMI audio sometimes didn't work
> properly after resume unless audio was playing during suspend.
>
> [How]
> Drop dm_prepare_suspend() callback. All code in it will still run
> during dm_suspend(). Also drop unnecessary dm_complete() callback.
> dm_complete() was used for failed prepare and also for any case
> of successful resume.  The code in it already runs in dm_resume().
>
> This change will introduce more time that the display is turned on
> during suspend sequence. The compositor can turn it off sooner if
> desired.
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Reported-by: Przemys=C5=82aw Kopa <prz.kopa@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/1cea0d56-7739-4ad9-bf8e-c9330faea=
2bb@kernel.org/T/#m383d9c08397043a271b36c32b64bb80e524e4b0f
> Tested-by: Przemys=C5=82aw Kopa <prz.kopa@gmail.com>
> Reported-by: Kalvin <hikaph+oss@gmail.com>
> Closes: https://github.com/alsa-project/alsa-lib/issues/465
> Closes: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4809
> Cc: stable@vger.kernel.org
> Fixes: 50e0bae34fa6b ("drm/amd/display: Add and use new dm_prepare_suspen=
d() callback")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> NOTE: The complete pmops callback is still present but does nothing right=
 now.
> It's left for completeness sake in case another IP needs to do something =
in prepare()
> and undo it in a failure with complete().
>
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 -------------------
>  1 file changed, 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e34d98a945f2..fadc6098eaee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3182,25 +3182,6 @@ static void dm_destroy_cached_state(struct amdgpu_=
device *adev)
>         dm->cached_state =3D NULL;
>  }
>
> -static void dm_complete(struct amdgpu_ip_block *ip_block)
> -{
> -       struct amdgpu_device *adev =3D ip_block->adev;
> -
> -       dm_destroy_cached_state(adev);
> -}
> -
> -static int dm_prepare_suspend(struct amdgpu_ip_block *ip_block)
> -{
> -       struct amdgpu_device *adev =3D ip_block->adev;
> -
> -       if (amdgpu_in_reset(adev))
> -               return 0;
> -
> -       WARN_ON(adev->dm.cached_state);
> -
> -       return dm_cache_state(adev);
> -}
> -
>  static int dm_suspend(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> @@ -3626,10 +3607,8 @@ static const struct amd_ip_funcs amdgpu_dm_funcs =
=3D {
>         .early_fini =3D amdgpu_dm_early_fini,
>         .hw_init =3D dm_hw_init,
>         .hw_fini =3D dm_hw_fini,
> -       .prepare_suspend =3D dm_prepare_suspend,
>         .suspend =3D dm_suspend,
>         .resume =3D dm_resume,
> -       .complete =3D dm_complete,
>         .is_idle =3D dm_is_idle,
>         .wait_for_idle =3D dm_wait_for_idle,
>         .check_soft_reset =3D dm_check_soft_reset,
> --
> 2.49.0
>
