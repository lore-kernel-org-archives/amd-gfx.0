Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725FCCD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 11:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A46D10E760;
	Tue, 16 Jun 2026 11:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DUbkw+6l";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D06A10E760
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:17:39 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490bc6a7958so42787265e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 04:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781608658; x=1782213458; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+xaKLzEmvbLvQcWoBCj7sJ6QPOEEcnHF2TmK5rP+GcU=;
 b=DUbkw+6lPtvtuuENnxpmx1DwowG4nd3VSBjl4/5bgT4ZpXRaa+hiqED23O4skfutSc
 3iMjitEjDLI+Tw3prItqy3dSuSn6HTKb9mjHJ9aTS1Giigf+XPYyY/7Di+1+Ys/ulUZd
 e7FvS1llHGSw0kQT0/jywH4PxhK3vO1dJ9RqPWWQdcWbqZGuVuDMI4BsX8sDmCZNTXQU
 ase1yAklEKiNu7KNEtgGqvKMkASWQAe2R2j2W6gQMVDeT8V5Nu7BFBYJQb6/zQT8vO+q
 jC44LMcW/D0s85vL13BbebNHcN1O9/QTmbCN4gW+jFK9EVb78smpISObE4PN+hOwQpIR
 I04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781608658; x=1782213458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+xaKLzEmvbLvQcWoBCj7sJ6QPOEEcnHF2TmK5rP+GcU=;
 b=dh0lI7PsqYcqyNgjR6LNNip2Q07t/kUzGXK2jUIJM7slOA/ZL2vBLGavqsQn6xnMm7
 gUzKRp2lZC/64WJgrvOLAQQiazdwVGkKTwO2E/2Gkv3PEAK8FfwgLX+8iHywpugutOeW
 l0v+iGy4ySb7FphF/3k97LHFRvyNxnoBHHKe7DmDkPnlX9IXsEkpybe0/+LZpJ5FbtGw
 mAwyyTmsL0vg2R/tDJj1X1pm1WxaMa3TRb+tPB19WFT/Mn198t7BmRGIYjpbW30eyAXc
 DfP2s98gaVQJsYdY0x/tMuEEwebw2Rv3o2qpwEuF20rFBHjMw/Poq1AworpoH8VtN/ls
 u69Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ83Mj65Z/2xJFvc1OGwmW7TQQ2Gq+DA9gto9+RPGfGSRKqqV+H5hnuFwg6/hWk5tI7nuKePFXmB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVqUhPXT5QEISmiyVu4tDuxKw9nRxpkTcS9OVGMKc6aSeLs1xw
 0yxJnpIyGR/yRpv5d+SbUHq8LsSjO1Uu5d5m26VjTblPAH3ebXpmfhRL
X-Gm-Gg: Acq92OF3nIhGIxqAwwb+yuWVz2oJnqhi+SCvJpnq1DDRyYorqpOdzkBDZM9sm5BeQZh
 WWgBCdL1TepTsozluIWMuqiptu/PgmVH32xGxZWyZNxdlkbFyFU0MbvUbt3w9a2mUwUqKFQMNjN
 D0ekN/vgh1b89nJLNdCz1svrjmwirb70u18G95FuTfpu/yzTPUcSKj9bmQsNKhtk1AA84oHUVIA
 3hjyh4WdbShCSVWwNFbRb4rek+ECQgIOb4dsLrsrH80HRT215Ltr+H3CT8LM5XY3peIstntXDGZ
 W7Lob+zwKEgZ1h2/sUCrzU1enSO9M/HNftj4mFo4oirb/TGxfSZjYcdeYt7w3+29i9ZwE5nvKFx
 Ea8hq9HIbSi8VSBNAuABW+AmAMYxa5+IZjFVaXAABg9xYC6tRsSDQwE1/KOgoLJXCpMSEWe9isF
 XQfc5+k/ZpA6qQBL9SKy+ulmaBy6nb6A9rSu8ICLQOMdxt3qSaFYTRHuP36UiCIFF586St3w==
X-Received: by 2002:a05:600c:810b:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-4922fac1214mr48764665e9.6.1781608657611; 
 Tue, 16 Jun 2026 04:17:37 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a96d14sm48420735e9.12.2026.06.16.04.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 04:17:37 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Natalie Vock <natalie.vock@gmx.de>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 3/7] drm/amdgpu/gmc: Don't compare page fault timestamps
 with other interrupts
Date: Tue, 16 Jun 2026 13:17:36 +0200
Message-ID: <2899310.lGaqSPkdTl@timur-hyperion>
In-Reply-To: <eb84897e-f4b3-4638-b7e7-e8a9dc787297@amd.com>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <c3f7ba5b-ce84-4626-b772-1e7d656aac93@ursulin.net>
 <eb84897e-f4b3-4638-b7e7-e8a9dc787297@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Tuesday, June 16, 2026 12:15:12=E2=80=AFPM Central European Summer Time =
