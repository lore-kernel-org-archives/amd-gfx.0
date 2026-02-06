Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30E5ECD9B7
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 01:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 284B210E21E;
	Fri,  6 Feb 2026 01:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="axMNipv9";
	dkim-atps=neutral
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4978310E218
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 01:07:25 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-8948273f5d0so23195286d6.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 17:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770340044; cv=none;
 d=google.com; s=arc-20240605;
 b=Vu19pBfaflFe5y9HKinB7J0bAbaJWBS0hGmvzO3oNyrSFNQdj1G2waxStIDk62nWRW
 kIsuQxc87sGUfotOkXdxNUEej+j1632gQ4sNp2se1sA1DJO68VZyjNJOjhNWIJ3rI3sv
 o3XXIoR2uq9sEp0zEkkjAXtH6c4Z5zx5Z8fric106+lORC5a8hLS4mKOLfp+Xnb7K1ri
 JdiNA4/WyGFqqxxbcKAUUc1aSuKwS4IuWlCjNgGY8+thbLJr3HrIn7cjYWWqymlmDTqN
 QksYL9HfUTIMgz7yf5jEYyRRztfNs0Mc9aevFK9Lt/8wVb3tdBQ4/2x8w2dOzeSTbbdP
 H88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wDWVWFCQyt41m36By+1mg9Tz8HGxZTNBLIvQ/XOM2S4=;
 fh=cmotXr8VySNNh9wT4GyPW4DqDMmlg4bQmpGhhWOpqAQ=;
 b=TVuo/Rpt1grM4sCX0oKmr3woR4wPVZJxOZoU7zF9IRm3yhPgAdSY/o0VvFn4Xv+RyB
 JhcsATJq2eCgtFi2wYJ1KpHtSgE4TuSiQGMXLbKacsgRUsc03LxHbq8bYhSSEJP8rHIa
 kRZS8XTVvSug/26eKdGr8rL5Rw6gX4fhP30R+4RwYcWkWOkW9GRkyASnznf5+cr97nqp
 7TddN5Fn7qzttV0yQHl7Skre1CCfEnLcMhlWWr1Lmi5EEhmCX6f91o/N7nBoOfSJg5q+
 Lo6B72K/QVP9JHCBkr2GMqfJQ5v/YBkYwaKPtH/WT8Ut4KzPJxLFvyso9b+oqsdATSin
 rxBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770340044; x=1770944844; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wDWVWFCQyt41m36By+1mg9Tz8HGxZTNBLIvQ/XOM2S4=;
 b=axMNipv9rCDoUnNKM22DGe0DqtfDa83qsjEcdokLVq5/zC/acXS2L1e8iL6zs2QsUr
 OwtvKrLTjw1nPqsIVRh+01IwLqcB0crmhg2X8hj3erorBR4JTraNWSP9kPG9rb38HNsS
 bmhqt0dOmQ7aIpLzXey0UuPwxy6PRlGBwTEZMZp8wsrLgFPE97LxOnbXrHRMhQfkIT01
 pmJ48CFbKrxH3bWw1KihhKMlKJkctJgJ1BqJGTmBcA48E7O9cbmCtRsaQRKzVwPEdI03
 mQRMqe4HDSDgGXtINaXq+fL44ITjOEuT5BoL7jJm9jWRCTGXvqS5HjUYBLlay7quYIRT
 hNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770340044; x=1770944844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDWVWFCQyt41m36By+1mg9Tz8HGxZTNBLIvQ/XOM2S4=;
 b=kUenbkF9vQMczJ/miJdwBzRM1rfA3U4y7d2YjwJjasEs3DD+uZS2XkxpaGwLs/ITaq
 fvPm+dGm96hD3+Jn4LFqCb65x2upAsihOQweq2wlJl/+btL3Pkh4L95HKpDRneDDO8Rm
 JjsMHQunkb+J9em8u/J7GXPv40TWRHltsUdjFIuAFB9ej3zJRX0ydi2W+drr1B2tLmu3
 bPvPpKeuhENS1onJrV0Gb4/0Vgsf9omcvK1smbRnUq88yhSFSdYwjku4cb5EeM7EVe9S
 8NA/CD83c/2OfNemxgpVzbcj31/6w67vkMvdH+tC1cSdMPpoyDMYFLcB+NqMYozAaLYA
 48nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuSeAuzFHVgJ9R4CsWEbfZ/JmztS/9YMcsrH7/94vIzUurzcUZFKndybutT0vPLd0aBqsdp+GP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxFeUBqw7D4KOHj3kOwjhGEY1NaZJfS1acys1xwrCLnhuO5c3l
 Z0KPQ9u6ludS4LyXBbiFT6QXqXcFQfqlcE7IWad0EVsIonsgA2bYkcpKz9Ig+Qy+biGEbGLXm+A
 2I4hr++xZjB33Tl1+EpLQehlf9nLQuHA=
