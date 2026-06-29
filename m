Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3978C43602
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75CBB10E198;
	Tue, 30 Jun 2026 07:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ifaenfxb";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F1810E8DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 13:57:01 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-80c5cb9a888so19017487b3.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 06:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782741420; cv=none;
 d=google.com; s=arc-20260327;
 b=DyEe5vp73u8xtgRMJq8Wa6yvRMZY9zQjQewUW42mQENXsZ0nPokoKbuqr/7HuisfZH
 iDGlcAUWRY4BNaoLWw4bAEOup68FYJA2TFv8/zdDJw3Ry4GAY8JrCMm2KzJueoknuEyu
 O9CydUMGMVRCeHzxG/mkpVM1UneyQbIk+m3KOMQK38Cp1TK2gF5VESPFyxCHXZzYN+yr
 Z9q43aGmhlyQkvKnZ0QeP1dnR4+2fimZBOLJj+6Epo+S39ORqWFHJ7H+w1CCm4mPx2Kq
 xJLLSWDyI6IBnFpPUJHoASia1SUvIQUdfc/686Hogsgf1lddaIGjD5jbXPim1V6fKtt/
 K+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:dkim-signature;
 bh=GgwHmQNiGftfM4Rvb8+WbihD7Vl9XT13f1KvcgOYD/4=;
 fh=R0kX7RA/NbHkF43LaZBt/Dipjej1ROGpha1btKAupWI=;
 b=DJ+m4g8lsCWZOM84/Xhc3IGJf8JGBCkTAyBw9uzW8dSXjXwUaplioykbqRo/at5/m3
 0ipftHF1dKAH8E2KJhqFzcuh/wP3JhWUVI0YueEq5LTXO/QOsOyOldscXCoYSgtUTA0S
 K/YwZZD7DCac9Bi7OUJWngr2+jy6L+KiYgwGGJXYpt043wXQ2x4VzrDDfJAr+eE8RoTd
 sQ671gBUv+Mgxmwuqk04+kGWXF+dCNEa6MPYNE8wQZ8Xlzi2JIkWYW6MusyJxcpCniOa
 x9v4px/Z36F9bg1D7a2lpl9Tafxg/RKJfKpXlZBuHj76ke1n6shk/6NozLmyuzalhtH9
 yYJg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782741420; x=1783346220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GgwHmQNiGftfM4Rvb8+WbihD7Vl9XT13f1KvcgOYD/4=;
 b=ifaenfxbuypCxdYbmNMAyRH3xUSRGtpiiDcsZaa3DoEb2PM9Y7FTCexWFiVVkaK4di
 IRWl9Bv+YQNikIgGXVr7jOaql0d9DkZBTr1GD+E+QxcjobWAyYKd1WtfKZUDSD7f6YtY
 9zqw+9HASwaifyUl4YU789kar4tGa73QLtgaDDWH6hF1tVc1GO87QNPSnVbCJQVs0EYn
 BtFhZf1aRY1TNQ2YAf/+KYOHQ2/QkM1FyIPf7KvADWGIOSGs/0e6/CwotSSL7S/FB/jm
 E4EwZbtSpU7jB7GeDtKM1VhsntNnefDFyICpAgKIsc2kf8KpbSEsHOQxkP93GmhXfVEo
 puYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782741420; x=1783346220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GgwHmQNiGftfM4Rvb8+WbihD7Vl9XT13f1KvcgOYD/4=;
 b=SLgG+Nqvk3f2flCNudu+1A0dRwXb6KbgdWeno7JhrHszivcrZC6y5mZRMWLRU6zrnl
 pLNQK3jnidG5U/7evcRXN26ZvJc4JI5ijQEFW4hl0cWzNgNUa+vUgHflYTEA6x6UILPz
 X/MFyW8CwI6b20KJ7VSZkDbeb+wYXa4aZ3Uxgd02Q9o4wRXtLrMqTyCam6zbuSqZ28eG
 kCiEcFxBslZZgfSLpXtQgNr7dqe1FPg4BeRjcjG3EUwaEZaJjggqtCP+BDhejGNKL1B7
 33SkwR8eCw8bfTVMr49h+N7gWk5WXESsbxAG898j6QN6AhjevLQDAy5NCnTT0Th8nPA3
 CggA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3yggaLwZtw4PmNiKFUN6+64t66uQN5TG40kGFpZIyZ1Jz6CkOzqZrCDg+Q6rS9TxJLib2sCeQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYChMAEnIKo4g6be7Mq+SUITyVwwKD5GBCVhIwfxIg10mBovf+
 hmx7D/IjFifDYnpopQO5h/i8urB/CUAgWgiRUuC1D344qSlwojHOyVAqLrjo8QKmDLPoAkAIPpo
 gsPGKIoxDMSl+GFWV2wWX7S+1k2aXSDbA2Sz+
