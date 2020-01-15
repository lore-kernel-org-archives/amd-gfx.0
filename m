Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EA3C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 22:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C28207E0
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 22:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueJ7nRXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C28207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A1B46E865;
	Wed, 15 Jan 2020 22:15:55 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2198A6E865
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 22:15:54 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id c13so3671066ybq.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 14:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iAK9hp5uK0BUy0g9IbUXqSuGNjJXLBjrLJBw6nLbtpo=;
 b=ueJ7nRXLJDsc/gYn7kRebk9KBy4JGc01+OKIx1GjRg6KflCv/LiTO2o9N5g8nBZQAY
 FtN9GfdwLJJEapUoLyOxlmHKbbh3P0bkVC4UdJE0zDd78S7TEHJ9Gl1jKWhLHPj8+KxT
 mY0YtEk02BIJkvxpynDFNppqbwDSTFWLFPeycUmTQYahDwAoim6exnjIfiYEb2pYtin6
 PQ616YZMpWc9yi+ztO7GJ8fC2Z2W6v91gdKvpjB1rDXxlP9oB4iyZB9M9T7kUAqM3u/i
 AGUDQ6zm7yamcECbAFQPs3tuyh5K/xjmn9dZmSFP4RoZ5xoMQsWBcdA595LbN9ffZuIt
 bpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iAK9hp5uK0BUy0g9IbUXqSuGNjJXLBjrLJBw6nLbtpo=;
 b=XblOdm8p+SBN2K7wO9dvrIlG7xxlaUMX55QvWOLJSi10cnGU7sid6dBu1/LMi35VAS
 j/xERV3ncSWYkR0CI3LNftrftbil3U2Yl0HH/s62xad8W04TArZ0tsdpTuk0VcAcIijF
 TWyudtVQ58XjjeOXI/pc7lWQd8iD3KkqKT2sZe1Z6SloM0JOsHyphdReXFwrCQBlMAKQ
 KKS10px5trHH2wCLnzFcusqPS48jhZtD5MDvIQrrTp6bW9xhdinwuCwoTdcvqZjtcXOE
 FtoJm84T3t0fgagOnxSQw5GRrbd7+YfB1BYlC33F3sgSmC7pkPN2Isunv5WLPK1MWTjy
 38eg==
X-Gm-Message-State: APjAAAUdSK9HaNNnl1sn2D0Ga7ChDwBMutJqsG8azjbyrOQSmtx6H4LM
 /TrRDFwEEQUsQl5eeRXcQrhJn19A
X-Google-Smtp-Source: APXvYqxQxAK0QvV9oNHUVExX8uC3Q/c5QhGdK5NvV/UDjjJSgnuxFsEovZoDUPtew6ko6/+sYj7Osg==
X-Received: by 2002:a25:aa72:: with SMTP id
 s105mr19092701ybi.410.1579126553004; 
 Wed, 15 Jan 2020 14:15:53 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id g29sm9112315ywk.31.2020.01.15.14.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 14:15:52 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix typo in amdgpu_vcn_sw_fini
Date: Wed, 15 Jan 2020 17:15:43 -0500
Message-Id: <20200115221544.1712687-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

Using the wrong iterator.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index ab51f0e9539c..f96464e2c157 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -193,9 +193,9 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
 		if (adev->vcn.indirect_sram) {
-			amdgpu_bo_free_kernel(&adev->vcn.inst[i].dpg_sram_bo,
-						  &adev->vcn.inst[i].dpg_sram_gpu_addr,
-						  (void **)&adev->vcn.inst[i].dpg_sram_cpu_addr);
+			amdgpu_bo_free_kernel(&adev->vcn.inst[j].dpg_sram_bo,
+						  &adev->vcn.inst[j].dpg_sram_gpu_addr,
+						  (void **)&adev->vcn.inst[j].dpg_sram_cpu_addr);
 		}
 		kvfree(adev->vcn.inst[j].saved_bo);
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
