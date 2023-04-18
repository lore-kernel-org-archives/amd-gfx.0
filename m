Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A65C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 13:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3AB10E9A5;
	Wed, 19 Apr 2023 13:25:21 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C303C10E3BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Apr 2023 22:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uA6P+8Hkrzo+D0+qPODF3BQfuZv/J+mQAU+Dzcl5MQc=; b=cmUMrnUeenYwfKDF4cFVPTRe/1
 t6p9MLU/246fi5J2DzE4LPWbg9l8HOAPIGN1ON7xlUC9sa5TdiEP7Xh/U7W7tdxmgiMRl5h+gM+/y
 zS0WFjqu/BoMzqU/N4Z/ZFAOLdd0K9YhY+Y7VGrlsSrGVocWr5VFcyWjNQE4xy/Ern0ChCQT9ClUX
 KWFANSmSSoSqczAyu4lr+Te51N6U/7PDENDSmW69OaLXMfvT5NisC2psUppznHHrL6XGqJYdRmycz
 ltXI/1sC893MKimUH7treA0yztdhQCSvTdt4Rdm3+PcirNOwQYu2N+0szUWhGgfDIozBHBqLlq3Q2
 Xdsc6CuQ==;
Received: from 201-92-79-199.dsl.telesp.net.br ([201.92.79.199] helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1potbo-004Qxi-6G; Wed, 19 Apr 2023 00:15:33 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] drm/amdgpu/vcn: Disable indirect SRAM on Vangogh broken
 BIOSes
Date: Tue, 18 Apr 2023 19:15:22 -0300
Message-Id: <20230418221522.1287942-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Apr 2023 13:25:18 +0000
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
Cc: sashal@kernel.org, gregkh@linuxfoundation.org, kernel@gpiccoli.net,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, James.Zhu@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

commit 542a56e8eb4467ae654eefab31ff194569db39cd upstream.

The VCN firmware loading path enables the indirect SRAM mode if it's
advertised as supported. We might have some cases of FW issues that
prevents this mode to working properly though, ending-up in a failed
probe. An example below, observed in the Steam Deck:

[...]
[drm] failed to load ucode VCN0_RAM(0x3A)
[drm] psp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0000)
amdgpu 0000:04:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring vcn_dec_0 test failed (-110)
[drm:amdgpu_device_init.cold [amdgpu]] *ERROR* hw_init of IP block <vcn_v3_0> failed -110
amdgpu 0000:04:00.0: amdgpu: amdgpu_device_ip_init failed
amdgpu 0000:04:00.0: amdgpu: Fatal error during GPU init
[...]

Disabling the VCN block circumvents this, but it's a very invasive
workaround that turns off the entire feature. So, let's add a quirk
on VCN loading that checks for known problematic BIOSes on Vangogh,
so we can proactively disable the indirect SRAM mode and allow the
HW proper probe and VCN IP block to work fine.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2385
Fixes: 82132ecc5432 ("drm/amdgpu: enable Vangogh VCN indirect sram mode")
Fixes: 9a8cc8cabc1e ("drm/amdgpu: enable Vangogh VCN indirect sram mode")
Cc: stable@vger.kernel.org
Cc: James Zhu <James.Zhu@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

Hi folks, this was build/boot tested on Deck. I've also adjusted the
context, function was reworked on 6.2.

But what a surprise was for me not see this fix already in 6.1.y, since
I've CCed stable, and the reason for that is really peculiar:


$ git log -1 --pretty="%an <%ae>: %s" 82132ecc5432
Leo Liu <leo.liu@amd.com>: drm/amdgpu: enable Vangogh VCN indirect sram mode

$ git describe --contains 82132ecc5432
v6.2-rc1~124^2~1^2~13


$ git log -1 --pretty="%an <%ae>: %s" 9a8cc8cabc1e
Leo Liu <leo.liu@amd.com>: drm/amdgpu: enable Vangogh VCN indirect sram mode

$ git describe --contains 9a8cc8cabc1e
v6.1-rc8~16^2^2


This is quite strange for me, we have 2 commit hashes pointing to the *same*
commit, and each one is present..in a different release !!?!
Since I've marked this patch as fixing 82132ecc5432 originally, 6.1.y stable
misses it, since it only contains 9a8cc8cabc1e (which is the same patch!).

Alex, do you have an idea why sometimes commits from the AMD tree appear
duplicate in mainline? Specially in different releases, this could cause
some confusion I guess.

Thanks in advance,


Guilherme


 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index ce64ca1c6e66..5c1193dd7d88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -26,6 +26,7 @@
 
 #include <linux/firmware.h>
 #include <linux/module.h>
+#include <linux/dmi.h>
 #include <linux/pci.h>
 #include <linux/debugfs.h>
 #include <drm/drm_drv.h>
@@ -84,6 +85,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 {
 	unsigned long bo_size;
 	const char *fw_name;
+	const char *bios_ver;
 	const struct common_firmware_header *hdr;
 	unsigned char fw_check;
 	unsigned int fw_shared_size, log_offset;
@@ -159,6 +161,21 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
+		/*
+		 * Some Steam Deck's BIOS versions are incompatible with the
+		 * indirect SRAM mode, leading to amdgpu being unable to get
+		 * properly probed (and even potentially crashing the kernel).
+		 * Hence, check for these versions here - notice this is
+		 * restricted to Vangogh (Deck's APU).
+		 */
+		bios_ver = dmi_get_system_info(DMI_BIOS_VERSION);
+
+		if (bios_ver && (!strncmp("F7A0113", bios_ver, 7) ||
+		     !strncmp("F7A0114", bios_ver, 7))) {
+			adev->vcn.indirect_sram = false;
+			dev_info(adev->dev,
+				"Steam Deck quirk: indirect SRAM disabled on BIOS %s\n", bios_ver);
+		}
 		break;
 	case IP_VERSION(3, 0, 16):
 		fw_name = FIRMWARE_DIMGREY_CAVEFISH;
-- 
2.40.0

