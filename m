Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD55C4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 14:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE9722518
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 14:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE9722518
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923B689276;
	Tue, 15 Dec 2020 14:39:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E656E3D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 14:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608043128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CA11H/hjEhbgy7tnphG2KLHb+jmHcRmnL5DLgtJD9b0=;
 b=b63oyqd7QaY3yQgKcwW2EI36soaMuBTXy0Jwkrz/jW49VtzaD/mNucVxKye3trYNYoJ00n
 u+77mdT0pZiUYnyDtqOqfQw8r+DVMGBvS1JHok0SBGfVsPRub3DVXWFifZXIrO9I292wf8
 1oXkjZznTE5NcTj+g+99eGrSplRO3w4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-muzixvKIMQmgn57a2tffJw-1; Tue, 15 Dec 2020 09:38:45 -0500
X-MC-Unique: muzixvKIMQmgn57a2tffJw-1
Received: by mail-qt1-f198.google.com with SMTP id a11so13379999qto.16
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 06:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CA11H/hjEhbgy7tnphG2KLHb+jmHcRmnL5DLgtJD9b0=;
 b=DMICl50YGRnMJ36EOf1kjzRMGFW08zx0fbk3A7zrU+SeanHL4fBGsV9pRnrQO58sCh
 uYOzctME1XVS9pMAgvsDxwpzgK3RukT7IULH4j7anoe0mFVAb2MdSr8ksTbLbnEVZPRc
 t2PwR2rMTdpVHqxnn/gVbrGhxCNvv0V0gmK1wAOCTPBMXeVuPlhvN7OM8+pUYhSqjZqM
 Kw66E4Aq1iedeyW4NIbOSSVBk/rlLmCmm9osEU4hwLoEYk+GPdMPOd/TdDxo0OcFDdeS
 Ljck7lmKiW0mhvT0EE7BBCZut5IpMDmYKwuvb0j6wkjbUe97K36GWI6kRp1Q8eSgYbTW
 T7OA==
X-Gm-Message-State: AOAM532TeKebA6N9xTr0gdauxWnX5wHtmmlaD1umgwv2thfPVni42MMV
 /ogawZ1rkHwJ41GXgp6ZzZ9MdVmatE24pwVWbPSwfk32v8L2SccgYafqIY9TzWmoZmJXi/6vskh
 5OlwgVqe0yWMUIYU04Q+eBFdsyQ==
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr38380281qtv.56.1608043124635; 
 Tue, 15 Dec 2020 06:38:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzv/jCdfHqYOSQUF3qGweRu3h36fTJyA9ZrWvPOpg/YPfe7jHGmISC3hdRzS09ANHjuNAsAYg==
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr38380257qtv.56.1608043124444; 
 Tue, 15 Dec 2020 06:38:44 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id m10sm16456643qtg.52.2020.12.15.06.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Dec 2020 06:38:43 -0800 (PST)
From: trix@redhat.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, lee.jones@linaro.org, Felix.Kuehling@amd.com,
 nirmoy.das@amd.com, sonny.jiang@amd.com, xinhui.pan@amd.com,
 colin.king@canonical.com, James.Zhu@amd.com, leo.liu@amd.com,
 thong.thai@amd.com, vegopala@amd.com, boyuan.zhang@amd.com,
 Monk.Liu@amd.com, mh12gx2825@gmail.com
Subject: [PATCH] drm/amdgpu: remove h from printk format specifier
Date: Tue, 15 Dec 2020 06:38:35 -0800
Message-Id: <20201215143835.1874487-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Tue, 15 Dec 2020 14:39:44 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.
h should no longer be used in the format specifier for printk.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 7c5b60e53482..8b989670ed66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -240,7 +240,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 
 		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
 		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
-		DRM_INFO("Found UVD firmware Version: %hu.%hu Family ID: %hu\n",
+		DRM_INFO("Found UVD firmware Version: %u.%u Family ID: %u\n",
 			version_major, version_minor, family_id);
 
 		/*
@@ -267,7 +267,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 		dec_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
 		enc_minor = (le32_to_cpu(hdr->ucode_version) >> 24) & 0x3f;
 		enc_major = (le32_to_cpu(hdr->ucode_version) >> 30) & 0x3;
-		DRM_INFO("Found UVD firmware ENC: %hu.%hu DEC: .%hu Family ID: %hu\n",
+		DRM_INFO("Found UVD firmware ENC: %u.%u DEC: .%u Family ID: %u\n",
 			enc_major, enc_minor, dec_minor, family_id);
 
 		adev->uvd.max_handles = AMDGPU_MAX_UVD_HANDLES;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 4861f8ddc1b5..ea6a62f67e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -179,7 +179,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
 	version_major = (ucode_version >> 20) & 0xfff;
 	version_minor = (ucode_version >> 8) & 0xfff;
 	binary_id = ucode_version & 0xff;
-	DRM_INFO("Found VCE firmware Version: %hhd.%hhd Binary ID: %hhd\n",
+	DRM_INFO("Found VCE firmware Version: %d.%d Binary ID: %d\n",
 		version_major, version_minor, binary_id);
 	adev->vce.fw_version = ((version_major << 24) | (version_minor << 16) |
 				(binary_id << 8));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 1e756186e3f8..99b82f3c2617 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -181,7 +181,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		enc_major = fw_check;
 		dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
 		vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
-		DRM_INFO("Found VCN firmware Version ENC: %hu.%hu DEC: %hu VEP: %hu Revision: %hu\n",
+		DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
 			enc_major, enc_minor, dec_ver, vep, fw_rev);
 	} else {
 		unsigned int version_major, version_minor, family_id;
@@ -189,7 +189,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
 		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
 		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
-		DRM_INFO("Found VCN firmware Version: %hu.%hu Family ID: %hu\n",
+		DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u\n",
 			version_major, version_minor, family_id);
 	}
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
