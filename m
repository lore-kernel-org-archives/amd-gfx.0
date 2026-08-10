Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE4DC5B56A
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 14:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F10310E1FD;
	Mon, 10 Aug 2026 14:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JAUJyVyD";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3960310E1FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 14:13:01 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-384c94c9423so270762a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 07:13:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786371181; cv=none;
 d=google.com; s=arc-20260327;
 b=NIR4XTKJ3cEtN9mqvd+8JxZhZB8fK3MGs62zKDxEPmIKFJp1znf12aKQdpHrw5UwqO
 08wrduVKptmc01ou1TokGylr+bDFg1ahGpxTuhuwcNz/qzowbCLQiUJSgWFqSArRD66R
 8URIBTLsXyTKn/1t0RYqeO5Y6J8Xd6fgQgypliVixvDg6sQ9sQI3pVcRPNCdRYx4PXba
 gykc+xq8mRiHvj34XlpK5xGkHTws+Bs/Fkx95hZeBIZi3vFhznmd1ED62AhgUmf6v0dL
 e+be9CnngPZudM/IwRgR9Bhba9HgnhVfteJz95Z7N4fwiKzzKAHpmklmWOnU0RKOsaXc
 ur/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g7juHvXKTBG97i+VkcAFjDGnxuCfP7bhg2vLhX+DfZ8=;
 fh=Nv+9+Z57DCYe0ycwk5iVaUfNB4X7lSK9xIC8J6iBWmM=;
 b=fVCzLAYc0FfbTq7Y/X0Wrg9bWWNeo94GrumwlBDpvfwBeBJczRjl7Ns5dha94vmNA2
 thSiiQaw3p4EqKADpPLwrNt/X4NEl/h1/A2cgnP4UmBsu3zYL6tvkcovWNlWXVuox7qR
 mNgVY8zTasDz43ktVK8/AvrxtsnJsL80LvitY4pCwJ6mBL7M3jHyE/W9agpXisivOJ0a
 KrOCgVm+9K6kNAtjEAr4DTA1LRnWZikVoDlO5OZbgadGzU1bXXjz7p+bkb4GTjPJlRWI
 svqp5oN/p+XR6pBIhxVkqP2wNgGWt6d3kyQNJ/INKThA6y0r8wxLsnEv4V14wwuN2uja
 y+NQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786371181; x=1786975981; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g7juHvXKTBG97i+VkcAFjDGnxuCfP7bhg2vLhX+DfZ8=;
 b=JAUJyVyDCzJIFNT3xPy2+0UYJIUyS290BCyv0tA7uVYxWSwdIpxYFMkZX+39QPwEeb
 8TN0VLdOdCHtfBaHkHyJcthKtXKIsWIAQcGk+5kX0/5KdpmUWhh3O34orIgpDaLLYFZV
 Zm9CHx/IIP0H1B6/0z1IPZgXF0P2YBD9FOnjuXIXBqDPQNakG4bKL5uRvIlNzxvn/bzX
 gk+qscYl2/J9SI5QRO5m36VLTLvDMzaUo/TRwfH8c1BgECyj/aBjK5Bfh2MGqn484hNT
 QdtJp/9ltG1UUPlO/hbA4O+W90lLYXwFrpUwNqtj4+mOcF/lYgD+oXjQEjY0vONEhPSd
 4trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786371181; x=1786975981;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g7juHvXKTBG97i+VkcAFjDGnxuCfP7bhg2vLhX+DfZ8=;
 b=qvp/4pOU5t6ohXMpZfCVnzfVvI5xqafhfiYaj3G8LB2FU2oJcJ982ZgGWt/EpK8oW9
 ZHEse4Ghz1xx0kvEdxX2K3KT67jkOIWEbBPcezt5PvaoUJiQbtL6gpi2SedP9oMNOeJx
 VL4arh2jEjxC14W50JtsX4LJ5dZzRZU7Isc4XNSNasTS+jDb8klcKrcoQN2zQQnK24Wi
 TIEc4/pLh3nZvkGFN0z3uDFcxiXiEARlII+UnAti/JO3cYMC8KeDNUaMHqbuo+EnMnVq
 Tv4YMi8D0llarnuSQ7bY4pXbEqAfv2E/zkZtdUGdGkeuem5Hz5yfJDLW9K4zIiUWxU+Z
 vi7Q==
X-Gm-Message-State: AOJu0YzbnUh5tZqLEMRBmAOnU/nj7/ElQeR0wMCoujKgZdLFfMxRjvLh
 OAZxlKavg3GPFIOLe5XvRK5pF66UVT+owS0CETdmvWJEaLVA6AOSY1VdsRzGVwhX0+N8Nnn2ZGd
 QQeJvVMDkgcXevEcs1BqpaEH46m0Avug=
