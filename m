Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F377CCA0EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 10:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032EC10E7A8;
	Wed, 27 Aug 2025 10:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.b="H07DyHX1";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005F110E7AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 10:39:38 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7f777836c94so55459885a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 03:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1756291178; x=1756895978;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KdUUYdYYMaA5K4ETaZuOUOJJM1a2acdPrTwBBDRRG4w=;
 b=H07DyHX1DmCyRKQ9TUyXw5wMscDrhGjwmn7cH1Pf5A8p5SCEaURTxDX3iE02FcBgry
 gk2jT/XqO/MY2f9sOUSux3Dz/ZRfK4p/te1iaYWqg9odf00PmxsByzOJt6ELWHkM5cx5
 U+/LaLLTEyTPDkDUeXvJcOG0WfLC4B6Zn1yVfQuoqlkbu8uR1HQLAmt00PqY3KJ0RgCh
 QddOUA6kZ+g5DWUVZDaK3ztwh3+q4UzjXd/5qa4zwdlaw6qZmHXcVX8JGBu31PXY3jh8
 i1DZ9xADs0G7CWks+U2GEKU1f9feyij4dntvNne9YK1pnIfzQ0vWdZSCJE9cNjXSGHGg
 UcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756291178; x=1756895978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KdUUYdYYMaA5K4ETaZuOUOJJM1a2acdPrTwBBDRRG4w=;
 b=b70c1zty6ApOM598GUGZ4yzX5O1TVgIbUYZMOMUsJrxL9IXBS2amLzs6ShzVM31XVE
 K4AXrxL5weFlszG3f0E7qLVSzGry5KgwWnnysSmnuitJCvmulWCnN64QeHCEEA4THs7Z
 zM1rVAdTwHy8IPWAU14Z9eLyNwmcJknVDqPFRr8f3nlKEW9a1e7Bb7PRzn7UpFlP4Oy2
 bcJ7rzVFM+W6M3k6nJO7Mz+oqFSDALwROJP2KTuLlY5Dye6wLvXfasyBTJa107g+rjVa
 S8ASOElbst+IiCzJdhCQS+Ihjoew9u5cvCYyek98R/gZR0ZJZ7y9mYCzNk5aXOPRNb/1
 zEnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOVSFYzNWw8//xoFEICzTjiYwvj+4MEjHkW0q3hb2IeBuTvX9x3hPVHyL3aQ0LWAvsyqN1rO2X@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3xJwdnwBoBdq+Dl8UILDlKhJtOAE6U6s1a3oY8bdt0+PHARui
 s88Ujk9L0MPodvbm+bx7Fdf08dcBD2+2oiD0phGNvBEGhcCi/abw+1E+5A8T77b5Wx7LS7H2A8U
 0geEprXo0qkVVXYCroMc32VPIXsPqSNmQOVzWPJNCZg==
X-Gm-Gg: ASbGnctMyYGb65Szn557YngYeebzQE4W+PMkOvV0N+2xyrL7Ewcupbvvf3Icscgo55w
 PAVAG2nha+I773PUX3dBIXPcRMtiQvGw5whYeccYbXxqxPfSfHDWTpgmnujic+KFurtyeAYo12h
 OaXPA2C8PA7FSsZmWYcF+cVGqyvpfG3CqwhXnC6zdMXCYFzf5RNq7uShOJehDNjPRqzDqz1aBHd
 oTCRtIPWgiwXP6qOevb+/IxIhc=
X-Google-Smtp-Source: AGHT+IGICLeibcQmnZWYFS/brOl+88R3Na1uvRw0VQWTlZaKJUHWBkBh81Tx23IIhL3FKds+ZF25D4ZEHOiVNLlKiOo=
X-Received: by 2002:a05:620a:ac15:b0:7e9:f1c3:6851 with SMTP id
 af79cd13be357-7ea1108f69amr2193999385a.71.1756291177899; Wed, 27 Aug 2025
 03:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <aK1hPoCmLziaPPOd@xpredator>
 <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <20250827-imperial-mongrel-of-dignity-712fab@houat>
In-Reply-To: <20250827-imperial-mongrel-of-dignity-712fab@houat>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 27 Aug 2025 11:39:25 +0100
X-Gm-Features: Ac12FXwa0ndxe4WhxS64VBVPx8pzaNWj2GmesKshpkeIDruMRsTSCWY0sc4CrIA
Message-ID: <CAPj87rPhK+E2FP62fnNxFySDOkqqKxo_oa94i7DR3_6a1j1o1A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
To: Maxime Ripard <mripard@kernel.org>
Cc: Shengyu Qu <wiagn233@outlook.com>, Marius Vlad <marius.vlad@collabora.com>,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
 contact@rafaelrc.com, lijo.lazar@amd.com, jesse.zhang@amd.com, 
 tim.huang@amd.com, dark_sylinc@yahoo.com.ar, mario.limonciello@amd.com, 
 alex.hung@amd.com, aurabindo.pillai@amd.com, sunil.khatri@amd.com, 
 chiahsuan.chung@amd.com, mwen@igalia.com, Roman.Li@amd.com, Wayne.Lin@amd.com, 
 dominik.kaszewski@amd.com, alvin.lee2@amd.com, Aric.Cyr@amd.com, 
 Austin.Zheng@amd.com, Sung.Lee@amd.com, PeiChen.Huang@amd.com, 
 dillon.varone@amd.com, Richard.Chiang@amd.com, ryanseto@amd.com, 
 linux@treblig.org, haoping.liu@amd.com, Relja.Vojvodic@amd.com, 
 Yihan.Zhu@amd.com, Samson.Tam@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 wayland-devel@lists.freedesktop.org
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

Hey,

On Wed, 27 Aug 2025 at 10:41, Maxime Ripard <mripard@kernel.org> wrote:
> On Wed, Aug 27, 2025 at 12:26:56AM +0800, Shengyu Qu wrote:
> > 1.Can you send patch with only i915/amdgpu first? It's a long-needed feature
> > to deal with some monitors/TVs with broken EDID.
>
> If it's to workaround broken monitors, then it's really not something we
> should be doing using a property.
>
> Most likely, those monitors don't support YUV* output and will just need
> to be forced to RGB, so it's not something that the user (or the
> compositor, really) has to care about.
>
> And it would be broken with every driver, not just i915 and amdgpu.
>
> We already have some quirks infrastructure in place, the only thing we
> need to do is create an EDID_QUIRK_NO_$FORMAT, clear
> drm_display_info->color_formats based on it, and you're done. No uapi to
> agree upon, support, test, and it works with every driver.

There are other reasons to have uAPI though ...

One is because you really care about the colour properties, and you'd
rather have better fidelity than anything else, even if it means some
modes are unusable.

Another is for situations which static quirks can't handle. If you
want to keep headroom on the link (either to free up bandwidth for
other uses), or you accidentally bought a super-long cable so have a
flaky link, you might well want to force it to use lower fidelity so
you can negotiate a lower link rate.

I'm all for just dtrt automatically, but there are definitely reasons
to expose it to userspace regardless.

Cheers,
Daniel
