Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36F1CA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 07:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 498A410FCE1;
	Thu,  8 Oct 2026 07:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bY+B2ZZB";
	dkim-atps=neutral
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0056910E739
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 05:17:21 +0000 (UTC)
Received: by mail-pj2-f2.google.com with SMTP id
 d9443c01a7336-2e61817b178so3378385ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 22:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791436641; cv=none;
 d=google.com; s=arc-20260327;
 b=eT7oVnj28PgqDFkyXQ6ic6B84FfbzEsDiYOc/lE3bP45fkLQcpf9oehUjTqC65WB+y
 N0MQWtJ3B1vE1El4ESnWLIwCd5jEWL2rbamfPv1kKPRO2HyJ5UImyxEya5ZhFtqVIKB+
 d2NUFaYQts16p8IGWXGp20DdkbMuOdrZL1TajQn1zQh4Y+H5ygAAssFCbfmJ5B/SVQg3
 aSy/fyAaCL8VhFGsOc9UHl+oPUcgu3vaBzCfiBOS88p4ZKx7nGZD18sN13eaJs+4pYJ0
 qHHT5HUsBNvPRRkayz54nzHMG2nBfWiitdW1mBkN+4iBtGPU8Xo/9Y7DtnznIECvXB6Q
 lBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=nZxCaIo9txwzpM9hHuP2f8v3rOWm8pOzF15AOYuWLXs=;
 fh=fbesewJozsFQtCZCsBpCe6u2XXtJjSI65kpPc8Gsa3w=;
 b=eBsHbjfocSDctkYfwNgeQ61s8P20nGG1DRvH5MlCvw2HrzF1TQFS1wqKeBzgSbFNDM
 TRKe+gfPJnyP02JArHaHk1F0Fuz0uZS7hZGGMTnGZF8jNygCwfNCC5MdK0lzdGJlsRU+
 llUhl4ykdSownS31G8caeT1rn9QagvtzejbmFy+Y+XT0Q8uRVf7xlNsw9BmIwsAj8838
 L4JUiEgi9HvVZoonMyMhaHnZBg1LQRzrRAnhka7jlix6nJCO2KRgIXeSNvRt3Ajn6fbq
 YAPlGQb1F2N0VNTGQ7aBUeEgjzgYnFDvDIpPdWRUkvg1nVeySXj9g8ZHena6y2m74qFj
 NgEA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791436641; x=1792041441; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nZxCaIo9txwzpM9hHuP2f8v3rOWm8pOzF15AOYuWLXs=;
 b=bY+B2ZZB1AsZ9adHZDFZM+Lb52/Nj3lgmITK//H82A32Eq7qAExJNNDJtkP2cW4ULB
 2/TnTviUJ7nbQ4WlUMjookMhAFD8zMS0Mx8V+p5oc8sHeBFti6ehl2I7y7nMfTJ1SHC6
 bR8TwHEL+kg56j/YekO21lROdA6Pq9xVy8/uaR6m6I6I71aQnjwNiUn6SNkI8ZMol9Bb
 ABCm1LB+B5cm8noJJvr94VOQoA7w9lnq1g6Xq3H2tJ0IqL4BV2AyymuXohV1LrYJGFy2
 5nn8sb7wXLuSzQWNw4XXOOIUeHysKiP+3Nl538OrnFG09pHrkQ1EIMhRRoVO5kOfJoyj
 k7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791436641; x=1792041441;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nZxCaIo9txwzpM9hHuP2f8v3rOWm8pOzF15AOYuWLXs=;
 b=VaVYf/e+BN2DZJYPUoQGdcD+/YrBLDNhaKunsbeV2tc7j6PAS5hm6JCcdBqm6JN+z4
 UzCV3OTyeguP7cmAAz1gKbyEjlhJHWOIaeoB4z/NLG8bSgz/dySmq97mZ6JVHg7uBdBR
 FQgKdJrq5Uhrb2wJVb9fadQ13BJN5JuB4ozW5TRDlMf2R0RMcTp3uijdtDmsKA6VT0Eu
 CiNyaih2xtIzCuTam3TcaEYGYI09i3gwwvrznP6or6viPbfo5zqSRuhy++pG4EJbh5p3
 ChQB1MpWJnvwTmybdPU0sLai21UbKq8RE1LYGDX8HrnuL0LQLhPd60oVjh6LLd5g3lbR
 FjQA==
