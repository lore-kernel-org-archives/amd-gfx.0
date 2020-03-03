Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9519C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 08:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE376208C3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 08:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE376208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5466EA1B;
	Tue,  3 Mar 2020 08:24:16 +0000 (UTC)
Received: from yyz.mikelr.com (unknown
 [IPv6:2602:ffb6:2:0:f816:3eff:fe0d:377b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5863D6E4AF
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 03:41:56 +0000 (UTC)
Received: from glidewell.ykf.mikelr.com (198-84-194-208.cpe.teksavvy.com
 [198.84.194.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by yyz.mikelr.com (Postfix) with ESMTPSA id E66383CF24;
 Mon,  2 Mar 2020 22:35:02 -0500 (EST)
From: Mikel Rychliski <mikel@mikelr.com>
To: amd-gfx@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/4] PCI: Use ioremap, not phys_to_virt for platform rom
Date: Mon,  2 Mar 2020 22:34:55 -0500
Message-Id: <20200303033457.12180-3-mikel@mikelr.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200303033457.12180-1-mikel@mikelr.com>
References: <20200303033457.12180-1-mikel@mikelr.com>
X-Mailman-Approved-At: Tue, 03 Mar 2020 08:24:15 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Matthew Garrett <matthewgarrett@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Mikel Rychliski <mikel@mikelr.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On some EFI systems, the video BIOS is provided by the EFI firmware.  The
boot stub code stores the physical address of the ROM image in pdev->rom.
Currently we attempt to access this pointer using phys_to_virt, which
doesn't work with CONFIG_HIGHMEM.

On these systems, attempting to load the radeon module on a x86_32 kernel
can result in the following:

    BUG: unable to handle page fault for address: 3e8ed03c
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    *pde = 00000000
    Oops: 0000 [#1] PREEMPT SMP
    CPU: 0 PID: 317 Comm: systemd-udevd Not tainted 5.6.0-rc3-next-20200228 #2
    Hardware name: Apple Computer, Inc. MacPro1,1/Mac-F4208DC8, BIOS     MP11.88Z.005C.B08.0707021221 07/02/07
    EIP: radeon_get_bios+0x5ed/0xe50 [radeon]
    Code: 00 00 84 c0 0f 85 12 fd ff ff c7 87 64 01 00 00 00 00 00 00 8b 47 08 8b 55 b0 e8 1e 83 e1 d6 85 c0 74 1a 8b 55 c0 85 d2 74 13 <80> 38 55 75 0e 80 78 01 aa 0f 84 a4 03 00 00 8d 74 26 00 68 dc 06
    EAX: 3e8ed03c EBX: 00000000 ECX: 3e8ed03c EDX: 00010000
    ESI: 00040000 EDI: eec04000 EBP: eef3fc60 ESP: eef3fbe0
    DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010206
    CR0: 80050033 CR2: 3e8ed03c CR3: 2ec77000 CR4: 000006d0
    Call Trace:
     ? register_client+0x34/0xe0
     ? register_client+0xab/0xe0
     r520_init+0x26/0x240 [radeon]
     radeon_device_init+0x533/0xa50 [radeon]
     radeon_driver_load_kms+0x80/0x220 [radeon]
     drm_dev_register+0xa7/0x180 [drm]
     radeon_pci_probe+0x10f/0x1a0 [radeon]
     pci_device_probe+0xd4/0x140
     really_probe+0x13d/0x3b0
     driver_probe_device+0x56/0xd0
     device_driver_attach+0x49/0x50
     __driver_attach+0x79/0x130
     ? device_driver_attach+0x50/0x50
     bus_for_each_dev+0x5b/0xa0
     driver_attach+0x19/0x20
     ? device_driver_attach+0x50/0x50
     bus_add_driver+0x117/0x1d0
     ? pci_bus_num_vf+0x20/0x20
     driver_register+0x66/0xb0
     ? 0xf80f4000
     __pci_register_driver+0x3d/0x40
     radeon_init+0x82/0x1000 [radeon]
     do_one_initcall+0x42/0x200
     ? kvfree+0x25/0x30
     ? __vunmap+0x206/0x230
     ? kmem_cache_alloc_trace+0x16f/0x220
     ? do_init_module+0x21/0x220
     do_init_module+0x50/0x220
     load_module+0x1f26/0x2200
     sys_init_module+0x12d/0x160
     do_fast_syscall_32+0x82/0x250
     entry_SYSENTER_32+0xa5/0xf8

Fix the issue by using ioremap instead of phys_to_virt in pci_platform_rom.

Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
---
 drivers/pci/rom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 137bf0cee897..e352798eed0c 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -197,8 +197,7 @@ void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom)
 EXPORT_SYMBOL(pci_unmap_rom);
 
 /**
- * pci_platform_rom - provides a pointer to any ROM image provided by the
- * platform
+ * pci_platform_rom - ioremap the ROM image provided by the platform
  * @pdev: pointer to pci device struct
  * @size: pointer to receive size of pci window over ROM
  */
@@ -206,7 +205,7 @@ void __iomem *pci_platform_rom(struct pci_dev *pdev, size_t *size)
 {
 	if (pdev->rom && pdev->romlen) {
 		*size = pdev->romlen;
-		return phys_to_virt((phys_addr_t)pdev->rom);
+		return ioremap(pdev->rom, pdev->romlen);
 	}
 
 	return NULL;
-- 
2.13.7

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
