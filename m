Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5415DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 13:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D40FD10F20D;
	Thu, 31 Mar 2022 13:08:42 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8889110E331
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 12:21:24 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id u3so33593921wrg.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P0bQwq9+fWC4pQuN+D8QOE/ntondfVbGkexQoq1N7Yk=;
 b=nKe2aqosp4lwdJRB+hSU+XNR1oThOneKPkDihQtBZOlZOnPTzNgUPX5gnckK8WBuv8
 Uznow3jCpIQ+eC00Mp7PiL3JPxLo0Ac1n7NKxoRH0M1Cmr/p/wJvLu1yVR6+ul7hVRMf
 DaneWKHcTokDYM/kXvV8XeXSyY/pv1ZTveGJiHzKKh43CQ6X5cfYFHMvA9uC/mZRb2ZI
 wOcu3kJSypzkGj3vBk0g3itjUTg8b16j9GDRCUNxCE4trfPhhWGV6TbdydwvrDJk7/D7
 8S7yRvp1OAsS36+aro0Od+esCI2yXogAO7lzEPyU/KXEJWB5w6Iq6OsZVPYHf4vNzAmG
 accw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P0bQwq9+fWC4pQuN+D8QOE/ntondfVbGkexQoq1N7Yk=;
 b=DBEhbq1mlYEDtTqTV/fdCOPjK+YLbc3fa4LhmImNwclj0GiiKgNxUCrFwvGgjKaYnW
 mLh0WHj/2DJ2UHAsSQJwcTwH8ljY4ZNzxGTdOdJV7DgBUmdsGJ1BAHOoZZX77kJae2vC
 p97S/hmrPCfULIrSyz+E4FerEC0exc1qhSmA8OrnN/LJX9tX+4tUWS1mrzGXrCroaf6H
 hOaY7ZVZ31Z7cf08fGTSavlpMAPOr1CYUAZKItwmVh9QwXBsMk0eLH4rQNPOFyAcvyMu
 eG+mKau9BUGfFdmQ5KjU1EaBydJIAuSvc1OgYNn9VH5APwsyTEQWuUBvb3J5ZgNG6EZ2
 5ucQ==
X-Gm-Message-State: AOAM533ETZktpQR56fUYVOrHK0isSZGR5iWQAm/3ZduSOIP4UsKpNuqV
 bdmyZaEPbE5MFXA5EKoiOMs68w==
X-Google-Smtp-Source: ABdhPJx/hLdsk0FmeDLpZSsSiExlN50kzyaGwP5OBjNfReLULHNPPVA8ar7byZkgveP76YNoaa42hA==
X-Received: by 2002:a05:6000:1a88:b0:204:1f4f:1c2 with SMTP id
 f8-20020a0560001a8800b002041f4f01c2mr4115718wry.642.1648729283038; 
 Thu, 31 Mar 2022 05:21:23 -0700 (PDT)
Received: from joneslee-l.cable.virginm.net
 (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a5d59a8000000b00204178688d3sm21892839wrr.100.2022.03.31.05.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Mar 2022 05:21:22 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH v2 1/1] drm/amdkfd: Create file descriptor after client is
 added to smi_clients list
Date: Thu, 31 Mar 2022 13:21:17 +0100
Message-Id: <20220331122117.1538913-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Mar 2022 13:08:40 +0000
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
Cc: David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This ensures userspace cannot prematurely clean-up the client before
it is fully initialised which has been proven to cause issues in the
past.

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---

CAVEAT: This patch is completely untested
        I can't seem to find a configuration strategy to compile test this
        allyesconfig and allmodconfig do not appear sufficient

v2: Also remove Client from RCU list in error path

 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 24 +++++++++++++--------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index e4beebb1c80a2..f2e1d506ba211 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -247,15 +247,6 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 		return ret;
 	}
 
-	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops, (void *)client,
-			       O_RDWR);
-	if (ret < 0) {
-		kfifo_free(&client->fifo);
-		kfree(client);
-		return ret;
-	}
-	*fd = ret;
-
 	init_waitqueue_head(&client->wait_queue);
 	spin_lock_init(&client->lock);
 	client->events = 0;
@@ -265,5 +256,20 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 	list_add_rcu(&client->list, &dev->smi_clients);
 	spin_unlock(&dev->smi_lock);
 
+	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops, (void *)client,
+			       O_RDWR);
+	if (ret < 0) {
+		spin_lock(&dev->smi_lock);
+		list_del_rcu(&client->list);
+		spin_unlock(&dev->smi_lock);
+
+		synchronize_rcu();
+
+		kfifo_free(&client->fifo);
+		kfree(client);
+		return ret;
+	}
+	*fd = ret;
+
 	return 0;
 }
-- 
2.35.1.1021.g381101b075-goog

