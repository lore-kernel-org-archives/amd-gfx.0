Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE2E107528E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 09:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB5410E0EB;
	Thu, 19 Mar 2026 09:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VRtVHlls";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADC310E263
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:42:00 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2bd5658b901so380881eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 07:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773844920; cv=none;
 d=google.com; s=arc-20240605;
 b=Z5L+yUK3I1bi9v0sN9UDgHHI6EjSTo/N22GCTNlPgzBgRJTXu0AwsZpPVvYxVMiMuE
 xyrXffqdR/Zren64D0rgs125zLICelcff7t/NnVDku9jeSi2tbCZYq5oSAbo3GQqj4tC
 eIYqGJrdX0DejVzqt122B85lrt43aNCDS0afb0FezxYF7yUHdKKgUXqIHh6QZD8mFBDs
 3BuKjItRiE6OQa5NTNWMHD5Q399QvvqtskJJeaTh+2mkpEkRy1pjfSF2Cu5rvnJcNKqi
 BS+Vzea3oCPXKPcGWNj3cA8J5FUm4nvhkMnpIfj5w7Zsqoj+YanAQROugUGBVmNWowQW
 xZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RTOE29KKEh2RCMQf09/Yf7/7d6oQT0Su+sy1NG6/ao4=;
 fh=Azw8mwer+hrNPCkCqcbT9pWEdftXwFgMKsrqS/f95SA=;
 b=D5Y98nmLUpoZ4cxVpGJeozPNR1+i/oqOyoibmJjQZkOfrwD7bAoxeANvtPrnf1KUQq
 z6xHwd/1czaksrVMUOyJcexeSHQnfK2bMKCAp46XpYwp0IumU/be3ZAEgqZK9Joi+63B
 NaYv6GNH4cTeU6l/0OiaPurhzRi3zd/YRmNoHs/2PCHjBuLWUTYykdJXSmXP3XMC6Jli
 +8J9onKdEbJ9yC/ZhFdVi1d4Ej7bFXFpRXffmAyW2FIWDHhTKvTR+nusVNHl9w6prCMq
 lSwuWCSXV6yOyTQhjk1PuqEUVBK6QRXX/77677dMSnN/YuPwalrExrfb6kY79/+2KniZ
 oMPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773844920; x=1774449720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTOE29KKEh2RCMQf09/Yf7/7d6oQT0Su+sy1NG6/ao4=;
 b=VRtVHllsYbUfS99x8ZJ5g4p32kEK+wtGik6SRcit90VBBH3EYlfQvrWNK/tzalFF1H
 8wZkA7EkU80PjeueroLcaAIw9QUWh0vkexlBYUyjfR8smumbcQbUg50DdmaGxRhpf1CN
 qmSE+vyb4lIRosAVGh/7tpW5LldPt5aSoI6zTzlzK2nMsVqoIj+/IbT8MbdxkaXcQTgk
 3qNAT1/I1MJyie16WYZrzWbXNgWmd2ksC636kT67MAXZpBaJaYMVQeXoyvqAcdzV+jBo
 emYB/hHO63xnRO7ZqfTZbwbhWeRgeIPbJQ157/IUZqB5lz/o/3g50Ou2B4IvpBx7vlfM
 50SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773844920; x=1774449720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RTOE29KKEh2RCMQf09/Yf7/7d6oQT0Su+sy1NG6/ao4=;
 b=TcBZ8us6+h2HB7J4xxKNpvQ65OaeROWs63VIRVMIbJckw/QWEZk0iK3ZxEaZjSP0mW
 VD8i/PGDcZU06zKSGUHOTGRUHCy7hetaHZP3DiHSimSect85L5gOFM639dqgbbzCGB+9
 EAYBz3Oz58xxVm7DhM1tc/3Xs71mNSh4b9EpX8QZr0C3/tly6ZvnEAsv3+qE1IvcV7Az
 oE5BSATiqT85pIfZHzztD6ABvnooYeP025gBWdhpbvqIm+dcQ1wa/w5AJv8I5zJ+ZHBr
 Xpj1sHqgBAS8JpTppXyAhKOmmd0YR0AmJ5lW6bI9e2QROd4MQhJEr/q1P8sE30kJkwVb
 FLEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWXegAHBZJ9q6c1tSaZyQ75DOptFxRfssi3FwtBmQllMWjDP8fCtAMVhMSExJFaLB20xZYp/V4@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6dDPJsFX7bCjAz+peleOS4XfuIEJJJwc4kKTADL0f4zjZ5vzK
 lzu+OAbBSsNfiudM2waP8ib8Re3Pnp6m0nqM4ZDgq5hcS86WhWWhtVLWQpU2g1Lu7iagR67wGEe
 H5GmfBQ8NxalaUvztgh901cxaLZ7KCus=
X-Gm-Gg: ATEYQzwinsvLjDORWw9ltj4U6yj8WlB8meU5yU/5hCXnYhM7kkWSOBOe0Ztf8BzzHWE
 omOF32E79oH8cEEgfO6u+P8qxwanNu0/XT8oR4YET0BYRK3HTQ6GAYXvf97gI5oBWc/MPkoJL1i
 UQVEUmczye4dGOXiSTHwcXYLOkaSjLeLrGJBFLO34mJaBKtf/6sN8NlFcFRwn4kfT6/GHUB3TAt
 4/nnpnqdCFiT2Dj0/GvwQByrc3MuY2N6HpVkrLv1JyRtzp1B2q9OKVC0NIYW+O9ZZgBUNjXJhwz
 ZyPLniXJWd/WKa6JVp0Dxsf+Wa1oyA3jdoyh8UCZMouI1zAb6y6i9Va/IzgmhA9L3W7F9Psdy2f
 v6jXXrotTxrmLMQL47r8gftg=
X-Received: by 2002:a05:7300:3724:b0:2be:1f56:ed32 with SMTP id
 5a478bee46e88-2c0e4f79e7amr877942eec.1.1773844919477; Wed, 18 Mar 2026
 07:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
 <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
 <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>
In-Reply-To: <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 15:41:44 +0100
X-Gm-Features: AaiRm52glbQ5k03i38HLvFJrknMe1XNNnKvvWBogM8moiNwsNZDgYGGN20TDKPc
Message-ID: <CANiq72nad-60tOJeAfkvHTFrWXQS_wbG4JUGQNnkjm_NvhhaYw@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Alice Ryhl <aliceryhl@google.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, 
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

On Wed, Mar 18, 2026 at 3:31=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> In principle this is possible using
>
> #[path =3D "pci/pci.rs"]
> pub mod pci;

No, I meant supported natively, i.e. without having to write an extra
file everywhere (which could perhaps be simpler as just a symlink
instead).

We could also generate the `mod.rs` on the fly, but that means a clean
tree isn't great for tooling etc.

Cheers,
Miguel
