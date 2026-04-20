Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01C4F5A8AC
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 18:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8577810E752;
	Mon, 20 Apr 2026 18:35:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CC8j42ew";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 740E110E753
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 18:35:54 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12714f01940so200227c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 11:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776710154; cv=none;
 d=google.com; s=arc-20240605;
 b=X38NUnVUUxJOr+XntazzDmxW4cWBoEZ9Od8NMSKK+i4QDsWngbiVPRpIbq/EMXtMtY
 Ch6txXstYKMmB6q4crSzOhvb44ANXAQBAFFKD3IVVw0T8uqnn3TFyx1f9FO6htJBXL4A
 o3dtFuwT6yAyQbIGPWsj9bZYso4EGKVSn669hPAwNM4H1WHXcdG1++Qgd4e+Uswtc81h
 AE2PKABzg6eQvjDiuaE35F2V1OycWaGTGoTh2B1cPhkyolRx5J3+xEUBECHJ8ADePjsf
 2RqcVE8GdLe7s6Npou4c3ukUjlGoFJ27cecmuSp/wDe17Wk8DHUas9gjpt2GrFMxlKiV
 zMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uxBm15eIKaXf6CUs+pV/AMJ0q6nJrZkgFaiTVCD3ZSE=;
 fh=lCkMuWnSZIwiZC/++vilQGjKRarhwu8gesIR6nG47Nk=;
 b=R8pWpRp6j9tRbkEf9zudnHGABP+9xoSXDJ4cx8jKnud5EOoJNkBx+T+DAG2Tz/4OIL
 khHRffV8Ycovrh/0CeVo20HF3Dml6yB9ouaSaDcXW0iZVMgyzkQAM0PVOHFaUa+eDnOy
 8D+ZDpU4KnPonNAhEsOW6uiO0nMARJettfm5V6srzufbR0GzRkoYCNk0F9c0eYG4xjSp
 AoE61ith5eOcrL1G5+DPaYiFTPCcXahIS79hUaDKrooT6gc/ZiSTrxBqkFJaZ3He+x7W
 yh3nfJduafVuzYC3oi2OfCrHiOXpw69XnfwxPl/Dq9sfDuvYOdeQSc2ZRcGCw/66f4RP
 kmxA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776710154; x=1777314954; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxBm15eIKaXf6CUs+pV/AMJ0q6nJrZkgFaiTVCD3ZSE=;
 b=CC8j42ewJxW4dxsXSxgNPfFLfBa8FIIp39H6bnynQVGZ34MafE5Kkv8rk2TMOJJQPs
 GV2CtsUQGv8PcWJUBrxwgC867uhxytMJTUYMkPGHxz7bNTxyl71SHiTRR8ztuVOSnz9f
 uz9KmEnaK1Jjm4uyNJoGbHFGGQJ0hJkJDt+3eBadsV0MjjJg/XzWlqgmG6gyEJdi6M1f
 VywAJjQKK7qqys8Byl/77Gou4RUero6Or1PiF2mGOnt61TwZpfQF/F6kotbebLNwDvfD
 QFDOWGyK2M5DxLKOs6PgXAFKwCmP9aanl5O5DScCE7hiw19kCc2W5sZlivEsoymwlWzj
 Pbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776710154; x=1777314954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uxBm15eIKaXf6CUs+pV/AMJ0q6nJrZkgFaiTVCD3ZSE=;
 b=Kdfq4EGjFQcMeJTXqgOl21FD700XuIAPXq6sZkAL8oQxexOOfpjPGve4SA/zj0D1Zg
 /nS/JSVPjXDG34ZuwzCHswSzsj7Iq8a9ll1GN+Q89Lz9YHJI5DhW6U2S5wf0ado7D21N
 j0lSgl8oSZi/+EV7CE3RolDAdw+7/bYJPLXayM6kdCHo1k3SPzblof/o+59UQJk8dUs5
 luV19x3QX29Dt0yNzxesE6h0kEW98VoBOuSuW1wqSj6KJ8kXUdVaphCObYqJEnYK5uUM
 L1EK0puFffMrlhaPqGR4DhE4uuVPtPszOIzyg2gGlAISG3pqwqe2+pYq+It/Sa8E3W4I
 8nrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uG9CNplBaueLbhmblDJDvYUYqGpnbkzgRN5ef0GJCW426/Aq/3uPd2/DYfbhtrpia3nNLFP/f@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTaKvqegZmJTDocHcgA9Zl0KKdHWS2VSIzrwRqpMC0qizRAF6R
 e2ory8zS8FSeyYGLMaaUc0ol1e+ZyNWEnni4+GmPd0CQMfsVX4/sd1H03+9XhVMd2HaUElIK5ay
 N1W16wCr3XLKdWmYu+WChcb1eO8nSE0c=
