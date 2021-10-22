Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4687AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 04:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061186103E
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 04:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 061186103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AADC89F0B;
	Fri, 22 Oct 2021 04:22:34 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FBA689F0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 04:22:33 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id s9so3547330oiw.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 21:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DfchsFfAgCLqMG/QGSg4JB4v01Iyv+sov17IA3nYLfU=;
 b=kzRymC+iDs4FRGpMptT5svQWDerU6BAv59sIVMWzQXM/HR6IN1tPFhgu0kzmtM5u3h
 ecgEdE7GBHKZ08QLiUdTMD2BTx6Mmvn/WF+rhzk/4CvgezwfsghNa8XvFO/Ad+Fotl8R
 LrfuSWCdap7uUcYBbDJCRPAFSTA5D1NC68lxlOl40njy2FCHt4R8pqyRzPBcYmluVYmI
 NRo1Ck/1Kv98FsZnxotRouscNZsvUyzdpemZnBZ/O8fJ3OjOa6q4Rgodv6KEaUo0qabu
 VzQdH9LkpwSMqCKZEIx8bAI/LVn1NWO4NDgkoOWqQ4GexJDwR8omk0zvKoGBKaJxtbMM
 m72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DfchsFfAgCLqMG/QGSg4JB4v01Iyv+sov17IA3nYLfU=;
 b=yIKml5XxNn/HuATA/UipyKm95s6d4dhEZ9H/h6H/p6JTd2krEKl3wcDLvSaEqfBFYK
 aXG+K/L8zV0VwC6OnBrwS4l4eJe4jJZXZldsZHzBdOq82tea1FJdhXR5+wh1rE/eJcFN
 AU2QToUe98Du0hgFwywtxRnMXdsDbzH1MXI+e1PYhRAdGfgvraP99WzVMNLWokv6VqXS
 Dmp61lfrsBOJ9foBKh19IPmeBfXs28asVG+z7eMkRzPdl+1F47kCVoTKaTzXZK3nokF0
 /HYIk6RV4squimpx4cSpEY/sbKRrSe1ENFDdl/u0yq1Ka82mKGKtXgCnKjJdC0bnYKkO
 fyIQ==
X-Gm-Message-State: AOAM533odeB3hJrsot1QK3rpFN8vuB02aD/gsCtdc3RMYt3SniFB+R2c
 nXbAW3UfQfx4SthVdywbmvjkcjaFXyu/mdL4OCFGPopidi8=
X-Google-Smtp-Source: ABdhPJw0rTTUXZ7re1Oz5Xu3jYkjzqYD2cdUCOKi4fjBuzJmORa56TD/dy7jPhZWskeZMRBxnnk5TPRAsugFRIw2pmU=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr7832257oia.5.1634876551878; 
 Thu, 21 Oct 2021 21:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211008161021.1922011-1-alexander.deucher@amd.com>
 <DM5PR12MB2469BFD61964E0CF258F64E5F1809@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469BFD61964E0CF258F64E5F1809@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Oct 2021 00:22:20 -0400
Message-ID: <CADnq5_N=+2=BxiEJbyPbWROw5bn1zvssa-pQgYnvXjckEW3BLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/nbio7.4: don't use GPU_HDP_FLUSH bit 12
To: "Chen, Guchun" <Guchun.Chen@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Oct 21, 2021 at 11:53 PM Chen, Guchun <Guchun.Chen@amd.com> wrote:
>
> [Public]
>
> This patch caused ring test of SDMA failure on Vega20.

Fix sent out.  Sorry for the breakage.

Alex

