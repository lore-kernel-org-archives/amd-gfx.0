Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6626C7EE29
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 13:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B816510E107;
	Tue,  6 Jun 2023 13:05:33 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D109E10E306
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 08:34:12 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6042d610fso57576205e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jun 2023 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686040451; x=1688632451;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2izjzTKrsvyjgmHREHIuV3DhydL97IdDiRxRMnOeXt8=;
 b=OErqnzweEJnhsaaPFaP7VZfLkSbPfX5qAZa28ojnzyelYj5YhqnntN6oV1OS9dkSaN
 G0ei+K2YXyGAGBrgE9XvDk+RPWt/BgtmQtOyyswysU7r/Q9EEFswS5CrABv/6nobBw9g
 yDqfNxCkaNFY/LaJp9W00iklyVLBn2l3MZyJLQCKONlBxICL8oqJ6P6cevqL0n564ZJj
 Tqi0d/FVYsPMXgJs+84uh4raeWnTP251t5LRhfviIOKkZna8VpZK7QqCdIwV97v9qXsJ
 2Po1FKgZaF0rKNixgfymwyvLILi/1/VepJMHiV7kBAFe1oqwLyTyrJClXOoRcZiqDz1u
 kw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686040451; x=1688632451;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2izjzTKrsvyjgmHREHIuV3DhydL97IdDiRxRMnOeXt8=;
 b=J7u86wil7+W+es+L2k1yCXG7HlJEjKYmpe5ilRBy2yVayEI6PvnKzDJhhZYvj81snX
 uqwvIdyuFPix5afCwR+eU/U4j06ta9DFlIknGQ2n8bYWqZ8B2hAhAyPijVd+uzx+ZAx7
 ObUv0SJXh0EjtEKjw9kMrSqDbizVgc6L7VUpCh3yslxPDksNml4qeYrDKTGvEBPp6X2y
 5QnxUSi8ljAx8J7f5eIfbdG8CIREcoJpl/USttaTIuJPbOR0MBsDtGhpHgWevXvzcLDR
 0BxmrkGG5liKC0P3833eFzLS/thHhITri3xT5paQ0UzyjhnrlesqiddfxIeAA9XzCSzK
 jm8A==
X-Gm-Message-State: AC+VfDwQm6XAEdL0tt/TzNbrGNeQvVWAJisO4/iBqESqhEX4zUwbfLPG
 pMy+EHHtVdJbj2l5GttUkj5DHA==
X-Google-Smtp-Source: ACHHUZ6SaR69anAz6NDuX/nLXmGxPow6vG6jR9hOpA0mGvflQ36v0mirre/H1zIBhvPfirSph2+hMA==
X-Received: by 2002:adf:df91:0:b0:309:51ec:b6e2 with SMTP id
 z17-20020adfdf91000000b0030951ecb6e2mr1281097wrl.21.1686040450791; 
 Tue, 06 Jun 2023 01:34:10 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 s2-20020a5d5102000000b0030ab5ebefa8sm11910258wrt.46.2023.06.06.01.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 01:34:09 -0700 (PDT)
Date: Tue, 6 Jun 2023 11:34:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: potential error pointer dereference in ioctl
Message-ID: <ZH7vfZnpMMsGKEOq@moroto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 06 Jun 2023 13:05:31 +0000
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The "target" either comes from kfd_create_process() which returns error
pointers on error or kfd_lookup_process_by_pid() which returns NULL on
error.  So we need to check for both types of errors.

Fixes: a42e42c4e3b1 ("drm/amdkfd: prepare per-process debug enable and disable")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I'm not sure how to compile this code or why I'm seeing this warning
again after two years...  Very strange.

 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index fc385000c007..6a27b000a246 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2920,9 +2920,9 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		target = kfd_lookup_process_by_pid(pid);
 	}
 
-	if (!target) {
+	if (IS_ERR_OR_NULL(target)) {
 		pr_debug("Cannot find process PID %i to debug\n", args->pid);
-		r = -ESRCH;
+		r = target ? PTR_ERR(target) : -ESRCH;
 		goto out;
 	}
 
-- 
2.39.2

