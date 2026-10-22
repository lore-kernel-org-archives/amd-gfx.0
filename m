Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8AE606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GBLbs/Cq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0CF41124E0;
	Thu, 22 Oct 2026 10:55:17 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 592911124E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 10:55:11 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1434999f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 03:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792666510; x=1793271310; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X8vVwzM0wmBwrkWAH3nL/zHqQmqm9Ez+JnojL1djNzg=;
 b=GBLbs/CqKXTkeqs4t4Zc+SLYNOwLilDd13r6sIFpKpOrRsxU4yUHb5uEO//OOOF2hH
 eHOVEf3m8rBVb7f4qcpnOdqK8wZMCmfDCm38ezpRhmpAvjgpykvQMB7p06Ph9LzNZxtq
 9ZlYQeXVBR5ObXN6rZcJxGDVuenzf+D8weOl4GI+HE6lmGEg4PU0aybMElXl3+d0Ej8Y
 fkqWYG84I8Mspw7LuBYe3ljiDmAANdeUDCCQMgJMsuI5+BjBufqeCG+erRmmXd4fydXd
 LEgzLzfdaOrUYmYH1n2lS8GVw7mAs2arK8ujefytzSVRXenqhWe21gtP3ldKSA/2oF7v
 dwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792666510; x=1793271310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X8vVwzM0wmBwrkWAH3nL/zHqQmqm9Ez+JnojL1djNzg=;
 b=GHIN7yrMgA3piBQtfIz/rFIypxwAZS4p1rwyXMz0Y2T0JRp+L/meChIsertHYot1SK
 KpyUoo1w7KIglLImu1RrzPqrTH7jfukV8+5ajpxZefQ/L8yV2/3rQNBVKEkm4tTdeKgL
 S+qLGrTLT00Vrty89I/yXx1sl/YBFoPuCy6jarJvJa9nH+YPbaSoiT8rCgUd51JzayG/
 hHUm/KO9U0Jm7wlqYzw7ISwT8NPZQNIakQPdE1ia64aZCtWoNIankpYrObFYaJJsCSYw
 BNdETNtrbBW536aZd4z4kV28FgHRgyOa96KXVFx7GJg6Iw1XOjtgZbfBgKsaJrts8xfj
 94xQ==
X-Gm-Message-State: AFq9FYIPe8VrWJ88ctErqefd+Voo29jN9I4pa488mNlvS+wuzCOtT0tH
 0nSWBqaqQWe28Hm0c8BY7g7EEhJbElG5FUI/lTS2KWKPCDTdKNjy6IT/2zSj0Ieg
X-Gm-Gg: AYBFou3pAceVZas30fUK2yBq/PkkQKqGnyqS0TiqJAo3iDREj1waQpxmjEvyK0FSgzH
 toyuogfZuznkrGRB2qPeFz4lqlXrRFP/Up7Pw/oOFG0i3ubOEBGYplSg97fZJiTgeCPQQRmo6nf
 kLzxd1dTmONcR9YfOFU72yKXuVJYz8YFWhSSQg3xUem9/eH321tWYz5QIkjb9wn5ApnB72m4+Zm
 yuZUaSlXSKQK8VtfcvzmoA/vFsgv8Pw+/lsP63GIT+b3EUE3d3gfiMKYevo7rfZHx2pCLW5FF/y
 sjQZi9RJ975zAf8GVTIsurW16RInaEMq0uvLCN5fh+OTs4zkVbXSzNs6H5QUAt4WQfvP2jo9Nwf
 Vkm1TI73aPnfo2TyO5r2sOvLmiLCfr0ZdMY5QH5n8CKrGrpDuMpWxQp9MeS/KQ6BcPVfD6bOE0t
 qUTYOalhDaSoHQoSt8WK0jTpqZglN/Y0nK8LP4LxM6iBUem64l7UUNokWRmqmtBhlGtoXn1XBrf
 oD5z9wl+8/VR7W5u17K4PCMlzLKXWHDFoRlgOi4F1F+TJw2V8TDc+KEucipzp6ypd9EsPJctb8G
 uIcsdp7NbpgCwc2ay8EmVvMDbUAlGE9vOps4eaG/9VNOtvO0GMH/pcdu57l+NAhEjR0Lw5DRp+3
 TAqYmq+SSa5zwTAubreGNBu47EJj/Hom7BwhRnZ1r4DXnDyPPg/cUed1LfepKarCJTyp+mH4VlC
 SXoI8EBuEbA1FMjZUpN/J4zjXSTvAEBCY4IpQzbDHZZhkmg8QGyXz/LAYBTOAx9rP6QYmls01pe
 g0e0nmZWlhVIw==
