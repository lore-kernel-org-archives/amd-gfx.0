Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF983C77B7C
	for <amd-gfx@archiver.kernel.org>; Sat, 13 May 2023 12:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C6E10E0A7;
	Sat, 13 May 2023 12:54:01 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D866710E0A7
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 May 2023 12:53:59 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-50bcd46bf47so2492596a12.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 May 2023 05:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1683982437; x=1686574437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=De8kzaBXLnyvN9Z09P0jq9T3apHCPHjjeL0qbnMu42M=;
 b=dsq9RK5+6/mtCUqZu6pWifpA7Md81jlBnBHHUsBNU1h27pgtOWGPXQboFttYdAXyrs
 L0cHA7I4ScHCIjvuBU+VUwOPeooELJUH9kGJ9lQ5kys0SWi5OZTRNdTRbNGg1de8rI2Z
 qzagRXCqCIOgnXoIkJkZawVHugWxKVY+acvjfxEyFpmWu88RhSgoZuijHkIIXp3QFGw1
 x1imfnQRp5V37Foag6L0ga5Hf0JqorJbI8o2dDcz63/kzbCjR2uynRo4cX1pZvfrY/h4
 pao3cMMnXhZiZD25xBMzvbLxH3fXc8h1CuPPJ4VpmOIJXBW0bAV1OuOpsPZeBHHVO7hb
 U03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683982437; x=1686574437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=De8kzaBXLnyvN9Z09P0jq9T3apHCPHjjeL0qbnMu42M=;
 b=FlqwUG5Pp3c3FCVBTaZTHU5OC86Ep00N/MNpfUeIcSmET4Mer56Ma0+2Ikm5mpENk5
 V1I0l204eNUl9XY7L8FySvTzXN9EYhInSaDux61rZmAGBhcQ0Ixp3ohkpqcIVXEfuCos
 YWB7cimTqpW7TwEHpXyQFE44BM8EODyYvnxvre9D0OdwogXWkFRVfbhGHKHmKg+ReZH1
 OHBMEZVOJc8E1ZCxZND/9yfjcArj5N+aMm8yZR52ib7BYt0nX0NjxU0ecM1i/Ar4lv+q
 hBMPX0/+54AM8ijH+BBTrsmeN6ErKevkYc6bd9uwxBN7tdJv0gklBSl3yGTiPkOU3D4Z
 9uEA==
X-Gm-Message-State: AC+VfDygrHy9f2MEmGXLuFKmnXb7GtPORgzHhfVm9A4O73oewJJy/uZP
 8VWGnTg6dNj9NDRrUGIuSwv+v5jVN+qpq9udXag=
X-Google-Smtp-Source: ACHHUZ4sqz5UnpBoPwNpWAZxEjfCKAN+7CzILystFLfdHZoGGmK4EP+qwwZhMDLiBpnwgyHOoXbsVw==
X-Received: by 2002:a05:6402:2710:b0:50d:9ba4:52df with SMTP id
 y16-20020a056402271000b0050d9ba452dfmr21966741edd.3.1683982437055; 
 Sat, 13 May 2023 05:53:57 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a781:180::a8])
 by smtp.gmail.com with ESMTPSA id
 z19-20020aa7c653000000b0050bd2f16ef5sm4905613edr.84.2023.05.13.05.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 May 2023 05:53:56 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Validate VM ioctl flags.
Date: Sat, 13 May 2023 14:51:00 +0200
Message-Id: <20230513125100.1287549-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

None have been defined yet, so reject anybody setting any. Mesa sets
it to 0 anyway.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 158176b2f47e..62922a795312 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2442,6 +2442,10 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	int r;
 
+	/* No valid flags defined yet */
+	if (args->in.flags)
+		return -EINVAL;
+
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* We only have requirement to reserve vmid from gfxhub */
-- 
2.40.1

