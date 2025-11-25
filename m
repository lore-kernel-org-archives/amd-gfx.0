Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C7ACFD379
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 09:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B2C10E38B;
	Tue, 25 Nov 2025 09:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UeA2lhDr";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D332010E38E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 09:08:50 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8b144ec3aa8so522108985a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 01:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764061730; x=1764666530; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCdO90en+FjhKk4ix5gedxAx+9JnP8FYLniKGNGpn2c=;
 b=UeA2lhDrvdiWVxKTAVOJxc+OC5kTBc4YDbg2MMgnZRTrMM9gOP4PEA/Zcu6xSDcN0O
 UQL4ah1CObf7Q9kEOhSCLMaE4Tqvij7tgTWEudttAbomJJOw1v21uCkGuV38LtPbI8ST
 hkBzo/XRftkWyw2nXGvAcImv+BGSEytirKK2h8W1LFtiSZcmZocjo/1doszKUiDtzoE9
 nKP5Msgc/Pm5Po8JY8FZuIFhvEw24YDSCaUx+jL+bvPGaFAMIFtw5NKJl5LofnLW25lZ
 FThWdc7bZHsqA4/DyvBIso1Z3MuUEu88macghUACMWWPOjbEY8banKYtJsKh2j6W8kSf
 X4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764061730; x=1764666530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jCdO90en+FjhKk4ix5gedxAx+9JnP8FYLniKGNGpn2c=;
 b=Pbv3Giiyce7652KeXjhgOkGXZ2qwvI0LZkNr2WL+2EOGTj52dI7XjaKy9CsY3WBpVd
 8jY0DYVZxROixZNytFeI/SxaIHAHIjYt9HkBnreABtlDK/zMjtUHdRmfY/c8dR0jwL1F
 1rU0bgp88kWMExpJHsufEsz9+1uLZunIJLP0aq/4AKVbIeVh0zWmggbj4R/095ocmX+x
 UHOkl6gDU1JWu50BT2NtQ059DBgKZLo0nCOMgIWc0Y0NBquQqaIEQ4hBo0GJdPDP02p0
 jRpWEgHPrKUO6XX0waTJt0Tq4BR+3IfjLn0nGpWAm0H15A7SmbE/opr/Yr69Zgnef57P
 aBdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/+4K+zyBjC33FL66oxhpncoFLNcwnBLXLtxGzQfHqxuzLutiYUMxiYZ2HXpJyuiebdA4wEuK8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoidVtM55Jwm88nwe26wCDPa2fmmASJb2ELdJ66ZjcBApCCjcs
 cb+gNwdgv1xhXEAW8qbaudRbnF+SW67667veWZYGcKVX4/SZ2JfVqkBu1gbvUldcix/sS7UlwLy
 9lpXr2e9MZ9433aMt9kMXsfO/+nudJhE=
X-Gm-Gg: ASbGnct2A8y9/Qfvkk4nPWJSBTuQbVdebZy5Q0MBFOz+GVtO7XcjAQqHvC3F/3Kc3xv
 DfeN4qpSvLZddiLfNJQZKhK58li+Sq7E7PJG+rbOf0nhEtnBzPJu0R+GRV8fvz3+87ebZczXzme
 +CMqGHQrfyjq7xMCMzzBw9uoXHGNUTP21a3P945Iz0Sas5j2/KV3XTqQyKpydUzZ/lQl4rL3wYi
 YnpDkhqXh+9X/JAvNyZickM0/M8mrecOFzdtpNzYzH66v5eD/xhcmmXXO7MSr8hO2dhtA==
X-Google-Smtp-Source: AGHT+IGTFbY486YnNQWkoWlEaQzvsvasZFyHoZ9KTpGkdm47RfNT3iuxVdTNRpkeEmLfhER+Qz0gUPpksmHAUXp+rAI=
X-Received: by 2002:a05:620a:4092:b0:8b2:4b6:22e0 with SMTP id
 af79cd13be357-8b33d468064mr1952580085a.60.1764061729682; Tue, 25 Nov 2025
 01:08:49 -0800 (PST)
MIME-Version: 1.0
References: <20251124234432.1988476-1-joelagnelf@nvidia.com>
 <f73e4536-ec89-4625-96d4-6fa42018e4e4@amd.com>
 <CAPM=9twe3xcVBgrNCT+1_pGECPL-ry_aA2dxBwbKVeai4+S7AQ@mail.gmail.com>
 <24d4f02b-8ecd-4512-a1f0-ba41684ede1d@amd.com>
 <dfc50417-66ce-44ce-b607-917d678c5631@nvidia.com>
 <9f433dee-7ad9-4d0f-8ac1-e67deb409b70@amd.com>
In-Reply-To: <9f433dee-7ad9-4d0f-8ac1-e67deb409b70@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 25 Nov 2025 19:08:37 +1000
X-Gm-Features: AWmQ_bm6tlLng_0bNMM-_zVqLKGasd2tHLj_Nv0hY-yBLivUiNyEs9A42o3KV94
Message-ID: <CAPM=9tyN_A3oEyQZCOWaLO1orO6oKX0ZukJHR7cFy12Go+7d=A@mail.gmail.com>
Subject: Re: [PATCH] gpu: Move DRM buddy allocator one level up
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, 
 Alex Deucher <alexander.deucher@amd.com>,
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
 Trevor Gross <tmgross@umich.edu>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Edwin Peer <epeer@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 25 Nov 2025 at 18:11, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 11/25/25 08:59, John Hubbard wrote:
> > On 11/24/25 11:54 PM, Christian K=C3=B6nig wrote:
> >> On 11/25/25 08:49, Dave Airlie wrote:
> >>> On Tue, 25 Nov 2025 at 17:45, Christian K=C3=B6nig <christian.koenig@=
amd.com> wrote:
> > ...
> >> My question is why exactly is nova separated into nova-core and nova-d=
rm? That doesn't seem to be necessary in the first place.
> >>
> > The idea is that nova-core allows building up a separate software stack=
 for
> > VFIO, without pulling in any DRM-specific code that a hypervisor (for e=
xample)
> > wouldn't need. That makes for a smaller, more security-auditable set of=
 code
> > for that case.
>
> Well that is the same argument used by some AMD team to maintain a separa=
te out of tree hypervisor for nearly a decade.
>
> Additional to that the same argument has also been used to justify the KF=
D node as alternative API to DRM for compute.
>
> Both cases have proven to be extremely bad ideas.
>
> Background is that except for all the legacy stuff the DRM API is actuall=
y very well thought through and it is actually quite hard to come up with s=
omething similarly well.
>

Well you just answered your own question, why is AMD maintaining GIM
instead of solving this upstream with a split model? the nova-core/drm
split would be perfect for GIM.

kfd was a terrible idea, and we don't intend to offer userspace
multiple APIs with nova, nova-drm will be the primary userspace API
provider. nova-core will not provide userspace API, it will provide an
API to nova-drm and an API to the vgpu driver which will provide it's
own userspace API without graphics or compute, just enough to setup
VFs.

Dave.
