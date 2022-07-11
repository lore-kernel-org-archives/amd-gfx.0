Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7902DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 15:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80D512BE7A;
	Mon, 11 Jul 2022 15:29:20 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB5512BB79
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 15:29:19 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id k30so6708616edk.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fjhF9JZ7AvcggY+gdUWjrZe2eoQP+ZJyarfQG/Lxv94=;
 b=cEAsIV9Ot2GnyLgnEqdqkFBl2KxkVZZNTc7qmmW/qduUg3mL/TgJOL4f0JIwgS+aiC
 coH3AamEb+YTl863p6aUA0b7UaDthg5LVPhqT9nIhqSKOYs5TskPD8bK5LoZILLV7YZv
 MsRgsJtMSQVs0I064zq5C0tEU14TDZIJ+vr5vMfa9Lo8nBjb6DitJA0mbxwDGqhpcMzk
 S7XH8S/LA+ag6qa96fmBJz35I/GdVX/W4uZBsUZbwloKXfw0vQPw23y/PHTpF5+apxXp
 k4STRWuaY1TeSj/OAyeDoByLAH6gs02nJvXHQ/df1U4lhYqY8XNSrt6QmjjVJKGw/Ryo
 xfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fjhF9JZ7AvcggY+gdUWjrZe2eoQP+ZJyarfQG/Lxv94=;
 b=7k1triKh9+EGi40nkiuoXM61dcfQsQ3RpXIpB+DQ5qgZ8Kw8O+73+Mcvwi4F+mkV9e
 r2RaZgVNl3Z+iTGHs/Vg8OdSCSTYXwDFkiH03QRBWKVFRDyVmwGCKTLxOn8hDDYkI4Pr
 A14AERHyVy5pIEK5dzxue0KFLHeg6JqULvoQoKZ+yVaqGbqcanflg1crd/D8fi0HZoBs
 vahGivHALcpWY3vMw0J4P+E9N9E6NAh1054Tmj363bWbZZOMNgPw7N0u3ywQ/eH2sznE
 fRcwBnq62fqbpmGSxe7UfuAZNRSPYoU8syqX8FeqgChmP8ZSb3J8usUBHNty4qNiwCNu
 z5Eg==
X-Gm-Message-State: AJIora8qh1ipjQuhlWiU3Hf54syNtyJ4rnXCOUXUxqMTFiS2Yw8atCDB
 Iviza1sX7/8hVZCQ/klW5v2AFLFGG0wsJ2b4Xp43xOam
X-Google-Smtp-Source: AGRyM1sv3PIyxycSYe6bkH24xFFlTNJhKraI+6xvJ9Vmkrc1CdUIvockZ87k1m2ipUy9uQrIUE4UL3ZOAMkrhZLhSqQ=
X-Received: by 2002:a05:6402:274c:b0:43a:9204:95fb with SMTP id
 z12-20020a056402274c00b0043a920495fbmr25857369edd.259.1657553358446; Mon, 11
 Jul 2022 08:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220711135742.11739-1-guchun.chen@amd.com>
In-Reply-To: <20220711135742.11739-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Jul 2022 11:29:06 -0400
Message-ID: <CADnq5_MvQUbixcowtu2KaD+giO4tFue48vCx=37SG4Q27XsOqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case
To: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 11, 2022 at 9:58 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> SMU is always alive, so it's fine to skip SMU FW reloading
> when runpm resumed from BACO, this can avoid some race issues
> when resuming SMU FW.
>
> Suggested-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index e9411c28d88b..9f17235bab83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2348,6 +2348,12 @@ static int psp_load_smu_fw(struct psp_context *psp)
>                         &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
>         struct amdgpu_ras *ras = psp->ras_context.ras;
>
> +       /* Skip SMU FW reloading in case of using BACO for runpm,
> +        * as SMU is always alive.
> +        */
> +       if (adev->in_runpm && amdgpu_asic_supports_baco(adev))
> +               return 0;

What is an asic supports both BACO and BOCO?  I think we need to
differentiate here.

Alex

> +
>         if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> --
> 2.17.1
>
