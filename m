Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F496D2F7F7
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 13:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E073410EB3A;
	Fri,  5 Dec 2025 13:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OWUZE5Bl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 625C610EB2D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sdsdXizVxqcXz0y0NCmmIYnsbUq1hsJqulZeHr0a6TM=; b=OWUZE5BlaiFdBmVOVBgUmcnQvE
 eW2xGpRhIK0tojgf8oYH5jav8e9BG2jxG4WYjvsoECpCB8JesqcKz/cxeupLme3yK39UyO04eA5mj
 k5GMEDLdDXtKTjtVEvYI/00A5O40GgZWSOw1ZqmbBZ0V6ms9l9tMf2RYaw5/kUg1U7e+xX71cxPqv
 o8wV3jAEYE0bXPW/Js3dTQmOQbxttubvOYEpJzlPhrRjZh5/Ct8xkHLeaNfmQ5th/miWcmx4KvcuT
 hEV47ns3EDr+uv+KXbOG1JZocQU1mv7fazitkxY6Rm4ANNy2eh3WARd31YRAT+LBjrRLbN12NXc2a
 fXoMaj1g==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vRW33-0095gM-DE; Fri, 05 Dec 2025 14:40:37 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 00/12] Some userq fixes/improvements
Date: Fri,  5 Dec 2025 13:40:23 +0000
Message-ID: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
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

Disclaimer - compile tested only.

Please see if there are interesting changes in here and let me know how to test
user queues. After that I will probably have some other ideas on what to improve
and/or fix in there. For starters I only looked at this single file while I was
trying to understand how it all works.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>

Tvrtko Ursulin (12):
  drm/amdgpu/userq: Fix reference leak in amdgpu_userq_wait_ioctl
  drm/amdgpu/userq: Do not allow userspace to trivially triger kernel
    warnings
  drm/amdgpu/userq: Consolidate wait ioctl exit path
  drm/amdgpu/userq: Use drm_gem_objects_lookup in
    amdgpu_userq_signal_ioctl
  drm/amdgpu/userq: Use drm_gem_objects_lookup in
    amdgpu_userq_wait_ioctl
  drm/amdgpu/userq: Use memdup_array_user in amdgpu_userq_wait_ioctl
  drm/amdgpu/userq: Use memdup_array_user in amdgpu_userq_signal_ioctl
  drm/amdgpu/userq: Consolidate fence lookup in amdgpu_userq_wait_ioctl
  drm/amdgpu/userq: No need to xa_erase before destroying the xarray
  drm/amdgpu/userq: Use more appropriate lock in
    amdgpu_userq_fence_driver_alloc
  drm/amdgpu/userq: Stop looking after finding ourselves
  drm/amdgpu/userq: Drop redundant conditional from the irq path

 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 597 +++++++-----------
 1 file changed, 245 insertions(+), 352 deletions(-)

-- 
2.51.1

