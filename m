Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1CE606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=inmRO8Ln
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23C110E351;
	Mon, 26 Oct 2026 17:01:10 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F48410E1DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 17:01:04 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-313bab9cfe7so559584eec.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 10:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793034064; cv=none;
 d=google.com; s=arc-20260327;
 b=EEPSNFfRlKrEysWZN3SofAt27HgTe2SlixDNQDi+xbrpBw0AZPOr+X5K+Rxp4RZXZX
 yjD9M9vg4jaLZIGpR5XIRlvb/azce0jdnQwToX24a8fTfR4pfrXyrf5riy1T+meqZJ63
 fCRsj3QuFmn8JJn2eIwJTKj0iXNMBgcSfGKlTEl9Nb5C7mEWR1II3a3s6J/uLsFYVU4e
 ddzmbBHZTcUkxXzbIqoJ+quTVP9gzzi1SXpFKZpjgL0ksrrrMC3WU40o8b6QU9LgnbYm
 lSMt/l8Nwi8QKy3pmcMVfjHZOJRzyqu/6UoYZEkR/IBKO52fF/czlYZGEnbJhIf3Fx8D
 7pRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BS54ovh1nB1Pr1TNbVZrV/xnE/i+a7dkc4mdMDvEa3E=;
 fh=MzjP44THGctB3bJ9O7DKkkpP1qgtwNmXjgild+RfD8Y=;
 b=NiZ9Fy4EE1ISDcbIUliPauBDGivoa3wvaKjWBkB7jLaZ6ds8bT/whtHBOHSkeb38Ob
 9aFVe0FMRkck2KvMB8Jz7fKRybgWPIyjMRsPMOlpTf9gXGQx93pndtuWy3IPI8MIeyBd
 41zjIO/9ZO4MJRuEOEI7wnSmJjIzbRx+yeeXX+Age5BohhuOjS+oWUDMe5Elqi9HG2bM
 ZAk8516nKmqEgh2CumfXWCSxSqsFIwPwcMrSQPxjrcIRCiB/lyK9KKfebp9m1HRtMAEp
 6IrK2LP/hpUviTQTqt/kJHX7YR/pYoCXDPyjchaPcTvTxBfcqOFWstoI5DB/j7yTa3Pf
 JIlA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793034064; x=1793638864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BS54ovh1nB1Pr1TNbVZrV/xnE/i+a7dkc4mdMDvEa3E=;
 b=inmRO8LnlyEUDfFSuW9gusZuU+5+Cp/L0ffwSwo3/pA0sZg0RRyyIV+XPbj0Grz3XB
 bBsehq4gT2Dsa1029f5QZI7FqgKyglUihXffJTbuJzPBa391meU1UMDlkMWpmmHjkj+m
 Ok+/CY2mmIAtJVtMJBqm9g4U2nV1W1NJccl79mz2PgXo8BNgYjuz9XCasauEiJUFLVKJ
 pbfCTYzFKdkiN3iHfzlYoM82zO0MCSv6z5HwSEZ/bY9Och5zes5PmwzOUQlts2zenNMx
 8Ev33ksfEgIM9jlfq1plVCVCThlAF+w1kZ5Gl8IvAOMC8AtNJ3OmDsJDWmSi3Dn8qwiw
 3r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793034064; x=1793638864;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BS54ovh1nB1Pr1TNbVZrV/xnE/i+a7dkc4mdMDvEa3E=;
 b=t32DgM/6SHL79Hsn3oypRTnMLRd+CmfGSMHUmeQbUpYzKbNOghDR8ceF41JUzZcMSq
 8bvLzkULmpCT0EVTiR/AjWRvHPQCuSvPQDKgr8SEjrkXorS8rVZiSm4ib11LHRiSSe5p
 nqL1TpwbNjrqdmxdEOpPAwdjdXGK0uS3rHbQWnpPEczljBHHKGV++1cj1ZF5ehSCrOur
 SsHzUrHrdfZ3oRX/1jktvSKLZpXB4/dyv5H73MVKabaufQl/OyRAPlDSUQLivD8Gza0g
 tBe3XPqxlZ7Is2H7BjvpTQlNyZi9z5g6k6U+sMXbkLcax9x9r0Bm4LzwAK7VxJLeswJW
 8uDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIwOwQj6WZ4vtUR1H4njJzcHqaRUfWGeyIe8kJ2iezLmJRbkvs3yfEEgiUiq+eMIpG02CjFDZZ@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJSi0YMXPPqC4QSIkgFWeZnFq6gX6vZ7IsfWWJRfWoOIOYulqiw
 WAZcMsbjIyuFy1VCo3gDj2VbJdUWs0srz8dyFbEwOFCOkJYHafDWD3GZ1kCtUxJPPeLqzkQHJLX
 cC9vm0WTrXVfZNT8afOuQJWq+AdmYnzw=
