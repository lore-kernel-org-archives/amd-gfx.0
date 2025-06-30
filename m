Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D13EC7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 07:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D883610E50E;
	Tue,  1 Jul 2025 07:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.b="g5vZVkP3";
	dkim-atps=neutral
X-Greylist: delayed 362 seconds by postgrey-1.36 at gabe;
 Mon, 30 Jun 2025 20:33:20 UTC
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36DD510E4C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 20:33:20 +0000 (UTC)
Received: from fedora.intra.ispras.ru (unknown [10.10.165.24])
 by mail.ispras.ru (Postfix) with ESMTPSA id 149D94076195;
 Mon, 30 Jun 2025 20:27:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 149D94076195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1751315236;
 bh=8/w97TsGErtMuAVzt/xfSxnTo0YaKKnyUWealjkgpms=;
 h=From:To:Cc:Subject:Date:From;
 b=g5vZVkP3QGXxVFY9GsScNZBUBHNhUn8gXek47RRjj/ajOg8KTNiUe7GyGrp5jChEt
 xw20gE7DebnPMYbCXzl2iscruypEzs+ACKz9hRoGb0dyYuK4VKWZJ/oG0ixJbBWtc5
 G3ggtRACy1o/q1jqDKWWvRklhlMzFs1HEVrgUsBY=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rex Zhu <Rex.Zhu@amd.com>, Jammy Zhou <Jammy.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] drm/amd/pm/powerplay/hwmgr/smu_helper: fix order of mask and
 value
Date: Mon, 30 Jun 2025 23:26:17 +0300
Message-ID: <20250630202618.1537569-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Jul 2025 07:16:54 +0000
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

There is a small typo in phm_wait_on_indirect_register().

Swap mask and value arguments provided to phm_wait_on_register() so that
they satisfy the function signature and actual usage scheme.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: 3bace3591493 ("drm/amd/powerplay: add hardware manager sub-component")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index 79a566f3564a..c305ea4ec17d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -149,7 +149,7 @@ int phm_wait_on_indirect_register(struct pp_hwmgr *hwmgr,
 	}
 
 	cgs_write_register(hwmgr->device, indirect_port, index);
-	return phm_wait_on_register(hwmgr, indirect_port + 1, mask, value);
+	return phm_wait_on_register(hwmgr, indirect_port + 1, value, mask);
 }
 
 int phm_wait_for_register_unequal(struct pp_hwmgr *hwmgr,
-- 
2.50.0

