Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0E4D1A62F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 13:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F80510E8C8;
	Fri,  9 Jan 2026 13:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZogEYfhD";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F1610E0A9
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 13:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xSpK34jZQU+63ieu93Oyf7yW7p16r6QPRDtxZVYgx8Q=; b=ZogEYfhDBcHXqnjFZQ0tSs6zxD
 gQqkOxkTSQDTsTf5n8YbDUINCazsPtdigd7x/6vfqZDG7CvcATPLAmFx3ZDivrDPbVUQ1LVAmypiz
 jXhqzh9yzjwZzkdqzHhnI1kmYC52bQqhO1oMHzS1yFNSRjDmlIDELY8lh6knIL1KhtzQjZREQZ7Ck
 sO/IjHER/4cu85t4ymoSdgkYmXFOBlq30HSeDthXrtxz/YcbAlJaEZ8UBFkVB6uxoRJw819Vml1j4
 nNAgsYX+WXlj2w+Umc/yAEUGAvN+SztW0XFfuVkWFMoqGUcEy7iTacwa3XmVfx1NirpnBGaVaMrDC
 Q5lR3kvA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1veCcF-003QbD-EZ; Fri, 09 Jan 2026 14:33:23 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 03/12] drm/amdgpu: Drop support for variable struct
 drm_amdgpu_bo_list_entry size
Date: Fri,  9 Jan 2026 13:33:05 +0000
Message-ID: <20260109133314.88548-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109133314.88548-1-tvrtko.ursulin@igalia.com>
References: <20260109133314.88548-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Userspace always uses struct drm_amdgpu_bo_list_in->bo_info_size equal to
sizeof(struct drm_amdgpu_bo_list_entry) and there are no plans to extend
it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 31 +++++----------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 87ec46c56a6e..d340a6438aaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -182,33 +182,16 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
 int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 				      struct drm_amdgpu_bo_list_entry **info_param)
 {
-	const uint32_t info_size = sizeof(struct drm_amdgpu_bo_list_entry);
-	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
-	const uint32_t bo_info_size = in->bo_info_size;
-	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
 
-	/* copy the handle array from userspace to a kernel buffer */
-	if (likely(info_size == bo_info_size)) {
-		info = vmemdup_array_user(uptr, bo_number, info_size);
-		if (IS_ERR(info))
-			return PTR_ERR(info);
-	} else {
-		const uint32_t bytes = min(bo_info_size, info_size);
-		unsigned i;
+	if (in->bo_info_size != sizeof(struct drm_amdgpu_bo_list_entry))
+		return -EINVAL;
 
-		info = kvmalloc_array(bo_number, info_size, GFP_KERNEL);
-		if (!info)
-			return -ENOMEM;
-
-		memset(info, 0, bo_number * info_size);
-		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
-			if (copy_from_user(&info[i], uptr, bytes)) {
-				kvfree(info);
-				return -EFAULT;
-			}
-		}
-	}
+	info = vmemdup_array_user(u64_to_user_ptr(in->bo_info_ptr),
+				  in->bo_number,
+				  sizeof(struct drm_amdgpu_bo_list_entry));
+	if (IS_ERR(info))
+		return PTR_ERR(info);
 
 	*info_param = info;
 	return 0;
-- 
2.52.0

