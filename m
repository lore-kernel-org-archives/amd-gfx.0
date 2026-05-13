Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0863DCD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 00:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A79710E027;
	Wed, 13 May 2026 00:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=dyllankobal.com header.i=@dyllankobal.com header.b="fGVf+rR5";
	dkim-atps=neutral
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB35310E027
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 00:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dyllankobal.com;
 s=protonmail2; t=1778631084; x=1778890284;
 bh=cFT5oCnRtB0B7BbDL++BMrqdRnCk+XSvWg/4saqH7SA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=fGVf+rR5abf72lG6ZWZs0qlhj+E4xQoICLXDdKbqrhCENSTmxirkFZZ2vdhqBJytu
 gP9ux1FHBHHo1kDorthK2hzCdmRd9cNGeI/4fvYf1mvkKwr6RbaVZ/mgq7PFM0/1Ty
 UOXaEC6Njuo+LSL3qQ/dQ4ivhVpWJ5v3CZFqulaN1b387xm1Tf8kCWGLm1LINVGjgq
 GvUp8SnsQkXJlSk2IrlIIv4VZW0AEOZt2g9EEi5p6flr1W7g/MSVcIFrWptyXjCJTM
 5FTngi+15ATynI+jGiIIAtk8/BB8eOQtrm9HPTgCxyvBva9HeBllTr9idRs0AW1/u2
 TmWfc+zW4gG2Q==
Date: Wed, 13 May 2026 00:11:19 +0000
To: Harry Wentland <harry.wentland@amd.com>
From: dyllan@dyllankobal.com
Cc: Jerry Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: fix FRL link-status polling never running
Message-ID: <20260513001114.1186443-1-dyllan@dyllankobal.com>
In-Reply-To: <20260512155244.403854-12-harry.wentland@amd.com>
References: <20260512155244.403854-1-harry.wentland@amd.com>
 <20260512155244.403854-12-harry.wentland@amd.com>
Feedback-ID: 33529580:user:proton
X-Pm-Message-ID: 9579835f12c64d677963b55e59f60b84e82c1eb5
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

If I am understanding the logic here correctly amdgpu_dm_commit_streams()
is suppose to be deciding whether to start the 200ms FRL link-status
polling worker by scanning the streams being committed and setting
frl_stream_found.  The intent is "if any FRL stream in use, arm=20
the worker so it can call dc_link_frl_poll_status_flag() and
trigger DETECT_REASON_RETRAIN on link errors".

The conditional seems to be inverted: it sets frl_stream_found=20
when the stream is *not* HDMI FRL.  Consequently:

  - On a commit with only an FRL stream (the normal case once an
    HDMI 2.1 sink is up), the worker is cancel_delayed_work_sync()'d
    and never re-armed.
  - On commits that include only TMDS/DP streams, the worker fires
    pointlessly and walks every dc_link looking for FRL links that
    aren't there.

The net effect on HDMI 2.1 FRL sinks is that FRL link retraining is
completely disabled.

Verified on a Sony Bravia 8 II connected to an RX 9070 XT (DCN 4.0.1). =20
ftrace function tracer filtered to hdmi_frl_status_polling_work:

  before fix:  0 invocations in 10 s
  after fix:  48 invocations in 10 s (expected 5 Hz cadence)

After the fix, dc_link_detect(DETECT_REASON_RETRAIN) recovers the
link automatically on the next transient instead of requiring a full
hotplug.

Fixes: f7d5a0012653 ("drm/amd/display: Tie FRL support into amdgpu_dm")
Signed-off-by: Dyllan Kobal <dyllan.kobal@zetier.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cc8e8717a460..4bd760871f85 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10986,7 +10986,7 @@ static void amdgpu_dm_commit_streams(struct drm_ato=
mic_state *state,
 =09for (i =3D 0; i < params.stream_count; i++) {
 =09=09struct dc_stream_state *stream =3D params.streams[i];
=20
-=09=09if (stream->signal !=3D SIGNAL_TYPE_HDMI_FRL) {
+=09=09if (stream->signal =3D=3D SIGNAL_TYPE_HDMI_FRL) {
 =09=09=09frl_stream_found =3D true;
 =09=09=09break;
 =09=09}
--=20
2.54.0


