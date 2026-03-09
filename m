Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60105F3C241
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 12:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67BE010E4F0;
	Mon,  9 Mar 2026 12:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Yo4U1JQE";
	dkim-atps=neutral
X-Greylist: delayed 746 seconds by postgrey-1.36 at gabe;
 Mon, 09 Mar 2026 02:35:12 UTC
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5FE10E22A;
 Mon,  9 Mar 2026 02:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=YM
 d0+Wp/o+zkTTLjkBVKHAkw64/YlBP0XcUPa1Rlkb4=; b=Yo4U1JQEoeAWln00la
 9OwgDsyVQH3AH0G59asyOIfpWi5y/4Vnk+PiRjA3wgfeX5f2AefY5nYKcJ9CzMEk
 CH7/wD6vVhTsdnocXwfSeR0MpaTsk6p+APTlQeIKTKGRCyIQWNVcdr/CMbUOITn5
 qcHL0zUcBTYaNMnL/r1p7VBJE=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wDXV5TmLq5pRMZoPg--.11725S2; 
 Mon, 09 Mar 2026 10:22:31 +0800 (CST)
From: Chenyuan Mi <chenyuan_mi@163.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: Arunpravin.PaneerSelvam@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/amdgpu: fix use-after-free in userq signal/wait IOCTLs
Date: Mon,  9 Mar 2026 10:22:27 +0800
Message-ID: <20260309022229.63071-1-chenyuan_mi@163.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXV5TmLq5pRMZoPg--.11725S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF43Jry5Kr47GF45Ar1fJFb_yoW8GrWfpr
 1rJw12kF4UXrn7Za47Ja48WFWkWFWfWFWfGF1xW34ru3W5X3Z8Zry8KFyrZrySkrs2ya9F
 qr1kX3y8JF1q93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaZX5UUUUU=
X-Originating-IP: [124.70.231.40]
X-CM-SenderInfo: xfkh055xdqszrl6rljoofrz/xtbC9gfK3WmuLuco0QAA3R
X-Mailman-Approved-At: Mon, 09 Mar 2026 12:57:16 +0000
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

Both amdgpu_userq_wait_ioctl() and amdgpu_userq_signal_ioctl()
access user queue objects obtained from xa_load() without holding
userq_mutex. A concurrent AMDGPU_USERQ_OP_FREE can destroy and
kfree the queue in this window, leading to use-after-free.

The two bugs have different origins:

- Patch 1 fixes a wait-path regression introduced by commit
  4b27406380b0 ("drm/amdgpu: Add queue id support to the user queue
  wait IOCTL"), which removed the indirect fence_drv_xa_ptr model
  and its NULL-check safety net from commit ed5fdc1fc282
  ("drm/amdgpu: Fix the use-after-free issue in wait IOCTL").

- Patch 2 fixes a similar pre-existing lifetime bug in the signal
  path, present since commit a292fdecd728 ("drm/amdgpu: Implement
  userqueue signal/wait IOCTL").

Patch 1 adds explicit userq_mutex coverage around the xa_load and
subsequent fence_drv_xa operations in the wait path.

Patch 2 moves the ensure_ev_fence call (which acquires
userq_mutex) before xa_load in the signal path, so that the queue
lookup and all subsequent accesses are covered by the same lock.

Chenyuan Mi (2):
  drm/amdgpu: protect waitq access with userq_mutex in wait IOCTL
  drm/amdgpu: protect queue access in signal IOCTL

 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 25 +++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

--
2.53.0

