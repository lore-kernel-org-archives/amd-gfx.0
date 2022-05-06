Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203B8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 13:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811F410E1A7;
	Fri,  6 May 2022 13:35:11 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA3010E1A7
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 13:35:10 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id l203so7514131oif.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 May 2022 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vemQpYrO550RwReRMn4T0Bx83H1CrV0kFHIgGZgrznY=;
 b=POly/8jwxI0X4X/cqtW2wLL9l3aa/ToQrcISeKU3nYCFyLs0jBYsEez1uEQpuSGHDb
 KEgCUEz16VLPeU3ftNOStm6pHK6duY3n+pmcOGLYI97GHfFIYXrSemNiHdWeUhTAbTvI
 YelZRU4dr/heM47BJSiFOl7eTm+vLMSOILx+jNSd7wThVeAbrL8j7nQtG6msxE1FdQgn
 dL1gAOCbXqV8Dv2BUeF1Qb9xZw24hYmVXPRqgiPmx/FORf31HC69uz0N2yBHw7+aXEHd
 ocidRoyJF80Q6l2wYnOWXUqhxG3kr7wCI/ELp4rbnhJNJFoOm8mOKYwZM5HiNwqbGtfz
 p/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vemQpYrO550RwReRMn4T0Bx83H1CrV0kFHIgGZgrznY=;
 b=wO0IJaghlmghbq2KUMyTe8DPEleu6OG6sk+YaFnommr7re3RnNctZJrD7uJarVWPXT
 enC4Rqk4nAJHf2Cm4VSL/Rf8RjqQMw5d6q8WeRbwxCpDRVyW5jxRvR+71eimy/GJAjh1
 hNPBHm+g6aP8u5d48xpKpzpDiL3MTzwi/ww/VkABRGsqutubqnTJR/fWchYYvXercXKj
 mxULVhT0qfB9MOuMwypkLEWKKPXycJ9USP0oBnJBDIoeNDuhdMDSvJOQgPQMWLzGp64v
 b/A5u/3lJehyv1zK8ST5GUMoBnfNTo7e/ZR82pDyZPu7mLBY32oFuJOt/TjKer38RcPj
 VElw==
X-Gm-Message-State: AOAM532qiKesbCALyJG96qx8wmkWpSEX1ZlWhJMG5lfzvYz60TPQ+KUt
 wOaNoUmCmKfEjrURcnoRKxp7gXHs0QAgT7a8Pic=
X-Google-Smtp-Source: ABdhPJzl+6I+8LKysKvFh0wg5QokZI7uzGmfRK9PqnoEPzfc/yaIWNnvHndsMhf2z3yTYrWe31TRXLQU9P7IyiLDejQ=
X-Received: by 2002:a05:6808:178d:b0:326:3fe9:7f03 with SMTP id
 bg13-20020a056808178d00b003263fe97f03mr4584028oib.200.1651844109748; Fri, 06
 May 2022 06:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <20220506112312.347519-3-christian.koenig@amd.com>
In-Reply-To: <20220506112312.347519-3-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 May 2022 09:34:58 -0400
Message-ID: <CADnq5_ONANC=SML3sHv3RKG5X2ZYNiv5gvzW_ExRdQdbg=oyhg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: bump minor version number
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
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 6, 2022 at 7:23 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Increase the minor version number to indicate that the new flags are
> avaiable.

typo: available.  Other than that the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Once we get the Mesa patches.

Alex


>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 16871baee784..3dbf406b4194 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -99,10 +99,11 @@
>   * - 3.43.0 - Add device hot plug/unplug support
>   * - 3.44.0 - DCN3 supports DCC independent block settings: !64B && 128B=
, 64B && 128B
>   * - 3.45.0 - Add context ioctl stable pstate interface
> - * * 3.46.0 - To enable hot plug amdgpu tests in libdrm
> + * - 3.46.0 - To enable hot plug amdgpu tests in libdrm
> + * * 3.47.0 - Add AMDGPU_GEM_CREATE_DISCARDABLE and AMDGPU_VM_NOALLOC fl=
ags
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       46
> +#define KMS_DRIVER_MINOR       47
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  int amdgpu_vram_limit;
> --
> 2.25.1
>
