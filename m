Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78526C2D0C5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6DA214AF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="whdJJl7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6DA214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC3886E983;
	Tue, 10 Dec 2019 21:17:27 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F6A6E971;
 Tue, 10 Dec 2019 21:17:23 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 535282468B;
 Tue, 10 Dec 2019 21:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576012073;
 bh=SBUx8yMp2GaWVuXdQGHugz9n6zPokEyvWLzJ9x4GqU8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=whdJJl7MCMzVqPkTV8iz0elwtIhrANvDrJfM6H5cWyIEhNRg4soUbd/ndZfUt1Yjh
 nSv+ypy2fByHVZ9AUvDAe7M/c0pBHWWi7YHKQx3M7KxAPEtGPUlWbvZAf6cNgXfuat
 I9rnsH9ukG5k4p9kq7zguqHsfdOpzyMp648fw7RI=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 053/350] drm/amdkfd: fix a potential NULL pointer
 dereference (v2)
Date: Tue, 10 Dec 2019 16:02:38 -0500
Message-Id: <20191210210735.9077-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Felix Kuehling <Felix.Kuehling@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Allen Pais <allen.pais@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Allen Pais <allen.pais@oracle.com>

[ Upstream commit 81de29d842ccb776c0f77aa3e2b11b07fff0c0e2 ]

alloc_workqueue is not checked for errors and as a result,
a potential NULL dereference could occur.

v2 (Felix Kuehling):
* Fix compile error (kfifo_free instead of fifo_free)
* Return proper error code

Signed-off-by: Allen Pais <allen.pais@oracle.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index c56ac47cd3189..bc47f6a444564 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -62,6 +62,11 @@ int kfd_interrupt_init(struct kfd_dev *kfd)
 	}
 
 	kfd->ih_wq = alloc_workqueue("KFD IH", WQ_HIGHPRI, 1);
+	if (unlikely(!kfd->ih_wq)) {
+		kfifo_free(&kfd->ih_fifo);
+		dev_err(kfd_chardev(), "Failed to allocate KFD IH workqueue\n");
+		return -ENOMEM;
+	}
 	spin_lock_init(&kfd->interrupt_lock);
 
 	INIT_WORK(&kfd->interrupt_work, interrupt_wq);
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
