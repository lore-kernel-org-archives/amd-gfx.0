Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE36C5519F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 08:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F12206CA
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 08:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H12ipulR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F12206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 558EF6E40A;
	Mon, 30 Nov 2020 08:27:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E79126EE4B
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 16:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606494376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=9kcT9NngfazbuS/JmAbn32wrrn8CkOa26eF7oEFiGFI=;
 b=H12ipulR/Ir0EUQPUaCWj/ddClTP633xRhgahTnOQdQfBorTuzZnXBxp00/luU4QDcuFn1
 y1YreGIRm8RnJSPoG0aQ94L7MGDJ1flAxHW/OV0AIKXnBTu8QtbzGrQnGpnxULC9gmXA02
 ZWdhbYLVMJlVFKdBxV/gy+YiuauMLsU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-uBODlMA_MByAA6W6O6oTbw-1; Fri, 27 Nov 2020 11:26:15 -0500
X-MC-Unique: uBODlMA_MByAA6W6O6oTbw-1
Received: by mail-qt1-f199.google.com with SMTP id a22so3513765qtx.20
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 08:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=9kcT9NngfazbuS/JmAbn32wrrn8CkOa26eF7oEFiGFI=;
 b=BRQGRnXAfYApllAi+khzVVWIyTGClFAza4IxfiFXgVcJzc8t8cV4XAS9r0hSY96kQn
 dCB33inMNn8+eem8asQNBEaBkvbtrONdXJd2lH0vx6Yx6hAovGw38cDQDR3gJ0qMjKVA
 OKOeZHeuZWibjk1gdl/RktsAEcXXuZgsrksyvDAQOvIhVdO2yG33W+POk2DyMLd+Z/W4
 I5bkbjzmVMiNHA0Xz+R+QhmI9w1zIQ+rikOiHy8J9syQ922tTLVnfRnyvzWq7LFaM6UV
 ckdnjRhqVY/qgTSoJJOymWeKbagqPVSXAiadNwNko3s7dao07MWasUHVON2AeWlpupqc
 FyAw==
X-Gm-Message-State: AOAM530zAgnx2M97+haf9JzmckJDJB+hxF1R9yxCvuNbVYdNCZl0rbf5
 81e96e2glMcLllNTh04tIxr3SATmRCaajiPzzpa8ttDG9MHaiNgtHvG9sij0Hrht82ZY39PU0D+
 WfddSTKbXeMKopzcfH7C3Lgwnhw==
X-Received: by 2002:a37:4350:: with SMTP id q77mr9607314qka.14.1606494374692; 
 Fri, 27 Nov 2020 08:26:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNGd4qb8oVRkjqDYpGhY8hkSGk1iJ3KkPlgznYCKM24/i6OjNo9tI0muQNVpoA0U0g2g/58g==
X-Received: by 2002:a37:4350:: with SMTP id q77mr9607280qka.14.1606494374479; 
 Fri, 27 Nov 2020 08:26:14 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id x33sm6358454qte.73.2020.11.27.08.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2020 08:26:13 -0800 (PST)
From: trix@redhat.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, Hawking.Zhang@amd.com, evan.quan@amd.com,
 Felix.Kuehling@amd.com, luben.tuikov@amd.com, Dennis.Li@amd.com,
 andrey.grodzovsky@amd.com, Joseph.Greathouse@amd.com, jonathan.kim@amd.com
Subject: [PATCH] drm/amdgpu/display: remove trailing semicolon in macro
 definition
Date: Fri, 27 Nov 2020 08:26:07 -0800
Message-Id: <20201127162607.2656353-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Mon, 30 Nov 2020 08:27:28 +0000
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f9c81bc21ba4..301e93c9e72a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1213,7 +1213,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
 	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
 
-#define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
+#define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter))
 
 /* Common functions */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
-- 
2.18.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
