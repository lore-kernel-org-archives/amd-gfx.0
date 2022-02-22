Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D443C43219
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D89310E840;
	Tue, 22 Feb 2022 14:06:51 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C33F110E61B
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 13:17:39 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 s203-20020a4a3bd4000000b003191c2dcbe8so17413410oos.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usp.br; s=usp-google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8PBq7kLR2y8s9lJx+dEOyUvKlmC0izFjBVBTrNAah9s=;
 b=zDyEXMRdcUX5t9jSuG3U62H5xWO+QvfUk2ZhsY58HqOIx9ZnUABFz3X6sbr6HP2ZhL
 ZkFEielo35ToVAG0T3KZnKFZq+ielr9LclAFAtCFbGqTnnYtoKb7yn+g2Wh/D1oyNezp
 0RzfGweLjxjfmYxWe3eS/tpFENTrHDFIM1lRMKJfCTu5sLLvV+KgHW/UD4nV2hJu5/ru
 vHNnxC1OY2tbeUAWCE6VEdaA3Pmothkk3CLzUH7rW2rSEu81lUeI6kTuGObzanZXxggT
 n5njzrT5GV82couAkS7S9CYMi+8RD1d+knUl/5DwG8spMBQ1BE576XER/mfh9CqYZbnp
 VScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8PBq7kLR2y8s9lJx+dEOyUvKlmC0izFjBVBTrNAah9s=;
 b=vWScGM7LPCIxX0PHpmpHrJ4y97OpM0wMaAaizz7bHCr+ck5WI4R1TzMNe6Uoay/mrP
 uKP/okJqd+U0SSSb2erG01b7OJSc7EVQw7owzjhgC59XwyuF/V/snfRlJ0V1Cw32i5Zc
 BophHQl1FXsUCvfAeGr5wf1XLAa2+udZUnoLKoTBMeZpcxs+ZfFAgcntETNWyeakrfQQ
 l80aS7z/IQP1clbGaQe0uz2LPOTibVmBsuemVtDQ1f/7Jkh9Xw1inN3tchIEZ34Kt05U
 XNtMEPPO5xFXVzxghROg8VhI4QetvgGQOuJTZIeXixghrbbcnUZgliVA3SnLlPCZnkvM
 IAUg==
X-Gm-Message-State: AOAM530LrgJI1OHjTD5dmI9U0LS716JemsNs9FjSvAyXzSBA/+chYRBk
 DdPgd09NUPkQ1ej2ii0hiqlEQg==
X-Google-Smtp-Source: ABdhPJw09Q2GTtVLbWQ/lSO046k89Fi/+pAQfC7O7eca3GixOjwGWDj/ecijDSXxl83tN2+o5PHkWg==
X-Received: by 2002:a05:6870:580c:b0:d1:7d97:19a with SMTP id
 r12-20020a056870580c00b000d17d97019amr1592418oap.281.1645535859003; 
 Tue, 22 Feb 2022 05:17:39 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
 by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 05:17:38 -0800 (PST)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 Hawking.Zhang@amd.com, john.clements@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, luben.tuikov@amd.com, Stanley.Yang@amd.com,
 Dennis.Li@amd.com, mukul.joshi@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, Anthony.Koo@amd.com
Subject: [PATCH 01/10] drm/amdgpu: Change amdgpu_ras_block_late_init_default
 function scope
Date: Tue, 22 Feb 2022 10:16:52 -0300
Message-Id: <20220222131701.356117-2-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222131701.356117-1-maira.canal@usp.br>
References: <20220222131701.356117-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Feb 2022 14:06:42 +0000
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
Cc: magalilemes00@gmail.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, mwen@igalia.com,
 amd-gfx@lists.freedesktop.org, isabbasso@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Turn previously global function into a static function to avoid the
following Clang warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2459:5: warning: no previous prototype
for function 'amdgpu_ras_block_late_init_default' [-Wmissing-prototypes]
int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
    ^
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2459:1: note: declare 'static' if the
function is not intended to be used outside of this translation unit
int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
^
static

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e5874df3c9ca..dff5240efcc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2456,7 +2456,7 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 	return r;
 }
 
-int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
+static int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
 			 struct ras_common_if *ras_block)
 {
 	return amdgpu_ras_block_late_init(adev, ras_block);
-- 
2.35.1

