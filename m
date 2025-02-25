Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9FCC021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 08:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F28CD10E5CB;
	Tue, 25 Feb 2025 08:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=tkos.co.il header.i=@tkos.co.il header.b="rT7+IIND";
	dkim-atps=neutral
Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB8B510E130
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:18:10 +0000 (UTC)
Received: from localhost (unknown [10.0.8.3])
 by mail.tkos.co.il (Postfix) with ESMTP id 94EAC440A74;
 Tue, 25 Feb 2025 08:12:28 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
 s=default; t=1740463948;
 bh=jIe8X1sJXTn9/E7XQ6cGdpiMKttyh7BAXk83u44A2X8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=rT7+IINDB+iE5MhybnJax6ofQ5UNu4hDSiPmdPM+ThmUEDMf/rW30y664YmBR+Rqa
 VOS8SuoHEMpHLHwLOTA53mUImT/9yDTLkdpYAUcIww1T/xxzib1BxHeQsHMSAZSZZ8
 tBL77tEzrllrQ13qHnKmz7zow1PnAkXdwdgNGfNV0NsS/5zHZscTPRLlKSsw4izkqD
 0WkrdLMhY6LAx9hXp/O+beY1Cj2RqqjgfXvBshuhkZrwvL6IhG4SbmsWZv4LYPCKkv
 CBP647JW2wvAtjis3xz4CDy8jx27a3Axd0H+U5DBsWNzdaqxVgCboVupF1otTFczgF
 p59jK7wOzjmxQ==
From: Baruch Siach <baruch@tkos.co.il>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [drm:amdgpu_ring_test_helper] *ERROR* ring kiq_0.2.1.0 test
 failed (-110)
