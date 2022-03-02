Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A1AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 08:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBC610EE91;
	Wed,  2 Mar 2022 08:56:08 +0000 (UTC)
X-Greylist: delayed 852 seconds by postgrey-1.36 at gabe;
 Wed, 02 Mar 2022 04:50:38 UTC
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com
 [203.205.221.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1213210EAF6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 04:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1646196634;
 bh=D/JdRfylauMoYuXSlLyF8tsjvhJVrbjWvgwY8MY63gc=;
 h=From:To:Cc:Subject:Date;
 b=mGVgoVNtfLLgI3/d0ev9KvIaylV7RiDKFPYVpnnIqDQRLupWbbiU0iYdr2pyqxDsk
 jxSZyOFvr5Cio0YBjm280vt0kSjHiKnA+/aJLTIqcIYCrC/3ILKMOJydEZOlFeoQtA
 QIIkXoTK8miJJCpnygoXDzZ7ma8Q6KhrXZb7UjZk=
Received: from localhost.localdomain ([111.193.130.237])
 by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
 id 8CD270DD; Wed, 02 Mar 2022 12:35:13 +0800
X-QQ-mid: xmsmtpt1646195713tqoswx7ca
Message-ID: <tencent_A4D5E94B44BF0EC4B7CE08BA886C0C1B0F06@qq.com>
X-QQ-XMAILINFO: N4iYxAloTBN2ZUMPUy1xluA/jtpl/Uf22h8LXwogTwdpkdjhkPjkc88KXkfpOB
 gc/ln2DHqfScc99zwkwDKqLBsTq1PzkA8sOjfLtOASXFVE0ikpnJYGrqhShEiCAXCLaX/w+PvR++
 CL53GC67hf4Q1BV/DzYZlPCdnP0EaYtvy0xGc1cQavZys5XspwQD09Bb7+w5FqURL/Fwl3zcjrZ5
 iPpyochoWge0X25Vq1OBoOePDZEj1CF/QxaheeCQnbGZevQX0EV2K1rUYHmNbdAca/KB9Q6/UvrO
 orQMqwG+A1MB1fuKHAyzWEebOtaD/BueghCWjhoFlbY5odQLFzZrw10dFfU2QyaciOXBq9R6f0RK
 A4OyOIypfyQ/rC4REQzq8DBvRQ52H0kNqcClIKqCxe8yCnHMW9oZi9qt/j+/zmtWCpu44bhfQ0Kf
 PN0pLVmjxHaAnEJTffZK53Uvmf4JpmQ1tr/iYcP/wf3EyPQh4tvX7rsQSYvIbtE85JN7iO3ZPHus
 6RpMsWEjUizKb6kWNLHkz1f9nc6OfiwzwnpLbtDPMzbXb24/E4yb72ACCgOgWPH1lQIa4S4/WJqO
 bACHeTkqwvl2lOayu7k20ThshnQQrpf16NVodthzgl2g4SF20JDOeRN+C0lcU45JUUP9Q1TxvTox
 eTvngp8hz4N36wg+8xQEp2fMiYZb/h0j6imR6rLW71qlkA9W56W4DcYkUXK6Hz5SGBuRZKiCgtx8
 zTlNDGWAcOZodOQZ3QqrcOtHvMSGHjPKGKt+RQ9EQebS8QiTFLqcWTrgB6sDz12QSnDrPKoO4EhW
 yEqHRbWCsOGAXPRJX+2A2RpTf8EUzrfY7ge0gEMveBqnCJQX1VjvnHXIdRn8vkKqKRTBl9G4vh5d
 SH6SwJ9ViDXJwS0goRjQpBu6DFEBrH3AdTpdDoJ1VK
From: Weiguo Li <liwg06@foxmail.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: fix potential null dereference
Date: Wed,  2 Mar 2022 12:35:12 +0800
X-OQ-MSGID: <20220302043512.574707-1-liwg06@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 02 Mar 2022 08:56:07 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

"ctx" is dereferenced but null checked later. Swap their positions
to avoid potential null dereference.

Found using a Coccinelle script:
https://coccinelle.gitlabpages.inria.fr/website/rules/mini_null_ref.cocci

Signed-off-by: Weiguo Li <liwg06@foxmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index f522b52725e4..b4f035ce44bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -258,11 +258,12 @@ static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
 static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
 					u32 *stable_pstate)
 {
-	struct amdgpu_device *adev = ctx->adev;
+	struct amdgpu_device *adev;
 	enum amd_dpm_forced_level current_level;
 
 	if (!ctx)
 		return -EINVAL;
+	adev = ctx->adev;
 
 	current_level = amdgpu_dpm_get_performance_level(adev);
 
@@ -289,12 +290,13 @@ static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
 static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 					u32 stable_pstate)
 {
-	struct amdgpu_device *adev = ctx->adev;
+	struct amdgpu_device *adev;
 	enum amd_dpm_forced_level level;
 	int r;
 
 	if (!ctx)
 		return -EINVAL;
+	adev = ctx->adev;
 
 	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
 	if (adev->pm.stable_pstate_ctx && adev->pm.stable_pstate_ctx != ctx) {
-- 
2.25.1

