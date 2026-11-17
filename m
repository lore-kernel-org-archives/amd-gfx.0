Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D28606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gC1Gyngz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC5389322;
	Tue, 17 Nov 2026 14:32:01 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F002A10E1E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 14:31:55 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-4b392d5f989so321842b6e.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 06:31:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794925915; cv=none;
 d=google.com; s=arc-20260327;
 b=qem+xo3R1Q/shdkOY1RBhlhLAKEbUJ+Ecs05hGmqXyWVkihywiCq+M7hR4dAyhvwCr
 PHnfZwdCATBK7+YGF6cHDcSd8CYipflP50gHja13NyXoj7ne60T4NPmHEXodPBf9Il8R
 VBGuozAs5OTTNPW0bcPTn1MYcMxKpSWq04/WoJNwXmjWnQsXS7LqQYmaomenu2jhKp0j
 Hyd57zFfUJWTOjyiKQEaJlebxIHPDxYdSYa1i9ympWN3UKOrdyuRPYoz3tq+LRh9Zn3u
 0PaoposzxWsMd3mJh872uCeYxCVaL0BGUJ0GbdudRMnwj94wDpg1QqAcwRa3IxKSXbuk
 QBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nC6zvhzfeQ/lIBk+g06lUZe43s0IJ3+mwXdPWK9MxnQ=;
 fh=YsTm8cAqchpUoABCXBCCZPTiK/sE7ecdsXjq6pC2gpg=;
 b=AiNRJFJj4Z9zHh5iWVvIhP7hY81A4qPX0pKYAeKx2xgNHmTnOdeNCIB/8sD/lFcqOU
 1wsdsVmqJM4/kV0ipREt239wF6n9pv7n1DRM07srmHBi6tQG30QgHwyC/UiAMbbDjIMb
 fpsGLIgA6uixzifzx/iFGkz275qAZ2ONs7iDoBQpGR/B665c3rv1BXVJ/w+hbEjkrU8P
 p8rAJy4rzovIvLWEwpxr/uKjo1spGjgkgmf/umMFgXEFv7kYAQ2b6IHrey+SS1bDP+xF
 YBpcgEJ/W2PrlUmxcOAs28tEDrIYd3cifUKpPvPFVhv/0WfvKgT59whVmW+kwjIpOX0a
 +VGA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794925915; x=1795530715; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nC6zvhzfeQ/lIBk+g06lUZe43s0IJ3+mwXdPWK9MxnQ=;
 b=gC1Gyngzgkb8r5nWArtUSijUESHzEuRGIgNqLBN4JvlRjKgL9s1b+HGq8jjksYUUcn
 YOej2pBTUExKZdNz4Fhl14IKl+QaZnSs8Bd0xKUUB4skInliQ9oAMB24CXrdw8fae6Rn
 IewLja2vShpP7v+C1c8Z6PN8kuQE+Cl1SxjZotT7Muk/gZsBf22t8YpRZXcLERt4vvNp
 PlonFKnZAmPm9NzzNGUVEf/Rx3Mq9UExgo4Qn+7MR5kz8inOiTRiLq+8CcdIQ+TCkJmn
 aqm36lMmT0sr7lB2YbjKHdpGk2bbfO4WM2MqDpI5XoVB880iVOhvK/CotH5VDFVM90FC
 ulSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794925915; x=1795530715;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nC6zvhzfeQ/lIBk+g06lUZe43s0IJ3+mwXdPWK9MxnQ=;
 b=bUu8k1E3USNIevVQsEIBMp/sD9G+KXMPAs+fHUkX2tuMOVlywD2163HDY50nOFWGpn
 XdEJdlWhY/5BQcA7GnUjGzJEqClDsVHaGvROqpvnsKDvzSlY0lJCWu1sLigVw8YVDich
 KFbCWVBTACT7Q7TSGoHQ2mqEwB/4h+svOraorEsAYZ5I+tL0aagiAKZgxtL4gH8UqEjc
 yr3SQQ/XnkaQ8CdETUuo7IGzcjB28+QOCKpv9+LgGjzq4RshYB69TzWVM5sxZi+13jwx
 kEbxjcs7t9TxP/zhcI9RzDuK3XwflDpOTlVF3OQ5gQptYomAyG2Ux7CvjWCaBBkibGkZ
 nulg==
X-Forwarded-Encrypted: i=1;
 AL+hErGQbp/mkZgVDu7ltFv4zGyt4FOGQ7usOAFPB64he2AefCPXGcJTwEvVJ4K5QQBhHGgxyU3cHKwK@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+kceAAJwujgKZ0KCC0928OB4jbferMhkw0xq98rnzYG97JiCVo
 udjHwhGvhtoVJlKjasB2tm84Avfqn4IlnsCvQcD7jHN8Vh5ZFXIFJGDZzNLzweL+6c0TzHI6UvB
 C2DRbD5lmz3BPPYbr5w1FcQAIEGmUNas=
