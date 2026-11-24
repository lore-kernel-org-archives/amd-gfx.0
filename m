Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478A606A329
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=lekXeErn;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=BgJ6RP+c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C59BA10F746;
	Tue, 24 Nov 2026 15:54:51 +0000 (UTC)
X-Greylist: delayed 548 seconds by postgrey-1.36 at gabe;
 Tue, 24 Nov 2026 14:43:51 UTC
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD6310F61A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530882;
 bh=O0TE38rH24r1ohj7x/wS2xvssKoIpXBAg2G4OB/hzhI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lekXeErnWB4QigHY6Z5A/SmV5k32AEt6uPcjzKJzb02FNORnWA2cA7c+FUOS+tvxm
 GOkzYFjQvE00RYVfpguMrci2k1+g+8oKdCoR2yu+Dle+Hs0SVv4A1A/urR6trH5r7J
 y/ihRBjL1FAQxUEMxvPsJ8TXRivr4r0PQ3CdBr688W/lGhDqknyQydQ4mjjh6JApTW
 d5XQvSVpbd9j5b3OjbLJInXbhPaSMJqSdNqCLfNKKmUwMoev8cbPua/Q/2WoQUHRk2
 PbQvKODtjBXALvuifXgEJooj924tU/pDHEs1+f8PPekB0sAWBmXtd9KSvx6YKMKJ0A
 54VjU38n9w0Ow==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 51E1617F066;
 Tue, 24 Nov 2026 15:34:42 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vXV-bjnt7cL3; Tue, 24 Nov 2026 15:34:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530881;
 bh=O0TE38rH24r1ohj7x/wS2xvssKoIpXBAg2G4OB/hzhI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BgJ6RP+c+lxBj79h7EAM6HEClwy9UyDs8qLQOkVw+QTIezVU4yCpIUJeDJl/vmDOx
 KLISGnNaBZAW7L+KVdOfry3xFBEkWz3MIEhSB58AYy3KBblFu9PrJ8ZdSdiSO/BOVA
 S/nMEhI2wuzfbwvmN3qzIHI2ukZljRmXjLK7zMqmdiRBz0vU3baW+RiZ1zxJCoNbeo
 HEXd4GcpiUsdeyGvynZ7lgQWpqYPFoE4LssMm07+01/3FT/edK4bPj9ldf71+aTaeJ
 AsOpWG+cGG1o3XvaSlClfwM6NItFLliO83tGcAQRPnWGhdZHLGQcHlL7taQNFPfGVf
 XWn3FdolRRSAw==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id B493217F067;
 Tue, 24 Nov 2026 15:34:41 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>,
 "Claude Fable 5.2" <noreply@anthropic.com>
Subject: [PATCH v1 2/9] drm/amdkfd: factor out freeing of per-queue MES
 resources
Date: Tue, 24 Nov 2026 15:34:25 +0100
Message-ID: <20261124143433.49736-3-zappel@simple-co.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124143433.49736-1-zappel@simple-co.de>
References: <20261124143433.49736-1-zappel@simple-co.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 15:54:45 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The gang context and the GART mapping of the write pointer are the parts
of a queue that only exist for MES. They are freed in
pqm_clean_queue_resource() together with the GWS bookkeeping.

Move them into kfd_queue_free_mes_resources() so that code outside the
pqm can free them at the point where MES is known to have let go of the
queue.

No functional change.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 .../amd/amdkfd/kfd_process_queue_manager.c    | 21 ++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3292e616d..0c276f7eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1387,6 +1387,7 @@ int kfd_criu_resume_queues(struct kfd_process *p);
 /* Queue Context Management */
 int init_queue(struct queue **q, const struct queue_properties *properties);
 void uninit_queue(struct queue *q);
+void kfd_queue_free_mes_resources(struct kfd_node *dev, struct queue *q);
 void print_queue_properties(struct queue_properties *q);
 void print_queue(struct queue *q);
 int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index b68e884b1..89e95b70e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -186,6 +186,21 @@ int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p)
 	return 0;
 }
 
+/*
+ * Free the storage that only exists so MES can run the queue: the gang
+ * context and the GART mapping of the write pointer. MES addresses both
+ * directly, so the queue must be out of MES before this is called.
+ */
+void kfd_queue_free_mes_resources(struct kfd_node *dev, struct queue *q)
+{
+	if (!dev->kfd->shared_resources.enable_mes)
+		return;
+
+	amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, q->gang_ctx_array_index);
+	amdgpu_amdkfd_free_kernel_mem(dev->adev, &q->gang_ctx_bo);
+	amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&q->wptr_bo_gart);
+}
+
 static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 				     struct process_queue_node *pqn)
 {
@@ -210,11 +225,7 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 		pdd->qpd.num_gws = 0;
 	}
 
-	if (dev->kfd->shared_resources.enable_mes) {
-		amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, pqn->q->gang_ctx_array_index);
-		amdgpu_amdkfd_free_kernel_mem(dev->adev, &pqn->q->gang_ctx_bo);
-		amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&pqn->q->wptr_bo_gart);
-	}
+	kfd_queue_free_mes_resources(dev, pqn->q);
 }
 
 void pqm_uninit(struct process_queue_manager *pqm)
-- 
2.56.1

