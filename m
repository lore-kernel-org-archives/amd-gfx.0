Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4C5C47DA9
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 08:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642D3112E0E;
	Tue, 30 Jan 2024 08:42:46 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A2B10EA75
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 22:21:16 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-68c3fbc48e0so2033686d6.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 14:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706566815; x=1707171615; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmoc6TMIM1XGef1GU+/KvkFMgd0OCyZYaEfBRT5oYnM=;
 b=a7XDu0DGJ48XFgW8m7Aq0b77Bb3ptHPbAHbVv06M7J68dfJwk6XvZyUaQsV6o5yRpF
 jvLuCvTiTasHzpJ54hFg9gy65jWQRNkUWandrnQzl/BNi8tW98n3Glk37IDFnSELUizh
 xv8G3/vsJS53UsLtl+BuHro6od7Qvd6BX2JvlsZwQU2vIQgDB0bTEXzgDuaF84fyu+k4
 yAV1pWH9Q1SF2wjOBDWW5jBqlquFLBY0L6XOaLEYejgnI7oDalTCfW5fJrok8dZDPj5e
 3XszZbeWyhp9WBj7VmorYyrN8toKEZFlGZfqoItv77rtesOBHY+Y6Wznjc8l0304uH7z
 JrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706566815; x=1707171615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmoc6TMIM1XGef1GU+/KvkFMgd0OCyZYaEfBRT5oYnM=;
 b=cDCvydiqTCQaYM+z3lZV/mu3s/OgPJbvywdcP9Nd/OWceXNSxLLQT9cFCr2yDmHZpy
 yz5VkbQyqrEGOedAOl9JjMPnfa3IriLJjf54NH6+zrP3zFFHb/cd5akb7CxLhQE+QjvM
 jciGiqnlAq/Aimxrcl75LOOPhzi1EhdqRZGjS3Im1TVp61eODJHJ0h8vlvHEaQjhVn1P
 uhaqxnpAQYDwCc6vDMVqq5FnLcCYusOEemCsBchBQnRk+KEu8rRhfhs3p9NMbgVjOCt+
 xNld2Mt581brf1ZtLhEgjZdhAgWvFyrjYukTryQhAClxIq0meYklv292M7qU8TVa4Yro
 Vpsg==
X-Gm-Message-State: AOJu0YweXZF6K21rF9bHJhwQRA8FV8QATpSV2VpnIMRGakmitIBvjlvi
 0J3IN3a39wxkmXEuJfNK14r96XWGQXZly9rKT+YeqKEfiDTL4BHS3ik3NKze
X-Google-Smtp-Source: AGHT+IE2nGhFMHeKNbnOEOC7+Y7A45i3GR3qEYq5mky0uUF1YSSFYJGpGFnEcgleeVN6zpDYN7doxg==
X-Received: by 2002:a05:620a:2944:b0:784:7b7:78f1 with SMTP id
 n4-20020a05620a294400b0078407b778f1mr1228902qkp.6.1706566815224; 
 Mon, 29 Jan 2024 14:20:15 -0800 (PST)
Received: from davidm-laptop.home
 (hlfxns018gw-134-41-187-249.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [134.41.187.249]) by smtp.gmail.com with ESMTPSA id
 x12-20020a05620a0ecc00b0078366823711sm2009468qkm.119.2024.01.29.14.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 14:20:14 -0800 (PST)
From: David McFarland <corngood@gmail.com>
To: mario.limonciello@amd.com
Subject: [PATCH v2 1/1] drm/amd: Don't init MEC2 firmware when it fails to load
Date: Mon, 29 Jan 2024 18:18:22 -0400
Message-Id: <20240129221817.8797-2-corngood@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8bda643f-314d-4947-83a4-8ad536dfdc41@amd.com>
References: <8bda643f-314d-4947-83a4-8ad536dfdc41@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jan 2024 08:42:45 +0000
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
Cc: David McFarland <corngood@gmail.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The same calls are made directly above, but conditional on the firmware
loading and validating successfully.

Fixes: 9931b67690cf ("drm/amd: Load GFX10 microcode during early_init")
Signed-off-by: David McFarland <corngood@gmail.com>
---
v2: signed off

 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d63cab294883..b0ba68016a02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4027,8 +4027,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		err = 0;
 		adev->gfx.mec2_fw = NULL;
 	}
-	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
-	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
 
 	gfx_v10_0_check_fw_write_wait(adev);
 out:
-- 
2.40.1

