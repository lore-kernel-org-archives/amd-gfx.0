Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38544C4321E
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 10:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 389FA10E19F;
	Mon,  5 Dec 2022 10:43:49 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2DF10E081
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 10:43:37 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id e13so15116074edj.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Dec 2022 02:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKv/YPe4KIU6T2AeltQH9Sip+g9lSl6DKVVfRY6CTkg=;
 b=nb0ADKz1YPk2h207JEgZxLBJ0aLytvtjamaynyUkA6ZCP+D/fhO0efr/04H67FkhEw
 9H7yFS/yTCkI/uJB9rhXvGhFqT7DMQvOmaTqOi6BZDoHyPMeuPLlLzYGUjqtOirVMtEr
 316t45b8aNtrUae+uV7qDkoxO7otT20PsARMof/H5Y4DyVDUsjNh8ReiftWBc1dC3WgY
 pYQetGsFEfYxZC7ABHIOovPmajZZw+IxV93WzUkJQJVpef6BddxxEhqHgGyuvlRTL87v
 YXnpw8xVOFtmTkvCPV9sLA3lM0xaC7WrrCDe9u3r+n+1qD0J3ijgQWTMIBTpMTnWC3g+
 J61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKv/YPe4KIU6T2AeltQH9Sip+g9lSl6DKVVfRY6CTkg=;
 b=TcAwJoOU77ExkEJeNjxVsR9omTj1ReD4K2GvPfC4jECGSBoxgFvg5z12ivXUrLIZA7
 L2wQZuSLxQFUHq/HUi4lfvccmLz2OuYf+Q/4Ft9pztSxBoG2nvMw0bEkcUtpeUu3m2Sx
 uz66Q8lytpzwl8gao4fhg4ppKkTxqc2rNLgdhf1VjmMucrCB+w+m0XQlqlJpZewERO/Z
 iJVrhBgA3yf2Mc08niWE8Tny6oBB1KsnNlBMH+SKczkC6agLP9zlGjkfoWpoYatPM3zv
 v5H4ZOu4vPCTX8Q6eLSE5zIYumqT13ItvauUGS9Iroa8ZnsWD84jq4Y/7AnTo7MQ3/nE
 fLbg==
X-Gm-Message-State: ANoB5pkKBNS6kUho3LSwSYZ8fPCjWc+JC0X2HT2e66V3I0ZayDaikqD/
 eqG9/9S0K88/UsxWPuWoSko/U1TRD+o=
X-Google-Smtp-Source: AA0mqf6//D9h2JogPhMCtBuq1jcIMO1OCiQK6h+YCMT+VTLAiJ5x8yf/pYQWTK6663oHGoWGrNMxmg==
X-Received: by 2002:a05:6402:a52:b0:46b:d3b3:669f with SMTP id
 bt18-20020a0564020a5200b0046bd3b3669fmr17969249edb.414.1670237016503; 
 Mon, 05 Dec 2022 02:43:36 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a056402444700b0044dbecdcd29sm4609432edb.12.2022.12.05.02.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Dec 2022 02:43:36 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: cleanup SPM support a bit
Date: Mon,  5 Dec 2022 11:43:31 +0100
Message-Id: <20221205104333.12536-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205104333.12536-1-christian.koenig@amd.com>
References: <20221205104333.12536-1-christian.koenig@amd.com>
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This should probably not access job->vm and also emit the SPM switch
under the conditional execute.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 9 +++++----
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 16bd12ddba85..7e5aad241295 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -315,6 +315,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 		return r;
 
 	job->vm_needs_flush = needs_flush;
+	job->spm_update_needed = true;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 64ff833cc95e..e9ff0ea08c28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -55,6 +55,7 @@ struct amdgpu_job {
 	uint32_t                preemption_status;
 	bool                    vm_needs_flush;
 	bool			gds_switch_needed;
+	bool			spm_update_needed;
 	uint64_t		vm_pd_addr;
 	unsigned		vmid;
 	unsigned		pasid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c2ee2e86286d..cf91e4440251 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -498,22 +498,20 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	unsigned vmhub = ring->funcs->vmhub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
+	bool spm_update_needed = job->spm_update_needed;
 	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
 		job->gds_switch_needed;
 	bool vm_flush_needed = job->vm_needs_flush;
 	struct dma_fence *fence = NULL;
 	bool pasid_mapping_needed = false;
 	unsigned patch_offset = 0;
-	bool update_spm_vmid_needed = (job->vm && (job->vm->reserved_vmid[vmhub] != NULL));
 	int r;
 
-	if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
-
 	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
 		gds_switch_needed = true;
 		vm_flush_needed = true;
 		pasid_mapping_needed = true;
+		spm_update_needed = true;
 	}
 
 	mutex_lock(&id_mgr->lock);
@@ -545,6 +543,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (pasid_mapping_needed)
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
+	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
+
 	if (!ring->is_mes_queue && ring->funcs->emit_gds_switch &&
 	    gds_switch_needed) {
 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
-- 
2.34.1

