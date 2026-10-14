Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F8CCC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 16:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 130C610FE7C;
	Wed, 14 Oct 2026 16:47:43 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FB310FF2C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 16:47:37 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-986e326c33cso86960241.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 09:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996456; cv=none;
 d=google.com; s=arc-20260327;
 b=EcH6c6/5qhxnwfQyClmGwSCqvQfXoWNW9wJ9pwYkrJzlps2iwMCsipkSy3pv878w2m
 9/iKkG+1UsR8MkiKtriJzpeCQQqJ7A1Zmw6VchXhXEbMrHnzmOjHVbYN4Oq9ntYVcW7I
 wLpeAlcS0TN+F+q89Fjmx2hCACZItxdCss80tM7IkHar1Z/kiSsVrJSHCFNcfRJxkBaz
 h+Qt3n4u4ms50ztvp1qcN4xslBLQc75Qtr2i2jCynXt9BNZw4MMm7cuiUllu2wJhZEPW
 YsjTx7W3kGGOA6FZJJmN2ocLHKbyZMAYXML4gM+lhqvLYZqvpwXlxVLbv5oNPEMt6vE+
 XPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aY4wa9XVG4bLBUrDNf/alpBmZD4Uo9u08+8/BssSkZ0=;
 fh=hIaibQ3hx8uhJRQ2vsK7kLLxUMsMJxZkypG6rSRSLHM=;
 b=n/0e55ZWsZEM7k7VMsAL76hoh/CEnLr25BgjisR2SszV7rx66uAlTTstQDgQE2vS6G
 vAO8GhacUj7pChjVe0MeeosmXP0LNLlUGV/OOaMG6Dy+jRmAeVryGMDMFFKqAfGwBdQ5
 L24cRyZFqc5unsXbM7KWcVkdlyG0IPIRB5vEmdzee/SBQtox1QjAk5SEPbHa2W986fl8
 ELXxzxps6NJcSznvq6UjzroSrIXfXlU3GI/EKbfPe4WnUXK+5TblSYgY/2NlKn/R05NI
 ezw4UxpB1z2Xwui4IRGqFhTy1+QkPL7CHTVtoFzx1f3ta2MYUcv1IWBdNaZ6gNV+MbL1
 34OA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791996456; x=1792601256; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aY4wa9XVG4bLBUrDNf/alpBmZD4Uo9u08+8/BssSkZ0=;
 b=W3b0BlJZOD8HiXgUbLz+iyk8sjppk90//guEsFE4Z5xj6jCsXPoIb37c9Yy01ULo1L
 XaRM+G5DtlwAxs0z60sgen+loGoufdF3lJOmJ8LR6AnC4dYvyAfxMX/tPV0Edq6BEmoq
 6pkFFcify2aoy2Bf1i6ELlXXNPw6E4qVS/swe7GDzcB2jniZlk/wFMZrSqFKPqIpcJZC
 5ac+Lm7YLgH/KJ/4VknA9zaJBCB9IyvDQt11ziAd4mGf8DpGSGEkeEoLPjiPPlODG1rd
 7lhUZ7AkVv6qiFOUdxzPsRzTm7+d5Ttk+W12BWmZQpcsextD6sL/5jXes9WodxZYKw9r
 QM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996456; x=1792601256;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aY4wa9XVG4bLBUrDNf/alpBmZD4Uo9u08+8/BssSkZ0=;
 b=XWSVvdUjhy37BZhdM9UlgS+NabbGkJsKZfm8KcDv+quQSo8sT9xHAO1lWvoxhm3Dma
 9TdRjdBDduLS+AD+9Lxn4lYNSYIS86TNgFARg2ocaFVyQ/BRDKNBmQInQTTX4SlGfvp8
 +pzk0sTwWVKvynwXCHL2L/kWZmsElUsLJP16V/20EFyArpCPjAzynATyP1BA/rFrWz6n
 BuycuwawtnhPfGdBdmB1AMI2En72TXHewlcNKTZ8B/+yCTDhCy+lis2Uq4soGIqsyY+F
 K9/DKfAoLjAnxTiR5WLhnehmEW5tuTCs2l2CAfIbVIWhFuCVfDu5oxu4BIonn8KpKgGh
 TXkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwmU88pcXy7Yuq9y9XqDoDnLkFpgx9oCPE/o5mZtE6iBs1XDDKM1MYkXuYC+ohzxNEtUBSD80E@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKbIPoLzKIp5fGdCNTx9jKFBzKyfPDsbtVOTc01hDheGHh17UZx
 SdLYO2CWuAJB4oCFLFnSzIlhReHgOPfrPARrB8UNzi0Yt1S/iutelZ+1/2mN1trzbI86VUgDB39
 uItudPGpBi2EfVqwoeRoBm029f/4z0Iw=
X-Gm-Gg: AYBFou2YA8h3crKcbHY2A9G0bMfe/T00vp8o0+R1TkJaBfzgvCeWmjrxmg2BvZWTtdc
 WtoJQD2GHFeJMBb6MXFJcsGFmD6skpGx9xytsOq2oHJayBBn3gA7JvBwfBrvqtblV4Gxjd8a2o9
 wMuf/AxdJFAyoYGa8cpv1F2CWZTOHm7tydQILhQ2vW2QufH7kqW461XdOYRaks+QE7gXZByI1Va
 irb+oO+dQ9gplAjgKZwLgrJ1Lcq51gf7DccJkWcIIooA6jOBabtNcF82Ar234knqq+pX+1eLSPm
 WEXU8y0dAqiDjOQdZFhpCBwKZ7Cinxq/FrpgO3FGkxrNCzt/TXGm8oZuxiKOPuheEneRF1mLzZK
 /kaSx4IQH/Bz0NUO8+p+3rme/EDDX1LmFGkjxP9eHlYCuM2m8DW6s
X-Received: by 2002:a05:6102:a4d:b0:7c8:3b8c:82ae with SMTP id
 ada2fe7eead31-7cb372321bdmr4394184137.2.1791996455921; Wed, 14 Oct 2026
 09:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20261014002858.172853-1-williandossantosdeoliveira287@gmail.com>
In-Reply-To: <20261014002858.172853-1-williandossantosdeoliveira287@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2026 12:47:23 -0400
X-Gm-Features: AclHuK-US1t3rz7_G3sKamqA-AukmKWflQ6FjzYQPCWKb7Z5Q5Xcc6YpUewNkao
Message-ID: <CADnq5_O0gGsDD96KkCTc71rPh1QJsBnWPw_XVvuwRoRQ9Wbhjg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx8: remove redundant RLC cleanup
To: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Tue, Oct 13, 2026 at 8:46=E2=80=AFPM Willian Oliveira
<williandossantosdeoliveira287@gmail.com> wrote:
>
> gfx_v8_0_sw_fini() already releases the RLC objects used by gfx8
> (clear_state_obj and cp_table_obj). The generic
> amdgpu_gfx_rlc_fini() also frees save_restore_obj, which is not used
> by gfx8.
>
> Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 7f91186ef1d1..088428e41f44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -2059,7 +2059,6 @@ static int gfx_v8_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         amdgpu_gfx_kiq_fini(adev, 0);
>
>         gfx_v8_0_mec_fini(adev);
> -       amdgpu_gfx_rlc_fini(adev);

I'd suggest dropping the explicit free calls and just use
amdgpu_gfx_rlc_fini() for symmetry with other gfx IPs and the rlc init
calls.

Alex

>         amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
>                                 &adev->gfx.rlc.clear_state_gpu_addr,
>                                 (void **)&adev->gfx.rlc.cs_ptr);
> --
> 2.47.3
>
