Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D73C624C6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 07:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA56C10E625;
	Mon, 31 Aug 2026 07:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KWpDJZpV";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE0E10E03F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 21:24:09 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49b8eeb3ff2so10179085e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787952248; x=1788557048; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tDbfWy3mJvr3iFz1oWIhMN0E9yCNJZGzu22x+0wJipk=;
 b=KWpDJZpVmD6nah/3um6vIWrjpC0rqMOyiBlD0jmskX/2hy5mBm7LoM3BlJ4n1EZpUN
 qh1YEdUsCXVofPFtcbsHGwqyx3reDjIIV/1Q1BDrN6biKCig3tOG91t6NxABRWJGTsBl
 fQ4YtOkj4+Rmkmn56MH1fEjahrbFHj3L0rhRW6iPI6usEVuYTMegfsWn7xUpctB72nvG
 n62IywfjxK9e79a6N01YXiDXkMvpPZS1BVXuYRhcTzu7V+tSwLcoFPHompArYfyFnXwh
 JmWr7X2Lhgh8hkXT5wQaNxEODonQyhq+LrkALo82PMK3zDTMrTK4XDrNEQ2m5nSyp6ip
 RkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787952248; x=1788557048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tDbfWy3mJvr3iFz1oWIhMN0E9yCNJZGzu22x+0wJipk=;
 b=GqFMzm1MlRs+gIQAqkIlvyWTZp7K544miTtjVRxXUzmWtVrSWSSVtmAD6s1BF8LKMm
 JvIHXPZtcKUyxnYnpkVlNnUF/PNogZpXtCk0ywGjz5aADKxmJ568mJC9/A5Zf2CI7lwO
 vWi+wR+unjPl1KsfeVAjz1xtoMZnCX/ULEfL6MJVeU0qf36zAb/AjqBngMOBStIbUf0V
 Zd/fWgtTwlv7Djdu8XtZPlMPPyV4nCer8BFT2WaB9miWPo/5ZkUXYqPvG0bKT2qQxmaH
 8WcDn0GmXk/KrQFPgqQinmYQ3f0Sli8tO5n5DlNbgGV4u2g9sXRSjt9CXIPnfzgHc3G1
 upBg==
X-Forwarded-Encrypted: i=1;
 AHgh+RroeBjoCDLGC2fc9bxgSIMO4L3PG1xAhQBSsE3ke+ZMGP/V2ZDR1Hr5Qj3QhtKG/wfx39Yv6Lra@lists.freedesktop.org
X-Gm-Message-State: AFuF++n6M6eNGI6pIgNFDMne/HWxGsQ24LVvZUmrzwjy5Wp8p5y8OUTt
 LQ7RXr3eR+tehub23UPf7emjHHMsiBVUpGzgfYmFy8XFFLrjpT/qtEH4
X-Gm-Gg: AR+sD13yVbaSUWkO4l5gcnXJwk4f6RMsfiFfNhNB8fZpBIzFwr+vCHT83yuhtR+ECNf
 sY/CsnwV/TvIL5GWnCs3m8R11CoV3IK6zQ8jK7/a0g4eavsfFCuLxwLug28pZDGYMaST0SjcvpY
 qFI+Y7D4ErmGYe/gezDrKXmv8TkFTE4YNTnlhIbduTPhBISYNUozXvIa4FBHCQiDknz4zgt9GII
 Mdpa6CZcR6a9wlmu+abacE6SYIGh94rpDwVlfFcQc3zusAIXPxb+s0c7ebtcgYBYWTkYor8AXP7
 kgUQizojePZO35otClMRENcSI2TqON+n4HfT5XQxNgMyprcOclTmrucgOe/rSh/VI+3JUK9pnjU
 /QbXUO9pj7Kh4NiOr9vXU89X4Rtw89WB60MmMv2V1Y6H+sSqUFVKKd63g5Kxbrd4uwIirHPFiqv
 ABsyMXmmMjkxV6DkA/SohgqWXR/khXyRNVa9a+/ny8Zx9JHJAGs+Ki1BXj+QvTQkHilA4W2HrvY
 oepG3YtHY/7HNTW3KMmdM4vOrboQCUy62Zv1zqQGLGdWXdxKmRuYXvH+wt1RQ==
X-Received: by 2002:a05:600c:314f:b0:499:4e47:eaf2 with SMTP id
 5b1f17b1804b1-49b91c38bcfmr136182665e9.6.1787952248132; 
 Fri, 28 Aug 2026 14:24:08 -0700 (PDT)
Received: from drago.hgw.local ([2a00:1d34:ebf3:5500:6828:ce36:77ad:ae8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91728319sm86367475e9.12.2026.08.28.14.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 14:24:07 -0700 (PDT)
From: Deniz Aydogan <denizaydogan1902@gmail.com>
To: lizhi.hou@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Deniz Aydogan <denizaydogan1902@gmail.com>
Subject: [PATCH] accel/amdxdna: fix double-free on mailbox channel stop
Date: Sat, 29 Aug 2026 00:24:05 +0300
Message-ID: <20260828212405.13124-1-denizaydogan1902@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:04:50 +0000
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

mailbox_release_msg() frees the message with kfree() but does not
remove it from the xarray. The stop function uses two loops to walk
pending entries in cyclic order, but since released entries remain in
the xarray, overlapping ranges cause the same entry to be freed twice.

In particular, when next_msgid is 0 (the initial value after kzalloc),
xa_for_each_start() covers all entries from index 0 onward, and
xa_for_each_range() with max=(u32)(0 - 1) = U32_MAX also covers all
entries. Every pending message gets double-freed.

Use xa_for_each() to iterate all remaining entries exactly once.
At this point the IRQ is already freed and the workqueue is drained,
so traversal order does not matter.

Fixes: 3ba13f5e7180 ("Merge tag 'devicetree-fixes-for-7.3-1'")
Signed-off-by: Deniz Aydogan <denizaydogan1902@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index cc8865f4e..271617347 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -556,9 +556,7 @@ void xdna_mailbox_stop_channel(struct mailbox_channel *mb_chann)
 	drain_workqueue(mb_chann->work_q);
 
 	/* We can clean up and release resources */
-	xa_for_each_start(&mb_chann->chan_xa, msg_id, mb_msg, mb_chann->next_msgid)
-		mailbox_release_msg(mb_chann, mb_msg);
-	xa_for_each_range(&mb_chann->chan_xa, msg_id, mb_msg, 0, mb_chann->next_msgid - 1)
+	xa_for_each(&mb_chann->chan_xa, msg_id, mb_msg)
 		mailbox_release_msg(mb_chann, mb_msg);
 	xa_destroy(&mb_chann->chan_xa);
 
-- 
2.55.0

