Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1624CC83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 17:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A072A10E2CA;
	Wed, 16 Jul 2025 17:44:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WcrmU+8O";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2966810E2CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 17:44:08 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-23de2b47a48so61855ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 10:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752687847; x=1753292647; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BoAwH8zwkO2O5sH+ozWmhN2+ueP4QnaK+aO4oidTs8A=;
 b=WcrmU+8OAF0cSUkZaur+sSNhWcsW6lqCn45Zu8m1iDfqNChnrIazVinccc0t9udJM0
 xpVNlIEGCDz7QX8U0j6MafZqWKc8C0Ok2G/uI5IdjGvD8LFa4bYCL1GR45V2gc1CeVA0
 8wn9Ni7gIixbeIe4pi4z50sEpEzWBV4jp787COzlZehHXh4uvZpHnhRK7pS3EeSJFDY2
 1x22MlYy8Vy77euBqgdaFzZFM8ugjUAWSwGPmRsjGsLdOiwj+FpTS3/QBI78DRUvIHVm
 5eVNuNqwcSJPRaWx5PvoSN4G5LtGxCm/C0itO4bWCyyDwDEIu1cEuoC05x9cHTWFkR6A
 LfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752687847; x=1753292647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BoAwH8zwkO2O5sH+ozWmhN2+ueP4QnaK+aO4oidTs8A=;
 b=jdz5fSH35RLLc9IX2GNoWSt1lanBGJJy6zPCiPNpc0D96x/Drw76Zs3uBpb6H5A/G/
 m/EEPY4TFFySpXUWXjJg5ZfvL/xqY3oZ3GcaVbcc+JS1IY3KNYmcVNTLRm9sS8fCmZwA
 AHvEll0st7hFlgc/ubAOoGaJbFBkyy1bd7DuzLPADdA3V9BwZU/Met1JEQ5aHYX8kesh
 Px7DQEBMUe0jn8MHrfxR4I7bhC5woiwNkMoD5SRHkqVpO3LwYO6VPFZxdSz6U5c+nnwo
 RqbDVTQV5xoHrD+QC+YdFBRLcYJzLalWCTnsBlux/W+4Mmls1loDpXrdQ0loSU4SrhEh
 0m2Q==
X-Gm-Message-State: AOJu0YzbP6hxlXnf3J7kmqVro6ovtwBcft4I11hcD1PrCEiUy7tnIApC
 QkdvxwKGQP4ImN7oDJfIPnmebRkb9l7IPI65r97Yb8jaiR+NeXxaFei9JhxdIwEZ8aMFBMfrQVm
 RYSumO4L66427sNuU/B6YVm9J/B5r0Ps=
X-Gm-Gg: ASbGncshOEVifb9yNMO78N6G1g7SxJ6NN0zfT60sl6dHBdCBXpkVO+9YbXEZf6q8FC6
 ZXybjiuQSc+TZSNC3SEv/ay6/sDmAnsUwxEYmh1ODph1ZbX/7FrO2Z+eIBAVyrwWAtHhB//A9fC
 IyPL86vVRVZlAWUYxDwUa83DZpGI7dax0UW98ecOIDZikvSmJJvpInOrACe5NINLFlB17E7GOoh
 D2hQWIO
X-Google-Smtp-Source: AGHT+IFjNWlzKnADALrZfioVML9ezN01uTADcDm28b/dyOh6SwUVrhTVlknIdStQ4bM04/5go1+hfrcx/WbzqWF4Dc4=
X-Received: by 2002:a17:902:db02:b0:23c:8f17:5e2f with SMTP id
 d9443c01a7336-23e24edd929mr23568455ad.4.1752687847419; Wed, 16 Jul 2025
 10:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250715144315.26642-1-coelacanth_dream@protonmail.com>
In-Reply-To: <20250715144315.26642-1-coelacanth_dream@protonmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Jul 2025 13:43:55 -0400
X-Gm-Features: Ac12FXze8YkbMSqr8FOqFVEdBRkUeNUaHvC02cqWZHTFOObYUdM5OCZrgkRDITw
Message-ID: <CADnq5_P-yjsAsqckS=RQacr0T=oF1MDWeO4RA9nGzyvyUXDvPg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix null pointer access
To: Umio Yasuno <coelacanth_dream@protonmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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

Applied.  Thanks!

Alex

On Wed, Jul 16, 2025 at 3:28=E2=80=AFAM Umio Yasuno
<coelacanth_dream@protonmail.com> wrote:
>
> Writing a string without delimiters (' ', '\n', '\0') to the under
> gpu_od/fan_ctrl sysfs or pp_power_profile_mode for the CUSTOM profile
> will result in a null pointer dereference.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4401
>
> Signed-off-by: Umio Yasuno <coelacanth_dream@protonmail.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> Thank you for your comment. I just fixed the patch message.
>
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index edd9895b4..39ee81085 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1398,6 +1398,8 @@ static ssize_t amdgpu_set_pp_power_profile_mode(str=
uct device *dev,
>                         if (ret)
>                                 return -EINVAL;
>                         parameter_size++;
> +                       if (!tmp_str)
> +                               break;
>                         while (isspace(*tmp_str))
>                                 tmp_str++;
>                 }
> @@ -3645,6 +3647,9 @@ static int parse_input_od_command_lines(const char =
*buf,
>                         return -EINVAL;
>                 parameter_size++;
>
> +               if (!tmp_str)
> +                       break;
> +
>                 while (isspace(*tmp_str))
>                         tmp_str++;
>         }
> --
> 2.47.2
>
>
