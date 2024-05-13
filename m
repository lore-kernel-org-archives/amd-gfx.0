Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED853C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 20:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9333310E974;
	Mon, 13 May 2024 20:47:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OMA+G5Q7";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2966210E974
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 20:47:00 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2b4a7671abaso3735104a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 13:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715633219; x=1716238019; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gyg5+sSAwTVVYZKpRyStVR6rlyD7mkf6vJfBogvLiSc=;
 b=OMA+G5Q7EbBcAo3OqI58hP6uX+0Ip24iGdyEboyWL6yPPnv/7cT9Z0vPahYyttXWT3
 G/HHmqNVSTDVZJkne9eqCaBlAbdfbCzL0w+bvwKzx1B3309wPo/Q6N/6Em599k/I60u0
 S8LKY7n/oxZn6OQb8my+XCxtxOueMwUhbjAi7L2KCOsTiT1HnzIlpRIecAldkM//FFsF
 d/rdxTMMU3jyqtGrDeGgAaA7DpRW37torU41WMZ7FAvnP3rBo09vuEC7jWtASvrOQBEn
 VBQ0q746Zmc5thtqzEGg+/HqXTQRcKZumOtXUhbfvC16/qKGcRgl6ZDv4XRDTAjluLId
 wj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715633219; x=1716238019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gyg5+sSAwTVVYZKpRyStVR6rlyD7mkf6vJfBogvLiSc=;
 b=pD8QUdN0cS1NW1IpbUSQ4Icwwc0BP6MWisVJmI3jhp4Fh6DuHx7RI7Tz/Z+IR9L1dp
 8ZL8OrRZut+UMwjjy0Jr4Zb340IrPh/Lmn6hcwb70hdlAvw/Ce6ZhFuwR3AdL03wdXUL
 nJ8k3NaNwRuy6/1Rj8YBxygpVl2Z6sawqEAe7yZYkYaN+ex71U9sB9oPxvze9ihTWCo1
 5xKhnzAIc0dB/07wJ19gGJ/0BEKpZjXnju0y+escc5SJsFsH2OMrKpvcd/JpD4u4FsVH
 lOhagaTNzSfnIEsvX+WLfipOL2nlOPskPbOBYRmU8Zyt5VyEAM5kkaO8G/gZv8kGnJrm
 zDlA==
X-Gm-Message-State: AOJu0YwVFI+Oq2GFW1feFJHnkxupbLMMcsAwwDqVOn/coBcqYb/Y67pX
 omhiMuc3wXURzwuS6G7Qi3kcRA5KqNPd0c8tK4L0qztrZJaMIki/OAsGYy0EcPQf0Der7LyTwkZ
 6aadbRwP4PFzFKsfDqJTgSut+Dto=
X-Google-Smtp-Source: AGHT+IGLOhZmLK2Gb3k8n4g9LtLzy27/O0Y1CDqxzdLCiJzEpQNIUMuNt8ECSPXfMa5TY2wr8gdVWSZCp/HA3QNE9Jw=
X-Received: by 2002:a17:90a:ea04:b0:2b6:c4d7:fda5 with SMTP id
 98e67ed59e1d1-2b6cc3410b8mr8967369a91.1.1715633219502; Mon, 13 May 2024
 13:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240502202216.3385044-1-alexander.deucher@amd.com>
In-Reply-To: <20240502202216.3385044-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 May 2024 16:46:46 -0400
Message-ID: <CADnq5_OYU5j6ozgacXHoMQ4qQN+NSgtcYEFxjskAYT23wjVeDQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: update documentation on memory clock
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

On Thu, May 2, 2024 at 5:07=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Update documentation for RDNA3 dGPUs.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index ec9058c80647a..9ad114e695e5d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -610,12 +610,18 @@ static ssize_t amdgpu_set_pp_table(struct device *d=
ev,
>   *
>   * Clock conversion (Mhz):
>   *
> + * Pre-RDNA3 GPUs:
> + *
>   * HBM: effective_memory_clock =3D memory_controller_clock * 1
>   *
>   * G5: effective_memory_clock =3D memory_controller_clock * 1
>   *
>   * G6: effective_memory_clock =3D memory_controller_clock * 2
>   *
> + * RDNA3 GPUs:
> + *
> + * G6: effective_memory_clock =3D memory_controller_clock * 1
> + *
>   * DRAM data rate (MT/s):
>   *
>   * HBM: effective_memory_clock * 2 =3D data_rate
> --
> 2.44.0
>