X-Gm-Gg: AYBFou2fNnKglK93eB0/DhYEVc7IcHmvw7nonX2mntshGh8wVdaxHApnBI+2GLnVtVl
 ES5M+9ha+rii2nMRVctO+5/DfIhPqk0Nce7iJcK8pOhsOKHdyfqmRnhMWoVyxbEDzQtrysEP1Ts
 g/lrhGbXqlJVxkCYYRzAyZ/5f7C8IOu5nPNXFvs3iuVSaNMmT4cW9uMdFBScAlAQfLPCIFm9YcF
 Chqs4cxIudbQ2w2NTXRN1VYQqk9M3NgHiK7mayRljH5sk5FZANPCJRLWo90UmkMhxcpsMK6LMuZ
 CsUY1BgXdB4UG9kVFGQ7wIavI4K6xXBbzIjbSMNlap35H1Hrkxt463csqWcyUAmR1wO4aw6aKlN
 jLZSY1NMSPlUaXmflEC+AjMjv1lgngXMolllKrlBxZreUsiMOEq1xbGN6Zb5L3VkQTw2pphabmO
 17zi8b78x8OIgynUS+hZTRHmGJ1pW86OC9xhBEioxdYl5SirI2xT4dverrY/OB+31VlLddUxcGG
 cifZOIO
X-Received: by 2002:a05:6809:115:20b0:572:6f55:8005 with SMTP id
 5614622812f47-5726f5586bemr7180928b6e.6.1794925914952; Tue, 17 Nov 2026
 06:31:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-amdgpu_partial_mappings_fix-v1-1-02c5dfa20889@igalia.com>
 <8333ede5-3833-4465-9eaf-ab9d1b75ca89@amd.com>
 <avXLe9-R-yzQzGU_@quatroqueijos.cascardo.eti.br>
In-Reply-To: <avXLe9-R-yzQzGU_@quatroqueijos.cascardo.eti.br>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 09:31:43 -0500
X-Gm-Features: AclHuK9LGwIei3kNk6GQPB5TgK2HGSQEEMxLLWa2HUwan-CfVM_r0WjhkJskoNE
Message-ID: <CADnq5_M1Xo2LR+8WuX3xxxgqNjOBGiFA8RLYw1LWxjeSR+zGkw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clear the entire mapping when partially
 unmapping
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied.  Thanks!

Alex

On Fri, Nov 13, 2026 at 8:51=E2=80=AFAM Thadeu Lima de Souza Cascardo
<cascardo@igalia.com> wrote:
>
> On Thu, Nov 12, 2026 at 10:24:04AM +0100, Christian K=C3=B6nig wrote:
> > On 11/11/26 19:28, Thadeu Lima de Souza Cascardo wrote:
> > > When we partially clear a BO mapping, we only add the partially unmap=
ped
> > > region to the freed list. That will update the page table to clear th=
at
> > > mapping and leave the other endpoints mapped.
> > >
> > > However, we move the endpoints to the invalids list. When later closi=
ng
> > > that BO, it will simply free the mapping and not clear the GPU page
> > > tables.
> > >
> > > Drop the optimization and clear the entire mapping from the page tabl=
es.
> > > As the endpoints are already in the invalids list, when that BO mappi=
ng
> > > needs to be accessed, the page tables will be updated.
> > >
> > > Though that may clear, then write page table entries and even lead to
> > > new page table allocations in certain situations, those would already
> > > happen in the clear path.
> > >
> > > When measuring a given workload, it was noticed an extra allocation i=
n
> > > less than 10% of the cases, but no noticeable extra latency. In any
> > > case, correctness is more important and this fixes the scenario
> > > described.
> > >
> > > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> >
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
>
> Sorry that I missed a Fixes line here, if possible to add it when applyin=
g,
> I believe it is:
>
> Fixes: 387f49e54672 ("drm/amdgpu: fix clear_all and replace handling in t=
he VM (v2)")
>
> Thanks.
> Cascardo.
>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vm.c
> > > index a99c2ef14be9..808b77083a5e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > @@ -2108,12 +2108,6 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_=
device *adev,
> > >     list_for_each_entry_safe(tmp, next, &removed, list) {
> > >             amdgpu_vm_it_remove(tmp, &vm->va);
> > >             list_del(&tmp->list);
> > > -
> > > -           if (tmp->start < saddr)
> > > -               tmp->start =3D saddr;
> > > -           if (tmp->last > eaddr)
> > > -               tmp->last =3D eaddr;
> > > -
> > >             tmp->bo_va =3D NULL;
> > >             list_add(&tmp->list, &vm->freed);
> > >             trace_amdgpu_vm_bo_unmap(NULL, tmp);
> > >
> > > ---
> > > base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> > > change-id: 20261111-amdgpu_partial_mappings_fix-c48d729ef590
> > >
> > > Best regards,
> > > --
> > > Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > >
> >
