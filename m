Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B5FC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 10:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98C510E8EA;
	Mon, 24 Jan 2022 10:25:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 774EC10ED48
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Jan 2022 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642862163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iMoDmTVNmITbklh5q/t/44BNAz/LykE1HqAeIjzQA3M=;
 b=UcZ9WG5bzT1mlTVD9rdm4nitoM4UQze+g5SXLcSbg3xiIXZn9aBuhe5sK5nYToce33+oVy
 AlVzL2d7Ki1Kn8H5kYNFi66dUNEUuLvTTR6D550G3+RdtLS3xtpTTa2sK69iQ6hAzUZWj4
 VsceuPaifXhRug5M8WeFtferYwMSCm4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-MX64WE7FN7CgERtKpREjMA-1; Sat, 22 Jan 2022 09:36:02 -0500
X-MC-Unique: MX64WE7FN7CgERtKpREjMA-1
Received: by mail-oo1-f70.google.com with SMTP id
 a7-20020a4ad5c7000000b002dacfc3d40cso3671581oot.9
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Jan 2022 06:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iMoDmTVNmITbklh5q/t/44BNAz/LykE1HqAeIjzQA3M=;
 b=jWgw+pWdba68r9kf6Cw+n0BK0nbFc4/kGKPb+yMd5TjZMECsAubw9oTVUMZmCtLzU1
 BBpblaVRyZzfK568c7KFMobPx44fesLBo7iw24uTW7x7U19EqDd0okp8tdSU+Y/H5jad
 U1V3SVglDsLEBTXhbHJQqzuC++BU7F1OGKH1uPKBYcDgDkzd4V+8V7+Vd7QbNuba+T9A
 Ckh+vJW9k1YcGtOzKT3oyknMurJ6TnLsQruAYA66iBWY50rqeqWtfLYtbYQez1zG/Kby
 wEPb01PF9u5Z+vO9b1SQHF59Dpk1/fnejrpAT6zfN4jalDVl2hTByOT3PldzoqWtUZyZ
 3znw==
X-Gm-Message-State: AOAM530OKVNPTnFR33rp7xpCLEX6UCt7MUeyJiUn3AC+8iKVNX57Q3IW
 T/+8t5xNDiWZ28hlvQWZqDqFagyeGX4Mek5bp4v3A6RDaynE+Ba91McqurT7/14/X/eAEajfh8h
 yw8Nx9Ut+YKPrh7Ahj6xNlhLMzQ==
X-Received: by 2002:a05:6830:25d0:: with SMTP id
 d16mr6221820otu.362.1642862158913; 
 Sat, 22 Jan 2022 06:35:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgc0T99YhICS47P7DM3QV6ViRHJuBhuoL3AAcXMdbyPUZZgVBeGsTVqm4QwhQs0NqYaB+Bjg==
X-Received: by 2002:a05:6830:25d0:: with SMTP id
 d16mr6221798otu.362.1642862158724; 
 Sat, 22 Jan 2022 06:35:58 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com.
 [24.205.208.113])
 by smtp.gmail.com with ESMTPSA id w13sm2943114oik.52.2022.01.22.06.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jan 2022 06:35:58 -0800 (PST)
From: trix@redhat.com
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch
Subject: [PATCH] drm/amdkfd: simplify else if to else check of
 MIGRATION_COPY_DIR
Date: Sat, 22 Jan 2022 06:35:49 -0800
Message-Id: <20220122143549.914925-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-Mailman-Approved-At: Mon, 24 Jan 2022 10:25:01 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

The enum MIGRATION_COPY_DIR type has 2 values.  So
the else-if can be converted to an else.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index d986f9ee0e1f4..c06c44f37b00e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -146,7 +146,8 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
 			gart_s = svm_migrate_direct_mapping_addr(adev, *vram);
 			r = svm_migrate_gart_map(ring, size, sys, &gart_d, 0);
 
-		} else if (direction == FROM_RAM_TO_VRAM) {
+		} else {
+			/* direction == FROM_RAM_TO_VRAM */
 			r = svm_migrate_gart_map(ring, size, sys, &gart_s,
 						 KFD_IOCTL_SVM_FLAG_GPU_RO);
 			gart_d = svm_migrate_direct_mapping_addr(adev, *vram);
-- 
2.26.3