X-Gm-Gg: AYBFou3dHdB/cQgk3FfGp01r1JitzvEHgS33Ny6xpP0a2Q5UMfkFjotSrFDbfdwsDl6
 /T72Om6Eahgcrotl8XTVtuNruki40kAx+iMCbMra+wq0X5CJh7lN969mzE6RCGnXShF2XzT6Mfj
 mNWlQASqIZT0ShXqDt/8qE8Tz0J6+gPbBsVX0KOoqvyoDYlhgqEnVo6YIO0MP5J4ecNNhjhZubq
 oAsUaxAT7XKnokl0ijoQxJwpa2A5ePUAg2t41K/XUdpdPSg2WmbkFYHlCsPY23lz7bNracSTOce
 QUqkaHo6IAG/L0Lr/VoYkcdpATP5BXnFC+8Z24bsAbRFyNpCdRNDoYk2/CVzUuzQC3RmB2Cx63C
 8/hVWe0L2jIm6eyPnksaigH/5Bbra4IXGg0GD6l7zIgRRmhd6gxL9bfEbXqFyAlGmuzKLWSPBNx
 jDSgRATHMFg3jaDz4K6gBglko=
X-Received: by 2002:a05:701b:430a:b0:16b:4f52:a08 with SMTP id
 a92af1059eb24-1991b142105mr15395135c88.0.1793034063564; Mon, 26 Oct 2026
 10:01:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260923152912.1296884-1-qwe.aldo@gmail.com>
 <20260923154357.1319689-1-qwe.aldo@gmail.com>
 <CADnq5_PuveD6MFtdLFkkHk24jVCQqgyC1R6pUy7ri_RyWVSZXw@mail.gmail.com>
 <CAP48Hftn=4fRju0BiDw84THpgOe=jn23zJT_9HFmvfWZHvfS=A@mail.gmail.com>
In-Reply-To: <CAP48Hftn=4fRju0BiDw84THpgOe=jn23zJT_9HFmvfWZHvfS=A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 13:00:51 -0400
X-Gm-Features: AclHuK-ZJnBGjssDmaDNeuleS1m5YvnvGtHzqQMdnRIj_FC0Z9Z0M08nvMiS3aY
Message-ID: <CADnq5_PGM6sh3ZidW=_ZrPP7d0oANFvFXfiarF_5UVj4HZwGqw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: prevent parameter-space underflow in
 nested ATOM table calls
To: Aldo Ariel <qwe.aldo@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 24, 2026 at 5:01=E2=80=AFPM Aldo Ariel <qwe.aldo@gmail.com> wro=
te:
>
> Hi Alex,
>
> Thanks for applying this fix. Could you point me to the commit or
> the branch where it landed? I haven't been able to locate it and
> would like to track its integration.

Sorry, I forget to mention that it caused a regression in atombios
parsing when I ran it through CI.

Alex

>
> Thanks,
> Aldo
>
>
>
> On Thu, 24 Sep 2026 17:52:34 -0400, Alex Deucher <alexdeucher@gmail.com> =
wrote:
> > Applied.  Thanks!
> >
> > On Wed, Sep 23, 2026 at 11:44=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@=
gmail.com> wrote:
> > >
> > > atom_op_calltable() invokes a child ATOM table, forwarding the
> > > parent's parameter space with an offset:
> > >
> > >     amdgpu_atom_execute_table_locked(ctx->ctx, idx,
> > >         ctx->ps + ctx->ps_shift,
> > >         ctx->ps_size - ctx->ps_shift);
> > >
> > > ctx->ps_shift is in dwords (set to ps / 4 in
> > > amdgpu_atom_execute_table_locked()), while ctx->ps_size is the
> > > remaining capacity in bytes. The subtraction therefore mixes units:
> > > a child table requesting 60 bytes (ps_shift =3D 15 dwords) with only
> > > 16 bytes remaining would compute 16 - 15 =3D 1 instead of the correct
> > > 16 - 60 =3D underflow.
> > >
> > > Convert ps_shift to bytes (ps_shift * 4) in both the guard and the
> > > subtraction so the units are consistent. Abort the interpreter when
> > > the request exceeds the available space so the parent table does not
> > > continue with stale or uninitialized data.
> > >
> > > Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table suppo=
rt")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> > > ---
> > > v3: abort the interpreter (ctx->abort =3D true + return) when the
> > >     child table's parameter space exceeds the parent's remaining
> > >     capacity, instead of silently skipping execution (found by
> > >     Sashiko AI review on v2).
> > > v2: convert ps_shift to bytes (ps_shift * 4) before comparing with
> > >     ps_size, fixing the unit mismatch (found by Sashiko AI review).
> > >
> > >  drivers/gpu/drm/amd/amdgpu/atom.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/=
amdgpu/atom.c
> > > index e0e585f..af283cd 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> > > @@ -646,8 +646,13 @@ static void atom_op_calltable(atom_exec_context =
*ctx, int *ptr, int arg)
> > >                 SDEBUG("   table: %d (%s)\n", idx, atom_table_names[i=
dx]);
> > >         else
> > >                 SDEBUG("   table: %d\n", idx);
> > > -       if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
> > > -               r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx,=
 ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
> > > +       if (U16(ctx->ctx->cmd_table + 4 + 2 * idx)) {
> > > +               if (ctx->ps_shift * 4 > ctx->ps_size) {
> > > +                       ctx->abort =3D true;
> > > +                       return;
> > > +               }
> > > +               r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx,=
 ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift * 4);
> > > +       }
> > >         if (r) {
> > >                 ctx->abort =3D true;
> > >         }
> > > --
> > > 2.43.0
