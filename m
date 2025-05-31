Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313B5C5AD49
	for <amd-gfx@archiver.kernel.org>; Sat, 31 May 2025 02:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABCBC10E0C3;
	Sat, 31 May 2025 02:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nms54wv8";
	dkim-atps=neutral
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A1FD10E0C3
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 May 2025 02:15:48 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-736ef1ccb85so55637a34.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 19:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748657747; x=1749262547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jo0wXCUCTE13/PiwCl8tTowFPmWg8bVXQABbPL1HyiI=;
 b=nms54wv8pe88yKzEMFkCwfvXdIhVVW2U4ZiwwTibhIFvEY+rIitqS1vhHMMUoaM6b/
 WycxC04UMP4CMFmLtISHNRySdEyx7o5YDKfij8l4kHjbP6y48GQ29+IoY9TrK0KTZa+5
 0xBBRjy0WqmS9VfkYloKRtkzr5ujdvy2g54B58fG+z0sDZneIV35z/fBx3eI/GedBLVF
 fYKkMpZjCO5+W61pR+tPE4Pox4oQvhznCozuMQcwzfWS4Ra3bkOEz+nMSwMQAppeJH+Q
 aAX6zgpM4KF0dLsG5rwPXXUzVLPn5McyY5GonxKUTpexCnU1VUGmtzdJUEHQg9C1Bgsj
 4R6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748657747; x=1749262547;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jo0wXCUCTE13/PiwCl8tTowFPmWg8bVXQABbPL1HyiI=;
 b=d2ErgVae1OS1Movv0l5ex66IstVrH1WEit6PMfmsDUXnvXvFFVky7XcUHDhMcw3j9E
 ccc8WJ0WivfJa/HezEEvkR/+w8cmg+QHZ+r49/q37vvbR2Jp0jPYnSstwsU71dcVSIw0
 la2uKsq4XzOFG87DsdFmyJVyygG570LP+7ZKlUqX4wb38teBJ0BnAo20b31DqxshvJuz
 UwI1pvIHON/S45UWfmJRSDcQ8nnJWldpdygzeWWbmmDHqZX+KKdNnT7eLUaSOcGgrCVu
 vuQ+9LonfFU5RbeOIpC0w3a4l+g38fNl3Cd7v6Ljjan0bA0zM8IZ17doMXLDQJhcMyVi
 sI8Q==
X-Gm-Message-State: AOJu0YwiIB3GJ5U1wCquvRxbDqlCSR+L19T7MLEWrWOf1ZdPpeQQPrvH
 b0Ma7Urh5FCC957lokjhRRLn6stLwTuQHC58+HDtyGCOl+x0sfyHmynxz9CHEA==
X-Gm-Gg: ASbGncsZfz86RwVAiL5EPt9ZrEwxbGgK7PZZGwsRFM4QbyyAmSIIHZ4xkWc5ct4Ycev
 Slk1UN0x/S4kJ+a4upeP1wYZZrKAIXCblUZKOKy4JlOivMGgDeyjl4aURXn5np3rqDi8lfsidJQ
 C6ZhxhSGV3aV5GS9SaENNKZtTsbDB+201PesS3elnSP4ScL+wV7uI9RLQO2QAjAJ9THGZQP/olE
 ey0UKKsbIOjFhVM/GZs5CQ8pEWP9vfUG9AqA+ffUBu8+FQ/ogd8D7aqEhC5G/au76YpPp6fB6Ri
 yl1yeeu010gyUx6U9D9FUIJ5hTVuhslqzLE0aZJm74jSP9kJHg0ZFzbFmXXdaWq078Wnl1E+uw=
 =
X-Google-Smtp-Source: AGHT+IHQYjgIVR/glzjB0LevrtxtYTqsFQDm46idgetJi1FmsL8w2kiV5+L6x5+C6VTxkomQcECsZw==
X-Received: by 2002:ad4:5aeb:0:b0:6fa:c46c:6fa1 with SMTP id
 6a1803df08f44-6fad9092a46mr11790296d6.3.1748657736856; 
 Fri, 30 May 2025 19:15:36 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.245])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6d4d500sm32248786d6.43.2025.05.30.19.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 19:15:36 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: drm/amdgpu: fix dce_audio.h filename definition
Date: Fri, 30 May 2025 22:15:35 -0400
Message-ID: <20250531021535.7049-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The filename definition must have been a leftover from a previous rename
operation.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
index 4eab9daa8754..1ac11ae4d079 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
@@ -22,8 +22,8 @@
  * Authors: AMD
  *
  */
-#ifndef __DAL_AUDIO_DCE_110_H__
-#define __DAL_AUDIO_DCE_110_H__
+#ifndef __DCE_AUDIO_H__
+#define __DCE_AUDIO_H__
 
 #include "audio.h"
 
@@ -175,4 +175,4 @@ void dce_aud_wall_dto_setup(struct audio *audio,
 	const struct audio_crtc_info *crtc_info,
 	const struct audio_pll_info *pll_info);
 
-#endif   /*__DAL_AUDIO_DCE_110_H__*/
+#endif   /*__DCE_AUDIO_H__*/
-- 
2.49.0

