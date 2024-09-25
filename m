Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA9ACCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 20:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0634F10E11F;
	Wed, 25 Sep 2024 20:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mit0a8pk";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D05DC10E11F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 20:13:45 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2db6b13c6a0so43772a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 13:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727295225; x=1727900025; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bkiJOgbF0vZ2CQqwB7WVse3ywFfQnFTtctL/MEW6N10=;
 b=Mit0a8pkS9/qvHX6t8sdA44l5gKSyc/mun1QgapjtbdiDwiTZ98ku8tUNvewV3kLKJ
 leuISs24TPLldNZBLvaspUrfiRxJWqihhaUPY46bGo/cLadzFYzzEYzUxA+v4w/hxcHV
 DcrFUYadVSmPmFGciml5Z09Ed2sidBmYa7IohsbHVaV8s10O76AqGFPiC6MXbWr0m1Pa
 cbadWgEqGw1VtrhaX84TFtXl2wLx/viMMcPZYS6B4Ir2+gNFQiPJSHQzYf/LCjc5+Jpe
 4ezSxXd9DeVoiU5SieFoBnEk9jv0Cjq6EJeHeolwx5pZkmJ7ILZmjMRHtm6yPRTl9b3N
 GvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727295225; x=1727900025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkiJOgbF0vZ2CQqwB7WVse3ywFfQnFTtctL/MEW6N10=;
 b=S1qSEey+A4NNV2dOFAAe2J417yQHylmxfG1SnbID7Kvw4PnZSpnGEvBSrfVrLwa0Z1
 LDg/yvgab1Rz1M+SacNzfGmQVQOoB6yHty/K1kb8f1XBGFPgp0tKjes4cliC78N9LLGt
 XGVuRlxDTOzr6/DBnS6cNHO9WvGU0nam1fyX65WXDBOXeWSQy3W5RVw8UHyOTI8mWbEI
 1DypmKwxvN46iZrFEq9c5hfvEWPWY2jksJkS+p+bgQ7QkWQsru/ySSmaUQdjqe220Jb5
 3LjHrcoRHlldh7s4qvZOnARkfF6wUFJLjfFRZJwkDzX3PLif74mX6VcidRcyQTni1PsX
 p6og==
X-Gm-Message-State: AOJu0YzWrVOT8ucQt5n6ESwiCKQwUBlsDESFkIuW42TSq4Skz3czEJEq
 R36/OsZfRAMFbqAtsgXh/nRQdf6JS5KWwBISax0e4qq7i/QxPKLgbkTyRKOxXIe5OvOrD/P81MR
 2dRSQZO4BpM4KDayfxeMQhY/Pvko=
X-Google-Smtp-Source: AGHT+IHAfWGn7LWtxMprwzaSAmX4uc/EJA0SHsPV1PKUlpbCjAJTD+DApi4ZqTXKh/tjlnWyRCteFypSGkmXRfboztI=
X-Received: by 2002:a17:90b:124d:b0:2ca:7e67:d11e with SMTP id
 98e67ed59e1d1-2e06ae26b15mr1930666a91.2.1727295225211; Wed, 25 Sep 2024
 13:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240925200507.75767-1-mario.limonciello@amd.com>
 <CADnq5_N9PiSMWEKLtyi_+dQvQQhH87MQC2XRgYP5OMsUMRaGTw@mail.gmail.com>
 <6561bb8d-d68d-4ead-ac86-cefff6f0fd37@amd.com>
In-Reply-To: <6561bb8d-d68d-4ead-ac86-cefff6f0fd37@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Sep 2024 16:13:33 -0400
Message-ID: <CADnq5_M+vxGV6y8oEQHC+-CcqV-vW9ND4SsRHqHKbwR_b0iJ9g@mail.gmail.com>
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

On Wed, Sep 25, 2024 at 4:12=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 9/25/2024 15:09, Alex Deucher wrote:
> > On Wed, Sep 25, 2024 at 4:05=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> Some distributions have been patching amdgpu to enable overdrive by
> >> default which may compromise stability.  Furthermore when bug reports
> >> are brought upstream it's not obvious that the system has been tampere=
d
> >> with.
> >>
> >> When overdrive is enabled taint the kernel and leave a critical messag=
e
> >> in the logs for users so that it's obvious in a bug report it's been
> >> tampered with.
> >>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c
> >> index f57411ed2dc2..99717a1d7f61 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -3067,6 +3067,11 @@ static int __init amdgpu_init(void)
> >>          /* Ignore KFD init failures. Normal when CONFIG_HSA_AMD is no=
t set. */
> >>          amdgpu_amdkfd_init();
> >>
> >> +       if (amdgpu_pp_feature_mask & PP_OVERDRIVE_MASK) {
> >> +               add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> >> +               pr_crit("Overdrive is enabled, please disable it befor=
e reporting any bugs.\n");
> >
> > Might want to reword this to something like:
> > "Overdrive is enabled, please disable it before reporting any bugs
> > unrelated to overdrive.\n"
> >
> Thanks, good suggestion; I'll reword.  Are you in agreement with the
> selected taint code and location in the driver?

Yes, with that change, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> > Alex
> >
> >> +       }
> >> +
> >>          /* let modprobe override vga console setting */
> >>          return pci_register_driver(&amdgpu_kms_pci_driver);
> >>
> >> --
> >> 2.43.0
> >>
>
