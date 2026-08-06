Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB95C5AC81
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 20:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F9510F2AD;
	Thu,  6 Aug 2026 20:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eB74IWnd";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D54410F2B3
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 20:25:52 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-384c94c9423so379610a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Aug 2026 13:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786047952; cv=none;
 d=google.com; s=arc-20260327;
 b=YpPa67HB0JqYA3Hs1BhflWmdwVd2NGHEY1AmPB+DCyfxcwcFDheEgtGhiREMJ5jVXZ
 beGTDJdTiukas2R0x961lJhSQHu/oUR3OkW14GnaFU0WafnTSye/7Y2VZbrLVx1O8fmA
 MP3Ig1mVc1QIxwh54OzUBF1zpljl3t66UXq+zVqKA/uDJ1Ey0GzIxz6Om7Z2VEUn5juJ
 5u+4zKkSp3hkvBH3OIqSOHRTqRTDr7osHcoTFTFgVfYI+1zxPqIB+h1fDzzAIuWFKO4r
 KaNaIF9TTYH0+zu+mG3NmzWC2smcZfwtNlqQWIrM6paCAntr9cBTzmMdmRplGKxu4YkK
 ORVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UB/TLDxrBBY2QlfdHBPHAu0QzanH7iO9OxicGBoPGLA=;
 fh=wLUnP8r9Oxb+cS3kWsfGgb0yIX0SNovu19S3VA1ZiBg=;
 b=SRFGerUL1lVXw+0Sr2cbc0/pfx/ScWYf2mltyzzxGvgCI8MdGEGVPhfIHZ8F4pQCYT
 Og98AKexAEbcf74yy3xrfbxyCO5e8hA/d371/GyMR0cbD/rxI2Ael+IAsfWeCIv3n5/o
 4uLL3MS9SshXubBZuY7zhXgCLmmtFeMHdMpTVvHZgwR4mnkZAEfcKHkoYqlwD4ssySWl
 RS7+oM2kDGsCVme3Ag8Ym5latmDGBahZ5ui1l1Mey9s7zydpG8GEG6GCFM2/h+DhYd5A
 JTaqXXoG/sZs8RbnzxstjrYGFeOA09WAYyZcf9HMMHmOUi5D8j0kbkLOIIr5B9ijMW65
 385Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786047952; x=1786652752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UB/TLDxrBBY2QlfdHBPHAu0QzanH7iO9OxicGBoPGLA=;
 b=eB74IWndRiG121Jq+oAkfL3Q/D/24KqWcB4BMJhPmLvvWdNxoUmsuJiJ8eTuZX75VF
 2CcG7JELo/zVEM8+0y90QdLByXGsisea9EdWdKlC0WKLjvh7Y8u0S7GZUEMmbrx8wjbM
 PisQJuA2bx617Nadwj+WwkPk61YFE1kjIocm01qFoOgbmhvHfl3vybRwNwiQjwmmA3J9
 tuBrsWHvmO72Sni0Au2H4a5lVZ4jcVw6zY5EeeOF6qziLMONLDxgd3bSwzvPb79JTmen
 fyXWK4fNlOOsK4IhFoHk8bAhfW1RUobRHENvIZ9tWvbisXIIKuhH78a57Xd17XR6+8zb
 0X7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786047952; x=1786652752;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UB/TLDxrBBY2QlfdHBPHAu0QzanH7iO9OxicGBoPGLA=;
 b=NJeRHCUP8wgcaihvn2Z+Eky8YPTEWs0zq98kJ3kFH5r0r9uA1dhy17paR4eIMv5N6p
 oh6FhmpREzbq2wCO8B2QreZjBbcoDlxSp2lsZy1XRfL1GJ7Ya9jEexZD3xPN4ZEIfCQD
 AZp28eItD+kTWai35tSOeA6bmCP251KBQ4A8ZhcNplJVRMrPfc/DHp7AFMnz7jxmRWEM
 atoP86S9kujkgtcX9rCEN4yL605LcAjfml77z9juQly8IYaGXC/5QIZvpHFlgnqMrw3W
 yWlGaWTLhHAUz9SC/dOHQlRAvMaRM+BKuOnpk/pfs18dEhOmf62nMhgmSLiNBYmaS5oe
 AHow==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHfN6SGjyDdpuRv2FEIGWrk3bJIiUF+/urKZJnDO4lHjMNsGVc7FMa79fLm/83yzl9+guZnDdt@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy62Arjw54oJTKmFxxA6Zyyqfxpa7j75iFwQbBtzGQlQNfAEwyb
 +/CgxngC9eYy+6hiTCAelT9bPxhB+nEfj3lVk61uU2cj7BsRXbdAQvFDCe02VDLgEe73g5rCUkd
 MeERR4Zmdj+bmqmNe87h4bxQSJy7uYfE=
