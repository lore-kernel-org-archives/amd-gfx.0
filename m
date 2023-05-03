Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2132C77B78
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 15:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3756A10E134;
	Wed,  3 May 2023 15:29:37 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4A410E2F0
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 15:09:43 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3063208beedso3023344f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 May 2023 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1683126582; x=1685718582;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lHn2q/LoLyqphWxooc9AtkUCXjbjiXmoO7+MLExrCDY=;
 b=mw6w9ImEn7ZTvxm+NpxjKfmIQCh2uH2sftTF71syVQ0PfSUhCyehC4HCVEJlSHMNc4
 djmwOVpXSHX5AxK4i0IaLrfzIxSsHgD+tUHrpMqpzz2GdiFNR71VHI1msZeahtxePojv
 fpKX2q6grqG2ilzrNnu1z1GkZMzVWN0y8+Aluig6/5cPW4iocaavD0CditZhhKvj2Ppc
 cWbBvd3hhL7JErTmLAmlOa+/HPq32qUWxGai8ILTrZ2h/3DjC3qb+himjYevcUBG9e82
 gdy/opjeNZ5ih2w/LnD7J9udlH8vlWCh+aFUnVPToo7wP2TB1xkYd+x2u+F2wjC84oV2
 rzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683126582; x=1685718582;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lHn2q/LoLyqphWxooc9AtkUCXjbjiXmoO7+MLExrCDY=;
 b=jDe3EaA752+Rj72L8AjH24OLpegkRIQcFSdr2Jc+9Xlx2oN8XdK2WfbGxUde3d4gUY
 ad0oaCv87poOxP+5qwavV4OpnDwWehLFNF8kWgMcw5CF/WOCUy/nzGjzUomaixqld6l3
 lMxEmd1rULwelNE57wrEOhr8H+RL/M2Y7wwaENmkchhXnRGDbXU+V6BVQefeSbEPtZnc
 KK3O6qxScXpw7y2mgg4kHK3pdWtqd2+BekjopGIXk2B+ry1m/oZZTqLqHKh/tYBejhn2
 brKyO4QjgBKmTJrlBYtPGO34NJA4GRYdx/GxYEwPUE4FL9mMHM1QOve5IEPwEfWehogU
 NIfg==
X-Gm-Message-State: AC+VfDzl146fWdRfLjQbsrQRkxXU+FP05XgF07srRwtsV0l0rJWCcj6G
 rKwadff4qOtYjVU7Gk/MpB83Zg==
X-Google-Smtp-Source: ACHHUZ7ta6829UORYzvq44Fqpb5GVNr04656qcKelYhqGaHHB1HPOWYiohvxlAg+tnS8YZhx2nMsuQ==
X-Received: by 2002:a5d:5942:0:b0:304:8147:f0ba with SMTP id
 e2-20020a5d5942000000b003048147f0bamr343888wri.3.1683126581860; 
 Wed, 03 May 2023 08:09:41 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 q7-20020a1cf307000000b003f18b52c73asm2139024wmq.24.2023.05.03.08.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 May 2023 08:09:40 -0700 (PDT)
Date: Wed, 3 May 2023 18:09:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Le Ma <le.ma@amd.com>
Subject: [PATCH] drm/amdgpu: unlock on error in gfx_v9_4_3_kiq_resume()
Message-ID: <cb48ef1c-5f1a-449f-a9f6-909042661ce6@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Wed, 03 May 2023 15:29:35 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, kernel-janitors@vger.kernel.org,
 Morris Zhang <Shiwu.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Smatch complains that we need to drop this lock before returning.

    drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1838 gfx_v9_4_3_kiq_resume()
    warn: inconsistent returns 'ring->mqd_obj->tbo.base.resv'.

Fixes: 86301129698b ("drm/amdgpu: split gc v9_4_3 functionality from gc v9_0")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
The Fixes tag is weird, but I think it's correct?

 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 56a415e151d4..552729a514d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1827,8 +1827,10 @@ static int gfx_v9_4_3_kiq_resume(struct amdgpu_device *adev, int xcc_id)
 		return r;
 
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0))
+	if (unlikely(r != 0)) {
+		amdgpu_bo_unreserve(ring->mqd_obj);
 		return r;
+	}
 
 	gfx_v9_4_3_kiq_init_queue(ring, xcc_id);
 	amdgpu_bo_kunmap(ring->mqd_obj);
-- 
2.39.2

