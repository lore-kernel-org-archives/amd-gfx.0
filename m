Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0FEC021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AE7710E2CF;
	Mon, 24 Feb 2025 13:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ne9xRv+x";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FDCE10E361
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3871wUm5DJtmzh7m9mxU2704QGE+wlsar9aFvUxKkhw=; b=Ne9xRv+x2eqtciklghK+majVf1
 36BdjbN0Zw5A/Bmym587nV5QoeunL9uXApHQF/HyBpB4xfv5Neh3FSJE8SDYIfDF4Q18KlDNiSZ52
 Hx18KeB5NGFi0BT71l4m2dwttwvlvz9c6EX/na3mogxURYRcMGtVnAOAqiJ/YPXqVBVbOOUfWsK2y
 TJTXl79w41yK50X8NkrudEBi70iKMFyZhR2xSKGJgTBd4rKk+9BHVBu50I7Qe4d5VYGuX0Gz0N7HR
 O4+nXqqtUxxoYISplRjVZoQpOppYiCpcMfr7pZf5VXGFl94iTQKxQhwpldAtRiofA2Nht3IWI+GFD
 u3ME3FYQ==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tmXEf-00HTAd-Hf; Mon, 24 Feb 2025 13:07:03 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 0/2] Fit one IB struct amdgpu_job into a 512 byte slab
Date: Mon, 24 Feb 2025 12:06:42 +0000
Message-ID: <20250224120644.40148-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Feb 2025 13:35:11 +0000
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

A lot of the workloads create jobs with just one IB and if we re-order some
struct members we can stop that allocation spilling into the 1k SLAB bucket.

Before:

  sizeof(struct amdgpu_job) + sizeof(struct amdgpu_ib) = 480 + 40 = 520

After:

  sizeof(struct amdgpu_job) + sizeof(struct amdgpu_ib) = 472 + 32 = 504

It is not a huge gain in the big picture but every little helps.

Tvrtko Ursulin (2):
  drm/amdgpu: Remove hole from struct amdgpu_ib
  drm/amdgpu: Reduce holes in struct amdgpu_job

 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  | 19 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++--
 2 files changed, 10 insertions(+), 13 deletions(-)

-- 
2.48.0

