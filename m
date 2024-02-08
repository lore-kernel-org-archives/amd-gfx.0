Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F08C4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 14:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3AD10E039;
	Thu,  8 Feb 2024 14:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O8xKsdb1";
	dkim-atps=neutral
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D747C10E039
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 14:35:10 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-2185739b64cso1043373fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Feb 2024 06:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707402909; x=1708007709; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbT4Z00Ek6gPGrYO/WvJ4dhIST5j0FD2AdvIgm6Krsc=;
 b=O8xKsdb1t+QDD1egdCS4Qbh9h2WLRyQhCJT3EYPaG/QIU2xAWeTLXx4FRpbt/AhS6j
 /VrFyRYBAcluFEM4Im1Z1ZstkF3+bhAxqXG10cgWz71HgqFsQM1CRmeuCdrhv4jjoDaO
 00RWl2VQjjTQrV2MUTCcIVSyRzPS1IIcDkjOlEpIEF/RS+wkPHL4tkb1WMIs4cQRM/aM
 sorSUxd27qdgnawyEdZ1qkrj1KOxoj5V2uoR4SZRKn28b9je8blFvgXv0jb3KXwCh3Zh
 VJWUipQiJ/tDCHMxLXdJqm9QUQAyhTyri8RP4DeQGOvrEr6Wqank8J6V/R4JRkomeNbk
 FBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707402909; x=1708007709;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IbT4Z00Ek6gPGrYO/WvJ4dhIST5j0FD2AdvIgm6Krsc=;
 b=hmNMIL2yfGVVRlhryL7Y7Wfx+GGkl75noCbIAIfD6xgxCI4iyX9kh5uW61RCoAysHi
 BCO+qASyfQWUD1WfnuQNZOZfD7M5GFKp6Iyjlb78fZHigv4FHbUX4Ps5X+I2eeFuVgOI
 YdoeopFClWCo8kvcW+pYCl3h6jB4uZNAL+2smmkM5GpopeKqfwrVYV8jIlZ6wPW4c1QU
 1qISwqWfm6+uyjKj1fi0HEjs60f4HMIKAwd73xeLZN8OwdpKFBYvoICTD9SHWowZJiG/
 zJmbsnbfNctWR3F1JsNkF/Hejr1D7Qi2zR2yVQHohBdEO0uSlzS75cIeKueyj+/1llMK
 plmA==
X-Gm-Message-State: AOJu0YzDuwnlStvlTHqRCWnCaDN5Ry9gKlOqJmpT5H7YL6yYkjgcSXW2
 IAnnwBnOSqaBTbBEGXLkN7kQEWdXXGnYtzN7Z8jM7lyzbLvoF2wbyoF3evzLFbpZvhpUfdUemAw
 fgXhOMdYyb9D6GKE9ejme9RgJr78=
X-Google-Smtp-Source: AGHT+IFGbgHg3hlSJmfuH8nIxb2Yiq7DWny9bafavn8pXHMQJVcH+/fRf+nJVzPE9gRA0xDd2PY6bt18L4OpdPXiXnI=
X-Received: by 2002:a05:6870:3a2a:b0:218:afdb:bb67 with SMTP id
 du42-20020a0568703a2a00b00218afdbbb67mr7739562oab.11.1707402909097; Thu, 08
 Feb 2024 06:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20240208053419.3978393-1-kenneth.feng@amd.com>
In-Reply-To: <20240208053419.3978393-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Feb 2024 09:34:56 -0500
Message-ID: <CADnq5_NBkepvAg-bK7k+8Wt-QHEgPO=-XeCTPyJwmexmXTmhWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: denote S to the deep sleep clock
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Feb 8, 2024 at 12:34=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> denote S to the deep sleep clock for the clock output on smu v13.0.0/v13.=
0.7/v13.0.10
>

Would be nice to fix up smu 11 as well at some point.

Alex


> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 27 +++++++++++++------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 27 +++++++++++++------
>  2 files changed, 38 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 2e7518f4ae1a..fd33646970a4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -109,6 +109,7 @@
>  #define PP_OD_FEATURE_FAN_MINIMUM_PWM                  10
>
>  #define LINK_SPEED_MAX                                 3
> +#define SMU_13_0_0_DSCLK_THRESHOLD 100
>
>  static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_C=
OUNT] =3D {
>         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,   =
              1),
