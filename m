Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF09C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 13:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4DCD10E929;
	Thu, 24 Mar 2022 13:46:02 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8127410E8E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 13:40:38 +0000 (UTC)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-2e644c76556so36099447b3.15
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=C/BnJKMJEeV8BFoBzBXZm96RIax/W1fb5Ij7o/AsFUY=;
 b=I5r3XueZuY2fFEJBQooGi7gGjzI2M6XTWZJbSSqpBHqZEDBRjs23ELQv+MaLam20gS
 HOUvaKIvKTzfDuxnGlhWHV1awOQClZC13qC5dYMPd6LdPodeULLxGTuIykA4wXX8DKPT
 t5CDgvB3VSiLzr4FTuibjgE3YNSQ9WeikcXR1mD1GBmZI8JqNdFBG/wyO9AFpvG2qv6e
 EjiewN5jQCS4w6yTZRu0uFg29AprjobE7MxGZLR5e3f11tpuOXDqu4LFZ1TQR0wPtoMV
 Nhf+WkQSCcPhfzmx91IPOQedBHGJhzcnFoJ3RoAKIygBAplidLdh8VikpiAYWZYVIhBN
 swAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=C/BnJKMJEeV8BFoBzBXZm96RIax/W1fb5Ij7o/AsFUY=;
 b=7kqWUgWGKxhc+EjJRIhpvGn9tG96TGJlVK1UFwFIigUeJkmCLPWw/nzK+2/Lfkud0w
 1/s6B/55IKHgc70HsThIP4m3TTQ5s3uIUV43wxpCQT0doGheqJt8/vfZlcxj8j0FqyZE
 EKTWeD4VGUPDrPbw5/TwMjfjN2ZUGg/k0Ngm7bEQsp+9ull09h+aWcZaEhQDXbMyiht8
 GGo5LfHXAdokGd2cHHlflIEI1tOssv/ihlAYxIsjD/hKkFaxBStCkTuhcjicXbqBlMPY
 uUHM3wb/q/V1Pue2In6flRck9zDe+npeJHjwc0FK7XP+eNdpcqAW42IcMQ1B35dSwDWz
 hx7g==
X-Gm-Message-State: AOAM531LZgWdebMIeXzY2nIUquFmZf8sQmKJZ+coq5olHkM6MP5W7AiC
 HbMIvJQvZVgHBb9fvpXeWr3pfZqYwl8+
X-Google-Smtp-Source: ABdhPJweQHmVV0UUx5aJF4XSf3mwT0CfS9APEo0gOtx/klTIZrZS7Nmxl9l15vxPFIn60fKz0VjEENXw93jx
X-Received: from ezekiel.c.googlers.com
 ([fda3:e722:ac3:cc00:4f:4b78:c0a8:108e])
 (user=shraash job=sendgmr) by 2002:a81:144a:0:b0:2e6:c2bd:b724 with SMTP id
 71-20020a81144a000000b002e6c2bdb724mr2226691ywu.270.1648129237510; Thu, 24
 Mar 2022 06:40:37 -0700 (PDT)
Date: Thu, 24 Mar 2022 19:10:31 +0530
Message-Id: <20220324134031.2648315-1-shraash@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v2] drm/amd/display: Fix unused-but-set-variable warning
From: Aashish Sharma <shraash@google.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Pan Xinhui <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, 
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Jake Wang <haonan.wang2@amd.com>, 
 Anson Jacob <Anson.Jacob@amd.com>, Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 24 Mar 2022 13:46:01 +0000
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
Cc: Aashish Sharma <shraash@google.com>, kernel test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Wayne Lin <wayne.lin@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the kernel test robot warning below:

drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2893:12:
warning: variable 'temp' set but not used [-Wunused-but-set-variable]

Replaced the assignment to the unused temp variable with READ_ONCE()
macro to flush the writes. READ_ONCE() helps avoid the use of
volatile and makes it obvious from the code that the read here is
intentional. Also verified on x86 that the generated code is exactly the
same as before.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Aashish Sharma <shraash@google.com>
---
v2: Removed unnecessary volatile qualifier in the typecast and an unnecessary comment. Also reworded the commit message.
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 873ecd04e01d..a58f460f431d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2913,13 +2913,11 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 	uint32_t wptr = rb->wrpt;
 
 	while (rptr != wptr) {
-		uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
-		//uint64_t volatile *p = (uint64_t volatile *)data;
-		uint64_t temp;
+		uint64_t *data = (uint64_t *)((uint8_t *)(rb->base_address) + rptr);
 		uint8_t i;
 
 		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
-			temp = *data++;
+			(void)READ_ONCE(*data++);
 
 		rptr += DMUB_RB_CMD_SIZE;
 		if (rptr >= rb->capacity)
-- 
2.35.1.894.gb6a874cedc-goog

