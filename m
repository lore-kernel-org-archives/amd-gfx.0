Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28CFCCD199
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 12:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62FF610E291;
	Mon, 20 Oct 2025 12:31:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b6yLbF0l";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17DF210E291
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 12:31:26 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b472842981fso584009066b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 05:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760963484; x=1761568284; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fKfa3oGe0LaN2eGz6GrRE6h6OI+JbUznvpo3T4Hggow=;
 b=b6yLbF0lA6HsY/kbsd8kNX0kvBiu7ABMls5x2zpSrtI6r7X70u5UHQpDodRKdrl1MS
 6somDV4TIWTgfELaqBQfCvPOYA1D2K1KyEYPKfFwX2odhtVVFZwlZ9oSWGSzaAydHS5K
 GKtdlNCQGSzIlA7RWe+HbFT2d+2mp5Gd624DH52qs4G/jKMUsPqkuQ5XPa/t+qttAD84
 VwyaZByWXsZEtgOsmZxfv3znyqCKi7B5lcZssX9Uc4QOscHt6Y2ewSrraTDAcu8i+aDj
 mDNnf+mCT7mdBUiTPpNDlI8UOn07NU0zAnIR/Rml1VANK0yraWjFnwXEv8qFTs3I5Fyo
 3oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760963484; x=1761568284;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fKfa3oGe0LaN2eGz6GrRE6h6OI+JbUznvpo3T4Hggow=;
 b=d28DG1XOjJLCoOQZdMod1rxwz75Ds0iAOqvUD3Hfmn5UvVkdB4yNv6uWv9Bw8yD9Js
 sblrM64RnjEvQsJdcoBAjIijl3fs+oliKcy3L7NpMjILSSlQQtZPfUSREOvJJ8aTdYrr
 48oOl7WT0MiovCovOpEc7i2WpHQ9m9AZt6wnmtVqVmtECOG6L53I4A7jYdcNBO6Oe8Gs
 5iq/y2zuX2h0ie1y2S0iFpfjyW9hjeR7Uy0nkhJg29Q6y/qZUXG53Yf+Xp3FFEZveBMV
 Rcpm54srCmyS1Aft6U6qASK6XlkuGGJgMyV2FSeZf4vFmT4cEA9IeZbiEzJKroX5/E4r
 P2aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjdkq48FZC94hFzlUarCXebf3EW1iSicZtrjVQLd0kgvKy0bbFlrxOQXi293fPSyp2dQLZKiBd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfcWwIl9K0c32NRVCyFCK5B93lAUSqP4+zoLND4LPAtD39+zPx
 1fBnd0V5tCVpO9qFaoRRZuvTNfEhQJPQpxp4mageNTOSpH3BuFAfSqBlsz43iA==
X-Gm-Gg: ASbGncsQhkgKpTm9BLA8nvvYG0BACLURgPVWnd1MOSSC8+hHstWz/jjkHCa/1lz5DzB
 CyIAJKqYnk1gjAlYmLidoA7EF6YkChB+CuPU5qbbqaGLRcRnsl8B+yTie27JbBRhXTDOVjoETNE
 eHQjfHxTZWhQ5Cm/uhBtZz4kqj31vnJaAGkc1VaAL1WZlPX6yBAJ5qZT256ZEPq4a/i6rjqTbFF
 VNB0wzm+ze+i9lI5RF+pW1d2sHS8rsZXKcY62jtGN5Fd8t1v3LLOPk5rww7oyLpgcQqOoNhs7j2
 pBfK07l8++9WLa1PM/p42/sGybgspin0UTJ1O7ILrihZz5tvJdWpY6mY8emKP7NDQlogQvdxdi9
 GN/ukL8lKQj+s664++xq+t2k99VNXnfgsyHUlWMfsGTMC6+WWl54BwTmHFbUF+JYsdl0OA+Qq5D
 NgNY7rrBiZqjonG4FHrYxJV6Y/EPZ9UapkYyK71q8QNgvWeZTNPvTKj+qHUPtUKBnI
X-Google-Smtp-Source: AGHT+IGZWGYri1CqGWfz7v5YmUXL7fwAek2+4xp/WDqtcS6MsEGt50P2/VRJ8BA+gs+xmjv/IFpRPA==
X-Received: by 2002:a17:907:a07:b0:b49:3ee4:d4a6 with SMTP id
 a640c23a62f3a-b6471f3bde8mr1479868266b.18.1760963484242; 
 Mon, 20 Oct 2025 05:31:24 -0700 (PDT)
Received: from ?IPv6:2a0a:f640:1410:5e2:6b13:3cc9:e4ff:7d7b?
 ([2a0a:f640:1410:5e2:6b13:3cc9:e4ff:7d7b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65eb526490sm775561766b.65.2025.10.20.05.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 05:31:23 -0700 (PDT)
Message-ID: <a021f76ec289089dab0715399d44ad7704af8c69.camel@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Skip SDMA suspend during mode-2 reset
From: timur.kristof@gmail.com
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com
Date: Mon, 20 Oct 2025 14:31:22 +0200
In-Reply-To: <20251008050418.3399656-1-lijo.lazar@amd.com>
References: <20251008050418.3399656-1-lijo.lazar@amd.com>
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

On Wed, 2025-10-08 at 10:34 +0530, Lijo Lazar wrote:
> For SDMA IP versions > v4.4.2, firmware will take care of quiescing
> SDMA
> before mode-2 reset.
>=20
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/aldebaran.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index 9569dc16dd3d..0007d00b9e8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -88,6 +88,10 @@ static int aldebaran_mode2_suspend_ip(struct
> amdgpu_device *adev)
> =C2=A0	uint32_t ip_block;
> =C2=A0	int r, i;
> =C2=A0
> +	/* Skip suspend of SDMA IP versions > 4.4.2. They are multi-
> aid */

What does "multi-aid" mean here?


> +	if (adev->aid_mask)
> +		ip_block_mask &=3D ~BIT(AMD_IP_BLOCK_TYPE_SDMA);
> +
> =C2=A0	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> =C2=A0	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> =C2=A0
