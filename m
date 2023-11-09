Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7605C4167D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 14:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C7B10E236;
	Thu,  9 Nov 2023 14:43:42 +0000 (UTC)
Received: from 5.mo583.mail-out.ovh.net (5.mo583.mail-out.ovh.net
 [87.98.173.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC4610E1E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 08:41:19 +0000 (UTC)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.108.20.85])
 by mo583.mail-out.ovh.net (Postfix) with ESMTP id AF6FA26CD6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 08:41:17 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-vsp9x (unknown [10.110.115.108])
 by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 30EBA1FD1C;
 Thu,  9 Nov 2023 08:41:15 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.103])
 by ghost-submission-6684bf9d7b-vsp9x with ESMTPSA
 id y8qgBiubTGXYrAEAbsEDOA
 (envelope-from <jose.pekkarinen@foxhound.fi>); Thu, 09 Nov 2023 08:41:15 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00528d66f00-163d-49d8-8ce5-862fd5d6f579,
 40AB3B8824D5DAA18E3B98848C0232F256E668F8)
 smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 213.216.210.65
From: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, skhan@linuxfoundation.org
Subject: [PATCH] drm/amd/pm: make power values signed
Date: Thu,  9 Nov 2023 10:41:10 +0200
Message-Id: <20231109084110.4056-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11181593452377646785
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddguddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepfedtleeuteeitedvtedtteeuieevudejfeffvdetfeekleehhfelleefteetjeejnecukfhppeduvdejrddtrddtrddupddvudefrddvudeirddvuddtrdeihedpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegrmhguqdhgfhigsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdfovfetjfhoshhtpehmohehkeefpdhmohguvgepshhmthhpohhuth
X-Mailman-Approved-At: Thu, 09 Nov 2023 14:43:40 +0000
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
Cc: jdelvare@suse.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
 linux@roeck-us.net, linux-kernel-mentees@lists.linux.dev
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The following patch will convert the power values returned by
amdgpu_hwmon_get_power to signed, fixing the following warnings reported
by coccinelle:

drivers/gpu/drm/amd/pm/amdgpu_pm.c:2801:5-8: WARNING: Unsigned expression compared with zero: val < 0
drivers/gpu/drm/amd/pm/amdgpu_pm.c:2814:5-8: WARNING: Unsigned expression compared with zero: val < 0

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e7bb1d324084..913ff62d5d5e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2795,7 +2795,7 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	unsigned int val;
+	int val;
 
 	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_AVG_POWER);
 
@@ -2806,7 +2806,7 @@ static ssize_t amdgpu_hwmon_show_power_input(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
 {
-	unsigned int val;
+	int val;
 
 	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER);
 
-- 
2.39.2

