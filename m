Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1481C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 14:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BDAC10E3E5;
	Mon, 24 Mar 2025 14:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZcNITSrN";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 318AA10E3E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 14:19:45 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-301a6347494so1132030a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742825985; x=1743430785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5+nV0QB/3cVvT8KFJevZq6vPLdi7XhqenpVS4Sa7Tk=;
 b=ZcNITSrNANINH3xMdDgXDVDQvN+y5DHcURtRdtEX0WFSV3saZNtoX0TB8NLCBhU81K
 sa62hq2hbEumiCLdbxDEPV75ADip4D/4Yqq0QgOXtza6aPD5FyvjrN4VvKaxxQ/us2TO
 KWS1zzeVjZTnmEXcTQuYZDU3LB6F7aXJdcrLcnZd3C2fH60YU5irPhPzQhRuenHtlTa0
 itq4v5CLP3X9jQj9l9544KNU1X6qvCNIloQToXpHKV7j2CCPjeFCF3O0T20nXUHqSgba
 BSzuWyyuKJYlkUAVQYhU1XABwNexFv3mdBEnuAbsEklZ+FSP9M+UwbTjBlQ6uf8kIGKy
 z7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742825985; x=1743430785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5+nV0QB/3cVvT8KFJevZq6vPLdi7XhqenpVS4Sa7Tk=;
 b=ORT7jCF4Gre/aKORbaz85Udg88fiv2bTVN9MlI54B2YTuv28zSxEc3usEp16nvn8f4
 ri/5dvk8RV5NL7/jyVjuR5Q5PezAXHO44rX+vG157MpN1dihy/85h4UlTp0KNrH3KzMo
 uzfN4MKfwyFE1Sj4/zx/b9ObSTSp1rTxLlzu6d8z4Kn+Fq31f948brT/3rCf1LmC2kX6
 9HRsx6Ditu5cnm8puFFOgBJmpbisAF3xrvukL4nbc3yu58rBWxyYd8iIXc+BaGXiwwAQ
 KEvSROYbirzy/x0OUGuZM/qnVoh+KLuiJ0qe20Nj9AyZb4a173vfqifFiuwOmeI+KA4u
 NW8A==
X-Gm-Message-State: AOJu0YylTG083mujNqMU/0AkTS4RTjzUPd4k/qHEwR2bhMGJ12onzRVa
 V6ZdYAWeA8Yf7ImiZMVPMkFqYW0CQy9DE/NaiChIZiuS3X5IHi+lO0z7ZQeKCwsGyn9za6biUPa
 BGYmtUd9MdHt4+UEPksBwgLH2XhoXCg==
X-Gm-Gg: ASbGncuXaEDlvcbA5gg6or59M159uVvjscm5N3CmlAol5hE+k1bR+4p9nVyvDM1ADkS
 DZM5xtPC//2sN9BFdUr5lhOHUK6Oi7HVy42XHxvN8XqHtlpgQPcKME3HAGuPdMrRrkaW6MX30Za
 g9Fr8VZD6UiY6kzqoUYYzIV4QS9A==
X-Google-Smtp-Source: AGHT+IHjGsFKI+Z0mmO8TKKDom5/mtNEwqBExB5hFL3uu6lsiw7koqFXYB107ZVxzhKm5rKT0dw6oF3SYq504HJa7J8=
X-Received: by 2002:a17:90b:1b09:b0:2ff:4e90:3c47 with SMTP id
 98e67ed59e1d1-3030fee39d8mr7731172a91.4.1742825984446; Mon, 24 Mar 2025
 07:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250221130030.3703750-1-Prike.Liang@amd.com>
 <20250221130030.3703750-4-Prike.Liang@amd.com>
 <DS7PR12MB6005EFC45E880B99D77781BCFBCD2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_OoqZcLoO+p7MseA9zG8hvXS85JRYpJZ9M=dT9sJMXcWg@mail.gmail.com>
 <DS7PR12MB6005A9ED729A0568C3608BA6FBC92@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB60053C5E76793E6A06471B32FBA42@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60053C5E76793E6A06471B32FBA42@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 10:19:32 -0400
