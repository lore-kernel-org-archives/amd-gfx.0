Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BEB107528B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 09:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0515110E944;
	Thu, 19 Mar 2026 09:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="APFO8JnJ";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4205810E11C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:30:46 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-124713e4244so474902c88.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 07:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773844245; cv=none;
 d=google.com; s=arc-20240605;
 b=Fy4d+ixEcDVUj/7mYad/MFmU6V4jv7uncPfE8wqQ4rWTEllriKmsYIyJBpxFQQVrLp
 zmaIiX035B9cb5aIUPlpS9lSluoQWpulvwcbz8LUs5Dj0QxI4Ys6wLak6BCfkREiklwI
 O5jUhE1/+BOwK+wYNIddMvC3nQL7ZSZ67py5HVhdH9vmMj5MTOzb7GUBoHi15LDIW+yl
 w+muku5n9oqGk0epA5Z+aRqE/ZlyKUoUW3VcG6O71+wt2AEGJgEL3MHL0W++iGWWWVLC
 yRsdfQcnOdLFB4FzHsT5sSrw7etGhkLwyLzeXHpiS77kRrjYI6k9waZ4S8/R8vGqUP6H
 LY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Lz2XCxRPQhc2ZncmeIQiQRFj2Y2HhTtKvhZaZiMtVkM=;
 fh=tsZUM3bHvaOnx+IwC94EFMexIlu291znanSiZ9SphRs=;
 b=LTD3gufKHMngeXRP1TyZlbSP+VJDuHX1vtcSDzJmW796h5TCKdB8qzQFJFSaSsMltl
 v53zZnR3jpPWD7e2IH1smT9EnYScSEigPYxLZmPWKyStEyYW58bayKDWBzYPt90J2Cdh
 m+lODC5eA7YA/WBDDtftpMRwAQsldExhjOQtg4x1Xdlw4felMhUi6nVvuuHa+vvd9fBE
 GyqKPzpI5IvvI3tiwii38ain/Ektpef0ZNJYg3cYZXOd8tplLU46f6svK74pja5/0r/g
 XAEVEbAoy9k5A2Vcq4Vtxp3aG1DA6O7oghsaBeUxRe63PrMTfE8GIeG090Sngzgayqab
 D5VA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773844245; x=1774449045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lz2XCxRPQhc2ZncmeIQiQRFj2Y2HhTtKvhZaZiMtVkM=;
 b=APFO8JnJ1yOoESUujcgaa6jVuaKJ+IvM89d3gFOWGcbiaYfaF8HgHZ5zc6lRral7r3
 ux2M8j6RSBU0vZ24PNLPK15xLa+ASU6gnt5Op8mDHwASbjJEuDEvQylNbQz8yO/G7yw9
 DdKbVOiN8J3DWqQADX4jPbr/V25XaW/0jzMyeHfCLkPViNXj3thVDqhw0/WzU7R3m55R
 SHZ/rziRd90fvETjLOvH3outj3i1jSnekOBcz+ZjlwuwgEZ+x1CTXb9dVZ4rikrJDYPo
 EpOAWkx+JhMC61oj78qloUcNQ+bL+a4xRuEgJ9QTSFKz3nt2QlvH3RysOtepAOYQhDm7
 S4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773844245; x=1774449045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lz2XCxRPQhc2ZncmeIQiQRFj2Y2HhTtKvhZaZiMtVkM=;
 b=bvkLb1JJAMtRbJsbyPVQF0Yk1qUQyRuyVOkvRWZ3QcrBqb5Zwbhzos0eu1+Eyf5sBK
 gqddnWOoXVuPbWfS8G2CLSzqgte4JNqIHT3lRSRGtR17/e4w6Yy6vJesQ++9nxyss1xD
 agKkMGPAIcXqJiIrfOXKp0GFL/PTWVoi5xlneXznoHlbVpjLmt20A9j0LzYIv9u03sT2
 PSYadAyUs2PWNyfi+NwsjtoyD/FdXvW3ARkKOKkdiIU4GCyQSh/BcsOMOLeaiR+SIy/F
 wwJgwVO//6lyOCuLHOVY0+O05j9aiHHU1QtbBY/cDeQJqqXU/4KuWRmLdY3LeIywNlil
 h5BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXahNNEarnx7Ws+/cUuOzfiH9mFdnz36MlM1tRVWO/VJdyItWv79vDUxse0p+W6L4wQkcosVjOa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuxIthLJIQ6K49BIbrhvEOkK+Q847GQTnIMAZSSacDjgjt9K9O
 azVIE7dmwqv7r3Ln6c+hcDZ3o1M3303Tn+IS0HFgOCtLsrS6EFqt3TM0I3SDHcFUSPj0VpYeYuM
 5vJcnn8/4qOrL/8b9yBnUr9JE9qXqdxE=
X-Gm-Gg: ATEYQzy9/6i1aqk8IXgKtMp9hy7euV4UMVbsHfjg6HfuNr3uD5XdZ11GTVNLF5JcoX7
 N75gEIepekZP3qrJ6A/NJdYuGQPpjgbzKVb17h2EvZmvndcDulGClIJzcvEgbyn+qjZ44hlvUPM
 F2uO1JFvDg2y4a9ZuJaXis9ojCrS+SNz647lRpGteZEiyen4+k6xG7YzHgzLj4XnaSM3cWmazEQ
 dFBmn+cBQNjblb6YViiXnL4KVFJ6+nEruQInFq2FwvCCuOJIGsZIzgngr7XzdR+8EWXBzfE/lM0
 RD4r3BbmF/LsO1AspoCCqrk7Yz/X+JLb/p2ge0U162djlwfRFanEF+KvHXoaC4pkCbnGqs9646E
 7y0s71oM2
X-Received: by 2002:a05:7301:1e96:b0:2bd:fa8f:77f4 with SMTP id
 5a478bee46e88-2c0e518610dmr846274eec.4.1773844245396; Wed, 18 Mar 2026
 07:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
 <CAH5fLgjUMaC5v3SERZLosdD1ajU-fvKSgNq6OgbBBcoTS21-Sg@mail.gmail.com>
In-Reply-To: <CAH5fLgjUMaC5v3SERZLosdD1ajU-fvKSgNq6OgbBBcoTS21-Sg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 15:30:32 +0100
X-Gm-Features: AaiRm50bVmwgAQrBl1Sd2LWxaRmG-ZY7uRxgxq5LrbNAlb0we3rijRktUCTLM4o
Message-ID: <CANiq72=GGicUCODkY3C8U53wQfsuRYeu9GiwrM5eFhkP99kiHw@mail.gmail.com>
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

On Wed, Mar 18, 2026 at 11:59=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> I'm not sure we have discussed it in detail yet. Both are used in-tree.

Yeah, we have discussed this several times in the list and in meetings
-- please see by other reply.

The handful existing ones I think were all created by Lina (so perhaps
some were kept as-is to avoid extra modifications of the patch -- not
sure) or by you (so those don't count ;)

Cheers,
Miguel
