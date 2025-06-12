Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FF9C71136
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 10:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE45010E77E;
	Thu, 12 Jun 2025 10:44:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="btQVGRjJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D07610E7CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 10:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=a1N+4ZuP5WofpnAChW4IN4BUt8W0vwfALDo3tNkCvyA=; b=btQVGRjJM5WDkcvZsWlh8E3KUC
 Aw7EPpInuYBkzbYx4uRtw5nbboPvm0VsRhdEe5gWy8gXnyFtPs0GF5yLgKExtbRvLJwUxluwcadh1
 CoS852RaGT231KmdLGq3lEoxUdjILIUozGxHm9BYXoFmm1grQc81+FyAuhO4JZ25rRrBbqigRx5rp
 tVUPsXKZfjzBfPxHz3k5CyLNwSmmgLDZfk8jpnMcGyeOpxRGh7Txy77y/RYNfauRclazI7ih5bKtu
 N9c3LWYP6vhY3BBi/92XjI1AHs7Y6aUJ23jibocNnZ1UavSxTaqUreLMfdeI5npQOJhDETd1kseNe
 PjyvGyRw==;
Received: from [81.79.92.254] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uPfQB-002akw-AR; Thu, 12 Jun 2025 12:44:35 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 0/4] Use memdup_user & co where applicable
Date: Thu, 12 Jun 2025 11:44:25 +0100
Message-ID: <20250612104430.41169-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
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

Replace some allocate + copy_from_user patterns with dedicated helpers.

This shrinks the source code and is also good for security due SLAB bucket
separation between the kernel and uapi.

Tvrtko Ursulin (4):
  drm/amdgpu: Use vmemdup_array_user in
    amdgpu_bo_create_list_entry_array
  drm/amdgpu: Use memdup_array_user in amdgpu_cs_wait_fences_ioctl
  drm/amdgpu: Use (v)memdup_array_user in amdgpu_cs_pass1
  drm/amdgpu: Use memdup_user in ta_if_load_debugfs_write

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 41 +++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 52 ++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c  | 14 ++----
 3 files changed, 37 insertions(+), 70 deletions(-)

-- 
2.48.0

