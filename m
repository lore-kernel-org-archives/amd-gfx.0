Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CF3606A323
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IfkmmucE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1ECC10EC23;
	Sat, 14 Nov 2026 19:10:57 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3A810E784
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 16:09:23 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-3791619605cso4134108eec.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 08:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672563; x=1795277363; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EfZAm8HK5M4blUNFdDl+epKKwi55wmzsTvrZgcxUZEg=;
 b=IfkmmucEil/q+h0aHvhynsvXxW8STfdBuQdX3yNMj/Aj8RLOZ99cVMMLRgJc92iT/n
 xOor+TiqEMawg55grcoXfW91FD+yVfozHNrLMOdayjOJGfVdMZViTv7VSeAQOGSwOHaV
 EKovBFf5mxYVuvfB3O+W4HxsebakRfOJK2CBGBtzYP7ZSRPQauWoixBHbxpNZr8CjNVz
 dd3ZUZaE1rUJyUOfg7ws8RPGDtXs6qQ8SYXSlNp7KDaRIZ5Z2ZNzYeMbFWkFZIkXS/3L
 /Px9kNtME5TcINtPIuaBP47GwbU6AMeST9wYIvNrRblunsXuIuk1NtEvMgJ+YXJe1pJ+
 RLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672563; x=1795277363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EfZAm8HK5M4blUNFdDl+epKKwi55wmzsTvrZgcxUZEg=;
 b=a5J+ybv/ls/Bt5K4pzP5KTK48S21C25d8Hai5SAwXOR/wGEffaxD3/F7YWhm8m36D2
 gviNp7Wm+W2WPEtgqFAdJWYHOFZDyjPYTzLB3ww4xZzWI3OHGdkklaWC1CRv2bM2xsMB
 xHesIG7CGMwKZc9PlcIvjHIKFZU4UBdmp+wmL4MdGsvmHdJfy3vNNG7yjGW8gZtYpZKm
 7WPMVpbgsb3He8FtD+FmpkGz+8dVsUP6hzJzJhVx8n9jbXBijyka+vxaEvXZcNjN1u73
 mhhgWs5WbqfmJ2f9XuqGRC1e/cerzXHsrA9cVSm0ik+vw9t/FhJQPVCXy+lx/60gCmZ2
 BGLw==
X-Forwarded-Encrypted: i=1;
 AL+hErHwdLKLEmAV06pRf13TUbBDA1OENUmKSGJe1Oqy9dVkBhbnUwUdDf/ZgSv8qbkGPvYTyoX9SGHS@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+zq+QmMHYxApGD9SF/aotq9W6eWBE41dL8OGzMva+1jzuw74FZ
 r9NPdGVeo5yaDpRDF8gCr+nKK17bDUyt/R2gHvPjy546jHkXItvFNsM=
X-Gm-Gg: AYBFou2SxdngsArhs77sR4jCNLbZIB5cLOg1K//JRLKvZKdoPmV9MQ694Hi7o+2tWt8
 a976g9GLjLmRTCtkrP6UTDVy4sBxierWES687C9XIx57nK7L50d5VX+YQbS/HS5XMe+OL4OhSxa
 lu10eCtTYewlTX1Q0nrlZ2tHSeJA4G+v1W0q55HxZUTz5cVatX/PuQ8g96x1nMDSDOirPNKK3BO
 cX9kZnO41YDIp/uNTTvjVMZUOy8k/NrsV7jBQxGD4Dg5vXEDI9obDD66ekLfXX9YJgIl41tibxX
 pTnp+CTFUOmARfrUN0NLIq7tPK7ODNgQqFztzad2smEmWtnPfn8NaivUNaYgJ2weSQc+Zu8F58c
 hV1AwbfYnV6sD0U5lhypZfFKtIxsxjo/Me7188WqtGb9gE2lZx/b0Nf0Fx30IckNpKQ4zPt8jgA
 40tcy3LvGjAJDqtVNwjvL5lrdM3u+Oi4IloIx0sCGwFjvX+zFbxb7I96YpkD3b3FDLfWeUbxHac
 iDLtn8LKsjUZxADeWz+U5hS/ok1W3nEhkJ/7N8D2UHd81fUcgYY7+Vw4kGRmxfIx0JTob5uYUQ6
 esng5lMvDp1EUiHvFrFrvUesIarR/C3c8ORUkniH+e9z02KXaTGxO5OKKY2aXo4mxQ==
