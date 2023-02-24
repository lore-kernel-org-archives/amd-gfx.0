Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832D7C6FA8E
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 17:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B536F10EC96;
	Fri, 24 Feb 2023 17:12:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B93C89EFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677257125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=13svcAbhKsbNR6lcnWL8PecfM86J5HXpB/wTf6k/HJg=;
 b=f+DR6jFhaf67jhNig1RYv+Bq/sbFKD/Chy8vdUgbfD0y3DB+uoKs5KlqbFpwp6gjsc/g2T
 Jqe6mW6IOtzyj69UGag6+RJvEFNGMMhqgaIVbFw8qrOBDN8Qd4sA/l0ckwL4HG83DuxTG3
 JaObMBOrDiPeg7xGpXnAXRo3j5DrBms=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-253-rPf-epRBN_KR_rr-jlO2bg-1; Fri, 24 Feb 2023 11:45:24 -0500
X-MC-Unique: rPf-epRBN_KR_rr-jlO2bg-1
Received: by mail-qv1-f72.google.com with SMTP id
 ef20-20020a0562140a7400b004c72d0e92bcso7148329qvb.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 08:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=13svcAbhKsbNR6lcnWL8PecfM86J5HXpB/wTf6k/HJg=;
 b=FNJxrFdrd5gYvg+LJH2zSidAWMFv6jq6fgNW0O4LRRvlkBwOoG6/TOwjowKCk0I4Mc
 i3DSQDDeI6NXe6jcq9qT5mCtE6zWUoF4y/R3qU2eUs3uBnYW3bT8fi4+cZVDPrOZQy/5
 biiYhI8IZLenZQhLSS/I+w/i8lJqhqRwYjsbpJmzADsn/XtBoFyZNmGRdRogpgv8fGop
 DqTPnRpo2a/G/5UBo5/4M7wZQG3oOf+u+qX61d7sRhSLq7tMbxW1IJNdfc6IFuhCQC/7
 m2cekPguMszWIq71urJuu9La2aPi1tutTwBPRzGxuMtA1VBRuhJRUWPxV4WB2fCL8Iw9
 zV9A==
X-Gm-Message-State: AO0yUKXc0F8rXzBCgbzLSLwujTNp4Tak/VsDazljkqHxzFHATf11H7Fh
 kNDS52uHETQkSygb6ML1YwXlHY0t+MY1QAzdYiEoLLDwU2tZa+UF8Le8B4Ho+D6kxGrxV9u+m4j
 eTj7Z/M8dQFdn8tqXTAtf+ZDGsA==
X-Received: by 2002:ac8:5744:0:b0:3bd:dfe:9c1d with SMTP id
 4-20020ac85744000000b003bd0dfe9c1dmr24611376qtx.59.1677257123552; 
 Fri, 24 Feb 2023 08:45:23 -0800 (PST)
X-Google-Smtp-Source: AK7set9ab3tb8sJ9dHB9BnRpA5KhvlL1jf3eeYsfFKZ/ZRG9txC27LuVJrseS7PPvfb60RIOXh+Tbw==
X-Received: by 2002:ac8:5744:0:b0:3bd:dfe:9c1d with SMTP id
 4-20020ac85744000000b003bd0dfe9c1dmr24611334qtx.59.1677257123231; 
 Fri, 24 Feb 2023 08:45:23 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 oq21-20020a05620a611500b0074235fc7a69sm5506113qkn.68.2023.02.24.08.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Feb 2023 08:45:22 -0800 (PST)
From: Tom Rix <trix@redhat.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, ruijing.dong@amd.com,
 Jane.Jian@amd.com, James.Zhu@amd.com, tao.zhou1@amd.com,
 sonny.jiang@amd.com, leo.liu@amd.com
Subject: [PATCH] drm/amdgpu: remove unused variable ring
Date: Fri, 24 Feb 2023 11:45:19 -0500
Message-Id: <20230224164519.2757173-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Feb 2023 17:12:51 +0000
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

building with gcc and W=1 reports
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:81:29: error: variable
  ‘ring’ set but not used [-Werror=unused-but-set-variable]
   81 |         struct amdgpu_ring *ring;
      |                             ^~~~

ring is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 213b43670f23..023a1fffa6a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -78,12 +78,10 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ring *ring;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.harvest_config = VCN_HARVEST_MMSCH;
 		for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			ring = &adev->vcn.inst[i].ring_enc[0];
 			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
 				adev->vcn.harvest_config |= 1 << i;
 				dev_info(adev->dev, "VCN%d is disabled by hypervisor\n", i);
-- 
2.27.0

