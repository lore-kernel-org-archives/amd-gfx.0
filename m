Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EF2C79FBD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 15:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D5D10F1DD;
	Wed,  9 Sep 2026 15:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bh/6liQj";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5993E10F1DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 15:57:51 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39666e7c9efso701885a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 08:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788969471; cv=none;
 d=google.com; s=arc-20260327;
 b=rEOKp4MUMzPd0R5RZ8yxg8pteRFB4IWL/0n9+Gv80a3vcw80Z8MyiUNE8LTQkK93x9
 PGyPdevL+wLeYSpHNvg0kyKlm28OK3S8V62P3KmXWwpNTaJ8qx6u6bw7HX746nE8IN2n
 OJLjZ6o2DFICO3/L9jgJ1F7RPjUIjEZ0715lhjKZ8EEo6adOJSHDjOk/4Waw7pfehE2D
 gVlR+I17nlCNAp6uAMfcdVRFWGPAV/OPinXT2Mg9NDOXA4vW0x3LCgo/JphJxRvtILP0
 QxQCVS1lxdwCC36qlp8bTq5GPWdiQtJzxTvJkopD71kqmwPkNkUVtkOlr2UnYS5A9Dom
 V/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0v9v/l61LJDXvYLeJKA3EU6R7TFlt+aBLu3xlyi9va8=;
 fh=b9+1i7ChlbzpOxQ0lZ3K9fshmSmYCZeQO+UM29S3T4c=;
 b=Ya9SlhSWsdxWAjOszh5b7nPJRIDKKWFbeGAiS07v1O3vHUbR8WTCyP6qADhkEByAPF
 cmT0VaylcceUSkdJaDT8wfp7M9FJyk25NAntn7uTXxYjUS+VTvPZxEG9elArfTmt+hvk
 jyZieDwxiKOOxc5RhNEPNZHGQaKSMtBBpvvtb5+XLUX5qcyTatTbgQMC3MGIovtb9fi4
 hqZg6fUL+MlO/1MmJrkL68kLgMUFVm+WheaICJext9LZWG1NEBDEdh367Y+PRwPNsW9O
 wYyuSGxZYTjI0lgWjo0zes9UxIsLUhiq1eI/PRf+YRoqYs+XkPXHLoBAs0Mafgb+EizN
 yFCQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788969471; x=1789574271; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0v9v/l61LJDXvYLeJKA3EU6R7TFlt+aBLu3xlyi9va8=;
 b=Bh/6liQjP6e2MkGCks1A1daQf6nnd/tv2oSLs5C1Jk8leCywFmjus5QFJrcy7Ney96
 r/Q0D5wogduE7Deyox/dBsANcGTsAZKs0BNzq1P8yVQzlJgjpjG0teZ56W4YUVP5ufk6
 c1TKJEixKDCwmvgEjDDUZDbiOlZcQ+CpB0HttwxDpsHoNhEq4t25B8ay3wDyKX5Y84hW
 1LuAvskZ/ysErmcOKMx0hW0rnhbM27zyHWCP89Tiwj+PsY+tiGTV5Kc0xkcUyyKVzRFc
 4H2pkAllvr5hJYeNXo5/mI5VKjGSQOxKEjsYmBfuemqeyRgfCe+rBIV7t3vddZZPCTXW
 fSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969471; x=1789574271;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0v9v/l61LJDXvYLeJKA3EU6R7TFlt+aBLu3xlyi9va8=;
 b=f2+4uRbCDM9PWbPfeA0CeNf58o6apv4V+KOnu3dgXHc3F2NNtGa7mzfjZwr5VKBJTQ
 x9l6znbthbMRl6kvEYFcZcihKS2QQR1CupllRrEQFWzRfupScpxZYhXt5q8SwqAAUJix
 Ad2Shws0k14sic3RO1j2EfaupdvKpq8U9EZgmjeBoxdXTU8mMspc1zHw7ehYBy20hCJ+
 ZWq9fV/dkq1lPcaAzGoLQmY+r1/iaW1ADrEztmqT1iV0HUTRn39RmU0v3P/kKQSsXFAT
 6PR/K6zaLkbLCL48uSHQHbC5R+UnZi1xs2CXjLWJyhr6pnYPr7P5XZg/ljNn/nIUuBC9
 0vyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoH3J+O75YFRiO7otoaF7K8EzgvXJI6OsHHtMSuglL4tfT4k9DGK2ZJkUZlNPKUswtMSmgGJ2t@lists.freedesktop.org
X-Gm-Message-State: AFuF++nW906YkhuKfYWAw5ZG3EvaKzMyxtHeuoa811tw/V9JnvU2+FED
 w+KlReI8adu8MuG9c3gCDVFNw1W0m0VSustZd9VUEK30qgvODhXw+fpDs2pVxDh65MkPtNKPy6M
 S8XuWH1IbisenPOG/ZFdB5t0GnwOqeyQ=