X-Received: by 2002:a05:6000:200c:b0:48d:f7ef:cd1d with SMTP id
 ffacd0b85a97d-48e264a6419mr10586555f8f.9.1792666509398; 
 Thu, 22 Oct 2026 03:55:09 -0700 (PDT)
Received: from localhost.localdomain (188.42.205.77.rev.sfr.net.
 [77.205.42.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583e25asm12227393f8f.46.2026.10.22.03.55.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 03:55:09 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 alexander.deucher@amd.com, xiaogang.chen@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v7 0/3] drm/amdkfd: fix wedged teardown on surprise removal
Date: Thu, 22 Oct 2026 12:55:00 +0200
Message-ID: <20261022105503.60372-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v7 drops the bounded fence wait entirely per Christian's NAK: fences on
a removed device must signal immediately, and blocking for all fences
is the correct shutdown order. svm_migrate_copy_done() now does an
unbounded dma_fence_wait() and returns the fence's error status, so
the error path is real rather than a timeout escape hatch.

For that to be sound, jobs pushed to a stopped drm_sched entity must
not strand their fences. drm_sched_entity_push_job() queues the job
before drm_sched_rq_add_entity() notices entity->stopped and returns
NULL; the job is never run and its fence never signals. The fix for
that orphaning is posted separately to dri-devel:

  drm/scheduler: signal fences of jobs pushed to a stopped entity

Patches 1 and 2 are unchanged from v6. Patch 3 is rewritten: the
timeout is gone, the fence error propagates through both
svm_migrate_vma_to_vram()/to_ram() callers (with the destination-page
rollback and migrate->dst clearing Felix requested), and
drm_dev_enter() guards only the job-submitting sections.

Tested on gfx906 (MI50, 16GB HBM2 behind Thunderbolt 3), vanilla
7.3.0-rc5 plus this series plus the scheduler patch:

- SIGBUS'd managed-memory hog mid-migration: process reaps in seconds,
  kfd_processes_count drains, no D-state tasks.
- Thunderbolt deauthorization with live KFD processes: SIGBUS to all
  KFD processes, teardown completes, pciehp removal finishes, host
  stays alive (previously: immediate wedge/reboot without trace).
- Re-authorization: clean re-enumeration, KFD usable again.

Changes since v6:
- p3: removed dma_fence_wait_timeout()/AMDGPU_FENCE_JIFFIES_TIMEOUT;
  unbounded wait + return mfence->error (Christian)
- fence orphaning fixed in drm/scheduler instead of worked around
- v7 split: scheduler fix is a standalone patch on dri-devel

Changes since v5:
- p3: both svm_migrate_vma_to_* callers check copy_done() and roll
  back failed migrations (Felix)

Regards,
  Olivier

Olivier Kaloudoff (3):
  drm/amdkfd: tear down KFD processes before early fini_sw on disconnect
  drm/amdkfd: stop restore retries on device unplug
  drm/amdkfd: propagate SVM migration fence errors and guard submit with drm_dev_enter

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  18 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          |   9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c         | 108 ++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |   6 +-
 5 files changed, 109 insertions(+), 37 deletions(-)

-- 
2.39.0
