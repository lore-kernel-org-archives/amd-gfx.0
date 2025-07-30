Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1045C87FD5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 07:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE29D10E71F;
	Thu, 31 Jul 2025 07:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="A1WW7fok";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF1B10E45A
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 22:20:16 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 3429833AD35
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 23:20:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1753914014; bh=VFe9p015ScIXFiUtnB4KEjmtx4DIA5kZoIwCWD6o93o=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=A1WW7fokFy0bwUQbkjuYBWxnvyUrcBNYS7dm4efRVXWyrBXcjUnN/tpFTNWVx/IwD
 NRtwILD851gishy0dpV3MavPWDVOItzvqccuw2hyQryOj7iZeqLr2/u2g8GkcHoHc9
 hYrhqkJhhfofeNJghjAKCXf2V/cPp5m85dLYeIVVRuYqUO91YRaY/MLKjcXWzZWnP8
 3GtlMjr/ZmH3aTgmUabV6BohwsvetfEaJQTzPu6ENrkmDK2zbEGHgZfMM50WPvRd9p
 L+lK82Ij8Qws6wjRIDD2RbR38flWm8+XM746d6s9wxIwKtTd5ub1KmpwHLS1kuTbfB
 3R5AirlaCzj5g==
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-ae401ebcbc4so50758066b.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 15:20:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVA2Ppf+13K3NfXj4DI3UZQytMxYoLPz20XMf8XVECrlwbBslwvnG+1SMnd+OtN0leNWZxUVOjP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBUF+4Z8CwpU9+4kZxp6JAQzvKnKZNZ+fUdRfbOgTGE7kWXFQC
 gUfJLCIzxI04T57Nr3f0rbkqCEcK0eoEPSsoRasklSBcIQ1LGjovSWjwr9llRlkq1FZFC07r7eS
 TsyOZlnXcqlDVkofoG42/+Pff6lKY4Pw=
X-Google-Smtp-Source: AGHT+IGrMBZGy5sXw9fDxKrPXXODpJH0qzo+VZMCFtIwn5IPDMz8rz35sNaVWierReo4AF8x++Fwmg7nTN20Hh3ZZTk=
X-Received: by 2002:a17:906:dc94:b0:ae2:4630:7de4 with SMTP id
 a640c23a62f3a-af8fd941362mr544215266b.34.1753914013595; Wed, 30 Jul 2025
 15:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250730080902.6849-1-michel@daenzer.net>
In-Reply-To: <20250730080902.6849-1-michel@daenzer.net>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Thu, 31 Jul 2025 00:20:02 +0200
X-Gmail-Original-Message-ID: <CAFZQkGy2m8OS-1FZdCT9tShs2soy5mtz4CVWfBhPW7dPWq_cZQ@mail.gmail.com>
X-Gm-Features: Ac12FXxA7NtfqVWv0wU22D7MG4YZT1Y6xjAau-cKuTf8C2ffY4zU-r9J0BOWXMY
Message-ID: <CAFZQkGy2m8OS-1FZdCT9tShs2soy5mtz4CVWfBhPW7dPWq_cZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add primary plane to commits for correct
 VRR handling
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 31 Jul 2025 07:24:00 +0000
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

I can confirm that this works. Thank you!

- Xaver

Am Mi., 30. Juli 2025 um 10:09 Uhr schrieb Michel D=C3=A4nzer <michel@daenz=
er.net>:
>
> From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
>
> amdgpu_dm_commit_planes calls update_freesync_state_on_stream only for
> the primary plane. If a commit affects a CRTC but not its primary plane,
> it would previously not trigger a refresh cycle or affect LFC, violating
> current UAPI semantics.
>
> Fixes e.g. atomic commits affecting only the cursor plane being limited
> to the minimum refresh rate.
>
> Don't do this for the legacy cursor ioctls though, it would break the
> UAPI semantics for those.
>
> Suggested-by: Xaver Hugl <xaver.hugl@kde.org>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3034
> Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 2551823382f8..010172f930ae 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -661,6 +661,15 @@ static int amdgpu_dm_crtc_helper_atomic_check(struct=
 drm_crtc *crtc,
>                 return -EINVAL;
>         }
>
> +       if (!state->legacy_cursor_update && amdgpu_dm_crtc_vrr_active(dm_=
crtc_state)) {
> +               struct drm_plane_state *primary_state;
> +
> +               /* Pull in primary plane for correct VRR handling */
> +               primary_state =3D drm_atomic_get_plane_state(state, crtc-=
>primary);
> +               if (IS_ERR(primary_state))
> +                       return PTR_ERR(primary_state);
> +       }
> +
>         /* In some use cases, like reset, no stream is attached */
>         if (!dm_crtc_state->stream)
>                 return 0;
> --
> 2.50.0
>
