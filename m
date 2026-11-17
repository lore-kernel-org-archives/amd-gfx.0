Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53683606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YvGtvT8B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E93810EBDD;
	Wed, 18 Nov 2026 08:25:51 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4C110E5DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 14:54:14 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e99b1e5b4cso30089415ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 06:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794927254; x=1795532054; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nR9F0XM+B7rn1+ea8p9fct2rHHNP071jbR/ecoiRPcU=;
 b=YvGtvT8BhwQonfDWTv6lPSJz00sq4i6nHLDP/k45KYBPvtB+xHkX9MqTunjsn+ZDCU
 PUcJzRHIjIrVtfBTVPVnUm7tgWMiJxAL4B8lTclKg8JtyaJMsDdR4VSX6y0iovsqwMJ/
 WB9QGdKAUB2EJ/295nm2k2QBAQa9ruAXPLnVF7wbp28Fw4yChm1Al01R/zzt4DdSGWZG
 LI9I5dy5JdrAmsi4br/bD/XMWX8Pyw+liTa0RdfrZBGf6Fhn+6dQ1+yqesd+6YiJ4vXi
 OQn2VyWHxX+DdNM5dVcX4H/h4ttFIxkU93vApcGLBfM/g1X7X+8NhcbNZJcjgJRAoT0E
 HKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927254; x=1795532054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nR9F0XM+B7rn1+ea8p9fct2rHHNP071jbR/ecoiRPcU=;
 b=iYbINZ4H1rtt6JwVyTwNKhH0e9pkBXMJ0YE0x3q3xiwOVTr2zVpwWn1fgvrobyW7rU
 Ph/aWHhcP0Xsu8lQgSFu8lXt6LnKugyRjnFlUiRJtJ2z7rAZE6ngKzw/cPcmIUsyV6Fv
 s3zlmEj/iKOSAO6ggNsuBEl9q2+AxWwj9UE+C6TPts1P+tjPiVl4A6NNGUJ5sywIL2nG
 AsVthAbKHnbChDFAMBn+PpRVmWflqvGkU45XLjLsIcxNU7YXa+SCB4TJQbSfANoIaxeP
 ZNU5iusPowe8ck4I0pkNdemXjN50blGn3U0ZR14Ht9do08y1o1OSP1Q5f+CuO0TwIAMj
 T0mw==
X-Forwarded-Encrypted: i=1;
 AL+hErFkOLiAUfFbkjxKVhr+HS75NhG77rPxeQ/TkoKVNUEbWIXxnEpu0y+Tb/qFXxsQfaZxbMLYw5i6@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/97bM0Cu1emIk+Mi/NwR6bDpQnGq0DTJIyG1XDBJRfmzRWiTEY
 pI3mUJpQkf7Lsq6k2wrqzGBgDTQNPBwJagjTr3fXTZHXm3WtSLVQj22l
X-Gm-Gg: AZFdTZctOlnLGc7ouXnzKsKz8HwKuuP0N/ItEe4g3QcGupX+7b3uQQNKuHSECPO5/xH
 T4TMmaFItqhT0F7xFqKO+Ef1Lbi4FnCidrqA2ZnCjRjljz93n33vN56fEY/XJsUEIQivlotdPQs
 ZYwEurCbUO7dPmJroGIDvTgdeC6YNPOlzPRZ3DeMwPjmsdrlirStAfK7fht4+/8Cd7eq6p8b2Yv
 t2P3eiQR23ik6DWRnEz1tvMSv1ls5C0mlS3tGJzMQXlETV6l1S1dAYGbyDHlxupkWMDJYxNXuy+
 qsVujxBJix5wR/lMEAZZ3At2aqPkiMlM22OSTS3iP4/56swcKCr6TKhyTJVPjhorhRl72hxRjaM
 nGc0VuF43h9P21c0XkpAAJUntOWnmWZB8CAWl4QeDnLKLW3Gf/wIcNYjT97yNTj7cGAyGGtXVyz
 lMBw+j2BljhHuEDOmm+VRY570YYcjOYBPwdZx3kJJszqNxNlcKZw3pe+P6gxYS6taBt/Le8jQCc
 0b8Z9V1QElExMt8LKbGwCcW+0veDrWxonX5wxMT7GT3xVGEp/4bvSDRPwTYX92QyGSc5se0ZrQs
 /4fx9fXvBn5WxJPK+2fbBuzaO6Va9+XKJx+guX+7nmbbhwu6I51VATtH+agwan7sAwoMvPy+kMh
 m0zXouaBYtwMzf5QSUmd3XbROz+6BvwEImNbs3HiE
