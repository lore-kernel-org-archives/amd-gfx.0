Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF764105F782
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A0510EB47;
	Fri, 13 Mar 2026 08:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eKa/GtPM";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3530110EA97
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 19:20:23 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2be2425ad18so54609eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 12:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773343222; cv=none;
 d=google.com; s=arc-20240605;
 b=KofEJVnpu2rBygmU70hLw/q+hMbbK88qsGIYSQkh1ecDBe0vps9o4OpauYEwKVeC9e
 ji9qM0Nt4mPuloFq5wFJeUqAR58UYt9vYpXLGS7svoHFydbdVGZ/U+oJJh/10sb3tBWk
 MSLbNHoleuxBZN8HwPFoQUj8M14IWn/fXa02n5+x4oGmDti36ROplTh41VYt/AL6LXUp
 Ie+E68f93nVBVgbkDfL82Uk3oeaHqhw8q+m/SA1I6bIv3PdI5R9Mxs/Taz5xI+vFSBjX
 3V6Lf1BpNrw3o3dsvQ0dfeI5OAwtSNfFt54HInqm5gW7T70EwT5GN6GBka5zxDhwDjK3
 Ytfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sqyBefgbThwlgKP9KCSuGlJgdIuR2RT0nMZ3gZqSKA8=;
 fh=4MoM57Ynhb6tbjhxMhx1OPrCZ1/IxkySa529tEv6xB8=;
 b=Dfd8CIIOPDgOQ1erj7o4uq2Lgl13xwXOLyReW86irK4vS9HwyvCJdfr6/kgQgIu5Xe
 qhIZySC+sM5BHm8T9V9KI7vdSQ4yAnP2uu2arcNzNiBJriDxbN3XIyqNklBxCwXQyJvy
 znHN2mSjUFXQCAMia3MCqOp/i7nFcn12G9ooYRaCzF5FcEG92uWunYinmU+J/GT7Bzjp
 OxdSH2u/rNnZ1UwvIqwqIkgrRNZyuZYY+4jL1+f4dKS6mTPZLpBJzmT5mI3/bY6ApyX8
 S7Belx9Y0eDL73td23Z1QZMTKJ0rbnp2QiG5utlAuZC/5Rw6KGIQXhvrwBBA0p0ZzvxN
 8aQw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773343222; x=1773948022; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqyBefgbThwlgKP9KCSuGlJgdIuR2RT0nMZ3gZqSKA8=;
 b=eKa/GtPM6DQyTDU1NXE17k03ynX+A5tbTCcDsNZIKXsmdmIq/2Vu2FvzIyDsBMF2kq
 3LB2Ba4NSm3HX4KTlxWs+XQe7CY4o0RwC07+JyWNzmZN4cgxB5VvH9RFlgMMxvbwKQ44
 e+9z7Rn+mW8nPeGorv2EXGrujJbIU/SrcoLjvuLFZFF9GuK65Qq/Orfm9g4r3xVVuQXm
 HNWJp0KcbVTZyQ06X0lG8/CefLI7VEfGZxw08RN70KxirSfYU8nRdXFRunAnrQz58EH5
 aCHWY0Lz7Tn3GVQ/vQxpnNi24rSzCQnwg7YwDCM6xkkU8ojuVnugo4ZbMgRi6ah2Clup
 /gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773343222; x=1773948022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sqyBefgbThwlgKP9KCSuGlJgdIuR2RT0nMZ3gZqSKA8=;
 b=gBmj1eERfQgpOttbNdWkiUb2PupAT5ABKpVGoWBFBydBH/vtZlelW60Oz9KTEI2+PE
 wsUi9ItO3FFYsN05bZ1wHPIlaFUesy0MSf03xMVv4sI7E2oHP2wD3KiyewPknyrhLi5j
 oq9cNYCZuBmk3zI5OFZM6hZHhVE8DOlD6NlaxfETF/f8/keOJlsP9ex+PJkWSCZ324zu
 +kYqFBYOjbwjJdNG/d63INRRPJhqF1JVCeQQFuMWNtjws1JucqDrZQsuPlhWBhYOj3FA
 31Fmx2RBPqwgoI+ZGj+fY7VmXf0WyamVOy8CM5MSvgNLDnuoPeOEyGLCr5TUVGVb1lTh
 i++g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJniryBkehCdrbl0x5GQKSFfw3V0pDeMrY4f5tu6kJPwo6qK3s8jiSRPoW8SyDpHanA+kdsbR+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBH+UWThe33a5i7aGfPO3xDxNiNIMpzPeYAwW5uV1iXoZeQ4uf
 O6gbcwtQLvsf35AnZQa7RObDQt4Q1JXyrrpYxOEjnBvEW5pzI7fCc0zZ5v5VE8ILQ7kBLZIUZJ/
 X0PpgQGh1Rl6+fLxYn0+0YcOnkdtPDVE=
X-Gm-Gg: ATEYQzw/PpY8gQxqAmh1hTVocApniArXkzn7XBBbHG4kzhnLoTNFhJRip4URGkSs1xJ
 2LPvzSv6PTrhjDIJttXN+ABYAus2Jn5XJSqLBmsE21mlQIRnBj8om3r5y4PHzhjY8nTo+RUnA+2
 96oygIJ/f0XwOwBV1zfuiO2HXWi5P9Zkqgd3hRaQZaxNY3EQHVV/GP/uja858c7JhgV4R7ECyYm
 9pE2HIhjHiy9aelvjd8eIJqWtASG6qYqiGtvE5tkZp75bZblziixmtHnKiBuoQzb4kskRWBrbSS
 Ya2Cev0VLSzNyv+1ynSxdCbbfxAby52JivAo86GCwTkCSTcJdyrgmS8MVI8BN4k0Vsux0Bls118
 AW44KCi0A4MhwV2EwqRC7u2A=
