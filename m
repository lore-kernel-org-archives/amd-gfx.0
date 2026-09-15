Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ED2C88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B8810F322;
	Tue, 15 Sep 2026 07:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CXRIKr0/";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAC410F7F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 00:54:34 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c25331b31e8so52634566b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 17:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789433673; x=1790038473; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hWZ4Y4zJql57aJqzMLFBZaa2Td+FuNKRPfVlv/bP7Sk=;
 b=CXRIKr0/ZmMDrS73QRqW4KiweIpOB79NuQakt8Xw2/Mc1qoym3pK1rd1W61GFrN4LV
 JHk0eA2GLD8O4KmVCHA1Nw9o5Xmatsr6lMODE+P9kjbILQDKcECPZ9bX/bQFnTRXQIYb
 e/3hB+90wZ0D99D81uVpXwjrsNfvuYb7JD6GsDuJeeud/h3l7YnSrhfaQ2hDW9TocA/A
 JfZwQNvQX922M76nyqM02hwHL2WRsgTugiWBUbfjfHtPj75hzo1N8XHMqK+W0ra99giw
 cUUTdVPchPLxh3aiJj89cO5n6H/Q2B1bMmrJCiYV6NjJKKxYoIp/krSE1TMsnr7jjhKs
 WYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433673; x=1790038473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hWZ4Y4zJql57aJqzMLFBZaa2Td+FuNKRPfVlv/bP7Sk=;
 b=pSmf0BnJbf7vpCpLgL3gF1cWodaRBRyOdmqPvyG+W/XKSn6khVVkoHQh5yxRpHI+AN
 wgPqJBviPYyAnU/DE4vl4PAwwavHCvxcAz15aVo3U3uaUPCMb65xbvQa9HTIW8sQJut7
 BU43EuKvlGDVHiTSz+vxV+ymDqkEZoAsNh13VuZ3q1PvYvTILxyLchYhLzymPtVFq1L5
 S7arrFreKdMXi2CAOZXXK8ieHyq9xLbjVR22oiiz7S6gVi9koXtvMYrWGqcSDrX2UtNx
 MMHX+MPAQMXSs1lzjITrJSkbOd68n7wxJiwbT9At8bUAn7IVsH6Tzo7amkrUv0tGBJps
 pXhA==
X-Gm-Message-State: AFuF++moc95mKWXMB06aFaETIido9m2UUdyDJFphrwF5KTCmuq3XCZuh
 KPlTe1OAVgSpotDQyw5sRQqbS9jjSF3YTsggmh6p4ankufH3lX/HSAN9+jTa62YyBLWRNg==
X-Gm-Gg: AYBFou3iamvx9kwwP52YnX4hWa0GKowr8cszs07HigVaKAdV0yrrpMtZWiLbjnXcAUN
 Uk5HOXzbCqEWLOCBR+ogv3HHKSqoDyzR8KnFnCvDW/ZHMhY32I2YfFXUyUyQzGsGNrKPQ14Pv6i
 H4F9iysRK1vm94KxMpAtUQT50NjyYqkWtJvtuigcHfBKYSTP4xDEd6RiwV2d6f4dJthiZ18hrXa
 JYNNP2dFhn0+CT+7VIWG0JkZX9Rf9Hlavrx7uzuCl9KI0Wb39OAlDOxX1ZqX2ZNGGt1Gw9Pry3g
 9ba8wGFbmiSphw/KtVXnxyxyR9OUCF0piZ4voR2NAJmoMay/O4iTYOid/xlfyixriaMBEVrjRky
 i/ZOqocUsdq6mhNt/Krg8l/d6618KP0UoZcVySRWyS6SIDseI2Uht43D6dfJV1bjxDAvd8M9wg0
 kb3Zdspfqlj9W8W937t8t6Bz3LtJI7fB9/5C5y6ZPeF8YxP60Hbu/Eb/P22mfQxwDbIo8rl+M/1
 EId9Nzfj9fVUuw9/bQ=
X-Received: by 2002:a17:907:9491:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c29b881e271mr346326166b.4.1789433672479; 
 Mon, 14 Sep 2026 17:54:32 -0700 (PDT)
Received: from Nuel20.localdomain ([105.113.65.85])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29660ead67sm501097966b.51.2026.09.14.17.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:54:32 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, bhawanpreet.lakha@amd.com,
 Wayne.Lin@amd.com, ivan.lipski@amd.com, matthew.schwartz@linux.dev,
 Jerry.Zuo@amd.com, chiahsuan.chung@amd.com, emmaonana18@gmail.com,
 chen-yu.chen@amd.com, skhan@linuxfoundation.org, me@brighamcampbell.com
Subject: [PATCH] drm/amd/display: fix kernel-doc warnings for
 amdgpu_display_manager
Date: Tue, 15 Sep 2026 01:54:21 +0100
Message-ID: <20260915005421.20570-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Sep 2026 07:32:47 +0000
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

scripts/kernel-doc reports missing and excess member descriptions
for struct amdgpu_display_manager:

  struct member 'power_module' not described
  struct member 'hdmi_frl_status_polling_wq' not described
  struct member 'hdmi_frl_status_polling_delay_ms' not described
  struct member 'boot_time_crc_info' not described
  Excess struct member 'dm_boot_time_crc_info' description

Add @power_module to the main struct doc, document
hdmi_frl_status_polling_wq/work/delay_ms with separate inline
comments, and rename @dm_boot_time_crc_info to @boot_time_crc_info
to match the actual member name.

Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3524931451c8..61756c089fcc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -330,6 +330,7 @@ struct hpd_rx_irq_offload_work {
  * @backlight_link: Link on which to control backlight
  * @backlight_caps: Capabilities of the backlight device
  * @freesync_module: Module handling freesync calculations
+ * @power_module: Module handling power calculations
  * @hdcp_workqueue: AMDGPU content protection queue
  * @fw_dmcu: Reference to DMCU firmware
  * @dmcu_fw_version: Version of the DMCU firmware
@@ -716,16 +717,26 @@ struct amdgpu_display_manager {
 		char reply_data[0x40];  // Cannot include dmub_cmd here
 	} fused_io[8];
 	/**
-	 * @hdmi_frl_status_polling_work:
+	 * @hdmi_frl_status_polling_wq:
 	 *
 	 * workqueue for 200ms frl status polling
 	 */
 	struct workqueue_struct *hdmi_frl_status_polling_wq;
+	/**
+	 * @hdmi_frl_status_polling_work:
+	 *
+	 * Delayed work for 200ms HDMI FRL status polling.
+	 */
 	struct delayed_work hdmi_frl_status_polling_work;
+	/**
+	 * @hdmi_frl_status_polling_delay_ms:
+	 *
+	 * Delay, in milliseconds, between HDMI FRL status polls.
+	 */
 	unsigned int hdmi_frl_status_polling_delay_ms;
 
 	/**
-	 * @dm_boot_time_crc_info:
+	 * @boot_time_crc_info:
 	 *
 	 * Buffer info for the boot time crc.
 	 */
-- 
2.43.0

