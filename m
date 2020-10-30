Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE5DC00A89
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 04:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7697221E2
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 04:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP11B+4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7697221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49516E951;
	Fri, 30 Oct 2020 04:49:04 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 088C76E951
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 04:49:02 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id k125so1763554wmf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2020 21:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=79RD2S2sqcqqjZSBIiuWXoOSrGXzs5hov/s45ugFqxo=;
 b=KP11B+4FDDvCA9Lj346sRbc0X0aUz60GQNeTDa9Nx8yaT206nd0YDZazSC6JinXj8p
 JOfd0ws9n6QnAMrqQvHAfDJURm3T9u3q0GSgLzbnmVICzPaCiXt1Iotu1Pobb5ZD4nmR
 nSHuTNzsDaBMU6f60z2A/T7LDqfs5h914ks6lhM7r6ZpQhYMKE9ZY+9sj71+8SMEZV5D
 gVW4ykjycRpE8cdPyvKix6EUq5WnRcYKZO6bvOj4s13uDwBX3eqSmrfuFodiOBVzaNji
 5r/arp1yU95ArkYrZfrys/j0LNWRCRJPC9sfbLz1N3/tUdXlnEAHV4URifcDAEgWJdVl
 Nqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=79RD2S2sqcqqjZSBIiuWXoOSrGXzs5hov/s45ugFqxo=;
 b=D3xBmJicwthWhOven0ruZ6rjp548gFcriwJr+Tv3XdUfVqTmMVLJroyIlm6Q48S8b5
 Ex43d9EQBJ2NsVQM4beBh/zI5Rj0iCInH0/4Xn6gdBkH5sCLIq8qogUIOQHkxglGw69v
 1AMGe7w7zQhpZ+xyxXDMeY8nMditWix5AsrzAP6xMhKONDolYgFgxc+lcNZSm1i4VVbh
 oRv378FHkZEVA8m170lHWu3yUVCNexcqwFTTZ4pAUfr6Hbnat0iD4kFjHIo4lYgAaDp9
 i3sHd3zpx6Uma5f+90OpNKvLEFhZragie6Y6eK+CRINRRPJqS5qw2odq+Ve4b+ClKYHT
 lYcQ==
X-Gm-Message-State: AOAM5306MnDiJ83J0DVzkCKm3NStIrF7NQ6sYG3+hzNhwifViw/V0kdX
 EL/OemM8GzHc1H7/pYbqDGDy9AZPE1N6P88eir9C07hOJUQ=
X-Google-Smtp-Source: ABdhPJwVvqncd4SfKBO8lEt9MJc+jrOjcTt2w++r4Be+JzFVqImBiHKp6M/FqvzT13CAI8XUGlA7GO0T+FqXt1camgg=
X-Received: by 2002:a05:600c:25a:: with SMTP id 26mr427744wmj.39.1604033341668; 
 Thu, 29 Oct 2020 21:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201030043306.1557713-1-likun.gao@amd.com>
In-Reply-To: <20201030043306.1557713-1-likun.gao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Oct 2020 00:48:49 -0400
Message-ID: <CADnq5_N2hnxPXc+xR815219po5gHggciN-WYvTZn_9RBQqAt0g@mail.gmail.com>
Subject: Re: [PATCH xf86-video-amdgpu] Fix drmmode_crtc_scanout_create logic
To: Likun Gao <likun.gao@amd.com>
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
Cc: Guchun Chen <Guchun.Chen@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 30, 2020 at 12:33 AM Likun Gao <likun.gao@amd.com> wrote:
>
> From: Likun Gao <Likun.Gao@amd.com>
>
> If crtc scanout create successfully, the function of
> drmmode_crtc_scanout_create should return TURE.
>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Change-Id: I4b7540b0d128c2d55f2b8491569004741435f343

Please create a gitlab MR for xf86-video-amdgpu updates:
https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgpu/-/merge_requests

Alex

> ---
>  src/drmmode_display.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/src/drmmode_display.c b/src/drmmode_display.c
> index f74106e..465915f 100644
> --- a/src/drmmode_display.c
> +++ b/src/drmmode_display.c
> @@ -513,9 +513,10 @@ drmmode_crtc_scanout_create(xf86CrtcPtr crtc, PixmapPtr *scanout,
>                 ErrorF("failed to create CRTC scanout FB\n");
>  error:
>                 drmmode_crtc_scanout_destroy(scanout);
> +               return FALSE;
>         }
>
> -       return FALSE;
> +       return TRUE;
>  }
>
>  static void
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
