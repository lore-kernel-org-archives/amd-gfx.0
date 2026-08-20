Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8570C5DF88
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 12:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF8FA10F011;
	Thu, 20 Aug 2026 12:34:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D107wQRr";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8ED810E5E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 08:28:35 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso1796791f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787214514; x=1787819314; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AtZWl8gfmirhc78hgFz/ygE56D7vm423VDeJ4LWiLPk=;
 b=D107wQRrvaxZYoSfwDoo9OAotWs8QTcC03v87odfthXySWfgrY40IYTG6D/qjgAj+i
 oA2V0x+fVD0o0XNzfGOL7rXY/7cHbHPTG0gtwUrRPR04lLDM+s3RAu0AjguBjCVr8KaC
 wvMYuBrwJSxRppmWWOQiPdvV0gDZDK3JPfArMZhN6VbXZ8zy6LfJnGVsUE/FykkgCo/7
 aKp0Vtc5fqkL3maEmZUI21MOHVJBTlRSbCrkPVtNtvO9vWqxmZCVQIMzdsU74BEBPTSq
 Fixt6OZqFUOLj5ZBvJP87MsiwvMRaq7qERYQ2ulNav04I8KUcPj4FCcZwGbYiAOSyPmS
 9jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787214514; x=1787819314;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AtZWl8gfmirhc78hgFz/ygE56D7vm423VDeJ4LWiLPk=;
 b=A5b20mkGihkbE8kgn/7TE+3lOMMEt+yFLrQEjrBqaou7ZmdEE9AwMLGH910JZh0jJa
 OjBGSJwC892B+M1QTusmMAPm7wL1I3XeRjvnvXfy2tIB9VMpbdxuY7hJRvjc//o6AuQH
 xosbQuGcwQLTzU9IvsTOe2EAzt+gZWYryouVXcETGVw7Lv0ACAXeLVsKrCFH6Rpxa1ib
 CXaZ3B32C1o22OY4V79HA7oJE2AS8JvMjGs3MkmKm0scH3U+ycBFrTfwIo+hsjBFnY6n
 nYzfkPjXUB9KcQKSw9usZFsUQ3uD46coy28j+wJXS2N+8uy5pTS6TWvjFdF3tLjOh2SE
 twcQ==
X-Gm-Message-State: AOJu0YxdGJQAtlsM+D/QMC0Ummoa0XHLAsHiKYCur1mTIX6wdNjomA3z
 58Eqn+Tg5bX26kJwm2YPXa0TukxmfNDTubtCe6xAdvQLgw4BxkPtNyCo
X-Gm-Gg: AR+sD10HrrbQq37aGWsE6haGUWdvi637tL9DkHujjCWmrcfWIYcHIC255t8tlh8J9a7
 8LXs9uyzLmPYGzPJ2HEItXOiDqUb1OI4gTY7349W1i7Hni9xPmR64SAIT87NDmG3ZcdfKgkGfTq
 vCG08UCFCM2jswrgB/6HXfyNXD51NOShyftWFl4Q7XNL8OrdksTccoLOqazzu+CMr0sWESomOSo
 j1BRKBrS6wQNJ3SjXEzLcI0ms3RlUFuuVOtbWR85Hy4wPgQUpzYlEEXabKzWFzFyvMDBZd3vbwI
 MQgdlL1xERE0lVvak2oaIAuKnQI/7Vv+H9wamWA4HnzBAvbXKahBD5lOmcs1fXwe87Pb4MWXBho
 HJLw8XAuaFIv7JZqLatHvU2IjIsBO8CCRVcf/jI/qAAi9lp2Yfr2xlMGTOHKU6aV/+0hjNN4qSk
 /ZW9MOkZvPo1lOqLIq5X8QubW8TqJ+0UZOOy9/ikwsp+mCCrMv1NYIvvfdOHEZkhPRze8w
X-Received: by 2002:a05:600c:4f52:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-499aa1fdfb3mr165898715e9.13.1787214513965; 
 Thu, 20 Aug 2026 01:28:33 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd5fcsm136676025e9.14.2026.08.20.01.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 01:28:33 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:28:29 +0300
From: Dan Carpenter <error27@gmail.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Add new sources for DCN6
Message-ID: <aoa6rezcQKFQLvWl@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 20 Aug 2026 12:33:59 +0000
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

Hello Aurabindo Pillai,

Commit 7f7d7ea1fa51 ("drm/amd/display: Add new sources for DCN6")
from Jul 22, 2026 (linux-next), leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c:82 dcn5_calculate_byte_per_pixel_and_block_sizes()
	warn: duplicate check 'SourcePixelFormat == 17' (previous on line 77)

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
    45 void dcn5_calculate_byte_per_pixel_and_block_sizes(
    46         enum dml2_source_format_class SourcePixelFormat,
    47         enum dml2_swizzle_mode SurfaceTiling,
    48         unsigned int pitch_y,
    49         unsigned int pitch_c,
    50 
    51         // Output
    52         unsigned int *BytePerPixelY,
    53         unsigned int *BytePerPixelC,
    54         double *BytePerPixelDETY,
    55         double *BytePerPixelDETC,
    56         unsigned int *BlockHeight256BytesY,
    57         unsigned int *BlockHeight256BytesC,
    58         unsigned int *BlockWidth256BytesY,
    59         unsigned int *BlockWidth256BytesC,
    60         unsigned int *MacroTileHeightY,
    61         unsigned int *MacroTileHeightC,
    62         unsigned int *MacroTileWidthY,
    63         unsigned int *MacroTileWidthC,
    64         bool *surf_linear128_l,
    65         bool *surf_linear128_c)
    66 {
    67         *BytePerPixelDETY = 0;
    68         *BytePerPixelDETC = 0;
    69         *BytePerPixelY = 0;
    70         *BytePerPixelC = 0;
    71 
    72         if (SourcePixelFormat == dml2_444_64) {
    73                 *BytePerPixelDETY = 8;
    74                 *BytePerPixelDETC = 0;
    75                 *BytePerPixelY = 8;
    76                 *BytePerPixelC = 0;
    77         } else if (SourcePixelFormat == dml2_444_32 || SourcePixelFormat == dml2_rgbe || SourcePixelFormat == dml2_422_packed_10 || SourcePixelFormat == dml2_422_packed_12) {
                                                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    78                 *BytePerPixelDETY = 4;
    79                 *BytePerPixelDETC = 0;
    80                 *BytePerPixelY = 4;
    81                 *BytePerPixelC = 0;
--> 82         } else if (SourcePixelFormat == dml2_422_packed_10) {
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Dead code.

    83                 *BytePerPixelDETY = (double)(8.0 / 3);
    84                 *BytePerPixelDETC = 0;
    85                 *BytePerPixelY = 4;
    86                 *BytePerPixelC = 0;

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
