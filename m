Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A85BC77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 20:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6AF010E754;
	Thu, 25 May 2023 20:14:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAAE610E74D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 20:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685045286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pscghevf+cSG52ERcGqww4er3grbyjpAV659C+ZtVu8=;
 b=gE/rmQNpXCCI1AaFsdeJ78LLbKKkzwW2JkctckNwUaUbOWkVsNDRnt+ep8Vf0U1uIPJnOy
 UQbVht/FH1vA1eRsSyRYqLqD0oecJCoteHrEiHoTO+Xe4vT1OOoDzYlBEzWYGEttllOFIC
 SkM8c559yzwYfIl2Qln0f5yF6xb91Qo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-VaOvet4uPT6NK3fXOxNnrA-1; Thu, 25 May 2023 16:08:03 -0400
X-MC-Unique: VaOvet4uPT6NK3fXOxNnrA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-626047242b9so329466d6.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 13:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685045282; x=1687637282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pscghevf+cSG52ERcGqww4er3grbyjpAV659C+ZtVu8=;
 b=VDDrFX2PAQUOj2ztQ1TEzyP0pS7BVgocU2bS/OkytKtX4HZw9326j1BLjT3pcERaI+
 8hVWTpYe2bFxwByiVVc/Kwx1upFLVwxv9O/RuKiPG+Sl/zbv6ugqmbIwtY7EdS4jenOF
 F8zcEyK3U9JmKaA31RXERXHNe6qzOzQYGZZD3aqa9/8FNnpoOUiTsWRU/+4BEfUkkw9a
 E3kbeeCBL2XmIiY4QDkx+TBjsxw4kySH+DIEk+CtL+urw3BJSQViQLarWXeLcyN90w1v
 XLjTIISYN7ykVBnO4o/fOLbQS/J5cVUbqBB61brgmT814g65LErYjmP2x9JXKPlpI9SP
 INIg==
X-Gm-Message-State: AC+VfDyAxCf0J0yKSrngzOEJXD4gjbQX6Ie7VK0/UflwwXAw0PSw4KNz
 4OQNvQK8x5u66s+hcWHbxVqjMRhH0jfr5kINoe1uDndNRscFXINwGmN/nGHSE9epIRWzFXNhA+K
 RbE/b9O/r28z5ok/woOQZ/aHP2A==
X-Received: by 2002:ad4:5cce:0:b0:625:aa48:def6 with SMTP id
 iu14-20020ad45cce000000b00625aa48def6mr2958789qvb.54.1685045282645; 
 Thu, 25 May 2023 13:08:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LtC1076E/oGoBe45eqDKHdSLnAL80iwqLeHY19bYNAJnnZix57WmgzgioKtImTkWVm13Drg==
X-Received: by 2002:ad4:5cce:0:b0:625:aa48:def6 with SMTP id
 iu14-20020ad45cce000000b00625aa48def6mr2958758qvb.54.1685045282407; 
 Thu, 25 May 2023 13:08:02 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 lw1-20020a05621457c100b005ef81cc63ccsm649736qvb.117.2023.05.25.13.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 13:08:01 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com
Subject: [PATCH] drm/amdkfd: remove unused function
 get_reserved_sdma_queues_bitmap
Date: Thu, 25 May 2023 16:07:59 -0400
Message-Id: <20230525200759.3214525-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Thu, 25 May 2023 20:14:24 +0000
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
Cc: Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

clang with W=1 reports
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:122:24: error:
  unused function 'get_reserved_sdma_queues_bitmap' [-Werror,-Wunused-function]
static inline uint64_t get_reserved_sdma_queues_bitmap(struct device_queue_manager *dqm)
                       ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 493b4b66f180..2fbd0a96424f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -119,11 +119,6 @@ unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm)
 		dqm->dev->kfd->device_info.num_sdma_queues_per_engine;
 }
 
-static inline uint64_t get_reserved_sdma_queues_bitmap(struct device_queue_manager *dqm)
-{
-	return dqm->dev->kfd->device_info.reserved_sdma_queues_bitmap;
-}
-
 static void init_sdma_bitmaps(struct device_queue_manager *dqm)
 {
 	bitmap_zero(dqm->sdma_bitmap, KFD_MAX_SDMA_QUEUES);
-- 
2.27.0

