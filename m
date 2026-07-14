Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF383C44501
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 15:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B2A910E3EB;
	Tue, 14 Jul 2026 15:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TTWmRrVS";
	dkim-atps=neutral
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D2E10EAFF
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 15:19:28 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-73843e514a3so128736137.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:19:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784042367; cv=none;
 d=google.com; s=arc-20260327;
 b=eVk9EcbDgY1QoO7Q3+hO2Uhopnf7WzUKgjo0nuC+m3qY0o+bZrx4jpyuGtFEtpE2Ii
 wmK1LY8BVHBrPqP5/RY37oqg6Sgb4JVXBvhnitlq8tHWjWlvQaGU5oe/9qmbW96bRvO9
 RaCVtYp7MLh0+PXCvuMWgoH6xq6Fft7T78B2p4KwlJ+W3tkXn2fg1RH42pVJs1h8c+ug
 k4XizGpqhtC5ArwZqN6+ZeKn4O6nJ2//4y2N5wXhYZ8ke5UlYr9lNHbTes7KUSQv+xq9
 54ZSgwOknIOHU6gPNmfaALoNKqbYQAwQn2K7+3aGS+byDul/r41QsHN3iFr/Llq3jJmn
 y8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vFaBn/i/aIobiSOR3r7wY27aOAGpBNMnJEW6eprZYIM=;
 fh=041Yz4nF2OOuagGcVtuPJyggyh3OhlCZwOY3vAG/25w=;
 b=kJGJsC02dF2bD0ctpJtyPFuk2bsBnyojFMW4l+6CPE6CSWrOnKcnFBGtuz6muFihcV
 ErSKczqjKdVUVmT/lf618gq9StjiiZ7f4t1ff67GOM0r7kxjbhodtWa6ZkDo83kAfO14
 KfV/XKTggG3PlwYIhKjSrQxjN8tdVn9sVB4rQlisJ+VyzeTmqGQVYGw/MJo92FlFV0SA
 Vht7u6eFH5aKmGwU5njNTeQUKEVREcTIK9VbIftlaBx5qAkXVswq/t63+owoqnl/laut
 KlyTEOJnh4UVi/DlRtsf8nHtqSlxNc6HKMpHPVCIWfaXIqC1Dissj5H9rJhO0PQQlFSE
 K8bw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784042367; x=1784647167; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vFaBn/i/aIobiSOR3r7wY27aOAGpBNMnJEW6eprZYIM=;
 b=TTWmRrVSMxT4nJWBHnju4Xwy1T9LHPCdPWGHd9W6WcCbWpfNyrBvH1pgeI8mJ1ddjG
 O1nPoSOX7LnwP9KmhPYM7i0R3nmK6ZxP15PyT1n3fZRzcu/rZ5h9/JyD5VxQ1FYK7+jT
 PGgH37P1hlipYYFt8GZZuDtqYa7gaZadjwBeGF7ObyvC+pOmQpqH0+TcMW/Em/bESspC
 UnEnVTQzZdyjgXeKfwneL4qF3uTO0ViOC9NrOBXvFJcwfbVxY/WYpFKQ17maGRfzMsuU
 8hiRniNcXqTFcHnI+ikG5S3MiiMbFlQUlqX2SRKUltzVx83iS572GqYgyomBiuZ+GP0A
 Z6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784042367; x=1784647167;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vFaBn/i/aIobiSOR3r7wY27aOAGpBNMnJEW6eprZYIM=;
 b=pzIKkpMfQAJ79eMSkMyKQ+TQpRCCpCjsJ10jQ4m4bhNufypGQWBxh/Vw0zDALUQ+i7
 b3EysxFOt/k6lnRv0lTdaFEKoKO1JpoLtcs06H9yjeOSphGMACKIwC617iSuEJjNPfRA
 aTk4hoSbhLgc+IWDYu0lFgZFC86hIyFu/VfJtsZk6kGDah8IKWa+QsX0t8wf3Di2X2/D
 m+p/4/PgYAOLtGXY6x8jp9nNuiswvNEgINfl0USUrL3C0fnLOznLuroqSvh0st9sXN/f
 4uLa115RXmsq+OAKKsL0lul0tLk780OQnYmukCg3MxQlB1qUmfC3bsmqGmU2cBQidacl
 NP8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RruGk0ZzJKS37h2HrKTGJc6ukbGMRP4Y7D2hc7vszkt9WLJwRq6VHswqOr5D0ZRbL0Wkzv9HtS9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZRHyTKUrdbxRBbkaZx3Kg8h0rWxMOQwUsWD3hymgAdob7MEIU
 6f6h8UdAVPFKc+eRu0HBT6VQ2Iy+3Ky+ZWkSywhQRWGBG+U/EUievMqfgI5xIC1tsnU7zFa4PXn
 jS1S6hMTyD0gyijdErbEJcT74tmkpzjM=
