Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52614CA6017
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A05F10E3C6;
	Mon, 19 Jan 2026 08:18:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hT941CHp";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ECB810E13C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:11:51 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b8718294331so56143366b.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768785110; x=1769389910; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5i79BDrxuHBezOHdjkerpF2EfskLPnOmytUYpUqDeYc=;
 b=hT941CHpQca7aA+jT6YLJA7pafTlueg/CxnE4M/Sl1wID9hI8+ccesw+aiPLpDWYSL
 02O9mdqijb5kWYuVmb7DCXoo+IdZNxSfsEkFPuyU+muITczvJBDGD9x01bEZny2u+XqX
 yE1mE/9kWQxV96pKgAcO0U19A9y5OiPB9Zj0N7npG+xvE/yHVqTUPhKr0acIG0hWZ5yM
 9d8A3W6pa67+gGRznN63t2YO0OCpx333DGWAjMiq3Ucj2Nbd9bmksnDRa7rK2cNZqxHJ
 8zi/EWsp21+f0KGukfwep1pFZ7IhfVeTY+f+9S9U9WqNvTQata/1kZpC1BErnXC91344
 58uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785110; x=1769389910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5i79BDrxuHBezOHdjkerpF2EfskLPnOmytUYpUqDeYc=;
 b=XBERZrOshvTf1uOBJhCPa81eZBeM8aSboer8bA6Os/FPJ1sYMcXL+GI/eaznN32POH
 QYyinWA0NsgAFfoV8LyNY4n5m2LbAGtNaM34/WYrz2OzjURyAzIH74oMmkDU+ZE/y6AA
 N4FA1SoP4ySiI1k/z3hlqr0Y0L+1NPgWfaISaP9E58tq2fbO71RvbTdo1IBHHrbM4t3L
 x30mjmUZpvYTG2jETQRbtSlPYvKMsaGqSmhMMh5uOFAMZh2mVAE3exdAnea4uuk/ymKF
 FhB+K33oC807eWKQKJqifpdKVRTPv+6DTkKK2ycWzf2E971ty8oDwgGS3dY1g/fzi/bM
 bOOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3wZmW9tehNNG7V6ozSgQPGc3Km4XiRKyeszEFHJg2Fs9zJ1+kyCQsoW3uXCQ+Ln2y8zvkAh+I@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsvvoyaFQYZ9H8jhyoK+piYLp7Cb6hOCGauczFZQdJd1ENdlov
 uzApPsHw05my2PNlGfif7pPfVZFyDS9FX3U6oHa2T7txndqc+sxMSgl2
X-Gm-Gg: AY/fxX4oHl3o4KvLx5EnoEoALON3ozZ+Y0ngcLfTX5UkBz89q42gkVh/nlYizTmBgHL
 bw/dGGsKA4d80pbVnhdiQKr8yHniT/cVd1IIPbqJvGYWR2qj5v7X0AtA+Z1ZRjyVYXieHJO8DdV
 bKfS0RJNqTTkY/t9s8ZJnVw9aK32HMCrUOIUSrbenoYNcDG1o5RDwzpNK2io14ZedaKdK9/KTaz
 BrtPbuNdkLAv9bYkRtRrOqtJQjeWVV757nZCbo77e0JfXfxrWfMB3XjsbFNkr5gJjvucLJSIlA5
 Yi5nXtuuL2GpqpiTeY779Q/C1RMdpcHG6ao8xqArWm6BWvRAACE473GcZYiebbYR2swHQL2Tgk6
 whnRVlifs6h44i3MvxuOYse4kp1jODaGqJRivlqe4xoAdzvRalvi2Xt5O93MmR/8XuxdKQbK7T2
 abOPO5qAY+tMnMvu5+47EBlDmEvBACC53VvhztqRZHyTfM9+seVx2F4mQVEkl6qS+K
X-Received: by 2002:a05:6402:270d:b0:649:9c37:5d5f with SMTP id
 4fb4d7f45d1cf-65452bccb59mr4148768a12.5.1768785109659; 
 Sun, 18 Jan 2026 17:11:49 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4912sm8989806a12.30.2026.01.18.17.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:11:49 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com
Subject: [PATCH 01/17] drm/amd/display: Return if DisplayID not found in
 parse_amd_vsdb()
Date: Mon, 19 Jan 2026 02:11:30 +0100
Message-ID: <20260119011146.62302-2-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Jan 2026 08:18:28 +0000
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

[Why]
The function would continue to try to parse EDID even if DisplayID
extension block wasn't found. Sometimes it got lucky and found AMD vsdb
in CEA extension block which made debugging harder.

[How]
Add a return if DisplayID extension block wasn't found

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 655c9fcb078a..a0d23853b8fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13113,6 +13113,9 @@ static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			break;
 	}
 
+	if (i == edid->extensions)
+		return false;
+
 	while (j < EDID_LENGTH - sizeof(struct amd_vsdb_block)) {
 		struct amd_vsdb_block *amd_vsdb = (struct amd_vsdb_block *)&edid_ext[j];
 		unsigned int ieeeId = (amd_vsdb->ieee_id[2] << 16) | (amd_vsdb->ieee_id[1] << 8) | (amd_vsdb->ieee_id[0]);
-- 
2.52.0

