Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B824DEE49A5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 07:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B11210E202;
	Mon, 21 Aug 2023 07:46:06 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr
 [80.12.242.19])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9588610E132
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Aug 2023 09:59:10 +0000 (UTC)
Received: from pop-os.home ([86.243.2.178]) by smtp.orange.fr with ESMTPA
 id Xf5hqwKJwP8tnXf5uq04hi; Sun, 20 Aug 2023 11:51:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1692525099;
 bh=Rze1GZkpKnzRfLucS78BXnfSJ2SRLYcMjVrfmplMy4I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oRrRBwegpGnnVWLfiSW72uzV5MN9TE5X6I0HTMYnjLLNdSXilqvI84otb+CfcJtVh
 lOQxsCeVsBh2wnH0aGeBDWAKsoljl/a/YGvVkfCuqOrcJ0fzz5NpIhCUBqMwr8oZtD
 leQT3K6AFPXjL9h3KsyXzHZe1PFtxEPOIMxjdOS1kO3ozXJks6yuPDLv4RU+cPqJNy
 pSp5SKgfNMrjRvqbdEQMRuTjjKGASXNJVNM6n9dJ9fBomvNIzkNOoeB1tKNHjcXz7H
 cdBzNeSz+uwBkjZOZcGq9JATf75xjZIkQkrdIlkX5C+OgYVb2FPRkvZMaB4l18UdNf
 8u52WOATkrQsw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Aug 2023 11:51:39 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Felix.Kuehling@amd.com,
 Arunpravin.PaneerSelvam@amd.com
Subject: [PATCH 1/4] drm/amdgpu: Explicitly add a flexible array at the end of
 'struct amdgpu_bo_list'
Date: Sun, 20 Aug 2023 11:51:13 +0200
Message-Id: <247e082be64febc32a3404a9ea42acca91156ed0.1692524665.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692524665.git.christophe.jaillet@wanadoo.fr>
References: <cover.1692524665.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Aug 2023 07:46:03 +0000
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
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

'struct amdgpu_bo_list' is really used as if it was ended by a flex array.
So make it more explicit and add a 'struct amdgpu_bo_list_entry entries[]'
field at the end of the structure.

This way, struct_size() can be used when it is allocated.
It is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 5 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h | 2 ++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index b6298e901cbd..571fed04eb7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -75,7 +75,6 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 	struct amdgpu_bo_list_entry *array;
 	struct amdgpu_bo_list *list;
 	uint64_t total_size = 0;
-	size_t size;
 	unsigned i;
 	int r;
 
@@ -83,9 +82,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 				/ sizeof(struct amdgpu_bo_list_entry))
 		return -EINVAL;
 
-	size = sizeof(struct amdgpu_bo_list);
-	size += num_entries * sizeof(struct amdgpu_bo_list_entry);
-	list = kvmalloc(size, GFP_KERNEL);
+	list = kvmalloc(struct_size(list, entries, num_entries), GFP_KERNEL);
 	if (!list)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
index 26c01cb131f2..368e50b30160 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
@@ -55,6 +55,8 @@ struct amdgpu_bo_list {
 	/* Protect access during command submission.
 	 */
 	struct mutex bo_list_mutex;
+
+	struct amdgpu_bo_list_entry entries[];
 };
 
 int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
-- 
2.34.1

