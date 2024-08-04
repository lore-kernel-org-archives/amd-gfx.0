Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C00CC3DA64
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Aug 2024 18:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A19D10E07C;
	Sun,  4 Aug 2024 18:12:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wu81+M5z";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6089810E07C
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Aug 2024 18:12:23 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a7aac70e30dso321928866b.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 04 Aug 2024 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722795142; x=1723399942; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLZUGObuH/PUjJlyP75nMsHfEQwt1h83YgjbiL4fo+A=;
 b=Wu81+M5zEgWWAw1Z0GlUqF3iOGu7AIIFaqBHZdvED8+5D7Y/MnL4o9UWaSHkSYdbRE
 FpFUSZwUOa26CzyxAJ9WmJ0qKZVQW4yXl0eOJhd1YJ8cVq/vN1QLi9pYvlYtiVcbCNlS
 uvm62p9MjGx9l93fIq0uL0Z7uSjbkSexGA6RTWLmHnCe72iycU+ngdI/As4Z4aYQ3U6z
 v52s/lqD2tXVInQbI6AKGartxslY6UtN1YVgYqOtb39S/b8EX2xANrMd+aGC7vnfcZWT
 6+3e9U9GNn2cHE32y7uLdZ4myUYn6hIcHdzcxK8N0rHRJICVWE21EnGUSq8Ozgtsb/hr
 IAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722795142; x=1723399942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLZUGObuH/PUjJlyP75nMsHfEQwt1h83YgjbiL4fo+A=;
 b=Ue2tmpucMbQ6x1xdB3R1dgyNlSZR/sbZ2XerBjSji+Hjdc8JYvJkUBPT1XLfATNYjl
 F+DyCQjkZ+CIDI5iJ0+OSQPJ4+89N6RFx/zwSrhOB1+8usdDgPJ4U5TrDQI1x60iHhIk
 D2tLb2nPw9qfRLBVbVtZJsmgYLny4DnAAuqHvoBpNfBfMDjqj8CssFr7eCbSnMXVmdta
 +kIuTkGjtOA8JlPc18bZaCCpouNJKHr5MoXrG8zqba2EnxIbjOxcROgGUTOFZ1jtpps+
 OKLRwv1Sv8KdEki6iclIZYjlinKWjwOMwbYa5dzgbaW8TsWUNjUpFiyGd7zjvYWBXxf+
 Ymbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNfqNTYF5/2Tt5cinWPEMmH/Z1RSjt2sv/rhPkxOou5jQOmzyynFanZCat79hKT8ziYdNo0tkN4eDw9l4c1GwaNTn8+6KK8rbxaYqmKQ==
X-Gm-Message-State: AOJu0YzjKt8L2lcvDUEyIlPtlfLvrQRolvKG6uAJHnuso+BCqwigL80n
 6QcU4qRbFqW2zeToZmMAmiYWwP2pJ5YcSPlIC1STHKROguV97VEDq2fxQ3++sf9XbgW0FrjLQoN
 rsSOR02iUw1NtUShfWKipfLcnmDE=
X-Google-Smtp-Source: AGHT+IHJUFcyk7f1BwnVhFJUubTPFnFI2pHBHzLyshKcsEt0fpJX7oc5HPdpoo5oAOJgrXoGDu6sUQEGS841cAz9lFo=
X-Received: by 2002:a17:907:36c4:b0:a7a:b73f:7584 with SMTP id
 a640c23a62f3a-a7dc5074f0bmr803571366b.34.1722795141282; Sun, 04 Aug 2024
 11:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240730124332.38030-1-sunil.khatri@amd.com>
 <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
 <28927b0d-f97f-451b-af03-943f8c85f92d@amd.com>
 <CAAxE2A7C3fuExvvjTytCR7fYNjoDTDzAqK2JroSihcz6EX7X2A@mail.gmail.com>
 <18c7c805-d2ec-4448-bd25-cdb106aeac7e@amd.com>
 <CAAxE2A7XBQfUnYhSg2RS7TP_i6cv775RW0ocdgAyc-F0dsSqmQ@mail.gmail.com>
In-Reply-To: <CAAxE2A7XBQfUnYhSg2RS7TP_i6cv775RW0ocdgAyc-F0dsSqmQ@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Sun, 4 Aug 2024 14:11:45 -0400
Message-ID: <CAAxE2A5EJGxR8XWnperC2tYjA+x1XwpqEAFC+9LR-Cs+74BpyA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, 
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

On Thu, Aug 1, 2024 at 2:55=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.=
com> wrote:
>
> On Thu, Aug 1, 2024, 03:37 Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>>
>> Am 01.08.24 um 08:53 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> On Thu, Aug 1, 2024, 00:28 Khatri, Sunil <sukhatri@amd.com> wrote:
>>>
>>>
>>> On 8/1/2024 8:49 AM, Marek Ol=C5=A1=C3=A1k wrote:
>>> >> +       /* Header is at index 0, followed by num_nops - 1 NOP packet=
's */
>>> >> +       for (i =3D 1; i < num_nop; i++)
>>> >> +               amdgpu_ring_write(ring, ring->funcs->nop);
>>> > This loop should be removed. It's unnecessary CPU overhead and we
>>> > should never get more than 0x3fff NOPs (maybe use BUG_ON). Leaving th=
e
>>> > whole packet body uninitialized is the fastest option.
>>> That was the original intent to just move the WPTR for the no of nops
>>> and tried too. Based on Christian inputs we should not let the nops pac=
ket
>>>
>>> as garbage or whatever was there originally as a threat/safety measure.
>>
>>
>> It doesn't help safety. It can only be read by the GPU with kernel-level=
 permissions.
>>
>> Initializing the packet body is useless and adds CPU overhead, especiall=
y with the 256 NOPs or so that we use for no reason.
>>
>>
>> Not filling the remaining ring buffers with NOPs is a pretty clear NAK f=
rom my side. Leaving garbage in the ring buffer is not even remotely defens=
ive.
>
>
> What are you defending against? You know the ring is kernel-owned memory,=
 right?

This was pushed without any justification why you need to clear
kernel-allocated memory with some constant number up to 30000 times
per second that only the kernel can read.

Marek
