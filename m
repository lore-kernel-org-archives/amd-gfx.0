Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FFCC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3614207D0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsKng4JL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3614207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D1B6E221;
	Mon,  1 Jun 2020 18:35:48 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2066E6E0D7
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:35:47 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id y1so8492529qtv.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kM7gHL1mL8ek85NplqxV/d90L8LrwI/42VQVOlhalbs=;
 b=HsKng4JLwPs5DgiUtnU1fWpZ26WNik/NH6s2CehphNPRnDclX7nBQ2jdZgFi5cQTkA
 qDwpPC6Hxzn8FIAZn4pO5H0Beck6vNhEKpClj8JcFRt7EqgsgNNKlaNmx78ghxuhIO92
 N0zYU/0g5ilAmwkZMiwKgTXBh+EIDMjf7H92QO7Z4GAxPzGFDAzv3nBWgkUkQIvxjf2E
 jRV4/wXWNMwvPeywElmux4NFMi/2TTL0hhzyeYbuIyszV3nUBQWBVenZ6COPlLqZpmT0
 pY/YWqhlQ4+mai8VUNwcSwgpCGP0MIFqrfzW7xxBvMIwDlTRWMNEHF8GZY4HLK3E9CGI
 fngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kM7gHL1mL8ek85NplqxV/d90L8LrwI/42VQVOlhalbs=;
 b=pN3Ef7kzRgH8XBUD4bfA84E3c5O3kQduu540mWl4kurHQY71a95MJrcwpkVHOhVCIE
 jEOG9doSq2YUjUMKtLBDvTEg6RVhhXmV48MyirDeAxy2RMXyHLZW1aOxeqg2FB6T7WP6
 pSrZ0p17fGvugOj47k0kwlDQImfwBj0QM5G1fjSBB5lA4qEL2tzfJfhmOBpaHNCsGdX3
 Qwpjpu5eCi9MhhudWj3UlbCECkD6M8EpcVVV1G7TdUXmehjPAEolkZbPp5wSDtUVsVqw
 R0B3+UCs849fcIBx0Y1aXna3ALrat0kgNqtb8k8LKqC5Fdj+839kvn9+8L55g1G8Zyzz
 u/ew==
X-Gm-Message-State: AOAM532kqbg2BgcdsloWMBPai0U0xStK7sj9+LuN4wPjb5ajyUk+Hi10
 Qjv7FPoNiBKpJrqndGcEUkNnMWpy
X-Google-Smtp-Source: ABdhPJxaQz3ArPPEcpSkUBDdN+x4DVEL+2z2xMBFIyuAysBJ2ZK6DvVmPTDIHqH0wNKdvs+hIIwucw==
X-Received: by 2002:aed:2213:: with SMTP id n19mr24129299qtc.246.1591036545437; 
 Mon, 01 Jun 2020 11:35:45 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w204sm39776qka.41.2020.06.01.11.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:35:44 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 000/207] Add support for Sienna Cichlid
Date: Mon,  1 Jun 2020 14:35:36 -0400
Message-Id: <20200601183536.1268046-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sienna Cichlid is GPU from AMD.  This patch set adds support for it
including asic init, power management, display, interrupts, gfx, multi-media,
etc.

The new register headers (patches 1-4) are quite large so I did not send
them to the mailing list.  The full patch set including register headers
can be found here:
https://cgit.freedesktop.org/~agd5f/linux/log/?h=amd-staging-drm-next-sienna_cichlid

Thanks!

Alex

Alex Deucher (2):
  drm/amdgpu/mes10.1: add no scheduler flag for mes
  drm/amdgpu/vcn3.0: schedule instance 0 for decode and 1 for encode

