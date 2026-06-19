Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E54CD98E4
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Jun 2026 08:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C4310E1B8;
	Sat, 20 Jun 2026 08:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ikjotzBF";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFEE310E0A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 15:21:42 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-492329c5514so9485225e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781882501; x=1782487301; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JlNoQTWruLYwjTd0yu1Yhr8omA9DMZWJZZsy9ry+wBQ=;
 b=ikjotzBF6e3AzN2fk30myb0OF2SPvwdj/TRhdxEweVHy7buVhq3tZI6HLwnbrcri43
 CReuxaRx2SBnlEdrT891gy2NZ6LS+Xh016YLA59lyjAL8d6mR4s1h92lRZZ/97oynfGL
 CnBgDk6V8+nl6ZGw+Ntfx6ELEzf89DIHlvDcPhQG3RDF3JR130hntk554a9JVg+FXbFA
 Bv05o5cd/CWElCyrwtqrthwWj8PYvkqUdAEj50aKO33JAvx9veD4/e1Zz4C+Fue2vBcn
 0awE/vz/ohxg9Q6MSj71Grm52MKe+h3DI8hX5+Wx2BFfmPNQZvb2FgCbu2aG8PDWfRYc
 FQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781882501; x=1782487301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JlNoQTWruLYwjTd0yu1Yhr8omA9DMZWJZZsy9ry+wBQ=;
 b=V+7FggjRhOgIwnQVsZBSZun8DlHcrfO5hWHtcuRIkfEpWmoZgeCpw75Z4dKhVen+DY
 is9cnGhz7EIJRujJ8crtlTeJWp/+iJfg2OTQd2WPaS0oC06zh3KF8alsxbFvmcSa/P4/
 Ti1VOwH9lIKBYiuNAMWUMr3tLdHu2Hd69bCYDFMBvD7AFPR7RY35LK81Tqf3xmQw16C9
 zAEcRw4QRLcf2GrG/kwIN7OPC7Q75PcTLaVQgGkXQk9hPw80p1f/GTxwOVUF7HtaSz9v
 +3Ave43++rvfVNaWM21EA9UgEgABTcZ7DXRgz+2vmfudlocQOg2tE8a0Nf6c5+iduYA1
 /gBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JKtSuAyN2Ro1hLN17MD6x4VzcSflhWaBjLSrDrdhM43SwtuPzNCg8H3MTCBoGkB8svWuIpyDB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsfDbNTNy+95vexwmD7s3qlLetZKwu6YmljaspH2dF+EAMWJDr
 Fl3QxC4biymJ187+moX3Vi+SaSbIVh1TdqKq4WcMJFWnFDv/dG3cxHfv
X-Gm-Gg: AfdE7cl72KoyalA6z/B1J+/ifWpVGhvh00Z9dJAFAku5bgk1YtG4cgchoDnoLTd4tLH
 BLQe0lz5mw9MC1JFei7XI6Oo5LZ9i19je01UQfrANWKPmQafEylxUZP64d6yIanVa4aqjsQdlbi
 52+v/BEPULHBcml9Abxv/fVQ59O4LxEFrSOLkzkxr9+xBUwevb0eX1DHrD3lXGRMGyykmyju9jV
 8N3+u308sBAG1gIdxDeliW3dyAc7nJX/7fR4TLo+WrsZoUCDq7ivpKpnZBYAxHFtZBZoYKm4NHc
 6bO0X/B3iSv8aKXWJerhuEjNRO0fONKnRKdUwTXw7RnEmeYISy9MjkyTMMpmShXMjPfKLPZG5tk
 hYXKfcIiowXYfY+gkpGSqTssuWqinkPzFXt7mwY+HRGgxLcXycXvaLgBEeb2CyBvrQaSPaddEvc
 s/RnhmA/y9PCzf6gs6cGNymA3PaWVPUEQH3csO3Y/cPYYCa+NuEKW5Pv9dJT7m
X-Received: by 2002:a05:600c:4e4f:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-49240a486cemr53130395e9.16.1781882501166; 
 Fri, 19 Jun 2026 08:21:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240084928sm79974115e9.15.2026.06.19.08.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 08:21:40 -0700 (PDT)
Date: Fri, 19 Jun 2026 16:21:39 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Ray Wu
 <ray.wu@amd.com>, Leo Chen <leo.chen@amd.com>, Arnd Bergmann
 <arnd@arndb.de>, Rodrigo Siqueira <siqueira@igalia.com>, Gaghik Khachatrian
 <gaghik.khachatrian@amd.com>, Dillon Varone <dillon.varone@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>, Linus Probert
 <linus.probert@gmail.com>, Kees Cook <kees@kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: avoid 64-bit division
Message-ID: <20260619162139.362299f9@pumpkin>
In-Reply-To: <20260619082313.3583603-1-arnd@kernel.org>
References: <20260619082313.3583603-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 20 Jun 2026 08:50:44 +0000
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

On Fri, 19 Jun 2026 10:23:00 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> 64-bit division is costly on 32-bit targets and should be avoided:
> 
> x86_64-linux-ld: drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.o: in function `get_dp_dto_frequency_100hz':
> dce_clock_source.c:(.text+0x407): undefined reference to `__udivdi3'
> x86_64-linux-ld: drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.o: in function `dcn401_get_dp_dto_frequency_100hz':
> dce_clock_source.c:(.text+0x8b8): undefined reference to `__udivdi3'
> 
> Replace the open-coded division with a div_u64() call where necessary.
> This could be done in a more clever way using mul_u64_u32_shr()
> or similar, but since this is called rarely, use the most readable
> variant that works.
> 
> Fixes: 6f6483dbfacd ("drm/amd/display: Update get_pixel_clk_frequency() for DCN4x DCCG DP DTO")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index 7c293917e6fd..501ab1a3bac2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -1229,9 +1229,9 @@ static bool get_dp_dto_frequency_100hz(
>  			 */
>  			modulo_hz = REG_READ(MODULO[inst]);
>  			if (modulo_hz) {
> -				temp = div_u64((uint64_t)clock_hz * dp_dto_ref_khz * 10, modulo_hz);
> -				ASSERT(temp / 100 <= 0xFFFFFFFFUL);
> -				*pixel_clk_100hz = (unsigned int)(temp / 100);
> +				temp = clock_hz * dp_dto_ref_khz * 10;
> +				ASSERT(temp <= INT_MAX * modulo_hz * 100);

Doesn't that need something to force the RHS to 64bit?
(or has modulo_hz been changed in a patch I'm not seeing?)

	David

> +				*pixel_clk_100hz = div_u64(temp, modulo_hz * 100);
>  			} else
>  				*pixel_clk_100hz = 0;
>  		} else {
> @@ -1286,12 +1286,12 @@ static bool dcn401_get_dp_dto_frequency_100hz(const struct clock_source *clock_s
>  		 */
>  		temp = (unsigned long long)dp_dto_integer * modulo_hz + phase_hz;
>  
> -		if (temp / 100 > 0xFFFFFFFFUL) {
> +		if (temp > (UINT_MAX * 100ULL)) {
>  			/* pixel rate 100hz should never be this high, if it is, throw an assert and return 0  */
>  			BREAK_TO_DEBUGGER();
>  			*pixel_clk_100hz = 0;
>  		} else {
> -			*pixel_clk_100hz = (unsigned int)(temp / 100);
> +			*pixel_clk_100hz = div_u64(temp, 100);
>  		}
>  
>  		return true;

