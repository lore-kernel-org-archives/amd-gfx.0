Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C69C3DA79
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 00:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC66610E3CA;
	Tue, 16 Jan 2024 00:06:42 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E86210E3CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 00:06:38 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-554fe147ddeso10374161a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 16:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705363537; x=1705968337; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNK3pOaJ2uLGZ3OGzL/rlej3R/D7/Mb4Xsr8nCQ1VVw=;
 b=blFx6CaYG8+rCtQicVsWHGaZZkH2xv/XSYQ4fDdQXGAn38dpnygQcn7TxuK0PmgRJK
 OdxkizyKxCIW3uWm5SOeK7gjjaNoYeBw6sqoaNWeZHt2hqK7n2X4XRQgSNrL6W/YOig2
 K1DoETHebit327l89u2iVe0zcx+4JA0benQVLYQmF0DluDxCrGbNId5mpDBs7NcWpUD/
 N4zbFFPtHJPjR2tJw6vwuCSYQUe/oUHVLYezaY40tof9PyVHoiVdJHGSr2d1v03NK8uR
 bfQ3xpScmfQB8MhNLX09Bjt6hTlZMsygyWQDs5d+KywOcpfl//UZ16ijZzSLQnT9iKw5
 sHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705363537; x=1705968337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNK3pOaJ2uLGZ3OGzL/rlej3R/D7/Mb4Xsr8nCQ1VVw=;
 b=uFAr0mti7kN7TF7iV5P+uIkzdpv+lD5QIWZjZ1Hu4hJfw/s9772NYVoqr36d+jayPL
 KjtRzQxPQB5pWyqGRi7GYhC0Qt489RPRQkXjOsAz5lI2oKieUJk+9QlI3EbBtZidXiCS
 mWgd9c47yk636eb7VxJC/B/iV3cuGTWBDqrhprIWVHK661Sjrr0RhdODb+FordHUV1qZ
 AQD6bGF3RO9gH0C4g99bxU7HRkYgOyFcU9pIwQKEwlEsuqPnTp826UM0hrSYX2pBI0a3
 /6u2AKez+voEOs79xNFRt/84ZxJZ5xmQMPzEeK1YBBTe4Nstp2eQrXUrf6++iHF7pHjb
 4j3A==
X-Gm-Message-State: AOJu0YwkfmivPdilAm2TMGqrjzknObRWK7JqrbBhsFzc6maCFVvHYNOi
 FeGcLpeZQ4WzznI+kh7f/tF2ve0hUSSI8VgDkKs=
X-Google-Smtp-Source: AGHT+IEo9ytBc3Ap76VPgW4nA1acAvC25sP/hfq5Kma2uIQwIEEd3X6AC8pLcJgG8+tgNlkOivxvqx8CmU92W4mTabM=
X-Received: by 2002:a05:6402:1a24:b0:557:7e12:1c1b with SMTP id
 be4-20020a0564021a2400b005577e121c1bmr1773125edb.116.1705363537087; Mon, 15
 Jan 2024 16:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
 <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
 <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
 <9a07c4e4-321c-4f75-aeae-81ed90038365@daenzer.net>
 <f2153219-e791-4e97-96eb-26094d7acf87@froggi.es>
 <5c99ec8c-142d-4877-9624-c8ce0373fccd@gmx.de>
 <5ff32f43-46ea-4e74-8db4-c23e0b03b429@daenzer.net>
 <8e5cd59e-075a-480e-8452-87924580122d@froggi.es>
 <1dbe811f-64a0-4ccd-88cf-3fd30f79f7bc@daenzer.net>
 <c36400bd-b8f2-4026-b989-f4e1854b05ca@gmx.de>
 <7194a09a-afe8-4eae-8288-c72e2ac7d0a6@daenzer.net>
 <51b9ffc3-9ab3-4a06-9307-6b2a343f6bc6@gmx.de>
 <CAP+8YyGg91f_z2ktrd7HQMtOSHn34F-8x7O2iRv=TTrXo2NNoA@mail.gmail.com>
 <81a82ffc-c2e6-4ce6-9cc0-4f01dc8b9891@froggi.es>
 <bff749b8-5531-46bd-8e21-97d094e6b4c2@amd.com>
 <9e6fec7b-3786-4221-8024-6b949efd08e7@froggi.es>
 <bfe79411-7f77-48ab-8cfd-4727704739e8@amd.com>
 <3e284517-0372-4c75-9902-7039c09b73e9@froggi.es>
 <baa54077-cf89-4fb7-b505-a41716e66a23@gmail.com>
