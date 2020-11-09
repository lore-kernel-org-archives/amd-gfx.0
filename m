Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53602C5517A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A4A206CB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGhqvmdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A4A206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3033689327;
	Mon,  9 Nov 2020 21:16:27 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2370D892E5;
 Mon,  9 Nov 2020 21:09:57 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id h12so7078468qtc.9;
 Mon, 09 Nov 2020 13:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/0XocD5P4X8PutfEBTr0iQ6o7VPBilDjyKi4NGpWaVc=;
 b=NGhqvmdqdeTsnOAPi1e5Vd1qdGimaQPD+OZZ7kiZ5p5sQGqAxeqoBFwYejrxi1j2WP
 f9gXR9FS5Ko+gq0afQJcfyyerPqO9NQuLqIRyJOPGK/al3votarLB9dVrDkf9rfE6pzB
 nSbwZOgoA4nrUiQpTZI6dh8NaHw9y19ug1V0x6EfqKJzIL4JaJ78FpaO1ljI8BCKNJQC
 qL5peFy7bg0NzjWgIYZkSmWO0tcV4Nu6HgVInMnWr97rfXw71KU6qw6ADW3PZ+6a/aer
 o4rX/XGWDDvd64WvJZto4lQdfbtjGV7/9r8jXQvDI79wWemK2m9AUTtm8RZQHj9grU8W
 IGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/0XocD5P4X8PutfEBTr0iQ6o7VPBilDjyKi4NGpWaVc=;
 b=K/RYwDmkqPxJMlascKp8gX+nRPrrKSxW3CAh7VRlNVsS80/ELRV2XS01kqvuUutqgl
 l4V6vIizppLyRsvtgTZaR7vXbzOXVqKjy+/ceKhxWan3iukRTq90RW4vWCTiqA+YUGEl
 S0ys1m5mpp6WfnJVF57nr4bl79tpyB9U9dIoXDz09xgPH1sOS4vT9y7Pg3E88DyGXy41
 XXKhFKhs4tEUIo/Ktcd5H33SJupRRg4ZhNmkv0dRxmPbovJ+wK6kGyLRapnFKwtrsEL8
 fj/UMjHi4yxSkX90A9BkbAYPE2ag4OGSFRuID8CjX7hGKlSgYMv1w6LS3WrZR9auSYF+
 885A==
X-Gm-Message-State: AOAM533GNUOsOhGVF44Y1SBYazaagQpMHsZczvyV5MF1KsIutbJF0Ay1
 GR5HmlHDUdj6Aol22MHiNW0=
X-Google-Smtp-Source: ABdhPJweV+Szh+PkEAYXoXyjTozPf81Tox2F7Dj/v1OFpc1GcHYkrXzj/rpBR38tMgQhU19OWI65SQ==
X-Received: by 2002:ac8:5649:: with SMTP id 9mr14720827qtt.379.1604956196346; 
 Mon, 09 Nov 2020 13:09:56 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.180])
 by smtp.gmail.com with ESMTPSA id o21sm7161000qko.9.2020.11.09.13.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:09:55 -0800 (PST)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, jdelvare@suse.de, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH] drivers: amdgpu: amdgpu_display: Fixed the spelling of falg
 to flag
Date: Tue, 10 Nov 2020 02:37:25 +0530
Message-Id: <20201109210725.24668-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Nov 2020 21:16:26 +0000
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
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

s/falg/flag/p

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 2e8a8b57639f..9223502c1e5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -509,7 +509,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 * to avoid hang caused by placement of scanout BO in GTT on certain
 	 * APUs. So force the BO placement to VRAM in case this architecture
 	 * will not allow USWC mappings.
-	 * Also, don't allow GTT domain if the BO doens't have USWC falg set.
+	 * Also, don't allow GTT domain if the BO doens't have USWC flag set.
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
--
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
