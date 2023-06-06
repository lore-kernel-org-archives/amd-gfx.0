Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CD8C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 13:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9622D10E346;
	Tue,  6 Jun 2023 13:05:32 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E7410E2F0
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 08:33:53 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30ad8f33f1aso5120591f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jun 2023 01:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686040432; x=1688632432;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ixVKLJG1J3IvnujzAUwpwAiWuL5lceT9xTDyP3ttmAs=;
 b=Ft1ai+Nebad4F1ztgqj/bHSM3UpcMV0hLzfc2Yvd1I8NsAhtx50lHj67VHwCCLIoS3
 zNm0f8obTd2fFypVUKb7KY0w3taJk3vB7UA4CUuO4ada24UHRB4JZWpS2aEZOquwgB+s
 CsGyN97LMcMvXpkjPF+Ki2OAbf6RTjBbDlypjNdCKMAj9c74b5E9U8JkDmFz342c5VO/
 8bmgd0IrjRLWbibgv+EuXAo2FDSQnu5QpWK8cZrgwmEEnE/aV/zD7O/7Hql6ZIi2h1n8
 LD8HAwrfM++ZMlJ5ZyEHkZFKW/Z9KLI4x8OF78zPrRRfmzEmY25Nm3MdGrrzAziqYDc8
 qmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686040432; x=1688632432;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixVKLJG1J3IvnujzAUwpwAiWuL5lceT9xTDyP3ttmAs=;
 b=CeKSlkL6Rxo2Eb8YsIzpOyp2ikeOiwJvZPe+yYfOLm1T0fR5tNCl6lNHGSSb4NoiO4
 l/pLI74nhjbzOCxVuhQqzjfAJ4k6i6yJp1Zdph102yLuLxlwi9Z7Mt73LgmZnxED7ci4
 navFXD70jqbwDHvDtmt3wgjBk6IcA+z7G2iW9HloytIHMyJuKgDGvJaj7yqUKdYRh9Yo
 5ScMH9ZsGrys70DvEXMHaFo3Ul23riSVgvEQ3/Q+Sb69IroIrZatkW0zu555/yvzDL92
 NM/OGkYJksSj1PDcEtL02NDf5aAZM1L8OrlOEwJplrPP3FxQj2mF02uPsXIG3JGhgxnX
 BI/Q==
X-Gm-Message-State: AC+VfDyKLmr/dsU7q4ACjqUMBeE7lqaALgEtcJeQ1QoVSKUYqshH2EgC
 2JwVzdnC8yNW/S2QJ3wC92PW+A==
X-Google-Smtp-Source: ACHHUZ6lXzUpAjlfOeWOwBgeuDEnlhI2XzFjrVsD3GMCZ2NqsCr9yljQBRIfLU53A7J1i47n26l4xw==
X-Received: by 2002:adf:dec3:0:b0:309:49e3:efb4 with SMTP id
 i3-20020adfdec3000000b0030949e3efb4mr1196426wrn.63.1686040431927; 
 Tue, 06 Jun 2023 01:33:51 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 d8-20020adff848000000b0030ae849c70csm11965924wrq.37.2023.06.06.01.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 01:33:50 -0700 (PDT)
Date: Tue, 6 Jun 2023 11:33:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Evan Quan <evan.quan@amd.com>
Subject: [PATCH] drm/amd/pm: Fix memory some memory corruption
Message-ID: <ZH7vaonsPEHJpy1j@moroto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 06 Jun 2023 13:05:31 +0000
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
Cc: Horatio Zhang <Hongkun.Zhang@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Yang Wang <KevinYang.Wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, kernel-janitors@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, YiPeng Chai <YiPeng.Chai@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Candice Li <candice.li@amd.com>, David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The "od_table" is a pointer to a large struct, but this code is doing
pointer math as if it were pointing to bytes.  It results in writing
far outside the struct.

Fixes: f0a0c659fb96 ("drm/amd/pm: fulfill the OD support for SMU13.0.0")
Fixes: e3afa4f988b3 ("drm/amd/pm: fulfill the OD support for SMU13.0.7")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 5ac5ea770c1c..413e592f0ed6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1535,7 +1535,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		 * settings. Thus we do not cache it.
 		 */
 		offset_of_featurectrlmask = offsetof(OverDriveTable_t, FeatureCtrlMask);
-		if (memcmp(od_table + offset_of_featurectrlmask,
+		if (memcmp((u8 *)od_table + offset_of_featurectrlmask,
 			   table_context->user_overdrive_table + offset_of_featurectrlmask,
 			   sizeof(OverDriveTableExternal_t) - offset_of_featurectrlmask)) {
 			smu_v13_0_0_dump_od_table(smu, od_table);
@@ -1548,7 +1548,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 			od_table->OverDriveTable.FeatureCtrlMask = 0;
 			memcpy(table_context->user_overdrive_table + offset_of_featurectrlmask,
-			       od_table + offset_of_featurectrlmask,
+			       (u8 *)od_table + offset_of_featurectrlmask,
 			       sizeof(OverDriveTableExternal_t) - offset_of_featurectrlmask);
 
 			if (!memcmp(table_context->user_overdrive_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 0bd086360efa..cda4e818aab7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1524,7 +1524,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		 * settings. Thus we do not cache it.
 		 */
 		offset_of_featurectrlmask = offsetof(OverDriveTable_t, FeatureCtrlMask);
-		if (memcmp(od_table + offset_of_featurectrlmask,
+		if (memcmp((u8 *)od_table + offset_of_featurectrlmask,
 			   table_context->user_overdrive_table + offset_of_featurectrlmask,
 			   sizeof(OverDriveTableExternal_t) - offset_of_featurectrlmask)) {
 			smu_v13_0_7_dump_od_table(smu, od_table);
@@ -1537,7 +1537,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 
 			od_table->OverDriveTable.FeatureCtrlMask = 0;
 			memcpy(table_context->user_overdrive_table + offset_of_featurectrlmask,
-			       od_table + offset_of_featurectrlmask,
+			       (u8 *)od_table + offset_of_featurectrlmask,
 			       sizeof(OverDriveTableExternal_t) - offset_of_featurectrlmask);
 
 			if (!memcmp(table_context->user_overdrive_table,
-- 
2.39.2

