Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C17C05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 20:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0072F10EA47;
	Mon,  6 Feb 2023 20:26:50 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA7510EA47
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 20:26:48 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id bd6so1809742oib.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 12:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYWAc5YnSQeIKbO6g/UZVz1Fvj5dC6iIc06j4sDIuz0=;
 b=LdsU0NeJTEdw/XDUi0KX128+MgxpQ0+WFYiRjyUflZmmAa6uc/wA9raiiingHmPaj+
 JpIgf8VxbM+2MA1knWNmL/TSDQ/UNxQ43kH6Cii/pHW+sT9BykedvxZJhiGQ3cm419Fd
 U+fmNCI7vKjo8kTXwBVY8kA7PCW4MrRn6hEgJEno1O1sWADeFI8t/CWCqO17Kr2dSCg1
 5OkWIxUh4ifJ4sxIi9wqZZROL0g8DGtAYAGG4P9/VrMbUPcm8IxkB2VHv43d2loztafm
 mU/Z3MsUkCyqcnHFTabH50XNILAdk3/oVb22Yi1YsCLEiXP9Z39PvgVZlC12sCAnr189
 YIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dYWAc5YnSQeIKbO6g/UZVz1Fvj5dC6iIc06j4sDIuz0=;
 b=JnJJzn5cGLrJV9luQg+Cc2fbDVyntCvqam2vQ51AL/A1ygAJu/MT2VXxMC2PR8nXaG
 CUrnvi4/SRDfUhyJb1UKKAbPqVDLfBlaHQWTUIVoHUA5GmtEm4YPuQGrrtu9S6GzOqf5
 /HOUg9DCC0EM7M/8+YTYNFgDzjpWN+PP2aAKmSA95uTw4o8Jif7pWOtZj/HSi/A53CNn
 zyDs81LV9+eS6EgWZ+ahGFngzsgEe5xR18gqbjeRIyK1aG+MbgWhkiKjB91WAJRiDiHK
 6nzIpt1mUkhsfatTXN7liZQKTNmVUfE6bWDAp66Y6jNNHTDSQqPPk3vYnd2HzhcPOCBM
 JKKg==
X-Gm-Message-State: AO0yUKVsDQbYEOHGi06VgXXL6pcfu5rWTIJvEfDA0KaoCd/4wm4Ow4vH
 0/lXX7Eko/qaAQOpGNFvczZJUfo/l7vp85n6EX9Mg0Uh
X-Google-Smtp-Source: AK7set/aJ8saEGoMOBdj1CJtfWiWyruAnVxVClRp9Xes9i82kKFKqHTeYBZyP5V8MyWrX2JdIXJRdzST6S515SqjRas=
X-Received: by 2002:aca:654d:0:b0:35b:d93f:cbc4 with SMTP id
 j13-20020aca654d000000b0035bd93fcbc4mr72632oiw.96.1675715207434; Mon, 06 Feb
 2023 12:26:47 -0800 (PST)
MIME-Version: 1.0
References: <20230202162103.5811-1-friedrich.vock@gmx.de>
 <44330b41-b7a9-d82e-2614-e9fd291e356f@amd.com>
In-Reply-To: <44330b41-b7a9-d82e-2614-e9fd291e356f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Feb 2023 15:26:36 -0500
Message-ID: <CADnq5_M--J7ERZqLML3SL56zj14RkSe7YVnDwv22nHtjyZJ1RQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use the TGID for trace_amdgpu_vm_update_ptes
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Feb 6, 2023 at 3:35 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
>
>
> Am 02.02.23 um 17:21 schrieb Friedrich Vock:
> > The pid field corresponds to the result of gettid() in userspace.
> > However, userspace cannot reliably attribute PTE events to processes
> > with just the thread id. This patch allows userspace to easily
> > attribute PTE update events to specific processes by comparing this
> > field with the result of getpid().
> >
> > For attributing events to specific threads, the thread id is also
> > contained in the common fields of each trace event.
> >
> > Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>
> Ah, yes that makes more sense. Reviewed-by: Christian K=C3=B6nig
> <christian.koenig@amd.com>
>
> Alex do you pick this up or should I take care of it?
>
> Thanks,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_pt.c
> > index b5f3bba851db..01e42bdd8e4e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > @@ -974,7 +974,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_p=
arams *params,
> >                       trace_amdgpu_vm_update_ptes(params, frag_start, u=
pd_end,
> >                                                   min(nptes, 32u), dst,=
 incr,
> >                                                   upd_flags,
> > -                                                 vm->task_info.pid,
> > +                                                 vm->task_info.tgid,
> >                                                   vm->immediate.fence_c=
ontext);
> >                       amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_v=
m(pt),
> >                                                  cursor.level, pe_start=
, dst,
> > --
> > 2.39.1
> >
>
