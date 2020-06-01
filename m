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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C3DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84DC2074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqFUIFox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84DC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DFB16E34B;
	Mon,  1 Jun 2020 18:22:23 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7AF6E34B
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:22 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id s1so9989957qkf.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6F1WwHEpK0n7vFFrLOrZPUqJUdj6ag0KBByva51RFIs=;
 b=kqFUIFoxbqzpIjQLoDjia9Is3kqAiW10ku6sovvPk0T+meE9Fw4YmFrOkctdQUij+3
 GoUTeMFuqCQNT3XM7BkK3duyy+fhWWmu1UlwfJMLE05laCJAlcjmgzJJiqqHRdtSJhlr
 tU9Vu9nj2rYKL9hT8YwsQO4h0E5rWahaaYcZTU9MI1Y+BUMiE/2jbYeDP5C6BpZg9JHz
 ZhT0l48BWqL15hFG8wzH77DuOq84vpllmsAvBjRxND01wHb8EScdYv+lLG27w47D9ZRo
 liTf7HUSR+M5vosu/C+5aRXjX/iuGOo+JBh7BXK6Ub7k0ccT/s76Xn9UloS2QvtC6V3Y
 xigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6F1WwHEpK0n7vFFrLOrZPUqJUdj6ag0KBByva51RFIs=;
 b=fiA6dhy1mTdEP2jiO8mIzK4DTmU5uzHIVLlY6Yo9Wx39OBU++16QmLc3JjZJzSN16C
 y2ykryJ6Vef+MNlH9FdaEyUFmi4Mpt9pDh2xnBfUem1VvgNv/mP04B7cFPDonc7cN5+g
 8FV/d/PFu6YgegHms4Ux4Xvatvx66jaNeB/VsV8ahclnBly3VACKwWLGJc3d4GlqTvOL
 30ltLe4CYXo0avnfI6HztnCOx1cQ1hhLvN+DJhdqY2EdNWC3Dz10fu9g76r7WkN7EE3x
 oVT6Lcn47JDgCrhXnpvjKuC5MGFeNWACCaIJFXq2QZSb7A9Cs4JN62V51vdewZJaWrSL
 NR6w==
X-Gm-Message-State: AOAM530RAZmlUylvNJ6RnQNVW5RWQVYmQc95A7hTx+HKB3GLy34gVS45
 74azV8ZDi+1CsgoJj+Z0xTYkRT47
X-Google-Smtp-Source: ABdhPJxyIs0vDcBSHURr4SoO+nLuxXPc2EwjEFTuVheECpq6PaRRzDAAetq6FSsG8ydQAI+PMTKWvQ==
X-Received: by 2002:a37:607:: with SMTP id 7mr19877326qkg.385.1591035741532;
 Mon, 01 Jun 2020 11:22:21 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:20 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 149/207] drm/amdgpu: add workaround for issue in DPG for VCN3.0
Date: Mon,  1 Jun 2020 14:19:56 -0400
Message-Id: <20200601182054.1267858-60-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, James Zhu <james.zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

To workaround an issue in DPG

V2: update description.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: James Zhu <james.zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c9b5d5a3e239..98ba6ddde823 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1340,6 +1340,10 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		WREG32_SOC15(VCN, ring->me, mmUVD_SCRATCH2,
+			lower_32_bits(ring->wptr) | 0x80000000);
+
 	if (ring->use_doorbell) {
 		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
