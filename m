Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E224EC3DA45
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 15:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D1110EA68;
	Thu, 11 Jul 2024 15:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DUq9AbjH";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1A010EA68
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 15:17:04 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-1fa2ea1c443so8324715ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720711023; x=1721315823; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cndaArC+WONfhfcBPuRxbjb5fy4NUXUK+ATLhKcVYGw=;
 b=DUq9AbjHGjF5N5lnWBKwebFyr1hrMdHr5O0zktgwoQQWN+r6erMhDqGDCV2YnElPHy
 lSmcx8UbgF5dKon5kD0zrDNut4QS1TF8xr66UUCQEZubi2lL/f8m8JNzn27mARX32iSs
 W1jYd9woo50RKFG43Zt/HYbiYolMYKJKzGS/JLfugkVl5ICeXtO7hK3QZcb9lKtJH07Q
 4Ej9k7HAHNr7TL1V0d4hGJA3IaL4b0FDAtQ1jW4HwmrJ33gi23Yz2EppsVeRu/5i5+oy
 oDwzyIviNU25+HUcbnBT0dGlkr5G8+U52Fa1FuTEOw1QmWAuZr0Rm6v6FwGw0wsuQAlZ
 FlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720711023; x=1721315823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cndaArC+WONfhfcBPuRxbjb5fy4NUXUK+ATLhKcVYGw=;
 b=uR58kEXeh3DC0KQuINUMkYejuqfvK/a50lMccIGZ60W0Bcpsq4IGTKXrbLIYzMJAr8
 KAT5JdHqi1mXjI0JUUS2YAb/a3zLgMUxBatvtMk1y7qYIcD1Bw9sNJDFAs8tk0xA7qRv
 +qarnk2sKB73SYXR2JHQ7iCYu9xi/r1XoovbeNhS9RyjxmQAy1Pdlh08im6/KxWv6iE+
 4boX/NGAD7RcO97Fh2OXKFXosmTPINYFvZgbu1bdiOtM08Df38N4v3yWkMvYlWtwahu7
 sntHkdQWQtMVF1o9lqKKoD6EOWuskO+9na0RHRTCXmP2FiU6QoATfBiPI6m8PQAQpCP0
 4hGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3xFWhhq6iZvAycl9GpnJVOHZxetO7hdgZcbhXO+tV9EK1dvdCbBLigglylUxq0apc4lDq0WLjT8+qGQZlxtWMm0Gq7aqrT+g3K/uVMA==
X-Gm-Message-State: AOJu0YwPCZF4xIcwe3YVWeqxKyzwF1+iT807YNb7Ko54BrDQZ1awypZN
 AUhFQEXkzDuPzblHpDhvlGHVcVPXWPydLWPbgPVKQnSH9HZjowpWq882Dgx47VwHzliBMZVGP21
 4t6NE0z8cGtp67rJJcArFgtMxT87ilQ==
X-Google-Smtp-Source: AGHT+IEcoqnjAY7g8oJ/rW4kbBBFG1FEZFjmu/c0E1Kgahgvoh627BrOykduV5+44tWw1JP/Zj6Q8pAYJP1NiaxXNT4=
X-Received: by 2002:a17:902:d490:b0:1fb:4f91:6728 with SMTP id
 d9443c01a7336-1fbb6d5fee1mr78618955ad.42.1720711023494; Thu, 11 Jul 2024
 08:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240711143109.13603-1-sunpeng.li@amd.com>
In-Reply-To: <20240711143109.13603-1-sunpeng.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Jul 2024 11:16:51 -0400
Message-ID: <CADnq5_OiZQ5P8SHePdwq81r9-i=jF7Xic9A6aRwMqvOcnq2+8A@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Reset freesync config before
 update new state"
To: sunpeng.li@amd.com
Cc: chiahsuan.chung@amd.com, amd-gfx@lists.freedesktop.org, 
 mario.limonciello@amd.com, Harry.Wentland@amd.com, Alexander.Deucher@amd.com, 
 hamza.mahfooz@amd.com
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

On Thu, Jul 11, 2024 at 10:40=E2=80=AFAM <sunpeng.li@amd.com> wrote:
>
> From: Leo Li <sunpeng.li@amd.com>
>
> This change caused PSR SU panels to not read from their remote fb,
> preventing us from entering self-refresh. It is a regression.
>
> This reverts commit f8ebe6341a6a3745ef02648b4b5c2c89fa4a9ace.
>
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d1527c2e46a1..19307d0024d3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10463,7 +10463,6 @@ static int dm_update_crtc_state(struct amdgpu_dis=
play_manager *dm,
>         }
>
>         /* Update Freesync settings. */
> -       reset_freesync_config_for_crtc(dm_new_crtc_state);
>         get_freesync_config_for_crtc(dm_new_crtc_state,
>                                      dm_new_conn_state);
>
> --
> 2.45.2
>
