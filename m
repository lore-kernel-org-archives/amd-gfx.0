Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274C4C47074
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Dec 2023 17:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B478610E2B9;
	Fri, 29 Dec 2023 17:43:40 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95FBF10E2B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 17:43:39 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6dbca115636so4212487a34.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 09:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703871818; x=1704476618; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkbUnn5Ov6f9K8Q3Xl0KXzVU1AtEsVeOHr25GVJq1Ns=;
 b=ZE+wy0LxT8atLwmTzcV1IH0/F93DysIeZ5di6FN4zmZgPBGLx+7pwLoTrwKaa0EvvP
 08q8PMSldgEqiDfPJM6ZxJmkektfsoel6S40N6XBnXosn3mcn/p+ol4fAA/OrFiPgdKe
 KLzNQ274SM7VqS0JYwwx083Mo98M+4Z5L25ExnS/1N44kfHPKpHzli9SCZEqUKcfjqgU
 BWS1Vocp22U8O7oxXbW0k3Cr5UFrblWPEWjPC1h0xQ9ry3QQq4xyAJyJFnNrzB00rWuI
 xsIUjlJArg9cMcUP0AGkeHqjtBfGyEsT12enR5eo5PPRNFnc8hz/3jGaBbdibdDbWdXk
 q29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871818; x=1704476618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GkbUnn5Ov6f9K8Q3Xl0KXzVU1AtEsVeOHr25GVJq1Ns=;
 b=guQRhq2VqX3qxS3o3NK659FzKCWiKPOZbCp2xjQAFBA2ffTeJ1wAmathng8dblPTBV
 1RbCXUIB15+Goojs/vFv6J5tqZZdbK5lARJfLPyvbqi6cmVQNQO2xiEddElUypL+9cFk
 2epvlsfgdCyCmCd8FyP/j7aWwmhC5cf2DCra7AZbt1DGawswKPkaqFplC7BJc2HrXlKK
 UmmJ8vFB41YhTEgyiYPbnausVLyG7XS863EXK5g7ms0traJYVFfmg/CFOVQ5ZbEeErEn
 +5Awum0JMi7WyTZitTtn9sEwFyTE18l1Y3xbWWaji4eZdpR0CRGmohvZKr5CEa92w8uU
 ExSQ==
X-Gm-Message-State: AOJu0YwSYN/mrzzg+7euZJgWmeBVu5hQF+gsgrhYSpmxdxXVpQmEP5R4
 jiycfFXtH5p1UV+xksCFjpI=
X-Google-Smtp-Source: AGHT+IH6HZpgn8URxOANkEf11oQ6gJQA4TVXAKOZa56OwN27wmsFkMBKfDFIGLbydYNKqk8yMNL5+A==
X-Received: by 2002:a05:6358:4298:b0:174:ecc5:1960 with SMTP id
 s24-20020a056358429800b00174ecc51960mr6671064rwc.32.1703871818573; 
 Fri, 29 Dec 2023 09:43:38 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a8c2:13af:e16c:ee4d:83e4:91a0])
 by smtp.gmail.com with ESMTPSA id
 m25-20020aa78a19000000b006d9b38f2e75sm10056424pfa.32.2023.12.29.09.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:38 -0800 (PST)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com
Subject: [PATCH 4/7] drm/amd/display: Fix hdcp_psp.h codestyle
Date: Fri, 29 Dec 2023 14:41:53 -0300
Message-Id: <20231229174156.1800-5-marcelomspessoto@gmail.com>
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

Fix identation inside enum and place expressions in define macros inside
() for hdcp_psp.h file

Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
index 5b71bc96b..7844ea916 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
@@ -98,9 +98,9 @@ enum ta_dtm_encoder_type {
  * This enum defines software value for dio_output_type
  */
 typedef enum {
-    TA_DTM_DIO_OUTPUT_TYPE__INVALID,
-    TA_DTM_DIO_OUTPUT_TYPE__DIRECT,
-    TA_DTM_DIO_OUTPUT_TYPE__DPIA
+	TA_DTM_DIO_OUTPUT_TYPE__INVALID,
+	TA_DTM_DIO_OUTPUT_TYPE__DIRECT,
+	TA_DTM_DIO_OUTPUT_TYPE__DPIA
 } ta_dtm_dio_output_type;
 
 struct ta_dtm_topology_update_input_v3 {
@@ -237,11 +237,11 @@ enum ta_hdcp2_hdcp2_msg_id_max_size {
 #define TA_HDCP__HDCP1_KSV_LIST_MAX_ENTRIES 127
 #define TA_HDCP__HDCP1_V_PRIME_SIZE 20
 #define TA_HDCP__HDCP2_TX_BUF_MAX_SIZE                                                                                 \
-	TA_HDCP_HDCP2_MSG_ID_MAX_SIZE__AKE_NO_STORED_KM + TA_HDCP_HDCP2_MSG_ID_MAX_SIZE__AKE_STORED_KM + 6
+	(TA_HDCP_HDCP2_MSG_ID_MAX_SIZE__AKE_NO_STORED_KM + TA_HDCP_HDCP2_MSG_ID_MAX_SIZE__AKE_STORED_KM + 6)
 
 // 64 bits boundaries
 #define TA_HDCP__HDCP2_RX_BUF_MAX_SIZE                                                                                 \
-	TA_HDCP_HDCP2_MSG_ID_MAX_SIZE__AKE_SEND_CERT + TA_HDCP_HDCP2_MSG_ID_MAX_SIZE__AKE_RECEIVER_INFO + 4
+	(TA_HDCP_HDCP2_MSG_ID_MAX_SIZE__AKE_SEND_CERT + TA_HDCP_HDCP2_MSG_ID_MAX_SIZE__AKE_RECEIVER_INFO + 4)
 
 enum ta_hdcp_status {
 	TA_HDCP_STATUS__SUCCESS = 0x00,
-- 
2.39.2

