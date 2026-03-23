Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9604CEC01A0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 08:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFA110E40C;
	Mon, 23 Mar 2026 08:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kEXvo3on";
	dkim-atps=neutral
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D4510E17F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 00:08:20 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-79628fb5c05so26853557b3.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Mar 2026 17:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774224499; cv=none;
 d=google.com; s=arc-20240605;
 b=BsrkxajfTUlnAbESkr77t+ti7cmg3XwCSljsjE3gsv5oIDjGgXTBD0L1MrrZYvDJvA
 qbKsMJx2KGM0/zNAvsZDZQK0MWJj8okTcApGCj0YhPW4IIqVCxKGd85u1ABE3ahRVt9R
 lq7IGF2c+mh+zMHp6sow8DIFmM1wikab6AiuDwcAFnSv6wTiFENT2aqbSuooK7ci1hsl
 kgyyV5bw515HQTvSs904Sr/pwduQ0dBeqr5lY1OgJihVoeOWrJkVPsqTBOMLnsZ/SI/4
 qeFrkaSL4EIGM8wQes4FNqhSpEjJ4CxE6sqvagIxlObP2MZJFGI5l0fAf4ZW77by6iv5
 lciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+To22M9XrloAsp8zyktj8aS2Z2Pum4SQehyzZWues4c=;
 fh=1dw1goSDTbxOp7fcIHZbffLLJQFqcgTrSu45NrrdFlM=;
 b=kGRcbgxGkQNXeVv6VXUTNsgazdRQCdWgOFBrNTpOZZO0GVyki857g9JLiwU/xpJQGx
 kF8KuxOjqQoeq1Hue43YsEkKtJCpWqukhcFgTF/7k4EE3hMzcH5d8/EFANlRjQfnDS/w
 3xFOO2T0Q2OTcUCdvVUQIlu1tjR3jThIqQKwnACuSxsWg6gM2uu8/CPPTqADwAV2gRuz
 203oaH45oMixUwmTUPmhMDgjx62m6yQk0EACFJQ7AGsjmrewnoePnoscHQUQf2A+WSQK
 3ogyU3keAyFT9lFkRLa/MrapHDK9e193jz7qqqimBRUROX7faVQmNphPg4rK35Wyemtr
 uECQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774224499; x=1774829299; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+To22M9XrloAsp8zyktj8aS2Z2Pum4SQehyzZWues4c=;
 b=kEXvo3onKDbCYpEcl0SNVj2ns8u+u0QKaeCMtHhJEWK4Qs1BcB3Efu+6t10YZH1hkw
 vLYIWXJSw0z9DtUIP8sh+u3A1mjTUmZKLjJba9RljRCB/yMoZiBm2ZPmO7ITJHN6+W/O
 ocQhy67noDzAjBdt5X2trx1eYJpj/P/9iYwBC8fIkaRVIpBfXOGoH+ZIwDSnMCy141aC
 6ZbhPLo32QrFsVvcZt6BYQ7s22TBvcpap2AH2eEVTcApnLnHpwpumm1KRfN5PPiBMH1m
 SkFCQSUloorUvOuyNIXfOh3sXVDSSS+Ijgo/pv8sRC7YK0Wbswfi6x4sZu0C2EOGv4wy
 S/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774224499; x=1774829299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+To22M9XrloAsp8zyktj8aS2Z2Pum4SQehyzZWues4c=;
 b=nBsYEDj52i2/SFk0zX7uLMTGzuGGvLnt2uLOrzHZhKbFpYTFCiuDjET5XyeRaj97Xu
 bVBLYbJ7KX/BTNovllbMGOWvMisA68Pgz70OhikS6t22QDlgtoy5d0iVw8f9zO/oPPl5
 aQ+XUN4eRvWnXCS7sxvm9I4KiDXU9hoITsw0oF57kzDPRlRLW2JJAlHOuzL1RPiryHaI
 hBJvwsO1BTGs1/p/fcD2sx2RQFPXAjCmg9YUFgtkwfRvimglHvZ7TwrIt5MGKG6Crzfr
 X9xwVJ3QKNyc2eu0dtB4mwCD1QNO1qL7oSCJwplNnUehWlBPHz+mMs8VfvpRhPu7SUtm
 hDRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIpM+P3n9qUzvmldHs9koZ93lQfAz0RLJszSSLr27qdlUob99fF4Yj7qVB+TZN9jhmRd8fe4A9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEeyvMVa+BYIsFyzk8gWWlgEA8f43beq7wf5TEhaTy1uATIt73
 XEOReUYSRyPkiyb71R8oMcV/hJc9nHRfAVjpnLqV95b5zS/LEghnxzQQhG6D1l0K5ylzbsEO5Y+
 DibbdCR+x8nEk5A6Xh9qhKRuKYtZqQh8=
