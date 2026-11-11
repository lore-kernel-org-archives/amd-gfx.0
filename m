Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676B606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VivWzSxD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C3310FCFD;
	Wed, 11 Nov 2026 17:18:30 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6711E10FCFD
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 17:18:24 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-36d1b3b9974so83780eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 09:18:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794417504; cv=none;
 d=google.com; s=arc-20260327;
 b=W2eEfrzXVu4qxqUZpw6W/aSSor0TO0dZbdGDcN14U0rAwDt9yuKgnekpxaQygFv2jm
 m9iUo3fOT4Ige5RzX0tEG7mOHVaxwrRk88URwYVpXN2jTJ0eQ2Uhpa32s7B7uYCJc09w
 sZeXmoDkMi7ckAbrf5trShYuRkeQ0GJTPxYQ2baPaCpdm5/HRnqxeLdbNTIqlnb7YE76
 Zp9OnEKrCMBADoNo0Ghp6atSUieCMWePKafmvkiYcLbadLRLRasf0d1sK7xR67lHaeuR
 JOzmEX56RzyBFiCI2MXtmrBa5iMlVN1o2KrnM7MYmP/U0hzFE/5M6f7D7o3IjQPyFxz5
 YUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kw0jfgt7++kJag8Rb81aSS+ViRwdZQnoobcBhHYL/qc=;
 fh=s9r4zmmxy4zoS0d5gCkQdxJ0YISpXfLFxZpdPI0Ri2Y=;
 b=I2xcc06jcPB6sLGX/pITfE06ZKgBDwSe2zpxqFBKeYMyJsmkA7x2Y6Qi046d+P80sx
 /Dvc/l/rRfGFtTK/ALio+nkW6d69WEgsks2nxLM5Z0kYEZ7MY0cbjEhRH4eENg/0JiNo
 isOlw8hHF8blY3k/KXmOOL/m0IOhEAE82sqXdhymnj66CEEDMku6IiiuyIM0bETAhYdL
 vM5SY5Pmam/gck0KR53MJXahmM5UdBp8dYRbjxVHtjiWQV8Z19gYb2YTxD10+NnOYZTD
 jioykL5sAlL7JuGKJedy8QG6wskYpHNZfMnA69dAkuQJ1hj0+bFYNES/UwcRIlMtSnW3
 GMXg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794417504; x=1795022304; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kw0jfgt7++kJag8Rb81aSS+ViRwdZQnoobcBhHYL/qc=;
 b=VivWzSxDKyt7m3aKiucHCcNdwU5vR3PZbT4i3FbiL0hUzrpy6Ag+C4uX+NMGHZKqnL
 qHMuYhyxu+tBh5dScySZ2PVMV6c6cMJSaRGoQSRkKD8g/cvlwliEGgVq71U4tBOIVxCG
 16UUekzXN9Sj0ybOV6Ay0msrTiREQ8JzOb4LWudBviOuOUv3p8y/1ndh0+hUEMceLhor
 ro/km56gjvdg0QTIT6EvGXzaCtuVhWoHscoaNACiH4WmRCJJ4iU+lveWKizNUTe0e8vN
 xgvnDv7wWXS54BuglqcE9nirbZZOudI1KSVz+o9xtSoxOU1dWbyBF9SYuqDinnFnjQn0
 C/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417504; x=1795022304;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kw0jfgt7++kJag8Rb81aSS+ViRwdZQnoobcBhHYL/qc=;
 b=TP+RkDQQyTn7/DuuNPT267AQiGJv6Czn+cPtXstGlfscbeEw6HtOhoBnqBjeOA5kxe
 la/a60lKQzVfS8FBq6yi9Cug2JB/LdfBNIapfzbqQFW0O1bUvvB6p0TlvQPEJ0bzx2P8
 ruFOPWGLos8/JVpgIYYn52OUmGOVKlKlUUl4wV9hx2oIWXWiKyZz/8XtrbdIUOLbZUZk
 P36+IgtbLX3tJdLL+Ld3gcIc3aZr5IjQHkmNfkcJCFouUoVr1b0pbhmMiWfwp9EyGS4N
 ZmZ10xeW2LhEkNVPrwNylaKsMBl+YkOFbaeKEY8UKmDe0mFCQqILtfPcTsnw7Mde0X7e
 pfOw==
X-Gm-Message-State: APuU4Z+a1qMHvNgfDN4UVj8W7Y2Cq3RkzM1+0i5eV2fB4EG/Ay2ibUEM
 rYBq3O5XbhLucfbKXyYM8ETLrfcRmcOffuNMDEc0SplnQPJH21DektnEaThPo4iwJSkyUYes50q
 ELVoK/2Gq8jeaNuc+ErJj3bJSqzb2WEQL2A==
