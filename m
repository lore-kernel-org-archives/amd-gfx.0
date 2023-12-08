Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0C0C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 18:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0763410E1D9;
	Fri,  8 Dec 2023 18:00:09 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE41310E1D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 18:00:06 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1f5bd86ceb3so1443874fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Dec 2023 10:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702058406; x=1702663206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAi/B4U+jgW+YuYqCxhuBSo96hHgz/wZrPHdVwF39q0=;
 b=kCfiaQDBcHr8+BhicDCHf6F10q2Sesj9MvrzOIFXc41S634Ck5lT7nsvp4z1185AVH
 QsHVl+y7o4m+EJq0q94dfRo3hCc6jEfoeCyFZxos6dyicjaXKnOERY0FpXsR3xMJlrgm
 asaAxjG008yA0O9gsHKSadEIofYhAEFcHQ27dEH0ryFUWGwCrxikVp+yN8fG+7Xdz6Eg
 zV5cBOnmvlLwOWkFQEq8gDnBpoAcBKaw/cuVXDmmZ3YpfimWUhOY1gIwcoANQ6eG6ikN
 uk52E1Dh39aq3ZwmXMeNoGqxwUxHlKWUEh7PyEuE2LfwGAfQjyxU2eSoTE/L38gTCs+Z
 O5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702058406; x=1702663206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QAi/B4U+jgW+YuYqCxhuBSo96hHgz/wZrPHdVwF39q0=;
 b=Roc4Zei25ESCqJE3zfaL+x27mFhPBDYhTM4bFs2pxZUiQB06MT2uWIwBQyRL0FGKms
 hFcFGUKagFSbjxmygkyHWdis2qpuxXW1p6npQ6gHjMpIdocJyG7a2MKoQV8r0FW9ek+S
 q75lrwQZqN/JiDYwQYYEyBtN4o+feulXWaNU9e31/rlDvrTUyu032I2XxSL9zjrJeq56
 +LHRTNsqKfJvpHJDua+DV79wuXaXQOLyYET2HA8PJmp0aGz+Shb7miNetWm/FppyB5tV
 287T4rYQhaBZPpH4gtr7kH/YkAvx4y2hJanOi1Z0SXQQsjsDM6IUJw+23KZhISca5JeB
 2xuw==
X-Gm-Message-State: AOJu0YwOgyT2iydTjuZDsUKk14OCfXVwbDTFCCVAi6wguXuB5Cq4w9pu
 dtFBigGoYUkpvQnlFzCN9EKhEG01Yke9EK20mtdrpH11
X-Google-Smtp-Source: AGHT+IGnBHeuTRGYfVfv5rMAvDSZ90uJEJX430HHoO9AQuaOYRcoiIiIO0iaEY/L1iVcjdaB3ZH1dK87WbLjMOc68nA=
X-Received: by 2002:a05:6870:858d:b0:1fa:df72:9ed5 with SMTP id
 f13-20020a056870858d00b001fadf729ed5mr472449oal.38.1702058405694; Fri, 08 Dec
 2023 10:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20231202001740.120840-1-friedrich.vock@gmx.de>
 <3525f437-9537-4fb4-80d0-65acd9d55d2f@gmx.de>
 <3cf226b8-c80b-43f6-9f6c-9610d224717a@amd.com>
 <1939f568-f780-4e34-b5c5-dab461f93b57@gmx.de>
 <8041be7c-64d5-4b1d-a734-4326db98f256@amd.com>
 <CAAxE2A6Kdj5TBCdZRoT_t+cABzf9tsNCvJLZAVCE66F5pz5yXQ@mail.gmail.com>
 <5de028e5-d24c-4e98-96aa-e3d18720ab6a@froggi.es>
