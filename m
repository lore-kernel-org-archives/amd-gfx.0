Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F899606A327
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rl0RAIDa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 976F810F0C4;
	Sat, 14 Nov 2026 19:11:01 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E65F510EC98
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 16:11:23 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-36f6295304dso1709391eec.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672683; x=1795277483; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kYhEGps0UomI4ThdCaZM/6xhr977LUTH98N7MCn1AQg=;
 b=Rl0RAIDa3oUmQhbTfxk1bZ/f+szCzAqun2NG1I4IctUi1r3Pvk7hhN+o+/SPXvN6aU
 QLEXmhJt29WqxyovuzzGCplk7GRz804eQR3fyHJ1Vm2mCj5QwvF31fCp+sxQcpfD6YUG
 8qD7qUhuOqmto3whBv6EC5+pUvIFE36VjwvcOXdmXV1kdbKEDY+mBqX45cFTOP6Oq2LJ
 WSXyZ9Pg0uWS65YmWfImP6RigIga9wJIWLuST37sYwAE+cGP8lUFnIdI45QL2JG5WMGU
 gN3PMStPcr7g6t2F42829PJc55LPyODbKaQ16hcYmzuXx1+udlYvLSP7yUquGNVzAf5I
 /KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672683; x=1795277483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kYhEGps0UomI4ThdCaZM/6xhr977LUTH98N7MCn1AQg=;
 b=KBsu0Xm7AiPZ8z/PQwGPq41ZEyp+1a/+BCVkchsw3AGZos8sRi1Tptin8A8DsqoOUG
 236NrxOMzNuSV0ouvWwDe8/l3Bcr/NPGY3G1v3pwDAbCjp5aXC46h2Qp48imYrIdJNJv
 3wVTPQcTlbakBny/zjTxgeqACN50CrOFY6pX+sAu8gtGmmqUMY89azACpSfoWc+D69mX
 D135hV6/pM4O2aQGX+ppAEzKtUtElWtWQTDJFIYkEZUlQazYAPLpMnwgRhBIitKIIrxQ
 gwPCn7BaoGvnhdasO2LuT8sEuPtW3qjStao2q3wTrX9ybMQvwIYZNdvqtlu7/MYmpxPG
 MnoQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEgg/n7CNlJT0fVgrWhKRQDoZ1iqtRgkmWY/ntQ/qeuii2+Qp9Oaeo+jMOJoQZhXVlTYx/4muyg@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9aHZcO9RP8c+B4BWlQzIbRGzWghiIhCIyJQQT2D+QbbGf1mQg+
 laZHYEPen6TZaMWp3v2e2w6zKjxjXdXwdG3N2To3GtOoRa6+Vzi344w=
X-Gm-Gg: AYBFou0yrpGBXXT7AZg+k52MMrwL7aRfNVK+xBkTtKuxtN/dcJuH1V81ZBiekljJ5cJ
 e2pm+2AaWONLPXy5hwgJIAo0Xc0pxyGVvR7PLUW+nEvLgaH9sQQGmNJAmG1UcKlzKALVqLDz534
 pDgY9yY8prkBRsvdc9oSila44faL+OkSdiIo5BFV2izBePFJg/Tz9VU3USMQeG2KQQB2+OZ6y5Z
 D0V7nwy2YE+yxt5vLhyw6pSIgiZZM2gGoss/YWlX3xO5izSz+YdwcjL/LxEz+OTFQ3KH8gYnUpn
 eQLXrhwydSLcOQtFiFJsV7PqF7hdcKNzGIuPABSxDyiOyXtip5xU8kZQECyUiLrjXGGM8hbj3HJ
 8rJcVh0gUt/mX0tzuX9/qMHiQSGRUW1rBOOP3xSe4axaWoA3GfBtlNEgBYM79S1DQmWQxhyGW9k
 Mz/pbX4TBVgpUcnx7+LfR7Al2dN/HgnYn03WvmAHUdAw3I6vDrCHHCAJDZ/HgtiO4x9zQy83jpX
 jBDX8yP6hLlQpUyxB8q8hHViPbAt7sX34zohv/mLc69BBA8jT9gA725WkCpMsmHGgNhPijYk82F
 B5guCDQZUPdt/Zr4Y4s1IlV2y4It8erniHGZhK9jE3FFxFuvuje2UH+VG9b8Aabw6g==
X-Received: by 2002:a05:693c:8115:b0:36a:1008:5815 with SMTP id
 5a478bee46e88-37963372d85mr5904580eec.5.1794672683015; 
 Sat, 14 Nov 2026 08:11:23 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:11:22 -0800 (PST)
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
Subject: [PATCH v2 12/12] drm/amd/display: Skip panel power savings on eDP
 links without a panel
Date: Sat, 14 Nov 2026 11:06:36 -0500
Message-ID: <20261114160731.3756-13-atharvatiwarilinuxdev@gmail.com>
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

When GMUX routes the internal panel to the integrated GPU, the eDP link
of the AMD GPU has no sink. It still exposed panel_power_savings, and
tuned writes it on every switch between AC and battery. Each write sends
a hotplug event and the following connector probe runtime resumes the
GPU that GMUX had powered off. Only create the attribute when the link
has a panel.

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 3 +++
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 703d0617d..c8fbd2167 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -761,6 +761,9 @@ amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *amdgpu_dm_connector)
 	if (amdgpu_dm_connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
 		return false;
 
+	if (!amdgpu_dm_connector->dc_link->edp_sink_present)
+		return false;
+
 	if (link->panel_type != PANEL_TYPE_LCD && !link->panel_config.cacp.cacp_supported)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 7ca17f803..d71f5e5da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -52,6 +52,7 @@ static void setup_test_connector(struct kunit *test,
 	fixture->aconnector->dc_link = fixture->link;
 	fixture->aconnector->base.dev = &fixture->adev->ddev;
 	fixture->link->connector_signal = signal;
+	fixture->link->edp_sink_present = true;
 }
 
 static void setup_test_dm_ddev(struct kunit *test, struct amdgpu_display_manager *dm)
-- 
2.55.0

