Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80D606A323
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cm8FOXnu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194EB10F0CB;
	Sat, 14 Nov 2026 19:11:02 +0000 (UTC)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C0310E6D8
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 16:08:43 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1b3b4bcbfc9so2125964c88.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 08:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672523; x=1795277323; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GtGLStqV/9gomKNOwdwCe8z1kLFSUJF9rkzKgx7PnnM=;
 b=Cm8FOXnu6korQovECplv+zE760xep6JOxhQnurMkU8l7Kt7Ri3Zx0vzMcooBI04Yu2
 21bYMjhXTueBJfvEVovmOM+kXrA6g/7KJl8C5qZ2H5rAS923AcKbooVFBXdo3saRdxFi
 ag7E+5EDxdxE9RzS5NirpMzDEc+4ym1hhm+3zKL82HDRhgEZWjFD1b5kL8i9cgpKg8Gs
 Pqj9xkcLFdp7lPU+yee8FzNkloCOCtfWVDCv0QkFtSjDoCagcRw+2go/cCA9A+l48CxS
 EP49+Jv3M4czK7otG88q4fNP2gxp1S+xi2iZju5vi2z114/J1yfrv5brT+xQUXG4n9xY
 RG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672523; x=1795277323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GtGLStqV/9gomKNOwdwCe8z1kLFSUJF9rkzKgx7PnnM=;
 b=q+HgRl9xn6DlcNGCpsGWrAt+3smlA2CMYOWM6RddPvPlBbeM+RyoHC9JDcS/glFKo/
 F9656UHXnM5zePuRyLDR6oIOBKgQNSGnqebczHRgiOTI/qyYQKCRzRgAWwpKe2AW13Gm
 nLIuSCNzFZOwNt0WkORWxzXcsT2CErP2YNY9SgQq9tZcnqNE5gkeLz3Tu4MU/carSr7P
 971EfeYMNefxgQ4TpzZX7cja2FEUs1yQqVvPZcVfxdN6fQgRi4wQOVEPabcHY8KO8At1
 ezEH1DA0N45xf01owVVeN8wsgO2aHm9B/x0Ft+gMUjTPiOgxRTlx7mgsAbh6o6pK+U4j
 Lp/Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFueihD1w7D64hc6lS8wRKvBjPFEMUl72lQa9G65NzRtID58sAwFvk4FN499+0RjhnbxhqdtJZZ@lists.freedesktop.org
X-Gm-Message-State: APuU4Z99txTHji+OuIHAONMX6q0egUAdLDAeB2IX+I6bqPGViJqWfZgb
 KLg3/gBrKm6YcDApOnp8nr8t+NlJPiAS0zXExQ8nRNY9BAVH09UKEHI=
X-Gm-Gg: AYBFou2QAlMcNmWzJkhGHxAtRwWNNhmvQ/mdlk/GpUGysc8bSG437/LjWraKH9eqL6c
 aYzQoVoKiTUW44KYP3oyt9LbUb+FfZhu/WjqY/NjZdQdR4Ic6BOtnAM56FZI6LkiWHa1semRfH3
 cXK+8xFYHkyNCwT6OTUAW8ge9Ccd6zKJEFZEWPkavK4xzAbhbReYlY0gAp4caZmqSpF+QW+M0tY
 WNvcCUH1qXDzcsEnsAy+8WeT3bRMMKo1kR88sPzOrjjz59oX5AxNgnyNyHE1/giiGI19sqgR/Sn
 N6of9dmgOYDHjmWhD7XrRpxCsV2SQey7CtfTTnoVPj6a2F/M0Ppqxs63oOpN11OeAlXqqw5KuE0
 BMcn8YfJIKDZThRR3bT86DGAlCQfABOoG/Qof2x/NhTDSjUAotnA5UvLryCfb36IsR2gAQEegAv
 7BXrJ7ObQhQTSFU4u8E4xKBcS8CSJKk2t6Jxu9nCE5frmAhMPOnKEFXbWVTIvlu1LADR0L73zYy
 sAHGPEpq2wjO9q5TnyC6j4tzuYQQa8jr/TWoZzbX79w0t6WryiGsvokmbQ1gCOtIOOc9F8xUWIo
 0yn8mkaZsb0F2QQ137Pb338VI6lU6/0lxtjg+QWk+CI5l05iUzJ29pNuwHBhfKFZMvfJxhcLDX3
 d5+p2OB+jHdY=
