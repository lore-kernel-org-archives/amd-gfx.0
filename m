Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656AEC77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 13:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E491C10E7D8;
	Wed, 12 Apr 2023 13:02:58 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0475610E7D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 13:02:57 +0000 (UTC)
Received: by mail-yb1-xb33.google.com with SMTP id e10so2555205ybp.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 06:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681304576; x=1683896576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmHBcMp3/prlmsmUF3Wy5qkNo8OUbj51alMKTLE/0tc=;
 b=HLF+fSTZn4/IahbsXic6I7GXqq4ALLSE96rjGYD7S4uOy2n9ye6IKzi/69N5uPJFBS
 dzj4r4PxBV/hPCSEKU4Z26dqiLa0CnQqpUAiMkIzh5DuZ1sxaPWi+c0CAjIeeKwU5128
 4gXB2f/yFSWnBSrogmE/EPDOv8WoKZzzCiGqJbuY2L2gHR1D7sUfKpDqqizz584cpKcn
 HROPm/r6m9VspHsYkRK5Gq2XImqvF09au3PeCgA/t+mhBEDJIBysJBtX87cQfOp8tXke
 OMh8R/h33Afuo58ZAvWSf8PBM+cmZs9fOnIM8V9mQJ5BEowFfilAiM5KoyHy+dKYyzwu
 Bjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681304576; x=1683896576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmHBcMp3/prlmsmUF3Wy5qkNo8OUbj51alMKTLE/0tc=;
 b=OMSp5kaIj/0WjMIIG1bnQglz9wEW06oTgJsDfzAYut/dq9ryVgfslvkLzsLdeVZXCU
 wnu6Ihi8xhslkQwArQhzUVDvwBsQpWY9H5CtEZ7u8oHhHoz8Nlh5ljb18aJoc/mBqOzy
 +kDOwk3vEU79fXgTVaAts80+tCy4I7dJAzPLFc+p8ZIUvWjsL1J7EIaKUrpgil71zL3o
 9iij8KF1O7o0fMCo8TWhT+zaB0Ld+lwhryzfImcMN0t0L2hPhmOnVtJfdzqfu1V4VmGa
 rm8GShiEiZE1P3dWJ0a/JSBY4EFmFhoKmkaM8kIRMFcH5cf9iAmmD0YktEXzpgyumK8m
 F4bA==
X-Gm-Message-State: AAQBX9dzTpXzR9CfKAqHF3T7G/M0nIkZZ9cymRX6fAFyS/Ab3rwSgMM6
 Tx4hChM2rG/9SJxixKJ7aoXZKwiYP99Dq1VLurM9sw==
X-Google-Smtp-Source: AKy350ZpmHUtpGXcc3opZMNE52u6mExNN+5Wi2kbaw7g/SUUud0PNG89e8wvLUVrRzdc8lLE6ZInrsQQKCWepVT9Jyg=
X-Received: by 2002:a25:d4ca:0:b0:b77:676c:773c with SMTP id
 m193-20020a25d4ca000000b00b77676c773cmr1638169ybf.2.1681304576573; Wed, 12
 Apr 2023 06:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230412121827.1122035-1-bas@basnieuwenhuizen.nl>
 <CAD=4a=VJ2V9=RQRtLmrokNx2id67pmbw+DnBe=_W2A7fAtN4rQ@mail.gmail.com>
In-Reply-To: <CAD=4a=VJ2V9=RQRtLmrokNx2id67pmbw+DnBe=_W2A7fAtN4rQ@mail.gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Wed, 12 Apr 2023 15:00:34 +0200
Message-ID: <CAP+8YyGsrUCJYhsY0imNgfWN-Cmvv-jT4T9027n9eGUqs3dD0w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Add a max ibs per submission limit.
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
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
Cc: alexander.deucher@amd.com, maraeo@gmail.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 12, 2023 at 3:01=E2=80=AFPM Ernst Sj=C3=B6strand <ernstp@gmail.=
com> wrote:
>
> Sorry if I read this completely wrong, but the other patch says "radv cur=
rently has
> a limit of 192 which seems to work for most gfx submissions, but
> is way too high for e.g. compute or sdma.", while you return 192 for AMDG=
PU_RING_TYPE_COMPUTE
> here still?

Yeah this totally changes the limits (to simplify), relying on the
code in amdgpu_ring_init to make the ring a bit larger. If I go the
WARN_ON route I have to lower them or go to the rings and make them
larger there.
>
> Regards
> //Ernst
>
> Den ons 12 apr. 2023 kl 14:20 skrev Bas Nieuwenhuizen <bas@basnieuwenhuiz=
en.nl>:
>>
>> And ensure each ring supports that many submissions. This makes
>> sure that we don't get surprises after the submission has been
>> scheduled where the ring allocation actually gets rejected.
>>
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
>> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 +++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 25 ++++++++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>>  3 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_cs.c
>> index 7af3041ccd0e..8362738974c8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -110,6 +110,9 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *=
p,
>>         if (r < 0)
>>                 return r;
>>
>> +       if (num_ibs[r] >=3D amdgpu_ring_max_ibs(chunk_ib->ip_type))
>> +               return -EINVAL;
>> +
>>         ++(num_ibs[r]);
>>         p->gang_leader_idx =3D r;
>>         return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ring.c
>> index dc474b809604..abd70d2f26f6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -49,6 +49,25 @@
>>   * them until the pointers are equal again.
>>   */
>>
>> +/**
>> + * amdgpu_ring_max_ibs - Return max IBs that fit in a single submission=
.
>> + *
>> + * @type: ring type for which to return the limit.
>> + */
>> +unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
>> +{
>> +       switch (type) {
>> +       case AMDGPU_RING_TYPE_GFX:
>> +       case AMDGPU_RING_TYPE_COMPUTE:
>> +               /* gfx/compute are often used more extensively and radv
>> +                * has historically assumed the limit was 192.
>> +                */
>> +               return 192;
>> +       default:
>> +               return 50;
>> +       }
>> +}
>> +
>>  /**
>>   * amdgpu_ring_alloc - allocate space on the ring buffer
>>   *
>> @@ -182,6 +201,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, str=
uct amdgpu_ring *ring,
>>         int sched_hw_submission =3D amdgpu_sched_hw_submission;
>>         u32 *num_sched;
>>         u32 hw_ip;
>> +       unsigned int max_ibs_dw;
>>
>>         /* Set the hw submission limit higher for KIQ because
>>          * it's used for a number of gfx/compute tasks by both
>> @@ -290,6 +310,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, st=
ruct amdgpu_ring *ring,
>>                 return r;
>>         }
>>
>> +       max_ibs_dw =3D ring->funcs->emit_frame_size +
>> +                    amdgpu_ring_max_ibs(ring->funcs->type) * ring->func=
s->emit_ib_size;
>> +       max_ibs_dw =3D (max_ibs_dw + ring->funcs->align_mask) & ~ring->f=
uncs->align_mask;
>> +       max_dw =3D max(max_dw, max_ibs_dw);
>> +
>>         ring->ring_size =3D roundup_pow_of_two(max_dw * 4 * sched_hw_sub=
mission);
>>
>>         ring->buf_mask =3D (ring->ring_size / 4) - 1;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ring.h
>> index 3989e755a5b4..e6e672727529 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -317,6 +317,7 @@ struct amdgpu_ring {
>>  #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r=
),(o))
>>  #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
>>
>> +unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
>>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>>  void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
>>  void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
>> --
>> 2.40.0
>>
