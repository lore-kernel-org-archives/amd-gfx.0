Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D88AC55179
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EDB22283
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kbv2wrvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EDB22283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0E36EB52;
	Tue, 27 Oct 2020 09:51:46 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E8D96EB4D;
 Tue, 27 Oct 2020 09:51:43 +0000 (UTC)
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de
 [95.90.213.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1A0A52467D;
 Tue, 27 Oct 2020 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603792302;
 bh=5vDvj3oyzh1Zm3XZyqT4S1ZktLUHAAkzgfhs/XvhF0g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kbv2wrvY2jihYBFGLE/Yg2vUUrX9J+UvwwK/VyhCFicXCGFnq+GSYdX/esugtNTzl
 zX6G5mvSt5TB+EkFXs6iJjUWGuTWpT3NL5r/ueNsMC0QXe0VjWufFf2zG3JliuDKS9
 g8GrpxFmK1GH/pPBjsLqyj/CaawGPgt6WOnrBxSk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
 (envelope-from <mchehab@kernel.org>)
 id 1kXLdj-003FFn-VV; Tue, 27 Oct 2020 10:51:39 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 30/32] amdgpu: fix a few kernel-doc markup issues
Date: Tue, 27 Oct 2020 10:51:34 +0100
Message-Id: <e899f50404e94ac9a7c3267dd34f951c1a44fb2b.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A kernel-doc markup can't be mixed with a random comment,
as it causes parsing problems.

While here, change an invalid kernel-doc markup into
a common comment.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 641c039150eb..5dbe93fe884c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -239,9 +239,11 @@ bool amdgpu_device_supports_baco(struct drm_device *dev)
 	return amdgpu_asic_supports_baco(adev);
 }
 
+/*
+ * VRAM access helper functions
+ */
+
 /**
- * VRAM access helper functions.
- *
  * amdgpu_device_vram_access - read/write a buffer in vram
  *
  * @adev: amdgpu_device pointer
@@ -4497,7 +4499,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
 
-	/**
+	/*
 	 * Special case: RAS triggered and full reset isn't supported
 	 */
 	need_emergency_restart = amdgpu_ras_need_emergency_restart(adev);
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
