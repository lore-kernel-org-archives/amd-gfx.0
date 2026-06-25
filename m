Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BA7CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B1F10F49F;
	Fri, 26 Jun 2026 07:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RCC2guPd";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD5610E1B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 09:07:07 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-80af6f707b5so665627b3.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 02:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782378426; cv=none;
 d=google.com; s=arc-20260327;
 b=sv7zHz9oOW4cowgHL2/WuZs4y5U/7Bq/emdIbjPbSFqFCAbAt42grcltTzlNu8mu1I
 F+KUsqd6oewOQ85PBqLLfSLXGwrrgGWJQKUNr6gj5LZXe/TKDGAH+WdamSwWgGG+Bi39
 mbGNSK3p2yx6442IbCjYWiIzEDA6DIaoVpMlV/v/LrxKZiIcXKJ7/LfOVR0MdNF5peO9
 zLEgJ2ixcwjjMWjeyH07ENkHegvKNXzfuoFWLydjeg52UYCF+AyD7ad5Ek4OiJXUCpBB
 cePFFdupdLvUwQLzoWyA69j3GfqfkcDsjG011KlL0UTK2SWpKoNZGj2EEzbmq61I4flw
 HiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:dkim-signature;
 bh=1lF2p0zapEf+xhq/90YUTa1Z2VnVgWZbekIEo47QZ4A=;
 fh=GQCCKYWZorMjIqEt1OoBoi+ydYpCUmfg/wswxkzamm4=;
 b=qa0h9ems1Tcy/2EAlE/dISUF7mdumk3bMkz9+ymRuGh5aPsOjEEJXyeBFsOpXLz/VK
 qcg/b9wAmGInwzO/8mhgzR2bLFI8bJebmr8/TZN9kxu4T/rPqQCGowaLL6J+qD+LXOZJ
 EfN3BUZEtWcboOsX+a9BTmuDKfCL3lcJsla3FYnR3e2WyvHxYmTWNqr2CDNV/9sH7Id2
 Jb7zBqQHMv9Nx+z1vbIaRgAcqCmA6yLNZeDqdA0iqkzHEq9aTSfLFSUrANWpmHCNH90g
 n9Jwi3+auY63LvrFYSywsAEX3GyOkmJeMxwdLE6p+ae1uIUavUyC3pvur01gCVnRIIZq
 QFvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782378426; x=1782983226; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lF2p0zapEf+xhq/90YUTa1Z2VnVgWZbekIEo47QZ4A=;
 b=RCC2guPdJ+UWt8NUcwdYaIbBdmV86R/G2bx6yD2UiunTWMNt7J25mZnpnNMWftON+K
 uO3rPO1T4Pe/wGDxhYHr29tTjYizC4ZEovjFgRvs3X8Kf9uuRb8OFwQsLHFi2/GmkHbE
 G5FkCrdjL+yPpSHKII6LdTTr7jIFSRp7Gi6momLbUD5EdYCQpJ/4H/RD5co1b+4aZa3Z
 HYwF+Y9JytdQ1Ud1GQALqdxGNCmPXtGkdNKXAQZZSijJaFEg5lXEOw3tg5+TCYC3j7KW
 hAtkjcOwnK6cV0BExQ8cWl2QzcSwifXN1g8XOgSzSsdvMWKZW5su9pwjXb3hyPqPFSJ8
 jJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782378426; x=1782983226;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1lF2p0zapEf+xhq/90YUTa1Z2VnVgWZbekIEo47QZ4A=;
 b=mNid6mRTzexurPz6R1W2tRCPgMTO7yO4OvXMazYqTL/MtJFtum4NP7IVnU7bsEfmrp
 mUnbiGpcf58Fs1L6CN68PbebAsHVlKp6rHVxWqcO+EyoWt4PHyGAh5W98vs0T1jZUkpm
 0Rifs4OaEe6lykH4YP+Es9QZ9I+sy9jXXTnJPuBPbLngYKf+c2YFd3iiJR/qQ5xLDmXW
 yyMT2hRTaTFwQZ/2SfeZyOVs/RHaK0DLGzFypJwQU1xea0oCVoYL7M95uXGyZ9ONVy15
 98vYR3AYBBh4OikfBlQHCHd76oe7UCIGwelJT3cqSvv7BCz6UW2SzoyPUk2Pdybu/F5v
 vkgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrC5xG8OpJ8N6lACMFUwtU1mysoNKJSDFzoQtWLdyaiQ1TckhZZ2RiMKZLgJrgfeCsQ0UUZA24L@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHsapdU1brB1FdPNsgJwF/xI66AqYnFUNEmFO6GT71G3vPPn8A
 e8bEErSwmpb48cmF2M6yZ6SWxYXBiDEz72TXcYMtlH1Ifi2kXQzewVxUOPNieVwcKdWo19DdXA+
 ewdfDggxtLt4wg/lXHBHYHh2a8CTT/9M=
