Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8D1C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Apr 2022 12:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 739E810EF6A;
	Mon,  4 Apr 2022 12:06:54 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD87410EF6A
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Apr 2022 12:06:52 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7094161E6478B;
 Mon,  4 Apr 2022 14:06:50 +0200 (CEST)
Message-ID: <9e689fea-6c69-f4b0-8dee-32c4cf7d8f9c@molgen.mpg.de>
Date: Mon, 4 Apr 2022 14:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Regression: No signal when loading amdgpu, and system lockup (was:
 [PATCH V4 17/17] drm/amd/pm: unified lock protections in amdgpu_dpm.c)
Content-Language: en-US
To: Arthur Marsh <arthur.marsh@internode.on.net>
References: <20211203030540.1710564-17-evan.quan@amd.com>
 <20220331022805.17236-1-amarsh04@internode.on.net>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220331022805.17236-1-amarsh04@internode.on.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: regressions@lists.linux.dev, lijo.lazar@amd.com,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, evan.quan@amd.com,
 kenneth.feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

#regzbot introduced: 3712e7a494596b26861f4dc9b81676d1d0272eaf
#regzbot title: No signal when loading amdgpu, and system lockup
#regzbot monitor: https://gitlab.freedesktop.org/drm/amd/-/issues/1957

Dear Arthur,


Thank you for your message. Too bad you didn’t update the subject, and 
didn’t include regressions@lists.linux.dev and notify regzbot [1] about 
it. (It’s understandable, as you might be unfamiliar with the processes, 
but I would have expected at least Even to do.) So I also spent quite 
some time on bisecting, but reached the same conclusion.

Am 31.03.22 um 04:28 schrieb Arthur Marsh:
> Hi, I have a Cape Verde GPU card in my pc and after git bisecting a situation
> where, at the time of the amdgpu module, the monitor would lose signal and
> the pc locked up so that it only responded to a magic sysreq boot (with no
> logging due to it happening before the root filesystem was writeable), the
> above commit was identified as the culprit.
> 
> The GPU card is a Gigabyte R7 250 with pci-id 1002:682b (rev 87).
> 
> With the 5.17.0 kernel and a kernel command line of:
> 
> amdgpu.audio=1 amdgpu.si_support=1
> 
> the following dmesg output was received:
> 
> [   76.118991] [drm] amdgpu kernel modesetting enabled.
> [   76.119100] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
> [   76.120004] Console: switching to colour dummy device 80x25
> [   76.120203] [drm] initializing kernel modesetting (VERDE 0x1002:0x682B 0x1458:0x22CA 0x87).
> [   76.120211] amdgpu 0000:01:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
> [   76.120235] [drm] register mmio base: 0xFE8C0000
> [   76.120238] [drm] register mmio size: 262144
> [   76.120245] [drm] add ip block number 0 <si_common>
> [   76.120248] [drm] add ip block number 1 <gmc_v6_0>
> [   76.120251] [drm] add ip block number 2 <si_ih>
> [   76.120253] [drm] add ip block number 3 <gfx_v6_0>
> [   76.120256] [drm] add ip block number 4 <si_dma>
> [   76.120258] [drm] add ip block number 5 <si_dpm>
> [   76.120261] [drm] add ip block number 6 <dce_v6_0>
> [   76.120264] [drm] add ip block number 7 <uvd_v3_1>
> [   76.163659] [drm] BIOS signature incorrect 5b 7
> [   76.163669] resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [mem 0x000d0000-0x000dffff window]
> [   76.163677] caller pci_map_rom+0x68/0x1b0 mapping multiple BARs
> [   76.163691] amdgpu 0000:01:00.0: No more image in the PCI ROM
> [   76.164996] amdgpu 0000:01:00.0: amdgpu: Fetched VBIOS from ROM BAR
> [   76.165001] amdgpu: ATOM BIOS: xxx-xxx-xxx
> [   76.165018] amdgpu 0000:01:00.0: amdgpu: PCIE atomic ops is not supported
> [   76.165270] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
> [   76.349679] amdgpu 0000:01:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
> [   76.349716] amdgpu 0000:01:00.0: amdgpu: GART: 1024M 0x000000FF00000000 - 0x000000FF3FFFFFFF
> [   76.349753] [drm] Detected VRAM RAM=2048M, BAR=256M
> [   76.349764] [drm] RAM width 128bits DDR3
> [   76.349940] [drm] amdgpu: 2048M of VRAM memory ready
> [   76.349953] [drm] amdgpu: 3072M of GTT memory ready.
> [   76.349992] [drm] GART: num cpu pages 262144, num gpu pages 262144
> [   76.350506] amdgpu 0000:01:00.0: amdgpu: PCIE GART of 1024M enabled (table at 0x000000F400900000).
> [   76.495343] [drm] Internal thermal controller with fan control
> [   76.495391] [drm] amdgpu: dpm initialized
> [   76.495637] [drm] AMDGPU Display Connectors
> [   76.495647] [drm] Connector 0:
> [   76.495655] [drm]   HDMI-A-1
> [   76.495662] [drm]   HPD1
> [   76.495668] [drm]   DDC: 0x194c 0x194c 0x194d 0x194d 0x194e 0x194e 0x194f 0x194f
> [   76.495685] [drm]   Encoders:
> [   76.495691] [drm]     DFP1: INTERNAL_UNIPHY
> [   76.495699] [drm] Connector 1:
> [   76.495706] [drm]   DVI-D-1
> [   76.495712] [drm]   HPD2
> [   76.495718] [drm]   DDC: 0x1950 0x1950 0x1951 0x1951 0x1952 0x1952 0x1953 0x1953
> [   76.495733] [drm]   Encoders:
> [   76.495739] [drm]     DFP2: INTERNAL_UNIPHY
> [   76.495746] [drm] Connector 2:
> [   76.495753] [drm]   VGA-1
> [   76.495758] [drm]   DDC: 0x1970 0x1970 0x1971 0x1971 0x1972 0x1972 0x1973 0x1973
> [   76.495773] [drm]   Encoders:
> [   76.495779] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> [   76.599604] [drm] Found UVD firmware Version: 64.0 Family ID: 13
> [   76.603443] [drm] PCIE gen 2 link speeds already enabled
> [   77.149564] [drm] UVD initialized successfully.
> [   77.149578] amdgpu 0000:01:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 5, active_cu_number 8
> [   77.456492] RTL8211B Gigabit Ethernet r8169-0-300:00: attached PHY driver (mii_bus:phy_addr=r8169-0-300:00, irq=MAC)
> [   77.486245] [drm] Initialized amdgpu 3.44.0 20150101 for 0000:01:00.0 on minor 0
> [   77.521555] r8169 0000:03:00.0 eth0: Link is Down
> [   77.547158] fbcon: amdgpudrmfb (fb0) is primary device
> [   77.591226] Console: switching to colour frame buffer device 240x67
> [   77.600296] amdgpu 0000:01:00.0: [drm] fb0: amdgpudrmfb frame buffer device
> 
> I can supply extra details but found no logging from the sessions that experienced the lock-up.

I had created issue *Worker [210] processing SEQNUM=2120 is taking a 
long time* on March 28th, 2022 [1]. Most annoying thing was, that the 
system locked up, and SSH didn’t work and Dell’s firmware (and all other 
x86 vendor firmware not based on coreboot) is so slow. Also, it was only 
reproducible with a powered-on monitor attached.


Kind regards,

Paul


[1]: https://linux-regtracking.leemhuis.info/regzbot/
[2]: https://gitlab.freedesktop.org/drm/amd/-/issues/1957
