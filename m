Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E817C636D3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 08:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CFF10EC84;
	Fri, 10 Feb 2023 08:04:08 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5033B10EC55
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 04:51:17 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id b1so2772593pft.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Feb 2023 20:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5Ha95DZYK/aP/j52BgmRVv3D+Ht1XBi+RBwbRpPJAA=;
 b=jeRCbikd0l+NYcX61eSocwQ1WUxxnAWy9jXktGeo2f1Ks/WWMN6X5HONHK7QeGRFVt
 iOUduMbJJxxI+2VxjAve5WkgVa4Z8HQaJBB2RcPWhn9YEPeT1sC2wS0FJVXrcYX9rxuA
 Tn6jmBhZ2gZC8wfNCWtA8AtXpd5hbTGVhN/DYmqHGTf0a4gt1sTPPQUBMAzsmYB0YX+I
 d8Ee/B6UJqkuoQgF6ommsJa/FZIrubLdFKhd1po/LM+Zq0QPNY35bBSY9MRxn9TiBdWW
 TaE0Dw6cX55x7gagXpw485WSPfiwCzg6t2bL883xOej+5KbppjICobrr2oOeAvOAbz6C
 exQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5Ha95DZYK/aP/j52BgmRVv3D+Ht1XBi+RBwbRpPJAA=;
 b=VDL2KDDgKJEVtRAXe4xv2sGAKXmCqpjivbUMayysE994M3W3g9GO/eMurJ/QJBIAVy
 5kymLDc12dUjEwH4/GodqouB6NvkNTggUtKFuEyoKahJ55N7aaw9XmDnz4/GFbV40gjn
 y2PLjMLhs6ykcYj5jeqjH8cumWrQwEWqJX51lKFdj7CFMbraeBnofM4Z8Aw5wcx/nxBi
 7TTfJbdTIsBqsJ/RsI8UI4yaGXpdSMXbmyx3afrkzUlH0Yb3hwOZ4UzTz5wOJAolgwGF
 6YRqWE7n6/LGewy1TZSZQ4Ph08Wghr80sCkomQvsV0QNfEVFCJwHw42NZWg+tFBKHHbc
 blCg==
X-Gm-Message-State: AO0yUKWUJKfj4Z42fBs4IxgL+1eIz9Uft42AM7JMdvIftRaM9MSVoDyZ
 StSmOUt0W98rqbsDCVZBj5g=
X-Google-Smtp-Source: AK7set8TZvXWIyGcQ3NgifffV8KYbOTEXt34sxsX5/J/r2MfeRhwM5bCgQOPxLHbQqGiay9vdFRZTg==
X-Received: by 2002:a62:6d85:0:b0:590:7616:41eb with SMTP id
 i127-20020a626d85000000b00590761641ebmr10365952pfc.30.1676004676892; 
 Thu, 09 Feb 2023 20:51:16 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Feb 2023 20:51:16 -0800 (PST)
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
To: platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH 8/9] hda/hdmi: Register with vga_switcheroo on Dual GPU
 Macbooks
Date: Fri, 10 Feb 2023 15:48:25 +1100
Message-Id: <20230210044826.9834-9-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210044826.9834-1-orlandoch.dev@gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Feb 2023 08:04:04 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Rander Wang <rander.wang@intel.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Evan Quan <evan.quan@amd.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Kerem Karabay <kekrby@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Jack Xiao <Jack.Xiao@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 Takashi Iwai <tiwai@suse.com>, Aditya Garg <gargaditya08@live.com>,
 Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Commit 586bc4aab878 ("ALSA: hda/hdmi - fix vgaswitcheroo detection for
AMD") caused only AMD gpu's with PX to have their audio component register
with vga_switcheroo. This meant that Apple Macbooks with apple-gmux as the
gpu switcher no longer had the audio client registering, so when the gpu is
powered off by vga_switcheroo snd_hda_intel is unaware that it should have
suspended the device:

amdgpu: switched off
snd_hda_intel 0000:03:00.1:
    Unable to change power state from D3hot to D0, device inaccessible
snd_hda_intel 0000:03:00.1: CORB reset timeout#2, CORBRP = 65535

Simialar to ATPX, we use the presence of an acpi method (PWRD in this
case) to ensure we only register with the correct devices.

Fixes: 586bc4aab878 ("ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD")
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 sound/pci/hda/hda_intel.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 87002670c0c9..c97bbe60e603 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1435,11 +1435,25 @@ static bool atpx_present(void)
 	}
 	return false;
 }
+
+static bool pwrd_present(struct pci_dev *pci)
+{
+	acpi_handle pwrd_handle;
+	acpi_status status;
+
+	status = acpi_get_handle(ACPI_HANDLE(&pci->dev), "PWRD", &pwrd_handle);
+	return ACPI_FAILURE(status) ? false : true;
+}
 #else
 static bool atpx_present(void)
 {
 	return false;
 }
+
+static bool pwrd_present(struct pci_dev *pci)
+{
+	return false;
+}
 #endif
 
 /*
@@ -1461,9 +1475,12 @@ static struct pci_dev *get_bound_vga(struct pci_dev *pci)
 				 * rather than the dGPU's namespace. However,
 				 * the dGPU is the one who is involved in
 				 * vgaswitcheroo.
+				 *
+				 * PWRD is in the dGPU's ACPI namespace on Apple
+				 * Macbooks with dual gpu's.
 				 */
 				if (((p->class >> 16) == PCI_BASE_CLASS_DISPLAY) &&
-				    atpx_present())
+						(atpx_present() || pwrd_present(p)))
 					return p;
 				pci_dev_put(p);
 			}
-- 
2.39.1