X-Gm-Gg: AYBFou1ZRjQvuW1+LwJLk64GyVF7o+DMDRdUhAo7DK2pREBglZ8qhLtFpw/tzQsECdb
 O+2lPCH8OG7AoAZnGt+9ZbrD/MgiEPaS2cGsKIEYZbJwChRr3veFaomYQQL1aj1xb+skKY1KUVJ
 HjihqrGpQmS6rRXPZpuOGv5KHVNHSmpmeBrszRARRnKlG13BCsoZWWqplM0Hu13pWC2AGtXrdi7
 H4G+kPZf2za3idV/Gp0fK65yQGMgvZZY0/JkY3mtxmDaRS52Z9PmPm5Yij7xKsdE8judZp77h8T
 vZFWZlQBgXx8Ssv0ebldjC1ooVMkCDIojYWCR/Zco7Fls5b8SgxQKKbr9dUcamCwRknKZ18xtVP
 l/DzEXSoBO2apMjZGUaiE4X02/sAG+Br3+6nBPI9+7G/mQ/1SGMVP
X-Received: by 2002:a17:90b:2251:b0:398:bac0:238d with SMTP id
 98e67ed59e1d1-39b3d7fc6a1mr28548919a91.5.1788969470558; Wed, 09 Sep 2026
 08:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260909094729.1593-1-mike@fireburn.co.uk>
In-Reply-To: <20260909094729.1593-1-mike@fireburn.co.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Sep 2026 11:57:37 -0400
X-Gm-Features: AcwNN1V2tAyfr-GYaZ5JcK9f7LxBdPRCMCy96FW7mYbvwWHGJtRYNOXLOtAWttM
Message-ID: <CADnq5_Mf5mQ4CF=8UTnEjYPGVUS-Hf29sHmesvtwdfnNxtrQMA@mail.gmail.com>
Subject: Re: [PATCH] rust: drm: gem: add missing handle_free to the object
 vtables
To: Mike Lothian <mike@fireburn.co.uk>, Klara Modin <klarasmodin@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thorsten Leemhuis <linux@leemhuis.info>, Gary Guo <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com, 
 alexander.deucher@amd.com, mukul.joshi@amd.com, 
 rust-for-linux@vger.kernel.org, amd-gfx@lists.freedesktop.org
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

Adding a few people.  Alternative patch at:
https://lists.freedesktop.org/archives/amd-gfx/2026-September/152673.html

Alex

On Wed, Sep 9, 2026 at 5:47=E2=80=AFAM Mike Lothian <mike@fireburn.co.uk> w=
rote:
>
> Both OBJECT_FUNCS and the shmem VTABLE initialise every member of
> drm_gem_object_funcs explicitly, so adding a field to the C struct
> breaks the Rust build:
>
>   error[E0063]: missing field `handle_free` in initializer of
>   `drm_gem_object_funcs`
>
> The callback is optional and the Rust abstraction has no equivalent
> DriverObject method, so leave it unset.
>
> The shmem copy is only built with CONFIG_RUST_DRM_GEM_SHMEM_HELPER,
> which DRM_TYR selects.
>
> Fixes: b67d2d039f64 ("drm/gem: Add callback for when handle count goes to=
 0")
> Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> Assisted-by: Claude:Opus-5 [Claude Code]
> ---
>
> b67d2d039f64 is only in agd5f/drm-next, so this can be squashed into it
> instead if you would rather keep that branch bisectable.
>
> The shmem hunk is by inspection - CONFIG_RUST_DRM_GEM_SHMEM_HELPER is
> not set in my config, so only the mod.rs copy is compile-tested.
>
>  rust/kernel/drm/gem/mod.rs   | 1 +
>  rust/kernel/drm/gem/shmem.rs | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 80d8f524f9d5..ae61ca7e1246 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -278,6 +278,7 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, C=
tx> {
>          vm_ops: core::ptr::null_mut(),
>          evict: None,
>          rss: None,
> +        handle_free: None,
>      };
>
>      /// Returns the `Device` that owns this GEM object.
> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index a687d46d170d..d08a03cb7a13 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs
> @@ -145,6 +145,7 @@ impl<T: DriverObject> Object<T> {
>          // SAFETY: `drm_gem_shmem_vm_ops` is a valid, static const on th=
e C side.
>          vm_ops: unsafe { &raw const bindings::drm_gem_shmem_vm_ops },
>          evict: None,
> +        handle_free: None,
>      };
>
>      /// Return a raw pointer to the embedded drm_gem_shmem_object.
> --
> 2.55.0
>
