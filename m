Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D035CA1009
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 12:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4614D10E6BE;
	Tue,  2 Sep 2025 12:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=listout.xyz header.i=@listout.xyz header.b="YTP4FO+0";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF8D910E03C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 17:57:59 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cFxRl2WqXz9ssn;
 Mon,  1 Sep 2025 19:57:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
 t=1756749475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ONAN0sAG8KjiLpOE4hKBXPpBEr1emSXgDFDunnuzi8M=;
 b=YTP4FO+0HnKNXdhqkJYfwp+uXIozVbsQ5MKohAdW9ArAR2BU4ZIQo4sGKQfArMqLBOxD7S
 DqBwFFtsUucD6Js6peCb/ndZh9eTeict/Lw6h5BEjvioVxfc+2bzp4FTv6eGjD5B/ZNg5f
 XHqKeOjctvq+STipHH7MMJkPoh9tsZV69KNJl+DBrZA9Zp7g+KThFgglS3uRpwmc+NGrCN
 sxhyB1mo+J/smg+7S4lO6Ek2xo2ZPXonXc6iY2ilS8aObck4tiU8zGVJjKxKlM2BRnZcLR
 OHFceyDSb4ZrVOWzXfbYxMaKiRjk08+E9G/v6RFQLMON5REkfcQ2OqE0CI7Yrw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=listout@listout.xyz
Date: Mon, 1 Sep 2025 23:27:47 +0530
From: Brahmajit Das <listout@listout.xyz>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, Sonny Jiang <sonny.jiang@amd.com>
Subject: Build failures in drm/amdgpu's vcn_v5_0_0.c
Message-ID: <x4ga2sfkszmylljox3p46ryog2owghv6hffo3rjj4o6xfjy7pd@jllj3us4heso>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cFxRl2WqXz9ssn
X-Mailman-Approved-At: Tue, 02 Sep 2025 12:49:12 +0000
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

Hello devs,

While building the -next tree with allyesconfig and GCC 16, I got this
build error:

drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:164:26: error: variable ‘internal_reg_offset’ set but not used [-Werror=unused-but-set-variable=]
  164 |                 uint32_t internal_reg_offset, addr;                                             \
      |                          ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:208:33: note: in definition of macro ‘WREG32_SOC24_DPG_MODE’
  208 |                                 offset;                                                 \
      |                                 ^~~~~~
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:751:41: note: in expansion of macro ‘SOC24_DPG_MODE_OFFSET’
  751 |         WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
      |                                         ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

The WREG32_SOC24_DPG_MODE macro is calling the SOC24_DPG_MODE_OFFSET.
The variable internal_reg_offset, while not being used in
SOC24_DPG_MODE_OFFSET, is used in WREG32_SOC24_DPG_MODE. I might be
wrong though. So I'm wondering is there any *easy* way to fix this?

-- 
Regards,
listout
