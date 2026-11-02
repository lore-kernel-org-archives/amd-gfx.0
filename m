Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6536B60A6F47
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tAQEPjPC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BBB10EEB2;
	Mon,  2 Nov 2026 13:58:48 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5926B10EE99
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 13:58:43 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2e93e0d86a0so4185435ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 05:58:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793627923; cv=none;
 d=google.com; s=arc-20260327;
 b=p4uxX+d7Cfrdm6+6dJmRTz3q0EeUJ9A4htAoljt9ENcOFKkhNj1EtNHMpPPoZkHnH5
 AjcmSyCts/CTjT8pJPRm1qjuEwiGJkrL59KDj530XK0fqdEwF8WlBU2iAsLa7zj2n9V8
 dLbtG9Tf5lkQBCoWPvY6Pn7UMEv7PbQBInsC2LeFjJm6jWF78VYJHn5+UzLNkVkNm6VA
 RbUQRadABL3BKrHq6qeSf2/6r7PTn0xXkC7zVlZ6/O3TxCudvLDsw5pE3j0t4xyl6MKX
 lB8g/ccH1TWQ1mZ9TyakGikWiti5JgzjD9HtBFizwx9EhxzzxAtQxj6CKSYX3+2Dst6c
 u55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nJ6alN4H3+Zgsia4c2nyz/5yJfYPVV0Oy8Rx7dpjduk=;
 fh=HpM/d1Wb7JmwxD1QMxqMQrKVCGDPyI9TD7DwttfC9Js=;
 b=aMCL8GUgYLe7unSMagTC4J4tke7aK7idU0l/6PeVhZ5OjF3bZJOjCL5rcDtVRGKpg7
 dL+KjKShgdi4Vi/kxX9lg8+pxayI9jmJcAUFHE3iWVLaUZUDk+0aZwfazWeCeNcplaWw
 9AxaRc4Pr7isoY2U2xQhNK/3mrBLFVRSo7fm1WExr7ynb4sAIdaK/fWkyGhoslKBUL0x
 X3Bh2fN+mXVbf4oBLBLQr7Jb9cedokF6tZ7UEYjwb72vCYIvC3Xd+pYcFMTkqb05QIK7
 2dx1ZUM4cfvv666m0MkBBzjK8QNKHLmQDTe0sN4tAEefgd+QIIiCilPLg6zDo1pNZP4P
 Kqpw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793627923; x=1794232723; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nJ6alN4H3+Zgsia4c2nyz/5yJfYPVV0Oy8Rx7dpjduk=;
 b=tAQEPjPCMPQbsozRSzFS2HQOuql+fkyQsC7Psm7l/BYcIg+Rq7Ye6d/qQMhdtI3c1M
 H0bRcYOaSqduIMWwAgNzaXnOEZEmuzANUI8JUR4oopdHJbgisJdLVGwcUQfJWvjJap/3
 p0Yl0ndf6nT0K1Unu7R+eHoN5TdI6G/FMjEfM8Mj7ng10B/7sE7p16EzIJDcswINB4VY
 u9gcPqCtUGF1PT4qBdO8YUQwhWwMyKLMGRvdM7y2U7JJnWqGq1VZ4jGovPEJpYtkU3iW
 pfAJwzlAw3GAvkirhGjjhGgURP+4+Kv6Fz1aWLW87iLsBQviQgvvgR71ToC2a4UdcO0C
 3weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793627923; x=1794232723;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nJ6alN4H3+Zgsia4c2nyz/5yJfYPVV0Oy8Rx7dpjduk=;
 b=Qgd86RSOQoY8zMp+f+cIL4kYU3GlSzaEDWwLRLIiFfVPRWnM7pwNpR2P9sw+ovb9rS
 HqUsi8doxNJNUy6ReW87fVoci13ixXUFliaPnmD4Jggk0K1R5oYbZCdo0qB0H0KnmsM8
 i53mOb1tMCvjdgl+sdCrywl2funmMTEv1DpktXZ0EvD+AZu9tQSKD88toT/J2nc8xCBa
 0Taqpxrgsr0laUXfIREw1xMBD3e/mebI6soOGUh0B1QG/8PgR3pZElyAZSoYyjgHr3cc
 ybdEhCEmhxxvwdvX4hfktiyzsnEOhFckoiT7hwPlf0cPcIINA4Cbwk3ua+pXUF2zJN7s
 xHPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlxPGs03AmYDKWwiaWKxtZGDRr0UJhuB1Hxdjg8O/A0jKbhlieLyV4jzZ9IVIFqQtja4TeLZ2+@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/1qJkkIRnbQUeWlwmtgpnpQfU/6Fwva17pKo5HeICa1nOa4x7q
 FVHCy9zVKF06yepwSZKD8hlPESZqoW2kCJ+8cxjyIeToTFIxPuHow+sHoH4L4gRuknWG7lBkCpc
 oo0ibValQJnwxbULqyzj6vFtGeAKwwdE=
