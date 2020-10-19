Return-Path: <SRS0=J5eG=D2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2F8C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 14:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2249222EA
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 14:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GT7Ja0ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2249222EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097366E9E8;
	Mon, 19 Oct 2020 14:57:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15FB6E9DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2020 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603118602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=HS9j6NFClw0xbf6pUYexyg09LSF+fCEmAaVviysMnkA=;
 b=GT7Ja0jar1geomzPWn23G9R0JWmjTns1I0NQtJnpjWNPEX9kuk1USpBy7rQz3iSXVcKgPY
 wSs5Sgb3/K6MXnnIPOEv7yw2Tbwz5TwwW1tku+U5jaQ7S0ymNAzJHdFcCBOM4j1sGynP+z
 5QTRtvTDOkkOFsIrgyY0ANgEFp2eHvM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-feGHq_K5OSSC8ebV4sFkFA-1; Mon, 19 Oct 2020 10:43:19 -0400
X-MC-Unique: feGHq_K5OSSC8ebV4sFkFA-1
Received: by mail-qt1-f200.google.com with SMTP id l12so75475qtu.22
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2020 07:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=HS9j6NFClw0xbf6pUYexyg09LSF+fCEmAaVviysMnkA=;
 b=H72PFhkfgZF59yUtxaw4p+6RVc8CzBobz+N4e7iJpXzcxQRYYRThVKVVEjPlWTWKov
 MoG8HgUlxx6Y+V49ndiKMK42w+WfRsYEWMXhlPU0mcCg3CGxQrvgUVV5Dp17upTDNjlT
 lBA5RLP6UkjRKeDbda+CAVDqoUSCABFUc9mDSDXhI5cN9nAv8epR6fsKChert2gnabXc
 7lbPA/zNKIIpVraEykJbBpPuioe5byAqguCE6jXByQ2G6D3HIi2vr01JBz1B+tKxTQ6z
 y0/5hPR0D9++ilE500zNIwDXyCfhreOKz5tZNyVjhct3dtTm5e285KnopGVBdUGnv0mY
 y/+Q==
X-Gm-Message-State: AOAM532WAvEEt8t+7TMTS+2vn8BsDmSGNbP1HzXcfqSCk4ciGzS04YQE
 aTT33yB1T5i/iyl9NyVq93Isn41tBNXhoaK4da4qzIqOY49ddES5Dste+sRtLhUS/foUwd07plX
 0JsS3eBIafm9fmFo5ebQwtZb65Q==
X-Received: by 2002:ac8:937:: with SMTP id t52mr15592714qth.268.1603118598597; 
 Mon, 19 Oct 2020 07:43:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAjzy0z6rzYX/CmMgw+uXDi5Q1r8M21MiqKjUC0Nu0rYOLfUvcBlanK5Bdn1pFWCESWLn7oQ==
X-Received: by 2002:ac8:937:: with SMTP id t52mr15592664qth.268.1603118598290; 
 Mon, 19 Oct 2020 07:43:18 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id j8sm107460qke.38.2020.10.19.07.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 07:43:17 -0700 (PDT)
From: trix@redhat.com
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 issor.oruam@gmail.com, Anthony.Koo@amd.com, Rodrigo.Siqueira@amd.com,
 Tony.Cheng@amd.com, Charlene.Liu@amd.com, yogesh.mohanmarimuthu@amd.com,
 Aric.Cyr@amd.com, Igor.Kravchenko@amd.com, colin.king@canonical.com,
 tao.zhou1@amd.com, Dennis.Li@amd.com, mario.kleiner.de@gmail.com
