Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E352C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 21:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B15110E074;
	Wed, 29 Mar 2023 21:08:38 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237D710E074
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 21:08:36 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id bk5so12672800oib.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680124115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPXWRFIoREXhZwsFskFZNeZ1+zPRfNX3xPUEorUWMOo=;
 b=Tg29Bs8pX/s+4I8MqATYnsQDlFeRZbx1yOf7IFCVgtoP6sRvNM15VaJ75BGk4uPYkl
 R091oIyuBzpmTaaQxjV5WUC/fFl/LaTU7AsVxYiuMQCm44Is4sVCvCdyMS4ZEO/p8LG9
 c8UpKlHxZMFKsf5Bi976naIk2C7ZeVIgGRdSXlcMWh/Zn35zMjG3gp6JcNXF4rWGyqdy
 Bof+J12aH5E+TPb6VkB087TjrPEKB5yNVvi88qpuzu8H1muzHIRLZ5GM7UOZsAkQLsgj
 FpGlEeHNGheHopgdnmj0EyxML8iBPIXGMqGjgkhk2OsxN94r9dhJjF/SxM8ls0pjA0N5
 BXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680124115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPXWRFIoREXhZwsFskFZNeZ1+zPRfNX3xPUEorUWMOo=;
 b=rhbugULK/BI6xwm9UbN0AAQ5I8rPHBHu1qTx3rhTEoEA8YUJv6i8Jy/uexngBTteck
 Zjl2xlIpkMHSj0XhsTF0KIQ793+pXDZdPQEItPzoCYW6uc1IMa6kgoINnFjviryV3lpZ
 lwMANjttWxjnGqpIt+1GS3g0iVaz2wiXWFhKT/yG0Avx3vMaAI2Ik/WMJByQNH23dL2P
 Jxs2oGH6LAC+sw/f9WK226o2t9nAzt0LQ2SEnSKug9DrskyV/ElV/kub1kpinlzpCDQk
 ICFEaiOi0pbBPhcCTtoVGCcc3P392pM64c7VgWiSJpsxa0oCTBFLHdnObrsSPAaGFYTo
 V0OA==
X-Gm-Message-State: AAQBX9dufmlt8bxKLhTFnfATr+TLCW6r86+OroRh9WFPI38l6W+ETkCl
 Wg8SqU5kDGAFhnbTc38tjZrhPHmYY1jWjdprf00=
X-Google-Smtp-Source: AKy350YOopVbnyRkX94ORtJ+sQy1ZS6t0Y8O/piyRsw7EmyXpLfeHqlsXwh+1YU3jAWuxZ5f/FYx3CtCqUHxSSlxQtg=
X-Received: by 2002:a05:6808:15a3:b0:389:6d65:6215 with SMTP id
 t35-20020a05680815a300b003896d656215mr485344oiw.3.1680124115221; Wed, 29 Mar
 2023 14:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <580414df-4adf-49cf-9930-743f7c539d46@kili.mountain>
 <BN9PR12MB52573A6551DD2E6464AA9AD5FC899@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52573A6551DD2E6464AA9AD5FC899@BN9PR12MB5257.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Mar 2023 17:08:23 -0400
Message-ID: <CADnq5_PvS7Ltx4KdM+mYn4TugWgN7dNXx6Vb9sLECH0U3wvMeQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix AMDGPU_RAS_BLOCK__DF check
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Dan Carpenter <error27@gmail.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, "Zhao, Victor" <Victor.Zhao@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, David Airlie <airlied@gmail.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Wed, Mar 29, 2023 at 1:31=E2=80=AFAM Zhang, Hawking <Hawking.Zhang@amd.c=
om> wrote:
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>
> Regards,
> Hawking
> -----Original Message-----
> From: Dan Carpenter <error27@gmail.com>
> Sent: Wednesday, March 29, 2023 13:28
> To: Zhang, Hawking <Hawking.Zhang@amd.com>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan=
@amd.com>; David Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch=
>; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Z=
hao, Victor <Victor.Zhao@amd.com>; Li, Candice <Candice.Li@amd.com>; amd-gf=
x@lists.freedesktop.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH] drm/amdgpu: fix AMDGPU_RAS_BLOCK__DF check
>
> There is a mixup where AMDGPU_RAS_BLOCK__DF is used as a mask instead of =
a shifter.  It means that this condition will be true for AMDGPU_RAS_BLOCK_=
_MMHUB instead of for AMDGPU_RAS_BLOCK__DF.
>
> Fixes: b6f512168478 ("drm/amdgpu: Add fatal error handling in nbio v4_3")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> From static analysis.  Not tested at all.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index fac45f98145d..4069bce9479f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2564,7 +2564,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>                         adev->nbio.ras =3D &nbio_v7_4_ras;
>                 break;
>         case IP_VERSION(4, 3, 0):
> -               if (adev->ras_hw_enabled & AMDGPU_RAS_BLOCK__DF)
> +               if (adev->ras_hw_enabled & (1 << AMDGPU_RAS_BLOCK__DF))
>                         /* unlike other generation of nbio ras,
>                          * nbio v4_3 only support fatal error interrupt
>                          * to inform software that DF is freezed due to
> --
> 2.39.1