X-Gm-Gg: AfdE7cmaHyO01A1c6fBI8ITaUQvWnWhfpjSO4qtEY/6zJFXd3qlNy3ZdiDixHjz1cVd
 y4PIFlPfdH3nfObKjeltWtWOpETIzQgC0ssnVsuviTevjl1FUBY188D2PwVofYaI353Bsg/CHVs
 sWMgCdwr0T6AqQcV8G6M9xW/lN3yOX9ShVpryip8ZzNLlR2+QDH4JqWmzsSM3GwPBw+K6bIDBLP
 41LfAwWZkBInRR090BB+OmONY1R/C5rXaq5D/8gwWJfCNKVA0p12B2Ke9OPeexO6fk9W0gJyA==
X-Received: by 2002:a05:690c:f06:b0:7bd:cf35:e33b with SMTP id
 00721157ae682-80a680fd6b5mr15809967b3.17.1782378426348; Thu, 25 Jun 2026
 02:07:06 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 25 Jun 2026 02:07:05 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 25 Jun 2026 02:07:05 -0700
In-Reply-To: <72aa8cb3-2b48-4b08-ab17-788c3dd18fe6@amd.com>
References: <20260624172029.2508-1-alhouseenyousef@gmail.com>
 <72aa8cb3-2b48-4b08-ab17-788c3dd18fe6@amd.com>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Thu, 25 Jun 2026 02:07:05 -0700
X-Gm-Features: AVVi8CediwaEU0lbA3vIZaDjcsLl9lonps5TiuUPNt_1EGi3rRkszgQM2DjFHFE
Message-ID: <CAMuQ4bXYumKw9jTJ-FpCYfnzipR9jcFVSbp_k=LAbModoinRsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reject mapping info for unmapped BOs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:54:04 +0000
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

Hi Christian,

You're right. I rechecked the handle-open path and bo_va should
already be created for this file, so I do not have a valid reproducer
for the NULL case.

Please drop this patch.

Thanks,
Yousef

On Thu, 25 Jun 2026 10:46:24 +0200, "Christian K=C3=B6nig"
<christian.koenig@amd.com> wrote:
> On 6/24/26 19:20, Yousef Alhouseen wrote:
> > AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the BO's VM mapping and then
> > iterates the valid and invalid mapping lists unconditionally. A GEM BO =
can
> > be queried before it has been mapped into the file VM, in which case
> > amdgpu_vm_bo_find() returns NULL and the list walk dereferences it.
>
> Mhm, that is not correct at all.
>
> The bo_va is created when the handle is opened inside the filp and not wh=
en the first mapping is created.
>
> Do you have a test case to reproduce the issue?
>
> Thanks,
> Christian.
>
> >
> > Return -ENOENT for an unmapped BO, matching the VA operation path that
> > already rejects missing BO-VA state before touching the mapping lists.
> >
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gem.c
> > index 212c14d99..4b2699931 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, =
void *data,
> > struct drm_amdgpu_gem_vm_entry *vm_entries;
> > struct amdgpu_bo_va_mapping *mapping;
> > int num_mappings =3D 0;
> > +
> > + if (!bo_va) {
> > + r =3D -ENOENT;
> > + goto out_exec;
> > + }
> > +
> > /*
> > * num_entries is set as an input to the size of the user-allocated arra=
y of
> > * drm_amdgpu_gem_vm_entry stored at args->value.
> > --
> > 2.54.0
> >
