Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE342C41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FF72064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWfkg4lJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FF72064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012A78932B;
	Wed,  7 Oct 2020 16:31:58 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2BB68932B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:31:56 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id s7so3415881qkh.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1116WI+WXdayMWjXGHK6lBSk1l0o2gHs/JhU/FgBKhA=;
 b=EWfkg4lJfc3SyKkrS2yw3Tjr2CD98dxjOEge7zwaZdNz+zrJNc50ptbMm6jK4+pCe7
 Jo/yt6kSti8sBPyrB98gUBZ3ZQf1QOYcq4y7iIlCV8MwWwfXkDcpedMB93VNOoK9hrOh
 L/9M2LIe9VDEZIRYjVUrHMt0BZq8ESSMQuTtlr8fICXCMBYWFBFqj3ZPhK/UgpScVcFe
 6J2VveMO3wbgVxsQGEgWHpMCpYa+9QDZqW352ZbalSebc2gVfJoz0Uh9p9CoGpIViJTN
 Sj8eoATVokDWLkvBhVj/aEFaIAZd5BZibjHKCLmPAbaCgH2m/lr9gVrJXLhXLvlCod+f
 qlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1116WI+WXdayMWjXGHK6lBSk1l0o2gHs/JhU/FgBKhA=;
 b=WkKQLGOnAsuV301IKofiZ6P/BYcZ+Hw+vNkZ6ctfPtAbbjfYdETNgkE8xlE/G3CaiA
 LOfhaul82i/fDZNzyqOjtj9uQ2m5coCCRH1SYu4jHVLaLsxkk2sIJfJV56vpPhs20bE2
 iqxX+bx724bqlTPIfYQ9fb5T7FaLzwFujffbp1Atz3STxb4ywEcahDx85781jOtbyR0n
 RfJ69XjaxovnUgP7UOTaSFETDd9SA9NbU+tkRHloqPnDm5Dk9gYY9QJk8ySyRhFx3jLB
 2Oj3qKOHytxwEQvrP5Wr7lFBsHnbCdR6+Me8ce21oASkppK7DtlppcBbVj8UKjo9ot0l
 8ndA==
X-Gm-Message-State: AOAM5326EZJ6pAqN2KrqKkx5y8wChkm/3I7W0n8cJQ4PaudL4r3OAsSc
 gpXixOoo6ShBapMb/pJZHfkV38ZIhmA=
X-Google-Smtp-Source: ABdhPJzFPTKi8HOTSAw1E3RzWAg8NHRcxksLhYn8s5dQinmxY7hJ4U00a3BTs0smYLAp/ubpC4nqeQ==
X-Received: by 2002:ae9:efc7:: with SMTP id d190mr3815480qkg.12.1602088315480; 
 Wed, 07 Oct 2020 09:31:55 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:31:54 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/50] drm/amdgpu: add common support for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:30:53 -0400
Message-Id: <20201007163135.1944186-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add external id and set clock gating for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2c2213d4908f..485c8907cc43 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -891,6 +891,11 @@ static int nv_common_early_init(void *handle)
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
+	case CHIP_DIMGREY_CAVEFISH:
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x3c;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
@@ -1118,6 +1123,7 @@ static int nv_common_set_clockgating_state(void *handle,
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
