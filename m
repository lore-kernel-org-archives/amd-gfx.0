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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8348C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2227225AA
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjEvE47/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2227225AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58B2E6E83F;
	Tue, 14 Jul 2020 18:24:32 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066E86E83F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:32 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id z63so16487648qkb.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O3rEaN/sRc7iuhb+6r+i8PEP1WaR8ZhTMJcAD7yocxw=;
 b=SjEvE47/2Pz+V4B5CRueICabVbRNKNWRMORsPcQGfD2aTbAu02QaXq9TPrUfIIV8nm
 WFILuyIyjtGnoaJ2H6ac8sMmyCL4zzjYkz7B57UC2/sOWfS1xpx1/6viNjc9k5yOVAYx
 ix6GPHSKv1oADrGMnobAKMoBrHeIhKj4b0pnAOFlQiPEW4ipMnnXC97jRRyC1bnJJ+KM
 KUtaLg5X8yf6q+RM/sAAMgw1ot1tmCyVCaMc3kaSaOwn/SSI7uPV/peAwuKheXqhdEvn
 3T9JnlMSK5GK0ib13vPMaIlUyS4l6CI24JrMwvMhfMVVJYyXhJ4VTEM7D9nGxPLx1F/+
 LmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O3rEaN/sRc7iuhb+6r+i8PEP1WaR8ZhTMJcAD7yocxw=;
 b=buyyPKMvwKkx+wULe5js/2uZya3jjG1DD0e79/spOdVJ7BkMUF8DkS4x2wWmYFOAqk
 ilWGBESDs+GGOvYWUi3+cblrpbbAksWxki2nwFdb5EUUWhPB1f7HUiOSvPDBLEJwSqK0
 Nk7cvy6HlSKHx0fmF5TILKistvZNCT/0dimmBXuu2dAi6DgYYZg1NrpboieO3cuvj2RL
 QiCgBYiUsrSFCmUo2BPVgrphQomvMLmfaJatKSPMRih14YYoGL+ZTiQkwhH0fP5H4NgR
 yS0VfCQVSAbGASV1DWhUV9al1Kn0aze1q+iLVHVGI/Ha7HmrNHrFwiWJ98LYZ0eYIoUz
 O1Ow==
X-Gm-Message-State: AOAM531YP+nQ6fJtgZqMy68SjFxyC4mTB5dpSWyRAWVRllUBdk2hMFKE
 q7EmtZFEob1us+l95k7JK/hQHuUv
X-Google-Smtp-Source: ABdhPJx07bHmRTk/iz31xoz8QqaiDFtNbYcqErry/x0KO9yZC4w2FJLDc2Iry2Crlcf2DsaRD/716A==
X-Received: by 2002:a37:45cb:: with SMTP id s194mr5982747qka.74.1594751070994; 
 Tue, 14 Jul 2020 11:24:30 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:30 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/42] drm/amdgpu: add virtual display support for
 navy_flounder.
Date: Tue, 14 Jul 2020 14:23:28 -0400
Message-Id: <20200714182353.2164930-18-alexander.deucher@amd.com>
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

Virtual display support for bring up and virtualization.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2f5a3e924a39..46c51e0380e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -512,6 +512,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
+			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
