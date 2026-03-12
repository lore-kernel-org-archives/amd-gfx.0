Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D1E106ACF9
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DACF10EB4C;
	Fri, 13 Mar 2026 08:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I70LgRYw";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC59110EA90
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 19:16:13 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1273c690e5bso106284c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 12:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773342973; cv=none;
 d=google.com; s=arc-20240605;
 b=Bjj49mBRDaqo7vUw+bcsEAOr3IoSg4wxJXka5x1NcDTRizsmyF4MHZl0QtcMY/ZBi0
 TzD1/AmpP1hXkLTtg3xLhLeMjmUlgXEysq/Rzwv5eK73PWckZVTo4iUHSHMMc1ht0qky
 M0SYh5JkZ6KqwlVMEy+t3BZbAoV3m+eNNbWZpmb6QTnm9aQBItyCcuK6XBz++owpMr87
 DALyYJjFgU5c+5MJ1GKM/WGDTz5lJ9BVlUvQqmfCXjkHg4WzVyN9QEuQYk6MPpoBbPRH
 AFy3BAj2a0hJ1DLpvjvqbDo1oLx0NAf3VEaZm3oBqgJKmLsWkDiRdUG+J4KNdEOXwMfW
 jIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2hzSysAOGotLHY/Gk0vtKsQ07bdjUjpPdIHGXWzs09g=;
 fh=S5/9mA9fQWpJ8WxlIENoFeKao3i2nJ4JwhFHpOu7CqY=;
 b=RU1yBfUxB5XpEKbDRkDx9sDsd/3ut/tl2e7VEBmuoAETtu4uWCLK8kIe90pHqOHLd5
 NzOZs8ciprIxBS+RdQsiC7RyVCc0qYAsu07SmId7WNbeCckEqQ5CqnG36M8KULXzz1t0
 95c3P2fq5EATg6GdNtL+8wMBlfbGK+tZw8MKK/vTJUyewQqTtyt4CEa609C/j0d7t89n
 msfkHacQvsDBFSwGV9CQP1Mszla+HQItfi3BVM9iPqWJ4b2EAN3sKaetzCGoeRI6VWlC
 wQSCpp4qIikLYqVrT4p0Wp416MMs99rhG01P0VVGzVLJUpciBC0TSHzbFa70D5Z0m1is
 YF6Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773342973; x=1773947773; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hzSysAOGotLHY/Gk0vtKsQ07bdjUjpPdIHGXWzs09g=;
 b=I70LgRYwmb1Kf3TSnl+ArSLtzExyTBoa7dl04aKCHbpIOVlt0pkM+kTuMC22F9ryVp
 jUv01TLfI+UOeUVX6Sjz3kZS8LJyXET8ksAMjQMZzMqR2UNwz/RhUR0Dh0iVLA9TJZHL
 QXDsAXdQJiSbkyV3ypZv6uYxCyR1eCY+nrb6KQRwRLstb0XzDVTra1OJoA7lxpmr4sXI
 kaiXA9abzkmSNzENEsVuZBIyKPxgfqceCeSC5GzkFLFj33Ut8QJ5agezs64BnIL5WFv+
 4K0QJleWgs+yILD46TlDsM4JTXcyiLlouPXq9bhfJihv+HoQC5so3WutGFCQ5CAn3ICC
 Xoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773342973; x=1773947773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2hzSysAOGotLHY/Gk0vtKsQ07bdjUjpPdIHGXWzs09g=;
 b=BqTF3r6Xg/ibX7MDrWLq4dxNT0Pb0jz4optaeNhPqo1BEPNrie5eCNhfPf6ZGl1Iwd
 adXver2k+bGTr8GcFGKQMEJ+1IzKaVBMIpEyBnbKqNqbDralSdeXYp+PCyngT4TmKExV
 t512Yh42LTa2JI/f6Fo5Ns4xcuppCdT8Tu7KDoCPmAASoYc4aIONKOPt8v+sIUCnyZ1S
 j2iqq7b+82jrD5HTDK/T2e0UXHctSqFpKy8O6MQbAvK9ZirRlncAhQBnid+4NIU0vOin
 R8jhhU6yMmOwxnGvQBYsBAxSwQqkcIs+tqFIU/aZTicnsk9cVeAfC/c/upiJ9smXNPYn
 cVhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdfo8UBfoT95p7JKRlglyYA6zZaqGtIqAHyltoqrqsOmgusqUK7e5WEeVFT1j8kd8Zv4lAHAot@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyL+wPEJnuvdD3y38kqEjAVetZ5xKyWaYZvTE0jhFdIzhEdYVtg
 oRUrhJClK1KLMuAQ/eFaBPNlRc/jKtHmN64ulAtSknj7CUuDUApb/M2eLOstpFu4i5CG44cs2sE
 Q/OycVoAMuTqCk27wOPps65Z15cCkzlo=
