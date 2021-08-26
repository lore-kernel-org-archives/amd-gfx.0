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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228EEC4320E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 01:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25036103E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 01:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E25036103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C4F76E471;
	Thu, 26 Aug 2021 01:55:17 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30ADE6E45E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 01:35:31 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 962573F316
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 01:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1629941729;
 bh=Bxc8P/tocTApC9nIFsbGOyLw8oxi4sU2mV0XrmLdLwQ=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=X8XHwh8nG6KWfvgbzAVwe9vny++nSKnChgAPuYVPI/bzwbql+ynKDCwctWiv6/05Y
 XrLnpps5Bz8KWmnwpdif6NtKfA9NqrzbosawFpxXlCNkNndmofpgVqLw/IV0Nyz5O1
 Xe8i7Ywh42e8HvI4Fx1vyuGZ8tTm09xFc5uLtw1rppNnYzUrADYjhYYz6zklDCakqH
 CMeF8SKEoKoj0Ka2hnSocx5IHWgoWiLiS9edEsQxa+KbFkqyk4AUt56fGJg7wc2b+O
 a+EGn7hMuB4f/wnsjahOqrJfktsaQMPJaj42zOO0uo62xU2wyTZQWJrCXsRUGrCIps
 yND0FQmTS3lPQ==
Received: by mail-pj1-f70.google.com with SMTP id
 u3-20020a17090abb0300b0019567f8a277so420548pjr.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 18:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bxc8P/tocTApC9nIFsbGOyLw8oxi4sU2mV0XrmLdLwQ=;
 b=m6OP6pGbUYYfMUzECTPB234w6Kbc+s6JaDw0kW6SoTtbgXvC4K7F9dbhNLmy1Kks4U
 dvo+4FpMLtSYt2g77OSQFsTKUMKatcs4mURG4opJV8Whpsccs/hRyCpWgJhgffMaAHcp
 qtE8qLaC4Ak+S44wtORSm5kv/xpmB51k4yIJhum8W4e4cB9QOtY1KonFv/QTVKFbwUc4
 5FOOFXiOeNpvhM5XpVATBD8lbgIwgHM9eLycjHBb6A5SRYxGs5zf19HoYBNSVT2YxYIg
 wNDzAPrkUThEUjcdvSs0uWHxVZ0u+01sGXAXpOM0YFBGUshnOR3t1Dld9kqti9IpksKI
 DgPA==
X-Gm-Message-State: AOAM531Be8mmP9QEO8SaPZyJaC7xEjm7Z8luxoLcgcymyRy1dpH4xROn
 xG3yfSXNeg7ob5apbeioaHVoP/iqZSaGh5Y2Y/egxNON2oGJBGUeb4Ht2t+e4eSjNpe+td2yamw
 s7fjRQYuYpB9e9zFibW5ZVOoJEW8yPCwp3Nu8FkCsTRY=
X-Received: by 2002:a17:902:6e02:b0:137:b47e:d779 with SMTP id
 u2-20020a1709026e0200b00137b47ed779mr1139621plk.50.1629941727852; 
 Wed, 25 Aug 2021 18:35:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuCV32HdLn4sHpXC2B+RvmgomQevFeILNEbH6GiLLDB8Sy+mJOfvHsei3QS4nV/LHJr324gQ==
X-Received: by 2002:a17:902:6e02:b0:137:b47e:d779 with SMTP id
 u2-20020a1709026e0200b00137b47ed779mr1139602plk.50.1629941727517; 
 Wed, 25 Aug 2021 18:35:27 -0700 (PDT)
Received: from canonical.com (61-220-137-34.HINET-IP.hinet.net.
 [61.220.137.34])
 by smtp.gmail.com with ESMTPSA id d22sm828818pfq.158.2021.08.25.18.35.27
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Aug 2021 18:35:27 -0700 (PDT)
From: Koba Ko <koba.ko@canonical.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH V2 1/1] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
Date: Thu, 26 Aug 2021 09:35:23 +0800
Message-Id: <20210826013523.394705-2-koba.ko@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826013523.394705-1-koba.ko@canonical.com>
References: <20210826013523.394705-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Aug 2021 01:55:16 +0000
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
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 0541bfc81c1b..6ce2a2046457 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -27,6 +27,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <asm/div64.h>
+#include <asm/intel-family.h>
 #include <drm/amdgpu_drm.h>
 #include "ppatomctrl.h"
 #include "atombios.h"
@@ -1733,6 +1734,17 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
 	return result;
 }
 
+static bool intel_core_rkl_chk(void)
+{
+#ifdef CONFIG_X86_64
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
@@ -1758,7 +1770,8 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 
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

