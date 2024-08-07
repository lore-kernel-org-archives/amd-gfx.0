Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA8EC52D73
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 16:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A7410E17E;
	Wed,  7 Aug 2024 16:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QUaO+7S0";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2011E10E17E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 16:43:34 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-5b3fff87e6bso2426087a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Aug 2024 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723049012; x=1723653812; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvzqJTJOvZ8y8LVSmBiBziJiGGtm6jzGynqa1AhFzO8=;
 b=QUaO+7S0InpOz5bdSc8E8rf5zQSJh3yUBx6uMfTeMtQAst0mkPmmRuQ7t/2tksnAn6
 oH3KxaGkq45vgA8/nRd7QFGZllz5ep2IY2ySHQy53hPInT+Lbg+8l3BuXoHTq4V9slLT
 HFg4gdh2FC1KVyK/xrEKkOh1kv0HeA9c81MIFtNHDL/JD4jIkUrmDzk5i8M8ZnJW1SCL
 uCd8dwx1yc3U4fDjwueOtYYJR+LEEl9fTQ2Xh07fUQ0wX5z/jP990D8DLWAInLsx+mIa
 +kzzqn20kKoF7xGzJUgR76j9Cvhet4SiNIvgY/N6bzb3sWPJgHNCc2L8p1JswuFqKRWd
 tzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723049012; x=1723653812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvzqJTJOvZ8y8LVSmBiBziJiGGtm6jzGynqa1AhFzO8=;
 b=Bg+zeWjyg0pux0vg98Sbb8OzvaSl6nRmCsGzifW7VCEbPq4kf1NE0rt44t4DFu6hkl
 N1NZ1KzNqIQPAy+IZ8MI+ffcT5DalEn7q+budVAoihz9dAQ5tYNQOPsQ7l4gj8267QWl
 VL7gsnyDhx4Rqs6DyDEtja9m/g0heShh8NM6SKnIdsxAmcoMz751TdfE55FyyDIJmDv7
 EjDjLQ5c92sVr2sGMLS8cP8uNDnyXvw1tVz48uWcoeeJ9AILgr7pZ/IFVLRwMDO725a5
 DguFBGZ4QRG0kI2sOeBMfrb+awxGdo9xvvR6xxL6sSt/oCMNvh2dxr4X9q/dh4Rz7AB3
 jSjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1aVkQO4n+OjrEUtAWNzo4S1kjnIiZXzJaEWkomEmvPw4rxhT5GREvyLdPiqHZ+bd75naYdWrrb45JIYUoTiLQBSTSPSiPcKgMmqNSEw==
X-Gm-Message-State: AOJu0YyKdqNqLN9jZRWibnavqD7fxLQgt5EGMfr7i9WJRi/9UhUvJ0Rx
 9+Gi+sDhPGMGyr2+xzDql2EhCbsiLe0LXvbY5tH19PQ/svQwkKXtYOcvhpSPLiGPa+30f1APNWR
 Xr1o+GfOBzQ4gWEMSr13XIEj8X6I=
X-Google-Smtp-Source: AGHT+IHnpggEZBRsVtqchNjtkG6FF9UgMpUFw5ZKM2VLlGF/oGmMEPV4nu6TPf5Vlf6vDIKSnpOWp1GYb1qMjEgRMbY=
X-Received: by 2002:a17:907:c70c:b0:a7d:cf4f:180b with SMTP id
 a640c23a62f3a-a7dcf4f1a5emr1120813166b.32.1723049012142; Wed, 07 Aug 2024
 09:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240730124332.38030-1-sunil.khatri@amd.com>
 <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
 <28927b0d-f97f-451b-af03-943f8c85f92d@amd.com>
 <CAAxE2A7C3fuExvvjTytCR7fYNjoDTDzAqK2JroSihcz6EX7X2A@mail.gmail.com>
 <18c7c805-d2ec-4448-bd25-cdb106aeac7e@amd.com>
 <CAAxE2A7XBQfUnYhSg2RS7TP_i6cv775RW0ocdgAyc-F0dsSqmQ@mail.gmail.com>
 <CAAxE2A5EJGxR8XWnperC2tYjA+x1XwpqEAFC+9LR-Cs+74BpyA@mail.gmail.com>
 <104cabc4-69a1-4faa-9837-d5b4dc7a5202@ursulin.net>
