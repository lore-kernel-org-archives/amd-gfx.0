Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BDBD73E83
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 20:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF33110E2AB;
	Thu, 29 Jan 2026 20:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WD9kdJuC";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C551810E26A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 20:13:08 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1233608c7e9so154263c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 12:13:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769717588; cv=none;
 d=google.com; s=arc-20240605;
 b=lFyqEz1AMjHgJq/+CJ4oC0cSUDTLXTyA55iAYQoiUdLVnt78Ehah+8479fiJmT/fVs
 DY2FB15fwXoOgPXdaSEa1BhhxWiyX5uV2lBqNlm9USzgbEPJJHnsMAO2mc6hRP31GcNA
 D3fdXfljcuVvSICNpB0QV0ofioe7OKnUC5/NCU6xItQOsTG3PhR0qiS2Iu97XYEw8dkb
 NAXYkU4+XxJaGV7Ei/x//vVI7q1jrrPbbC1LukZpSYUweKLaw22dGkFPSjtjJS0pqeTu
 S9onwNyXSTVnCHp7yMgG1+nNtRHkH8TbB8x0qc7Fq0R0bk5XozAi/2nfPIZzBx9b4Num
 gUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tApJ29XxsWnlOHSD6HhJHddKuaUFTtAnSbJizPmuQhQ=;
 fh=SiFI6UoF3gg+Gd0sYO6Q8xMu0vCNIPkWrHfYQ/YN4ZQ=;
 b=HsnkOn7YSfXpJjcIv4/mkz9ocigVsqMeImpGfHIFT2HzZWPVI4xloc6su8fBMM5jRn
 qbsEAVIcuXpg0XLVy8VTvJBmcNuOzdKiCpeyulDiU0xK6uSefc8Yg4WjMwv5equb8QsE
 rwqsPu3yGJHOwsnL0OdjbH6Mrw6qbjevWVOuSEppSoFjcnpMAkXzwkHlv5y6IAvGEt02
 hIPnO6046jYmdEjEdPN5l3x4JF28uBcynz3w4BTo9lbvGRpobNcoadblN2WdzccnL1yT
 YSHeStw6wYgA2/CZpPiwgnio73up6tJ1czDXZJmeTh5s+gqV4FPoKIi0yRiac5Z7S++M
 KgLA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769717588; x=1770322388; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tApJ29XxsWnlOHSD6HhJHddKuaUFTtAnSbJizPmuQhQ=;
 b=WD9kdJuCeOGti8MMu0/9AYWo9DXzjVo9tLTaBUz4YR/lq1khpZTCiWbuMjDhVu2EaU
 5y99BCIQJB93jIvJGDiELDWuoTKNvYgXGS/YxpkBUf37IKq3SZR20fJorhqewe/c9rhs
 OIHYMTgv/2+LMI3y1CoyDpEW6QDuVVAIHSbrlSCXVUrebfCrpDQwg04FIcOhly+/WpM3
 juK/+MVJduaejF+cAA7KnDRlMNwW3dBQ8OUpif+6Vt+Nj8lbPwp6+/Z2TkXheE8Hjz/0
 E+/8WCdhfkbx+TsDHXsBtQcHQC79WWfvTdy5qkmpWHYyggavelzuU5TGa+ktcXX0DvHF
 5CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769717588; x=1770322388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tApJ29XxsWnlOHSD6HhJHddKuaUFTtAnSbJizPmuQhQ=;
 b=hI8/FysVaPdXkhKki0EBPgByY5OLKOQKUi9XLEm12Fy7fZSmF5HfvHrLP+4UXSxOSH
 AatCzFHf06XywmmViITY5emGYQG+gTGp1ZhXH0j01sxn6+b+jUgdAAI31rSOK/9hnuPN
 XhabbPA9HgDm05lhldgaJ11lhCDR36GBR1Yemjnz2iJYO5pvuoJdpWG2mRl71908N/Ld
 2KYwiVzGG9TLImxD2bx5Vc/XA/brLBvucUo8OaWTlnBp1SElhdh/TyCUBz4k/GZPhByc
 E7RDrnnhz20yA9d7C03bIL+XfIEsETtTyzmjqML0ZUF+B6eTdkxOxv6q3CBLJoD9weUm
 7R0Q==
X-Gm-Message-State: AOJu0YyAvwkhZWy04/NjZblg+fCoRDNwaXvSjLAQPO6zlgWVcJUUnoq9
 u0e0RAPsHEA7saeqa1+tvCgbUq7kqr5BR/gn9Og7e2MPOpwsSIYOlgIlet7KDJYvfOifvIVLAKw
 qNO1HDQ5jzJ6EpOMemHFr8JAnZKdyXHM=
X-Gm-Gg: AZuq6aKMxjli/UI5wP4ZoiMhodpgkeneY5AA1GshH72E9nYpHMHrzdsUZnSqe8mlLjL
 WIyb1IcVAbK1q1METvmJPobfx1maOJ4LH7FBgjWj32v+bkC8GzMIb7pWDOCYxN5aFWvabGo/RtR
 zszOLtLmcuaFtC7G84oJD93eIWKLa9kmXACMJecCIE1Mrz6BQ3ZMVPOaGHrTBPJrZHMGF7YSLch
 teQc8c4pSCpFoJbOR3A9egKJ6Hbss3ig4wsP0sWcs9KU74N3TBr2NLMzn4mr9bcgODLSEMr8uEN
 1RMqlW0=
X-Received: by 2002:a05:7022:911:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-125c0ff4b25mr202056c88.6.1769717587886; Thu, 29 Jan 2026
 12:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20260129194722.2331593-1-mario.limonciello@amd.com>
In-Reply-To: <20260129194722.2331593-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Jan 2026 15:12:56 -0500
X-Gm-Features: AZwV_QjaJqNDLRMnON8ZouHRjsB89qNzEouRpDW5_fU0vApj83Xlf35VEIaWXZ4
Message-ID: <CADnq5_MKvLhziwueZQ2HU7RUD8tr5NZH_a4TmDnYQMr+_UcCgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Set minimum version for set_hw_resource_1 on
 gfx11 to 0x52
To: Mario Limonciello <mario.limonciello@amd.com>,
 Shaoyun Liu <Shaoyun.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, danijel@nausys.com
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

On Thu, Jan 29, 2026 at 2:57=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit f81cd793119e7 ("drm/amd/amdgpu: Fix MES init sequence") caused
> a dependency on new enough MES firmware to use amdgpu.  This was fixed
> on most gfx11 and gfx12 hardware with commit 0180e0a5dd5c6
> ("drm/amdgpu/mes: add compatibility checks for set_hw_resource_1"), but
> this left out that GC 11.0.4 had breakage at MES 0x51.
>
> Bump the requirement to 0x52 instead.

Do we know that 0x52 actually has it?  @Shaoyun Liu can you verify?
Assuming that is correct,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Reported-by: danijel@nausys.com
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4576
> Fixes: f81cd793119e7 ("drm/amd/amdgpu: Fix MES init sequence")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 81bf9385d55a0..09ebb13ca5e81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1673,7 +1673,7 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
>         if (r)
>                 goto failure;
>
> -       if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x50=
) {
> +       if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x52=
) {
>                 r =3D mes_v11_0_set_hw_resources_1(&adev->mes);
>                 if (r) {
>                         DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=
=3D%d\n", r);
> --
> 2.52.0
>