X-Gm-Gg: ATEYQzxBlAKlBaQVevazU0m5fBp8XGNFZi7i64nV/XrsV2vw6AK7dwekXCQCIR2WTCn
 ovlI+Iamq7MAc25+aaVEIBag6ZTvnJSlin5KnuMkbEzp3ZebmsziVtVRiRoalQos4/hW7c44gQB
 0lFnIfhBVhB5X95+o55qM6EFK2YSAZRbpy7kEfyv6X90OiWYOxTvjfYuayJOgNGwWW1oAPodzO9
 49ImjtAqZB0x/luYsfvsrnHu7lkaY7Ku6ujpCX7GuGN6v2XW1EDv0cMvOmE8AcFBmtd9PemjsGw
 e78cb9eLjDzzqZ6xDhoFeODBn9C7f0I02ZhSdjTTy7frTIvA
X-Received: by 2002:a05:690c:4424:b0:798:6f13:2419 with SMTP id
 00721157ae682-79a90bce798mr96296727b3.37.1774224499042; Sun, 22 Mar 2026
 17:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <abqdUBqchnVFo7Qk@google.com>
 <71b6a115-98f1-4b09-9c04-a99349f51e49@nvidia.com>
 <CANiq72nZKx7pw_rZK2mHHvR=TaeGvMRvg5GTHOd58X17oyxieg@mail.gmail.com>
In-Reply-To: <CANiq72nZKx7pw_rZK2mHHvR=TaeGvMRvg5GTHOd58X17oyxieg@mail.gmail.com>
From: =?UTF-8?Q?Alejandra_Gonz=C3=A1lez?= <blyxyas@gmail.com>
Date: Mon, 23 Mar 2026 01:07:43 +0100
X-Gm-Features: AQROBzBsI6copsViR8GCb5s4kn_1rinKOMbl-9Inr9UPp4mS88b9cJGUv5vqwNA
Message-ID: <CAGeanHfNwP6Zs3LSfc9eEO7_LG0kK-jO24oUd7BjxrQbndEmNw@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
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
X-Mailman-Approved-At: Mon, 23 Mar 2026 08:11:39 +0000
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

On Wed, Mar 18, 2026 at 7:57=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Mar 18, 2026 at 7:31=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia=
.com> wrote:
> >
> > Anyway, the fix is simple, just need to do // SAFETY*: as Miguel sugges=
ts
> > here, instead of // SAFETY:
> > https://lore.kernel.org/all/CANiq72kEnDyUpnWMZmheJytjioeiJUK_C-yQJk77dP=
id89LExw@mail.gmail.com/
>
> So, to clarify, I suggested it as a temporary thing we could do if we
> want to use that "fake `unsafe` block in macro matcher" pattern more
> and more.
>
> i.e. if we plan to use the pattern more, then I am happy to ask
> upstream if it would make sense for Clippy to recognize it (or perhaps
> it is just a false negative instead of a false positive, given
> `impl_device_context_deref`), so that we don't need a hacked safety
> tag (Cc'ing Alejandra).

The team is a bit hesitant on adding comment-specific syntax apart
from the widely used (and already on clippy) `// SAFETY` comments.

I'm pushing for some more comments specific to the Rust4Linux project,
because we already tailor some lints for specific projects (such as the
Safety Critical Rust Consortium), but adding more than new types of
comments is a bit much.

On this specific lint emission, I'll see if I can get it fixed,
because it's a false
positive.

Cheers,
Alejandra.
