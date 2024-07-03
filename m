Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8FEC2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 17:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1094510E99F;
	Wed,  3 Jul 2024 17:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KuYwibfp";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA3D310E99E
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 17:55:02 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-726d9b3bcf8so4356897a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jul 2024 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720029302; x=1720634102; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DyQ8s00KwuH09aKQW/DWUF8aQZjEEjD5MkzVVchsiTA=;
 b=KuYwibfpwL9Gt0Kr60vMCAReTuCVoXQSvtz+8JjmmEY0f/kh/dFcM1FE0vUXUpE/1C
 9s3PhhV/Ri7uS7Cb9M8yqxZBi8KYHlCIP51AF2gBRZ2IaTpbhxCuOZe/hbC4GWh7VPUa
 FzaAYiDICMj5AFW0IMcz4mSzcnHp7oOVpHSeaQkIyTYyE50DRo3DQs2NRPNB/8/XRPfG
 k5eWlPfKXayAcSqz3EorDbFEZMmatElQt6KPRBp4OiPfy63DYW+zp4wRunKVrZ0c/12b
 yDB5dp7mY3aNEcvnr/rY6LrOxY0Lzz2xysPPrmeefbTMLg/wVH/7je6V46nFH+jIABIz
 EUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720029302; x=1720634102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DyQ8s00KwuH09aKQW/DWUF8aQZjEEjD5MkzVVchsiTA=;
 b=v5ukLS2+Dlr9iOTmdqfGB1uKgSbg4161FXXlhD2GroziQp3sWy1cTPIyCGucpn83nt
 /AFThBjFzPz+t6DqKqD+6n1tdzyuxeS876nQmH8Qt4kIpMcLNzk5NbYvxBsl363+aJ8f
 taRmJlI5KoBIV5fUvBO0qq/vxd/l5/dmqG96Lg4MVrXFYXXjLrJyRtmCTTfwYB2H6nes
 Xt0iJDpY0MxdPyi6I300pPANdy7MpX6gw5SZacNgEcF0WIyYFGtHIart0Cydmoy/NZ6m
 f6dwPgXQaUa+kYtUNxUDb5QQR4bzsMLZe6f4Tf7lKASuGGV/9zINtr2b3hfU0kP6hY8H
 Tggw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAOnmwHtTVWrYnujx8/0Ta8zrzEdqpbJE1wp+mPOCUxGt5GoAutf6nnK51k9oeYoo9TfiXEjdPiRlyUxv6dluVjfSHGtVvtSQOrRkWNQ==
X-Gm-Message-State: AOJu0Yx5fQoYHih1YXTwpM4e2g1fW9f+cSZGDKSyjPm7d+qyYO9kZZ8W
 lUZI9f3lgF5mrhPcIg0fMVLdBQFVim2D7PcwzHCPRjOgI+5W2Amn09RDS0xOi+u2vi9M+1z6FDR
 110PdPGwQExaoxjVqsHdWiXGApAQONQ==
X-Google-Smtp-Source: AGHT+IGRDQWIPv+tMlDWBbRejQ/zpyKNVkiQRg4jn5mkWQuAR0prVAUrp9zM3UBgAVPmkuV82PWfWdQZxjz6KLWvufo=
X-Received: by 2002:a05:6a20:a106:b0:1bd:2559:305e with SMTP id
 adf61e73a8af0-1bef610cecemr13140645637.30.1720029302185; Wed, 03 Jul 2024
 10:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240703174908.2610353-1-sunil.khatri@amd.com>
 <20240703174908.2610353-2-sunil.khatri@amd.com>
In-Reply-To: <20240703174908.2610353-2-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jul 2024 13:54:50 -0400
Message-ID: <CADnq5_NiiiUOgdw2qVPtHb3PVR7zcyxO1WjoOLkti2f=a0njuw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/amdgpu: enable redirection of irq's for IH v7.0
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jul 3, 2024 at 1:49=E2=80=AFPM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> Enable redirection of irq for pagefaults for specific
> clients to avoid overflow without dropping interrupts.
>
> So here we redirect the interrupts to another IH ring
> i.e ring1 where only these interrupts are processed.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/ih_v7_0.c
> index 548b3c63a765..6852081fcff2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -346,6 +346,21 @@ static int ih_v7_0_irq_init(struct amdgpu_device *ad=
ev)
>                             DELAY, 3);
>         WREG32_SOC15(OSSSYS, 0, regIH_MSI_STORM_CTRL, tmp);
>
> +       /* Redirect the interrupts to IH RB1 for dGPU */
> +       if (adev->irq.ih1.ring_size) {
> +               tmp =3D RREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_IN=
DEX);
> +               tmp =3D REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_INDEX, IND=
EX, 0);
> +               WREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_INDEX, tmp=
);
> +
> +               tmp =3D RREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DA=
TA);
> +               tmp =3D REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA, CLIE=
NT_ID, 0xa);
> +               tmp =3D REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA, SOUR=
CE_ID, 0x0);
> +               tmp =3D REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA,
> +                                   SOURCE_ID_MATCH_ENABLE, 0x1);
> +
> +               WREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DATA, tmp)=
;
> +       }
> +
>         pci_set_master(adev->pdev);
>
>         /* enable interrupts */
> --
> 2.34.1
>
