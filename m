Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E93D606A32D
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xhm2PQ+g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3BDF10F0D9;
	Sat, 14 Nov 2026 19:11:07 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 705C710EA56
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 16:09:40 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-36f8cdd30beso2135194eec.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 08:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672580; x=1795277380; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Ir5z9ASuMHPvYC0aOx9GZ500HHk9wmpAKRwADGNQH8=;
 b=xhm2PQ+gT7RYFU34q2hgnLG141gGvb8vIR3Jfo10yXHMyuFMpMQL0LmMSaYz0ZI5xZ
 OkQK5yFZVcpGom9fuJ0JpbUD2HTs1riDj8Dyx3Qy4ZDaI64yh8rM4hmtlOjuIgqE9Ngu
 vnr4ayLIPfa8Vyhuxuxp56cPO/AGWVT/6UJdNnpU3LvQ3FGKv9EzpdhMYL8THZM7XUzm
 hQB+bjODeQPiyJbRjK3IpETZh65cEwMdR6kx9FnBUXmIBtZ+4cj3Pi6MBTROMOOfLymG
 yvRsJZgvjNMo0d73HEtxRasn/5id4/lpkI5CdpYsKM3DeaVi7nuwhCFVsYiZu5/zEqzh
 5ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672580; x=1795277380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Ir5z9ASuMHPvYC0aOx9GZ500HHk9wmpAKRwADGNQH8=;
 b=MhmFHioDYlM7hxNGNvnnUhtLVcXMZs1vkD62YtgRA0q1l6ZtdtCh38k165K+rW0mOv
 tBfqhtHFQtpG7p8c2L5G8GpGrJLkr25tg74FD6OsrXTiQg5dtA/XEuKW/9BjBz02CMd7
 1Hn0iJpka6xmn1yPvuSF2slRKm73hG7Rt9XU262YHrpkKk1U6NYw3545Q+XYlLZicv/a
 IWeN0Qadyi6zT/9av/Dy760hzNWoe1ol6iwQi5GiNFWkF1KvDyTj/ogs7uRxyIzBEId1
 qNVI0yTTnwKwqyyE3pE+JXjMSqyQzEKtKRFMe6NK6dG7zKMaBsDwsnDtpR47gt/emmL7
 2Elg==
X-Forwarded-Encrypted: i=1;
 AL+hErEWAhVBMQpaySc8i0ap3stN8zMJO1jJ1h5Ip5Srs29IQI5k4Ci82WvY/vUn7+qs/oH/pjrVZM0U@lists.freedesktop.org
X-Gm-Message-State: APuU4Z92Y5gD6Ebjv++34JcJFTOPMgYfHIntp8fsewejG7yLXIUr1bs9
 SLXBaBUzvIzxLM+7bVMA/1T9tjhDqJ46thB4rOhHU/tXTpYHzHuTK9g=
X-Gm-Gg: AYBFou2Vjou8Q7BDnghqm2u1Lsfuv50mLV7/+cLIrhvpDCZLsu1Ccg1UklBH18al0Y+
 p8mNAEXfaZHkJ9U1Y5eRcm1keETWnjsehEi5b+f0XI7VQKcHfHaGRuDlmKgav5i0jLQyZ7ICNJ5
 whDWU3h+UbFZ7olyZwNf9kGkSfwSQ9UHb5vvEJyj8C+DQvb3cVFDTkjucgwieuh8pgpz6dpzWrw
 gim/dHgoABpcJF1XuHmk5uGMF182JEbA8LkVh0EsmyvcgHAXpfZwl3SHP7JSOwmPm+mWp++K5cI
 czqFUfQ5Jj2DHsBO0+K/6gMiMr4yYz09UCfcX1dlcUQiqf+XRjH1aUKpXB8WPnq6pgTVVa/kG+r
 fHjgGVHB+WiklJC+CPyefFA7hQQLsMPHhj7pDGoJQsov9Wjea2ElBRuHMK7nr5KE05PD1cfkSIu
 EgFsKpi+hlg5hQQDLNYEwiVowP0Ip5hrJwvrWJtmDgFNAuU5p50gL/6a5wzc9NWj3zU9zsIrjCE
 Vxi1PYgw2HiMI99tdGfbpQcQfxMFanH29y2/atk8xSiMBcT+9AFIiCNMpM8GogBkYxKSjmmOD8y
 qRrmeXPXKKGNu9/fxkeOaCoD3VWZ+g1jLy5Hhcpy8Hju5iHrNCUQRS4BHkASArZzscU=
X-Received: by 2002:a05:701b:4648:b0:19b:1202:77f8 with SMTP id
 a92af1059eb24-1b503192303mr5750642c88.32.1794672579670; 
 Sat, 14 Nov 2026 08:09:39 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:09:39 -0800 (PST)
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
Subject: [PATCH v2 06/12] platform/apple-gmux: Add check to detect FSS
Date: Sat, 14 Nov 2026 11:06:30 -0500
Message-ID: <20261114160731.3756-7-atharvatiwarilinuxdev@gmail.com>
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

On MMIO macs, there is feature called FSS, we assume its
a display syncing technology between internal links
(for example 5K iMacs).

We detect it and then warn the user about it, if its broken/unavailable.

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 2 ++
 include/linux/apple-gmux.h        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index c4a953b5b..a1b7a4709 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -1196,6 +1196,8 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	gmux_enable_interrupts(gmux_data, 1);
 	gmux_read_switch_state(gmux_data);
 
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

