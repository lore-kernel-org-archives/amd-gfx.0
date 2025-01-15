Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA20C02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 12:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2AB10E636;
	Wed, 15 Jan 2025 12:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.b="jpuLxiCz";
	dkim-atps=neutral
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CD210E642
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 12:20:20 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6dcdf23b4edso59974256d6.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 04:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1736943619; x=1737548419;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAB9wiU4nf/DepdyNjk7NO70CuLQ2ZcDafrtyDQ7E4c=;
 b=jpuLxiCz2kxIQDUClw5s0KuKkUxn8aoicUBy0TkEUlAUIOICYlwTXP6zX0P5GSHSkK
 AXu/sVg98KMXzy1zmpZpsEtNxUNyzpVqMlio4oVV7S0686DDeIPYyMQ4B6Sr2IWfyr7D
 6daUFPUvHAPatcqqsUyfq4fZo2MJKJ/OhxS8jKbTJsdwoV+hf7q9ILjG3NoiidGzdvbf
 tSHb/hmst3h55i9XAKGEntdu90vE3ZKAKVr9CVQjkW+DzfzbM1hvUOwM8KIgW6KnF1kA
 afmyHrdSqVnA9aln61JZ+5iLuPX+W800UiwDIfK1AazerNXcnlLHNP+GMS7h+pvP7soH
 dF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736943619; x=1737548419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAB9wiU4nf/DepdyNjk7NO70CuLQ2ZcDafrtyDQ7E4c=;
 b=a/ZeDsiY/msTdEEBJTMMKyWcNU8p4KYem8ri7rb/DIy+O9ghcN+FfT7mwkNEISOi9l
 yPRzhLv+nRNBEyswzraL9lrY8B0keEVP3uFrJTJ8HuyT+U+2gvWEO10l2SkO/w7wFIRd
 bz8ruzaeQ3DtTe5m2oJx0rXYX2HmXMJwEDCt/KlCELOrumM4/+gIppCDtm0+lIfFeR8N
 PgsoEwB3kdKNU2fFr9Rhbmyy+4eQLZ4IfHYI75n1gosDExer1Ok7pb4RzqlwsnRkLqrL
 C8fHjLxWaakxWrbWsJFVf2mgUe1/yKtrbVKbFh4AbX2LrNzU6fo2xJiwI5IbN3mzpBvs
 MXEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpH2UFnu7BFnCA3/g/6D83Em029rjAZXwUWRb7F4rKY3uTfI8TXGIJIcSp+v/FMu4pZVKza8tQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+EbLNOSqOqkvmzyRQEMFwCKPCiUMyFwcLMbesaEiooDluv556
 0zdhkrhx2nr5qJMGZDZMKoQB2cCjywZaU0QEM9LpNf+i4Hk6F68zFlhW79zTU+lYwC32WT4mgID
 arYAveP8hqqORCdJC5lJrzkE6zahTeV92ColOGA==
X-Gm-Gg: ASbGncsb0Lo2CIfp54BtxaTqZIZ64PK77p5r5y8WvWGus7T2MsiDfyhFFOGVCpcFKf1
 sycSi3xs6I3d8rivJ2eVl4OjLeVd1fFixoCA=
X-Google-Smtp-Source: AGHT+IH++MvvbPX1N6C4BsVMZdJuPpHeIHlRVGwK/q1DLnsCFWiUlolSn7pCijM10VWaG92QHVc57ip1CChWurmFgfw=
X-Received: by 2002:a05:6214:242f:b0:6d8:a5da:3aba with SMTP id
 6a1803df08f44-6df9b221686mr478026176d6.20.1736943618918; Wed, 15 Jan 2025
 04:20:18 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A5BkF13bFt8_UnuiqPM8W-ZESgmKEjqqGfv=DGzSfJ7aQ@mail.gmail.com>
 <uffsfaps6a75zmkyshkwfxgybcslqrnfqqtjzekegdptvwpugc@2ndpcuxyfp3f>
 <c64cb9d8-5ea7-4644-93c8-04a97b758fa0@mailbox.org>
 <h26quuebhpxwkc3fl4vtfteoqyvingnddgxbnzptfnxfg6xgkd@kkkmeqwplomv>
 <8dae97c9-9286-451a-8122-b309eb21b2f4@mailbox.org>
 <Z2Ki-lQH4Fbch6RO@phenom.ffwll.local>
 <q45c43j5kwwvemec7mcs4kqzt54pa3nz3jlhkcky2v63s2vfie@him4q253uw4p>
 <CAPj87rMFJ0JRvsKqZUsw_EGrFWr1VLO4Ne2w_bZ5cH+gs_d=og@mail.gmail.com>
 <Z2Rf7mpSuzZ0ObmT@phenom.ffwll.local>
 <07d08a42-c44a-477e-8057-721b270310cf@nvidia.com>
 <CAAxE2A6N0xtgZmzTR9FXMN79xxy3T8zfhh1sz73h1h8=0ycJ2g@mail.gmail.com>
 <CAPj87rP4r4q-wBx1dHsEkZ7=S2c2XsbA1Pz4Skw1ETt_2yD2Ag@mail.gmail.com>
 <CAAxE2A6ghBK2VTLkNXgk1c61UG1ZQAzWQ4q=wO-OShAUC9eRmQ@mail.gmail.com>
