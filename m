Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EE8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 13:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FBA10E5F1;
	Tue,  7 Nov 2023 13:40:20 +0000 (UTC)
X-Greylist: delayed 588 seconds by postgrey-1.36 at gabe;
 Tue, 07 Nov 2023 08:48:00 UTC
Received: from 6.mo582.mail-out.ovh.net (6.mo582.mail-out.ovh.net
 [87.98.177.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 603A210E149
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 08:48:00 +0000 (UTC)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.143.136])
 by mo582.mail-out.ovh.net (Postfix) with ESMTP id 3407128F6D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 08:29:20 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-btv5j (unknown [10.110.115.220])
 by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 6EF6D1FDDC;
 Tue,  7 Nov 2023 08:29:18 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.105])
 by ghost-submission-6684bf9d7b-btv5j with ESMTPSA
 id I8daFV71SWUqAQAAWJgi0A
 (envelope-from <jose.pekkarinen@foxhound.fi>); Tue, 07 Nov 2023 08:29:18 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0063a9f607e-0194-493b-a956-73c3cacca2fa,
 990ED9DB402E285008FC912DE57946D84A8BC800)
 smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 213.216.211.70
From: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, skhan@linuxfoundation.org
Subject: [PATCH] drm/amd/pm: clean up redundant comparisons with 0
Date: Tue,  7 Nov 2023 10:29:09 +0200
Message-Id: <20231107082910.92508-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17681132139527513793
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudduhedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepfedtleeuteeitedvtedtteeuieevudejfeffvdetfeekleehhfelleefteetjeejnecukfhppeduvdejrddtrddtrddupddvudefrddvudeirddvuddurdejtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegrmhguqdhgfhigsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdfovfetjfhoshhtpehmohehkedvpdhmohguvgepshhmthhpohhuth
X-Mailman-Approved-At: Tue, 07 Nov 2023 13:40:19 +0000
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
Cc: linux-hwmon@vger.kernel.org, jdelvare@suse.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
 linux@roeck-us.net, linux-kernel-mentees@lists.linux.dev
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is a couple of function return checks of functions that return
unsigned values, and local variables to hold them are also unsigned, so
checking if they are negative will always return false. This patch will
remove them, as well as the never reached code.

drivers/gpu/drm/amd/pm/amdgpu_pm.c:2801:5-8: WARNING: Unsigned expression compared with zero: val < 0
drivers/gpu/drm/amd/pm/amdgpu_pm.c:2814:5-8: WARNING: Unsigned expression compared with zero: val < 0

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 8bb2da13826f..e7bb1d324084 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2798,8 +2798,6 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 	unsigned int val;
 
 	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_AVG_POWER);
-	if (val < 0)
-		return val;
 
 	return sysfs_emit(buf, "%u\n", val);
 }
@@ -2811,8 +2809,6 @@ static ssize_t amdgpu_hwmon_show_power_input(struct device *dev,
 	unsigned int val;
 
 	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER);
-	if (val < 0)
-		return val;
 
 	return sysfs_emit(buf, "%u\n", val);
 }
-- 
2.39.2

