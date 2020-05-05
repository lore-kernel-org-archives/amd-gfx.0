Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4D5C47247
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 14:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB5D20735
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 14:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB5D20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 826A56E5CE;
	Tue,  5 May 2020 14:50:32 +0000 (UTC)
X-Greylist: delayed 836 seconds by postgrey-1.36 at gabe;
 Tue, 05 May 2020 14:16:13 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09DD89138;
 Tue,  5 May 2020 14:16:13 +0000 (UTC)
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MBV6n-1jQid641ol-00CwN4; Tue, 05 May 2020 16:16:08 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH] amdgpu: fix integer overflow on 32-bit architectures
Date: Tue,  5 May 2020 16:15:59 +0200
Message-Id: <20200505141606.837164-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:AkHFlSmgzp0jc+4llNiW+N+aB5OAyViD48sJ9HgEiVEF6fHsqQ/
 my7xScjJabhxQy51veqRxDGj468ZcU2Y1qyA/vAWUNneRt7mAboEJtEMSf0s2KYcuIhxneJ
 Vvf4HOqoO+vV98lY8TcGZhyq9Jzo8LXqSdQyDu6cAIZQuJO+ec6Z2IyWzTOXqFohOIDYfGl
 XToXSuqrzN3OY0YATcdag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4EQ5IcEC00E=:KlLlWj4vyVL6/3IxXdVlFy
 iRqdSEEX4aDUpKxY6hg6N1dWPK43VxA7TZYttNGVpXIpyxawAHjee1HRvrqb+HzATJWxvxsGD
 Q/Tjvr6CEfoY+1CP7lT1pbzw20DbbUMsJu2ebpvFm5R/ic3GWJKvgGe/p0ofkxkWpOM4OKDIH
 hxJmw+XvBJpM7ne3kn/a+L4dN50kueITd5SmkXEBt7OuVyQ+kKNkasA6WcLsXjk6/ZD/b1214
 I48BAXqy+VTn02bnk7G89hi3P5vo/ZuQFLZU93xeHm9fdvoU4vyLBpzzq0+nwoOTH7i0l/xvO
 FPlrWrrCGmvXr5aRpr9A9pI7fmHP6K2vhghcS1uTrg87fL9hKnLh8g7XysYxqlidjgbjiN83B
 62Dh3AEihexlbYZeA1dpOPvlsk0XlaZen6yD1HW0gTTIyEn/1r1n7eaanrG1fZViKWknI72/f
 qeGhH3uU4RKyP6TZa2qCIDVQ0SARl6hTHvC9P0HvdDA82zVjqRx3AzT10hesKq8x1czlRJeKY
 rSSzoadO5ogqzgCPAwBs7TFv4sS1K2Mc8AysvvqrZpb3QPU7DSX0FYp3NnM4OOcGD6H1ewxjg
 b/KYBsyphRkgKHn7bLGznymg1KPOk2hotz9lzDrV7vKFtEaJ4wDaEabkUagz8JYKeKcdBDL+K
 yU465Q5L24SuHzhfm/8Gjw0ZnrNXvMiNsbikd4MUZG78MHvHvTQEGD0ijwduMmz3Dkz4Mm6aQ
 vlELC3mDFgcUkOQd1ur5gleJJsf4wCHPumesooBI3ccz9dqyU22QpvOc5st9PjX60klfXyMh2
 xDDdQIRdBZ3gdeCaNzJCDgaP6leVG1gnnJlXnYpoke0b6J3R5Q=
X-Mailman-Approved-At: Tue, 05 May 2020 14:50:31 +0000
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
 Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 clang-built-linux@googlegroups.com, Kent Russell <kent.russell@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Multiplying 1000000000 by four overruns a 'long' variable, as clang
points out:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4160:53: error: overflow in expression; result is -294967296 with type 'long' [-Werror,-Winteger-overflow]
                expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4L;
                                                                  ^
Make this a 'long long' constant instead.

Fixes: 3f12acc8d6d4 ("drm/amdgpu: put the audio codec into suspend state before gpu reset V3")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm not sure the ktime_get_mono_fast_ns() call is necessary here
either. Is it intentional because ktime_get_ns() doesn't work
during a driver suspend, or just a mistake?
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6f93af972b0a..2e07e3e6b036 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4157,7 +4157,7 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
 		 * the audio controller default autosuspend delay setting.
 		 * 4S used here is guaranteed to cover that.
 		 */
-		expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4L;
+		expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4LL;
 
 	while (!pm_runtime_status_suspended(&(p->dev))) {
 		if (!pm_runtime_suspend(&(p->dev)))
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
