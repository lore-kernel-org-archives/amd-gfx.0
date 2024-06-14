Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8363C27C6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 17:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 157C110EE00;
	Fri, 14 Jun 2024 17:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ql14oL8B";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53B010EE00
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 17:46:42 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7042cb2abc8so1859465b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718387202; x=1718992002; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmH5Cvwmby9+Mvat7NnqtFzQcJXwwBRRfru0RupO8ng=;
 b=Ql14oL8B5EH2J62a5LJz0G2c7IKwT3YsL3C0fbSYyHoawhdrEfOhQxCCOSHUK69yrm
 +k7L7deUHL39QoZsaBDXyzsNTNm2VTb6OTiy6ixl9meWbPmeKUfqGQnyVQPkrEgeiCaR
 wCUStWm9THKVnykUeyYNJY9oKLam7RIaN6jkzu3+2BkYylG/LlCB7rpeyk3kVdmGfqzr
 Js268xH1iLVMNQhTR1fL3qOq45tDDnmW2+yTwsbTZG/RvFqqVoCcsTcaboQlBwDnZjq1
 GdRFZNSUZjlT0VO5dKXEi6FhLOnGhgIVqum4xGEzKbjk+q6FKMdgXM8S0dN9PGtUGCA6
 gRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718387202; x=1718992002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmH5Cvwmby9+Mvat7NnqtFzQcJXwwBRRfru0RupO8ng=;
 b=vPB4l5qJ77pOOsT4AYKB+YXN1XTanJoUl74GSBzgS/UU8lRBsQlRX5oYMdRA3GAGFB
 piR7HRKrL+Nw2Hi08qpmVUaRO0X0k248R7rIr7smsORaIk5D0cMevp7+ECEH0EkFLFvA
 2NjzmLw8AAeOc2RgXdYosmi4hCGLtXjTwYx7sIKVXgqQ2Y0t7gat7D0ucOh7QLrtEBDK
 CehJmq14xa+8QBTywWOCbeNVyGMmVG+cemFwX31A+3V+gOOqCoFheG6Z6xd65DZVevAf
 z3CJBJ9LlTbA1ud/I4umvb5LEyCdyEiBvldz6PMeLAYvzd0sb89jxEHkripRTsFNQ4WS
 q3mQ==
X-Gm-Message-State: AOJu0YzNKtRKakAzNAqdPF9hfWJZLn3wfw3PZbrXCZxrnhLtRIsrVm+B
 DDdKWtzsv6dt4YE9xTE74Tb/fp+rap4hCl5B+Jw82q80RrgY3j/FSy0Q1g+FRDZnHOveB53gBUw
 N09rxgOuvC1KxFf4C6Bwn95w3jAVVmw==
X-Google-Smtp-Source: AGHT+IEdd3E+V/ouKodTYbUiMKTaZPVJxeaEJPEULuKqy+8ZpWKLGHtMg3VuHDLjL0GfYNezzm+r+/TKGoHMOPD5cEQ=
X-Received: by 2002:a05:6a20:3c87:b0:1b8:8ddd:fe32 with SMTP id
 adf61e73a8af0-1bae7f008f4mr4037419637.25.1718387201820; Fri, 14 Jun 2024
 10:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240614170551.6195-1-mario.limonciello@amd.com>
 <20240614170551.6195-2-mario.limonciello@amd.com>
