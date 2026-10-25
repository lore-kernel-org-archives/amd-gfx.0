Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC3606A323
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cklDkuek
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A405510ECC3;
	Mon, 26 Oct 2026 08:44:00 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E644E10E57B
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 04:02:48 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-3535a54bed9so3242099eec.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Oct 2026 21:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792900968; x=1793505768; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kIWFjWx6bY2aMzP1Dlox6FZiyYw6gduqI5+MEIlEj5E=;
 b=cklDkuek544JNBsdVjqKZNR+BcqNtDeXfljxkJfM7QB2XCy4arHVLqLdwWKDBr3sRd
 DWnPb958f7BxaL/AiNkUlJ7rYa58gJ4L8gQg53C7G+tm2dBXuiQp0H6UIMajCBeRbsi7
 74N4KbFty5BZbaW19dR1JAcMrRf/CmtXUpzlR9AZnHs2kkuDu7TMBHYDxFwxEtQO8ajw
 Yz0ERBkPFVY2hWxzTU+5khvyI0DdZ1KLe+L5bMroTZjABrMEH6NpPkF0UvCGySQOoXTd
 9JP19r6cywPv/VEZHmSf6IrZVKpJZ8jzkxFl3CCjgG2qn0rE+LcQvw/V7DCrq+fapXo7
 vVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792900968; x=1793505768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kIWFjWx6bY2aMzP1Dlox6FZiyYw6gduqI5+MEIlEj5E=;
 b=jeoaPgt0MyImwo4SoiTKxB3xHVsGVnTVOmMva07qP84D/6Gh8KNCvSzvMHZfvfGuX0
 inlv/YCSRBcw+3BWttlhTClW9Q2rOxLcFWgFHeAUhmBzJBigC4RpmJZxsbE+U3Ch/nRl
 XZF9V7gpaSvOxpytKK1QdABDAjDYcdhgg4r5kx7tLLANL438/MaAjHTsuJmTrYvQ47pt
 y4vMiGRCLzO6zLY0nqoe5U+A4EVo8rBrk4CKuPxycqAaMQRfkKV9CcddKBXZv/UY6iZ6
 s0xlYdpRhYIpF4svR1FUwXJk7bdJ20ol/Yy0uPKvZ7UiXO+uYLHhQyajzFu/2vviwz7k
 yKGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4nhlhCQhUv5yOI2yzzR2tjf8b2SMOTsLwnP+twSVd6sQIBgHbEFHN/Z8A0aCf9M8TZIhpustJ@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKGEP4j2XVZLPH/ks4mwmAbQfpyuWZCvoKP1FofH94lZVpn+qnR
 QYtS5uT6YRpB1nUxIwllP3TPyn0mHMUXIeO9HOwIuqyjqnENYa/4S5s=
X-Gm-Gg: AYBFou1jxppBRQd7vEWw8BzmQ4gKJrhQSv6KL+et6H7T+T9XR04n+rET4XHeZHWldWc
 R9wpfwO17KSn0adqumzpeIX2LESlGZ/qIj1LdHfoRqgGCei0S4TIhqPjsx8VGX8mNzaaKg6sIE2
 I682a/PJJjeQ0TCZ9dWfvA8exLlbdmlR78YEuRIoB3kRZ+58I4T9g159tZZWhMuNXgsEVE4qfqV
 AD1xuo5Smywf+MaDjeX9E/opmdNDn4MFGwz47yAjp4dNsbfPYrut6BUrDFYKF0Vr3Tugq/Ghgrq
 0hGvOPC7SynkSBcr9iTLBS+tnKjYa3hUUDbp9jmR9wfqlf1+HDcvbxTK/XsmPrpJ7eDgxENgY65
 KZYAN+Ibk27axzB51Awlr/GS5GXzC8KI7rlJO/C6a8djy9Tk9cfQDJKL+7IL6o63w+GAWP592MT
 H5ZNJjYDBanM0kx7Ds30uulLH0UazOLgEVo4Gc0q5vwZgWF8tLW1rNNybcfSk1pEbCuGkxFMoEW
 GbNT4VqFD4WlM5EFqc/wmpfu6pilz729ILYuxAnyH5AcpvDu6TJS3J/DL6nvztIwul4GsdaU/Ug
 7cQXt6S6ft2WeIV4
X-Received: by 2002:a05:701a:ca0b:b0:17d:7b45:f91f with SMTP id
 a92af1059eb24-1993580fcd2mr5442774c88.32.1792900968114; 
 Sat, 24 Oct 2026 21:02:48 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:02:47 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
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
 Andre Eikmeyer <dev@deq.rocks>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 06/13] platform/apple-gmux: Add parameter to configure boot gpu
Date: Sat, 24 Oct 2026 23:59:42 -0400
Message-ID: <20261025040046.1602-7-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:43:34 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently on Indexed and MMIO systems, the system can't change
GPU's on runtime, as the display is not trained on the secondary
GPU, to combat this, we add a module parameter to configure the boot
GPU, so users can change to iGPU or dGPU via reboot.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 637b3b216..6a9580f27 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -109,6 +109,10 @@ struct apple_gmux_config {
 	char *name;
 };
 
+static int boot_gpu = -1;
+module_param(boot_gpu, int, 0);
+MODULE_PARM_DESC(boot_gpu, "Configure the boot gpu (-1 = auto, 0 = iGPU, 1 = dGPU)");
+
 #define GMUX_INTERRUPT_ENABLE		0xff
 #define GMUX_INTERRUPT_DISABLE		0x00
 
@@ -1215,6 +1219,11 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	gmux_enable_interrupts(gmux_data, 1);
 	gmux_read_switch_state(gmux_data);
 
+	if (boot_gpu == 0)
+		gmux_switchto(VGA_SWITCHEROO_IGD);
+	else if (boot_gpu == 1)
+		gmux_switchto(VGA_SWITCHEROO_DIS);
+
 	/*
 	 * Retina MacBook Pros cannot switch the panel's AUX separately
 	 * and need eDP pre-calibration. They are distinguishable from
-- 
2.55.0