>
> Oct 12 00:18:24 vega20-ebd-11 kernel: [   11.900968] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.007480] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.007482] AMD-Vi: AMD IOMMUv2 functionality not available on this system
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069082] [drm] amdgpu kernel modesetting enabled.
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069226] amdgpu: CRAT table not found
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069229] amdgpu: Virtual CRAT table created for CPU
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069288] amdgpu: Topology: Add CPU node
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069415] checking generic (90000000 300000) vs hw (90000000 10000000)
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069416] fb0: switching to amdgpudrmfb from EFI VGA
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069700] Console: switching to colour dummy device 80x25
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069755] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070047] amdgpu 0000:03:00.0: enabling device (0006 -> 0007)
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070241] [drm] initializing kernel modesetting (VEGA20 0x1002:0x66A1 0x1002:0x081E 0x06).
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070244] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070257] [drm] register mmio base: 0xA0300000
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070258] [drm] register mmio size: 524288
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070263] [drm] add ip block number 0 <soc15_common>
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070264] [drm] add ip block number 1 <gmc_v9_0>
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070265] [drm] add ip block number 2 <vega20_ih>
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070266] [drm] add ip block number 3 <psp>
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070266] [drm] add ip block number 4 <powerplay>
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070267] [drm] add ip block number 5 <dm>
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070267] [drm] add ip block number 6 <gfx_v9_0>
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070268] [drm] add ip block number 7 <sdma_v4_0>
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070269] [drm] add ip block number 8 <uvd_v7_0>
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070269] [drm] add ip block number 9 <vce_v4_0>
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070286] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070293] amdgpu: ATOM BIOS: 113-D1640600-103
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072517] [drm] UVD(0) is enabled in VM mode
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072519] [drm] UVD(1) is enabled in VM mode
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072520] [drm] UVD(0) ENC is enabled in VM mode
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072520] [drm] UVD(1) ENC is enabled in VM mode
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072521] [drm] VCE enabled in VM mode
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072632] amdgpu 0000:03:00.0: amdgpu: MEM ECC is active.
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072633] amdgpu 0000:03:00.0: amdgpu: SRAM ECC is not presented.
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072651] amdgpu 0000:03:00.0: amdgpu: RAS INFO: ras initialized successfully, hardware ability[105] ras_mask[105]
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072657] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072668] amdgpu 0000:03:00.0: amdgpu: VRAM: 16368M 0x0000008000000000 - 0x00000083FEFFFFFF (16368M used)
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072669] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072676] amdgpu 0000:03:00.0: amdgpu: AGP: 267894784M 0x0000008400000000 - 0x0000FFFFFFFFFFFF
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072683] [drm] Detected VRAM RAM=16368M, BAR=256M
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072684] [drm] RAM width 4096bits HBM
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072736] [drm] amdgpu: 16368M of VRAM memory ready
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072738] [drm] amdgpu: 16368M of GTT memory ready.
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072745] [drm] GART: num cpu pages 131072, num gpu pages 131072
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072819] [drm] PCIE GART of 512M enabled.
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072820] [drm] PTB located at 0x0000008000300000
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.075598] amdgpu 0000:03:00.0: amdgpu: PSP runtime database doesn't exist
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.075605] amdgpu: hwmgr_sw_init smu backed is vega20_smu
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.083924] [drm] Found UVD firmware ENC: 1.2 DEC: .43 Family ID: 19
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.083956] [drm] PSP loading UVD firmware
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.085826] [drm] Found VCE firmware Version: 57.6 Binary ID: 4
> Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.085837] [drm] PSP loading VCE firmware
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.254187] [drm] reserve 0x400000 from 0x83fec00000 for PSP TMR
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.336956] amdgpu 0000:03:00.0: amdgpu: HDCP: optional hdcp ta ucode is not available
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.336964] amdgpu 0000:03:00.0: amdgpu: DTM: optional dtm ta ucode is not available
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.336967] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.336970] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.340605] [drm] Display Core initialized with v3.2.156!
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.356874] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.404543] [drm] kiq ring mec 2 pipe 1 q 0
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.446720] [drm] UVD and UVD ENC initialized successfully.
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.645505] [drm] VCE initialized successfully.
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.651286] [drm] TX was terminated, IC_TX_ABRT_SOURCE val is:1000001
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.651289] [drm:smu_v11_0_i2c_xfer [amdgpu]] *ERROR* Received I2C_NAK_7B_ADDR_NOACK !!!
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.651460] [drm:smu_v11_0_i2c_xfer [amdgpu]] *ERROR* WriteI2CData() - I2C error occurred :1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.651641] [drm:amdgpu_ras_eeprom_init [amdgpu]] *ERROR* Failed to read EEPROM table header, res:-5
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.651789] amdgpu 0000:03:00.0: amdgpu: Failed to initialize ras recovery! (-5)
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.652729] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.729075] memmap_init_zone_device initialised 4194304 pages in 40ms
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.729082] amdgpu: HMM registered 16368MB device memory
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.729266] amdgpu: SRAT table not found
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.729267] amdgpu: Virtual CRAT table created for GPU
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730290] amdgpu: Topology: Add dGPU node [0x66a1:0x1002]
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730294] kfd kfd: amdgpu: added device 1002:66a1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730313] amdgpu 0000:03:00.0: amdgpu: SE 4, SH per SE 1, CU per SH 16, active_cu_number 60
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730951] amdgpu 0000:03:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730953] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730955] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730956] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730957] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730958] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730959] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730960] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730961] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730962] amdgpu 0000:03:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730963] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730964] amdgpu 0000:03:00.0: amdgpu: ring page0 uses VM inv eng 1 on hub 1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730965] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 4 on hub 1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730966] amdgpu 0000:03:00.0: amdgpu: ring page1 uses VM inv eng 5 on hub 1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730967] amdgpu 0000:03:00.0: amdgpu: ring uvd_0 uses VM inv eng 6 on hub 1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730968] amdgpu 0000:03:00.0: amdgpu: ring uvd_enc_0.0 uses VM inv eng 7 on hub 1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730969] amdgpu 0000:03:00.0: amdgpu: ring uvd_enc_0.1 uses VM inv eng 8 on hub 1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730970] amdgpu 0000:03:00.0: amdgpu: ring uvd_1 uses VM inv eng 9 on hub 1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730972] amdgpu 0000:03:00.0: amdgpu: ring uvd_enc_1.0 uses VM inv eng 10 on hub 1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730973] amdgpu 0000:03:00.0: amdgpu: ring uvd_enc_1.1 uses VM inv eng 11 on hub 1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730974] amdgpu 0000:03:00.0: amdgpu: ring vce0 uses VM inv eng 12 on hub 1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730975] amdgpu 0000:03:00.0: amdgpu: ring vce1 uses VM inv eng 13 on hub 1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730976] amdgpu 0000:03:00.0: amdgpu: ring vce2 uses VM inv eng 14 on hub 1
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.742823] amdgpu: Detected AMDGPU DF Counters. # of Counters = 8.
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.742901] amdgpu: Detected AMDGPU 2 Perf Events.
> Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.745583] [drm] Initialized amdgpu 3.44.0 20150101 for 0000:03:00.0 on minor 0
> Oct 12 00:18:41 vega20-ebd-11 kernel: [   28.755954] amdgpu 0000:03:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on sdma0 (-110).
> Oct 12 00:18:42 vega20-ebd-11 kernel: [   29.779951] amdgpu 0000:03:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on page0 (-110).
> Oct 12 00:18:43 vega20-ebd-11 kernel: [   30.803948] amdgpu 0000:03:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on sdma1 (-110).
> Oct 12 00:18:44 vega20-ebd-11 kernel: [   31.827955] amdgpu 0000:03:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on page1 (-110).
> Oct 12 00:18:44 vega20-ebd-11 kernel: [   31.931041] [drm:amdgpu_device_delayed_init_work_handler [amdgpu]] *ERROR* ib ring test failed (-110).
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Saturday, October 9, 2021 12:10 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu/nbio7.4: don't use GPU_HDP_FLUSH bit 12
>
> It's used internally by firmware.  Using it in the driver could conflict with firmware.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 91b3afa946f5..3b7775d74bb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -56,12 +56,15 @@
>   * These are nbio v7_4_1 registers mask. Temporarily define these here since
>   * nbio v7_4_1 header is incomplete.
>   */
> -#define GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK     0x00001000L
> +#define GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK     0x00001000L /* Don't use.  Firmware uses this bit internally */
>  #define GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK     0x00002000L
>  #define GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK     0x00004000L
>  #define GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK     0x00008000L
>  #define GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK     0x00010000L
>  #define GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK     0x00020000L
> +#define GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK     0x00040000L
> +#define GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK     0x00080000L
> +#define GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK     0x00100000L
>
>  #define mmBIF_MMSCH1_DOORBELL_RANGE                     0x01dc
>  #define mmBIF_MMSCH1_DOORBELL_RANGE_BASE_IDX            2
> @@ -332,14 +335,14 @@ const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg = {
>         .ref_and_mask_cp7 = GPU_HDP_FLUSH_DONE__CP7_MASK,
>         .ref_and_mask_cp8 = GPU_HDP_FLUSH_DONE__CP8_MASK,
>         .ref_and_mask_cp9 = GPU_HDP_FLUSH_DONE__CP9_MASK,
> -       .ref_and_mask_sdma0 = GPU_HDP_FLUSH_DONE__SDMA0_MASK,
> -       .ref_and_mask_sdma1 = GPU_HDP_FLUSH_DONE__SDMA1_MASK,
> -       .ref_and_mask_sdma2 = GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK,
> -       .ref_and_mask_sdma3 = GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK,
> -       .ref_and_mask_sdma4 = GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK,
> -       .ref_and_mask_sdma5 = GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK,
> -       .ref_and_mask_sdma6 = GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK,
> -       .ref_and_mask_sdma7 = GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
> +       .ref_and_mask_sdma0 = GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK,
> +       .ref_and_mask_sdma1 = GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK,
> +       .ref_and_mask_sdma2 = GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK,
> +       .ref_and_mask_sdma3 = GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK,
> +       .ref_and_mask_sdma4 = GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
> +       .ref_and_mask_sdma5 = GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK,
> +       .ref_and_mask_sdma6 = GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK,
> +       .ref_and_mask_sdma7 = GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK,
>  };
>
>  static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
> --
> 2.31.1
