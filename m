Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2AFC47073
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Dec 2023 17:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C7A10E2D1;
	Fri, 29 Dec 2023 17:43:46 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C4310E2D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 17:43:44 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9af1f12d5so3697845b3a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 09:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703871824; x=1704476624; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDgfBD5ORXOI+gcg2E8XttFM08WBnDESkti4p4CBxj0=;
 b=hwJ6evlV2ftrPv0xQTF5QyRU8SQxzKJfMIVGMNZ4Mn9ipTlRip0dsX2Jsj5BOjoIvj
 rivdqNpDjiTAJL6raa0ZG5Z9Nm6YryG8zFGzSSVc5g/uC3xaqf1iVC669Xhtcq2r103U
 XRBNqg75djcd4upj7T1CTWPvFYVMKTHVG5MY5zVyWt5+drnVnAhqlWgj8ESdSc8doaCl
 AP0Uhuvj/kbHOapui5d3O/bSRXHBBbXwxT9PmeKyUR8KYLYHPFU7zJqWqUCqGj6Qejiv
 u0efDU3eblm2pVKBDQP6pd/wRQ70SBAEZcssu+uRx+ssZfhUX6ZCpG3BB/KYVLvRESqB
 mVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871824; x=1704476624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kDgfBD5ORXOI+gcg2E8XttFM08WBnDESkti4p4CBxj0=;
 b=pntNTUWUXNhsIG22GzajkuYU8b9yKubwGukEUOo1Rg+W+LfJ9MOlUmVOl0jl9vWyRN
 DLPcr7rVrnyHyVsOa/DtCj1Q/3wTK3xQH7xhzm5NwtRg7lgh3K5dPv2mBFk4h0Q+YqmK
 A/gb4+2AIhW3gxWs+3vDUMzhehxVxEsjTlQfNznOOKkBMwQO5C1oyB4p+fg+fVmmUhy+
 0BcBEenKZnn6vT7U99FqiIyYAFibErU/CcIuXyLaBW3qCuY91JbusJpmKcXAIuGcCsuX
 42zn6OmGQiUtYRMf6Syq+dafpTlCQQLUce0rsl9cTZiq+hSdwOSi259+gXNUys1cm34O
 AdJw==
X-Gm-Message-State: AOJu0YwwlB7uHOybJNAyF5d7DfNJRatwwQSkxfBVheODMxp7STQOc6Or
 Z/SMPsEbh0NecV16Jhs0+ww=
X-Google-Smtp-Source: AGHT+IFQQNxGrcv0XyuXY6n7JC8rq2kDs5EF9fqnqQmpqocqvYbcmzkWoNwOca68S4qKKYSmIA05sA==
X-Received: by 2002:aa7:8c47:0:b0:6d9:b417:1afe with SMTP id
 e7-20020aa78c47000000b006d9b4171afemr8938226pfd.32.1703871824309; 
 Fri, 29 Dec 2023 09:43:44 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a8c2:13af:e16c:ee4d:83e4:91a0])
 by smtp.gmail.com with ESMTPSA id
 m25-20020aa78a19000000b006d9b38f2e75sm10056424pfa.32.2023.12.29.09.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:43 -0800 (PST)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com
Subject: [PATCH 6/7] drm/amd/display: Fix hdcp_log.h codestyle
Date: Fri, 29 Dec 2023 14:41:55 -0300
Message-Id: <20231229174156.1800-7-marcelomspessoto@gmail.com>
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

Place HDCP_EVENT_TRACE(hdcp, event) macro content inside do while loop
to avoid if-else issues in hdcp_log.h file

Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
index c62df3bcc..55a2c5d4c 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
@@ -86,10 +86,12 @@
 #define HDCP_CPIRQ_TRACE(hdcp) \
 		HDCP_LOG_FSM(hdcp, "[Link %d] --> CPIRQ", hdcp->config.index)
 #define HDCP_EVENT_TRACE(hdcp, event) \
-		if (event == MOD_HDCP_EVENT_WATCHDOG_TIMEOUT) \
-			HDCP_TIMEOUT_TRACE(hdcp); \
-		else if (event == MOD_HDCP_EVENT_CPIRQ) \
-			HDCP_CPIRQ_TRACE(hdcp)
+		do { \
+			if (event == MOD_HDCP_EVENT_WATCHDOG_TIMEOUT) \
+				HDCP_TIMEOUT_TRACE(hdcp); \
+			else if (event == MOD_HDCP_EVENT_CPIRQ) \
+				HDCP_CPIRQ_TRACE(hdcp) \
+		} while (0)
 /* TODO: find some way to tell if logging is off to save time */
 #define HDCP_DDC_READ_TRACE(hdcp, msg_name, msg, msg_size) do { \
 		mod_hdcp_dump_binary_message(msg, msg_size, hdcp->buf, \
-- 
2.39.2

