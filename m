Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEDF107528A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 09:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD2E10E93A;
	Thu, 19 Mar 2026 09:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hls9sLPd";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4A9210E715
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 18:57:27 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2c0e158158eso6621eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 11:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773860247; cv=none;
 d=google.com; s=arc-20240605;
 b=g+1S9pxnk+NhXNIBFuKjr+rOF6J+V9jAR1JfknyiWs2I9yi7GHgBStYSYKRI4lrZgo
 AEVlZdSuOfk4sprwCZRr+JZ+s1XLSKwJGLalkVSlkU6dFKVcq/MmsjZZdUbBwTtv/Wzi
 hqw01YwnD1nwFm4IVltCJIFiQ5lmuJIEqyaCYnPW3fBvS5TvfQvrEcsMGvVmIHOAcUza
 eetGjwDE8jocJnVDb5/1JmtyKGfpmF5Km3Vkpkce546Gq/lT0g1KsCX22sqk2us6oURQ
 K3R/3Ubjp5kAO6IV9vAFM5T/p+2Cr/LrRiFPW53bc+iBFNWqJMQ2fJbvZpcLOOzOYS9R
 jhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d3bcHjPGT0Fov9B4KoCksRHw66Y8wxvQ5LjIruDyWqI=;
 fh=adOLyB3887bIPTaZ9N2+olz+84cXiLxoBYszBFcPXvs=;
 b=VO2q1XoVljrHwHED9QRbGyxzG7fReo76as73aq+sMzks2zKzhDckezCQRwi68d2DJq
 gqiAgcKKyH7jWSjO7bXUzt7uSgkF795KgWwUu4Ys5QWIoZwmLdeAvcQ6cY6Rm87lE3TN
 ze57ukJanVFNFl3pf6rvqXjmP2RV6F/2n1eEYMrD5C9u+3/8RDOrihGSxG7b0sKbnwvt
 QH0rrhpJSBKdt0rK7K47tjtHhFLhUtVS7nZjx7Qe4KTtgPJJp/PjRq7lePYES9WoQ5rU
 kRoPyGaY8PpYrIYH5WqDLNF64M9O98sLI8mmJSidWb9fH034i4+GoDx+STivOtzd14Rh
 lwmg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773860247; x=1774465047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3bcHjPGT0Fov9B4KoCksRHw66Y8wxvQ5LjIruDyWqI=;
 b=hls9sLPdPRx7gKm2di3aMw2U4eOoEz7UL1WQuwlgmSVnwttmdt5y3dmL6ifcOEIPm6
 vrrOEbeNXy3TVfnEm89bUrAf2dQ2n2Hg7X5bICkUMdC1wuJgnDVthMzkTACUH0dki0Pa
 ba8a7Yr0Qd5tu4BFRsVH/vFH95M2ttgA5ZlLadSrmsZTog02L1DjqGm1IKAk9IyBp3Kf
 7pq9Uem0z0W1RHuHX3+FZyMXfWHEcl04Ue1fqTnqdjs3o4ftWaGArAH66masDZ8xzSm/
 4ZPs2eD8zzbFGTW5Tgn7LwbRB+LF5nwVfebtJzIv6vm3rVID9I5dt03Z0uautMoxF6oh
 DK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773860247; x=1774465047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d3bcHjPGT0Fov9B4KoCksRHw66Y8wxvQ5LjIruDyWqI=;
 b=pfOj/JQT3TQ7/EWv0vHOnCB5Fjiwqdqz5nttfK4yAfHy6K20aaR1gtgzhvtSSfnj4D
 O0dgH8dl5V8x1ze74crdlW9tuNErRclWk5DqY/qw/RZHWMbPsZLYp82g3c814NbvbC2V
 dlk+7JIHS2hYcCC9FlzqrZx6nt7l7fYLd/QF8SYy7uw2ZyATAXEA5XZzfjX6HCk4P5yb
 itOCZ2ZVnQWrwMxozGc4BiclVJ4P7mjCMSAI3lGpu4hbQNbxawECKYCSSe3OT/9bGmkB
 IkQ4ZXby9i3xcEZATSmon0ghpW/aAjI8HBcRSJ25vuTncRHlUbrYIulJdppja+DPt7cP
 ks8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEtxrj6FlNV8c3LWc1zxrLjt1+hu/6oKZI8HxKOmTZc3rjTRMMNM3lYselCIzgLQJlSYP6uB1r@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHgOT3OBZyOMshhkFu0wni+etvDLJ3quYSsfospQv64kPBWySg
 WokbpaqNnPm9xKkCVNPysrqzrY9Lj8o3PqsVH07DNDKZ5xx5RKWDPvcqe9BN2lnV3Uebnadq3ua
 Db2ZwjHCMKTmMP0iZoUfMobIfenvVzik=
