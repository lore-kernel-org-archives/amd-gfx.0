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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B521C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5481B2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrNZWVW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5481B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152646E329;
	Mon,  1 Jun 2020 18:21:59 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A366E329
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:58 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id c14so8977867qka.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DY339AbYrkJ7+KbJg1cbM8OZxMWorLvgC7igzTPCrOQ=;
 b=mrNZWVW87YEUn3p9RpnvOyrMYi0Z8Rh77LwUMCKGyzcltYALKJS1un0WaiBLBk2DP6
 gonPqNzLk7alcQxK2C07+bQj3foriVgzNcJK9vt3sB9qCDJH9aVxK2os3u3tvnfOXdWR
 kBcW1xEdW/4/udqLs7/bFuxAxGw351bxT7vsiJvRuNTH2OATkuxBKaS/Sys3vqir2JEE
 Po8LYPVqXk3IzMdVJ3uKhyy3LaYEpRSzjldmkG4vmMFo+dUEnnjMav/ghBudNwds/ASq
 UYfTem6Hp+HZuHN4gjp1nAkHj5INNZM6CU6c0Q/9E6z3cXtQtFmTFJL6BcZPKPb3HIkS
 mpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DY339AbYrkJ7+KbJg1cbM8OZxMWorLvgC7igzTPCrOQ=;
 b=NDt9q/Hht0WBIvJb9/kZ7Aa3S+L7p18mKxks3A+vy22k3nLbTHuaF3JDrh0YOdzMn6
 gnXde72EX825fqxHRI4GWI8ydMACg+A5o/vMPCAPVcZPSTlB452bvCotX+Ry5ajXKgGR
 NuRM/wTlTGLemD6wZH+TGe1G5784rgJ330wbrIijSPrLnDqdGgXAGNpmCEUr3zXg4/Bq
 8peIPyPOLRIk8ZM/M+jGsICRoXSzrTOlakhb5OgpcWNNxU5Xk5Ak0wM60+1kvBlE/7SB
 hfafeXPwJW5VmJj0pCrh4sGcqph5n3mI9jC+94m1U06jHX8XH/01JwgDPHinaq9tNDc2
 eF6Q==
X-Gm-Message-State: AOAM5330XNy3ftscNv793H9Gi6Ro73d7QaeCrbpgeSUprpdyZ7vfQ31+
 xvZSkDzs2t1muGeiRKBAPra6JmLL
X-Google-Smtp-Source: ABdhPJx028droCtekuFaLlMjfRfJG3Pb8MDPb3byCGNZr9AU5+LPWVt+iK8EZArCWBn/1NDanRtgtQ==
X-Received: by 2002:a37:7244:: with SMTP id n65mr20803811qkc.483.1591035717108; 
 Mon, 01 Jun 2020 11:21:57 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:56 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 130/207] drm/amdgpu/mes: add status fence memory definitions
Date: Mon,  1 Jun 2020 14:19:37 -0400
Message-Id: <20200601182054.1267858-41-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Update for new member query_status_fence_gpu_mc_ptr in MESAPI_SET_HW_RESOURCES.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 3 +++
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 4da9d8f50578..7334982ea702 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -82,6 +82,9 @@ struct amdgpu_mes {
 	uint32_t                        sch_ctx_offs;
 	uint64_t			sch_ctx_gpu_addr;
 	uint64_t			*sch_ctx_ptr;
+	uint32_t			query_status_fence_offs;
+	uint64_t			query_status_fence_gpu_addr;
+	uint64_t			*query_status_fence_ptr;
 
 	/* ip specific functions */
 	const struct amdgpu_mes_funcs   *funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 447bee159089..6ba0c04f7fb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -237,6 +237,8 @@ static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
 	mes_set_hw_res_pkt.paging_vmid = 0;
 	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr = mes->sch_ctx_gpu_addr;
+	mes_set_hw_res_pkt.query_status_fence_gpu_mc_ptr =
+		mes->query_status_fence_gpu_addr;
 
 	for (i = 0; i < MAX_COMPUTE_PIPES; i++)
 		mes_set_hw_res_pkt.compute_hqd_mask[i] =
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