Bhawanpreet Lakha (28):
  drm/amd/display: Add DCN3 chip ids
  drm/amd/display: Add DCN3 DIO
  drm/amd/display: Add DCN3 CLK_MGR
  drm/amd/display: Add DCN3 DCCG
  drm/amd/display: Add DCN3 OPTC
  drm/amd/display: Add DCN3 OPP header
  drm/amd/display: Add DCN3 MPC
  drm/amd/display: Add DCN3 DPP
  drm/amd/display: Add DCN3 HUBHUB
  drm/amd/display: Add DCN3 HUBP
  drm/amd/display: Add DCN3 MMHUBHUB
  drm/amd/display: Add DCN3 DWB
  drm/amd/display: Add DCN3 DML
  drm/amd/display: Add DCN3 IRQ
  drm/amd/display: Add DCN3 GPIO
  drm/amd/display: Add DCN3 DMUB
  drm/amd/display: Add DCN3 HWSEQ
  drm/amd/display: Add DCN3 Support in DM (v2)
  drm/amd/display: Add DCN3 Resource
  drm/amd/display: Add DCN3 Command Table Helpers
  drm/amd/display: Add DCN3 AFMT
  drm/amd/display: Add DCN3 VPG
  drm/amd/display: Init function tables for DCN3
  drm/amd/display: Handle RGBE_ALPHA Pixel Format
  drm/amd/display: Remove Unused Registers
  drm/amdgpu: Enable DM block for DCN3
  drm/amd/display: Add DCN3 blocks to Makefile
  drm/amd/display: Add DCN3 to Kconfig

Boyuan Zhang (11):
  drm/amdgpu: add clock gating DPG mode for VCN3.0
  drm/amdgpu: add mc resume DPG mode for VCN3.0
  drm/amdgpu: add start DPG mode for VCN3.0
  drm/amdgpu: add stop DPG mode for VCN3.0
  drm/amdgpu: add pause DPG mode for VCN3.0
  drm/amdgpu: set indirect sram mode for VCN3.0
  drm/amdgpu: add internal reg offset translation for VCN inst 1
  drm/amdgpu: rename macro for VCN1.0
  drm/amdgpu: rename macro for VCN2.0 2.5 and 3.0
  drm/amdgpu: add workaround for issue in DPG for VCN3.0
  drm/amdgpu: enable DPG mode for VCN3.0

Dmytro Laktyushkin (1):
  drm/amd/display: fix and simplify pipe split logic for DCN3

Evan Quan (1):
  drm/amd/powerplay: let PMFW to handle the features disablement on BACO
    in V2

Hawking Zhang (7):
  drm/amdgpu: force pa_sc_tile_steering_override to 0 for gfx10.3
  drm/amdgpu: add vram_info v2_5 in atomfirmware header
  drm/amdgpu: support query vram info for sienna_cichlid
  drm/amdgpu: drop gfx_v10_0_tiling_mode_table_init
  drm/amdgpu: add firmware_info v3_4 structure for Sienna_Cichlid
  drm/amdgpu: add atomfirmware helper funciton to query reserved fb size
  drm/amdgpu: switch to query reserved fb size from vbios (v3)

Hersen Wu (1):
  sound/pci/hda: add sienna_cichlid audio asic id for sienna_cichlid up

Jack Xiao (25):
  drm/amdgpu: assign the doorbell index to mes ring
  drm/amdgpu: add the ring type definition of MES
  drm/amdgpu: avoid dereferencing a NULL pointer
  drm/amdgpu/mes: update some mes definitions
  drm/amdgpu/mes10.1: allocate the eop buffer
  drm/amdgpu/mes10.1: initialize the software part of mes ring
  drm/amdgpu/mes10.1: implement the ring functions of mes specific
  drm/amdgpu/mes10.1: allocate mqd buffer
  drm/amdgpu/mes10.1: initialize the mqd
  drm/amdgpu/mes10.1: install mes queue by register programming
  drm/amdgpu/mes10.1: install mes queue via kiq
  drm/amdgpu/mes10.1: enable the mes ring during initialization
  drm/amdgpu/mes10.1: add the mes fw api
  drm/amdgpu/mes10.1: add the helper function for mes command submission
  drm/amdgpu/mes10.1: implement adding hardware queue
  drm/amdgpu/mes10.1: implement removing hardware queue
  drm/amdgpu/mes10.1: implement querying the scheduler status
  drm/amdgpu/mes10.1: implement setting hardware resources
  drm/amdgpu/mes10.1: add sienna_cichlid mes firmware support
  drm/amdgpu/mes10.1: copy mes fw info into global fw array
  drm/amdgpu: upload mes firmware to gpu buffer
  drm/amdgpu/psp: convert amdgpu mes ucode type
  drm/amdgpu: no need to set up GPU scheduler for mes ring
  drm/amdgpu/mes10.1: update mes initialization
  drm/amdgpu: add mes block to sienna_cichlid