X-Received: by 2002:a05:693c:3113:b0:2be:ca4:e136 with SMTP id
 5a478bee46e88-2bea539b6c2mr239955eec.2.1773343222351; Thu, 12 Mar 2026
 12:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260306203648.1136554-1-joelagnelf@nvidia.com>
 <20260306203648.1136554-2-joelagnelf@nvidia.com>
In-Reply-To: <20260306203648.1136554-2-joelagnelf@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Mar 2026 20:20:10 +0100
X-Gm-Features: AaiRm53FHItUdFEegxUW1-4wt0_otNvbfdbd3Uys6sYfgMCnCSAVDf6Yalvkc30
Message-ID: <CANiq72kEnDyUpnWMZmheJytjioeiJUK_C-yQJk77dPid89LExw@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] rust: interop: Add list module for C linked list
 interface
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, 
 Nikola Djukic <ndjukic@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Philipp Stanner <phasta@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
 Jonathan Corbet <corbet@lwn.net>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Helge Deller <deller@gmx.de>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, 
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 Balbir Singh <balbirs@nvidia.com>, alexeyi@nvidia.com, 
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:55:39 +0000
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

On Fri, Mar 6, 2026 at 9:37=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.co=
m> wrote:
>
> +//! // Create typed [`CList`] from sentinel head.
> +//! // SAFETY: head is valid and initialized, items are `SampleItemC` wi=
th
> +//! // embedded `link` field, and `Item` is `#[repr(transparent)]` over =
`SampleItemC`.
> +//! let list =3D clist_create!(unsafe { head, Item, SampleItemC, link })=
;

Was the patch tested with Clippy? It has several issues.

The worst news is that it seems the "supposed to be `unsafe` block"
does not count as one for Clippy, i.e.:

    let list =3D clist_create!(unsafe { head, Item, SampleItemC, link });

So we get:

    error: statement has unnecessary safety comment
        --> rust/doctests_kernel_generated.rs:7416:1
         |
    7416 | let list =3D clist_create!(unsafe { head, Item, SampleItemC, lin=
k });
         | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^
         |
    help: consider removing the safety comment
        --> rust/doctests_kernel_generated.rs:7414:4
         |
    7414 | // SAFETY: head is valid and initialized, items are
`SampleItemC` with
         |    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^
         =3D help: for further information visit
https://rust-lang.github.io/rust-clippy/rust-1.94.0/index.html#unnecessary_=
safety_comment
         =3D note: `-D clippy::unnecessary-safety-comment` implied by
`-D warnings`
         =3D help: to override `-D warnings` add
`#[allow(clippy::unnecessary_safety_comment)]`

For this, we could write them as a `// SAFETY*: ` comment or similar,
to make progress for now, but it would best to request upstream Clippy
to detect this or to rework the macro to force the `unsafe` block
outside.

In addition:

    error: unsafe block missing a safety comment
       --> rust/kernel/interop/list.rs:357:17
        |
    112 |     let _list =3D clist_create!(unsafe { head, Item,
SampleItemC, link });
        |
--------------------------------------------------------- in this
macro invocation
    ...
    357 |             |p| unsafe { &raw const (*p).$($field).+ };
        |                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        |
        =3D help: consider adding a safety comment on the preceding line
        =3D help: for further information visit
https://rust-lang.github.io/rust-clippy/rust-1.94.0/index.html#undocumented=
_unsafe_blocks
        =3D note: `-D clippy::undocumented-unsafe-blocks` implied by `-D wa=
rnings`
        =3D help: to override `-D warnings` add
`#[allow(clippy::undocumented_unsafe_blocks)]`
        =3D note: this error originates in the macro `clist_create` (in
Nightly builds, run with -Z macro-backtrace for more info)

So this needs a `// SAFETY:` comment on top of the closure.

    error: this macro expands metavariables in an unsafe block
       --> rust/kernel/interop/list.rs:362:9
        |
    362 |         unsafe { $crate::interop::list::CList::<$rust_type,
OFFSET>::from_raw($head) }
        |
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^
        |
        =3D note: this allows the user of the macro to write unsafe code
outside of an unsafe block
        =3D help: consider expanding any metavariables outside of this
block, e.g. by storing them in a variable
        =3D help: ... or also expand referenced metavariables in a safe
context to require an unsafe block at callsite
        =3D help: for further information visit
https://rust-lang.github.io/rust-clippy/rust-1.94.0/index.html#macro_metava=
rs_in_unsafe
        =3D note: `-D clippy::macro-metavars-in-unsafe` implied by `-D warn=
ings`
        =3D help: to override `-D warnings` add
`#[allow(clippy::macro_metavars_in_unsafe)]`

For this one, to begin with, do we expect to have actual expressions
for `$head`, or could we constrain it for now to an identifier for
instance?

With an identifier there is no issue then -- the example currently has
just an identifier anyway.

I hope that helps.

Cheers,
Miguel
