Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C46C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 07:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B041110E3B0;
	Tue,  8 Aug 2023 07:40:27 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FF310E3A9
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 02:27:44 +0000 (UTC)
Date: Tue, 08 Aug 2023 02:27:31 +0000
Authentication-Results: mail-4321.protonmail.ch;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.b="otsiRUdY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1691461658; x=1691720858;
 bh=rLyqhqtc/MDZ2VUlG4CH6NUh7rXYVmwrFO5WIOp1Wv0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=otsiRUdY5h8BITQCPYdaCzwvIu7vzn8bKD7YEbLivLx08aJO/vScubQSXQ3mXnEQM
 RHfmn4019bbwxtrhCmXArvt74WEeDhIiLewjJ5E2de2Zgqzcnd9VHiIw7YgU9UmhEi
 zPgRkwZBoXEHEKGaxj0iYYcZXiszdgV6GGWR2lkEm4IaaFZZtrKLZsa7Ej93FY86aZ
 t3mxj7NsAi9sx80npzJv3pcBbgGlhA11OjMVvRklsPo78oqNI5baCjLwy4rKyipCmj
 GJV5qLXHCzCKaSg11vIF1KzuGZVau/mbQPJEjLa7kRPZkRu3cb4FppFrj7sOuYogym
 agNPxxLj0gzOg==
To: amd-gfx@lists.freedesktop.org
From: Umio Yasuno <coelacanth_dream@protonmail.com>
Subject: [PATCH] fix throttle_status for other than MP0 11.0.7
Message-ID: <20230808022713.776023-1-coelacanth_dream@protonmail.com>
Feedback-ID: 19510729:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 08 Aug 2023 07:40:23 +0000
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
Cc: Umio Yasuno <coelacanth_dream@protonmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2720
Signed-off-by: Umio Yasuno <coelacanth_dream@protonmail.com>
---
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 85d53597e..548d25cf3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -578,7 +578,9 @@ static int sienna_cichlid_tables_init(struct smu_contex=
t *smu)
 =09return -ENOMEM;
 }
=20
-static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_cont=
ext *smu)
+static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_cont=
ext *smu,
+=09=09=09=09=09=09=09   bool use_metrics_v3,
+=09=09=09=09=09=09=09   bool use_metrics_v2)
 {
 =09struct smu_table_context *smu_table=3D &smu->smu_table;
 =09SmuMetricsExternal_t *metrics_ext =3D
@@ -586,13 +588,11 @@ static uint32_t sienna_cichlid_get_throttler_status_l=
ocked(struct smu_context *s
 =09uint32_t throttler_status =3D 0;
 =09int i;
=20
-=09if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7)) &=
&
-=09     (smu->smc_fw_version >=3D 0x3A4900)) {
+=09if (use_metrics_v3) {
 =09=09for (i =3D 0; i < THROTTLER_COUNT; i++)
 =09=09=09throttler_status |=3D
 =09=09=09=09(metrics_ext->SmuMetrics_V3.ThrottlingPercentage[i] ? 1U << i =
: 0);
-=09} else if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0=
, 7)) &&
-=09     (smu->smc_fw_version >=3D 0x3A4300)) {
+=09} else if (use_metrics_v2) {
 =09=09for (i =3D 0; i < THROTTLER_COUNT; i++)
 =09=09=09throttler_status |=3D
 =09=09=09=09(metrics_ext->SmuMetrics_V2.ThrottlingPercentage[i] ? 1U << i =
: 0);
@@ -854,7 +854,7 @@ static int sienna_cichlid_get_smu_metrics_data(struct s=
mu_context *smu,
 =09=09=09metrics->TemperatureVrSoc) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADE=
S;
 =09=09break;
 =09case METRICS_THROTTLER_STATUS:
-=09=09*value =3D sienna_cichlid_get_throttler_status_locked(smu);
+=09=09*value =3D sienna_cichlid_get_throttler_status_locked(smu, use_metri=
cs_v3, use_metrics_v2);
 =09=09break;
 =09case METRICS_CURR_FANSPEED:
 =09=09*value =3D use_metrics_v3 ? metrics_v3->CurrFanSpeed :
@@ -4056,7 +4056,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct =
smu_context *smu,
 =09gpu_metrics->current_dclk1 =3D use_metrics_v3 ? metrics_v3->CurrClock[P=
PCLK_DCLK_1] :
 =09=09use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_1] : metrics->Curr=
Clock[PPCLK_DCLK_1];
=20
-=09gpu_metrics->throttle_status =3D sienna_cichlid_get_throttler_status_lo=
cked(smu);
+=09gpu_metrics->throttle_status =3D sienna_cichlid_get_throttler_status_lo=
cked(smu, use_metrics_v3, use_metrics_v2);
 =09gpu_metrics->indep_throttle_status =3D
 =09=09=09smu_cmn_get_indep_throttler_status(gpu_metrics->throttle_status,
 =09=09=09=09=09=09=09   sienna_cichlid_throttler_map);
--=20
2.40.1


