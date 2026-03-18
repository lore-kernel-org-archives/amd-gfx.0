Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E54E107528A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 09:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B069610E93F;
	Thu, 19 Mar 2026 09:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L0DTtRSj";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F5410E731
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 18:57:23 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-128d428ba0cso29510c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 11:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773860243; cv=none;
 d=google.com; s=arc-20240605;
 b=k10ZEuR69izhN22vizenqiZORMzGH8TxA9Qn/dJCfHL6ZwUvHT9LNIgGdBVezL+/Gu
 WSLvxL6753Q4pS50cjIMFjYW7HUki3W/LyDVI1CWwg0+ynEcznHp/p9lebBys8+/O+5T
 neLmeHawP2ZRt23BZtD2RwqzOYT7ttfmZjMMSIUQ42Z910h3RS5P4jhffRkA+yZ5rcv8
 FY0FB0b7KbNBjKbUhda79+0DkVuKF4l39n8MW5aWsyMAjT2P7QjPxueP9AWCucl2wBnD
 +LMv5Qb1FCN9F4Cd1luDnxn9aUOPuYtrsmEyVlOP689aH4X9kXwrJMcnxkuhiyXU7Z7T
 bQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VupaCI1OwER3l7ohvi40E+Y56v6gbAu+x5/VVVtmeFc=;
 fh=9yaFfMF5xzFhF8/OUjHGx0cckWf41Y3uwcf8EZDTj94=;
 b=akxldomtec6OsRUQzby1+e0aTMlzx/KvtgWQAhx+OIxM3Pn1p3bFM61M5YQAAS+sNg
 D4jqgVXaUcwPkRNVbdAlnZbDooGQ+OLaRuz3k2IvrexrPEU3UwzlulrZzqmgIPbEU7V3
 i1f9ZkTWdxeQ9OfS7zu/sBPgU2d/wUrpKXRTTrP4i9c0K6lQgdaVO2CWpdUpyL25dIAg
 PJJ/R+vt0BgmMyUGT8Kk4mb+OFdOEBkhV1sQ/59TU/Zt9LI+lcv3MZPASySOSEQHcgHS
 CaCn8H8TS3VA+qIK6RRy1EGJcgQCf0ikGVP48CLP+n6mg+mwFuyxAeXt8v6Ss+SyKGYS
 +K3A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773860243; x=1774465043; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VupaCI1OwER3l7ohvi40E+Y56v6gbAu+x5/VVVtmeFc=;
 b=L0DTtRSjD3P3foLZzcumBUqXBNdSjOrQZwtECp9tPcgS0q9LqHnvJaH7dj94Sxq/sr
 PUtC+N5h1uLnGRTOxod6NNqMaqXGx48v8gHJ2IQVnb8CjT9EBQ+KRLYMnqvtqn34seen
 V3g9URV6HjGebB3Tenn4M5DkDPl8vZDMYL4/1urXKbasaSZFknDwmg17N8CaIrosgceb
 +ZST64CeDqVD1cHP3sXqLhyS3XTCHF7iM7ihUMzKaostxn2QgSAQymx72ePvSrRaH77p
 UpGQrWPmWVLBKoGU2Zl5A8Bj9RwsUcOlWNLcrjVzHIrs/lKK/3JIh6PuVUmnX9SCaiEX
 sduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773860243; x=1774465043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VupaCI1OwER3l7ohvi40E+Y56v6gbAu+x5/VVVtmeFc=;
 b=Ev5BZALRnnvc7ap5xxGAYBjjW0MM0vxrm9XQr3vQYNLfQyvtF7tHDuadZvwFTV6Nj7
 4eyG/OagWY4z+uRuvcUXhDXsamc13ELRnEjW1d+zWNhgXYfGUQJHsx/Tslfl4f+CjE6c
 rUjCMQK1reXRGxioSc+cDHnGFd4EvZ+QJPgcauJgzmrWN0DrkOr6XPkS5r0/uawGjyHE
 KK2bxndSLpKWAsPAmLI9L7CKXH5XYW0b2GyUdInsJEmY+U4dUVMdreQND9yAkRAZBu1P
 xm5X8bUtTBVe3oYMO09MRRF8vaQa2T9Vf0RrrZav7/8l8Ao2U7ivrL6uUtfN+6VxKdA2
 AbVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWn773Xoe7girR2xRqcIkLpX7/p9xUSlx+ZsGkBlPzA70B/aC8x8+L7ajoveJ2XST5x/Vj+XTK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzH4TnVAARV/B6xRGGJ3mgqysQ3e+0pXt7VRwSRUbEL69QxkkBE
 WzFhSV+PE+PM2g7gUZGSS/gWZg3QhMqFn3mOVW0UsmGjO3HOSq7dcHF2SUzq48lj6oPi/JOKVek
 PD+PmFIy3wjOgVSa3uaoxXl2VUSU7+Sw=
X-Gm-Gg: ATEYQzwHMdgV489Jt1oowMr9lmnhRpZYumk9LZqGutzzgxqtlinpB29E9Qclvu+64Ln
 LOttDHH4jBovDIN5W3u/0agRKzF0OEkoX8ThYnJ+lFR3G+zQrUHlhPULiEEjRpp0g3XhurWJzHJ
 uaGquNOGXHa53VCNBwTBL0xhTmm+8odoRYSpu4r/cjDjf2bWa87S15vAyrn2Rk+e8xN8dClvKPp
 aUTeF5tEO0MQEbMB8NpTq+BCNW2zus04++tvo/eqO+2o7txZOVOYHiNoMCt0jsUZrPN4ZYexqff
 nPBkIFpAxXnnRMx30326uY/Vz7jd5jTVHm+whT1bIiURHxo9R7uV8i67pZR1VqXVQDZDLRGU5DH
 guvHkRU3puSvhVL7Lco51rqQzPWyHXFqzXg==
X-Received: by 2002:a05:7301:658a:b0:2bd:a3fa:9bdc with SMTP id
 5a478bee46e88-2c0e51afa4fmr1076751eec.5.1773860242532; Wed, 18 Mar 2026
 11:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
 <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
 <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>
 <CANiq72nad-60tOJeAfkvHTFrWXQS_wbG4JUGQNnkjm_NvhhaYw@mail.gmail.com>
 <DH5ZP3IUEWMD.TOOZSEUTLV85@kernel.org>
In-Reply-To: <DH5ZP3IUEWMD.TOOZSEUTLV85@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 19:57:08 +0100
X-Gm-Features: AaiRm53Z-cAG5mIpOPhPdv8BAXPHEZ1FbMlHxMtUEupEIZpM9NVL3ZvZ5w4-nno
Message-ID: <CANiq72ndoX123PKYr4DbJpvQaM=1YjYoYhoTq7wMoY51X7PuNw@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>, 
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

On Wed, Mar 18, 2026 at 3:49=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> What do you mean with extra file?

Right, sorry -- I was probably overfocused on the `mod.rs` symlink for
some reason. We may have talked about generating them on the fly in
the past too, I don't recall anymore.

Let's assume "s/an extra file/extra lines" on my message... If folks
are OK writing manually them, or that we generate them on the fly,
then I am happy I can get the option I always liked! :P

We can chat about it in one of the calls.

Cheers,
Miguel
