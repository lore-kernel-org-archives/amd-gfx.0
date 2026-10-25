Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A244606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WEcTjWaZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13E310ECD8;
	Mon, 26 Oct 2026 08:44:18 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B0C10E680
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 04:04:09 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1438d9363fbso1478496c88.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Oct 2026 21:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792901048; x=1793505848; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HlYNTG1YeavwC+hNZqZ9gnXD5hsIPEAX4XNijQPWf9E=;
 b=WEcTjWaZxZh8WyqZsmt4ane309t5BOigBarL+fJw7J7i0d+xUShAKMaMLvHYf9pDk2
 5wybFT9VSpZfxwPoroWCC2mBBG4PBQk3J18XDc57Ko+0KvWhUQec53CAWRLL+6CwjRhT
 23vR5oKLSJZdhd2viPtjUQqQpbc5dPih0GbCH3/VA5d5CtMJHoEVphG7yiv8c5dn5S0k
 rQV34CoSFpDcaXBThbF2Pn10nGpwpyMx36hSABnqlOcjgsP4quKj6wG8sratOaOLWuuX
 7EIGipARhm7dGXQxxrR7iLB+Wmd7jFYXonjrLhtzYMcE0gNtqc+0hlhFy/K7NqoI7a9T
 5i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792901048; x=1793505848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HlYNTG1YeavwC+hNZqZ9gnXD5hsIPEAX4XNijQPWf9E=;
 b=o6S7SEUSsCtR6z3eCb6KBxVTfOYuyW09LBuHw/Nbjbnu/ikllp41YMh75x/7Sgrhar
 ibuEELH7gnc1Xhh7JwU4igjCr2QnUdz9VRzfY9n3PVdPzpsJzvKzorPiKB9nN5hWvkg3
 GJ2YQ5xrP2ha1yuvi5dPaooB4sDOkhE5iDr25ge3jdf+Xybx/6dVksJX/5FSoBggtD5Y
 4hOMCI+lK+QiTn9+iwrmyfqNp7viHRMSQ4XDvocPkdyQXwYnnGrG2fbJudKC72Xr5DIJ
 lkhamvdhJSvMh8ZdYseH70jmRWBdnylI6U3zfoYKuG/CBhS2msVYpHev2SPJSGXvn1eU
 U+5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBymFYzWcCGRtrnRHkZD0z7d0f8B15ypQWk/RAzPrPA/zY1LRFmTlZn9V5UKPxjYzRM7ZsP4Pd3d@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJo80IZ/SOahKfQzUNos1ckVHyL8bl01SuAYOEGMKu4O9GhHHMP
 Dx6ww407IzWcJ+okomorTL2+fhyxdw9AGY8osHN9khDlkLSl1UJfz7w=
X-Gm-Gg: AYBFou1EPPcrUHVlWBdj5VFAv5C2qLWJbX70derz+Yr0ZTVYUARiDr7dVK+LjLt166l
 kTmy9wQjNrqUt1N1usO8aQ/2M8ce595Vat5yiZui1NE8/RN6UNbRRt3LVA/F1cPzgMIDO4i2HAG
 D6hWWo54WfIka95Q3pU0Y2E3meBrFgnBdjLnDlfip+5RF3TTt4iCS9nkl5mD9K/9kihSI2mSxmp
 NUwZDGDCt/ilFLhrTkXJf6obEA9N2YjbU82WnJCL15/NOJ4en9zR10i8V72HBPr/hdqHxfCYsBR
 MZd0bqqzAlGyocTTbUqxQ6WK4ZKpxHukHLoF7sHy0Epl+B7gUvIkr3nvAm5YQ0EmCjIXHrmNPpp
 89Q6Yqth1ycv6f5rfVEsnVCb17mefhh67/DUMyjONS/YicHrch18oly22LEhIJqgQmHMJVRBsNP
 J2sg5/M3hrl5rcdtDwTkhgzMbKQDFoT3FKvjlKyb9qoHT5Scc4+jfiLUeuzxQGZ0/9Xc9XESAlH
 geszuMgRa/R7mkLN8H9f0XrUvA3Xi58Tt7kuZeL6HE73xPAGk3A2iohBJtdU57Rx9BlS5wqPfvm
 4RZj5SwYhJWE1sS7cKiIpj81QSVUcxckSHlB/pvIIxIj0G9LWI7b81X99J6hqMOUyQ==
X-Received: by 2002:a05:7022:5f14:b0:146:5f73:d45b with SMTP id
 a92af1059eb24-1994cb430a1mr4374141c88.3.1792901048032; 
 Sat, 24 Oct 2026 21:04:08 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:04:07 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>,
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
Subject: [PATCH 12/13] drm/amdgpu: Skip AC/DC notification while the GPU is
 runtime suspended
Date: Sat, 24 Oct 2026 23:59:48 -0400
Message-ID: <20261025040046.1602-13-atharvatiwarilinuxdev@gmail.com>
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

From: Andre Eikmeyer <dev@deq.rocks>

Plugging or unplugging the charger raises an ACPI AC event. The handler
sent the new power source to the SMU without a runtime PM reference, so
with GMUX keeping the GPU off every SMU message spun on skipped register
reads for seconds. A runtime resume racing with that left the SMU
firmware unable to start on MacBookPro15,1 and the GPU in runtime PM
error state. Record the power source only and let the resume apply it.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 808be6c42..b64f0b681 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -30,6 +30,7 @@
 #include "amd_pcie.h"
 #include "amdgpu_display.h"
 #include "hwmgr.h"
+#include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include "amdgpu_smu.h"
 
@@ -498,20 +499,26 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
 
 void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 {
+	int active = 0;
+
 	if (adev->pm.dpm_enabled) {
 		mutex_lock(&adev->pm.mutex);
+		active = adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX ?
+				pm_runtime_get_if_active(adev->dev) : 1;
+
 		if (power_supply_is_system_supplied() > 0)
 			adev->pm.ac_power = true;
 		else
 			adev->pm.ac_power = false;
 
-		if (adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->notify_ac_dc)
-			amdgpu_dpm_notify_ac_dc(adev);
-
-		if (is_support_sw_smu(adev))
-			smu_set_ac_dc(adev->powerplay.pp_handle, true);
+		if (active) {
+			if (adev->powerplay.pp_funcs &&
+			    adev->powerplay.pp_funcs->notify_ac_dc)
+				amdgpu_dpm_notify_ac_dc(adev);
 
+			if (is_support_sw_smu(adev))
+				smu_set_ac_dc(adev->powerplay.pp_handle, true);
+		}
 		mutex_unlock(&adev->pm.mutex);
 	}
 }
-- 
2.55.0

