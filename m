Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CFCC388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 13:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F42222249
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 13:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP3rmRat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F42222249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 122496F55D;
	Thu, 22 Oct 2020 13:59:33 +0000 (UTC)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6637F6F52B;
 Thu, 22 Oct 2020 13:49:48 +0000 (UTC)
Received: by mail-pj1-x1042.google.com with SMTP id az3so1059235pjb.4;
 Thu, 22 Oct 2020 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yTl8+Dyvrrb2/Dw69EXXgAneFBqPnAI/YfkWw2WmlZ0=;
 b=TP3rmRataYjyPqJdaBoyWz54I2agvdRkJv3SFqJTSNmQk/xR5db1xz/iZBa8eQocpP
 us2f6rRY4/PFR9V69DZrktfGGiZS240dDh7rOHEqfaOFNEVPDm770MxoDX9s83Tb2NTe
 tncNTKu71aZNmUgswujzD9aWUenusMFZAfmyztX72I9KTMlT99aA5MT0YbePiggIcpBQ
 9b4j1+IGJDYhdz/ICX4s9ljeVTe940faL/Df2j135mNkxF78d0X+YRm/7JTroTM8QrMN
 M/LPw9ZZYbuNwOgKdeVBP8LKx43c8L2Xkb/ZxqJev5LZfVU/mi7BcbSyxQ8hkxfeqdOG
 7HsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yTl8+Dyvrrb2/Dw69EXXgAneFBqPnAI/YfkWw2WmlZ0=;
 b=CXFc0L2RkLCLp+8PHDUdSp0yJPx+E7xeSvBAkyGNyNr5DD69mEpurS+osSfRbWT6ke
 Qx/2JxI+dOSTzqimezPAMS7n8O82d4DrnHwm6kahamhAzbNxn1xNUrirCc8Jpoc0Kd0N
 wPBDPVLK2buXyKGHFcFrWom7Ggx+b5oyzDCMXPcrMAyzSStyz1pNVdXPxTFl4nUl0Jz2
 23ZHDI8wPYad2tB16hM/bnguyl4W6xh8pu9U+0lEfPi8JPV0z91lYG6zC0PW3+SRMtOM
 dFDQKv0FanAPzGXFxjPvA2o7RoGiwlVltOEY93CubwCpKw3jlx6ppbHMhHvYesSGD6ob
 Q4Yw==
X-Gm-Message-State: AOAM531Lxus0TNn+DnhGGfSM64AXp6f1eMifSRnBXA9jSmYpfGnDTsq0
 GRHCycffOVFJGFDm144RF2Chl6yHepVhuw==
X-Google-Smtp-Source: ABdhPJxqsM1gId5qcxXgzjgcDhvuj/wtcwVM9aDQUPnnS86XiqYptot0vssZjMRVYQGGZD1jC1QNuQ==
X-Received: by 2002:a17:902:a383:b029:d5:dde6:2e86 with SMTP id
 x3-20020a170902a383b02900d5dde62e86mr2562630pla.37.1603374587755; 
 Thu, 22 Oct 2020 06:49:47 -0700 (PDT)
Received: from adolin ([49.207.204.75])
 by smtp.gmail.com with ESMTPSA id 78sm2479155pfz.211.2020.10.22.06.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 06:49:47 -0700 (PDT)
Date: Thu, 22 Oct 2020 19:19:42 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 5/5] gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
Message-ID: <a8ece8d34c64206a315adc3da321bb9e675972af.1603371258.git.sylphrenadin@gmail.com>
References: <cover.1603371258.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1603371258.git.sylphrenadin@gmail.com>
X-Mailman-Approved-At: Thu, 22 Oct 2020 13:59:31 +0000
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
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, melissa.srw@gmail.com,
 outreachy-kernel@googlegroups.com, daniel@ffwll.ch, alexander.deucher@amd.com,
 christian.koenig@amd.com, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Using snprintf() for show() methods holds the risk of buffer overrun
as snprintf() does not know the PAGE_SIZE maximum of the temporary
buffer used to output sysfs content.

Modify amdgpu_ras.c to use sysfs_emit() instead which knows the
size of the temporary buffer.

Issue found with Coccinelle.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e5ea14774c0c..6d9901e1b4b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -429,13 +429,13 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
 	};
 
 	if (!amdgpu_ras_get_error_query_ready(obj->adev))
-		return snprintf(buf, PAGE_SIZE,
+		return sysfs_emit(buf, PAGE_SIZE,
 				"Query currently inaccessible\n");
 
 	if (amdgpu_ras_error_query(obj->adev, &info))
 		return -EINVAL;
 
-	return snprintf(buf, PAGE_SIZE, "%s: %lu\n%s: %lu\n",
+	return sysfs_emit(buf, PAGE_SIZE, "%s: %lu\n%s: %lu\n",
 			"ue", info.ue_count,
 			"ce", info.ce_count);
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
