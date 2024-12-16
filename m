Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59386E77183
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 18:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E742310E616;
	Mon, 16 Dec 2024 18:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OCjYj6A2";
	dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D6410E616
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 18:04:08 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ee8ecb721dso780301a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 10:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734372248; x=1734977048; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SmdU+z4thx6hqK5wfrVIEw+18jKRwR9or1g+LDTZilI=;
 b=OCjYj6A23L/kI58nOPD7v7K5NEAgjGgnltyXsS8GJ19le6Au+DWMaLmjFllqZZ05LZ
 MoDuaClfTsk6Rjb8RQfv+rOsTV9FIvGm9EOnJWGM349DnML4kMVAJQoh2qWD2JME1Php
 mbBCt6bIU6gHXxtWlucieEd5n0GHn8sOjzXZfbgMRQVm6R32YLsB/C6c2dpaeopEFhV8
 KkDWS/pJ0TGOryCr1kCWrev5RviMe21czw+EAQfUFqQX+pYOWWugtnbVjd58JhVFmmPF
 /j7NrhOTjKdcW5arDeRv/IpR4hfdjIY3e0r4SOyNJKsMYMa0522yN4YoXgZJFshRZU6y
 xRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734372248; x=1734977048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SmdU+z4thx6hqK5wfrVIEw+18jKRwR9or1g+LDTZilI=;
 b=UzWmy1iQEkORmawNum+9O34Y/0NP2v1PEaJbRJot02J0HuWd2ESlxwGN/Q8B8+S7/k
 h6WM+//5ykmiEg8q9cHgGqEwChcqXVHcRMFxuJ9RcvSDoQScgGZWT0Y3KucnfJN+GOUC
 8lIZxp0ERpuXa2zATjX9RAPcwXttWxzrEvGrxtgXpFDteAHulsyVsHQVVeiHzcofwRkH
 rh1+ZmV0u2V6Jiw6AnpevL3uPk5WQzlP2jWpdOum14EB0xnm6yPirkZmRRo8TsYiI4qV
 HbCQyjmpnWmbg8xqstK+Chb+m8jzQHYEzVmfRzaTL7ZB+pwCLWS5lN7wWfSJJ7TtzA1o
 xMig==
X-Gm-Message-State: AOJu0YxcZh7KuLnQWypxL0ugYRRJrQIVWqUNe2KGaN1utOmo4Hxm4ZGt
 rYT+4kVpbIRXeHSdtu5E7D7xPMNRLByBxT63S208Y1u8xErWFksbRUJYATFbqmBD+j1a8nqQw+a
 kXGcyn1UVb5J1wsQv4zFuGZAXPmpoOg==
X-Gm-Gg: ASbGncuFZyKGF77MjAXV7TO66dm8E9mzdtef5argTTyS1QyVZLNqprY73BinXeptupL
 QX/eKPeo0U1Kyq0vND5A4IYjFq3LLcYizKPm3Og==
X-Google-Smtp-Source: AGHT+IE1n3ZNwFKPcHlHF+l4d9G/qTMnWJoaxXLdUmXRS4T8tJTWhumcHc9x27A0kd2Wtj5IivJ9o+JqyqW9l4a/+aQ=
X-Received: by 2002:a17:90b:5444:b0:2ef:93:154e with SMTP id
 98e67ed59e1d1-2f2901b2b70mr7407588a91.5.1734372247677; Mon, 16 Dec 2024
 10:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20241216092929.105280-1-jesse.zhang@amd.com>
 <20241216092929.105280-3-jesse.zhang@amd.com>
In-Reply-To: <20241216092929.105280-3-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Dec 2024 13:03:56 -0500
Message-ID: <CADnq5_OAHoTVhHJtabAbLWTQ390nrHgFyOwiK03fkBn1-5C60A@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue reset for
 different asic
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Tim.Huang@amd.com,
 jiadong.zhu@amd.com
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

On Mon, Dec 16, 2024 at 4:30=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@am=
d.com> wrote:
>
> Implement sdma queue reset by SMU_MSG_ResetSDMA2
>
> Suggested-by: Tim Huang <tim.huang@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 30 ++++++++++++++-----
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 9222e7a777a6..446959145058 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2721,17 +2721,31 @@ static int smu_v13_0_6_send_rma_reason(struct smu=
_context *smu)
>
>  static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst=
_mask)
>  {
> -       struct amdgpu_device *adev =3D smu->adev;
> +       uint32_t smu_program;
>         int ret =3D 0;
>
> -       /* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 an=
d above */
> -       if ((adev->flags & AMD_IS_APU) ||
> -           amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D IP_VERSION(13, 0, 6=
) ||
> -           smu->smc_fw_version < 0x00557900)
> -               return 0;
> +       smu_program =3D (smu->smc_fw_version >> 24) & 0xff;
> +       switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
> +       case IP_VERSION(13, 0, 6):
> +               if (((smu_program =3D=3D 7) && (smu->smc_fw_version > 0x0=
7550763)) ||
> +                       ((smu_program =3D=3D 0) && (smu->smc_fw_version >=
 0x00557700)))
> +                       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +                               SMU_MSG_ResetSDMA, inst_mask, NULL);
> +               else if ((smu_program =3D=3D 4) &&
> +                       (smu->smc_fw_version > 0x4556e6c))
> +                       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +                                     SMU_MSG_ResetSDMA2, inst_mask, NULL=
);
> +               break;
> +       case IP_VERSION(13, 0, 14):
> +               if ((smu_program =3D=3D 5) &&
> +                       (smu->smc_fw_version > 0x05550f00))
> +                       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +                                     SMU_MSG_ResetSDMA2, inst_mask, NULL=
);
> +               break;
> +       default:
> +               break;
> +       }
>
> -       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> -                                             SMU_MSG_ResetSDMA, inst_mas=
k, NULL);
>         if (ret)
>                 dev_err(smu->adev->dev,
>                         "failed to send ResetSDMA event with mask 0x%x\n"=
,
> --
> 2.25.1
>
