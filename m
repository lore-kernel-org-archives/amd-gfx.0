Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C3CC43457
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C55223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgFP1dlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C55223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BEEF6E84A;
	Tue, 14 Jul 2020 18:24:40 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 788766E84A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:38 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id a32so13610405qtb.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u7y1m1dijd0FHc2Jt/JAcNaf2A5UMjGH5O767hhMEno=;
 b=FgFP1dlS3WRpuuHcHIznPt8xD4I4aXMxyXGyhji/8xky8Z6dj2ecBsGC54gZZTdu4W
 QS4XW/ZRcPR+og8kFiRnDxDeGCt2MvQ33GjD49XPt0E5uJkMFNs9RmKp2TjdnDpfrRnH
 JtlWh0vloa9CBN94eEsR528wOhZ9ZKADs+JczhW8JIvNBJtH9w5FYxqxvAubsWttMTlR
 +fRM453Zfx+CywnVS0RmFeAtbDrYbKjO3xYEIqN6rDy9ZPx5eEZfAEYubSadfZfldOOt
 6Zw0h/d3oHDXQndttLL9kOOlO1kj4pE5wQtpPQ51BNvRgPRTLsuv6IwM2jBAuQzEVAVb
 lTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u7y1m1dijd0FHc2Jt/JAcNaf2A5UMjGH5O767hhMEno=;
 b=IjwXy/cdC5GM32qIIOa4f6lzpHxcRdn66lc95ZwPydXxxhDH0p76rJNoKQ9CTzdaaF
 C6dz+oiDRjf2+6sgI0MYHMFl/d6q8U+RALYj6qJKzvLrsai7WZaHZrRlEYA814dVTbA6
 U16w7lobyoo88TNpkuNz+mkGGoYoInWWvSukEIkMI8l3b6llYkuVXtX+nSahrnS5PKB1
 k9m8PZM1LD/DybEjg89gjDCQZcX93C6qYNGm2bxr2etaUP176+OuxYqEGvnMX8RbYt03
 8JU9TC3+O1AaD8CDQAXQquKsWZmMvGNHX0mSGY1kR5/qYonmoWUPFxdPOeEvTJ1zH3AN
 +GqA==
X-Gm-Message-State: AOAM530dTaxW4WmSOGqkm36yzIiU6OErQNfoKFJIQsP3lyLMXF04WPx3
 CLlg4GJzrZmKDnZjdJizPeGyK7mk
X-Google-Smtp-Source: ABdhPJzp+7ldb5pDhe/ZqjbXGH7N61xHTXysZnWP+6JsQ7qUlZYE62z1y89nSRaYjaz9rE/rD7OJtg==
X-Received: by 2002:ac8:3563:: with SMTP id z32mr6126257qtb.244.1594751077428; 
 Tue, 14 Jul 2020 11:24:37 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:36 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/42] drm/amdgpu: add smu block for navy_flounder
Date: Tue, 14 Jul 2020 14:23:33 -0400
Message-Id: <20200714182353.2164930-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

Add SMU block for navy_flounder with direct
firmware load type.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 46c51e0380e8..383db88f4995 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -516,6 +516,9 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
+		    is_support_sw_smu(adev))
+			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
