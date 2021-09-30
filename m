Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F610C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 20:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F0761994
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 20:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33F0761994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB87F6EC6B;
	Thu, 30 Sep 2021 20:35:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3356C6EC69
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 20:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633034113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ddey/K9wpIxOBXbjiNaGsj4E/caV13pJbiNDITnKjiA=;
 b=OGkUGz1BH4npy+fxrMPgR1uAiOSbRzbxXTWQaktqXLwHuNi7zzYmkpRoLZ/c5ZlVY0ULNV
 l2W1kVckOFwNK5MZuz6EQfzneQewBqAV3na2iSXQaQhI07WtzQLt/p8AyzT8QNCvew94eV
 E4zz1TGF721Jjrchd3lGFa6v22IH8Lg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-XbhJ1h4yMvSZF5uD4tiiAg-1; Thu, 30 Sep 2021 16:35:10 -0400
X-MC-Unique: XbhJ1h4yMvSZF5uD4tiiAg-1
Received: by mail-oo1-f69.google.com with SMTP id
 o8-20020a4aabc8000000b002b601d1fb33so4892232oon.23
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 13:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ddey/K9wpIxOBXbjiNaGsj4E/caV13pJbiNDITnKjiA=;
 b=LUVquIq4/SoCQQfA/qV4ePYSe7K7xpibBGX74bht6pdpyHFV49VUQ9LXywIFX2Gy69
 VnxJnTuK4X6iUUtwkaIBCmJTc23pwHLPF8k+CYFnAUON6pADDxIWG2KrFbBMDMu20cUM
 JLpqnfoe9Bl8jM/UvgE9wgVQEiZx+BR2Hbsv7+jyfUx0Sa3JFziHHnzKD9AI8eVLVmvu
 k0QR8aDYpa5WjP/aNYFwLyS/ecnPVtZ3RduP/jpWuHAoTJ+z8sNmh+U/XlWMfOxC9LiC
 VutFsg+pJDw+cbtnDtv0qIgMbAshgsq3zCkVUwzHhX/SJFjLlwdYeIpMkqE6YMOLLUVs
 CTWg==
X-Gm-Message-State: AOAM533fTtC0W+PSHJTGV7TmdtHI5Wi0Y2DXB/irKjWiS0nWdqYwQaCM
 hcdcC5niZlQvFlLk/R8TkKNSxvvK4Hj4ZlqSvSPn51s0dZ7rKx1cLNTjQYNMuP2xQESTKpC7rfY
 5jnMuWkn2YRCaCPRGl+FiTPIqsg==
X-Received: by 2002:a9d:eac:: with SMTP id 41mr6915147otj.38.1633034108767;
 Thu, 30 Sep 2021 13:35:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHDY1UmnahWM3r/K2pa4cUoccqfVEBvB3ig9Y7Mb2SIBYYFlvI2J1A9NKArgCzNIpdaObCPg==
X-Received: by 2002:a9d:eac:: with SMTP id 41mr6915131otj.38.1633034108556;
 Thu, 30 Sep 2021 13:35:08 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id a23sm769273otp.44.2021.09.30.13.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 13:35:07 -0700 (PDT)
From: trix@redhat.com
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdkfd: match the signatures of the real and stub
 kgd2kfd_probe()
Date: Thu, 30 Sep 2021 13:34:58 -0700
Message-Id: <20210930203458.441556-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Sep 2021 20:35:39 +0000
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

From: Tom Rix <trix@redhat.com>

When CONFIG_HSA_AMD=n this there is this error
amdgpu_amdkfd.c:75:56: error: incompatible type for
  argument 2 of ‘kgd2kfd_probe’
   75 |  adev->kfd.dev = kgd2kfd_probe((struct kgd_dev *)adev, vf);

amdgpu_amdkfd.h:349:17: note: declared here
  349 | struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
  struct pci_dev *pdev,

The signature of the stub kgd2kfd_probe() does not match the real one.
So change the stub to match.

Fixes: 920f37e6a3fc ("drm/amdkfd: clean up parameters in kgd2kfd_probe")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 38d883dffc20..69de31754907 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -346,8 +346,7 @@ static inline void kgd2kfd_exit(void)
 }
 
 static inline
-struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev,
-					unsigned int asic_type, bool vf)
+struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
 {
 	return NULL;
 }
-- 
2.26.3

