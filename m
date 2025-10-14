Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5DACCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 21:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52DF610E241;
	Tue, 14 Oct 2025 21:27:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VTmdzzjB";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23F810E241
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 21:27:38 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2680ee37b21so12017375ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760477258; x=1761082058; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HDZ0v8FQFsUDyODHKNaSPVNhy5SvLc3hjWYWzkydSY=;
 b=VTmdzzjBr+ze7w3nveHAJT1vcr3Dg8Vq2f5Wk/BYnc2G/ItmwAP5edKWLc+11qdLwT
 r/N5KSMrgtOgwbdOtfHHMhfLdNZVtcPKgfjuNPGi+Zy1XTz8uMVkU8vr8lAzoH16TKBv
 zRUK41WJQMVRlLISrZT6B2D0glguRYqt5z0c/EU5jEnRo/hQ+t/YWtgIjXrNiEzlWBKi
 /Q+ZC14Ri/PWFqyXWh46NWbHD7wTF4nkBUOW3Hpj0O2HYtcQhLS8QhqnuHLD4F9GwIYC
 Q/obvODgPINnpCHk1j/INRR2UieDbkz2pymdPsf7OgdgO4OaQpaBRmva+DWr04it/dvm
 yPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760477258; x=1761082058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8HDZ0v8FQFsUDyODHKNaSPVNhy5SvLc3hjWYWzkydSY=;
 b=Ey1Q4HIYuEqQlYzL9gDkKb1SjIrlM8AZVqODM1h9UOsEuuDpYiXiIrQ6Ll7rUUnjrM
 iB6klpA2I1uDP+EGPaxbZIJXXshUUz+wK8nc0tqIQVXi5iOO8Tnvx9m/PvGyWAFxvZ5n
 trDSF+9rJBqu6NCo5QKssVB6hl35ifz5ZTWh8eafipyVa415dIkBepj6aDpkHOnXfXqQ
 fo6ZyKGBWBHr+9b+4iemPeUCHM7LiMl337p2xmx9erzMzQNZuczDf8ZkAbS3qpESjvgU
 By2/o3Sslgj1cnpkELxbmjSCk9w1DEzveiPulAnCzDPrl7xb7eZnB4LKtWAFBWJifB+U
 pizA==
X-Gm-Message-State: AOJu0Ywv5c6tEyrZyboX7UfR3SXkacwzL0efJd4Bq+7fO0LF1xqQro4R
 B/da2ZInW5+ENtJHpEtptztNkhufD6HKN8d66Mul/9X2r7g4++3iSzF8d7X4IYLMecoDyIuF966
 6qY/QoXrKEk724e5eEYvpgZ0YqzzJeSA=
X-Gm-Gg: ASbGncsMNE02ijAfxt99eZiYKFklmzSjNmSfxcgpAvccAXnIiU99tophkS3+57y06yj
 Vjq8H3CUF8Gdlvx10F+DFl4queJY1NHMCho2q63qs0iFbpd+gfr7zk+Z7H0+6y/+E/cioGZNaeQ
 pSoEU+Q89hatmnvom43AU0rMM64yMPPj2dXe9p20343zXNzh5uyjn8uNY+J/8EE0v4wPJjGkun9
 /hDUcSkhClWTyF+X3+JhCXmGQMFNKayOLgBRQ/GPY8lFcc=
X-Google-Smtp-Source: AGHT+IEnwfm1F7+Ns5wq/nLOyTdvLcC3P6bXoFZdv7zmQm0dxCY8/rm48r8D8gPCjewY704xQ6wRpX3L0xxlM2cDXxU=
X-Received: by 2002:a17:903:1a6f:b0:257:3283:b859 with SMTP id
 d9443c01a7336-29027321d06mr208166245ad.9.1760477258257; Tue, 14 Oct 2025
 14:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251014193036.595453-1-mario.limonciello@amd.com>
 <20251014193036.595453-2-mario.limonciello@amd.com>
In-Reply-To: <20251014193036.595453-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Oct 2025 17:27:25 -0400
X-Gm-Features: AS18NWAKXwgvvQrf1q7Zol_MGtt5RD7w4B8XMJ2iTgRmTHkm9pDelV9ia-_lptA
Message-ID: <CADnq5_P-9F0NsOK_5HG06YP98vqJH+1RXxfEnhnAhQ_U1Q=DNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amd/display: Check if display HW is enabled in
 amdgpu_dm_atomic_check()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>
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

On Tue, Oct 14, 2025 at 3:46=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> [Why]
> If userspace hasn't frozen user processes (like systemd does with
> user.slice) then an aborted hibernate could give control back to
> userspace before display hardware is resumed.  IoW an atomic commit could
> be done while the hardware is in D3, which could hang a system.

Is there any way to prevent this altogether?  This seems like a recipe
for trouble for any driver.

Alex

>
> [How]
> Add a check whether the IP block hardware is ready to the atomic check
> handler and return a failure. Userspace shouldn't do an atomic commit if
> the atomic check fails.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Harry Wentland <harry.wentland@amd.com>
> v2:
>  * Return -EBUSY instead (Harry)
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6446ec6c21d4..f5cd9982af99 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -12010,6 +12010,11 @@ static int amdgpu_dm_atomic_check(struct drm_dev=
ice *dev,
>
>         trace_amdgpu_dm_atomic_check_begin(state);
>
> +       if (WARN_ON(unlikely(!amdgpu_device_ip_is_hw(adev, AMD_IP_BLOCK_T=
YPE_DCE)))) {
> +               ret =3D -EBUSY;
> +               goto fail;
> +       }
> +
>         ret =3D drm_atomic_helper_check_modeset(dev, state);
>         if (ret) {
>                 drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() fa=
iled\n");
> --
> 2.49.0
>
