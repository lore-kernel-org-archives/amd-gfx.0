Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B240AF54AAD
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 13:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B9C410E58C;
	Tue, 24 Mar 2026 13:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cZX/agZN";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9F910E58C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 13:10:19 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12714f01940so260479c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 06:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774357819; cv=none;
 d=google.com; s=arc-20240605;
 b=hM0dN2f2IlgAUAurAuUPtfm7MwykvjYp66O7TAOX7MkNK7E/gIbIwdC1v4XsyMoBy5
 yA1Ol/jtowu72ZRRwFIrH5T96VIl7E7AD9Du0sZxyd8bWONxiHpDAMFIM7h6caF8ysDk
 qx9BhSz38OH2mvYxE7O05P1EmQ/w0r/aRvVMSBw8DE6hc538pirSSQ2PULN5eUbWVb7w
 T9kbywU0XlPSDW0azXNK9E/Bj4Zvni7bkLpvA505zX2fUj8KQYvgcfwUxgNA1JgdS4xw
 K1RuG+E/CaFhl8oEEHfJE/CvtfGHPef9vvUh6CUzDX0CLkpzNyDxatYb9n/OjhdpxxBf
 AsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TwWbl3gQrlg4sgo335nHJ9PERnGe6ovz4ONesm9QN2Q=;
 fh=vqfujzjIqeyU+/f9qzJWK5H0HSMKoD59R8PKI29HyXQ=;
 b=Vnf0GtlIKItG8FFZaq98QoHFRShS+XFrzB+BMQYQGoGLddsNciaitHU8+z7DLo6XJy
 E4f49zOrR5cp0WEOZZvVlwfqH57RvUrrywwwoXgUJTg443sA2aBI92SyT/LCiK6spsGK
 lL3OlE4JxBIY8WLZgBZHXE7wtt1YO0CkSEse7QXpRn6mDWKY0KpDvI6pz6Gn0ULecBMc
 knhlZn6sT/+jC8+R+z/E/bRKrZlBHiNkCNmSHt6MjpSuYYytm/kfkdYDU5cgdcsxlmMU
 0jBQ18yfJJQz3LIRBajpHhAvorfIQGE6vORi9D7RsGXMlmnSkYkAf6FeMN7CJRFHDN22
 tJCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774357819; x=1774962619; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwWbl3gQrlg4sgo335nHJ9PERnGe6ovz4ONesm9QN2Q=;
 b=cZX/agZNqFgVcCLvcePjuKbf0efMZc1x+g1DzDXdPLEol/Fdu0Q3YxNL1TxIW00iX6
 SnHYoLjwJejrsK9TTXolW2IbGDKOcTxMRfjLwJdAS2fj8tIxN8ohNt5fJjLM5GLueLAS
 OUufDezHlHt+9MTmXhEa3aR6y/xQWoEnHXxO3FzXYkvj+fmVFVfGXYP8oqeORJMaUvDw
 FC7bhi2S5uQVdqOH6W79Kg4uYI91GgOgyod8jcix/yDr4nOQPsA/YBziYGLdTAwvTiWO
 /SIFnfLiSjCzqBvH2SM9rh/OFG/ulD4EqrOm2pkxxZjnBdXhq5t02wjREkKSLmAAuYp+
 /8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774357819; x=1774962619;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TwWbl3gQrlg4sgo335nHJ9PERnGe6ovz4ONesm9QN2Q=;
 b=Q59yBepM3V2CTARUF3tLbQdT+YKsaF3DsVRYC1NS6RAgM0g8jstHUWcYEF6wvk6rkW
 eR+nTIagBbE7nIfcxBMfD7yiOOo7bBjaxqShvkbclqPaVDcunuUyu6v/N2tfRIgyK+p1
 5bX9gy7EN+7g2eleSnXlaoU1zpo8emsSF8vJKwWN+uFT41ekYTycP8ED72qOxthkMiT4
 QOyDHfnhI3CIbhwDCKzSAfervFu7oYhoZA2Pku/0EOr4MEL1PScHpbDl+6KIJCRJ45en
 LnTyPDYSqmN0FVF4KHg0QwUEkPr5K2LNvH4qUdka7OvAcqgokYx+6o1m2ACSM7cwCzsO
 LQ6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVthl5t8Zlax17xbQPejTTEF/xc8H236fEPLBK/SfJRiJCbblsCA8hqun6/4yeXqgT1NnUB3BNh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYdiquze1TmIRwIKohA2xgzROYFIihBjk7kd1UPNmVw19yJQR+
 rNcxK0wOIioCr3jKnEPz+fDnbjcHl1OmbIX5MGSIPdxYIoQ+TJypk/HA/ZFfkEODVVexetAV9sm
 uHNyuAFOoeNjZjhJc2fFjlDq0sHfJeQif/g==
