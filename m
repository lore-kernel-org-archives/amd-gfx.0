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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA15C2BA2B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 12:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8E920769
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 12:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXhyH5WN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8E920769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651E66E1E0;
	Fri, 10 Apr 2020 12:52:07 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EAFC6E1E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 12:52:06 +0000 (UTC)
Received: by mail-qt1-x836.google.com with SMTP id w24so1292082qts.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 05:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uP106l/ZvB6Gu/e/dYAw1Zrj7QRpLRNbUQXM6qGog/4=;
 b=NXhyH5WNZojrpOYzgHhcAeVrmcSzQziWzqQn/b8hLZWgFl38ria6ccUdaVPeNWX6EK
 G61F9ChZaqJVHGknOBhwg2mSXnMUbxG4hZTv9e6Oei5V6GHRAvLOe5s4rGF5UediBHlo
 xr9ac6ry4h3rXOq1Uqeib2AxS3mlf1GW8/8evzr1Wz5tqe5EQXbmjGVo9m5+qv2/GXWR
 6rU3ZTaFTtQWzPlVC+pnyNECjxOhVvY8S8c58oWiZLngRbC/BxgUrt3CYGwMcmcr/7A/
 Fb2+5zmwUtheR17Oyfoba2KGy64/av95ZPM27HtiB89/BWfAe2+RqpQ/xHl2WMLkxHFG
 CF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uP106l/ZvB6Gu/e/dYAw1Zrj7QRpLRNbUQXM6qGog/4=;
 b=QJSd2lAtmnRYW4h434mCGo3wgFs+D0vey0FHoGwzJNo3HKmJm9D4nuoKiLDvRKYgqI
 ZDKV0c3wLasqvTMlIeE3eUXJs684U99oTREGenhiH+TWsyibyPxAMz8vzMPg+qEBKZ9f
 403NkSKntnf3j591KTyhuGL4twml1RXAnTMAKU53pSNSbAaHSeazL8N6pfsOZMwayJxI
 p/iNDH0Ybh+HcBvjOty/87U84JK7hwIGwqXR8E5RS2Xk3BFw5OdsW+72wPxFyermpIbc
 /+5PmnqoHRgIZ/EM/w74JZ5y08PAtUZnbOORb2S5LXL0GxCesyht4llL+vTv4Kfvonsg
 BuNw==
X-Gm-Message-State: AGi0PuY4AbKnm/uwrMFGzW1OPPjupv+LrqYuYhPgWgx/5wLtgbJpJxfv
 cb0SvERO4SpmDIPAVIjr/EyD6SJM
X-Google-Smtp-Source: APiQypLciw44t8hb+wWONbLw7ASpClbwKfAxsxOSDXOdXeRw5JB4/2cAtl45RRptSHxnjxWTmkkjrQ==
X-Received: by 2002:ac8:4e56:: with SMTP id e22mr4297139qtw.185.1586523124940; 
 Fri, 10 Apr 2020 05:52:04 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id g21sm1524536qtq.26.2020.04.10.05.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2020 05:52:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu/ring: add no_scheduler flag
Date: Fri, 10 Apr 2020 08:49:57 -0400
Message-Id: <20200410124959.1489394-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.2
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

This allows IPs to flag whether a specific ring requires
a GPU scheduler or not.  E.g., sometimes instances of an
IP are asymmetric and have different capabilities.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 5f36bd58202a..4863e91c5533 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -261,7 +261,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	mutex_init(&ring->priority_mutex);
 
 	if (ring->funcs->type >= AMDGPU_RING_TYPE_GFX &&
-	    ring->funcs->type <= AMDGPU_RING_TYPE_VCN_JPEG) {
+	    ring->funcs->type <= AMDGPU_RING_TYPE_VCN_JPEG &&
+	    !ring->no_scheduler) {
 		hw_ip = ring->funcs->type;
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index efd7627b3f69..f61664ee4940 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -238,6 +238,7 @@ struct amdgpu_ring {
 	unsigned		vm_inv_eng;
 	struct dma_fence	*vmid_wait;
 	bool			has_compute_vm_bug;
+	bool			no_scheduler;
 
 	atomic_t		num_jobs[DRM_SCHED_PRIORITY_MAX];
 	struct mutex		priority_mutex;
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
