Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2C3CD8C9F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 11:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0796010F25D;
	Mon,  8 Jun 2026 11:46:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AOn7UR9H";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C0710F25D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 11:46:48 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304eb0fc233so339491eec.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jun 2026 04:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780919207; cv=none;
 d=google.com; s=arc-20240605;
 b=f6r6XHasQru7KNVzyFQtGSWa3OhKQyWWSxyFJjnazKWoklsOGpXqdAodqdCm2LloY7
 ew6fmvSrMTEsYlMi/WQHD5Np7vsas9NDpJ64HQm5gT3J81mcUtNqt8xLRrwNIm8cubgO
 cxhwVUTZPVFQS+qRgWUx00IEMveYiAJZvfmwDs44+dGhpq9aPp51mm9CduXxzk7eWs0v
 xkQV/DLREv9Wczm1TVl3VzFBqGgoZIcMkb1AiJSNfYgzAfMHF+lrjosLCFxNushWLawU
 v7lqIrsee66cTFs0eYcRXX2B1YfGpoufIFZFcDF2U5USoeOe/wQI8dBeSYF04pMs8j9A
 BbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PdAfFNTHWxgXcumbrD9A813ql91FtBDsuDtrJ41Tu1U=;
 fh=OPekTQnnLVCcWc//LmnCpZ2hURZmA8rDK790xSCBngY=;
 b=FyVO6z+TRMC71NPw6YPML3G3rQlZlI3k5xcav2W9O9FNqe8KaUENYF4kxXEDKVXYKB
 VB7JouDxBS/DdOUwvHV3QM6hhpYPhYynFtBG6U/Ngrfl0WlMA8DfrFpG2KfYVih9Kwsj
 V2isPLKioheQGIXiGHX2cwa4TLKg90anPYh31668zCbfe8D0o3bUN23akKY8bz0fFC4l
 E/JsL2YjRLopFRk88DC3OQilDo9m88KGEUxMWiIQ2aZaCjGC2cubcfnvOBoUPHDNUYrW
 9aYxX/IUJZahfZAb0b65A8N5xl1SspaLtjhQhm49GqESmREqrFRk8v0OSmgEAUEfvK3f
 MRBw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780919207; x=1781524007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdAfFNTHWxgXcumbrD9A813ql91FtBDsuDtrJ41Tu1U=;
 b=AOn7UR9H7hid0XoByCEycNT9Q5TWdqjp+ebBkmqFmJ4JsQfrIDjNdO1BySb3KXUpP3
 AHQaYj/FyQEtKpmCZoVPhTOBX/XESPse+ST+Vdda8OKwNk75bFLHzcE5tZqFPvWNF4NR
 L3GBdMlHbgolGxt77IJUVMRHQWapG5bB0lC2IUSKx6RcouE5ACQWCVnMsQn/ekcioptr
 VFl1gQb52Cl66WUgHM8+DWdpOLI8kYBTI7MNC9iEbe2glR6hGrMQT/B0Q0Fn19LdS5bH
 85mkxVIW2TV/P8QzWx5wj7UJDdsHtVE8dI3U6iXwZBnyZykfdFaIOd6sFbP+DRd17vMy
 uGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780919207; x=1781524007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PdAfFNTHWxgXcumbrD9A813ql91FtBDsuDtrJ41Tu1U=;
 b=OSA7RsuhoDz1SrWUMTslUxdJl0f4EveCOBpb5E+C3nO/lwC//ZeS1Zy++fKIrxGVKk
 b/f7jv1wNrq21SkI0BsBFkgMVXGk7opXNfs4QlB+g4bvNV3fWeb3lvabllR8zyQW0IWv
 cLT60Rg7lQiTi2JW2a5ECC0rn1ZWR/WoGvH9BkCh5DKpSjlt07eLK5j5qtcHCz8iBs59
 c8e+6sdiZastHhi+nWYsLhNnLi8Qqq+RckOsYrPtxVMzN8pTlCFz3FMI46vRxNk6ilAj
 6zWIhdpDiA3yq6qxewSgbFtHiWxsLfqFoKydcuGPmMsrd7UKHkQ931CPAuU+rrERNq+n
 AOrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cmpbzPjlTjPyWqHUbmptAZZX8EuFSYlpLxs9wNv34ME///dCOKIOUrWjsEmD+0CIgAHyLQZGf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrE21zv415BIzZqJALLm0NVlw1eh+DrUd0IRlVDPQnrfpEnSnC
 qnA/Xe19IbAVnjEoq0ir1/vNd30VEXHXVIyKnTD5eUkAGUyD+qskNOcZbE4dXY8FqAI67vQczkm
 eFl+Xo91TVtRfe7SOHg2N93dii6bl9tE=
