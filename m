Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA4DCCF9F2
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 22:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC6810E680;
	Tue, 28 Oct 2025 22:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="exYSeZFE";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C6310E67E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 22:06:45 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-63e076e24f2so4387239a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761689203; x=1762294003; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tGrJ6j/w9JB4KdsKNkwkhZPKRA7XysrPZ/9yFKGiBzk=;
 b=exYSeZFE5ZLymNWxYqxGx1mmgE/Pa7o72e8V75fOuAAztXQQGaO4Yy49ArttzuvDh8
 Y+LyXy6z30hWpcqX5YlRmeL+23jkfY2fuhqOZ5d3NfrEMLiarYi6w2dlpw2yhPbEWxK8
 EcSCYqaHaZich9+xU217J/GJBsLx9qKnVz/p1seVhoKLaJpL9s1xOkfRqdJvimEU+jxM
 H12/fwCUI0y2toXkWRPRtkH/j2fQzaXkQQ6b7PQEEoQacol6y8kyE5X3npdWz7HnSjXx
 soEKaPfXc/0/IqL6dIzK0G/J3M+A2/ZvXZN1VAESwpyaWfUepc3wY7PF0uyvqlQfDaEB
 7lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689203; x=1762294003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGrJ6j/w9JB4KdsKNkwkhZPKRA7XysrPZ/9yFKGiBzk=;
 b=fKElpoHCL2u6WSrDNsKyXAmPTd4gj+625K/vuoPdOZTIcpkthrx8KQEgor6Q3Hh+9I
 0JEniiCk+egVK6NEC9yKkE0YwtQeN42vdN13MaAaf+y9qLwrzuNbsQlwx3EFEUO1CpjE
 dq9oWPMXaBUCkyvLT1EbRwjGOlesJ7qMCQwckGHKUZLDbKjuChKpXRD1pb0O49Cno/R5
 +LQ6mrVw2LffL12bRSqtq6hbiS2oFZ6k0KM6q2GcaKhAlGio3Jb5GHj8vqnMy/8lnHuQ
 zXpx2kn5F9XZiRP/k6bfSLhoNCOHlP621WU2h7thH6bxtt6tLLjVWFxa5/ROJ2m+sEG6
 t3Lg==
X-Gm-Message-State: AOJu0YwZM5F+a4oucbBIM76NnzSzB68zSXu6xfUlUgbKC7v5ZK4wmEjE
 p+f36JQfQURlSPTlNUp5sjc/LkI9aHtALAnG2V9vCgRjaTNeEmC6LtKgR3aTMw==
X-Gm-Gg: ASbGncuOqYzobkTqRezH5hTsajaKKEls9pcyj0mngIPZPO3vFTM14a0D1MkC+OUdvlW
 9igHz4hE0eWqlWkH3QsZQ6taZMgQxtAdjuy6weeXQYmMpvqTuaqTAKBIbY1jht8qXz3RWJSxLv2
 QCTBbi/8JyVTRyEl452+YxmWaG85W1FzKoqhd7uzSI4fgBcJtrlQAw8gZTr0nubTD0nBsnzGXMI
 TppPPHqdjSR5Jf9ojfhWbqNc8hgsziZGlKCpgQGHPoDWbK7Ed/4VTrg+TvGv6ywMB4tvIMRuGlm
 oTQG2nDK0seP0gDBSi2McsT5tJWjK9xC3dHcirtpKZhn+w9SNrXJABIabiApSfuCQXA8e+0aZch
 8wkO4jq0GKTnZPQgt9JXFWF4AozU0zG3c+8Ce3CmpM1LqJmjFVNDiyJR2D2NiO5LC/HnSpI4eJw
 XMRdMl0Qi9HfCsgiEY0N5b1Gm7VW9LyMPl1Gzjtcq1r4I/fC9Ms/fc1yNBFNAx2eYtIWTsdOcrH
 aCoBuJh
X-Google-Smtp-Source: AGHT+IFQo8/UxIbAqBj2qJOHO651iCe8TqtScgdAFUiRChXNkuMdl/sk46eBA9wfxgj5eaRdYgxDag==
X-Received: by 2002:a05:6402:350e:b0:63a:35c:6ebc with SMTP id
 4fb4d7f45d1cf-64044251725mr488401a12.23.1761689203454; 
 Tue, 28 Oct 2025 15:06:43 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24CBF70057E8101A3AD09709.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:57e8:101a:3ad0:9709])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640342e5acesm1881182a12.28.2025.10.28.15.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:06:42 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 05/14] drm/amdgpu/vce: Clear VCPU BO before copying firmware
 to it
Date: Tue, 28 Oct 2025 23:06:19 +0100
Message-ID: <20251028220628.8371-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028220628.8371-1-timur.kristof@gmail.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
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

The VCPU BO doesn't only contain the VCE firmware but also other
ranges that the VCE uses for its stack and data. Let's initialize
this to zero to avoid having garbage in the VCPU BO.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index b9060bcd4806..eaa06dbef5c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -310,6 +310,7 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
 	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		memset32(cpu_addr, 0, amdgpu_bo_size(adev->vce.vcpu_bo) / 4);
 		memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
 			    adev->vce.fw->size - offset);
 		drm_dev_exit(idx);
-- 
2.51.0