Christian=20
K=C3=B6nig wrote:
> A bit late to the discussion, sorry. Trying to answer questions now.
>=20
> On 6/15/26 17:48, Tvrtko Ursulin wrote:
> > On 15/06/2026 16:32, Timur Krist=C3=B3f wrote:
> >> On Monday, June 15, 2026 5:23:52=E2=80=AFPM Central European Summer Ti=
me Tvrtko
> >>=20
> >> Ursulin wrote:
> >>> On 15/06/2026 15:52, Timur Krist=C3=B3f wrote:
> >>>> On Monday, June 15, 2026 4:32:23=E2=80=AFPM Central European Summer =
Time Tvrtko
> >>>>=20
> >>>> Ursulin wrote:
> >>>>> On 25/05/2026 12:45, Timur Krist=C3=B3f wrote:
> >>>>>> Different interrupts may have different timestamp sources,
> >>>>>> which shouldn't be compared.
> >>>>>>=20
> >>>>>> If we compare the timestamps of retry faults to timestamps
> >>>>>> of other interrupts, it may result in all retry fault
> >>>>>> interrupts being filtered out, because of the different
> >>>>>> time stamp source.
> >>>>>>=20
> >>>>>> This issue was observed on Strix Halo.
> >>>>>> Solved by storing the timestamp of the last page fault interrupt.
> >>>>=20
> >>>> Hi,
> >>>>=20
> >>>>> This one may require access to AMD docs to review. For example I am
> >>>>> immediately curious as to how many different clock sources on a sin=
gle
> >>>>> IH there are
> >>>>=20
> >>>> As far as I know there are various timestamp sources in the GPU and
> >>>> some
> >>>> interrupts use different ones. I am not aware of any documentation on
> >>>> this
> >>>> topic, unfortunately.
> >>>>=20
> >>>>> how does that relate to the timestamp_src field
>=20
> The timestamp_src bit indicates if the timestamp came from the IH block
> which wrote the IV to memory or the original IP block which signaled the =
IH
> that an interrupt happened.
> >>>> The timestamp_src field is set differently when the timestamp source=
 is
