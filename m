Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCA3C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 03:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDA2238E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 03:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDA2238E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ict.ac.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AD1C6E8BF;
	Tue,  8 Dec 2020 03:00:05 +0000 (UTC)
X-Greylist: delayed 337 seconds by postgrey-1.36 at gabe;
 Tue, 08 Dec 2020 03:00:03 UTC
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9255F89AB7
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 03:00:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [159.226.43.53])
 by APP-05 (Coremail) with SMTP id zQCowAA3F+DS6s5fzjnzAA--.8552S2;
 Tue, 08 Dec 2020 10:54:21 +0800 (CST)
From: Chen Lei <chenlei18s@ict.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Subject: [PATCH] drm/amdgpu: add the missing AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
 flag 
Date: Tue,  8 Dec 2020 10:50:40 +0800
Message-Id: <20201208025040.30268-1-chenlei18s@ict.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowAA3F+DS6s5fzjnzAA--.8552S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWfCr18Wr47ArW5Jr1xGrg_yoW3KwcEk3
 yUuFn09r1a9F1qq3W3Zr4YvF1jyFyrWF48JF1YqF9Ykryjva4UZ3yUWrZ7Ja1DCrs3KFn0
 qa18WF15CwnxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
 6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
 4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
 Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8
 JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUatC7UUU
 UU=
X-Originating-IP: [159.226.43.53]
X-CM-SenderInfo: hfkh0zthlrm2g6lf3hldfou0/
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
Cc: amd-gfx@lists.freedesktop.org, Chen Lei <chenlei18s@ict.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag in amdgpu_gem_create_ioctl.

Signed-off-by: Chen Lei <chenlei18s@ict.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 7e8265da9..da18aeff7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -233,6 +233,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		      AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
 		      AMDGPU_GEM_CREATE_CPU_GTT_USWC |
 		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
+		      AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
 		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
 		      AMDGPU_GEM_CREATE_ENCRYPTED))
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
