Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA5ACCF9FC
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 14:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6E0E10E99B;
	Thu, 30 Oct 2025 14:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nrY2ExGG";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 452B310E99B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 14:20:21 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-26808b24a00so2052875ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761834021; x=1762438821; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fr/xKsLYiju/u8n+oVAaehTAOm0s6fTcU0fGSAw84H8=;
 b=nrY2ExGGv3F7c1cADeZQORRrZ2sETlM2rUHlBKIGrLTQ8m9c+MoT3f6DrFKgHDatka
 Va/Jz9EANCZiddM0aDHFabLPSQv/JlPUo6+hEgmxgm6b9v0v1qUR7E+CKpAz7dWy3jSy
 JgghCWImKsnU+Rl5RX5ZQ6bII9X0Jf8fkh6YtsIlK4cNj9cGj6C1M/Izj11eNIRuDqsx
 7OwkVmkGvzN9RI57rGWvsDI7+zmVECkkE/fr3kp/TJdEclRLm4wDg+r078cLZmgwTHUL
 EQ1KN2gy1JB8WluqmCK/ur/89oZsAAvHppN0R/ixABeZmRyAYDha8Hl0073hFAzjz9G0
 oJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761834021; x=1762438821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fr/xKsLYiju/u8n+oVAaehTAOm0s6fTcU0fGSAw84H8=;
 b=F2ofd+Q6fUHMYPpUg+3cRUKJqkXySWK6ne2B5r5BAiDhIaZ/5wxAxdtMaUCATZDQOc
 mBkRvkCfO7nzHhF+s6Ixc5MikVYQ4+rwlWdWfWZC2PPgRjkvwIWdbjw++PkofYOgF7qA
 3D/WGQUNlU38mxQ7vPfEqJgaY/kIkqu874Gsg3EHF6ABCN8EcS87XtHRFF7eMkMptCnh
 8PouPsU/Z13+SOWkWyxTAbJdTXjEVdIQy4efb8CZX8dSPHoFxiMiBmsQiRIDXdK2dqjn
 lpx6Phirs89/OvK+ALNPt+fv5BK262AteMy9PZtm2BNLu2Xs+HZZKxoBmpc924AjxG+k
 tXzQ==
X-Gm-Message-State: AOJu0YzLsjOwl1Uzkzl+4yyKkH6nFAz6tbbhXOCfv64K3+dC++MUpbNQ
 UeDZJWqRK1w/zcRDNLzx1hkRdx4y0ltslFeE6/uM3hrQ0ACpk8aKfq0WrNdlRzMnv2LN6yH2GJx
 mxPIfa5NrlarKJBN6zkZmruLE4IsUGrjwMOc8
X-Gm-Gg: ASbGncu0ryBY0FlwITWSPviRAh3jf689kS5B0bgy0rb/FP4DhJRbip0BqJ9DK230kLY
 J0qTgg1br6vXyePtiHqPahyWJxfw5FXiITarMbKWqI1z9JveMaJa0eiqu1UjwuEbdJnjrBFSJdN
 J/CTBE8h+F2Jvqw6Of5usL5a3y33vNzpjWZLd288knlifB4q1k4YYtHOMOD1WcDa5RH8AoRIfW1
 XyQY+gpXjp5CGbDnGVEFx1EcIJpZxRllrHBAcXm0Lu7xYwuuXvkthYm0qf4
X-Google-Smtp-Source: AGHT+IGiV0aIpVcEeqxtmA8/mb2XpRFh0QqnV4P1qYxDM4qPEyVtkE9D0nAgUzsp27ull5pICWDBZZN0LIv2bu5IEfE=
X-Received: by 2002:a17:902:c404:b0:269:96d2:9c96 with SMTP id
 d9443c01a7336-294dea100damr49638645ad.0.1761834020291; Thu, 30 Oct 2025
 07:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20251030010027.2503555-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20251030010027.2503555-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Oct 2025 10:20:07 -0400
X-Gm-Features: AWmQ_bnpkZav4-AdnmIZ5hsiglOYr2b6jzzyVFoLndiMbbFxU6YOSPpXX1aPsqo
Message-ID: <CADnq5_MMZ+mE1=0aRRLE7dbfpndVOXL9UCODB7BeQg9QMyspJw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdkfd: Fix GPU mappings for APU after prefetch
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>
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

On Wed, Oct 29, 2025 at 9:36=E2=80=AFPM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> Fix the following corner case:-
>  Consider a 2M huge page SVM allocation, followed by prefetch call for
> the first 4K page. The whole range is initially mapped with single PTE.
> After the prefetch, this range gets split to first page + rest of the
> pages. Currently, the first page mapping is not updated on MI300A (APU)
> since page hasn't migrated. However, after range split PTE mapping it not
> valid.
>
> Fix this by forcing page table update for the whole range when prefetch
> is called.  Calling prefetch on APU doesn't improve performance. If all
> it deteriotes. However, functionality has to be supported.
>
> v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with carveout
> VRAM

apu_prefer_gtt is used by small APUs as well.  It depends on how much
VRAM vs GTT is available on the system.

        if (adev->flags & AMD_IS_APU) {
                if (adev->gmc.real_vram_size < gtt_size)
                        adev->apu_prefer_gtt =3D true;
        }

Alex

>
> Suggested-by: Philip Yang <Philip.Yang@amd.com>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index c30dfb8ec236..76cab1c8aaa2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -766,14 +766,21 @@ svm_range_apply_attrs(struct kfd_process *p, struct=
 svm_range *prange,
>  {
>         uint32_t i;
>         int gpuidx;
> +       struct kfd_node *node;
>
>         for (i =3D 0; i < nattr; i++) {
>                 switch (attrs[i].type) {
>                 case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
>                         prange->preferred_loc =3D attrs[i].value;
> +                       node =3D svm_range_get_node_by_id(prange, attrs[i=
].value);
> +                       if (node && node->adev->apu_prefer_gtt && !p->xna=
ck_enabled)
> +                               *update_mapping =3D true;
>                         break;
>                 case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
>                         prange->prefetch_loc =3D attrs[i].value;
> +                       node =3D svm_range_get_node_by_id(prange, attrs[i=
].value);
> +                       if (node && node->adev->apu_prefer_gtt && !p->xna=
ck_enabled)
> +                               *update_mapping =3D true;
>                         break;
>                 case KFD_IOCTL_SVM_ATTR_ACCESS:
>                 case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
> --
> 2.34.1
>
