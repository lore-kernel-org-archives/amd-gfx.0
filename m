Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1CCC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 17:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E5820707
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 17:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppexb1fE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E5820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EDA6E2CF;
	Thu, 25 Jun 2020 17:14:41 +0000 (UTC)
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BDF86E042;
 Thu, 25 Jun 2020 16:51:19 +0000 (UTC)
Received: by mail-lj1-x244.google.com with SMTP id t25so2719776lji.12;
 Thu, 25 Jun 2020 09:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/UdLMEbsDOCR1U9pQ5KV9lzE5YZFu5bOJN7OeGkQDNQ=;
 b=ppexb1fEv8Sukf5p8oW35AQ2df2siKDT8RUubIHYQJDlyShZhvd04ibfyDJSBICwdu
 cqhBwt37T+fJ1T3WNXcxsG/70YEbQ2qK8UfAT3zkHBerQy5oCSwkHGYyK1BJlij2ij0x
 nXWdva+EENVDDUPUM+Ev5/VBwJR1IvXMrsciLTXU9GtqtMGyyYSg47ke13MD939Z3zfB
 lUlm/jM9Kpt+y9EnZQMPbtP9PyN6J+noskAdEQek45b9KT051oNZBIqakk14NLin+OU7
 eDoWPsSPv1j3iHF9NAlFp7h28mgDTeX3ZCgNSwrh56r2oaJJhLrgQTHzc++cf6031HCI
 dScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/UdLMEbsDOCR1U9pQ5KV9lzE5YZFu5bOJN7OeGkQDNQ=;
 b=Z5tUCiuIjKBQsM3adm7pth0e2aPYqQ+iisQYSwJ/CfbaZ+rDagq8/ztyiAMCKBa4+B
 vliBklYnG/6C0aPdpd62jArB2FAZAXG2MckRbSkAN6BT2AaLve8C33kg1sryFBngl4vm
 pV7GTRuQuZqDFAmoSO4kmKgVngC0nBnRQueLGf8kN+kcVbsKrP440/9bRGCQuTiya4IM
 skrd7kEVHU/ANn2URzey96t0bBJyh/j/KFHwFmiNVo0xJUrzJPMQZwO+Q4Lu20a5dCEY
 YU5h82f10CyMC1LnCiZqy8U9eD1Pcyak5BkCYTRJdRzkLfhiDPdhzwRPOOjAZH2LfIAQ
 lXUg==
X-Gm-Message-State: AOAM533pUhHEnLg7i4fEmvsGz53v7zqV9so82fL/W3Z0nbSv84a0zgxC
 JhejWvsjGyS2WaaroVIFCu/yu4LglwM=
X-Google-Smtp-Source: ABdhPJy+x+R/cxt2yvhXQOTLvfn7L5Omua0+PZfhzHADRJgLB5AIxhxHpzbxCSfoANT7Tedy5cE+GA==
X-Received: by 2002:a2e:8e8d:: with SMTP id z13mr5268182ljk.215.1593103877478; 
 Thu, 25 Jun 2020 09:51:17 -0700 (PDT)
Received: from localhost (pool-109-191-188-200.is74.ru. [109.191.188.200])
 by smtp.gmail.com with ESMTPSA id n1sm4914636ljg.131.2020.06.25.09.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 09:51:16 -0700 (PDT)
From: Ivan Mironov <mironov.ivan@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v1] drm/amd/powerplay: Fix NULL dereference in lock_bus() on
 Vega20 w/o RAS
Date: Thu, 25 Jun 2020 21:50:42 +0500
Message-Id: <20200625165042.13708-1-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 25 Jun 2020 17:14:40 +0000
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Ivan Mironov <mironov.ivan@gmail.com>,
 Bjorn Nostvold <bjorn.nostvold@gmail.com>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I updated my system with Radeon VII from kernel 5.6 to kernel 5.7, and
