Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC3DC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Apr 2022 14:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336FF10E274;
	Sun, 10 Apr 2022 14:45:59 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E1D810E274
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Apr 2022 14:45:57 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 a17-20020a9d3e11000000b005cb483c500dso9605022otd.6
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Apr 2022 07:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=DysugT3WtR06atlxi8eSAY/eRGPtJzAcz05hEd8SIGA=;
 b=Gp69AadrkzstQek99+Qqj/tbTYjNJtOij65/gQTKkRx5u4wHgoKI4hlo328vLIpRRa
 QbUWbZEJbnn3weLwRQd4zNKm9/EqNNPu7CPx8zu0lbwqLpNonH+KBcvNo61dGygIw4rf
 dHA/tijCF8QBSYshrtoa1U6j8KA29ULoKhUEA6ZAAug9OHEWUnVWIzd57QdL6Pau110N
 V//VnnE9rCgNEsBAVYZHyj26voUAzBRr+KbA5quvTNJrYmUUpNwf5HGJILRJTyX32pw5
 8pMKPe0dZaEmrtDIv2CukKElL4p46BQmpQiF2dMDJm07V/rfESzpAEHxNCE9VpQBsfRH
 cwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=DysugT3WtR06atlxi8eSAY/eRGPtJzAcz05hEd8SIGA=;
 b=dYd4n27/dOnJuVsq7bWib196J0w6/k1dXRRqyu8HWGOskpoz1M3430UZOi1vHHB7iK
 XqgYuF0zP7SzU7oZgYO7Xx7AJoX9Y2gRIcmTmNcyK2fT3FCeq5qVuBbJD/L6TeZYXGPs
 4qUyKS95g3PXpV+9/a51lYW5DvY/h42ukP2JciBQiGNu594n4nVjsO07NAsXZID5fhnB
 +I2206bIqnBdxyTwGtQH8q8bh3hdFOP2wImp+/rg8KjLg1Z98TvkhFcB6atAS768UY+0
 nEZAUY4xloF+/cdEHydAn1iK4Q3ZMJPk9dc4tyzVpzx6gWeP006Y6cJSaa+uf/tN5Pa3
 iFQA==
X-Gm-Message-State: AOAM530NMsQhAr2rWDdZlRUpFAKx7ilN70QkzVYGNpGBzIYEx54Oot46
 qSGOSjdV4R1dDTqAJUwyPZo8g/BkIyBjKCJqqIYnGZsT8sJ+PnSg
X-Google-Smtp-Source: ABdhPJxf4jMX9PZTxGu/Okg94QqCICIqreEvUqpCc0uuGngq0ACo7BTf6R0QmMvFdBVYFK/WwUap65Ucsh9Ag9VLGjs=
X-Received: by 2002:a9d:6f08:0:b0:5b2:26c4:22b2 with SMTP id
 n8-20020a9d6f08000000b005b226c422b2mr9962233otq.294.1649601955949; Sun, 10
 Apr 2022 07:45:55 -0700 (PDT)
MIME-Version: 1.0
From: Innocenti Maresin <innocenti.maresin@gmail.com>
Date: Sun, 10 Apr 2022 17:45:43 +0300
Message-ID: <CANvdy75mC5N9FKU8=z8akZ=Vonmnj6WKGE+JsoazbK2ebtgixA@mail.gmail.com>
Subject: =?UTF-8?Q?Lenovo_Cezanne_=E2=80=94_some_ip_blocks_fail_on_both_amdgp?=
 =?UTF-8?Q?u=5Fdevice=5Fip=5Fhw=5Finit=5Fphase1_and_amdgpu=5Fdevice=5Fip=5Fhw=5Finit=5Fphas?=
 =?UTF-8?Q?e2?=
To: amd-gfx@lists.freedesktop.org
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

