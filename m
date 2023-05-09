Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8796CC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 14:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11BBB10E38F;
	Tue,  9 May 2023 14:32:04 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25AF10E355
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 14:21:20 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f4000ec6ecso59601875e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 May 2023 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1683642078; x=1686234078;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tKxPPgYNyYSo5DBFq3CPZcdXe5HoTU5bwZzAoSKP9zY=;
 b=OI1NQ1W5f3mp3fG4eqJ6ffb5S2ZxWAYinNYSgokbDOyIyzElP3DIhIGYbKhJIRXgzJ
 88VJJWxaA8RuyLjFV/GM7Ib+6JRBnY9QLzPSajNT8rHPKEykxRi9h8DGbOON6aF+ruL4
 pyZxn/Ri+JNaWnmG5uz4XzM3wgHhavhHWeow2sfcbviZrlil9eSPdC9gKh9Z3fDtudbh
 Na/ohNQPN+HV+b2whejPpA/e3+TTGp3k0Dq6bIGBW2urdyd5JaIxn+xNzHyJev3ZlN0Z
 dKNct4vUDCpQZ0EPo2CAoLQ6J74rMLBkHYNXz9y2z06LGLzOrmir75/3EDbTYE/FMnSs
 9hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683642078; x=1686234078;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tKxPPgYNyYSo5DBFq3CPZcdXe5HoTU5bwZzAoSKP9zY=;
 b=JxjhfBEakZnopv/576k2NeOihrhL93NYjwTm9hRjRqUJn8st0wRhVjoG6ft2ZatLh1
 gCwg0OMpYXkBwtebP+kxGZB0+RSFrWhkXhKW5XDQ4MfiBQZKxtFMZg9kB1fDae7gIqW/
 9fB3qEUEou+2QJ9DpUY7tMX/NUikhxCLTxwqnrqnbGReogtzMQl2R5VB5kWRG5ywiyX0
 trgq+/5va5KU1O3hRfJ2KjWmliDlzMm4NIlAZ2SRZHWNytBCInn1F05mIeJqXDyKL1Ht
 rG54Nsre0gVSTfvqMI354fGZgpuJtt7X9wPksmgTeW9abiO6y/1f8msJZCIoc+H+ySyE
 ALLg==
X-Gm-Message-State: AC+VfDxOXhxOvNG6d33f4UK99u23hmW+z8yboUXHAp5xWIbRZ5NIpBuP
 LeLwqG8HbySS9PLQKOXp7N/o/Q==
X-Google-Smtp-Source: ACHHUZ5yT9mNx0iVJS45hDO9GhW7CW1PKVcX2BFfRjBmKez5Mh/Sl4r98fbSYl4QoCE8fpT3gu2Mgg==
X-Received: by 2002:a1c:720e:0:b0:3f0:7e15:f8fc with SMTP id
 n14-20020a1c720e000000b003f07e15f8fcmr10417276wmc.14.1683642078664; 
 Tue, 09 May 2023 07:21:18 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 d10-20020a1c730a000000b003f325f0e020sm19879491wmb.47.2023.05.09.07.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 May 2023 07:21:17 -0700 (PDT)
Date: Tue, 9 May 2023 17:21:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: release correct lock in amdgpu_gfx_enable_kgq()
Message-ID: <75e5d2a6-9be4-4530-b8f8-c98d1bd96b03@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Tue, 09 May 2023 14:32:02 +0000
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
Cc: Tao Zhou <tao.zhou1@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Le Ma <le.ma@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Likun Gao <Likun.Gao@amd.com>,
 David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This function was releasing the incorrect lock on the error path.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 9bfa241d1289 ("drm/amdgpu: add [en/dis]able_kgq() functions")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
The LKP robot sent me an email about this after I had already written
the patch.  (I review LKP Smatch emails and hit forward).

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 969f256aa003..7d2f119d9223 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -644,7 +644,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 						adev->gfx.num_gfx_rings);
 		if (r) {
 			DRM_ERROR("Failed to lock KIQ (%d).\n", r);
-			spin_unlock(&adev->gfx.kiq[0].ring_lock);
+			spin_unlock(&kiq->ring_lock);
 			return r;
 		}
 
-- 
2.39.2

