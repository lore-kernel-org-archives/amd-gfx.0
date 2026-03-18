Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86475103E173
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 12:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018B410E7FB;
	Wed, 18 Mar 2026 12:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="M2DQgzVr";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E2110E090
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 10:59:34 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-439c56e822eso6961593f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 03:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773831573; cv=none;
 d=google.com; s=arc-20240605;
 b=l1FsDQ3GQ8kePkU9ZPQEUacmmI1Z6mM8NWDeqtX8EJ08Dx8OVo3LSbk9/lSqidE1Bz
 +Jb/O9Mj2yKBiBi1wGRtGA/xqSuP9pJR/NZ+o3JxbXA1PgVuDSA2FENQHLhM9/z/7tMy
 bbd34Q+UgJroaWQ8emssFnnDQRI6TdOkoIijFAVOxcsUxcn+KBmbInxbB4I/WhLW2s9Z
 F3uLScbHHsWzxWn5Aa6FdQrhaRC2u/ZqRKAJaIZ3/SuSVoIscb3RD89OWcC18kd95Jft
 UVe3NtvlTwUj5wJuu6LGsdM5kSmHkVcq77ET6IClZ1aPimeOzoiqdqBiVq22HyXDHpSz
 09rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S/1Satukh6eOX2Q2yp9irpav0rskLC7MIDb5UTQcoh4=;
 fh=j9EbqGU2DbQp0YkbjeXEvsxf/oGZF1ku1e4d8Dgtdnw=;
 b=d9APMfGUvM+2hSaG+tF1OLObUNuTmkUrA2cGb8kPxVcQLTcjhibukrsfURRfOoNN30
 HVPw1HdmMyBotI4fWSJF8ohozuC0/g4FUHDwNouidaTtsD38SJn86J3jWtSaJ/3c4S2t
 j7qVilU45kNddW9vRhr3SdTjgZRBFRrqdZlZUBoWVo58KptNC+XXlNQu7UHBuyaaanFU
 KJR4MYRlivzxzlWkfOkq5/x1tI+9KsHYzsnnSGQIAnrfUi9jG57xNhrwIn7A0vZ9jPAb
 RbPHk1/7DqgyNvxtiDR5Ih0AH7GnBqUDsxwvWjJ/gZ6AS17tCJzZJ6CjAP1I1As1M3iM
 2dNA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773831573; x=1774436373;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/1Satukh6eOX2Q2yp9irpav0rskLC7MIDb5UTQcoh4=;
 b=M2DQgzVr84yXEVMqD7m1rOy1PmrZSyfCJ6pUcIW1kXgVziu748Qx017IGOnlWeDiVj
 6zwtaSX9bHnbLh0cK39Vaza0wwoO0Ybxpcky0D7mqK4A1/QjxUVeEnURpP/HPnRDgd4h
 q1ow0Nkf+2DTbD9FvwzS/lOMk98M0o+P2O3/UZ/Qzjg1DQIHD6ea1xrZsbRE6IVg0vMV
 c11uH4eYuyqQIN6bei/j/4D2NoKWBpy/WlmDK5Yj89SX5u8HoObVIE8KbYvs2+dIU31a
 bZRes96np7tOlq+UhKk4jSQmkY48DeJvZIcvzFpv2idx/S7c0C9GK2iY/be7+Ht1dvUp
 YxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773831573; x=1774436373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S/1Satukh6eOX2Q2yp9irpav0rskLC7MIDb5UTQcoh4=;
 b=FLLa4bdDn6TB3bwcvre+9gNIidu3recCTMzfLhoeFEAeiGgEhKt0DgtGkxcbSBZTBf
 1VkdhUzJVHF5zwiJfjX/jRTMf7+Fp70oP0DRKJL9HsVDoeZwJ41dN7Cs1mszmir/ZqXg
 x4Hc88wATnEnNlj6/NEIdTorBcCTKXemgcEAYJbt4XAU+ams5yqdmswnVLk8ovEtzwda
 kcwAWSsAuirO3FcXf4L2Hm33eXFDVRu2oz2VG7IYEQzsQcg9WIbt7XELeNTEdVcvCQnM
 W3xp2u08fAmw7wYus2CMjOutUGX1XVXg85pO/vZ9bx6VrQY93fC2q0ZWYNXAW/V63qd1
 RycQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkpC2GQZJmA112IGBPvTU2BHiY5SkSxdeVeP2xDAJsGxAvokNQaGDrVysGKqOFCjVKZNASZmy+@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8m6R1OmtzyG1+H7VYsZBiDE37myzhNYBjSAO2SfRiljnSnv/+
 yC3mgFsymZw14qrhKV//PKotsRdd/yt2PZtKbOya6vMMU5qX4JYSsstkfv/4B2GwcunpQcTuGu+
 AzKJHuj/Au4afe/5ksBC661KQDXmMFDtWotFqMX0E
