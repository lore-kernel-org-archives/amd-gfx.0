Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2B8C4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 17:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 736B210E637;
	Wed, 10 Jan 2024 17:46:21 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE1C10E637
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 17:46:20 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5571e662b93so3801241a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 09:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704908778; x=1705513578; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8+xeHuCrOpZij85cRNo+iSlV7k0jyAELbK5l7zPqic=;
 b=geRKpLONXnXnYXkcsjSxv20vZaZZYBHqwfIADU6enArNiFKq1f92uuEPb9ZHQecZbo
 dgL3k8qntNGlsMpXjDJV7eyuslielhYTAvs5Xj4YPpw3j9xcVPP9LTeM01PGCx7Tny2q
 89vpaEd26Wgm4yMqVaRNHf0UqPtHrOn0Dwz7FcsHERYTFg3AHN9jVTK/1vKNyk/FbAuB
 fh+kV6cDydiJaBYaiJ1iErbp5OmcTsFAhJYUy6GifqCkvZdTvzi+pAR4uDRyjOqSaAl8
 IuCpu7TA8gF0Yu27012TkZICjoFkBnB0zFeXYOWdrHoOBNSMUgJsYa/qF29S+J1YoBHH
 3XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704908778; x=1705513578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8+xeHuCrOpZij85cRNo+iSlV7k0jyAELbK5l7zPqic=;
 b=fGloYaX/iQDHh8RJBYPPCmQN7vkze3ulFZhOZqRUhk8fQwke991kXDKlnrSw1m9UIj
 3GULKd5fxBZPYYtgmIPttAF7ik2QBKzPjgQ3f9sDuUEEHmiE02cQqyKE/xRhNFBOTTTV
 R4HQOgCi0UJ9j8JzGG0k+BdqNjh8tKTnFEoGlHN/M2VlvsrpKx8cZ6zU52FvUo/iySe1
 9GdP7eWA2K16N6F8Z/DE+Ws3ThyFK4TSzZxIuWU0JzlYQGG094tvLOAZOYHwbsX1prMo
 YYubepS7SDl+MxiVcIqMEVNgsJMWQ5Hybo81pyT8/KmhFkUXI6ac7Td8Jn2oKvwmr+T9
 /RjQ==
X-Gm-Message-State: AOJu0Yy48HKITArhUptZEgLtZEk3UKForpyeacHxWV80BvuCVkDXPHy2
 BmytqUXIileMcc6KicmX99ng3DiY8dR2wNo9HVQ=
X-Google-Smtp-Source: AGHT+IGw2jnRgrhygiDqsULlHi2poJ630ICWX4jYAmQH1cN51KBCOf0XKZoBlFeqEJtJXmgW8KYDPbVez8Zd9c+0YHw=
X-Received: by 2002:a50:8ad9:0:b0:558:817:1215 with SMTP id
 k25-20020a508ad9000000b0055808171215mr703837edk.67.1704908778297; Wed, 10 Jan
 2024 09:46:18 -0800 (PST)
MIME-Version: 1.0
References: <20240103043000.23971-1-ent3rm4n@gmail.com>
 <CADnq5_NexkgrEKbM39QVGo+hOmd2G0Yc0sui3jWuJsKAyb3ONg@mail.gmail.com>
 <10b32f43-7b0c-1232-1070-cf51731c5d5f@amd.com>
 <0416969a-ddf5-4c6b-9017-6a6a4384b163@amd.com>
 <2e8cd9ed-bdea-eb54-99f1-a7b854594b69@amd.com>
 <CAAxE2A6YdbbC0EKWTdAMLQK9tKmO3v17+yPvhqfby2P_bfH1pw@mail.gmail.com>
 <285317c2-4236-4a22-a6ba-26e2100dde54@amd.com>
 <CAAxE2A7+bJm7g+8S_Z3z99vinnSr_8CwjJs+YZVizOS94CekoA@mail.gmail.com>
In-Reply-To: <CAAxE2A7+bJm7g+8S_Z3z99vinnSr_8CwjJs+YZVizOS94CekoA@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 10 Jan 2024 12:45:41 -0500
Message-ID: <CAAxE2A6c2pxv5j_Mums73Y0PYMXyASOJFoS3rXvUYuRGmbSj-g@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of
 VM hole"
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>, Kaibo Ma <ent3rm4n@gmail.com>,
 Jay Cornwall <jay.cornwall@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It looks like this would cause failures even with regular 64-bit
allocations because the virtual address range allocator in libdrm asks
the kernel what ranges of addresses are free, and the kernel doesn't
exclude the KFD allocation from that.

Basically, no VM allocations can be done by the kernel outside the
ranges reserved for the kernel.

Marek

