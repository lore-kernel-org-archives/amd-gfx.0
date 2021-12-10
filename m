Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069ACC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D34810E2A2;
	Fri, 10 Dec 2021 23:05:02 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C92310E2A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:05:01 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id r26so15259981oiw.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 15:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mMAXeSNkmP2rLtM0jiY1pXbDQAfvFXhxPDoktVhoCpc=;
 b=mPo34lFANa1qlkhxzzR8TS4ywzp2VHbqfMZsIBHwntT92M9gmxcUP4bebekXEbeM2m
 kAuJFZnltCsYtpqeOFNhyvgOiTF7ytMLbK0NzO4CX0IBzI9zjX+jd4ANRGwaXSwrF3ef
 /MRBkaGDojSGEgpS3vHVSwYXSYaIkuApERCGz3VJi/3PTCywJ/foFAytAOhcGwDtC4T8
 TqPPCezbxZcOEmrauo3cPUWz+2K/edudIUHFa1qFz2jQT/RZSHzhB1JM71o7wPJq0ba5
 nruZTnOrjNzXtrPwfi0x9lyAHPJklU8afWNXba2jv+/z1fVHsz7mWf+PLl62kcQXxcqO
 UJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mMAXeSNkmP2rLtM0jiY1pXbDQAfvFXhxPDoktVhoCpc=;
 b=sgE1hHWKbVcvWhzlj1X876JGhx7f1ZgG6asIq5I46DjNZWFq2JrIeJEi/lROtjm+Vw
 06lc3PxKHXPn5QWFfAsPmFZEL7cpgt6ocRcGtJDFm3qsYFC4of56TZitx/e6cny0oZdw
 x3R1AxvU68TENDxHm1ab5pfpP06HcDilddDB+tR5nSugDs+wIlUKuSGhedRmBNnPyJrV
 6d3IPBzXqzirLgWmUTU5O+DrmlbpY5j11jyyO6f34EwGnEVMJTiFWkRSRJTvcjYTBbg8
 9rsWXIoQ9gyfd2PL/Q+jEM3fPhSCMV1+R7lpb2QasBpUAACzZ3jImeCwnVXxCUsbX7NK
 j3+w==
X-Gm-Message-State: AOAM5333uY+fCWp2580tOSyywn2vB62aaxhnafNvc9sKfU6VOHBSRITc
 HJc85FN1KwGZTB2atKK68dAXR4h9N4omN6NkAdIdI8xQ
X-Google-Smtp-Source: ABdhPJz1GDmLpH2KcJNScBJwalz7HMMqtSwAmVwwzYCdHT/5zO/9hKFKYrEdzzzOz0Ftb21Pgx+9thDNGQmGIfm1pbg=
X-Received: by 2002:a05:6808:44:: with SMTP id
 v4mr15045620oic.123.1639177500477; 
 Fri, 10 Dec 2021 15:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20211209154722.4018279-1-isabbasso@riseup.net>
 <20211209154722.4018279-2-isabbasso@riseup.net>
In-Reply-To: <20211209154722.4018279-2-isabbasso@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Dec 2021 18:04:49 -0500
Message-ID: <CADnq5_OPpUaY4EYVZzEehkeGR_OiL1eAnxLd4D2ekcUxzVNUXw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] drm/amdgpu: fix amdgpu_ras_mca_query_error_status
 scope
To: Isabella Basso <isabbasso@riseup.net>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, ~lkcamp/patches@lists.sr.ht,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Dec 9, 2021 at 12:01 PM Isabella Basso <isabbasso@riseup.net> wrote=
:
>
> This commit fixes the compile-time warning below:
>
>  warning: no previous prototype for =E2=80=98amdgpu_ras_mca_query_error_s=
tatus=E2=80=99
>  [-Wmissing-prototypes]
>
> Changes since v1:
> - As suggested by Alexander Deucher:
>   1. Make function static instead of adding prototype.
>
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 00f94f6b5287..dc2a8d58d578 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -867,9 +867,9 @@ static int amdgpu_ras_enable_all_features(struct amdg=
pu_device *adev,
>  /* feature ctl end */
>
>
> -void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
> -                                      struct ras_common_if *ras_block,
> -                                      struct ras_err_data  *err_data)
> +static void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev=
,
> +                                             struct ras_common_if *ras_b=
lock,
> +                                             struct ras_err_data  *err_d=
ata)
>  {
>         switch (ras_block->sub_block_index) {
>         case AMDGPU_RAS_MCA_BLOCK__MP0:
> --
> 2.34.1
>
