Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EC3CD4F52
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 09:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2FC10E767;
	Mon, 18 May 2026 09:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QFey4Jy/";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1ABF10E032
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 May 2026 18:58:44 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-bcd9c871f97so17654666b.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 May 2026 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779044323; x=1779649123; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Bce3b7dbICRrjRie4Pc3Tb/eGf0Vh3PHL1ybxfqDgP8=;
 b=QFey4Jy/aBShRNQ/re8ZILLFyrTxp3VohXpQ6nTxW7luHPtDaWn/4xQccdHrogOrHP
 v3DbkU1PbTmD1atdGjz2kZ9Hzu01YcOOpM9Ln/7NqxDypPIwGilIUnRMauOZmQDRbF6F
 /UJ1vnWi1sAOIQ/6yNKb+BF3TDJRbyNOYl1nAtWoDJkvq0XgOReNxKgDMhhIQfDEvqG9
 0cE2BN/ylcOW2N4mDQeL9Ji/kBJRsWAARi4MdEM2HQp5e1L0s2vAI5e22BnB+KmU02jz
 Q4utwvvy77hEbewjXQ1KXjHFJb4ynUugDuSjG1w9jxCfyictj+5bEybgm10YdR+E+dc5
 FRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779044323; x=1779649123;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Bce3b7dbICRrjRie4Pc3Tb/eGf0Vh3PHL1ybxfqDgP8=;
 b=p9YtO/kzXGxh0dRiLaKElA1XZ3pGEaey6YFL16hKp6k/GBhA0TNFPUIRszbEB978Sa
 MJhjGhnrUu5LI+CCQtl/J2LYiOxrS/5elBP5RwCOr6npCMuf2ad6zmZtFK7NRdKe9kc6
 MckqcyoB+wW4n87yJbuRqBjwZjACKpJxB1CwQBOHpRrkawgQRP3vF51QgwwKen5xOcFu
 it2CSjA9GxlZow3ozjKuUpO2QZq40NT5Dbl1X08fYh+cIeASeEaWpdosB/i8hmVfMyy3
 87QuRgs44WPnt5gy2Le9ZSLhCYYTnI7rup2T2hQtZd1GncifCbG93iMvpwKg2JKgTHTF
 Eo3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9v+eMYOlrGFafg28Ov3+1UruFqGBb/qYMlp6Av4rtbNDWte7Rbdhz4AUz2qk5Rr93NDWmb00eP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJPSqenzcedBFcnBSgytJZGiMnqSBVNnh/2pyhXPyHS9kb4er4
 GPoH54DsN9A1UkPUVH80Piye68/nKp4M/sAHEY2MXOGmgijFKIf3iqDC
X-Gm-Gg: Acq92OEOCikShldu+8WRq8mvKOMQNljkadnkg1VCQdqkpIHqNWa962EtCJQXhw8YLgM
 ByZ77TJLNborBAYu5iTvye9eQaZMnOCYQvQv4RNwmEpqWfpykWvrD9/ipziSEOuMawpbG3qVehV
 j3yNta7w3RKB6jNfqvgxaWvsY1K1Jp2XmPOP3PDm4IIcIFdRxgXzzYrWPpqx4Ki1bYnTcwxOw/N
 bPYAM/x12hygLZyQf+KJHBVo60XDfLyeIucuDdHk+aGGEw3U+dAW1brLH360+BS7vRlozVFf2YI
 +ApBSYAdHxt9lTMz3S/mB/C2qwtRqJZ2q0CtITo2j/cZmumQCPy1M00C/9jUdV3gJ/LK5YS4jgr
 rVRxP8rx//AyyvHRutpUPPZIksl14tPEljf2prR3yJojP42LkB+7KMyBd5QEQyoks0LUv1Qi4RE
 uuge4EvXQhNGvxYu5It8EZ3FW9ozQJNf6fl7oaN/uc+JHlDmvjLlG7CguWVdPDS9LHuyiBF8O+e
 q3zJz3IX8w=
