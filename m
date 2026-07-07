Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD470C43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 12:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA18610ECD0;
	Tue,  7 Jul 2026 12:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="dByC/pNr";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F5A10EC28
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 09:38:23 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47dec32798aso262818f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2026 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783417101; x=1784021901; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/GXN7KALIdbRbK09e4URWXHozY0BPCu8Afi5h74f/sk=;
 b=dByC/pNrWS+mnVJ6M7BuUxdFRB9v+MJBeh5tF8a4rZLeOBgkq8ZPPCAk5CCyAu2WGn
 S1+xKfTJNjkbY5SJNe+Y4o27GEbOHMHI3PX386JyK7qMkusnCHi40+7mRP/0P4vjtWB4
 x25gmy5/Guh9nz0LPdRYkXNvXFV8i55rd/7XOip9JoSiS5eUTb1c5Tmz5Ojb/SyZaPRr
 6ejunm18yo/CyCJ0t/GBlKrI2oP1ETs09Oa0MDb9Yd0gW6eCWfLe8abeqlBiUgP40270
 JnMox/GyI+TsT3N7mnXFjoZ/FidqGD/Tx1YPJqfaryk0kAEJHohJ+5fwDcl5pp5/tIAC
 Msuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783417101; x=1784021901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GXN7KALIdbRbK09e4URWXHozY0BPCu8Afi5h74f/sk=;
 b=oWBhOpeYDAY9ueZg7WWnnmqm9fvDFjDRlfy18MsVwBJdfpYaeZE0RjiSwwH+00x/PQ
 mMzdgMGtIk2R9CDIQGzYMrj3WSqY5UwPisF3+Ueu9R0u4tR/c6DlcMOWsaZWQP8WUPb9
 OvZq65xqTv4CaGk8kFFs+TY6PrN+K9smOU4Mling14TpAlqbJ1jTVix9u/eAO9q6K8Hu
 t7mClJZYeBd6NifwsZruthY4L9PUTPyCrjLNANIKNfqGWri41Rd1rVdFKR8CPMnhKZxJ
 KIdGeaxrvVhKCeOY2PA2kTj10mzNUfbPqsAswOlb9mCvFldRXFyjr50yxKI14zsUINmN
 DASw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzPYIYc6s1PoxuV9S/c5wmlkmiKjihVq11tUAE8YZ54FEP1/6O15l3HT/Ae64U007CTnHVF2pO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlKAUgNrOakmdZJBmM3niTLy+ENUxYZr6xywXqqLfE9RRZEKdy
 dqcXUZJaIcOAlAgF7vAu4DYW1rL83nwOotRS7kSVLHEkOihdpXS0ALsho0il93aPXxo=
X-Gm-Gg: AfdE7cksYm2GOII5CDC5q00sM5rlq5ZMQ6LANKfM2Ny+Siz4DdKHv415uKpl6Y/+Xsn
 KRNpMLyX4Ho0btlMM696ZF4bOCaa3UFZrRRjB/aommd7xQNNaVuAWRLCPCGiKyotVGS9gfN07KH
 ArKZKRDcicXzvdJmXQp8SpS9+yS/EhlFSmpHa/TIG1tvvvEUxtWCXgpeMBCqpSeXVkrMz83iCpv
 /ie4i1PQOa88/H5XzupcOS773OzCFsv1UvsMC2HCuGVZP7lt+ZokjvSW0gOAc+YRqQa7GzQa6Au
 HLdsVb/VKcUZUE1bPXx3C9GVi2WqEMmzBJ9NsMzjRT3YBD3EOpc4uxeyyoiEv3csmbLwD0g58AM
 Vo4cumByPYIkBtmdqum6Olg3D542G6Pv/AwNnUlCkMq6H5tb3LBm/yeUMGsoWxNmD55oYzEz/Bt
 yNqc6qjHlIHVTNEIECw+owCXmDQkPVVFo3Frgx
X-Received: by 2002:a05:6000:46d0:b0:475:f0d1:eb6d with SMTP id
 ffacd0b85a97d-47de666d761mr3612337f8f.58.1783417101587; 
 Tue, 07 Jul 2026 02:38:21 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f214d2sm31578816f8f.33.2026.07.07.02.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 02:38:21 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Ce Sun <cesun102@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Timur Kristof <timur.kristof@gmail.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Change system_unbound_wq with system_dfl_wq
Date: Tue,  7 Jul 2026 11:38:12 +0200
Message-ID: <20260707093812.109176-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Jul 2026 12:58:30 +0000
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

system_wq (per-CPU) and system_unbound_wq (unbound) are the older
workqueue name, replaced by system_{percpu|dfl}_wq.
The new workqueues have been introduced by:

  128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")

Usage of older workqueues will now trigger a pr_warn_once() because they are
marked as deprecated as per commit:

  64d8eae3f895 ("workqueue: Add warnings and fallback if system_{unbound}_wq is used")

So change the used workqueue with the newer, keeping the same behavior.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 53be764968e4..95cceed4e971 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -545,7 +545,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
 			 unsigned int num_dw)
 {
 	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, num_dw);
-	queue_work(system_unbound_wq, &adev->irq.ih_soft_work);
+	queue_work(system_dfl_wq, &adev->irq.ih_soft_work);
 }
 
 /**
-- 
2.54.0

