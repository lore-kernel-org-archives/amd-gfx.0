Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAB7C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 12:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0272310E4BC;
	Wed, 31 May 2023 12:48:26 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9239110E4BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 12:48:23 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-19f68a583a7so624151fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685537302; x=1688129302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PeW/DM98XuGkaieBWPeNW9yO4H9Z8Pw/V05Rt/+UEzU=;
 b=WU4rlPdW3qj5Fi0w5d8iw0ijycX7T8vO6pP+LA8v2HOgA9xurcGF4w9iiFzht77D1z
 Px9g53iXHW62QHEnbs4GpWmtlu2fZFaHBXYm5r1LPjwGZy+OMbZkbz/NgyFkEYusDHC/
 ouyh7zOB8mfSsE6PyXTQw/ehtPpUoh2r08A6XcWDAEKtly6tzjlDxeo4xlgG/isl304b
 pMkP6LQoAoA7IiMuvqyk2fMzqWm+Sl5XT+VcHDUQ9POsycXZWYeHEr2ye/W5tN91G7xH
 5QeqYEh1YiUFof94LoV6hKBnM4wNMFMCxVqFhDYqT4OyRJarMRF10nyLzXGCXQCWCrcl
 QDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685537302; x=1688129302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PeW/DM98XuGkaieBWPeNW9yO4H9Z8Pw/V05Rt/+UEzU=;
 b=TUFOFru7XHJMFfsmRwVHQ1a2ksyeIKKnsvdXg+zFUa79jmZq/laDx9M2Xl+4+3/suh
 WfwPk5GX0aKC8cACBVhhuajZ1SYLyFL9WyKu4GOe6IjvU5CMkuqLa7B28ozE9Zmo7sbq
 8qIvxs7bu+MNEPKfBQkWXFXmAX1BtsP+ESULiO+pwn6uKWzhxuViP4Zo48qtrxqs8j8Z
 9X8FJoInCdd/8/YuBymqz5jQFUFGxMjx82wjZ4ygLasIF7hDOjqhwzUyWOnXdgj4qEYe
 PeMYLNH0ZcG3yM5TEgm0zHq8ltpxctsdGR5ruNSdeZNRLcNr7wi/12he7U57iOmxY53g
 KFPQ==
X-Gm-Message-State: AC+VfDz8O6mKt8xAjeXGxYx9027QkSrNrG8rWBoRu5aKEKHAGolqhcNC
 tjWViv1amDa3A65d35+E2fNtyWsMYMwiI1gUnrb2adwJ
X-Google-Smtp-Source: ACHHUZ57AeNdtj5/yOz3JdARniYdQ+p2VtvxaUNybzkjKtjmDNvxnv42OcDtL4dEsNFdSZej62/ZvLuqCeRTeWLmEKs=
X-Received: by 2002:a05:6870:f581:b0:19f:202d:cf74 with SMTP id
 eh1-20020a056870f58100b0019f202dcf74mr6827629oab.20.1685537301988; Wed, 31
 May 2023 05:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230421072835.842112-1-evan.quan@amd.com>
 <DM6PR12MB26192A46ED09CDB6BC1A3BF2E4609@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB261983FB6A9A84960055C198E4489@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_MKZsLmTgc4dib3sPA2mwbG0CKTGypf=UqjC79xiXTp-A@mail.gmail.com>
