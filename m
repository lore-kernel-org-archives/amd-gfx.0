Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F3E10ED664
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8EE510EE37;
	Fri, 27 Mar 2026 12:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n4jzjz9+";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4219110EE37
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 12:43:33 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-128eb45835cso118336c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 05:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774615412; cv=none;
 d=google.com; s=arc-20240605;
 b=ax5lMdH5yWfMaaQq923BFJT9oHJ85h1GYD/m6a5zhqpXKjixDpdVMp+gw5/8kRj3ww
 5B6zu8RyIM7owhgmRGMBGPBLl+hpj2ZshO4Qsj/ZL226C/OjYTwev+mfdn2nsntt8p/a
 BsVs8YsoGZeFWxinrPIKXNH0jt5NK2721M61xQDHN/dJcR59Txr3xwZ1bzqm6Rrgz8BS
 ZgCY7DZa7r4x3gMIjb9eQae3dLXivuqWPyVk6NIL2SU3ujgOji5PI8ZL3x7YIQVZRERc
 Rk2ODHzNh2EnHG01zd1SXVobOhXXkQX3+swBUcARDyIDJfgTd7UqZ1xAvuOzWQuMp6DH
 E/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gzOwetipCPpHGQyeHR8z+heZBtVz0pSl1aGCS8rwr1Y=;
 fh=sN9lHjfQgBY6fORl+AnBCHZUFbjxtDik1bv+B/xT3Eg=;
 b=PglGj9wvFcqI7stJSkIGu7g5NMg4wDtS0rE1jnLiRwmqPnJLorKfICsD/iMjov8LJb
 xnOZfTqZMlI59GiOMX2FRKYObKF1ctyXGaiaQshMDQxfxKcslSkOxNuyWoy2t9fCdwu6
 XafReVjHFo7LN9Tk6cAAP31mE4FBtcxr7ZhTiz1ksKHsAPPhQbRaAVxeDZP+AnHBMLqO
 JnkMjoMn3lz3+QoYHaCK5DhhucooiUAvVZAEwIYPktRRpYv+P4DE/2pbPaAMX/W8cGxj
 x2IwFqh/YOY2uyU+VvbVqYL6J17TsIZLcw8nHd0X9owlx1/WsGcQwa7R2JqsfpSf8jf6
 Lrfw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774615412; x=1775220212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzOwetipCPpHGQyeHR8z+heZBtVz0pSl1aGCS8rwr1Y=;
 b=n4jzjz9+LFCNgMjE7gkXWKk4Aus0JfLHi6JOlBD0K6Fpjusw3RPXGvNmJ1JvRyPfQk
 mpFWG2w0NfUbxOwPx0ygofCCEKPg0VZV15JfwLX2hrgdO7JVp0LMG+hZquTXwHm3crGz
 Om28mqYd4qGEuKOOYkgreaGfDhCMmvUe18Gs1aonIKS29aFluUmSiLx+HY33Cb7RhYl4
 nxre1srW8sIngpnTQqkaP+ZyE3DYlSmUCy7mknJ0qfW5sT8JI50SxRXdZJK1r0oej3/c
 OTvSJgAQdnEncSjd94HeI4u78L7rQB2qQNuM7Bg/ZUBeYFkfM5zr1pumXSZ+gJJdWDXo
 5bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774615412; x=1775220212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gzOwetipCPpHGQyeHR8z+heZBtVz0pSl1aGCS8rwr1Y=;
 b=fwQCYY/3w/AW5raxxgjPDstSj3zTJZTeYDMZ2qZVGuuvWtHENDK3aR1dRYZLz/3uac
 T4sltO+YQTYFmJeRO+D9Ipdd37jtbLFc9XnmB8Edet0wNHQ2yXmpNnh5o6dqH5F8L00e
 C2upqScOgQgcbrSri+Qvq+YkqgUlgI2sE+/AS5VqHx3RKzHff9w0R0Yy9mjDGv3D2Wbh
 +Qf2HMonD31U54OfHgv53ydQ98WPsJkTXSIam+b69N4sIvVzTCAQrgwGJLBeaQZZcnwk
 IfSvptmFZMUT4iJWaB8Uhd8wfgm0SRlRFop4izpNsRl5Y7uqkbtOrMLZYLJ5LnTtqkny
 AaLw==