In-Reply-To: <baa54077-cf89-4fb7-b505-a41716e66a23@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 15 Jan 2024 19:05:00 -0500
Message-ID: <CAAxE2A5v_RkZ9ex4=7jiBSKVb22_1FAj0AANBcmKtETt5c3gVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx@lists.freedesktop.org, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 15, 2024 at 3:06=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 15.01.24 um 20:30 schrieb Joshua Ashton:
> > On 1/15/24 19:19, Christian K=C3=B6nig wrote:
> >> Am 15.01.24 um 20:13 schrieb Joshua Ashton:
> >>> On 1/15/24 18:53, Christian K=C3=B6nig wrote:
> >>>> Am 15.01.24 um 19:35 schrieb Joshua Ashton:
> >>>>> On 1/15/24 18:30, Bas Nieuwenhuizen wrote:
> >>>>>> On Mon, Jan 15, 2024 at 7:14=E2=80=AFPM Friedrich Vock
> >>>>>> <friedrich.vock@gmx.de <mailto:friedrich.vock@gmx.de>> wrote:
> >>>>>>
> >>>>>>     Re-sending as plaintext, sorry about that
> >>>>>>
> >>>>>>     On 15.01.24 18:54, Michel D=C3=A4nzer wrote:
> >>>>>>      > On 2024-01-15 18:26, Friedrich Vock wrote:
> >>>>>>      >> [snip]
> >>>>>>      >> The fundamental problem here is that not telling
> >>>>>> applications that
> >>>>>>      >> something went wrong when you just canceled their work
> >>>>>> midway is an
> >>>>>>      >> out-of-spec hack.
> >>>>>>      >> When there is a report of real-world apps breaking
> >>>>>> because of
> >>>>>>     that hack,
> >>>>>>      >> reports of different apps working (even if it's
> >>>>>> convenient that they
> >>>>>>      >> work) doesn't justify keeping the broken code.
> >>>>>>      > If the breaking apps hit multiple soft resets in a row,
> >>>>>> I've laid
> >>>>>>     out a pragmatic solution which covers both cases.
> >>>>>>     Hitting soft reset every time is the lucky path. Once GPU
> >>>>>> work is
> >>>>>>     interrupted out of nowhere, all bets are off and it might as
> >>>>>> well
> >>>>>>     trigger a full system hang next time. No hang recovery should
> >>>>>> be able to
> >>>>>>     cause that under any circumstance.
> >>>>>>
> >>>>>>
> >>>>>> I think the more insidious situation is no further hangs but
> >>>>>> wrong results because we skipped some work. That we skipped work
> >>>>>> may e.g. result in some texture not being uploaded or some GPGPU
> >>>>>> work not being done and causing further errors downstream (say if
> >>>>>> a game is doing AI/physics on the GPU not to say anything of
> >>>>>> actual GPGPU work one might be doing like AI)
> >>>>>
> >>>>> Even worse if this is compute on eg. OpenCL for something
> >>>>> science/math/whatever related, or training a model.
> >>>>>
> >>>>> You could randomly just get invalid/wrong results without even
> >>>>> knowing!
> >>>>
> >>>> Well on the kernel side we do provide an API to query the result of
> >>>> a submission. That includes canceling submissions with a soft
> >>>> recovery.
> >>>>
> >>>> What we just doesn't do is to prevent further submissions from this
> >>>> application. E.g. enforcing that the application is punished for
> >>>> bad behavior.
> >>>
> >>> You do prevent future submissions for regular resets though: Those
> >>> increase karma which sets ctx->guilty, and if ctx->guilty then
> >>> -ECANCELED is returned for a submission.
> >>>
> >>> ctx->guilty is never true for soft recovery though, as it doesn't
> >>> increase karma, which is the problem this patch is trying to solve.
> >>>
> >>> By the submission result query API, I you assume you mean checking
> >>> the submission fence error somehow? That doesn't seem very ergonomic
> >>> for a Vulkan driver compared to the simple solution which is to just
> >>> mark it as guilty with what already exists...
> >>
> >> Well as I said the guilty handling is broken for quite a number of
> >> reasons.
> >>
> >> What we can do rather trivially is changing this code in
> >> amdgpu_job_prepare_job():
> >>
> >>          /* Ignore soft recovered fences here */
> >>          r =3D drm_sched_entity_error(s_entity);
> >>          if (r && r !=3D -ENODATA)
> >>                  goto error;
> >>
> >> This will bubble up errors from soft recoveries into the entity as
> >> well and makes sure that further submissions are rejected.
> >
> > That makes sense to do, but at least for GL_EXT_robustness, that will
> > not tell the app that it was guilty.
>
> No, it clearly gets that signaled. We should probably replace the guilty
> atomic with a calls to drm_sched_entity_error().
>
> It's just that this isn't what Marek and I had in mind for this,
> basically completely forget about AMDGPU_CTX_OP_QUERY_STATE or
> AMDGPU_CTX_OP_QUERY_STATE2.
>
> Instead just look at the return value of the CS or query fence result IOC=
TL.
>
> When you get an -ENODATA you have been guilty of causing a soft
> recovery, when you get an -ETIME you are guilty of causing a timeout
> which had to be hard recovered. When you get an -ECANCELED you are an
> innocent victim of a hard recovery somebody else caused.
>
> What we haven't defined yet is an error code for loosing VRAM, but that
> should be trivial to do.

So far we have implemented the GPU reset and soft reset, but we
haven't done anything to have a robust system recovery. Under the
current system, things can easily keep hanging indefinitely because
nothing prevents that.

The reset status query should stay. Robust apps will use it to tell
when they should recreate their context and resources even if they
don't submit anything. Let's fully trust robust apps here. In the
future we might change our mind about that, but for now, let's just
focus on API conformance, and later we can change it as long as we
stay API conformant.

Non-robust apps must be terminated when they hang or are innocent but
affected. Their existence is a security and usability problem and a
source of frustrations for users. 100% guaranteed system recovery is
impossible if they continue to live.

IBs should be rejected for all guilty and affected innocent contexts
unconditionally, both robust and non-robust ones, by the kernel.
Userspace only forwards the reset status to apps for robust contexts
and doesn't do anything else, but userspace may decide to terminate
the process if any non-robust context is affected.


Marek
