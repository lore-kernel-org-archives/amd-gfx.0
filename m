Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BBAE9DE6A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 08:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE05F10E771;
	Thu,  9 Apr 2026 08:34:12 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6AC810E76C
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 08:34:10 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 6398Y0B51326137; Thu, 9 Apr 2026 14:04:00 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 6398Y0Xs1326130;
 Thu, 9 Apr 2026 14:04:00 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 0/4] Never take root bo reservation locks with
Date: Thu,  9 Apr 2026 14:03:51 +0530
Message-Id: <20260409083355.1326089-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

v: Fixes the locks issue in all the places where userq_mutex is taken
and then vm->root.bo reservation lock is next.

Sunil Khatri (4):
  drm/amdgpu/userq: dont look root bo with userq_mutex held
  drm/amdgpu/userq: create_mqd does not need userq_mutex
  drm/amdgpu/userq: caller to take reserv lock for
    amdgpu_userq_buffer_vas_list_cleanup
  drm/amdgpu/userq: hold reservation lock in caller of
    amdgpu_userq_input_va_validate

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 77 +++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 23 +++++++
 2 files changed, 69 insertions(+), 31 deletions(-)

-- 
2.34.1

