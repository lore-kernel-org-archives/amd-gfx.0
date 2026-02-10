Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3EAEA3F36
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 10:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E5A010E53E;
	Tue, 10 Feb 2026 10:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AmE+/FBO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB78A10E53B;
 Tue, 10 Feb 2026 10:07:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A21F66013C;
 Tue, 10 Feb 2026 10:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E11BC19423;
 Tue, 10 Feb 2026 10:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770718068;
 bh=u8PznRMNHUq4nAGBxZMhRsI1nFCYrCQ3fE2qie4jbrc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=AmE+/FBOXpx4l68K7mRYkO1VaqodkSC6EYBRpsvdmsAAuCtBUC0Ski789nLR1zq1E
 TFTDJAvO/WZbEVJGb8S5jNstC+zYelojWUA/Vz701gpxjENKDqf79Whnceiw8FNbBY
 ut8jot+h95U+T6RJ5kCKlxvUFRclDycYQjjaBjTHT6bLOEcE9HUbcuS+BZFG44DJnu
 CVAHmq30G99r6V870J6tOn4+Jg52OrlgRgVX3eznZ31pPxPm5cEPxdXhux6nTT538r
 +/0qFbG/tLyPxoR1S45Ir7yxIN7ouU4u22nUuj5eODPtQ6D7izQW76OuKa/9AuTQs9
 71HQcI6dvN+Lw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Feb 2026 11:07:37 +0100
Message-Id: <DGB75XMWML8M.DFZY5L52EBQF@kernel.org>
Subject: Re: [PATCH -next v8 1/3] rust: clist: Add support to interface with
 C linked lists
Cc: <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jonathan Corbet"
 <corbet@lwn.net>, "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang Rui" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Helge Deller" <deller@gmx.de>, "Alice Ryhl" <aliceryhl@google.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer"
 <epeer@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp Stanner"
 <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <joel@joelfernandes.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260209214246.2783990-1-joelagnelf@nvidia.com>
 <20260209214246.2783990-2-joelagnelf@nvidia.com>
In-Reply-To: <20260209214246.2783990-2-joelagnelf@nvidia.com>
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

On Mon Feb 9, 2026 at 10:42 PM CET, Joel Fernandes wrote:
>  rust/kernel/clist.rs   | 320 +++++++++++++++++++++++++++++++++++++++++

I think we should move this under rust/kernel/ffi/ to make it obvious that =
this
is FFI infrastructure.

> diff --git a/rust/kernel/clist.rs b/rust/kernel/clist.rs
> new file mode 100644
> index 000000000000..8aa72b5d54be
> --- /dev/null
> +++ b/rust/kernel/clist.rs
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A C doubly circular intrusive linked list interface for rust code.

Here and in the struct documentation, I'd suggest to clearly point out the
use-cases, i.e. that this infrastructure is for FFI use-cases only and shou=
ld
not be used otherwise in drivers, etc.
