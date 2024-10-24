Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EFED1038D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 22:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D10B10E3C6;
	Thu, 24 Oct 2024 22:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mrvWoFH1";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A0F10E3C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 22:10:25 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-7eaebc773d8so187537a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729807825; x=1730412625; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCq+1SG2c930TQ3Eyt7YPnPyRORD9b0jn8krd/W8tJE=;
 b=mrvWoFH1JAGLTENgOB+UW0aeYEVqexHHtwa4WOvx/ANIMJsIfgMolVUTBmOmQu4cDh
 JesNhsSrVqowkXzbgPv+6EbThl4J1QphSV8A7JAJLAudvWFpdWUaDbN8nSsBNEt1YDNl
 owWx+p6rVVhx2CTguq6IE0I4aNjeblShUT1Eqe8BrBdJEDuDOtEq3Ljc+eCzh3Fz8GCf
 WZD/PBuUtZfSE4d4JjBeCkXuCfu4vwItMj1fAHi9OFgJ2LPLK+QBHTSGyxMcsp3J6/mt
 AD6UWL2IgxQ1LFcONpTVHbgSCeeSfxIA0Q6XizjIA3QYzjXlbkYW9+r2mi5uFhTRwagK
 vafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729807825; x=1730412625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCq+1SG2c930TQ3Eyt7YPnPyRORD9b0jn8krd/W8tJE=;
 b=JedPh16Xs9TwTIyUYj0g2asDy9EU82EqNo2Dibx6RxwrVk0Hdd3D1h7tE78sBrUmKW
 tMdiWkXcwuHvraet4uMNPrkRtyGwHvK9CTNdEabrRuTHt0jm2oS0NFbrj9iee210vTh9
 EpALfsqlCHppbupmUxGeFL7oI6m6KPrZnZxvJlsWqlCivaDR/f2cGumNKTTP+xxqRTI9
 B8TLDpOq7Wi5SqOi9ZwpMx0JC8JgNxs1Tal5OiZ8P6xu19B4/yDgL3+UN+fOeu/r5TJ9
 2sE251e8l10qKUt54TebDW0PdO3a55GbTKy4cKAZOeti+d57QTAdZpcn1jZUR/oTYC8i
 /16g==
X-Gm-Message-State: AOJu0YzAW9B910pBKkz9V4cGZZwcAKebIUxLsJn5PUnNmPTvk5Zsn3qv
 1Cudzfy4lP+ItZ9no36+BR9qSnoGHhq5nertnreXved0weSUA0aaqtbgeDdYV/tqxkkOX8VmU6W
 +H8NOD+W9/Qu7SHvL0bckRL8YlMNXwg==
X-Google-Smtp-Source: AGHT+IEa0Cg5sNGo1oVcAE1O7fR3FG5iJOyr3ZGDblAS1r1Hq/mrI41YDOCJ9xl9n9egUg1HJGIWZd047LxlClO+/UY=
X-Received: by 2002:a05:6a21:3285:b0:1cf:3be6:9f89 with SMTP id
 adf61e73a8af0-1d9789e6952mr4967712637.0.1729807824930; Thu, 24 Oct 2024
 15:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20241023132254.329135-1-alexander.deucher@amd.com>
In-Reply-To: <20241023132254.329135-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Oct 2024 18:10:13 -0400
Message-ID: <CADnq5_NmwEVFSXWF-ugssj7fO1RqWXt3CbngOsiqPQpgfOZpLQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/smu13: fix profile reporting
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

On Wed, Oct 23, 2024 at 9:23=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> The following 3 commits landed in parallel:
> commit d7d2688bf4ea ("drm/amd/pm: update workload mask after the setting"=
)
> commit 7a1613e47e65 ("drm/amdgpu/smu13: always apply the powersave optimi=
zation")
> commit 7c210ca5a2d7 ("drm/amdgpu: handle default profile on on devices wi=
thout fullscreen 3D")
> While everything is set correctly, this caused the profile to be
> reported incorrectly because both the powersave and fullscreen3d bits
> were set in the mask and when the driver prints the profile, it looks
> for the first bit set.
>
> Fixes: d7d2688bf4ea ("drm/amd/pm: update workload mask after the setting"=
)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index cb923e33fd6f..d53e162dcd8d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2485,7 +2485,7 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,
>         DpmActivityMonitorCoeffInt_t *activity_monitor =3D
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>         int workload_type, ret =3D 0;
> -       u32 workload_mask;
> +       u32 workload_mask, selected_workload_mask;
>
>         smu->power_profile_mode =3D input[size];
>
> @@ -2552,7 +2552,7 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,
>         if (workload_type < 0)
>                 return -EINVAL;
>
> -       workload_mask =3D 1 << workload_type;
> +       selected_workload_mask =3D workload_mask =3D 1 << workload_type;
>
>         /* Add optimizations for SMU13.0.0/10.  Reuse the power saving pr=
ofile */
>         if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
13, 0, 0) &&
> @@ -2572,7 +2572,7 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,
>                                                workload_mask,
>                                                NULL);
>         if (!ret)
> -               smu->workload_mask =3D workload_mask;
> +               smu->workload_mask =3D selected_workload_mask;
>
>         return ret;
>  }
> --
> 2.46.2
>
