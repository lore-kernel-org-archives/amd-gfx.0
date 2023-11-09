Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5BAC4167D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 09:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B0010E214;
	Thu,  9 Nov 2023 09:49:00 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5765110E1F9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 09:48:54 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso1417022a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Nov 2023 01:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699523333; x=1700128133; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=N4GZPr3RBAEqoXrk87IPRQ0Il9ybtSGY8Ba75kAQ6OM=;
 b=iL/DyVCPi15ip9OXkMneS563wbegRgjzhexZYSKLWruvdQVK2f/4wX55cYzBc4/X48
 fr0eV0xNbn3LWAOUriw7LJQDxUjbBjf+Lz/2QCuZb0oKuXRVBlVlb9c5VpHvH0V4hMwE
 PVyCt8pus7Kbh10P3okxdVdrZnEQBgW5XISODfveGALeYbo96JRgugsIZdK0ITZBDiDA
 5WVpvJWKi48uzpJukTIOmarLaYaMAy+KRowPw+USqgFWeBTUuSS6j3m2uCln+2jOa766
 msFgABIIFxTolM/6OHciCz8CQlBh4kO6pvw8TQo/pWXJ6XhhNjyFBn1RCr9iHspFqO6W
 3zWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699523333; x=1700128133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N4GZPr3RBAEqoXrk87IPRQ0Il9ybtSGY8Ba75kAQ6OM=;
 b=MkZtPyAjq3oOA9v3QnAQTjzoKpYp7rC6FbOqEJNMBsDPQSGNWyMHW90VXm2c5+jGfq
 u3VMvshRxGMd4Pqej/h+4LQTDkD9wMGaoXgck4sdsU0WDLLDCZUI76qiURxbRsalFotM
 oVrC7xLgjgvZHXvvAuTP6UETHL5JJ277dfvAyKRu/d9qG0LMLSYYIBC5SeOjDVvTPPk4
 Uc5dEi4RRqC0h1LJe8e5ldbWeQBJwTd+nQdVKaxje88cwvNJ0nAxC/mxKHGjk2nwB6kf
 eIhlCXf/uzw1LYgYxyI/m7rs3uLI1VgV2COUQGpH5UGJXCwU5Vf0ys5ii3yBpjqxZqPh
 7aLg==
X-Gm-Message-State: AOJu0Yz4g+OM5MSOC7wW3JN1vzzpap3HGhGt4p8jvwvjnc62XpSjulu6
 +Wou8r3IC9tJIv2AlmeJabJAGIKYbAO0KpIk
X-Google-Smtp-Source: AGHT+IEc6qfUGpWgRNtywVdAzZ4j2Jan5BBK5HZlBSANWmjLuLEnONC9T8fp43a6RmkUFWx9W+4QsQ==
X-Received: by 2002:a50:ff19:0:b0:53e:1207:5b69 with SMTP id
 a25-20020a50ff19000000b0053e12075b69mr4700440edu.10.1699523332629; 
 Thu, 09 Nov 2023 01:48:52 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1516:6100:36ac:9121:5531:de23])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a05640208ce00b0054130b1bc77sm7792401edz.51.2023.11.09.01.48.51
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 01:48:52 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix error handling in amdgpu_bo_list_get()
Date: Thu,  9 Nov 2023 10:48:50 +0100
Message-Id: <20231109094851.674657-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We should not leak the pointer where we couldn't grab the reference
on to the caller because it can be that the error handling still
tries to put the reference then.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 4e7089a22139..8ffad1dabcb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -168,6 +168,7 @@ int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
 	}
 
 	rcu_read_unlock();
+	*result = NULL;
 	return -ENOENT;
 }
 
-- 
2.34.1

