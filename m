Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8D0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 14:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833A260F13
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 14:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 833A260F13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CB789503;
	Tue,  7 Sep 2021 14:19:50 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A95F89503
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 14:19:47 +0000 (UTC)
Date: Tue, 07 Sep 2021 14:19:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1631024384;
 bh=5hc80ht2gxrAiqx6AkPCtmxjGHe4rsb5mrXCoQ+LZyo=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=XmzPZnHaIQoGZb4McaiM8SLI5s+oZQ2AuJlJlvS02Fz8zFrJ15oYo5TjhtcbV0S0v
 3vc2h7qk94BxlfeFRtc9mfctebChRVWa3hspW10zUwLuE+vj+gV6bbqUTShpeRekrk
 SVDViBtPIwKTohnMSoj9wZTEOIBq48t1xVy6O27S+h6a7I7d+jIdRdkk+ktylrWp8v
 HftT0rV2FeOCUN6cd9/ee0Tt29wzgKa80HBz7dCo+CF6CoQV2zZqRQjMU06Vr66pSW
 vbNY2FX1hFqjQ6juyIsYOHooNgLwMev3D8Z/f+b7YqGCh1TRDKCZcTDFLrfzvcCcTZ
 2jCuq2I6PZbGg==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH] amd/display: downgrade validation failure log level
Message-ID: <20210907141925.125177-1-contact@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Simon Ser <contact@emersion.fr>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In amdgpu_dm_atomic_check, dc_validate_global_state is called. On
failure this logs a warning to the kernel journal. However warnings
shouldn't be used for atomic test-only commit failures: user-space
might be perfoming a lot of atomic test-only commits to find the
best hardware configuration.

Downgrade the log to a regular DRM atomic message. While at it, use
the new device-aware logging infrastructure.

This fixes error messages in the kernel when running gamescope [1].

[1]: https://github.com/Plagman/gamescope/issues/245

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 986c9d29d686..6f3b6f2a952c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10467,7 +10467,8 @@ static int amdgpu_dm_atomic_check(struct drm_device=
 *dev,
 =09=09=09goto fail;
 =09=09status =3D dc_validate_global_state(dc, dm_state->context, false);
 =09=09if (status !=3D DC_OK) {
-=09=09=09DC_LOG_WARNING("DC global validation failure: %s (%d)",
+=09=09=09drm_dbg_atomic(dev,
+=09=09=09=09       "DC global validation failure: %s (%d)",
 =09=09=09=09       dc_status_to_str(status), status);
 =09=09=09ret =3D -EINVAL;
 =09=09=09goto fail;
--=20
2.33.0


