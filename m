Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4CECD3447
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2026 02:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1004010E04C;
	Sat,  9 May 2026 02:25:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=dyllankobal.com header.i=@dyllankobal.com header.b="C+zEo7MB";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA5E10E04C
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2026 02:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dyllankobal.com;
 s=protonmail2; t=1778293433; x=1778552633;
 bh=HBR4Q7Rds8AJcAqvrbLJuSOx42Q9edHoLUwwlmRL2Ko=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=C+zEo7MBEWDttGA7wLc/ejp5G8FqGZDAIuOBfjeE9eO9ZcYtw+q0qEu7BzXXDkOXz
 VRN5kFoGjhFkTdSz3yJ+8CBMQmFfXO+orwMGyQk2+HWrn0pqatX+TYUyUnJBXe9C/I
 uE3oIt1yD+W/5htmyPOZTwKIzPPqSPWxQC0K1f7arbBmvzGBacpTL59Q54zQSVqJqH
 zCxQ51qgkvGquPzJY6bVGYTEVJenxpMvVJ1yjNH9q1H4DFbFWOVKv2V4rRoZ/Ob1lt
 98knXjn54EqDCOqhElQkh0Bq4Ax3WANkrKLzfuTbB5StMc7B5poUtuaMvgIqghohUk
 z16IcNaPC96sQ==
Date: Sat, 09 May 2026 02:23:48 +0000
To: amd-gfx@lists.freedesktop.org
From: Dyllan Kobal <dyllan@dyllankobal.com>
Cc: harry.wentland@amd.com
Subject: [PATCH] drm/amd/display: fix uninitialized port deref in SST PCON DSC
 path
Message-ID: <20260509022345.272269-1-dyllan@dyllankobal.com>
In-Reply-To: <20260508182808.520863-1-harry.wentland@amd.com>
References: <20260508182808.520863-1-harry.wentland@amd.com>
Feedback-ID: 33529580:user:proton
X-Pm-Message-ID: 0632f221c340b824e3ec877e39764a32fd8eb17a
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dyllan Kobal <dyllan.kobal@zetier.com>

The SST DP-HDMI PCON branch of dm_helpers_dp_write_dsc_enable() logs
through (port->passthrough_aux), but `port` is only assigned inside
the SIGNAL_TYPE_DISPLAY_PORT_MST branch above. On a SST link with a
DP-HDMI protocol converter, `port` is read uninitialized, producing
a null dereference when the driver enables DSC over a SST DP-HDMI PCON link=
:

  BUG: kernel NULL pointer dereference, address: 0000000000000570
  RIP: dm_helpers_dp_write_dsc_enable+0x453/0x620 [amdgpu]
  Call Trace:
    link_set_dpms_on
    dce110_apply_single_controller_ctx_to_hw
    ...
    amdgpu_dm_atomic_commit_tail

Replace the (port->passthrough_aux) selector in the debug message with
a check on the local enable_dsc, which is always valid here. No
functional change on the wire; the DPCD write below is unchanged.

Signed-off-by: Dyllan Kobal <dyllan.kobal@zetier.com>
---
Reproduced with a Sony Bravia 8 II via a UGREEN unidirectional DP 1.4 to HD=
MI 2.1 8K@60Hz active adapter on a Radeon RX 9070 XT.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 83034b0236c6..b55b1719892e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -973,10 +973,10 @@ bool dm_helpers_dp_write_dsc_enable(
 =09=09=09=09=09enable_dsc =3D DSC_DECODING;
 =09=09=09=09}
 =09=09=09=09drm_dbg_dp(dev,
-=09=09=09=09=09  "SST_DSC Sent DSC decoding enable to %s port, ret =3D %u\=
n",
-=09=09=09=09=09  (port->passthrough_aux) ?
-=09=09=09=09=09  "remote HDMI FRL RX" :
-=09=09=09=09=09  "DP-HDMI PCON", ret);
+=09=09=09=09=09  "SST_DSC Sent DSC %s to DP-HDMI PCON, ret =3D %u\n",
+=09=09=09=09=09  (enable_dsc =3D=3D DSC_PASSTHROUGH) ?
+=09=09=09=09=09  "passthrough enable" :
+=09=09=09=09=09  "decoding enable", ret);
 =09=09=09} else {
 =09=09=09=09enable_dsc =3D DSC_DISABLE;
 =09=09=09=09drm_dbg_dp(dev, "SST_DSC Send DSC disable to DP-HDMI PCON\n");
--=20
2.54.0