X-Gm-Features: AQ5f1JqfsaJPAHD-bIrOIJQGguggskSXBwadOZ9LX6Rx_js2eq-V29pCGlMU7fM
Message-ID: <CADnq5_NgTvcYQo3eZNEStSq2joorKCN0Lvnd-qX7LC2Hqv6m5Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ pipe
 reset
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Mon, Mar 24, 2025 at 8:01=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> It seems there still requires implementing the gfx11/gfx12 pipe reset fro=
m the project perspective, so please help review the patch series.

See my latest comments on patch 1.  With those addressed the series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lian=
g,
> > Prike
> > Sent: Monday, March 3, 2025 7:23 PM
> > To: Alex Deucher <alexdeucher@gmail.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: RE: [PATCH v2 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ p=
ipe
> > reset
> >
> > [Public]
> >
> > [Public]
> >
> > Thank you for the input. I have confirmed with the firmware team that t=
he CP FW
> > _start instruction address will be kept consistent.
> > Could we move this patch series forward now?
> >
> > Regards,
> >       Prike
> >
> > > -----Original Message-----
> > > From: Alex Deucher <alexdeucher@gmail.com>
> > > Sent: Thursday, February 27, 2025 10:38 PM
> > > To: Liang, Prike <Prike.Liang@amd.com>
> > > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>
> > > Subject: Re: [PATCH v2 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ
> > > pipe reset
> > >
> > > On Thu, Feb 27, 2025 at 7:36=E2=80=AFAM Liang, Prike <Prike.Liang@amd=
.com> wrote:
> > > >
> > > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > >
> > > > Please review the series patch to catch up the gfx latest base and
> > > > to avoid the
> > > commit merged problem.
> > >
> > > See my comment on patch 1:
> > >
> > > #define RS64_FW_UC_START_ADDR_LO 0x3000
> > >
> > > Will this potentially change in future firmware versions or is it
> > > fixed?  If it will change, then let's just read it back from register=
s
> > > and store it in adev-
> > > >gfx.rs64_fw_use_start_addr_lo so that it will be correct if the user
> > > >has a mix of
> > > GPUs in the system.
> > > Other than those comments, the series looks good to me.
> > >
> > > Alex
> > >
> > >
> > > >
> > > > Regards,
> > > >       Prike
> > > >
> > > > > -----Original Message-----
> > > > > From: Liang, Prike <Prike.Liang@amd.com>
> > > > > Sent: Friday, February 21, 2025 9:01 PM
> > > > > To: amd-gfx@lists.freedesktop.org
> > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> > > > > <Prike.Liang@amd.com>
> > > > > Subject: [PATCH v2 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ
> > > > > pipe reset
> > > > >
> > > > > Implement the GFX12 KCQ pipe reset, and disable the GFX12 kernel
> > > > > compute queue until the CPFW fully supports it.
> > > > >
> > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 90
> > > > > +++++++++++++++++++++++++-
> > > > >  1 file changed, 88 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > > > index 79ae7d538844..103298938d22 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > > > @@ -5352,6 +5352,90 @@ static int gfx_v12_0_reset_kgq(struct
> > > > > amdgpu_ring *ring, unsigned int vmid)
> > > > >       return amdgpu_ring_test_ring(ring);  }
> > > > >
> > > > > +static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring=
)
> > > > > +{
> > > > > +
> > > > > +     struct amdgpu_device *adev =3D ring->adev;
> > > > > +     uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> > > > > +     int r;
> > > > > +
> > > > > +     if (!gfx_v12_pipe_reset_support(adev))
> > > > > +             return -EOPNOTSUPP;
> > > > > +
> > > > > +     gfx_v12_0_set_safe_mode(adev, 0);
> > > > > +     mutex_lock(&adev->srbm_mutex);
> > > > > +     soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue,
> > > > > + 0);
> > > > > +
> > > > > +     reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> > > > > +     clean_pipe =3D reset_pipe;
> > > > > +
> > > > > +     if (adev->gfx.rs64_enable) {
> > > > > +
> > > > > +             switch (ring->pipe) {
> > > > > +             case 0:
> > > > > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > > > > CP_MEC_RS64_CNTL,
> > > > > +                                                MEC_PIPE0_RESET,=
 1);
> > > > > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > > > > CP_MEC_RS64_CNTL,
> > > > > +                                                MEC_PIPE0_RESET,=
 0);
> > > > > +                     break;
> > > > > +             case 1:
> > > > > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > > > > CP_MEC_RS64_CNTL,
> > > > > +                                                MEC_PIPE1_RESET,=
 1);
> > > > > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > > > > CP_MEC_RS64_CNTL,
> > > > > +                                                MEC_PIPE1_RESET,=
 0);
> > > > > +                     break;
> > > > > +             case 2:
> > > > > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > > > > CP_MEC_RS64_CNTL,
> > > > > +                                                MEC_PIPE2_RESET,=
 1);
> > > > > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > > > > CP_MEC_RS64_CNTL,
> > > > > +                                                MEC_PIPE2_RESET,=
 0);
> > > > > +                     break;
> > > > > +             case 3:
> > > > > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > > > > CP_MEC_RS64_CNTL,
> > > > > +                                                MEC_PIPE3_RESET,=
 1);
> > > > > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > > > > CP_MEC_RS64_CNTL,
> > > > > +                                                MEC_PIPE3_RESET,=
 0);
> > > > > +                     break;
> > > > > +             default:
> > > > > +                     break;
> > > > > +             }
> > > > > +             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe=
);
> > > > > +             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe=
);
> > > > > +             r =3D (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNT=
R)
> > > > > << 2) - RS64_FW_UC_START_ADDR_LO;
> > > > > +     } else {
> > > > > +             switch (ring->pipe) {
> > > > > +             case 0:
> > > > > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > > > > + CP_MEC_CNTL,
> > > > > +
> > > > > + MEC_ME1_PIPE0_RESET,
> > > > > 1);
> > > > > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > > > > CP_MEC_CNTL,
> > > > > +
> > > > > + MEC_ME1_PIPE0_RESET,
> > > > > 0);
> > > > > +                     break;
> > > > > +             case 1:
> > > > > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > > > > + CP_MEC_CNTL,
> > > > > +
> > > > > + MEC_ME1_PIPE1_RESET,
> > > > > 1);
> > > > > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> > > > > CP_MEC_CNTL,
> > > > > +
> > > > > + MEC_ME1_PIPE1_RESET,
> > > > > 0);
> > > > > +                     break;
> > > > > +             default:
> > > > > +             break;
> > > > > +             }
> > > > > +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
> > > > > +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
> > > > > +             /* Doesn't find the F32 MEC instruction pointer
> > > > > + register, and
> > > > > suppose
> > > > > +              * the driver won't run into the F32 mode.
> > > > > +              */
> > > > > +     }
> > > > > +
> > > > > +     soc24_grbm_select(adev, 0, 0, 0, 0);
> > > > > +     mutex_unlock(&adev->srbm_mutex);
> > > > > +     gfx_v12_0_unset_safe_mode(adev, 0);
> > > > > +
> > > > > +     dev_info(adev->dev,"The ring %s pipe resets: %s\n", ring->n=
ame,
> > > > > +                     r =3D=3D 0 ? "successfully" : "failed");
> > > > > +     /* Need the ring test to verify the pipe reset result.*/
> > > > > +     return 0;
> > > > > +
> > > > > +}
> > > > >  static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigne=
d int vmid)
> > {
> > > > >       struct amdgpu_device *adev =3D ring->adev; @@ -5362,8 +5446=
,10
> > > > > @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
> > > > > unsigned int vmid)
> > > > >
> > > > >       r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid,=
 true);
> > > > >       if (r) {
> > > > > -             dev_err(adev->dev, "reset via MMIO failed %d\n", r)=
;
> > > > > -             return r;
> > > > > +             dev_warn(adev->dev,"fail(%d) to reset kcq  and try =
pipe reset\n",
> > r);
> > > > > +             r =3D gfx_v12_0_reset_compute_pipe(ring);
> > > > > +             if (r)
> > > > > +                     return r;
> > > > >       }
> > > > >
> > > > >       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> > > > > --
> > > > > 2.34.1
> > > >
