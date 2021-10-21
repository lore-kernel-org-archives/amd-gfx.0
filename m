Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B669AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7296B60F6E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7296B60F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F15086E43C;
	Thu, 21 Oct 2021 13:05:55 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 661C36E43C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 13:05:55 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 34-20020a9d0325000000b00552cae0decbso391223otv.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A64HuZaafQpMi38CuipSAsJkEuSHxqwilhBEXYwdoyg=;
 b=q3IYRaPNVrX+0j9C74br1G/2FNZ8kuuS898RB7xO4kT+iyR8zGsscTKuk0ihilZayr
 AiaT2qa9niATzADTx8XmTKi4lzR6rM2iMjTWx7DLbrl03XQ/0pkJ3F1I9gt1Hyc4yZmF
 L5pBaq4GjlZlHqfucJCnKHCmA1yF0Lt7ZZJTFboWIt74AK0PAEr3DlCz0yh637ZJSz6r
 mZ/ehnk0XZ5EpRagIc5w21WF1ELY4BXHX2CeBBIIh83zgUnaC80lju2HtDBnKdFff93b
 JpA+K2+jlbYlcInfnBaEKh7NWv7PapiToO8WgIk0C85WyaXmI1wMHJ0c5qx/5VnsB/vM
 bJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A64HuZaafQpMi38CuipSAsJkEuSHxqwilhBEXYwdoyg=;
 b=cHT1XHNHSVoR3GHtpc/o3cYnnfkGwh29+lfXPGKXoooK98m1LryfyYtEmFlhTi4Pwb
 KWVdaBwYbo0AkKfwKTW0YyUqIKoT8mlIogBi5HZHIkZ5Q0UxankAkE+qB9SeIsZMPp8e
 fO37tr3pK8bYhshpOJNJ6gTyXjbK0pl7QcpwRe68zN9/Lci9+d0rQ1YeVI1FrcabhUUC
 bF+CzIcmUrgxW1SQOWPZc5CmFvfHFPgOLrr4FXSHiSyIkPWZ5ZAHQBokY6RDrTwTVBUc
 QK8m1h/2iCqYXUGjA2SzQLNKSOknCnIABxsi60A7lj3ob9DhU8W2yrePQOp9A7Fh6YQv
 uqRA==
X-Gm-Message-State: AOAM531dCsJxqLPHzYExtKT1/2BufYQA0+yGo2Ppy2Tu5EIMcJbe2QC1
 JVyDUQnMRBml2xZ6Lsgx0GIKVOm49wlIUP96bVA=
X-Google-Smtp-Source: ABdhPJzoA4mY/XWrTbTmo68mNCBYsiObCS4HHpCEjBE1uyAlAGpkMCI73mqzbpqecuRoVUoa0iLWWYq8Dbnk7AHcocE=
X-Received: by 2002:a9d:718e:: with SMTP id o14mr4738525otj.299.1634821554573; 
 Thu, 21 Oct 2021 06:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211021071512.20034-1-guchun.chen@amd.com>
In-Reply-To: <20211021071512.20034-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Oct 2021 09:05:43 -0400
Message-ID: <CADnq5_PJZDfNJOrFLsn5+FeWPm=eS4CE2d4FTdTSUKkDkDZg6g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
To: Guchun Chen <guchun.chen@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Christian Koenig <christian.koenig@amd.com>, xinhui pan <xinhui.pan@amd.com>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 21, 2021 at 3:15 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> VCN instance 1 is power gated permanently by SMU.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1743
>
> Fixes: f6b6d7d6bc2d("drm/amdgpu/vcn: remove manual instance setting")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Doesn't this patch effectively do the same thing?
https://patchwork.freedesktop.org/patch/460329/
Where else is num_vcn_inst used that it causes a problem?  Or is the
VCN harvesting not set correctly on some navy flounders?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index dbfd92984655..4848922667f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -103,6 +103,15 @@ static int vcn_v3_0_early_init(void *handle)
>                         adev->vcn.num_enc_rings = 0;
>                 else
>                         adev->vcn.num_enc_rings = 2;
> +
> +               /*
> +                * Fix ME.
> +                * VCN instance number is limited to 1 for below ASIC due to
> +                * VCN instnace 1 is permanently power gated.
> +                */
> +               if ((adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 0, 0)) &&
> +                       (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 2)))
> +                       adev->vcn.num_vcn_inst = 1;
>         }
>
>         vcn_v3_0_set_dec_ring_funcs(adev);
> --
> 2.17.1
>
