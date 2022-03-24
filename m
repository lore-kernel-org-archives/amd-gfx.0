Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06333C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 13:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9069E10E8E6;
	Thu, 24 Mar 2022 13:46:01 +0000 (UTC)
X-Greylist: delayed 913 seconds by postgrey-1.36 at gabe;
 Thu, 24 Mar 2022 08:41:50 UTC
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
 by gabe.freedesktop.org (Postfix) with ESMTP id D98AB10E1C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 08:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=SYdtMX0fUBJBGCRkZr
 x91FiJtXR+g6Dfi9TegzBMeTM=; b=qdSVARpouAfRPbGS+iy46sNTs3+sdaXlS8
 FC1UgeHYkfoW6IvAoxmthn9A6gAw44Y/MsSgjgi6wH7kCt59QxrAxbSSlDhbEfa8
 C5HaMRAu0SWQaHwu8lQ7F0FkiDChh6myl+Z5NiE5BVZ+qZWbivKFeqMZ/ljIF7lB
 lgVo2TGsA=
Received: from localhost (unknown [159.226.95.33])
 by smtp8 (Coremail) with SMTP id DMCowAD3_zc3KzxicLj8Bg--.28399S2;
 Thu, 24 Mar 2022 16:26:32 +0800 (CST)
From: QintaoShen <unSimple1993@163.com>
To: Felix.Kuehling@amd.com
Subject: [PATCH v1] drm/amdkfd: Check for potential null return of
 kmalloc_array()
Date: Thu, 24 Mar 2022 16:26:23 +0800
Message-Id: <1648110383-3533-1-git-send-email-unSimple1993@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMCowAD3_zc3KzxicLj8Bg--.28399S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4kWF17uF47Ar1kArWDurg_yoWftrg_Gr
 15Xr9xAr4DCFn5Wry2vw4aqry0yr4rZ3WkXF18t3WfJryfZFyUC348XrWkZ3yfGa4DuFyD
 tw4DKF4fuFsF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_GYL3UUUUU==
X-Originating-IP: [159.226.95.33]
X-CM-SenderInfo: 5xqvxz5sohimizt6il2tof0z/xtbCbgjNH2BbCZsoFAAAsh
X-Mailman-Approved-At: Thu, 24 Mar 2022 13:46:01 +0000
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
Cc: QintaoShen <unSimple1993@163.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the kmalloc_array() may return null, the 'event_waiters[i].wait' would lead to null-pointer dereference.
Therefore, it is better to check the return value of kmalloc_array() to avoid this confusion.

Signed-off-by: QintaoShen <unSimple1993@163.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index deeccce..64f4a51 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -749,6 +749,8 @@ static struct kfd_event_waiter *alloc_event_waiters(uint32_t num_events)
 	event_waiters = kmalloc_array(num_events,
 					sizeof(struct kfd_event_waiter),
 					GFP_KERNEL);
+	if (!event_waiters)
+		return NULL;
 
 	for (i = 0; (event_waiters) && (i < num_events) ; i++) {
 		init_wait(&event_waiters[i].wait);
-- 
2.7.4

