Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0438CCFA18
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Nov 2025 19:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F5010E1AA;
	Sat,  8 Nov 2025 19:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kMsq1wtV";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0204E10E1AA
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Nov 2025 19:03:26 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-343806688c5so195766a91.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Nov 2025 11:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762628606; x=1763233406; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9C+/uklAOsr23qYQ5/YsnNbwKcGDulyMEuT9Yu4p/vs=;
 b=kMsq1wtVr3AC3tuA0cX8nPRsQGTxKqRd/DVSZ4A0uWf533v6k1I0YGCjNvmJIE2tIZ
 dvnR+qUbEncsd3XEYagrto227rNhHXBMO3EDudmNho23hlZfJzGcbJCj0LPB/D8FTyof
 Py1zIR+drtTB+uGWh1ZoEFDKdloWyvE/Kl7+fVdwl9kfbEDtPgQsSgUXgrp5RcDt6oee
 kwNjmHLcSYzvb1sBlIFDkxbZG3455ccU3akqPWCQAZPepJg+S8IkTRPhek/Z6BJ1zBnM
 pBfgy/xlbPtKq46OTXdAKOP7aJofwI3KwxWvTLQSK1qQBktQ7jkePqD/T9Bj2wJI7Vle
 Pw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762628606; x=1763233406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9C+/uklAOsr23qYQ5/YsnNbwKcGDulyMEuT9Yu4p/vs=;
 b=qvUmsLZBnErNJcUrg0p18azNDlz42EFkdZNDW79Y2rSkUENqaxU+fiSbg6Si+61b9l
 C18lLRS0S5fSuG+JzjsZNgndc6erKn/G6ozVK5/UmRyJZmJdO8WsOt/2zGOVO/Yjpva9
 KUsyXfySFWwZ6PXtVNMspK2DrUZNrsJX0pS8qyBARmC9LVsyVpwhp/Ec+WTKsAv/OZaA
 rg8BzPnCqNXDN/6bdZ+JjsnigKGRFs4zABB9LQOhm9pjSy40yc0qfvOh8Wk/zaYbnCl+
 7RbdXhupNLp65ElKQjAAI3CW8djh6pMN1dAtMeedbh2Ui8zyNZsE79FwM9tAuBNNmEIg
 BqIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs1eLXupZvwGsC6qhEi85hTj5ka4g+NlYtwkkjxvfouDlEDLDtdOz02Me3aqJgEFxkoY4+6/11@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZA6YigZY41zGgF4MLFTUiL+UfRj2SvU6O8LWsQGMlYfoEBMrT
 O7IMXpvCibsn4utQRIkIZPUCkqMwKyT2OJDOY3PivXTzE3X5/NFtRwne
X-Gm-Gg: ASbGnctZAcX8vgv+WT8Syl5xfaDazPbpT8lVTuEbO6y7OQrRdHlWJ6+OSBasoHag342
 kKJHAvFr32dipzwd0O70Nc9npVIF80qL/1eBmUcyJ8yUYII8c12MJvKw2JMCNDJjKceXl++ofYX
 oBY5sIRhBov9phv0G7h1vN9RRkBRYqpM2T3uH+1hny3gs5dRpocapigklI6Ub0qua1DVI067VjL
 aaPHkeQuV6PxpoAc5QlAy7rA9fMVJO1OckTQeVVquKj4ydcPH4HdUTJigvgvG4EO0JvzvKh+gNY
 /TD2mAYyYvNYlSsg6/dzEzWq94RYNgx6laiFVTcou3+wlJjNMQe21whYwDAvmydC9PWa95PclrD
 nDdK0bAKL/z0WJqluSpI9FaMeQ+gwoOMrVbkwYpwzoCFi64I1uP/CxcPr7yc6Q5EZ2apAfigBDW
 iWpj8DT1fcAh0QwOhEOOPKJab2u6sAq/VuPvheNswQG1Y=
X-Google-Smtp-Source: AGHT+IFXpK181b6iyP3yJGOhrUBoDSlmwl1y+xVGO9ArpvaUWZSDM62O4IJ7wHf6r/QfNoFOBvF4eQ==
X-Received: by 2002:a17:90b:4f8b:b0:32e:d599:1f66 with SMTP id
 98e67ed59e1d1-3436ccfef31mr3782867a91.30.1762628606346; 
 Sat, 08 Nov 2025 11:03:26 -0800 (PST)
Received: from sallu.. ([2402:e280:2130:b5:62c3:5e59:8a15:7da3])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba8f8c880c5sm8473552a12.6.2025.11.08.11.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Nov 2025 11:03:25 -0800 (PST)
From: Saleemkhan Jamadar <saleemkhan083@gmail.com>
To: Christian.Koenig@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, saleemkhan083@gmail.com
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: do not use amdgpu_bo_gpu_offset_no_check
 individually
Date: Sun,  9 Nov 2025 00:32:33 +0530
Message-ID: <20251108190317.13240-1-saleemkhan083@gmail.com>
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

v2 - pin bo so that offset returned won't change after unresv/unlock (Christian)

Signed-off-by: Saleemkhan Jamadar <saleemkhan083@gmail.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 21 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index b1ee9473d628..f0ad3edbdef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -93,8 +93,27 @@ mes_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
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

