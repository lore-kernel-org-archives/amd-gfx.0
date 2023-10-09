Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375E2CD611E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 18:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1DDB10E0A4;
	Mon,  9 Oct 2023 18:41:01 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4833010E0A4
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 18:40:59 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1e12f41e496so3229018fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 11:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696876858; x=1697481658; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7/ceM1M+eZUtzeHV+3Pxiie++gjX+eNhoNBLJFBtyQ=;
 b=K2zx1f6N8fYMVuxyM0Gxj3fCQWisWKmiq3WXs1YDGtIT0ot1urnfNSfRTlaUqJmhm1
 RaT9R086mGy41YMhfN6k7jWBGEx22QktRZt4MjrW//mQTZ4hecfgV96t+v3OqDP4oZzm
 jWpkrqjtOGr7915+nSHof1i0cfcSmv6UJfq7Y4aX4b+TBGf7gb3ipZb8+gvc1WHIPKMV
 e+38SvWHx8m/8zBSM1G1A3ZwMjXqOK8HSpZaDJXe3dyY2l6rxeoqHVrrvEPYtHpcbk+M
 HTCHx8ZukBeJ68H7WDswuTiLu09KKhmKZPpI0PlU+DETnUzJQufBkYiungX7VuCbBlkj
 Ghig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696876858; x=1697481658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7/ceM1M+eZUtzeHV+3Pxiie++gjX+eNhoNBLJFBtyQ=;
 b=Lz8KGBF+Cj9OxcwK0YIBslK8EuYsuJ5E5jAjgZ8fEF1T2YmJj5PVZWDAvj26WKXuel
 IeQdJ4lapwVp81syZyomcAxUEr5EQ9TtS0qrZs1qhxyiLTDGXhs/hkqVWhl3weeXjdHL
 8VUvKfTIeu0Sgi2OJtGFQScoxnBYDnQGOAvPKVJ1b0Ub/+wRLvNIQfF2bTmaAAxPEi0p
 b9HU/rwcj+n43VjzT46XBxHdeRYrRr7S6Ck5aNk0UHwpw4aZW7ahIGQmbDvF+IqmrWFe
 dssybdQbGr/pa4QkL1Dt/mJDVfJ/I8vKpX/d5xYGBeR6pGCj9el0toaLKJV9ieTht1O9
 8gpQ==
X-Gm-Message-State: AOJu0YxiJ1kbekFAWOElWnAG6IUeAqqmPxnUKJTkmyl1mKkOJvihAmi5
 GENEeU15WabADhJV49dJgxZ8nuTpNHXZ56x/Xds=
X-Google-Smtp-Source: AGHT+IHnIht5l3bOGBe40/ppF/7jN0t2DrJrF4cc7whyvF/UAMVeT1yvjaQto7783WE9L26cmJfTB137KtYfKWQsNzI=
X-Received: by 2002:a05:6871:5cc:b0:1c8:bbd0:2fd1 with SMTP id
 v12-20020a05687105cc00b001c8bbd02fd1mr19046564oan.41.1696876853867; Mon, 09
 Oct 2023 11:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231009155426.96232-1-mario.limonciello@amd.com>
 <20231009155426.96232-5-mario.limonciello@amd.com>
In-Reply-To: <20231009155426.96232-5-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Oct 2023 14:40:42 -0400
Message-ID: <CADnq5_M6yqe_2UkrTbDO9AVKOHxwN6rzJ_NqR3bPnexUxGnytw@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] drm/amd: Capture errors in
 amdgpu_switcheroo_set_state()
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 9, 2023 at 12:52=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> amdgpu_switcheroo_set_state() calls lots of functions that could
> fail under memory pressure or for other reasons.  Don't assume
> everything can successfully run sequentially, and check return codes
> for everything that returns one.

I think the reason we do this rather than returning errors was not
because we assumed they would be successful, but that it seemed better
to try and restore the hardware than to bail early.

Alex

>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 +++++++++++++++++-----
>  1 file changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 0f98f720d9ca..65a4537ee6f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1749,23 +1749,45 @@ static void amdgpu_switcheroo_set_state(struct pc=
i_dev *pdev,
>                 /* don't suspend or resume card normally */
>                 dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;
>
> -               pci_set_power_state(pdev, PCI_D0);
> -               amdgpu_device_load_pci_state(pdev);
> +               r =3D pci_set_power_state(pdev, PCI_D0);
> +               if (r) {
> +                       DRM_WARN("pci_set_power_state failed (%d)\n", r);
> +                       return;
> +               }
> +               if (!amdgpu_device_load_pci_state(pdev))
> +                       return;
>                 r =3D pci_enable_device(pdev);
>                 if (r)
>                         DRM_WARN("pci_enable_device failed (%d)\n", r);
> -               amdgpu_device_resume(dev, true);
> +               r =3D amdgpu_device_resume(dev, true);
> +               if (r) {
> +                       DRM_WARN("amdgpu_device_resume failed (%d)\n", r)=
;
> +                       return;
> +               }
>
>                 dev->switch_power_state =3D DRM_SWITCH_POWER_ON;
>         } else {
>                 pr_info("switched off\n");
>                 dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;
> -               amdgpu_device_prepare(dev);
> -               amdgpu_device_suspend(dev, true);
> -               amdgpu_device_cache_pci_state(pdev);
> +               r =3D amdgpu_device_prepare(dev);
> +               if (r) {
> +                       DRM_WARN("amdgpu_device_prepare failed (%d)\n", r=
);
> +                       return;
> +               }
> +               r =3D amdgpu_device_suspend(dev, true);
> +               if (r) {
> +                       DRM_WARN("amdgpu_device_suspend failed (%d)\n", r=
);
> +                       return;
> +               }
> +               if (!amdgpu_device_cache_pci_state(pdev))
> +                       return;
>                 /* Shut down the device */
>                 pci_disable_device(pdev);
> -               pci_set_power_state(pdev, PCI_D3cold);
> +               r =3D pci_set_power_state(pdev, PCI_D3cold);
> +               if (r) {
> +                       DRM_WARN("pci_set_power_state failed (%d)\n", r);
> +                       return;
> +               }
>                 dev->switch_power_state =3D DRM_SWITCH_POWER_OFF;
>         }
>  }
> --
> 2.34.1
>
