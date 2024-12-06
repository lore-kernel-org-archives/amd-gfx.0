Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51B4E7717D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 14:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F0210F113;
	Fri,  6 Dec 2024 14:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m3m8/hX5";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA0010F11B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 14:35:40 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso406033166b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2024 06:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733495739; x=1734100539; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PVaB2JTYs+lHlwdEogZYGoy5Zahh53FmmeqmgfgU+GY=;
 b=m3m8/hX56jHngfD/dZQT905qGjFtJVJeFdCSwLmyjDwQyCuI5DZAno9Znpy6W4OxKv
 FElbiK5VVxNLMUYe/sIqdB6OjSEdfXY174Mh80B9aP/yAHVUSB3Og0ItTmxM3iLFTLXC
 s5VN5bj/5eHU63zlivao274OLp7II6QJiqr4fknCNYdH1GDuHerpHtCqlzGqZrIRh8zt
 Lp64yGOkKFTvL107iq4DBed64xeDaAS5RjA0vV005AdZyS7orlX3TPI3taevypTnQmS/
 9d++Nx3oiO5wTtS2Gfu3nUYOlYAInogBQ02iD5SalRF3Xxnf24szgeTxeCJuQ9HgV0gD
 y2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733495739; x=1734100539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PVaB2JTYs+lHlwdEogZYGoy5Zahh53FmmeqmgfgU+GY=;
 b=EOgDoPUHtwloSAJ/GqR6N2MY2U26wlGrikiWRDVCfJdxzs8fSO5F99TuMjwdksesx8
 5ynM5m/XarlFEK2GKYn/fxcA1Ne6dyyFX4GqNYsF7i4/Ldy+DoTbUrmjBt6Gm4pspHsB
 HyrYIvkn6qjrB1ie7tGG1GzBcFJrYl5ppD73tamRRoJejrz5lcmP7RP3ejdOyZV6aIO9
 9SpV9orD9Svgle1KyibpdmfWMGJTdfmpwhunw/g7dEK/2AVNzcdByG0K2zu0k7lO84U3
 YqKoau1scJ5eOBHhiwjodVScbO816Cr2p80vviySw5ZS3WyisXqL9iDWb1fDRTwnY2uS
 8zoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh9WLrsE5aalMXb9e2SThWCy48bFg8vm19Per/wGbaMlkpJx3ZMGSdUpZkpGYcrTWUxDq9DbGV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQiiKpD94RVToegUV9x4YweRQ6bpEQvS2cV8rvVcZOVimL4Y+e
 hEPuqSIqgr8V9xpL47Oq9byhGnR5gClzSBXzKyzJofWpdDjcgZFPlAXN3Hxt
X-Gm-Gg: ASbGncthOVQ4HF4S9zv8k+gpDSUcgL5+rbb0UEPzBGxADzUc1DTpQMHupLQqMfTWdZQ
 U2iJ9RPu0tshI5zh4X4ZzREq92sDDr6Spt3AyA8dPqJB3DIbpzbJpfu5guGsDaXq/UH8FXIE1Gf
 BNB+ieDd3Nk55zAttPJA6YnWjadUadN1ap9bCrerdimBVc05BzaFkxHS57n7kLonedREahFvFyK
 bDJzEr9/LBcvBnlh8AXbWevk5ZVEhfjVZI42Hp9wmzeWZiC4fkzptyBQLd89/o=
X-Google-Smtp-Source: AGHT+IHtN5dKxFLC1YM9T5C4XIQcQ5WutpyBz9Cd0IKpGmkZPIq8bavNdLMZnuQaRZZgBsqlm+K9BQ==
X-Received: by 2002:a17:906:1bb2:b0:aa5:1757:bdd3 with SMTP id
 a640c23a62f3a-aa63a03affemr295170166b.20.1733495738757; 
 Fri, 06 Dec 2024 06:35:38 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15fb:db00:10f2:24c4:16ed:228b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6260e2c31sm250984066b.180.2024.12.06.06.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 06:35:38 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix when the cleaner shader is emitted
Date: Fri,  6 Dec 2024 15:35:37 +0100
Message-Id: <20241206143537.2272-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Emitting the cleaner shader must come after the check if a VM switch is
necessary or not.

Otherwise we will emit the cleaner shader every time and not just when it is
necessary because we switched between applications.

This can otherwise crash on gang submit and probably decreases performance
quite a bit.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 68dd4130b5ad..db913d533898 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -674,11 +674,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
 		ring->funcs->emit_wreg;
 
-	if (adev->gfx.enable_cleaner_shader &&
-	    ring->funcs->emit_cleaner_shader &&
-	    job->enforce_isolation)
-		ring->funcs->emit_cleaner_shader(ring);
-
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
 		return 0;
 
@@ -690,6 +685,11 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (need_pipe_sync)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
+	if (adev->gfx.enable_cleaner_shader &&
+	    ring->funcs->emit_cleaner_shader &&
+	    job->enforce_isolation)
+		ring->funcs->emit_cleaner_shader(ring);
+
 	if (vm_flush_needed) {
 		trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr);
 		amdgpu_ring_emit_vm_flush(ring, job->vmid, job->vm_pd_addr);
-- 
2.34.1

