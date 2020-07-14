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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC40C433E8
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2DF223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHHkuCxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2DF223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E78356E861;
	Tue, 14 Jul 2020 18:24:55 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C96F56E859
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:54 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id c139so16496811qkg.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q5qox4sCR0t/00Xvit+CjGki2zMtBnP7RjDv7QDzNls=;
 b=XHHkuCxriWxNq67NE4UysGGwXczHCDXg8n/khuf5cKchrp5FGH1A3ScwkLhQJnoxb1
 129aWOWjMSvmYEY5cZGEQhUFf0cAGiCN8CP1PCjDzgI11NpgcRXPGe3cwamo2r3JGso7
 EbST4P5x4awf8X0lTlnJ7XrB4TvxG2+/x6Kl1SKxqgbnAwQZ/LXNnEqfZzu2OpfKWjl+
 3Zn2jDK1oLXpj6pqwmXwJvoa7ALwDoKU3rXfApxreEWaLQaSfYY2sL3herB+ZjouYS2q
 FzhOun0W+0Vuo5y/Kaw9yj0fzOyeHeqxOwr0Uhaul0Y2EaDBz4dv71xCoEslAy9wYHuC
 UCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q5qox4sCR0t/00Xvit+CjGki2zMtBnP7RjDv7QDzNls=;
 b=QFaJahJOso2F4o0L1+/Mh51rkPD9dSUt4nlWb6Ukg73ntaU4eaj8BfG9cO0ghvYKOX
 YyC4ISzOS+mSDJG0gvCAhTM1947eVeiSsm37x3OBmyv3pNW8C8NSBPN4KSuHnL86OihM
 IFalmtYxTM4GIWeXAs6EXf6TJhirj57mPl72VCgQqncAWZ039MiewXnuh0Z72uizdTxG
 NPPQdK+moFHdzjMQMH3ue8BkseyON7rGMobbZ3zW3z/+mR/hnLeq/jNgUZsw6KWjm0en
 q3PaATJtqEbGkXQmST9q/QB1fK+4yoe1HtYeaBCYgdeZUj1LuIszVu/INmjch7A7+qbb
 GDdA==
X-Gm-Message-State: AOAM533thniP97l+kAHMN4WojQms87CXal+4NL4MoALaDIXSh9ivNb6P
 2KQ/poyjhII33+HQWH3ZCV2bmPKe
X-Google-Smtp-Source: ABdhPJxPfJ45qC4yjAL1QQHnuzRRlhRRHp/M/q8zARYoSopDMPJCV/Eau+ao/BtmQGNPGWr6V3t8VQ==
X-Received: by 2002:a37:5a45:: with SMTP id o66mr5487987qkb.137.1594751093728; 
 Tue, 14 Jul 2020 11:24:53 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:53 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 34/42] drm/amdgpu: enable JPEG3.0 PG and CG for navy_flounder
Date: Tue, 14 Jul 2020 14:23:45 -0400
Message-Id: <20200714182353.2164930-35-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

Enable JPEG3.0 PG and CG for navy_flounder by setting up the flags to the ASIC

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2af335b2edec..34f4e636b30d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -755,9 +755,11 @@ static int nv_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x28;
 		break;
 	case CHIP_NAVY_FLOUNDER:
-		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG;
+		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
-			AMD_PG_SUPPORT_VCN_DPG;
+			AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x32;
 		break;
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
