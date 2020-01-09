Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98938C282DD
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 20:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623FF20721
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 20:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNU3eNvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623FF20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E474E6E04E;
	Thu,  9 Jan 2020 20:45:01 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA0B6E04E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 20:44:59 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id n66so3529971ybg.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2020 12:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zRF4M8OhlsupMp39sFWiELd0khlr5YUkoAst1HDEkfE=;
 b=QNU3eNvpDQtBmJJEgxbq5lESE+YxZxDXB4WKT25m4ETd/lpzcuqI5naA1bNcBLLHje
 JFbSja60MIjT1Qs0zv1RlG8NA1XeePlSED0CL1sMauw0GlpsgroJDwgWno+dQjl2VpOv
 Q66PQObas7EAi+ylSv3YHltvu2dJo0DI6EPNL8OKGgC2nekvXGyMmx1Z9CGAGk0/1rFb
 EJEo7o7HpbMHWtDi7nDj5XKG5paLu8ncVaLsSiIgttenbFRRNW6HTm/INmJeJCa8mbo9
 CfbFrV/z1v+TZCG2J/afdloVRkjjwnLPyAYxA6P3YXPFnUoV4TPQB4En5yxL9toL+QWB
 o4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zRF4M8OhlsupMp39sFWiELd0khlr5YUkoAst1HDEkfE=;
 b=bDYs0ZcyqgtYl6AQ8A+RJSr6JnVTYpRKkQ0l/VyGoWNBB+5HndtWJ18ATdyXI5l55y
 9gN5tWyPe+x0VxbcgGCizVh9Gyt+zHU21JMnaZ3vO9BDFMYxlCCvlSkJ2pxsPQnTCsvk
 hkQMBaPfVm/mv7my3Dw2+LekKdYX5MmTAtlwfxWeqIgGaVFtArcVFfc8ObC8ew2JcNdx
 90dz8pQx8JwmG4Q9K6VuCtektPBqDjB2KtwTnviHSS+BSdMT2v3WNohFWAh4PSoaU3nY
 xbo6MO49Itg8+hM1IDyYqtBpo0E8DHDaHv9GtmMxSOb8/r46QDVvoSFsWSA4y8ZQMCB5
 ILdg==
X-Gm-Message-State: APjAAAVdl9udvwF+8e2ay+LoGNgO75pEJ4ulMSHTKxlmkjtBJszGuKfE
 pHULFN7K743yiyP+9Kqg5r+ttFCA
X-Google-Smtp-Source: APXvYqyZVNwZCrpqIi0cIVC7Ghzv8Y9Ddfb4vjdAFhPRec3qjN795z2ovfUAJYbSl/pzW0/wy0IIxw==
X-Received: by 2002:a25:449:: with SMTP id 70mr10127286ybe.50.1578602698935;
 Thu, 09 Jan 2020 12:44:58 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t140sm3673584ywe.28.2020.01.09.12.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 12:44:58 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/powerplay: fix warning in smu_v11_0.c
Date: Thu,  9 Jan 2020 15:44:36 -0500
Message-Id: <20200109204436.1184619-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cast to make min() happy.  The values are well within
range.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 76bddd582c60..02f8c9cb89d9 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1159,7 +1159,7 @@ static int smu_v11_0_set_thermal_range(struct smu_context *smu,
 
 	low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
 			range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
-	high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_table->software_shutdown_temp);
+	high = min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_table->software_shutdown_temp);
 
 	if (low > high)
 		return -EINVAL;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
