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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB6DC43459
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49AB2223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezksgr0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AB2223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140EC6E850;
	Tue, 14 Jul 2020 18:24:44 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C9A6E850
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:42 +0000 (UTC)
Received: by mail-qv1-xf2e.google.com with SMTP id h17so7964246qvr.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VdJNO+pu0gib00RSADeplk8gQnb4IUyhKgniWyz9CuI=;
 b=ezksgr0HF80DRKeMJrZ6C5jbo1huPcpv06Jd+/95ad3WdU8Z6qYxJTYGw0Z7NGsmTI
 rZduNlz2XxsOH1IDVpEk5OlM/FuQIfdAdkA7rFwuK06VBD8peG95aeiRih/7YxIsdFIJ
 5EJzp3G1wJ1o1m3HEf0hXEZraVj/tFZjTLu1UaKDoI68JG6Pdbs7WyUnpJ06hHugRXZq
 u1xC/3VydAtwwa7IzaDdeOoUDNvNHoEaIq7ZzK/RQ9TafsNOOMombjGKs7MmrEQfKsMO
 hbkURlj6TKfuTvhSJNbwvZj16g3J0W0fqI9vWTiTDhQwDuz8wO19ITVgFECKW1i1DmDl
 4oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VdJNO+pu0gib00RSADeplk8gQnb4IUyhKgniWyz9CuI=;
 b=mh7Fsb25a/rXnUrDbk1n/xvldV4j//SMdIKG60/Pw98zLv3UPDOFRas2ncrQzaMSPf
 vRpJp5BLQP+VW3DZKt70aI9tOCXmVe5ygzs3uFdmhPa+X6DZ9SmIG+sb2MnWBSFWPbbH
 WGFOeD+PYIx5YE4XyMDx12QDwDZxA0sx1SGAhPPtZ07vTd+5m00WodEalWjs+Eo0+GhL
 mjB1okb/qxUsG1HwW07vQR9OhhUPm3tKV2cpIgjcl2FaVYkdFTt9ifwxry/fGQKi/bBj
 45d2VhXnJk+SZq75cUxL/49Tk7yGczAM2E680ARVPX+raeYaQ4rSLZqDiyz9Rpp+obIO
 AXIg==
X-Gm-Message-State: AOAM533C1lGHSpZFJ05w894VhnFeorboYo05KfZUBhFN9rxZXNPelO+T
 lofRs+i/Y41ooL32oiCjCOZY3+dM
X-Google-Smtp-Source: ABdhPJxMHfbjGuFAjqel1oI98NqEmW3XjHua3wbTrP5LpTa0UEN0uITOcqzqTmFa/Az+rZSSQ3gz3w==
X-Received: by 2002:ad4:54af:: with SMTP id r15mr6181346qvy.162.1594751081591; 
 Tue, 14 Jul 2020 11:24:41 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:41 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/42] drm/amdgpu: use front door firmware loading for
 navy_flounder
Date: Tue, 14 Jul 2020 14:23:36 -0400
Message-Id: <20200714182353.2164930-26-alexander.deucher@amd.com>
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

Same as other navi asics.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 43af71c3202c..183743c5fb7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -390,12 +390,11 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		if (!load_type)
 			return AMDGPU_FW_LOAD_DIRECT;
 		else
 			return AMDGPU_FW_LOAD_PSP;
-	case CHIP_NAVY_FLOUNDER:
-		return AMDGPU_FW_LOAD_DIRECT;
 	default:
 		DRM_ERROR("Unknown firmware load type\n");
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
