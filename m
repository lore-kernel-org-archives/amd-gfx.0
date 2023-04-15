Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25092C77B70
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Apr 2023 07:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AECB710E3A1;
	Mon, 17 Apr 2023 07:30:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAF710E09F
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Apr 2023 15:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681571859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q5M14rzEqBNgFK8HU9Akt9HYXKL8QNDYAZuFGTil5ww=;
 b=cJkdgMlrfRl54/qq6ey9rBTd+u/JIuTtphnNAgIzop+E6lu9zvBV3nHC+BqB417yjf+M/f
 G8km2Lsl3GpF7GC+7bUFaY6eihTDdfLjbcDfKSv9xHgOvljK0xeZDDFa4hrumPvSXMv7kd
 Q3VOWEteRtYCXk/EM3gi7r5ImFW9QxA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-qd32bT7oNzKOiiaOuyh-_Q-1; Sat, 15 Apr 2023 11:17:32 -0400
X-MC-Unique: qd32bT7oNzKOiiaOuyh-_Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-2f5382db4d1so122286f8f.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Apr 2023 08:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681571851; x=1684163851;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q5M14rzEqBNgFK8HU9Akt9HYXKL8QNDYAZuFGTil5ww=;
 b=Slt9+Ss0nf91j0KU+oeUGBudSu8FDkeBQH4dAkSLJVXLPaJABTiwYl+FzsG86I5G23
 /HINgKT+cCpb8T85E6nRaK/75Snuu6Pjf3qEhSd04NJC+vo4QwoFhntj5cNqgzkn3Nd+
 AYLfRnmAN6xkPiu2P5/qwKBKgSzXJzz2o2Niwd9kTY8X3Yy0mvvaj/NdjvVUclOcbwG+
 qPUVDA78nHaFc6Qk2DrkVW4I8yv3wurScj9sar5iUg2LxuLOjmmCmq0E8fuzAq5+bsQK
 8iiTq/EMXjdLrKVx84Z3FX9tb/Ih7CJru1UKoHIPesbg3lr2pwMCbFm5n8cW0fNf8odZ
 o4hg==
X-Gm-Message-State: AAQBX9eE3rIwsQfsEX9wXODrq6QDU+QcIUVQzcy36Gs4OVTts+V2yB14
 OF5b8RpfeSOcMMkma+8QA7gibxNIHxQcymMKKK8LORb/IIEJbXfzvLfcbuZtOuaJSVA0lZEC/hp
 vHZ4+7ITSeGFiMZQy45NXJdDKhg==
X-Received: by 2002:a5d:5248:0:b0:2f9:a75:b854 with SMTP id
 k8-20020a5d5248000000b002f90a75b854mr479319wrc.59.1681571851276; 
 Sat, 15 Apr 2023 08:17:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZiVk0AFMX3CN+Ea1tpGa+ZETudf89c2CORBo70Q1fyjzBSsB+LBm6h3/+QEZQTcBxaKCvJSg==
X-Received: by 2002:a5d:5248:0:b0:2f9:a75:b854 with SMTP id
 k8-20020a5d5248000000b002f90a75b854mr479290wrc.59.1681571850835; 
 Sat, 15 Apr 2023 08:17:30 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 m13-20020adffe4d000000b002efb139ce72sm5953488wrs.36.2023.04.15.08.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Apr 2023 08:17:30 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, nicholas.kazlauskas@amd.com,
 Syed.Hassan@amd.com, jdhillon@amd.com, alex.hung@amd.com,
 michael.strauss@amd.com, aurabindo.pillai@amd.com
Subject: [PATCH] drm/amd/display: set variable dccg314_init
 storage-class-specifier to static
Date: Sat, 15 Apr 2023 11:17:22 -0400
Message-Id: <20230415151722.3188010-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Mon, 17 Apr 2023 07:30:15 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smatch reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_dccg.c:277:6: warning: symbol
  'dccg314_init' was not declared. Should it be static?

This variable is only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 6f879265ad9c..de7bfba2c179 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -274,7 +274,7 @@ static void dccg314_set_dpstreamclk(
 	}
 }
 
-void dccg314_init(struct dccg *dccg)
+static void dccg314_init(struct dccg *dccg)
 {
 	int otg_inst;
 
-- 
2.27.0

