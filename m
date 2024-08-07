Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1042FC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 03:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7232610E06C;
	Wed,  7 Aug 2024 03:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l67NhH7U";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E2C10E06C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 03:41:15 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2cfdafdb914so975267a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Aug 2024 20:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723002075; x=1723606875; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKpH5JaXl4YjrAHrc9UiUTFgvHvU/5rv/a4LFzirGkg=;
 b=l67NhH7UAeiL6OXYzpAeN4xMie9HBjy4nGyb+CXrlZS+aV3bNVb4P2R8oX5vR6v6De
 j1s5v5+VDUTo/KfTvb/QI+VynmpJPDGS35qA68Ezzs7c9dCZd50NGNF8ngyeuXnTWXXQ
 zA3UOSZJgqCt+RjcCRAg5VWBA7GvqK2CBnZinSoRKB3BnWV4VDJYJwkRtO7FumQR+tvE
 uKjXnPwjJS0tfD0/6aXqTPfoDjQDz5fgBT4EVtAfI1kJNoTcfHY4e5P7OrgI9PZ7/lv9
 PpIQ94BTwZpywe2w7h0VMS33YcL8jnLvLfl0eeFT04htDespWZDdfUn3muyY11++y1G1
 PKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723002075; x=1723606875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKpH5JaXl4YjrAHrc9UiUTFgvHvU/5rv/a4LFzirGkg=;
 b=jc5KYq0/0IoN2JYsqdsvDoGHbp1lU/5KYQ3/s/DYkjYdeP8Ij1CYgVx1WdpCjLKu46
 gANa9AUR3TdF573wREzdEEF3D4/baXRjpuZmDa4dnK1HP7aomvukYpy0/Ql08YDSxpp2
 bXgNQjRCqrgtCZsSVZhp9BzgzLh5EzsMG1GMcjo1+y8etH4cBe4R21D4yqznWqPJdjHn
 E433KyQ7UOqmII6MTRVQdIK7dK0IbXQ2YFZgJoF9w0ZoEw9P6S8xLv63CnNqiwtANJDQ
 eTAP2q8McCiDJR/VqkXEaw7B420uEZFQH85m9Z3vB1PnncvCRMF0KK/4dy4GKI5Di1SC
 L9iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtXBGi8Y2wztYQvyA/DgpX7lh85HcCkWJc1q9YBsuXqXTJhxVqhWkovWcICmpXC7+nRY0BlMgLrkMRmydOGnqcuZXASjo8T+TbVyIiKQ==
X-Gm-Message-State: AOJu0Ywj9tpHS3BjOzJRMuaep40C1d6908NfeG+YMdEBRkpxxR8Pb7kN
 y/qs+wTpPbZHp+SQZA5Oh4sIH++a+ztIGjAp5HClKeNzZJdCUPd9MpVUX+96E8N+Ecglbrfptv9
 W0SwYrJbyCF3NyPqq3pNcc7g+quk=
X-Google-Smtp-Source: AGHT+IH3hwzoPYYXgCCJlgwWkJYt6ImQqEsUUAaW+qlwF9fMnt9FJquRyDqtQTZBKmdziPVXzNQkwf6Nid4RtonK+h8=
X-Received: by 2002:a17:90b:1802:b0:2c9:7e80:6bc8 with SMTP id
 98e67ed59e1d1-2cff95401a4mr16091931a91.37.1723002075013; Tue, 06 Aug 2024
 20:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240806081825.2422771-1-sunil.khatri@amd.com>
 <20240806081825.2422771-7-sunil.khatri@amd.com>
 <CADnq5_PgwrRWLCRGpx2JMW4TiAbbuWyX_3eAphHreocw1K61cQ@mail.gmail.com>
 <8daf65f2-7fab-4ec1-81d1-1070846adeb3@amd.com>
