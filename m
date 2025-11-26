Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A846D10F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 14:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1257B10E615;
	Wed, 26 Nov 2025 14:12:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jQ+BzOG1";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1557A10E615
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 14:12:48 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-bceaaed0514so582672a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 06:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764166367; x=1764771167; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLtXY9kyRcXxRiVIAelR1TGgoB5H1meQiLz13Qz0Fhg=;
 b=jQ+BzOG1NuB0UtRToqusA+869yaUoGn5Au+2W8aeNcWHph3Wz/5/6ozkIB9jxYx6zF
 g7OgxLA3pYxQyb6blc0+PSaL8rzr58Db4XQW321OKxU17zUwdkAdS2dU1c1FmdM6SyH/
 80TFD0w0wNRDeXeyzk7+sDviyL6fDvQVgIiTNN0/EqYi0msUZ4FiDOIl+T7Brll6OvKH
 cpOJk10xK13B3mazB5iIR2mehlLsf+zgaizMpeeDzQuogngti/0OKKyhLcHknu5+frWj
 kyZZUeE+yx2Mr+iOczOon+KRyrF3Y3JsTi9Sg1qzUVVSkYF+9traAGeGIma691jz+tGK
 JLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764166367; x=1764771167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yLtXY9kyRcXxRiVIAelR1TGgoB5H1meQiLz13Qz0Fhg=;
 b=SW3emtZC0NvwUFOejHlVrUkhyD2nmnyVhjQYJbDPH1HvZoIyXBOuDtoL0udV1KkTli
 usLE3pJiU393TPUQvjR0zP8Ev+Fz+0gUyd5FrCgigLixEB3HAuIl0jKWj2JCwhhKaEsR
 YfgKxOVdlkplzUhK8IF95TJRqifRBly5AcgISP6849vGen9oECNzaj+dRoT3Jxcdi+QW
 yr3l5g9585dQt8k1QgrAdZbBLSqCTRML6VRlIOuqFaRUjX7WnuZa6bPhlDTsEVdAysVq
 HjQacdYG9fJ6HBfMH9sPlPbwBgUd5ZHtvh3cepsscXXOterc2/3JPtrT2plXVgXQBqK4
 nGXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL3xvRjTI0jDFu3dfy2raicgSh1fl9RG6AaSfXJjvrfW5bD5YL80CWDIbIvlZf1gpZjYopzraH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlkkaZMVHH2Y+O+ly0N4NQYQYqw1NXsSqbU/lP2vu9IuoSQJY2
 g4jSsdz5bksh+RQJxoHQX1o15oZEvfHYZYkc5JvLJSKtpn4FJP1//1cHj6M2db32QohPXbpB+iF
 QlfhgmHI98XCl3D+Ds2nX+g9m1HAwh/Y=
X-Gm-Gg: ASbGncuw4nhH2qjTr0OTc3gsRJ46LQteHu5QkSQnjkB7M6dzkuVFS1jvIZPMSyopp1E
 sYYzAS2ICx/4YUerj2Z4eezYzYbbus9rX7bIxVuhxAClKTRiBeU3n99iFqm5hY84fGDv2Fp9E7f
 6WF4d5VXwj49W816F4m0NuVLAXB3hYtM6WVO25Q05JyHYqTeUv8L0DMkBzlZDy+DjnOgtOUTUwB
 05Jaq8PEWJlJ+JKldD6QkWHwci/Mdth9w5SLp5Lkvx5W5l2k/2MBKsUBm0VHqZ4oMGukjc=