X-Received: by 2002:a05:7022:1081:b0:154:e9d2:d741 with SMTP id
 a92af1059eb24-1b503112e3amr4894890c88.8.1794672522574; 
 Sat, 14 Nov 2026 08:08:42 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:08:42 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Sebastian Zygadlo <szgit@icloud.com>,
 Yossef Osman <yossef.osman@proton.me>, Andre Eikmeyer <dev@deq.rocks>,
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
Subject: [PATCH v2 03/12] platform/apple-gmux: Fix MMIO interface
Date: Sat, 14 Nov 2026 11:06:27 -0500
Message-ID: <20261114160731.3756-4-atharvatiwarilinuxdev@gmail.com>
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

This patch brings a lot of fixes to MMIO interface such as:
1. Using 1ms waits instead of 100us.
2. Checking if Timed out before reading and writing
3. Adding missing wait before gmux_mmio_write32

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 60 +++++++++++++++++--------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 34e94f2b2..9625551e5 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -235,8 +235,8 @@ static int gmux_mmio_wait(struct apple_gmux_data *gmux_data)
 	u8 gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
 
 	while (i && gwr) {
+		fsleep(1000);
 		gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-		udelay(100);
 		i--;
 	}
 
@@ -245,15 +245,16 @@ static int gmux_mmio_wait(struct apple_gmux_data *gmux_data)
 
 static u8 gmux_mmio_read8(struct apple_gmux_data *gmux_data, int port)
 {
-	u8 val;
+	u8 val = 0;
 
 	mutex_lock(&gmux_data->index_lock);
-	gmux_mmio_wait(gmux_data);
-	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
-	iowrite8(GMUX_MMIO_READ | sizeof(val),
-		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-	gmux_mmio_wait(gmux_data);
-	val = ioread8(gmux_data->iomem_base);
+	if (gmux_mmio_wait(gmux_data)) {
+		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+		iowrite8(GMUX_MMIO_READ | sizeof(val),
+			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+		if (gmux_mmio_wait(gmux_data))
+			val = ioread8(gmux_data->iomem_base);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 
 	return val;
@@ -263,28 +264,33 @@ static void gmux_mmio_write8(struct apple_gmux_data *gmux_data, int port,
 			      u8 val)
 {
 	mutex_lock(&gmux_data->index_lock);
-	gmux_mmio_wait(gmux_data);
-	iowrite8(val, gmux_data->iomem_base);
 
-	iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
-	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
-		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+	if (gmux_mmio_wait(gmux_data)) {
+		iowrite8(val, gmux_data->iomem_base);
 
-	gmux_mmio_wait(gmux_data);
+		iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+		iowrite8(GMUX_MMIO_WRITE | sizeof(val),
+			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+
+		/* We already wrote the value there is no point to check if timeout */
+		gmux_mmio_wait(gmux_data);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 }
 
 static u32 gmux_mmio_read32(struct apple_gmux_data *gmux_data, int port)
 {
-	u32 val;
+	u32 val = 0;
 
 	mutex_lock(&gmux_data->index_lock);
-	gmux_mmio_wait(gmux_data);
-	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
-	iowrite8(GMUX_MMIO_READ | sizeof(val),
-		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-	gmux_mmio_wait(gmux_data);
-	val = ioread32be(gmux_data->iomem_base);
+
+	if (gmux_mmio_wait(gmux_data)) {
+		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+		iowrite8(GMUX_MMIO_READ | sizeof(val),
+			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+		if (gmux_mmio_wait(gmux_data))
+			val = ioread32be(gmux_data->iomem_base);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 
 	return val;
@@ -294,11 +300,13 @@ static void gmux_mmio_write32(struct apple_gmux_data *gmux_data, int port,
 			       u32 val)
 {
 	mutex_lock(&gmux_data->index_lock);
-	iowrite32be(val, gmux_data->iomem_base);
-	iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
-	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
-		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-	gmux_mmio_wait(gmux_data);
+	if (gmux_mmio_wait(gmux_data)) {
+		iowrite32be(val, gmux_data->iomem_base);
+		iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+		iowrite8(GMUX_MMIO_WRITE | sizeof(val),
+			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+		gmux_mmio_wait(gmux_data);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 }
 
-- 
2.55.0

