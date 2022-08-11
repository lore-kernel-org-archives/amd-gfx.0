Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F28C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 20:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1DD28F097;
	Thu, 11 Aug 2022 20:43:58 +0000 (UTC)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790BE8EFD0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 20:43:42 +0000 (UTC)
Received: by mail-vs1-xe31.google.com with SMTP id d126so15174230vsd.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=fGLEsX6f7eB86knQL2Eok2YJ/oihu0tXU04F3LSO7N0=;
 b=JhnRzM0rrNjJ8WLyBzonqSHp/33gvEbfsRzRnt7XWXnb4AcU7oASuMx12uDReKkXOM
 hhV77v2r2a3GbNflvp0IEujeudiqSl+i4KB+uoN6pgBoQx0XvuU4SsHAcdGR0fcdV8lR
 wWf2A70H8dbR5Rj4jrA2MFMPPlwK/FXrPa5dc5Edt/1qqrFCRuMsdvoFvLA2gM3VVwnD
 LzLJaTGiQY576N8zvI8KAqowYIP6vtfl6LbC8cazSjOrhc5uXYGxFfLIzDFRS5ULOJD7
 uS3V2UxtRu5ho0/cp72l8SwYTDvqLlNfeJEj7MJgOJV257XAi56nUi0seAcltERV2urC
 PcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=fGLEsX6f7eB86knQL2Eok2YJ/oihu0tXU04F3LSO7N0=;
 b=0S6z+UP0n3dTMIV8u0oI058Mh+oijGqU4JkO/Xa/PxyhwoxJWwjK+1zRD/G2gR5u2k
 6nhNrG0o9nOYtxf/4AjnHQjjze+/XqJbIyBgW3zwZdaYMVqNU6c8kUcmfJcKnd0IBjSg
 TlHpkd7BnIt3keq3xcVaXchRltyaKUuzPzIm5B/+3R5MJMMcCcwVReXSwIrg7RgEmKp8
 2ZJqRLniCnAi4qs8IvuIAvyEUXRlnyfWadrMSs3m4T/cZKdKFKR20DabaizvZanSS4D7
 lrkzb0pM11LNcob5m2GHdDMAKap5TXLb6+v8lJdp53q8qCuvUiMg/67SCOJLFfVMnuvc
 UQgw==
X-Gm-Message-State: ACgBeo3Jv06bVklXEPwhNvNuRouRMYrz5mEn8tJTWyUf3b+S4FcNK2d1
 2/6BHDYhQcX9HqBSG5sYBnY=
X-Google-Smtp-Source: AA6agR41eZPqTV4Fj/bVE8YEK8ysmBA8PWDRrC2ZGvMhkc6sBFhRiIVkYtXpmazE1QrSHPjv7PcuGA==
X-Received: by 2002:a05:6102:5e6:b0:385:361:5892 with SMTP id
 w6-20020a05610205e600b0038503615892mr541039vsf.7.1660250621592; 
 Thu, 11 Aug 2022 13:43:41 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a67ee97000000b00388d3be20bfsm226846vsp.28.2022.08.11.13.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 13:43:41 -0700 (PDT)
From: Tales Aparecida <tales.aparecida@gmail.com>
To: davidgow@google.com, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 1/2] drm/amd/display: fix overflow on MIN_I64 definition
Date: Thu, 11 Aug 2022 17:43:26 -0300
Message-Id: <20220811204327.411709-2-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220811204327.411709-1-tales.aparecida@gmail.com>
References: <20220811204327.411709-1-tales.aparecida@gmail.com>
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
Cc: siqueirajordao@riseup.net, magalilemes00@gmail.com,
 tales.aparecida@gmail.com, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 mairacanal@riseup.net, Isabella Basso <isabbasso@riseup.net>,
 andrealmeid@riseup.net, Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Gow <davidgow@google.com>

The definition of MIN_I64 in bw_fixed.c can cause gcc to whinge about
integer overflow, because it is treated as a positive value, which is
then negated. The temporary positive value is not necessarily
representable.

This causes the following warning:
../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/calcs/bw_fixed.c:30:19:
warning: integer overflow in expression ‘-9223372036854775808’ of type
‘long long int’ results in ‘-9223372036854775808’ [-Woverflow]
  30 |         (int64_t)(-(1LL << 63))
     |                   ^

Writing out (-MAX_I64 - 1) works instead.

Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
index 6ca288fb5fb9..2d46bc527b21 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
@@ -26,12 +26,12 @@
 #include "bw_fixed.h"
 
 
-#define MIN_I64 \
-	(int64_t)(-(1LL << 63))
-
 #define MAX_I64 \
 	(int64_t)((1ULL << 63) - 1)
 
+#define MIN_I64 \
+	(-MAX_I64 - 1)
+
 #define FRACTIONAL_PART_MASK \
 	((1ULL << BW_FIXED_BITS_PER_FRACTIONAL_PART) - 1)
 
-- 
2.37.0

