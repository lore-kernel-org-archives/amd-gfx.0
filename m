Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74D7C35FF9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED0510E2F1;
	Mon, 17 Mar 2025 06:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GQeN3Ynw";
	dkim-atps=neutral
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1773610E2DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:29 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-476a57a9379so15997271cf.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191644; x=1742796444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lsIo/ww6dQr3ZzJn+/76utSv6PhJ7u4CPLB+kqNpkLQ=;
 b=GQeN3YnwCFTcxzljFKxVKHtkNr/JoxGiD5ernzJoTofP8uHApbWU/TAZ2Onen76sq9
 1KB1lbTSHMG0ItXT4kflez2VSLwiPMnM0updDBtuQFw0dfyZCdmzaCr81sjW/2qnRVGr
 ZlGIobAt4Vy5S2etw8l5O0YmalDcq/3VrSkDMUqTVOl43IT/RYz8S43LT+dYsFF4/DoS
 hitR5jWIMaukWe40JkNcjZeE9DM6QxolS6liQmIxkdH/Ytf+bUq8IVvYDhHFTAS1ceEA
 krzdungEdjVl9iq0wycG+KDl04iIYp1bfLjfX7Re8Os2QC1SuW5HEGoDD64VbKBO/Rmu
 XfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191644; x=1742796444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lsIo/ww6dQr3ZzJn+/76utSv6PhJ7u4CPLB+kqNpkLQ=;
 b=ACZfyhp9YpePjQjIoCgioHCUVMjOhqOnVRUl3lsK497siWPqt6NBxgiiHZhv2a1/Kq
 hRdcBGK/vlqx1APlrGpesZc+2SbyDNaFJ3hbIF9fycAA/M4XbhOhhdseeb1Ikyv61M+I
 P+x9V+HxKXg85VJyOfnlTiLxUA/nVPJ1LHW35ENrN8gpXEddeWRkDZwXoFGDUF3PdSe7
 SepJ3K6AmZgsUKde3RLoLoiyZfUJ6+ogdMGeTd1ATu+tjD47M2YNuy/gumFPriLctTNo
 UVNXLaw+Kj6H2cbvRPHjafPUqKyDc1GpNvTMbn6qvYJaX2WpFOo6qB3KsGiaCFLN0R35
 /L0w==
X-Gm-Message-State: AOJu0YxK+F1lfpAn8Jb/KGb076MgU7fE/mQKPkF/KqGIL6NkieOui8kW
 45sUvKe8ySNE3/S3Gx5BmixKzF2K+CJlZdKfXoR7FSy7NKlfE+q+a7Reiw==
X-Gm-Gg: ASbGncsG4abClrA+P8rqfQM5ytSfYJXWMEPf0+1lKfYgs1H2EL6EAvz12JCpwvotojv
 7+BO5suHdbugT/dxK4/rOen07d9zadtlLGsQsRvV3C7tCyRZXyBoZWmE2hScVmINXDSwsFlV1gE
 cZze15fOu2q9OrloMNKhfZteSeIdLFKVQcg8WQrOrbGukhop8MurVVJUNMlBfCdgdyYZNM9qjkJ
 W/XrFnFu5CgwPIfxZAGX6WJP/x9NeygjfLOzTcATa+4g/NquE8pLUGhu+JVKZsJcchIfz/wF1BV
 C45sH1W6oFkVlKEwXAeKTxfsCyWhln6Qbl+MO6Mow77uCfyRmJ3oNhUG5QVF7chfLlVmbtZHdIB
 tFQ==
X-Google-Smtp-Source: AGHT+IEt4HgzEunHezRFJKvbLroJusjH8H3qjt79mBRWnf8zTYJREziBVKRje62cJteZctRuvLBe/w==
X-Received: by 2002:a05:622a:38b:b0:476:87f6:3ce4 with SMTP id
 d75a77b69052e-476c81c3327mr201671931cf.39.1742191644007; 
 Sun, 16 Mar 2025 23:07:24 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.23
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:23 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/18] drm/amdgpu: move GFX6 defines into gfx_v6_0.c
Date: Mon, 17 Mar 2025 02:06:45 -0400
Message-ID: <20250317060702.5297-2-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
References: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
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

Send a few GFX6 defines where it's used in GFX6.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/si_enums.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 4476fb816659..5f85c3b63971 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -53,6 +53,9 @@
 #define VERDE_GB_ADDR_CONFIG_GOLDEN         0x12010002
 #define HAINAN_GB_ADDR_CONFIG_GOLDEN        0x02010001
 
+#define GFX6_NUM_GFX_RINGS     1
+#define GFX6_NUM_COMPUTE_RINGS 2
+
 static void gfx_v6_0_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v6_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v6_0_get_cu_info(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/amd/amdgpu/si_enums.h
index d656ef1fa6e1..b44a32bacd5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
+++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
@@ -148,8 +148,6 @@
 #define WAIT_REG_MEM_FUNCTION(x)                ((x) << 0)
 #define WAIT_REG_MEM_ENGINE(x)                  ((x) << 8)
 
-#define GFX6_NUM_GFX_RINGS     1
-#define GFX6_NUM_COMPUTE_RINGS 2
 #define RLC_SAVE_AND_RESTORE_STARTING_OFFSET 0x90
 #define RLC_CLEAR_STATE_DESCRIPTOR_OFFSET    0x3D
 
-- 
2.48.1

