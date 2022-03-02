Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84193C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 16:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2E110EC68;
	Wed,  2 Mar 2022 16:17:49 +0000 (UTC)
X-Greylist: delayed 42145 seconds by postgrey-1.36 at gabe;
 Wed, 02 Mar 2022 16:17:48 UTC
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com
 [162.62.57.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 053A810EC68
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1646237862;
 bh=h54ggvRxqi6Eh2jAuKV4V3B+HbRiwHUaT51TNqE38wY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hOiGQvML2nea+17fQKH5/3V4wjSL538iXm8la+mlRTfVw7GZR5t3ox17TDoOEyNv/
 f/JPtYwItjnt85yBabs6hadLBYLiKUkXYNpFDHuo4cR+/fI6ykI8zl8TSUQ1kkc+W/
 sq3jJ4dmGLS0Qh96HkGqFcnCn0Mqw2rLzl8/LtMk=
Received: from localhost.localdomain ([111.193.130.237])
 by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
 id 4672A85D; Thu, 03 Mar 2022 00:17:39 +0800
X-QQ-mid: xmsmtpt1646237859tc6wr6jlf
Message-ID: <tencent_DD9048474C138FE4294644B7CEEDF7D84806@qq.com>
X-QQ-XMAILINFO: ORuEwgb9eurk6ANUdRyWVVtOmbG3L5aFT0qJovIFMBUKuzeelPatJ/B0gO2LsV
 g4eElJILrR03NNr7f0WRVqSIo3mlIu4ahjoOG75kWNvRupvOFtwkbWTSOZYsNP8OFSlJdi5yD3o3
 NRndf5+XAVY7KbuwC/FrsCzM6j64obw3RSWRxburhHT0xBT+zkjpYBjf2HCaUDJNyfWD4oVPM05V
 ZSwUSy8Q3xAsrBUJxA15wjvx1nIrF1EvvTT+YhL4eaDU8A+3VXtbpwKQNEC/xQuulrMsGDJ/xHMo
 8MYJkpTpW95yMBmY9hAaQhJxKkFOumz3HDruWDjqIQP9J/th8f1HzMfx3ik+5LpsWtCLJG1mC0Z2
 2DOWuhDQaomsBaSWNlCRwE59y4BHUh0ucRF5CC+JfVI3lYZWr4eCM8PEGd6pBl8kkNykgDq0/u/9
 qPjtCaUpvnxUEgHR+HYiyHxIhoDoHZK4FWc26cgTgwTnm8+JNksNmkn0FVjQGAgjFbcSdrUSUz9l
 wqXP9J0cLgEQ6bboM/zczinQjY+ELcofKD5Pm1ahwNUWqoZ7y0s13rsZWvwvfv8dRve565/NXlUN
 +adTJdEpd1PzLzwZFjolYk/jelBJhaAcXL+rm2Lx+Y0W3kL/j7YByTRQ5zx0NIbgMZqKoT867MhI
 glfAP9TQIn0Y7iQPdWVw7jD6qGkeCK/E79rafegZXPSRLcbsPJAlic7S9LBUO351SiazK7n1BgEj
 TZ26HXqVV0jUF3tiyG40bOgnhX11ov+Z/9mTKMWT0VKZUhyJcio3StbPxirJMmF34zfu1dPGf+wy
 XmGlepw5Wd4aV4JN7Uv+4gX9v06UcEL23av2/mDYTTqJa+tlme+lmeYqa6EJCeM90g6NpZmN2O1G
 15I6R0wV6ctUbWuFjY0EI=
From: Weiguo Li <liwg06@foxmail.com>
To: alexander.deucher@amd.com
Subject: [PATCH v2] drm/amdgpu: remove redundant null check
Date: Thu,  3 Mar 2022 00:17:39 +0800
X-OQ-MSGID: <20220302161739.617215-1-liwg06@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CADnq5_Na2UtFUTX5uphZH6THw7PisPM835TLgjB=Ne_3==VJUg@mail.gmail.com>
References: <CADnq5_Na2UtFUTX5uphZH6THw7PisPM835TLgjB=Ne_3==VJUg@mail.gmail.com>
MIME-Version: 1.0
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
Cc: ckoenig.leichtzumerken@gmail.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the redundant null check since the caller ensures
that 'ctx' is never NULL.

Signed-off-by: Weiguo Li <liwg06@foxmail.com>
---
v2:
* take Christian and Alex's suggestion
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index f522b52725e4..2f38de406937 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -261,9 +261,6 @@ static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
 	struct amdgpu_device *adev = ctx->adev;
 	enum amd_dpm_forced_level current_level;
 
-	if (!ctx)
-		return -EINVAL;
-
 	current_level = amdgpu_dpm_get_performance_level(adev);
 
 	switch (current_level) {
@@ -293,9 +290,6 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 	enum amd_dpm_forced_level level;
 	int r;
 
-	if (!ctx)
-		return -EINVAL;
-
 	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
 	if (adev->pm.stable_pstate_ctx && adev->pm.stable_pstate_ctx != ctx) {
 		r = -EBUSY;
-- 
2.25.1

