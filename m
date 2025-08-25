Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFA5CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2202910E5AC;
	Mon, 25 Aug 2025 21:56:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GLpXDIzq";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37CFA10E598
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:56:38 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3c46686d1e6so3053916f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158997; x=1756763797; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKvDrHKAjd29FkcdJ4KOdy80p0NjS82Q5MtH5X5q71w=;
 b=GLpXDIzqhNSM/RoMaG8mAFBFwt7FhrKfIvl6VQ/pvAbic5WVZCOCgWhzOqm+2GsSLo
 HESdLJkkh3MuV0ixXUdYe7IvyTyEXbTGpwllvFnU/cYh08fSZ0eSMMeKr3SulvYpV1oY
 kPn5zzikxCdbeKimFFfluBuwMNVjBU6ZD6dKTKk69q2dqCkCCaCg7oOrGlnWz84+aPtd
 2X6iOLoXZsNxsF1kef3sD2rZVlYUbfjCPtwBMKR0z55+ulwgkvv3B4ssTpFknIvJbGy/
 3pFDI1+njnUxbHEg7svyoiBeHtgkJvdlBDXybFrs/9XVShQl3q8L98aRXhoUAjX2xWXU
 5KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158997; x=1756763797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKvDrHKAjd29FkcdJ4KOdy80p0NjS82Q5MtH5X5q71w=;
 b=E4g3Jp2OGtazH4mytpYLu1WEAg3lK0/uToJI1nCGK8GqNhjbgf+b0bl9OvFDIRjUWZ
 k6f1L86EZtGh/BoiD1D5VSoyLsVuJ9uTaSP5JXSkio2QLfGIwfZ9FfTRulYQGl1OiMfO
 yx7HNPdgnKE8uUP8VudywzfTSKikTA6Tt9qxLB+oIOTvo5QmxIhP/+RmnW/NfrNXt/03
 8r1oKpV2rFaI3qyy3z9JVCi65vzCIfMHaHYWa4viGslbyyoTs32AC8EjM73mLoBcn/SR
 KGX4y52WXqpcMxRvfHHYtA7R/OR5ACbuEUK2hZeS8C7kc5nHFbrpHuai1pAadl1X5FWt
 wLaQ==
X-Gm-Message-State: AOJu0YxCaW9W5Bp+Gsg78uhVvz9kQP3bJecCUkyOL685MIOHlj6RDl0A
 T8AvQHZ/Kfv2epOQwUfvLP4+rX0Gk+i3Irt9SVjHiHK/6rPyoN9dXz5uJ29Blw==
X-Gm-Gg: ASbGncurFxWFReGni95amUShgpjGHC97HS+ALbQmKv8FJUIr7htMdJmpp0rAk0avnEr
 bkvDsMXcK4dfgrImv9KdOUqQwBeL4Hr1Ua92CyRA73Ra2cLMHQQ3jlSKckvAIUJ0NZIe/dT7DVw
 rVEumKJFFIjKA453ZceaASK7oLttBV1+JEL99AyxqOBQ5wYmQivVPW/YWRxDZQ5R3leVVgNcYLJ
 k798dj0uih4B3MFVqcZ55lS+IuCF0/KoffxFeH9WcBE7r8Pm3PkPRcLWK1IL/Y/8j6N6jcL45RT
 x7LxAWnlkLVaR5gXDj2Aj877mfCWEo/06YvwQ/TaVH+Vo7zhjD5QtjLld/xAUckefH7Wci5uplq
 XmVTuo0+UQLbNJ5RWi0WZZglseBDe3lPtQ5qKtadauYlieJ8Tpe9k9ueMRv28MgsFoth2Ls08hY
 F8DrxGDOyhaiTVzN8yP7OvKEuOUw==
X-Google-Smtp-Source: AGHT+IEDQGTEelJ+aga6cn7FkfCVGWbtBLAjxETplvXN8UHxYt5VuNHkifo7fRFgYFY0fujSiwoF5w==
X-Received: by 2002:a05:6000:1788:b0:3c3:5406:12ad with SMTP id
 ffacd0b85a97d-3c5dcff73c7mr9384091f8f.61.1756158996638; 
 Mon, 25 Aug 2025 14:56:36 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57499143sm121827575e9.26.2025.08.25.14.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:56:36 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 2/4] drm/amd/display: Disable fastboot on DCE 6 too
Date: Mon, 25 Aug 2025 23:56:29 +0200
Message-ID: <20250825215631.628949-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825215631.628949-1-timur.kristof@gmail.com>
References: <20250825215631.628949-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

It already didn't work on DCE 8,
so there is no reason to assume it would on DCE 6.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 153d68375fa3..1d57df7fc948 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1923,10 +1923,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
-	// Check fastboot support, disable on DCE8 because of blank screens
-	if (edp_num && edp_stream_num && dc->ctx->dce_version != DCE_VERSION_8_0 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_1 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_3) {
+	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
+	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
 			if (edp_link != edp_streams[0]->link)
-- 
2.50.1

