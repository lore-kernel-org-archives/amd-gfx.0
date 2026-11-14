Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106FB606A32E
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aGis6+wC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC3A10F0CD;
	Sat, 14 Nov 2026 19:11:13 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8877C10EB27
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 16:09:54 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-37986eb6fa2so1681179eec.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672594; x=1795277394; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jd91Zwd/kmiwKW4+PLimd5fenaYkPvHETCW1wh847os=;
 b=aGis6+wCi9s1WY6EOuvi2wDyICRuCvtwg7tZU3DWs4SyrTF/m7e/I7zV8ZgrQ3gjNP
 wE550Mwwx8iJ2xiD3xCGHDBuZUu1RhG2kS4jTpt/iu+ZQhzrzZ6MNaKfmcTyCLst8sBQ
 R6erYzvlbzkG/h1Uz4Kx8LPKl/f5jxLgVh76paHITWLEA/69vLPzUuwXG459y3EDs5x/
 lfyfoHGlzxhrxB4xHSUP+xQZcQW4duqiXeIzHaKX96ujM5dGtDiORGRGbox9N/nWlVfF
 4/XZTcjLcjNU5eq1oxcMxLNhjQzlpQxvNvPlZBDbD5l7Yt0yO+JmM3YvcLcnMO8KLo4t
 0anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672594; x=1795277394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jd91Zwd/kmiwKW4+PLimd5fenaYkPvHETCW1wh847os=;
 b=THKCqoN+zrZnMS2s9+VdhFCAdQpeTPUeH1eFmI9XPibUkMKm8s0AX2UI9YPSLhTWj8
 TsULrxogI8rt9pPfWtGdRooh+uznFjaYewImUIwIPM2zxdsyOOGgKpB+iHxqgGJT7kYd
 cRH1ifhGhJZILegOcoZh9wWYGiVs/SvcONu9MypvstmF8EwV1fG0WVPwx5gYOQRDQnRG
 MktG5YNYe9U01LbyauIdEAWunPWlIlalNF0QNE/gM5qgWS9AUa5dijh+mOyrnMAehpva
 kPOPjRAMDc1IoA98zBkWpkx5JSBqWt4iCvbL0WdZfW6xlbc70ZSHMF5toEceIbvvMF5n
 u/rg==
X-Forwarded-Encrypted: i=1;
 AL+hErGynGWOMUov7m/Lih++y/JsMp26bUS72wdKGrocBkvCtNZaDi4+mdU3GrRyd6ZsS+BVaPdSmWg/@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+wWZ18OAWS9ScoWDuyTa/XenbN5Imj10s25Gfz5SCHdwxBPfiR
 TsjfyPNXgz4Emu2I3OjBQeDh+xZiEE+ijjxfox36G8PN3jvbmzgNJ8k=
X-Gm-Gg: AYBFou01MDBBhzkywdCCbc4/Xr/yibOH0YV8/GenYrGKSljInxjab88g3PaYh1ik/md
 /XLpdLtuhXLYIgxJ/8IlhkyYpyeF0R2U3zFwHJY349WjHnFpP5bWflJG5z25n9Lr4C41yauOC8H
 w0vL4YxPtld8iRwGdXdPj1x7HNfyfarFzGbtgXmNU11Bo05m5fRsZeU64JPKi7evmaKIKePs34n
 zmgzraHvOsxBrwLFnQSUC4uy1v1XWVBj+ZYfRrNlxbUPK0XpElfKxx1MQgMOP5DiA100J+dhnVk
 WBXSYMtbSSqYK6pZK2KyGaK3p2LCDWYfhdxO20NUes1S5zv4TVmukEwPuWO30QZ2Qx5Eh58QGLB
 P2PwtS4mdPkO8BeP/BUyOHrsYmbbEsyrY2n6BtTSTQHQ1rddjY65dpnymDtTdymQgfqzjqGJVrf
 hYv25N9ErnHnj74S95H/bxUo9sNKj1Ut+pAGWJmK+aBo6+vCk9hoM4NKEoCeQSyi3SRAhBEv6vf
 NkTV+Y4FISeX53P9TnygSCEpDubm7jQ5v4EsC5ATp1y77NdH+iBFUV2rqrpEvN/vHyiHMxZEO/7
 BUUUMHL167Ky8qpjVy5zNmqbALwylwM1o6QtilgD7BbEU1uREnsksji0X2cWaSXrMrJ2st6z13X
 HrD9x32Keaqo=
X-Received: by 2002:a05:7301:4d16:b0:36a:1d6a:596b with SMTP id
 5a478bee46e88-379675feb32mr5897107eec.29.1794672593531; 
 Sat, 14 Nov 2026 08:09:53 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:09:53 -0800 (PST)
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
Subject: [PATCH v2 07/12] platform/apple-gmux: Add documentation about iMacs
Date: Sat, 14 Nov 2026 11:06:31 -0500
Message-ID: <20261114160731.3756-8-atharvatiwarilinuxdev@gmail.com>
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

Add documentation about iMacs

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index a1b7a4709..4f5c98445 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -444,6 +444,11 @@ static const struct backlight_ops gmux_bl_ops = {
  * switch the panel and the external DP connector and allocates a framebuffer
  * for the selected GPU.
  *
+ * There is iGPU present on iMac's aswell, and we can enable it using apple-set-os.
+ * But there arent any display lines going from the iGPU to the display. iGPU is only
+ * used for offloading then, it makes sense as iMac's display are massive (4K or 5K).
+ * A integrated GPU won't be able to handle that.
+ *
  * .. _US 8,687,007 B2: https://pimg-fpiw.uspto.gov/fdd/07/870/086/0.pdf
  * .. _NXP CBTL06141:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
  * .. _NXP CBTL06142:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
-- 
2.55.0

