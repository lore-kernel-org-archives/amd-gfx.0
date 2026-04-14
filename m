Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2766F9D0CD
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 14:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5119C10E239;
	Tue, 14 Apr 2026 14:03:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WKOmTssR";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2455310E239
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 14:03:06 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12714f01940so281315c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 07:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776175385; cv=none;
 d=google.com; s=arc-20240605;
 b=WVtiGLN9rU2aLZWy4eeFLC/8pOX0owWOy5SZlWHzDyQOm01S/oL2pV98fgNU9Ly06M
 2TRMRXc7u4YVynwVHXjmzsIYCQ4cpForNLPaGd1Rs4wEG7msjMVTwGcC6elc17lKdp7L
 dfAMqp4YBRyydnDM2WDsgNzYvgPyoqRi0Xeqj3Fu1EvdaZ049exhnVFGZLqxVWZaZ/+V
 NF0rCYS4eDbFa6Uuh3VfO79JmRQOOox0imUYyiQ0hjUoIUlWRfjxm8vQ525vA9QohUT+
 ey9BCkxqCEBn4GkW6U0JitCz78gBok780jWWcCi62U3TbHlikhhKXqWbTYB0KIHHwm/K
 I0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iaF/fBkX/7gnLRB/IP9DP6cQNuFeF5SktwmWO3OWG7k=;
 fh=MxQh+SlkoL1zXYOD1oJRjnIupgFL8FxibwjJLdsIDdo=;
 b=j5AgNL9Ra+VWe1ILBCeViakKQcJZD9KyLW4cIX7IZ6KhYYc/kJ9efn/EUtu82bO/uk
 YiWecgn4gnHEsn/opmaHskDFvwCXY8zr+9RhVJqbqsIGdcgVTB49WIzP35Q/uPzeul05
 FiXjLHA9t++ghBh2gzrnItLDZfKcCeqtnhGvBcwZYM2SqZ0KbaNOibAdJnFBeI5hPMeV
 ghSGra3mTvtWJ2B03tvO2/Pl82VbJp0FCQCx5leJmq4EjlKqEXFtKwXnbF5lVU31liJ1
 ed1iRsOBEWwB6N1bzOTwQ2JbNATuCTkr9lvX2seqj+XAQqgdtCU2vgQYfWEgBbkBF81g
 TfCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776175385; x=1776780185; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaF/fBkX/7gnLRB/IP9DP6cQNuFeF5SktwmWO3OWG7k=;
 b=WKOmTssRi4wIe7lDY8UrLWoNjLEn1q4z0To84u511pKFjH9wwYP6BPCruuL6a1pcmx
 /h3Z7wbRcOd3/zEYLE9U73wxslvUwRAr3LBSIPldV0AJWngrdu9aMMbBkAN3lzJ/Q8Hx
 X3fbTiZ5hrI+FJqLJckWvctAjMICklty0WHrJFao+OXc8GDRr8/8uFUOF9rr9SXRJ43j
 W//iAyeWcC9dHe/FZvO24PzlbXU5tuVI8fpCYkMwalySvGoMQgzF2VkKEDrGYo5Qvbyf
 M+lq7jOVLuLwjvS5uvD01i+/jgjvtP6v74l7eGduAI7Bk0HWRTE/LsV0n6wNv9wL9RFP
 sEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776175385; x=1776780185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iaF/fBkX/7gnLRB/IP9DP6cQNuFeF5SktwmWO3OWG7k=;
 b=QmXXXmtV92tMb6tgGyUOLcLmKDkKUg9RRBKvFK0x5MdCQP1nyonxMzB0BH1t1EHsto
 rsHeAtc/YyP25PUZRvweevYgVQtvLHSTpLZqXkS6Ux+00TQNsJafVU/isc7XM+FdF99c
 8t8hKxW9NSmdJKSxrCw3oWgMi8+BsHpIbMcfCctEhSeaLMJ7SK6jWyUHJgtNAVmQN9QM
 SW38ZGh4rSPnoF6TL1LQwfsJ/A1emhkaXLiIY7dvQtqB8y9TbrfXJcFPSjWw+Yg2jkRY
 MYXshsSY8qNyNU/mImLyj3yEoavvjfRfbpLT//3I4f+DnqVU3iTQ0cTunjLbEbMnm60G
 8Ifg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AUicUQmpChGBbh/KZzamqF1MVpmLb/wZey583WP4IAzk6mMaQWFSpH9nij7K9tU+lMayx+hxh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdqaqjU8ajYWgaHdUf3Qtc6RdNCVvhHH7vVd5syjgjbfVK2lin
 2/AC4jaeKb2RMFxf+gQKidY3JvCp6EdlqVQ8+nfCiSDRPnXDGzQkrMEPfebOW9deJZsK/tPSalt
 QJepKpQ3x5O3MdpXSE/212wLoH+HqLAU=
