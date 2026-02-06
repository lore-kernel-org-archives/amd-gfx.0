Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A555FEE20B9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 17:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B2410E846;
	Fri,  6 Feb 2026 17:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RyhQrtAN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4433E10E843;
 Fri,  6 Feb 2026 17:13:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 05B1A60051;
 Fri,  6 Feb 2026 17:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1083C116C6;
 Fri,  6 Feb 2026 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770397997;
 bh=VusUcOG57uVq4aP95tB6o/KYonI51RwqmHWJ63rGzUM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=RyhQrtANOB+D11Wve/m8L2lLmA2sIYZtIVT7zQ/BhQ3fOrDR8nn1qXOzitA6AFauP
 jFNpNdriH7tCxOuPCjR6KH6bfyDLu9qNr6V/ZVDeOvQZCpNjaXaqiTIeg9yqQYyg1D
 vIb+sgs0lvBbA4M2G+fEJkFNMYGE+AwnsQ7mkKVOnZZs2wSBSsyGEZNh6hARQvRyec
 lK9cgEs8C2fBf3C66y/paf8fUmjjfGbkrltqpuhW2AThwChDilq+cxnZiXKDFJ430p
 XOSSALCb08kTJLJSXY57IJFBjb3YEOL3zhrE2iMxYwFdZBkzlqceQ/rswM4JhPal97
 ivpvFOs16n0mA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 18:13:06 +0100
Message-Id: <DG81PJ9QD8FC.2NF6VEKDD3F2Q@kernel.org>
Subject: Re: [PATCH -next v7 1/2] rust: clist: Add support to interface with
 C linked lists
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
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
 "Boqun Feng" <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer"
 <epeer@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp Stanner"
 <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <joel@joelfernandes.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260206004110.1914814-1-joelagnelf@nvidia.com>
 <20260206004110.1914814-2-joelagnelf@nvidia.com>
 <DG7ZF1UT98RQ.3F42J3ULGV2OC@garyguo.net>
 <DG800TDA6OXQ.275PMMS19F1EX@kernel.org>
 <77ac3274-a962-469d-a2f6-6ccc0670988a@nvidia.com>
 <DG80FV3VTT6P.2ZP18EM8605GT@garyguo.net>
In-Reply-To: <DG80FV3VTT6P.2ZP18EM8605GT@garyguo.net>
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

On Fri Feb 6, 2026 at 5:13 PM CET, Gary Guo wrote:
> On Fri Feb 6, 2026 at 4:05 PM GMT, Joel Fernandes wrote:
>>
>>
>> On 2/6/2026 10:53 AM, Danilo Krummrich wrote:
>>> On Fri Feb 6, 2026 at 4:25 PM CET, Gary Guo wrote:
>>>> On Fri Feb 6, 2026 at 12:41 AM GMT, Joel Fernandes wrote:
>>>>> diff --git a/drivers/gpu/Kconfig b/drivers/gpu/Kconfig
>>>>> index 22dd29cd50b5..2c3dec070645 100644
>>>>> --- a/drivers/gpu/Kconfig
>>>>> +++ b/drivers/gpu/Kconfig
>>>>> @@ -1,7 +1,14 @@
>>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>> =20
>>>>> +config RUST_CLIST
>>>>> +	bool
>>>>> +	depends on RUST
>>>>> +	help
>>>>> +	  Rust abstraction for interfacing with C linked lists.
>>>>
>>>> I am not sure if we need extra config entry. This is fully generic so =
shouldn't
>>>> generate any code unless there is an user.
>>>=20
>>> I also don't think we need a Kconfig for this.
>>>=20
>>> In any case, it shouln't be in drivers/gpu/Kconfig.
>>
>> Fair point, I believe I was having trouble compiling this into the kerne=
l crate
>> without warnings (I believe if !GPU_BUDDY). I'll try to drop it and see =
if we
>> can get rid of it.
>
> If you run into dead code warnings, I think it is fine to just
>
>     #[allow(dead_code, reason =3D "all users might be cfg-ed out")]
>
> the overhead of just let rustc type-checking this module isn't worth the =
extra
> Kconfig plumbing, I think.

You mean because there are pub(crate) in clist.rs? I don't think the Kconfi=
g
would help with that, nothing prevents people from enabling RUST_CLIST, but=
 none
of the users.

Besides that, once we have the new build system, the users of CList are lik=
ely
in other crates anyways, so I think we should just change things to pub.