X-Gm-Gg: AeBDieta/izHG6d/ubTERsTipzK9VhqdcBWQ6/6O/Zx1+M21jA/x/uV3it6FHqWlZ0U
 kZPrF7epEPuoYqm1Pb6a1QvVakTaH4jBzxE+Wx9208rFZyNRNBUSMSVGRgp0bYj+Qw5548hZhWv
 FNUi0y8iZRyTc6x8uTvWJ6b+lrqY3aRgSyRHMhdF+PJqQG9iSvC2cjnbNeddL8TS1JbA9hD3hIL
 g5PvAkFFzUhPYMdAT+7kXFIy3lxYI9bH3EsQxSKPuCeOT8Uz74npgvYZBV5BcULpKEwt/ib9ZTF
 uF8fQD6Xhe5Mo6GIikLRGQwUqeW1EGzmuJ0NAn96s/AnSR1H+TAu5BLHfpr5KwyejdFVSA0WbiV
 T/KzB
X-Received: by 2002:a05:7022:170a:b0:12c:8cd7:d463 with SMTP id
 a92af1059eb24-12c8cd7dbb7mr537251c88.2.1776710153607; Mon, 20 Apr 2026
 11:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260420032858.10286-1-giovannauchoa@usp.br>
 <CADnq5_P2+OqDtmhwOAuM9QsOFi8D45QA+=XOCqJ1vbMbjVQJCg@mail.gmail.com>
 <7eb86bbd-d875-474c-a052-176f6d00ad79@amd.com>
 <CADnq5_MTSC4ehVTOaeJ2ui3LwD8=em1+Kgu7yCh68aLgXa1dKQ@mail.gmail.com>
 <5d32ad1b-5788-44b1-bb21-5f37891b6c82@amd.com>
In-Reply-To: <5d32ad1b-5788-44b1-bb21-5f37891b6c82@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Apr 2026 14:35:41 -0400
X-Gm-Features: AQROBzDaY6bQVpjMQIxONLXzyMK-efKdJyvL4BEtf4GywhSubDDUeq7eI5HH7Ug
Message-ID: <CADnq5_P7mGBw21FYTfZwaff+3G6Ddj1wkCTKOU=LRLaVgF4ZAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: consolidate SDMA trap IRQ handler
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Giovanna Uchoa <giovannauchoa@usp.br>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Mon, Apr 20, 2026 at 2:31=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/20/26 20:25, Alex Deucher wrote:
> > On Mon, Apr 20, 2026 at 2:23=E2=80=AFPM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> Wait a second Alex, this patch actually doesn't make sense at all.
> >>
> >> The code is only common for a subset of SDMA engines and so shouldn't =
be moved into a common handler.
> >
> > It still reduces duplication across the chips where it is shared.  I
> > can kind of go either way on this.
>
> Well it was your decision when we started amdgpu that we don't want to do=
 this and as far as I can see it is still the right thing to do.
>
> We have avoided tons of issues with that approach since the code is indep=
endent per generation and modifications doesn't automatically affect all of=
 them.
>

Fair enough.  Patch dropped.

Alex

