Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEB7C36002
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 18:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC8A10E15B;
	Sat, 22 Mar 2025 18:38:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CdR+yBRP";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7ADC10E163
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 18:37:57 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7c5b8d13f73so258917985a.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668677; x=1743273477; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oLJmzV2r8LqidAHLW0n3smB2eXT4H9bX6ahb61sB06M=;
 b=CdR+yBRPRaN+4zJBYGwIWceA43lC25gLxSeZekttuurTDq1ijgP/47pPKDdNjuNl21
 li1wVKD/9P+kHfm/9EJhfE+5chsHKhfDW20fWDwg3BqMzpJLUwj1VQPUw8hzQtVdvILE
 m0ZufDZx14ZKW8A2FsX41ANTZHWGCFCFW1wl5Z0mYACVbbBevCr6BS7ZMwC8iCZU6tVb
 czx+jI4rnyteaG8UVpFskkicR1UZoYClYqPAVgeD1GMN9rlZ3UVqKJqOxoR+2F8dCBVg
 JASmzXPuGJUI22luOHfuj2YgcgKTVARNU1Yc5BaUJVT7JwJytXRjJ90Ssbs7cg6Gg1z6
 7Mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668677; x=1743273477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oLJmzV2r8LqidAHLW0n3smB2eXT4H9bX6ahb61sB06M=;
 b=kb+lG4WRIQsyx4fpW2R6R1111tsw34wC3VW9MRbFcnUDJY4vCdmkWihiq02I9wsCKT
 msAQBANzDidYvcu5Es1vZzDZhzmmLono1dmE6bPyW4uTUSZ+po5bfs8UE6R1WOe5grrz
 tnBhGTT39VUcK7Fb5zHKJNtNQh4DrdRDSxw8jDyhxLGCZljR1+pbx4DW877zmbZELcRL
 FUccWwcWHSe9zDAUbiNuJc+E/pPF/7xAxl0t5Os3vHunYJ+aRLFZFghA8EmYbCxYijmI
 iPexavEYgTzb7LdONSZNsYm7mb9qgXsgzLRTQrRtRzbz7X1SiJpDQjmKS5ha4bBh5kGU
 l/Yw==
X-Gm-Message-State: AOJu0YwWcJ8X6YXGHSmna41F8w2lzJ4kQSF5xs75AMOBt/wDYAQJligD
 WFg0izsYYFPqWlUwwu5YLwy5CJ7t2yDhwtN0xa3Qy/23im8HKvKYF4vmoA==
X-Gm-Gg: ASbGncuK0xTh90FpmjIMs6UGvRJC9oFj0FPKvegGec3RxAHMf/oOqKNCPM4jWa0jQTf
 iR/WxN/lbC5cnnsOqOT4BGsMBOsmIIVANWVOfjPRWS/ta9bQGpq1XPpznLBl36S2Cyrufa2Tcyc
 E3lldP+g5nKL7I9beu8o8Jx4swJ+UED8xOt1O+Sr5Ac/BeFXSycjJ1EZMUtB/BEC2JI/EAHic+8
 ak2bwdhMYhyckLuqGBVdK+NIVIvIVRzNLszTEjnbPglZlVyN5U1CICdgqZs/0eIEBRqyDdJwRxV
 sNh1TuprW+v3mMEws3cqkhtTIvEb62jrgomOhz7FKRnRjvra2Q9VFOZAUCQllx6FYf8=
X-Google-Smtp-Source: AGHT+IHmn9WqLjZk6CQiF9SNFNDQfc7fodnsbkLyX97g29j+zpXJXLw3h7UwsHJl+npgK8EPDc0K2w==
X-Received: by 2002:a05:620a:4102:b0:7c5:49e3:333f with SMTP id
 af79cd13be357-7c5ba1e890amr1451922985a.36.1742668676855; 
 Sat, 22 Mar 2025 11:37:56 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec688sm279895085a.64.2025.03.22.11.37.56
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:37:56 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: move X_GB_ADDR_CONFIG_GOLDEN in GFX7
Date: Sat, 22 Mar 2025 14:37:45 -0400
Message-ID: <20250322183746.86002-5-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
References: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[BONAIRE|HAWAII]_GB_ADDR_CONFIG_GOLDEN are only used by GFX7. So keep them
where they are needed.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cikd.h     | 3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cikd.h b/drivers/gpu/drm/amd/amdgpu/cikd.h
index 279288365940..8aca4f2734f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/cikd.h
+++ b/drivers/gpu/drm/amd/amdgpu/cikd.h
@@ -60,9 +60,6 @@
 #define AUD5_REGISTER_OFFSET                 (0x179d - 0x1780)
 #define AUD6_REGISTER_OFFSET                 (0x17a4 - 0x1780)
 
-#define BONAIRE_GB_ADDR_CONFIG_GOLDEN        0x12010001
-#define HAWAII_GB_ADDR_CONFIG_GOLDEN         0x12011003
-
 #define		PIPEID(x)					((x) << 0)
 #define		MEID(x)						((x) << 2)
 #define		VMID(x)						((x) << 4)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 824d5913103b..adc49c2036db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -55,6 +55,9 @@
 #define GFX7_NUM_GFX_RINGS     1
 #define GFX7_MEC_HPD_SIZE      2048
 
+#define BONAIRE_GB_ADDR_CONFIG_GOLDEN        0x12010001
+#define HAWAII_GB_ADDR_CONFIG_GOLDEN         0x12011003
+
 static void gfx_v7_0_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v7_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v7_0_set_gds_init(struct amdgpu_device *adev);
-- 
2.49.0

