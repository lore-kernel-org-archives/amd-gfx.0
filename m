Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F78E7718A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 09:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98A1A10E45E;
	Thu, 19 Dec 2024 09:09:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.b="fp0Rm1Qo";
	dkim-atps=neutral
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B2310E29F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 09:09:27 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b6fc3e9e4aso34518685a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 01:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1734599367; x=1735204167;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WUF6Mu/hi5ZRo8wGjE624NrI6OVco4HQeJhI5p+6BeE=;
 b=fp0Rm1Qo3Xp+RwrxDj/Egd4fo2EWA/U+d4RbDJuQawxD6spEXAPjdxKbrSw0nFZY06
 ggOUDGSWRDmeca7KJ/BkEvnDkPpCL4qr2WQSRFwBKAwMhTV197YdyupH9xDW1RBP8Ylc
 KFSfu5cFXGqX3aQ2CjwAIC7+lz3JbyZ3hSCzj6Dx9Tkf05l6x/VpBaxEdOE15mwCnam7
 Q+IfQz/404Wftt1FxlPUVrBw+wEPFMhjY9l8CSbLATHnl2iRlrH+QF+ixRZrdMFQHxoQ
 /1MSn/QfXXeD8ZdhMsNvNr3ePCQRsjdvhyxr5IpmDg5AK7nlcby8qIjl2hzPgvpiE4+B
 N0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734599367; x=1735204167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WUF6Mu/hi5ZRo8wGjE624NrI6OVco4HQeJhI5p+6BeE=;
 b=xRx+qo+3q/w0uOqlIHpE6zVAzcelSSZG+InSp94NB2RegW4aLINjrE4jqxJlA947dq
 ZouDpukUGZBfFEOVnKekrdW+xHi6aINz4amUsaMESR01vXSnG+jMeBeLdZGSyZyzb2ar
 NVxPVDPeHIf1ZH6wJ/CZayfRWXn8/GPnpL9lyWa7jxZKo65rwpFhU6PL9puNpQ2LuK8l
 h/k8y108Cm+ip9vUDhG8CGf4+bxnOED7YWAvm5r69ptDWo8lo+88SXTu1JMet6THdSK0
 /FFq3RVbAnuGwxZrMWSm4xMPpKCBDhhXhGMz4rKvYauoP6jc1lo8S7KqzMjL+A973QJv
 Tglg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzlN/ZIFN0l+qVHVebYIKVLFDTp4drZW8TBXDvvEJmlMiVQ76VCmWrdIv/GCJjyGycIs3FC+Z9@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8fDIN1iSeBMlwXA+vqk5k5XIcm3ZAnS6N+n/GrTZ88+Df4ANu
 TirI3pEArBY+BnFGANYu4rjRr71x3JFPeudiOaPVh/4etlFtmwA+K0pu0tm1uGwjOdfE80nt5Om
 p7PQKnT0T05/4EZmWtSC2vZlxeWYb9+JumW9SQw==
X-Gm-Gg: ASbGncsLO3rxI4BI7okxpJMG+3y4NiUT5/f2CX0mEE9Jri6vfEs11Z4EKROn0D1SFum
 muFEgO14J6sEQd83bjgWIqtvw53J2IgJLenE=
X-Google-Smtp-Source: AGHT+IEtP97myDSiHvWNcG3HuGT/xIDLF3tgNYJVSNISIo+Pf4zCrxAweedmRXd1xkgrKGeJr3l9TrytywrBFMDUDF8=
X-Received: by 2002:a05:620a:318a:b0:7b6:d643:59ab with SMTP id
 af79cd13be357-7b8636f6ab3mr1011720685a.10.1734599366867; Thu, 19 Dec 2024
 01:09:26 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A5BkF13bFt8_UnuiqPM8W-ZESgmKEjqqGfv=DGzSfJ7aQ@mail.gmail.com>
 <uffsfaps6a75zmkyshkwfxgybcslqrnfqqtjzekegdptvwpugc@2ndpcuxyfp3f>
 <c64cb9d8-5ea7-4644-93c8-04a97b758fa0@mailbox.org>
 <h26quuebhpxwkc3fl4vtfteoqyvingnddgxbnzptfnxfg6xgkd@kkkmeqwplomv>
 <8dae97c9-9286-451a-8122-b309eb21b2f4@mailbox.org>
 <Z2Ki-lQH4Fbch6RO@phenom.ffwll.local>
 <q45c43j5kwwvemec7mcs4kqzt54pa3nz3jlhkcky2v63s2vfie@him4q253uw4p>
 <CAAxE2A5+=QVAFXXCbe3qEgY-Mzb-5XW73CYdANEO+N_xA+ivaw@mail.gmail.com>
