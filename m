Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D68BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 16:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E664760527
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 16:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E664760527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6AF8997E;
	Tue, 26 Oct 2021 16:27:47 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E58899B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 16:27:45 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 s18-20020a0568301e1200b0054e77a16651so20543397otr.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NsF+h/7LxPB4+/xRa7hc4Qws/CfKjuNn5IBAV9p2/JY=;
 b=Ham5Zi+gx3JARrAX59QC2huY0L+nCSgpw1/21NOglM5sD2FjeItZWuUZrxOeB0NzUE
 ig7hxCfxo5sRUSlRf1iPlg3bTisyInZxeup0wXZ/oU01/QvZRi7pxd6U7BolXAxq2RG/
 VqkxzJHAiRnLZhFDxjj/JFmyldDbOXfQ9QvI5JElkS/TJFAhjZps4o1TBUq6onq70Xoq
 vuXz6+rGcmF+jMydVqVsf8zSrKELm6wMFt1uvSMXp4l2t2K4dYlUmIzWRefFij+xxFN3
 H/E1JTfhVF9P0byRi+pA4T/Up5dnj3BYzVVOeaZ+KRPIJA0QDrR22XRYX6Raxdna9roH
 3XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NsF+h/7LxPB4+/xRa7hc4Qws/CfKjuNn5IBAV9p2/JY=;
 b=mzjdJI3/3A4FvzDWhHKtJJC84Osvk49v2dm8pQxEMDE7oGTp3msAMAbYF33NQ7Uq8c
 fiuJ/ic8ujhereGqhBpxs1LGd7CalT6OhsR4Y9iur51oxh6GdO7Q8unkAr0Y6u+QUpE8
 TEU4e6M7xGnQatoKnU1hjrBIprU0E17Gg+kuNx2LVXgCMOM5uqtmy1mi7Brw32W32+gf
 1g2Kj6yiKXNQVeBFntGzYKyG/2MmWsTSOgFNIKJNQYHKByWZC+3DNeg+v/D6KnUCtnMa
 qBDveepMUzR5ZA2U7NFE1xS+APacRWyqOPZuFKQizSFfG/o672C/XSVcX4eTI8PDLvbe
 Wxyg==
X-Gm-Message-State: AOAM531kJtZsFYX9S3d8v9RBtiVsw2akHsFUc6V/QKISlaIqq24gHzvU
 QvbVDWq/elHskfMQ2CHGi68X+Hlz2gxV5YP5w6Q=
X-Google-Smtp-Source: ABdhPJzs3IrSpjb13sc8d7s2LUANcX+lvaOpra0/CRlBkD2Ctf2u/tPZhyjDN4mmHp0Yeh/cm3SHRrDKFY5bz7++DBg=
X-Received: by 2002:a9d:1b4f:: with SMTP id l73mr20634207otl.200.1635265665099; 
 Tue, 26 Oct 2021 09:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211026153612.474820-1-alexander.deucher@amd.com>
In-Reply-To: <20211026153612.474820-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Oct 2021 12:27:34 -0400
Message-ID: <CADnq5_Ngq=0t9sZep-5j9gdOuPU0Ae5ashffp-66HHqC4Ers6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix warning in pr_debug
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Philip Yang <Philip.Yang@amd.com>
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

On Tue, Oct 26, 2021 at 11:36 AM Alex Deucher <alexander.deucher@amd.com> w=
rote:
>
> In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:52:
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: In function =E2=80=98amdgpu_ttm_=
tt_get_user_pages=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/amdgpu.h:35:21: warning: format =E2=80=98%llx=
=E2=80=99 expects argument of type =E2=80=98long long unsigned int=E2=80=99=
, but argument 4 has type =E2=80=98long unsigned int=E2=80=99 [-Wformat=3D]
>    35 | #define pr_fmt(fmt) "amdgpu: " fmt
>       |                     ^~~~~~~~~~
> ./include/linux/dynamic_debug.h:134:15: note: in expansion of macro =E2=
=80=98pr_fmt=E2=80=99
>   134 |   func(&id, ##__VA_ARGS__);  \
>       |               ^~~~~~~~~~~
> ./include/linux/dynamic_debug.h:152:2: note: in expansion of macro =E2=80=
=98__dynamic_func_call=E2=80=99
>   152 |  __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS_=
_)
>       |  ^~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:162:2: note: in expansion of macro =E2=80=
=98_dynamic_func_call=E2=80=99
>   162 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
>       |  ^~~~~~~~~~~~~~~~~~
> ./include/linux/printk.h:424:2: note: in expansion of macro =E2=80=98dyna=
mic_pr_debug=E2=80=99
>   424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:697:3: note: in expansion of macr=
o =E2=80=98pr_debug=E2=80=99
>   697 |   pr_debug("failed %d to get user pages 0x%llx\n", r, start);
>       |   ^~~~~~~~
>
> Fixes: 702dde19d4b0e7 ("drm/amdkfd: restore userptr ignore bad address er=
ror")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index ae6694f2c73d..881a91a6ab13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -694,7 +694,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo=
, struct page **pages)
>                                        ttm->num_pages, &gtt->range, reado=
nly,
>                                        false, NULL);
>         if (r)
> -               pr_debug("failed %d to get user pages 0x%llx\n", r, start=
);
> +               pr_debug("failed %d to get user pages 0x%lux\n", r, start=
);

Actually this should be 0x%lx.  Will fix that up locally.

Alex

>
>  out_putmm:
>         mmput(mm);
> --
> 2.31.1
>
