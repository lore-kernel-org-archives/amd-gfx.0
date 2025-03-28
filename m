Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEC7C36011
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 14:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E30510EA45;
	Fri, 28 Mar 2025 14:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i3+3Bpj2";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E4D10EA45
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 14:58:29 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-301b4f97cc1so528736a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743173909; x=1743778709; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJ8OqoGg2nIOzBRf59QZSiPvYojbxBwTE06/pxhV14I=;
 b=i3+3Bpj2cJbRrU22r2d9UU847LPBIYXEyD6Q0/yj5Z82ygAT3O40UlKk1+0Omf8E/B
 BMaPiK3bRippjrp2P1/YUl7VVpZXmbGx319Z1rCpBpfMBCwZh0utgNxAqc2QCou0zeuT
 uv2A9nfms0bp49NWZgKH899RYs7XltgUmQcCXyWHEhZjhzx3VhVTm2L6ExznoOZya6Ap
 nfNaNXetMdHrLI80Z9UXEPNSHWDi7ZWllxbIxobrTdjMmo14N5lt3xzr+kz0FkmQ5xPd
 5BGigQ+TG0Gj3NkLNrr08zfPOLYNVH+dJAm0R3hjoZO3qZqD528EtUSjbHgYAOv0KmYF
 S2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743173909; x=1743778709;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJ8OqoGg2nIOzBRf59QZSiPvYojbxBwTE06/pxhV14I=;
 b=MsKQ2ir7h0+aJY8ZR8jxGHjCNumhm2jxXW75wK3BEl2fdgZWbSDWPZDD6HoczX7KCX
 ZliZNXbFZiSbJBlBW+3c6Hy7AxJHz0rjV71t7Csg5SZyjHGy4SFG9VRk7rStmRYD8SOG
 ad/BbYvQfYi7G5iFAGVs7GYJniu1w111soic2eVEpOW6hlrQI9qc0ghIYh1Wj3k2m/6A
 fIiiLcUYwbk8UbcteT7iVPvrEHfGXcQvmRn/E3XKRhb6uEYrrafF5oERUZZf4oILtpwb
 kJsE1/QQIAA9vPe08XoVsMrNIl30MCvT5W3FgGnJ0v86Wd8azmPby+8j7ZWdwLAFDa9q
 vnow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdJb5d39kln4t86GzaXIErAISxrMovr5TYvcaC1+nSl244yQVHF2Qd+pz2ZDu6cR1TwAiZt/MM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyuxNup3oDdYQ/3bqS2e78TQJ5dIOOo7xxyJ2yX0GVlB9C+7mM
 CtQpchHYAj4LovA9woVe2ND6QPkY4oW5EvJ/q4WsXbfRBRavsH+CMMNAVAeYKNwtLv8udTRPqLl
 FUU1mHWCDwrgBahCc9ALiK2qJ4is=
X-Gm-Gg: ASbGncuF0pZROyiFiWMo3HzI2ASj1zr08yzlIPsl4/Hbk4G3t61sUNnrMXVN6TnlfTN
 pu8PRUoDkQRUzSYyo/M3Axls7VYgUzuPZ6SOEpR6xVBIPr4rRcJjFA1kthX1cgAjulkCk6OYd0D
 z2+38om4bmS7dquIP0jS3QM+bGfw==
X-Google-Smtp-Source: AGHT+IHaQcFENH9w6fmzX1ktiN/qz8VxsV/TcndjdYF+PxwOuAuByhVfLIy4v+JgJLHpBw+joF8HkYKyXX8hWNs93uU=
X-Received: by 2002:a17:90b:180d:b0:2ff:78dd:2875 with SMTP id
 98e67ed59e1d1-303b2754fddmr4253114a91.5.1743173908549; Fri, 28 Mar 2025
 07:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250325152407.2543116-1-srinivasan.shanmugam@amd.com>
 <b30810ba-3e16-4f52-8b4a-070bda1bc129@amd.com>
 <CADnq5_PcPDULfTjtkWGXRVpuJ3Wc770Be3QjrxkRDsw1E-VUeQ@mail.gmail.com>
 <740940f4-055b-483b-88b7-072907539167@amd.com>
 <fc461f19-44b8-4699-b3e6-c37e1b7dc76f@amd.com>
 <5a04ac1b-6b83-40c4-b9f1-ca42bd53763c@amd.com>
 <6e0ab036-59fd-4f1c-8b3b-386ef450dadb@amd.com>
