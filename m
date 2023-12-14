Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D1AC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 16:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA0310E0AD;
	Thu, 14 Dec 2023 16:39:25 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net
 (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
 by gabe.freedesktop.org (Postfix) with ESMTP id E90BD10E1AA;
 Thu, 14 Dec 2023 15:59:37 +0000 (UTC)
Received: from luzhipeng.223.5.5.5 (unknown [115.200.224.93])
 by mail-app2 (Coremail) with SMTP id by_KCgBnbU1ZJntlOkaTAA--.62179S2;
 Thu, 14 Dec 2023 23:59:22 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Subject: [PATCH] drm/amd/pm: fix a double-free in si_dpm_init
Date: Thu, 14 Dec 2023 23:24:11 +0800
Message-Id: <20231214152413.3483199-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgBnbU1ZJntlOkaTAA--.62179S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urykCF1UJr43Zr15tr1xuFg_yoW8XFWxpF
 Z3GF98K3yUJF48t3ZrXF10gr1Duw40kay8GrWjkw13A3W5ZF1v9rZ3A3yqqFW8uFZ7ur42
 g34qv34DZr4Ikw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
 xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
 MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
 0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
 JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5s
 jjDUUUU
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/
X-Mailman-Approved-At: Thu, 14 Dec 2023 16:39:23 +0000
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Zhenneng Li <lizhenneng@kylinos.cn>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the allocation of
adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries fails,
amdgpu_free_extended_power_table is called to free some fields of adev.
However, when the control flow returns to si_dpm_sw_init, it goes to
label dpm_failed and calls si_dpm_fini, which calls
amdgpu_free_extended_power_table again and free those fields again. Thus
a double-free is triggered.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index fc8e4ac6c8e7..df4f20293c16 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7379,10 +7379,9 @@ static int si_dpm_init(struct amdgpu_device *adev)
 		kcalloc(4,
 			sizeof(struct amdgpu_clock_voltage_dependency_entry),
 			GFP_KERNEL);
-	if (!adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries) {
-		amdgpu_free_extended_power_table(adev);
+	if (!adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries)
 		return -ENOMEM;
-	}
+
 	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.count = 4;
 	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].clk = 0;
 	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].v = 0;
-- 
2.34.1

