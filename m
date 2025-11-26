Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3251DD10F4D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF9F610E5B5;
	Wed, 26 Nov 2025 13:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gMj7+oxJ";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F239E10E5B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:30:03 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-42b2dc17965so6254855f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 05:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764163802; x=1764768602; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=478bvESfK0+8wGBUy5SiutJ5AizRFftHft13AI1X+rE=;
 b=gMj7+oxJR8ShTMDBgVjF/rK/dt+pMpqduhxTgFAQ/BJpmA8IWpdn/aUBp9ZuEXPCXv
 apvVJrd+PcWK1vG/yzhdxZlI9CtQnNJZI73b3Al+BoQbZcrkac1AeSW26gTyzQYRES93
 3O8LZSOmBtI04GzJ30IS6VW02oU7F35o0qnm6vMYp9w0JotJ3YWd/j7UaiB5eU8B+iOo
 KNVJX0VJHQaqWm0iCBn029Mp4A071CAq5dWYik3IP5OoqpuODuHubf4RTU4rEGETloQK
 5h+kBlpxr/coGAK5auXTTepvK6Io/BNJul1WKlprWpJkI6K8PRvuUN3PqiwQvlbZwqjL
 e2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764163802; x=1764768602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=478bvESfK0+8wGBUy5SiutJ5AizRFftHft13AI1X+rE=;
 b=ssOsLQjyvYZUe00abxRWAt2/yPRcI0EVVzSS3mda0iCKzD5zZHKi7H2VBcCQ0AwiO3
 pufvA3TA94mXXitfq6mpouLM9EDXB0ZRbiNA+vwunimXws5GOeIUPDvnuQk/uDjvGfXF
 ibccPoE6MqWb/wnTVElgr1aADdCCx0e0TWXItqWKz9dAGQrlLGuT4b85wtzVV0+8bT8b
 jacESDLNAMlg+ajyYt4nRHPakWpVB42VKZGWmvODqBmS06JyIA3mnVWDJFhcUKcJOb0+
 A2b9rcuas2BdTan6+GbDkwOnVZi5cPZDtI2F8o5+iG7bnx42Aevby5YyfakqEVhCR7j3
 ydEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTAJTGiHZ6lDYH17dcXRg7LdQjauNeGkOjg10MzrP3X5wyLMiRVm2aHd/1NDXybQ2l/Au929sm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzG7SFH848SNH+GIhw7SEVdPbhA6hVJ1Hq0ELnUftcK4A68QgQ2
 +oxOXkv+JUibs3eExZQeg42u7rFR9pr3gfFa9UJUsZTZHgZDOmYkOL+V
X-Gm-Gg: ASbGncssRzpatqVJC67OpM8EbYPh1jlhtL8B7N5jFuEJnvbLHkUREdVPsekrHpc8pm5
 ZRDe7rm1glDoT+UVrKV6LdXTZ3sihRTEB/jOkwfyGIQKqAkWPXPeKPK4U1vLIHhp3/f525WA460
 0Il8gpiZM7Gma6db8Acrgom5z578znJkrxcT9Xt8iTLFhHj1jpbqr22ord4MI/aVZze+2pcRYfM
 /zJirfC1NvOrhl4t7QovhIkjbAEyfMPWr2ZJH/VgWEFTGyAsDAAeByk9v2KS0E1wWbbv4d841c0
 QMq5BUSwF90384w95csNnh+7b1rbyFWTLHks6FBFlqweuKmIqn9EgBIj+K6d419/h77B4XoWSq3
 eeHZQ7xdrka6AxkW681SoXjmPesNg2v+A0LTo2010I0Ed0gDiOs4Nf3UnqWYXOmqMDLj0Wj1Z2g
 6vrW9btga/BT0VZmtPGSlc7NkW/ojY73b5DUM2VuQ4EZHFm2YymvK0Wt8fW62ACd7c1T2EOH9MN
 L151u5+ZSk5XzGKmhI=
X-Google-Smtp-Source: AGHT+IHMNYZg1OxRniqeCtjPhW770bWuDm4v3sQisjjC7He2fS33Sn30fNIYf8J+LYH6eo4gu2W1XQ==
X-Received: by 2002:a05:6000:1ace:b0:42b:4177:711e with SMTP id
 ffacd0b85a97d-42cc1d0cf97mr21442105f8f.37.1764163802440; 
 Wed, 26 Nov 2025 05:30:02 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24D8E6005908B7D279C7B6B2.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e600:5908:b7d2:79c7:b6b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm40537696f8f.2.2025.11.26.05.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 05:30:01 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 07/10] drm/amdgpu/gmc6: Cache VM fault info
Date: Wed, 26 Nov 2025 14:29:49 +0100
Message-ID: <20251126132952.150452-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251126132952.150452-1-timur.kristof@gmail.com>
References: <20251126132952.150452-1-timur.kristof@gmail.com>
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

Call amdgpu_vm_update_fault_cache on GMC v6 similarly to how we
do in GMC v7-v8 so that VM fault info can be used later by
userspace for debugging.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index f6715648b08a..bc6a74903f4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -1077,6 +1077,10 @@ static int gmc_v6_0_process_interrupt(struct amdgpu_device *adev,
 	if (!addr && !status)
 		return 0;
 
+	amdgpu_vm_update_fault_cache(adev, entry->pasid,
+				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT,
+				     status, AMDGPU_GFXHUB(0));
+
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
 		gmc_v6_0_set_fault_enable_default(adev, false);
 
-- 
2.51.1

