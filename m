Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953BCC001DB
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 13:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E2910E20A;
	Tue,  8 Aug 2023 13:29:58 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E282810E20A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 13:29:55 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bb140cd5a5so4518940a34.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Aug 2023 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691501395; x=1692106195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYUBTpYOn+RW72cJikc3sHLDMgPT7nmhE0kHkA8+M44=;
 b=kPN8yN6OYlBOIzAuQ/HTA6YQv9K40IARHVV6QQq+aI4S9fsGKS5FLVE/yLoUUrttdP
 flUAuFkKppWX7OdHLTXzicGHwEdg7sHeJeZC+PKdEOn+N+5sOPMc2ZhsTLZ5/skWAlGt
 ONOVHZo9UwpzjdUmEagjn/EMYBNp4KT7iNU+6el3iPAHlJbqXQY64ErNIsHhBvyBS+UX
 6xarGtEhhR2CxI3KWjVjI9nIRVWgx4RhAeIZ+7KEmDitXkEqgM68W4yEoziCzLQa815m
 lttOq0l31g10wVzRz5FMZ3TBf7u+14gSml1INSbqvBwiwpqQpwAPV/RhD+oeOF27f5WR
 TgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691501395; x=1692106195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYUBTpYOn+RW72cJikc3sHLDMgPT7nmhE0kHkA8+M44=;
 b=eNKgwmNpPXaJExIAg26SiZb8qYFwrWNkIHNrelHCL5fqJ5f2BrGNRsrlBz//aer6hb
 eBye0VijFnijFAMuLqC1YesFd/PkIkFjDFLk0Nb6ZpMLmDRxybIGnh1LF1t5gxamtxUM
 /MhqfU3or18GtLITno/KJ2io4ygO5pzY8L/wJ118NoCR2KhW2em7b16v/0nktGlo1RdS
 HAffbBDNrGsnfmQmP8HjM5i19GLi3N/FsuPPI6KFBrgBmjJ78VkmbwfPAXnrEL+6tWw6
 xO7vrjDTsOT25V1nS/Hoa+MJWqM5nk1xD6+j5uEDzb0pkKD5G/H6cVOERqyN3WEiG+ep
 MkFw==
X-Gm-Message-State: AOJu0Yw6LmxYVF2Cmf3dCUKmPa+FSu0TZ/4mbO8ckoS1AL35oo1ySZqM
 ImNoobP/7GqeGqpJ1i/6VoNRAJpIp8nbcjq9+7k=
X-Google-Smtp-Source: AGHT+IGn/VfSs1rkbkP4TBt25sjMBWcKHeIQqGyC6nROa1yce8W2bzAcAs7VSNaBLVEpy8QgH13lSRGkebi73mxiClQ=
X-Received: by 2002:a05:6870:9708:b0:1aa:30e3:6a5e with SMTP id
 n8-20020a056870970800b001aa30e36a5emr13901372oaq.22.1691501394965; Tue, 08
 Aug 2023 06:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031736.529835-1-jiadong.zhu@amd.com>
In-Reply-To: <20230808031736.529835-1-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Aug 2023 09:29:43 -0400
Message-ID: <CADnq5_M7+Ktg_Y8UEhRzmOffEfJLvoEjqp0T8kQ+3zd6NimRUw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable mcbp if parameter zero is set
To: jiadong.zhu@amd.com
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 7, 2023 at 11:18=E2=80=AFPM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> The parameter amdgpu_mcbp shall have priority against the default value
> calculated from the chip version.
> User could disable mcbp by setting the parameter mcbp as zero.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>

I think this should be expanded to disable the sw rings as well since
they presumably won't work correctly without MCBP.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7314529553f6..615669dcabc2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3699,10 +3699,11 @@ static void amdgpu_device_set_mcbp(struct amdgpu_=
device *adev)
>  {
>         if (amdgpu_mcbp =3D=3D 1)
>                 adev->gfx.mcbp =3D true;
> -
> -       if ((adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, 0, 0)) &&
> -           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &&
> -           adev->gfx.num_gfx_rings)
> +       else if (amdgpu_mcbp =3D=3D 0)
> +               adev->gfx.mcbp =3D false;
> +       else if ((adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, 0, 0))=
 &&
> +                (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &=
&
> +                adev->gfx.num_gfx_rings)
>                 adev->gfx.mcbp =3D true;
>
>         if (amdgpu_sriov_vf(adev))
> --
> 2.25.1
>
