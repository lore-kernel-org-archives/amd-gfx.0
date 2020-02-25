Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F51C35E04
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 20:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6323421744
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 20:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhF46UmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6323421744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230706E8E7;
	Tue, 25 Feb 2020 20:32:33 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F19C6EB8F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 20:32:32 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id b5so475436qkh.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 12:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MVjXRcwzuMtuqxhpd7jBiqivYkgtAepVMpzY6X0AW38=;
 b=hhF46UmEHmLkuAte24jMHHwWhPxEr6xtOZ3AFOSv3d9GHwXP2yL9//39CWFzDkJLLA
 weRGnAPgtZWMZSwdzCRscAEN5/pYt3OfKJx60Q11JBtXTZzslFV1W7Ql+sYihJeo7dFM
 2cViAQ3/rO0tLiZF4CME52IH97BO/wtMoFjfeRGmCgh5PeZd5DFhSKWMUIa6qiJavzHJ
 hvEW4UeHpXS7ratwisvnt0tG3K17y9Sj4BwZLBAFK4FcnjA43frl1zHPZJp9JRpC9pvX
 hfhV3wmlRkPuMAKhRbLBoEokmL6i1QE+7eBnwbZirYfUfM+Noh8xA1gyX1dftkA0o4kM
 zpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MVjXRcwzuMtuqxhpd7jBiqivYkgtAepVMpzY6X0AW38=;
 b=tcpe1f4IlAtEHHOBixoWodIlG2puTz/ODs8j4d1FTUmQuBsXObm5yF8/0DtpCGNVar
 bS2WcxDUP2rLNoab2jERmRSkJYANSoU6XQaeB0C6xFncuLx6HGIQ9hI3rwrat8HjKjfh
 B40+h7Yf2tdqqUaVyqOsKzlslQjvifSx5WnLCMz36QR4p6FUygXaM9m71wL2MRbcHun4
 U0QCEhJ09CrbotFK8p5nHVEZCweDQhBfHU5Y3l22SzIGtUwwcJyL4j/g0MJUiL9e5Xem
 DrhsJ1/943fTcWkEy9pJiYKAJcYFSPCVFBNfXJN58audoWlJmxYU1+qGt04Q99S5t2Bs
 gC5Q==
X-Gm-Message-State: APjAAAVU7rVU65JzGdRris8WjZ/NCW7D4q3FZvlWpOhkV39Bds16oEv1
 /7OXj5anWRyk+63GinaEXMbW6qKu
X-Google-Smtp-Source: APXvYqzmmm39dud3dujKVCRzruJYhmN1HXqg5Hzl6SbApULh7XS6Nv6ChhemO1dg+JjS1E8gaQQksw==
X-Received: by 2002:a37:a38b:: with SMTP id m133mr854080qke.418.1582662751062; 
 Tue, 25 Feb 2020 12:32:31 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id h34sm8219530qtc.62.2020.02.25.12.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 12:32:30 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching
Date: Tue, 25 Feb 2020 15:32:23 -0500
Message-Id: <20200225203224.1129396-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aly-Tawfik <altawfik@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aly-Tawfik <altawfik@amd.com>

Use the pci revision id rather than the asic silicon revision id.

Signed-off-by: Aly-Tawfik <altawfik@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0c55d44c9d5b..92166150bf9f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -902,7 +902,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.asic_id.chip_family = adev->family;
 
-	init_data.asic_id.pci_revision_id = adev->rev_id;
+	init_data.asic_id.pci_revision_id = adev->pdev->revision;
 	init_data.asic_id.hw_internal_rev = adev->external_rev_id;
 
 	init_data.asic_id.vram_width = adev->gmc.vram_width;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
