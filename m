Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F13BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E572077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj9RJq2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E572077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B589E6E2DD;
	Mon,  1 Jun 2020 18:04:30 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D0936E2C8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:28 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id z1so8471480qtn.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9Ayw+qeV185DPXGEZsZNzUPLYtX5hqA0L7W5wqIDZcI=;
 b=Zj9RJq2Iks3o1FaonfIQh97g/Q8m9uVO2aPJm6WiX76GNYpcstk5+zOpFvZm0JAzn/
 xQr13rxFrYdMznzUROhUkwRsSyC7e092Ak8hmCagI3LwviSHtgeY8eZCx7KJfZgTJxtF
 i5I4GjnmfK+HuoL1NkUd0Ywc6lpx0rI+68uMWFEWicsjiClTu34JFZXkwopvx8sZ4l6D
 m9ii2qRAhYr1xbjlR8hAfAuC6n+/KGc1hq35HN9f/oVA+S/zngpBgr7wuwiJmrk6kGr9
 XZT/vGSdtRIt8g8Qxk4yYKNpLJVlAeOfVTOCFsY1+vlz34jAr0nGFvr2qMotZmhn98Zy
 5aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9Ayw+qeV185DPXGEZsZNzUPLYtX5hqA0L7W5wqIDZcI=;
 b=Zy4ohwClxOfH6dqyg1NVHbeBf5NqRHAhy+mllfGTMDXw3grm3ZgKTvWDLhismXkum2
 vophRlsJBWE9VFY8aHumkpfdujmfqr2WGT9xZwSOlg2j374dgc+K41G6LtAXjYEoCP/h
 GA/aKn0ToPU55a1uM8vVl9picORRNfOKymq+MZ1fK7nqp8hYmTZs2ajevXfaelfgCO4w
 3FE+0gfTMFnYnu2sKK8oq3SAvos9LdQWsETp/bBdGL6zS2RMGGS8X0igG9fw3+335FTs
 TKD+4wTGg1MwJNL6jETcT8aJyGLOzTw8S2+WrbW+w2Ts8x/9EMQ7DYhewps/dUlcYpzE
 WhuQ==
X-Gm-Message-State: AOAM531fBpW4XtPGQMt7jqYS+wU8Zxv+gbkFWmfCRXC4Bj3dR3Zjlmi1
 CMVRLuwrtqSBuiPL8pboDTZ/b+Vd
X-Google-Smtp-Source: ABdhPJy/3RDcnROWkDEUvvDZO/aqRJFVEYcJ6Gjip+7VsZ+9NBlJQz53e4U35LfV5f7uO83L2FQlFQ==
X-Received: by 2002:ac8:78d:: with SMTP id l13mr2825608qth.37.1591034667559;
 Mon, 01 Jun 2020 11:04:27 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:26 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 071/207] drm/amdgpu/mes10.1: implement querying the scheduler
 status
Date: Mon,  1 Jun 2020 14:00:23 -0400
Message-Id: <20200601180239.1267430-68-alexander.deucher@amd.com>
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
to query the status of hardware scheduler.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index bd986e5fa474..27374561ff4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -197,6 +197,25 @@ static int mes_v10_1_resume_gang(struct amdgpu_mes *mes,
 	return 0;
 }
 
+static int mes_v10_1_query_sched_status(struct amdgpu_mes *mes)
+{
+	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
+
+	memset(&mes_status_pkt, 0, sizeof(mes_status_pkt));
+
+	mes_status_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_status_pkt.header.opcode = MES_SCH_API_QUERY_SCHEDULER_STATUS;
+	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_status_pkt.api_status.api_completion_fence_addr =
+		mes->ring.fence_drv.gpu_addr;
+	mes_status_pkt.api_status.api_completion_fence_value =
+		++mes->ring.fence_drv.sync_seq;
+
+	return mes_v10_1_submit_pkt_and_poll_completion(mes,
+			&mes_status_pkt, sizeof(mes_status_pkt));
+}
+
 static const struct amdgpu_mes_funcs mes_v10_1_funcs = {
 	.add_hw_queue = mes_v10_1_add_hw_queue,
 	.remove_hw_queue = mes_v10_1_remove_hw_queue,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
