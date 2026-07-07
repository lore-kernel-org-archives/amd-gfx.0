Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8294BC43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 18:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 172CE10EEB6;
	Tue,  7 Jul 2026 18:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q0yw4Ybs";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E90210EEB6
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 18:13:06 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3856d4015e0so305578a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2026 11:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783447986; cv=none;
 d=google.com; s=arc-20260327;
 b=F6DC3Kb9GQw0WFcNj78KO2lxf6PFbsNrW7p0TAVB1aUxf15w8MImmMlhP1AmtmMC9a
 jx+wzPS1tJd1FgP4r0qKO/VdS9XdT7z++uo3N/2oQJjNl81eIDOmzgLOgxXU3hKJyEWz
 HLbe3BRPfAfXh+O2fy5Bi/uc63X7cUyo2XOMfJuKHZnKRdRR5O1San4Qkd4PjzmJNhBv
 pkIstyjP37W0HWBwqbNCe78rkpkdUg8nInd2KUE0lkcXFj98XxkqrFPDf63lKPM59umC
 oE98VqpRt89EXfk9S9+eKd+rC7oLrXg9r3d7DDcFY6xoS5kAoMr5bzqL2fy6mvZUMagK
 6U7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kqdEQqGxI7vgb8pogihq5FM0tpdEo42yoW6988L8HP0=;
 fh=rzW1zAWW4fZXndHMusocLcbWblKj9BxBu4UGUc7n/jw=;
 b=f6IJnaBZfwbdr2Qz/ZLku07mjUhew4ESjMBiOOTqDmCjiR366K04rX6TYFbO/SNnMr
 mt/l36jJZ1oe3oIavr27/mWrPM+f4HzxodoBYI5gUT07xJ990V10lU2nJbT6H3yNsbI0
 QdEMKr97n0Yd5qQhCdGW1q/k7dtiocobjAiupTZZvcnuBHdZUSGXKy/TauUvgg+c07bj
 z2ZbLc4dj0JxxtwjuCF46bEAPz2XsKcDAgc4yMd91YO0js9ZSuvpHQY9vKlu2HF+f1Xq
 j01h1bY3l+eONqX8BBrd+ev6bg6fGepQ9vXOd+06rXwFFIHth04+75zoLCwkIlCHGIyN
 94Kg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783447986; x=1784052786; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kqdEQqGxI7vgb8pogihq5FM0tpdEo42yoW6988L8HP0=;
 b=q0yw4YbsckrRuO2bR3x4GrGVytoHA5RrWlarl5/rogHXn9aAA58fJDHLBBHTeq459k
 RWGyBVbHitLN13gzCEfS0by8pxPD1GDQR6nkx0vimJ9iCkRMCMv/xpf1tIgf43PytLwO
 KlX4lHxL9demBITS5J6xyl4WehNgCHXeee7fY7Cy1Xb2AqdV4Wcc05aDuEDQVh64MosM
 /GGF/xaqBsbJzb06ltDlR6QiIrg7ZildhQ77e5XWrm5w4sadBPK1KZy3HhmtAm5V3+IO
 rV/39CMyQlJYTOt9RlGhEpMNvYcXZ2aVyZr0cUP69v5QvnN8xvD1SAPGXxLoW3G84la/
 0iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783447986; x=1784052786;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kqdEQqGxI7vgb8pogihq5FM0tpdEo42yoW6988L8HP0=;
 b=HCgvrHtMNnFJeNZe4jvQWAktyf1Aw/I87Q9rUXuYs/fpEBK2V5mMMf/cc7GiVkX17w
 yEiT+Jnu5j2KfydePA9npxrRId7zKCdXV5IHyU76xh9KuG7O4w7wDjakHvY7oKFKlpKe
 KVVgMUpfEwLuQ4umWpWeL2gBx7Gdczs55+pk0CZXeuZxlMVYZrHcZZ/bfCS7optlXxd7
 Hpz/H00RGKITuCzPmBrPF2VCp5lj/vBBg0wkOcA88wKVWxdQ7GWl3G9+n9oEXk9f5lYg
 XFWXovHTO88sDCGOfhDr8738/REFecSAAjBXj6ifUzybk4mk78MoDXabVEMqaYLDzXg3
 FWiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3/9lqLZWW0FJQpO2h5h5GWFi1Ypjm1E6uVrQZ+z6OMTWBTJgcoSL6bgyboK1egt8Hebp4IZjx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjuxAs+/257IKXSz+nu9qk74ypPiMhHLAkvEjOnMBudX8jnalk
 TBa4fEnGtY2IEcXc97xtqZTbK9b9shIOJpF6RQQcMKJn5ZselMYvU3cakETAuYljaQ30uUO57ue
 8tn5Xwb4Jg4zptDVfiBzssnIpa8FUPfI=
