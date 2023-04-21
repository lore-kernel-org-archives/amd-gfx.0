Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC509C7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 13:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A72110E0F3;
	Fri, 21 Apr 2023 13:44:33 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 888BC10E0F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 13:44:31 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-38dee9a7795so730243b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682084670; x=1684676670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5GiThIa5VHUDDQyprtfHsvOOK5m9u3hVuQeB3lTJyQ=;
 b=rj4BcuqU8WFiY50mEpSghERD43aF3PoUD0BI0+VVhLtCs7S84fKatHEU22wH9EjATA
 QvYjiFcD2b+DfsNsjPgLNBwZCnJd0hn12xX0ar2OBXcyq9zAgYhP7qHFgjxXNDc4i130
 USs9b265LSrNqjiaJ95ZE5zJ9nJAfOoFOe+jRz3D4rcJSTvcH8jtQcMsDMHf7H+i0kqu
 V+oN6J12qQoAENSMAM4OWnn56VvZKWG2Ay8eX14yKVO/O99uEYfPWsIuG60CCPZ2pch3
 0256a95y/dWrMZJlGdim6Qhly0JHxpEMFmJsbtAjFdhspZkaST0CkMs408d09JagMZdB
 o1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682084670; x=1684676670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5GiThIa5VHUDDQyprtfHsvOOK5m9u3hVuQeB3lTJyQ=;
 b=QiUm4ro4ba0xjaxQcHmGe9uQz9rKJhalPo/BKmVs+IBNAleHYXfNYaFcycAjdKBkQr
 6L9XUla8TsnyI8903sjYRQ+U01ThHFxfttUrZ8dR5E4R8dfWVui0tVnsjmvnL4RPpoNd
 EspcjKB9+B1r1ze5syd91p+d2g6Yj2P30YX4JjbDmYnTmdvf7vYAyIaLsW7bxD80k95x
 jYBf2eS5WPngN4HPx9lHHdw3twlMXzHkg9iJwmjQdKppnGFYXnIJV/7IzHnKQc7ltmrB
 yGOnhtfbYUWvX7FSuVC4NRwxzvKyiuTFzSt4Sr48r18pJuollni5/Dlkquo8GUqCvMst
 F0Mg==
X-Gm-Message-State: AAQBX9fdoIq/1x/23Pudwb6MAHwYg7kvhS+aA/+jdyJfXTSzQEoC4yxe
 wygQbVnDUgJFiRKTU0m6Mlvph9JPscOSKUvQt2w=
X-Google-Smtp-Source: AKy350b9Hbxp0J7C1NGhwGZOVAPBI7z0lB7ZtfANsRh8OGpjFitLnsJPCQ4h0P9HcNfYh3oul4afH/ttx+YgHqEvUqQ=
X-Received: by 2002:a05:6808:16ab:b0:38c:17a7:5b7b with SMTP id
 bb43-20020a05680816ab00b0038c17a75b7bmr2570110oib.19.1682084670075; Fri, 21
 Apr 2023 06:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230421072835.842112-1-evan.quan@amd.com>
In-Reply-To: <20230421072835.842112-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Apr 2023 09:44:18 -0400
Message-ID: <CADnq5_Os3Hm5p+K8uWJTrDMb=4++Oiq5BQT5QuQR5EPo6u_=6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: conditionally disable pcie lane switching for
 some sienna_cichlid SKUs
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, Mario.Limonciello@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 21, 2023 at 3:30=E2=80=AFAM Evan Quan <evan.quan@amd.com> wrote=
:
>
> Disable the pcie lane switching for some sienna_cichlid SKUs since it
> might not work well on some platforms.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Iea9ceaa146c8706768ee077c10e5d33bce9bc1c2
> ---
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 92 +++++++++++++++----
>  1 file changed, 74 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 4b91cdc3eaa0..e7223513e384 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2067,33 +2067,94 @@ static int sienna_cichlid_display_disable_memory_=
clock_switch(struct smu_context
>         return ret;
>  }
>
> +static void sienna_cichlid_get_override_pcie_settings(struct smu_context=
 *smu,
> +                                                     uint32_t *gen_speed=
_override,
> +                                                     uint32_t *lane_widt=
h_override)
> +{
> +       struct amdgpu_device *adev =3D smu->adev;
> +
> +       *gen_speed_override =3D 0xff;
> +       *lane_width_override =3D 0xff;
> +
> +       switch (adev->pdev->device) {
> +       case 0x73A0:
> +       case 0x73A1:
> +       case 0x73A2:
> +       case 0x73A3:
> +       case 0x73AB:
> +       case 0x73AE:
> +               /* Bit 7:0: PCIE lane width, 1 to 7 corresponds is x1 to =
x32 */
> +               *lane_width_override =3D 6;
> +               break;
> +       case 0x73E0:
> +       case 0x73E1:
> +       case 0x73E3:
> +               *lane_width_override =3D 4;
> +               break;
> +       case 0x7420:
> +       case 0x7421:
> +       case 0x7422:
> +       case 0x7423:
> +       case 0x7424:
> +               *lane_width_override =3D 3;
> +               break;
> +       default:
> +               break;
> +       }
> +}

