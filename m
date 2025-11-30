Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E559D111A8
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Nov 2025 09:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F73610E059;
	Sun, 30 Nov 2025 09:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f4FtKwD0";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C4510E059
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Nov 2025 09:05:11 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2957850c63bso23138575ad.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Nov 2025 01:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764493511; x=1765098311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EYXnAWzBT2Pd+YKQ/W0aXWPP6OkmYIFwyKGZKZ1m6GI=;
 b=f4FtKwD003kqrKdaQr7Uu2bij1P38+qR5iYHb07c2O0SO7B2ZAO3IlVQ/p+jYva924
 sChJhMHVpepRYmNdtz27E3te/RTqEs/+0qyXjpTuohnoOE5+1uXSo2pe+vr/6hB/Km/m
 J/JTYfuwT5oV+8lvjBNsxyAfFXpdmhXx6bEITfPMyHCl++iweINpqvqtt1LETQgN09cD
 h1zyLxO43nnHfFkI0H5MkiYzF7QnPQmk2ZBCEFztMJeNBPxSb9RwhryuMcST0mwfQAn8
 TPUlFYyF5/xHXIQ+EA8c7iWLG29+ZxVQGcLoa/9Nnesmom+Sao1kCiPP0YZ+lYc6hB25
 sguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764493511; x=1765098311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYXnAWzBT2Pd+YKQ/W0aXWPP6OkmYIFwyKGZKZ1m6GI=;
 b=I8L8wAIStPjKw8rIz5u4wXgGkJL3WT2ev5hjIwG7Zdk+8kcRwejO44v5jV93A/dQxv
 BbQ20Va6fgpVWcFTxMXD22f9beHSjUwPAM3UHocJinNVtkzIFTeblYJa6qhrKKGd/Io+
 LCdNon1CR0Nexx6QXnV9iX6oz3/Gk6x+ZdHD0w10eP80Rf3phXpfXN/w2jNOtoOAYEKZ
 AYhCIpkYbvCyPH4Rsyx8uK0nSH3e4xpXwqVpzZXDCHcpZhKxj7mJo0VT1hkW2/gxW8WP
 d/uW1pDIWELTDQjCmSvRRZSB5mWBa+kruOUpa6P/sAeYslHNveRgouYLoSvsYAxuKWCA
 Lsbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAQFhz5uTVZQsEuSPwpjXKPemEpioVvKX1OnQXuCQ/jpT2rw1Yp6XoMJEg+M54ziJfEEvWLlYi@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5zwOs5tSAJnogbKjPF/+yR651l7wCoc8DYb3DvRXi99QPY6F8
 aquRFQq8w/krf0i3rpfa8575+3XDzvUsRya7sES3UkHdx9EQC7XYh9MW
X-Gm-Gg: ASbGncuR+4KVsPaZy0Yr9zQczVrqwMCD5l4VTv1G7CS1t60ijrr22RkZcYbolvRVSCW
 IuvMPMboPYDgAYWxSHDavzUjafXy03ob6daQAojKaagWSdw9hbL7OX765PJ2auWDLvznl3Vm144
 ZqTfWGVyMs/HtAXwN05BdHZcBkzC1/Laudaif7kxSrDSBBmk2a/UcRWUCWOT9+IOCE/nZy2hdWH
 WPJwO7cQB2pa3+NoNdluNXx3SYvulHTlC4Y7RRSOx+cy4LW2LNQxq9lZhkfNX+JnqA+xra0gbza
 6uR1YUwGrgTvMF/FzPxvLNi3XM+OUwwUqrO1GcVQCKN7hWHSt62x7neBy2rxHuX2kZSNZ3xqDdq
 Nun6bOhBMXYpy06CofJkwZxEGy3PtbBZgV7kzDdkstUSU38LFCxlritFRjTeXrpbvrgVJm/+mQk
 GqZcbpHL8i40YWB95ZQnDk
X-Google-Smtp-Source: AGHT+IFFOVDIJSxc7Y2Y2M61+/yPmrFk/CE/6ALxkKYBPzjazrdYdu+jqKnv9CxYsB1kUQu21l87+w==
X-Received: by 2002:a17:903:2383:b0:295:557e:7468 with SMTP id
 d9443c01a7336-29b6c00b02dmr373392415ad.28.1764493511112; 
 Sun, 30 Nov 2025 01:05:11 -0800 (PST)
Received: from sallu.. ([2402:e280:2130:b5:bfa:f3d9:b4ff:2649])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bceb54454sm90192245ad.84.2025.11.30.01.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Nov 2025 01:05:10 -0800 (PST)
From: Saleemkhan Jamadar <saleemkhan083@gmail.com>
To: Christian.Koenig@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, saleemkhan083@gmail.com
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v3] drm/amdgpu: do not use amdgpu_bo_gpu_offset_no_check
 individually
Date: Sun, 30 Nov 2025 14:34:44 +0530
Message-ID: <20251130090502.83707-1-saleemkhan083@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This should not be used indiviually, use amdgpu_bo_gpu_offset
with bo reserved.

v3 - unpin bo in queue destroy (Christian)
v2 - pin bo so that offset returned won't change after unlock (Christian)

Signed-off-by: Saleemkhan Jamadar <saleemkhan083@gmail.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  8 +++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 21 ++++++++++++++++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 3040437d99c2..bc7858567321 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -129,7 +129,7 @@ uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
 {
 	int db_bo_offset;
 
-	db_bo_offset = amdgpu_bo_gpu_offset_no_check(db_bo);
+	db_bo_offset = amdgpu_bo_gpu_offset(db_bo);
 
 	/* doorbell index is 32 bit but doorbell's size can be 32 bit
 	 * or 64 bit, so *db_size(in byte)/4 for alignment.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2f97f35e0af5..98110f543307 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -586,6 +586,14 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
+
+	r = amdgpu_bo_reserve(queue->wptr_obj.obj, true);
+	if (!r) {
+		amdgpu_bo_unpin(queue->wptr_obj.obj);
+		amdgpu_bo_unreserve(queue->wptr_obj.obj);
+	}
+	amdgpu_bo_unref(&queue->wptr_obj.obj);
+
 	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 8b0aeb89025a..23cf517bec39 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -94,8 +94,27 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 		return ret;
 	}
 
-	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
+	ret = amdgpu_bo_reserve(wptr_obj->obj, true);
+	if (ret) {
+		DRM_ERROR("Failed to reserve wptr bo\n");
+		return ret;
+	}
+
+	ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
+	if (ret) {
+		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin wptr bo\n");
+		goto unresv_bo;
+	}
+
+	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
+	amdgpu_bo_unreserve(wptr_obj->obj);
+
 	return 0;
+
+unresv_bo:
+	amdgpu_bo_unreserve(wptr_obj->obj);
+	return ret;
+
 }
 
 static int convert_to_mes_priority(int priority)
-- 
2.43.0

