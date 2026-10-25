Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F0606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KU1EE+0S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC2010E1FB;
	Mon, 26 Oct 2026 08:43:35 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 255A410E674
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 04:03:03 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-354ba08cfd1so3631174eec.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Oct 2026 21:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792900982; x=1793505782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=788LSEJ/nQEllvwR1yiw9f56ICCRyDbD8OfNlkBC7CM=;
 b=KU1EE+0SjSGiJTLTEa+mMCyBphzR/nYNvN6vIXumAm1Dhr+cwqmxUjyJv93+yoB2Vz
 GvclgNW5HrdI+eJmeBBmwo1jBCmBBto1s2p1v+BBK+aW1nw1OmuWHLbZFmuxxEqC2Typ
 VQFkS4Jo+m00c7yBixG6AQQEOzU0VjFc2TS3HkSqMOGh4xEim0DSKvXXRwhdQUWSoLhY
 Jio3aBBW5p0RElGwRzEEQSio4LzgPE4NPyXLhu6vlsx038U3vgy+Inp4LayE20dvEAZh
 Hp7NUJhkExndJcQzHkXYV+mJPJZyTo6Rs47r3uoHTsnIwYe+vEVNsC+GXfamfMIP1hyq
 DhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792900982; x=1793505782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=788LSEJ/nQEllvwR1yiw9f56ICCRyDbD8OfNlkBC7CM=;
 b=0ofAfJaXgGHhVzA9aXZUw7GK9y28L9EnHPI4VId5Xc0sNUq6Ml1QtNcNbPaJlMG7yd
 5hu28rSK2CxJwlu4Un8h3kRQCsuQvZpHuIuOAIov/qiKLw8S5fxkTVOwEwwmhXGuGojG
 0UdhjxlNePIYQJmZVrr20GZG276qIocX8/HwzCqGQQadDhZM9ab173duLDUlXDx4EONq
 oo8n+pjFEbX95hmIJ3t93OgHM12qiqM8+iau1QVBiqytlyid2qXg4H6kYdiFMpYoCmlK
 ctXMSzvweAuPKrntWDtm5ESf98DicSxCiulyN4UE2MYlt3lxCD1pRXj3rnX9oIUN2qz1
 VTBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6o18dF75s/4M3wJ8VN6+/HnSLqHqmzRGC0++ytWfsINOBToDtSosQC03gPl5f1iH5MLttIjBe@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLZpVQlihl+Rpsef6jJQmzQVNtkT18/mKtPVSH25xqYtEGZOW7L
 R+zAxSMAwijJuBDPtAC+VCejvmkVC7Wj1zBfkblr+KGLXYNOhevpdkQ=
X-Gm-Gg: AYBFou3AXtsY78m6p43HV5J1u7tlmOTG/8Ek8ae+rGgUyRKl8g7L5Olzuob4C/5fWn0
 MJnhqSqdKfhu/VBQ9bRVz2QP/fUBXJv61xZulU7/1v0wP9k2ua3z2n6J8xjQdU5vfEPTbchF1rw
 S/dnb8pRDlQUQFqRcj1gcc1RdRebsVFJHiK+ssoDRprL0bdRnUk0UxGxcS6/1VdQ3kxyhT0qCJK
 F2uYsdoWqGzxWot0f42msYDAZujOExB8dp0neZtaR1l50KYW56lxQuKh6djhUYsFnjrB7aXYcDT
 19m8MQ4yl6CszjJ8klfyQEDgEJew9GT+L45BCoJD+LMAtVIYzv9BhZNBk5KF6RmD4pnrvZmzbgE
 lBYmGgdIPUGmGC/B40kgD9TdO9M2mpH8ZrShzoIvYc0CHH7kLhMpwZGsC8RJlnabBRgHaJ1R933
 Kwe5Ky7vMU4rIvKP+yEmGFmLsg6K1YrLF3kC94vnEj3IJAwa94JxoJQLV05J4cmtrg0f+56BTPW
 TOD7G+mbVFKbpecAxaJke8ISmqvlWmA8Sy8og32NLHn9+mBQbaYZtGPyBh5uQEgtcF6NDNHBPUU
 41j1/HYbmvlEwPg=
X-Received: by 2002:a05:701a:ca05:b0:14c:1f57:3e86 with SMTP id
 a92af1059eb24-1993f3f1d75mr5747943c88.47.1792900981958; 
 Sat, 24 Oct 2026 21:03:01 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:03:01 -0700 (PDT)
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
Subject: [PATCH 07/13] platform/apple-gmux: Add check to detect FSS
Date: Sat, 24 Oct 2026 23:59:43 -0400
Message-ID: <20261025040046.1602-8-atharvatiwarilinuxdev@gmail.com>
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

On MMIO macs, there is feature called FSS, we assume its
a display syncing technology between internal links
(for example 5K iMacs).

We detect it and then warn the user about it, if its broken/unavailable.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 2 ++
 include/linux/apple-gmux.h        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 6a9580f27..dda281f2f 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -1224,6 +1224,8 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	else if (boot_gpu == 1)
 		gmux_switchto(VGA_SWITCHEROO_DIS);
 
+	if (type == APPLE_GMUX_TYPE_MMIO && gmux_read8(gmux_data, GMUX_PORT_FSS) & 1)
+		pr_warn("FSS Failure, display tearing expected\n");
 	/*
 	 * Retina MacBook Pros cannot switch the panel's AUX separately
 	 * and need eDP pre-calibration. They are distinguishable from
diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
index 206d97ffd..a4fa84500 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -22,6 +22,7 @@
 #define GMUX_PORT_VERSION_RELEASE	0x06
 #define GMUX_PORT_SWITCH_DISPLAY	0x10
 #define GMUX_PORT_SWITCH_GET_DISPLAY	0x11
+#define GMUX_PORT_FSS			0x12
 #define GMUX_PORT_INTERRUPT_ENABLE	0x14
 #define GMUX_PORT_INTERRUPT_STATUS	0x16
 #define GMUX_PORT_SWITCH_DDC		0x28
-- 
2.55.0