X-Gm-Message-State: AFuF++lAYfIYv7/n/IH+NLsMqKrgMbvArCkV4uvublJqpngej7DmURPf
 8+iPqZTbbSNBYdfqt/OnXt4Onz7mFIxiKP8tZkbqIoOuM6w7ZP+zHK6P8pwDZBu3U641BNs8bWy
 SMiLXo9iafXNKdf6CVAXXk+Is6rC38HUvBg1/v7f3JIGUMG0=
X-Gm-Gg: AYBFou2C93LtSdsMtbBPI7/9U3sCB8x3mtGqjNK77/kb7q4OLMjBiqi3VxeU7RvX6f/
 Xmw3MAADxTIkb4nWjmmaiCrsWEBWw5X1PyoLH1BD8G3S81E4wU5AzwgX1bJ4Lw35YUzJFq5QRk1
 Ykk0Ze22/z3Z6H6Al9GtgvPfUUEXezaWA0ulUyZ64pu4GN4Tjhy6PpgW4+uWS3pj4EDMO182xsF
 UeDxDZ6FvabYFBPWaKgLDYvKUsDbxI0bHJ7+a4HBZVhfxqV+aPO/Fm6pLd0xdwQvPOGR2F78UzV
 UUmYDszih+4FtVK3uN1hDFYym/EUErZhFtOCCUNwoqP3LyRysJnlfA==
X-Received: by 2002:a05:6a20:ecc7:20b0:3e1:4541:899b with SMTP id
 adf61e73a8af0-3e145418a8fmr1385001637.41.1791436641046; Wed, 07 Oct 2026
 22:17:21 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 7 Oct 2026 22:17:20 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 7 Oct 2026 22:17:20 -0700
MIME-Version: 1.0
From: Yibiao Li <biaobiao2233@gmail.com>
Date: Wed, 7 Oct 2026 22:17:20 -0700
X-Gm-Features: AclHuK9UcY5R91xpt04gOFDaB136BcNqqe9341-E5szYJoMqgQSodHyBmZUxnAI
Message-ID: <CAG1agfwtnjmb8RVLmZvY9W-zrR1onhK6urJA3Lqai82tAXn2Cg@mail.gmail.com>
Subject: [PATCH] drm/amd/display: Use separate iterator for preferred mode
 lookup
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 08 Oct 2026 07:43:00 +0000
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

From: Yibiao Li <biaobiao2233@gmail.com>

create_stream_for_sink() uses preferred_mode both as the list iterator
and as the selected mode. This triggers a false positive from
scripts/coccinelle/iterators/use_after_iter.cocci: native_mode_found
already ensures that an exhausted iterator is replaced before use.

Use a separate iterator and assign preferred_mode only when a preferred
entry is found. This keeps the selected mode separate from the iterator
state and makes native_mode_found unnecessary. Preserve the fallback to
the first entry, or NULL when the list is empty.

No functional change intended.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202609190901.yKTzhsGz-lkp@intel.com/
Assisted-by: LLM coccinelle
Signed-off-by: Yibiao Li <biaobiao2233@gmail.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index d386bb1475..ceea8fe481 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1453,12 +1453,12 @@ create_stream_for_sink(struct drm_connector *connector,
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_dm_connector *aconnector = NULL;
 	struct drm_display_mode *preferred_mode = NULL;
+	struct drm_display_mode *connector_mode;
 	const struct drm_connector_state *con_state = &dm_state->base;
 	struct dc_stream_state *stream = NULL;
 	struct drm_display_mode mode;
 	struct drm_display_mode saved_mode;
 	struct drm_display_mode *freesync_mode = NULL;
-	bool native_mode_found = false;
 	bool recalculate_timing = false;
 	bool scale = dm_state->scaling != RMX_OFF;
 	int mode_refresh;
@@ -1509,14 +1509,14 @@ create_stream_for_sink(struct drm_connector *connector,
 	stream->timing.flags.LTE_340MCSC_SCRAMBLE =
 		connector->display_info.hdmi.scdc.scrambling.low_rates;

-	list_for_each_entry(preferred_mode, &connector->modes, head) {
+	list_for_each_entry(connector_mode, &connector->modes, head) {
 		/* Search for preferred mode */
-		if (preferred_mode->type & DRM_MODE_TYPE_PREFERRED) {
-			native_mode_found = true;
+		if (connector_mode->type & DRM_MODE_TYPE_PREFERRED) {
+			preferred_mode = connector_mode;
 			break;
 		}
 	}
-	if (!native_mode_found)
+	if (!preferred_mode)
 		preferred_mode = list_first_entry_or_null(
 				&connector->modes,
 				struct drm_display_mode,
-- 
2.43.0
