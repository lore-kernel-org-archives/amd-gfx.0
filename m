Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FBDC3ABCA
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 13:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A840510E90C;
	Thu,  8 May 2025 13:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="EftWKVWm";
	dkim-atps=neutral
Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch
 [79.135.106.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FA410E36D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1746625605; x=1746884805;
 bh=uZ5Qe7tqS+Lcn6Rzm0dh4NGjhzw6mgYx6fToIEeqB+E=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=EftWKVWmiEtP8LHqgh7slp1NkC5XR9sI09FpM3k08s1PIfZQXdacr8/PFw+dIHs/v
 CvlmSqrsCKvNMa5W6rDiJjQnNohYKOOcrP/6NXm5P7TW1P5XZzTrrPTVKtksbtncvc
 Vq30PJFLwMG6B1lYqpkdU/xux0ellFloVmQJd6C9y1oBqFzzP8Gq+HuYknUJgEyTff
 jTeeMtumEFzQZH4B7oJSbDWbOUDtqLxEvoTXYQ61j8iEV0PHxhxSRO20hF/1ZlkSg0
 y6o1c7ZOQ3UlAO2XL65HhawqFiZKuFKdfUs4Aqmp9CECXARS9pWG0JSwACZfAtyhHm
 y0w6oN2tdUYsQ==
Date: Wed, 07 May 2025 13:46:40 +0000
To: amd-gfx@lists.freedesktop.org
From: Umio Yasuno <coelacanth_dream@protonmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v2] drm/amdgpu/smu13: set the threshold for TEMP_HOTSPOT
 throttling
Message-ID: <20250507134553.6812-1-coelacanth_dream@protonmail.com>
Feedback-ID: 19510729:user:proton
X-Pm-Message-ID: ac6dcd39b9ce2456fe377529c15658cc868ac541
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 08 May 2025 13:02:10 +0000
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

ThrottlingPercentage for TEMP_HOTSPOT on SMU v13.0.0/7 is almost always gre=
ater then or equal to 1.
The THROTTLER_TEMP_HOTSPOT_BIT bit will be set even in idle states and some=
 applications will continue to detect it.
Therefore, set a threshold and make it work like any other throttling.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3251

Signed-off-by: Umio Yasuno <coelacanth_dream@protonmail.com>

---
V1 -> V2: Decrease threshold to 80 and update description
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 13 ++++++++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 13 ++++++++++---
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 5a9711e8c..34b62eca4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -744,14 +744,21 @@ static int smu_v13_0_0_system_features_control(struct=
 smu_context *smu,
 =09return smu_v13_0_system_features_control(smu, en);
 }
=20
+#define SMU_13_0_0_TEMP_HOTSPOT_THRESHOLD=0980
 static uint32_t smu_v13_0_get_throttler_status(SmuMetrics_t *metrics)
 {
 =09uint32_t throttler_status =3D 0;
 =09int i;
=20
-=09for (i =3D 0; i < THROTTLER_COUNT; i++)
-=09=09throttler_status |=3D
-=09=09=09(metrics->ThrottlingPercentage[i] ? 1U << i : 0);
+=09for (i =3D 0; i < THROTTLER_COUNT; i++) {
+=09=09if(i =3D=3D THROTTLER_TEMP_HOTSPOT_BIT) {
+=09=09=09throttler_status |=3D
+=09=09=09=09((metrics->ThrottlingPercentage[i] >=3D SMU_13_0_0_TEMP_HOTSPO=
T_THRESHOLD) ? 1U << i : 0);
+=09=09} else {
+=09=09=09throttler_status |=3D
+=09=09=09=09(metrics->ThrottlingPercentage[i] ? 1U << i : 0);
+=09=09}
+=09}
=20
 =09return throttler_status;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index c8f4f6fb4..eb007cb37 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -736,14 +736,21 @@ static bool smu_v13_0_7_is_dpm_running(struct smu_con=
text *smu)
 =09return !!(feature_enabled & SMC_DPM_FEATURE);
 }
=20
+#define SMU_13_0_7_TEMP_HOTSPOT_THRESHOLD=0980
 static uint32_t smu_v13_0_7_get_throttler_status(SmuMetrics_t *metrics)
 {
 =09uint32_t throttler_status =3D 0;
 =09int i;
=20
-=09for (i =3D 0; i < THROTTLER_COUNT; i++)
-=09=09throttler_status |=3D
-=09=09=09(metrics->ThrottlingPercentage[i] ? 1U << i : 0);
+=09for (i =3D 0; i < THROTTLER_COUNT; i++) {
+=09=09if(i =3D=3D THROTTLER_TEMP_HOTSPOT_BIT) {
+=09=09=09throttler_status |=3D
+=09=09=09=09((metrics->ThrottlingPercentage[i] >=3D SMU_13_0_7_TEMP_HOTSPO=
T_THRESHOLD) ? 1U << i : 0);
+=09=09} else {
+=09=09=09throttler_status |=3D
+=09=09=09=09(metrics->ThrottlingPercentage[i] ? 1U << i : 0);
+=09=09}
+=09}
=20
 =09return throttler_status;
 }
--=20
2.39.5


