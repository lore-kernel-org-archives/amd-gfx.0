Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0109C47077
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Dec 2023 17:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538BF10E2B8;
	Fri, 29 Dec 2023 17:43:32 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8902910E2B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 17:43:30 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5944d1ce0c7so3147560eaf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 09:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703871810; x=1704476610; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/oN5Kgs8vOcS1tb3i3xf8rw/T12KctZbx72cIkcduU=;
 b=QeBDX8MlW7MjslIsvDZs7yQjT7h8eP7oUrxc+28TW/abW0wWFPkp774/TZPRM+Ybqi
 kR4yhmqJKBiahmvMK/dBiabzI00BhdX3bG6Z98ARRZEpT1ft4f8oQa0gztdiPTt8g8+6
 vKzQqRR1ihXxGThbBSbU8c033ud6/kW5mbvn4om3BXBHZQHpUitXWiFXnedkaCxsCoj9
 kG6vWOTtEzldySwm6AHVG27OMbW4k9hZ5C8TQgNBJjiie3wHYMlxhK6ckQtAsUnmI3IM
 OvqXwKvTTGHtZEUzLFJH+EYCLJPZFmUg03G1M16TmpusU29hKGXCTsH9D8E7uKWmu/63
 CaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871810; x=1704476610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/oN5Kgs8vOcS1tb3i3xf8rw/T12KctZbx72cIkcduU=;
 b=G7xVrp6iHentfxJJ7TyobC3zG2MPuUNysEXaiDCzra0xRvBf6QenS2Xo1q7pOXns5U
 05U+uILZLARXszrWpvEujjflFrY3XauYRwJ4tIdMjpNS5AkP2770HC8awq8jFk54UH7Y
 8RfBS8FN/A8+judn8xIEv2WfUlzms59XIZNrI8Clk8j1Syt8i9fskWdg3dZLPWGOgZbz
 lW9Adkk/nQ1XVOsJeQ3jRBwqIyIaaUKHbh1hQlsoJnXxBC/gt9wOgS7UqSs+aWeMfPnq
 r6gp2RMBz98oNArZ7G4mEwn85WMJo94s+30sD68L/s8O+w4NF3BJaNX5Jd5XpGW68hdI
 0rqQ==
X-Gm-Message-State: AOJu0YwOxsAK/v9Q6bfKOQ0vE88EsOdDJgYpNozY0/exhBjoFnwHSw4O
 pQ7k89bgXR5BeyreWtwFKQM=
X-Google-Smtp-Source: AGHT+IFK5BtUJCJs4SR68ACDgYXDH9JXmouhwYNPhMB0dEC5TFQ3tRf1Vl4wkjmufDdmG+/VPNesmg==
X-Received: by 2002:a05:6358:591a:b0:170:f2f3:1de1 with SMTP id
 g26-20020a056358591a00b00170f2f31de1mr12181467rwf.33.1703871809604; 
 Fri, 29 Dec 2023 09:43:29 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a8c2:13af:e16c:ee4d:83e4:91a0])
 by smtp.gmail.com with ESMTPSA id
 m25-20020aa78a19000000b006d9b38f2e75sm10056424pfa.32.2023.12.29.09.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:29 -0800 (PST)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com
Subject: [PATCH 2/7] drm/amd/display: Fix hdcp_psp.c codestyle
Date: Fri, 29 Dec 2023 14:41:51 -0300
Message-Id: <20231229174156.1800-3-marcelomspessoto@gmail.com>
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

Fix identation for hdcp_psp.c file

Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index ee67a35c2..8c137d7c0 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -443,7 +443,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stream_encryption(struct mod_hdcp
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
 
 		if (hdcp->displays[i].adjust.disable || hdcp->displays[i].state != MOD_HDCP_DISPLAY_ACTIVE)
-				continue;
+			continue;
 
 		memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
@@ -926,7 +926,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
 		if (hdcp->displays[i].adjust.disable || hdcp->displays[i].state != MOD_HDCP_DISPLAY_ACTIVE)
-				continue;
+			continue;
 
 		hdcp_cmd->in_msg.hdcp2_enable_dp_stream_encryption.display_handle = hdcp->displays[i].index;
 		hdcp_cmd->in_msg.hdcp2_enable_dp_stream_encryption.session_handle = hdcp->auth.id;
-- 
2.39.2