X-Gm-Gg: AR+sD13wV1MM0L/HTUnrLzfKxqxWxD846G91L1KKg8BCpI3YXoOtMHHczKIEoNjE4MW
 gN1Pdl0+/jmII3KVqF3/1yhcKwsYVReH/3sj4kx7tpoNx0gOFCPx/tkJjJajEsx/InT6TAFfThe
 m26+ZGtx0Hfprnzek9N76SBTPjDMCuTFzYyJBuY4eZkBFfgaEn96KXMZrTtc2g/oZwOzfxek/zO
 TRmgUqsJ1Ai4Uc0ynSNSu9qDfz5tqnSQrymxrDXL6XOUjC/indtFsRL6a+gWzeP69CznQFSt+bj
 tu1oQi8xyDPwJRcTzvCDFbnVLj3h669WZa/hCgvUeXgIbojEIMlpgiX7MteJV1n3zTtmjkqqCaA
 VpRkbWQ30LTWpVwv955ceTsb35U9LDpU=
X-Received: by 2002:a17:90b:3a81:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-3903c510c3cmr11918552a91.1.1786047952031; Thu, 06 Aug 2026
 13:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
 <20260806-amdgpu-fixes-v1-1-ce247012d4da@outlook.com>
 <75a5fe30-4ae4-450b-8053-2a4633c5115f@amd.com>
In-Reply-To: <75a5fe30-4ae4-450b-8053-2a4633c5115f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Aug 2026 16:25:40 -0400
X-Gm-Features: AUfX_mwniMh7P5P2yqjjnyFH_x3k9YJsgfjH2jDtORPTDpSehrDugpH-kLVXCOM
Message-ID: <CADnq5_O3FeOFFmdR0tQx6cATN9PRmS43Q+4+HZTSXnb5HVUqvA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: disallow multiple FENCE chunks in one
 submit
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: moonafterrain@outlook.com, Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jammy Zhou <Jammy.Zhou@amd.com>, Madhav Chauhan <madhav.chauhan@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
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

On Thu, Aug 6, 2026 at 8:03=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 8/6/26 06:45, Junrui Luo via B4 Relay wrote:
> > amdgpu_cs_pass1() dispatches on chunk_id once per chunk without
> > rejecting repeated ids. p->uf_bo is a single-slot field, so a
> > submission carrying two AMDGPU_CHUNK_ID_FENCE chunks runs
> > amdgpu_cs_p1_user_fence() twice, and the second run overwrites
> > p->uf_bo with a freshly referenced BO without dropping the reference
> > taken by the first.
> >
> > amdgpu_cs_parser_fini() only unrefs the final p->uf_bo, so every FENCE
> > chunk but the last leaks a BO reference. The leaked BO outlives handle
> > close and process exit.
> >
> > Reject duplicate FENCE chunks the same way commit fec5f8e8c6bc
> > ("drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit") did
> > for p->bo_list.
> >
> > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > Assisted-by: Claude:claude-opus-5
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Thanks,
> Christian.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 5445f75741b5..9c514cb01096 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -228,6 +228,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser=
 *p,
> >                         if (size < sizeof(struct drm_amdgpu_cs_chunk_fe=
nce))
> >                                 goto free_partial_kdata;
> >
> > +                       /* Only a single user fence is allowed to simpl=
ify handling. */
> > +                       if (p->uf_bo)
> > +                               goto free_partial_kdata;
> > +
> >                         ret =3D amdgpu_cs_p1_user_fence(p, p->chunks[i]=
.kdata,
> >                                                       &uf_offset);
> >                         if (ret)
> >
> > --
> > 2.51.2
> >
> >
>
