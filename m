Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD595C61DC6
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 15:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35FA410E99E;
	Thu, 27 Aug 2026 15:49:07 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7640510F07A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 15:49:05 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 67RFmtc91021105; Thu, 27 Aug 2026 21:18:55 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 67RFmtSq1021104;
 Thu, 27 Aug 2026 21:18:55 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 4/4] drm/amdgpu: fix Idle BOs list in VM debugfs status info
Date: Thu, 27 Aug 2026 21:18:49 +0530
Message-Id: <20260827154849.1021013-4-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827154849.1021013-1-sunil.khatri@amd.com>
References: <20260827154849.1021013-1-sunil.khatri@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_debugfs_vm_bo_status_info() prints the "Idle BOs" section by
iterating lists->needs_update, the same list already printed just
above under "Moved BOs". struct amdgpu_vm_bo_status has a dedicated
idle list, populated whenever a BO's state machine settles, but it
was never read here, so genuinely idle BOs never show up in the
debugfs output and the "Idle BOs" section duplicates "Moved BOs"
instead.

Iterate lists->idle for the "Idle BOs" section.

Fixes: 4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dbdcd57e5b6b..24113bf4d276 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3121,7 +3121,7 @@ static void amdgpu_debugfs_vm_bo_status_info(struct seq_file *m,
 
 	id = 0;
 	seq_puts(m, "\tIdle BOs:\n");
-	list_for_each_entry(base, &lists->needs_update, vm_status) {
+	list_for_each_entry(base, &lists->idle, vm_status) {
 		if (!base->bo)
 			continue;
 
-- 
2.34.1

