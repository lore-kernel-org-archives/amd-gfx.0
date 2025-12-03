Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B740AD12D55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 12:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 589B910E788;
	Wed,  3 Dec 2025 12:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZNLWxb7u";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6802310E788
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 12:19:56 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso31897825e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Dec 2025 04:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764764395; x=1765369195; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlxVp9dqRcA2jpMhVYIan4EgPyzzqXl7hx+uY1LH8Rg=;
 b=ZNLWxb7ukOZQzzWxJwG2kkyN6vkfmdQFnOO3LA9L9U0XUBHwpOYB93+faeTluhN2PE
 VpwLYRb33iQEi5t+IOqKKGloHbK3PehDFnW+zrZOnyDI/uomPdY7Jv8M82ac2MXGEzXF
 zpdFs9NpBcUv4Z0uCWz+VeL9tLVfnp92YYK1N9p+5Qi01n9Yz08b9DuloNF+xTUgY1xU
 YRGHt5p7nxE24TEbmf0QwVM4fitzLJR8JuhkdGLnu2V0medz3YK2P3VIgNV47/QlL1cj
 Rc5VgzNhbSAlQKTIWZoOjElgVdYKPtt0kJoTew3c5OGtXsg9UJu/hR8N6tq8ABxSftmZ
 BfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764764395; x=1765369195;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QlxVp9dqRcA2jpMhVYIan4EgPyzzqXl7hx+uY1LH8Rg=;
 b=IbtCes6KCkXYiMyuFBUjBPelFEPj9hfr5+JG7Rwrx3ruSnjgkEQQLisq/fAhlzMbE4
 9RVP3HnJG5Rs6XYTQ52MJuS1zSUiyxRwS1clWszCQiUsX1W6p6o1DqbOlGlUNRc9fBII
 sovF+Pxg2McTyjYnvyJHrLx/0YBiGctf0Uv3WNso3n41Vcw9tseaCaN328rBJMAcZbec
 Twh/PcqNM13dbdxJiqaKEC98CnzN3/5jqTAkIqGgfT6q6kj+ozdNeyeW6K+hfptu3cqN
 qi4QjQaQ4jyLt3Cfz+TCOi4O2xEN4gLVCJmZKDpAfG4Ifz1048+sTpHre9dcZoCHAI7e
 73jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJFqvnTbFNjsyf7t08RCE4FTDGhL41sqQWd2QoM85V2V8DR6GIYNlw5wYJfXHS49M/0p/IJP8J@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzeo9kWXlR6rg9URHAwCi/AZycFYO91+NuD/HWQn0uboXfk5fG+
 OnlP0lysEKMez3wgr2D9yYiWSD1VS5vOsMS5R4yYIgpKET3UCykg4dGm
X-Gm-Gg: ASbGncv9oF8eF73BclmQcL5unZJd8OHFhPviKEL9HYPtFS9JAfZRqqfvngBpujKv1S/
 sq8zDDI1TjxdLWmGQNyj+nfNHJdmETrvcmjl/VDMTj7Bhqs9uZf57MTWcGjeYP1owfCE+MTC51h
 XE/wyKwu1e79oSH0TK9HU1QfS7uXbJ6g5o2T3srFDrheLfd7wmr4ab9eHFHw6hlCbcg6jsWEHN+
 nkQFv5PmKOdyh492+dse1tLU3d5VeK2cZ8wz67XwSX5oqXng3/0+tEm8pb71pFo9kMhTWkvNGDJ
 wvPJlzCxLBmeXwvvG0SEXX9y8QOywXN6s7q24DmSaFrOrxwAQswiYbAl8KBx/Re0xvrU1mV9eQV
 HScdL1Kd39rd4QqnQArHt7/kOji8a77wVwwMoeXq3kEq8/CI5INxFT8sG8fjfPX1+e89JQB8Ti0
 NWIDb+3pXeu9TMmb1gA2CgyUSqaQkMyMGYbJEKBcBzGWGgoT7o1lOoN0MJVsFEYV8fjP4OQMWkn
 Q8RWIpgSgrNYrVD3SjhEFnUMtp7JsGhyfy4d9yIZxXcJbwkR1vszPI=
X-Google-Smtp-Source: AGHT+IH9zDPgsbAGP0c1bcn82pXCOPpLhlhVWoBWouhn7VEm5z2XpzNE5GQxJ+HMizGf1hssfyKWcQ==
X-Received: by 2002:a05:600c:1d0d:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-4792af49480mr18689815e9.34.1764764394700; 
 Wed, 03 Dec 2025 04:19:54 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24e0:9500:1ded:b2c8:b651:4266?
 (20014C4E24E095001DEDB2C8B6514266.dsl.pool.telekom.hu.
 [2001:4c4e:24e0:9500:1ded:b2c8:b651:4266])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a7a31ecsm44017205e9.7.2025.12.03.04.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 04:19:54 -0800 (PST)
Message-ID: <d8731e63e9a412f8b6100b140db8fda619bd79db.camel@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't attach the tlb fence for SI
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Date: Wed, 03 Dec 2025 13:19:53 +0100
In-Reply-To: <20251202192932.2038495-1-alexander.deucher@amd.com>
References: <20251202192932.2038495-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Tue, 2025-12-02 at 14:29 -0500, Alex Deucher wrote:
> SI hardware doesn't support pasids, user mode queues, or
> KIQ/MES so there is no need for this.=C2=A0 Doing so results in
> a segfault as these callbacks are non-existent for SI.
>=20
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4744
> Fixes: f3854e04b708 ("drm/amdgpu: attach tlb fence to the PTs
> update")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Thank you Alex!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 6a2ea200d90c8..0eccb31793ca7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1069,7 +1069,9 @@ amdgpu_vm_tlb_flush(struct
> amdgpu_vm_update_params *params,
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Prepare a TLB flush fence to be attached to PTs */
> -	if (!params->unlocked) {
> +	if (!params->unlocked &&
> +	=C2=A0=C2=A0=C2=A0 /* SI doesn't support pasid or KIQ/MES */
> +	=C2=A0=C2=A0=C2=A0 params->adev->family > AMDGPU_FAMILY_SI) {
> =C2=A0		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
> =C2=A0
> =C2=A0		/* Makes sure no PD/PT is freed before the flush */
