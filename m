Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28C5C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 07:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 638A510F2AE;
	Fri, 12 Apr 2024 07:44:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="iYTiuvbU";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491E910F1AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 15:44:44 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-56fe56d4d9cso15091a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 08:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712850282; x=1713455082;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8+kSzR/bbUG7SZ7+vYBto575ROCoi2amnwoZ2CSD14=;
 b=iYTiuvbUEzyIpJDokOgecMhkGxcqJxuaPh/coFsF5BcHPSfXoIKX54R7y/+BY3PR0d
 hbCg5AHg1DRusW0trxCQ+a2cXhinHNRtiynIebMOX2Dlt2pTliqo3sHx7GJn63G5KTLH
 KrceDdEeXm8nzdVQMPkwbH6VcvzClcyJYGFtUlV+7CfJkCVG0fgNuPVqlbOiSFSOxpRV
 0dJXMqwK9V20xk+zoKGARRtgcRzyqNgHY/vyWrpqY/EayeFqNYgH9bfXFZpN5H5t2Qox
 z3hlvc076RDxm9A+LfkkraFyR3YVO2w5HNirvcYQ0j0qpxJT5wIg7zFggYv3XtiFBaHV
 jamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712850282; x=1713455082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8+kSzR/bbUG7SZ7+vYBto575ROCoi2amnwoZ2CSD14=;
 b=lOs1K4LA7pZSnM0ZdRciUQJnCFda+3D8YcsbdR+VcPYkkYLklhkcWC+qjwwI0kICx7
 NnDqw1Nnkdm66U2WiURs5Vrh9qr3rGXL7KOLZd3j2vqhg9Bvwtwj4aC2K+fVT4ScE2cb
 Zkg9opo2dD+ZP+ehCuNASCpQYs1jj2yNiH/AnjXPzbjyXwQX8KkV1K+QknIg7F7xtLcN
 duBJPPCsWXZr1WLJzlQuB7/waSm04jzf3bGUpnE61dxt/XSfbI8t9/o7uRjudZrScRi7
 bNe/y2Xrp9VxFdHsg3kZACbjR3k+3eorBGPHIYV7SJpNYdAOdZNqT+wjVbLemIduVJu3
 cr2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSoZOCSmQm0Db/8onzPi4P5Ssin7rkopDKGukQ9cM6/AldOosOYvnEA7smUuqv0Pye4QQX1a4FzqnpO8Wd9xifOo57zebF8YWZqhcP/A==
X-Gm-Message-State: AOJu0YzqTSR+9ozSl2BNlqUdJmTuxXqlTPmUrMFbUgg5dnSReDIpCC/5
 zJ+vOlULuRtyhX3Ipgxo0mAl25RPG8IKT/kOQsXz1Op8iQHFexzF1HfyzE7ysV/sRIqKwucRbVh
 my/f3/xBCtQ28HclziEIUAZZy1QcsYwF/qc42
X-Google-Smtp-Source: AGHT+IGztZsMRxnrz1w1/0xkGy03uvIpUYjnocxjeFMwQ8tjzbL9RtzokaDIHzz+LwUmjLxOU7mj3MYPjhNn8yHfjuI=
X-Received: by 2002:aa7:cf08:0:b0:56f:f510:671b with SMTP id
 a8-20020aa7cf08000000b0056ff510671bmr34321edy.2.1712850282263; Thu, 11 Apr
 2024 08:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240411032844.41839-1-xinhui.pan@amd.com>
 <81623e99-58d0-4ab8-9e8e-6b75351a6729@amd.com>
In-Reply-To: <81623e99-58d0-4ab8-9e8e-6b75351a6729@amd.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 11 Apr 2024 17:44:04 +0200
Message-ID: <CAG48ez1WFe9C5B3a8A8TLSUE51UBNDzN993ybqFAOpi4hf=UCQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: validate the parameters of
 amdgpu_vm_bo_clear_mappings
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, Vlad Stolyarov <hexed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 12 Apr 2024 07:44:35 +0000
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

On Thu, Apr 11, 2024 at 12:25=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
> Am 11.04.24 um 05:28 schrieb xinhui pan:
> > Ensure there is no address overlapping.
> >
> > Reported-by: Vlad Stolyarov <hexed@google.com>
> > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 8af3f0fd3073..f1315a854192 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1852,6 +1852,12 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_de=
vice *adev,
> >       LIST_HEAD(removed);
> >       uint64_t eaddr;
> >
> > +     /* validate the parameters */
> > +     if (saddr & ~PAGE_MASK || size & ~PAGE_MASK)
> > +             return -EINVAL;
>
> Well as general rule: *never* use PAGE_MASK and other PAGE_* macros
> here. This is GPUVM and not related to the CPUVM space.
>
> > +     if (saddr + size <=3D saddr)
> > +             return -EINVAL;
> > +
>
> Mhm, so basically size is not checked for a wraparound?

Yeah, exactly.

> >       eaddr =3D saddr + size - 1;
> >       saddr /=3D AMDGPU_GPU_PAGE_SIZE;
> >       eaddr /=3D AMDGPU_GPU_PAGE_SIZE;
>
> If that's the case then I would rather check for saddr < eaddr here.

FWIW, it would probably a good idea to keep the added check analogous
to other functions called from amdgpu_gem_va_ioctl() like
amdgpu_vm_bo_replace_map(), which also checks "if (saddr + size <=3D
saddr || offset + size <=3D offset)" before the division.

> But that actually shouldn't matter since this code here:
>
>          /* Now gather all removed mappings */
>          tmp =3D amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
>          while (tmp) {
>
> Then shouldn't return anything, so the operation is basically a NO-OP the=
n.

That's not how it works; the interval tree is not designed to be fed
bogus ranges that end before they start. (Or at least I don't think it
is - if it is, it is buggy.) I think basically if the specified start
and end addresses are both within an rbtree node, this rbtree node is
returned from the lookup, even if the specified end address is before
the specified start address.

A more verbose example:
Let's assume the interval tree contains a single entry from address A
to address D.
Looking at the _iter_first implementation in interval_tree_generic.h,
when it is called with a start address C which is between A and D, and
an end address B (result of an addition that wraps around to an
address below C but above A), it does the following:

1. bails out if "node->ITSUBTREE < start" (meaning if the specified
start address C is after the range covered by the root node - which is
not the case)
2. bails out if "ITSTART(leftmost) > last" (meaning if the specified
end address is smaller than the entry start address A - which is not
the case)
3. enters _subtree_search. in there:
4. the root node has no children, so "node->ITRB.rb_left" is NULL
5. the specified end address B is after the node's start address A, so
"Cond1" is fulfilled
6. the specified start address C is before the node's end address D,
so "Cond2" is fulfilled
7. the root node is returned from the lookup
