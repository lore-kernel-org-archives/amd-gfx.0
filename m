Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F614C9830E
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Sep 2026 13:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C3B10E5EF;
	Sun, 27 Sep 2026 13:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CYkR8ykr";
	dkim-atps=neutral
Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com
 [74.125.229.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D5210E5F0
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Sep 2026 13:29:59 +0000 (UTC)
Received: by mail-dl2-f12.google.com with SMTP id
 a92af1059eb24-141a5cf1371so124334c88.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Sep 2026 06:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790515798; cv=none;
 d=google.com; s=arc-20260327;
 b=UM1bbcdK4FlykP/St4HMceZWDoIbjkQ/z1d3KuRJ44BoVqfcQfmr1iW7vwGo7mk2KA
 mlCvvj+sToi365U2z6JGIIAjrYvrawrTeBiKz+1AfgyI5uGVb1bfJbU4WmUKjXNDH1ay
 zmKW8bUo1FCVW3uA6CppdPkh/aM7MQ7PzcwrhKswwYsEZrwTak8a0RQ020k4RHZAXDLU
 ScHO3auuqda6Mkr4NyQrqgmsvlGg7URuqu5WfkjPz/MwmiKykJnAapVq74TndsVJM12O
 9ZtmZpnHp6AGZ62dVcIJGN+O1APApUHNZAHPZ9IFfYyiwYL+cQ2HAaKUO7cqHvYCSolt
 F9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JjWx7CdMGt/+JDfl7KX1wEPjdEp46bufMD+qtwVQ9jw=;
 fh=49PlFXa6BK5CG1J+N8Zh/P8mJx2Zkg4iOR47EnOrvBM=;
 b=S8nfeK8CpcgmpIMH4vJPLUKAsoA93AmrCmpVtjf9zJvc+jnMp4EFt3Sq6DRPf7nLOF
 8M9cM65IomRGFG3DjlT52kJBWX8fydueLZ8nRAX8e3WV7UrRsN4DsYq+XxydoHZDSkr/
 C/CNPEZEgsfg+MCv+cpE+8BH8xm1xDlt/Lq3/QOu9YfreskErPHdlmTRPhJYhCK+hrQS
 mojhxM88Izrb+pnGv3tNQKB1B2XUZqT4Bou22ZbsWhwfzCOdCT/WohAT8TmMUsSWxJk6
 RkzxrWiU4YrL9Py7yfGDWVyQGXtfuiJ7Qa9IjTCEvyi3ly0nZxO9B2c2Q5dJDEVOx/qL
 1vuw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790515798; x=1791120598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JjWx7CdMGt/+JDfl7KX1wEPjdEp46bufMD+qtwVQ9jw=;
 b=CYkR8ykrnTKYEA7ZoiHIeaOb4q8nVWYHEe+8gu+4xel1R74R/yoG6FsuxCpodd/G/S
 BmdlJTFoLenvNA/5scvtW2VGrdtfs9w8pnQwGpUwRp9e4FD6G8HQxR+7sPVY0iJAcTlJ
 XxkWcJKdikCFfHjDXzNFYdH8y9iZnst2BskFo5csNJcHAhf/sTJ+AUiL2V6jvNS+PBht
 FisSBxMGfsE3Y2uaT6Zr5tUrRFqU6FYt1LeoL0oetsF2DAm31TF3feAyRyTyTaDXFmBD
 eXMzdb0kZoyckDALKTl7SzOUuyKXHzlJ0SOfd57abYyfisciQ/zc4TnW4Gyxqljwu5v2
 8K4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790515798; x=1791120598;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JjWx7CdMGt/+JDfl7KX1wEPjdEp46bufMD+qtwVQ9jw=;
 b=Cx5nQ/sbhUfkUqrY4WO2r3drK8loVcTL0nGMXue4PVeoSpKsoBzhCBiANf4QH4kEJa
 jyeZcqAjxvdC19Ikqi2MshCaxpnLvcTxYyC4ihIatDZBsixLGCuQs+YkCugohp2o3EAC
 TM1Ucnn5+DbEkOReOCqrBEJm+0AV3k2/c70i9pOTgQz4ipE1NE9xeSbJw1WrVtO81CGQ
 zlfZPFnfHhu/5oYxULKPIZzcnkfZkOdEKZ4uN2a8fELuiuip8h9jSTkndBn7nbkig+AB
 i9CfItA0WeDj44kNOIC/KcrMyZpxUvw+0ILsHc663W7XjYIlP6klufKa0nz5Vp9t1sq9
 zhaA==
X-Forwarded-Encrypted: i=1;
 AKwUvByHixAKTK3d2xSr7UVbeK/8A1tU91AqkrAYDwdT4uM8iwkQwrllkn6gO/oAUi9C5JOW0m+5VA2e@lists.freedesktop.org
X-Gm-Message-State: AFuF++mly2uPIbrVpcPKbfEr7HnQpqOtql4ESR0oAUW5TwGkXF3oot3+
 tmuJ2g+2+4j+7M5ZNLvKgdDps58n3PBC8adPcvr5rmf8aWlRM/dXScljLjP1tBvn07WrlWjkqKR
 qTQxaK8DQeEOZKPA0LXzWOPKMlU1CA5A=
X-Gm-Gg: AYBFou1wsg6V7ihZJAiVKQZkqiyBIGGUCOn2IQ5Egf0T5msPY7tQ7keP+Ps/mkHcks/
 vAoe1WnP+EV4CcoaGyJ2rKXO7rc5PcHda19vDkrTDb0G1UdvLZxCM7wgjVR6+3ZdB4dNcS3HG9g
 /H12DeEtv9HmVtCgaFz9X1j8kI0/RK1CNlaDPNuZCOra56eLNJRYKWu7qF7uX12sH8xSZma8DW7
 MI6Ixya5MR0Alb7kKhMRk79ohFm8MiZajuGKOmw2RBdkR4WJP4S9ebGp22W88y3sOTA5d/j3B6A
 Jd4pZySputLoxfeYAZWZiWq9Q5ODbUJRmOL9RexHhlbS8FhgefQFDQr9BkX0slaYfsTkgYTCjji
 A+JTyYKTCtUkhQU1lkOpYvKFeNvLHh5yh76GstvRI5Q==
X-Received: by 2002:a05:7022:29c:20b0:12d:c389:ae54 with SMTP id
 a92af1059eb24-146cfdd1a65mr10144867c88.2.1790515798339; Sun, 27 Sep 2026
 06:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <179039514312.597384.1659548947123427650@kernelci.org>
 <8ad00f0f-d924-4b19-986c-8c17dcdade86@leemhuis.info>
In-Reply-To: <8ad00f0f-d924-4b19-986c-8c17dcdade86@leemhuis.info>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 27 Sep 2026 09:29:46 -0400
X-Gm-Features: AclHuK-3xaAgJQ-_J7Ya8xlZeXYTi28sJqJn3vWlASVO1_3rsBfjl4g86XVoWRU
Message-ID: <CADnq5_O7R096UP9mF5RvGSzT+c2p2v2Dm8M243CLxXa=VZvRwQ@mail.gmail.com>
Subject: Re: [REGRESSION] mainline/master: (build)stack frame size (3096)
 exceeds limit (3072) in 'dml_core_mode_prog...
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: kernelci@lists.linux.dev, kernelci-results@groups.io, 
 regressions@lists.linux.dev, broonie@kernel.org, 
 Alex Deucher <alexander.deucher@amd.com>, DRI <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Sat, Sep 26, 2026 at 6:37=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 9/26/26 05:59, KernelCI bot wrote:
> > New build issue found on mainline/master:
> >
> > ---
> > stack frame size (3096) exceeds limit (3072) in 'dml_core_mode_programm=
ing' [-Werror,-Wframe-larger-than] in drivers/gpu/drm/amd/amdgpu/../display=
/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.o (drivers/gpu/drm/amd/=
amdgpu/../display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c) [lo=
gspec:kbuild,kbuild.compiler.error]
> > ---
> >
> > Log excerpt:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > /tmp/kci/linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml21/sr=
c/dml2_core/dml2_core_dcn4_calcs.c:10513:13: error: stack frame size (3096)=
 exceeds limit (3072) in 'dml_core_mode_programming' [-Werror,-Wframe-large=
r-than]
> >  10513 | static bool dml_core_mode_programming(struct dml2_core_calcs_m=
ode_programming_ex *in_out_params)
> >        |             ^
> > 1 error generated.
>
> Hmmm, there are known "stack frame size [...] exceeds limit" problems in
> -next that should soon be fixed there, see:
> https://lore.kernel.org/all/CADnq5_MFMriR-b3eX0mTZShPDgUBgwoObgumEjJ9cJqd=
mDM6xQ@mail.gmail.com/
>
> But this error is new -- and happens in mainline. Wondering if this is
> caused by a fix for those problems.

+ Leo, Alex

Looks like some combination of compiler and/or config options explodes
the stack even further than the recent changes handled.

Alex

>
> CCing Alex and Christian in case this is really something new they want
> to know about.
>
> Ciao, Thorsten
>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> > When fixing this issue, please attribute this report according to the
> > patch submission rules:
> >
> > Reported-by: kernelci.org bot <bot@kernelci.org>
> > Link: https://lore.kernel.org/all/179039514312.597384.16595489471234276=
50@kernelci.org/
> >
> > For complete logs and details about the environment used, see the issue
> > on the KernelCI dashboard:
> >
> > - dashboard: https://d.kernelci.org/i/maestro:24dc0670f5eb776888969170a=
199e08b7f23f99b
> > - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
> > - commit HEAD:  6812ce4e4379ffc99c52401ec28f0d7ffbc36206
> >
> > # Builds where the incident occurred:
> >
> > ## x86_64_defconfig+allmodconfig on (x86_64):
> > - compiler: clang-21
> > - config: None
> > - dashboard: https://d.kernelci.org/build/maestro:6ab70c1f5ec73975aade9=
d6e
> >
> > #regzbot introduced: f14572c203d57492e1d4e5d7851a3b143e083b82..6812ce4e=
4379ffc99c52401ec28f0d7ffbc36206
> > #regzbot link: https://d.kernelci.org/i/maestro:24dc0670f5eb77688896917=
0a199e08b7f23f99b
> >
> > #kernelci issue maestro:24dc0670f5eb776888969170a199e08b7f23f99b
> >
> > --
> > This is an experimental report format. Please send feedback in!
> > Talk to us at kernelci@lists.linux.dev
> >
> > Made with love by the KernelCI team - https://kernelci.org
>
