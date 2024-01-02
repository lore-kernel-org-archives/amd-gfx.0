Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364FCC47074
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 19:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DEF910E14A;
	Tue,  2 Jan 2024 19:44:04 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83D2A10E148
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 19:44:03 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-20451ecbb80so4952652fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jan 2024 11:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704224642; x=1704829442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6N5edZ+25Aqc07in1Gsuqd9U2TqsukxmwXtZxk2B/E=;
 b=U7rBhs1CjRw6mHt4oMZFvA1VCh+l022zC2BFG6uPHwGX6+R7aHR4eTZVlKZYEnxgPX
 QKwm/lLRoda4PlLjHRX3YvaDbGuToKLoWxEB70/AdDG1aylFMcwQLN0txdoyUa8hM7TV
 f0ABaM+HnTIpvo85gy6YJjS19TF5/YNDvIiliAZG119mfRjAscQTCxFZD9dig9WrhOaL
 A3jpRyBa1wFOdnR7vbYRLSsd00TIt4vEOAKfddvruC01kfRFIih5OqZkNvpgCWBxW/vC
 8Ue4Mv5+95U9iGJZ5frutA1I4Maee2N5i62w4MoyyB2El7NsV0bXmP3A5sgZsBX7lYsR
 /HtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704224642; x=1704829442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T6N5edZ+25Aqc07in1Gsuqd9U2TqsukxmwXtZxk2B/E=;
 b=syjYqHzDlleVMQmpRyQ2NY5X1DfNpKJgjzcdujXRpREPMDGwXHNPIYOgatJfdZGLgR
 vbo+54YoNbMoVaEnzn6XADA9l8NKBHfNTZqEHNk66cz/xGmswbQNXC7jhnOjA0jrWtpk
 G+nwNx5gYFc7LT8W0zkM+AnZKPJX3yY9/JjlJBpWWMnNpHGwMcVx0s/mRUY4Bafk/VHc
 TnJ6Q4bYsORpNz70hnPBNmBBiGzIkJuoUeW7JYhGQgOBKuwEA5lXTPPAp8Qabaeh8mmQ
 IXJDs2rzIOjzvHo3p6ldyKUSCrLtP4ZkWfQ9uWCuqrwDT9yLihtWTT7ouu+xbSn08W+V
 yfSQ==
X-Gm-Message-State: AOJu0YxTdKrzYsKpVkWBNfb0uL3uagGjkpEGb3uRlvmnwhqX1rXWnLVf
 LRsq0rO/I/DcV+uHpZk/ySMxqSxFMMbdBsalvRY=
X-Google-Smtp-Source: AGHT+IFFBmezn8cyzejeKYgtGTE51RmBHanX6jGLzT73nzYxRHjLdFP2hCti7y0zCB5MJjA+A5Zuojcjow4L1e4c8X4=
X-Received: by 2002:a05:6871:688:b0:1fb:75b:99c8 with SMTP id
 l8-20020a056871068800b001fb075b99c8mr16928066oao.119.1704224642235; Tue, 02
 Jan 2024 11:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20240102034341.16321-1-Hawking.Zhang@amd.com>
 <20240102034341.16321-3-Hawking.Zhang@amd.com>
In-Reply-To: <20240102034341.16321-3-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jan 2024 14:43:50 -0500
Message-ID: <CADnq5_OXqvmzNdjyOS8mNe3kVqAyRuCFRm4GEdiC1v9cSe7hWw@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amdgpu: Init pcie_index/data address as fallback
To: Hawking Zhang <Hawking.Zhang@amd.com>
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Yang Wang <kevinyang.wang@amd.com>,
 Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 Le Ma <le.ma@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Candice Li <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 1, 2024 at 10:50=E2=80=AFPM Hawking Zhang <Hawking.Zhang@amd.co=
m> wrote:
>
> To allow using this helper for indirect access when
> nbio funcs is not available. For instance, in ip
> discovery phase.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 001a35fa0f19..873419a5b9aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -781,12 +781,22 @@ u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_d=
evice *adev,
>         void __iomem *pcie_index_hi_offset;
>         void __iomem *pcie_data_offset;
>
> -       pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
> -       pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
> -       if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offs=
et))
> -               pcie_index_hi =3D adev->nbio.funcs->get_pcie_index_hi_off=
set(adev);
> -       else
> +       if (unlikely(!adev->nbio.funcs)) {
> +               pcie_index =3D (0x38 >> 2);
> +               pcie_data =3D (0x3C >> 2);
> +       } else {
> +               pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(ad=
ev);
> +               pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev=
);
> +       }
> +
> +       if (reg_addr >> 32) {
> +               if (unlikely(!adev->nbio.funcs))
> +                       pcie_index_hi =3D (0x44 >> 2);

I'd still use a define for these, E.g.,

#define AMDGPU_PCIE_INDEX_FALLBACK (0x38 >> 2)
etc.
Or something similar.

Alex

> +               else
> +                       pcie_index_hi =3D adev->nbio.funcs->get_pcie_inde=
x_hi_offset(adev);
> +       } else {
>                 pcie_index_hi =3D 0;
> +       }
>
>         spin_lock_irqsave(&adev->pcie_idx_lock, flags);
>         pcie_index_offset =3D (void __iomem *)adev->rmmio + pcie_index * =
4;
> --
> 2.17.1
>
