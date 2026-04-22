Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A34F9B5E3
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 08:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F3310E984;
	Wed, 22 Apr 2026 08:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="bdFQKL01";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F294210E947
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 00:40:18 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1279eced0b9so7052979c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1776818418; x=1777423218; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1/I+pZwMOrzhrEepnB/LVQxD8E3WFxc/6DwgKc4sW9c=;
 b=bdFQKL01JcTq1M/RviuyOHHIj/oQgo6MBPvQVYT7GU64h5430Ugpqm4gKdGmLI4itw
 /iRFzl1Zq3zSf4BNKEn6HzhoImMgCH0+za7fmRvwWcld6CK5whY7SQc0DdgqrukbJwuk
 7SJABbh0UTUKiv0MAF/rBxeDCVxhr3iYZT9O6qyOdpRQHIfJV4gug40ZC9WUXmIgCUqr
 vkAQholQnxaPp0jiQCatoRuu16SG6DT6QOUPyDpBEgCEMwzjVl+MBNuY/LcqvV6pUynZ
 39j+P4PEu2HNKNS/Ki4sonU07iOwBswmM31A5CvctN6yLEEebUoT1oayFnApuu6nBS3y
 PmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776818418; x=1777423218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/I+pZwMOrzhrEepnB/LVQxD8E3WFxc/6DwgKc4sW9c=;
 b=n367Ls0lJONIHj2rgwGvvxRI12r2RfeoohEwumZGY0Pe/ZWu9QrPHqG7hBX/4aKw1d
 rTKirZjihb4ZKokibXaAa4oFUIAa5urnRddXrs83ZYwWEn+zjJGR9hk6oIwjIVaL8lbj
 HcI6zSzt7N064dV3ttTH6kYIyTXB2LBC+YavrKHPoOuDkJWqlKsSECrDK0L4qqfdejqb
 qE3mutboMh2cqVr691PHPqymPjILoBzeXo+Yih0YlqWSLRuyIswlB0kDSZxKfSnBWqNR
 hv371xLLSJ7yTeTKF1mneS1MlQtBNOMW30X/Y6u9S3M4LG2jBBIDxAUBlyp1gr/PlWZD
 lf6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Zh0vk3olVFqEcVIPuD7BsLKM3RDxEeEr2IJJe5HJYDDJ2enjOC0ZyVjaQflQzfYFar940EY4I@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4GJdNicLMVBQwXuhlE96HME1l2ykW70ashpNl78VdRAnWfvQi
 y4dl+DKQpeYjVbWTvRanbIaEN80IDXY0wRr5n6W+2Gae+VR5m2+Jf3jmLldHFcMEKhg=
X-Gm-Gg: AeBDies3xHcuhm3yXyE9a0NLIDUT/aMlsywe82xtfyH6qg13a303V/3Ph1Q2vx65lLo
 gcatKB7FHuDXkVmMcFR+tF5fw6AZSLBod3HiXBFSbM4fcFh+FBxRqapxpFVLtNGY6k1SJg6jEHR
 3KGM5Yd01CsYm4ujbcW5qfV3g9Z3iz7AjmPkwqyfqHwBpGd3v4qeT6PHOPLLlzdMV4X3FrHyWqn
 wStyqgLObydkrmQ4+RTt1uv0w/UdyRqUkz5fPvvF4K8ySaYdTpOwO1oaSsTcardGg7iYGntRrM5
 9ejIMoCuJ1/89s09xYOaVY9S2q04YlLw4oedauR5PptcsnWA3mD3qJuLf9WGrkol+0PAXrFkNk2
 FaL02vs19KwYReSCeM05YP6tg759Lwbn0Dby0jqj0BmUo/m9IvotvHcVNCGJKg2Xsl7qTKVlP+i
 A4+XK/G61L3xhXF/r0wE/BvDgGxzm7CG9FQOTtskf9b1JP7Y1dy2OuD4QfPzf8MBfU1BwP6eyS+
 95d5X/qu6sMWMVqHnoGvh+Sfvaf+g==
X-Received: by 2002:a05:7022:6606:b0:128:bae0:e044 with SMTP id
 a92af1059eb24-12c73fc621dmr10332983c88.30.1776818417739; 
 Tue, 21 Apr 2026 17:40:17 -0700 (PDT)
Received: from voyager.. ([191.251.25.148]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12dbaab165bsm552462c88.6.2026.04.21.17.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 17:40:17 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 simona@ffwll.ch
Cc: luiz.f.f.fernandes@usp.br, Tiago Dourado <tiagodourado@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] drm/amdgpu/jpeg: deduplicate process_interrupt across
 JPEG versions
Date: Tue, 21 Apr 2026 21:38:43 -0300
Message-ID: <20260422003911.33841-1-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 08:27:32 +0000
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

The JPEG versions v3_0 and v5_3_0 have process_interrupt implementations identical to their predecessor versions (v2_0, v5_0_0 respectively). This patchset removes these duplicates by exporting the original functions and reusing them via macro aliases.

Tiago Dourado (2):
  drm/amdgpu/jpeg: deduplicate jpeg_v3_0 process_interrupt
  drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0 process_interrupt

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 21 ++-------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 22 +++-------------------
 6 files changed, 15 insertions(+), 40 deletions(-)

-- 
2.43.0

