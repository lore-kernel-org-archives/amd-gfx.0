Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F79C4707C
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 08:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F18E410E18D;
	Mon,  8 Jan 2024 08:41:11 +0000 (UTC)
X-Greylist: delayed 699 seconds by postgrey-1.36 at gabe;
 Sun, 07 Jan 2024 13:19:11 UTC
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3DC810E013;
 Sun,  7 Jan 2024 13:19:11 +0000 (UTC)
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
 t=1704632830; bh=QAb1xU4JKbRPoLcalM9q1eA+hq8zVqofoDj3r0FUJ00=;
 h=From:To:Cc:Subject:Date:From;
 b=PLXjChloIKCd+RB8Wotl/908+CQI8DEeB3BihElbplNWQOyZuAvfqDbsbnHrr5uDv
 Z0aK2hDBLMfol7RSe+kH+lU6Z5UBx8dj443eSeVJtCTQjUL3QVUfuiT0n+XmJhTimP
 OOk3KWSAFgnLuxiWHAfBJR83EeloyEPgnX+p/v7sC1WydrXshBooqmUnhdDc5KU+qe
 AG3CDaeRUxvzDAkjb7HWYIjhBIld1mSENiBZVZW+JZ6RMeobxS1yCmLOKIrmrVB+FV
 hWc9gVvzgOeC5A7R00O+4POzQTU3fGdbNqg7iJL9w2xEuSFQY9QCNqv0sVj3Zv7azO
 BBMNVVvL43DZQ==
Received: from dhirschfeld-vm-u22.habana-labs.com (localhost [127.0.0.1])
 by dhirschfeld-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with
 ESMTPS id 407D74Tv1165051
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 7 Jan 2024 15:07:04 +0200
Received: (from dhirschfeld@localhost)
 by dhirschfeld-vm-u22.habana-labs.com (8.15.2/8.15.2/Submit) id
 407D748a1165050; Sun, 7 Jan 2024 15:07:04 +0200
From: Dafna Hirschfeld <dhirschfeld@habana.ai>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/amdkfd: fixes for HMM mem allocation
Date: Sun,  7 Jan 2024 15:07:00 +0200
Message-Id: <20240107130700.1165029-1-dhirschfeld@habana.ai>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Jan 2024 08:41:10 +0000
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
Cc: ogabbay@kernel.org, Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Dafna Hirschfeld <dhirschfeld@habana.ai>,
 alexander.deucher@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 obitton@habana.ai
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix err return value and reset pgmap->type after checking it.

Fixes: c83dee9b6394 ("drm/amdkfd: add SPM support for SVM")
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
---
v2: remove unrelated DOC fix and add 'Fixes' tag.

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6c25dab051d5..b8680e0753ca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1021,7 +1021,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 	} else {
 		res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
 		if (IS_ERR(res))
-			return -ENOMEM;
+			return PTR_ERR(res);
 		pgmap->range.start = res->start;
 		pgmap->range.end = res->end;
 		pgmap->type = MEMORY_DEVICE_PRIVATE;
@@ -1037,10 +1037,10 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 	r = devm_memremap_pages(adev->dev, pgmap);
 	if (IS_ERR(r)) {
 		pr_err("failed to register HMM device memory\n");
-		/* Disable SVM support capability */
-		pgmap->type = 0;
 		if (pgmap->type == MEMORY_DEVICE_PRIVATE)
 			devm_release_mem_region(adev->dev, res->start, resource_size(res));
+		/* Disable SVM support capability */
+		pgmap->type = 0;
 		return PTR_ERR(r);
 	}
 
-- 
2.34.1

