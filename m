Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B29C432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 07:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A03A60F8F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 07:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A03A60F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E36689CF3;
	Mon, 30 Aug 2021 07:17:54 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB6E789C84
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 02:02:07 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 527634077C
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 02:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1630288926;
 bh=ql0s+QjpnPyqso7Ywb2HMLPII4+zn2mMzFfsFgd6ZIE=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=QGTrInsHTxq84Q4hG5jBQsPIQYiO0TVSbY2cLzDw94wz1NdFWi/ObM3NqZwFVfxZI
 gcoL/g/zUCsraQwULll/5igQ4MCzm81XhxH+S+3Hbs6V5jaXUuaOyClH16k3T6TYRY
 3E3kiknuzZtRDhncKJrixJEyTfC2riX30/9lpBKc0wTEhly1ECgEz8Rbli6iSq3QaI
 wW9/tYuqmtfgSNlI3DDzvlF2PwxEb/q3pTRfkGgf28LZHUDaVsNyJitk9zOIY7XOax
 4cLTHqaQV02+j0QnXcOylko4G01skbJy28c4/ZwF4sYkWyy6OyVUkszspAUKVXfrHc
 3UEOxMojgCCGg==
Received: by mail-pl1-f200.google.com with SMTP id
 p7-20020a170902b087b029012c2879a885so1121970plr.6
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Aug 2021 19:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ql0s+QjpnPyqso7Ywb2HMLPII4+zn2mMzFfsFgd6ZIE=;
 b=YCrXPLZ2jVtcvpMRvImJ7lM37QMwJASgvepn2yfhYZvybfwggQOI7+4EUx8txTUJcg
 vM5u0m1U/kJGaqtnjT22YIUOj2/+wnYF+asvK2Vg0X6y2O7hIN56h6wkWOTpE9Ej8fuW
 K3CpjK3+P/QjK7epy+UV7xWleCbOdo8EojgkLLo4cab+TF8s1Dql/qGfGGXx/pCzAxaE
 ra8QpT8fMTnDAfBctTD7/VElEEEztUL04+vuSgjKb4b+cdm03y2NUcd1Rm6yuPtfk8lB
 o3/WW431yaJzkIjo5IZl+4OBYVPxyR+xqMcBJwFHaS523SKwtpKK8/Pik5KdbbePDftt
 w4XA==
X-Gm-Message-State: AOAM532LeqvseWdn2+SFwL1ZzLo155vMyhjtmMWLd0D5zfv0gpHuIWHO
 wnILa+qwwkbgSmpWhFH5hqhPhiDF5koRKOHRVx3sagQvglC/o6e5WaCvidGyre/opDP58GWtVUJ
 4Izc3notY58ClimgU9YuFH1lIoBkmu8pd6F+j4u/11kc=
X-Received: by 2002:a17:90a:4a88:: with SMTP id
 f8mr37174580pjh.226.1630288924605; 
 Sun, 29 Aug 2021 19:02:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjQE4NzN1JbWkDiuCYR0t5RPBcu2x81db21t+6+qktnbcmFEdt/BuXibnrXuY8DDLkHL1zFA==
X-Received: by 2002:a17:90a:4a88:: with SMTP id
 f8mr37174554pjh.226.1630288924287; 
 Sun, 29 Aug 2021 19:02:04 -0700 (PDT)
Received: from canonical.com (61-220-137-34.HINET-IP.hinet.net.
 [61.220.137.34])
 by smtp.gmail.com with ESMTPSA id g7sm8590812pfj.70.2021.08.29.19.02.03
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Aug 2021 19:02:04 -0700 (PDT)
From: Koba Ko <koba.ko@canonical.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH V4 1/1] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
Date: Mon, 30 Aug 2021 10:02:00 +0800
Message-Id: <20210830020200.611574-2-koba.ko@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210830020200.611574-1-koba.ko@canonical.com>
References: <20210830020200.611574-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 30 Aug 2021 07:17:52 +0000
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

Due to high latency in PCIE clock switching on RKL platforms,
switching the PCIE clock dynamically at runtime can lead to HDMI/DP
audio problems. On newer asics this is handled in the SMU firmware.
For SMU7-based asics, disable PCIE clock switching to avoid the issue.

AMD provide a parameter to disable PICE_DPM.

modprobe amdgpu ppfeaturemask=0xfff7bffb

It's better to contorl PCIE_DPM in amd gpu driver,
switch PCI_DPM by determining intel RKL platform for SMU7-based asics.

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