X-Google-Smtp-Source: AGHT+IH+VgkLA18SLnYm8AMMRdsk5iX3vEVEKdgJyAQ3Slr1x+CtP63LGAJN/y1ohqaCJ5Ja+DVp8ff/rXJTl65axKU=
X-Received: by 2002:a05:7022:ea46:10b0:11b:acd7:4e48 with SMTP id
 a92af1059eb24-11c9f2fcd10mr10191764c88.2.1764166367420; Wed, 26 Nov 2025
 06:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20251118220637.3594610-1-alexander.deucher@amd.com>
 <264534d7-86cc-4964-8225-07a32e2373cd@damsy.net>
 <CADnq5_PZr7Ce4weM1zc+CnwREM6A2=e57QBKBsbkm0s4theseg@mail.gmail.com>
In-Reply-To: <CADnq5_PZr7Ce4weM1zc+CnwREM6A2=e57QBKBsbkm0s4theseg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Nov 2025 09:12:35 -0500
X-Gm-Features: AWmQ_bkuCdV2d1Rh-vhSc4E9DIoVE526RQ35297X-w9k4x46Rvhci86Weou3ebY
Message-ID: <CADnq5_N9rcs9F-V=BYWUaVDLnN7Lcqh7XOFjmfx0u6BuSruHMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gmc11: add amdgpu_vm_handle_fault()
 handling
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
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

Ping on this series?

On Wed, Nov 19, 2025 at 10:16=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Wed, Nov 19, 2025 at 3:14=E2=80=AFAM Pierre-Eric Pelloux-Prayer
> <pierre-eric@damsy.net> wrote:
> >
> >
> >
> > Le 18/11/2025 =C3=A0 23:06, Alex Deucher a =C3=A9crit :
> > > We need to call amdgpu_vm_handle_fault() on page fault
> > > on all gfx9 and newer parts to properly update the
> > > page tables, not just for recoverable page faults.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 27 +++++++++++++++++++++++=
+++
> > >   1 file changed, 27 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm=
/amd/amdgpu/gmc_v11_0.c
> > > index 7bc389d9f5c48..25cdcb850416c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > > @@ -103,12 +103,39 @@ static int gmc_v11_0_process_interrupt(struct a=
mdgpu_device *adev,
> > >       uint32_t vmhub_index =3D entry->client_id =3D=3D SOC21_IH_CLIEN=
TID_VMC ?
> > >                              AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
> > >       struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub_index];
> > > +     bool retry_fault =3D !!(entry->src_data[1] & 0x80);
> > > +     bool write_fault =3D !!(entry->src_data[1] & 0x20);
> > >       uint32_t status =3D 0;
> > >       u64 addr;
> > >
> > >       addr =3D (u64)entry->src_data[0] << 12;
> > >       addr |=3D ((u64)entry->src_data[1] & 0xf) << 44;
> > >
> > > +     if (retry_fault) {
> > > +             /* Returning 1 here also prevents sending the IV to the=
 KFD */
> > > +
> > > +             /* Process it onyl if it's the first fault for this add=
ress */
> >
> > typo: onyl -> only (same for patch 2/3)
>
> Fixed locally.  thanks!
>
> Alex
>
> >
> > Pierre-Eric
> >
> >
> >
> > > +             if (entry->ih !=3D &adev->irq.ih_soft &&
> > > +                 amdgpu_gmc_filter_faults(adev, entry->ih, addr, ent=
ry->pasid,
> > > +                                          entry->timestamp))
> > > +                     return 1;
> > > +
> > > +             /* Delegate it to a different ring if the hardware hasn=
't
> > > +              * already done it.
> > > +              */
> > > +             if (entry->ih =3D=3D &adev->irq.ih) {
> > > +                     amdgpu_irq_delegate(adev, entry, 8);
> > > +                     return 1;
> > > +             }
> > > +
> > > +             /* Try to handle the recoverable page faults by filling=
 page
> > > +              * tables
> > > +              */
> > > +             if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, ad=
dr,
> > > +                                        entry->timestamp, write_faul=
t))
> > > +                     return 1;
> > > +     }
> > > +
> > >       if (!amdgpu_sriov_vf(adev)) {
> > >               /*
> > >                * Issue a dummy read to wait for the status register t=
o
