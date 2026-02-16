Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E20E63F29
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F2510E463;
	Tue, 17 Feb 2026 08:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T5vzutyf";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8B310E3BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:30 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b8fa033d805so46890566b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260329; x=1771865129; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cytjPGPVyEqSdYgwIyq0GlV8NbwaC2+24peBJ4/9eGA=;
 b=T5vzutyf0Nxd1fRKKdLpmLHriKPghHHaQPvXiy3gbWjh02r+y8hD1rK9wCEv0CXhyW
 K0AIuq7zRciHvtbPkSPEDe25uV9uYxE6hUzyor+wQqGoXD0JE9irn+IGub+oDsfzxnwq
 WCiAlArJdaJVFDzIwL8YNQhDZB16DkDeHDkUOqunXKhMegIQMuIyElnAaTL6ym4ZOzcQ
 yZZ2VseXOKnruWTO0Rd58SXZq1bOMOzzmw/6taDYE+yvFPM7zkVaE49SXkex0pbKTQDW
 63JLyOBKd4/P1fDiRj0vDmYNkbXUc8eY5H0UdV3zNyl8iPggQoiBMmSY5CZAcnkTlZxt
 XrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260329; x=1771865129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cytjPGPVyEqSdYgwIyq0GlV8NbwaC2+24peBJ4/9eGA=;
 b=j9Z+hhiQvJv6dw8Hxi57YdIA71cJbmGGTGqrWw8hb4iqr0BnSjIPl6upxieNfYJgye
 zK/acfWjs6nfhiz8gzXfwxl0aR8exvGaeHm9gC45PBpgt+NaUgmXFsJc/cOwoe0O00++
 sjoskvgax496cD39+OlwsVEEgm1IUuwzvSUN0FCDrZspaHtz0JgceeDts05uYJOZVDhE
 2in960SIDOI/BDj03EtS3G+J5dIpSjzZTshrE3soHdOkF8TraKZ6VgoRUmf1tYkqACiD
 cIk9BBMenguGXSVav9ewuQQBZ/P+enDQmcM8W2SoA4IGLrB9DxultNKA63mwGIUwbqFb
 XBEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURAupvvbU6k980vsR62GrsIzqFlnpHNJ/bvJKudbrCHQYHSU081AtxpTBRlG9fafHxxi3EAihv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0MTcVVKmAlYXshjd4EClyJp7LgmDoqMBLS9BRY0wL2E0ipevs
 JMYIdN2xTCg2GZip7A2w7Cy921KsQpD8BkoWYEruAICc3vleJNJFfbug
X-Gm-Gg: AZuq6aJ853fOpcOvhFC2WBQdYCNHlXNXCOt7mEKkyr8TycekngTYh3oyjmh2XImKkjb
 WZmaZswaQv8TjgfX+Yv8MsdYnWU9/Wuz0WiK8AB7wm91W+YMhhy2nmRQw3zXHTQ+0dW1bqBAwLX
 d/nsP6h7Ra8jaTqdyJP0TuMC4VCLrLK6GYsLFHQ4a8+t6o7dh4zgSahUrXsg8KKaFutsaxsSVrp
 2VfDfuH7RfOObudPfum8WLvYxABMzED8Dv0n/d8jMgRYgWwRyByhEudDg+jlAPjTE3dVsGwLxMV
 c0tDcL3zDN2f22xkRYMYNsK8RUEvs8WuN7Cc/HKyKdnJ+diZ61U7/kggJnO6+PmpYZebgPWNgBZ
 w8653kkU7C/aOBW4ZBPsIL4oXvVeZCum/oos78Rlaz5jNqDUmys7epmEi/5AEX9OhNc+38+jc8G
 b/TLMqZ4/23tNZIM06GOC7TO36CXLCJjOlgj7nHtco1xrb/e6GeY1BJWKHZdH5pk6b91xbzs1Pj
 uZx
X-Received: by 2002:a17:907:7f90:b0:b8a:f2d7:9942 with SMTP id
 a640c23a62f3a-b8face51f34mr359995366b.3.1771260328825; 
 Mon, 16 Feb 2026 08:45:28 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:28 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 07/27] drm/amd/display: Use bigger VRR range if found in
 AMD vsdb
Date: Mon, 16 Feb 2026 17:44:56 +0100
Message-ID: <20260216164516.36803-8-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 08:05:08 +0000
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

[Why]
Some monitors only expose their full VRR range in AMD vsdb for some
reason.

[How]
Compare exposed ranges and use the bigger one.
Only adjust lower limit if it doesn't support LFC

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4177
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3bf5e0c19a5..f36059bb0324 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13269,6 +13269,34 @@ static bool copy_range_to_amdgpu_connector(struct drm_connector *conn)
 	return is_freesync_capable(range);
 }
 
+static void extend_range_from_vsdb(struct drm_display_info *display,
+				   const struct amdgpu_hdmi_vsdb_info *vsdb)
+{
+	u16 vrr_min = display->monitor_range.min_vfreq;
+	u16 vrr_max = display->monitor_range.max_vfreq;
+
+	/* Always extend upper limit */
+	if (vsdb->max_refresh_rate_hz > vrr_max)
+		vrr_max = vsdb->max_refresh_rate_hz;
+
+	/*
+	 * Only extend lower limit if current one disables LFC.
+
+	 * During widespread testing, we found that some manufacturers probably
+	 * had issues with their monitors' lower VRR boundaries and adjusted
+	 * them up (Gigabyte X34GS with official range 48 - 180, AMD vsdb 48 -
+	 * 180 yet Monitor Ranges 55 - 180). After setting the lower boundary
+	 * from AMD vsdb, such monitors start having blanking issues.
+	 *
+	 * Work around that by not touching VRR min if it still supports LFC.
+	 */
+	if (vsdb->min_refresh_rate_hz < vrr_min && (vrr_min * 2 >= vrr_max))
+		vrr_min = vsdb->min_refresh_rate_hz;
+
+	display->monitor_range.min_vfreq = vrr_min;
+	display->monitor_range.max_vfreq = vrr_max;
+}
+
 /**
  * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
  *
@@ -13339,6 +13367,9 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		if (is_monitor_range_invalid(connector))
 			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
 
+		/* Try extending range if found in AMD vsdb */
+		extend_range_from_vsdb(&connector->display_info, &vsdb_info);
+
 		if (dpcd_caps.allow_invalid_MSA_timing_param)
 			freesync_capable = copy_range_to_amdgpu_connector(connector);
 
-- 
2.53.0

