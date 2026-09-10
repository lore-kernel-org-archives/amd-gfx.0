Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1E6C79F9F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 13:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A3E10E2EC;
	Thu, 10 Sep 2026 13:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k3fEr0zq";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F0610E2B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 13:16:02 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 ada2fe7eead31-781d5818299so230263137.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 06:16:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789046162; cv=none;
 d=google.com; s=arc-20260327;
 b=dr69pyEZqdH2GaWqEiCVWcNnWcWgdEMC9RtOcSuI19qiQpUo009/cL0dxivrnUSEz2
 gVsFKCoDnsVcYXnPZ49z74MQkQlaS8cFl4LpxWv+cPKX/UuV0R/3n1eIH0kcKFmj+bRw
 TvVeaWBSJwR8eeU26FgnEoloS4ojBizeooXPdRghxtvFySwChTU03i5VjwsDpRVaPZAi
 ARnkxAUoNr3O88wjhqbwspHczAOckBu12gUPQ/EBTrTyxkfFS3kG5zHaRuNDmy+hr4DK
 2RLZeWvlaFBWlRnvu9Tc5dlD3ITz2reO22D6jUKTR9Lv9TLfOvfphia+SYlInFFTtEM/
 AbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=moA5jUO3uVa6D/ugtSObUrS5bANjOYs5c5g0mj7H5a0=;
 fh=vUkROqhcmiv/iZJTyfXKJi7f16/uHKllBbp0n/KSDBI=;
 b=jeVy1NiEnVPMCqO7Y2Sgv70HuZsliZG6L5b8R33IghGtoiEvxrLWfICbRmEpQT/ybU
 jVnHctrkyMioPk/ApznYJQPKJJ1GqFyTrzWQ1oXgMPehjpspIw3SYKSuURxYGL97DM+b
 lrzxkV48THz7Tt0j8zDxHuzsuEgaxOKpqx1Tq00TrXMi+XvrQR7IeLulEG517XF/Z/tT
 BTw3j7sPN8exr9G9X+ON/YkkFfNStF9dJPL7r1Wa6t5im4tf+gIxHJ+R6U0VjkSc9k7Z
 WRRSyH+dfIxrVIfOb1WQ6plLfz64Hrzimy9ti7YF2/FHHc0Hhx1JHHx9rRS3u7UnzEo0
 GbHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789046162; x=1789650962; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=moA5jUO3uVa6D/ugtSObUrS5bANjOYs5c5g0mj7H5a0=;
 b=k3fEr0zqlvgpWBU+0mud+inxEMOA+WYlHbLBHZOpKE/zJVJRuI6QeTILxyLxsKtnrg
 ImLTI2t2KX/wOTmUrLj7virQd2KkXe8To0oAS03TVSwV2l/XZ9AnMAv26WEgX8lS+sCm
 zZY0o0zn3L4exKr/JYYup/hEpRsOfoRAN9EkOWf7R5Kw2hSUw6G3H/BxoWORcX+Q8Y/Q
 le9xc52QkWhLDfbHGCi1zjASlik7ZJrNHEHxXLrSe1fl9qeMol6sDytZNUazj/GtPoBK
 KVWAhHerzphdw0LZ8OIVlwHFeheaYQTCBcyJ/Tt+9kllbmO59unkT31iActBKXKCUbfj
 K84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789046162; x=1789650962;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=moA5jUO3uVa6D/ugtSObUrS5bANjOYs5c5g0mj7H5a0=;
 b=PJf4gqbjfR7QAhgW8THns5dF01LrwXk6BrY5g0ce7hHVpzfyG7wyMUbUSt8HjunoCN
 23aZYYKlf8sF1xcdi3J8xhd7bBdWLYxchLTxW0xaZqO3sxrPOqqcVqvgZ6MdQLnL11Dd
 AZWcn2bK8XBzJYKCmuc8m9kWQXggnRujpWFoX96QtcuPvEqdcv33UXTnSr2fM/jXERNr
 u+wG3uFsVBBBWP3K+8dnKpQlGA5I9Luh9wZgEXL8+0RgKD2ONJ0hGd3LpL4GRSCutImE
 wdLtTZqOjjewgk7Y8sNeyiHQpTj+9dfEruynrXEeivmEIzmFBNYY1Cpe4xIWDdKHPiTc
 wu/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTlDI1BnpVDac6TrR3ei7IvIliW8C3SqyPEvq98wz0cElyq/Uol5fP4IHT0uCD43bqmWu5/28J@lists.freedesktop.org
X-Gm-Message-State: AFuF++my/IQqC6JeKfg1bd/4SMhxGZl68MdaX91o2xCg8A18AObaMStV
 9X9S81yK6iyoyehe2I0UduHo7TtKUiLSWKI/ZmNgJRTMm6lPT21Ep20pDGcow4R9nWr0TLaegDq
 AgbJqgRip2NmO3CchQ1KXP8YhAwFkc8A=
