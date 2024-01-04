Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459D8C47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 18:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 516A810E4EE;
	Thu,  4 Jan 2024 18:30:09 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF1010E4EE
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 18:30:08 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-555e07761acso1039481a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jan 2024 10:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704393007; x=1704997807; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DbxwK1KqMVdvr+v2dOve5+iRXUnV8TbZJ/rIQ6a4f0=;
 b=DpaZY25FZwgD9Y79Nc9gVKMt5sG2K4JyvfRNdXLe88v14+5aX/HcgnlqyVH4xTk51b
 p8qsTgxHNKH+RQOG2y7nlc+ac/5qtp/OV7ManpBd4F42XwsyErFWcm4+4kjpwpelN3dS
 PlrIBPOKdjY/43GTNzqTYyi+cPmaQYat/hw4B3ZPizmdKGSMVyPIW3R9spDPyE1pNvhN
 bQWazI2a8p8rvgzV4U8mo+tNRpWH42mKf4sZ8V2g87Ljc4iaNGzspm4VLGNCrY2LlU58
 8HNATiN2KUoa9aw2QMFjlS+D4s4HI1TWDFU0L2kKkRgOUVDKvtjB0ZC77cKrMHYCbbAY
 Px6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704393007; x=1704997807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DbxwK1KqMVdvr+v2dOve5+iRXUnV8TbZJ/rIQ6a4f0=;
 b=IFoGwg/Zj9E+I2ZZ+yqeH82GJ1iAOZ/s4vH01HpLWBmBDeA74i9bPLvS1MoBkobOet
 v6Db9mmLlNkmJqZf/2lsjsNeL/cjTe92nf2sHOiePintGdax/jLbsJrogJ0A/pu70Zzg
 wEn0lqLn5Njtm5kWgeax4CZsiKK9A/7wyNCf2q0VmjnrQSnTBLRiBqv0IxQWBIXYscDE
 OldKVSrqOohLTOalu8HKZoCDUTFo2UR3qBVBPpeo4X6RBHAobspT2qROfYsIJ6p8Nq5E
 yA5pkt3MHHRO8F1mw6/bgWSi5GMjGcG5XO3tm2j8Sm5bmXGwdZG7lZuPhmuOMzx9Bqiq
 eLUQ==
X-Gm-Message-State: AOJu0YxqmnY1u1iKGa7vTZ9q8FeKxBrY811ZzVCa7NeD544gyhLgIhgV
 UL1X+TDGbgg3ijaP6eG8u1805G/McBNTxXHH+Ms=
X-Google-Smtp-Source: AGHT+IHwqHk82TqSU7Tcw8T80dlw+iMpuWnBwGcNjGAYbzePQcqQ8WH2rVm68YaYx/XTgKJYfH6zpS5CuzI4/K8x3SA=
X-Received: by 2002:a17:906:53d1:b0:a28:a8b9:5e1c with SMTP id
 p17-20020a17090653d100b00a28a8b95e1cmr368594ejo.53.1704393006843; Thu, 04 Jan
 2024 10:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20240103043000.23971-1-ent3rm4n@gmail.com>
 <CADnq5_NexkgrEKbM39QVGo+hOmd2G0Yc0sui3jWuJsKAyb3ONg@mail.gmail.com>
 <10b32f43-7b0c-1232-1070-cf51731c5d5f@amd.com>
 <0416969a-ddf5-4c6b-9017-6a6a4384b163@amd.com>
 <2e8cd9ed-bdea-eb54-99f1-a7b854594b69@amd.com>
In-Reply-To: <2e8cd9ed-bdea-eb54-99f1-a7b854594b69@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 4 Jan 2024 13:29:30 -0500
Message-ID: <CAAxE2A6YdbbC0EKWTdAMLQK9tKmO3v17+yPvhqfby2P_bfH1pw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of
 VM hole"
To: Jay Cornwall <jay.cornwall@amd.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Kaibo Ma <ent3rm4n@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

I have received information that the original commit makes all 32-bit
userspace VA allocations fail, so UMDs like Mesa can't even initialize
and they either crash or fail to load. If TBA/TMA was relocated to the
32-bit address range, it would explain why UMDs can't allocate
anything in that range.

Marek

On Wed, Jan 3, 2024 at 2:50=E2=80=AFPM Jay Cornwall <jay.cornwall@amd.com> =
wrote:
>
> On 1/3/2024 12:58, Felix Kuehling wrote:
>
> > A segfault in Mesa seems to be a different issue from what's mentioned
> > in the commit message. I'd let Christian or Marek comment on
> > compatibility with graphics UMDs. I'm not sure why this patch would
> > affect them at all.
>
> I was referencing this issue in OpenCL/OpenGL interop, which certainly lo=
oked related:
>
> [   91.769002] amdgpu 0000:0a:00.0: amdgpu: bo 000000009bba4692 va 0x0800=
000000-0x08000001ff conflict with 0x0800000000-0x0800000002
> [   91.769141] ocltst[2781]: segfault at b2 ip 00007f3fb90a7c39 sp 00007f=
fd3c011ba0 error 4 in radeonsi_dri.so[7f3fb888e000+1196000] likely on CPU 1=
5 (core 7, socket 0)
>
> >
> > Looking at the logs in the tickets, it looks like a fence reference
> > counting error. I don't see how Jay's patch could have caused that. I
> > made another change in that code recently that could make a difference
> > for this issue:
> >
> >     commit 8f08c5b24ced1be7eb49692e4816c1916233c79b
> >     Author: Felix Kuehling <Felix.Kuehling@amd.com>
> >     Date:   Fri Oct 27 18:21:55 2023 -0400
> >
> >          drm/amdkfd: Run restore_workers on freezable WQs
> >
> >          Make restore workers freezable so we don't have to explicitly
> >     flush them
> >          in suspend and GPU reset code paths, and we don't accidentally
> >     try to
> >          restore BOs while the GPU is suspended. Not having to flush
> >     restore_work
> >          also helps avoid lock/fence dependencies in the GPU reset case
> >     where we're
> >          not allowed to wait for fences.
> >
> >          A side effect of this is, that we can now have multiple
> >     concurrent threads
> >          trying to signal the same eviction fence. Rework eviction fenc=
e
> >     signaling
> >          and replacement to account for that.
> >
> >          The GPU reset path can no longer rely on restore_process_worke=
r
> >     to resume
> >          queues because evict/restore workers can run independently of
> >     it. Instead
> >          call a new restore_process_helper directly.
> >
> >          This is an RFC and request for testing.
> >
> >          v2:
> >          - Reworked eviction fence signaling
> >          - Introduced restore_process_helper
> >
> >          v3:
> >          - Handle unsignaled eviction fences in restore_process_bos
> >
> >          Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> >          Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >          Tested-by: Emily Deng <Emily.Deng@amd.com>
> >          Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> >
> > FWIW, I built a plain 6.6 kernel, and was not able to reproduce the
> > crash with some simple tests.
> >
> > Regards,
> >    Felix
> >
> >
> >>
> >> So I agree, let's revert it.
> >>
> >> Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
>
