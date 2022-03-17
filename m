Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2460CC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 13:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2738210EBDC;
	Thu, 17 Mar 2022 13:50:56 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C5310EBD8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 13:50:54 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id t1so6658566edc.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f5Hg96guGARQ6KheV+UUCr298aclPxzSLMquwZGQxSk=;
 b=Sd/mvHD00xghKkZqqDzG3/1OcScUXYHbA25LcqgzYuXgjzWOie9JlUEr/UgMhuvxqU
 J/OdOuJ7ofMbABJyARCroNoSrTALsKiY19k81g9hhRmdxigeZgrBt5QubxVm8nssP56+
 vOXs2I84IYUTmZ2TSrHtXdBU0GGEw4HvPSgWgZJRvbjazo8ml9sUuf+P8zhI8mHuoJgJ
 O+8vG/6cKiBJH7Pi9ZtGWEFE0MSis3dT56y/1eEg/1D0bZtsTVCMc61mmuZPQivMDVEL
 0hzu7eOIIHI/+f1lA08xWh7w2DmB75s+isqrab9rBe9JT5gFn34kT1dkHzxZHkOx7tjv
 FDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f5Hg96guGARQ6KheV+UUCr298aclPxzSLMquwZGQxSk=;
 b=3exYVjjzhX4KV6ykila9btSdbjnd3docbOFnPdfW90JKoftVulgESdPL3yQLPc/7ZH
 iP3yJTkgRUuqEc1Ac2jp7/UAQqAVks6Weq6/esAVPzpqOM9mbJWSSky2kHU3RA7QMdCy
 I27L7757eOyrxeS5QnECM+J3Pw8dqTzdZoeOwKpO0GT0gM2I4/A9B0LOg+QwsvMliH69
 bUu0mw0sHaW5EWgX4eAgz2HkPDhTMpH25xMKK3HQIaBh7Kz8eHLDUUi+xcbma2HSNqP6
 MXdqJ7lsCLVYdgD5k4zl90riwKRZpppED+JjkyAcmV3sUb90S+/RSQIHOaUqIQKkt36h
 mgeA==
X-Gm-Message-State: AOAM532hd0XDbOzP46rhYBgLKF04k9rrhZKQEXO8ulqOInfug8OEgjpz
 8emVqrF64ii97fe/GX2yMhhDPUBT4qs=
X-Google-Smtp-Source: ABdhPJwvpeCZWr4qOlMa++aTVe4PHb2z5XpYdO40VOcpeT+77dlP9NRH7HG9kWMiZi3Ira0Zb7AiVg==
X-Received: by 2002:a05:6402:4301:b0:418:585b:cfe1 with SMTP id
 m1-20020a056402430100b00418585bcfe1mr4509763edc.250.1647525053070; 
 Thu, 17 Mar 2022 06:50:53 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056402254900b00416b0ec98b5sm2706721edb.45.2022.03.17.06.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 06:50:52 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Felix.Kuehling@amd.com
Subject: [PATCH 5/7] drm/amdkfd: start using tlb_seq from the VM subsystem
Date: Thu, 17 Mar 2022 14:50:42 +0100
Message-Id: <20220317135044.2099-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317135044.2099-1-christian.koenig@amd.com>
References: <20220317135044.2099-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of trying to figure out if a TLB flush is necessary or not use
the information provided by the VM subsystem now.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f36062be9ca8..945982a5d688 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -705,6 +705,7 @@ struct kfd_process_device {
 	/* VM context for GPUVM allocations */
 	struct file *drm_file;
 	void *drm_priv;
+	uint64_t tlb_seq;
 
 	/* GPUVM allocations storage */
 	struct idr alloc_idr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 59c04b2d383b..4a8a047b7593 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1560,6 +1560,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 		return ret;
 	}
 	pdd->drm_priv = drm_file->private_data;
+	pdd->tlb_seq = 0;
 
 	ret = kfd_process_device_reserve_ib_mem(pdd);
 	if (ret)
@@ -1949,8 +1950,14 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, struct kfd_process *process,
 
 void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 {
+	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
+	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
 	struct kfd_dev *dev = pdd->dev;
 
+	if (pdd->tlb_seq == tlb_seq)
+		return;
+
+	pdd->tlb_seq = tlb_seq;
 	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
 		/* Nothing to flush until a VMID is assigned, which
 		 * only happens when the first queue is created.
-- 
2.25.1