In-Reply-To: <20240614170551.6195-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Jun 2024 13:46:30 -0400
Message-ID: <CADnq5_MFTnW-=i-TBiT3N2+k_cTVofaZRuhLNV8Cg=cOKh-T7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: powerplay: Add `__counted_by` attribute
 for flexible arrays
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Fri, Jun 14, 2024 at 1:42=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> This attribute is used to hint the length of flexible arrays to
> compiler and sanitizers.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h | 36 +++++++++---------
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  | 38 +++++++++----------
>  2 files changed, 37 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> index 2cf2a7b12623..7711e892c31f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> @@ -163,8 +163,8 @@ typedef struct _ATOM_Tonga_State {
>
>  typedef struct _ATOM_Tonga_State_Array {
>         UCHAR ucRevId;
> -       UCHAR ucNumEntries;             /* Number of entries. */
> -       ATOM_Tonga_State entries[];     /* Dynamically allocate entries. =
*/
> +       UCHAR ucNumEntries;
> +       ATOM_Tonga_State entries[] __counted_by(ucNumEntries);
>  } ATOM_Tonga_State_Array;
>
>  typedef struct _ATOM_Tonga_MCLK_Dependency_Record {
> @@ -178,8 +178,8 @@ typedef struct _ATOM_Tonga_MCLK_Dependency_Record {
>
>  typedef struct _ATOM_Tonga_MCLK_Dependency_Table {
>         UCHAR ucRevId;
> -       UCHAR ucNumEntries;                                              =
                               /* Number of entries. */
> -       ATOM_Tonga_MCLK_Dependency_Record entries[];                     =
       /* Dynamically allocate entries. */
> +       UCHAR ucNumEntries;
> +       ATOM_Tonga_MCLK_Dependency_Record entries[] __counted_by(ucNumEnt=
ries);
>  } ATOM_Tonga_MCLK_Dependency_Table;
>
>  typedef struct _ATOM_Tonga_SCLK_Dependency_Record {
> @@ -193,8 +193,8 @@ typedef struct _ATOM_Tonga_SCLK_Dependency_Record {
>
>  typedef struct _ATOM_Tonga_SCLK_Dependency_Table {
>         UCHAR ucRevId;
> -       UCHAR ucNumEntries;                                              =
                               /* Number of entries. */
> -       ATOM_Tonga_SCLK_Dependency_Record entries[];                     =
        /* Dynamically allocate entries. */
> +       UCHAR ucNumEntries;
> +       ATOM_Tonga_SCLK_Dependency_Record entries[] __counted_by(ucNumEnt=
ries);
>  } ATOM_Tonga_SCLK_Dependency_Table;
>
>  typedef struct _ATOM_Polaris_SCLK_Dependency_Record {
> @@ -209,8 +209,8 @@ typedef struct _ATOM_Polaris_SCLK_Dependency_Record {
>
>  typedef struct _ATOM_Polaris_SCLK_Dependency_Table {
>         UCHAR ucRevId;
> -       UCHAR ucNumEntries;                                              =
       /* Number of entries. */
> -       ATOM_Polaris_SCLK_Dependency_Record entries[];                   =
        /* Dynamically allocate entries. */
> +       UCHAR ucNumEntries;
> +       ATOM_Polaris_SCLK_Dependency_Record entries[] __counted_by(ucNumE=
ntries);
>  } ATOM_Polaris_SCLK_Dependency_Table;
>
>  typedef struct _ATOM_Tonga_PCIE_Record {
> @@ -221,8 +221,8 @@ typedef struct _ATOM_Tonga_PCIE_Record {
>
>  typedef struct _ATOM_Tonga_PCIE_Table {
>         UCHAR ucRevId;
> -       UCHAR ucNumEntries;                                              =
                               /* Number of entries. */
> -       ATOM_Tonga_PCIE_Record entries[];                                =
                       /* Dynamically allocate entries. */
> +       UCHAR ucNumEntries;
> +       ATOM_Tonga_PCIE_Record entries[] __counted_by(ucNumEntries);
>  } ATOM_Tonga_PCIE_Table;
>
>  typedef struct _ATOM_Polaris10_PCIE_Record {
> @@ -234,8 +234,8 @@ typedef struct _ATOM_Polaris10_PCIE_Record {
>
>  typedef struct _ATOM_Polaris10_PCIE_Table {
>         UCHAR ucRevId;
> -       UCHAR ucNumEntries;                                         /* Nu=
mber of entries. */
> -       ATOM_Polaris10_PCIE_Record entries[];                      /* Dyn=
amically allocate entries. */
> +       UCHAR ucNumEntries;
> +       ATOM_Polaris10_PCIE_Record entries[] __counted_by(ucNumEntries);
>  } ATOM_Polaris10_PCIE_Table;
>
>
> @@ -251,8 +251,8 @@ typedef struct _ATOM_Tonga_MM_Dependency_Record {
>
>  typedef struct _ATOM_Tonga_MM_Dependency_Table {
>         UCHAR ucRevId;
> -       UCHAR ucNumEntries;                                              =
                               /* Number of entries. */
> -       ATOM_Tonga_MM_Dependency_Record entries[];                       =
  /* Dynamically allocate entries. */
> +       UCHAR ucNumEntries;
> +       ATOM_Tonga_MM_Dependency_Record entries[] __counted_by(ucNumEntri=
es);
>  } ATOM_Tonga_MM_Dependency_Table;
>
>  typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
> @@ -264,8 +264,8 @@ typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
>
>  typedef struct _ATOM_Tonga_Voltage_Lookup_Table {
>         UCHAR ucRevId;
> -       UCHAR ucNumEntries;                                              =
                               /* Number of entries. */
> -       ATOM_Tonga_Voltage_Lookup_Record entries[];                      =
       /* Dynamically allocate entries. */
> +       UCHAR ucNumEntries;
> +       ATOM_Tonga_Voltage_Lookup_Record entries[] __counted_by(ucNumEntr=
ies);
>  } ATOM_Tonga_Voltage_Lookup_Table;
>
>  typedef struct _ATOM_Tonga_Fan_Table {
> @@ -367,7 +367,7 @@ typedef struct _ATOM_Tonga_VCE_State_Record {
>  typedef struct _ATOM_Tonga_VCE_State_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;
> -       ATOM_Tonga_VCE_State_Record entries[];
> +       ATOM_Tonga_VCE_State_Record entries[] __counted_by(ucNumEntries);
>  } ATOM_Tonga_VCE_State_Table;
>
>  typedef struct _ATOM_Tonga_PowerTune_Table {
> @@ -481,7 +481,7 @@ typedef struct _ATOM_Tonga_Hard_Limit_Record {
>  typedef struct _ATOM_Tonga_Hard_Limit_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;
> -       ATOM_Tonga_Hard_Limit_Record entries[];
> +       ATOM_Tonga_Hard_Limit_Record entries[] __counted_by(ucNumEntries)=
;
>  } ATOM_Tonga_Hard_Limit_Table;
>
>  typedef struct _ATOM_Tonga_GPIO_Table {
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/d=
rm/amd/pm/powerplay/inc/hwmgr.h
> index 69928a4a074b..9118fcddbf11 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> @@ -60,7 +60,7 @@ struct vi_dpm_level {
>
>  struct vi_dpm_table {
>         uint32_t count;
> -       struct vi_dpm_level dpm_level[];
> +       struct vi_dpm_level dpm_level[] __counted_by(count);
>  };
>
>  #define PCIE_PERF_REQ_REMOVE_REGISTRY   0
> @@ -91,7 +91,7 @@ struct phm_set_power_state_input {
>
>  struct phm_clock_array {
>         uint32_t count;
> -       uint32_t values[];
> +       uint32_t values[] __counted_by(count);
>  };
>
>  struct phm_clock_voltage_dependency_record {
> @@ -122,8 +122,8 @@ struct phm_acpclock_voltage_dependency_record {
>  };
>
>  struct phm_clock_voltage_dependency_table {
> -       uint32_t count;                                                 /=
* Number of entries. */
> -       struct phm_clock_voltage_dependency_record entries[];           /=
* Dynamically allocate count entries. */
> +       uint32_t count;
> +       struct phm_clock_voltage_dependency_record entries[] __counted_by=
(count);
>  };
>
>  struct phm_phase_shedding_limits_record {
> @@ -140,7 +140,7 @@ struct phm_uvd_clock_voltage_dependency_record {
>
>  struct phm_uvd_clock_voltage_dependency_table {
>         uint8_t count;
> -       struct phm_uvd_clock_voltage_dependency_record entries[];
> +       struct phm_uvd_clock_voltage_dependency_record entries[] __counte=
d_by(count);
>  };
>
>  struct phm_acp_clock_voltage_dependency_record {
> @@ -150,7 +150,7 @@ struct phm_acp_clock_voltage_dependency_record {
>
>  struct phm_acp_clock_voltage_dependency_table {
>         uint32_t count;
> -       struct phm_acp_clock_voltage_dependency_record entries[];
> +       struct phm_acp_clock_voltage_dependency_record entries[] __counte=
d_by(count);
>  };
>
>  struct phm_vce_clock_voltage_dependency_record {
> @@ -160,33 +160,33 @@ struct phm_vce_clock_voltage_dependency_record {
>  };
>
>  struct phm_phase_shedding_limits_table {
> -       uint32_t                           count;
> -       struct phm_phase_shedding_limits_record  entries[];
> +       uint32_t count;
> +       struct phm_phase_shedding_limits_record  entries[] __counted_by(c=
ount);
>  };
>
>  struct phm_vceclock_voltage_dependency_table {
> -       uint8_t count;                                    /* Number of en=
tries. */
> -       struct phm_vceclock_voltage_dependency_record entries[1]; /* Dyna=
mically allocate count entries. */
> +       uint8_t count;
> +       struct phm_vceclock_voltage_dependency_record entries[] __counted=
_by(count);
>  };
>
>  struct phm_uvdclock_voltage_dependency_table {
> -       uint8_t count;                                    /* Number of en=
tries. */
> -       struct phm_uvdclock_voltage_dependency_record entries[1]; /* Dyna=
mically allocate count entries. */
> +       uint8_t count;
> +       struct phm_uvdclock_voltage_dependency_record entries[] __counted=
_by(count);
>  };
>
>  struct phm_samuclock_voltage_dependency_table {
> -       uint8_t count;                                    /* Number of en=
tries. */
> -       struct phm_samuclock_voltage_dependency_record entries[1]; /* Dyn=
amically allocate count entries. */
> +       uint8_t count;
> +       struct phm_samuclock_voltage_dependency_record entries[] __counte=
d_by(count);
>  };
>
>  struct phm_acpclock_voltage_dependency_table {
> -       uint32_t count;                                    /* Number of e=
ntries. */
> -       struct phm_acpclock_voltage_dependency_record entries[1]; /* Dyna=
mically allocate count entries. */
> +       uint32_t count;
> +       struct phm_acpclock_voltage_dependency_record entries[] __counted=
_by(count);
>  };
>
>  struct phm_vce_clock_voltage_dependency_table {
>         uint8_t count;
> -       struct phm_vce_clock_voltage_dependency_record entries[];
> +       struct phm_vce_clock_voltage_dependency_record entries[] __counte=
d_by(count);
>  };
>
>
> @@ -393,7 +393,7 @@ union phm_cac_leakage_record {
>
>  struct phm_cac_leakage_table {
>         uint32_t count;
> -       union phm_cac_leakage_record entries[];
> +       union phm_cac_leakage_record entries[] __counted_by(count);
>  };
>
>  struct phm_samu_clock_voltage_dependency_record {
> @@ -404,7 +404,7 @@ struct phm_samu_clock_voltage_dependency_record {
>
>  struct phm_samu_clock_voltage_dependency_table {
>         uint8_t count;
> -       struct phm_samu_clock_voltage_dependency_record entries[];
> +       struct phm_samu_clock_voltage_dependency_record entries[] __count=
ed_by(count);
>  };
>
>  struct phm_cac_tdp_table {
> --
> 2.43.0
>