X-Gm-Gg: AfdE7cmlaHfAhEsNi0LKttWFp4m/eiAOqbIgri5aNqrY7+V9JVu4twtKA8QcZj1LgM2
 rE+o4c2pvtVwEwSXqSrdYQZqjiUJu12b9RqreSp1HHuJ+9xDsGCp2muYF/bx4Xnkt7xz9NNhZP9
 heCQKm/491OlCXr20uDQju90NYk2BrbT43SvrHl34fcFwq1a0G90VM+9Lhhaxf/OVq7D01Tr+vd
 Z4SdX+VpWIFlIOtdsncuza6YduaGL0L1s6yzwmdmg+xNMJSH3pAm6OGZz0RDuEWc0PjxEfDc7ka
 vqRImot29tr5x2GUeKuP70BnefkAEM2MXNKpCu8tEyqEZk9tHeJOClzHw4g=
X-Received: by 2002:a17:90b:510b:b0:36d:de94:f31 with SMTP id
 98e67ed59e1d1-382a05aef5bmr10041142a91.7.1783447985781; Tue, 07 Jul 2026
 11:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260707093812.109176-1-marco.crivellari@suse.com>
 <12766042.8bMQJbFj6T@timur-max>
In-Reply-To: <12766042.8bMQJbFj6T@timur-max>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jul 2026 14:12:53 -0400
X-Gm-Features: AVVi8CcFtIefmJgVcRFeNq0XkI_qubOg5oXAk2MnXUnij9hKh_kHzDeX4SXC8zQ
Message-ID: <CADnq5_MHa8L9gWutwRKBQQ5QuM=5qd8eJgC8ZYKyBQQ1J9NUZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Change system_unbound_wq with system_dfl_wq
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, Marco Crivellari <marco.crivellari@suse.com>, 
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Christian Konig <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Ce Sun <cesun102@amd.com>, 
 Tao Zhou <tao.zhou1@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>
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

Applied.  Thanks!

Alex

On Tue, Jul 7, 2026 at 7:02=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> On 2026. j=C3=BAlius 7., kedd 11:38:12 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Marco Crivellari
> wrote:
> > system_wq (per-CPU) and system_unbound_wq (unbound) are the older
> > workqueue name, replaced by system_{percpu|dfl}_wq.
> > The new workqueues have been introduced by:
> >
> >   128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> >
> > Usage of older workqueues will now trigger a pr_warn_once() because the=
y are
> > marked as deprecated as per commit:
> >
> >   64d8eae3f895 ("workqueue: Add warnings and fallback if system_{unboun=
d}_wq
> > is used")
> >
> > So change the used workqueue with the newer, keeping the same behavior.
> >
> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
>
> Nice catch, thank you Marco!
>
> Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c index 53be764968e4..95cceed4e=
971
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > @@ -545,7 +545,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev=
,
> >                        unsigned int num_dw)
> >  {
> >       amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry,
> num_dw);
> > -     queue_work(system_unbound_wq, &adev->irq.ih_soft_work);
> > +     queue_work(system_dfl_wq, &adev->irq.ih_soft_work);
> >  }
> >
> >  /**
>
>
>
>