James Zhu (1):
  drm/amdgpu: fix typo for vcn3/jpeg3 idle check

Jay Cornwall (3):
  drm/amdkfd: Add Sienna_Cichlid trap handler support
  drm/amdkfd: Support newer assemblers in gfx10 trap handler
  drm/amdkfd: Support debugger in Navi1x trap handler

Jerry (Fangzhi) Zuo (2):
  drm/amd/display: Add dcn30 Headers (v2)
  drm/amdgpu/dc: Add missing Sienna_Cichlid chip id

Kenneth Feng (10):
  drm/amd/amdgpu: fix the HDP LS/DS/SD programming
  drm/amd/amdgpu: add HDP mgcg and ls support
  drm/amd/amdgpu: add IH cg support
  drm/amd/amdgpu: add athub ls support
  drm/amd/powerplay: enable athub pg
  drm/amd/powerplay: enable mmhub pg
  drm/amd/powerplay: enable GPO
  drm/amd/powerplay: bundle GPO with gfx DPM
  drm/amd/powerplay: enable fw ctf
  drm/amd/powerplay: show gfxclk=0 in gfxoff state

Le Ma (4):
  drm/amdgpu/mes: update mes fw api
  drm/amdgpu/mes: add status fence memory definitions
  drm/amdgpu/mes: allocate memory slots for hw resource setting
  drm/amdgpu: skip VM inv eng assignment for mes ring

Leo Liu (14):
  drm/amdgpu: add VCN3.0 register headers (v2)
  drm/amdgpu: add 2rd VCN instance doorbell support
  drm/amdgpu: add VCN3.0 support for Sienna_Cichlid
  drm/amdgpu: add Sienna_Cichlid VCN PG and CG support (v2)
  drm/amdgpu: enable VCN3.0 PG and CG for Sienna_Cichlid
  drm/amdgpu: add Sienna_Cichlid VCN to the VCN family
  drm/amdgpu: enable VCN3.0 for Sienna_Cichlid
  drm/amdgpu: add JPEG3.0 support for Sienna_Cichlid
  drm/amdgpu: add Sienna_Cichlid JPEG PG and CG support
  drm/amdgpu: enable JPEG3.0 PG and CG for Sienna_Cichlid
  drm/amdgpu: enable JPEG3.0 for Sienna_Cichlid
  drm/amdgpu: change the offset for VCN FW cache window
  drm/amdgpu: fix the PSP front door loading VCN firmware
  drm/amdgpu: set the LMI ctrl and reset earlier

