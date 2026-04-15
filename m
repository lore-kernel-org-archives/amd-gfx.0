Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35739F4199E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 12:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B909D10E6EA;
	Wed, 15 Apr 2026 12:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IdAogUoH";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8347110E6E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 12:42:10 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-128bae6a35aso990008c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 05:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776256930; cv=none;
 d=google.com; s=arc-20240605;
 b=BoBVJyc+aN08t10DP2cDosgTy3N+9z85XTZtxVx3yxWQczdqfYAgdvOvtBtx70SnKu
 KOM9vo2e9nc1El/YDCX7Z65hZrRXzj5pDFn7g5MQa8dHBMsFvuqe+1chw/RqIw/nXbXk
 +sYZF/07HWMSQEplGtpj7N7KmgcxvSzPSDgJK4eABiSMz0jpaH3iOojkBTriociV6JHL
 GMZgB74iXNAlO2qLn5pB8Mr9GtofpBwAJ27T1MCu5eWEOIf/oe/U2ujTmTXET3CB6Hep
 I/HffYaZ+JuDbVDhKa3q/uAT5QXYQ+o16Rk7CClMP22Ws2yp8MbsEINUlzLoPhUIEeFM
 e2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m6mhDh8ZVimpaQsmL7r1x1xR/f0QJ/vDpnN2yyq/t1k=;
 fh=jkX39MFCRwDBWrGklTHhsZqKubERsuImSi/HwuQ8hRc=;
 b=i9q6GoiaWa3Qy60zanHvRJWPCyAMWfyFlN/kNVpEDTArJ0ghBRzLhw2xkfxMyFWY2t
 NmOCwHU9MnsjbRlJYkmD0EOzTsF8NpvmxYI7R8p6snUgwitvLQycCOtH4WsCfZB3mH8E
 TtxOfH+k1LdHxa87JPmthGbs9vQTojRZgYzqqdtlPIOYAzDsjBcjVQGbi9OsyyGyJeMN
 fwQajssD2DmdYhM7XN1ajma+7c6m+4CF1XsIFRDPeZzBu0EJxvmQk9Xer36T631+EYZa
 isXoRFw1V7W46sbimxjDZQCFocNJyDTZWTLrTsdhPIS4X5qwuhnkG7HH5SOyCJMryIAi
 TPDQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776256930; x=1776861730; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6mhDh8ZVimpaQsmL7r1x1xR/f0QJ/vDpnN2yyq/t1k=;
 b=IdAogUoHqovoxMB+5nBOxrgHTq6YA1hk1CamLTW+R2c63+F3cysk76vvf0cWXrlIBc
 pS6cvZeumHKXRu34T5Iv+JH0M1ZTLo2SVn1Ls/NWxt54LoyX4j7Pgy1PYlDNsxZyeOJq
 g8+m1mpBIYlPrs0p2xXNcaaQaGGVUc/Dwzsdfd6newn77BQRk6X+h6htasoQbbW5oX/o
 EeNLCOvGXieFTuDBoNYlB4C5I2+0yATtcbNUDpmqpKqzw5/ZJ5CSVp1ynR6b8f2hMGaa
 pDhPAT+7aK7dQBD2onLHfxPz95Ldbwj2Okfj46UdFYyPwcjRpvXzIIey8d4weT8Nl6SR
 scqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776256930; x=1776861730;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m6mhDh8ZVimpaQsmL7r1x1xR/f0QJ/vDpnN2yyq/t1k=;
 b=RaW4TIq4HoXTSHKUFhHL+/hhd9alMdnphnybhzs1iL3LDTqDMUdCh3xP74qglKefy/
 2K2OnrsbGZEaJ0vvicQfquFnLDNhFURtifiPhjCsM4ZvNcBQHDMYMjxTchIu28Qxgkqj
 nP4zAbSKZ0u9JJo+nPezbetTnwIfXr+KF1vwk5VHmBjJWkzHjvQfRRdPyCJ6Fdq190Pc
 FGckAWcUAV3iJeq53zgZFJYj+gqaNa28845ybsRVTNBFxEuis9VjEjg32GhXBaVjOlr7
 tcB7rwbHmoqQVANqEzegR7MjgXanvBePLqYpan8WABoZHXPqLAEZR95PN9cYpooc11Wl
 oS5w==
