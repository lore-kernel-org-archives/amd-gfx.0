Return-Path: <SRS0=trOe=7I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A73C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 13:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277BF204EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 13:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz5jppIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277BF204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A988996E;
	Tue, 26 May 2020 13:03:20 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A7689890
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 13:03:19 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id n11so14912260qkn.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g4eRARDiacx8/5RQNlC50jVi7KPm/RKBqpassYqRRd8=;
 b=gz5jppIXC814Xg+LApP791zvf5mzy28hz4dFjEpGBJ3//JA0eg7HNxiKrixNCfhgFK
 bQveQTFCsNSf06jEoKlQv6ns9tqdK9CrZb6hlW+YYAeVdam5eEEPXPG2L7epIijMJFfR
 er2e5sFT37T8+hjoL7kToUAXlyxzxlF8xKoYRhgj/UUUaNHkc1neg465pNswo40UJz+R
 R43BJJzPYm0pFpKmDkqGVSUtQ+R23jfDTnXIdXshRU5mmPBdo/I3Rxu/R8PvsCEfkZWi
 AbFXEjweLhN4StSQGR1KtUn1sVRcXTITVyuUvVq5+Qk9v01+wLSSpdIU9GiAk2d6UKQC
 krrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g4eRARDiacx8/5RQNlC50jVi7KPm/RKBqpassYqRRd8=;
 b=ojvayOVIL5T90UHsqcdDTs0B7Ma1FjTW4ctLDwn/cBiT/n0OF9jFO97icfjgO+NCQl
 oYgyg3/hrkSFYlf48vN7NBfatg+gFQZUi4CFjbc1kzXDDbIMyo7RYOUg/Z8tgkcV7MaK
 BPJZiemd29AdkpASZFLxu8vJaTR00UmU98oIlmub2PCfYqR+YdTTMBhRct2aMfrPzoHD
 277cW8gNy9tkD0zY4+6fK7P6ipX6EZkcs3x6r+1DDg9pw+g8yM98AlsDuQH3ddHnS6VK
 pwdchCLPL7HXjc4QCEo5j65Twd2Y4W6w/AlgBTeFQWbFLI/CvBMHHlAAnnWxMesnLO51
 NiXw==
X-Gm-Message-State: AOAM532wQoV3Z52KaH52j+yUpXzuyHIJO8SbLmIeny0B8Na7ngcjC6Nz
 HGZZ8xLEl23+s/baQ0nAtbrsxxytDMcMxw==
X-Google-Smtp-Source: ABdhPJz7L0S8zT0nR9/KkqsY5ssZv1Ojhpu2JhJleoRgjDjtqGFerSdltNfUcci+09TZwAWKPdRCIg==
X-Received: by 2002:a05:620a:319:: with SMTP id
 s25mr1125371qkm.25.1590498198230; 
 Tue, 26 May 2020 06:03:18 -0700 (PDT)
Received: from localhost.localdomain.amd.com
 (p200300c58f3aed00c6c4febd9c19b346.dip0.t-ipconnect.de.
 [2003:c5:8f3a:ed00:c6c4:febd:9c19:b346])
 by smtp.gmail.com with ESMTPSA id a38sm7830915qtb.37.2020.05.26.06.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 06:03:17 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: remove unused variable
Date: Tue, 26 May 2020 15:03:37 +0200
Message-Id: <20200526130337.123848-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.26.2
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
Cc: nirmoy.das@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 1291bd70a2ee4 ("drm/amdgpu/sriov skip the update of SMU_TABLE_ACTIVITY_MONITOR_COEFF")

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 7f414034d2ef..67980f50d8ec 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1335,7 +1335,6 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 static int arcturus_get_power_profile_mode(struct smu_context *smu,
 					   char *buf)
 {
-	struct amdgpu_device *adev = smu->adev;
 	DpmActivityMonitorCoeffInt_t activity_monitor;
 	static const char *profile_name[] = {
 					"BOOTUP_DEFAULT",
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