X-Received: by 2002:a05:693c:4152:10b0:36a:4a68:84e5 with SMTP id
 5a478bee46e88-379659c6839mr6027249eec.8.1794672562295; 
 Sat, 14 Nov 2026 08:09:22 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:09:21 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>, Sebastian Zygadlo <szgit@icloud.com>,
 Yossef Osman <yossef.osman@proton.me>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH v2 05/12] platform/apple-gmux: Write switch state to EFI on
 MMIO devices
Date: Sat, 14 Nov 2026 11:06:29 -0500
Message-ID: <20261114160731.3756-6-atharvatiwarilinuxdev@gmail.com>
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

From: Andre Eikmeyer <dev@deq.rocks>

On T2 devices (MMIO), the T2 coprocessor reads gpu-active efi
variable, and macOS seems to write it, so to properly communciate
to the T2 coprocessor, we write gpu-active.

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Co-developed: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/platform/x86/Kconfig      |  1 +
 drivers/platform/x86/apple-gmux.c | 40 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index c37e76066..01895d511 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -217,6 +217,7 @@ config APPLE_GMUX
 	depends on ACPI && PCI
 	depends on PNP
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on EFI
 	help
 	  This driver provides support for the gmux device found on many
 	  Apple laptops, which controls the display mux for the hybrid
diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 37ba20779..c4a953b5b 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -26,6 +26,7 @@
 #include <linux/debugfs.h>
 #include <linux/workqueue.h>
 #include <linux/pm_runtime.h>
+#include <linux/efi.h>
 #include <acpi/video.h>
 #include <asm/io.h>
 
@@ -489,6 +490,32 @@ static void gmux_write_switch_state(struct apple_gmux_data *gmux_data)
 		gmux_write8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL, 3);
 }
 
+#define APPLE_GPU_VARS_GUID EFI_GUID(0xfa4ce28d, 0xb62f, 0x4c99, \
+				     0x9c, 0xc3, 0x68, 0x15, 0x68, 0x6e, 0x30, 0xf9)
+
+static efi_char16_t gmux_gpu_active_name[] = L"gpu-active";
+
+static void gmux_write_switch_state_efi(struct apple_gmux_data *gmux_data)
+{
+	efi_guid_t guid = APPLE_GPU_VARS_GUID;
+	u32 active = gmux_data->switch_state_display == VGA_SWITCHEROO_IGD;
+	efi_status_t status;
+
+	if (!efivar_is_available() ||
+			!efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
+		return;
+
+	status = efivar_set_variable(gmux_gpu_active_name, &guid,
+				     EFI_VARIABLE_NON_VOLATILE |
+				     EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				     EFI_VARIABLE_RUNTIME_ACCESS,
+				     sizeof(active), &active);
+	if (status != EFI_SUCCESS)
+		pr_warn("writing gpu-active failed: 0x%lx\n", status);
+	else
+		pr_debug("gpu-active: %u\n", active);
+}
+
 static int gmux_switchto(enum vga_switcheroo_client_id id)
 {
 	apple_gmux_data->switch_state_ddc = id;
@@ -497,6 +524,8 @@ static int gmux_switchto(enum vga_switcheroo_client_id id)
 		apple_gmux_data->switch_state_external = id;
 
 	gmux_write_switch_state(apple_gmux_data);
+	if (apple_gmux_data->type == APPLE_GMUX_TYPE_MMIO)
+		gmux_write_switch_state_efi(apple_gmux_data);
 
 	return 0;
 }
@@ -1240,6 +1269,15 @@ static void gmux_remove(struct pnp_dev *pnp)
 	kfree(gmux_data);
 }
 
+static void gmux_shutdown(struct pnp_dev *pnp)
+{
+	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
+
+	gmux_write_switch_state_efi(gmux_data);
+
+	gmux_remove(pnp);
+}
+
 static const struct pnp_device_id gmux_device_ids[] = {
 	{ .id = GMUX_ACPI_HID },
 	{ }
@@ -1254,6 +1292,7 @@ static struct pnp_driver gmux_pnp_driver = {
 	.name		= "apple-gmux",
 	.probe		= gmux_probe,
 	.remove		= gmux_remove,
+	.shutdown	= gmux_shutdown,
 	.id_table	= gmux_device_ids,
 	.driver		= {
 			.pm = &gmux_dev_pm_ops,
@@ -1265,3 +1304,4 @@ MODULE_AUTHOR("Seth Forshee <seth.forshee@canonical.com>");
 MODULE_DESCRIPTION("Apple Gmux Driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pnp, gmux_device_ids);
+MODULE_IMPORT_NS("EFIVAR");
-- 
2.55.0