X-Gm-Message-State: AOJu0YwaDi3uQ5jcd6rpSPLb9hftZwn0VxInoXG46K4hY1gTJ/sU325t
 ho3H6Nrj1SddeHc87LvvjEUWtRY4ZWCee5F4zD7wd5zvoYxSX5vdBAMPAwSPYfgxkpNTd+Dm9L5
 8QFP2m7qtzz/tyWC2cKBpT1Gls10v1BM=
X-Gm-Gg: AeBDietuEmqkYOXQlkLeBJXL88wLiKZO6yZLtG2a+rHJsxF2eSi11JwgcCbIsIL8KCw
 45Vgqpb+mxFYhN7JVLUfw96CTjQkWrS33mQMEBdZr9Mjr/RBQYALffhtHxxr7Yibhfk+Mcp3MwH
 IQSe+P9neC5H6w+SvZVT+V8PO8CF5pAR8VuQ/EbewWbfS/gx+5HiSCrTrxmTU9EasPrbIQcyYYJ
 0wczM8I0mhHchBr9bmbefHTTAKUsDjfGUVZ6XBJSzl/wnQuxtR6NP+mDQPGoUj2Yyd1ZQ/QO05b
 cG2GjE0ois0ym5Jl2USqIEmfHEWJFusqaxQReqXE/gmCet3DvoWZr6X1ac1CsECTDsbvTw==
X-Received: by 2002:a05:7022:6288:b0:128:d4d5:93b9 with SMTP id
 a92af1059eb24-12c5d4f349emr470556c88.7.1776256929440; Wed, 15 Apr 2026
 05:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260403214329.2976329-1-alexander.deucher@amd.com>
In-Reply-To: <20260403214329.2976329-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Apr 2026 08:41:56 -0400
X-Gm-Features: AQROBzBw9xzWFFRU4nNxAhqgJRDrt_tA99Kk_T2mlZd3GoHhkm4ke_mPtIzELW4
Message-ID: <CADnq5_OG-R0AVesZyxoAxS+yQFaEigA0yu5wZSyukm4PH8bjug@mail.gmail.com>
Subject: Re: [pull] amdgpu, amdkfd, radeon, drm drm-next-7.1
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 airlied@gmail.com, simona.vetter@ffwll.ch
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

Hi, looks like this got missed.  Can you still pick it up?

Thanks,

Alex

