Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F42F34C51
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 13:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1CE10E433;
	Mon, 13 Apr 2026 13:10:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rsI6ihAD";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 898E210E433
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 13:10:01 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-488971db0fdso43846165e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 06:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776085800; x=1776690600; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhSMxhE5Dwtw1sPjxnXk51spImxGB+t3SQoJ99qfUxw=;
 b=rsI6ihADU4SRs9+EMUs4W4z7n0ejMNrNCHpmH5cDfgpKf6y01RSnFu/qYkEvdGbfrg
 f8BS4hXvR6IfPslxkmSIh/8C+kZQWOc3Uc8YuOsDSKtn7NISR2dxvzLyRvEsqwUvHi9H
 KUjwRI8Xzt6Zd7a9wYmfwr5910CBJood88L0SoS/Mq7/AfGu5l8x1xZcqV/WHExydIkQ
 G4GIR7xe7YRW5dFa7mt79OsjcddlycsnYgqGIQaoSzxK7thfKnH2QtfGc3QbGzgpGjtx
 xHimllswrgjikrbPCHszHT+lyAQEitNXe/exOK2M2lmqyZqzOBDJoTQNnDDUUPUiSCMI
 54tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776085800; x=1776690600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qhSMxhE5Dwtw1sPjxnXk51spImxGB+t3SQoJ99qfUxw=;
 b=ivMROsdmXBDLlcDojbEiXOfWWkdbXXojZcj1NIcn53ykI296Spdp6eMKB95SDznHQi
 7tRXdwfezn32pW0k1LQck+6lYcCg7RePaNe4xtKwByFJbxq/jlqUEfqas+EdRdrjQqj0
 DyZDt83DFoCzpvNllc1xuMAoocLGmV/9PoEibST3pWXXdLItw8lEH8uMWQFhBa1MKLgr
 EP1p8H3Xmy2H1zmESZypSgy91PzjT9VH3lN+wv0DwUDc4AjVTrdhsnaoJA5j6hoL3I3y
 Z5CQc2sMiGoRd2cJ6UvbPTTN8rLUMazYm2b4OkfCRoViqF1ZKVb3FQ0/b2YyCCXPY/2q
 vloA==
X-Gm-Message-State: AOJu0YzWKXozZj8lztjNkXPVDy6nRGNPN8cRik8+cJ2gJrxgcN+XsAa9
 tYMA9mPQb5Mg/veJbQafhJJza0kGPKb8fWgqSXyTs/a78DPslMvT/IPS+8ZAcbUO
X-Gm-Gg: AeBDiev85rnwpHd9biNZKIpo2ZKTI/98V/nePL6kJb3JgmZpcz+d7K+vJ9IW2xQoTRK
 GhobIH22oZOdbHmeXDqGN5/rSEVbe1NIIAPz1lqz+GgHlLU7AG+6qVzmAKww6ifxE2TWfYZG/5X
 VdzDHa32bfBU2tI0Lpmudg1mZ9vO2J1scFX0B/lhoeQD+qG1qqTngC0lfR8Urv1s+Bv5AWx88TQ
 1K8XeYnXPxwUi024yTLYDEMz5rc53HrLR/V00OFJg8yTvOdCLPpb7iY7bthiw7RMwY2yYE3FTiz
 NmbfwC4QP18tFJoXMSd9OCnyQZ2HbAEgIETsuVHwhCG4HmGMtiTiv4kzNxgVrbUtYSI7k+6WG6w
 OAeUA5qj1L+4ozPGc96jgP1vMz5uhLyLPHjyHCKUtfp5BPZ/LwL0c5My4AbduJAauVLwtvhsYuh
 Wwyh+6rVx5+xQfWfWguGZ7JwWgQGPrgbJYCkSOEaA7UDpruUhBsgm5h4dATqQ6pdYt19eg4t+1C
 bIZHV4hjIwWr6xpVlNQULc5E2AnZw==
