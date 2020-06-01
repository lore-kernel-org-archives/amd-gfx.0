Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B82C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE86E2077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vA3Cd+GD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE86E2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 872AC6E290;
	Mon,  1 Jun 2020 18:03:51 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4457D6E28E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:50 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id j32so8406726qte.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pV+5+2VDJg0sjZjF0ZnBoR0nqm6/75woVULHoamIrYE=;
 b=vA3Cd+GDzohzGok7ZD8Oxt5TYXANIttN1CHuBqlSTBK07YbtrgFUYAe2noXckwm7pV
 lGzVI/sZURMEYdsOtCjJSlGk6O0e5zTIGoDy/zENgb/OoQJmGUsTZTnFiOgzg6w+i60+
 v5mPL5AtucnYAmAzIy+NFfrkHtWy1a0sfVSD7PWg+n7j/95fDZBxlrPZ8qUIXsnLY8WC
 FKfWn6T028+MsCO3EU5OOLf5LcpDeBHogdEc68mWU4VnDdcfr+v9SWDpC/woyeUl9QU4
 W4mZl0oYSNLhTmMOqsFgeL9A2TtFepIqXE9vzbkWom//IXVE9MjnvIr3Liv1a04OCMY+
 DkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pV+5+2VDJg0sjZjF0ZnBoR0nqm6/75woVULHoamIrYE=;
 b=sSahNo9QGtI3nkSjNZVE8DEWaNi7U9KWJjfPdZD7dCd26Hs0BYcPPkjtVVBtxDc7q4
 W3pIxT5YqdBpBibtw7bNl8dKCMAHR+nofWl1oQPQ5TsV269S5tRnn9iC1AAhWD+UgyQk
 QzIfMrBmpqP8EfuNZGWEOywHuEi6g2lGSNimM3P+8R1tZVZTLBmusVefeAO8Q0GQOdeu
 NtdspxOvYw/+azjQpMa+BwHV9GUhJ+0QqhY75KJASQ3yqIO/T29UOdBA/E4+26yjDRQj
 +wGpbbz0eHmKvihPbB41PWtKaW05mzS6W1J39dLEvUs12d4m3cHsM0YrhN1lg+gGcOEB
 ijFg==
X-Gm-Message-State: AOAM533PBebWdZ5gqcStAa2xu9bqoMy1CPdAdckL1wb+2TrRZRfDPaUQ
 nUgxrtfVIouqWek2dsDT/8hIy0YW
X-Google-Smtp-Source: ABdhPJwsakBlxjfJmbynM7sETBlyrpyE1glLh72WLbU2Uz99Fev3htO9p2gwhejhj+2QJElL7MdZOg==
X-Received: by 2002:ac8:775b:: with SMTP id g27mr23425366qtu.217.1591034629291; 
 Mon, 01 Jun 2020 11:03:49 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:48 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 044/207] drm/amdgpu/powerplay: add smu block for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:56 -0400
Message-Id: <20200601180239.1267430-41-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Likun Gao <Likun.Gao@amd.com>, Jack Xiao <Jack.Xiao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add SMU block for sienna_cichlid with psp load type.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 1b17fca98fef..e2d97bcdf328 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -488,6 +488,9 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
+		    is_support_sw_smu(adev))
+			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