In-Reply-To: <CAAxE2A6ghBK2VTLkNXgk1c61UG1ZQAzWQ4q=wO-OShAUC9eRmQ@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 15 Jan 2025 12:20:07 +0000
X-Gm-Features: AbW1kvZypYUDzjEI4tFk9DCbDQL9wznW1ZpJeL0bmA-05bm7WepfcCFdFzlZvFM
Message-ID: <CAPj87rNFy7GLAjjxDYGLN-f8M0F7yMX6PED94O4kBJ=pwtPVyA@mail.gmail.com>
Subject: Re: [PATCH] drm/fourcc: add LINEAR modifiers with an exact pitch
 alignment
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: James Jones <jajones@nvidia.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
 Brian Starkey <brian.starkey@arm.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, 
 ML Mesa-dev <mesa-dev@lists.freedesktop.org>, nd@arm.com, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
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

On Wed, 15 Jan 2025 at 04:05, Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wrot=
e:
> On Tue, Jan 14, 2025 at 12:58=E2=80=AFPM Daniel Stone <daniel@fooishbar.o=
rg> wrote:
>> AMD hardware is the only hardware I know of which doesn't support
>> overaligning. Say (not hypothetically) we have a GPU and a display
>> controller which have a minimum pitch alignment of 32 bytes, no
>> minimum height alignment, minimum 32-byte offset alignment, minimum
>> pitch of 32 bytes, and minimum image size of 32 bytes.
>>
>> To be maximally compatible, we'd have to expose 28 (pitch align) * 32
>> (height align) * 28 (offset align) * 28 (min pitch) * 28 (min size) =3D=
=3D
>> 19668992 individual modifiers when queried, which is 150MB per format
>> just to store the list of modifiers.
>
> Maximum compatibility is not required nor expected.
>
> In your case, only 1 linear modifier would be added for that driver, whic=
h is: [5 / 0 / 5 / 5 / 5]
>
> Then if, and only if, compatibility with other devices is desired, the dr=
iver developer could look at drivers of those other devices and determine w=
hich other linear modifiers to add. Ideally it would be just 1, so there wo=
uld be a total of 2.

Mali (actually two DRM drivers and sort of three Mesa drivers) can be
paired with any one of 11 KMS drivers (really 12 given that one is a
very independent subdriver), and something like 20 different codecs
(at least 12 different vendors; I didn't bother counting the actual
subdrivers which are all quite different). The VeriSilicon Hantro G2
codec driver is shipped by five (that we know of) vendors who all have
their own KMS drivers. One of those is in the Rockchip RK3588, which
(don't ask me why) ships six different codec blocks, with three
different drivers, from two different vendors - that's before you even
get to things like the ISP and NPU which really need to be sharing
buffers properly without copies.

So yeah, working widely without having to encode specific knowledge
everywhere isn't a nice-to-have, it's a hard baseline requirement.

>> > DRM_FORMAT_MOD_LINEAR needs to go because it prevents apps from detect=
ing whether 2 devices have 0 compatible memory layouts, which is a useful t=
hing to know.
>>
>> I get the point, but again, we have the exact same problem today with
>> placement, i.e. some devices require buffers to be in or not be in
>> VRAM or GTT or sysram for some uses, and some devices require physical
>> contiguity. Solving that problem would require an additional 4 bits,
>> which brings us to 2.3GB of modifiers per format with the current
>> scheme. Not super viable.
>
> Userspace doesn't determine placement. The kernel memory management can m=
ove buffers between heaps to accommodate sharing between devices as needed.=
 This is a problem in which userspace has no say.

It really does though!

None of these devices use TTM with placement moves, and doing that
isn't a fix either. Embedded systems have so low memory bandwidth that
the difference between choosing the wrong placement and moving it
later vs. having the right placement to begin with is the difference
between 'this does not work' and 'great, I can ship this'. Which is
great if you're a consultancy trying to get paid, but tbh I'd rather
work on more interesting things.

So yeah, userspace does very much choose the placement. On most
drivers, this is either by 'knowing' which device to allocate from, or
passing a flag to your allocation ioctl. For newer drivers though,
there's the dma-heap allocation mechanism which is now upstream and
the blessed path, for which userspace needs to explicitly know the
desired placement (and must, because fixing it up later is a
non-starter).

Given that we need to keep LINEAR ~forever for ABI reasons, and
because there's no reasonably workable alternative, let's abandon the
idea of abandoning LINEAR, and try to work with out-of-band signalling
instead.

One idea is to actually pursue the allocator idea and express this
properly through constraints. I'd be super in favour of this,
unsurprisingly, because it allows us to solve a whole pile of other
problems, rather than the extremely narrow AMD/Intel interop case.

Another idea for the out-of-band signalling would be to add
information-only modifiers, like
DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_EQ(256), or
DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_GE(32). But then that doesn't really
work at all with how people actually use modifiers: as the doc
describes, userspace takes and intersects the declared modifier lists
and passes the result through. The intersection of LINEAR+EQ256 and
LINEAR+GE32 is LINEAR, so a userspace that follows the rules will just
drop the hints on the floor and pick whatever linear allocation it
feels like.

I think I've just talked myself into the position that passing
allocator constraints together with modifiers is the only way to
actually solve this problem, at least without creating the sort of
technical debt that meant we spent years fixing up implicit/explicit
modifier interactions when it really should've just been adding a
!)@*(#$ u64 next to the u32.

Cheers,
Daniel
