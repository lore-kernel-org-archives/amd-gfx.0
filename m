Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B3AC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 21:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BFF23B87
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 21:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BFF23B87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A3D89AC0;
	Fri, 18 Dec 2020 21:34:27 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A740B89AC0
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 21:34:26 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id bd6so1623116qvb.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 13:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OStlWHrNGYZ2qjV9i4PTC5CmW5WEmJyKebHLKcaUDWk=;
 b=uON+nY0vwBpAQx/lZ20B8wTPiX+f8g1RjAJgEpnv+FJ47vcdI/+MhocL8lJunaqwbm
 ghYM7D9gTh6DPZWpEnzmvpf30tVbrex8KdC3bMkLhL9BFWtgmuzNF7wFaiNqffjklMSK
 j6OUbJFjlR4ftvhh4EX6YBpUwpv+vnnwsWqAU1KYQAjlAfZaujLT2KUy1btPQUcyJl7h
 Q8xv6Xp3RJiYcXTz8TfJFoiowlF5hbVp1XQNfvcnxDvBLMA7Y6oqXCIxxsizxkqiHJAv
 xpUyOHAS5/nYfvmlPCGUMKcysyVOeCdatVxfxtIv0al5P9vfAvaOZdidihfwx3jkrO6V
 4YjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OStlWHrNGYZ2qjV9i4PTC5CmW5WEmJyKebHLKcaUDWk=;
 b=aQH8EvmqZeJPkk+us/yEwLiLTVYB7urzRMc3WPsniidfHuWbFlLCOVWgqV8hFzshAi
 /BYKo9Hgix4HqxqgiVxmrSlWMf/4SCP35ywCT9XUbgJL7IyKUbmO8/JGetaksDz+CKCd
 nkg1up0Z0oJrGJpdYWPz7fF7+KcM92eZVYxQdwLvqbthwVa5GzJHZKwZEC0YC50n/D6u
 dGiHztdkF5T68S0LotfzLD8sSraJJ+kGDr596zAC0A8V3yq94gFACMx1YpfdXReCWETu
 kmfqCWvpZhQA/vm1dIZVpGIqZvX4OP61SCH2jiu/SGh8ZXHYwP8PD4dVjTXfo8IaH55c
 gzlg==
X-Gm-Message-State: AOAM5328+uUuueiuAzCTJBiAikYekOijtxPCGgNJMJ3UdQXwfOA9qEOD
 /4XlZbm71ZFXBXEGvr4J5IftycmeGFc=
X-Google-Smtp-Source: ABdhPJym/wNU6uOKuhhuUklR1sCe0Z0ogsdIfoWsVe7gYuXVcbWx8ukXJgsNzyo+5GbTeCDSYrVOJA==
X-Received: by 2002:ad4:52cb:: with SMTP id p11mr6644746qvs.49.1608327264710; 
 Fri, 18 Dec 2020 13:34:24 -0800 (PST)
Received: from localhost.localdomain ([204.111.139.145])
 by smtp.gmail.com with ESMTPSA id c20sm6058918qtj.29.2020.12.18.13.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Dec 2020 13:34:24 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: check both client id and src id in interrupt
 handlers
Date: Fri, 18 Dec 2020 16:34:16 -0500
Message-Id: <20201218213416.61131-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We can have the same src ids for different client ids so make sure to
check both the client id and the source id when handling interrupts.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 46 ++++++++++++++-----
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 241bd6ff79f4..0ca0327a39e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -44,6 +44,21 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
 	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
 
+	/* Only handle clients we care about */
+	if (client_id != SOC15_IH_CLIENTID_GRBM_CP &&
+	    client_id != SOC15_IH_CLIENTID_SDMA0 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA1 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA2 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA3 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA4 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA5 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA6 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA7 &&
+	    client_id != SOC15_IH_CLIENTID_VMC &&
+	    client_id != SOC15_IH_CLIENTID_VMC1 &&
+	    client_id != SOC15_IH_CLIENTID_UTCL2)
+		return false;
+
 	/* This is a known issue for gfx9. Under non HWS, pasid is not set
 	 * in the interrupt payload, so we need to find out the pasid on our
 	 * own.
@@ -96,17 +111,26 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
 	context_id = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
 
-	if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
-		kfd_signal_event_interrupt(pasid, context_id, 32);
-	else if (source_id == SOC15_INTSRC_SDMA_TRAP)
-		kfd_signal_event_interrupt(pasid, context_id & 0xfffffff, 28);
-	else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG)
-		kfd_signal_event_interrupt(pasid, context_id & 0xffffff, 24);
-	else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
-		kfd_signal_hw_exception_event(pasid);
-	else if (client_id == SOC15_IH_CLIENTID_VMC ||
-		client_id == SOC15_IH_CLIENTID_VMC1 ||
-		 client_id == SOC15_IH_CLIENTID_UTCL2) {
+	if (client_id == SOC15_IH_CLIENTID_GRBM_CP) {
+		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
+			kfd_signal_event_interrupt(pasid, context_id, 32);
+		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG)
+			kfd_signal_event_interrupt(pasid, context_id & 0xffffff, 24);
+		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
+			kfd_signal_hw_exception_event(pasid);
+	} else if (client_id == SOC15_IH_CLIENTID_SDMA0 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA1 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA2 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA3 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA4 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA5 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA6 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA7) {
+		if (source_id == SOC15_INTSRC_SDMA_TRAP)
+			kfd_signal_event_interrupt(pasid, context_id & 0xfffffff, 28);
+	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
+		   client_id == SOC15_IH_CLIENTID_VMC1 ||
+		   client_id == SOC15_IH_CLIENTID_UTCL2) {
 		struct kfd_vm_fault_info info = {0};
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
