Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFFD10F92E0
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 17:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF59E10EC95;
	Tue, 31 Mar 2026 17:13:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fB3hpIOc";
	dkim-atps=neutral
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62AC010EC8E
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 17:13:04 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-46703fb602fso1963949b6e.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 10:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774977183; cv=none;
 d=google.com; s=arc-20240605;
 b=O6Y2GABxX4i3HYRi0L0umNF4gFZwmuMpW+6oGAkyjDhQbbcg44JGzPeqgr6EPv6gHh
 BnOjzA8irAn7jAdMZeKVsGxxxqNyLEL5oITlRHg7VCA55zOxGLwi+ENnMaKjBYsXPC/R
 47LQnfQR2kdxmgXyAXt6PAvMyFd8mu4KaWPvCxa1PcQgjoK5ffP4N8o0utQYmgG7EyLb
 Cz+PYM4KCj8FT5CIUOLEPnMfTdMCBKt69ClrN+HXgMqkTWTtonp01EQlcxFiUbw4xphj
 1gZSo3cZcpXe8jZpAk5TYU/vsK1WqAIry2gTbGwDVOvvR98ZUhnoycML0ApcYlJ4Q6Fa
 ck8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iFEKQ83y9bedeJoX/1IopbEkVlHg3BCGxN7/0fDF1QA=;
 fh=+SFKBuBhogmdwbC66+c3gv1mqWLMS//hio7zEkoAG/k=;
 b=efpz/wZprdCvpyoRmZbd9r3M9LmqavpfXmzLX7gUw0igyZi4mCtwBGYfdXwi+mUIz0
 ZeKsGh8+tgCrIG8avYpiEAPwQjplSOWVUMUie+bJl12+bdfEZ8z9+SLpn/octRMOTC9r
 uKlf0PocwAr1UR1sp4h3gUaqbNnXP42jsqHZpNh+dOqCVeUudF+gDH5eyfTiBYSOmGqt
 kKt23RRPSr+OlzcfgeHspYPlCiGOLGUd7Ufjmy9M9O5c3O0pEE5QzOvdq7ybvwDA5p8n
 MmcEVAC7o6W6bOlR4PYTTVUau4qygrzckH7a3rwbwhzz2zVeq5j1tJZ7xTE5UHMDShyK
 8b/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774977183; x=1775581983; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFEKQ83y9bedeJoX/1IopbEkVlHg3BCGxN7/0fDF1QA=;
 b=fB3hpIOcuSM9qW8TT2TNSX4Evvtz8Tvt1gqER1FHs2hdV4IZQ2XIGpe9is7/xl8cYG
 K9XuGogubbtLZCrjPUQUXQtBYROr2VeRHbVBSEggifawsxUr2r55goEZniKj7g1q9c6h
 iD/V3Tf/leuut+SrOrYlJWhSpb6UGOZP7mo751w9TnfXQo8+odkBaGRFs7Pwu37nk/Ty
 KPJ6P+k14ORftil1VkjDw5eJ4qeUgTePHuCejOCPvoWmbZZUlxqHDtdXztyJY746qeVH
 Jmdkm4d3YZXH35RW8ONoAT9aUJ3WraG2FowWRaIobi4FC64BOiNxKv+0fxEA4NaHA6Vi
 EuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774977183; x=1775581983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iFEKQ83y9bedeJoX/1IopbEkVlHg3BCGxN7/0fDF1QA=;
 b=sz4FrTRrhgzB63Inm+y/W2ee6xaLNVIAje3Lsl85fsqZN3rYGsfCd6PZFIV/+9L+uo
 V+gpwZOz21gpxZUXvHsjcWWM/ZX0q7X53WoZJD2QmdXqsgkG02aybAPyHFx/HdxYlxvr
 UPmdT+HjJRrQWbTo+HGHYCqw0iwhJtRub95r9LdXMYSlEp6CdM2n4ZZHs0rknBw63sPm
 TzqEviBSy+NqHMkWidgtZAPZg7fwIp25L1x55xjJjP7f3MA82pxzsP/09ovknIkZ6owv
 ys8KQiH5De1Jnmrzaedfk2C0efQf6Z8lK8XhnioWR5OumrrUoMv1frElGu+/naYMy6OQ
 yL6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTHr3W3/WqFbd3lmLT9vuCq4iAMqunT2clLNQjIt86oSagXS3ixURTIK+sbdxFgH7lky7QvzUP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIU6duOWN3cTucTDMwv9NbB1SRnmcfy17PzaRWBeuhQnb0U5Pm
 1YkY+S95/vGIj501UEqAhai4AFDrbYSwo0Dzu+SBwkl8hE3DKGJ9dymiLEazrBeT6ASzLuY+CK+
 QulFhnD8ZveLHGfyWe39yMGgh4nxtLnM=
