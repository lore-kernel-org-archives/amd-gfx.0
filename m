Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFFAEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 14:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7790610E635;
	Fri, 16 Jun 2023 14:12:04 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBA010E635
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 14:12:02 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-39e86b3da59so618432b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686924722; x=1689516722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZR8l87uxMTn24HKBJkRWEV1gNPPBQJxvGEngYiN4xkQ=;
 b=j5WOs6Ftj3JBiMEpAfWucV9BkxMbsAsHbfb/l4V8+uuD51kAZDiU5t9DOOKK3gIUdK
 z9T5+6pWqpRNpHx89X123mOstQwn8SvXyIWxcRtb37fzf5RQnxMqLPqN/wCMf9oe+dmp
 iGU57FwGUdCtpT2+tLzrqq3Iz9+gnZYoLyPziEk/k1Hhc3UbDoboIi6Tnwjti2rLP5bT
 f0A66MNudWL5BGLCPp3QmxDS8nTprmANOSnj4ClSTXybkFimf+gdma/1onkcQThsbAtX
 febgJqw5hpeT4XLhqWhio+OnMSspZt6yEm4qlxsfu6ZJPBH3PE3VzK1ayp9e8U467lEA
 cAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686924722; x=1689516722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZR8l87uxMTn24HKBJkRWEV1gNPPBQJxvGEngYiN4xkQ=;
 b=DNZu63XyiNB/ckplxsWqYdRLgh6+6yQzO2EOsjC4N6zqn44o+viH2YBXOCZPxqFgmD
 Eljo937IswClbwWuei0cfx2bszuiYuAmIlh/7GuHAS/tyjBeBPJ2fSO1qevoMQ5vDezZ
 BJ6CcMQCbPzo5IoEyhKd/Iarlz89MQckC+vuIF0B9zdBi4mSETSapywp+6EO/xDOvXIE
 PloSSGME+URFC/QIOPDZ403TwdpBHy5VKaWVBgOoJ2z19YTsHId3MZ2vIiGQSlx5uwtG
 Gygy8lSpLWYAhbySP0SIli+lwzwZIFZ+QV762MrQlaVuGPQWoazoTPM9ZNjxxh7d/V/Y
 JyYA==
X-Gm-Message-State: AC+VfDy+JlxNcZh3pLvVWWxsDhznYgjI/sPp2Mgg+yWI/SoE3xAkNRbk
 En68jUBvyi+um3z1U5NSGwg9jcP3cWv14nLH3YY=
X-Google-Smtp-Source: ACHHUZ7S7UcTqzYA4X92kgh1zTF0zzUpPOtfVou4EAWc1BUBVzWSXBetXuQNVekQXln0eh+Olb1I2/5nGt05X9ocfS4=
X-Received: by 2002:a05:6808:2394:b0:39e:78ae:1d2c with SMTP id
 bp20-20020a056808239400b0039e78ae1d2cmr2519162oib.58.1686924721691; Fri, 16
 Jun 2023 07:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230616062708.15913-1-samuel.pitoiset@gmail.com>
 <20230616131407.170149-1-samuel.pitoiset@gmail.com>
In-Reply-To: <20230616131407.170149-1-samuel.pitoiset@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Jun 2023 10:11:50 -0400
Message-ID: <CADnq5_MxYHW8-LYvm2KevPQaiQGh=Yzq1QO7ejc7hwzjeZXW9Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix clearing mappings for BOs that are
 always valid in VM
To: Samuel Pitoiset <samuel.pitoiset@gmail.com>
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
Cc: stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Fri, Jun 16, 2023 at 9:38=E2=80=AFAM Samuel Pitoiset
<samuel.pitoiset@gmail.com> wrote:
>
> Per VM BOs must be marked as moved or otherwise their ranges are not
> updated on use which might be necessary when the replace operation
> splits mappings.
>
> This fixes random GPU hangs when replacing sparse mappings from the
> userspace, while OP_MAP/OP_UNMAP works fine because always valid BOs
> are correctly handled there.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 143d11afe0e5..eff73c428b12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1771,18 +1771,30 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_dev=
ice *adev,
>
>         /* Insert partial mapping before the range */
>         if (!list_empty(&before->list)) {
> +               struct amdgpu_bo *bo =3D before->bo_va->base.bo;
> +
>                 amdgpu_vm_it_insert(before, &vm->va);
>                 if (before->flags & AMDGPU_PTE_PRT)
>                         amdgpu_vm_prt_get(adev);
> +
> +               if (bo && bo->tbo.base.resv =3D=3D vm->root.bo->tbo.base.=
resv &&
> +                   !before->bo_va->base.moved)
> +                       amdgpu_vm_bo_moved(&before->bo_va->base);
>         } else {
>                 kfree(before);
>         }
>
>         /* Insert partial mapping after the range */
>         if (!list_empty(&after->list)) {
> +               struct amdgpu_bo *bo =3D after->bo_va->base.bo;
> +
>                 amdgpu_vm_it_insert(after, &vm->va);
>                 if (after->flags & AMDGPU_PTE_PRT)
>                         amdgpu_vm_prt_get(adev);
> +
> +               if (bo && bo->tbo.base.resv =3D=3D vm->root.bo->tbo.base.=
resv &&
> +                   !after->bo_va->base.moved)
> +                       amdgpu_vm_bo_moved(&after->bo_va->base);
>         } else {
>                 kfree(after);
>         }
> --
> 2.41.0
>