> >>>> different. So, it could happen that we accidentally filter out all p=
age
> >>>> faults when we shouldn't.
> >>>>=20
> >>>>> and if there are indeed multiple clock domains should the patch
> >>>>> perhaps
> >>>>> be
> >>>>> generalized to something like
> >>>>> ih->processed_timestamp[entry->timestamp_src] or something?
> >>>>=20
> >>>> For the context of this patch, I think it doesn't matter how many
> >>>> different
> >>>> kinds of time stamps there are. What's important is that we just
> >>>> shouldn't
> >>>> compare timestamps of page faults with time stamps of other interrup=
ts.
> >>>=20
> >>> True, thank you!
>=20
> Yeah, completely agree.
>=20
> >>> Another question is why the backward timestamp check is needed only f=
or
> >>> fault interrupts? I do not see it elsewhere.
> >>=20
> >> Correct, this is only used for retry fault interrupts and only when th=
ey
> >> are dispatched to the soft IH ring.
> >>=20
> >> The reason this was added is because when retry faults are enabled and
> >> the GPU hits a VM fault, it keeps spamming the CPU with many interrupts
> >> for the same fault until the fault is resolved. The CPU needs to filter
> >> out the faults which it is already handling, otherwise we would end up
> >> handling the same fault multiple times.
> >=20
> > Got it, thank you!
> >=20
> >> (As a side note, I should also probably look into how to reduce the
> >> frequency of how often these interrupts are repeated.)
> >>=20
> >>> Let me also ask two more things below.
> >>>=20
> >>>> As far as I see the timestamp doesn't really matter for other
> >>>> interrupts
> >>>> as we only use it to filter out page faults and nothing else.
> >>>>=20
> >>>> Hope this helps,
> >>>> Timur
> >>>>=20
> >>>>>> ---
> >>>>>>=20
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
> >>>>>>     2 files changed, 5 insertions(+), 1 deletion(-)
> >>>>>>=20
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
> >>>>>> 13bec8461cde..52258f1341c2 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>>>>> @@ -437,9 +437,12 @@ bool amdgpu_gmc_filter_faults(struct
> >>>>>> amdgpu_device
> >>>>>> *adev,>
> >>>>>>=20
> >>>>>>         uint32_t hash;
> >>>>>>       =20
> >>>>>>         /* Stale retry fault if timestamp goes backward */
> >>>>>>=20
> >>>>>> -    if (amdgpu_ih_ts_after(timestamp, ih->processed_timestamp))
> >>>>>> +    if (timestamp =3D=3D adev->gmc.processed_fault_timestamp ||
> >>>>>> +        amdgpu_ih_ts_after(timestamp, adev-
> >>>>>=20
> >>>>> gmc.processed_fault_timestamp))
> >>>=20
> >>> First thing is whether you are confident the equality check is either
> >>> safe or required?
> >>=20
> >> I don't see why it wouldn't be safe. But maybe it isn't required.
> >> What do you suggest instead?
> >=20
> > Safe as is whether it has potential to swallow a legitimate unseen faul=
ts.
> >=20
> > Looking at amdgpu_gmc_filter_faults() a bit lower down, it does appear =
to
> > filter out repeated faults on the same address. Would it be safe to rely
> > on that instead of the timestamp equality check?
> Yes.
>=20
> The check was added with patch to make retry page faults more resilent to=
 IH
> ring buffer overflow: commit 3c2d6ea27955cfac8590884d207353eece8c2cee
> Author: Philip Yang <Philip.Yang@amd.com>
> Date:   Thu Nov 18 15:24:55 2021 -0500
>=20
>     drm/amdgpu: handle IH ring1 overflow
>=20
>     IH ring1 is used to process GPU retry fault, overflow is enabled to
>     drain retry fault because we want receive other interrupts while
>     handling retry fault to recover range. There is no overflow flag set
>     when wptr pass rptr. Use timestamp of rptr and wptr to handle overflow
>     and drain retry fault.
>=20
>     If fault timestamp goes backward, the fault is filtered and should not
>     be processed. Drain fault is finished if processed_timestamp is equal=
 to
> or larger than checkpoint timestamp.
>=20
>     Add amdgpu_ih_functions interface decode_iv_ts for different chips to
>     get timestamp from IV entry with different iv size and timestamp offs=
et.
> amdgpu_ih_decode_iv_ts_helper is used for vega10, vega20, navi10.
>=20
>     Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>     Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>     Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>=20
> But as far as I can see the whole idea is completely broken. The timestamp
> can also go backward in case of a reset for example.
>=20
> So having this check like this is clearly a bad idea.
>=20
> What we could do in amdgpu_gmc_filter_faults() is to check some range for
> the timestamp, e.g. last seen timestamp (in amdgpu_gmc_filter_faults(),
> e.g. only faults) - value X is considered a duplicate caused by ring buff=
er
> wrap around.
>=20

Hi,

I agree that filtering based on timestamps is not a good idea in general, a=
nd=20
we should probably re-think it. I wish someone had thought of that in 2021=
=20
when the above patch was accepted.

Maybe this patch should be dropped and the timestamp check should be remove=
d=20
instead. What do you guys think about that?

Best regards,
Timur


>=20
> > I appreciate that may cause a transient interrupt handling storm if the
> > clock granularity is poor, but maybe that is better than losing a fault=
=2E>=20
> >>> For example can two blocks fault with the same timestamp on different
> >>> addresses?
> >>=20
> >> They might. But keep in mind that the GFX block just keeps spamming the
> >> interrupts until the fault is handled. So, if we filter one out by
> >> mistake, we know we will just receive the same fault again very soon.
> >>=20
> >>> Or from a different angle, is the clock granularity good enough to not
> >>> coalesce two separate faults to a single timestamp?
> >>=20
> >> I am not sure about that.
> >=20
> > I guess if the equality filter can be removed then this concern also go=
es
> > away.
> >=20
> > Regards,
> >=20
> > Tvrtko
> >=20
> >>>>>>             return true;
> >>>>>>=20
> >>>>>> +    adev->gmc.processed_fault_timestamp =3D MAX(timestamp,
> >>>>>> adev->gmc.processed_fault_timestamp); +
> >>>=20
> >>> Doesn't a plain assign work here? The if above has already verified n=
ew
> >>> timestamp is larger than the old.
> >>>=20
> >>> Regards,
> >>>=20
> >>> Tvrtko
> >>>=20
> >>>>>>         /* If we don't have space left in the ring buffer return
> >>>>=20
> >>>> immediately */
> >>>>=20
> >>>>>>         stamp =3D max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
> >>>>>>       =20
> >>>>>>             AMDGPU_GMC_FAULT_TIMEOUT;
> >>>>>>=20
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> >>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h index
> >>>>>> 676e3aaa1f27..77eb15380284 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> >>>>>> @@ -361,6 +361,7 @@ struct amdgpu_gmc {
> >>>>>>=20
> >>>>>>         u64 noretry_flags;
> >>>>>>         u64 init_pte_flags;
> >>>>>>=20
> >>>>>> +    u64 processed_fault_timestamp;
> >>>>>>=20
> >>>>>>         bool flush_tlb_needs_extra_type_0;
> >>>>>>         bool flush_tlb_needs_extra_type_2;




