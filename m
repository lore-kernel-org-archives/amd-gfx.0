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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F52C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024F6223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAysC4oM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024F6223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E0756E868;
	Tue, 14 Jul 2020 18:25:03 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 857F46E865
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:25:02 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id z63so16489046qkb.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D2rV6YqaZfNOUOUElAIml7X0AZqfyDh6fq9cJCuJXrI=;
 b=ZAysC4oMDQX8m12s/ATTUQW4tPGhwVhN6MAqc3iJTBU3hDGpCGs2wOrifG6oJVQnV0
 8DSm1rE/g8FA8uidDtAyUDgp/mLV6EbyI3/L91f64ZbVqsNlTfECW5OFiUKhM3ByY3oj
 0BbOvFoO1p/It9qz/n4h5ZsCWYRsBR25iBOqM9hHKTvseqKiu22Hp6/Z/odnDpf40A12
 2vGnsIGfW6jANXJxWRZx/jYEmZZv9JQH44JaD2FLgTQLtVZ7T43yKbBejb9R+h3RMYji
 9PSlXLfa4JuVXC0bn121bO0QpPDz0THUT+wcbt+JZabP5I5UJq5ltDZSHLKthrocldz+
 06fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D2rV6YqaZfNOUOUElAIml7X0AZqfyDh6fq9cJCuJXrI=;
 b=s1/8Ahfq1Ppk/1BUg4mz+YmJfdG5XuCdDCXp3OQubprGcwj6Lx7HKx2hg50xwS3MtY
 Fyfy4DjKkdPTYBMlDNFuE0X7LcERGnGTHPR8LdK7jxKQWvFB0caORJm9k6N2nhsq6/P2
 YZsaKNhiGqdlNmPz9s+a8cIKjIv62dw6v8TzFqIRzi7rZf+0JYjpSRe/NfnzpLraQPw3
 R1dGSiWvxEGr6o3GwteWr6R5ns4yd2TvvvBf3rDqZu+HUhE3iykILp2jgxoOEoCbwDl3
 zY3A8H1uZUBnK7yEInu5S3nzgtfcQrhCuF80QfjO3w+YWhiz/v2NlhEkRY/tIUltwsWK
 SQcA==
X-Gm-Message-State: AOAM530sDcmUo2U+ncexBivhWti542zdUMTRSvBua7MZ1g1kljTo3m7l
 pEE3T+IQx9LeuoOomIa2nvkTXr1y
X-Google-Smtp-Source: ABdhPJxFYpc4oz3nVrJPR6SKtAYEV7Uh/4yAuRdmoyS2zcqhpkn5VOxcHImQNMeuI6PppPwcxGGWVQ==
X-Received: by 2002:a37:4592:: with SMTP id s140mr5678649qka.245.1594751101475; 
 Tue, 14 Jul 2020 11:25:01 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:25:01 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 40/42] drm/amdgpu: enable mc CG and LS for navy_flounder
Date: Tue, 14 Jul 2020 14:23:51 -0400
Message-Id: <20200714182353.2164930-41-alexander.deucher@amd.com>
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
 Kenneth Feng <kenneth.feng@amd.com>, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

Enable mc CG and LS by setting the corresponding flags.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 1260d7d138ea..add0698df3fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -763,7 +763,9 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
 			AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