In-Reply-To: <CADnq5_MKZsLmTgc4dib3sPA2mwbG0CKTGypf=UqjC79xiXTp-A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 31 May 2023 08:48:10 -0400
Message-ID: <CADnq5_ND1uYpwK8D_-W0yy-KYR-ZFzCRrUc1rtU1Ui9iC8Y=sQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: conditionally disable pcie lane switching for
 some sienna_cichlid SKUs
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, May 31, 2023 at 8:12=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Sure.  Please go ahead.
>
> Alex
>
> On Wed, May 31, 2023 at 5:54=E2=80=AFAM Quan, Evan <Evan.Quan@amd.com> wr=
ote:
> >
> > [AMD Official Use Only - General]
> >
> > Hi Alex,
> >
> > Can we land this as a temporary solution while we are seeking a more pr=
oper one?
> > This is gating our customer and I was pushed for a solution.
> >
> > BR,
> > Evan
> > > -----Original Message-----
> > > From: Quan, Evan
> > > Sent: Friday, April 21, 2023 3:32 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mari=
o
> > > <Mario.Limonciello@amd.com>
> > > Subject: RE: [PATCH] drm/amd/pm: conditionally disable pcie lane swit=
ching
> > > for some sienna_cichlid SKUs
> > >
> > > [AMD Official Use Only - General]
> > >
> > > This seems able to address some audio noise issue observed per custom=
er's
> > > feedback.
> > >
> > > Evan
> > > > -----Original Message-----
> > > > From: Quan, Evan <Evan.Quan@amd.com>
> > > > Sent: Friday, April 21, 2023 3:29 PM
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Ma=
rio
> > > > <Mario.Limonciello@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> > > > Subject: [PATCH] drm/amd/pm: conditionally disable pcie lane switch=
ing
> > > > for some sienna_cichlid SKUs
> > > >
> > > > Disable the pcie lane switching for some sienna_cichlid SKUs since =
it
> > > > might not work well on some platforms.
> > > >
> > > > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > > > Change-Id: Iea9ceaa146c8706768ee077c10e5d33bce9bc1c2
> > > > ---
> > > >  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 92 +++++++++++++++=
-
> > > --
> > > > -
> > > >  1 file changed, 74 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.=
c
> > > > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > index 4b91cdc3eaa0..e7223513e384 100644
> > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > @@ -2067,33 +2067,94 @@ static int
> > > > sienna_cichlid_display_disable_memory_clock_switch(struct smu_conte=
xt
> > > >     return ret;
> > > >  }
> > > >
> > > > +static void sienna_cichlid_get_override_pcie_settings(struct
> > > > +smu_context
> > > > *smu,
> > > > +                                                 uint32_t
> > > > *gen_speed_override,
> > > > +                                                 uint32_t
> > > > *lane_width_override)
> > > > +{
> > > > +   struct amdgpu_device *adev =3D smu->adev;
> > > > +
> > > > +   *gen_speed_override =3D 0xff;
> > > > +   *lane_width_override =3D 0xff;
> > > > +
> > > > +   switch (adev->pdev->device) {
> > > > +   case 0x73A0:
> > > > +   case 0x73A1:
> > > > +   case 0x73A2:
> > > > +   case 0x73A3:
> > > > +   case 0x73AB:
> > > > +   case 0x73AE:
> > > > +           /* Bit 7:0: PCIE lane width, 1 to 7 corresponds is x1 t=
o x32 */
> > > > +           *lane_width_override =3D 6;
> > > > +           break;
> > > > +   case 0x73E0:
> > > > +   case 0x73E1:
> > > > +   case 0x73E3:
> > > > +           *lane_width_override =3D 4;
> > > > +           break;
> > > > +   case 0x7420:
> > > > +   case 0x7421:
> > > > +   case 0x7422:
> > > > +   case 0x7423:
> > > > +   case 0x7424:
> > > > +           *lane_width_override =3D 3;
> > > > +           break;
> > > > +   default:
> > > > +           break;
> > > > +   }
> > > > +}
> > > > +
> > > > +#define MAX(a, b)  ((a) > (b) ? (a) : (b))
> > > > +
> > > >  static int sienna_cichlid_update_pcie_parameters(struct smu_contex=
t *smu,
> > > >                                      uint32_t pcie_gen_cap,
> > > >                                      uint32_t pcie_width_cap)
> > > >  {
> > > >     struct smu_11_0_dpm_context *dpm_context =3D smu-
> > > > >smu_dpm.dpm_context;
> > > > -
> > > > -   uint32_t smu_pcie_arg;
> > > > +   struct smu_11_0_pcie_table *pcie_table =3D &dpm_context-
> > > > >dpm_tables.pcie_table;
> > > > +   uint32_t gen_speed_override, lane_width_override;
> > > >     uint8_t *table_member1, *table_member2;
> > > > +   uint32_t min_gen_speed, max_gen_speed;
> > > > +   uint32_t min_lane_width, max_lane_width;
> > > > +   uint32_t smu_pcie_arg;
> > > >     int ret, i;
> > > >
> > > >     GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
> > > >     GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
> > > >
> > > > -   /* lclk dpm table setup */
> > > > -   for (i =3D 0; i < MAX_PCIE_CONF; i++) {
> > > > -           dpm_context->dpm_tables.pcie_table.pcie_gen[i] =3D
> > > > table_member1[i];
> > > > -           dpm_context->dpm_tables.pcie_table.pcie_lane[i] =3D
> > > > table_member2[i];
> > > > +   sienna_cichlid_get_override_pcie_settings(smu,
> > > > +                                             &gen_speed_override,
> > > > +                                             &lane_width_override)=
;
> > > > +
> > > > +   /* PCIE gen speed override */
> > > > +   if (gen_speed_override !=3D 0xff) {
> > > > +           min_gen_speed =3D MIN(pcie_gen_cap, gen_speed_override)=
;
> > > > +           max_gen_speed =3D MIN(pcie_gen_cap,
> > > > gen_speed_override);
> > > > +   } else {
> > > > +           min_gen_speed =3D MAX(0, table_member1[0]);
> > > > +           max_gen_speed =3D MIN(pcie_gen_cap, table_member1[1]);
> > > > +           min_gen_speed =3D min_gen_speed > max_gen_speed ?
> > > > +                           max_gen_speed : min_gen_speed;
> > > >     }
> > > > +   pcie_table->pcie_gen[0] =3D min_gen_speed;
> > > > +   pcie_table->pcie_gen[1] =3D max_gen_speed;
> > > > +
> > > > +   /* PCIE lane width override */
> > > > +   if (lane_width_override !=3D 0xff) {
> > > > +           min_lane_width =3D MIN(pcie_width_cap,
> > > > lane_width_override);
> > > > +           max_lane_width =3D MIN(pcie_width_cap,
> > > > lane_width_override);
> > > > +   } else {
> > > > +           min_lane_width =3D MAX(1, table_member2[0]);
> > > > +           max_lane_width =3D MIN(pcie_width_cap, table_member2[1]=
);
> > > > +           min_lane_width =3D min_lane_width > max_lane_width ?
> > > > +                            max_lane_width : min_lane_width;
> > > > +   }
> > > > +   pcie_table->pcie_lane[0] =3D min_lane_width;
> > > > +   pcie_table->pcie_lane[1] =3D max_lane_width;
> > > >
> > > >     for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
> > > > -           smu_pcie_arg =3D (i << 16) |
> > > > -                   ((table_member1[i] <=3D pcie_gen_cap) ?
> > > > -                    (table_member1[i] << 8) :
> > > > -                    (pcie_gen_cap << 8)) |
> > > > -                   ((table_member2[i] <=3D pcie_width_cap) ?
> > > > -                    table_member2[i] :
> > > > -                    pcie_width_cap);
> > > > +           smu_pcie_arg =3D (i << 16 |
> > > > +                           pcie_table->pcie_gen[i] << 8 |
> > > > +                           pcie_table->pcie_lane[i]);
> > > >
> > > >             ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > > >                             SMU_MSG_OverridePcieParameters,
> > > > @@ -2101,11 +2162,6 @@ static int
> > > > sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
> > > >                             NULL);
> > > >             if (ret)
> > > >                     return ret;
> > > > -
> > > > -           if (table_member1[i] > pcie_gen_cap)
> > > > -                   dpm_context->dpm_tables.pcie_table.pcie_gen[i] =
=3D
> > > > pcie_gen_cap;
> > > > -           if (table_member2[i] > pcie_width_cap)
> > > > -                   dpm_context->dpm_tables.pcie_table.pcie_lane[i]=
 =3D
> > > > pcie_width_cap;
> > > >     }
> > > >
> > > >     return 0;
> > > > --
> > > > 2.34.1