X-Gm-Gg: AfdE7cnBjRx5FIvez+XuHR1uOaabQ2XwljqUCnhATjHHs/yhKSaMi2TSgRvvodzYRQV
 oqTGB7y8jBnfjsrx6WtpQ7qsFZBRLR3YvshQAnLFQV705k/ZrVmCBmiHisK+PbW2lDjzGkT5lIS
 ptxDp6D8PoMqjfvUFLlsVA1Cx/y3Pm7qKCGsORt9OplKTdvjYO6IbNbeFRWRmWQ6d7LqFvibgyE
 N8rMwF+E8eu5b4gL83OEqxegB5hZhYYQqwV9SG6EZhfJsPUPAxfsD6PDuhRTDo+0GgVi/uAYOf/
 wY/b0LMBPcDUQSdlxBY869AP1Nonop4vamayHobBynsSAxHpKZx6YbEIpCg=
X-Received: by 2002:a05:6102:94c:b0:602:b87a:3524 with SMTP id
 ada2fe7eead31-74533ee30f3mr3151510137.8.1784042367111; Tue, 14 Jul 2026
 08:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260713182732.630947-1-alexander.deucher@amd.com>
 <20260713182732.630947-5-alexander.deucher@amd.com>
 <e8926046-2e03-4224-98ba-8601de0421db@amd.com>
 <CADnq5_OGJBx5xkSDfU4cyt0bjZRot18F-PE29RJFSkC=YPz6oQ@mail.gmail.com>
 <1e4cead4-73b7-461f-b4d4-a66e293d0d96@amd.com>
 <CADnq5_OnTfvMf+Bx3V36p0W_M4ARksHZ+emGSNb07Us9xPr2uw@mail.gmail.com>
 <c9e1526e-c2b6-465c-9f82-24299d8a0e23@amd.com>
In-Reply-To: <c9e1526e-c2b6-465c-9f82-24299d8a0e23@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 11:19:12 -0400
X-Gm-Features: AUfX_mwjAFxX3pTeOBeEZ5cNsq0lB7NmgMnj7D3N6M7oS_OPqEAthXyG0jjQb4A
Message-ID: <CADnq5_P8dPWAJCd_=u13KKDPmJQecC9MqHJ6K9g4+4iQxYvi_Q@mail.gmail.com>
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

On Tue, Jul 14, 2026 at 11:13=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 7/14/26 17:03, Alex Deucher wrote:
> > On Tue, Jul 14, 2026 at 9:46=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 7/14/26 15:42, Alex Deucher wrote:
> >>> On Tue, Jul 14, 2026 at 3:19=E2=80=AFAM Christian K=C3=B6nig
> >>> <christian.koenig@amd.com> wrote:
> >>>>
> >>>> On 7/13/26 20:27, Alex Deucher wrote:
> >>>>> Use this interface to issue TLB invalidations using
> >>>>> SDMA.
> >>>>
> >>>> Hui? What should that be good for?
> >>>
> >>> To use as a replacement for doing the invalidation using MES.
> >>
> >> We should already have that as workaround for the Navi 1x SDMA bug.
> >>
> >> I suggest to just move that code into a separate function instead.
> >>
> >> But the SDMA can't do PASID based invalidation and that is what we nee=
d the MES for, so I'm not sure how useful that will be.
> >
> > The current gmc code doesn't do pasid based invalidation either.
> > Everything ends up in gmc_vXX_0_flush_gpu_tlb() for each gmc version.
>
> Yeah, but that one shouldn't use the MES in the first place. We could use=
 direct register accesses here.
>
> Using the MES makes only sense if we invalidate per PASID.
>
> Why are we using the MES for per VMID invalidation?

gfxoff.  We can't access the registers directly unless we disallow gfxoff.

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
> >>> Alex
> >>>
> >>>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>>
> >>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>> ---
> >>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 18 ++++++++++++++++++
> >>>>>  1 file changed, 18 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_sdma.h
> >>>>> index 4f4e56022c970..4ab92d287675a 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>>>> @@ -155,6 +155,23 @@ struct amdgpu_buffer_funcs {
> >>>>>                                uint64_t dst_offset,
> >>>>>                                /* number of byte to fill */
> >>>>>                                uint32_t byte_count);
> >>>>> +
> >>>>> +     /* number of dw to reserve per operation */
> >>>>> +     unsigned        tlb_inv_num_dw;
> >>>>> +
> >>>>> +     /* used for buffer clearing */
> >>>>> +     void (*emit_tlb_inv)(struct amdgpu_device *adev,
> >>>>> +                          struct amdgpu_ib *ib,
> >>>>> +                          /* vmid to target */
> >>>>> +                          unsigned int vmid,
> >>>>> +                          /* vmhub to target */
> >>>>> +                          u32 vmhub,
> >>>>> +                          /* inv eng to target */
> >>>>> +                          u32 eng,
> >>>>> +                          /* flush type */
> >>>>> +                          u32 flush_type,
> >>>>> +                          /* XCC to target */
> >>>>> +                          u32 xcc_inst);
> >>>>>  };
> >>>>>
> >>>>>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t =
instance_id,
> >>>>> @@ -162,6 +179,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_devi=
ce *adev, uint32_t instance_id,
> >>>>>
> >>>>>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman=
.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
> >>>>>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.bu=
ffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
> >>>>> +#define amdgpu_emit_tlb_inv(adev, ib, v, h, e, f, x) (adev)->mman.=
buffer_funcs->emit_tlb_inv((adev), (ib), (v), (h), (e), (f), (x))
> >>>>>
> >>>>>  struct amdgpu_sdma_instance *
> >>>>>  amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
> >>>>
> >>
>
