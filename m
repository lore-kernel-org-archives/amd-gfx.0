Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BC9F8D761
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 17:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C2910E906;
	Thu, 16 Apr 2026 17:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DAqkqEmW";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC5BF10E906
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 17:27:28 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1277863a912so798792c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 10:27:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776360448; cv=none;
 d=google.com; s=arc-20240605;
 b=iDDavMv2kG2lLxuLK1BMKrEmLmzC0mIkP75WJrpABi4r4zuiR7ulJ0gDJWEq8VBuIh
 vOyz9hh8CAep0kYa4LZDQ9kHLPC8njkcH/hx5AZU5KCEKF6lV5FEGtcc5Q1+KqIN2dw/
 RtC6UeqPN/0IFfqbIVmqcDtoB+vUpJcC2rzfGiGNj/ZoTMxb/c4imqKeSRyN4MZJG5+J
 uk5TIFDnGMiDux7zcKeA8xjNVW91IJe/2cv6e7jsxOw39xbxZJy5MHN+JreVqIMRtycM
 vNClQUqiA3fQFldMCg0i7mrGE73QS3iuhfM4+2gWd3ovO7qObEm7d2rS7U2EfTrq75E7
 klbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lJ33xfCcr7ujewLKKPQxYIyguzUGxVbSgkkm3EDmY7M=;
 fh=tfjiyQiw2s6YcdxXwhHMkIDXKm8aun+ea11dOqVouwo=;
 b=kUsj684fVTO2cdx2OV4FgPck2YeYWBYuy/pK6Pf8aqwys18aoSm9/c+dfZlfC4E2ak
 LjnmZ4LkPsyE93cp4G0EHo+OrrlWKS08d+WNnjkmy79Q2lUEJgEo+lWpYYDdbs56FZAQ
 A0O+m97XZww8WzEQ0TKoH/r9ro8zcyVoPpsqXqC0tCoP8LO5SO5GlIqMBw2OGKrnX5Vh
 I2sgQs4RRAhLKUSK4eaCLKT6LIOaDFzOT/csphSrCoM2ODA91wWo6NJU6rmB5fBQ/fBH
 yV6mUCD9IBJTmfB5o9Rkg1ebCQa3Eur7bdLkciUhRb+6OCElw0D31SJ5ursRf9PTmEI/
 zt5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776360448; x=1776965248; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJ33xfCcr7ujewLKKPQxYIyguzUGxVbSgkkm3EDmY7M=;
 b=DAqkqEmWqwEr5SBn/X+x85epFmhPL1IAubHcoHLEE+4aSQHoDXha5o18+T/VW3Poev
 KJZ93ZcNXybqh6NOC1khFCD2SybsE7DAr/KW5Fr9LOyzODl1U+ILnJZmiL3X2mwVKrpC
 2LlDr5sG4eS5QBTxN+XpZfLhLN1l1jC+1Mxo6L+a0TL4hxy5hsD22LHCYSzDCdMCav+c
 /0gDQQMTn7SVoh8gAaiD2ZnokPJVMHrQgzCG5lwhrtig7Dpb9VGugn/g59IHPUbovcOZ
 yYziNmwONXoLNJOO+SEEjX4HsIX93BpO5OQ7b5KQFv6yftLnTGsD+t+y3QhaBeHL/QOT
 jBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776360448; x=1776965248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJ33xfCcr7ujewLKKPQxYIyguzUGxVbSgkkm3EDmY7M=;
 b=izunCoB2tNJno5sOtuz+OkCn8bOCipppa07ym3sap4zJOREOfpqg4/Su97E9921cM7
 NSpH7cUeva/kj3tULXZORETrhQ+Q6evkNScONsj2cEuDQLxAgiqWwAZ/Gj3SurLCdwZi
 y8Rc/ZMEodL2YmtRfEu2mws3dR17oi/sc4S9gW10XcUR2mNLPa5J/WgiCwdFxWRgOmg/
 ye/yZnqN6FbgPs/9gTJOEp+hL54JEF7KFdV9EDDRj9d0dyIM+2DpcFbRbh3aODODhkx1
 iodinAG2DNzBXPl9u4r9/unqb+gCrPDeTF3+d0CrDNhDzH5Q8hpiT1ysCWPAM/cF/d+v
 fEAQ==
