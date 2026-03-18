Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6B71075286
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 09:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B09B10E935;
	Thu, 19 Mar 2026 09:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fn/6vfKJ";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B9410E0D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:21:46 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2c0c4194b2bso119887eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 07:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773843706; cv=none;
 d=google.com; s=arc-20240605;
 b=hf/J6Ljpiuf6a7pj85cDU8MXLGfBArS+TuANIg7GRqXPyTc7ULeLUQzKIEN5Qy/H2W
 9vbo/2Gjsa4TBxGw8UCgliI/tYNjTxQsyRDarulV8iitlaZybqs7vosWEpOfZO/pa4mp
 7IrpBWHfIZ8dZkW/XaKskpJd3GESkuBTrUsc1J2jx/1LH1V/9aw9d/MkuAMJ2tj2zsMW
 o87TutviyJeB2C8aWHSX3gwMakuS2C7oW3nZ7NwDuKJXJNM43xp2jjQRLT0iTeGIiRID
 4L68Oh4k7bqrAy7DsFwwxa19sDNdyCiZ+jIrFi3ksc4aqVFOv1L8uHO+H/Z64/EPdP9b
 vFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N50RuEjVo0iFefZqItqTOtUCCVZJT3+xKOol5E25ZQw=;
 fh=viEoh+Y683EdHvjBzBtd6CH7c8bBgSxD1nbVkySFoRM=;
 b=EjreHMVZ+PolVZYudhnhrNbWnhny8DXQv6S1Dokjy3my2T91y38XhdAMZ3aDS57KAa
 Ddy+bHVE1NWSvvPFsAnXlWCkGLbAEm/2F67riO3Cg2s/bd+/PF6Y7O3M74djS9+OPkhH
 yx49cHNNznrl9YdQvScvvmmbfpN2wvz97Q7mSZBbFb9Fwu9ZnSdpm7R8AK9YAPVpzR3p
 257kFk7DkACAO827Bpd7x6fKIU95m0R1gyei3tVgzVlWW9bGIh+75IVj6ulSOZln2OOF
 260xlQ13txT561IwrR0QH2gOFrSvbrWyDp4hKSNfZc38l5mW0M2hVxt6xcbcsQTKk19R
 KO0A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773843706; x=1774448506; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N50RuEjVo0iFefZqItqTOtUCCVZJT3+xKOol5E25ZQw=;
 b=Fn/6vfKJAm1PXIA+PjVSinbVk50X9xttHklztIQGz3nIKnd9QCJmU4Y3KXdS3HR9P6
 Yf/n9ZvcGlAmtezUQW4HDqvYlZEodElBA9jNszqClTI+1hT1rdvBYi0/ZZ8VxXz61hSm
 2PoqXjdBsBVPOAJb8IzHPcMgXRRnskoTgIf8yHvh634XbgT2yQSk7in4PV8LXLLJ+yH3
 LpYYM3A7Nn+aes5Qx84UrOsqTQ/SGjlWyZKJ96nOnCXk/ZOE8zBYpV28V4CqSvZft/5F
 J3oT0LVWwyobrkp2B1ArTRqFpxliEEq2PpivGxli/1m7PKbJnPXPQQEWfCoR7QVrWD1U
 4ofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773843706; x=1774448506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N50RuEjVo0iFefZqItqTOtUCCVZJT3+xKOol5E25ZQw=;
 b=Z/kD3vktR58PGQ69Wb4KlhzPu6ZWY0VB88k3BV0Rr/19GjQ4/kS4r+C3nifyMPh+Kj
 LNB7AwyIxnDyobJ0fWqFmtLYfK82qCWWe5Vl8ePU00ettW6cwWAIvaP5hoES6Qivvern
 yyxg3pDbu5gQeIAHFnZFmSt4v8k3gLsWveuOGSIkm7uofEvPVAqeslCU5mYirS9t+tT2
 im40el07/6xsINkfnSTF3U/8nPURLnJp1d5y4RfWHF1Zl94EpPObeNtYiii3+FIh/7z8
 jkueXODWvjSFaTVeB6MwLU9V9I9VPKxj7IFaHKvrwg0JsJjTT1SUeedABzzQI9OWKE0Y
 Jt9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNv7Uj0w2KkWzCjFTtL2sVlgFSYUkS3M5SYxNABnPjLbIFsl2SDTnmXCV9ZqRnPcsgd8hJFTjQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwObxqvyT2i2QVkX0pZ7HmzH6MO1gcgLcYA9YffJzkmcheM1BZr
 KSX6/j6DJZl8x/l1QhNTRxcBLMr2pzjxYdxmAAu8GYvzYCG8jQFE3MEwU6WeyCcjXfohSpMdiRA
 I3dr3ttD3d9WJGlhQWv0OaW4HZq3RFWA=