> @@ -1269,20 +1270,30 @@ static int smu_v13_0_0_print_clk_levels(struct sm=
u_context *smu,
>                          *   - level 0 -> min clock freq
>                          *   - level 1 -> max clock freq
>                          * And the current clock frequency can be any val=
ue between them.
> -                        * So, if the current clock frequency is not at l=
evel 0 or level 1,
> -                        * we will fake it as three dpm levels:
> +                        * So, if the current clock frequency is lower th=
an level 0,
> +                        * we will denote it to S:
> +                        *   - level S -> current actual clock freq
>                          *   - level 0 -> min clock freq
> -                        *   - level 1 -> current actual clock freq
> -                        *   - level 2 -> max clock freq
> +                        *   - level 1 -> max clock freq
>                          */
>                         if ((single_dpm_table->dpm_levels[0].value !=3D c=
urr_freq) &&
> -                            (single_dpm_table->dpm_levels[1].value !=3D =
curr_freq)) {
> +                            (single_dpm_table->dpm_levels[1].value !=3D =
curr_freq) &&
> +                                (curr_freq < SMU_13_0_0_DSCLK_THRESHOLD)=
) {
> +                               size +=3D sysfs_emit_at(buf, size, "S: %u=
Mhz *\n",
> +                                               curr_freq);
>                                 size +=3D sysfs_emit_at(buf, size, "0: %u=
Mhz\n",
>                                                 single_dpm_table->dpm_lev=
els[0].value);
> -                               size +=3D sysfs_emit_at(buf, size, "1: %u=
Mhz *\n",
> -                                               curr_freq);
> -                               size +=3D sysfs_emit_at(buf, size, "2: %u=
Mhz\n",
> +                               size +=3D sysfs_emit_at(buf, size, "1: %u=
Mhz\n",
>                                                 single_dpm_table->dpm_lev=
els[1].value);
> +                       } else if ((single_dpm_table->dpm_levels[0].value=
 !=3D curr_freq) &&
> +                                               (single_dpm_table->dpm_le=
vels[1].value !=3D curr_freq)) {
> +                               size +=3D sysfs_emit_at(buf, size, "0: %u=
Mhz %s\n",
> +                                               single_dpm_table->dpm_lev=
els[0].value,
> +                                               single_dpm_table->dpm_lev=
els[0].value =3D=3D curr_freq ? "*" : "");
> +                               size +=3D sysfs_emit_at(buf, size, "1: %u=
Mhz *\n", curr_freq);
> +                               size +=3D sysfs_emit_at(buf, size, "2: %u=
Mhz %s\n",
> +                                               single_dpm_table->dpm_lev=
els[1].value,
> +                                               single_dpm_table->dpm_lev=
els[1].value =3D=3D curr_freq ? "*" : "");
>                         } else {
>                                 size +=3D sysfs_emit_at(buf, size, "0: %u=
Mhz %s\n",
>                                                 single_dpm_table->dpm_lev=
els[0].value,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 0ffdb58af74e..2ecebad7a9cb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -85,6 +85,7 @@
>  #define PP_OD_FEATURE_FAN_MINIMUM_PWM                  10
>
>  #define LINK_SPEED_MAX                                 3
> +#define SMU_13_0_7_DSCLK_THRESHOLD 100
>
>  static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_C=
OUNT] =3D {
>         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,   =
              1),
> @@ -1258,20 +1259,30 @@ static int smu_v13_0_7_print_clk_levels(struct sm=
u_context *smu,
>                          *   - level 0 -> min clock freq
>                          *   - level 1 -> max clock freq
>                          * And the current clock frequency can be any val=
ue between them.
> -                        * So, if the current clock frequency is not at l=
evel 0 or level 1,
> -                        * we will fake it as three dpm levels:
> +                        * So, if the current clock frequency is lower th=
an level 0,
> +                        * we will denote it to S:
> +                        *   - level S -> current actual clock freq
>                          *   - level 0 -> min clock freq
> -                        *   - level 1 -> current actual clock freq
> -                        *   - level 2 -> max clock freq
> +                        *   - level 1 -> max clock freq
>                          */
>                         if ((single_dpm_table->dpm_levels[0].value !=3D c=
urr_freq) &&
> -                            (single_dpm_table->dpm_levels[1].value !=3D =
curr_freq)) {
> +                            (single_dpm_table->dpm_levels[1].value !=3D =
curr_freq) &&
> +                                (curr_freq < SMU_13_0_7_DSCLK_THRESHOLD)=
) {
> +                               size +=3D sysfs_emit_at(buf, size, "S: %u=
Mhz *\n",
> +                                               curr_freq);
>                                 size +=3D sysfs_emit_at(buf, size, "0: %u=
Mhz\n",
>                                                 single_dpm_table->dpm_lev=
els[0].value);
> -                               size +=3D sysfs_emit_at(buf, size, "1: %u=
Mhz *\n",
> -                                               curr_freq);
> -                               size +=3D sysfs_emit_at(buf, size, "2: %u=
Mhz\n",
> +                               size +=3D sysfs_emit_at(buf, size, "1: %u=
Mhz\n",
>                                                 single_dpm_table->dpm_lev=
els[1].value);
> +                       } else if ((single_dpm_table->dpm_levels[0].value=
 !=3D curr_freq) &&
> +                                               (single_dpm_table->dpm_le=
vels[1].value !=3D curr_freq)) {
> +                               size +=3D sysfs_emit_at(buf, size, "0: %u=
Mhz %s\n",
> +                                               single_dpm_table->dpm_lev=
els[0].value,
> +                                               single_dpm_table->dpm_lev=
els[0].value =3D=3D curr_freq ? "*" : "");
> +                               size +=3D sysfs_emit_at(buf, size, "1: %u=
Mhz *\n", curr_freq);
> +                               size +=3D sysfs_emit_at(buf, size, "2: %u=
Mhz %s\n",
> +                                               single_dpm_table->dpm_lev=
els[1].value,
> +                                               single_dpm_table->dpm_lev=
els[1].value =3D=3D curr_freq ? "*" : "");
>                         } else {
>                                 size +=3D sysfs_emit_at(buf, size, "0: %u=
Mhz %s\n",
>                                                 single_dpm_table->dpm_lev=
els[0].value,
> --
> 2.34.1
>