X-Gm-Message-State: AOJu0YxP6J/RssqdZde8dqU1e6RPsUoXBsldrh3xdrLuLkUljaZ1cHlw
 rextHcPVl3H3Q18VL9hKC2LeOqaWMyvzsLtYK8hGZNTqERijiJAl+pjg23z1Bzv9aUOc4limnnU
 IZ1y4Rcv3iVDVggw4pHD3Cen32r2E1Bc0OA==
X-Gm-Gg: ATEYQzwAzTUNoDuHsbih8X3Agqk2eYDJb+cl8OOM5Afjs564o1rvbTnMseqy7+Cq+4A
 aGGP4qFO9u2cLyW5ZdOPKxxH3P/6YLtvf5P3VfHHvujzaXmt2vSt/AtC6k98H5a05fQjUCLWBpF
 Q1ksDW6mlzwWZ0LU+SaolzDF/4fynuRBx8gmYUxn/36V5OekUVxz4R4Gj0ybaGER6QrvdNEcibO
 3PxqrOrcTjU7MzLBUzoOSuq+VqUorTbix9Re22nn+b9tQ11It7D/6zlQjMEETH9bi0WoHB1kHoG
 pZtIdUCjczxk+URz1wC21m7ZpX9BEf0OTplV1bXTVtAWcLedluZXAfvgcsXoUzRKLZs70vQjT0a
 SMcNk
X-Received: by 2002:a05:7022:698c:b0:123:2d38:929b with SMTP id
 a92af1059eb24-12ab28f8b88mr633249c88.6.1774615412450; Fri, 27 Mar 2026
 05:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260327103944.1477094-1-lijo.lazar@amd.com>
In-Reply-To: <20260327103944.1477094-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 27 Mar 2026 08:43:21 -0400
X-Gm-Features: AQROBzDq5jCOdtqd83s1RybVrjjdbX7NbBLEXsEW9Iq3LlzCoyt6Be_tLrIIAZU
Message-ID: <CADnq5_M4G9gJ8f4WFFnxirY6idnKZDi1LyJR00A6Y2OYjaMAUQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix wait after reset sequence in S4
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

On Fri, Mar 27, 2026 at 6:40=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> For a mode-1 reset done at the end of S4 on PSPv11 dGPUs, only check if
> TOS is unloaded.
>
> Fixes: 32f73741d6ee ("drm/amdgpu: Wait for bootloader after PSPv11 reset"=
)
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4853
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 3 ++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index a44baa9ee78d..8ed637f92322 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2683,8 +2683,12 @@ static int amdgpu_pmops_freeze(struct device *dev)
>         if (r)
>                 return r;
>
> -       if (amdgpu_acpi_should_gpu_reset(adev))
> -               return amdgpu_asic_reset(adev);
> +       if (amdgpu_acpi_should_gpu_reset(adev)) {
> +               amdgpu_device_lock_reset_domain(adev->reset_domain);
> +               r =3D amdgpu_asic_reset(adev);
> +               amdgpu_device_unlock_reset_domain(adev->reset_domain);
> +               return r;
> +       }
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v11_0.c
> index 9aa988982304..fb7aaf5ae05c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -170,7 +170,8 @@ static int psp_v11_0_wait_for_bootloader(struct psp_c=
ontext *psp)
>         int retry_loop;
>
>         /* For a reset done at the end of S3, only wait for TOS to be unl=
oaded */
> -       if (adev->in_s3 && !(adev->flags & AMD_IS_APU) && amdgpu_in_reset=
(adev))
> +       if ((adev->in_s4 || adev->in_s3) && !(adev->flags & AMD_IS_APU) &=
&
> +           amdgpu_in_reset(adev))
>                 return psp_v11_wait_for_tos_unload(psp);
>
>         for (retry_loop =3D 0; retry_loop < 20; retry_loop++) {
> --
> 2.49.0
>
