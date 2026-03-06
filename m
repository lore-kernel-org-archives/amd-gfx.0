Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E13F01807
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 08:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC3F10E3AB;
	Fri,  6 Mar 2026 08:06:47 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ABBA10E3AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 08:06:46 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62686gwb1810346; Fri, 6 Mar 2026 13:36:42 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62686gmn1810345;
 Fri, 6 Mar 2026 13:36:42 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>,
 Philip Yang <philip.yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v1 1/2] drm/amdkd: fix the warning for potential insecure
 string
Date: Fri,  6 Mar 2026 13:36:35 +0530
Message-Id: <20260306080636.1810291-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

Below is the warning thrown by the clang compiler:
linux/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:588:9: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
                                           stats_dir_filename);
                                           ^~~~~~~~~~~~~~~~~~
linux/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:588:9: note: treat the string as an argument to avoid this
                                           stats_dir_filename);
                                           ^
                                           "%s",
linux/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:635:18: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
                                           p->kobj, counters_dir_filename);
                                                    ^~~~~~~~~~~~~~~~~~~~~
linux/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:635:18: note: treat the string as an argument to avoid this
                                           p->kobj, counters_dir_filename);
                                                    ^
                                                    "%s",

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
CC: Philip Yang <philip.yang@amd.com>
CC: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0b3b0c26e05c..d202827df66e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -585,7 +585,7 @@ static void kfd_procfs_add_sysfs_stats(struct kfd_process *p)
 		ret = kobject_init_and_add(pdd->kobj_stats,
 					   &procfs_stats_type,
 					   p->kobj,
-					   stats_dir_filename);
+					   "%s", stats_dir_filename);
 
 		if (ret) {
 			pr_warn("Creating KFD proc/stats_%s folder failed",
@@ -632,7 +632,7 @@ static void kfd_procfs_add_sysfs_counters(struct kfd_process *p)
 			return;
 
 		ret = kobject_init_and_add(kobj_counters, &sysfs_counters_type,
-					   p->kobj, counters_dir_filename);
+					   p->kobj, "%s", counters_dir_filename);
 		if (ret) {
 			pr_warn("Creating KFD proc/%s folder failed",
 				counters_dir_filename);
-- 
2.34.1

