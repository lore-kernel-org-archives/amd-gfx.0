Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBA6C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 13:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA53810ED58;
	Tue, 14 Jul 2026 13:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WDn5BEtn";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47AA810ED58
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:43:00 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c9ff8b54ee3so126760a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 06:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784036580; cv=none;
 d=google.com; s=arc-20260327;
 b=hL4cbOFZkeGFT4saZy8gW41J4V+Oypigd9WxK27jGJkOY8XYaTS4Q+KSeQlIsBc2jW
 7f+oNMLqicHy8Fyko3BViBwX8BiaUl+g87ouAIS6ZRhzEgw0HPkhV/Iyu0debrppowqT
 Du9o3Z+cwcQt3Wgnkim3IaPdIP4Oe9tN6+JX1x2xkZ4YprmOdLNGTtPJChsAMbQNKmHI
 m+KENX9QLdIGRTBGuR2lKJD13davy5T1qsXGzSNL5Bhrb8KM8Qv33pn6NZlDqvitt9Qu
 hIysJSdvLikyg1K+bCz0/5f1JYw1OFLG3FGP583WF8BH/psB+89x7HwK2QazNjEG5UZs
 c6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=R2IFGVaEq1+8OFH2QD4kp1ai5GZ29nON/7kTJXb70AU=;
 fh=2zxESS6xG1PzAexTEGpxISaus6mmWmijjwoz4nAAw3w=;
 b=AS7kyeFEXiECdLNwcINLcA/HrKMy2E3hcYT8lrz6hqbLLBMbrHLltin/u4cTwDRAzc
 OsTC5MuZ9/QELRI/6M/MazQJdVUv3JQRXF/oovS5WJrRUHcgxAnRtalLw4uWjyueH90V
 9VxmQNwCd1bKnJKZU7a1CqKCqmdfQBmU1lQAzzFQtbvLAS+PrlIQxgBukChW0NtMs+7W
 qE2YvbURPbZQTUQbRlT7PVjMGqandVWCfdGK7XER7hpjOucQbsi4C+GdERtMAxFgty9P
 bdCTz2A+nFN5NHSw0AU+RQ0GjiFIk0hrwCI/abJ0UNsRwuNlItEGIp5/KIABAPnxw4Rn
 qY3Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784036580; x=1784641380; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R2IFGVaEq1+8OFH2QD4kp1ai5GZ29nON/7kTJXb70AU=;
 b=WDn5BEtnROr/EdVpqkLmSR20165YmgHEqfRNzn8O+JGNwdEYjB22IsGeKxX3YQa1GS
 ET+iIk3TUHw/mISNdu4hLXetpmJ1c+94PuvIdUfyL+gETUrgegQ6KVi19q7O4UyY35m7
 tZ15ha0c6lcFwoGov4vqnSUzR3KuwvBCMuTUXR6OQK8/+0/yra4mNOIVbzE87GMcEBf3
 b18mZKMRv/xWiMP0bYmC+rCiqUAegWzDAKjqNR8I90pRpTpQ1nN0U1foO2b39Sse3n++
 suNYM6uMnxfPX5rH8g5/2iAGKXWZtNofy/42vWReOovZH1z/7Iy7+p44Hj5d5iHINGIb
 3wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784036580; x=1784641380;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R2IFGVaEq1+8OFH2QD4kp1ai5GZ29nON/7kTJXb70AU=;
 b=lIa7iUkOovPSeGg1GbQb9l8hT8KDaHnaaR2g1L2Vm2gLiHZzEmAZW/aUObHzupgWAI
 t/552HWmPRmX2joQIzpiEYGTu0xgz//IFJN523cs0k//5q6VAoi57aruG+lZyuFdS+IC
 FFypoaSD00RJoVA1dsb8DkcU0pnoGrN6kj2WDpMh42QeZpTqTxyEb5DvFjQ/E8Bjbe0d
 Wu3ie1+ltQyleh7K8PH9Ux3ASk8ZQQ6y0QVnxHDl0TJkiHOzQ0sbx5VpbpjMC0oVQjnm
 hKIuGALPlOq2BQ9KRLzp+10bGTw6JhiBBRk2rN22YOAD7lN+yYracdwKiZuZkk52HUOJ
 siAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXiEuzNJEgXaEehwTQITymR0/c+ugdi95rFBj12WgfZL960IBcDtJuczSMiuLqiGr3AIQwZUGE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHTuRD4lFybaxw07Pl3J+IUuwsWi4RNuriGljmUT8ZmTfAfOg9
 E/A8wVxIw7k7kEctIDwLc5yZeO4qQ88cDV2iPVi8TutOzDlu1yeyFwUSn2Z3fCroGD/EttTF/QG
 e4u/PPBY4Tl+vkMKOuK3PR8+584yOnfCRlQ==
