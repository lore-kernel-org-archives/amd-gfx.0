Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383BAC44501
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 15:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ADDA10E4AF;
	Tue, 14 Jul 2026 15:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C3q8Azup";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89AE910ED8D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 15:03:18 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cc7e132d3eso6222845ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784041398; cv=none;
 d=google.com; s=arc-20260327;
 b=LevpaRbhU8zxjCzhOGsPqtpv1XNSCaqTU6fEdnoNlPYCWZc4QuI/bpB5NDHjUiG4fJ
 45vaL6mLSQ8IWfWbNTfStg5t3qPQqPzvS+SWLGmnXHZJguggNmzaao6MtpuoS+8hX8jj
 gZccNjtEg5zioJYBmJa6z8/aWwUzB2Oo2Mphriq8IN0nBkCw3HuuAE4ZFYlMM7mo5hiW
 CxGR86eY4OWJUO3vDi3UIqdA2+pBPO8h+kxTjd1V1sW6PC5mNAkYN7gFe4iEdZTxO8oQ
 gLjE9G/MOQquVbqylb+PrQs3mVB61wl0UXi7N8LF6mE7J5R03rylsTt3AnVE1UYJ5BKw
 1j6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+DzlyWp2etMmWuZBhLlYvRM3K9KwQkU7WrlJATKyM4Y=;
 fh=JXcrtMhQzB5pOVVzYC4w8oUOQdqn1C9L5etxDS9Dlvo=;
 b=oLoBn+3zUfd/Z1Aw6qy7D/+tVuT1yxFQrH40qPUQ9d6IFY0+kmj8lvtK0VobS3IGME
 uBdtkSKGFsQMDpENCFc6U69hMthvHkOtB4sAWI5g0OLbM7/v19y3IvO9E439h+hiNWr/
 J6k4dhCSZhnTUr1YVnVdBAaG0TDjVVcdcqzyDG9gpgSOBsi7Lh8R9P2WfEROHiZM3jPe
 jtqW0cnDLm7xGSBdcfWDAjlO4sC7qCLT1lryMjqF61Ntt4mPzBNG9da/0ss3mAT1y5hB
 /lE92TryOZcE6cagMlpgc7h/+Go4583Wz5H68FyDhI79fuoiV9+fX5JuENnvY7dtfZMZ
 4RPg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784041398; x=1784646198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+DzlyWp2etMmWuZBhLlYvRM3K9KwQkU7WrlJATKyM4Y=;
 b=C3q8Azupl0DEPEQ+v7NK5hjveDPuyoILuhjOCCbZI0x2FqJoa19rZIHm8BSFKD/pnJ
 G3RPf5OVgCvrf3xR1eFZJF/0QfF9SWAUJq/p+U1yNnpGfiBUCEHxA+oAb6kHyraeDqPS
 mk6CZyuMJjzF6c+Fx4VgI+3JlDNS0SUS/Y8rsrIum/js5W1bwuApTm5PtsvsGqQ1u/ww
 5mDs8qtwFOctJFyKdQbnZNi+/6CJR051uWMbKGu0L7mUvqDNY+3FhN91W+nW6bTlWfwJ
 xF+qsm3d4OhLc//GypHYbqxO4zI3OZFBtgnwSocnGcSa9eriJbSnN5C0KoOhmpgGVmQk
 SuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784041398; x=1784646198;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+DzlyWp2etMmWuZBhLlYvRM3K9KwQkU7WrlJATKyM4Y=;
 b=aKJFriTQBLRJJ8i2qOwV9jtogKb7aWSSUsW1zQS7DO9spT5INsbl5S601OT/8okZel
 14Z/z+DkdyD8x2++ZbzmDeAqdGnC8HYiJoXg9AHP1VXkrrIvVfcZfsqBTena2ueC7Yn7
 9n/dxLVr9RUrbXIArg6yXekrgYzFz1DySV1ewIfJvXoKGk+QTNnaRoXZ9+sprnLoe5mD
 KEwHbx3UMa/QlsWi878eJA10qhxuDInOtADIqO/Rthj1scLovdyZ/m1a3EU6l2Ykpi45
 h4s8dnRnXHccXyAV+jgzl1HpIyD+u5JZGt7MFDNAJr2qzhHK94ePVNjaSD6knejiouRG
 0/5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFRctziFUgAqa/7THav5Klk204w3ovrubvGYO64Ono9SR39i/i/eUmUskbYDEggdrp0jputYpr@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yze8K5ZSKfvHr4NowV+01EYIB8BG+H7EAJANEfzvdUWf15aS7ll
 t4rVPZwhqJu+EiVzl51qcH1Ti7p21PUewBjowliNDuJf5toZxG/nYxwGv5DalTHYXwCRA0TXMQ7
 6gcm0Nwb/1YSdtnfsw4/q+WwSSXVCOgQaC2BW
