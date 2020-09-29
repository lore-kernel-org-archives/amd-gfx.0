Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAAAC47423
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915CC207F7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6KUYCQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915CC207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1586E4DD;
	Tue, 29 Sep 2020 15:28:03 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 336056E4CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 15:28:01 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id q63so4694920qkf.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kSE9kc/oWEd70zJ0lkkMMt+FUyiLFoZ+gFAJPre47WA=;
 b=P6KUYCQMz+cgkahoxND28oJPAUhzV4t947FjVfbcxFhxs08fPomFL+JDQP+51b5Kpp
 LpqasCKYhsTIjIId7Gbp8TUFGNch9jvsDs09CyVW2H7Uf76hbU3XuJdHvF/L4xj251D4
 aGHhD2btuxZ+kfkGuyP21FJ4a9iWNliZiOoDygcynSgaa+iyY7I/7pRFtt98j+aR77cm
 +PhMOBlc3fRqzTa9C6Yy+OAv507kEchcW07xsXbJOt7jGNLuHPyIR6z/viby04DGJZCq
 sw/aVJdzKWzE98FsTtVUVrujPSFz5i3Brf5XZ1kl35eUduR9HrXkN8ad5KsrKls7LYcE
 YD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kSE9kc/oWEd70zJ0lkkMMt+FUyiLFoZ+gFAJPre47WA=;
 b=Pitbxrhqs8oJG8qtmwJl5EWdf/QGOgFm+2LqCa9ghiTWFqmRWyOtOr2oEgobyxwHBd
 9XpBIcPaUHMymavGQDUhaSpVzScZBJDzP1dxDHiCV+CkJMTTyJZlpsrKP8Qtvhd08Rgv
 vBO2t/Zpn8MDp3E0m+blVSyER4T5d5bOu9SEAU6PgmBxspNr9EPRRTx5wfYa2jae2eyx
 lWDbdQ6W9Xzrb+CSh5sqczqxlmAIoGoXQhW+jlx6CeK5z5SFZnjL3HgsWLPezvCbNRbQ
 P0D8LcLZQAEpPB1308LXSb1lEH7VZHuqtN17sZRkDWz97UVLlXAfcrY2w5jByVEbT34Q
 QR5w==
X-Gm-Message-State: AOAM530+Jahr7SRZtQlNI80miNjFi3MO/WOe5LcQeemJEIQiCrGyJMej
 b8ErDMgy0/zp7azApKWHlzWnDqptXGw=
X-Google-Smtp-Source: ABdhPJye8HUnJ8Hpbpw2qWGB8sW3UOkZRByflxnEtJFNy1203w2R1cZtAMYm9qWOX1b6EmFX3mkmcQ==
X-Received: by 2002:a05:620a:545:: with SMTP id
 o5mr5062884qko.172.1601393280183; 
 Tue, 29 Sep 2020 08:28:00 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id r187sm4669007qkc.63.2020.09.29.08.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 08:27:59 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/45] drm/amdgpu: add nv common ip block support for van gogh
Date: Tue, 29 Sep 2020 11:27:47 -0400
Message-Id: <20200929152749.2442370-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200929152749.2442370-1-alexander.deucher@amd.com>
References: <20200929152749.2442370-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

This patch adds common ip support for van gogh.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index bc894cfba60c..2077f897d6eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -478,6 +478,9 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 	case CHIP_NAVY_FLOUNDER:
 		sienna_cichlid_reg_base_init(adev);
 		break;
+	case CHIP_VANGOGH:
+		vangogh_reg_base_init(adev);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -858,6 +861,11 @@ static int nv_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x32;
 		break;
 
+	case CHIP_VANGOGH:
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x01;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