On Fri, Apr 3, 2026 at 6:09=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Hi Dave, Simona,
>
> A few last changes for 7.1.
>
> The following changes since commit 512f9f150f367176fa9e5f4613b4863409a6f6=
86:
>
>   Merge tag 'drm-msm-next-2026-04-02' of https://gitlab.freedesktop.org/d=
rm/msm into drm-next (2026-04-03 18:57:00 +1000)
>
> are available in the Git repository at:
>
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.1-20=
26-04-03
>
> for you to fetch changes up to 7b15fc2d1f1a00fb99f0146e404ff2600999ec74:
>
>   drm/amdgpu: dump job ibs in the devcoredump (2026-04-03 16:16:25 -0400)
>
> ----------------------------------------------------------------
> amd-drm-next-7.1-2026-04-03:
>
> amdgpu:
> - Audio regression fix
> - Use drm edid parser for AMD VSDB
> - Misc cleanups
> - VCE cs parse fixes
> - VCN cs parse fixes
> - RAS fixes
> - Clean up and unify vram reservation handling
> - GPU Partition updates
> - system_wq cleanups
> - Add CONFIG_GCOV_PROFILE_AMDGPU kconfig option
> - SMU vram copy updates
> - SMU 15 fixes
> - SMU 13 fixes
> - SMU 14 fixes
> - UserQ fixes
> - Replace pasid idr with an xarray
> - Dither handling fix
> - Enable amdgpu by default for CIK APUs
> - Add IBs to devcoredump
>
> amdkfd:
> - system_wq cleanups
>
> radeon:
> - system_wq cleanups
>
> drm:
> - Add support for AMD VSDB parsing to drm_edid
>
> ----------------------------------------------------------------
> Benjamin Cheng (5):
>       drm/amdgpu: Add bounds checking to ib_{get,set}_value
>       drm/amdgpu/vce: Prevent partial address patches
>       drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg
>       drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg
>       drm/amdgpu/vcn4: Prevent OOB reads when parsing IB
>
> Ce Sun (1):
>       drm/amd/ras: enable uniras via IP version check
>
> Chenyu Chen (2):
>       drm/edid: Parse AMD Vendor-Specific Data Block
>       drm/amd/display: Use drm_display_info for AMD VSDB data
>
> Ionut Nechita (1):
>       drm/amd/display: Wire up dcn10_dio_construct() for all pre-DCN401 g=
enerations
>
> Lijo Lazar (17):
>       drm/amdgpu: Add reserved region ids
>       drm/amdgpu: Add stolen vga reserve-region
>       drm/amdgpu: Add extended stolen vga reserve-region
>       drm/amdgpu: Add stolen_reserved reserve-region
>       drm/amdgpu: Add fw_reserved reserve-region
>       drm/amdgpu: Add firmware extended reserve-region
>       drm/amdgpu: Add fw vram usage reserve-region
>       drm/amdgpu: Add host driver reserved-region
>       drm/amdgpu: Add memory training reserve-region
>       drm/amdgpu: Group filling reserve region details
>       drm/amdgpu: Add function to fill fw reserve region
>       drm/amdgpu: Add function to fill training region
>       drm/amdgpu: Move validation of reserve region info
>       drm/amdgpu: Consolidate reserve region allocations
>       drm/amd/pm: Add smu vram copy function
>       drm/amd/pm: Use smu vram copy in SMUv13
>       drm/amd/pm: Use smu vram copy in SMUv15
>
> Linus Probert (2):
>       drm/amd/display: Replace inline NUM_ELEMENTS macro with ARRAY_SIZE
>       drm/amd/display: Remove unused NUM_ELEMENTS macros
>
> Marco Crivellari (5):
>       drm/amd/display: Replace use of system_wq with system_percpu_wq
>       drm/amdgpu: replace use of system_unbound_wq with system_dfl_wq
>       drm/amdgpu: replace use of system_wq with system_dfl_wq
>       amd/amdkfd: add WQ_UNBOUND to alloc_workqueue users
>       drm/radeon: add WQ_PERCPU to alloc_workqueue users
>
> Mario Kleiner (1):
>       drm/amd/display: Change dither policy for 10 bpc output back to dit=
hering
>
> Mikhail Gavrilov (1):
>       drm/amdgpu: replace PASID IDR with XArray
>
> Pierre-Eric Pelloux-Prayer (4):
>       drm/amdgpu: save ring content before resetting the device
>       drm/amdgpu: extract amdgpu_vm_lock_by_pasid from amdgpu_vm_handle_f=
ault
>       drm/amdgpu: store ib info for devcoredump
>       drm/amdgpu: dump job ibs in the devcoredump
>
> Prike Liang (2):
>       drm/amdgpu: rework userq fence driver alloc/destroy
>       drm/amdgpu: make userq fence_drv drop explicit in queue destroy
>
> Srinivasan Shanmugam (3):
>       drm/amd/display: Fix dc_is_fp_enabled name mismatch
>       drm/amd/display: Fix parameter mismatch in panel self-refresh helpe=
r
>       drm/amd/display: Fix missing parameter details in amdgpu_dm_ism
>
> Sunil Khatri (5):
>       drm/amdgpu/userq: dont need check for return values in amdgpu_userq=
_evict
>       drm/amdgpu/userq: fence wait for max time in amdgpu_userq_wait_for_=
signal
>       drm/amdgpu/userq: add the return code too in error condition
>       drm/amdgpu/userq: call dma_resv_wait_timeout without test for signa=
lled
>       drm/amdgpu/userq: use dma_fence_wait_timeout without test for signa=
lled
>
> Timur Krist=C3=B3f (1):
>       drm/amdgpu: Use amdgpu by default for CIK APUs too
>
> Vitaly Prosyak (1):
>       drm/amdgpu: add CONFIG_GCOV_PROFILE_AMDGPU Kconfig option
>
> Xiaogang Chen (1):
>       drm/amdgpu: add an option to allow gpu partition allocate all avail=
able memory
>
> Yang Wang (4):
>       drm/amd/pm: correct mem_busy_percent display due to calculation err=
ors
>       drm/amd/pm: fix null pointer dereference issue in smu_v15_0_8_get_p=
ower_limit()
>       drm/amd/pm: optimize logic and remove unnecessary checks in smu v15=
.0.8
>       drm/amd/pm: fix memleak issue in smu_v15_0_8_get_gpu_metrics()
>
>  drivers/gpu/drm/amd/amdgpu/Kconfig                 |  17 +
>  drivers/gpu/drm/amd/amdgpu/Makefile                |   4 +
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c             |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   5 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |  18 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   | 191 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |  21 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  39 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |  17 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  23 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |  39 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  13 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c          |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |  11 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 362 +++++++++------=
------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |  53 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  81 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  32 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h    |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |  50 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  89 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h            |   2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  10 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  10 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |  11 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   2 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |   2 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |   2 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   2 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   2 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   2 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   2 -
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |  10 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |  10 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  23 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |  44 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   3 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 128 ++++----
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  14 -
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  21 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |   9 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c     |   2 +-
>  .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   5 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   2 +-
>  .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   6 +-
>  .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c    |   3 -
>  .../drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |   3 -
>  .../gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c   |   2 -
>  .../gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   |   4 -
>  .../amd/display/dc/resource/dcn10/dcn10_resource.c |  41 +++
>  .../amd/display/dc/resource/dcn20/dcn20_resource.c |  42 +++
>  .../display/dc/resource/dcn201/dcn201_resource.c   |  41 +++
>  .../amd/display/dc/resource/dcn21/dcn21_resource.c |  34 ++
>  .../amd/display/dc/resource/dcn30/dcn30_resource.c |  42 +++
>  .../display/dc/resource/dcn301/dcn301_resource.c   |  42 +++
>  .../display/dc/resource/dcn302/dcn302_resource.c   |  41 +++
>  .../display/dc/resource/dcn303/dcn303_resource.c   |  41 +++
>  .../amd/display/dc/resource/dcn31/dcn31_resource.c |  40 +++
>  .../display/dc/resource/dcn314/dcn314_resource.c   |  40 +++
>  .../display/dc/resource/dcn315/dcn315_resource.c   |  40 +++
>  .../display/dc/resource/dcn316/dcn316_resource.c   |  40 +++
>  .../amd/display/dc/resource/dcn32/dcn32_resource.c |  43 +++
>  .../display/dc/resource/dcn321/dcn321_resource.c   |  43 +++
>  .../amd/display/dc/resource/dcn35/dcn35_resource.c |  43 +++
>  .../display/dc/resource/dcn351/dcn351_resource.c   |  43 +++
>  .../amd/display/dc/resource/dcn36/dcn36_resource.c |  43 +++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  17 +
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  10 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |   9 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  19 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  10 +-
>  .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  10 +-
>  .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |  76 ++---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  12 +
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |   3 +
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |   9 +-
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |  16 +-
>  drivers/gpu/drm/drm_edid.c                         |  72 ++++
>  drivers/gpu/drm/radeon/radeon_display.c            |   3 +-
>  drivers/gpu/drm/radeon/radeon_drv.c                |   3 +-
>  include/drm/drm_connector.h                        |  38 +++
>  92 files changed, 1756 insertions(+), 703 deletions(-)
