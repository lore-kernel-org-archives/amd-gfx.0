Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA22CFA775
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 14:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E202410EA19;
	Fri,  4 Oct 2024 14:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MOH9dB/h";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 327BF10EA19
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 14:17:13 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-7e9b2d75d92so344897a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Oct 2024 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728051432; x=1728656232; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Uf60QwOetKSD0ge2s/Y1RvA/FXgNjrNtt2pbjJQmWo=;
 b=MOH9dB/hdzKowMAqoTVGUswq3PEQhNobha2bmqZEfMJUGOTxjzp+ud6DCUqrGMKRHG
 tqGT7Pyp+s58wFzmi5yrD4k16VZqUCf+8f6zpkrMdM+W1obxnpvgwUSQfJ35kWLsDKWy
 sDUhOVufznpat1Lnnx6TgoWbZAbe0k0V0hsuiuoYEENkWRd42j2rJdnEAacMG0VwB6Uf
 03KK5oVzMuoafkmj87911ZrqeudgAf6QdgtzSK1DapWCcqUukJRwOp4qwBS99L+cduAN
 9ktrJIrTcLHBr28fqKRSGCO3AUHu/3Zsj0O68uxoExragQLophEvGOk9i8IE6BO4CnNL
 oJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728051432; x=1728656232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Uf60QwOetKSD0ge2s/Y1RvA/FXgNjrNtt2pbjJQmWo=;
 b=Kn/v9TSwbfMesPuXkuBOYUNkwfnkpWIMBK4O5w49BaYEjH9dXS8AEeXTXcl16DFjo4
 dslCclV1mxJXzOKPKU1iHEdW7jHcPktpcbh4/z6CDZTT8iVpJ5FmVNAtGiE/lYxQLoio
 TaeiQSlS4pLa7MQRfSLiFpK4Kr8oVULwh/e16lMTCXFvGUmJBSpZPIrT4C3SH+wDic32
 A6t1PWnKqFjlFItfT2w1pl+J50cfG8Xte0lhuhkx9RAOfYJrIqZucdBocPExCK5YSD1h
 U2969UFotzUe1JcWokK/eYgcshFmR9Ro/m3R3jFuZSvgTIr3E4wxD4u3gNLm/nW4l1s7
 zg2g==
X-Gm-Message-State: AOJu0Ywgz4Gjx7fJTQhAwu5NLYKZqeOZLtpmbUgM7Y+WkkqL+lBCtxKW
 oYwQUKJ/gPFIBUdC9Kyq2/XVldLV6Ze5HmE8XZQDtIigFdlF4fGaM2kahtZer6+J2vbCBwyIoLk
 BPis9fEl9vQFT5ilZFiO9B7sPkTM/5g==
X-Google-Smtp-Source: AGHT+IEmHCXSPB2IY2MWVsSpdbpe2Me0S1D9aCjhbMmjXbFvJHnQJnKzSLOP5S/US5HezJfAQ3cwoD3wekw1GrEAzAE=
X-Received: by 2002:a17:90a:fa91:b0:2db:60b:697e with SMTP id
 98e67ed59e1d1-2e1e63c5747mr1357973a91.8.1728051432456; Fri, 04 Oct 2024
 07:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241003140614.3976582-1-alexander.deucher@amd.com>
In-Reply-To: <20241003140614.3976582-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Oct 2024 10:17:00 -0400
Message-ID: <CADnq5_OKdHEXLzn4aTTBVWX0SZRHQq3E2yB_VZysA-ZYPPs_Rw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: partially revert powerplay `__counted_by`
 changes
To: Alex Deucher <alexander.deucher@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
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

Ping?

