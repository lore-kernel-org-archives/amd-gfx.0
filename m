Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645B2C369A5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 16:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E6410E28C;
	Tue,  8 Apr 2025 16:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=swemel.ru header.i=@swemel.ru header.b="moaCAWWZ";
	dkim-atps=neutral
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF5210E1FA;
 Tue,  8 Apr 2025 09:17:58 +0000 (UTC)
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1744103875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1FLiFT+T5gQcR7Vpti1w2BgNdDvjvH7axHcj6poLqfw=;
 b=moaCAWWZ18pXziwG8oX+TkII9D5Ads52zgtbWvMZzDuX39fTOmjHt1GkoXlh4B6BG9OqwM
 p6o3vkxR0o29TanFoIgXefyWW+280xeadbOdDlOFzLYuuzGecmd7yDtWHwwrUs8YxEpDMM
 YaBH8aWZ71hdODC+SzmYFAlLdpdYvTU=
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Chunming Zhou <david1.zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: check a user-provided number of BOs in list
Date: Tue,  8 Apr 2025 12:17:53 +0300
Message-ID: <20250408091755.10074-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Apr 2025 16:33:46 +0000
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

The user can set any value to the variable ‘bo_number’, via the ioctl
command DRM_IOCTL_AMDGPU_BO_LIST. This will affect the arithmetic
expression ‘in->bo_number * in->bo_info_size’, which is prone to
overflow. Add a valid value check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 964d0fbf6301 ("drm/amdgpu: Allow to create BO lists in CS ioctl v3")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 702f6610d024..dd30d2426ff7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -189,6 +189,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	struct drm_amdgpu_bo_list_entry *info;
 	int r;
 
+	if (!in->bo_number || in->bo_number > UINT_MAX / info_size)
+		return -EINVAL;
+
 	info = kvmalloc_array(in->bo_number, info_size, GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.43.0

