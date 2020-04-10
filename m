Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77722C2BB86
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 12:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4986A20769
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 12:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BydqKFVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4986A20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7A46ECDD;
	Fri, 10 Apr 2020 12:52:09 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C946E1E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 12:52:06 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id q17so1039147qtp.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 05:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0/uGiQQylMFcCX1egQAFPs0VR0OpqEp3/ZacviSL9N8=;
 b=BydqKFVzdudJNkDlxx/ibKVDDExTlOHFtmb3aCTNe3M7uAYQS33/bVrvzSXIqwiPxm
 Q+euE66pjIqYYwRrGjjS79jZ074muNJeIKI4oocY1FSAyE2RBfyq8JXjGn/GWX9vJ/N+
 gyWu4u1mU3HBTgIQ2PSFt+QOjJ2Qh5PFsUbMJGOYoiGb2ix+ZWSseo3p4VttxP1RblZE
 B9cOIzmkLVcLbuA2A1bRt4tnFCXyv1Wej7Nbmg2A9Q+1+4Vx3RNK+H604TdywOph/swj
 M1vgYJtj/fiCD9rqu9SkS60nlnkIls9XkmS0xQHDBq3gAQ4by52E6WbXWgpglVjUuMMB
 FO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0/uGiQQylMFcCX1egQAFPs0VR0OpqEp3/ZacviSL9N8=;
 b=iVyWDqHFRXqWAJp7JsbJ6i+Q8YMx36uO1C4nj2WoMp+2jPtZgv547Ir86Gt+Gpxlr4
 b+vsNQgs0J5tTDs3oAsV7lmnShUlq+aKBT/jhfDxrhKz6rs9nOO8PQHEvJzHP85vYY9k
 RFPpcwqG3wGQxXEYQ7jDXRakVVIdYeW9zfuEnT104cDM9jXT1D8Pf+Ew8dIjEGsXte4a
 ALcLvwmyhnx8g7kNrCeQkn4aA1CzQzsJVyOWZK242X4Z9a9kPL4tMd+o0j8pXdAWVU+v
 rbO+EU98mEqu6Yu5rTEt9+8/R5ATqWYsE7riI9JS7TAQ5Yg75Or0lCy/xLg+cum6JQLU
 BKNw==
X-Gm-Message-State: AGi0Pubxasv3OOmRdUMx1SBF7sYl+hbZK/GYCDl02l+kVO7PcQD8sHCv
 rG8T9PPPtUbwPc92/cL92lBP00/Y
X-Google-Smtp-Source: APiQypKsWac/hEnF4EvH8QDzviE+PGbDD3Ap63JMiJV+srYIcX8YmEtBoVClB3aKwf/j1NsVX2VFcQ==
X-Received: by 2002:ac8:18c3:: with SMTP id o3mr4380376qtk.49.1586523125747;
 Fri, 10 Apr 2020 05:52:05 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id g21sm1524536qtq.26.2020.04.10.05.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2020 05:52:05 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu/kiq: add no_scheduler flag to KIQ
Date: Fri, 10 Apr 2020 08:49:58 -0400
Message-Id: <20200410124959.1489394-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200410124959.1489394-1-alexander.deucher@amd.com>
References: <20200410124959.1489394-1-alexander.deucher@amd.com>
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We don't want a GPU scheduler for this ring.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 92f2e59056c9..ea576b4260a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -318,6 +318,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 		return r;
 
 	ring->eop_gpu_addr = kiq->eop_gpu_addr;
+	ring->no_scheduler = true;
 	sprintf(ring->name, "kiq_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 	r = amdgpu_ring_init(adev, ring, 1024,
 			     irq, AMDGPU_CP_KIQ_IRQ_DRIVER0,
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
