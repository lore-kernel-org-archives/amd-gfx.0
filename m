Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAA2CC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCBA410F24D;
	Wed, 14 Oct 2026 12:47:39 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1B3510E870
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 14:01:28 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a022fee0caso27892595e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791900087; x=1792504887; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ViTWpehkUTNRhhx96u8NdBVsVZbPiHx1y/c2M4wY64Y=;
 b=jRVlnioh4GGa/VWFL7qF41aKB81rflnIGo6aVF2HEl4TstSfc97k5W8SShf2RV8Xz0
 0veV7jCd6i4SMg7XvqcPUo2IrPMCxHPXKYspBZ9UR43b3Yb8dLxQuYwF8UiNA2dsc+zT
 92/bbtbSl8dRiMdcT7UCmyS1qu+QoHQvOi584GtV/uz5V1wpYCnhZ8TKc1WBcA5HAjP5
 o+q77oPtGiOMNvLW6i9QyZ0nAosyajycuB7r8L6jU5OKvV7RUVn9CRR8vABH9CXBRQVs
 jIOH2q1ki/LhcL5TYK4uzzBy+ypyoAy/yn1VEPdp43tjDfereq+HTHBoQRe1dHFgff2R
 M3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791900087; x=1792504887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ViTWpehkUTNRhhx96u8NdBVsVZbPiHx1y/c2M4wY64Y=;
 b=Ls92MhE6jWLFso2aqUKCK56yGODeJoVfzgqn7xs8AZcnmvoDp6dK4sHUQFGYG3E7zp
 3eAEq1oG9VYkDtg9jBAjPQnrP9Xjf8ngNa+iJf/0D03e3lVwWWN3KMbUbqzOBul6E1ZZ
 mDjTKumSY5/QSjSWnhROE42ylJ3k/KsnF4guJWnUhLmjeaTD9HyD24mC1iNZ4vd11O9L
 sDzxpLhYMjOyEACuAIgQYK5M5XL3XAh90tr03ZLm3ta1++lgzt+cUZ+6Y8oUVBx/8cD8
 f7m+I7Cy+CSy8ySOxSYL5lKBxOJeRhKJ+SO8y70s24DDL1Cw8bGgjNge+ukJO8zBLsAa
 Zjrg==
X-Gm-Message-State: AFq9FYJKkoluv0N2Z86R9ziz7jSqMuVNz6GaCat/K4f931hOS5wAXUTW
 aGMZfBPO/ChLe5q4WOYI8qX/x0k8L71IrRd0cBrHmj8cR/uE68KnqZxQ
X-Gm-Gg: AYBFou1AX+CoyLXwCyIQR+80B/SJSQusUTw7Rl2VCd9WdwFMVvXo2X3+UzGopwjLjbz
 ObdH17Kp4MWMY1GIjdjXF5Vy3AfMxtvkf1BFEc6OvrsSBKy70ogrFhJVEpJ+NEyxDdER6DOCAwV
 Fxu6GRzXLxESRj2qtXN+JtZYM53a4PHuIud333m7oJ+iv8wq1hV9fIn1XbSheCcuLnK697LzrGS
 VtwDsvRhePIbpmZd99R4FYXHRZ8rKaTC1DlW0E/n5ivm8XcZA7UNxiba5cvFxo8XmdAYOUy2Zgq
 1cDs3iXXw6IGlkjdAkuf1M+Ex5oY/ls/GwmxlbDYB8wVN/AwhlIyZgLBAsGhUmg6DRp1TsCJepx
 Yypra0NOHfTIs7oy18Gfno0bVlhUvwUjmC1+tu6kPF1VrcAqOKF3vn3Kr7L5BslwyX3IzAuEIXg
 ula8ELNxxUGxdAwoUuSRwfp7ld+GO3ozVjQbi7edec7Q+sf0YijrDaaAb+wf6DigO5MW9xgJZDh
 awoGySiWrDtRV9M4A==
X-Received: by 2002:a05:600c:3111:b0:4a0:1e87:910 with SMTP id
 5b1f17b1804b1-4a18e4cb7a9mr257096075e9.20.1791900084826; 
 Tue, 13 Oct 2026 07:01:24 -0700 (PDT)
Received: from potato ([31.176.175.60]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de72d2b13sm304691f8f.55.2026.10.13.07.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:01:19 -0700 (PDT)
From: Omer El Idrissi <omer.e.idrissi@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Omer El Idrissi <omer.e.idrissi@gmail.com>
Subject: [PATCH] drm/amdgpu: remove unused tracepoint
Date: Tue, 13 Oct 2026 16:01:03 +0200
Message-ID: <20261013140104.32179-1-omer.e.idrissi@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

Remove unused tracepoint "amdgpu_reset_reg_dumps", flagged by UT=1,
from amdgpu/amdgpu_trace.h

Signed-off-by: Omer El Idrissi <omer.e.idrissi@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index fcd4cf2f4cd8..6fecee5be1ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -564,22 +564,6 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
 		      __get_str(ring), __entry->ctx, __entry->seqno)
 );
 
-TRACE_EVENT(amdgpu_reset_reg_dumps,
-	    TP_PROTO(uint32_t address, uint32_t value),
-	    TP_ARGS(address, value),
-	    TP_STRUCT__entry(
-			     __field(uint32_t, address)
-			     __field(uint32_t, value)
-			     ),
-	    TP_fast_assign(
-			   __entry->address = address;
-			   __entry->value = value;
-			   ),
-	    TP_printk("amdgpu register dump 0x%x: 0x%x",
-		      __entry->address,
-		      __entry->value)
-);
-
 DECLARE_EVENT_CLASS(amdgpu_userq_queue,
 	    TP_PROTO(struct amdgpu_usermode_queue *queue),
 	    TP_ARGS(queue),
-- 
2.53.0