X-Gm-Gg: AR+sD12FmGVJPn/j0YxGuBPsXRNghJbvKPrOWcNdwvJgpGNQY5amZRVakJtYsi8tVdj
 B1WTtofqHti1tg/9Qikodl0ZtfSe60m1Uy2jOFah+nC2nCeKm24S4gqA+bqSeLVBQlhyP6fR0hv
 OJ3nLp1jvXLY8vClI5dbcBIHNGbNPYIAhkVcivEXkSMt/J+ikZH8YhsKkQdrLuUut9GKDdfBSHL
 ShRyVAaBa7TxxgWx0oCIhZbBM0ufC5i5odXwypJA0sCaEfm9knvkZUSZypfoL621BZMQJjq59bQ
 o0Zr56cxZqlmTgqI2s6mYwzJ4+h144GRwSMSx+rF4BzpvxvkuPQKhqBbeMHlD1Sj5uvtFEWPDgy
 bURjGIEUYc/1ohmAWEXb5Y5Ty1SjXWF90Y7Gk43tckA==
X-Received: by 2002:a17:90b:278e:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-3903c721be4mr31305981a91.4.1786371180518; Mon, 10 Aug 2026
 07:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260808032958.385566-1-IVAN.LIPSKI@amd.com>
In-Reply-To: <20260808032958.385566-1-IVAN.LIPSKI@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 10:12:49 -0400
X-Gm-Features: AUfX_mwWmRjOXUM2Sw_lb9-FZeASeXc88r3SFfexd-Al321yJ66PhmKsKiup2dQ
Message-ID: <CADnq5_O8Qa3VGKTfngqjULcr6Mdky=bNEmau_+3BHtuNJAD8Ew@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Relax frame size limit for dcn5/6 DML
 core funcs files
To: IVAN.LIPSKI@amd.com, Mark Brown <broonie@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Dillon Varone <dillon.varone@amd.com>
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

On Sat, Aug 8, 2026 at 6:05=E2=80=AFAM <IVAN.LIPSKI@amd.com> wrote:
>
> From: Ivan Lipski <ivan.lipski@amd.com>
>
> [Why]
> During compilation with  allmodconfig with KASAN, there appears a Werror:
>
>   dml2_core_dcn5_funcs_mode_programming.c:11:13: error: stack frame size
>   (2400) exceeds limit (2048) in 'dcn5_mode_programming'
>   [-Werror,-Wframe-larger-than]
>
> The dcn5/dcn6 dml2_core_*_funcs_mode_{programming,support} files were
> split out of dml2_core_dcn4_calcs.o, which carries a relaxed
> -Wframe-larger-than limit via $(frame_warn_flag) (2056 normally, or
> 4096 for clang + KASAN/KCSAN + COMPILE_TEST). The split-out files were
> never added to the per-file CFLAGS override list, so they inherited the
> strict global default of 2048. This is why these files trip the frame
> size warning under KASAN while the larger dml2_core_dcn4_calcs.o does
> not.
>
> [How]
> Apply the same $(frame_warn_flag) and CFLAGS_REMOVE handling used for
> dml2_core_dcn4_calcs.o to the split-out files:
>  - dml2_core_dcn5_funcs_mode_programming.o
>  - dml2_core_dcn5_funcs_mode_support.o
>  - dml2_core_dcn6_funcs_mode_programming.o
>  - dml2_core_dcn6_funcs_mode_support.o
>
> Fixes: 7f7d7ea1fa51 ("drm/amd/display: Add new sources for DCN6")
>
> Reviewed-by: Dillon Varone <dillon.varone@amd.com>
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>

Reported-by: Mark Brown <broonie@kernel.org>
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dml2_0/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu=
/drm/amd/display/dc/dml2_0/Makefile
> index 35d697872a9a..5388bf094fbc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
> @@ -75,11 +75,19 @@ $(foreach obj,$(DML2_RELATIVE_O_FILES),$(eval CFLAGS_=
REMOVE_$(AMDDALPATH)/$(obj)
>  CFLAGS_$(AMDDALPATH)/dc/dml2_0/display_mode_core.o :=3D $(dml2_ccflags) =
$(frame_warn_flag)
>  CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.=
o :=3D $(dml2_ccflags) $(frame_warn_flag)
>  CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.o :=
=3D $(dml2_ccflags) $(frame_warn_flag)
> +CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_=
mode_programming.o :=3D $(dml2_ccflags) $(frame_warn_flag)
> +CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_=
mode_support.o :=3D $(dml2_ccflags) $(frame_warn_flag)
> +CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_=
mode_programming.o :=3D $(dml2_ccflags) $(frame_warn_flag)
> +CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_=
mode_support.o :=3D $(dml2_ccflags) $(frame_warn_flag)
>  CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o :=3D $(dml2_rcflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o :=3D $(dml2_rcflags=
)
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/display_mode_core.o :=3D $(dml2_rc=
flags)
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4=
_calcs.o :=3D $(dml2_rcflags)
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_util=
s.o :=3D $(dml2_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5=
_funcs_mode_programming.o :=3D $(dml2_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5=
_funcs_mode_support.o :=3D $(dml2_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6=
_funcs_mode_programming.o :=3D $(dml2_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6=
_funcs_mode_support.o :=3D $(dml2_rcflags)
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o :=3D $(dml2_ccflags=
)
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o :=3D $(dml2_=
ccflags)
>
> --
> 2.43.0
>
