Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901E560A2606
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NE/4JsED
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943B810F6CD;
	Tue, 10 Nov 2026 13:15:41 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FDEB10F6CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 13:15:35 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6b70192ebceso3544153a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 05:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794316534; x=1794921334; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oh2e2vjuLv+CFo3ixnoCrqgK7d1srk0NoRqmzsamSCw=;
 b=NE/4JsED4gmlB0Mq2YMZq3ODu3elhX0GCEN1cLVL7HHElpwNfMYhiiGAgyaV5LosL0
 JxMJhFxgrxKeq9yu1n8YYWtSZCFs+f0PA8rOHjFgDClTBT9xJ1ZQc1AdmAf4qhjgOvig
 yb8gvVK2/FFWr0aiy73ULi2buPqMhAVpA+EiAcSmruvhoUses5vsyeUrBQZvPq3ikn9I
 sMQJLMIXsagyKnyXDbHpbCgcg8Unm+F2rgeex63mJLJoMbmbdSjiWD2oUZH7QUOOQofF
 5M3mvpggAb4K4Rkb4pFeoJuYYAC1SUk6MsUL/3xhiw109nY3IgYTHR0ru+V9TeIChk/n
 LopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794316534; x=1794921334;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oh2e2vjuLv+CFo3ixnoCrqgK7d1srk0NoRqmzsamSCw=;
 b=iHGWllCknh/CU2sVsZqeu0fq0Q6BGTmqy/hqMlwrcaPzd0nW3uBLUgsHqN0XpCmHhn
 Nuw8rYwnb9vcdjHvyzN7kbtyCoz6M70V8FTFV11/Svg9hNW4l5/Z5SMBHM1BP1+BLtaM
 U8Q4y/DNarUMh+J/yYYnzQ8iga41EBSNb250rSWYbbFGF6H5EY3iFsM11WuZzTZ2nrJL
 hw6b7uK4HpRHSxCc1tHuUsuZ8NYkb7Rv4M4p8epr71WYBqiLwdGe5C7Im8vc1AqMlhxk
 HWBzZ7MXxjFFsbAr3/7j+jS3jqI/3rfuWEyVTCm2loWULRo7SNH77mW2UPVn0oQH0IIM
 APYQ==
X-Gm-Message-State: APuU4Z9YfINBOZ8A/ONAJe4WRZ9O84HFfo8YORfejZy0knZIaFiCOvtr
 tWfSkcuq30ERR4ZsX9ubQVrso4Y+w4pnxxmDKSX+gxbhiTgsZMXC3quKlyITLaGXzeg=
X-Gm-Gg: AYBFou35SrT+zOiSNzDEJ9EVAr1QziypwGHL4X/GeYuC0plaXKQXIBio4jl9cu81+sZ
 sY18nxulaO5p7sS4dfgBAZNH3EYf+mPaFANa9Ltp0gZUKK950sDtkUW1WsyDbZMc+esEfIMpD8N
 HYFmM+ESgUu8J/ok3LvmPv5txVenmqNLLO17Vh5darBBL8qTU7nLgNUeZuUkuARYeLNsBAKxUMr
 08BbvHdVeRpbvkZrbSk7pcwhINdhjP08oU4/2zcxLihWDWxfukdiLTby12faT7lA9q4MBAHTrhm
 NwPq24/nqANioLX7ilXNJSsRWHVzGwb+vYsWH7s9BihEYxLjg+eY6ZUobFlCdJ9VICLkCpryw2s
 qCZnsTPpvdA/quNH1iANL69OhMaYkQJgGKtIzURPn+WGdfdnLFgL2zvUlRBO6ivAfHYGNscMGuN
 tYTs2dhvvtX4PiKg1Mh8gImotCpjzE5pF2BoN4a7g+LAGGl+88UDGsvpcpFkAvu4R4GCiavbqyK
 XTYhXit+JpHKwQU6tN/Hz+LNQLp1dGhjNxq+8fZRJNfqQs4ZXZuoP6iaO1V6Uqa1EYGKT8UPqFp
 Ad+QlqTf+HAT7HCgHJI0M+e1eF/aWrW2Tpij2AFFDAo+NLiBoNESq4eyiKX64EweZv28xRojF+l
 j
X-Received: by 2002:aa7:c6d5:0:b0:6a9:8863:ada4 with SMTP id
 4fb4d7f45d1cf-6b7571c10acmr1542857a12.3.1794316533631; 
 Tue, 10 Nov 2026 05:15:33 -0800 (PST)
Received: from desktop.home ([46.205.207.69]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b75790353asm1126372a12.31.2026.11.10.05.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:15:33 -0800 (PST)
From: =?UTF-8?q?Andrzej=20Pi=C4=85tyszek?= <andrzej.piatyszek@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>,
 Ilya Bakoulin <Ilya.Bakoulin@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Andrzej=20Pi=C4=85tyszek?= <andrzej.piatyszek@gmail.com>
Subject: [PATCH 2/3] drm/amd/display: Wait up to 1 s for slow sinks in FRL
 link training
Date: Tue, 10 Nov 2026 14:09:55 +0100
Message-ID: <20261110130956.160024-3-andrzej.piatyszek@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
References: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LTS:3 gives the sink 220 ms (320 ms at 16 Gbps and above) to answer an
LTP request before the driver gives up on the rate. A Samsung QE65Q80T
(2020) sometimes answers at 10 Gbps x 4 only after 225 to 967 ms, so
link verification falls back to 6 Gbps x 3.

Wait up to 1 s at every rate. Sinks that answer within the old limit
are unaffected; a sink that never answers costs up to 1 s per rate in
the polling loop instead of 220 ms.

Fixes: cbb8e2044b9e ("drm/amd/display: Add DC link support for FRL")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Andrzej Piątyszek <andrzej.piatyszek@gmail.com>
---
 .../drm/amd/display/dc/link/protocols/link_hdmi_frl.c    | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 78e62bfec..97b2b9b74 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -612,10 +612,13 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 
 		FRL_INFO("FRL LINK TRAINING:  Poll for FLT_UPDATE.\n");
 		/*LTS:3: Start Link Training*/
-		/*Start FLT Timer = 200 ms, or 300ms if link rate >= 16Gbps*/
+		/*
+		 * Start FLT Timer. Some sinks need longer than the nominal 200 ms
+		 * (300 ms at 16 Gbps and above) to answer an LTP request, so wait
+		 * up to 1 s before giving up on this rate.
+		 */
 		num_polls = 0;
-		if (link_settings->frl_link_rate >= HDMI_FRL_LINK_RATE_16GBPS)
-			poll_timeout_ns = 320 * 1000 * 1000;
+		poll_timeout_ns = 1000 * 1000 * 1000;
 
 		flt_poll_start = dm_get_timestamp(ddc_service->ctx);
 		uint8_t prev_flt_update = 0;
-- 
2.56.0