X-Gm-Gg: AYBFou3eslhlu1JjjCji5dMr96hzB4c+5TvhAhSp7JlZsQtUr89MNfaFblNLTG/vMoL
 yTdcyW3rXY4T//1RCWTuL1LsGqzySGrXi9hRjb0GwKml6vWQdtmf4s/QX2WqyGbGAWRjhnpktnZ
 B/WhokC6A15B92N0sCvkQasllhJ/ABzCD9a8gR0+Beoi5SHBA76QIf4lKkErcgdVG1QZd+tfnDl
 aYhUcZEG8kC8zMxGpMKdmZnVWxoHFwUvmHynhz+7s1RDlxH03/CHsaHEBJF+sr8z+ORDT35LZuK
 kXj8mWO6oQjxfwlwtTldz4uJFdj3XEmN3ECO9ljD8CePmW/Ugnn51eQOIR/d8gzI/tpounX569E
 LoJR4LMWMqGcTPpVFWm8UIuGpSbBgxMT6mrbkd+gl4A==
X-Received: by 2002:a67:ebd5:0:b0:790:563:8d1b with SMTP id
 ada2fe7eead31-79005639f22mr1869415137.0.1789046161658; Thu, 10 Sep 2026
 06:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260909173103.73656-1-klarasmodin@gmail.com>
In-Reply-To: <20260909173103.73656-1-klarasmodin@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Sep 2026 09:15:48 -0400
X-Gm-Features: AcwNN1XHoZUcFvWmvZ91jrJEiVXoE4O9xNxPdZc5AmfqfU3fK8LxM3IuZyCmVsY
Message-ID: <CADnq5_MCChZJ3vFmAeMPhq1xHLC5Ba+=g+v4+OUKZ8ciLbKY3A@mail.gmail.com>
Subject: Re: [PATCH v2] rust/drm/gem: initialize callbacks with
 ..pin_init::zeroed()
To: Klara Modin <klarasmodin@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Thorsten Leemhuis <linux@leemhuis.info>, Manuel Ebner <manuelebner@mailbox.org>,
 Gary Guo <gary@garyguo.net>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org
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

Applied.  Thanks.

Alex

On Thu, Sep 10, 2026 at 6:08=E2=80=AFAM Klara Modin <klarasmodin@gmail.com>=
 wrote:
>
> When the commit b67d2d039f64 ("drm/gem: Add callback for when handle
> count goes to 0") added the handle_free callback, it did not update the
> rust abstraction, which will cause a build failure when that is enabled.
> Rather than just adding another None initializer, use
> ..pin_init::zeroed() to make all unlisted callbacks None, and remove the
> existing zero-initializations.
>
> Fixes: b67d2d039f64 ("drm/gem: Add callback for when handle count goes to=
 0")
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/all/aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@=
leemhuis.info
> Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
> Closes: https://lore.kernel.org/all/4da62a4b-c4ef-492a-9a27-b56bd4784acf@=
suse.de
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Klara Modin <klarasmodin@gmail.com>
> ---
> v2:
> - also remove initialization of vm_ops, which is also handled by
>   ..pin_init::zeroed() (thanks Gary)
> - fix the same issue in the shmem helper (thanks Thomas, also reported
>   by Sashiko)
> - v1: https://lore.kernel.org/lkml/20260908175427.47207-1-klarasmodin@gma=
il.com
> ---
>  rust/kernel/drm/gem/mod.rs   | 13 +------------
>  rust/kernel/drm/gem/shmem.rs |  5 +----
>  2 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 80d8f524f9d5..9d4280002765 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -266,18 +266,7 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, =
Ctx> {
>          free: Some(Self::free_callback),
>          open: Some(open_callback::<T>),
>          close: Some(close_callback::<T>),
> -        print_info: None,
> -        export: None,
> -        pin: None,
> -        unpin: None,
> -        get_sg_table: None,
> -        vmap: None,
> -        vunmap: None,
> -        mmap: None,
> -        status: None,
> -        vm_ops: core::ptr::null_mut(),
> -        evict: None,
> -        rss: None,
> +        ..pin_init::zeroed()
>      };
>
>      /// Returns the `Device` that owns this GEM object.
> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index a687d46d170d..24cb5343e0db 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs
> @@ -132,19 +132,16 @@ impl<T: DriverObject> Object<T> {
>          open: Some(super::open_callback::<T>),
>          close: Some(super::close_callback::<T>),
>          print_info: Some(bindings::drm_gem_shmem_object_print_info),
> -        export: None,
>          pin: Some(bindings::drm_gem_shmem_object_pin),
>          unpin: Some(bindings::drm_gem_shmem_object_unpin),
>          get_sg_table: Some(bindings::drm_gem_shmem_object_get_sg_table),
>          vmap: Some(bindings::drm_gem_shmem_object_vmap),
>          vunmap: Some(bindings::drm_gem_shmem_object_vunmap),
>          mmap: Some(bindings::drm_gem_shmem_object_mmap),
> -        status: None,
> -        rss: None,
>          #[allow(unused_unsafe, reason =3D "Safe since Rust 1.82.0")]
>          // SAFETY: `drm_gem_shmem_vm_ops` is a valid, static const on th=
e C side.
>          vm_ops: unsafe { &raw const bindings::drm_gem_shmem_vm_ops },
> -        evict: None,
> +        ..pin_init::zeroed()
>      };
>
>      /// Return a raw pointer to the embedded drm_gem_shmem_object.
> --
> 2.55.0
>
