Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EEBD3ABDA
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Dec 2025 02:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B10A710EBE1;
	Sat,  6 Dec 2025 02:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kdXQQ868";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD5510EBDF
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Dec 2025 02:31:19 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-42e2ddb8a13so1325711f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Dec 2025 18:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764988277; x=1765593077; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfyyFQqc2imYEGtyR7LjwI7bPCVKjdwCE8HZLulSLTg=;
 b=kdXQQ868qNLQtCjMzjFipyUJIRcZmBss2JwFO1bqXfUsk/Cd4bCmZUL50+IfMgKiyV
 8Fs/7dNAl2lMG0YYsyiYJk09tuN9tjnUP6ECjttHyw7lmqjE3u8j7zadQ2QkRKaq1DMf
 89pVf+M0FCjOYugqexGmKnRh/KJyP6IiI74Se0MX/Vr8//HDN9IwiYVWx085orG4EBzd
 ZCmz43rTH3NvtlVNUZb2R26yfM509aiFo5lqPAVAHLJbfobVEoRUi6pjmN0N3YeCNsEe
 JgMFpZ0l2iKNnnto1rBOrHMOyDcyHja9AzhBfS3hNwVQG53FcsoeovqNwiIc8SuaFpu0
 4oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764988277; x=1765593077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NfyyFQqc2imYEGtyR7LjwI7bPCVKjdwCE8HZLulSLTg=;
 b=ohJNbMgmbpgOvJekRtlzeWMY8jZO/VtVetY6LLUI2x4D5NcHbFOUNKf578CftnC/ku
 Nm+NubgABUeRdP4tvYZ19OukWqPBxZL0HcCtHpn3VdFxaE4ac1ZaJdSV9aB0Dm1T8oz3
 6H2ZEyKZfIfKNLLJZmFNF+WVbgSkYu5Ibkk02zo5Wze3miTb77pTqkeSzyk5GoSBEVPp
 /ZBZNihqw8r5KG7slaSUtnP5zNaEp1BwnLTC4hwsEu2kGCCkxj+jQfHurU/IP1dAs5Hf
 oJ/+zWLK+TgEIccyUe+dbyfI8pWd74+FBDDuVm7FoLkeXmgwioxdv/x/UQqfsiN44qhE
 S7ww==
X-Gm-Message-State: AOJu0YzCZ0zdpnZeWkGZeO1T5F86ODyQVB81Tqay+g3Vsgw2iNIEl/jQ
 swsvpX196zPPQA/k5BZpdMRB+Nd58UqAT/OC20XhxpdEyoTEUZT7PA21qR1Ltg==
X-Gm-Gg: ASbGncuEo0Yc/IB7rOPDluSaF+Kpvr6tj8pil8sWoruQ2rgJMGe5bHoJTl+pT/AghdI
 c+0A/aDX2Vftg7P1rz+kwUvBOPtgqDtFfFFOVW/V6FAr18JkKaafxyWILyLze0w2H0Bq84Xjmq4
 DuAEt1idvzd7ObQesCp+EL3qrCyo3RlraJCAs4f2/VNdQiPpT4npKoRyW+eDhRpZypHC3n6yz6O
 d52SjP8G5LeB20unMy6SeNkaDHA5QpjbVZZni1iY5IWwlBleFQ8IUPngykXxD3OVW3AbuOT/3yI
 vaLXOiznb996OCPGjSqRAxYWhyHJNG1sXUUeLBfqcU1BaY3matDhoPI4485CVwEEg2B3r3mdW+g
 T9lpNDmIYbyChZ7ZRBp2Fiq+/qwWWnh7tV2pFstgwOwSrYx9UyyJRZNWskE977WPmhtLysWQu44
 GNzm5ml+1MwbaUDIZErS1siN8mFdMYlCihYB8RvZGIpOMBDden+3+wZQhnOffbU9/9m02u7yvcR
 s4rdWVKGZ3ZW4qR4nc=
X-Google-Smtp-Source: AGHT+IGoAt9rn5utTNNkEx+njJlt/dctWGfKMNrudyrpcLQ1VG7nEEkPXzNjZseVJybBDuRwFg7r+w==
X-Received: by 2002:a5d:64c5:0:b0:429:c450:8fad with SMTP id
 ffacd0b85a97d-42f89f57394mr1239257f8f.53.1764988277491; 
 Fri, 05 Dec 2025 18:31:17 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E095001DEDB2C8B6514266.dsl.pool.telekom.hu.
 [2001:4c4e:24e0:9500:1ded:b2c8:b651:4266])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbff320sm12133689f8f.18.2025.12.05.18.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 18:31:17 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 alexander.deucher@amd.com, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/5] drm/amd/display: Don't repeat DAC load detection
Date: Sat,  6 Dec 2025 03:31:06 +0100
Message-ID: <20251206023106.8875-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251206023106.8875-1-timur.kristof@gmail.com>
References: <20251206023106.8875-1-timur.kristof@gmail.com>
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

The analog link detection code path had already performed the
DAC load detection by the time the EDID read is attempted.
So there is no need to repeat the DAC load detection,
we can know that no display is connected if no EDID is read.

Fixes: ee9fe14a64a2 ("drm/amd/display: Use DAC load detection on analog connectors (v2)")
Suggested-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 6d31f4967f1a..5c769f51f1ea 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1169,11 +1169,10 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			 * - cheap DVI-A cable or adapter that doesn't connect DDC
 			 */
 			if (dc_connector_supports_analog(link->link_id.id)) {
-				/* If we didn't do DAC load detection yet, do it now
-				 * to verify there really is a display connected.
+				/* If we didn't already detect a display using
+				 * DAC load detection, we know it isn't connected.
 				 */
-				if (link->type != dc_connection_dac_load &&
-					!link_detect_dac_load_detect(link)) {
+				if (link->type != dc_connection_dac_load) {
 					if (prev_sink)
 						dc_sink_release(prev_sink);
 					link_disconnect_sink(link);
-- 
2.52.0

