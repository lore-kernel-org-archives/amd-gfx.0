Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F96C4320A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E462E60F44
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E462E60F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EACA66E85A;
	Thu, 26 Aug 2021 13:49:36 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6631C6E5A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 09:53:49 +0000 (UTC)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5184D3F043
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 09:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1629971628;
 bh=5lBBExzclXZfUWUQjh9W4eV0x5YBM6EFcjPmG2pg4ko=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=RmkihPWSwqzjs9Qt86bUtyPBFhxXAmL+IcsBVUbyyMH20eT4TrBaVkyVdcEn94QBV
 YzhUBFrkk1inAaBnCqJLFfE8lcIBFGrHJZSBD7haTJgoVZuvs2fCUX5Y/ge6w7FXzI
 Tv0yOGebBlf+eghckH+H+PBMBFdYTGMg7plKbfTy9rBHNcYDa3ZUNPfsApuzroyGms
 GvHt/+FyiEnImxqqnxnOIdNBQilV04ciW96T9aFWmBS7h+8py5oeRRs4nEgjUApJvc
 z2uzkftORM8oTgB/aH1Cay8Zo7C8/6L8eRefEEt/h+UBbfGJYJ30r1hKGug0rqPx2o
 pYKscuQ+TSRBA==
Received: by mail-pf1-f200.google.com with SMTP id
 s53-20020a056a001c7500b003e0f67df507so1249599pfw.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 02:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5lBBExzclXZfUWUQjh9W4eV0x5YBM6EFcjPmG2pg4ko=;
 b=OxUcn16VMb0UkdcQtbX5sKAQ/41ZYuxJuNXMlPpHE7Csv5hCR2d4VFpRHsqrRk/z6w
 VmZj6IHomdvja4mnnm2tzlgtrIVDDRereZgyqyCuonJayL+TpUSQVT/a0mo9KA9ZmoTG
 aaVn3Ayrhb+BKSB5LX6pz20/Lf8YZ6tpDQqQ810N6QVeZ7WUSNfIiiBtCUCRwPAmT8Ul
 LFAW1GdxoCfsproWlOraxSEn2fAMH0B3wqYNw5NpD2wTTyGmP1GUMLcYA3uVeL88DqXR
 8hSH5nVe5WWbFKwDKezJ6bM7R3vZ1TAbAsHT0SFhRC8c/+F4yprgF5ZA/6DDgFFahQJQ
 5Cjg==
X-Gm-Message-State: AOAM5326c7CnDBx8ED8d7PYnPXbNXYVGKQwxM88Wd7xdfh08ifwXvxG2
 oBUIoO6nob6lUBGMo2RTLrMKpYZjvyTAZT5lSjhbfWQF363ZpMaYIz4NYIpY1ZjFgpw2tOTNtCV
 ZSlzNd8uLoAxEPL7UA+693PZSIgNYR/+Ub3SZYLEtmlQ=
X-Received: by 2002:a65:534b:: with SMTP id w11mr2656604pgr.141.1629971626614; 
 Thu, 26 Aug 2021 02:53:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXY9R9CirItLodWJUlI3C9TDo1dVoMOykDBJfXC0F28eZL9iihYTscqogmJ/Mot5y+g91cmg==
X-Received: by 2002:a65:534b:: with SMTP id w11mr2656588pgr.141.1629971626315; 
 Thu, 26 Aug 2021 02:53:46 -0700 (PDT)
Received: from canonical.com (61-220-137-34.HINET-IP.hinet.net.
 [61.220.137.34])
 by smtp.gmail.com with ESMTPSA id c15sm2262735pjr.22.2021.08.26.02.53.45
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Aug 2021 02:53:46 -0700 (PDT)
From: Koba Ko <koba.ko@canonical.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH V3 1/1] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
Date: Thu, 26 Aug 2021 17:53:43 +0800
Message-Id: <20210826095343.426397-2-koba.ko@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826095343.426397-1-koba.ko@canonical.com>
References: <20210826095343.426397-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Aug 2021 13:49:36 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD polaris GPUs have an issue about audio noise on RKL platform,
they provide a commit to fix but for SMU7-based GPU still
need another module parameter,

modprobe amdgpu ppfeaturemask=0xfff7bffb

to avoid the module parameter, switch PCI_DPM by determining
intel platform in amd drm driver is a better way.

Fixes: 1a31474cdb48 ("drm/amd/pm: workaround for audio noise issue")
Ref: https://lists.freedesktop.org/archives/amd-gfx/2021-August/067413.html
Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 0541bfc81c1b..1d76cf7cd85d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -27,6 +27,9 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <asm/div64.h>
+#if IS_ENABLED(CONFIG_X86_64)
+#include <asm/intel-family.h>
+#endif
 #include <drm/amdgpu_drm.h>
 #include "ppatomctrl.h"
 #include "atombios.h"
@@ -1733,6 +1736,17 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
 	return result;
 }
 
+static bool intel_core_rkl_chk(void)
+{
+#if IS_ENABLED(CONFIG_X86_64)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
+#else
+	return false;
+#endif
+}
+
 static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -1758,7 +1772,8 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 
 	data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
 	data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
-	data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
+	data->pcie_dpm_key_disabled =
+		intel_core_rkl_chk() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
 	/* need to set voltage control types before EVV patching */
 	data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
 	data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
-- 
2.25.1

