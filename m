Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4033DE7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 08:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E0510EF64;
	Fri, 13 Dec 2024 08:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I1j2gK0S";
	dkim-atps=neutral
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9DB410EF64
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 08:52:59 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso10291915e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 00:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734079978; x=1734684778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mH07pMS2yDvVoZ+w96eKUMkNBpCKjLgK/Qmp04pavos=;
 b=I1j2gK0STlNsKfNrggPNUyVLqAeoecLDkFMCYi8E3H/xe4fj2VKfvK0UleZh6SvGVo
 jxVI47O/YhZuAbGRwpdaIJruXnIcWrY9oXZDZ2JDQ/Rm+clIr5QD2Ww9JFRhHYnPrHSh
 w8A50tm/7OIJkbvXDuamSel0l+dOUrzWav1pKHnV9mza+w+5LUfGljBsv/KeGNNqRNtw
 /lhqDr4Nl08LwPuKGDUs4WMCKvnGLh9iorQ10EktDZBkUQRQsoikeDUpqx9aP1tOwFse
 B0qHURNLcfhGEExWK57aP3s60bwSNaimZYnSlF6UWWXMeeIXttbKvLxpI9pUSMj2j5q8
 lAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734079978; x=1734684778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mH07pMS2yDvVoZ+w96eKUMkNBpCKjLgK/Qmp04pavos=;
 b=oBr1lLxermIT4iCe5AtJMPd0fEsbIbabILlHuISShLZr+NdSydRn844xxkjOSxeiih
 OSm6GasaAJj4RJYgda8cPD5uqfyq4CGLWp/yvBrcVnnGL3I43r8o3uppIhksHmPvTRrQ
 N/eFbpa11PjQ7aJpsLIuyfcXu0eMH475RuwDuKEJ/2uhGJBsoLovMjqNor9JEcACS61s
 etji0dHJpjnFKkYrDhfdxVej7wLKm4Nc18hwjIIw8WvLVSiENcVe4ZjkqXdPj+6dfqf+
 wxIoRS8UJGOepn3EIbaeKW9EMyYIqsrp+hDpFO5WOQ/VFQJFi26ElmO3kuMHnWjRNpPq
 X8lQ==
X-Gm-Message-State: AOJu0YwpZjEYl0fuJ2oP6TFj/QgzJ/UmzbzL8d8TTGXqoTrW8o4wUVXt
 AHU6zDrap7wFWce9FKb4mk8Im3kt1k2P/G3EsfYhAK4Cte9AYNEduW3sjA==
X-Gm-Gg: ASbGncsj/zgzSMVasGyfzT/DOubFUqZl/5xx0TZG5N+Oy0eylLSoH5SMr8b/SmVTrX1
 C2OdKbnYx9w+G3pWwWL2RPCFP89IgVtlZnwbRsme7JbGkZvAEVqaikxW0aT6AA7b/S+KO2R9LPF
 VStsva7RkexG8MLU/hT9ezv43oR60yLQf1Kj2yW7DoWt5fG9AfNG2wkQlZnvR6BAlNcK5wAYwFm
 9v7KSZTUGpPnCKdfTzm+bhf+NiuRJUXGJTenW9UULhkyv1UllFzsQLait/meLfgIh/vuw==
X-Google-Smtp-Source: AGHT+IHwXrwx6HIF/djmaTorelNq9NAjDVNOGXJ9xYkkzGb1R408TFk2Hi8T/wL3stP6jWk4bnVOjA==
X-Received: by 2002:a5d:64c3:0:b0:386:41bd:53a3 with SMTP id
 ffacd0b85a97d-3888e0c07f6mr1077976f8f.50.1734079977968; 
 Fri, 13 Dec 2024 00:52:57 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15a3:f300:e495:bece:6ecb:efbd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824cab97sm6392473f8f.62.2024.12.13.00.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 00:52:57 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
Subject: [PATCH 2/3] drm/amdgpu: set the VM pointer to NULL in
 amdgpu_job_prepare
Date: Fri, 13 Dec 2024 09:52:54 +0100
Message-Id: <20241213085255.1449-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213085255.1449-1-christian.koenig@amd.com>
References: <20241213085255.1449-1-christian.koenig@amd.com>
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

As soon as the prepare phase is completed the VM might be released,
better set it to NULL.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index b9d08bc96581..7fdf7b047317 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -367,6 +367,13 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 			dev_err(ring->adev->dev, "Error getting VM ID (%d)\n", r);
 			goto error;
 		}
+		/*
+		 * The VM structure might be released after the VMID is
+		 * assigned, we had multiple problems with people trying to use
+		 * the VM pointer so better set it to NULL.
+		 */
+		if (!fence)
+			job->vm = NULL;
 	}
 
 	return fence;
-- 
2.34.1