following started to happen on each boot:

	...
	BUG: kernel NULL pointer dereference, address: 0000000000000128
	...
	CPU: 9 PID: 1940 Comm: modprobe Tainted: G            E     5.7.2-200.im0.fc32.x86_64 #1
	Hardware name: System manufacturer System Product Name/PRIME X570-P, BIOS 1407 04/02/2020
	RIP: 0010:lock_bus+0x42/0x60 [amdgpu]
	...
	Call Trace:
	 i2c_smbus_xfer+0x3d/0xf0
	 i2c_default_probe+0xf3/0x130
	 i2c_detect.isra.0+0xfe/0x2b0
	 ? kfree+0xa3/0x200
	 ? kobject_uevent_env+0x11f/0x6a0
	 ? i2c_detect.isra.0+0x2b0/0x2b0
	 __process_new_driver+0x1b/0x20
	 bus_for_each_dev+0x64/0x90
	 ? 0xffffffffc0f34000
	 i2c_register_driver+0x73/0xc0
	 do_one_initcall+0x46/0x200
	 ? _cond_resched+0x16/0x40
	 ? kmem_cache_alloc_trace+0x167/0x220
	 ? do_init_module+0x23/0x260
	 do_init_module+0x5c/0x260
	 __do_sys_init_module+0x14f/0x170
	 do_syscall_64+0x5b/0xf0
	 entry_SYSCALL_64_after_hwframe+0x44/0xa9
	...

Error appears when some i2c device driver tries to probe for devices
using adapter registered by `smu_v11_0_i2c_eeprom_control_init()`.
Code supporting this adapter requires `adev->psp.ras.ras` to be not
NULL, which is true only when `amdgpu_ras_init()` detects HW support by
calling `amdgpu_ras_check_supported()`.

Before 9015d60c9ee1, adapter was registered by

	-> amdgpu_device_ip_init()
	  -> amdgpu_ras_recovery_init()
	    -> amdgpu_ras_eeprom_init()
	      -> smu_v11_0_i2c_eeprom_control_init()

after verifying that `adev->psp.ras.ras` is not NULL in
`amdgpu_ras_recovery_init()`. Currently it is registered
unconditionally by

	-> amdgpu_device_ip_init()
	  -> pp_sw_init()
	    -> hwmgr_sw_init()
	      -> vega20_smu_init()
	        -> smu_v11_0_i2c_eeprom_control_init()

Fix simply adds HW support check (ras == NULL => no support) before
calling `smu_v11_0_i2c_eeprom_control_{init,fini}()`.

Please note that there is a chance that similar fix is also required for
CHIP_ARCTURUS. I do not know whether any actual Arcturus hardware without
RAS exist, and whether calling `smu_i2c_eeprom_init()` makes any sense
when there is no HW support.

Cc: stable@vger.kernel.org
Fixes: 9015d60c9ee1 ("drm/amdgpu: Move EEPROM I2C adapter to amdgpu_device")
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
Tested-by: Bjorn Nostvold <bjorn.nostvold@gmail.com>
---
Changelog:

v1:
  - Added "Tested-by" for another user who used this patch to fix the
    same issue.

v0:
  - Patch introduced.
---
 drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
index 2fb97554134f..c2e0fbbccf56 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
@@ -522,9 +522,11 @@ static int vega20_smu_init(struct pp_hwmgr *hwmgr)
 	priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].version = 0x01;
 	priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size = sizeof(DpmActivityMonitorCoeffInt_t);
 
-	ret = smu_v11_0_i2c_eeprom_control_init(&adev->pm.smu_i2c);
-	if (ret)
-		goto err4;
+	if (adev->psp.ras.ras) {
+		ret = smu_v11_0_i2c_eeprom_control_init(&adev->pm.smu_i2c);
+		if (ret)
+			goto err4;
+	}
 
 	return 0;
 
@@ -560,7 +562,8 @@ static int vega20_smu_fini(struct pp_hwmgr *hwmgr)
 			(struct vega20_smumgr *)(hwmgr->smu_backend);
 	struct amdgpu_device *adev = hwmgr->adev;
 
-	smu_v11_0_i2c_eeprom_control_fini(&adev->pm.smu_i2c);
+	if (adev->psp.ras.ras)
+		smu_v11_0_i2c_eeprom_control_fini(&adev->pm.smu_i2c);
 
 	if (priv) {
 		amdgpu_bo_free_kernel(&priv->smu_tables.entry[TABLE_PPTABLE].handle,
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
