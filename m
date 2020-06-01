Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC26C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40802077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrOGH138"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40802077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6768B6E2B6;
	Mon,  1 Jun 2020 18:04:28 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3874F6E2B6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:27 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id n11so9939716qkn.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0di/au8kZIr6j1Tw9jwxYn0L6SH8eRm1wRJsm7lBmWc=;
 b=OrOGH138wUJIughTViYYjWg2WXJB8D7Cra+gmtPBszKnADJOCMVd2TrtOEOKcw2ywo
 1W0WTTcupNaOQof21xYT2rAUE/HaxpdhFMZB5lxzp+nofYcPrA2tO6Pt+9QbplIi3Kzc
 4nNBOlPfLNXAXFaAJjSjm0eMZxrH3MnbRtwuXt3skgFJXmFMKBIt57nJzJrUYAz/J+LW
 kx8yBtcR0hrfIAaET/emRhdnKJGEZFY+oS+COnSZ0H21BqocuQ+oneii6wqj4Gz/1KLe
 vO67aPE+xYmfpQiQ1EWQr8QCjs9rtrgnCnJYSEgAnDvQ5OVl+jRR9BD8J9YOrA2xaqGA
 E8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0di/au8kZIr6j1Tw9jwxYn0L6SH8eRm1wRJsm7lBmWc=;
 b=BiKoNvfHyicNxfn9Y35RFV9iT2G+8N3ec7KxxqpDbLaJlvPVdXFJ1fzc0J8E0TNhNH
 /des0AIPrNi19JMNhtrOhsRabFo0/moPmJ/kJw3hU99MQo3CvP4UplARkvp+00Nujpzu
 HbR3KKbyjDHPcDnN15K1Sy9yOgeZMgIYaIcqj7SWnQPbsge5AUwHqocjG4RBV3rZx/AZ
 mre3qGv8XoOJQMKJ2jt/f2H8sVfiGNoFe4oSsf1K6NFbIhHIhLdOV3h6enYIRFGEJAim
 SAkEIcVZrg1MOKH53k6Z+t+G6Z50B/yWZ6qAsNtxQ+Aq4DQRfkXxTihbrk/2vNYDzA/L
 SiAw==
X-Gm-Message-State: AOAM530QFUIGEX7Pu1g6vBPmnGQtosXH2XdXCfxLb9OWlfg7yCLwQDAV
 vhRODmJRJWHuYPblW24HtmOspFhO
X-Google-Smtp-Source: ABdhPJyt70iT206XtyQhr5Hcdk4r1mgaJapv9v3kKs4WsSqDovQbQfr6kvUjFhQ5tl19nuwqZg/a0g==
X-Received: by 2002:a37:650:: with SMTP id 77mr22153236qkg.369.1591034666110; 
 Mon, 01 Jun 2020 11:04:26 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:25 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 070/207] drm/amdgpu/mes10.1: implement removing hardware queue
Date: Mon,  1 Jun 2020 14:00:22 -0400
Message-Id: <20200601180239.1267430-67-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

The routine is implemented to generate mes command to remove
a specified hardware queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index e1c0443031f9..bd986e5fa474 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -165,7 +165,24 @@ static int mes_v10_1_add_hw_queue(struct amdgpu_mes *mes,
 static int mes_v10_1_remove_hw_queue(struct amdgpu_mes *mes,
 				     struct mes_remove_queue_input *input)
 {
-	return 0;
+	union MESAPI__REMOVE_QUEUE mes_remove_queue_pkt;
+
+	memset(&mes_remove_queue_pkt, 0, sizeof(mes_remove_queue_pkt));
+
+	mes_remove_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_remove_queue_pkt.header.opcode = MES_SCH_API_REMOVE_QUEUE;
+	mes_remove_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
+	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
+
+	mes_remove_queue_pkt.api_status.api_completion_fence_addr =
+		mes->ring.fence_drv.gpu_addr;
+	mes_remove_queue_pkt.api_status.api_completion_fence_value =
+		++mes->ring.fence_drv.sync_seq;
+
+	return mes_v10_1_submit_pkt_and_poll_completion(mes,
+			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt));
 }
 
 static int mes_v10_1_suspend_gang(struct amdgpu_mes *mes,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