In-Reply-To: <104cabc4-69a1-4faa-9837-d5b4dc7a5202@ursulin.net>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 7 Aug 2024 12:42:55 -0400
Message-ID: <CAAxE2A7yT7p0YdXdKKNpa2d0ggviqmJvhtTRs=hf7ee6Lhw7zg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
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

On Wed, Aug 7, 2024 at 4:21=E2=80=AFAM Tvrtko Ursulin <tursulin@ursulin.net=
> wrote:
>
>
> On 04/08/2024 19:11, Marek Ol=C5=A1=C3=A1k wrote:
> > On Thu, Aug 1, 2024 at 2:55=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gm=
ail.com> wrote:
> >>
> >> On Thu, Aug 1, 2024, 03:37 Christian K=C3=B6nig <christian.koenig@amd.=
com> wrote:
> >>>
> >>> Am 01.08.24 um 08:53 schrieb Marek Ol=C5=A1=C3=A1k:
> >>>
> >>> On Thu, Aug 1, 2024, 00:28 Khatri, Sunil <sukhatri@amd.com> wrote:
> >>>>
> >>>>
> >>>> On 8/1/2024 8:49 AM, Marek Ol=C5=A1=C3=A1k wrote:
> >>>>>> +       /* Header is at index 0, followed by num_nops - 1 NOP pack=
et's */
> >>>>>> +       for (i =3D 1; i < num_nop; i++)
> >>>>>> +               amdgpu_ring_write(ring, ring->funcs->nop);
> >>>>> This loop should be removed. It's unnecessary CPU overhead and we
> >>>>> should never get more than 0x3fff NOPs (maybe use BUG_ON). Leaving =
the
> >>>>> whole packet body uninitialized is the fastest option.
> >>>> That was the original intent to just move the WPTR for the no of nop=
s
> >>>> and tried too. Based on Christian inputs we should not let the nops =
packet
> >>>>
> >>>> as garbage or whatever was there originally as a threat/safety measu=
re.
> >>>
> >>>
> >>> It doesn't help safety. It can only be read by the GPU with kernel-le=
vel permissions.
> >>>
> >>> Initializing the packet body is useless and adds CPU overhead, especi=
ally with the 256 NOPs or so that we use for no reason.
> >>>
> >>>
> >>> Not filling the remaining ring buffers with NOPs is a pretty clear NA=
K from my side. Leaving garbage in the ring buffer is not even remotely def=
ensive.
> >>
> >>
> >> What are you defending against? You know the ring is kernel-owned memo=
ry, right?
> >
> > This was pushed without any justification why you need to clear
> > kernel-allocated memory with some constant number up to 30000 times
> > per second that only the kernel can read.
>
> I see that this seems to be controversial, but FWIW, if the loop ends up
> staying, at least we could replace it with memset32 as I have shown in
> https://lore.kernel.org/amd-gfx/20240715104026.6311-1-tursulin@igalia.com=
/
> that the inefficient amdgpu_ring_write can show up in the profile.
>
> And also maybe consider other than gfx? Again, I did something in
> https://lore.kernel.org/amd-gfx/20240712152855.45284-4-tursulin@igalia.co=
m/,
> but AMD folks will know if there is a similar (like in this series)
> approach which also improves the GPU side processing and not just CPU sid=
e.

1. Yes, we should reduce CPU overhead by not using amdgpu_ring_write
to flll a ring buffer.

2. We should stop clearing NOP content.

3. We should stop padding to 256 dwords when we really just need to
pad to 8 dwords.

4. We should get rid of amdgpu_ring_write and use a more efficient way
to write into a ring buffer, which is described below.
amdgpu_ring_write generates bad CPU code because the compiler can't
determine pointer aliasing.

When starting to write into a ring buffer, count_dw, *ring, buf_mask,
and wptr should be copied to local variables and ring writes should
only use those. After everything has been written into the ring
buffer, the local variables should be copied back to amdgpu_ring, and
ptr_mask should be applied only then. That allows the compiler to use
constant offsets for the writes, and
reorder/merge/const-evaluate/optimize all operations on the local
variables, which doesn't happen with non-local variables. 3 macros
(amdgpu_ring_begin, amdgpu_ring_write, amdgpu_ring_end) can be created
to encapsulate this logic. Example:

amdgpu_ring_begin(ring);
amdgpu_ring_write(value0);
amdgpu_ring_write(value1);
amdgpu_ring_write(value2);
amdgpu_ring_write(value3);
amdgpu_ring_end();

Marek
