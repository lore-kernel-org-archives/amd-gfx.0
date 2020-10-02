Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02BFC47425
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 05:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05178206C3
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 05:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05178206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E6D6E0AC;
	Fri,  2 Oct 2020 05:17:20 +0000 (UTC)
X-Greylist: delayed 422 seconds by postgrey-1.36 at gabe;
 Fri, 02 Oct 2020 05:17:18 UTC
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net
 [IPv6:2a01:37:1000::53df:5f64:0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C832C6E0AC
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 05:17:18 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "*.hostsharing.net",
 Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
 by bmailout1.hostsharing.net (Postfix) with ESMTPS id B35CA30000CCE;
 Fri,  2 Oct 2020 07:10:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 7CB8449136; Fri,  2 Oct 2020 07:10:12 +0200 (CEST)
Message-Id: <cea9071dc46025f0d89cdfcec0642b7bfa45968a.1601614985.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 2 Oct 2020 07:10:12 +0200
Subject: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power managed by
 ACPI
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Len Brown <lenb@kernel.org>
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
Cc: Aaron Zakhrov <aaron.zakhrov@gmail.com>, linux-pci@vger.kernel.org,
 Michal Rostecki <mrostecki@suse.com>,
 Arthur Borsboom <arthurborsboom@gmail.com>, linux-acpi@vger.kernel.org,
 Shai Coleman <git@shaicoleman.com>, amd-gfx@lists.freedesktop.org,
 matoro <matoro@airmail.cc>, Alex Deucher <alexander.deucher@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Recent laptops with dual AMD GPUs fail to suspend the discrete GPU, thus
causing lockups on system sleep and high power consumption at runtime.
The discrete GPU would normally be suspended to D3cold by turning off
ACPI _PR3 Power Resources of the Root Port above the GPU.

However on affected systems, the Root Port is hotplug-capable and
pci_bridge_d3_possible() only allows hotplug ports to go to D3 if they
belong to a Thunderbolt device or if the Root Port possesses a
"HotPlugSupportInD3" ACPI property.  Neither is the case on affected
laptops.  The reason for whitelisting only specific, known to work
hotplug ports for D3 is that there have been reports of SkyLake Xeon-SP
systems raising Hardware Error NMIs upon suspending their hotplug ports:
https://lore.kernel.org/linux-pci/20170503180426.GA4058@otc-nc-03/

But if a hotplug port is power manageable by ACPI (as can be detected
through presence of Power Resources and corresponding _PS0 and _PS3
methods) then it ought to be safe to suspend it to D3.  To this end,
amend acpi_pci_bridge_d3() to whitelist such ports for D3.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1222
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1252
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1304
Reported-and-tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
Reported-and-tested-by: matoro <matoro@airmail.cc>
Reported-by: Aaron Zakhrov <aaron.zakhrov@gmail.com>
Reported-by: Michal Rostecki <mrostecki@suse.com>
Reported-by: Shai Coleman <git@shaicoleman.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci-acpi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d5869a0..d9aa551 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -944,6 +944,16 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	if (!dev->is_hotplug_bridge)
 		return false;
 
+	/* Assume D3 support if the bridge is power-manageable by ACPI. */
+	adev = ACPI_COMPANION(&dev->dev);
+	if (!adev && !pci_dev_is_added(dev)) {
+		adev = acpi_pci_find_companion(&dev->dev);
+		ACPI_COMPANION_SET(&dev->dev, adev);
+	}
+
+	if (adev && acpi_device_power_manageable(adev))
+		return true;
+
 	/*
 	 * Look for a special _DSD property for the root port and if it
 	 * is set we know the hierarchy behind it supports D3 just fine.
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