In-Reply-To: <6e0ab036-59fd-4f1c-8b3b-386ef450dadb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Mar 2025 10:58:15 -0400
X-Gm-Features: AQ5f1Jo_mYgG4J2rpw4CssAG-gg1abBmRIOVntbiFnFUWlxl5_1j8byR1tKStmc
Message-ID: <CADnq5_PM47FqTKJbo=PcKn2ef8S9q9L4L3ctZ0KS1a4SKb6aSA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix Manual Execution of Cleaner Shader in
 Gang Submissions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Mar 27, 2025 at 9:50=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 27.03.25 um 10:37 schrieb SRINIVASAN SHANMUGAM:
>
> On 3/27/2025 2:54 PM, Christian K=C3=B6nig wrote:
>
> Over all this change doesn't seem to make much sense to me.
>
> Why exactly is isolation->spearhead not pointing to the dummy kernel job =
we submit?
>
> Does the owner check or gang_submit check in
> amdgpu_device_enforce_isolation() fail to set up the spearhead?
>
> I'm currently debugging exactly that.
>
> Good news is that I can reproduce the problem.
>
>
> I have to take that back. I've tested the cleaner shader functionality a =
bit this morning and as far as I can see this works exactly as intended.
>
> Srini, what exactly is your use case which doesn't work?
>
> Hi Christian, Good Morning!
>
> The usecase is to trigger the cleaner shader, using sysfs "run_cleaner_sh=
ader" independent of  enabling "enforce_isolation", so that cleaner shader =
packet gets submitted to COMP_1.0.0 ring by default, without prior enabling=
 any enforce_isolation via sysfs,
>
>
> I've tested exactly that and it seems to work perfectly fine:
>    kworker/u96:1-209     [020] .....    86.655999: amdgpu_isolation: prev=
=3D0000000000000000, next=3Dffffffffffffffff
>    kworker/u96:1-209     [020] .....    86.656190: amdgpu_cleaner_shader:=
 ring=3Dgfx_0.0.0, seqno=3D2
>            <...>-11      [022] .....   150.607688: amdgpu_isolation: prev=
=3Dffffffffffffffff, next=3D0000000000000000
>    kworker/u96:0-11      [022] .....   150.608228: amdgpu_cleaner_shader:=
 ring=3Dcomp_1.0.0, seqno=3D2
>    kworker/u96:0-11      [022] .....   150.620597: amdgpu_isolation: prev=
=3D0000000000000000, next=3Dffffffffffffffff
>    kworker/u96:0-11      [022] .....   150.620624: amdgpu_cleaner_shader:=
 ring=3Dgfx_0.0.0, seqno=3D1527
>
>
> The only thing which might be confusing is that when you issue the cleane=
r shader multiple times when the GPU is idle it would only run once.
>
> But that should be easy to change if necessary.

The problem is that it doesn't take into account KFD jobs.  We need to
be able to run the cleaner shader even if there have been no KGD jobs,

Alex

>
> Regards,
> Christian.
>
> AFAIK, this "isolation->spearhead" initialization is not being takencare =
in this path "amdgpu_gfx_run_cleaner_shader -> amdgpu_gfx_run_cleaner_shade=
r_job" (ie., when we trigger cleaner shader, using sysfs "run_cleaner_shade=
r"), and this check "&job->base.s_fence->scheduled =3D=3D isolation->spearh=
ead;"  is having the problem ie., "&job->base.s_fence->scheduled" address a=
re is not matching with "isolation->spearhead" address, which results into =
zero & thus fails to emit cleaner shader, when running using "run_cleaner_s=
hader" sysfs entry, in "amdgpu_vm_flush()" function
>
> Best regards,
>
> Srini
>
>
> Regards,
> Christian.
>
> Regards,
> Christian.
>
>