On Thu, Oct 3, 2024 at 10:06=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Partially revert
> commit 0ca9f757a0e2 ("drm/amd/pm: powerplay: Add `__counted_by` attribute=
 for flexible arrays")
>
> The count attribute for these arrays does not get set until
> after the arrays are allocated and populated leading to false
> UBSAN warnings.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3662
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 26 ++++++++++----------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/d=
rm/amd/pm/powerplay/inc/hwmgr.h
> index 9118fcddbf11..227bf0e84a13 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> @@ -60,7 +60,7 @@ struct vi_dpm_level {
>
>  struct vi_dpm_table {
>         uint32_t count;
> -       struct vi_dpm_level dpm_level[] __counted_by(count);
> +       struct vi_dpm_level dpm_level[];
>  };
>
>  #define PCIE_PERF_REQ_REMOVE_REGISTRY   0
> @@ -91,7 +91,7 @@ struct phm_set_power_state_input {
>
>  struct phm_clock_array {
>         uint32_t count;
> -       uint32_t values[] __counted_by(count);
> +       uint32_t values[];
>  };
>
>  struct phm_clock_voltage_dependency_record {
> @@ -123,7 +123,7 @@ struct phm_acpclock_voltage_dependency_record {
>
>  struct phm_clock_voltage_dependency_table {
>         uint32_t count;
> -       struct phm_clock_voltage_dependency_record entries[] __counted_by=
(count);
> +       struct phm_clock_voltage_dependency_record entries[];
>  };
>
>  struct phm_phase_shedding_limits_record {
> @@ -140,7 +140,7 @@ struct phm_uvd_clock_voltage_dependency_record {
>
>  struct phm_uvd_clock_voltage_dependency_table {
>         uint8_t count;
> -       struct phm_uvd_clock_voltage_dependency_record entries[] __counte=
d_by(count);
> +       struct phm_uvd_clock_voltage_dependency_record entries[];
>  };
>
>  struct phm_acp_clock_voltage_dependency_record {
> @@ -150,7 +150,7 @@ struct phm_acp_clock_voltage_dependency_record {
>
>  struct phm_acp_clock_voltage_dependency_table {
>         uint32_t count;
> -       struct phm_acp_clock_voltage_dependency_record entries[] __counte=
d_by(count);
> +       struct phm_acp_clock_voltage_dependency_record entries[];
>  };
>
>  struct phm_vce_clock_voltage_dependency_record {
> @@ -161,32 +161,32 @@ struct phm_vce_clock_voltage_dependency_record {
>
>  struct phm_phase_shedding_limits_table {
>         uint32_t count;
> -       struct phm_phase_shedding_limits_record  entries[] __counted_by(c=
ount);
> +       struct phm_phase_shedding_limits_record  entries[];
>  };
>
>  struct phm_vceclock_voltage_dependency_table {
>         uint8_t count;
> -       struct phm_vceclock_voltage_dependency_record entries[] __counted=
_by(count);
> +       struct phm_vceclock_voltage_dependency_record entries[];
>  };
>
>  struct phm_uvdclock_voltage_dependency_table {
>         uint8_t count;
> -       struct phm_uvdclock_voltage_dependency_record entries[] __counted=
_by(count);
> +       struct phm_uvdclock_voltage_dependency_record entries[];
>  };
>
>  struct phm_samuclock_voltage_dependency_table {
>         uint8_t count;
> -       struct phm_samuclock_voltage_dependency_record entries[] __counte=
d_by(count);
> +       struct phm_samuclock_voltage_dependency_record entries[];
>  };
>
>  struct phm_acpclock_voltage_dependency_table {
>         uint32_t count;
> -       struct phm_acpclock_voltage_dependency_record entries[] __counted=
_by(count);
> +       struct phm_acpclock_voltage_dependency_record entries[];
>  };
>
>  struct phm_vce_clock_voltage_dependency_table {
>         uint8_t count;
> -       struct phm_vce_clock_voltage_dependency_record entries[] __counte=
d_by(count);
> +       struct phm_vce_clock_voltage_dependency_record entries[];
>  };
>
>
> @@ -393,7 +393,7 @@ union phm_cac_leakage_record {
>
>  struct phm_cac_leakage_table {
>         uint32_t count;
> -       union phm_cac_leakage_record entries[] __counted_by(count);
> +       union phm_cac_leakage_record entries[];
>  };
>
>  struct phm_samu_clock_voltage_dependency_record {
> @@ -404,7 +404,7 @@ struct phm_samu_clock_voltage_dependency_record {
>
>  struct phm_samu_clock_voltage_dependency_table {
>         uint8_t count;
> -       struct phm_samu_clock_voltage_dependency_record entries[] __count=
ed_by(count);
> +       struct phm_samu_clock_voltage_dependency_record entries[];
>  };
>
>  struct phm_cac_tdp_table {
> --
> 2.46.2
>
