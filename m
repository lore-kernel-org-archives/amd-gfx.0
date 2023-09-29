Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E108E71D32
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 13:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FBB010E10F;
	Fri, 29 Sep 2023 13:38:35 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55DE610E10F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 13:38:33 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6c4bad60a1aso6255843a34.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695994712; x=1696599512; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5ZrVU0MFq1z3NslFY+/FYfdwozDgGZVy40gP43y3jk=;
 b=Rf/ro36fSBfmzD0Uf8/OwF86cLcBCkONAFA9Yu/sSYHxo+KK7NG4OymWGorRKNI7fG
 QATBc7jERc1t/q9U1hMJHOofQ0+MtoOOjLQ7PfCcta3/LPHLWm9JBCXRmDjcWhRBn57w
 v1qky0clNPeCOY+XxaIL1BSuDMmqmzZJ5Ybtyi/lsh7i4fprn06y1b0RcATPi+aq2Vd9
 +hOwndj0buP+OnjyT8vV1zo9MOq8trmebf1aBH5eKNMdxk3Iv979o6qykTxry+3qSdy4
 qdtd5lQU3mV2SoH9pwW2m2jqNBMJbD6PtiKTsDRpYsP/h69AsRuDKUEIe/+/g5B041Xb
 GQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695994712; x=1696599512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5ZrVU0MFq1z3NslFY+/FYfdwozDgGZVy40gP43y3jk=;
 b=wOkNWNcaQHij++KRnBSwlL0Q07d533xVRPosWM6E5h/CUTDTIGacRod4O5M56JJq+8
 VkF1N+H3kJa1dBmGWglHh8fEedNkH1CX1yebT5X7xjvx/C9/Ac+WK6oKB/eSEf8BlITF
 YGYF40HcZlc/7rghUCW2YTOMFbqg3KMr9XETn8QdasA1uczBUdyLP/Lj8GEQo48eyDVu
 S6YTJZJQucV0cra4e23PN7158awVOdt4Q1LVvZU6f36vWfYTYwpoxEQ5jpY/XltWIi+V
 /+lxYnYyNKNWP1dxTyoQD+QOMfQMm44zcSJVFk01RyNv9MLR2wJX+UkBYZlSLHcW3lfB
 xZOA==
X-Gm-Message-State: AOJu0YzuhmhFyM60MMkSvVdK6xPfdpLlGwaQzd4770K6PJzUCuP+mhoa
 y66JN4EKKXXp2I8Dm7yturE/wABhHFgfSvViUVY=
X-Google-Smtp-Source: AGHT+IGrkm/DW08xtavZYHktzxMR+shdB0Fsfq2qbRFvB7OMbchU4+uyQwkBaN6zjC0n//2y+PMfwWof7RMarAKywLE=
X-Received: by 2002:a05:6870:a706:b0:196:45b7:9385 with SMTP id
 g6-20020a056870a70600b0019645b79385mr4820057oam.27.1695994712340; Fri, 29 Sep
 2023 06:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230927020743.387802-1-mario.limonciello@amd.com>
In-Reply-To: <20230927020743.387802-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 Sep 2023 09:38:20 -0400
Message-ID: <CADnq5_MB=qExJfqgdy+pA0_ndfPz2zp-57nVwrYvdjPvjJyMdA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix logic error in
 sienna_cichlid_update_pcie_parameters()
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: coelacanth_dream@protonmail.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 28, 2023 at 6:16=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> While aligning SMU11 with SMU13 implementation an assumption was made tha=
t
> `dpm_context->dpm_tables.pcie_table` was populated in dpm table initializ=
ation
> like in SMU13 but it isn't.
>
> So restore some of the original logic and instead just check for
> amdgpu_device_pcie_dynamic_switching_supported() to decide whether to har=
dcode
> values; erring on the side of performance.
>
> Cc: stable@vger.kernel.org # 6.1+
> Reported-and-tested-by: Umio Yasuno <coelacanth_dream@protonmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1447#note_2101382
> Fixes: e701156ccc6c ("drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters=
 implementation with SMU13")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 41 +++++++++++--------
>  1 file changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index f0800c0c5168..9119b0df2419 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2081,36 +2081,41 @@ static int sienna_cichlid_display_disable_memory_=
clock_switch(struct smu_context
>         return ret;
>  }
>
> +#define MAX(a, b)      ((a) > (b) ? (a) : (b))
> +
>  static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu=
,
>                                          uint32_t pcie_gen_cap,
>                                          uint32_t pcie_width_cap)
>  {
>         struct smu_11_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_con=
text;
>         struct smu_11_0_pcie_table *pcie_table =3D &dpm_context->dpm_tabl=
es.pcie_table;
> -       u32 smu_pcie_arg;
> +       uint8_t *table_member1, *table_member2;
> +       uint32_t min_gen_speed, max_gen_speed;
> +       uint32_t min_lane_width, max_lane_width;
> +       uint32_t smu_pcie_arg;
>         int ret, i;
>
> -       /* PCIE gen speed and lane width override */
> -       if (!amdgpu_device_pcie_dynamic_switching_supported()) {
> -               if (pcie_table->pcie_gen[NUM_LINK_LEVELS - 1] < pcie_gen_=
cap)
> -                       pcie_gen_cap =3D pcie_table->pcie_gen[NUM_LINK_LE=
VELS - 1];
> +       GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
> +       GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
>
> -               if (pcie_table->pcie_lane[NUM_LINK_LEVELS - 1] < pcie_wid=
th_cap)
> -                       pcie_width_cap =3D pcie_table->pcie_lane[NUM_LINK=
_LEVELS - 1];
> +       min_gen_speed =3D MAX(0, table_member1[0]);
> +       max_gen_speed =3D MIN(pcie_gen_cap, table_member1[1]);
> +       min_gen_speed =3D min_gen_speed > max_gen_speed ?
> +                       max_gen_speed : min_gen_speed;
> +       min_lane_width =3D MAX(1, table_member2[0]);
> +       max_lane_width =3D MIN(pcie_width_cap, table_member2[1]);
> +       min_lane_width =3D min_lane_width > max_lane_width ?
> +                        max_lane_width : min_lane_width;
>
> -               /* Force all levels to use the same settings */
> -               for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
> -                       pcie_table->pcie_gen[i] =3D pcie_gen_cap;
> -                       pcie_table->pcie_lane[i] =3D pcie_width_cap;
> -               }
> +       if (!amdgpu_device_pcie_dynamic_switching_supported()) {
> +               pcie_table->pcie_gen[0] =3D max_gen_speed;
> +               pcie_table->pcie_lane[0] =3D max_lane_width;
>         } else {
> -               for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
> -                       if (pcie_table->pcie_gen[i] > pcie_gen_cap)
> -                               pcie_table->pcie_gen[i] =3D pcie_gen_cap;
> -                       if (pcie_table->pcie_lane[i] > pcie_width_cap)
> -                               pcie_table->pcie_lane[i] =3D pcie_width_c=
ap;
> -               }
> +               pcie_table->pcie_gen[0] =3D min_gen_speed;
> +               pcie_table->pcie_lane[0] =3D min_lane_width;
>         }
> +       pcie_table->pcie_gen[1] =3D max_gen_speed;
> +       pcie_table->pcie_lane[1] =3D max_lane_width;
>
>         for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
>                 smu_pcie_arg =3D (i << 16 |
> --
> 2.34.1
>
