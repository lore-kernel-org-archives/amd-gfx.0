Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D8FCCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 20:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE09810E46F;
	Wed, 25 Sep 2024 20:09:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jtb5ajXE";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46CA10E46F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 20:09:36 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7191f1875d3so41401b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 13:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727294976; x=1727899776; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2c6yyxOvyzufgl/xkfpkmG5zZYgD6njsYPf3S/Vv24=;
 b=Jtb5ajXEpIGkD43x5/osqTcbp4PzS7q0nVRm1OI9RFfpxavzuJ9f+HTc432h9E85Uk
 yxOv5TrGKceNwzSgqOUCZTLY4gK/Slx7sTIYDP/k9hi3/feNjzVZL80v4n+Ms89FZ9QL
 in6esIPuoERvght1m+gavtUIlnqj/kSNvUavwnpUpwyzJ46jRRfrjHVTn7WDYFDNhqY4
 gGx77wcsgude+E4C0BgLYJxYP2KrUVjwf73XmGzrYDGGL6f5g0IIE4CsfknR+ZEJ4nB2
 CXGyd/B7DJJRSCfjA2Zlf0qZZddl8DzCqINCHHe2cPgaiBEKzg2rp2GLLZApq5MsRbCG
 vT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727294976; x=1727899776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2c6yyxOvyzufgl/xkfpkmG5zZYgD6njsYPf3S/Vv24=;
 b=kerrZHIA8M+Vpb9U45Jh88I8jRrpE8EiqzE4A2X5YtzLiudUUTdAG5HwrCKzo+L71B
 pVqNg1C8jiaW8aLXQMmQe07DRspRLXdOjcm9yjmpuNU6zEduRZ82q6DgyQyBY38LYLmG
 Gtkw5tgTeETV36zjmAoMs/KI0VmNs09pnOFGG/ynfSPB+McrxPC/usUQmWioFTc0Ridc
 +2Jx61Sa2TbMgrrnfqHHZbYTyLTMqaOs09ge/UGmqqAyn3jh6nj1yXJmzkPE+F0uBSD7
 7Uan5aEHOpzZqLI+RzwDv86vmoih3RGto/lxmyS/6Mm2fvLmuoObUO18fF9k5nj1Ny3t
 LO6A==
X-Gm-Message-State: AOJu0YxZKVGe+kjEmc71v4jsIKHo7HmbkY6uBWHcxGdh5AkxGJmlvHuP
 eLVgwpR2OCt20kwxA9nOkdHf9umfTySCeQgNJmZRwHfkxSzfzgIv7XW6Ydc6d+49e2qAwgynDlF
 zfX6nWsfkfo+tZZszair54fyLrpgIIOBd
X-Google-Smtp-Source: AGHT+IFNbQcq9NJJQEMlx5vunGbpvCQlFry9bnz5XzkJE+FGbrQgUm7HiBuN39CNGT1hTKhOE/y5XTpRtbVGXIiqF2c=
X-Received: by 2002:a05:6a00:23c4:b0:718:e49f:137a with SMTP id
 d2e1a72fcca58-71b0acb74d7mr2389786b3a.6.1727294976051; Wed, 25 Sep 2024
 13:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240925200507.75767-1-mario.limonciello@amd.com>
In-Reply-To: <20240925200507.75767-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Sep 2024 16:09:24 -0400
Message-ID: <CADnq5_N9PiSMWEKLtyi_+dQvQQhH87MQC2XRgYP5OMsUMRaGTw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Taint the kernel when enabling overdrive
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Wed, Sep 25, 2024 at 4:05=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Some distributions have been patching amdgpu to enable overdrive by
> default which may compromise stability.  Furthermore when bug reports
> are brought upstream it's not obvious that the system has been tampered
> with.
>
> When overdrive is enabled taint the kernel and leave a critical message
> in the logs for users so that it's obvious in a bug report it's been
> tampered with.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index f57411ed2dc2..99717a1d7f61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3067,6 +3067,11 @@ static int __init amdgpu_init(void)
>         /* Ignore KFD init failures. Normal when CONFIG_HSA_AMD is not se=
t. */
>         amdgpu_amdkfd_init();
>
> +       if (amdgpu_pp_feature_mask & PP_OVERDRIVE_MASK) {
> +               add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> +               pr_crit("Overdrive is enabled, please disable it before r=
eporting any bugs.\n");

Might want to reword this to something like:
"Overdrive is enabled, please disable it before reporting any bugs
unrelated to overdrive.\n"

Alex

> +       }
> +
>         /* let modprobe override vga console setting */
>         return pci_register_driver(&amdgpu_kms_pci_driver);
>
> --
> 2.43.0
>
