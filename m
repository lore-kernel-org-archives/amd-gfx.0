Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03905606A327
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w0djcSRN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE87C10F0CE;
	Sat, 14 Nov 2026 19:11:02 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42AFE10E390
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 16:08:30 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-37071c0f42aso2959116eec.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 08:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672509; x=1795277309; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=57QGYlJp5ubvUnaSXRDvNGBB3M2Beb8mEN3QVUFhP3Q=;
 b=w0djcSRNVLGWV12+m9ILz6NogghVCRJNGHL0M+7jwTmtGJL564I5BhmFTsmYXpOOaY
 vIgsj7CNZYgPl1WCTysk6RANNmmp1QT+Xyx/SLgJqEFZGjtp0nAQJyj11UEgH5ljbTiJ
 +wfw5NaLqlY/A7hdvdCcwZnvJY1gxGAwpSl+bL6EO03JKJictJ5o8cNJinJL0tHamJxh
 usQxieFYOOYZmGu/IcA5/9CC2reNXm+BCaG2T7rgTZNbNX0fm10ymV1c4t36AlR2ec5a
 8jv96FTcB8R+n7VYOQplguUQAfxuA0kvQ72UvTgbMMEjNHuJZ6DKwDZB8/LCZmWI3CQ3
 dbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672509; x=1795277309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=57QGYlJp5ubvUnaSXRDvNGBB3M2Beb8mEN3QVUFhP3Q=;
 b=qCQlAGw8sEqHGYq7z0I75aSkblzPgyHwkHCVQHldeHY20zRdH0Tn9T0dolvq8IxaJo
 3tIRqSizz/1jDMyTiiFB3i8IPttvOzDC+L3StFxvkonMRGQPxqp7bQE/tQJMvfvdxysR
 Peuh/u6yPGXHUxQeK3Ug+94AdoBWtdd7FcX+GyFNIgat8IpcrL5V0V4P7vjZT4MewWBG
 MqnbyIYO8tEALTWO3hk4dGacQ6IHoiYyv/1jY4SQmIUflBdWeMAEPZexCAC04vBYeSxq
 UD1fL42Elra9zkWL/jlJA80ByYhRp+kGKMdYfE5vbzhW1N53RwWejMoeirFwmj3/nvTd
 a1ZA==
X-Forwarded-Encrypted: i=1;
 AL+hErH6RNMIPHJ+BKyMjan3LTyABts9HTr4JkF/TXHE3pC0g5fOsZSaK7QFcs+/UeudyRTQq1IPGRom@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9xav3l6Cx1lKbX9OHUkfw9C5qhsc89POtVzLsMom8z64j2h5L6
 i4zEhfyJsMp6MaOSExunRu0Huoa04IR7YKbSk4iybSudFENVp8SxsOA=
X-Gm-Gg: AYBFou086HoxYhlW82CnFoTVMr+erBYb//kMZS1nEd2PAWz1uHvbkQ81hjZaLg18jig
 7WrX0rKe4o4vNpllJXvNPilBM2Xn8cqMQ8B5EbzDZh0vWmEgqzLHJIJkavUtc7tPqGfgN6i+IYw
 siMqbn9Vv0dkjbtHd2d9rNf28rzon0etzjbjX00CBAwf+0cEd5ilRculXPr+wtWHpMOxMuCwGrj
 cGpn2qALzDW5+zD3jEX//14mJ0exuk+QbC6CRMensL4AZw/yi8NEcp5ZfZyCLSYcFbsKvLxLj/U
 TIHqjqYWI856s+F0oqxJTU/nrGr55SVFDV02cNvtGZkYIi2Wf3hgu2H1RceOYw13wocsfQVBlJP
 lTm0jExeaIi59c6Z5rC/LyYJKOj7CE8ZQOYwslLXmFKddymy83or4F/M1KJXubWayOntRj3IQu/
 YiD8ZftD27rCDkRHBJ5yCkKrhprCHMzzo4msj9MMkMSmMo6ut1kVSRKw1duRiFDppJgOaxhu1kx
 N2zkoEpYZ5wFBreJG1NccM89LmaEkUr96IueF1E30QMuHYZwL0RAx7ak/5ssM4ubOAH0LIJ2RIF
 dPXMLSyXBknkS0kPUZKeO5nYSzuyO1idoNEwmtYsoMf/jlMjMRbwvemoy6r7g6CqkQ==
X-Received: by 2002:a05:7300:f18e:b0:375:894f:2524 with SMTP id
 5a478bee46e88-37966b52646mr7220639eec.12.1794672509407; 
 Sat, 14 Nov 2026 08:08:29 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:08:29 -0800 (PST)
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
Date: Sat, 14 Nov 2026 11:06:26 -0500
Message-ID: <20261114160731.3756-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
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