X-Gm-Gg: ATEYQzxsq5u2RRxIfLSEvNdgDvy9o7mvbJQ1LanbGcXsJgy6XdIjHKwvNyhqC/PWR5n
 fZv6tOPq1dgUhYJ2UZZtilBytGajs6LSEe/aPYTjBqt0RKSFZdCDsB5YVNxE9W36J65J5GVOIsV
 rgYgWJOoABdB2me8yXbCdO5r4Ekm05O+08ltQEbDM6dX6uHmc0GmYSV9faNyUwvtHWGzHgRiMUd
 DC2vc9m4HIiFoh7Iu4JofkrQlX8gvb+In9QwQbyUaNtG9oZCeWN+OKzqzwah2X2rrPBeU+YfITt
 uoICItcTBbSlvMnad2ZShaso1WQqp9tyGz9C1CI3b6809srt8zt3xBU3MmkR9dbx/IpcLQuScSh
 WC7xoKAuz4lvBQ2O6XavjL9g=
X-Received: by 2002:a05:7300:f191:b0:2be:9886:d4ff with SMTP id
 5a478bee46e88-2c0e50fefe8mr982481eec.2.1773860246896; Wed, 18 Mar 2026
 11:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <abqdUBqchnVFo7Qk@google.com>
 <71b6a115-98f1-4b09-9c04-a99349f51e49@nvidia.com>
In-Reply-To: <71b6a115-98f1-4b09-9c04-a99349f51e49@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 19:57:14 +0100
X-Gm-Features: AaiRm52hIUr0vzgoavDmbzyJmg3hgU_AUfgRxMfUiR8zNc5S5daML4wMbNTdaCA
Message-ID: <CANiq72nZKx7pw_rZK2mHHvR=TaeGvMRvg5GTHOd58X17oyxieg@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Joel Fernandes <joelagnelf@nvidia.com>,
 =?UTF-8?Q?Alejandra_Gonz=C3=A1lez?= <blyxyas@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
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

On Wed, Mar 18, 2026 at 7:31=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> Anyway, the fix is simple, just need to do // SAFETY*: as Miguel suggests
> here, instead of // SAFETY:
> https://lore.kernel.org/all/CANiq72kEnDyUpnWMZmheJytjioeiJUK_C-yQJk77dPid=
89LExw@mail.gmail.com/

So, to clarify, I suggested it as a temporary thing we could do if we
want to use that "fake `unsafe` block in macro matcher" pattern more
and more.

i.e. if we plan to use the pattern more, then I am happy to ask
upstream if it would make sense for Clippy to recognize it (or perhaps
it is just a false negative instead of a false positive, given
`impl_device_context_deref`), so that we don't need a hacked safety
tag (Cc'ing Alejandra).

But if we could put it outside, then we wouldn't need any of that.
Unsafe macros support could help perhaps here, which I have had it in
our wishlist too (https://github.com/Rust-for-Linux/linux/issues/354),
but I guess the fake block could still be useful to make only certain
macro arms unsafe? (Perhaps Rust could allow `unsafe` just at the
start of each arm for that...).

Cheers,
Miguel