X-Gm-Gg: AYBFou1KWhjD6JuVbptY1muvjMYKxb+eMpjv79oDBCdhOi/UcD98tY4ebO6/8a6zOSs
 SxjXI6zwITNO563daUI9cOmY0RG7gd/pqrCKNSg1D9maKSeIDBTiur7Qd7cM6qDHaVhu+g81Mpz
 zCYMMzy11T7WhD+qflPzQlvnSzqDqyRM4bsORkbNE14VMs0RuhHqfpgZU/127S2Ae17Dhh1EpVV
 uHX3Zus9Rqz5UN0XUQNk2k+rOLlyL8GT+8MI5JtssaqXwK2mtcTfpuoA2VGysWbs6sKqqClVrWJ
 LWubWSF8pQXir5Ip/AcIIi8/1tlRuH3ntXnXtmauo5SHRYFGh0B+S4F+/762pzk20KQDBTmKwI0
 ye46/dpWc7nQ6VU1AphJ8f/zb6NsA0cPihChLNeTpo79wzEIhE5UV7/+y1T9iKgSj/avjT1cNdo
 j7D5/CWMl74DYQeorI/qU7hUqRUpwz57CTfYzbC5C/wHLZ
X-Received: by 2002:a17:902:d501:b0:2e9:6468:1ff1 with SMTP id
 d9443c01a7336-2eb3648bf2cmr153268595ad.2.1793627922776; Mon, 02 Nov 2026
 05:58:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAGxFSwnBDM93ouN6Aq2ppm5zF1h19XE6NJ92NT2UEhMP1P4xEg@mail.gmail.com>
In-Reply-To: <CAGxFSwnBDM93ouN6Aq2ppm5zF1h19XE6NJ92NT2UEhMP1P4xEg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 08:58:31 -0500
X-Gm-Features: AclHuK_W2nYNzhWcT-bUVBFipztB_PsZmQptpzSQo4X8vrE-d5Ne3PfFZ8Lk8pA
Message-ID: <CADnq5_PyctWJK2k4-CutYFNPkuMprmZE98d2JjodBQkTLGJhDA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add firmware file fallback for APU VBIOS
 discovery
To: Arnaud BERTRAND <arnaud078@gmail.com>
Cc: Oz Tiram <oz@shift-computing.de>, airlied@gmail.com,
 alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 simona@ffwll.ch
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 3:07=E2=80=AFAM Arnaud BERTRAND <arnaud078@gmail.com=
> wrote:
>
> Hello,
>
> I have two dGPUs : a Radeon RX 6800
> XT and a Radeon RX 6800. They both report the same PCI identity
> 1002:73bf and each has a different VBIOS.
> I hit the same VFCT bus-number mismatch on 7.2.10, but with a different
> outcome: on my machine the device-identity fallback actively breaks the s=
econd
> dGPU.
> I patched my kernel to remove the fallback, but I would like to have a
> better solution for my use case.
> Would it be possible to apply the patch only to APUs ? That would keep
> Oz's APU case working but a dGPU with a stale bus number would fall
> through to its own ROM, which is the source that is
> guaranteed to match the card in the slot.
> I can provide more details if needed, I am out of my depth here.

Should be fixed with this patch series:
https://patchwork.freedesktop.org/series/176969/

Alex

> Thanks
> Arnaud
