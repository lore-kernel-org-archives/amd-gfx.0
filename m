Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD510C5B571
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76FEE10E6BD;
	Mon, 10 Aug 2026 06:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z8FiYSzT";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C0D10E115
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 08:49:58 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c9ef3e1337fso620915a12.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Aug 2026 01:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786265398; x=1786870198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ohuKFNYedefwgEV1kOLtJZIOQiLf64k0Qg77YlHmp8s=;
 b=Z8FiYSzTCEovlS+3L/EvVq87R7B+nm43iAuTyX5TCujgT5FdJWC7PmrXRLmcmifbxr
 QJq2zvIZlgBZ44qDHkLqluqJGVFIAEgxZpv2XSnnMH1EHHTn0u9+zd0TzE/V9LAWIUFr
 h/J79rIv0+AHgRFr2V8orei5SEdDM5A3R9MtYSF2aJurloLX5c66kuCpEafItVikadXY
 jWfJG9sgwiZ/PM7+6zn2v4+Ani+MUzTWg9vvj+d/k4jaxXZSGl7osICUGuQhqnCtLCB1
 U3SjVV0VpHlZrFNYgab4VJ1SXKitFIz48Ay0WUNAxuay7ht1nDE3mBr+Xpae+R0zCbB4
 4JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786265398; x=1786870198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ohuKFNYedefwgEV1kOLtJZIOQiLf64k0Qg77YlHmp8s=;
 b=E7nI1M73c/Ed1szD+rpMNC+Cpr48N696QwUwDZYtNg8m5xrF11GL0hcguY125n6e9K
 tuOzOq9mSs9pYGS11a1jcvEOvwqQQz+1mD7l1685mC9TQi69poMoQxs7ycEJ0DiHuE1E
 QakgntMZU5QcHmey9fXMzSrdjFb6D7fd36MAbsAgN1eznhPMqVInQoZNGjBSPL1lTPZK
 WzxnESa/Pxg933dqg7pG7xpqXDGYE9rIinOdi/gFSgtxEBxxqgQHEcqwZrM5xnvsMwuT
 axNO9n4jGoj9KcgzCYw7ZulirYHvDUwEM5QOXoIv+tyNcNmop+Mg2xcFELUOz6ikpUi1
 StmA==
X-Gm-Message-State: AOJu0YyIwHOpwxQufAb9k9wWkwWWxgKx811YHII5+52W7KZgJMQUgySY
 IwFFGVDvpdD0POjg1aMq154+ZgToPuItmSmHY09/1QdFSE4QcdtYUlMW
X-Gm-Gg: AR+sD13XaffqgeTRjk93BVtSrJlLTVmmPxu11YOY+bOd8PTKRAluC+uPdiZTm7U4FiV
 b9ocbOLa7T7ClgJzrT8iAL/UDZbhxVPNQ1HI60K9FX96++M+nauAMPnAv6MZBsNdqiOBX9Lp9OB
 CDmkLy/gFCSqYMOmgBU3zvHyguQqSSoqtLeKt0xNOtzi8L2e7qBhorm3IdyV/yL3NkG/lfMjr47
 lV9wlQcTAvvQmZdeityaurAQeuO/+CRUNE8o5f4F6aYw/Y7DpTsUmOogEXnz8xveVWmxw4XvB8n
 HIRwRYnWQuvh9IbzWVO1p0YyKQ6+FCDntiC5qzysM5m7Hp5wWR/SIvC0TdZDz4anUJfuB+g2ev9
 4BsPof0UKSg5oZq1XL1MK+4+5bd0KZ7q4Wzg8rNRTx+8Iy6+GDUff/wElHBux8TI3mq9d0lA3Ce
 nCYHoGb6XtU3RyeDdFuHqBZuP9IuSzOZyulHxNot82DfaewIRk57ApwlRZqa954Ku8iyJDSLtbr
 zU0QNhHUik=
X-Received: by 2002:a05:6a20:6f02:b0:3c4:511e:26ab with SMTP id
 adf61e73a8af0-3cb85ded984mr46153927637.3.1786265398022; 
 Sun, 09 Aug 2026 01:49:58 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm28800025eec.1.2026.08.09.01.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:49:57 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v4 5/6] drm/amdgpu/aca: Fix off-by-one buffer size parameter
 in add_aca_sysfs
Date: Sun,  9 Aug 2026 08:47:34 +0000
Message-ID: <20260809084735.9743-6-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

snprintf() guarantees NUL-termination within the size limit specified by
its second argument. Passing 'sizeof(handle->attr_name) - 1'
unnecessarily reduces the usable buffer capacity by one byte, causing
sysfs attribute names to be truncated early.

Pass 'sizeof(handle->attr_name)' directly to snprintf() in add_aca_sysfs()
to allow full use of the allocated buffer space.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index dcddeb381628..3da3d369a918 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -682,7 +682,7 @@ static int add_aca_sysfs(struct amdgpu_device *adev, struct aca_handle *handle)
 {
 	struct device_attribute *aca_attr = &handle->aca_attr;
 
-	snprintf(handle->attr_name, sizeof(handle->attr_name) - 1, "aca_%s", handle->name);
+	snprintf(handle->attr_name, sizeof(handle->attr_name), "aca_%s", handle->name);
 	aca_attr->show = aca_sysfs_read;
 	aca_attr->attr.name = handle->attr_name;
 	aca_attr->attr.mode = S_IRUGO;
-- 
2.54.0

