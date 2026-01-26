Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA17D1951F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9126E10E4A9;
	Mon, 26 Jan 2026 21:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R+Uz4HIn";
	dkim-atps=neutral
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C19AF10E4A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:48 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-4801bc328easo55840275e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461727; x=1770066527; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2KfeyCZN9isKUbc+K+4j4RAGOncenX+jP52x3ZfdJvo=;
 b=R+Uz4HInuZF5jqXI+AVcoHRUrAfgE4gZmYRF+2r2Vnv2t2F14WrhZY5boDpCiXVwPp
 OuLIhkarCVXgg/ziACerUgkDGOXVwMscTgEa0AdULgJHi+QEjy/YJm0aVwWp5/oA3ZYb
 2iKfyOOdCsw3nohxPj6bfc3w/ipR7+ImpqOzcEvfC8ROacZKILHxnu7Sd68DaRhyKzV+
 92VeKZKYypdmISg13bkdMmozdU9gAwt+pNPucGdd3MjDEKNMTqNRWYPzbaMN+/6vjAEx
 53f43mN7if4Yzf/E/rx2hH+JJqpF7gTcu3ddtCA5Ix4Bs4zBzYrdiadbzIZg1HSyd71p
 qcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461727; x=1770066527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2KfeyCZN9isKUbc+K+4j4RAGOncenX+jP52x3ZfdJvo=;
 b=Z6VsrelnZ8goe8BI6B+ulRtApd5pEAYcV7GK4KvqEL0Sh8u02fXL94n2s5mPXTGG5d
 z2awrYw7Q1XsiVy4aPoOuDA2vELjs7AbmhVN2TMthX3zRjtqEQy64q3V0t6Pv8r/dieV
 ++8OEX9x7vTEPPiqpOPTl6QulxnYcsF2TAUX2RwBf0/q9Cfh4zTK3h68TAGDo8y4x70f
 VBCFJwDxymqwNpp8HDebGyngFiPYjo5D5W2NPRiH8yJw9if/BXE9MKxBql5IpggIZYr6
 HRTgvOK9vBWbOukSIQuqnFRI+upW6QKC+TSdAWz4JVVlxKIkUq6b5TCls9Iy3N7Zyqmh
 40fg==
X-Gm-Message-State: AOJu0YwVdIzZf7PF9eXTmkMIS/Vr4EOTXzM4qepM9OUxTeoAU3BupekQ
 bOg2KP9K+B1sb0HWRXy/K65V+3CwbxPqvghylcBYCRnDy8KOdE+PqnMxL7vOn6rR
X-Gm-Gg: AZuq6aL8+FIMZ2iDJrca/tLNuKMDfMhwVEvTLRmw5ZyOW6RiMXvuYO95cz4BzqN7KVA
 oiJyTJHlBnwKGW/w/vWRivZmc12SRdta0s1GggTwvpjJJMu3yd4T2B70cYcSlT6Nx8txNHub3KQ
 +LF29uDCEgYoVYKOaOjDzrT1HZ/XCikCby8IM5xBCcPeLIS++fuja7cUqHl3Ip0shVt6aYF7dfT
 g8O5HpPUaIzwtzrK1VgOuKJr70AUnfHhjXd5y6Dgsr/k+xOE2idNjQjOJzPo2O52j3Ke/MaX81o
 w3zxTKrGw0pWoogCwoaAsbtpTLY7Dr7oAokVMLVEu7eNmzkh5uSd04rctIKjoCkpvvgpt4MchWu
 k9D5kRVIN17RMra/j0f7MccwqiOYROgoPsKZlAoF9QCU0jDSKkhS1FFHtIfjNrYTSyfGjPFROty
 2jtE0BDM1czAMfxjtcDoWyTYnIeJkB3yAeav79YTRLJGjWdCYrq5qq1h4AF5sAI08=
X-Received: by 2002:a05:600c:46c3:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-4805d0646e9mr88250315e9.26.1769461727229; 
 Mon, 26 Jan 2026 13:08:47 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:46 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 08/14] drm/amd/display: Add ability for HWSS to prepare the
 DDC before use
Date: Mon, 26 Jan 2026 22:08:31 +0100
Message-ID: <20260126210837.21885-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126210837.21885-1-timur.kristof@gmail.com>
References: <20260126210837.21885-1-timur.kristof@gmail.com>
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

Make it possible to add a HWSS function to prepare the DDC
before trying to use it. This is going to be necessary for
external DP bridge encoders.

This commit just adds the function to common DC code.
The actual implementation of this function for DCE is
done in a subsequent commit.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 3 +++
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h        | 1 +
 drivers/gpu/drm/amd/display/dc/link/link_detection.c      | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 1f41d6540b83..3b8b7a4d9dd8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1016,6 +1016,9 @@ enum dc_edid_status dm_helpers_read_local_edid(
 	else
 		ddc = &aconnector->i2c->base;
 
+	if (link->dc->hwss.prepare_ddc)
+		link->dc->hwss.prepare_ddc(link);
+
 	/* some dongles read edid incorrectly the first time,
 	 * do check sum and retry to make sure read correct edid.
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 5c9a758fde37..93e171c3a179 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1188,6 +1188,7 @@ struct hw_sequencer_funcs {
 			const struct link_resource *link_res,
 			enum signal_type signal);
 	bool (*dac_load_detect)(struct dc_link *link);
+	void (*prepare_ddc)(struct dc_link *link);
 
 	void (*get_dcc_en_bits)(struct dc *dc, int *dcc_en_bits);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index e1d568905581..2ccbca570c77 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -909,6 +909,9 @@ static bool link_detect_ddc_probe(struct dc_link *link)
 	if (!link->ddc)
 		return false;
 
+	if (link->dc->hwss.prepare_ddc)
+		link->dc->hwss.prepare_ddc(link);
+
 	set_ddc_transaction_type(link->ddc, transaction_type);
 
 	uint8_t edid_header[8] = {0};
-- 
2.52.0

