Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FF6C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 16:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8E510F90F;
	Fri, 26 Apr 2024 16:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SW16/WgP";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BB310F1BF
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3neJFAZCGTAJZ95LLv3rqfiL2ANykLcDRXu+bihMRlw=; b=SW16/WgPLomn5ju06XwZJ3hOxh
 L4YWESXUgiET6Sf4mev5YMK5MaClPBPPDMFgBmZqACx3VmZ1ZMs0HlhtJzESjHItpaH63NTauUvH+
 jN8qMiIOrB8DG4u4ktbJy7/fsWWKCMxINb83tzdxP49JjVhPEU02yMHVrhjUvJEqO0qjoLe9YUlBs
 mT0utw2q5cQwcHBseRNV6Gy6SjZGivQRqGZgttsm0WNp+ddFAo4ym6+LmD9xXPfiXxWhj55+A/DqJ
 46TbqAHNFArIgPUSeVxT7ewk3t/S9CDEHvJEfynBkQg5qMvusCj304iTIsfvFYmhIunvbiygXuoAl
 6tPeKKQw==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s0OgO-000CGg-3F; Fri, 26 Apr 2024 18:44:19 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 0/3] Some refactoring and maybe a memory accounting fixlet
Date: Fri, 26 Apr 2024 17:43:52 +0100
Message-ID: <20240426164355.1563-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

As I was reading through the driver I spotted one thing which could
perhaps make it more readable (1/3), one thing which reduces some double
conversions (in principle) from TTM placement back to domain (2/3), and
also enables the last patch in the series which maybe fixes a small
memory accounting issue. But only relevant when interacting with KFD
IIUC.

Assuming the fix is real and not my confusion, please let me know if it is
all acceptable, or you would like me to re-structure the series to only
contain the fix and break off the rest for later (or never).

Tvrtko Ursulin (3):
  drm/amdgpu: Add amdgpu_bo_is_vm_bo helper
  drm/amdgpu: Reduce mem_type to domain double indirection
  drm/amdgpu: Fix pinned GART area accounting and fdinfo reporting

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 31 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  | 14 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 31 +++++++++------------
 5 files changed, 44 insertions(+), 38 deletions(-)

-- 
2.44.0

