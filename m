Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522B606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=azYq6A/G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85EDB10E2E1;
	Mon, 26 Oct 2026 13:32:50 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73BFB10ECDF
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 08:53:34 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jCnTk6L7XzMl1M;
 Mon, 26 Oct 2026 09:53:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793004810; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EokGsTUkGJK4OLHgk9LEaNnxdNdDgFwkubYZcc9mZbg=;
 b=azYq6A/GPlOp9hjUI4h19NTGRbMLAHAybud6Ay60/ZBl/lJBxCigcRJY0n6Is+3Nd5/Uuf
 NhBBwCo8ZP0SKR6+nQhsLJ6nVqI5A8q2mX/MbGja3KgBQDqLHZtQwot/qYjr848M1BuVoZ
 B4e/ffjkVtBmZy6BRRONxDyBfYEqB99CBRv/AGnRHIjwPwl3B5Qh41TxEmf81d7H34nngv
 GzTTHQQri7nSmXgK0JhVmohtNxUpg3vWDF5pEloZt1lCmxhlfXPXWfwjmx6wY3fFlxUEOE
 Qhv3B+FFZks4mhEf6d6DII8jTpayDL2ICmUgnScaYRQaANh5gr/JE4Y7GJciJw==
Message-ID: <d1db22be29151b65ac5054be1e80d36605ee732b.camel@mailbox.org>
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Olivier
 Kaloudoff <olivier.kaloudoff@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, Philipp Stanner <phasta@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>
Date: Mon, 26 Oct 2026 09:53:29 +0100
In-Reply-To: <9c4f99bf-4bb4-4c31-9571-31f2aa57da38@amd.com>
References: <20261022105443.60162-1-olivier.kaloudoff@gmail.com>
 <9c4f99bf-4bb4-4c31-9571-31f2aa57da38@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 1fb85a6b7e5a7e8ce50
X-MBO-RS-META: znnn15etoo7e17chdxfy7pq6fjbptjnf
X-Mailman-Approved-At: Mon, 26 Oct 2026 13:32:48 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: phasta@kernel.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-10-26 at 09:22 +0100, Christian K=C3=B6nig wrote:
> Hi Olivier,
>=20
> adding Philip and Danilo as DRM scheduler maintainers, just FYI on the te=
chnical background.
>=20
> On 10/22/26 12:54, Olivier Kaloudoff wrote:
> > Hi Christian,
> >=20
> > > No, what we need to avoid killing the entity while KFD is still
> > > using it!
> > >=20
> > > That is basically an use after free what you have here, only that
> > > the drm_sched can point that out with a warning instead of
> > > crashing immediately.
> >=20
> > The exact "use" we hit is the dying process's own exit fault:
> > SIGBUS -> coredump -> get_dump_page -> do_swap_page ->
> > svm_migrate_to_ram() submits the migration job on the process's own
> > entity after drm_sched_entity_kill() already ran for it.
>=20
> Well, thanks for confirming my worst fear :) That is exactly what I
> expected and it is essentially unfixable.

What prevents you from having your own synchronisation primitive in the
struct where your drm_sched_entity lives in?


> > I think we actually need two complementary things rather than a
> > choice between them:
> >=20
> > b) The scheduler-level guarantee: a job pushed to an entity must
> > =C2=A0=C2=A0 have its fence complete.

drm_sched_entity_kill() is part of this data structure's destructor-
path. amdgpu does not even invoke it directly, just
drm_sched_entity_fini().

After the destructor ran, all usage of the destructed data structure is
effectively undefined behavior.

// Thread A
foo_fini(ptr);
kfree(ptr);

// Thread B
do_stuff_with(ptr); // explodes

You cannot fix this by modifying foo_fini() or kfree().

As Christian has pointed out, the only reason why you don't run into
UAF is that amdgpu keeps the memory the entity lives in alive for
longer.

The solution is to use the API correctly. You must stop thread A from
killing your resources while B is still trying to use them. Or you must
stop B from using something that was deconstructed.

You need a separate synchronisation primitive for that.


>=20
> Approaches like those were rejected many times before, but just for
> the record: Big *NAK* to any hacks with the dma_fence signaling,
> especially in this particular case here it will definitely cause data
> corruption.
>=20
> > drm_sched_rq_add_entity() returning NULL
> > =C2=A0=C2=A0 for a stopped entity leaves the pushed job stranded on the=
 spsc
> > =C2=A0=C2=A0 queue forever =E2=80=94 that window exists independently o=
f who killed
> > =C2=A0=C2=A0 the entity when.

No one must push to a killed entity, no matter where and when. This is
a lifetime problem within amdgpu that must not be worked around in
drm_sched.


Regarding your device unplug issue=E2=80=A6 as you know we're attempting to=
 get
those things right in Rust and really prevent this entire class of
bugs.

A data structure that is very helpful in this regard is Revocable:

https://rust.docs.kernel.org/next/kernel/revocable/struct.Revocable.html

It revokes access to a device / hardware resource by setting an atomic
bool, and then waits an RCU grace period until everyone has seen that
access to this resource is now revoked.

Maybe you can draw inspiration from that for C?


P.
>=20