In-Reply-To: <8daf65f2-7fab-4ec1-81d1-1070846adeb3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Aug 2024 23:41:03 -0400
Message-ID: <CADnq5_NYuhW6+iTY1wP_gcEc=dZ2aCHPQ5QQhke22nphWTj1nw@mail.gmail.com>
Subject: Re: [PATCH v1 06/15] drm/amdgpu: add print support for vcn_v4_0_3 ip
 dump
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Aug 6, 2024 at 11:37=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
>
> On 8/7/2024 3:02 AM, Alex Deucher wrote:
> > On Tue, Aug 6, 2024 at 4:18=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.c=
om> wrote:
> >> Add support for logging the registers in devcoredump
> >> buffer for vcn_v4_0_3.
> >>
> >> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 34 +++++++++++++++++++++++=
+-
> >>   1 file changed, 33 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm=
/amd/amdgpu/vcn_v4_0_3.c
> >> index dd3baccb2904..033e5c88527c 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >> @@ -1823,6 +1823,38 @@ static void vcn_v4_0_3_set_irq_funcs(struct amd=
gpu_device *adev)
> >>          adev->vcn.inst->irq.funcs =3D &vcn_v4_0_3_irq_funcs;
> >>   }
> >>
> >> +static void vcn_v4_0_3_print_ip_state(void *handle, struct drm_printe=
r *p)
> >> +{
> >> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >> +       int i, j;
> >> +       uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_4_0_3);
> >> +       uint32_t inst_off, is_powered;
> >> +
> >> +       if (!adev->vcn.ip_dump)
> >> +               return;
> >> +
> >> +       drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> >> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> >> +               if (adev->vcn.harvest_config & (1 << i)) {
> >> +                       drm_printf(p, "\nHarvested Instance:VCN%d Skip=
ping dump\n", i);
> >> +                       continue;
> >> +               }
> >> +
> >> +               inst_off =3D i * reg_count;
> >> +               is_powered =3D (adev->vcn.ip_dump[inst_off] &
> >> +                               UVD_POWER_STATUS__UVD_POWER_STATUS_MAS=
K) !=3D 1;
> > Actually, we shouldn't be checking whether or not VCN is powered up
> > when we print the results.  We've already stored the registers so we
> > don't care if VCN is powered at this point or not.  VCN could be
> > powered down by the time we print this.  It would be better to just
> > store a flag to determine whether or not we logged the registers in
> > the first place, then use that to determine whether or not we print
> > anything.  Same comment for the other VCN print_ip_state callbacks.
> This is exactly the same being done here.
>
> is_powered =3D (adev->vcn.ip_dump[inst_off] &
> +                               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) =
!=3D 1;
> The above is already stored at the time of capturing the dump, i am just =
checking the value to make sure if it was
> powered up at the time of dump and if yes then add logs to devcore dump e=
lse skip. Its done this way rather than using a variable as there could
> be multiple instances of VCN and one may be powered or not so power state=
 is captured for each instance and based on that value only its we are prin=
ting or logging in devcoredump.

Ah, yes, you are right.  My brain misread that.

Alex

>
> Regards
> Sunil khatri
>
> >
> > Alex
> >
> >> +
> >> +               if (is_powered) {
> >> +                       drm_printf(p, "\nActive Instance:VCN%d\n", i);
> >> +                       for (j =3D 0; j < reg_count; j++)
> >> +                               drm_printf(p, "%-50s \t 0x%08x\n", vcn=
_reg_list_4_0_3[j].reg_name,
> >> +                                          adev->vcn.ip_dump[inst_off =
+ j]);
> >> +               } else {
> >> +                       drm_printf(p, "\nInactive Instance:VCN%d\n", i=
);
> >> +               }
> >> +       }
> >> +}
> >> +
> >>   static void vcn_v4_0_3_dump_ip_state(void *handle)
> >>   {
> >>          struct amdgpu_device *adev =3D (struct amdgpu_device *)handle=
;
> >> @@ -1871,7 +1903,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_f=
uncs =3D {
> >>          .set_clockgating_state =3D vcn_v4_0_3_set_clockgating_state,
> >>          .set_powergating_state =3D vcn_v4_0_3_set_powergating_state,
> >>          .dump_ip_state =3D vcn_v4_0_3_dump_ip_state,
> >> -       .print_ip_state =3D NULL,
> >> +       .print_ip_state =3D vcn_v4_0_3_print_ip_state,
> >>   };
> >>
> >>   const struct amdgpu_ip_block_version vcn_v4_0_3_ip_block =3D {
> >> --
> >> 2.34.1
> >>
