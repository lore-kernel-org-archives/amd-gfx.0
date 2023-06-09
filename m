Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A4EC7EE25
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 17:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808FF10E161;
	Fri,  9 Jun 2023 17:13:48 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D7210E161
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 17:13:47 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b296cadbffso775315a34.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Jun 2023 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686330825; x=1688922825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9Ew8qCQrlyCyJxxDqgYQcfx9Zs2F5EdKF+oKOoHqvY=;
 b=cm9T1sWDc1RSVdXAlL19wRySXnm89mfFu0us89Bjb13C8L+Yg5zp7T/DELESlR2Yk3
 pzbyi9dbUNfvj3NtNfxxoCniQcuEItOOqHJse1rTaF+/lgixVwmHtnhWkR7rOgkqjPPf
 bAn7avdTBHVstCBZj23eqDvJmsJcaABQlyb4w3f33xLT+AqrixlAT979Zm25B1POXN2j
 F/U/liKNY0lSEaXX+WKJzFCM0gaBOC81RsUZLGhPbr9JYcOxsFx2H46kBNN7mPJEXyHI
 FBqSDN/I1Fl2dE1Kql+5SGqR1NLTeDNzXxNUHarIzBwtrU3cY3S3DjejyAHyQz95Uk5t
 hKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686330825; x=1688922825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o9Ew8qCQrlyCyJxxDqgYQcfx9Zs2F5EdKF+oKOoHqvY=;
 b=Sak2cAvP0Umrs8QhMGdohnO+PxXse4Ra4wZnKZ2wd984GcFylxUbPUl3XVgE/1pR01
 eAsMM8bNXsbovv5Vej1+ZhzdRjAWG89tVFqKPP22m3gvTNts+b7c5IRwFkTdxmTnKo5Y
 NfCn5DFaXSz4opxWH4kp9i3BMmeGYRVT5/0lSdV6CVrv85eJ++yDxywRND76yG5pSPhf
 vWg2FE/MYapT76zrnJF29rR5SjyRIfeIT2Ybjae0nznF1lIOYbVp4dSeU9jl1vwJQDaq
 3Sjxq4bdKmYkugcNGXkBB9x6rjuzCEWlB7Hf08C8wepVMjcp46//CFD9SRmPgEDMy6kz
 9frg==
X-Gm-Message-State: AC+VfDzdGz/QXqi5/BuDqx6Xc/b6RLwr41Z/lTZ3H+12PiQBXlEmZkTz
 LML1zQvnYyKTx1dO/XGirB8XOyyxSVEnQlyue+RIoo/k
X-Google-Smtp-Source: ACHHUZ5iL1LmL5ZNXUOoKB+u/AxpGh0p4jYbWsUj6O60GhdjPkSJ7pevaY+6M6NGnGKkQlL/qSSAnlRQlOdMPFqCQrQ=
X-Received: by 2002:a05:6870:d2ab:b0:1a2:9a3c:ae31 with SMTP id
 d43-20020a056870d2ab00b001a29a3cae31mr1611381oae.11.1686330825626; Fri, 09
 Jun 2023 10:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230609151123.1006374-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230609151123.1006374-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Jun 2023 13:13:34 -0400
Message-ID: <CADnq5_PU4jRNMCGdb6LTNQpnhqGEMmppVrDd_1OUrcZkeegDzw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix kdoc warning
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Jun 9, 2023 at 11:11=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the following gcc with W=3D1:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c:76: warning: This comment =
starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-=
guide/kernel-doc.rst
>  * EEPROM Table structure v1
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c:98: warning: This comment =
starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-=
guide/kernel-doc.rst
>  * EEPROM Table structrue v2.1
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index c2e8f6491ac6..0648dfe559af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -72,7 +72,7 @@
>  /* Bad GPU tag =E2=80=98BADG=E2=80=99 */
>  #define RAS_TABLE_HDR_BAD       0x42414447
>
> -/**
> +/*
>   * EEPROM Table structure v1
>   * ---------------------------------
>   * |                               |
> @@ -94,7 +94,7 @@
>  #define RAS_MAX_RECORD_COUNT    ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_=
SIZE) \
>                                  / RAS_TABLE_RECORD_SIZE)
>
> -/**
> +/*
>   * EEPROM Table structrue v2.1
>   * ---------------------------------
>   * |                               |
> --
> 2.25.1
>
