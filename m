Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8044DC433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D3020738
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anjUYqwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D3020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A7C96E314;
	Mon, 24 Aug 2020 16:15:57 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 603956E30C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 16:15:55 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id m7so7865138qki.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=msJrEhsB7QgClSWliPWpRiF5oCt6obmXcLEN4KQvRvk=;
 b=anjUYqwfMgJ8ZTQAXJ3iHJ8KGHg4tO1uXOCLiS3CmAuwEahRi6kc7QIfdxWv3s44qh
 OJA6uqFFU24HzfCtRVVp9PM4lBSjtFLt0N7Y8q/28L4DcPxxjk42Cw1bBR86Z0Id+18J
 6SwFTys5i67TWwHE2lwwCqjLwV7gKOE1zxV1sl+2o3xzcZPML/k2cTEWIH/cbshlDMUp
 cOPlx/q96/3GyW34iJXtGjAK7U0kn20MLVIQJTqKjxmD0Yj7Z1+RgAy/Bq87jLPowVzT
 tUf0JuF5SKlGUEECPA8omvPBrS8kW6Lz5SzMmse/h4KJMZU3HVtYAhQIZGY12iEbWySF
 nNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=msJrEhsB7QgClSWliPWpRiF5oCt6obmXcLEN4KQvRvk=;
 b=AgpzTuhlQ+sfnP4gIFKgT0GTWy52vjyntMYS1KNTX73wqvwtVumjrYNMuezungN6Nm
 zJeK8XDQaTTJQ53fr+R2R/opGwG6E1PlKSQihkqvm0HA3ault24he0icGGMSSdlJvT6B
 0U34/D/ueRQRen5qFSK05b1BH0O6LW3cbfGIN6jd5uqBieWvJeOQENkH6xm4iHJgGZ3K
 N7AAnZ87Szq0CZY82K0j6gvaDpfUBFxRSF7ydqgleRx+8Go+Z3gEkWMTnTH0NTKlLLm6
 lNKmvMWTm/4nOHJz4WOuOiRV73lcShtZ8YEFJi04EyWcownw/1q2dlCQ9QMJxic4NbB/
 kKfQ==
X-Gm-Message-State: AOAM5323l8e2atnarWFnpD8KSui430n2Uj6odDmkwfIzu6D//30iuxK+
 JbGk6Ka7qhZj0nEYjaBw4kliRR2lt18=
X-Google-Smtp-Source: ABdhPJz61Ze51GP2/3vcRFvIc+439X72bR7J8MErG84pwc4Pcg/Di7ZfdYR8ZvYVtpPBg02nAV5+Wg==
X-Received: by 2002:a05:620a:2481:: with SMTP id
 i1mr5250294qkn.139.1598285750272; 
 Mon, 24 Aug 2020 09:15:50 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id q7sm9654097qkf.35.2020.08.24.09.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 09:15:49 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amdgpu: add pre_asic_init callback for VI
Date: Mon, 24 Aug 2020 12:15:24 -0400
Message-Id: <20200824161527.2001591-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200824161527.2001591-1-alexander.deucher@amd.com>
References: <20200824161527.2001591-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Nothing to do for this family.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a92880c67841..9bcd0eebc6d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1068,6 +1068,10 @@ static bool vi_need_reset_on_init(struct amdgpu_device *adev)
 	return false;
 }
 
+static void vi_pre_asic_init(struct amdgpu_device *adev)
+{
+}
+
 static const struct amdgpu_asic_funcs vi_asic_funcs =
 {
 	.read_disabled_bios = &vi_read_disabled_bios,
@@ -1088,6 +1092,7 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
 	.need_reset_on_init = &vi_need_reset_on_init,
 	.get_pcie_replay_count = &vi_get_pcie_replay_count,
 	.supports_baco = &vi_asic_supports_baco,
+	.pre_asic_init = &vi_pre_asic_init,
 };
 
 #define CZ_REV_BRISTOL(rev)	 \
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