Why not just apply this to all SKUs?  Or use the pcie info we fetched
at init time?

> +
> +#define MAX(a, b)      ((a) > (b) ? (a) : (b))

There is already a max macro in the kernel you can use.

> +
>  static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu=
,
>                                          uint32_t pcie_gen_cap,
>                                          uint32_t pcie_width_cap)
>  {
>         struct smu_11_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
> -
> -       uint32_t smu_pcie_arg;
> +       struct smu_11_0_pcie_table *pcie_table =3D &dpm_context->dpm_tabl=
es.pcie_table;
> +       uint32_t gen_speed_override, lane_width_override;
>         uint8_t *table_member1, *table_member2;
> +       uint32_t min_gen_speed, max_gen_speed;
> +       uint32_t min_lane_width, max_lane_width;
> +       uint32_t smu_pcie_arg;
>         int ret, i;
>
>         GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
>         GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
>
> -       /* lclk dpm table setup */
> -       for (i =3D 0; i < MAX_PCIE_CONF; i++) {
> -               dpm_context->dpm_tables.pcie_table.pcie_gen[i] =3D table_=
member1[i];
> -               dpm_context->dpm_tables.pcie_table.pcie_lane[i] =3D table=
_member2[i];
> +       sienna_cichlid_get_override_pcie_settings(smu,
> +                                                 &gen_speed_override,
> +                                                 &lane_width_override);
> +
> +       /* PCIE gen speed override */
> +       if (gen_speed_override !=3D 0xff) {
> +               min_gen_speed =3D MIN(pcie_gen_cap, gen_speed_override);
> +               max_gen_speed =3D MIN(pcie_gen_cap, gen_speed_override);
> +       } else {
> +               min_gen_speed =3D MAX(0, table_member1[0]);
> +               max_gen_speed =3D MIN(pcie_gen_cap, table_member1[1]);
> +               min_gen_speed =3D min_gen_speed > max_gen_speed ?
> +                               max_gen_speed : min_gen_speed;
>         }
> +       pcie_table->pcie_gen[0] =3D min_gen_speed;
> +       pcie_table->pcie_gen[1] =3D max_gen_speed;
> +
> +       /* PCIE lane width override */
> +       if (lane_width_override !=3D 0xff) {
> +               min_lane_width =3D MIN(pcie_width_cap, lane_width_overrid=
e);
> +               max_lane_width =3D MIN(pcie_width_cap, lane_width_overrid=
e);
> +       } else {
> +               min_lane_width =3D MAX(1, table_member2[0]);
> +               max_lane_width =3D MIN(pcie_width_cap, table_member2[1]);
> +               min_lane_width =3D min_lane_width > max_lane_width ?
> +                                max_lane_width : min_lane_width;
> +       }
> +       pcie_table->pcie_lane[0] =3D min_lane_width;
> +       pcie_table->pcie_lane[1] =3D max_lane_width;
>
>         for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
> -               smu_pcie_arg =3D (i << 16) |
> -                       ((table_member1[i] <=3D pcie_gen_cap) ?
> -                        (table_member1[i] << 8) :
> -                        (pcie_gen_cap << 8)) |
> -                       ((table_member2[i] <=3D pcie_width_cap) ?
> -                        table_member2[i] :
> -                        pcie_width_cap);
> +               smu_pcie_arg =3D (i << 16 |
> +                               pcie_table->pcie_gen[i] << 8 |
> +                               pcie_table->pcie_lane[i]);
>
>                 ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                 SMU_MSG_OverridePcieParameters,
> @@ -2101,11 +2162,6 @@ static int sienna_cichlid_update_pcie_parameters(s=
truct smu_context *smu,
>                                 NULL);
>                 if (ret)
>                         return ret;
> -
> -               if (table_member1[i] > pcie_gen_cap)
> -                       dpm_context->dpm_tables.pcie_table.pcie_gen[i] =
=3D pcie_gen_cap;
> -               if (table_member2[i] > pcie_width_cap)
> -                       dpm_context->dpm_tables.pcie_table.pcie_lane[i] =
=3D pcie_width_cap;
>         }
>
>         return 0;
> --
> 2.34.1
>