Likun Gao (90):
  drm/amdgpu: add GC 10.3 header files (v2)
  drm/amdgpu: add sienna_cichlid asic type
  drm/amdgpu: add sienna_cichlid gpu info firmware v2
  drm/amdgpu: set fw load type for sienna_cichlid
  drm/amdgpu: set asic family and ip blocks for sienna_cichlid
  drm/amdgpu/gfx10: add support for sienna_cichlid firmware
  drm/amdgpu/gmc10: add sienna_cichlid support
  drm/amdgpu/gfx10: add clockgating support for sienna_cichlid
  drm/amdgpu/soc15: add support for sienna_cichlid
  drm/amdgpu: initialize IP offset for sienna_cichlid (v2)
  drm/amdgpu/soc15: add common ip block for sienna_cichlid
  drm/amdgpu: add support on mmhub for sienna_cichlid
  drm/amdgpu: add support gfxhub for sienna_cichlid (v3)
  drm/amdgpu: add gmc ip block for sienna_cichlid
  drm/amdgpu: add ih ip block for sienna_cichlid
  drm/amdgpu: add gfx ip block for sienna_cichlid (v3)
  drm/amdgpu: add sdma2 and sdma3 irqsrc header files for sienna_cichlid
    (v2)
  drm/amdgpu: add sdma ip block for sienna_cichlid (v5)
  drm/amdgpu: correct SDMA3 IH clinet id for sienna_cichlid
  drm/amdgpu/gfx10: change register configure for sienna_cichlid
  drm/amdgpu: add virtual display support for sienna_cichlid
  drm/amdgpu/powerplay: add initial swSMU support for sienna_cichlid
    (v2)
  drm/amd/powerplay: add support to set performance level for
    sienna_cichlid
  drm/amd/powerplay: set SOCCLK DPM for sienna_cichlid
  drm/amd/powerplay: set FCLK DPM for sienna_cichlid
  drm/amd/powerplay: enable Ultra Low Voltage for sienna_cichlid
  drm/amd/powerplay: enable Graphics Clock Deep Sleep for sienna_cichlid
  drm/amd/powerplay: enable SOC Clock Deep Sleep for sienna_cichlid
  drm/amdgpu/powerplay: set Thermal control for sienna_cichlid
  drm/amdgpu/powerplay: set UCLK DPM for sienna_cichlid
  drm/amd/powerplay: make gfx ds can be configure for sienna_cichlid
  drm/amd/powerplay: Enable SOCCLK ULV for sienna_cichlid
  drm/amd/powerplay: enable DCEFCLK DPM and DS for sienna_cichlid
  drm/amd/powerplay: support pcie value set and update for
    sienna_cichlid
  drm/amd/powerplay: support to print pcie levels for sienna_cichlid
  drm/amd/powerplay: enable LCLK DPM for sienna_cichlid
  drm/amd/powerplay: enable GFX SS for sienna_cichlid
  drm/amd/powerplay: enable Fan control for sienna_cichlid
  drm/amd/powerplay: support to get power index for sienna_cichlid
  drm/amd/powerplay: enable PPT and TDC for sienna_cichlid
  drm/amdgpu/powerplay: add smu block for sienna_cichlid
  drm/amdgpu: skip ASD fw load for sienna_cichlid
  drm/amdgpu/psp: add psp support for sienna_cichlid
  drm/amdgpu: skip for reroute ih for sienna_cichlid psp ring init
    currently
  drm/amdgpu: enable psp ip block for sienna_cichlid
  drm/amdgpu: update SDMA 5.2 microcode init
  drm/amdgpu: add support for athub v2.1
  drm/amdgpu: add gmc cg support for sienna_cichlid
  drm/amdgpu: add psp block load condition for sienna_cichlid
  drm/amdgpu: update the num of queue per pipe for mec on sienna_cichlid
  drm/amdgpu/mes: correct register offset for sienna_cichlid
  drm/amdgpu/gfx10: add gc golden setting for sienna_cichlid
  drm/amdgpu: add cp firmware backdoor loading triger
  drm/amdgpu: disable gfxoff for sienna_cichlid
  drm/amdgpu: only send one sdma firmware for sienna_cichlid
  drm/amdgpu: open GFX clock gating for sienna_cichlid
  drm/amdgpu: update golden setting for gfx10.3
  drm/amdgpu: Enable Multi Media Hub (MMHUB) Clock Gating for
    sienna_cichlid.
  drm/amdgpu: fix SDMA hdp flush engine conflict
  drm/amdgpu: enable 3D pipe 1 on Sienna_Cichlid
  drm/amd/powerplay: enable VR0HOT for sienna_cichlid
  drm/amd/powerplay: enable FCLK DS for sienna_cichlid
  drm/amd/powerplay: enable MM DPM PG for sienna_cichlid (v2)
  drm/amd/powerplay: enable BACO for sienna_cichlid
  drm/amd/powerplay: enable APCC DFLL for sienna_cichlid
  drm/amd/powerplay: add function to get power limit for sienna_cichlid
  drm/amdgpu: update golden setting for sienna_cichlid
  drm/amd/powerplay: enable RSMU SMN PG for sienna_cichlid
  drm/am/powerplay: enable OUT OF BAND MONITER for sienna_cichlid
  drm/amd/powerplay: enable ULCK DS for sienna_cichlid
  drm/amd/powerplay: and smc dpm info struct for sienna_cichlid
  drm/amd/powerplay: append pptable for sienna_cichlid (v2)
  drm/amd/powerplay: enable VDDCI and MVDD for sienna_cichlid
  drm/amdgpu: skip GPU scheduler setup for KIQ and MES ring
  drm/amdgpu: disable runtime pm for sienna_cichlid temporarily
  drm/amd/powerplay: drop jpeg instance1 dpm setup
  drm/amdgpu: only use one gfx pipe for Sienna_Cichlid
  drm/amd/powerplay: support mclk socclk limit value set for
    sienna_cichlid.
  drm/amd/amdgpu: disable gfxoff to retrieve gfxclk
  drm/amdgpu: enable gfxoff for sienna_cichlid
  drm/amdgpu/psp: add structure to support PSP SPL
  drm/amdgpu/psp: initialization PSP SPL fw
  drm/amdgpu/psp: support for loading PSP SPL fw
  drm/amdgpu: update golden setting for sienna_cichlid
  drm/amd/powerplay: update smu function for sienna_cichlid
  drm/amd/powerplay: drop sienna_cichlid hardcode of using pptable
  drm/amdgpu: reserve fb according to return value from vbios
  drm/amdgpu: support memory training for sienna_cichlid
  drm/amdgpu: remove unnecessary check for mem train
  drm/amdgpu: bypass tmr when reserve c2p memory

