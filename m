Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF47A10A88FC
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 18:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E08A10EAFB;
	Thu, 26 Mar 2026 18:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VTSSI0/A";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7794D10E066
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 17:57:57 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12714f01940so98817c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 10:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774547877; cv=none;
 d=google.com; s=arc-20240605;
 b=gy+kGclhJQFNWtT57r2l1q7JzNpd24bFaINiPWVexDtwx1eehRPbtNVhILU+ts/uFp
 UPIIoqpEZ3ZGtSMry3rQZMpsb5q/fZecxbPL99Xh/FZQdsA8PFxaZiEHBujq8QugXufo
 4SOb5+2WFWEaSQmDOCbqsat78lGQ9HHts25TsO7zlnJkNgO47ctvKJbJe8jS4/eSEjk6
 Oq4fLHzfUxtcp/na/zeeM7SuxxooUlnz9VzbGSUZLDTB4MskVkeXJaXozU1msswK5DKf
 WUGGIaCLdZ0fZWBaR5O9qCtEUmyljQss3IsTIh0vDodfh/3USa9HwKKgaeRlemIC0iDk
 LVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ztFQ6h83l0AZ98mqhm/2uwSl1/3EyN6LDCHzTVk5oSI=;
 fh=TjSDHDexhxAlozvahAqSjH/1kZYNEUCZM+OUwnm2QTM=;
 b=VKDu70Sr11Owag8d16K0vKAjMWuLm8FXaWsLt5nTKuHVHYWZEZ7HZDnpKexV4GFJ7m
 SxfgnlRvTtkxi1WLm5Dk6kwQWyfA5M+BZ2UYCNp5UXGzjONa2/Dyp0Zk/2bUaB7uWWHA
 8uBNtoGGUXnJkHJaf8WVvXw2KRbtFWhJQzmuJhLxSXx2z5AbeKZdN/UnP89MnSbadMJm
 50r4N/F0SQbixqpni+1HkEg9Eq+veKdbAPo1tTm0HGi+tj9UhnLxXH0izLod6Do4OHDA
 rVmkndgBtolldOfA2OgagwIvxaGgOmZ8X6EKuQqywmx0TxFklNbCg8V1sE7HD09dw3ZU
 9t3w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774547877; x=1775152677; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztFQ6h83l0AZ98mqhm/2uwSl1/3EyN6LDCHzTVk5oSI=;
 b=VTSSI0/AMarrVtcxLKCFaJI5MWB5dSSHUaNEC8c9LBujRuxlmjfL28wjn0QIrXrpzF
 mQE4hYr8MLCoIXJ3Vak9XiMnE6RdBqb824BWdZjq+dUpbCVE7c9WGtSLJT8tIc2XbRrd
 si1qwGslRgsTp/+mGmuRC7C7tLugHeL310UaPBGDK4LM16Bgcz1UB/zIaVK9w3cv5oe9
 idCmM/ZwdvudTNCRP80zHz3vZXjVVwtRlhXbxSooIXpe6MgpMCcda+n2Ad/zOEx9ZRGK
 Ww60owR9GaH6P1AsLsQ6QvG7S61sZJtpmk77tBIIUeTdH5H/zhrEgerRc7RDhvU1B61B
 j/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774547877; x=1775152677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ztFQ6h83l0AZ98mqhm/2uwSl1/3EyN6LDCHzTVk5oSI=;
 b=KrYRcR78PiPDAWNwZWY+F1ntZveT2DEJbPwUr0OKTidPPWyIhy6AxWvg5+GHPfwPYi
 K+VxFLn4/s8AMNyJ98dUOGifbWwNTieaNcD6ThnxLwW19QTsQSuyGyUgpBv0sLJMe7TB
 AraHuAXcwxmooKNrbUoho2pqAPbAp8tIq/eTQU5AxyWhHkcKgTyAbZ7za4144MD/lBUa
 P7bmYRv57/AJ/9NpZ4+n+xINmz2gtsimKbXoFuT+IadRbze8JKE8x+oFfqmgVPHPY0xd
 3iC3DNN3MDFlRIPDZXFraiNHbvdg7DXpaMJNCR3h9PXp71R3NWCFZUIvKR2Jmxae7RPd
 SyHQ==
X-Gm-Message-State: AOJu0YwnTfJI+dWg4fQYgU2657LfapKvC3fklpoGfgEoyEPKhxFEO2vg
 7PRpBdcFF8hKK7ya0YqVtL1idqUL0H+mwyQO1fpcHuWoHuwadsZlUmhq/WMIcivwdTEUczd7vV/
 SWNg+jqBqeNGZMfYS0Kdi9uP9x2yWNmg=
X-Gm-Gg: ATEYQzw9eeZHmocoC/1Ee9xh63VBWNS2zjiDeWWT+kNk1Dftkg7qcNx4ereE9Oa4uav
 v2318YEzRYNEiIzfnXf51DvvbP6Mf1ryk48xTou5uRoEIpYjxTq8CGzkTzj1l8IhL1vSO7ugYZO
 ElyT0tucwjCOaxrGNYy+76J6iW1u3xOTXrl4AJP1YHaJefAZ7KTKi5MhSVRAmwSJpq8E0FMZeNl
 418sOErlvZ0/ECFZ80Fu8wHIfe0gBPxr5u0UxYrTn9w3IhWc+O3zFLb+qK8WzdAnAN8e0O9Lmyo
 T/nt+DokZipzJ/DEnC1415gioLNiBWj/0nDoGkJnR78lqoUYRz7fw4oikyCQgNpZZjkWtp3DTad
 hlqFY
X-Received: by 2002:a05:7022:4190:b0:119:e56b:c3f5 with SMTP id
 a92af1059eb24-12a96ed96f1mr2145003c88.5.1774547876667; Thu, 26 Mar 2026
 10:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
 <20260324175653.1325754-6-Amber.Lin@amd.com>
In-Reply-To: <20260324175653.1325754-6-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Mar 2026 13:57:43 -0400
X-Gm-Features: AQROBzCo7-EWz4Ey8qlElV_JKhqacgl7i1wXUJJ6K3SdJKpkXX4ZzMcUYEgeO18
Message-ID: <CADnq5_OA06j6ZRY4RkT4KGLp_XrsdrdwdTxzJTfUwdaekVRJQg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] drm/amdgpu: Update mes 12.1's suspend/resume
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com
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

On Tue, Mar 24, 2026 at 1:57=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> Update mes_v12_1_suspend and mes_v12_1_resume to line up with mes_v12_0.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_1.c
> index 70d80c2aed52..4b279259b9d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -1888,24 +1888,12 @@ static int mes_v12_1_hw_fini(struct amdgpu_ip_blo=
ck *ip_block)
>
>  static int mes_v12_1_suspend(struct amdgpu_ip_block *ip_block)
>  {
> -       int r;
> -
> -       r =3D amdgpu_mes_suspend(ip_block->adev);
> -       if (r)
> -               return r;
> -
>         return mes_v12_1_hw_fini(ip_block);
>  }
>
>  static int mes_v12_1_resume(struct amdgpu_ip_block *ip_block)
>  {
> -       int r;
> -
> -       r =3D mes_v12_1_hw_init(ip_block);
> -       if (r)
> -               return r;
> -
> -       return amdgpu_mes_resume(ip_block->adev);
> +       return mes_v12_1_hw_init(ip_block);
>  }
>
>  static int mes_v12_1_early_init(struct amdgpu_ip_block *ip_block)
> --
> 2.43.0
>
