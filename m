Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8931C54788
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 08:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3AED10E657;
	Wed, 21 Feb 2024 08:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="jo7dazof";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED36A10E53A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 19:47:37 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-6e45d0c9676so1789877b3a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 11:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1708458457; x=1709063257; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6VIzixTXzfsOehBNdTAI/rwoARfHVoZJfkUg/7sqYs=;
 b=jo7dazofMUTXm+ZVYxatgP8h8GL15OCTwCEBx2KHmltqIl+giMuSwSE0melsQ0ILpO
 TBYkbyjGU+iHpX14KGKifwtB0+lGNhV5/9WHwkVHrX1Ip44BaE1Y7ub1xIOadTEGoJne
 es+Cy06jmXlbvIUu28MoztFsxO2BPmiawCMV7Kzy+j+rmY8pXf8DcHYb1XVCVquMsDO2
 T6EQTqxanqMbd2l7+GoPspH9ySatKUzcKONfiKeGvxAO9NAsvoEHLqa8//5EU3JqCj7p
 b3Ry9o3Mrz2RSA2ENaVks3KcA3NS9t/5aUO4ZuSpdK3uehluENjrKcBapMZ5RQ7l+msq
 lE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708458457; x=1709063257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6VIzixTXzfsOehBNdTAI/rwoARfHVoZJfkUg/7sqYs=;
 b=tJ5AIGIq+oEWfowW5Aknmd2bz3a+YWs1RCOwStrWBdImRZqQn63x0T92f5VoMz2N5a
 tcJV+vvmaBY8kYtyJ3cF8qU+2ZLXOxB2etDKGGvhS3m0wA+KGzfd8slwUqooRq/fRJ4U
 PvqIKeREoWVVRKR0MGyTPq/47wqhl4KKMJjTZbDlMKGolUzmlwSj6K6iNMaHqcfVBWUy
 A9Etw+ryu87o8QCwPqCoGT2ys9gCt+xGigghnYdL5gp7UC8QuHK8V69b2Rb4SUvK6xSq
 SFs40PIkkOnFLnTyhEAq5QFYXOHrHWQf/2uwKPj4/XR085lOsC4Y2Q3lLpe1zCXJn0AR
 r+aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCE7G9LKjnKfOZp9+pph2NRQMsl+2v1RjD6MSPv0ROOc6L/20PnVJLM6aec88MEXE8GypJppsZbHxyhSDu1FzAdlL1DI+EeCMs5EhK0A==
X-Gm-Message-State: AOJu0YyJiythlC70Dp8BOTaexh3nhrjwaSfao3bolu+3Er3LlRKMBb0c
 hJUsHs8POHevt+Qs4xbt/2u2CZWUnOZURjITn5yg3S3VQLIAsb/hw3O0rL6o13k=
X-Google-Smtp-Source: AGHT+IFgSkgcVtlGl29yJIA184G9Y9bRu08SmE/6+uoV1knpPK9Evk4Db0EYpHCqkt1tBAyEziIoXg==
X-Received: by 2002:a05:6a20:93a2:b0:19e:5dda:6bd with SMTP id
 x34-20020a056a2093a200b0019e5dda06bdmr25055183pzh.8.1708458457453; 
 Tue, 20 Feb 2024 11:47:37 -0800 (PST)
Received: from localhost.localdomain ([185.153.176.89])
 by smtp.gmail.com with ESMTPSA id
 u21-20020aa78395000000b006e0ad616be3sm7293482pfm.110.2024.02.20.11.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 11:47:37 -0800 (PST)
From: David Tadokoro <davidbtadokoro@usp.br>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: David Tadokoro <davidbtadokoro@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/display: add prefix to rv1_clk_mgr_clk.c function
Date: Tue, 20 Feb 2024 16:46:55 -0300
Message-Id: <20240220194657.243378-2-davidbtadokoro@usp.br>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220194657.243378-1-davidbtadokoro@usp.br>
References: <20240220194657.243378-1-davidbtadokoro@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Feb 2024 08:14:29 +0000
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

The function defined in dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c doesn't
have a name that indicates where it was declared.

To better filter results in debug tools like ftrace, prefix this
function with 'rv1_clk_mgr_clk_'.

Signed-off-by: David Tadokoro <davidbtadokoro@usp.br>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c
index 61dd12198a3c..b63e0e92d118 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c
@@ -49,7 +49,7 @@
 
 
 /* Only used by testing framework*/
-void rv1_dump_clk_registers(struct clk_state_registers *regs, struct clk_bypass *bypass, struct clk_mgr *clk_mgr_base)
+void rv1_clk_mgr_clk_dump_clk_registers(struct clk_state_registers *regs, struct clk_bypass *bypass, struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 
-- 
2.39.2