Subject: [PATCH] drm/amdgpu: remove unneeded break
Date: Mon, 19 Oct 2020 07:43:11 -0700
Message-Id: <20201019144311.18260-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Mon, 19 Oct 2020 14:57:31 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return or break

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c      | 1 -
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 7 -------
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 7 -------
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 7 -------
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 7 -------
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c   | 7 -------
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 7 -------
 7 files changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 2a32b66959ba..130a0a0c8332 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -1330,7 +1330,6 @@ static bool configure_graphics_mode(
 			REG_SET(OUTPUT_CSC_CONTROL, 0,
 				OUTPUT_CSC_GRPH_MODE, 0);
 			break;
-			break;
 		case COLOR_SPACE_SRGB_LIMITED:
 			/* TV RGB */
 			REG_SET(OUTPUT_CSC_CONTROL, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index d741787f75dc..42c7d157da32 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -418,25 +418,18 @@ static int map_transmitter_id_to_phy_instance(
 	switch (transmitter) {
 	case TRANSMITTER_UNIPHY_A:
 		return 0;
-	break;
 	case TRANSMITTER_UNIPHY_B:
 		return 1;
-	break;
 	case TRANSMITTER_UNIPHY_C:
 		return 2;
-	break;
 	case TRANSMITTER_UNIPHY_D:
 		return 3;
-	break;
 	case TRANSMITTER_UNIPHY_E:
 		return 4;
-	break;
 	case TRANSMITTER_UNIPHY_F:
 		return 5;
-	break;
 	case TRANSMITTER_UNIPHY_G:
 		return 6;
-	break;
 	default:
 		ASSERT(0);
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index 2bbfa2e176a9..382581c4a674 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -471,25 +471,18 @@ static int map_transmitter_id_to_phy_instance(
 	switch (transmitter) {
 	case TRANSMITTER_UNIPHY_A:
 		return 0;
-	break;
 	case TRANSMITTER_UNIPHY_B:
 		return 1;
-	break;
 	case TRANSMITTER_UNIPHY_C:
 		return 2;
-	break;
 	case TRANSMITTER_UNIPHY_D:
 		return 3;
-	break;
 	case TRANSMITTER_UNIPHY_E:
 		return 4;
-	break;
 	case TRANSMITTER_UNIPHY_F:
 		return 5;
-	break;
 	case TRANSMITTER_UNIPHY_G:
 		return 6;
-	break;
 	default:
 		ASSERT(0);
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index b622b4b1dac3..7b4b2304bbff 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -446,25 +446,18 @@ static int map_transmitter_id_to_phy_instance(
 	switch (transmitter) {
 	case TRANSMITTER_UNIPHY_A:
 		return 0;
-	break;
 	case TRANSMITTER_UNIPHY_B:
 		return 1;
-	break;
 	case TRANSMITTER_UNIPHY_C:
 		return 2;
-	break;
 	case TRANSMITTER_UNIPHY_D:
 		return 3;
-	break;
 	case TRANSMITTER_UNIPHY_E:
 		return 4;
-	break;
 	case TRANSMITTER_UNIPHY_F:
 		return 5;
-	break;
 	case TRANSMITTER_UNIPHY_G:
 		return 6;
-	break;
 	default:
 		ASSERT(0);
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 16fe7344702f..3d782b7c86cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -383,25 +383,18 @@ static int map_transmitter_id_to_phy_instance(
 	switch (transmitter) {
 	case TRANSMITTER_UNIPHY_A:
 		return 0;
-	break;
 	case TRANSMITTER_UNIPHY_B:
 		return 1;
-	break;
 	case TRANSMITTER_UNIPHY_C:
 		return 2;
-	break;
 	case TRANSMITTER_UNIPHY_D:
 		return 3;
-	break;
 	case TRANSMITTER_UNIPHY_E:
 		return 4;
-	break;
 	case TRANSMITTER_UNIPHY_F:
 		return 5;
-	break;
 	case TRANSMITTER_UNIPHY_G:
 		return 6;
-	break;
 	default:
 		ASSERT(0);
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 5a5a9cb77acb..e9dd78c484d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -453,25 +453,18 @@ static int map_transmitter_id_to_phy_instance(
 	switch (transmitter) {
 	case TRANSMITTER_UNIPHY_A:
 		return 0;
-	break;
 	case TRANSMITTER_UNIPHY_B:
 		return 1;
-	break;
 	case TRANSMITTER_UNIPHY_C:
 		return 2;
-	break;
 	case TRANSMITTER_UNIPHY_D:
 		return 3;
-	break;
 	case TRANSMITTER_UNIPHY_E:
 		return 4;
-	break;
 	case TRANSMITTER_UNIPHY_F:
 		return 5;
-	break;
 	case TRANSMITTER_UNIPHY_G:
 		return 6;
-	break;
 	default:
 		ASSERT(0);
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 0eae8cd35f9a..9dbf658162cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -458,25 +458,18 @@ static int map_transmitter_id_to_phy_instance(
 	switch (transmitter) {
 	case TRANSMITTER_UNIPHY_A:
 		return 0;
-	break;
 	case TRANSMITTER_UNIPHY_B:
 		return 1;
-	break;
 	case TRANSMITTER_UNIPHY_C:
 		return 2;
-	break;
 	case TRANSMITTER_UNIPHY_D:
 		return 3;
-	break;
 	case TRANSMITTER_UNIPHY_E:
 		return 4;
-	break;
 	case TRANSMITTER_UNIPHY_F:
 		return 5;
-	break;
 	case TRANSMITTER_UNIPHY_G:
 		return 6;
-	break;
 	default:
 		ASSERT(0);
 		return 0;
-- 
2.18.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
