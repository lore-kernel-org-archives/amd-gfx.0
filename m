Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9375C47073
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Dec 2023 17:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477F410E2DB;
	Fri, 29 Dec 2023 17:43:26 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C07C10E2D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 17:43:25 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5945ba54d54so2771981eaf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 09:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703871804; x=1704476604; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHXVABU2Kc6MEFqZvp4RESMPJbHxxLdFi2QVZ9raygU=;
 b=XymD87Grzv8bxOX9m1abpUrDOQdHX41JrL9Hcrme6Q+jEHCkIk+QAg+p1O+k8pCJeh
 HctrwsomMBCSB4sAoKqzSiJJDzWYV7pA9Ce1JzjumNQA3Lsb8nFuPQJn2qvQP2kEz7RA
 sNsHpc7WlbtfMaJ+dCimfBhyfiGxxhQlWFlgjJaggn10ElAGrqrNV/xSo8uVfpfIZaKg
 wJDNkl7ydN6NJYp+h3KhiRn844uEqEIRywKoZmQXhzcKiENkcxj3k5W6kMfMSavvZJX8
 XA0LyR/hVHzbNFceW7EWd5zE0oAhJZTjdkG94hY0zUMP1uu2tvQphSY6/bp76QJAAXzJ
 RrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871804; x=1704476604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHXVABU2Kc6MEFqZvp4RESMPJbHxxLdFi2QVZ9raygU=;
 b=XhxkA77ti9URKcYMc3goMNza50vGDe2yvMoZGPi7dNkKIdUZJxpG03TgJOAG3UlyTX
 +3lLRVsJTn1fsBLrm1z5S2aaziR6hSfx3iWbXWrMI23qIBbtZ5GaqgOE8+wcbgJ0ytVL
 qtHUCNtbktTTtHdD/Fj56VEdqJmD7MuVrKWrjCPWoXolJFJ76jGBnavDu1fjTkmG+3L2
 omV8drTn8y1d8/kgtH8u2SreecdJnBg8d9vQ3n/MLQYgnGn+OzWAmsvr+jzmbUfvihq7
 fbVwYcQ35/Ch801egRKCh4fFETV1LLmjq7BG4HNQL7FoXPvquwzAdq6iuz6D2sPKeqUB
 Z37g==
X-Gm-Message-State: AOJu0YxBcpoRoKKzFS+eGP7jOxr6a3OgwiMUYBM64BLSOmGzxzKXtMx7
 c/4OTqqnrJC6nRkhr/6BHTU=
X-Google-Smtp-Source: AGHT+IGKbZCs5qvTUnAkZzE+ewvoZZgSHLgmUsD0XnSSUxEVXUxoDwwNtcEISJO0AvDyi+ZRZ2IdsQ==
X-Received: by 2002:a05:6359:4c1c:b0:172:fc38:9404 with SMTP id
 kj28-20020a0563594c1c00b00172fc389404mr10495645rwc.2.1703871804079; 
 Fri, 29 Dec 2023 09:43:24 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a8c2:13af:e16c:ee4d:83e4:91a0])
 by smtp.gmail.com with ESMTPSA id
 m25-20020aa78a19000000b006d9b38f2e75sm10056424pfa.32.2023.12.29.09.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:23 -0800 (PST)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com
Subject: [PATCH 1/7] drm/amd/display: Fix hdcp1_execution.c codestyle
Date: Fri, 29 Dec 2023 14:41:50 -0300
Message-Id: <20231229174156.1800-2-marcelomspessoto@gmail.com>
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

Remove braces from single statement if expression in hdcp1_execution.c
file

Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 1ddb4f5ea..182e7532d 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -63,6 +63,7 @@ static inline enum mod_hdcp_status check_hdcp_capable_dp(struct mod_hdcp *hdcp)
 static inline enum mod_hdcp_status check_r0p_available_dp(struct mod_hdcp *hdcp)
 {
 	enum mod_hdcp_status status;
+
 	if (is_dp_hdcp(hdcp)) {
 		status = (hdcp->auth.msg.hdcp1.bstatus &
 				DP_BSTATUS_R0_PRIME_READY) ?
@@ -131,9 +132,8 @@ static inline uint8_t get_device_count(struct mod_hdcp *hdcp)
 static inline enum mod_hdcp_status check_device_count(struct mod_hdcp *hdcp)
 {
 	/* Avoid device count == 0 to do authentication */
-	if (0 == get_device_count(hdcp)) {
+	if (get_device_count(hdcp) == 0)
 		return MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILURE;
-	}
 
 	/* Some MST display may choose to report the internal panel as an HDCP RX.
 	 * To update this condition with 1(because the immediate repeater's internal
-- 
2.39.2

