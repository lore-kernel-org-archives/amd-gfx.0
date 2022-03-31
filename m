Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30109C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 07:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE6F810FD0B;
	Thu, 31 Mar 2022 07:47:39 +0000 (UTC)
X-Greylist: delayed 837 seconds by postgrey-1.36 at gabe;
 Thu, 31 Mar 2022 02:49:01 UTC
Received: from ipmail04.adl3.internode.on.net (ipmail04.adl3.internode.on.net
 [150.101.137.10])
 by gabe.freedesktop.org (Postfix) with ESMTP id A61A910F3C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 02:49:00 +0000 (UTC)
X-SMTP-MATCH: 1
IronPort-Data: =?us-ascii?q?A9a23=3AJfskDqtJoty+CFqEOCk3YODT0OfnVCVfMUV32?=
 =?us-ascii?q?f8akzHdYApBsoF/qtZmKW2OPa2LYjb9e9snbo/j9UkOvMTVm4M3TlY9pSs8F?=
 =?us-ascii?q?ikU88CfX9nEcR+vZSjNIp3IRRM74Z8TN4ebc8w+ECDR9h6EP+m6pxGQ94nRF?=
 =?us-ascii?q?uKmUrKs1gOd5ONcpZRIZStLw4bVv6Yx6TSHK1PV0T/Ni5W31G+Ng1aYA0pMg?=
 =?us-ascii?q?06xgEoHUMfa4Fv0imcDicVj5zcyoZW04KU3fsldJ1OgKmVd83XTq+zrlNlV9?=
 =?us-ascii?q?UuBl/sh50/Mr1r1TqEKaua60QliZJZUc/H70l4Y/3R0iPd9baFEAatUo2zhc?=
 =?us-ascii?q?9RZwc9RtYGqDwIgJLbMsOUbTxRCFSZyMOtB/vnBLGTXXcm7lROdLSSzmqQ+Z?=
 =?us-ascii?q?K0xFdZAobYtWzAmGeYjADkIYlWMifKexLOgVvIqiN4uIcXmJ4ADvWkmyivWZ?=
 =?us-ascii?q?d4rX5nFBbzX7Nlw1TI8wMtJGJ72Ts4UeTNpYBnaJTFCJ1wXBYgWleKkwHL4d?=
 =?us-ascii?q?lVwi1+To6cr4y79wQp++LHoPJzefdnibc5VhEeDumPP+SL6BRwcNdO3wD+Jt?=
 =?us-ascii?q?Hmrg4fnmSL5X8QWHa+x7NZjhVHVzWsWYCD6/3Ov+az80xb4A8YGfhRSoj50+?=
 =?us-ascii?q?PB0pRPwFc2mCkX+/Wrb6yYWX84JS7hirFmZokbPyx6BHjFdHnsbMYRj7p5zH?=
 =?us-ascii?q?GdykFaFm5bgCTcqtLqTDHiH/6zP9HWuISdTLGkeaDUCSgcIpd7l5oc+knryo?=
 =?us-ascii?q?h9YOPbdprXI9fvYmW3a8EDSX4kusPM=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AdkJ8Ra4LAnCzWyVnDgPXwN/XdLJyesId70?=
 =?us-ascii?q?hD6qm+c3Bom6uj5qSTdZsguyMc5Ax6ZJhko6HiBEDiewK4yXcK2+gs1N6ZNW?=
 =?us-ascii?q?GMhILrFvAB0WKI+VLd8kPFm9K1rZ0BT5RD?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BOBADpEUViAIId0nZSCIESgVGML44?=
 =?us-ascii?q?4kEaMIoF8CwFUBAEBhQcChFgmNgcOAQYVAQEGAgEBAQcEEAE5UoV1hkMGMgF?=
 =?us-ascii?q?GEFFXgx2zHIEBiBeBZYp3hUaBVUSBS4MyhB6GJphdJQ4ED1JsSwQCJQpfgRG?=
 =?us-ascii?q?RdQabU5IzNAeDTIE7BgyeD02oTC2TXIJUoUMHDRtKhjQOggAzGi6DfyicbxS?=
 =?us-ascii?q?BMgmRYAEB?=
Received: from ppp118-210-29-130.adl-adc-lon-bras31.tpg.internode.on.net (HELO
 localhost) ([118.210.29.130])
 by ipmail04.adl3.internode.on.net with ESMTP; 31 Mar 2022 12:58:07 +1030
Received: from amarsh04 by localhost with local (Exim 4.95)
 (envelope-from <arthur.marsh@internode.on.net>) id 1nZkXd-0004U8-BM;
 Thu, 31 Mar 2022 12:58:05 +1030
From: Arthur Marsh <arthur.marsh@internode.on.net>
To: evan.quan@amd.com
Subject: [PATCH V4 17/17] drm/amd/pm: unified lock protections in amdgpu_dpm.c
Date: Thu, 31 Mar 2022 12:58:05 +1030
Message-Id: <20220331022805.17236-1-amarsh04@internode.on.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20211203030540.1710564-17-evan.quan@amd.com>
References: <20211203030540.1710564-17-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Mar 2022 07:47:38 +0000
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, I have a Cape Verde GPU card in my pc and after git bisecting a situation 
where, at the time of the amdgpu module, the monitor would lose signal and
the pc locked up so that it only responded to a magic sysreq boot (with no
logging due to it happening before the root filesystem was writeable), the
above commit was identified as the culprit.

