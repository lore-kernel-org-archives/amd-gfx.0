Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAB2C5478C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 08:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C2A610EB40;
	Fri, 23 Feb 2024 08:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="SkX3qMOz";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 911E710E95A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 14:19:08 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-6e4d48a5823so236595b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 06:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1708611548; x=1709216348; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WGPosRtMSArWndWjzJ9481uweCFGTHltu8X2CabZAF8=;
 b=SkX3qMOz2RGL3HkXMlT3cur9G1GouD9J1WV3pG9oBV1foOyIDIsHoo0ICmE9jTHZI5
 mYj6e4mcl655zhWWTQLX/fpPk20ON4UURAG2oK0RUcbtDJudVQuCmrzz4OqQExYbjM8n
 2d/pCGT2WRTpqinNG92gbz5TFWGRDDO+RWi88/HBhU6nzTEXJZjHz296KeH5wMEDI+XO
 Y9NvW0/1xoIAbeQ0wA8fip0ZW+BtVPJjWoJH5U7ZLAGqRNiVvFN5s//fmkpOGMXOEOyi
 FZwOK6upgKpRetT31hvag/wizFoa+bl8G0p7hjcrsv1r3IaoIiZb3+vFvT6gBKowth6u
 JWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708611548; x=1709216348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WGPosRtMSArWndWjzJ9481uweCFGTHltu8X2CabZAF8=;
 b=jYi6P+SsqEQKuwDhE+bnNNtmBfdzbz7RiFr0FZw0RSyaIIyQ3A0NbAM/vJ0R62zfg6
 SMdF1ObS7Nuk+mRdfHe25evjAeGL+TdLln1zNcxKL9UquH4qr5mUiP+FSaj9JdJpdbfz
 OhsRiDvHmlYS9oqYMBzOFxu97JZpTKd05Nf8XoHJzU0rhezqXAIm0Ay8IhCfiJw+bnom
 Ea8wlS64/KGFznmK0jOBZ7Nx8hEZRE8IYab/2S5ATAeKvwiBzdz2FwB3sodJCNnk8hrQ
 edGolcVZqQzpOdFWy3mh78TkAHhgrLAPPCLjGsAM6ChibRarMmFencDRsVmuFK8NVT+g
 XL4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXUBmUIc3GsB2YOdk0JqD/GnUR94wxWZX1/Pw8oEh/pt7G0R2iR7G8bQlKAsSwHPoQSO/CtcAbLpQ1JRbx+emxGnv0NWKOFBn5ACCXlA==
X-Gm-Message-State: AOJu0Yy5oVNqnZ8Af/PkXuUYCagkYKoymPeIQfA3WYiB8gu5EEgflNC3
 9ywpAwd9urjCPK/iJZQKrrpTT2yVHotZZxM8Q8kLHQDQjj5HIlJsgNwiYqRukGg=
X-Google-Smtp-Source: AGHT+IHeireBxnEc2NlixryU2+IL2Al6qrZ952mZYAql+oMsMKKQF7Ttr/F3G4+bmBhDgUqAzV4gwA==
X-Received: by 2002:a05:6a20:e68c:b0:19e:44c9:cdd4 with SMTP id
 mz12-20020a056a20e68c00b0019e44c9cdd4mr20657777pzb.14.1708611548072; 
 Thu, 22 Feb 2024 06:19:08 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:63:8e10:b166:c84d:a12c:b836])
 by smtp.gmail.com with ESMTPSA id
 t185-20020a6281c2000000b006e0fc1ed2b7sm11021583pfd.134.2024.02.22.06.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 06:19:07 -0800 (PST)
From: David Tadokoro <davidbtadokoro@usp.br>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: David Tadokoro <davidbtadokoro@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Remove duplicated function signature from
 dcn3.01 DCCG
Date: Thu, 22 Feb 2024 11:19:00 -0300
Message-Id: <20240222141900.295254-1-davidbtadokoro@usp.br>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Feb 2024 08:56:15 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the header file dc/dcn301/dcn301_dccg.h, the function dccg301_create
is declared twice, so remove duplication.

Signed-off-by: David Tadokoro <davidbtadokoro@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.h
index 73db962dbc03..067e49cb238e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.h
@@ -56,10 +56,4 @@ struct dccg *dccg301_create(
 	const struct dccg_shift *dccg_shift,
 	const struct dccg_mask *dccg_mask);
 
-struct dccg *dccg301_create(
-	struct dc_context *ctx,
-	const struct dccg_registers *regs,
-	const struct dccg_shift *dccg_shift,
-	const struct dccg_mask *dccg_mask);
-
 #endif //__DCN301_DCCG_H__
-- 
2.39.2