In-Reply-To: <CADnq5_P+_iGePpp9c1Sr85-z7fgWxq1iejpHxuyVO_G5nW8kYw@mail.gmail.com>
 (Alex Deucher's message of "Mon, 24 Feb 2025 09:05:56 -0500")
References: <87seo3ga1t.fsf@tarshish>
 <CADnq5_P+_iGePpp9c1Sr85-z7fgWxq1iejpHxuyVO_G5nW8kYw@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 25 Feb 2025 08:18:03 +0200
Message-ID: <875xkyfsys.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 25 Feb 2025 08:56:44 +0000
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

Hi Alex,

Thanks for your prompt response.

On Mon, Feb 24 2025, Alex Deucher wrote:
> On Mon, Feb 24, 2025 at 8:51=E2=80=AFAM Baruch Siach <baruch@tkos.co.il> =
wrote:
>> I see this failure on probe when trying to bring up amdgpu on a new arm64
>> platform.  Kernel is v6.14-rc4, and aldebaran firmware is latest
>> (linux-firmware commit 4f47e84d06f9).
>>
>> Tested with these kernel command line parameters:
>>
>> amdgpu.vm_size=3D1 amdgpu.msi=3D1 amdgpu.gartsize=3D32 amdgpu.vramlimit=
=3D32 amdgpu.gttsize=3D32
>
> Why are you setting those?  Does the driver load ok if you do not
> specify those driver options?

Driver probe fails the same way with or without these options. These
options were meant to fit the driver into limited address space.

>> I guess the "CP firmware version" warning is bogus. IP version for GC_HW=
IP is
>> 9.4.2.
>>
>> Any idea?
>
> Potentially the driver parameters combination is causing a problem, or
> your ARM SoC may not be PCIe compliant.  A lot of small SoC's just
> throw a PCIe bridge on the SoC without proper coherency in place
> between the CPU and the PCIe bus.  PCIe requires cohorency with the
> CPU (i.e., the device can snoop the CPU's cache).

I'll take a look into PCIe coherency in this SoC.

Thanks for the hint.

baruch

>> Relevant log snippets follows:
>>
>> [    1.792949] pci 0000:05:00.0: [1002:740f] type 00 class 0x038000 PCIe=
 Endpoint
>> [    1.800652] pci 0000:05:00.0: BAR 0 [mem 0x00000000-0xfffffffff 64bit=
 pref]
>> [    1.807629] pci 0000:05:00.0: BAR 2 [mem 0x00000000-0x001fffff 64bit =
pref]
>> [    1.814506] pci 0000:05:00.0: BAR 4 [io  0x0000-0x00ff]
>> [    1.819729] pci 0000:05:00.0: BAR 5 [mem 0x00000000-0x0007ffff]
>> [    1.825647] pci 0000:05:00.0: ROM [mem 0x00000000-0x0001ffff pref]
>> [    1.833297] pci 0000:05:00.0: PME# supported from D1 D2 D3hot D3cold
>> [    1.840118] pci 0000:05:00.0: 126.024 Gb/s available PCIe bandwidth, =
limited by 16.0 GT/s PCIe x8 link at 0000:02:00.0 (capable of 252.048 Gb/s =
with 16.0 GT/s PCIe x16 link)
>> [    1.857150] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to =
05
>> ...
>> [    2.615336] pci 0000:05:00.0: BAR 0 [mem 0x1000000000-0x1fffffffff 64=
bit pref]: assigned
>> [    2.623529] pci 0000:05:00.0: BAR 2 [mem 0x2000000000-0x20001fffff 64=
bit pref]: assigned
>> [    2.631720] pci 0000:05:00.0: BAR 5 [mem 0x5d000000-0x5d07ffff]: assi=
gned
>> [    2.638544] pci 0000:05:00.0: ROM [mem 0x5d080000-0x5d09ffff pref]: a=
ssigned
>> [    2.645583] pci 0000:05:00.0: BAR 4 [io  size 0x0100]: can't assign; =
no space
>> [    2.652707] pci 0000:05:00.0: BAR 4 [io  size 0x0100]: failed to assi=
gn
>> ...
>> [    3.153154] amdgpu 0000:05:00.0: enabling device (0000 -> 0002)
>> [    3.159112] [drm] initializing kernel modesetting (ALDEBARAN 0x1002:0=
x740F 0x1002:0x0C34 0x02).
>> [    3.167817] [drm] register mmio base: 0x5D000000
>> [    3.172425] [drm] register mmio size: 524288
>> [    3.176775] amdgpu 0000:05:00.0: amdgpu: detected ip block number 0 <=
soc15_common>
>> [    3.184341] amdgpu 0000:05:00.0: amdgpu: detected ip block number 1 <=
gmc_v9_0>
>> [    3.191558] amdgpu 0000:05:00.0: amdgpu: detected ip block number 2 <=
vega20_ih>
>> [    3.198858] amdgpu 0000:05:00.0: amdgpu: detected ip block number 3 <=
psp>
>> [    3.205639] amdgpu 0000:05:00.0: amdgpu: detected ip block number 4 <=
smu>
>> [    3.212421] amdgpu 0000:05:00.0: amdgpu: detected ip block number 5 <=
gfx_v9_0>
>> [    3.219635] amdgpu 0000:05:00.0: amdgpu: detected ip block number 6 <=
sdma_v4_0>
>> [    3.226935] amdgpu 0000:05:00.0: amdgpu: detected ip block number 7 <=
vcn_v2_6>
>> [    3.234149] amdgpu 0000:05:00.0: amdgpu: detected ip block number 8 <=
jpeg_v2_6>
>> [    3.247351] amdgpu 0000:05:00.0: amdgpu: Fetched VBIOS from ROM BAR
>> [    3.253626] amdgpu: ATOM BIOS: 113-D67301V-073
>> [    3.259731] [drm] CP firmware version too old, please update!
>> [    3.260400] amdgpu 0000:05:00.0: amdgpu: Trusted Memory Zone (TMZ) fe=
ature not supported
>> [    3.274294] amdgpu 0000:05:00.0: amdgpu: PCIE atomic ops is not suppo=
rted
>> [    3.281115] amdgpu 0000:05:00.0: amdgpu: MEM ECC is active.
>> [    3.286679] amdgpu 0000:05:00.0: amdgpu: SRAM ECC is active.
>> [    3.292351] amdgpu 0000:05:00.0: amdgpu: RAS INFO: ras initialized su=
ccessfully, hardware ability[7ff7f] ras_mask[7ff7f]
>> [    3.303232] [drm] vm size is 1 GB, 2 levels, block size is 9-bit, fra=
gment size is 9-bit
>> [    3.311338] amdgpu 0000:05:00.0: amdgpu: VRAM: 65520M 0x0000020000000=
000 - 0x0000020FFEFFFFFF (32M used)
>> [    3.320811] amdgpu 0000:05:00.0: amdgpu: GART: 32M 0x0000000000000000=
 - 0x0000000001FFFFFF
>> [    3.329070] [drm] Detected VRAM RAM=3D65520M, BAR=3D65536M
>> [    3.334199] [drm] RAM width 4096bits HBM
>> [    3.338251] [drm] amdgpu: 32M of VRAM memory ready
>> [    3.343039] [drm] amdgpu: 32M of GTT memory ready.
>> [    3.347861] [drm] GART: num cpu pages 8192, num gpu pages 8192
>> [    3.353779] [drm] PCIE GART of 32M enabled.
>> [    3.357955] [drm] PTB located at 0x0000020001FF0000
>> [    3.365901] [drm] Found VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 R=
evision: 28
>> [    3.432199] amdgpu 0000:05:00.0: amdgpu: reserve 0x800000 from 0x2000=
1000000 for PSP TMR
>> [    3.504497] amdgpu 0000:05:00.0: amdgpu: smu driver if version =3D 0x=
00000008, smu fw if version =3D 0x00000009, smu fw program =3D 0, smu fw ve=
rsion =3D 0x00443f00 (68.63.0)
>> [    3.519356] amdgpu 0000:05:00.0: amdgpu: SMU driver if version not ma=
tched
>> [    3.526265] amdgpu 0000:05:00.0: amdgpu: use vbios provided pptable
>> [    3.532523] amdgpu 0000:05:00.0: amdgpu: smc_dpm_info table revision(=
format.content): 4.10
>> [    3.560964] amdgpu 0000:05:00.0: amdgpu: SMU is initialized successfu=
lly!
>> [    3.568167] [drm] kiq ring mec 2 pipe 1 q 0
>> [    3.785160] amdgpu 0000:05:00.0: [drm:amdgpu_ring_test_helper] *ERROR=
* ring kiq_0.2.1.0 test failed (-110)
>> [    3.794825] [drm:amdgpu_gfx_enable_kcq] *ERROR* KCQ enable failed
>> [    3.800929] [drm:amdgpu_device_init] *ERROR* hw_init of IP block <gfx=
_v9_0> failed -110
>> [    3.808929] amdgpu 0000:05:00.0: amdgpu: amdgpu_device_ip_init failed
>> [    3.815361] amdgpu 0000:05:00.0: amdgpu: Fatal error during GPU init
>> [    3.821705] amdgpu 0000:05:00.0: amdgpu: amdgpu: finishing device.
>>
>> Thanks,
>> baruch
>>
>> --
>>                                                      ~. .~   Tk Open Sys=
tems
>> =3D}------------------------------------------------ooO--U--Ooo---------=
---{=3D
>>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