X-Gm-Gg: AZuq6aIPnaa0V5CQsH9le1O4wYsqHBjWUMzqFJUv/59w9O5XMCzJwJ/7eq/4yv9ES0A
 BVzGyzewwgawRVz7J7/vJZ+4U6lnU3FZlX7EVNNftEb4vddwcWTixwyr9cRo+LM0QJZRF1q7wAQ
 112fcnjZ/Ojpa+DHPJSuz6ONYbMsIpwFLLGlZYwzwkOUVBepJS9R1Yr/0zI+qimN7+y6t7Rfxlb
 FtdQ1DXzKVLdohVl8Y3qaHiUGEDwVnRdzqRHjY25M1OfOs8NgKQq45MoEGK331OwqHJSAd2zcBe
 0riexOqM5+P0J9Hx9XR5LKiLBRqd4g/PGUzgyA2eSgpGTEyNHFAZWlI=
X-Received: by 2002:a05:6214:c29:b0:88a:44c8:fe30 with SMTP id
 6a1803df08f44-8953000350fmr75404466d6.10.1770340043910; Thu, 05 Feb 2026
 17:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20260120204303.3229303-1-joelagnelf@nvidia.com>
 <20260120204303.3229303-3-joelagnelf@nvidia.com>
 <CAPM=9tz5iXoFQ3+4hPFW+tZCL2zWe0WJ07-oFkP8TNVL_J_SSg@mail.gmail.com>
 <44542f0b-be3d-4e82-aacf-0bf19ab69954@nvidia.com>
In-Reply-To: <44542f0b-be3d-4e82-aacf-0bf19ab69954@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 6 Feb 2026 11:07:12 +1000
X-Gm-Features: AZwV_QjEIAozPEFJ7NdCW81HEOLtXZUhxCZzFmSJOZbp-SMcdPX-QLYah3tkGzE
Message-ID: <CAPM=9tzafj_-L+ia8q=tL5DBWZU9PdSq9vaCAD7ituoMR+CaQg@mail.gmail.com>
Subject: Re: [PATCH RFC v6 02/26] gpu: Move DRM buddy allocator one level up
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Helge Deller <deller@gmx.de>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>, 
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Alexey Ivanov <alexeyi@nvidia.com>, 
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
 Elle Rhumsaa <elle@weathered-steel.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 joel@joelfernandes.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
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

On Fri, 6 Feb 2026 at 11:04, Joel Fernandes <joelagnelf@nvidia.com> wrote:
>
>
>
> On 2/5/2026 3:55 PM, Dave Airlie wrote:
> > On Wed, 21 Jan 2026 at 06:44, Joel Fernandes <joelagnelf@nvidia.com> wrote:
> >>
> >> Move the DRM buddy allocator one level up so that it can be used by GPU
> >> drivers (example, nova-core) that have usecases other than DRM (such as
> >> VFIO vGPU support). Modify the API, structures and Kconfigs to use
> >> "gpu_buddy" terminology. Adapt the drivers and tests to use the new API.
> >>
> >> The commit cannot be split due to bisectability, however no functional
> >> change is intended. Verified by running K-UNIT tests and build tested
> >> various configurations.
> >>
> >> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >
> > I suggested this and think it's a good idea.
> >
> > Reviewed-by: Dave Airlie <airlied@redhat.com>
> Thanks, Dave!

I'm going to apply this to drm-misc-next today but I'll move some of it around.

Dave.
