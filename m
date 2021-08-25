Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635DEC4320E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F0961139
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24F0961139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481A76E203;
	Wed, 25 Aug 2021 12:34:21 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8846E14B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 04:35:30 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AF4D54076D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 04:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1629866127;
 bh=WVfbKewHZLqWbITzgLCPHNKWv+F2XUGievOPg9HDU4M=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=s2818a/o/y1QxIiUYcpwAfsJJ25nIuq9AktYS76uzEQtwMPzLluUQ21JCs6G5vakg
 cP+G0pM1ieP9xBjNHxFpilze7+Q4HbcTRP9SNmsxHTA3xT6A7ySNnqqh1m7KyndMBe
 kEoBBr+Djn6WNlf3v4gAg7zKFW2L9Hoe2hBlnc+kVBDWqJ3cgm7+Upqs0SvI1RjDln
 BQUdKeiLsgJf8OKVgOhNFhmJkAUFwpOveVFKWRcMmhQPGGixThgN4Q5LS2UySXompK
 CF2TmwM5+Nav7QPsMR9267UoXvQzFWwwaP2rmokJSEy1Wy5jTdqLnT1E7OdGBjNBSl
 xTqR9lKG5UMEQ==
Received: by mail-pl1-f200.google.com with SMTP id
 n1-20020a170902e54100b0012dbd2c897cso6539355plf.20
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 21:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WVfbKewHZLqWbITzgLCPHNKWv+F2XUGievOPg9HDU4M=;
 b=bKid30eoa8ZWh/Vyxezivj9T+ak0ViIpCd7CluFNXxX0/niWqfIiitpbFrTFGUF9+l
 uVaTF+U03G/xsfgAntyXOpw6ZEHORvhNk+Z37jujsYR9+TQykqIRy/rZMA+9YuPgf04x
 Ha7ITZPc5w9iKVx3jOy5pOs0XL+UDCpdzcm2ZqBMlPAxIefh7paMwxN15URKMM9bED88
 YD3JspDKldfhYemFUHoZ2GCu+KZSrJpCNc5p5a8UiRngaWcvKnjtvJpkqxHrb+RlHf0e
 j+4nZOkmgOAX+T8NWR5RcfjdFAs6rvupKv4bo6LKd/qOiWwzrtnUTvWw2nSm4qDPIYOm
 Blng==
X-Gm-Message-State: AOAM5305fo4hl1s/Df3KriM/CF69u6bpAW41t7F5Qw3Fx9R2/AfjnOmc
 gZlpT0NARMLwe0F+aoO46mwTvAjaYeBbUsCTX288BIuNXo40CRQnDk+s4Xfn28Otx4u6jAsfa45
 jY8bjcXe42ly1dxNrzuww0avJ7g54QY7tZKm2FDk6+rQ=
X-Received: by 2002:a17:90a:890a:: with SMTP id
 u10mr8100748pjn.40.1629866126125; 
 Tue, 24 Aug 2021 21:35:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkdhSeNq+mPnqI0GDpDHzoTs/1ZcX+C+/0SlFjb+A/wxB36jqkK55FJt8JPtRKDkgPs9A71Q==
X-Received: by 2002:a17:90a:890a:: with SMTP id
 u10mr8100726pjn.40.1629866125822; 
 Tue, 24 Aug 2021 21:35:25 -0700 (PDT)
Received: from canonical.com (61-220-137-34.HINET-IP.hinet.net.
 [61.220.137.34])
 by smtp.gmail.com with ESMTPSA id r10sm20417995pff.7.2021.08.24.21.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 21:35:25 -0700 (PDT)
From: Koba Ko <koba.ko@canonical.com>
To: intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 jani.nikula@linux.intel.com
Subject: [PATCH 2/2] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
Date: Wed, 25 Aug 2021 12:35:22 +0800
Message-Id: <20210825043522.346512-2-koba.ko@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825043522.346512-1-koba.ko@canonical.com>
References: <20210825043522.346512-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Aug 2021 12:34:20 +0000
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

For avoiding the module parameter, switch PCI_DPM by determining
intel platform in amd drm driver.

Fixes: 1a31474cdb48 ("drm/amd/pm: workaround for audio noise issue")
Ref: https://lists.freedesktop.org/archives/amd-gfx/2021-August/067413.html
Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 0541bfc81c1b..346110dd0f51 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1733,6 +1733,25 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
 	return result;
 }
 
+#include <drm/intel_pch.h>
+
+static bool intel_tgp_chk(void)
+{
+	struct pci_dev *pch = NULL;
+	unsigned short id;
+
+	while ((pch = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, pch))) {
+		if (pch->vendor != PCI_VENDOR_ID_INTEL)
+			continue;
+
+		id = pch->device & INTEL_PCH_DEVICE_ID_MASK;
+		if (id == INTEL_PCH_TGP_DEVICE_ID_TYPE || INTEL_PCH_TGP2_DEVICE_ID_TYPE)
+			return true;
+	}
+
+	return false;
+}
+
 static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -1758,7 +1777,7 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 
 	data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
 	data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
-	data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
+	data->pcie_dpm_key_disabled = intel_tgp_chk() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
 	/* need to set voltage control types before EVV patching */
 	data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
 	data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
-- 
2.25.1

