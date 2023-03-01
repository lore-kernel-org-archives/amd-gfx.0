Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8919CC7EE36
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 15:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1704610E0D6;
	Wed,  1 Mar 2023 15:43:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 868EC10E26C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677679209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CL8E0O6RN+NrPQ/BLg0Ur8+SgAnEDTABwI3zVV7mIYc=;
 b=hUmHuq3N0NccMv9tmR1cdARk0HgzIPBgeebM0frKQix7K4ZJA7cdTin5BU2HtpGkUYTNAM
 OL+J1DiJs21zXAq0QebIRnI/An6eiU6gxBkquPvTSwsveQ6fKcmRwUlBU9aP3dN1vc2VBG
 qFSJWbB8a7eNa2RPmP/+3RZ854CJZgg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-269-9eS4x7bkPD2_w74GCtcl7g-1; Wed, 01 Mar 2023 09:00:06 -0500
X-MC-Unique: 9eS4x7bkPD2_w74GCtcl7g-1
Received: by mail-qk1-f198.google.com with SMTP id
 d72-20020ae9ef4b000000b0072db6346c39so8081651qkg.16
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Mar 2023 06:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677679205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CL8E0O6RN+NrPQ/BLg0Ur8+SgAnEDTABwI3zVV7mIYc=;
 b=PUEoWjd0YUKndfCWSY5GOSvj++0olCI4nD8+4oqF5UmUDwcKuwr9+8BPaC4NU+cOC7
 OdFTjaWg0OXY4/dBGG47n0gAFR65GNRYMB/94iUJL1e1GRFM2+XbKtKp2A+/sdB9WS+9
 Bd3ojc+MdcmDxAmTuwZl8PCaChNnzVfW/h0HtPQ39/+VfmD2RrL/8cY62UPa2IofOwqX
 NEhV8thXoyV+HhFSu7Hg0gG2oTC/q3HXWLS/TdJQWIp8RJB4ucQ6jTlXURtGHFVKnw2k
 W3xv7WXT0yI2ZGtdETOCo8WrsBpElrHfquhJzWXUv4l8EDYZmfBjxpXOMHjY35/UADEh
 B1Fw==
X-Gm-Message-State: AO0yUKVHPT5nT3CO1kfz6G9efAftlbEAkcx2g9kIPV1t6CZ4BXaVPsfk
 269XyyKoYgMRL6aU9S0fiViVZT9BpyUxuVf0NHy3VJ7djqFKVuTMQn9kXFRw18pP4io0B4+HUSR
 qnuwcvZkvpUSABjPZ+hBO9Oc/IA==
X-Received: by 2002:ac8:5a4e:0:b0:3bf:e320:ba5d with SMTP id
 o14-20020ac85a4e000000b003bfe320ba5dmr11526512qta.17.1677679205436; 
 Wed, 01 Mar 2023 06:00:05 -0800 (PST)
X-Google-Smtp-Source: AK7set8dWK4c13zlMSqeRkUXAOU6QC6GcZMEJsa/xNpp+NtbXPm/fld3f2OETxlRbgVc4VZpjYjcQw==
X-Received: by 2002:ac8:5a4e:0:b0:3bf:e320:ba5d with SMTP id
 o14-20020ac85a4e000000b003bfe320ba5dmr11526351qta.17.1677679204525; 
 Wed, 01 Mar 2023 06:00:04 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 t128-20020ae9df86000000b0073d7e81f8b5sm8801235qkf.35.2023.03.01.06.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Mar 2023 06:00:03 -0800 (PST)
From: Tom Rix <trix@redhat.com>
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
 andrealmeid@igalia.com, kevinyang.wang@amd.com, li.ma@amd.com,
 Kun.Liu2@amd.com
Subject: [PATCH] drm/amd/pm: set vangogh_set_apu_thermal_limit
 storage-class-specifier to static
Date: Wed,  1 Mar 2023 09:00:00 -0500
Message-Id: <20230301140000.2719608-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Mar 2023 15:43:23 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gcc with W=1 reports
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:1600:5:
  error: no previous prototype for ‘vangogh_set_apu_thermal_limit’ [-Werror=missing-prototypes]
 1600 | int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vangogh_set_apu_thermal_limit is only used in vangogh_ppt.c, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 016d5621e0b3..24046af60933 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1597,7 +1597,7 @@ static int vangogh_get_apu_thermal_limit(struct smu_context *smu, uint32_t *limi
 					      0, limit);
 }
 
-int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
+static int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
 {
 	return smu_cmn_send_smc_msg_with_param(smu,
 					      SMU_MSG_SetReducedThermalLimit,
-- 
2.27.0

