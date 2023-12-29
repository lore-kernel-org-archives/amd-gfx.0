Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB46C47073
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Dec 2023 17:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7654C10E2CB;
	Fri, 29 Dec 2023 17:43:43 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C3810E2CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 17:43:42 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so5501273a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 09:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703871822; x=1704476622; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7yGnFMfovRgf22VGv/wXN8Byxi60LfoBIt8oAuc5W4=;
 b=j0EJ8BlLygySgvoVDPO8d84okIta/7A68xKGC3s3nfMVqdj+dY3twPGDETubxic3pL
 E+xBnx+ChB92YDzOhX5HG3OztOXdsnfNay5e1+1mlgEO6hwh5PdjS3iYgDsSeC5vKZ+Y
 kSDlqA1JlKuJ9TYIO6wYr/CW89tQ41isQbzeUEAwNBcaYJFV6uI/DMlRigpvBaezCv0p
 CimuOwXCHJPXSpUVxO4tUBTNhVVJFQBvrAq7g3P6nsNXa8iOGzoYbbTf7va96pj4dxU0
 WVBMwXihK6DdSWFYO916ITF7zTUcwEB+JaGXTGTiqxKpv082XPS0hxfstm88S7O2ins1
 GBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871822; x=1704476622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7yGnFMfovRgf22VGv/wXN8Byxi60LfoBIt8oAuc5W4=;
 b=Hly/FqB4ZWApck3DBpoueUdVAybtUXNEnggzwHj4MBA/iTbfP5EZlooinlaOuXKy01
 3mQPMUK+smDEybiXXX9j/+F+MGIboqj6puz6mblWja1RpB1P8lAAxmz2qoIGNryE+WK1
 +TpbfFtQPkYiai3GVenVhdauj3feh5hs2Q2DDBlAuv/6UpqHnx/pWI7uXH9xenSc2bnS
 stSJEbwUCs7KiIY4wDi7QF6zyp8el0+JDhgJI009oii0LCeFPzfPlP9YKHATEs0T/lGL
 fzYzxZJlEa4UYHY/WKen1wUaf/AsbqCdsgjCSbKz5TicpJFXIhNlClKJkNkZLVX7Bn0D
 avnw==
X-Gm-Message-State: AOJu0YxryRHPRVcDfTzS4PWHCCnSvOMQo2YXfwR8QoAWKFKk1syHUnrh
 oOitY9xH+xltRFuL4HdDQRHoCBrxeQeCgQ==
X-Google-Smtp-Source: AGHT+IFS3uHTt5SUw8YM8Kor9JFOX9EbjHll1B0AeMhBXpkOAw+cvVwWmcFZICpNSbVT6Y+YXmvu1w==
X-Received: by 2002:a05:6a20:78a2:b0:195:a969:9215 with SMTP id
 d34-20020a056a2078a200b00195a9699215mr7856813pzg.121.1703871821611; 
 Fri, 29 Dec 2023 09:43:41 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a8c2:13af:e16c:ee4d:83e4:91a0])
 by smtp.gmail.com with ESMTPSA id
 m25-20020aa78a19000000b006d9b38f2e75sm10056424pfa.32.2023.12.29.09.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:41 -0800 (PST)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com
Subject: [PATCH 5/7] drm/amd/display: Fix hdcp2_execution.c codestyle
Date: Fri, 29 Dec 2023 14:41:54 -0300
Message-Id: <20231229174156.1800-6-marcelomspessoto@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231229174156.1800-1-marcelomspessoto@gmail.com>
References: <20231229174156.1800-1-marcelomspessoto@gmail.com>
MIME-Version: 1.0
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
Cc: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove braces for single statement if expressions and change comparison
order for hdcp2_execution.c file

Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index 91c22b96e..733f22bed 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -208,9 +208,8 @@ static inline uint8_t get_device_count(struct mod_hdcp *hdcp)
 static enum mod_hdcp_status check_device_count(struct mod_hdcp *hdcp)
 {
 	/* Avoid device count == 0 to do authentication */
-	if (0 == get_device_count(hdcp)) {
+	if (get_device_count(hdcp) == 0)
 		return MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILURE;
-	}
 
 	/* Some MST display may choose to report the internal panel as an HDCP RX.   */
 	/* To update this condition with 1(because the immediate repeater's internal */
@@ -689,9 +688,8 @@ static enum mod_hdcp_status validate_stream_ready(struct mod_hdcp *hdcp,
 	if (is_hdmi_dvi_sl_hdcp(hdcp)) {
 		if (!process_rxstatus(hdcp, event_ctx, input, &status))
 			goto out;
-		if (event_ctx->rx_id_list_ready) {
+		if (event_ctx->rx_id_list_ready)
 			goto out;
-		}
 	}
 	if (is_hdmi_dvi_sl_hdcp(hdcp))
 		if (!mod_hdcp_execute_and_set(check_stream_ready_available,
-- 
2.39.2