X-Gm-Gg: ATEYQzxsoXHw7PR9fcaeItMr7gqBgGXf8nbnCEo9pmFlxVRQj+SJoXjvVXLX0pYmVmA
 SoIvdHPQ9C0i3tqlmZZ8Koo3o7G/DrJigQ/x73JY8DNJqIQ4Ze5Tj6hqzzbEphkUfvT3nfhNHUU
 iy4ljNF9VpUgyW8A3cbTzl6kY1KM5O2qQ/WPKEm42cCHJ5nXKi4m4Azyux0Vjkzd/fo+4FvoK5G
 jYcKLzHbNBjoHSFBHsVb1DEPCv3ERU7ldmyf9L2Jv5m0gZPW2Sr/9gPVC4ypUNP1590bSqdxa7u
 OPmGTD5dPx3HCCZwzVQZuyQpu95v+RqZKx6+N3HsOAXs/wstMuEcFa3i8ELd5bz8Wm30mmbJzgn
 9CWOOVeVVnmAkFAR0P7M0AxA=
X-Received: by 2002:a05:7300:3724:b0:2be:1f56:ed32 with SMTP id
 5a478bee46e88-2c0e4f79e7amr862302eec.1.1773843705849; Wed, 18 Mar 2026
 07:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
In-Reply-To: <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 15:21:33 +0100
X-Gm-Features: AaiRm52hYvm4SlfuaD_e2Ur_BKHJMunoPzi20wYq7repEoz5nN2Go3Dpr2oWwgo
Message-ID: <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, 
 Nikola Djukic <ndjukic@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
 Elle Rhumsaa <elle@weathered-steel.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Alex Deucher <alexander.deucher@amd.com>,
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
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 19 Mar 2026 09:46:17 +0000
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

On Wed, Mar 18, 2026 at 11:54=E2=80=AFAM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>
> Ah, so there is a rationale for using a `mod.rs` file after all. What
> are the project-wide guidelines re: `foo.rs` vs `foo/mod.rs`?

Quoting myself from a few years ago:

  I don't have a strong opinion either way -- this was originally done
  to improve fuzzy searching, see commit 829c2df153d7 ("rust: move `net`
  and `sync` modules to uniquely-named files") upstream:

    This is so that each file in the module has a unique name instead of th=
e
    generic `mod.rs` name. It makes it easier to open files when using fuzz=
y
    finders like `fzf` once names are unique.

Another reason was that it is what upstream Rust recommends:

  "Prior to rustc 1.30, using `mod.rs` files was the way to load a
module with nested children. It is encouraged to use the new naming
convention as it is more consistent, and avoids having many files
named mod.rs within a project."

  https://doc.rust-lang.org/reference/items/modules.html#r-items.mod.outlin=
ed.search-mod
  https://doc.rust-lang.org/edition-guide/rust-2018/path-changes.html#no-mo=
re-modrs

Now, several other people have argued for the other way over the years.

For instance, one reason is that tab completion can be smoother with
`mod.rs`, e.g. every time you complete something like
`rust/kernel/sync`, you have to decide whether you want `sync.rs` or
`sync/`, and then if you wanted the folder, you have to tab-complete
again.

So I guess it depends if you use more the shell TAB (like Linus really
values on the C folders) or the fuzzy finder (like Wedson argued for
in the commit referenced above).

I personally don't want to bias it one way or the other [*], but
please let's avoid having both mixed if possible (unless there is a
reason not to). I can put the result in the new guidelines rules list
file.

I hope that gives some context!

[*] I would have preferred a middle ground like  modules being inside
but repeating the folder name, e.g. `.../pci/pci.rs`, but I doubt that
will ever be supported upstream since one probably wants to support
the other ways at the same time.

Cheers,
Miguel
