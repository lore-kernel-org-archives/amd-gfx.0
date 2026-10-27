Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDE8606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pQ+CxO47
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA6F10FC4D;
	Wed, 28 Oct 2026 13:00:03 +0000 (UTC)
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54A8610F876
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 22:39:33 +0000 (UTC)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-19dbbe4b1d8so296853c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793140772; x=1793745572;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MTMJFM/nqHoym7HFBiG90k6OXEIlh5WHZZg+1coUz9A=;
 b=pQ+CxO47ZcdXy3FR3kf/oZ8HHuRAtQynwgzfllEH/+DfBvW3X4zjnN5jWJUS8/KOHv
 OUXo7w2ZFO5sPzTEYL6bbhfEGoFzjgGHYrx9ZNaV12bQoA85+jfmc+Hj9I6GphF0Wyaj
 q7DVe/WC4BozY5j90MP6lNdZG+2dAM4CKRVwzDmfu2qPbW5dzfAIWVaj49i4uYlugyCa
 ylQ/CR9qLz48d4zfzzPTtwlZkyy22ShDvZrOWgN/3eAVG2ggJZ+kvzVd9gt2IqPy8mYe
 GMIfhcvYr+rD44pm3PnIWrMXqc3e8RMIAXyuERV6V2mQ92604sz3vt0JKdHPEq0gjB0J
 gy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793140772; x=1793745572;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MTMJFM/nqHoym7HFBiG90k6OXEIlh5WHZZg+1coUz9A=;
 b=W4XzdmmU/o81QA2oy04lvgdOi+DaG//lXtQBexOw373N2Lo4AKaoiDVUWiunN1lKVV
 v0oDzvcw4I/2dpqVQuWoxMDz9sAOdEZDPHX9xnino0F3k43/2U1Ac93LFx8UvtnlKBAb
 aRkRsknLxocsJv3+vUpdGOvqw82236qK0dM7chsBOdYvT5LEVlntmwyXDT7NUAazXL+w
 TXyY/A3QaDbmpyubIA5WX3ldvEklA4+E0zAouC02lJAvBpilu/jpRBkxxx3P1Cg8jV33
 ORfamCCQagpOtXMlua1pC9YvNJf1LolWNmtlPIqh1C+G0Dnf6zS+0evnk5IlnH34Ryq7
 khCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZrMDkz3Fob20NC1C0bPYACC4mLWaffv0uZlWm7yw7iX1ErSsnyv9QIPW/RlhzS3npU/Yv6fP3@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJytoholqNxb+VNam/QlcvLL0nOWRnROA9oaifFfyolprA8mFFC
 wDhHq5NR8pTIXD7lVGct3NE51yg6EdxAOMyRVnYd11vwrE9BMJlHtFwPv1LLFki67OpXcxP1GLI
 cluxB5pGSPA==
X-Received: from dlea12-n1.prod.google.com
 ([2002:a05:701b:420c:10b0:1a4:c892:b166])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2813:b0:143:6525:f9f6
 with SMTP id a92af1059eb24-1a6cd3a1575mr630918c88.13.1793140772067; Tue, 27
 Oct 2026 15:39:32 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:43 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-9-irogers@google.com>
Subject: [PATCH v2 8/9] drm/amdkfd: Free queue in procfs_queue_type kobject
 release callback
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 driver-core@lists.linux.dev, 
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amber Lin <Amber.Lin@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 28 Oct 2026 12:59:51 +0000
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

struct queue embeds a struct kobject (q->kobj) for procfs entries, but
procfs_queue_type had no .release callback and uninit_queue() freed q
immediately after kfd_procfs_del_queue() called kobject_put(&q->kobj).
With CONFIG_DEBUG_KOBJECT_RELEASE=y, this causes a use-after-free.

Add kfd_procfs_queue_release() to free struct queue from the kobject
release callback, change kfd_procfs_del_queue() to only remove the
kobject from sysfs via kobject_del(), and drop the final reference in
uninit_queue() via kobject_put(). Check q->kobj.state_in_sysfs before
calling kobject_del() in kfd_procfs_del_queue() to avoid warnings if
sysfs creation previously failed.

Fixes: 6d220a7e7971 ("drm/amdkfd: Add queue information to sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  5 ++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 226f52626e84..8e6136d52a50 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -512,7 +512,15 @@ static const struct sysfs_ops procfs_queue_ops = {
 	.show = kfd_procfs_queue_show,
 };
 
+static void kfd_procfs_queue_release(struct kobject *kobj)
+{
+	struct queue *q = container_of(kobj, struct queue, kobj);
+
+	kfree(q);
+}
+
 static const struct kobj_type procfs_queue_type = {
+	.release = kfd_procfs_queue_release,
 	.sysfs_ops = &procfs_queue_ops,
 	.default_groups = procfs_queue_groups,
 };
@@ -552,7 +560,6 @@ int kfd_procfs_add_queue(struct queue *q)
 	if (ret < 0) {
 		pr_warn("Creating proc/<pid>/queues/%u failed",
 			q->properties.queue_id);
-		kobject_put(&q->kobj);
 		return ret;
 	}
 
@@ -697,11 +704,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
 
 void kfd_procfs_del_queue(struct queue *q)
 {
-	if (!q || !q->process->kobj)
+	if (!q || !q->process || !q->process->kobj || !q->kobj.state_in_sysfs)
 		return;
 
 	kobject_del(&q->kobj);
-	kobject_put(&q->kobj);
 }
 
 int kfd_process_create_wq(void)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index ae3e7c54014a..4666110aebe0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -83,7 +83,10 @@ int init_queue(struct queue **q, const struct queue_properties *properties)
 
 void uninit_queue(struct queue *q)
 {
-	kfree(q);
+	if (q && q->kobj.state_initialized)
+		kobject_put(&q->kobj);
+	else
+		kfree(q);
 }
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
-- 
2.56.0.313.g2479322e68-goog