X-Gm-Gg: AfdE7cmIpe7x8b7vx6x3RejOXrukrfQAMo+0ZlHQh83Dnbqvy3CAr6HfHgwvKZLB4AI
 uQcn7rlzpDiDXDhRwoJJnAAPz0oaMOsUGtsQCFSooCkKjIxO0SpOFKHSMZKhiG6bT/l35Cn7Z52
 L7VdzHEqSoP/pRGrxGNMAvj0RM2mAQuQZPwaw7h5mlbxjPxcZ7gAhj/YPVUy/qZer6ZtQl3jpLc
 fp/bCSwua/sV+t0g/2NwaJFk5sV7qJ9l4SDlsAPWUwt0Hy/a5NYJ69VcnyGXikE4S2yIZkf1RRr
 9tE1XeoGUiVYJb6W8n4aStFqEK5Oocaurp7Du/by9QxpuL0j7flRzBU3Ebs=
X-Received: by 2002:a05:6a20:5681:b0:3bf:689a:3950 with SMTP id
 adf61e73a8af0-3c110e35f53mr10135501637.7.1784036579770; Tue, 14 Jul 2026
 06:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260713182732.630947-1-alexander.deucher@amd.com>
 <20260713182732.630947-5-alexander.deucher@amd.com>
 <e8926046-2e03-4224-98ba-8601de0421db@amd.com>
In-Reply-To: <e8926046-2e03-4224-98ba-8601de0421db@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 09:42:48 -0400
X-Gm-Features: AUfX_mxJymiTl1NbV3mdoUxk5wT5UPFkyjbLbk7ortvrn7HLPjIzZanZyf0TapY
Message-ID: <CADnq5_OGJBx5xkSDfU4cyt0bjZRot18F-PE29RJFSkC=YPz6oQ@mail.gmail.com>
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

On Tue, Jul 14, 2026 at 3:19=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 7/13/26 20:27, Alex Deucher wrote:
> > Use this interface to issue TLB invalidations using
> > SDMA.
>
> Hui? What should that be good for?

To use as a replacement for doing the invalidation using MES.

Alex

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_sdma.h
> > index 4f4e56022c970..4ab92d287675a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > @@ -155,6 +155,23 @@ struct amdgpu_buffer_funcs {
> >                                uint64_t dst_offset,
> >                                /* number of byte to fill */
> >                                uint32_t byte_count);
> > +
> > +     /* number of dw to reserve per operation */
> > +     unsigned        tlb_inv_num_dw;
> > +
> > +     /* used for buffer clearing */
> > +     void (*emit_tlb_inv)(struct amdgpu_device *adev,
> > +                          struct amdgpu_ib *ib,
> > +                          /* vmid to target */
> > +                          unsigned int vmid,
> > +                          /* vmhub to target */
> > +                          u32 vmhub,
> > +                          /* inv eng to target */
> > +                          u32 eng,
> > +                          /* flush type */
> > +                          u32 flush_type,
> > +                          /* XCC to target */
> > +                          u32 xcc_inst);
> >  };
> >
> >  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t inst=
ance_id,
> > @@ -162,6 +179,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *=
adev, uint32_t instance_id,
> >
> >  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buf=
fer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
> >  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer=
_funcs->emit_fill_buffer((ib), (s), (d), (b))
> > +#define amdgpu_emit_tlb_inv(adev, ib, v, h, e, f, x) (adev)->mman.buff=
er_funcs->emit_tlb_inv((adev), (ib), (v), (h), (e), (f), (x))
> >
> >  struct amdgpu_sdma_instance *
> >  amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
>
