Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59864CCFA06
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3141310EBCA;
	Fri, 31 Oct 2025 14:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XKRqTA+N";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC7810EB32
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:02:31 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47114a40161so25270955e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761915750; x=1762520550; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2FQGZCGnHsgyhdfpYgLWb8UhWYQWnOT5iNG04Z0iL94=;
 b=XKRqTA+N0FlOH8g4WHUgiXhqQ/loz/G5ZlKgaVEfoZLS2mbiBhdpYBSRAWcziIbiOB
 wxdtLh5V1RDNiW9e3+Jw2IisjSQ8qlfMbjMuQjGiUomYpJWUw53BEMZLE/TzMO7/Q91x
 88kdR8rBUgBDbK0JN3TpBUYYF6H8iCTrVH2ioBAI5TKBg0YbLpfUkKS6kXtSQLxWARdp
 IM4x85Zur4MDY/sMlthQvp8AA1pJcGwGP/dUnnhFy4yNk0jPJXBs+28clAC3TSzjXt4k
 ftRhlSl2aStRu7ClP1sjUDhEM7DvnyfpLvVeI5Nk6oihVMFS9iy7n+Sz4HwalZRTjumR
 Vz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761915750; x=1762520550;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2FQGZCGnHsgyhdfpYgLWb8UhWYQWnOT5iNG04Z0iL94=;
 b=PDnsqKM6hZFJY4yNj5AO2Y7sN8LfeUzlFKrcNK85ln+dmJ2UiAKdDOfZIEnu5MXtbj
 xEf8PPidqNCnjejl7S4f16Q1TcDAc/R7OL5+u2z49161LmJQGeWjNCBZpuEPhyjU+Y2E
 75zCZUHApLUQWALIAG6iE449uHsKZrh7ePRNWzj64nyZMYOSgRtXnhj9N8AxfdIZmIcO
 Lj4qot6KS7i5tOXWZQ65toST3OmgFBujFtNvMddeNImkqtsNNgxnz/VS4yFLQe/y83HK
 ne+5uQAD1KKlt6G2w2zuNnvo0kdY1VOiPnZNlccgt1niPt3cs1iiDIvxltmbkKWTLsRN
 VuvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrYcK0DkDJ2i6iRdBpkUVQSfJ97T9oBHHhFJzaxdIKttfM6V3WMw2TXu6RyP4c3YS1fEWnwilQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywE/BZCjniaReRy6LToLrfPvR8Nw6ZkLU77o8PI9o12LYyvdCd
 jBfwMQcPGBD5J4JJPLY1qvREeC9064BNJcasECRaLva/tvVTMpEhwZIgmbyf1DfUTec=
X-Gm-Gg: ASbGncsKhQ10VlNH6u//whc76PbE4Tic30RDv0x1I+ulmD4DIt9QYG3VnW+g96CN37y
 mtabdMDxi8WAKmLA2HHwbTSBYzrqALBkm96bupO//W8SvuEQRWinegJNsphe/6n+HdAgMH5jB/K
 vWdfqTal30I7ndonAuGOE+GoEt+K8vS81LXqUvs7bNePzGxVxdQGD5XOG6fxL5sk/azG2q0AuvJ
 hhJ2Zv4ZLZ8X26bY2P7ZlPi42DmpXmqCWHTPm6P1DOuD3Gil7ZAiFk5+OYBNmDXhGVO8Na9Rl7+
 m3dxZ9b60AOigz3Eu0JWGLaw4eTc0aLE/d2pQ4I8upbgB7IbIo9vYE+pDBsVKE6WLusstP7BHlk
 hq+sfKT1Cp7/n1H7uiepwbzwRZW+nrqayk27OEZa+/HZ2PHJBqWIGEtqSGxU7hxjFMi6p2TGS68
 EoyghfHA==
X-Google-Smtp-Source: AGHT+IFtOV4W0Y8ZfIuQZW9gadDZKRpyQvtO7XZin6e2iW2zHXOgFcxmDRDXqGF4RU8aG0zT2NZ4TQ==
X-Received: by 2002:a05:600c:3149:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-4773089c4a1mr29545645e9.22.1761915749827; 
 Fri, 31 Oct 2025 06:02:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4772fbc32d9sm22667605e9.1.2025.10.31.06.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:02:29 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:02:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harry Wentland <harry.wentland@amd.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hamish Claxton <hamishclaxton@gmail.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Zaeem Mohamed <zaeem.mohamed@amd.com>,
 Michael Strauss <michael.strauss@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix logical vs bitwise bug in
 get_embedded_panel_info_v2_1()
Message-ID: <aQSzYV0ytfQK2kvN@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Fri, 31 Oct 2025 14:16:25 +0000
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

The .H_SYNC_POLARITY and .V_SYNC_POLARITY variables are 1 bit bitfields
of a u32.  The ATOM_HSYNC_POLARITY define is 0x2 and the
ATOM_VSYNC_POLARITY is 0x4.  When we do a bitwise negate of 0, 2, or 4
then the last bit is always 1 so this code always sets .H_SYNC_POLARITY
and .V_SYNC_POLARITY to true.

This code is instead intended to check if the ATOM_HSYNC_POLARITY or
ATOM_VSYNC_POLARITY flags are set and reverse the result.  In other
words, it's supposed to be a logical negate instead of a bitwise negate.

Fixes: ae79c310b1a6 ("drm/amd/display: Add DCE12 bios parser support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Please note that I have not tested this.  It's straight forward enough to
see that logical negate was intended, but it's always good to test things
as well.

Harshit and I only recently created this static checker warning.

 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 04eb647acc4e..550a9f1d03f8 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1480,10 +1480,10 @@ static enum bp_result get_embedded_panel_info_v2_1(
 	/* not provided by VBIOS */
 	info->lcd_timing.misc_info.HORIZONTAL_CUT_OFF = 0;
 
-	info->lcd_timing.misc_info.H_SYNC_POLARITY = ~(uint32_t) (lvds->lcd_timing.miscinfo
-			& ATOM_HSYNC_POLARITY);
-	info->lcd_timing.misc_info.V_SYNC_POLARITY = ~(uint32_t) (lvds->lcd_timing.miscinfo
-			& ATOM_VSYNC_POLARITY);
+	info->lcd_timing.misc_info.H_SYNC_POLARITY = !(lvds->lcd_timing.miscinfo &
+						       ATOM_HSYNC_POLARITY);
+	info->lcd_timing.misc_info.V_SYNC_POLARITY = !(lvds->lcd_timing.miscinfo &
+						       ATOM_VSYNC_POLARITY);
 
 	/* not provided by VBIOS */
 	info->lcd_timing.misc_info.VERTICAL_CUT_OFF = 0;
-- 
2.51.0

