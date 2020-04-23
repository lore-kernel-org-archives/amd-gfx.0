Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76D6C54FD0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE372208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fudan.edu.cn header.i=@fudan.edu.cn header.b="2PukIG9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE372208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=fudan.edu.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 211656E057;
	Thu, 23 Apr 2020 07:37:23 +0000 (UTC)
Received: from fudan.edu.cn (mail.fudan.edu.cn [202.120.224.10])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2A19C6E135
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 05:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id; bh=raVeIWaYg75pW07/IsX+vunYDfGP0hLRH+1G2wNODvA=; b=2
 PukIG9H0iiVv7WWOVDYsT7fChtU13lrqjmyoTJg5hm2uU6kHhfVhMmlrr4dgnMY0
 4+z4eHYOR5vG+L6bKo8vZ9m0m4j8P9nBaTVzfIxm/7E8323q3k+wHPSpx9epmzkE
 5OYTr7Efbjmnn7FJRVpwzgYj+vQFnHUoYiJeHOOvhE=
Received: from localhost.localdomain (unknown [120.229.255.80])
 by app1 (Coremail) with SMTP id XAUFCgC3JZzPIqFefZc8AA--.30807S3;
 Thu, 23 Apr 2020 13:08:32 +0800 (CST)
From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Roman Li <roman.li@amd.com>,
 Thomas Anderson <thomasanderson@google.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/display: Fix dc_sink refcnt leak when detecting
 link
Date: Thu, 23 Apr 2020 13:05:51 +0800
Message-Id: <1587618357-13349-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgC3JZzPIqFefZc8AA--.30807S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AryfAFyDJFyfWw1UuryxuFg_yoW8Cr4Upr
 W5Gr409r18AF1Iqr98Aa4ruFyUZ3W8JF1Fk3y5CwnYvw15ZwsxtF15Xr43XrW7WFZ8Aa9r
 ZFnFq3yxZFnruaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
 6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
 YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW8WwCF04k20xvY0x0EwIxGrw
 CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
 14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
 IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
 wI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
 AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbfOz3UUUUU==
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
X-Mailman-Approved-At: Thu, 23 Apr 2020 07:37:22 +0000
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
Cc: Xin Tan <tanxin.ctf@gmail.com>, yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
 Xiyu Yang <xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

emulated_link_detect() invokes dc_sink_retain(), which increases the
refcount of the "prev_sink".

When emulated_link_detect() returns, local variable "prev_sink" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in all paths of
emulated_link_detect(), which forgets to decrease the refcnt increased
by dc_sink_retain(), causing a refcnt leak.

Fix this issue by adding a "err_sink_put" label and calling
dc_sink_release() before emulated_link_detect() returns.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e997251a8b57..1b0c4f11b9b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1633,7 +1633,7 @@ static void emulated_link_detect(struct dc_link *link)
 	default:
 		DC_ERROR("Invalid connector type! signal:%d\n",
 			link->connector_signal);
-		return;
+		goto err_sink_put;
 	}
 
 	sink_init_data.link = link;
@@ -1642,7 +1642,7 @@ static void emulated_link_detect(struct dc_link *link)
 	sink = dc_sink_create(&sink_init_data);
 	if (!sink) {
 		DC_ERROR("Failed to create sink!\n");
-		return;
+		goto err_sink_put;
 	}
 
 	/* dc_sink_create returns a new reference */
@@ -1655,6 +1655,9 @@ static void emulated_link_detect(struct dc_link *link)
 
 	if (edid_status != EDID_OK)
 		DC_ERROR("Failed to read EDID");
+err_sink_put:
+	if (prev_sink != NULL)
+		dc_sink_release(prev_sink);
 
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