X-Received: by 2002:a17:907:5cd:b0:bd0:4a19:22f2 with SMTP id
 a640c23a62f3a-bd517b5b664mr255649966b.7.1779044323117; 
 Sun, 17 May 2026 11:58:43 -0700 (PDT)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl.
 [87.205.5.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4e604e6sm470623666b.52.2026.05.17.11.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 11:58:42 -0700 (PDT)
Message-ID: <ba0d05a59db5cf49b9eb1dacbf8a79a053012b66.camel@gmail.com>
Subject: Re: [PATCH v5 00/13] HDMI FRL and DSC Support for amdgpu
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jerry.Zuo@amd.com, Rodrigo Siqueira <siqueira@igalia.com>
Date: Sun, 17 May 2026 20:58:42 +0200
In-Reply-To: <20260512155244.403854-1-harry.wentland@amd.com>
References: <20260512155244.403854-1-harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 18 May 2026 09:33:27 +0000
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

On Tue, 2026-05-12 at 11:52 -0400, Harry Wentland wrote:
> This patch series adds HDMI FRL and FRL DSC support to the amdgpu
> display driver.
>=20
> This work passed a representative subset of HDMI compliance and a full
> compliance run on this branch is in the works. We don't expect the full
> run to show any failures since it passes in other environments.
>=20
> Thanks to Siqueira who prepared this work a couple years back and
> unfortunately didn't manage to send them while he was still working
> at AMD.
>=20
> Thanks to Jerry who has been making this code solid on Linux and
> running the compliance tests.
>=20
> The first patch in the series isn't related to HDMI 2.1 but included
> here because it moved the code around some key bits of the HDMI 2.1
> stuff around too much. It will land with the next DC Patch series.
>=20
> v5:
> - One more missing FP compilation fix
>=20
> v4:
> - Disable FRL over DP MST due to lack of testing
> - FP compilation fix
> - squash fixup commit
>=20
> v3:
> - Add missing DML2 bits
> - Merged register headers to asdn and removed from patchset
>=20
> v2:
> - Add missing function pointers on DCN 3.x
> - Add DSC
>=20
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Cc: Zuo, Jerry <Jerry.Zuo@amd.com>
> Cc: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
>=20
> Fangzhi Zuo (1):
>   drm/amd/display: add HDMI 2.1 Compliance Support
>=20
> Harry Wentland (12):
>   drm/amd/display: Add HDMI FRL definitions to includes
>   drm/amd/display: Add DML changes to support HDMI FRL
>   drm/amd/display: add HDMI 2.1 FRL base support to DML 2.0
>   drm/amd/display: Add DCCG DIO, HPO, OPP, and OPTC support for FRL
>   drm/amd/display: Add FRL support to clk_mgr, dsc, hdcp
>   drm/amd/display: Tie FRL programming together in HWSS
>   drm/amd/display: Add DC resource support for FRL
>   drm/amd/display Add DC link support for FRL
>   drm/amd/display: Add support for FRL to DC core
>   drm/amd/display: Update HDCP and info_packet modules for FRL
>   drm/amd/display: Tie FRL support into amdgpu_dm
>   drm/amd/display: add HDMI 2.1 DSC over FRL support
>=20
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  160 ++-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   11 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   28 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    2 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   68 +-
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   79 ++
>  .../drm/amd/display/dc/bios/bios_parser2.c    |   21 +
>  .../drm/amd/display/dc/bios/command_table2.c  |    6 +
>  .../dce112/command_table_helper2_dce112.c     |    3 +
>  .../bios/dce112/command_table_helper_dce112.c |    3 +
>  .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |    3 +
>  .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |    3 +
>  .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |    3 +
>  .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |    3 +
>  .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   12 +
>  .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   14 +
>  .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   18 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |   32 +-
>  .../gpu/drm/amd/display/dc/core/dc_debug.c    |    4 +
>  .../drm/amd/display/dc/core/dc_hw_sequencer.c |   49 +
>  .../drm/amd/display/dc/core/dc_link_enc_cfg.c |    3 +
>  .../drm/amd/display/dc/core/dc_link_exports.c |   45 +
>  .../gpu/drm/amd/display/dc/core/dc_resource.c |  289 ++++
>  .../gpu/drm/amd/display/dc/core/dc_stream.c   |   35 +
>  drivers/gpu/drm/amd/display/dc/dc.h           |  128 ++
>  drivers/gpu/drm/amd/display/dc/dc_dsc.h       |    8 +
>  .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |  164 ++-
>  drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    8 +
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |   24 +
>  .../amd/display/dc/dccg/dcn30/dcn30_dccg.c    |   40 +
>  .../amd/display/dc/dccg/dcn30/dcn30_dccg.h    |    8 +
>  .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |   88 ++
>  .../amd/display/dc/dccg/dcn31/dcn31_dccg.h    |   13 +
>  .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |   25 +
>  .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |   68 +
>  .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  321 +++++
>  .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   73 +
>  .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |    4 +
>  .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |   33 +
>  .../gpu/drm/amd/display/dc/dce/dce_audio.c    |    8 +
>  .../drm/amd/display/dc/dce/dce_clock_source.c |   30 +-
>  .../display/dc/dio/dcn10/dcn10_link_encoder.c |    3 +-
>  .../display/dc/dio/dcn20/dcn20_link_encoder.h |    1 +
>  .../dc/dio/dcn30/dcn30_dio_link_encoder.c     |  250 ++++
>  .../dc/dio/dcn30/dcn30_dio_link_encoder.h     |   17 +
>  .../dc/dio/dcn301/dcn301_dio_link_encoder.c   |   18 +
>  .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |  114 ++
>  .../dc/dio/dcn31/dcn31_dio_link_encoder.h     |    8 +
>  .../dc/dio/dcn32/dcn32_dio_link_encoder.c     |  214 +++
>  .../dc/dio/dcn32/dcn32_dio_link_encoder.h     |   16 +
>  .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |   20 +
>  .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |   21 +
>  .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |  220 +++
>  .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |   16 +
>  .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |   21 +
>  drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |    1 +
>  .../drm/amd/display/dc/dm_services_types.h    |    1 +
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   |    3 +
>  .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    5 +
>  .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  127 ++
>  .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |   22 +
>  .../dc/dml/dcn30/display_mode_vba_30.c        |  280 +++-
>  .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |    1 +
>  .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |    1 +
>  .../dc/dml/dcn31/display_mode_vba_31.c        |  243 ++++
>  .../dc/dml/dcn314/display_mode_vba_314.c      |  241 ++++
>  .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   10 +
>  .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |    2 +
>  .../dc/dml/dcn32/display_mode_vba_32.c        |   16 +-
>  .../dc/dml/dcn32/display_mode_vba_util_32.c   |  127 +-
>  .../amd/display/dc/dml/display_mode_enums.h   |    1 +
>  .../drm/amd/display/dc/dml/dml1_frl_cap_chk.c |  786 +++++++++++
>  .../drm/amd/display/dc/dml/dml1_frl_cap_chk.h |  173 +++
>  .../gpu/drm/amd/display/dc/dml2_0/Makefile    |    2 +
>  .../amd/display/dc/dml2_0/display_mode_core.c |  104 +-
>  .../amd/display/dc/dml2_0/display_mode_util.c |    3 +
>  .../dml2_0/dml21/dml21_translation_helper.c   |    4 +
>  .../dml21/src/dml2_core/dml2_core_dcn4.c      |    1 +
>  .../src/dml2_core/dml2_core_dcn4_calcs.c      |   29 +-
>  .../src/dml2_core/dml2_core_shared_types.h    |    3 +
>  .../lib_frl_cap_check.c                       |  396 ++++++
>  .../lib_frl_cap_check.h                       |   90 ++
>  .../dc/dml2_0/dml2_translation_helper.c       |    4 +
>  .../drm/amd/display/dc/dml2_0/dml2_utils.c    |    2 +
>  .../amd/display/dc/dml2_0/dml_frl_cap_chk.c   |  413 ++++++
>  .../amd/display/dc/dml2_0/dml_frl_cap_chk.h   |  109 ++
>  drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  704 ++++++++++
>  drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |    5 +
>  .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |    1 +
>  drivers/gpu/drm/amd/display/dc/hpo/Makefile   |   10 +
>  .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c |  286 ++++
>  .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h |  146 ++
>  .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.c  | 1043 +++++++++++++++
>  .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.h  |  436 ++++++
>  .../dcn401/dcn401_hpo_frl_stream_encoder.c    |  907 +++++++++++++
>  .../dcn401/dcn401_hpo_frl_stream_encoder.h    |  335 +++++
>  .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  |  207 +++
>  .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.h  |   59 +
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   99 +-
>  .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   37 +
>  .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   19 +-
>  .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   49 +-
>  .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   13 +
>  .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    1 +
>  .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   13 +-
>  .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    1 +
>  .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |    3 +-
>  .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    1 +
>  .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   13 +-
>  .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    3 +
>  .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   42 +
>  .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |    2 +
>  .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    2 +
>  .../amd/display/dc/hwss/dcn351/dcn351_init.c  |    2 +
>  .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   13 +
>  .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
>  .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   38 +-
>  .../amd/display/dc/hwss/dcn42/dcn42_init.c    |    2 +
>  .../drm/amd/display/dc/hwss/hw_sequencer.h    |   34 +
>  .../display/dc/hwss/hw_sequencer_private.h    |    3 +
>  .../gpu/drm/amd/display/dc/inc/core_status.h  |    2 +
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |   12 +
>  drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   10 +
>  .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |    1 +
>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |  176 +++
>  .../amd/display/dc/inc/hw/stream_encoder.h    |  231 ++++
>  .../amd/display/dc/inc/hw/timing_generator.h  |    5 +
>  .../gpu/drm/amd/display/dc/inc/link_service.h |   15 +
>  drivers/gpu/drm/amd/display/dc/inc/resource.h |    7 +
>  drivers/gpu/drm/amd/display/dc/link/Makefile  |    2 +
>  .../display/dc/link/hwss/link_hwss_hpo_frl.c  |  113 ++
>  .../display/dc/link/hwss/link_hwss_hpo_frl.h  |   34 +
>  .../drm/amd/display/dc/link/link_detection.c  |  111 ++
>  .../gpu/drm/amd/display/dc/link/link_dpms.c   |  223 +++-
>  .../gpu/drm/amd/display/dc/link/link_dpms.h   |    1 +
>  .../drm/amd/display/dc/link/link_factory.c    |   44 +
>  .../drm/amd/display/dc/link/link_validation.c |  298 +++++
>  .../drm/amd/display/dc/link/link_validation.h |   13 +
>  .../amd/display/dc/link/protocols/link_ddc.c  |   90 ++
>  .../amd/display/dc/link/protocols/link_ddc.h  |    4 +
>  .../display/dc/link/protocols/link_hdmi_frl.c | 1187 +++++++++++++++++
>  .../display/dc/link/protocols/link_hdmi_frl.h |   53 +
>  .../amd/display/dc/link/protocols/link_hpd.c  |    1 +
>  .../drm/amd/display/dc/opp/dcn10/dcn10_opp.c  |    1 +
>  .../amd/display/dc/optc/dcn10/dcn10_optc.h    |    5 +-
>  .../amd/display/dc/optc/dcn30/dcn30_optc.c    |    8 +-
>  .../amd/display/dc/optc/dcn30/dcn30_optc.h    |    8 +-
>  .../amd/display/dc/optc/dcn31/dcn31_optc.c    |    2 +
>  .../amd/display/dc/optc/dcn401/dcn401_optc.c  |    2 +
>  .../dc/resource/dce112/dce112_resource.c      |    3 +
>  .../dc/resource/dcn30/dcn30_resource.c        |  126 ++
>  .../dc/resource/dcn301/dcn301_resource.c      |    1 +
>  .../dc/resource/dcn302/dcn302_resource.c      |  109 ++
>  .../dc/resource/dcn303/dcn303_resource.c      |  109 ++
>  .../dc/resource/dcn31/dcn31_resource.c        |  127 ++
>  .../dc/resource/dcn314/dcn314_resource.c      |  127 ++
>  .../dc/resource/dcn315/dcn315_resource.c      |  128 ++
>  .../dc/resource/dcn316/dcn316_resource.c      |  126 ++
>  .../dc/resource/dcn32/dcn32_resource.c        |  131 ++
>  .../dc/resource/dcn32/dcn32_resource.h        |   79 +-
>  .../dc/resource/dcn321/dcn321_resource.c      |  132 ++
>  .../dc/resource/dcn35/dcn35_resource.c        |  121 ++
>  .../dc/resource/dcn351/dcn351_resource.c      |  121 ++
>  .../dc/resource/dcn36/dcn36_resource.c        |  121 ++
>  .../dc/resource/dcn401/dcn401_resource.c      |  121 ++
>  .../dc/resource/dcn42/dcn42_resource.c        |  121 ++
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    5 +-
>  .../gpu/drm/amd/display/include/audio_types.h |    1 +
>  .../amd/display/include/bios_parser_types.h   |   14 +-
>  .../drm/amd/display/include/logger_types.h    |    2 +
>  .../drm/amd/display/include/signal_types.h    |   12 +-
>  .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |    2 +
>  .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |    6 +
>  .../drm/amd/display/modules/hdcp/hdcp_psp.c   |    2 +
>  .../drm/amd/display/modules/hdcp/hdcp_psp.h   |    2 +
>  .../amd/display/modules/inc/mod_freesync.h    |    3 +
>  .../drm/amd/display/modules/inc/mod_hdcp.h    |    1 +
>  .../amd/display/modules/inc/mod_info_packet.h |    2 +-
>  .../display/modules/info_packet/info_packet.c |  122 +-
>  179 files changed, 15129 insertions(+), 113 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_=
standalone_libraries/lib_frl_cap_check.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_=
standalone_libraries/lib_frl_cap_check.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk=
.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk=
.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_fr=
l_link_encoder.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_fr=
l_link_encoder.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_fr=
l_stream_encoder.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_fr=
l_stream_encoder.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_=
frl_stream_encoder.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_=
frl_stream_encoder.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_fr=
l_stream_encoder.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_fr=
l_stream_encoder.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hp=
o_frl.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hp=
o_frl.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hd=
mi_frl.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hd=
mi_frl.h
>=20
> --
> 2.54.0

Okay, I might not have that much to add, but since you CC'd me, I can
add my two cents.

1. I think the hungarian notation should be removed from the patches.
It's not used in the kernel and I even saw some commits to amdgpu that
explicitly remove it in favor of snake_case.

2. Are the patches actually tested on top of amdgpu/drm-next? I think
that the branch that should be targeted on this list right? I'm asking
this because I still can't apply these patches cleanly on top of, well,
anything. git am is complaining of missing target SHAs and there are a
lot of conflicts. Yes, most of the conflicts are with whitespace so it's
easy to deal with them, but still, to test properly, this should apply
cleanly right?

3. Most of the FRL code is too much to even argue with, but the little
bits I did myself before, there I could comment. I think the hf-vsif
modifications to support hdmi forum infopacket are too verbose. I don't
think code duplication just to add values in a different place is that
great of an idea. In my patch series for VRR and ALLM, I implemented a
simple offset variable, and I think this would be a cleaner solution.
Here's a snippet of how it looks:

...
uint8_t offset =3D 0;
uint8_t length =3D 5;
uint32_t oui =3D HDMI_IEEE_OUI;
...
if (allm)
	oui =3D HDMI_FORUM_IEEE_OUI;

info_packet->sb[1] =3D oui & 0xFF;
info_packet->sb[2] =3D (oui >> 8) & 0xFF;
info_packet->sb[3] =3D (oui >> 16) & 0xFF;

if (oui =3D=3D HDMI_FORUM_IEEE_OUI) {
	offset =3D 2;
	length +=3D 2;
	info_packet->sb[4] =3D HF_VSIF_VERSION;
	info_packet->sb[5] =3D stereo << HF_VSIF_3D_BIT;
	info_packet->sb[5] |=3D allm << HF_VSIF_ALLM_BIT;
}

if (stereo) {
	info_packet->sb[4 + offset] =3D (2 << 5);

	switch (format) {
	case TIMING_3D_FORMAT_HW_FRAME_PACKING:
	case TIMING_3D_FORMAT_SW_FRAME_PACKING:
		info_packet->sb[5 + offset] =3D (0x0 << 4);
		break;

	case TIMING_3D_FORMAT_SIDE_BY_SIDE:
	case TIMING_3D_FORMAT_SBS_SW_PACKED:
		info_packet->sb[5 + offset] =3D (0x8 << 4);
		++length;
		break;

	case TIMING_3D_FORMAT_TOP_AND_BOTTOM:
	case TIMING_3D_FORMAT_TB_SW_PACKED:
		info_packet->sb[5 + offset] =3D (0x6 << 4);
		break;

	default:
		break;
	}

/* Doesn't need the offset as it can't be used with hf-vsif */
} else if (hdmi_vic_mode) {
	info_packet->sb[4] =3D (1 << 5);
	info_packet->sb[5] =3D stream->timing.hdmi_vic;
}


Moreover, the hf-vsif infopacket function is taking ALLM and ALLM value
variables directly. I think this is wholly misguided for few reasons.
First, ALLM in an on/off setting. I simply don't see a reason to pass
two variables if it can be done in one, but maybe I'm missing something.

void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
    struct dc_info_packet *info_packet, int ALLMEnabled, int ALLMValue)

Secondly, ALLM will have to be part of dc_stream or some other struct
because it's use is mutually exclusive with HDMI VIC modes and if ALLM
is in use when doing 4k 60, we must inform AVI infopacket function of
this, so it can decide to translate them into CEA modes.

And finally, I think it would be a good idea to indicate that this
function support bot h14b-vsif and hf-vsif depending on the use-case.

I'm eagerly waiting for updates with HDMI VRR and maybe even fast
vactive (I've seen it implemented in the code).

Tomasz