X-Gm-Gg: ATEYQzypJVsfAR6DNS1H6sb1Vf3WvKOBSmWIXiw8vikrN5LdrYMUoPYnyFoL/wFJGS+
 kqYQoGvivOg1KOAMBQVtFvedqRUupFP7oe9kH8Hzl7Dc33uYF+1LU1NHHh2O5Se9Lyr4mUS+/PQ
 hM5Jdq4Sids5JyB0KbiU+UZvAxJ3hCK97znasrfQlICMoywjz85TF6iZTqd98UBzOgJ2mjhI8oB
 40gdKfRCYbDiOsJaBCUeVGWXiCRnF5OkCvKBCIPyyDtZmUvONAyXm6aaJqYQVGQGnNNimpHuPYA
 3Kvu8tUiHrSfJsfn8mUvdJPNoeWBb4RQ1MtbgWdeL8RaRmuU7ppM6g86dmPr1Ss21a1oxw==
X-Received: by 2002:a05:7022:792:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-12a72651381mr3814100c88.1.1774357818810; Tue, 24 Mar 2026
 06:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <1e6240945c2fcb53b6703ae62d4b36f5958ca8a6.1774239489.git.donettom@linux.ibm.com>
 <3a5ed765-3a50-446d-bd26-aa09dfe3d6a2@amd.com>
In-Reply-To: <3a5ed765-3a50-446d-bd26-aa09dfe3d6a2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:10:07 -0400
X-Gm-Features: AaiRm53wTvFaie_ti12g5_uhAPMMa80SbX_M6oLaqW46aYiqMuKI-7GKZg1TM-Q
Message-ID: <CADnq5_Mc5TEBXD+sTLmT2ew6KKH++=8YjN=3N9d_bWUqqKgMRA@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v3 3/6] drm/amdgpu: Handle GPU page faults
 correctly on non-4K page systems
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Philip Yang <yangp@amd.com>, David.YatSin@amd.com, Kent.Russell@amd.com, 
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
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

On Mon, Mar 23, 2026 at 9:04=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 3/23/26 05:28, Donet Tom wrote:
> > During a GPU page fault, the driver restores the SVM range and then map=
s it
> > into the GPU page tables. The current implementation passes a GPU-page-=
size
> > (4K-based) PFN to svm_range_restore_pages() to restore the range.
> >
> > SVM ranges are tracked using system-page-size PFNs. On systems where th=
e
> > system page size is larger than 4K, using GPU-page-size PFNs to restore=
 the
> > range causes two problems:
> >
> > Range lookup fails:
> > Because the restore function receives PFNs in GPU (4K) units, the SVM
> > range lookup does not find the existing range. This will result in a
> > duplicate SVM range being created.
> >
> > VMA lookup failure:
> > The restore function also tries to locate the VMA for the faulting addr=
ess.
> > It converts the GPU-page-size PFN into an address using the system page
> > size, which results in an incorrect address on non-4K page-size systems=
.
> > As a result, the VMA lookup fails with the message: "address 0xxxx VMA =
is
> > removed".
> >
> > This patch passes the system-page-size PFN to svm_range_restore_pages()=
 so
> > that the SVM range is restored correctly on non-4K page systems.
> >
> > Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 6a2ea200d90c..7a3cb0057ac5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2985,14 +2985,14 @@ bool amdgpu_vm_handle_fault(struct amdgpu_devic=
e *adev, u32 pasid,
> >       if (!root)
> >               return false;
> >
> > -     addr /=3D AMDGPU_GPU_PAGE_SIZE;
> > -
> >       if (is_compute_context && !svm_range_restore_pages(adev, pasid, v=
mid,
> > -         node_id, addr, ts, write_fault)) {
> > +         node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
> >               amdgpu_bo_unref(&root);
> >               return true;
> >       }
> >
> > +     addr /=3D AMDGPU_GPU_PAGE_SIZE;
> > +
> >       r =3D amdgpu_bo_reserve(root, true);
> >       if (r)
> >               goto error_unref;
>
