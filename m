Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B06C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 21:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3081B20738
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 21:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQfOrITB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3081B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E86176E172;
	Mon, 24 Aug 2020 21:33:42 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A38E6E598;
 Mon, 24 Aug 2020 21:15:51 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id t14so216863wmi.3;
 Mon, 24 Aug 2020 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LFw4WfZ8EhsNfys63tZhqlDitg+wRfgOs5oV//XPrUM=;
 b=FQfOrITBr/YQmprdbDs9K0Z2Kq+p9iialWri9yWFnpOyReVYm0eyFFSpkA9dfanxkT
 IRTWbqHsmXT0FApdWrAoXwRvynXtd8rU9PnFu+pA5DosfghqjjJh7DNvOQMdDSgds0nn
 IEaM1xEuJ984gyfGYP+5f6UgTFNYZwk1pE0PqTO4bdsdvkN86oTTeRTXPwTP/8h4PdA7
 T+pgYyrjH2SmkmEthb8p1oMkGmgL1ciUfEVPII0CaDvTpBznT+OaqZMBTxsFKxIDNgru
 yghkD6ZRfTmeQTIKGkA5pDwbHaqO+afu1s/cvLzrnct4VkTCwR6lC1Kaj88tktIUkaBr
 ccDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LFw4WfZ8EhsNfys63tZhqlDitg+wRfgOs5oV//XPrUM=;
 b=HQF6+Y7U6JNfUpAqa+6iTOJMXLh0NNcAgjw5N4INvZ+WX6XiZv82baSA0EMtIqkTAq
 f+xKDCVYjkzb1HwgJ9E2CLlHsaNQFC0kpjsa3pvU9t7iOSNdk17e3t0JUMfBLwDIxFKZ
 czUBKuUrO2jeterdk21R4E4Y4MLQl41cGjYdI+VrNrwP0fg+Ajy+WqqtuNnfEGb8mwJD
 KEwcB5HFyfOSJww4M1A/4VYXBrT0BEnpa+1r9SQ9L6rfQOd/IepfXndd/Vcb93sNP4dP
 XXpOMAFzlKPAQdBKprwCd3jOVHeaWE71zaEsrn2gKTju1kpMH5qxKJ1iexdjkOrukZBP
 lmJA==
X-Gm-Message-State: AOAM5315KVNblmSOsH3kjoKbnmzswfOcbDzIhhjRxFncPq8146nferfa
 wzZh0ynL/pv2qlyi4OdcNA4=
X-Google-Smtp-Source: ABdhPJz0baJ8O+INbMWboBj35pDbefXGIzNS8GiFPjrN5PieYka8Z4czgAFx6rk+IT2Y7nTgcfBJNg==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr1146892wme.50.1598303750143; 
 Mon, 24 Aug 2020 14:15:50 -0700 (PDT)
Received: from localhost.localdomain
 (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
 by smtp.gmail.com with ESMTPSA id c9sm1638261wmf.3.2020.08.24.14.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 14:15:49 -0700 (PDT)
From: Alex Dewar <alex.dewar90@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Dewar <alex.dewar90@gmail.com>, Li Heng <liheng40@huawei.com>,
 Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: use kmemdup() rather than kmalloc+memcpy
Date: Mon, 24 Aug 2020 22:15:25 +0100
Message-Id: <20200824211530.592909-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 24 Aug 2020 21:33:41 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Issue identified with Coccinelle.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c   | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
index f56a3cbdfa3b..1f9082539457 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
@@ -890,14 +890,12 @@ static int init_powerplay_table_information(
 				power_saving_clock_count);
 	}
 
-	pptable_information->smc_pptable = kmalloc(sizeof(PPTable_t), GFP_KERNEL);
+	pptable_information->smc_pptable = kmemdup(&(powerplay_table->smcPPTable),
+						   sizeof(PPTable_t),
+						   GFP_KERNEL);
 	if (pptable_information->smc_pptable == NULL)
 		return -ENOMEM;
 
-	memcpy(pptable_information->smc_pptable,
-			&(powerplay_table->smcPPTable),
-			sizeof(PPTable_t));
-
 
 	result = append_vbios_pptable(hwmgr, (pptable_information->smc_pptable));
 	if (result)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