X-Gm-Gg: AfdE7cm3+4kqcw5302jdaIowmWwud+768NX741k1gXKSS3rjuUglePjHwv8D3AYPaJk
 cRqwQKgrb3WEWXHxkgkTU50/dNcIgv4CRr9vqEK6ggZ9VFr8XhLVx86h2wiJJxNfoN8cEaMVgBF
 LKrdyclP1hhOMddWFB/bS9Q/p7cUHD1DLwhrdo/CDWRgxCpbIiCQotl73Q2NwiyIt1y+CpjEaXB
 rvJRs+lZZbhF3ZklMvPc2ekbDTsjbd73RrHV25vqQNj3/bfOseOiKOPzD16sUxZyqjjk4CZ/A0o
 fUSkbORcwoN4VWLi4izc0KzXet5c1vTJ2Vtp+PivKkm6U2s9MVeCD9h7HC4=
X-Received: by 2002:a17:903:8cc:b0:2cc:d6de:d58e with SMTP id
 d9443c01a7336-2ce9f0580d8mr106348495ad.4.1784041397433; Tue, 14 Jul 2026
 08:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260713182732.630947-1-alexander.deucher@amd.com>
 <20260713182732.630947-5-alexander.deucher@amd.com>
 <e8926046-2e03-4224-98ba-8601de0421db@amd.com>
 <CADnq5_OGJBx5xkSDfU4cyt0bjZRot18F-PE29RJFSkC=YPz6oQ@mail.gmail.com>
 <1e4cead4-73b7-461f-b4d4-a66e293d0d96@amd.com>
In-Reply-To: <1e4cead4-73b7-461f-b4d4-a66e293d0d96@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 11:03:05 -0400
X-Gm-Features: AUfX_mwg_5Hugo2OccxE2LfeiIpiEa80K85hi2BLtgjT3dFfZorrJOJ7P0Ha6do
Message-ID: <CADnq5_OnTfvMf+Bx3V36p0W_M4ARksHZ+emGSNb07Us9xPr2uw@mail.gmail.com>
Subject: Re: [PATCH 05/14] drm/amdgpu: add an buffer funcs callback for TLB
 invalidation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Jul 14, 2026 at 9:46=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 7/14/26 15:42, Alex Deucher wrote:
> > On Tue, Jul 14, 2026 at 3:19=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 7/13/26 20:27, Alex Deucher wrote:
> >>> Use this interface to issue TLB invalidations using
> >>> SDMA.
> >>
> >> Hui? What should that be good for?
> >
> > To use as a replacement for doing the invalidation using MES.
>
> We should already have that as workaround for the Navi 1x SDMA bug.
>
> I suggest to just move that code into a separate function instead.
>
> But the SDMA can't do PASID based invalidation and that is what we need t=
he MES for, so I'm not sure how useful that will be.

The current gmc code doesn't do pasid based invalidation either.
Everything ends up in gmc_vXX_0_flush_gpu_tlb() for each gmc version.

Alex

>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 18 ++++++++++++++++++
> >>>  1 file changed, 18 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_sdma.h
> >>> index 4f4e56022c970..4ab92d287675a 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>> @@ -155,6 +155,23 @@ struct amdgpu_buffer_funcs {
> >>>                                uint64_t dst_offset,
> >>>                                /* number of byte to fill */
> >>>                                uint32_t byte_count);
> >>> +
> >>> +     /* number of dw to reserve per operation */
> >>> +     unsigned        tlb_inv_num_dw;
> >>> +
> >>> +     /* used for buffer clearing */
> >>> +     void (*emit_tlb_inv)(struct amdgpu_device *adev,
> >>> +                          struct amdgpu_ib *ib,
> >>> +                          /* vmid to target */
> >>> +                          unsigned int vmid,
> >>> +                          /* vmhub to target */
> >>> +                          u32 vmhub,
> >>> +                          /* inv eng to target */
> >>> +                          u32 eng,
> >>> +                          /* flush type */
> >>> +                          u32 flush_type,
> >>> +                          /* XCC to target */
> >>> +                          u32 xcc_inst);
> >>>  };
> >>>
> >>>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t in=
stance_id,
> >>> @@ -162,6 +179,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device=
 *adev, uint32_t instance_id,
> >>>
> >>>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.b=
uffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
> >>>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buff=
er_funcs->emit_fill_buffer((ib), (s), (d), (b))
> >>> +#define amdgpu_emit_tlb_inv(adev, ib, v, h, e, f, x) (adev)->mman.bu=
ffer_funcs->emit_tlb_inv((adev), (ib), (v), (h), (e), (f), (x))
> >>>
> >>>  struct amdgpu_sdma_instance *
> >>>  amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
> >>
>
