Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C39C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 10:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 009436E8E7;
	Mon, 22 Nov 2021 10:25:49 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr
 [80.12.242.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8199F6E05D
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Nov 2021 17:41:44 +0000 (UTC)
Received: from pop-os.home ([86.243.171.122]) by smtp.orange.fr with ESMTPA
 id oqqUmhaPXdmYboqqUmGBjl; Sun, 21 Nov 2021 18:41:43 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 21 Nov 2021 18:41:43 +0100
X-ME-IP: 86.243.171.122
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch
Subject: [PATCH 2/2] drm/amdkfd: Slighly optimize 'init_doorbell_bitmap()'
Date: Sun, 21 Nov 2021 18:41:40 +0100
Message-Id: <3e54737649cf94daabaa5b51db9f4c21d43124fe.1637516393.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2343a4e6547a8436419308744ba8c433088922a5.1637516393.git.christophe.jaillet@wanadoo.fr>
References: <2343a4e6547a8436419308744ba8c433088922a5.1637516393.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Nov 2021 10:25:48 +0000
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
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The 'doorbell_bitmap' bitmap has just been allocated. So we can use the
non-atomic '__set_bit()' function to save a few cycles as no concurrent
access can happen.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
bitmap_set() could certainly also be use, but range checking would be
tricky.
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 172ee8763523..2e9d341062c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1447,9 +1447,9 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
 
 	for (i = 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS / 2; i++) {
 		if (i >= range_start && i <= range_end) {
-			set_bit(i, qpd->doorbell_bitmap);
-			set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
-				qpd->doorbell_bitmap);
+			__set_bit(i, qpd->doorbell_bitmap);
+			__set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
+				  qpd->doorbell_bitmap);
 		}
 	}
 
-- 
2.30.2

