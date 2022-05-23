Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBCFC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 23 May 2022 20:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9572710EA20;
	Mon, 23 May 2022 20:06:30 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A8510EA20
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 20:06:29 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id v66so19122519oib.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2SKCL4ZRnd/eLSbjNA2yKsNo+wfuaagR1g4ADTkoSLw=;
 b=OUAeg83ldJK/UbC/82mr9phJNwf07aZOIJPs+kTrujuhSmV5eq2cceDmZ+DHrXMzFz
 y9wPWy5fE8eQNLrWfKKna4rkblpPZBt09/BOrmIV2capr11RzLWv+6ZA04dVthVQgjpP
 xt25zUtOP6kIW9gFoz/gzhGogMKzknOeO8Ff41s5+zK8bEyB8U18mAK+KNRjeEQQLmRx
 +OiMWNfiVyqh5Vu4J+x3CBOzxlvNdc+q4/FyCSgOedpo3mO8xD2nCRUT98f4gR1MaK+B
 z5iWeLeECUf63UZOSzspwvWpcO8s/CqZ57gVVG3KKoaik4TBW+LVKFEalT+G7h6qVymF
 NXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2SKCL4ZRnd/eLSbjNA2yKsNo+wfuaagR1g4ADTkoSLw=;
 b=SDS468KbRu9lMg0BqH9tCDZHEKZay090DRyNxFS3M9MSEU80qY1DFTwzoehDiZBYYj
 rXf3tFzed7dXuJKbh7b5bbTeIxvy8SNf6ZQnrtfpPXcVpa5tmvS/4oPHC2+vZJ22fDr5
 7IEjG0pnbMpvmG1i7wEMvT6uloRSi87BosWvIA75sJGQMxOPA9kZ7ebUpu90Tcn7Ae88
 Qj6wEGJeLTur6hPtekxHWxnopLZU2B4O7+NQDo/3+uUSSWHV94U0yvYD5KCnHxrqwiPa
 Sa96Gdzw+KGfDsFVuS8tgMytWGZwzOmtkMqZtMHJRpwwUAJeReVkz3/Sw18h4hdBjxBc
 C8FA==
X-Gm-Message-State: AOAM530ux8eSRcV90s6odVY9Kq59jv1ENaVgzuVjC/kOhA3m5IPahQsN
 NdrMmHiLyas0cpi42AtqltdElANh/itlTX7WTf8=
X-Google-Smtp-Source: ABdhPJyGfZUSvR9a6M3LOsVxc0sJv5Oi0WvW41bjD3eajtnIR2RiMNN6TQYdIbk0vEpUSKGdeN1yZgfXCB0O7yqny44=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr419497oiw.253.1653336388935; Mon, 23
 May 2022 13:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220523002418.3652481-1-airlied@gmail.com>
In-Reply-To: <20220523002418.3652481-1-airlied@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 May 2022 16:06:17 -0400
Message-ID: <CADnq5_NSjnFha60GdoysxAFM-8uyK+OJiK6770+Lp33rRee-zw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/cs: make commands with 0 chunks illegal
 behaviour.
To: Dave Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, May 22, 2022 at 8:32 PM Dave Airlie <airlied@gmail.com> wrote:
>
> From: Dave Airlie <airlied@redhat.com>
>
> Submitting a cs with 0 chunks, causes an oops later, found trying
> to execute the wrong userspace driver.
>
> MESA_LOADER_DRIVER_OVERRIDE=v3d glxinfo
>
> [172536.665184] BUG: kernel NULL pointer dereference, address: 00000000000001d8
> [172536.665188] #PF: supervisor read access in kernel mode
> [172536.665189] #PF: error_code(0x0000) - not-present page
> [172536.665191] PGD 6712a0067 P4D 6712a0067 PUD 5af9ff067 PMD 0
> [172536.665195] Oops: 0000 [#1] SMP NOPTI
> [172536.665197] CPU: 7 PID: 2769838 Comm: glxinfo Tainted: P           O      5.10.81 #1-NixOS
> [172536.665199] Hardware name: To be filled by O.E.M. To be filled by O.E.M./CROSSHAIR V FORMULA-Z, BIOS 2201 03/23/2015
> [172536.665272] RIP: 0010:amdgpu_cs_ioctl+0x96/0x1ce0 [amdgpu]
> [172536.665274] Code: 75 18 00 00 4c 8b b2 88 00 00 00 8b 46 08 48 89 54 24 68 49 89 f7 4c 89 5c 24 60 31 d2 4c 89 74 24 30 85 c0 0f 85 c0 01 00 00 <48> 83 ba d8 01 00 00 00 48 8b b4 24 90 00 00 00 74 16 48 8b 46 10
> [172536.665276] RSP: 0018:ffffb47c0e81bbe0 EFLAGS: 00010246
> [172536.665277] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [172536.665278] RDX: 0000000000000000 RSI: ffffb47c0e81be28 RDI: ffffb47c0e81bd68
> [172536.665279] RBP: ffff936524080010 R08: 0000000000000000 R09: ffffb47c0e81be38
> [172536.665281] R10: ffff936524080010 R11: ffff936524080000 R12: ffffb47c0e81bc40
> [172536.665282] R13: ffffb47c0e81be28 R14: ffff9367bc410000 R15: ffffb47c0e81be28
> [172536.665283] FS:  00007fe35e05d740(0000) GS:ffff936c1edc0000(0000) knlGS:0000000000000000
> [172536.665284] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [172536.665286] CR2: 00000000000001d8 CR3: 0000000532e46000 CR4: 00000000000406e0
> [172536.665287] Call Trace:
> [172536.665322]  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
> [172536.665332]  drm_ioctl_kernel+0xaa/0xf0 [drm]
> [172536.665338]  drm_ioctl+0x201/0x3b0 [drm]
> [172536.665369]  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
> [172536.665372]  ? selinux_file_ioctl+0x135/0x230
> [172536.665399]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
> [172536.665403]  __x64_sys_ioctl+0x83/0xb0
> [172536.665406]  do_syscall_64+0x33/0x40
> [172536.665409]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2018
> Reported-by: Michael Bishop
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

And applied.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index d0d0ea565e3d..2019622191b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -116,7 +116,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>         int ret;
>
>         if (cs->in.num_chunks == 0)
> -               return 0;
> +               return -EINVAL;
>
>         chunk_array = kvmalloc_array(cs->in.num_chunks, sizeof(uint64_t), GFP_KERNEL);
>         if (!chunk_array)
> --
> 2.35.3
>