X-Gm-Gg: AeBDieviloeOt0pOXTpmkyQqdAi7Z+O+Aq7I4diOUAXHFdEmiyaTPS71rvKMCXW9xll
 Q653I7cXlN+E8OEl6Pm5kT9x9IGyyQYFztHv5KVP/vIOPjsQO6d20Ld6cfn+HQuAI1SANRxduML
 Ec2EjVtCqDCzQwqy8wnpZUgDpjALRhScr93vKwbojqtA484nLGa+Rmfy0lGvy1aXKORC4dl8vry
 DAE0MEc0QuJhBwUjLYUkPdYqpMwoOLZg1l+UYthjR7w004zNyejFXmh3FjyIuKd/LB8f5lGgfH7
 xY3YrzKSSrPAxm2l6gVPVaYsZPjoy0zVpdCSD57MC5XBWjMaNzmteMUmU7EyjW1sHfW15LKEGUS
 AiD+U
X-Received: by 2002:a05:7022:b92:b0:12c:33dd:fa28 with SMTP id
 a92af1059eb24-12c34e6b5c2mr4483565c88.2.1776175383371; Tue, 14 Apr 2026
 07:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260413084943.819126-1-sunil.khatri@amd.com>
 <5976d500-d768-4a63-8fbe-4e68e20fc0e6@amd.com>
 <4e862955-3437-40f4-bf04-2bdab7d84909@amd.com>
 <3e220f91-a89e-42fa-9186-c9658d41839b@mailbox.org>
 <9ad4a8a9-7888-4634-aa50-15d22e98dc1d@amd.com>
In-Reply-To: <9ad4a8a9-7888-4634-aa50-15d22e98dc1d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Apr 2026 10:02:51 -0400
X-Gm-Features: AQROBzBC9qUS5gF3ogE4ZmasvHDtA8PAUl6WSN-exbk87YM7KnvKrJYZMIDkESg
Message-ID: <CADnq5_OGYawMqwVVyeB7hB0CqkzGC3wXdt_1RqKa3XG4XAQ=Gw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: gnome shell uses max priority
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 "Mohan Marimuthu, Yogesh" <yogesh.mohanmarimuthu@amd.com>,
 amd-gfx@lists.freedesktop.org
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

On Tue, Apr 14, 2026 at 9:59=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
>
> On 14-04-2026 07:12 pm, Michel D=C3=A4nzer wrote:
>
> On 4/13/26 11:24, Khatri, Sunil wrote:
>
> On 13-04-2026 02:32 pm, Christian K=C3=B6nig wrote:
>
> On 4/13/26 10:49, Sunil Khatri wrote:
>
> In function amdgpu_userq_priority_permit allow till
> maximum priority i.e 3 which is seen for gnome shell.
>
> This is needed to fix the issue of unable to create queue
> for gnome shell.
>
> logs:
> [drm] *ERROR* comm: gnome-shell pid: 2802 client-id:10 client: Unset ... =
SK: Priority 3
>
> Clear NAK, as far as I can see the existing code is correct.
>
> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH is only allowed when you ha=
ve CAP_SYS_NICE, e.g. you are root.
>
> That is also documented in the UAPI. Question is why is gnome shell tryin=
g to use that?
>
> I see, let me add Yogesh for his inputs, @yogesh, why gnome shell is aski=
ng for priority AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH. Based on the=
 code seems mesa is getting a flag set flags & PIPE_CONTEXT_HIGH_PRIORITY -=
> this sets AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH for graphics queu=
e.
>
> For some background, mutter uses EGL_CONTEXT_PRIORITY_HIGH_IMG when EGL_I=
MG_context_priority is supported, to try and prevent its GPU work from gett=
ing starved by clients.
>
> This works (or at least doesn't fail similarly) with kernel queues, presu=
mably via DRM master status. I'd argue that should suffice with user queues=
 as well.
>
> Below is the check that we have for userqueues during queue creation, and=
 for gnome it did not hit any of the condition and eventually return with -=
EACCES that is wrong. It has to be maste or CAP_SYS_NICE capable.
> if (priority < AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH)
>                 return 0;
>         if (capable(CAP_SYS_NICE))
>                 return 0;
>         if (drm_is_current_master(filp))
>                 return 0;
>         return -EACCES;

This is the same logic as kernel queues:

        /* NORMAL and below are accessible by everyone */
        if (priority <=3D AMDGPU_CTX_PRIORITY_NORMAL)
                return 0;

        if (capable(CAP_SYS_NICE))
                return 0;

        if (drm_is_current_master(filp))
                return 0;

        return -EACCES;

Maybe there is a timing difference?

Alex