On Sat, Jan 6, 2024 at 1:48=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.=
com> wrote:
>
> The 32-bit address space means the high 32 bits are constant and predeter=
mined and it's definitely somewhere in the upper range of the address space=
. If ROCm or KFD occupy that space, even accidentally, other UMDs that use =
libdrm for VA allocation won't be able to start. The VA range allocator is =
in libdrm.
>
> Marek
>
> On Fri, Jan 5, 2024, 15:20 Felix Kuehling <felix.kuehling@amd.com> wrote:
>>
>> TBA/TMA were relocated to the upper half of the canonical address space.
>> I don't think that qualifies as 32-bit by definition. But maybe you're
>> using a different definition.
>>
>> That said, if Mesa manages its own virtual address space in user mode,
>> and KFD maps the TMA/TBA at an address that Mesa believes to be free, I
>> can see how that would lead to problems.
>>
>> That said, the fence refcount bug is another problem that may have been
>> exposed by the way that a crashing Mesa application shuts down.
>> Reverting Jay's patch certainly didn't fix that, but only hides the prob=
lem.
>>
>> Regards,
>>    Felix
>>
>>
>> On 2024-01-04 13:29, Marek Ol=C5=A1=C3=A1k wrote:
>> > Hi,
>> >
>> > I have received information that the original commit makes all 32-bit
>> > userspace VA allocations fail, so UMDs like Mesa can't even initialize
>> > and they either crash or fail to load. If TBA/TMA was relocated to the
>> > 32-bit address range, it would explain why UMDs can't allocate
>> > anything in that range.
>> >
>> > Marek
>> >
>> > On Wed, Jan 3, 2024 at 2:50=E2=80=AFPM Jay Cornwall <jay.cornwall@amd.=
com> wrote:
>> >> On 1/3/2024 12:58, Felix Kuehling wrote:
>> >>
>> >>> A segfault in Mesa seems to be a different issue from what's mention=
ed
>> >>> in the commit message. I'd let Christian or Marek comment on
>> >>> compatibility with graphics UMDs. I'm not sure why this patch would
>> >>> affect them at all.
>> >> I was referencing this issue in OpenCL/OpenGL interop, which certainl=
y looked related:
>> >>
>> >> [   91.769002] amdgpu 0000:0a:00.0: amdgpu: bo 000000009bba4692 va 0x=
0800000000-0x08000001ff conflict with 0x0800000000-0x0800000002
>> >> [   91.769141] ocltst[2781]: segfault at b2 ip 00007f3fb90a7c39 sp 00=
007ffd3c011ba0 error 4 in radeonsi_dri.so[7f3fb888e000+1196000] likely on C=
PU 15 (core 7, socket 0)
>> >>
>> >>> Looking at the logs in the tickets, it looks like a fence reference
>> >>> counting error. I don't see how Jay's patch could have caused that. =
I
>> >>> made another change in that code recently that could make a differen=
ce
>> >>> for this issue:
>> >>>
>> >>>      commit 8f08c5b24ced1be7eb49692e4816c1916233c79b
>> >>>      Author: Felix Kuehling <Felix.Kuehling@amd.com>
>> >>>      Date:   Fri Oct 27 18:21:55 2023 -0400
>> >>>
>> >>>           drm/amdkfd: Run restore_workers on freezable WQs
>> >>>
>> >>>           Make restore workers freezable so we don't have to explici=
tly
>> >>>      flush them
>> >>>           in suspend and GPU reset code paths, and we don't accident=
ally
>> >>>      try to
>> >>>           restore BOs while the GPU is suspended. Not having to flus=
h
>> >>>      restore_work
>> >>>           also helps avoid lock/fence dependencies in the GPU reset =
case
>> >>>      where we're
>> >>>           not allowed to wait for fences.
>> >>>
>> >>>           A side effect of this is, that we can now have multiple
>> >>>      concurrent threads
>> >>>           trying to signal the same eviction fence. Rework eviction =
fence
>> >>>      signaling
>> >>>           and replacement to account for that.
>> >>>
>> >>>           The GPU reset path can no longer rely on restore_process_w=
orker
>> >>>      to resume
>> >>>           queues because evict/restore workers can run independently=
 of
>> >>>      it. Instead
>> >>>           call a new restore_process_helper directly.
>> >>>
>> >>>           This is an RFC and request for testing.
>> >>>
>> >>>           v2:
>> >>>           - Reworked eviction fence signaling
>> >>>           - Introduced restore_process_helper
>> >>>
>> >>>           v3:
>> >>>           - Handle unsignaled eviction fences in restore_process_bos
>> >>>
>> >>>           Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> >>>           Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>> >>>           Tested-by: Emily Deng <Emily.Deng@amd.com>
>> >>>           Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> >>>
>> >>>
>> >>> FWIW, I built a plain 6.6 kernel, and was not able to reproduce the
>> >>> crash with some simple tests.
>> >>>
>> >>> Regards,
>> >>>     Felix
>> >>>
>> >>>
>> >>>> So I agree, let's revert it.
>> >>>>
>> >>>> Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