X-Received: by 2002:a17:902:d4d2:b0:2e9:2a1a:8b69 with SMTP id
 d9443c01a7336-2ee0dcc33ebmr121427145ad.55.1794927254093; 
 Tue, 17 Nov 2026 06:54:14 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:29ac:0:f6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2efd7a7ff9asm16767345ad.54.2026.11.17.06.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:54:13 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, oded.gabbay@gmail.com,
 kent.russell@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] drm/amdkfd: unlink destroyed event waiters from the wait queue
Date: Tue, 17 Nov 2026 22:54:06 +0800
Message-Id: <20261117145406.1092636-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:25:50 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

destroy_event() clears waiter->event and calls wake_up_all() before the
event is removed from the IDR.  The waiters use init_wait(), so a
successful wake-up already unlinks the wait_queue_entry through
autoremove_wake_function().  A waiter that is already runnable, though,
is not woken again and stays linked to ev->wq after destroy_event()
returns.

free_waiters() only calls remove_wait_queue() while waiter->event is
still set.  destroy_event() has already cleared that field, so a waiter
that is still linked there is freed without being unlinked.

ev itself is released with kfree_rcu(), so a reader that reaches it
through RCU -- kfd_set_event() or the GPU signal interrupt path -- can
take ev->lock afterwards and walk ev->wq in set_event(), writing
waiter->activated into memory that has already been kfreed.  The
waitqueue_active() test at the top of set_event() reads the same list.

destroy_event() used to unlink the waiters here.  That unlink was lost
when the code was converted to wait_queue_entry_t by 74e4071665da,
which moved the removal into free_waiters() and left the destroyed
path without one.

Unlink whatever is left on the wait queue after wake_up_all(), while
still holding ev->lock, so the wake-up is delivered first and the
remainder can no longer outlive its storage.

Fixes: 74e4071665da ("drm/amdkfd: Use wait_queue_t to implement event waiting")
Cc: stable@vger.kernel.org
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
Prepared against v7.4-rc1-1969-g666539eecdf4.

AI assistance: the analysis, the change and its review notes were
prepared with Claude (Anthropic) as a coding assistant.  The author
reviewed the reasoning and takes responsibility for the content.

History: fe528c13acc7 unlinked the waiters here.  That unlink was lost
when the code moved to wait_queue_entry_t (74e4071665da).

Testing: compile tested only (x86_64, gcc 11.4).  No AMD GPU was
available, so the race was not run.
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 6e32a892d56f..adc27f25af4d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -219,13 +219,25 @@ int kfd_event_init_process(struct kfd_process *p)
 
 static void destroy_event(struct kfd_process *p, struct kfd_event *ev)
 {
-	struct kfd_event_waiter *waiter;
+	struct kfd_event_waiter *waiter, *tmp;
 
 	/* Wake up pending waiters. They will return failure */
 	spin_lock(&ev->lock);
 	list_for_each_entry(waiter, &ev->wq.head, wait.entry)
 		WRITE_ONCE(waiter->event, NULL);
 	wake_up_all(&ev->wq);
+
+	/*
+	 * A wake-up that actually wakes a task detaches its entry through
+	 * autoremove_wake_function(), but a waiter that was already runnable
+	 * stays on the list.  free_waiters() only unlinks a waiter while
+	 * waiter->event is still set, so once that field has been cleared
+	 * above nothing else will detach the remainder.  Leaving them linked
+	 * would let a concurrent set_event(), which reaches ev through RCU,
+	 * walk a list pointing at already freed waiters.
+	 */
+	list_for_each_entry_safe(waiter, tmp, &ev->wq.head, wait.entry)
+		remove_wait_queue(&ev->wq, &waiter->wait);
 	spin_unlock(&ev->lock);
 
 	if (ev->type == KFD_EVENT_TYPE_SIGNAL ||
-- 
2.34.1

