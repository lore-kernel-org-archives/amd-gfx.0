Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43693C52D7C
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 21:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC03010E2B6;
	Tue, 13 Aug 2024 21:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VA+kCOGG";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51FB610E2B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 21:13:01 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-1fc6ee64512so44368985ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723583581; x=1724188381; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EuaJTyNPOLFQ7GFqTjdu9BlgKg8Vx0sEmHfErqdlVpM=;
 b=VA+kCOGGG2w70KxdhyBJy59ntfvZIS6cNBfr8oGW2Gye7yV4BzOPQaElrupAtVDWXr
 TCb4NuzTseOaRzbWRrXMn1AVBlzAPOMEB+uV1pquNFaI9FRRd9BDZawgiuQWsG1jH9Z/
 ItK1FZqlhYTkfH6YWfrrVQzbYef9/mR8VNyqVPCOvSjFKpMyj0hT2vqr9zu3CONe1F/t
 F3Ph0ZxxTlpjd2lxbgsv1uFzYM+I/qBA7deu6Es5QHIvwgoo5aH7oL4SP7s4Gtr6jiOv
 q0q64HO+2xM4Cj75s2gWx42Hnwdc+S+rKMh7QyQD44TDQqkFbuqneCI0keYcf8HDAYOP
 FSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723583581; x=1724188381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EuaJTyNPOLFQ7GFqTjdu9BlgKg8Vx0sEmHfErqdlVpM=;
 b=er7mrokTPkhbZa+AM0/opj+WNUGe2+AJr5XwZjics9xZfd3ie6dHCcqPcOZNh7RyZ6
 qE0POfXfVDTZsaUb3O1rXthhPi1z9FLPH1f5sQf8qoMF6vdAqTeJPGt55OBZ5gKvfSv9
 998iNYaK+5fr2/00ZNLRG5BC73x9ie8dLnCeBY5qAzIT9H+D7vyL3ysmi4LSysWWx5b7
 w2mDT2l49jJgSPvVedLRG0YCJDfoZK6dx4hh4d3hH2TncKzprpWK3FtdtYsfrSFmPgeV
 9v71z/VMa0FB9JkMGKY6hUb1uzdt9CNMox8Nb0O9d/8YfjgQ7oKP6dhEOa3JMeiP/8ai
 MJww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmaFN6AZOSiQtqtSWu8yCc+wmdr0Rc8Nmk5ujEEPkgvOYgv3NOkMvZZas1qjEqySYpU3ER+fvx2+Kvrsf3k63SdBpIb53HcMZgZVaytw==
X-Gm-Message-State: AOJu0YyTc6oewUgNJQQG/R6z1KTTABlth8Jpn7d50h+x5W7iC7gKsftp
 JPs0vR7Y4cjGhZRDRLDJQOu3gW7AuEDR9Im382FoikrUBvRBTKDR0VTzB7hlYJI9YJpcZruZsp3
 TWTuYOyPAR1pajXHeqyAlhkmWjQY=
X-Google-Smtp-Source: AGHT+IF0V/drPOXDpcOdREeSvY7RgMkEuIp7MLoPnfIv+GQEE2tQqk3xE6J8alWedr0v4YIg3eewMFMRudYw49PI/do=
X-Received: by 2002:a17:903:3583:b0:1fb:6473:e91f with SMTP id
 d9443c01a7336-201d64a5b36mr10181185ad.40.1723583580592; Tue, 13 Aug 2024
 14:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240813170735.905194-1-sunil.khatri@amd.com>
In-Reply-To: <20240813170735.905194-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Aug 2024 17:12:48 -0400
Message-ID: <CADnq5_M4MqrdbSB5Rr2D1s5hm40u1ScFXPsii=5j8quR4egFTA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove ME0 registers from mi300 dump
To: Sunil Khatri <sunil.khatri@amd.com>
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

On Tue, Aug 13, 2024 at 1:07=E2=80=AFPM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Remove ME0 registers from MI300 gfx_9_4_3 ipdump
> MI300 does not have  gfx ME and hence those register
> are just empty one and could be dropped.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 37 -------------------------
>  1 file changed, 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 7b4ae197eb49..edebc4459b75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -75,42 +75,11 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list=
_9_4_3[] =3D {
>         SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
>         SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
>         SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB1_BASE),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB1_RPTR),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB1_WPTR),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB2_BASE),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB2_WPTR),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB2_WPTR),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_CMD_BUFSZ),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_CMD_BUFSZ),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_BASE_LO),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_BASE_HI),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_BUFSZ),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_BASE_LO),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_BASE_HI),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_BUFSZ),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
>         SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
>         SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
>         SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
>         SOC15_REG_ENTRY_STR(GC, 0, regGDS_PROTECTION_FAULT),
>         SOC15_REG_ENTRY_STR(GC, 0, regGDS_VM_PROTECTION_FAULT),
> -       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
> -       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_CNTL),
> -       SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
>         SOC15_REG_ENTRY_STR(GC, 0, regRLC_UTCL1_STATUS),
>         SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
>         SOC15_REG_ENTRY_STR(GC, 0, regSQC_DCACHE_UTCL1_STATUS),
> @@ -122,11 +91,8 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list=
_9_4_3[] =3D {
>         SOC15_REG_ENTRY_STR(GC, 0, regVM_L2_PROTECTION_FAULT_STATUS),
>         SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
>         SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_INSTR_PNTR),
>         SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC1_INSTR_PNTR),
>         SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC2_INSTR_PNTR),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
>         SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
>         SOC15_REG_ENTRY_STR(GC, 0, regRLC_STAT),
>         SOC15_REG_ENTRY_STR(GC, 0, regRLC_SMU_COMMAND),
> @@ -139,11 +105,8 @@ static const struct amdgpu_hwip_reg_entry gc_reg_lis=
t_9_4_3[] =3D {
>         SOC15_REG_ENTRY_STR(GC, 0, regRLC_INT_STAT),
>         SOC15_REG_ENTRY_STR(GC, 0, regRLC_GPM_GENERAL_6),
>         /* cp header registers */
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_HEADER_DUMP),
>         SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>         SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME2_HEADER_DUMP),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
> -       SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
>         /* SE status registers */
>         SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
>         SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
> --
> 2.34.1
>