In-Reply-To: <CAAxE2A5+=QVAFXXCbe3qEgY-Mzb-5XW73CYdANEO+N_xA+ivaw@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 19 Dec 2024 09:09:15 +0000
Message-ID: <CAPj87rPHg9mJc1eMTtFARG7PBCbBrN9SrkdekY73KCDnaO9-VA@mail.gmail.com>
Subject: Re: [PATCH] drm/fourcc: add LINEAR modifiers with an exact pitch
 alignment
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: Brian Starkey <brian.starkey@arm.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, 
 ML Mesa-dev <mesa-dev@lists.freedesktop.org>, nd@arm.com
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

On Thu, 19 Dec 2024 at 02:54, Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wrot=
e:
> On Wed, Dec 18, 2024 at 5:32=E2=80=AFAM Brian Starkey <brian.starkey@arm.=
com> wrote:
>> On Wed, Dec 18, 2024 at 11:24:58AM +0000, Simona Vetter wrote:
>> > For that reason I think linear modifiers with explicit pitch/size
>> > alignment constraints is a sound concept and fits into how modifiers w=
ork
>> > overall.
>>
>> Could we make it (more) clear that pitch alignment is a "special"
>> constraint (in that it's really a description of the buffer layout),
>> and that constraints in-general shouldn't be exposed via modifiers?
>
>
> Modifiers uniquely identify image layouts. That's why they exist and it's=
 their only purpose.
>
> It doesn't matter how many modifiers we have. No app should ever parse th=
e modifier bits. All apps must treat modifiers as opaque numbers. Likewise,=
 documentation of all modifiers in drm_fourcc.h is only meant for driver de=
velopers. No developers of apps should ever use the documentation. There ca=
n be a million modifiers and a million different devices, and the whole sys=
tem of modifiers would fall apart if every app developer had to learn all o=
f them.

I'm afraid linear _is_ special. And we've never had a delineation
between 'applications' and 'clients' for uAPI purposes; I mean, if
it's OK for Mesa and AMDVLK and ROCm to know exactly how to deal with
AMD tiling modes for HIC, why is it not OK for apps to know that
themselves too? Mostly because it's immaterial to the kernel: if it
breaks one, it's going to break the other too.

> The only thing applications are allowed to do is query modifier lists fro=
m all clients, compute their intersection, and pass it to one of the client=
s for allocation. All clients must allocate the exact same layout, otherwis=
e the whole system of modifiers would fall apart. If the modifier dictates =
that the pitch and alignment are not variables, but fixed values derived fr=
om width/height/bpp, then that's what all clients must allocate.
>
> If any app uses DRM_FORMAT_MOD_LINEAR directly instead of querying suppor=
ted modifiers from clients, it's a misuse of the API.

Yes, but it's _not_ a misuse of the API for the app to query supported
modifiers, see that LINEAR is supported, know that its input is linear
(because it created it, or because the subsystem it gets it from only
supports linear layouts, or because they have another flag for linear
with a non-modifier API, or), and use LINEAR with that. That's exactly
what happens for anyone who wants to do interop with e.g. V4L2.

> DRM_FORMAT_MOD_LINEAR will be deprecated because it's the only modifier t=
hat is generally non-functional (it's only functional in special cases). Af=
ter new linear modifiers land, drivers will stop supporting DRM_FORMAT_MOD_=
LINEAR if they can't support all pitches and alignments because we only wan=
t to have functional software.

You're extrapolating way too far. Linear works totally fine for
everyone except AMD. The special case is that it doesn't work on AMD
because AMD imposes really weird constraints.

LINEAR cannot be removed any time soon/ever. You'd have to change all
the clients who clearly and correctly use it without breaking the
rules today, wait for them to phase out, wait to make sure that no-one
would have them in an old container image or want to bisect into them,
and only then kill it.

Cheers,
Daniel
