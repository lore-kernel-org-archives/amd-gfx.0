Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E12CCD199
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 17:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A51D10E0E7;
	Mon, 20 Oct 2025 17:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IAzDJDb4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB07610E0E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 17:18:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C1B2620C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 17:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE20BC4CEF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760980715;
 bh=4DeNbsFjA3GHAvuLpWPwdNkAditJGZMykUeSPTvXfPI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IAzDJDb4ojXUi/sH9bE/JrBXDlxA86v5WcegcNYbiBVchvmT6yaL1Lijo1TvKEGDt
 snY6qEqecS/PcWU5Xk8O+rNbRDbAoCI57Yg03K8QeM4T2WyojWFszIXIjptz0i3RqV
 scLrP3XMFUNmuitiA9Ph5kdld2InsLktImukfTwFBWSXuE5mB/niaiCPyn5qxFMg9i
 is51pg2srmTIeHZKDTWPW6XG7SIeksJ+OdkTz8SRP9L5tH7Yr2f65ZrcZQRB3egrKy
 z0t18SCRrKnjIjluTDUc/EHeA03icbnUyer6J7eoic+M8eEqGaCkrWGD3RXFgJq/0N
 lWU3QskxKQ04g==
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-4439f1df5f6so1083513b6e.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 10:18:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXuLCL7qPRY7fKxeBRuYGXemoTyBwnvHurhDBf5Ud25y9eDlYn/NdYxN0C5XNrTSrnom2DATn6H@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEZ2XGpgGEblVr8fgdE17qe3aFQ/ymB4SCaMV0Gy2zbgRQ9Abu
 Mic3lSG8wRamLQFWk+4+j0odbSrBJ0PZxXRxQwd+YvSN8ijv+VY3B2TO50yP8YJyJrDrmsAzF8X
 HKgI1NipHo1rvzPaMOyK77qa382WRujQ=
X-Google-Smtp-Source: AGHT+IEpBFVPe13rSyWoAQmkn/h4MheLuYhwx+bDHEMRoTzYJkC2HBrn+zWJIIX4GlHStnkZidJOsjnAs+i7vboU7aI=
X-Received: by 2002:a05:6808:1a03:b0:441:8f74:e85 with SMTP id
 5614622812f47-443a309d405mr6105705b6e.63.1760980715153; Mon, 20 Oct 2025
 10:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20251020165317.3992933-1-superm1@kernel.org>
 <20251020165317.3992933-3-superm1@kernel.org>
In-Reply-To: <20251020165317.3992933-3-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 19:18:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g64Hu15k5sLVfxj-AADy2goyvseGGm_zTAqSPHXEaxOA@mail.gmail.com>
X-Gm-Features: AS18NWBumdOGpspcARVBeurDv1os9xsYPMYfkNgvhTlP7jAwUq2a1Wu4Nq9UyAw
Message-ID: <CAJZ5v0g64Hu15k5sLVfxj-AADy2goyvseGGm_zTAqSPHXEaxOA@mail.gmail.com>
Subject: Re: [RFC 2/3] PM: Don't pass up device_resume() -EBUSY errors
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org, 
 lenb@kernel.org, pavel@kernel.org, rafael@kernel.org, simona@ffwll.ch, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
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

On Mon, Oct 20, 2025 at 6:53=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> If a device resume returns -EBUSY the device resume sequence has
> been skipped.

Is this actually demonstrably true in all of the cases?

And what about -EAGAIN?

> Don't show errors for this or pass it up to async
> resume.  If resume is run again in another stage the device should
> try again.
>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/base/power/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index bf9c3d79c455f..f6bc7ef9a8371 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1112,7 +1112,9 @@ static void device_resume(struct device *dev, pm_me=
ssage_t state, bool async)
>
>         TRACE_RESUME(error);
>
> -       if (error) {
> +       if (error =3D=3D -EBUSY)
> +               pm_dev_dbg(dev, state, async ? " async" : "");
> +       else if (error) {
>                 WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async" : "", error);
> --
> 2.43.0
>