X-Gm-Gg: ATEYQzzMRhzs0Tkq8tWnMpEY3eTWq9nkJI4HclS9yzcb15n2c88pyRd6tuAZaSsrb35
 TKLF0XP1jrTR3NYb/jTECgSE6t/b0/RD/2NLEMZL7ycOn2sxaM6bNWBXaQV5AbIsofbUUCwuIAq
 fOjdYe8b1Oh+qRHu09DhAx7HigvIw16bCz1231cztXapiQwtDr+Q5IB19Sn5Kmyd2OSm/fH4+ZY
 MO0ZfnsjTl78qaz0RxcHsiVpqJKpzSUKl90bCwcUup7c036xx1IoTwlv9CfA03ANFLH6SMFTMeL
 zPc/aJ4KnqsNkl/efIRD8nprF/waqR3dsMjYgTtY6ZW6D3HYSTYsHgMRVsDwP0qcVQQTBw==
X-Received: by 2002:a05:6000:2dc6:b0:439:c62a:6dc2 with SMTP id
 ffacd0b85a97d-43b527c8385mr4835579f8f.41.1773831572498; Wed, 18 Mar 2026
 03:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
In-Reply-To: <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 18 Mar 2026 11:59:20 +0100
X-Gm-Features: AaiRm53Ixe1xgNfLSphN46y2ra7z4xTRu79njkh2iKHrEPi4sPbqBJ9Zi7PRuxY
Message-ID: <CAH5fLgjUMaC5v3SERZLosdD1ajU-fvKSgNq6OgbBBcoTS21-Sg@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Alexandre Courbot <acourbot@nvidia.com>
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
X-Mailman-Approved-At: Wed, 18 Mar 2026 12:46:48 +0000
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

On Wed, Mar 18, 2026 at 11:53=E2=80=AFAM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>
> On Wed Mar 18, 2026 at 5:59 PM JST, Alice Ryhl wrote:
> > On Tue, Mar 17, 2026 at 04:18:46PM -0400, Joel Fernandes wrote:
> >>
> >>
> >> On 3/17/2026 4:17 PM, Joel Fernandes wrote:
> >> > Add a new module `kernel::interop::list` for working with C's doubly
> >> > circular linked lists. Provide low-level iteration over list nodes.
> >> >
> >> > Typed iteration over actual items is provided with a `clist_create`
> >> > macro to assist in creation of the `CList` type.
> >> >
> >> > Cc: Nikola Djukic <ndjukic@nvidia.com>
> >> > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> >> > Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> >> > Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> >> > Acked-by: Gary Guo <gary@garyguo.net>
> >> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
> >> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >> > ---
> >> >  MAINTAINERS                 |   8 +
> >> >  rust/helpers/helpers.c      |   1 +
> >> >  rust/helpers/list.c         |  17 ++
> >> >  rust/kernel/interop.rs      |   9 +
> >> >  rust/kernel/interop/list.rs | 342 +++++++++++++++++++++++++++++++++=
+++
> >> >  rust/kernel/lib.rs          |   2 +
> >> >  6 files changed, 379 insertions(+)
> >> >  create mode 100644 rust/helpers/list.c
> >> >  create mode 100644 rust/kernel/interop.rs
> >> >  create mode 100644 rust/kernel/interop/list.rs
> >> >
> >> > diff --git a/MAINTAINERS b/MAINTAINERS
> >> > index 4bd6b538a51f..e847099efcc2 100644
> >> > --- a/MAINTAINERS
> >> > +++ b/MAINTAINERS
> >> > @@ -23251,6 +23251,14 @@ T:        git https://github.com/Rust-for-L=
inux/linux.git alloc-next
> >> >  F:        rust/kernel/alloc.rs
> >> >  F:        rust/kernel/alloc/
> >> >
> >> > +RUST [INTEROP]
> >> > +M:        Joel Fernandes <joelagnelf@nvidia.com>
> >> > +M:        Alexandre Courbot <acourbot@nvidia.com>
> >> > +L:        rust-for-linux@vger.kernel.org
> >> > +S:        Maintained
> >> > +T:        git https://github.com/Rust-for-Linux/linux.git interop-n=
ext
> >> > +F:        rust/kernel/interop/
> >>
> >> Sorry, I forgot to add an additional F: for the rust/kernel/interop.rs=
 file.
> >> Danilo/Miguel, do you mind adding this when applying?
> >
> > I think you should consider a mod.rs file to avoid this. It's tiny, and
> > just re-exports submodules, so I don't think the "mod.rs name in file
> > view" concern is that big, and IMO having files related to interop/
> > inside the directory is much better than having them outside.
>
> Ah, so there is a rationale for using a `mod.rs` file after all. What
> are the project-wide guidelines re: `foo.rs` vs `foo/mod.rs`?

I'm not sure we have discussed it in detail yet. Both are used in-tree.

Alice
