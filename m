Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12928C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Oct 2022 13:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF5AE10E602;
	Tue,  4 Oct 2022 13:11:21 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF8610E226
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Oct 2022 08:14:55 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id s20so4358934lfi.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Oct 2022 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=hPaN5F00WNMdLlaDyOEsLhHNGFoDad3WAqwYwUQx6uY=;
 b=KfyD+OiUrVWViL1kJZsMGn8t7Mibe/Tam0ljRwRxIptn+MhEYtqJRsvpHC34hDqVia
 hBcihEX6Ewd9GRs7WfYImo4oQ8WvGCdmYHijfKyZpuqWpiESjiALshG2u5XjNDLYTYOB
 cP0+I4ALEJrbMLFUj3f4XGXiiTe2zZUCSub16FQb/3U/OgPGdLla8BRyoDwTD+qKjkdX
 nsw0tImjoCo2xetzdvKSABAfBL4wPoksoRM4BqtfLJ9QhWFhA7iH17JkCCrB/Bk58olP
 vNnkvnjbUujGDqasadpjOzT4S3pY1BSbk7LPWm6liL7iTjgvkk5Zst0QoreF9CAbi21p
 4wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=hPaN5F00WNMdLlaDyOEsLhHNGFoDad3WAqwYwUQx6uY=;
 b=k08zUPzYugJ4wbrdiFinR4ib4hsBJn6bXELwcCt7dYkUAJQtSzVFZKOfnihl1Jx9YG
 d1bkDnZ5dXeoAwJR1+G8Ch90x08yRUnorUzkVeTDJKpntqJOJ3xC4ONd0c9KXfvi/bJA
 M8jtQDqz9VCDGF0AT/KejDrOgN0RH8QnXEwk5bgKGQ/wrkU5WTCX0EYdjGakhlLg+XOR
 9FrJENs1vYTVgr+MqMFN8SJZ6qpd9qPonLiY6I3wdjv1EWNB6oacIiz240eG7v1I2MOV
 MMraHv4w+iozl4QNh7M6haDjR4Be3/SdgOEA37/WstvlYATYGHAzBbltV+FJ/hoTqcPr
 QV+w==
X-Gm-Message-State: ACrzQf3nIxTCpcmYTGZp40n5Q4QRl9Sj3bQ3gPvMhKQglXGOHRG3g2Td
 SSFc4OpbnIMUB7cqb5WlTEI8xl0W3sCT
X-Google-Smtp-Source: AMsMyM68vvXqKyv24OwvaggsIP4KOeaNgpz/TTOVMPLPC1SJ/uTtq7qFmEyuZEuEG66uuKk8RYIKHA==
X-Received: by 2002:a05:6512:3252:b0:4a2:473f:1fa1 with SMTP id
 c18-20020a056512325200b004a2473f1fa1mr2132696lfr.53.1664871293221; 
 Tue, 04 Oct 2022 01:14:53 -0700 (PDT)
Received: from localhost.localdomain ([95.161.223.113])
 by smtp.gmail.com with ESMTPSA id
 cf31-20020a056512281f00b00492c663bba2sm1808982lfb.124.2022.10.04.01.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Oct 2022 01:14:52 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: smu7_hwmgr: fix potential off-by-one overflow
 in 'performance_levels'
Date: Tue,  4 Oct 2022 11:14:02 +0300
Message-Id: <20221004081402.49069-2-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221004081402.49069-1-aleksei.kodanev@bell-sw.com>
References: <20221004081402.49069-1-aleksei.kodanev@bell-sw.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Oct 2022 13:11:14 +0000
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
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since 'hardwareActivityPerformanceLevels' is set to the size of the
'performance_levels' array in smu7_hwmgr_backend_init(), using the
'<=' assertion to check for the next index value is incorrect.
Replace it with '<'.

Detected using the static analysis tool - Svace.
Fixes: 599a7e9fe1b6 ("drm/amd/powerplay: implement smu7 hwmgr to manager asics with smu ip version 7.")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index e4fcbf8a7eb5..7ef7e81525a3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3603,7 +3603,7 @@ static int smu7_get_pp_table_entry_callback_func_v1(struct pp_hwmgr *hwmgr,
 			return -EINVAL);
 
 	PP_ASSERT_WITH_CODE(
-			(smu7_power_state->performance_level_count <=
+			(smu7_power_state->performance_level_count <
 					hwmgr->platform_descriptor.hardwareActivityPerformanceLevels),
 			"Performance levels exceeds Driver limit!",
 			return -EINVAL);
-- 
2.25.1