X-Gm-Gg: AfdE7cnYENFK5gEDsL6OkDfMuo0Yjb7oeIiIH/qQutMtbosWZQekUzM/K4K1E7/GPvI
 CRyaVRYVKPl4/32TvU+PYu5rkdtXkNcbXSr9V0d6BP6XMfGWBr9r+RVyo0LnL06HhJ0OyYyvz66
 zdjcEhUERjvtQAIumNupyhvypas4zfz6PqljbQciPdphYWXLnMuGwcYsBul2bRhLOYZNelrahd6
 ehntFTrNQm+DsnQ/YrQVSrEC2qXrcIiNNcBdS+cO4KLMzRZSCcFffCjwNxObXd9vNu7HYDiFcau
 b+PJ0dQ=
X-Received: by 2002:a05:690c:6386:b0:80c:85b6:75be with SMTP id
 00721157ae682-8109186d88emr5241967b3.71.1782741419655; Mon, 29 Jun 2026
 06:56:59 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 29 Jun 2026 08:56:57 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 29 Jun 2026 08:56:57 -0500
In-Reply-To: <63537951-2c16-4ce0-ab8a-067315833bac@amd.com>
References: <20260624172029.2508-1-alhouseenyousef@gmail.com>
 <20260625135341.1159-1-alhouseenyousef@gmail.com>
 <CAMuQ4bWVb-vxCWMxF_JpJmBnKD=rVH2KZWf36jnzPbC35CdrmA@mail.gmail.com>
 <63537951-2c16-4ce0-ab8a-067315833bac@amd.com>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Mon, 29 Jun 2026 08:56:57 -0500
X-Gm-Features: AVVi8Ce95FJU1tUzW1L8s63UJlluxab-3LuvsLRAn19TFAa3RcTbRjB_TqHo-4k
Message-ID: <CAMuQ4bUio-XcOTDMY6r+Momg24uy7j0UXT=Bsk85jTbvjiCN7g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: reject mapping info when BO VA is gone
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:28 +0000
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

No, you are not blind. I generated v2 from a local branch that still
contained v1, so the v2 diff added a second check on top of the
intended one. I then mistook that local state for the target tree when
withdrawing it.

The close-handle race you identified still calls for the single check,
but neither of my postings is suitable as sent. I will prepare a clean
v3 against the target branch.

Sorry for the confusion.

Thanks,
Yousef

On Mon, 29 Jun 2026 14:33:37 +0200, "Christian K=C3=B6nig"
<christian.koenig@amd.com> wrote:
> On 6/25/26 16:26, Yousef Alhouseen wrote:
> > Hi Alex, Christian,
> >
> > Please drop this v2 as well.
> >
> > I rechecked the target tree and missed the existing !bo_va check in
> > AMDGPU_GEM_OP_GET_MAPPING_INFO.
>
> Am I blind? As far as I can see at least the code in drm-misc-next doesn'=
t have such a check.
>
> Regards,
> Christian.
>
> > The close-race case is already handled
> > before the mapping list walks, so this patch only makes the later check
> > unreachable and changes the errno.
> >
> > Sorry for the churn.
> >
> > Thanks,
> > Yousef
> >
> > On Thu, 25 Jun 2026 15:53:41 +0200, Yousef Alhouseen
> > <alhouseenyousef@gmail.com> wrote:
> >> AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the GEM object from the file
> >> handle and then locks the object and VM before resolving the BO-VA. Th=
e
> >> GEM object reference keeps the BO alive, but it does not keep the
> >> per-file handle open.
> >>
> >> If a racing close drops the last handle reference in that window,
> >> amdgpu_gem_object_close() can remove the BO-VA before
> >> amdgpu_vm_bo_find() runs. The ioctl then walks the BO-VA mapping lists
> >> unconditionally.
> >>
> >> Return -EINVAL if the BO is no longer associated with this VM.
> >>
> >> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> >> ---
> >> Changes in v2:
> >> - Describe the handle-close race instead of an initially unmapped BO.
> >> - Return -EINVAL instead of -ENOENT.
> >>
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
> >> 1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gem.c
> >> index 212c14d99..6f5b6f4c2 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >> @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev,=
 void *data,
> >> struct drm_amdgpu_gem_vm_entry *vm_entries;
> >> struct amdgpu_bo_va_mapping *mapping;
> >> int num_mappings =3D 0;
> >> +
> >> + if (!bo_va) {
> >> + r =3D -EINVAL;
> >> + goto out_exec;
> >> + }
> >> +
> >> /*
> >> * num_entries is set as an input to the size of the user-allocated arr=
ay of
> >> * drm_amdgpu_gem_vm_entry stored at args->value.
> >> --
> >> 2.54.0
