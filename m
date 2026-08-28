Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D020C61DD7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 12:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A1810F371;
	Fri, 28 Aug 2026 12:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fG2AnTS0";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C0810F370
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 12:07:42 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso154129366b.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 05:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787918861; x=1788523661; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a3umpp61n4jkj/rYOy0LxiMasTwW+3As1Xud+0Swq94=;
 b=fG2AnTS0eyGlCabWFV6soqi8uTd4OnaoqQtBx6k5OwMbgnk2hMginSCY3eF4nKXyIZ
 n7pxlP5iv+6iEzHRWym1DymKo8oNgqwSvCAgyKXwBDcoy8tVZRhi6rlm+6WQMwmGLGrz
 vQ9fXVFBm8fu0TRy87Qvp7oF31TciN2g0dxP9k3rQdkNlVop/bAcrENRAYOK33ZnakI6
 RGWPGXWsAEA+Zpd4eVA2Hes6mE8mtP5FNaLgeKSYmQbpO6gJ0RN42cRopvJm2lYv2n+p
 iUTEFi9tmIZRfvr9NgwXTrjiJuTPQujKRaP8k8jZGeNyj5HjalNoSHecS/dH/UHhNm6f
 FRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787918861; x=1788523661;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a3umpp61n4jkj/rYOy0LxiMasTwW+3As1Xud+0Swq94=;
 b=K6Qbiz27BsqNguzEZDd86Pn++4Kn7lcg1uoRYmoAbhXs9ZIVCpfHFhk1soJID9qrpl
 ldbC/Wka9W/n7j8VOkK7OdGNf51kpyqjmuTElXPU9CWPMuf7e1rU0ull0PJ6cH3ELdwn
 yGOZoojCkyC0fw4iTPThw0nOzScOfxwbTfFl4u3Li9/4n04M70pSSGwB1PBBEGjrg/RP
 3rRL+53zqn+2KozaN5e+vM4QDm0RY089yaKUHu/dYtxcXOxvfdyZiZPLHoH5LFJmzrKG
 ejbZ+hKnTvKGYz2OP9P1t20g2XGhxrH+SXZaG7zl2NhBF3F4pJtzgvDaQg6YeaTzU2gu
 iC6w==
X-Gm-Message-State: AFuF++kRZziid3QwxEkD1PwrJmn1s1dVvMsCJinh/stuzY8z/t4Ahy8d
 Lyo6L37+cREhwjWzPuWFPXRFbJpGZkH+1y1DpwhTBXSPMgu8yWOSCs6DT9Qw3xUn
X-Gm-Gg: AR+sD13feKKQgIysSzQnBROKWbTgBOAfOsIndOea8rbMI/neP1oo0D7aFrGwocjoKqJ
 YWFW3IiLkUx37iz8q2oN8ZQa3dBO2ZWCmQiCsPjl3UHoyqZ/h/hUq5E7efwzzgB6lu7StOMxr4o
 xIP7Mci9WkvC0fKsYRtx+FHXe714opUQFH73jps6pwMjHZdM1B/0gT5LdmtKd6hLpjKk1Ub1JI6
 1BonlwTOrTFEBvWmX1LVvaBS/r1NjjxPf+Bmy4gdr47LqWZpt5/zrlTft621vbXvRRNKC+PN6CP
 Q2iUW5avY06o4rjVaT0C9CQVIO1VwLbEW+GVPov28qLdKpWPoX0pcY0m4o1cZ8SoZP+BTBH6qVd
 pqocrf1IxYd4RPNcMs3ZjLDkfA76/32ri03CFcpiMeTVXWykCzCC06vPezWRjY95W5J5g+bx2Rz
 lvwzq7y/gQ3Ch+unVqDi719b+DuzaE8zmot8GdNZkt48DYlMWlcErwKjKBwSV+vCIw8kBmTvD3F
 xPOGg3GfJT3iCVg19uq5QZO
X-Received: by 2002:a17:906:9fc7:b0:c20:ff26:336e with SMTP id
 a640c23a62f3a-c25570191c9mr444138566b.14.1787918860619; 
 Fri, 28 Aug 2026 05:07:40 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f29a9dfsm75364066b.63.2026.08.28.05.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:07:40 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/5] drm/amdgpu/sdma: In legacy queue reset function,
 check if KFD is initialized
Date: Fri, 28 Aug 2026 14:07:29 +0200
Message-ID: <20260828120729.25908-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828120729.25908-1-timur.kristof@gmail.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
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

Avoid calling amdgpu_amdkfd_suspend() and amdgpu_amdkfd_resume()
when the KFD device is not initialized.

This allows the function to be used on GPUs where KFD is
not supported or the support is hidden behind an experimental
flag, such as CIK, in the future.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 9eebd8380834..8798caed1ff1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -664,9 +664,14 @@ int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	amdgpu_amdkfd_suspend(adev, true);
+	if (adev->kfd.dev)
+		amdgpu_amdkfd_suspend(adev, true);
+
 	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
-	amdgpu_amdkfd_resume(adev, true);
+
+	if (adev->kfd.dev)
+		amdgpu_amdkfd_resume(adev, true);
+
 	if (r)
 		return r;
 
-- 
2.55.0