X-Gm-Gg: AYBFou0db86Y/Wc+2miXVgMrnMdF84a1KWhThSU2k6m97JftBzItTKsZl8BseRcpjjV
 7bjfzxRknJBvfzGLmnoEkJwDZ6wj7idvckvmhzX5oZ6+Ims7vaWFYKLbzmcrK4NTDT89LHEhrKN
 2xLWtYwSA4Ca9Iuta0JqjaKrTjIwXCtyAqyRGSnA1Z0y5MOe4ICMCF1q3zEJCyUlf+YrkAUektO
 ApiaQLjOuEvSoL1bjgeWLe0HFhBBtiaz86uS1BZQ0Q97spk5Ks1LCOX2M41yLlM0q9Ify3zCOqI
 txIETyPmHg4ZDiHFGjvdsmCmKkZS0t2LX1l3+6sQ3s3eXsO8JZEut8Bd6EZvffiInuwOa0heU7/
 omzXjIA4WRcLl0AQ0I5KgGG/h1XFN+35XhT/Vqrp6ioWsx8ZZISXc5tizKiDDEU8V+q40EXhBZX
 kGoqfJ3jPkH8TYISmT9Cpv0Eskx2XqkselJ13omAT9wmHM5NVQlOW1aEohE5E=
X-Received: by 2002:a05:701b:21c3:b0:183:d275:cf76 with SMTP id
 a92af1059eb24-1b3c02fe0abmr4070035c88.2.1794417503678; Wed, 11 Nov 2026
 09:18:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <OS3PR01MB102512A4873E4DCA42A648069E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
In-Reply-To: <OS3PR01MB102512A4873E4DCA42A648069E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 12:18:11 -0500
X-Gm-Features: AclHuK-ZRh2e0fWOIUsPc0nxQ2eBDRgCD8Cdo-GGx5U88w9KRwlyo863aeYY-fQ
Message-ID: <CADnq5_OW3v4oLBhH6Gev4jzaXvrR=VM7rfqjRwgknLbvvSWZqw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: only unregister the ATPX handler if we
 registered it
To: Jiaming Fan <fan.jiaming@hotmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.

Thanks,

On Tue, Nov 10, 2026 at 10:56=E2=80=AFAM Jiaming Fan <fan.jiaming@hotmail.c=
om> wrote:
>
> radeon_register_atpx_handler() registers the ATPX handler with
> vga_switcheroo only when ATPX is detected, and ignores the result:
> vga_switcheroo has a single handler slot and refuses a second handler
> with -EINVAL. radeon_unregister_atpx_handler() calls
> vga_switcheroo_unregister_handler() in either case, and that clears the
> slot no matter who set it.
>
> So unloading radeon removes a handler registered by another driver, such
> as apple-gmux. No Radeon GPU is needed for this; loading and unloading
> radeon is enough. amdgpu is another such driver: when radeon and amdgpu
> are both loaded and both detect ATPX, only the first one gets the slot,
> and unloading the other one clears it. Afterwards vga_switcheroo can no
> longer switch outputs, and a client that uses the vga_switcheroo runtime
> PM domain, such as nouveau on a non-Optimus machine with a v1 DSM, can
> dereference the now NULL handler during runtime suspend.
>
> Record whether the registration succeeded and unregister only in that
> case. amdgpu has the same problem and gets the same fix.
>
> Fixes: 6a9ee8af344e ("vga_switcheroo: initial implementation (v15)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaming Fan <fan.jiaming@hotmail.com>
> ---
> The amdgpu counterpart is patch 1 of this series:
> https://lists.freedesktop.org/archives/amd-gfx/2026-November/157097.html
>
>  drivers/gpu/drm/radeon/radeon_atpx_handler.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/d=
rm/radeon/radeon_atpx_handler.c
> index f557535..9ed75c6 100644
> --- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
> +++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
> @@ -34,6 +34,7 @@ struct radeon_atpx {
>  static struct radeon_atpx_priv {
>         bool atpx_detected;
>         bool bridge_pm_usable;
> +       bool handler_registered;
>         /* handle for device - and atpx */
>         acpi_handle dhandle;
>         struct radeon_atpx atpx;
> @@ -605,7 +606,8 @@ void radeon_register_atpx_handler(void)
>         if (!r)
>                 return;
>
> -       vga_switcheroo_register_handler(&radeon_atpx_handler, handler_fla=
gs);
> +       if (!vga_switcheroo_register_handler(&radeon_atpx_handler, handle=
r_flags))
> +               radeon_atpx_priv.handler_registered =3D true;
>  }
>
>  /**
> @@ -615,5 +617,14 @@ void radeon_register_atpx_handler(void)
>   */
>  void radeon_unregister_atpx_handler(void)
>  {
> +       /*
> +        * vga_switcheroo has a single handler slot and unregistering cle=
ars it
> +        * no matter who set it, so leave a handler registered by another
> +        * driver, such as amdgpu or apple-gmux, in place.
> +        */
> +       if (!radeon_atpx_priv.handler_registered)
> +               return;
> +
>         vga_switcheroo_unregister_handler();
> +       radeon_atpx_priv.handler_registered =3D false;
>  }
> --
> 2.56.0
>
>
