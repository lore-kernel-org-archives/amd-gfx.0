Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3CFE7315B
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 11:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A6110E43A;
	Mon,  2 Feb 2026 11:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jrEzdgCz";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9416E10E439
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 11:25:14 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4806f9e61f9so21674435e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 03:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770031513; x=1770636313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QsQ8uEnSdREJihLyf3tIbQsddBQ4q6EZ+Rc6uVEt5gc=;
 b=jrEzdgCz3LNklpCz9J4HAE+V2jbu8x4mCfiC1jFbOn7HjS33EQqIFHBygzQudaW+wh
 a/FL+nvyggrxct65HIN16KElrxDwcFP550CakUVsUEZYv6GIjrEXxSyeKlNH90ZkoEry
 gOkq2wq/AdDFoFgmdTVlCJVrx4kfEt0WApcflNXEsT8v/xr5a5wlehNMytq33DDXb69v
 AZBzqwAvlEpk+CbfqcHDM1JXT0jnBbwp0RL0BmSlNPZ4GSiRsWasedkahH3jum4M+FlT
 kklpRXZavM/QUxXWFoV//oVyT4yn5Wx8njr4ZqP+xiSzjGidb3Vrgoa4RqVSnWAiAscK
 ZQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770031513; x=1770636313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QsQ8uEnSdREJihLyf3tIbQsddBQ4q6EZ+Rc6uVEt5gc=;
 b=v1hDDiwfNY8Opkf4koleu2Z63WkVu4MJjLml7SMT+LAmkx+Ru4bsAvjusAxcm8jCtv
 tTE83FtLvF48UojT9U6FehFhun+n/UBbBTG3HziqSkRKu8mvmnToJdVOLZ0H2DnWYzmV
 cWqGN+HNTLJAQA9H1EsyZA3ix7V5xeiwLz8o8aJSbGlUwOCBfaBpmYuJFgPdfmmZZjAM
 y4yDQCpFApv2todQY9q6mCpQObeaTua5A4px2Yb2Zl1+6B+B3Z6A1cMKDafdEJvLL+7j
 b9ZC+XogjPyEaLHF/qw2wIMptI+xIsjxZh3BTaB6x+QsLNIDbiXHY0hK/iTiSYMCVwhZ
 t80Q==
X-Gm-Message-State: AOJu0Ywvf7WCc9ZFPmaM/fadgyIwvwxMen1VB1QpHILMrRpnyz2W+smR
 NxQy8dzBoGpQDDnNaEhOlvJCP0faGOzFe19gkNzICfNAMXK4FbUQ0xuMWzf7jXL0
X-Gm-Gg: AZuq6aJa3erezKZVNUdfoDilj9wFEZjIa4Dy6E5v3RtJ5AHnWR769oxnwCadqwLyg0K
 ASV2BjGemCm7G27S2PfAEBoBUKX2F86g6GtQsVX3G+RIxHeJZwW3J1peJg0qU7nUQyaBAf8ynXD
 ufQE9fhoylqu+zATXG+V16HK6Txku/Cd5PJocHxT81wNmCwgJjgdBaqqzgHNmaj5yCPN51/2v+V
 EscKxdfy6XDQc2jJEEGl4Nq9u1g2E8RwEVF8KqpnoN7YNygi+6ENbwRbt+5cw2EN1z8HP7IR9Pb
 nnaSBBjNJLDa7UDB5F9HOEVgO49koLoIE0nOWm3V3f0DxqTV9ceTFHSqEi8R0KK4t6hTUJnuqSt
 gleIxZv4Reu9aC8Wd0N1lOrgWvAi3Gu+XBjmvKSH9j7VkurMRfg9BGJnScmPH5nQEjc4ncBXYMq
 3Ci2lsIi57RoWQ
X-Received: by 2002:a05:600c:8115:b0:477:b734:8c22 with SMTP id
 5b1f17b1804b1-482db448774mr127983425e9.8.1770031512909; 
 Mon, 02 Feb 2026 03:25:12 -0800 (PST)
Received: from Timur-Max ([109.137.72.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm43306225f8f.7.2026.02.02.03.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 03:25:12 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 siqueira@igalia.com, Mauro Rossi <issor.oruam@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/8] drm/amd/display: Fix disabling fastboot on DCE 6-8
Date: Mon,  2 Feb 2026 12:25:02 +0100
Message-ID: <20260202112508.43000-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202112508.43000-1-timur.kristof@gmail.com>
References: <20260202112508.43000-1-timur.kristof@gmail.com>
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

The fast boot optimization should be enabled when the current
display controller engine version is DCE 10 or newer.

This was a typo.
By mistake, it was enabled for older than DCE 10.

Fixes: 7495962cbceb ("drm/amd/display: Disable fastboot on DCE 6 too")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 4659e1b489ba..bd3a9f008699 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1965,7 +1965,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
 	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
-	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
+	if (edp_num && edp_stream_num && dc->ctx->dce_version >= DCE_VERSION_10_0) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
 			if (edp_link != edp_streams[0]->link)
-- 
2.52.0

