Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8356107528B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 09:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F8810E93E;
	Thu, 19 Mar 2026 09:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SP3day0O";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A51810E06C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:03:59 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so375509c88.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 07:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773842639; cv=none;
 d=google.com; s=arc-20240605;
 b=SlTfGVH2ePfvyQqTI9z9w/4zad0pTNe6rCvOf3uQd8+gLR9Z4w6Yl3UyuSUkt5iUtR
 2QYREwIsGEAanGoiufTtdLRhT/wIioo92NPFGL91xpq+HSaDhRFv/11DGRWQriq9c+lu
 Iw/YgZZkomIji2tS1t/Ni00SfmDNwI4twoxhamlOP3RN6dmT07axl01/TIzwko2OKvn9
 j1zOU5sP1EnQCtW0FcYgKlBwM1U0nflwrEth4kOY7JB7SzsHCQHTE6Ts+mrrFrlc3EDO
 24EqVWKNBQlha0SSTceR0hIPq6s7+T4ykqMOm1aSEQGYhx7oHvmxOmL70DgAiKGdwVhH
 NmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k/U8OvDUcJJhqeuFuNoQEHJ2yWsVYBLtuE+GiuKyXfU=;
 fh=7MQ3oiETcvNXTu5PQtMJjWPd+a4YBoMARpMxLxgDdbI=;
 b=iSy7HvutW898U+L+OQd8eZblEuM+muZJd0Nrhe4fDgb8AZh/klvFd8522LrtwsRykl
 gEgli5T0sJCNomQRuNoEpXtvuXfxeVKLqxkE+R1cpJf0XLNCY3X1HgAEAVsb+wJH1rdE
 aYK8QFMEjhSHxVVDS+Lp3ALRm01i4RlyCDT1BEHAfV17Ix1uKcYTZs/DSnLab1Lnl9bD
 5D3R39A9SmRuz3p15Io9RWKM9uRu1A6KhWxUjuVWz+DkRoosyF1VbwlRQ/efH6OGLV5N
 jGbEAF6/QgKni9qvH/6q+94zirlEXrGdQwtzgZD7mFTk/3ANt+rJeZGE0oeSlvLeBuSn
 /TAQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773842639; x=1774447439; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/U8OvDUcJJhqeuFuNoQEHJ2yWsVYBLtuE+GiuKyXfU=;
 b=SP3day0Oj1/DjmRsdSyPMUjcp7kcdrq1r2LXRBcppvHqjaVbg2DfE3Tt2aO9sP+SCL
 FlumoOqH/KiCk+ke+0A+w6l4K+3rQA929h8DWAlc98BtNpAYgAM5ST6OUNaoZMfq3apA
 trVFMVqhsG6ESM3trF/LoKrJ1/QvbpZqLyM6iG6yLu4oSWMJnwadH7ovP3j6n7oDDf49
 YDFX1qOuZNNu8rCyHXzZ7857+F1qSq6KrjnCp9mHCnXNjnLWMoK7WT2TN1eg9UpToaiK
 iZosSFEBYX/VOD5d0F++HRFKCfCqz8wGlL8opS1K+hQsXqLQ9HvqwlLUV5JfyihExxX5
 IEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773842639; x=1774447439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k/U8OvDUcJJhqeuFuNoQEHJ2yWsVYBLtuE+GiuKyXfU=;
 b=KtQfRjLe1+eLv5SUzbmI4phlLZRcS5c13X7n5PrbcQ0XPWLyXLxHLRvadIx88FeX6T
 +IyfFee2pphAwyAZOU0oCXlPPRBSkaYnidHb+soBQz7exDe1S11O0wplqdhe6ImZwAFc
 8xhD6Aj3bUGoXgpcxSAxONYCyHwfPytswUEiAPM35D9YMH3EsU/lfLPu85uVPdv057ci
 FkLp4W8NGoeZ+o5D224FkSGp0GHQLHntvTI13vp4xiA7tCJu61LOxR8IFngE/5IP0CUg
 W9xRe1HVpbed5eLoBS9wHX/D0QKr4urXm8w5LqY7F/Iuk9eFNMsN1ow3CXgjOa51QaTp
 D8yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTI9xdBHnXH4cIvWQl6+u/cNtOE9zN80p1VuZYXoINw1TN53u0EAkLfqiigxdms7DV0NBBnia/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznHcVIjXYlNJna2TYBKxy1v4yGkkrPkjXMBCL3yERD1xVBoQVu
 rX5AwULm7F1Anc2H5VdQbnhqeSqjXAmZBugU6pfomuIiYAawK8hWHBiAfI6MiL4N3qOsn4snHc0
 +L5PjQBzeLpbJavqVYvbgm79B5d5eD0g=
X-Gm-Gg: ATEYQzx+s9FTK0ijih9PPm6IEmzD3xudLV7LFosPTcZ02XCYXZa9wSfNB/ftW4U6y4n
 HmOXMwcMkRLOZBFHyaOhfYTnJ/cDb1zgvGkJGtfJU8DuHXNADSdYT70UeNUtDreJPtx83zQ0Ibj
 A3rh2QbtUcQe34tEcC+dLiIqAUpHolHfxPQiGMSH1AMLczw0dqVq9CBAc9tZhcQi48Two3HKWFY
 Hp0m0QncW15y0FTIG16P6ITNDZpVuIN4hieAmqBDjV5eCpY4XsIw8ru4QqkdVRQGrPjOKkQdEt2
 Y5U2Do2RNBuqXDwTGsYxF1wE446RU5GXHqYDD4duv7saWXgPgQYrk5qbGQAVqeKntJZjiOwOoPb
 IHwPyz+JuztwlD/QQ2pt1KTg=
X-Received: by 2002:a05:7301:1e92:b0:2bd:d8e6:90a0 with SMTP id
 5a478bee46e88-2c0e5071063mr859030eec.3.1773842638629; Wed, 18 Mar 2026
 07:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <abqdUBqchnVFo7Qk@google.com>
In-Reply-To: <abqdUBqchnVFo7Qk@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 15:03:46 +0100
X-Gm-Features: AaiRm52jPRFXXf03k9diVYR0ZGnNxGkoAlPwk0mwDAEpyLjxWwYifunzB4OTgFU
Message-ID: <CANiq72koBNCeXFh7uX5GHRJoAu7fyhttDHHN0WZzx9Q74F=mWg@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Alice Ryhl <aliceryhl@google.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
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

On Wed, Mar 18, 2026 at 1:40=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> My build triggers this warning:

I reported that in the previous version -- Joel, you said you used the
workaround I mentioned, but I don't see it here.

Did you decide otherwise and retested and you couldn't reproduce it?

It is fine either way -- I am asking because if we decide to keep and
use that "fake `unsafe` block" pattern, then I should create the issue
to ask Clippy to support it.

Thanks!

Cheers,
Miguel
