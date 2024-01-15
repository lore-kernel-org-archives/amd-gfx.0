Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F8FC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 23:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C1910E306;
	Mon, 15 Jan 2024 23:38:43 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331E410E306
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 23:38:42 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-557bfc7f7b4so13865004a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 15:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705361859; x=1705966659; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6SetjaLGUUTbnyV9ZrNGlfELsrZY2w11CNISKU15Ijs=;
 b=P+QguqJxX5R+TCJNuJZ1HUlcjyBmYz09AExwoxsmAeC6ym+UloF58EwB5YRYUg9kWx
 ZrdMuXqAZsZuMFe42lboecyYu49WvX4am5EMSZ4BwjazSaZJXzuHYeuwXydUi2X4J1mn
 u0eC4JF97RbrkR7nL7rzDxnMJQf74ArkfyWH9aV5SDRescf/rejt7MT7dXr13Oeo4yeY
 TZXBwegyUkSe3VdLIatRXkajdOemw4ajnXzYQDVfXJtjTh9y0EGeUZ68ss0dm6Lv4539
 38ERMZy8JAL0Dcb+AOriGwsV217nIsMM+0tPj0RnltBN+4Vub5g6K/ji60zWJV+QsrzD
 6GFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705361859; x=1705966659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6SetjaLGUUTbnyV9ZrNGlfELsrZY2w11CNISKU15Ijs=;
 b=PYxhrr+ubzAo3bH/FuvVWu6nJrNpyiIZMyAsfLfLuIYkiY5wkZ50pWNdD8PKSbbKal
 e1Mek2WDF6C9G6hTcb+CkqZAJndxwHXibP8Up7lehYE1jpXP8FqD4bft1IyzcLlWe4Ll
 6s/xujL7TEgCz8YwdSVnsNoBg7e8GJcdSmGC3dwTNa8ubLxwPUezWbi8RG91EdypyFtX
 +qNzP55i2de9o0wu1gRhVXifbYCg/FwU7O4SmbTjG0dKFW/YhDw30X6sJqyWRgtuBwob
 fE5b4UyWA0RP4AADZ9Qn/QqN0ZKvwzoDIKIe8L6X28NR30deff5O+0g+snjld3A8e9ln
 0NGQ==
X-Gm-Message-State: AOJu0YyCKrvntk4GQEc2/mn5BoCHvGWSuNqLTz9LwVf4gKlxNGOsFWll
 hnZe6qZLAiAcDqD6Gb/yr8xARQ64WYXkECkdVVI=
X-Google-Smtp-Source: AGHT+IFV92u59O4Ccxtkmesc+s9hyvOR005q9lfM8bM1Lt3RypNRmpwNSzdzlsg57dZJqMgKo0quK5+Q6Mqi1eRJ7Y0=
X-Received: by 2002:aa7:de0f:0:b0:558:b975:1ff3 with SMTP id
 h15-20020aa7de0f000000b00558b9751ff3mr6313154edv.6.1705361858852; Mon, 15 Jan
 2024 15:37:38 -0800 (PST)
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
In-Reply-To: <5ff32f43-46ea-4e74-8db4-c23e0b03b429@daenzer.net>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 15 Jan 2024 18:37:02 -0500
Message-ID: <CAAxE2A6J_fTxjbNdDX37361NaSA_SntfC_g5Tf5rUePXhEk2UA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 15, 2024 at 11:41=E2=80=AFAM Michel D=C3=A4nzer <michel@daenzer=
.net> wrote:
>
> On 2024-01-15 17:19, Friedrich Vock wrote:
> > On 15.01.24 16:43, Joshua Ashton wrote:
> >> On 1/15/24 15:25, Michel D=C3=A4nzer wrote:
> >>> On 2024-01-15 14:17, Christian K=C3=B6nig wrote:
> >>>> Am 15.01.24 um 12:37 schrieb Joshua Ashton:
> >>>>> On 1/15/24 09:40, Christian K=C3=B6nig wrote:
> >>>>>> Am 13.01.24 um 15:02 schrieb Joshua Ashton:
> >>>>>>
> >>>>>>> Without this feedback, the application may keep pushing through
> >>>>>>> the soft
> >>>>>>> recoveries, continually hanging the system with jobs that timeout=
.
> >>>>>>
> >>>>>> Well, that is intentional behavior. Marek is voting for making
> >>>>>> soft recovered errors fatal as well while Michel is voting for
> >>>>>> better ignoring them.
> >>>>>>
> >>>>>> I'm not really sure what to do. If you guys think that soft
> >>>>>> recovered hangs should be fatal as well then we can certainly do
> >>>>>> this.
> >>>
> >>> A possible compromise might be making soft resets fatal if they
> >>> happen repeatedly (within a certain period of time?).
> >>
> >> No, no and no. Aside from introducing issues by side effects not
> >> surfacing and all of the stuff I mentioned about descriptor buffers,
> >> bda, draw indirect and stuff just resulting in more faults and hangs..=
.
> >>
> >> You are proposing we throw out every promise we made to an application
> >> on the API contract level because it "might work". That's just wrong!
> >>
> >> Let me put this in explicit terms: What you are proposing is in direct
> >> violation of the GL and Vulkan specification.
> >>
> >> You can't just chose to break these contracts because you think it
> >> 'might' be a better user experience.
> >
> > Is the original issue that motivated soft resets to be non-fatal even a=
n
> > issue anymore?
> >
> > If I read that old thread correctly, the rationale for that was that
> > assigning guilt to a context was more broken than not doing it, because
> > the compositor/Xwayland process would also crash despite being unrelate=
d
> > to the hang.
> > With Joshua's Mesa fixes, this is not the case anymore, so I don't thin=
k
> > keeping soft resets non-fatal provides any benefit to the user experien=
ce.
> > The potential detriments to user experience have been outlined multiple
> > times in this thread already.
> >
> > (I suppose if the compositor itself faults it might still bring down a
> > session, but I've literally never seen that, and it's not like a
> > compositor triggering segfaults on CPU stays alive either.)
>
> That's indeed what happened for me, multiple times. And each time the ses=
sion continued running fine for days after the soft reset.
>
> But apparently my experience isn't valid somehow, and I should have been =
forced to log in again to please the GL gods...
>
>
> Conversely, I can't remember hitting a case where an app kept running int=
o soft resets. It's almost as if different people may have different experi=
ences! ;)
>
> Note that I'm not saying that case can't happen. Making soft resets fatal=
 only if they happen repeatedly could address both issues, rather than only=
 one or the other. Seems like a win-win.

This is exactly the comment that shouldn't have been sent, and you are
not the only one.

Nobody should ever care about subjective experiences. We can only do
this properly by looking at the whole system and its rules and try to
find a solution that works for everything on paper first. DrawIndirect
is one case where the current system fails. "Works for me because I
don't use DrawIndirect" is a horrible way to do this.

Marek
