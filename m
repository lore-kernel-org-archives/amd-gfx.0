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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AA5C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49012077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP6aS0AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49012077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9757C6E2BE;
	Mon,  1 Jun 2020 18:04:26 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10AFA6E2BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:26 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id 205so9962596qkg.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cK6ZbaLKLgsG72VhsZS2t4yNmT6hHN/cerI0n6r+dcc=;
 b=iP6aS0APD9pXf6QcVBB/GavJ5nXjuGKxa78I4G2lnSl3tvsT0MuXK+jhvrPNwlINlo
 0yFwo6dsrms4DeKbFVhZu6VJp+fa0gJHgWnNuFEF0g2+MRK6Uqf57MeGSUu0PzaMTzA6
 mQ7sRpNaACZXha/razKYDxrddnMiz3LeRPaPDqxCq/t1CJHN1HlxqCU6i5mCaf+RM0gF
 l7tkyM+4Hio5yKyjf0cc0uzvSGJ0vviiGbH3GyoqzLaxR0AOe2d63iGwvwA1ypu8zqxu
 If4z1aCe1m7+musZVTnQ+VxWA69HPVz+DLKDS5EMAh6q7iFidYlxBl1BCO1gvCVRM3Zx
 F6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cK6ZbaLKLgsG72VhsZS2t4yNmT6hHN/cerI0n6r+dcc=;
 b=DXQ3+S0Uo6g8B2PAspxOgRLG57CukW4Wgaz0voF2Csy2Fi6mjnxd43mY3D52sIYeEJ
 xEmxFGqF3rlUU+pnNAswUAJoD03UAUw8h+2fLxVLloi2oKT+U+mBbMLBOrIS2xs95al9
 NCe2DKsx/ZskCBH8HglKnz2tdcoqW2UlaIh+wDElU3t2OUGmqCMz1u7VauCbQGwB+3by
 0SMxju3JGzqKd+X++vMps4Z1IM3NQ8YJ88fp9qCp61hKJi+Z0ZVXkOyofYMbu/m7O5kz
 szqqwig0BE3TQWJt4WWTzlf7J3LUbH8cGNWA191zrM+U2SnrqC2hOt5otmPHfjC2ECGw
 Vz9w==
X-Gm-Message-State: AOAM532IOxKMlzEZNyvQ1Chflu0OGNm030zTaGD2zuAaqdKXun6dBhb7
 P85b0NzCJ4uuIAJdbvEenezXH1nI
X-Google-Smtp-Source: ABdhPJzip7jDaccwARA7Wk/7qrgjgt3urxsTlrkpmp3Xa2hsYPYqazKJ+Rs4wE1kHCTCcfQxU2Coig==
X-Received: by 2002:a37:7105:: with SMTP id m5mr22229376qkc.370.1591034665047; 
 Mon, 01 Jun 2020 11:04:25 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:24 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 069/207] drm/amdgpu/mes10.1: implement adding hardware queue
Date: Mon,  1 Jun 2020 14:00:21 -0400
Message-Id: <20200601180239.1267430-66-alexander.deucher@amd.com>
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

The routine is implemented to generate mes command
to install a hardware queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 50 +++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 3ce77839468d..e1c0443031f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -108,10 +108,58 @@ static int mes_v10_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	return 0;
 }
 
+static int convert_to_mes_queue_type(int queue_type)
+{
+	if (queue_type == AMDGPU_RING_TYPE_GFX)
+		return MES_QUEUE_TYPE_GFX;
+	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
+		return MES_QUEUE_TYPE_COMPUTE;
+	else if (queue_type == AMDGPU_RING_TYPE_SDMA)
+		return MES_QUEUE_TYPE_SDMA;
+	else
+		BUG();
+	return -1;
+}
+
 static int mes_v10_1_add_hw_queue(struct amdgpu_mes *mes,
 				  struct mes_add_queue_input *input)
 {
-	return 0;
+	struct amdgpu_device *adev = mes->adev;
+	union MESAPI__ADD_QUEUE mes_add_queue_pkt;
+
+	memset(&mes_add_queue_pkt, 0, sizeof(mes_add_queue_pkt));
+
+	mes_add_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_add_queue_pkt.header.opcode = MES_SCH_API_ADD_QUEUE;
+	mes_add_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_add_queue_pkt.process_id = input->process_id;
+	mes_add_queue_pkt.page_table_base_addr =
+		input->page_table_base_addr - adev->gmc.vram_start;
+	mes_add_queue_pkt.process_va_start = input->process_va_start;
+	mes_add_queue_pkt.process_va_end = input->process_va_end;
+	mes_add_queue_pkt.process_quantum = input->process_quantum;
+	mes_add_queue_pkt.process_context_addr = input->process_context_addr;
+	mes_add_queue_pkt.gang_quantum = input->gang_quantum;
+	mes_add_queue_pkt.gang_context_addr = input->gang_context_addr;
+	mes_add_queue_pkt.inprocess_gang_priority =
+		input->inprocess_gang_priority;
+	mes_add_queue_pkt.gang_global_priority_level =
+		input->gang_global_priority_level;
+	mes_add_queue_pkt.doorbell_offset = input->doorbell_offset;
+	mes_add_queue_pkt.mqd_addr = input->mqd_addr;
+	mes_add_queue_pkt.wptr_addr = input->wptr_addr;
+	mes_add_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+	mes_add_queue_pkt.paging = input->paging;
+
+	mes_add_queue_pkt.api_status.api_completion_fence_addr =
+		mes->ring.fence_drv.gpu_addr;
+	mes_add_queue_pkt.api_status.api_completion_fence_value =
+		++mes->ring.fence_drv.sync_seq;
+
+	return mes_v10_1_submit_pkt_and_poll_completion(mes,
+			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt));
 }
 
 static int mes_v10_1_remove_hw_queue(struct amdgpu_mes *mes,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
