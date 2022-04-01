Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96C2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 13:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5F510E312;
	Fri,  1 Apr 2022 13:02:38 +0000 (UTC)
Received: from ipmail05.adl3.internode.on.net (ipmail05.adl3.internode.on.net
 [150.101.137.13])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8E82D1121A4
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Apr 2022 08:50:06 +0000 (UTC)
X-SMTP-MATCH: 1
IronPort-Data: =?us-ascii?q?A9a23=3Abvm0e6zmdPyJ2nHSaJ96t+chxyrEfRIJ4+Muj?=
 =?us-ascii?q?C+fZmUNrF6WrkUDxmVNWGnSMv+IM2T3Ltl1YIjk9R9T7ZCBn95hQQNvqyswH?=
 =?us-ascii?q?34a+MCfWoiQchesbi6ecMOSQB03ssgXYNTLdMppZ3KN/R3F3prJ9Ckkj/vUL?=
 =?us-ascii?q?lbf5E8oAs3CLONdYH9JZS9LwobVvKY42bBVPCvV0T/Ci5W31G6Ng1aYAEpNg?=
 =?us-ascii?q?06wgEsHUMDJhd8tlgdWicanHbPpvyJ94Jo3fcldJpZjK2VeNrbSq+3rlNlV8?=
 =?us-ascii?q?o5FlirBBO9Jkp6jGqELrlA+PyDX0yoQAfH6xEIT4HVpis7XN9JFAatTozyTg?=
 =?us-ascii?q?9Bs0pNIvIarSS8oOLHBguIaXxQeFCc4O6BakFPCCSTm6ZPJnhaaLRMAxN01V?=
 =?us-ascii?q?BpmZ9dJkgptOklD6/UebikQZxarjue6hrm8T4FEr8AuPMDtMI4F/F1t0DrZA?=
 =?us-ascii?q?OwOSJXPBa7N4Ldw9zcqh9tSHP/YIekeZDxuYzzJZhEJMVASYLodkeGui2X/N?=
 =?us-ascii?q?RNVrl29rK87pWPUyWRZ9LnvN5zxc86DX+1cm0rerWXDl0zwBx1fO9KP4T6E6?=
 =?us-ascii?q?W63wOHVkC73VZkRCLqgsPlwjzW7z3YPCAAME16yu+K5ok+4R99FLUsY92wpq?=
 =?us-ascii?q?+40+VDDczVXdwng9Tvd5lhET4MFS6ti/FvYkuyFvF3CEjNRFngcfINzjMUyU?=
 =?us-ascii?q?WVygwfNx8eB6SdHqKWNECvNs+3N9XboaG1MdjdEbCMACAIJ6Jznp4d2hAjGV?=
 =?us-ascii?q?Y06VrKtgZv0Hy392TaNoCV4gLNVi8MXv5hXNGvv21qEzqUlhCZuvm07hl6Y0?=
 =?us-ascii?q?z4=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AOpaJyaj0u8TcOsCwS5ZX7JVEX3BQXs0ji2?=
 =?us-ascii?q?hC6mlwRA09TyVXrayTdZMgpHvJYVkqNk3I9errBEDEewK+yXcX2/h1AV7dZm?=
 =?us-ascii?q?jbUQKTRekI0WKh+UyDJ8SUzIFgPMlbHpSWcOeRMWRH?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BQBAA6vEZiAIId0nZaHgEBCxIMSYF?=
 =?us-ascii?q?GC4IAii+OOJxpgXwLAVQEAQGFBwKEWCY2Bw4BAgQVAQEGAQEBAQEHBBABOVK?=
 =?us-ascii?q?FdYZDAgEDMgFGEFFXgx2zSYEBiBeBZYE8iT2FETeBVUSBFAE2gzKECYY7BJk?=
 =?us-ascii?q?ec2xLBDFfkweuETQHg0yBPAYMnhNNqE4tljGhTQ1lhjQNggEzGi6DL1Aojiw?=
 =?us-ascii?q?WgQQBB401gRoCBgsBAQMJkWABAQ?=
Received: from ppp118-210-29-130.adl-adc-lon-bras31.tpg.internode.on.net (HELO
 localhost) ([118.210.29.130])
 by ipmail05.adl3.internode.on.net with ESMTP; 01 Apr 2022 19:19:54 +1030
