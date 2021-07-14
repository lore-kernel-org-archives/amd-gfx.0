Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39070C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02FA6128D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02FA6128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81B736E3CE;
	Wed, 14 Jul 2021 15:50:44 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 975506E3CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 15:50:43 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 m14-20020a4a240e0000b029025e4d9b0a3dso720388oof.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+5xLdtpDcTwLYJnAW4JgegPQBzUVIDnvvCvyi5Hh5VY=;
 b=Kz5eWyr0EMymjKSp/YVqon7LG/k4wRPY332Q8r7zJswDO943bCj3d6wo1gaBKelytk
 LfIITW1dReuoJ9Rc0lIN2Of8EdrNM+mljiKPC3ZI2wPQL1VpPENbgTy8wgQecAsD9oeC
 qi+C/bTqqg24to0YjxfrPURNSTNmbJgrP9HxD/1j9cLbxewEJtchX58dusjARWScIffa
 KgZUyAAdjCA1ZLZ3TZAixskAokkJvQ2K1zoWonaOR9EhCo/TBybSzrJHl6wWMnpnadPT
 DGAUACKaK1fhByM4rqdjt703X2KUmzzJSCwfrOob6a6RPM1XZCvdxVOuXlRkhNHNSm51
 cM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+5xLdtpDcTwLYJnAW4JgegPQBzUVIDnvvCvyi5Hh5VY=;
 b=ZBjDnPGsIiywlG+ndTGSWIeGGNX9zhrDbHmSd2KKOLq+i8wWxtbL4YR77olIgXtOd7
 yuMgaxm6gNsa69zEPvDZgLmqkqib9eOnp8DyTpmEJzK/9meTlpXNanNeexP0v4PQq/bh
 4l2yGtB+qfaLkfjaazLcpggATQu+wcy3JVfEQr2J+R+HzmsoGz/vTVR8grIBn79OOLzZ
 wUiyyiF1u01YUCTO/rjvoJKq2xWjs75r1bSwtGdjraMq6LJqwjdjleTpaEEb76i6Vhd0
 JJMa+mDKHUFJgFBvdUAWjnR15uOft0SGqCc71Wvq6+6veIH3qNUmy0GADZ7rje/uG3Ak
 sWxQ==
X-Gm-Message-State: AOAM532axXFWUbNmKZpv/Zcqj0j0DBfaV/e+WSdkHX7BJLvvXIwvtN+N
 itj0QO0sOPzpAkvdtkQkOK/CASsKDIIthBfVRfI=
X-Google-Smtp-Source: ABdhPJwOc4lKJV8Eych6oy/cBYP1LTSzI/jsPk6YNff318/kCSD2/LzBcvxlLkM+KFkChTuE+CyplPjjfNXIqg7pIY0=
X-Received: by 2002:a4a:be93:: with SMTP id o19mr8548849oop.61.1626277843038; 
 Wed, 14 Jul 2021 08:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
 <1626276343-3552-4-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1626276343-3552-4-git-send-email-Oak.Zeng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Jul 2021 11:50:32 -0400
Message-ID: <CADnq5_NqnYEbxXJmv55LsVtvq8czjwO=ZQ8KqSM3tizeAvJ5qw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Change a few function names
To: Oak Zeng <Oak.Zeng@amd.com>
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
Cc: Feifei Xu <feifei.xu@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 Leo Liu <leo.liu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 14, 2021 at 11:25 AM Oak Zeng <Oak.Zeng@amd.com> wrote:
>
> Function name "psp_np_fw_load" is not proper as people don't
> know _np_fw_ means "non psp firmware". Change the function
> name to psp_load_non_psp_fw for better understanding. Same
> thing for function psp_execute_np_fw_load.
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index d9ddb2c..8d1e2b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2351,7 +2351,7 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
>         return ret;
>  }
>
> -static int psp_execute_np_fw_load(struct psp_context *psp,
> +static int psp_execute_non_psp_fw_load(struct psp_context *psp,
>                                   struct amdgpu_firmware_info *ucode)
>  {
>         int ret = 0;
> @@ -2387,7 +2387,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
>                 }
>         }
>
> -       ret = psp_execute_np_fw_load(psp, ucode);
> +       ret = psp_execute_non_psp_fw_load(psp, ucode);
>
>         if (ret)
>                 DRM_ERROR("PSP load smu failed!\n");
> @@ -2442,14 +2442,14 @@ int psp_load_fw_list(struct psp_context *psp,
>         for (i = 0; i < ucode_count; ++i) {
>                 ucode = ucode_list[i];
>                 psp_print_fw_hdr(psp, ucode);
> -               ret = psp_execute_np_fw_load(psp, ucode);
> +               ret = psp_execute_non_psp_fw_load(psp, ucode);
>                 if (ret)
>                         return ret;
>         }
>         return ret;
>  }
>
> -static int psp_np_fw_load(struct psp_context *psp)
> +static int psp_load_non_psp_fw(struct psp_context *psp)
>  {
>         int i, ret;
>         struct amdgpu_firmware_info *ucode;
> @@ -2488,7 +2488,7 @@ static int psp_np_fw_load(struct psp_context *psp)
>
>                 psp_print_fw_hdr(psp, ucode);
>
> -               ret = psp_execute_np_fw_load(psp, ucode);
> +               ret = psp_execute_non_psp_fw_load(psp, ucode);
>                 if (ret)
>                         return ret;
>
> @@ -2565,7 +2565,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
>         if (ret)
>                 goto failed;
>
> -       ret = psp_np_fw_load(psp);
> +       ret = psp_load_non_psp_fw(psp);
>         if (ret)
>                 goto failed;
>
> @@ -2765,7 +2765,7 @@ static int psp_resume(void *handle)
>         if (ret)
>                 goto failed;
>
> -       ret = psp_np_fw_load(psp);
> +       ret = psp_load_non_psp_fw(psp);
>         if (ret)
>                 goto failed;
>
> @@ -2863,7 +2863,7 @@ int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
>         ucode.mc_addr = cmd_gpu_addr;
>         ucode.ucode_size = cmd_size;
>
> -       return psp_execute_np_fw_load(&adev->psp, &ucode);
> +       return psp_execute_non_psp_fw_load(&adev->psp, &ucode);
>  }
>
>  int psp_ring_cmd_submit(struct psp_context *psp,
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