X-Gm-Gg: ATEYQzw0VO5+qP+yum1SENMyXB3ZX7p8nLRIXwGjKYxYKVGSVNRk7A+euqQxPiCCnSH
 x9GrKQmgnZ1F9c2Ye5W83B8NTggACyq3f/SEuwIWoN5I+PFXK2HfsURvw8zbQhcU6Hrb2FSbeL9
 wqKbMejYVzb4D3dZBsv382up6pKjeglveny8hEtot5fVF77uVapILanwgVk7r/H2iW+/RsXVCag
 ZPnElfOCQd7pZS6NYr/Zs7sYa4gIEH59PoGOd+nYaOClZKnpx/FLRGSvybL2klD9pAzmsaPVxau
 UGcYW599sw==
X-Received: by 2002:a05:6808:c28a:b0:468:fad3:1303 with SMTP id
 5614622812f47-46ae0253498mr126746b6e.45.1774977183505; Tue, 31 Mar 2026
 10:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
 <845af7e1-3ca7-483b-a3b1-0840d9c98596@amd.com>
 <CADnq5_M-iwCHKJ+cnU1TQSc-aGJC465dwzWGQkhaZoSPz7Wu5g@mail.gmail.com>
In-Reply-To: <CADnq5_M-iwCHKJ+cnU1TQSc-aGJC465dwzWGQkhaZoSPz7Wu5g@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 31 Mar 2026 22:12:51 +0500
X-Gm-Features: AQROBzBzA9IUSBY7s1YWXyeLaMTcjuCvXtDiYrwavdp4mR0QqCiBggByPXI7qNU
Message-ID: <CABXGCsNcRQnQmsZJAhfJPsR71HXU5+CG4URJiX03xkPJD+f7SA@mail.gmail.com>
Subject: Re: [PATCH v7] drm/amdgpu: replace PASID IDR with XArray
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, lijo.lazar@amd.com, 
 Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Tue, Mar 31, 2026 at 7:38=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Applied.  Thanks!
>

Hi Christian, Alex,

While testing v7, I noticed that xa_erase() and xa_alloc_cyclic()
use plain xa_lock()/xa_unlock() regardless of XA_FLAGS_LOCK_IRQ =E2=80=94
the flag only affects lockdep annotations, not runtime locking.

The XArray API provides separate _irq variants for this:
xa_alloc_cyclic_irq() and xa_erase_irq(), both defined as inlines
in include/linux/xarray.h using xa_lock_irq/xa_unlock_irq.

I confirmed this by hitting the same lockdep WARNING with v6
(which has the same locking), and by reading lib/xarray.c:

  void *xa_erase(struct xarray *xa, unsigned long index)
  {
      xa_lock(xa);              // plain spin_lock, not _irq
      entry =3D __xa_erase(xa, index);
      xa_unlock(xa);
      return entry;
  }

Should I send a v8 using xa_alloc_cyclic_irq() and xa_erase_irq()?

Thanks,
Mikhail