> I mean we can clearly cleanup the code, the DRM_DEBUG() is just superflou=
s since we have a general tracepoint for IRQs and I think we can reduce the=
 switch case to just an if. E.g. something like:
>
> u8 instance_id, queue_id;
>
> instance_id =3D (entry->ring_id & 0x3) >> 0;
> queue_id =3D (entry->ring_id & 0xc) >> 2;
> if (instance_id <=3D 1 && queue_id =3D=3D 0)
>         amdgpu_fence_process(&adev->sdma.instance[instance_id].ring);
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
> >> On 4/20/26 20:18, Alex Deucher wrote:
> >>> Applied.  Thanks!
> >>>
> >>> Alex
> >>>
> >>> On Mon, Apr 20, 2026 at 9:09=E2=80=AFAM Giovanna Uchoa <giovannauchoa=
@usp.br> wrote:
> >>>>
> >>>> Move the amdgpu_sdma_process_trap_irq handler from version-specific
> >>>> implementations (cik_sdma, sdma_v2_4, sdma_v3_0) to the common SDMA
> >>>> module (amdgpu_sdma). This eliminates code duplication and centraliz=
es
> >>>> the trap interrupt handling logic, which is identical across all SDM=
A
> >>>> versions.
> >>>>
> >>>> Update the trap_irq_funcs in each version-specific module to referen=
ce
> >>>> the common handler implementation.
> >>>>
> >>>> Signed-off-by: Giovanna Uchoa <giovannauchoa@usp.br>
> >>>> ---
> >>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41 +++++++++++++++++++++=
+
> >>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 ++
> >>>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 43 +--------------------=
---
> >>>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 42 +--------------------=
--
> >>>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 42 +--------------------=
--
> >>>>  5 files changed, 47 insertions(+), 124 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_sdma.c
> >>>> index 321310ba2..4f15334ce 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> >>>> @@ -147,6 +147,47 @@ int amdgpu_sdma_process_ecc_irq(struct amdgpu_d=
evice *adev,
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> +int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
> >>>> +                                    struct amdgpu_irq_src *source,
> >>>> +                                    struct amdgpu_iv_entry *entry)
> >>>> +{
> >>>> +       u8 instance_id, queue_id;
> >>>> +
> >>>> +       instance_id =3D (entry->ring_id & 0x3) >> 0;
> >>>> +       queue_id =3D (entry->ring_id & 0xc) >> 2;
> >>>> +       DRM_DEBUG("IH: SDMA trap\n");
> >>>> +       switch (instance_id) {
> >>>> +       case 0:
> >>>> +               switch (queue_id) {
> >>>> +               case 0:
> >>>> +                       amdgpu_fence_process(&adev->sdma.instance[0]=
.ring);
> >>>> +                       break;
> >>>> +               case 1:
> >>>> +                       /* XXX compute */
> >>>> +                       break;
> >>>> +               case 2:
> >>>> +                       /* XXX compute */
> >>>> +                       break;
> >>>> +               }
> >>>> +               break;
> >>>> +       case 1:
> >>>> +               switch (queue_id) {
> >>>> +               case 0:
> >>>> +                       amdgpu_fence_process(&adev->sdma.instance[1]=
.ring);
> >>>> +                       break;
> >>>> +               case 1:
> >>>> +                       /* XXX compute */
> >>>> +                       break;
> >>>> +               case 2:
> >>>> +                       /* XXX compute */
> >>>> +                       break;
> >>>> +               }
> >>>> +               break;
> >>>> +       }
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>>  static int amdgpu_sdma_init_inst_ctx(struct amdgpu_sdma_instance *s=
dma_inst)
> >>>>  {
> >>>>         uint16_t version_major;
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_sdma.h
> >>>> index 2bf365609..ca4fd94ac 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>>> @@ -203,6 +203,9 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgp=
u_device *adev,
> >>>>  int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
> >>>>                                       struct amdgpu_irq_src *source,
> >>>>                                       struct amdgpu_iv_entry *entry)=
;
> >>>> +int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
> >>>> +                                    struct amdgpu_irq_src *source,
> >>>> +                                    struct amdgpu_iv_entry *entry);
> >>>>  int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 inst=
ance,
> >>>>                                bool duplicate);
> >>>>  void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm=
/amd/amdgpu/cik_sdma.c
> >>>> index 120da838a..1bf1af633 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> >>>> @@ -1141,47 +1141,6 @@ static int cik_sdma_set_trap_irq_state(struct=
 amdgpu_device *adev,
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> -static int cik_sdma_process_trap_irq(struct amdgpu_device *adev,
> >>>> -                                    struct amdgpu_irq_src *source,
> >>>> -                                    struct amdgpu_iv_entry *entry)
> >>>> -{
> >>>> -       u8 instance_id, queue_id;
> >>>> -
> >>>> -       instance_id =3D (entry->ring_id & 0x3) >> 0;
> >>>> -       queue_id =3D (entry->ring_id & 0xc) >> 2;
> >>>> -       DRM_DEBUG("IH: SDMA trap\n");
> >>>> -       switch (instance_id) {
> >>>> -       case 0:
> >>>> -               switch (queue_id) {
> >>>> -               case 0:
> >>>> -                       amdgpu_fence_process(&adev->sdma.instance[0]=
.ring);
> >>>> -                       break;
> >>>> -               case 1:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               case 2:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               }
> >>>> -               break;
> >>>> -       case 1:
> >>>> -               switch (queue_id) {
> >>>> -               case 0:
> >>>> -                       amdgpu_fence_process(&adev->sdma.instance[1]=
.ring);
> >>>> -                       break;
> >>>> -               case 1:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               case 2:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               }
> >>>> -               break;
> >>>> -       }
> >>>> -
> >>>> -       return 0;
> >>>> -}
> >>>> -
> >>>>  static int cik_sdma_process_illegal_inst_irq(struct amdgpu_device *=
adev,
> >>>>                                              struct amdgpu_irq_src *=
source,
> >>>>                                              struct amdgpu_iv_entry =
*entry)
> >>>> @@ -1270,7 +1229,7 @@ static void cik_sdma_set_ring_funcs(struct amd=
gpu_device *adev)
> >>>>
> >>>>  static const struct amdgpu_irq_src_funcs cik_sdma_trap_irq_funcs =
=3D {
> >>>>         .set =3D cik_sdma_set_trap_irq_state,
> >>>> -       .process =3D cik_sdma_process_trap_irq,
> >>>> +       .process =3D amdgpu_sdma_process_trap_irq,
> >>>>  };
> >>>>
> >>>>  static const struct amdgpu_irq_src_funcs cik_sdma_illegal_inst_irq_=
funcs =3D {
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/dr=
m/amd/amdgpu/sdma_v2_4.c
> >>>> index 93ec52c1f..545077897 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> >>>> @@ -1035,46 +1035,6 @@ static int sdma_v2_4_set_trap_irq_state(struc=
t amdgpu_device *adev,
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> -static int sdma_v2_4_process_trap_irq(struct amdgpu_device *adev,
> >>>> -                                     struct amdgpu_irq_src *source,
> >>>> -                                     struct amdgpu_iv_entry *entry)
> >>>> -{
> >>>> -       u8 instance_id, queue_id;
> >>>> -
> >>>> -       instance_id =3D (entry->ring_id & 0x3) >> 0;
> >>>> -       queue_id =3D (entry->ring_id & 0xc) >> 2;
> >>>> -       DRM_DEBUG("IH: SDMA trap\n");
> >>>> -       switch (instance_id) {
> >>>> -       case 0:
> >>>> -               switch (queue_id) {
> >>>> -               case 0:
> >>>> -                       amdgpu_fence_process(&adev->sdma.instance[0]=
.ring);
> >>>> -                       break;
> >>>> -               case 1:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               case 2:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               }
> >>>> -               break;
> >>>> -       case 1:
> >>>> -               switch (queue_id) {
> >>>> -               case 0:
> >>>> -                       amdgpu_fence_process(&adev->sdma.instance[1]=
.ring);
> >>>> -                       break;
> >>>> -               case 1:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               case 2:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               }
> >>>> -               break;
> >>>> -       }
> >>>> -       return 0;
> >>>> -}
> >>>> -
> >>>>  static int sdma_v2_4_process_illegal_inst_irq(struct amdgpu_device =
*adev,
> >>>>                                               struct amdgpu_irq_src =
*source,
> >>>>                                               struct amdgpu_iv_entry=
 *entry)
> >>>> @@ -1159,7 +1119,7 @@ static void sdma_v2_4_set_ring_funcs(struct am=
dgpu_device *adev)
> >>>>
> >>>>  static const struct amdgpu_irq_src_funcs sdma_v2_4_trap_irq_funcs =
=3D {
> >>>>         .set =3D sdma_v2_4_set_trap_irq_state,
> >>>> -       .process =3D sdma_v2_4_process_trap_irq,
> >>>> +       .process =3D amdgpu_sdma_process_trap_irq,
> >>>>  };
> >>>>
> >>>>  static const struct amdgpu_irq_src_funcs sdma_v2_4_illegal_inst_irq=
_funcs =3D {
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/dr=
m/amd/amdgpu/sdma_v3_0.c
> >>>> index 3fde9be74..b3eab4e11 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> >>>> @@ -1373,46 +1373,6 @@ static int sdma_v3_0_set_trap_irq_state(struc=
t amdgpu_device *adev,
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> -static int sdma_v3_0_process_trap_irq(struct amdgpu_device *adev,
> >>>> -                                     struct amdgpu_irq_src *source,
> >>>> -                                     struct amdgpu_iv_entry *entry)
> >>>> -{
> >>>> -       u8 instance_id, queue_id;
> >>>> -
> >>>> -       instance_id =3D (entry->ring_id & 0x3) >> 0;
> >>>> -       queue_id =3D (entry->ring_id & 0xc) >> 2;
> >>>> -       DRM_DEBUG("IH: SDMA trap\n");
> >>>> -       switch (instance_id) {
> >>>> -       case 0:
> >>>> -               switch (queue_id) {
> >>>> -               case 0:
> >>>> -                       amdgpu_fence_process(&adev->sdma.instance[0]=
.ring);
> >>>> -                       break;
> >>>> -               case 1:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               case 2:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               }
> >>>> -               break;
> >>>> -       case 1:
> >>>> -               switch (queue_id) {
> >>>> -               case 0:
> >>>> -                       amdgpu_fence_process(&adev->sdma.instance[1]=
.ring);
> >>>> -                       break;
> >>>> -               case 1:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               case 2:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               }
> >>>> -               break;
> >>>> -       }
> >>>> -       return 0;
> >>>> -}
> >>>> -
> >>>>  static int sdma_v3_0_process_illegal_inst_irq(struct amdgpu_device =
*adev,
> >>>>                                               struct amdgpu_irq_src =
*source,
> >>>>                                               struct amdgpu_iv_entry=
 *entry)
> >>>> @@ -1601,7 +1561,7 @@ static void sdma_v3_0_set_ring_funcs(struct am=
dgpu_device *adev)
> >>>>
> >>>>  static const struct amdgpu_irq_src_funcs sdma_v3_0_trap_irq_funcs =
=3D {
> >>>>         .set =3D sdma_v3_0_set_trap_irq_state,
> >>>> -       .process =3D sdma_v3_0_process_trap_irq,
> >>>> +       .process =3D amdgpu_sdma_process_trap_irq,
> >>>>  };
> >>>>
> >>>>  static const struct amdgpu_irq_src_funcs sdma_v3_0_illegal_inst_irq=
_funcs =3D {
> >>>> --
> >>>> 2.53.0
> >>>>
> >>
>
