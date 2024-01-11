Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A786FC47DB0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90CC510E899;
	Thu, 11 Jan 2024 09:04:31 +0000 (UTC)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2045B10E070;
 Thu, 11 Jan 2024 02:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=9aR55xkwecnRVJ0nnM
 w73iproCVEKWqgG1rUjSYKFBg=; b=AuZFHS7MqHdcUB1kQ9Q0cdu9sPeOr6yEyS
 bOmbVOaZi4gUDoajsT8nD6YRgeVX9X37NHlN3l0mf6iX0/B78w3R0TG9Waf0kKQ9
 QrD9+nLkge4hP9dIFbzqTw3bwYIT1V58zztzPFMKAZEzUpNk9rewhrXhdt7ITcNS
 czw5X8BiA=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD3fzFmSp9l3IAsAA--.46727S2;
 Thu, 11 Jan 2024 09:54:46 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: christian.koenig@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, daniel@ffwll.ch
Subject: [PATCH] drm/amdgpu: Clean up errors in navi10_ih.c
Date: Thu, 11 Jan 2024 01:54:42 +0000
Message-Id: <20240111015442.5343-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3fzFmSp9l3IAsAA--.46727S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWDZrWxuFW8uFW5Jw4DCFg_yoWfGFb_Cr
 W8AryfXr12vF1qqrn8Ar4Yv34kKF1F9rs3W342qFnayryUZr4rAa1qgryYqayruF43Wasx
 Jrn8WF1YywnxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUrHUDUUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOgtixWVEuXlrAAAAsc
X-Mailman-Approved-At: Thu, 11 Jan 2024 09:04:24 +0000
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

ERROR: that open brace { should be on the previous line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index e64b33115848..57d04ed20357 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -722,8 +722,7 @@ static void navi10_ih_set_interrupt_funcs(struct amdgpu_device *adev)
 		adev->irq.ih_funcs = &navi10_ih_funcs;
 }
 
-const struct amdgpu_ip_block_version navi10_ih_ip_block =
-{
+const struct amdgpu_ip_block_version navi10_ih_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_IH,
 	.major = 5,
 	.minor = 0,
-- 
2.17.1

