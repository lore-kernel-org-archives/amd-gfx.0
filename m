Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8903DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1943710E81B;
	Tue, 22 Feb 2022 14:06:50 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3929010E624
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 13:17:47 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 w10-20020a4ae08a000000b0031bdf7a6d76so17385967oos.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 05:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usp.br; s=usp-google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yJggk1To+XLut1ObcBuO//1+OtwNQL2IY8utthiAw+M=;
 b=M5U+hrmDa39RJmpT6cpDMWuT1ftn8C6oDHPdv+0YjkKjP3plzi/1n7Yos1ZJvj5TWL
 oSJ6jfHTPW6wOoEzXfnmv0O6XULQpIlFFRouo6PlM2daWq3ng4LttobHWIUFfhweB76U
 cbnu0WB5CVQAQUu+9ZsF71wZFXSr5Tr2Q3GSMDmVZTSvqqUBxkN8maDIQdoR6mbTHnzl
 +sXNxOLwoN5wFXpDoydePtV49H1x/bexC6s0pumgdWV1YSFBFau+iHG9qfZvXDzLh5Dp
 R5V1tJuwXzwOTm8SeUcVi5RKzf90KB6fCi/7MmcsgKU7TGU4UFNug4thzgm77mP9WDgN
 jpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yJggk1To+XLut1ObcBuO//1+OtwNQL2IY8utthiAw+M=;
 b=h6DdR+xnEpBjitUWXTTPJU6XVPbRYfO97CFOYewVgOlzNr9fXK2/dB2Bb6bvR9M/Me
 H51DAEEZIeuFtdepeaAdgk5WcnqJuRza50UQCQNkmTwmiMjbvl16GVz7fjqjcq75eSis
 N6w6ePuI0Iqd/M7zb0Va7tI4td7P7PG0TJ7qz2awKzq62/YarEP7UfN6k6I3d91NdRTr
 8YyKiYKI43VnFSicWbZO3Ir4QgBVplqYhM2x+1ohxbt36Quwwkd7UifhLI83ZrIXnUGM
 n6T/v/d+bkZrFbF0zXMj3aOlWAcE1pW7b08ctPYFaGGUtJu7ukJoM8HNkwL0qqB424DB
 +mLQ==
X-Gm-Message-State: AOAM533Wb4j+4SqUjiG2pr/coJRjEvs2dftK2ijRggfr39rn0CrghHsj
 qK89zgZvAfIF9i3D24CnjlzJkg==
X-Google-Smtp-Source: ABdhPJyEmLFkADch2Vvvvc2TiPZFt4fsErzfmYtqCPhQrfpy8eB9rJIReQvGDozdKk6LKkOtj8RqLQ==
X-Received: by 2002:a05:6870:c898:b0:ce:c0c9:660 with SMTP id
 er24-20020a056870c89800b000cec0c90660mr1543821oab.178.1645535866494; 
 Tue, 22 Feb 2022 05:17:46 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
 by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 05:17:46 -0800 (PST)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 Hawking.Zhang@amd.com, john.clements@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, luben.tuikov@amd.com, Stanley.Yang@amd.com,
 Dennis.Li@amd.com, mukul.joshi@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, Anthony.Koo@amd.com
Subject: [PATCH 02/10] drm/amdgpu: Remove tmp unused variable
Date: Tue, 22 Feb 2022 10:16:53 -0300
Message-Id: <20220222131701.356117-3-maira.canal@usp.br>
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

The variable tmp is not used in the dce_v6_0_hpd_fini and
dce_v8_0_hpd_fini functions. Therefor, the variable is removed in order to
avoid the following Clang warnings:

drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:331:6: warning: variable 'tmp' set but
not used [-Wunused-but-set-variable]
    u32 tmp;
        ^
drivers/gpu/drm/amd/amdgpu/dce_v8_0.c:325:6: warning: variable 'tmp' set but
not used [-Wunused-but-set-variable]
    u32 tmp;
        ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index b90bc2adf778..2c61f0c2e709 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -328,7 +328,6 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
-	u32 tmp;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -337,8 +336,7 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *adev)
 		if (amdgpu_connector->hpd.hpd >= adev->mode_info.num_hpd)
 			continue;
 
-		tmp = RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd]);
-		tmp &= ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
+		RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd]);
 		WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd], 0);
 
 		amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 7c1379b02f94..c5e9c5dbd165 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -322,7 +322,6 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
-	u32 tmp;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -331,8 +330,7 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *adev)
 		if (amdgpu_connector->hpd.hpd >= adev->mode_info.num_hpd)
 			continue;
 
-		tmp = RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd]);
-		tmp &= ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
+		RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd]);
 		WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd], 0);
 
 		amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
-- 
2.35.1

