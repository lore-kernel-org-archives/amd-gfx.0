Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769F0606A327
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qw8U3Q+o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36FD310F0BC;
	Sat, 14 Nov 2026 19:10:59 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918BF10E387
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 16:06:07 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1438d9363fbso1021470c88.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 08:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672367; x=1795277167; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=57QGYlJp5ubvUnaSXRDvNGBB3M2Beb8mEN3QVUFhP3Q=;
 b=Qw8U3Q+oU6kNJQ4YxDdVYnfTe5LX9PQlf2ZpaacezZRfJKGKumeTq/ldt8DlezDfJ+
 u0a1bwUL11+liEYHLDl1d2nw6Vl+oqBmiwDCJrwmx3QnSsEEX0bTU5eNaublXG2s5oyh
 /9TZSDVc/t50E/60PIqYFjlPsuKNnkyl2r95G04rLlyDBhPFg+7i48kVbBbT15RluSMP
 USqU5JlR+kczMvaUYn21lNOS6mzM1uVdCpIyWGG7Pgcc7kriBzK4iFQVB/OyneHDsY1y
 gfu/nH3ELq6PR7RjOWFrQZCnbP8tcOtsES9pycHtOROQADK0KRL38qorj5TbBC7PZ7Xw
 VvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672367; x=1795277167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=57QGYlJp5ubvUnaSXRDvNGBB3M2Beb8mEN3QVUFhP3Q=;
 b=vt3qqWzxyWTxL7Y0s0D7BujXLtP+TTqtvjwC7tHvjrpvSNDD9DPhuC2Hz2DH6fz7Qi
 1lvOgNj8qhxboL5ycVb0chLOMTd3hSshWOhBmqr+3gjCZnP+gc9+GklibB8war1Z1jyH
 0+JLtemDCjONUfDeUNLj04Q5pRL/LwYE1VdOHbekCIK9Nux1OzsEZIyU6SUULxNBWgPd
 9oM1vvyJ6l2i4dbrLVzw4IhAjD0EorIJxHw9N1NSPr7YMO3byQpvlyRTQw7dxha6t0Gb
 L33QM/JNU0cc1OVULQtBkjecWqVEYg67SHmei5+c10rMpNx0aFe45edRnS7JGofilpPK
 rUMA==
X-Forwarded-Encrypted: i=1;
 AL+hErFJVVSZINBfNWU3jaBZ1Wt4HbuJu3xXBZp5t3EFqDylR9J/ZFZanFQQ3uj5Tj0IdUK7sGh4dx0H@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9M4NVKL2ybDUYmwd41veQap666FlHUe5d/QoFbmTDx0T6M8XLa
 8Uy5qbPmVF65LVqhl8GKXMvI0Rp6uLV+PyrmEOkxoQVg12TQrnydmw4=
X-Gm-Gg: AYBFou2Tq09g3G8yGihtZwkzoM9TAytxpi2cwg0K9rx6Ds7h3s5/JgNuRsf0QXVMiDH
 IyASj+SgkmajSXGWlOzGsUl8tTgPiQffqRPj4p16n1L2SruyDhdkb+AKxXaITy8PLMKPyP5L97B
 LAmabXB144uVHTrueUqnrEr72dlhOHTjpMy6WXR72lMBqS36QVLCRjCiKz3+h9HPWBTCSP+S5ml
 LXecXIPLi30LxqLkYWFwCRNMXl8ox8hU4Ff8o9urMNFvfbyOgBfpaD7tRqT5f/6axcMx4czPD/6
 c1P1Q5mo096snlvNF0wf0c9tDuRCIo6K4JrCrKwnGE3/NrELSfWSirGVF3Joc0hhF2+EtH3deF7
 rZAiaZJ6Ii3UCh+nz1ItDdyGY+I5gi26vqW/ZfqM/6IMNZUNu4fQV/nBqp7AwGfJSp9mWYAyRU6
 K+EI+eJcgy2ctONgdpNrM+8HLVJXQ8Y+okZq4/BevKjliCH5u/TpkImFNf+t4vfkHs8VaF4N2Oc
 WsbTKicje9qtdNdgw8GWakRQ+bzCn7rgAP3IjTUsdv+cnMfNlONUKYMPMYoeEHf5+tXl16ip5Cs
 20cfjqiF0aOKYiD7TE2eMtTp+oxkjMTa+i3Fj+BZ7D2joKxVDGwCALgpbqhuFE/5OA==
X-Received: by 2002:a05:7022:3b84:b0:1b3:a8ee:a0e5 with SMTP id
 a92af1059eb24-1b5030243ddmr6212226c88.2.1794672366456; 
 Sat, 14 Nov 2026 08:06:06 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.114.179])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b505b5bf76sm13378548c88.10.2026.11.14.08.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:06:05 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Sebastian Zygadlo <szgit@icloud.com>,
 Yossef Osman <yossef.osman@proton.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andre Eikmeyer <dev@deq.rocks>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH v2 02/12] PCI: Disable pcie port on specific amd devices
Date: Sat, 14 Nov 2026 11:03:49 -0500
Message-ID: <20261114160457.3034-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114160457.3034-1-atharvatiwarilinuxdev@gmail.com>
References: <20261114160457.3034-1-atharvatiwarilinuxdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 19:10:55 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As mentioned in the previous commit, PWRD turns off the entire
bridge, and if we read/write anything to the config space
or the PCIE space when the bridge is dead, the CPU CATERR's,
so to avoid interaction when the bridge is dead,
we remove pcieport support for the bridges..

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 arch/x86/pci/fixup.c       | 43 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c |  2 +-
 include/linux/pci.h        |  1 +
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 795d81c7a..b1697cc4a 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1094,6 +1094,48 @@ static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
 
+static const struct dmi_system_id quirk_disable_pcie_port_dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,3"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,4"),
+		},
+	},
+	{}
+};
+
+static void quirk_disable_pcie_port(struct pci_dev *pdev)
+{
+	struct pci_dev *upstream = pdev;
+
+	if (dmi_check_system(quirk_disable_pcie_port_dmi_table)) {
+		while ((upstream = pci_upstream_bridge(upstream)))
+			upstream->no_pcie_port = 1;
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x67ef, quirk_disable_pcie_port);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x69af, quirk_disable_pcie_port);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7340, quirk_disable_pcie_port);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7360, quirk_disable_pcie_port);
+
 #ifdef CONFIG_SUSPEND
 /*
  * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
@@ -1179,4 +1221,5 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
+
 #endif /* CONFIG_SUSPEND */
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index a9cbfc1d2..d2f19e566 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -688,7 +688,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	int type = pci_pcie_type(dev);
 	int status;
 
-	if (!pci_is_pcie(dev) ||
+	if (!pci_is_pcie(dev) || dev->no_pcie_port ||
 	    ((type != PCI_EXP_TYPE_ROOT_PORT) &&
 	     (type != PCI_EXP_TYPE_UPSTREAM) &&
 	     (type != PCI_EXP_TYPE_DOWNSTREAM) &&
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107..fcb4f5893 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -420,6 +420,7 @@ struct pci_dev {
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
 	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
+	unsigned int	no_pcie_port:1; /* PCIE Port driver is forbidden */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */
-- 
2.55.0

