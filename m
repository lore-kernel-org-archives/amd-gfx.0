Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B70C43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 20:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55DC710E2FA;
	Tue,  7 Jun 2022 20:28:01 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D34410E2FA
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 20:28:00 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-e93bbb54f9so24600549fac.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jun 2022 13:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pdYGmff/lo5RrQZii0YwH6PQy6I4rdXfoIio+S6Lr/A=;
 b=drJoqoBWn3qYXy3Hle/tl+prjD4zXPyXxqZxazKzWDhZNL67wso5ZStra+sT96nd83
 sLTB8nJrxf5NGGHKTfw7NfgFRbQh4mVov7ddwyU+YvKL87iDOeaqaSvkw2fj0aTda4Fg
 GkUoE4/ls7Ly9MOwB8w6wF0CfcBNUhvMRd00+Tvb8/RMWuVr7VMJVKEip6D9inraR0lr
 9rEkY6WTwE/B0rS7vMMt0h+aXQy4K17gPCNK3P4KjZD4Yzs+FtEHCjAWfSaJ9t9Gd+Dq
 WS4shw1z1wux+m9wCur570cEYCh/Pswmhox0X7njj6Uqq2y+M+bVKtJ28rhlXmPudU5F
 goVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pdYGmff/lo5RrQZii0YwH6PQy6I4rdXfoIio+S6Lr/A=;
 b=jyekkXzjN5BBCZek6waJ3aIJrnGOAGpkHKocURozH1PdFITlda2s7mczebMp8FoGJr
 6C2FcOSCzEf+RebidRzJzqRuB4ZWUNrSXYva8b11wDFlucilOKuPoiv3pgX0f7nOnPaB
 TgcGINIHTL4LYAKwrWB2qso8dH5j/Gb/+KtGyBmrzdN1xin5FElPFJu52xq8yZbx39SH
 2JDB62uyJqL8z8zCsD0r0KIz4Bfr8mjYMojFdR6nuhWbdDVb5zTWqyQAIcl//iunTi1W
 3iBLAIBuGo1MDYOYuIa9AlYqMmJ08TmH2jMtFnVtvqMpZ90y8ijEEEDpWOd4avr+0k26
 t1qg==
X-Gm-Message-State: AOAM532/ZNSZ9RKR9zwfwEep46Rt6bvvhSFfj9LZ6hUhOym+tORNPI80
 8q8RVDF+aN6Ga1KO1N3d7jwKHLEnhb9JQTY92CNt9/a/
X-Google-Smtp-Source: ABdhPJyFqB6jW1qJIIvEc91WRbostzKZSQZehm5gCa7mocaqHuJFsKMm1ecyxovoJivCWpTj/KI+eFP7af+FNkVy3sc=
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id
 v5-20020a056870310500b000f29615ff8emr401863oaa.200.1654633679774; Tue, 07 Jun
 2022 13:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220603130504.81147-1-christian.koenig@amd.com>
In-Reply-To: <20220603130504.81147-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jun 2022 16:27:48 -0400
Message-ID: <CADnq5_OxrThyuAa0z9pK7FxJ=NoOj9yoezM4aC0_sL=UUPOXBw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always flush the TLB on gfx8
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 3, 2022 at 9:05 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The TLB on GFX8 stores each block of 8 PTEs where any of the valid bits
> are set.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 9596c22fded6..b747488c28ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -847,6 +847,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm,
>         flush_tlb |=3D adev->gmc.xgmi.num_physical_nodes &&
>                      adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4=
, 0);
>
> +       /*
> +        * On GFX8 and older any 8 PTE block with a valid bit set enters =
the TLB
> +        */
> +       flush_tlb |=3D adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 0=
);
> +
>         memset(&params, 0, sizeof(params));
>         params.adev =3D adev;
>         params.vm =3D vm;
> --
> 2.25.1
>
