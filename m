Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8035CDB47C
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D3C10E9D4;
	Tue, 23 Jun 2026 08:07:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=dyllankobal.com header.i=@dyllankobal.com header.b="kIAGDSCv";
	dkim-atps=neutral
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD0510E5D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 01:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dyllankobal.com;
 s=protonmail2; t=1782176291; x=1782435491;
 bh=A14xOCSUJIIMFQZE0VRp3UXHUGZdex4M/Cm4rQbdfqU=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=kIAGDSCvtQpJVfwgWxiNZhvmN3K9f2H7Ms2m4nM43uOWw8BKF/Dwi0nXfSsRDcHMs
 /Tpr8RReiI9dxK2qCGKxQl9nI+dsTcQolzacQMND/JMRMBUys4g72ecNAadDQUuOaY
 rigaLK1S0H2qlfco6XoRMlFKWCGWRVYA/+XK+Q3owGt1PU6bcI5pEfjtBvK7y9KzeL
 ZblY34c0JAWPhZMCE2C7Q5OW0qYWGNfrb3JVsz2yyNUNYLm6rCdVqHQDm/q1l5yRb+
 zsaLrFCiUL15mVLho7igXM81mfoA5QDapYrsn8zDf8zAMUz1FH9oomEFQSVJc8Eg5t
 8nt0lby8BMa7w==
Date: Tue, 23 Jun 2026 00:58:04 +0000
To: Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
From: dyllan@dyllankobal.com
Subject: [PATCH] drm/amd/display: fix wrong register field in
 dccg35_set_hdmistreamclk_src_new
Message-ID: <20260623005800.285812-1-dyllan@dyllankobal.com>
Feedback-ID: 33529580:user:proton
X-Pm-Message-ID: 8ccd7c2649e7e5c26899dd0127c6cedcb95bf80a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:07:15 +0000
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

From: Dyllan Kobal <dyllan.kobal@zetier.com>

dccg35_set_hdmistreamclk_src_new() updates HDMISTREAMCLK_CNTL but
passes DPSTREAMCLK0_SRC_SEL as the field identifier in the second
REG_UPDATE_2 slot.

The current behavior is harmless on DCN3.5 because both fields share the
same bit layout, but it is still incorrect and could break on future
hardware revisions.

Fixes: d36771a03412 ("drm/amd/display: Add DCCG DIO, HPO, OPP, and OPTC sup=
port for FRL")
Signed-off-by: Dyllan Kobal <dyllan.kobal@zetier.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drive=
rs/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 483cd9ab7eb7..42066b8a0362 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -572,7 +572,7 @@ static void dccg35_set_hdmistreamclk_src_new(
 =09case 0:
 =09=09REG_UPDATE_2(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_EN,
 =09=09=09=09=09 (src =3D=3D HDMI_STREAM_REFCLK) ? 0 : 1,
-=09=09=09=09=09 DPSTREAMCLK0_SRC_SEL,
+=09=09=09=09=09 HDMISTREAMCLK0_SRC_SEL,
 =09=09=09=09=09 (src =3D=3D HDMI_STREAM_REFCLK) ? 0 : src);
 =09=09break;
 =09default:
--=20
2.54.0