X-Received: by 2002:a05:6000:240b:b0:43d:7633:2649 with SMTP id
 ffacd0b85a97d-43d76332872mr7515945f8f.45.1776085799633; 
 Mon, 13 Apr 2026 06:09:59 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24DEE400DF3121E46476B2BD.dsl.pool.telekom.hu.
 [2001:4c4e:24de:e400:df31:21e4:6476:b2bd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7a6054dfsm6904798f8f.17.2026.04.13.06.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 06:09:58 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Alex Hung <alex.hung@amd.com>, David Airlie <airlied@gmail.com>,
 Christian <christian.koenig@amd.com>
Subject: DC analog support regressed by "drm/amd/display: Sync dcn42 with DC
 3.2.373"
Date: Mon, 13 Apr 2026 15:09:56 +0200
Message-ID: <7370736.9J7NaK4W3v@timur-max>
In-Reply-To: <20260306031932.136179-20-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
 <20260306031932.136179-20-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi,

This patch breaks analog connector support in DCE, both for analog encoders=
=20
and DP bridge encoders, because it deletes key functions such as=20
dce110_enable_analog_link_output, dce110_prepare_ddc,=20
dce110_external_encoder_control, and more.

With this patch applied, when you connect an analog monitor you just get a=
=20
crash in DC from trying to call link->dc->hwss.enable_analog_link_output()=
=20
which is now NULL.

This is basically undoing all the work I did for supporting old GPUs with D=
C.
I think either this commit should be reverted or someone should add back th=
e=20
analog support bits that were removed. I'm happy to help with that if neede=
d.
What do you guys think?

As a side question, why was this commit merged without any review or ack?

Thanks & best regards,
Timur

On 2026. m=C3=A1rcius 6., p=C3=A9ntek 4:13:45 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Alex Hung wrote:
> From: Roman Li <Roman.Li@amd.com>
>=20
> This patch provides a bulk merge to align driver
> support for DCN42 with Display Core version 3.2.373.
>=20
> It includes upgrade for:
> - clk_mgr
> - dml2/dml21
> - optc
> - hubp
> - mpc
> - optc
> - hwseq
>=20
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/bios/bios_parser.c |  11 +-
>  .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 141 +++--
>  .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |   2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  95 ++-
>  .../gpu/drm/amd/display/dc/core/dc_stream.c   |  41 +-
>  .../gpu/drm/amd/display/dc/core/dc_surface.c  |   9 +
>  drivers/gpu/drm/amd/display/dc/dc.h           |  59 +-
>  .../gpu/drm/amd/display/dc/dc_bios_types.h    |   3 +-
>  drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   2 +-
>  drivers/gpu/drm/amd/display/dc/dc_plane.h     |   1 +
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |  24 +
>  .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  20 +
>  .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  16 +
>  .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.h |  13 +
>  .../dml2_0/dml21/dml21_translation_helper.c   |  30 +-
>  .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   1 +
>  .../display/dc/dml2_0/dml21/dml21_wrapper.c   |  14 +-
>  .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   | 308 ++++------
>  .../dml21/inc/dml_top_display_cfg_types.h     |  13 +
>  .../dc/dml2_0/dml21/inc/dml_top_types.h       |   2 +
>  .../dml21/src/dml2_core/dml2_core_dcn4.c      | 204 +++----
>  .../dml21/src/dml2_core/dml2_core_factory.c   |   1 +
>  .../dml21/src/dml2_core/dml2_core_utils.c     |  63 +-
>  .../dml21/src/dml2_core/dml2_core_utils.h     |   2 +
>  .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |   1 -
>  .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   1 +
>  .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.h |   2 +-
>  .../dml21/src/dml2_mcg/dml2_mcg_dcn42.h       |   5 +-
>  .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |   1 +
>  .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   6 +
>  .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   4 +-
>  .../dml21/src/dml2_pmo/dml2_pmo_factory.h     |   2 +-
>  .../dml21/src/dml2_top/dml2_top_interfaces.c  |   1 +
>  .../dml21/src/dml2_top/dml2_top_legacy.c      |   1 -
>  .../src/inc/dml2_internal_shared_types.h      |   3 +
>  .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  |   3 +-
>  .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |   2 +
>  .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  21 +
>  .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.c   |   5 +
>  .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 201 ++++---
>  .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  23 +-
>  .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |  85 ++-
>  .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |  16 +-
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 136 +++--
>  .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 412 +++++--------
>  .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 553 +++---------------
>  .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |  10 +-
>  .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   8 +-
>  drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  36 +-
>  .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  18 +-
>  drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 112 ++--
>  drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
>  .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    | 177 +++---
>  .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  25 +-
>  .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  | 390 ++----------
>  .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h  |  50 +-
>  .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   2 +-
>  .../amd/display/dc/optc/dcn42/dcn42_optc.c    | 105 +++-
>  .../amd/display/dc/optc/dcn42/dcn42_optc.h    |  13 +-
>  .../dc/resource/dcn42/dcn42_resource.c        |  10 +-
>  .../dcn401/dcn401_soc_and_ip_translator.c     |   3 +
>  .../dcn42/dcn42_soc_and_ip_translator.c       |  12 +-
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  38 +-
>  .../include/asic_reg/dcn/dcn_4_2_0_offset.h   |   2 +
>  .../include/asic_reg/dcn/dcn_4_2_0_sh_mask.h  |   9 +
>  65 files changed, 1596 insertions(+), 1984 deletions(-)




