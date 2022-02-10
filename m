Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A291C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 17:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A793810E8A8;
	Thu, 10 Feb 2022 17:08:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C084F10E8A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644512666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yfg+rvc8vcVuTj7+GQ4UV9mGgjoAYvtiDa4kYWoYjJ8=;
 b=G3fqw+Qjwq5bAv7gnCTPpQFACnMI4woKwNIof5qBGgaDnKVdm26ZF0UDiohTBY1hBAD1rg
 4MTMtwNWc/KRQ2rTE85CEk/VoJrQsxZgqbX/qq3KNiayXADaXS0365PBOAzUoi+4hT5ACz
 LKefstpEc/xmct1CjACuc0w01N+YvWM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-S59ewgXIO-WB8HMyMZs7Ig-1; Thu, 10 Feb 2022 12:04:25 -0500
X-MC-Unique: S59ewgXIO-WB8HMyMZs7Ig-1
Received: by mail-qk1-f200.google.com with SMTP id
 de36-20020a05620a372400b00508b2c3063eso3992813qkb.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 09:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yfg+rvc8vcVuTj7+GQ4UV9mGgjoAYvtiDa4kYWoYjJ8=;
 b=dPLjuIe+UJwFjeLDzV8/JOFujT0S78xmZ5L6Cq/dh7UdemTUQJi5Z+NqtRqHFiAsjs
 MANr25VcDuZpR4A9njwqjQ3JN+UsMMHEFQpgSXI2wwujjF2oonLlCP9AF+huuPKwOlrj
 OL2OTRNxN8xQLN59oaCjDRLH82p3bzLYiDXM2aiZMvEsX32+cDndvBy4jtdNCNwo0FQN
 XWtmkaItEqwjUgdT5vfFg1Ak0gfwOcVwkRDtdldhv1dgmu4vo6kDtlLd4fG62jnbCSqE
 vvzcTXWBIBOutvo9X5vY2eYI1F3MZgC56E1RLekLTOBXZVXbCX2T928qpZIrygsSG08w
 upkA==
X-Gm-Message-State: AOAM532tzUjJWj4OTq4J/+KyhzeKCmCyoZrB/xLi4BScWSxCX4uhPaXx
 2YoXsCdCBPcOJ0Csz/WDbO3MIbKZ/2wRyfI4EC0TV/SlAU7RlFqaYQYHdX7rQKs7L0/2ZD8XeEX
 HRIXG8cscXpAdAW0NJmr3LqnY1Q==
X-Received: by 2002:a05:622a:488:: with SMTP id
 p8mr5619803qtx.97.1644512664829; 
 Thu, 10 Feb 2022 09:04:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6fO5DYKXU/juk8kup+dK1EWIDMNgxbwD2+eVcMOxOQtX4NtPMxUE/mv2fPNsQDd1zWg2wfQ==
X-Received: by 2002:a05:622a:488:: with SMTP id
 p8mr5619768qtx.97.1644512664592; 
 Thu, 10 Feb 2022 09:04:24 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com.
 [24.205.208.113])
 by smtp.gmail.com with ESMTPSA id j11sm11156880qtj.74.2022.02.10.09.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Feb 2022 09:04:24 -0800 (PST)
From: trix@redhat.com
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
 rajneesh.bhardwaj@amd.com, david.yatsin@amd.com
Subject: [PATCH] drm/amdkfd: fix loop error handling
Date: Thu, 10 Feb 2022 09:04:18 -0800
Message-Id: <20220210170418.2404807-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-Mailman-Approved-At: Thu, 10 Feb 2022 17:08:45 +0000
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

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this problem
kfd_chardev.c:2594:16: warning: The expression is an uninitialized value.
  The computed value will also be garbage
        while (ret && i--) {
                      ^~~

i is a loop variable and this block unwinds a problem in the loop.
When the error happens before the loop, this value is garbage.
Move the initialization of i to its decalaration.

Fixes: be072b06c739 ("drm/amdkfd: CRIU export BOs as prime dmabuf objects")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 636391c61cafb..4310ca07af130 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2374,7 +2374,7 @@ static int criu_restore_bos(struct kfd_process *p,
 	const bool criu_resume = true;
 	bool flush_tlbs = false;
 	int ret = 0, j = 0;
-	uint32_t i;
+	uint32_t i = 0;
 
 	if (*priv_offset + (args->num_bos * sizeof(*bo_privs)) > max_priv_data_size)
 		return -EINVAL;
@@ -2410,7 +2410,7 @@ static int criu_restore_bos(struct kfd_process *p,
 	*priv_offset += args->num_bos * sizeof(*bo_privs);
 
 	/* Create and map new BOs */
-	for (i = 0; i < args->num_bos; i++) {
+	for (; i < args->num_bos; i++) {
 		struct kfd_criu_bo_bucket *bo_bucket;
 		struct kfd_criu_bo_priv_data *bo_priv;
 		struct kfd_dev *dev;
-- 
2.26.3

