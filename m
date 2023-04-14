Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DBDC77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 12:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB68C892E4;
	Fri, 14 Apr 2023 12:58:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9933210ECFC
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681473834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EzZmygZ/h6mW1KymHJQMpqqwuqkO8pIbZa2IhX1gPjg=;
 b=PRN+r0Cw6gQZD1k3JNd7yLB8PN9owFpOciTwwPt2V4Ub3VRvWNYTSLbzAxiox0GC2G/gUZ
 W2T9NMZtjRMZ0BKsGv8qsAak3At6M4mStrl/w2MZGZlhKaB1bxilFYlVBnDXmQ3j7anXA/
 TE5kbGjB4MXX0AJwhKFIoZn7XyBs6Fw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-AvHx1KepOM2qfVk09ni8aQ-1; Fri, 14 Apr 2023 08:03:53 -0400
X-MC-Unique: AvHx1KepOM2qfVk09ni8aQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 d184-20020a37b4c1000000b007467c5d3abeso8874771qkf.19
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 05:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681473833; x=1684065833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzZmygZ/h6mW1KymHJQMpqqwuqkO8pIbZa2IhX1gPjg=;
 b=TvcibbcWgVrhRNKS0BN1Zh0WVdy9IJ0WhSvkmSbqW0TWO8UkHChywKVZvgBgy5hKkr
 SV5q2nAoUOoZWJSbdu0s0eel1BZ1c4D1Ns1EQe4KrWlQ/P4pboLMhO8dbWGmV3SkulOI
 92+gaUvWsq9Cm5SzHz0xqkEnZKfN0/dtNGI2ggV3XS9wMy7prUyxNOXjXafb5p1+espz
 X41Mto2L293rORYNaSi5EdWK0LfbIoLBAxzRxLhoKiZk7Y/tzRZl118s4h4rnLeihorp
 5z2pm7Rq6Ij002yCXp3tRw9g9E3UCMRmju3Ulk8byFwd1mAzfyBUzuuAbLJM5rlJVF1d
 liPA==
X-Gm-Message-State: AAQBX9d4z+iSjD7Qsj+ljIR+7YA3e+gt1gS3BTM7oK6vQ1pEI1Mwj3xz
 R3PnZXWM1vZ0oclEyBgReSkV0rD+/Xsq4NiMFY5m3nBwI5Np9T+Or470VRW/w83Zl+A7BN5q2rt
 8TggCdM1pyBsSA7LyNlDMyxNIJA==
X-Received: by 2002:ac8:5f53:0:b0:3e3:8ee5:1629 with SMTP id
 y19-20020ac85f53000000b003e38ee51629mr7740969qta.51.1681473832730; 
 Fri, 14 Apr 2023 05:03:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZD/j4DT8ikAl75WcXZCOLLsqk7WERFlQmI22J29ud9lx0mWwo6lSZErGjashkqixzZG9eJOw==
X-Received: by 2002:ac8:5f53:0:b0:3e3:8ee5:1629 with SMTP id
 y19-20020ac85f53000000b003e38ee51629mr7740944qta.51.1681473832463; 
 Fri, 14 Apr 2023 05:03:52 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a05620a084700b006fcb77f3bd6sm1168803qku.98.2023.04.14.05.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Apr 2023 05:03:52 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
 Hawking.Zhang@amd.com, kenneth.feng@amd.com, tim.huang@amd.com,
 lijo.lazar@amd.com, mario.limonciello@amd.com
Subject: [PATCH] drm/amd/pm: change pmfw_decoded_link_width,
 speed variables to globals
Date: Fri, 14 Apr 2023 08:03:44 -0400
Message-Id: <20230414120344.3170942-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Apr 2023 12:58:17 +0000
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
In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c:36:
./drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v13_0.h:66:18: error:
  ‘pmfw_decoded_link_width’ defined but not used [-Werror=unused-const-variable=]
   66 | static const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
      |                  ^~~~~~~~~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v13_0.h:65:18: error:
  ‘pmfw_decoded_link_speed’ defined but not used [-Werror=unused-const-variable=]
   65 | static const int pmfw_decoded_link_speed[5] = {1, 2, 3, 4, 5};
      |                  ^~~~~~~~~~~~~~~~~~~~~~~

These variables are defined and used in smu_v13_0_7_ppt.c and smu_v13_0_0_ppt.c.
There should be only one definition.  So define the variables as globals
in smu_v13_0.c

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 7944ce80e5c3..df3baaab0037 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -62,8 +62,8 @@
 #define CTF_OFFSET_HOTSPOT		5
 #define CTF_OFFSET_MEM			5
 
-static const int pmfw_decoded_link_speed[5] = {1, 2, 3, 4, 5};
-static const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
+extern const int pmfw_decoded_link_speed[5];
+extern const int pmfw_decoded_link_width[7];
 
 #define DECODE_GEN_SPEED(gen_speed_idx)		(pmfw_decoded_link_speed[gen_speed_idx])
 #define DECODE_LANE_WIDTH(lane_width_idx)	(pmfw_decoded_link_width[lane_width_idx])
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 73175c993da9..393c6a7b9609 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -85,6 +85,9 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
 static const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
 static const int link_speed[] = {25, 50, 80, 160};
 
+const int pmfw_decoded_link_speed[5] = {1, 2, 3, 4, 5};
+const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
+
 int smu_v13_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-- 
2.27.0