Yong Zhao (3):
  drm/amdgpu: Add ATHUB 2.1 header files (v2)
  drm/amdgpu: Use variable instead of constant for sdma doorbell range
  drm/amdkfd: Support Sienna_Cichlid KFD v4

shaoyunl (4):
  drm/amdkfd: sienna_cichlid virtual function support
  drm/amdgpu: Sienna_Cichlid don't enable SMU for SRIOV
  drm/amdgpu/sriov : Use kiq to do tlb invalidation for gfx10 on sriov
  drm/amdgpu/sriov : Add sriov detection for sienna_cichlid

 drivers/gpu/drm/amd/amdgpu/Makefile           |    27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |     4 -
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   834 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |     5 -
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |    79 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |    24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |    45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |    39 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |     6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   113 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |    39 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |     9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |     8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |    25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |     1 +
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c       |   100 +
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.h       |    30 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   513 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |   375 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h      |    37 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |    81 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   613 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.h        |    29 +
 drivers/gpu/drm/amd/amdgpu/mes_api_def.h      |   443 +
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        |   664 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c       |    72 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |    21 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c        |    14 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |    62 +-
 drivers/gpu/drm/amd/amdgpu/nv.h               |     1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |    52 +-
 drivers/gpu/drm/amd/amdgpu/sdma_common.h      |    42 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |     1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.h        |    15 -
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  1753 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.h        |    30 +
 .../drm/amd/amdgpu/sienna_cichlid_reg_init.c  |    54 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |    96 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |    86 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |    94 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  1689 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h         |    29 +
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    |   877 +-
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |   301 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |    25 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |     1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |     1 +
 drivers/gpu/drm/amd/display/Kconfig           |     8 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    27 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    20 +
 drivers/gpu/drm/amd/display/dc/Makefile       |     4 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |     3 +
 .../display/dc/bios/command_table_helper2.c   |     5 +
 .../dce112/command_table_helper2_dce112.c     |    40 +
 .../dce112/command_table_helper2_dce112.h     |     3 +
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |     7 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |    10 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |    22 +
 .../drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h |    60 +
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   543 +
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.h  |    38 +
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  |   255 +
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h  |   108 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    88 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |    14 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    36 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |    37 +
 drivers/gpu/drm/amd/display/dc/dc.h           |    59 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    75 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    15 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    34 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |    20 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |   153 +-
 .../drm/amd/display/dc/dce/dce_clock_source.h |    42 +
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |    46 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |    12 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |     5 +
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |     6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |    10 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |    62 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |    42 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |    22 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  |    17 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h  |    12 -
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   |     9 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |    20 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h |    41 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |    85 +
 .../amd/display/dc/dcn20/dcn20_link_encoder.h |     7 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |    39 +
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |    54 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c |   206 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_afmt.h |   230 +
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |   640 +
 .../amd/display/dc/dcn30/dcn30_cm_common.h    |    78 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c |   100 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h |    66 +
 .../display/dc/dcn30/dcn30_dio_link_encoder.c |   205 +
 .../display/dc/dcn30/dcn30_dio_link_encoder.h |    76 +
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   851 +
 .../dc/dcn30/dcn30_dio_stream_encoder.h       |   269 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  |  1414 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  |   608 +
 .../drm/amd/display/dc/dcn30/dcn30_dpp_cm.c   |   410 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c  |   264 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h  |   923 +
 .../drm/amd/display/dc/dcn30/dcn30_dwb_cm.c   |   354 +
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.c   |   417 +
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.h   |   119 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |   532 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h |   292 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   714 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |    70 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   148 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.h |    33 +
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.c |   239 +
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.h |   463 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  1409 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  |   665 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_opp.h  |    36 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   365 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |   333 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  2671 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |    82 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c  |   194 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h  |   133 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |    23 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |     7 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |  6860 ++
 .../dc/dml/dcn30/display_mode_vba_30.h        |    43 +
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |  1868 +
 .../dc/dml/dcn30/display_rq_dlg_calc_30.h     |    69 +
 .../drm/amd/display/dc/dml/display_mode_lib.c |   181 +
 .../drm/amd/display/dc/dml/display_mode_lib.h |    11 +
 .../amd/display/dc/dml/display_mode_structs.h |     3 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |     3 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |     3 +
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |    10 +
 .../display/dc/gpio/dcn30/hw_factory_dcn30.c  |   257 +
 .../display/dc/gpio/dcn30/hw_factory_dcn30.h  |    33 +
 .../dc/gpio/dcn30/hw_translate_dcn30.c        |   387 +
 .../dc/gpio/dcn30/hw_translate_dcn30.h        |    35 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |     9 +-
 .../drm/amd/display/dc/gpio/hw_translate.c    |     8 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    25 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |    69 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |    14 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |     6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |     7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |    83 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |     4 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |     9 +
 .../gpu/drm/amd/display/dc/inc/hw/mcif_wb.h   |     8 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   108 +
 .../amd/display/dc/inc/hw/stream_encoder.h    |     4 +
 .../amd/display/dc/inc/hw/timing_generator.h  |    19 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |     4 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |     3 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |    10 +
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |   384 +
 .../display/dc/irq/dcn30/irq_service_dcn30.h  |    37 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |     3 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |     3 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |   184 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.h |    50 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |    15 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |     4 +
 .../gpu/drm/amd/display/include/dal_types.h   |     1 +
 .../asic_reg/athub/athub_2_1_0_offset.h       |   523 +
 .../asic_reg/athub/athub_2_1_0_sh_mask.h      |  2378 +
 .../include/asic_reg/dcn/dcn_3_0_0_offset.h   | 17880 ++++
 .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  | 70929 ++++++++++++++++
 .../include/asic_reg/dcn/dpcs_3_0_0_offset.h  |   573 +
 .../include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h |  3565 +
 .../include/asic_reg/gc/gc_10_3_0_default.h   |  7272 ++
 .../include/asic_reg/gc/gc_10_3_0_offset.h    | 13469 +++
 .../include/asic_reg/gc/gc_10_3_0_sh_mask.h   | 47692 +++++++++++
 .../include/asic_reg/vcn/vcn_3_0_0_offset.h   |  1542 +
 .../include/asic_reg/vcn/vcn_3_0_0_sh_mask.h  |  5496 ++
 drivers/gpu/drm/amd/include/atomfirmware.h    |   283 +
 .../include/ivsrcid/sdma2/irqsrcs_sdma2_5_0.h |    45 +
 .../include/ivsrcid/sdma3/irqsrcs_sdma3_5_0.h |    45 +
 .../amd/include/sienna_cichlid_ip_offset.h    |  1168 +
 .../gpu/drm/amd/include/soc15_ih_clientid.h   |     1 +
 drivers/gpu/drm/amd/powerplay/Makefile        |     2 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |    34 +-
 .../inc/smu11_driver_if_sienna_cichlid.h      |  1209 +
 drivers/gpu/drm/amd/powerplay/inc/smu_types.h |     4 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |     1 +
 .../drm/amd/powerplay/inc/smu_v11_0_7_ppsmc.h |   139 +
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  2506 +
 .../drm/amd/powerplay/sienna_cichlid_ppt.h    |    37 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |    13 +
 include/drm/amd_asic_type.h                   |     1 +
 sound/pci/hda/hda_intel.c                     |     3 +
 205 files changed, 214201 insertions(+), 792 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v2_1.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_api_def.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_common.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sienna_cichlid_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_opp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/athub/athub_2_1_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/athub/athub_2_1_0_sh_mask.h
 create mode 100755 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
 create mode 100755 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
 create mode 100755 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
 create mode 100755 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_3_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_3_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/sdma2/irqsrcs_sdma2_5_0.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/sdma3/irqsrcs_sdma3_5_0.h
 create mode 100644 drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_7_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h

-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