X-Gm-Gg: ATEYQzy35u6d05b6xFCSEwI96qdp7I5pOoknKEVYh9lRqjOxbgoRm0zED6l0RWES629
 Hu+a8WcS/kaXE845n31WyBH/nhKCGSCr7Y/x4WodDg7syBhXgdSFo9hUEBcOeRSO1MNiAZOrhvz
 tJolMG1Yht3js50fzX7vibgVe96LTBefkdKh9dQ3qN//QXmHWLIZY6qeXPv9rQl9N/Yo6EN+aKh
 bRqh6TXlbsTdudjyWyU1VQ3o6qh6qWBVm2zMix+B5x0CZ1cNDJWonYqRSRWm2xF0z9VuRq8d3ay
 rDsw4VrG8Tn9wEGA4N4575YoMM7A2CtiScl+wziS87B0NThKngjR1quexxUto4DnXsodCkChGVS
 gwJHHOsaeijYcWeCzm0ygF6A=
X-Received: by 2002:a05:7300:fd03:b0:2be:171c:2177 with SMTP id
 5a478bee46e88-2bea5744a60mr186533eec.7.1773342973060; Thu, 12 Mar 2026
 12:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260306203648.1136554-1-joelagnelf@nvidia.com>
 <20260306203648.1136554-2-joelagnelf@nvidia.com>
In-Reply-To: <20260306203648.1136554-2-joelagnelf@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Mar 2026 20:16:00 +0100
X-Gm-Features: AaiRm537cVQtFBzSwOEaMgXdjzYeE0uMIzdX3f2cfwXX8kFS15LK67mGvYzfQo0
Message-ID: <CANiq72m2Eo1UAuwMC0LhiD4+yqKixRm=+oHtEnpwY-VbNdR+fw@mail.gmail.com>
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
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

> +//! # // SAFETY: head and all the items are test objects allocated in th=
is scope.

`head`

> +//! // Rust wrapper for the C struct.

Empty newline comment between these:

  //! //

Actually, should this be `//! ///`?

> +//! // The list item struct in this example is defined in C code as:
> +//! //   struct SampleItemC {
> +//! //       int value;
> +//! //       struct list_head link;
> +//! //   };
> +//! //

Let's try to use the usual style, i.e. no empty newline at the end of
docs for an item.

And the example should be in a proper code block with a C tag, so all
together something like:

    //! /// Rust wrapper for the C struct.
    //! ///
    //! /// The list item struct in this example is defined in C code as:
    //! ///
    //! /// ```c
    //! /// struct SampleItemC {
    //! ///     int value;
    //! ///     struct list_head link;
    //! /// };
    //! /// ```

> +//!         // SAFETY: [`Item`] has same layout as [`SampleItemC`].

No need for intra-doc links in comments (for now at least).

> +//! // Create typed [`CList`] from sentinel head.

Empty newline comment.

> +//! // SAFETY: head is valid and initialized, items are `SampleItemC` wi=
th

`head`

However, this is giving me a Clippy issue (please see the other email).

> +///   `next`/`prev` pointers are valid and non-NULL.

We started using `NULL` recently as a convention for the null pointer.

> +        // - [`CListHead`] has same layout as `list_head`.

Intra-doc link not needed.

> +        // - `ptr` is valid and unmodified for 'a per caller guarantees.

`'a`

> +        // SAFETY: self.as_raw() is valid per type invariants.

`self.as_raw()`

> +/// perform conversion of returned [`CListHead`] to an item (using `cont=
ainer_of` macro or similar).

Intra-doc link to `container_of`?

> +        // - [`CList`] has same layout as [`CListHead`] due to repr(tran=
sparent).

Intra-doc link not needed.

> +        // Convert to item using OFFSET.

`OFFSET`

Newline comment after this one.

> +/// Create a C doubly-circular linked list interface `CList` from a raw =
`list_head` pointer.

[`CList`]

> +///   pointing to a list that is not concurrently modified for the lifet=
ime of the `CList`.

[`CList`]

> +/// Refer to the examples in this module's documentation.

Perhaps we could have an intra-doc link here to the module.

> +        // Compile-time check that field path is a list_head.

`list_head`

Cheers,
Miguel