The GPU card is a Gigabyte R7 250 with pci-id 1002:682b (rev 87).

With the 5.17.0 kernel and a kernel command line of:

amdgpu.audio=1 amdgpu.si_support=1

the following dmesg output was received:

[   76.118991] [drm] amdgpu kernel modesetting enabled.
[   76.119100] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
[   76.120004] Console: switching to colour dummy device 80x25
[   76.120203] [drm] initializing kernel modesetting (VERDE 0x1002:0x682B 0x1458:0x22CA 0x87).
[   76.120211] amdgpu 0000:01:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
[   76.120235] [drm] register mmio base: 0xFE8C0000
[   76.120238] [drm] register mmio size: 262144
[   76.120245] [drm] add ip block number 0 <si_common>
[   76.120248] [drm] add ip block number 1 <gmc_v6_0>
[   76.120251] [drm] add ip block number 2 <si_ih>
[   76.120253] [drm] add ip block number 3 <gfx_v6_0>
[   76.120256] [drm] add ip block number 4 <si_dma>
[   76.120258] [drm] add ip block number 5 <si_dpm>
[   76.120261] [drm] add ip block number 6 <dce_v6_0>
[   76.120264] [drm] add ip block number 7 <uvd_v3_1>
[   76.163659] [drm] BIOS signature incorrect 5b 7
[   76.163669] resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [mem 0x000d0000-0x000dffff window]
[   76.163677] caller pci_map_rom+0x68/0x1b0 mapping multiple BARs
[   76.163691] amdgpu 0000:01:00.0: No more image in the PCI ROM
[   76.164996] amdgpu 0000:01:00.0: amdgpu: Fetched VBIOS from ROM BAR
[   76.165001] amdgpu: ATOM BIOS: xxx-xxx-xxx
[   76.165018] amdgpu 0000:01:00.0: amdgpu: PCIE atomic ops is not supported
[   76.165270] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
[   76.349679] amdgpu 0000:01:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
[   76.349716] amdgpu 0000:01:00.0: amdgpu: GART: 1024M 0x000000FF00000000 - 0x000000FF3FFFFFFF
[   76.349753] [drm] Detected VRAM RAM=2048M, BAR=256M
[   76.349764] [drm] RAM width 128bits DDR3
[   76.349940] [drm] amdgpu: 2048M of VRAM memory ready
[   76.349953] [drm] amdgpu: 3072M of GTT memory ready.
[   76.349992] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   76.350506] amdgpu 0000:01:00.0: amdgpu: PCIE GART of 1024M enabled (table at 0x000000F400900000).
[   76.495343] [drm] Internal thermal controller with fan control
[   76.495391] [drm] amdgpu: dpm initialized
[   76.495637] [drm] AMDGPU Display Connectors
[   76.495647] [drm] Connector 0:
[   76.495655] [drm]   HDMI-A-1
[   76.495662] [drm]   HPD1
[   76.495668] [drm]   DDC: 0x194c 0x194c 0x194d 0x194d 0x194e 0x194e 0x194f 0x194f
[   76.495685] [drm]   Encoders:
[   76.495691] [drm]     DFP1: INTERNAL_UNIPHY
[   76.495699] [drm] Connector 1:
[   76.495706] [drm]   DVI-D-1
[   76.495712] [drm]   HPD2
[   76.495718] [drm]   DDC: 0x1950 0x1950 0x1951 0x1951 0x1952 0x1952 0x1953 0x1953
[   76.495733] [drm]   Encoders:
[   76.495739] [drm]     DFP2: INTERNAL_UNIPHY
[   76.495746] [drm] Connector 2:
[   76.495753] [drm]   VGA-1
[   76.495758] [drm]   DDC: 0x1970 0x1970 0x1971 0x1971 0x1972 0x1972 0x1973 0x1973
[   76.495773] [drm]   Encoders:
[   76.495779] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   76.599604] [drm] Found UVD firmware Version: 64.0 Family ID: 13
[   76.603443] [drm] PCIE gen 2 link speeds already enabled
[   77.149564] [drm] UVD initialized successfully.
[   77.149578] amdgpu 0000:01:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 5, active_cu_number 8
[   77.456492] RTL8211B Gigabit Ethernet r8169-0-300:00: attached PHY driver (mii_bus:phy_addr=r8169-0-300:00, irq=MAC)
[   77.486245] [drm] Initialized amdgpu 3.44.0 20150101 for 0000:01:00.0 on minor 0
[   77.521555] r8169 0000:03:00.0 eth0: Link is Down
[   77.547158] fbcon: amdgpudrmfb (fb0) is primary device
[   77.591226] Console: switching to colour frame buffer device 240x67
[   77.600296] amdgpu 0000:01:00.0: [drm] fb0: amdgpudrmfb frame buffer device

I can supply extra details but found no logging from the sessions that experienced the lock-up.

Regards,

Arthur Marsh.