X-Gm-Gg: Acq92OGY/JiqoeKhPb50cjg36uvoUxSGGDh29AHHh/oz/igsSPdwM6GgrKTeMSHFXdW
 tTAr2ZZQiZsGJHQKu4xgQAePIfFPXKRxpjX/RzW6a+JeZvhl165HOah+GznS+nMJGYFgw8gwu9O
 4/Tl5AVDych16c1owCBarIbd5EwHkWU8ncQZclOB38yeWBO+ZuRIvxUXyjg+LTydTneZHQtRFzL
 oSNImkBx8+O/QK4kp4I3erJMJ9Z00J0Flei0CW38e/WWhPifGPGzaXMcuLxpVoDSy7TWNCFFFcc
 ervRd/0KravE+xZZ4VG+3h4eiSe33jcPJ+Emeh/9+jhvyBA99XjOFWpiO4MPifCcc878bXUxQEW
 Xlqs=
X-Received: by 2002:a05:7022:e01:b0:134:c6ab:a516 with SMTP id
 a92af1059eb24-13806759a9dmr2924000c88.6.1780919207149; Mon, 08 Jun 2026
 04:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260605154920.1314590-1-asad.kamal@amd.com>
 <CADnq5_MO7q3E99QZhkLqYGAJP8m6kH7Mf2ATkut6kPikehB10g@mail.gmail.com>
 <70051591-bce7-4a0a-86d6-b9a949a41069@amd.com>
In-Reply-To: <70051591-bce7-4a0a-86d6-b9a949a41069@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Jun 2026 07:46:36 -0400
X-Gm-Features: AVVi8Cf6_TU9q9swv1D4H9dmJa-y3BiT_LFErJKBftGV41dQcfQPOausOJByQxg
Message-ID: <CADnq5_MbOXW+2NYuTJN19HOLy4euJcA8rsZ+zT+fTe1ZDk2bJw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org, 
 hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com, 
 alexander.deucher@amd.com, kevinyang.wang@amd.com, 
 srinivasan.shanmugam@amd.com
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

On Mon, Jun 8, 2026 at 3:25=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wro=
te:
>
>
>
> On 06-Jun-26 1:30 AM, Alex Deucher wrote:
> > On Fri, Jun 5, 2026 at 11:59=E2=80=AFAM Asad Kamal <asad.kamal@amd.com>=
 wrote:
> >>
> >> The cleaner shader sysfs path allocates a 16-dword (64 byte) IB but
> >> incorrectly fills (align_mask + 1) dwords. On GFX rings align_mask is
> >> 0xff, so the loop wrote 256 dwords into a 64-byte buffer, causing a
> >> kernel page fault.
> >
> > It would be better to set the job alloc size to
> > ring->funcs->align_mask + 1.  The whole point of the align mask is to
> > align to the hardware's fetch boundary.
> >
>
> Hi Alex,
>
> This is for IB packet. Is this a restriction from the FW? For 9.4.3, CP
> team mentioned that hardware doesn't have any such restriction.
>
> As a side note (not related to IB), within the primary queue, the
> default RPTR_BLOCK_SIZE is 64DWs - block size granularity for RPTR update=
s.
>

I thought the IB fetch would have similar restrictions since the
existing code was trying to align to that.  If that's not the case,
then the patch is fine as is.

Alex

> Thanks,
> Lijo
>
> > Alex
> >
> >>
> >> The IB only needs to be a minimal NOP shell to schedule the job; the
> >> cleaner shader itself is emitted on the ring via emit_cleaner_shader()=
.
> >> Fill 16 dwords to match the allocation.
> >>
> >> Fixes: d361ad5d2fc0 ("drm/amdgpu: Add sysfs interface for running clea=
ner shader")
> >>
> >> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> >> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 +++----
> >>   1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gfx.c
> >> index ff5a55f5f3c9..f2c536929446 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >> @@ -1694,7 +1694,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(str=
uct amdgpu_ring *ring)
> >>          struct amdgpu_job *job;
> >>          struct amdgpu_ib *ib;
> >>          void *owner;
> >> -       int i, r;
> >> +       int r;
> >>
> >>          /* Initialize the scheduler entity */
> >>          r =3D drm_sched_entity_init(&entity, DRM_SCHED_PRIORITY_NORMA=
L,
> >> @@ -1722,9 +1722,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(str=
uct amdgpu_ring *ring)
> >>          job->run_cleaner_shader =3D true;
> >>
> >>          ib =3D &job->ibs[0];
> >> -       for (i =3D 0; i <=3D ring->funcs->align_mask; ++i)
> >> -               ib->ptr[i] =3D ring->funcs->nop;
> >> -       ib->length_dw =3D ring->funcs->align_mask + 1;
> >> +       memset32(ib->ptr, ring->funcs->nop, 16);
> >> +       ib->length_dw =3D 16;
> >>
> >>          f =3D amdgpu_job_submit(job);
> >>
> >> --
> >> 2.46.0
> >>
>