X-Gm-Message-State: AOJu0YwBKirdBVwfWcQquZa+axTrU1hxr069br5TKQecsRv+M6x/8acV
 2O9oO6XFMmpZhg42pUTpn8HAnUuNMOAKU5d/tDKfet3y5RBpYkhfQb6gtZokObPnnDaGNomu+DM
 FkOYt82Z/LG2dnQbrsMRY2jK001KS79U=
X-Gm-Gg: AeBDietMpHm2lDKo+XT9i6EaJ56mL/bs/XiqBhjesrDBIi3JkRuSUzKxkMjmsYDe3wj
 UVU81ELtzuqS3nJ0lic3KL+e4nzSgftLuAFXFuBvqGBblHaVeVce6lzpDiMX9ZATdtG4OA6cAOO
 omKuWQCA27JV8BE3Y2QCpypCgPOsIL1sB1aLTyo/7AjRlEZJC6oDNfMsdac8wq+hoNO1vdqhpsq
 mH2Nd0n+7yilR/j/8Rn1dVdX3GohpTCGW3jyHvuq2WYzzDjUB8IqUc86/Awc/4CazPGhxQPGNdj
 dqu+oKOZG56wYw4/2j0jZvV8w+8mUQYrfocr+OcOx4FhiQrnrpiYwugvnhf5rh5sBI8SUNUlaPh
 er5t9
X-Received: by 2002:a05:7022:211:b0:127:def:dd72 with SMTP id
 a92af1059eb24-12c727f6438mr11974c88.2.1776360447923; Thu, 16 Apr 2026
 10:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260416165056.15459-1-shaoyun.liu@amd.com>
In-Reply-To: <20260416165056.15459-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Apr 2026 13:27:16 -0400
X-Gm-Features: AQROBzC6Te2Fhue5VYheW5oprb3TBt9Avn5dLxdeSQNiU86ciAoTxjgtRhJSqj0
Message-ID: <CADnq5_OThuww_7RA0xyQNkaiGBzzt1q2tRsCBtH_CKn48aD7DA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu/include : update mes api header v11/v12
To: Shaoyun Liu <shaoyun.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Apr 16, 2026 at 12:59=E2=80=AFPM Shaoyun Liu <shaoyun.liu@amd.com> =
wrote:
>
> Update the parameter in SET_HW_RESOURCES API
> 1. Align with the setting of enable_lr_compute_wa
> 2. Add enable_compute_pipe_reset to enable pipe reset when compute queue =
reset failes
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>

Would be good to note which MES firmware versions support this.  With
that noted,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/include/mes_v11_api_def.h | 5 +++--
>  drivers/gpu/drm/amd/include/mes_v12_api_def.h | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v11_api_def.h
> index f9629d42ada2..6644fabeb0b7 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -238,8 +238,9 @@ union MESAPI_SET_HW_RESOURCES {
>                                 uint32_t enable_mes_sch_stb_log : 1;
>                                 uint32_t limit_single_process : 1;
>                                 uint32_t is_strix_tmz_wa_enabled  :1;
> -                               uint32_t enable_lr_compute_wa : 1;
> -                               uint32_t reserved : 12;
> +                               uint32_t enable_lr_compute_wa : 2;
> +                               uint32_t enable_compute_pipe_reset : 1;
> +                               uint32_t reserved : 10;
>                         };
>                         uint32_t        uint32_t_all;
>                 };
> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v12_api_def.h
> index e541a43714a1..08466d59695c 100644
> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> @@ -294,8 +294,9 @@ union MESAPI_SET_HW_RESOURCES {
>                                 uint32_t limit_single_process : 1;
>                                 uint32_t unmapped_doorbell_handling: 2;
>                                 uint32_t enable_mes_fence_int: 1;
> -                               uint32_t enable_lr_compute_wa : 1;
> -                               uint32_t reserved : 9;
> +                               uint32_t enable_lr_compute_wa : 2;
> +                               uint32_t enable_compute_pipe_reset : 1;
> +                               uint32_t reserved : 8;
>                         };
>                         uint32_t uint32_all;
>                 };
> --
> 2.34.1
>