Hello.
Sorry to distract the developers for a private busyness, but it=E2=80=99s a
non-trivial diagnostic problem. I bought a laptop where the GPU is
probably faulty or badly misconfigured (note =E2=80=9C[drm] BIOS signature
incorrect cc cc=E2=80=9D and the next message about memory ranges) but inde=
ed
present. All attempts to use either of two Linux drivers (see
https://linux-hardware.org/?id=3Dcpu:amd-25-80-0-ryzen-7-5800u-with-radeon-=
graphics&hwid=3Da26ef811f12f
) failed. Of course, it doesn=E2=80=99t prove anything conclusively, and AM=
D
virtually turned me around
(https://community.amd.com/t5/graphics/tools-to-check-for-malfunction-of-ry=
zen-s-gpu/m-p/519397
). But I am reluctant to complain to the manufacturer (namely, Lenovo)
until expend all possibilities to make the stuff work.

The recent attempt to run (modprobe) the open amdgpu driver with
linux-5.16.18 produced:
[ 1234.755272] AMD-Vi: AMD IOMMUv2 loaded and initialized
[ 1234.884288] [drm] amdgpu kernel modesetting enabled.
[ 1234.885947] device class 'kfd': registering
[ 1234.885973] device: 'kfd': device_add
[ 1234.885984] PM: Adding info for No Bus:kfd
[ 1234.886032] amdgpu: Virtual CRAT table created for CPU
[ 1234.886039] amdgpu: Topology: Add CPU node
[ 1234.886506] bus: 'pci': add driver amdgpu
[ 1234.886527] bus: 'pci': __driver_probe_device: matched device
0000:04:00.0 with driver amdgpu
[ 1234.886531] bus: 'pci': really_probe: probing driver amdgpu with
device 0000:04:00.0
[ 1234.886535] amdgpu 0000:04:00.0: no default pinctrl state
[ 1234.886545] checking generic (b0000000 13d0000) vs hw (b0000000 10000000=
)
[ 1234.886547] checking generic (b0000000 13d0000) vs hw (b0000000 10000000=
)
[ 1234.886548] fb0: switching to amdgpu from VESA VGA
[ 1234.886551] device: 'fb0': device_unregister
[ 1234.886598] PM: Removing info for No Bus:fb0
[ 1234.886607] device: 'fb0': device_create_release
[ 1234.886740] Console: switching to colour dummy device 160x64
[ 1234.886757] device: 'vtcon1': device_unregister
[ 1234.886766] PM: Removing info for No Bus:vtcon1
[ 1234.886774] device: 'vtcon1': device_create_release
[ 1234.886782] amdgpu 0000:04:00.0: vgaarb: deactivate vga console
[ 1234.886899] [drm] initializing kernel modesetting (RENOIR
0x1002:0x1638 0x17AA:0x3809 0xC1).
[ 1234.886901] amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone (TMZ)
feature enabled
[ 1234.886939] [drm] register mmio base: 0xC0700000
[ 1234.886940] [drm] register mmio size: 524288
[ 1234.888465] [drm] add ip block number 0 <soc15_common>
[ 1234.888466] [drm] add ip block number 1 <gmc_v9_0>
[ 1234.888467] [drm] add ip block number 2 <vega10_ih>
[ 1234.888468] [drm] add ip block number 3 <psp>
[ 1234.888468] [drm] add ip block number 4 <smu>
[ 1234.888469] [drm] add ip block number 5 <dm>
[ 1234.888470] [drm] add ip block number 6 <gfx_v9_0>
[ 1234.888470] [drm] add ip block number 7 <sdma_v4_0>
[ 1234.888471] [drm] add ip block number 8 <vcn_v2_0>
[ 1234.888471] [drm] add ip block number 9 <jpeg_v2_0>
[ 1234.896313] [drm] BIOS signature incorrect cc cc
[ 1234.896319] resource sanity check: requesting [mem
0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [mem
0x000c0000-0x000cbfff window]
[ 1234.896322] caller pci_map_rom+0x73/0x1c0 mapping multiple BARs
[ 1234.898188] amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from ROM BAR
[ 1234.898189] amdgpu: ATOM BIOS: 113-CEZANNE-X18
[ 1234.905717] [drm] VCN decode is enabled in VM mode
[ 1234.905719] [drm] VCN encode is enabled in VM mode
[ 1234.905720] [drm] JPEG decode is enabled in VM mode
[ 1234.905722] amdgpu 0000:04:00.0: amdgpu: PCIE atomic ops is not supporte=
d
[ 1234.905748] [drm] vm size is 262144 GB, 4 levels, block size is
9-bit, fragment size is 9-bit
[ 1234.905754] amdgpu 0000:04:00.0: amdgpu: VRAM: 2048M
0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
[ 1234.905756] amdgpu 0000:04:00.0: amdgpu: GART: 1024M
0x0000000000000000 - 0x000000003FFFFFFF
[ 1234.905758] amdgpu 0000:04:00.0: amdgpu: AGP: 267419648M
0x000000F800000000 - 0x0000FFFFFFFFFFFF
[ 1234.905764] [drm] Detected VRAM RAM=3D2048M, BAR=3D2048M
[ 1234.905765] [drm] RAM width 128bits DDR4
[ 1234.905822] [drm] amdgpu: 2048M of VRAM memory ready
[ 1234.905824] [drm] amdgpu: 3072M of GTT memory ready.
[ 1234.905828] [drm] GART: num cpu pages 262144, num gpu pages 262144
[ 1234.905961] [drm] PCIE GART of 1024M enabled.
[ 1234.905964] [drm] PTB located at 0x000000F4013C7000
[ 1234.906471] amdgpu 0000:04:00.0: amdgpu: PSP runtime database doesn't ex=
ist
[ 1234.906956] [drm] Loading DMUB firmware via PSP: version=3D0x01010020
[ 1234.909652] [drm] Found VCN firmware Version ENC: 1.16 DEC: 5 VEP:
0 Revision: 3
[ 1234.909660] amdgpu 0000:04:00.0: amdgpu: Will use PSP to load VCN firmwa=
re
[ 1234.910507] [drm] hw_init (phase1) succeeded for 2 IP blocks of 10,
going forth...
[ 1235.633664] [drm] reserve 0x400000 from 0xf47f800000 for PSP TMR
[ 1235.643014] [drm] failed to load ucode SDMA0(0x0)
[ 1235.643019] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
response status is (0xF)
[ 1235.643234] [drm] failed to load ucode CP_CE(0x8)
[ 1235.643236] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
response status is (0xF)
[ 1235.643450] [drm] failed to load ucode CP_PFP(0x9)
[ 1235.643451] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
response status is (0xF)
[ 1235.643706] [drm] failed to load ucode CP_ME(0xA)
[ 1235.643709] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
response status is (0xF)
[ 1235.643924] [drm] failed to load ucode CP_MEC1(0xB)
[ 1235.643925] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
response status is (0xF)
[ 1235.644141] [drm] failed to load ucode CP_MEC1_JT(0xC)
[ 1235.644143] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
response status is (0xF)
[ 1235.644356] [drm] failed to load ucode RLC_RESTORE_LIST_CNTL(0x11)
[ 1235.644358] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
response status is (0xF)
[ 1235.644596] [drm] failed to load ucode RLC_RESTORE_LIST_GPM_MEM(0x12)
[ 1235.644598] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
response status is (0xF)
[ 1235.644811] [drm] failed to load ucode RLC_RESTORE_LIST_SRM_MEM(0x13)
[ 1235.644813] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
response status is (0xF)
[ 1235.645027] [drm] failed to load ucode RLC_G(0x16)
[ 1235.645029] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
response status is (0xF)
[ 1235.645243] [drm] failed to load ucode VCN(0x1C)
[ 1235.645245] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
response status is (0xF)
[ 1235.645458] [drm] failed to load ucode DMCUB(0x22)
[ 1235.645460] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
response status is (0xF)
[ 1235.645926] [drm] psp gfx command LOAD_ASD(0x4) failed and response
status is (0xF)
[ 1235.645928] amdgpu 0000:04:00.0: amdgpu: RAS: optional ras ta ucode
is not available
[ 1235.646175] [drm] psp gfx command LOAD_TA(0x1) failed and response
status is (0xF)
[ 1235.646416] [drm] psp gfx command LOAD_TA(0x1) failed and response
status is (0xF)
[ 1235.646419] amdgpu 0000:04:00.0: amdgpu: RAP: optional rap ta ucode
is not available
[ 1235.646420] amdgpu 0000:04:00.0: amdgpu: SECUREDISPLAY:
securedisplay ta ucode is not available
[ 1235.652585] amdgpu 0000:04:00.0: amdgpu: SMU is initialized successfully=
!
[ 1235.652825] [drm] Display Core initialized with v3.2.160!
[ 1235.758565] [drm] Wait for DMUB auto-load failed: 3
[ 1235.758567] [drm] DMUB hardware initialized: version=3D0x01010020
[ 1235.970912] [drm:dc_dmub_srv_wait_idle [amdgpu]] *ERROR* Error
waiting for DMUB idle: status=3D3
[ 1235.971495] amdgpu 0000:04:00.0: adding component (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[ 1235.971674] device: 'i2c-3': device_add
=E2=8B=AE
[ 1236.118414] device: 'i2c-6': device_add
[ 1236.118415] bus: 'i2c': add device i2c-6
[ 1236.118417] PM: Adding info for i2c:i2c-6
[ 1236.119861] [drm] kiq ring mec 2 pipe 1 q 0
[ 1236.314252] amdgpu 0000:04:00.0: [drm:amdgpu_ring_test_helper
[amdgpu]] *ERROR* ring kiq_2.1.0 test failed (-110)
[ 1236.314379] [drm:amdgpu_gfx_enable_kcq.cold [amdgpu]] *ERROR* KCQ
enable failed
[ 1236.314536] [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* hw_init
(phase2) of IP block <gfx_v9_0> failed -110
[ 1236.471837] amdgpu 0000:04:00.0: [drm:amdgpu_ring_test_helper
[amdgpu]] *ERROR* ring sdma0 test failed (-110)
[ 1236.471954] [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* hw_init
(phase2) of IP block <sdma_v4_0> failed -110
[ 1236.472444] [drm] failed to load ucode VCN0_RAM(0x20)
[ 1236.472448] [drm] psp gfx command LOAD_IP_FW(0x6) failed and
response status is (0xFFFF0007)
[ 1236.667574] amdgpu 0000:04:00.0: [drm:amdgpu_ring_test_helper
[amdgpu]] *ERROR* ring vcn_dec test failed (-110)
[ 1236.667693] [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* hw_init
(phase2) of IP block <vcn_v2_0> failed -110
[ 1236.867093] amdgpu 0000:04:00.0: [drm:amdgpu_ring_test_helper
[amdgpu]] *ERROR* ring jpeg_dec test failed (-110)
[ 1236.867205] [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* hw_init
(phase2) of IP block <jpeg_v2_0> failed -110
[ 1236.867349] [drm] hw_init (phase2) succeeded for 2 IP blocks of 10,
going forth...
[ 1236.868093] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[ 1236.868196] amdgpu: Virtual CRAT table created for GPU
[ 1236.868867] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
[ 1236.868868] kfd kfd: amdgpu: added device 1002:1638
[ 1236.868874] amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 1, CU per
SH 8, active_cu_number 8
[ 1236.868891] amdgpu 0000:04:00.0: amdgpu: couldn't schedule ib on ring <s=
dma0>
[ 1236.868894] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (=
-22)
[ 1236.870867] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to
clear memory with ring turned off.
[ 1236.870948] amdgpu: failed to allocate framebuffer (20738048)
[ 1236.870950] [drm:amdgpufb_create [amdgpu]] *ERROR* failed to create
fbcon object -12
[ 1236.871025] device: 'hwmon6': device_add
[ 1236.871036] PM: Adding info for No Bus:hwmon6
[ 1236.871104] amdgpu 0000:04:00.0: amdgpu: ring gfx uses VM inv eng 0 on h=
ub 0
[ 1236.871105] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM
inv eng 1 on hub 0
[ 1236.871106] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM
inv eng 4 on hub 0
[ 1236.871107] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM
inv eng 5 on hub 0
[ 1236.871107] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM
inv eng 6 on hub 0
[ 1236.871108] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM
inv eng 7 on hub 0
[ 1236.871108] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM
inv eng 8 on hub 0
[ 1236.871109] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM
inv eng 9 on hub 0
[ 1236.871110] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM
inv eng 10 on hub 0
[ 1236.871110] amdgpu 0000:04:00.0: amdgpu: ring kiq_2.1.0 uses VM inv
eng 11 on hub 0
[ 1236.871111] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng
0 on hub 1
[ 1236.871112] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec uses VM inv
eng 1 on hub 1
[ 1236.871112] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 uses VM inv
eng 4 on h[ 1236.871112] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec
uses VM inv eng 1 on hub 1
[ 1236.871112] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 uses VM inv
eng 4 on hub 1
[ 1236.871113] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 uses VM inv
eng 5 on hub 1
[ 1236.871114] amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses VM inv
eng 6 on hub 1
[ 1237.070116] [drm:dc_dmub_srv_wait_idle [amdgpu]] *ERROR* Error
waiting for DMUB idle: status=3D3
[ 1237.070377] device: 'renderD128': device_add
[ 1237.070382] PM: Adding info for No Bus:renderD128
[ 1237.070419] device: 'card0': device_add
[ 1237.070422] PM: Adding info for No Bus:card0
[ 1237.070433] device: 'card0-eDP-1': device_add
[ 1237.070438] PM: Adding info for No Bus:card0-eDP-1
[ 1237.070442] device: 'i2c-7': device_add
[ 1237.070444] bus: 'i2c': add device i2c-7
[ 1237.070446] PM: Adding info for i2c:i2c-7
[ 1237.070454] device: 'card0-HDMI-A-1': device_add
[ 1237.070458] PM: Adding info for No Bus:card0-HDMI-A-1
[ 1237.070467] device: 'card0-DP-1': device_add
[ 1237.070472] PM: Adding info for No Bus:card0-DP-1
[ 1237.070475] device: 'i2c-8': device_add
[ 1237.070476] bus: 'i2c': add device i2c-8
[ 1237.070481] PM: Adding info for i2c:i2c-8
[ 1237.070491] device: 'card0-DP-2': device_add
[ 1237.070494] PM: Adding info for No Bus:card0-DP-2
[ 1237.070496] device: 'i2c-9': device_add
[ 1237.070497] bus: 'i2c': add device i2c-9
[ 1237.070499] PM: Adding info for i2c:i2c-9
[ 1237.070504] [drm] Initialized amdgpu 3.44.0 20150101 for
0000:04:00.0 on minor 0
[ 1237.070509] driver: 'amdgpu': driver_bound: bound to device '0000:04:00.=
0'
[ 1237.070517] bus: 'pci': really_probe: bound device 0000:04:00.0 to
driver amdgpu
[ 1237.672369] [drm] Register(0) [mmUVD_POWER_STATUS] failed to reach
value 0x00000001 !=3D 0x00000002
[ 1237.867388] [drm] Register(0) [mmUVD_RBC_RB_RPTR] failed to reach
value 0x00000010 !=3D 0x00000000
[ 1238.062366] [drm] Register(0) [mmUVD_POWER_STATUS] failed to reach
value 0x00000001 !=3D 0x00000002
[ 1240.100668] amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests
[amdgpu]] *ERROR* IB test failed on gfx (-110).
[ 1240.100808] [drm:process_one_work] *ERROR* ib ring test failed (-110).

Note that I modified the open driver enabling it to go through certain
failures and also made certain diag messages less ambiguous (see
http://course.irccity.ru/amdgpu_device.c ). You also can see the full
transcript at https://linux-hardware.org/?probe=3Dce0316a106&log=3Ddmesg
although, unfortunately, it is spammed with an unrelated OS problem.

How can one check whether is this GPU able to do its job? At the end I
made the driver to create all the /dev/dri/ stuff, but yet unsure what
to do next because the video system produces no image with it. Should
I run the AMD tools from gpuopen.com? Or try vulkaninfo(1) when =E2=80=9Cmy=
=E2=80=9D
amdgpu is active? Do more kernel debugging? Update the BIOS? Note that
I shouldn=E2=80=99t eventually compromise my standing as a wronged customer
with bold changes in the computer.

Regards,
--Incnis Mrsi
