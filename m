Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AA8CD4F24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8426F10EEEF;
	Wed, 13 May 2026 14:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="IGcKhfk8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BF310EEEF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZmRor0xiwkOgufXUFDHRfWZgnuGRnPYOogVuZ+KbT+g=; b=IGcKhfk8PeIAMLEHQaUpMy5jBN
 LpnkLlUqLphavwDfRXlFt6Ba8PzySJPWdbu41tgKh8E/o1oY4bxp/W8HU/Hg9RpSuRGYIlrp+5/rc
 3L/fmlvJNnaDRfI0ISTXyU0WdFD3dr2eRmK1b7qvSM8GXCEuv/N5YLfU2tf6Dnm0IXsvB9go87/Q1
 EbiUpbrc2Kwv1hi3idF+VHfldF53WsGnMbgaSiDm+TAPFgOzIIIU5iQdmBGkHjKfkCSAuMYDkx6Qr
 Ula9Bsfb/2DedG2QOHGXR7lBSJuj6IgpwttP0F+2tdOQmEdNFMqTLcj0/qlgTRwwIJvCnlunvbH2m
 P6XdVzWA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wNAx0-00A0lx-P3; Wed, 13 May 2026 16:52:42 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: Remove obsolete check from userptr creation
Date: Wed, 13 May 2026 15:52:17 +0100
Message-ID: <20260513145217.8924-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
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

Ever since commit
b39df63b16b6 ("drm/amdgpu: always register an MMU notifier for userptr")
it is no longer needed to reject not asking for a MMU notifier with
read-write objects since notifiers are always installed.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 5376035d32fe..0259d81e5157 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -514,13 +514,6 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	    AMDGPU_GEM_USERPTR_REGISTER))
 		return -EINVAL;
 
-	if (!(args->flags & AMDGPU_GEM_USERPTR_READONLY) &&
-	     !(args->flags & AMDGPU_GEM_USERPTR_REGISTER)) {
-
-		/* if we want to write to it we must install a MMU notifier */
-		return -EACCES;
-	}
-
 	/* create a gem object to contain this object in */
 	r = amdgpu_gem_object_create(adev, args->size, 0, AMDGPU_GEM_DOMAIN_CPU,
 				     0, ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1);
-- 
2.54.0