Received: from amarsh04 by localhost with local (Exim 4.95)
 (envelope-from <arthur.marsh@internode.on.net>) id 1naCyf-0001BI-0C;
 Fri, 01 Apr 2022 19:19:53 +1030
From: Arthur Marsh <arthur.marsh@internode.on.net>
To: evan.quan@amd.com
Subject: [PATCH V4 17/17] drm/amd/pm: unified lock protections in amdgpu_dpm.c
Date: Fri,  1 Apr 2022 19:19:52 +1030
Message-Id: <20220401084952.4536-1-amarsh04@internode.on.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <BYAPR12MB2615DA93084138A62E593442E4E09@BYAPR12MB2615.namprd12.prod.outlook.com>
References: <BYAPR12MB2615DA93084138A62E593442E4E09@BYAPR12MB2615.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 01 Apr 2022 13:02:37 +0000
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
Cc: Kenneth.Feng@amd.com, Lijo.Lazar@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, arthur.marsh@internode.on.net,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Evan, this is what was logged (filtering for drm and amdgpu) when I 
blacklisted amdgpu then manually did:

modprobe amdgpu si_support=1 gpu_recovery=1

Apr  1 18:31:14 am64 kernel: [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.17.0+ root=UUID=39706f53-7c27-4310-b22a-36c7b042d1a1 ro amdgpu.audio=1 amdgpu.si_support=1 radeon.si_support=0 page_owner=on amdgpu.gpu_recovery=1 udev.log-priority=info rd.udev.log-priority=info
Apr  1 18:31:14 am64 kernel: [    0.059624] Kernel command line: BOOT_IMAGE=/vmlinuz-5.17.0+ root=UUID=39706f53-7c27-4310-b22a-36c7b042d1a1 ro amdgpu.audio=1 amdgpu.si_support=1 radeon.si_support=0 page_owner=on amdgpu.gpu_recovery=1 udev.log-priority=info rd.udev.log-priority=info

Apr  1 18:33:43 am64 kernel: [  245.724485] ACPI: bus type drm_connector registered
Apr  1 18:33:44 am64 kernel: [  245.945020] [drm] amdgpu kernel modesetting enabled.
Apr  1 18:33:44 am64 kernel: [  245.945140] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
Apr  1 18:33:44 am64 kernel: [  245.946413] [drm] initializing kernel modesetting (VERDE 0x1002:0x682B 0x1458:0x22CA 0x87).
Apr  1 18:33:44 am64 kernel: [  245.946423] amdgpu 0000:01:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
Apr  1 18:33:44 am64 kernel: [  245.946448] [drm] register mmio base: 0xFE8C0000
Apr  1 18:33:44 am64 kernel: [  245.946451] [drm] register mmio size: 262144
Apr  1 18:33:44 am64 kernel: [  245.946642] [drm] add ip block number 0 <si_common>
Apr  1 18:33:44 am64 kernel: [  245.946657] [drm] add ip block number 1 <gmc_v6_0>
Apr  1 18:33:44 am64 kernel: [  245.946660] [drm] add ip block number 2 <si_ih>
Apr  1 18:33:44 am64 kernel: [  245.946663] [drm] add ip block number 3 <gfx_v6_0>
Apr  1 18:33:44 am64 kernel: [  245.946666] [drm] add ip block number 4 <si_dma>
Apr  1 18:33:44 am64 kernel: [  245.946668] [drm] add ip block number 5 <si_dpm>
Apr  1 18:33:44 am64 kernel: [  245.946671] [drm] add ip block number 6 <dce_v6_0>
Apr  1 18:33:44 am64 kernel: [  245.946674] [drm] add ip block number 7 <uvd_v3_1>
Apr  1 18:33:44 am64 kernel: [  245.990113] [drm] BIOS signature incorrect 20 7
Apr  1 18:33:44 am64 kernel: [  245.990146] amdgpu 0000:01:00.0: No more image in the PCI ROM
Apr  1 18:33:44 am64 kernel: [  245.991510] amdgpu 0000:01:00.0: amdgpu: Fetched VBIOS from ROM BAR
Apr  1 18:33:44 am64 kernel: [  245.991516] amdgpu: ATOM BIOS: xxx-xxx-xxx
Apr  1 18:33:44 am64 kernel: [  245.991539] amdgpu 0000:01:00.0: amdgpu: PCIE atomic ops is not supported
Apr  1 18:33:44 am64 kernel: [  245.991841] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
Apr  1 18:33:44 am64 kernel: [  246.045705] amdgpu 0000:01:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
Apr  1 18:33:44 am64 kernel: [  246.045719] amdgpu 0000:01:00.0: amdgpu: GART: 1024M 0x000000FF00000000 - 0x000000FF3FFFFFFF
Apr  1 18:33:44 am64 kernel: [  246.045736] [drm] Detected VRAM RAM=2048M, BAR=256M
Apr  1 18:33:44 am64 kernel: [  246.045739] [drm] RAM width 128bits DDR3
Apr  1 18:33:44 am64 kernel: [  246.045825] [drm] amdgpu: 2048M of VRAM memory ready
Apr  1 18:33:44 am64 kernel: [  246.045829] [drm] amdgpu: 3072M of GTT memory ready.
Apr  1 18:33:44 am64 kernel: [  246.045854] [drm] GART: num cpu pages 262144, num gpu pages 262144
Apr  1 18:33:44 am64 kernel: [  246.046180] amdgpu 0000:01:00.0: amdgpu: PCIE GART of 1024M enabled (table at 0x000000F400900000).
Apr  1 18:33:44 am64 kernel: [  246.084159] [drm] Internal thermal controller with fan control
Apr  1 18:33:44 am64 kernel: [  246.084180] [drm] amdgpu: dpm initialized
Apr  1 18:33:44 am64 kernel: [  246.084264] [drm] AMDGPU Display Connectors
Apr  1 18:33:44 am64 kernel: [  246.084268] [drm] Connector 0:
Apr  1 18:33:44 am64 kernel: [  246.084270] [drm]   HDMI-A-1
Apr  1 18:33:44 am64 kernel: [  246.084272] [drm]   HPD1
Apr  1 18:33:44 am64 kernel: [  246.084274] [drm]   DDC: 0x194c 0x194c 0x194d 0x194d 0x194e 0x194e 0x194f 0x194f
Apr  1 18:33:44 am64 kernel: [  246.084279] [drm]   Encoders:
Apr  1 18:33:44 am64 kernel: [  246.084281] [drm]     DFP1: INTERNAL_UNIPHY
Apr  1 18:33:44 am64 kernel: [  246.084283] [drm] Connector 1:
Apr  1 18:33:44 am64 kernel: [  246.084285] [drm]   DVI-D-1
Apr  1 18:33:44 am64 kernel: [  246.084287] [drm]   HPD2
Apr  1 18:33:44 am64 kernel: [  246.084289] [drm]   DDC: 0x1950 0x1950 0x1951 0x1951 0x1952 0x1952 0x1953 0x1953
Apr  1 18:33:44 am64 kernel: [  246.084293] [drm]   Encoders:
Apr  1 18:33:44 am64 kernel: [  246.084295] [drm]     DFP2: INTERNAL_UNIPHY
Apr  1 18:33:44 am64 kernel: [  246.084297] [drm] Connector 2:
Apr  1 18:33:44 am64 kernel: [  246.084299] [drm]   VGA-1
Apr  1 18:33:44 am64 kernel: [  246.084301] [drm]   DDC: 0x1970 0x1970 0x1971 0x1971 0x1972 0x1972 0x1973 0x1973
Apr  1 18:33:44 am64 kernel: [  246.084305] [drm]   Encoders:
Apr  1 18:33:44 am64 kernel: [  246.084307] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
Apr  1 18:33:44 am64 kernel: [  246.135615] [drm] Found UVD firmware Version: 64.0 Family ID: 13
Apr  1 18:33:44 am64 kernel: [  246.137371] [drm] PCIE gen 2 link speeds already enabled
Apr  1 18:33:44 am64 kernel: [  246.674277] [drm] UVD initialized successfully.
Apr  1 18:33:44 am64 kernel: [  246.674849] amdgpu 0000:01:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 5, active_cu_number 8
Apr  1 18:33:45 am64 kernel: [  247.008964] [drm] Initialized amdgpu 3.46.0 20150101 for 0000:01:00.0 on minor 0
Apr  1 18:33:45 am64 kernel: [  247.068412] fbcon: amdgpudrmfb (fb0) is primary device

The monitor still went blank but the magic sysreq sync and boot worked,
allowing capture of the above log but nothing after the line above.

Regards,

Arthur Marsh.
