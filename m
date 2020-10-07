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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5607FC4727F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D542064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX3tZE/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D542064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E3E6E975;
	Wed,  7 Oct 2020 16:32:44 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0226E974
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:43 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id y198so3511453qka.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j0UoHdpyrxNmMpfurbGt0yCaQlveV1jiZOIkUbhjwXk=;
 b=mX3tZE/WP1/fp23WDBcOmA159LTaLjTU23vZmbJvKPX6kXIsninfL/PHRtFq5le6PN
 tS2BTFtAOmHQ+nLe5R4nscugb8ah/mba7STqdvw5HHwjFs1mnRyBBxoLVtYMfA83p9qA
 rZfy6mb+WEKjt1SMO/N090XaViiJnx2mgEXAU0k4T9jzPUHb3DUnY9n09Ck49xK4tcv6
 kb09Ag+W93GUgZHOnDnapF0HDLQEq4pbttqmDq84SHIl2kpf8Ug5r2uJza/7pj99jxm8
 9DbBDS7/Dm44tR4f6T05sLflw+ky8znjR74PLClLwv3EArP6AtxQ0W55+IfSeJ/cH4cY
 JHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j0UoHdpyrxNmMpfurbGt0yCaQlveV1jiZOIkUbhjwXk=;
 b=olycRBZiIkTTa3wXcPHFAn2eVFJ/qOgJzswqJanQdVF0PdmpuoQgH08adzNHB7NmDB
 riQNMVRFGTPLoJIuRXqT/g62LdX1/IcjdN89360HLxkMaHxSK4RYgoHPlL9/QmyESJHf
 7jJdtBWG83qwhUxILuL7Lf4NV0Iqo8GU5G9dDqlwBKqKclMf+OYfE5u6ks9qq+GSjHVl
 uG3wbXA0GKfIqrOI/0Nn8F4PpX6ch+W1X37Jfw2rewVRmNkyxmZqVMBNROO9fP8MjJV8
 Cxrf1bCfVWkBhGVSFQVdHWVYysDt4kmLEZgiXqAdZbvQ7UNaQHtRA+vTdjCirV0j0n5Q
 coRQ==
X-Gm-Message-State: AOAM5312NaIWiZRkCu+YVhgwr+gTiGMFt7jIFAkACAac6UGDO+viUX6+
 CicoNyNyOt/Z/7yx53TT1L3BiV9bktw=
X-Google-Smtp-Source: ABdhPJym6LunYBxQOzeD5DTI6hykor82dJ7wCHypxGNFPN+nhR10FGNgCIE153VGDojHrFnGPF0xWA==
X-Received: by 2002:a37:a495:: with SMTP id n143mr3672196qke.394.1602088362464; 
 Wed, 07 Oct 2020 09:32:42 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:41 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 39/50] drm/amdgpu/swsmu: update driver if version for
 dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:24 -0400
Message-Id: <20201007163135.1944186-40-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Update driver if version from 0x4 to 0x5 for dimgrey_cavefish, per PMFW 59.02.0.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 4ce0d484b73c..9edc9f24746c 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -33,7 +33,7 @@
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x39
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x01
-#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0x4
+#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0x5
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