In-Reply-To: <5de028e5-d24c-4e98-96aa-e3d18720ab6a@froggi.es>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Dec 2023 12:59:54 -0500
Message-ID: <CADnq5_PrvUZXvsLY6fsvigrF+SEwwKZCN5MCF=Zo-RggGJrd1A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
To: Joshua Ashton <joshua@froggi.es>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 8, 2023 at 12:27=E2=80=AFPM Joshua Ashton <joshua@froggi.es> wr=
ote:
>
> FWIW, we are shipping this right now in SteamOS Preview channel
> (probably going to Stable soon) and it seems to be working as expected
> and fixing issues there in instances we need to composite, compositor
> work we are forced to do would take longer than the compositor redzone
> to vblank.
>
> Previously in high gfx workloads like Cyberpunk using 100% of the GPU,
> we would consistently miss the deadline as composition could take
> anywhere from 2-6ms fairly randomly.
>
> Now it seems the time for the compositor's work to complete is pretty
> consistent and well in-time in gpuvis for every frame.

I was mostly just trying to look up the information to verify that it
was set up correctly, but I guess Marek already did and provided you
with that info, so it's probably fine as is.

>
> The only times we are not meeting deadline now is when there is an
> application using very little GPU and finishes incredibly quick, and the
> compositor is doing significantly more work (eg. FSR from 800p -> 4K or
> whatever), but that's a separate problem that can likely be solved by
> inlining some of the composition work with the client's dmabuf work if
> it has focus to avoid those clock bubbles.
>
> I heard some musings about dmabuf deadline kernel work recently, but not
> sure if any of that is applicable to AMD.

I think something like a workload hint would be more useful.  We did a
few patch sets to allow userspace to provide a hint to the kernel
about the workload type so the kernel could adjust the power
management heuristics accordingly, but there were concerns that the
UMDs would have to maintain application lists to select which
heuristic worked best for each application.  Maybe it would be better
to provide a general classification?  E.g., if the GL or vulkan app
uses these extensions, it's probably a compute type application vs
something more graphics-y.  The usual trade-off between power and
performance.  In general, just letting the firmware pick the clock
based on perf counters generally seems to work the best.  Maybe a
general workload hint set by the compositor based on the content type
it's displaying would be a better option (video vs gaming vs desktop)?

The deadline stuff doesn't really align well with what we can do with
our firmware and seems ripe for abuse.  Apps can just ask for high
clocks all the time which is great for performance, but not great for
power.  Plus there is not much room for anything other than max clocks
since you don't know how big the workload is or which clocks are the
limiting factor.

Alex

>
> - Joshie =F0=9F=90=B8=E2=9C=A8
>
> On 12/8/23 15:33, Marek Ol=C5=A1=C3=A1k wrote:
> > On Fri, Dec 8, 2023 at 9:57=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com
> > <mailto:christian.koenig@amd.com>> wrote:
> >
> >     Am 08.12.23 um 12:43 schrieb Friedrich Vock:
> >      > On 08.12.23 10:51, Christian K=C3=B6nig wrote:
> >      >> Well longer story short Alex and I have been digging up the
> >      >> documentation for this and as far as we can tell this isn't cor=
rect.
> >      > Huh. I initially talked to Marek about this, adding him in Cc.
> >
> >     Yeah, from the userspace side all you need to do is to set the bit =
as
> >     far as I can tell.
> >
> >      >>
> >      >> You need to do quite a bit more before you can turn on this fea=
ture.
> >      >> What userspace side do you refer to?
> >      > I was referring to the Mesa merge request I made
> >      > (https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462
> >     <https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462>).
> >      > If/When you have more details about what else needs to be done, =
feel
> >      > free to let me know.
> >
> >     For example from the hardware specification explicitly states that =
the
> >     kernel driver should make sure that only one app/queue is using thi=
s at
> >     the same time. That might work for now since we should only have a
> >     single compute priority queue, but we are not 100% sure yet.
> >
> >
> > This is incorrect. While the hw documentation says it's considered
> > "unexpected programming", it also says that the hardware algorithm
> > handles it correctly and it describes what happens in this case:
> > Tunneled waves from different queues are treated as equal.
> >
> > Marek
>
