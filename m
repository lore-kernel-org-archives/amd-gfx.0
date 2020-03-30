Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B08C2D0E8
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 07:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91D0206DB
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 07:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca92LU24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91D0206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 585D66E584;
	Tue, 31 Mar 2020 07:39:31 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0114F89E01;
 Mon, 30 Mar 2020 22:16:34 +0000 (UTC)
Received: by mail-oi1-x244.google.com with SMTP id y71so17176640oia.7;
 Mon, 30 Mar 2020 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rHTfazG0JcHchUkZkwqmfv3skWoFel0RHtJDeLWFMUQ=;
 b=Ca92LU24QgTe15iUum7o+GWCCxrpDi/NBlydV3Y7UaeHp3UkpEJ0w3PsnajA8/jp1R
 xa4eS5TvtcurrFF8L9WuPHdSCuUhFfYlAomFz951J9FAMhgAfJkK33UVCRcVBw2m52Wd
 ZK+i/Q8HIqIYIVo9n2fKbgbduGG394emhSQyh6rPbdXWu9dxOcpPGwj3Ql7/+b7FvLDw
 wrgqKKtyJBby4Qq2AHh2zf6iDd6ex8sq8izmSMRGf0W8M+Gtr6xKUbo00XLWOS8R5dsx
 RTEvjWV+Vxu/htwiMLb+gkKPSMgSTF+GuUwxTfPNyiSsp4kLGyPP9oFgjobop6Cffs86
 4GAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rHTfazG0JcHchUkZkwqmfv3skWoFel0RHtJDeLWFMUQ=;
 b=XT2vSDiq4ec+MsJeyA9wF4RX7Jb4ks1DS5Va3FVFA2AmxQ9mR7sKOU0i6TTHJqAX+M
 /SNsaF05MfZEWX46WHD47RZ+Efx/8ZMeSF2/iGjf+J3AFK99B29vOceb7DS2du68WlR5
 XSnkqhXbvPdCNaDgu+3ClMmXF9hk6Pmm2iYcGarDn/bBmZFnXCijJ9jswOppoJuLRWTS
 eK3uhlZBd4OBltx0sKFD7Xo3cUfaLrIMjiXYvpPcgs66PP4WpQz+Em1CV+bpMjsGKc2G
 t9ALFArxhRRGc36hd5jaIp/cqz/5XDW4+XOsro2oPHtz+Gsuoim3FTOPED8JaiKqdgdC
 4waw==
X-Gm-Message-State: ANhLgQ3rpINfFUC3QE1J54SfQe1yyaYrWiKqYLCFWAL6WEUpkTHSj1+g
 LmWx6USlqWXaC7M7wftxu/k=
X-Google-Smtp-Source: ADFU+vtRqzG9oYmCmjI3rVBaaXZZBnhy9DdhlKuP9NiWmIWqtTC/fMZaYpnYKJ/MHG2Na6JPD8ApJg==
X-Received: by 2002:aca:646:: with SMTP id 67mr202286oig.4.1585606593916;
 Mon, 30 Mar 2020 15:16:33 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
 by smtp.gmail.com with ESMTPSA id c18sm4680750ooa.8.2020.03.30.15.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 15:16:32 -0700 (PDT)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Subject: [PATCH] drm/amd/display: Fix 64-bit division error on 32-bit
 platforms in mod_freesync_build_vrr_params
Date: Mon, 30 Mar 2020 15:16:14 -0700
Message-Id: <20200330221614.7661-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
X-Mailman-Approved-At: Tue, 31 Mar 2020 07:39:29 +0000
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
Cc: Nathan Chancellor <natechancellor@gmail.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When building arm32 allyesconfig,

ld.lld: error: undefined symbol: __aeabi_uldivmod
>>> referenced by freesync.c
>>>               gpu/drm/amd/display/modules/freesync/freesync.o:(mod_freesync_build_vrr_params) in archive drivers/built-in.a
>>> did you mean: __aeabi_uidivmod
>>> defined in: arch/arm/lib/lib.a(lib1funcs.o)

Use div_u64 in the two locations that do 64-bit divisior, which both
have a u64 dividend and u32 divisor.

Fixes: 349a370781de ("drm/amd/display: LFC not working on 2.0x range monitors")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 8911f01671aa..c33454a9e0b4 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -761,10 +761,10 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 
 	// If a monitor reports exactly max refresh of 2x of min, enforce it on nominal
 	rounded_nominal_in_uhz =
-			((nominal_field_rate_in_uhz + 50000) / 100000) * 100000;
+			div_u64(nominal_field_rate_in_uhz + 50000, 100000) * 100000;
 	if (in_config->max_refresh_in_uhz == (2 * in_config->min_refresh_in_uhz) &&
 		in_config->max_refresh_in_uhz == rounded_nominal_in_uhz)
-		min_refresh_in_uhz = nominal_field_rate_in_uhz / 2;
+		min_refresh_in_uhz = div_u64(nominal_field_rate_in_uhz, 2);
 
 	if (!vrr_settings_require_update(core_freesync,
 			in_config, (unsigned int)min_refresh_in_uhz, (unsigned int)max_refresh_in_uhz,
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
