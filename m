Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A276DC47DAC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D420A10E8B7;
	Thu, 11 Jan 2024 09:04:31 +0000 (UTC)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8D37510E036;
 Thu, 11 Jan 2024 02:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=nd6Mj0RtoD5c7xd3/S
 D4+mpKUxvN4uC5t+EZUCKM8Tg=; b=aEVDtYQ9pXCiMSUMMF7Lo4e0QAr6MIxsHV
 fiqJRc69dJuGRtXF1AcDGUDtTi8Wob/wEIVMh5fRPu/Z6IzjVSyngXWAgnrC1vst
 vig1EDSxCLmfWAtbdPFAf7/ham9TwEt+z5Q3NMpOULHASOH1UDqSfnNEv5M8oBIR
 T0cLQGS3Y=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3n6HjV59ld++cAA--.11062S2;
 Thu, 11 Jan 2024 10:52:19 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: airlied@gmail.com, Xinhui.Pan@amd.com, daniel@ffwll.ch,
 christian.koenig@amd.com, alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: Clean up errors in umc_v6_0.c
Date: Thu, 11 Jan 2024 02:52:18 +0000
Message-Id: <20240111025218.6599-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3n6HjV59ld++cAA--.11062S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1fZw15Cw1kAr48tFyUAwb_yoWxZrb_Cr
 WUJ3sIqFsrAFn2qw1avwsxZFy0vF1rZFWkAF1jqa4Syry7Z345XrWqgr1kXr18ursxCF9r
 Xw4qgr45JasrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU0tC7UUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWQVixWVLYT6O6gAAsu
X-Mailman-Approved-At: Thu, 11 Jan 2024 09:04:25 +0000
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
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, chenxuebing <chenxb_99091@126.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_0.c
index 0d6b50528d76..97fa88ed770c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_0.c
@@ -25,7 +25,7 @@
 
 static void umc_v6_0_init_registers(struct amdgpu_device *adev)
 {
-	unsigned i,j;
+	unsigned i, j;
 
 	for (i = 0; i < 4; i++)
 		for (j = 0; j < 4; j++)
-- 
2.17.1

