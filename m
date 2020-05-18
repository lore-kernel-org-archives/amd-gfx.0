Return-Path: <SRS0=VEb6=7A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC1CC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 16:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBA520758
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 16:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCxeUuua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBA520758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440286E43C;
	Mon, 18 May 2020 16:37:30 +0000 (UTC)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656246E42F;
 Mon, 18 May 2020 16:23:23 +0000 (UTC)
Received: by mail-pj1-x1043.google.com with SMTP id q9so48550pjm.2;
 Mon, 18 May 2020 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=K211i4h2u/TxQcxsieD51LxexrJexjO9Rx1FtdNootg=;
 b=ZCxeUuuaf+obk5I3yVMAoO21FuFn9ZnaajU4+BOQ99SaS5pj2jagOJ/JOGl+8RsUII
 rvwLVEZZIkzXNr6+b5GK8kBK5CwmCLz1LU0DPBurnFBaDT4RSxCswhVllgphaQG+aZjj
 p/NUv/ujcSx2sF8dexJN5AdeFuomxgou0IRwg3hXoLKBdK/NS2+wU/KFY8//Q1WbOVzx
 zSuZB4Bs5Z+jwykwSB4wAhMcLrvVt6iGZlNfPN/l6Rb1XTrVmBKIOUjCY/D2PWfPmFXt
 /PzfwEXc5tl2MfRF3y+kOyECmkL7fRukDwcF+Ii3mXydS4jRBqnvfcTtirZxzQWmQRCT
 0uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=K211i4h2u/TxQcxsieD51LxexrJexjO9Rx1FtdNootg=;
 b=M1AUoLLuFS9SogKsVUA+11udAK0WFEsQtsy+hAiFlyRxEHGie9bbSftzlM9Rx0TedZ
 d8fnHtYmUKLkFRFQjmR9cZPDPePBRhT2Pv9LlmBxlmCLZ18lbFa5yRULxVKV3yTVomAF
 a0JEy0D9giWPbSqqA0QHcB9OUS6kWZqXbTPD9+DCyqbV4mTZwJaNyAKy7NyTk2v38S0v
 E8zF5SwRvsR/fRsLDdRZzn7Euwez9WicjXkYMLtrLCPCl53As+LCJj+vSgxaHrBIFhiu
 xsn5HuuL5GsKoOKs6RrrRF3AXvcCDu2FHaC/5etQp0XCvWXz/k+4MxzckP85aClO/zCR
 Gcfw==
X-Gm-Message-State: AOAM532l+pCbh+gdR7572Wf6gz14tAZbtHzWZHMk3Km1t3Azdkkjrk8f
 8jdXB/U5O+18ghNLAmfxE7s=
X-Google-Smtp-Source: ABdhPJwGk4vPSvK7vas58uw/Mle4Y1AUjToQolSEGddq1AGgxZx/L/rMqSj8a28neGfe3Hv0XNqxVw==
X-Received: by 2002:a17:902:7587:: with SMTP id
 j7mr17207481pll.81.1589819002963; 
 Mon, 18 May 2020 09:23:22 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:418:e389:7149:74ab:b584:ecf8])
 by smtp.gmail.com with ESMTPSA id s63sm44882pjj.16.2020.05.18.09.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 09:23:22 -0700 (PDT)
From: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Fix boolreturn.cocci warnings
Date: Mon, 18 May 2020 21:53:12 +0530
Message-Id: <20200518162312.18059-1-aishwaryarj100@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 18 May 2020 16:37:29 +0000
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
Cc: aishwaryarj100@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return statements in functions returning bool should use
true/false instead of 1/0.

drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c:40:9-10:
WARNING: return of 0/1 in function 'event_interrupt_isr_v9' with return type bool

Generated by: scripts/coccinelle/misc/boolreturn.cocci

Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index e05d75ecda21..fce6ccabe38b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -37,7 +37,7 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
 	if (vmid < dev->vm_info.first_vmid_kfd ||
 	    vmid > dev->vm_info.last_vmid_kfd)
-		return 0;
+		return false;
 
 	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
 	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
@@ -69,7 +69,7 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 
 	/* If there is no valid PASID, it's likely a bug */
 	if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
-		return 0;
+		return false;
 
 	/* Interrupt types we care about: various signals and faults.
 	 * They will be forwarded to a work queue (see below).
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
