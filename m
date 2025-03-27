Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20848C36011
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFD210E955;
	Thu, 27 Mar 2025 20:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BZ3+wSHt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A7D10E945
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BAB7614C6;
 Thu, 27 Mar 2025 20:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CB8C4CEDD;
 Thu, 27 Mar 2025 20:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107955;
 bh=TUICzPCtKb+WBSn1CTdV+POwCsezWMBY7PATHhQUVWM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BZ3+wSHt85fHFcJVIteV8qQGDlnNrPuf0gRYZzIU2xNrIoBVR/uj1CXlE+C/x6tn7
 NWEWgHCc+sDSRC+mwIGgB3qG1bixmwfwcqUdONQE/lX6fGyFedDz8bvdUf5xY1jznw
 y7necPFD6YtB+lao3qaIIN+QvMsq52p3svNH02HN62HFUJnTNWz/rzGxUI/b/wqPuR
 jd4b0B1MoX4+TYEmJKxBNf6FZ+FacadGRZZ9sYBWwOlqjoPj30x17E5jUNWwCqG5Pb
 TdgVGJUYJ0MZuMPKmuu6UEssA9SMPzDE9ltvWqYcVkDHQ2e6Sm4qXLLqCILdYu4FAu
 fmuEpCnJgdWNA==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 12/14] drm/amd: Add struct amdgpu_device argument to
 amdgpu_reset_create_reset_domain()
Date: Thu, 27 Mar 2025 15:38:56 -0500
Message-ID: <20250327203858.3796086-13-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327203858.3796086-1-superm1@kernel.org>
References: <20250327203858.3796086-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

In order to be able to log messages specific to a GPU, add device
argument into the amdgpu_reset_create_reset_domain() function.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 68d00e8cdaaf3..04abbc46ef602 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4391,7 +4391,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 * (if any) and initialized to use reset sem and in_gpu reset flag
 	 * early on during init and before calling to RREG32.
 	 */
-	adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
+	adev->reset_domain = amdgpu_reset_create_reset_domain(adev, SINGLE_DEVICE,
+							     "amdgpu-reset-dev");
 	if (!adev->reset_domain)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce6..dd98fc292afc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -271,7 +271,8 @@ void amdgpu_reset_destroy_reset_domain(struct kref *ref)
 	kvfree(reset_domain);
 }
 
-struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_domain_type type,
+struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(struct amdgpu_device *adev,
+							     enum amdgpu_reset_domain_type type,
 							     char *wq_name)
 {
 	struct amdgpu_reset_domain *reset_domain;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139be..36cc1ff3fb386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -114,7 +114,8 @@ int amdgpu_reset_prepare_env(struct amdgpu_device *adev,
 int amdgpu_reset_restore_env(struct amdgpu_device *adev,
 			     struct amdgpu_reset_context *reset_context);
 
-struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_domain_type type,
+struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(struct amdgpu_device *adev,
+							     enum amdgpu_reset_domain_type type,
 							     char *wq_name);
 
 void amdgpu_reset_destroy_reset_domain(struct kref *ref);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 477424472bbee..ee23bc96ec1ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -687,7 +687,8 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 	 */
 		if (adev->reset_domain->type != XGMI_HIVE) {
 			hive->reset_domain =
-				amdgpu_reset_create_reset_domain(XGMI_HIVE, "amdgpu-reset-hive");
+				amdgpu_reset_create_reset_domain(adev, XGMI_HIVE,
+								"amdgpu-reset-hive");
 			if (!hive->reset_domain) {
 				dev_err(adev->dev, "XGMI: failed initializing reset domain for xgmi hive\n");
 				ret = -ENOMEM;
-- 
2.43.0

