Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BA2CD98D5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9D010EE64;
	Thu, 11 Jun 2026 10:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZgXn7F9y";
	dkim-atps=neutral
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6F810EC60
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 01:30:19 +0000 (UTC)
Received: by mail-dl1-f67.google.com with SMTP id
 a92af1059eb24-137335bc3caso9510452c88.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 18:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781141419; x=1781746219; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zzr9EpiC86PYUO+6HwHEv+DWj/5lwfmBLneVLzjCz+E=;
 b=ZgXn7F9yXky2tlPGW11pBfPJnWeAu9ZHLDKb/ds5Abxx9MPA3MDYcJXhT10xUHXLB7
 REkBhHvMc8YEmQGELKs/eYwO3sTsHVv8q8toZk2QLdYiOO/Ifxi+W2OzfUNYYBk7Y4cJ
 GbgDOSQg/7NJUp76khHpvUcWnEf/6UM3giWsM9pTv51umpfZhEDw0WQDif+o3ta3vVLg
 tQVU53gwo5kJRHIKljYOwMlHlnugvo7VJqOjEpr6eXhAPG9OWacBi99WtvXPCshqxrWe
 kkfD63ZO2PXTlHyo/3BL8W3kIqaqG0TN3ccXS6wTl5y8uS9nzxxrNz4WRbE66Z63b6Xv
 LolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781141419; x=1781746219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzr9EpiC86PYUO+6HwHEv+DWj/5lwfmBLneVLzjCz+E=;
 b=J5hmc2E10Nun0GqAW4UX08seG348fBFB9eyZI1O//XeOrRvQGEdT4BCFoSnN+xBKFc
 jR8W1stXyMws18tIXkCPK6EFTPLDZJAcGkgKwWdBCHLF55T43nR63VaakqeRBiotZvfp
 oAQIgR9ip0GOaDAj0z28stAuTd5XXmtXq/URcXBamXnIwJuoEnRuWiaPLIUSTnBSLe30
 Ny3bz8Cs5tiTrKqClEMI2seNoXscNSmTmkbasZIdxlRjqF6qOkHK53FeL4qF1Q32BSn1
 8zKRG9WOxwn8Ciiio3f4JNwFxgLIEdZ7NxVbvh0FV9NGEOljVrQe7rfZ4bg9WxUtsQe2
 KeRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ImAbhjLAvay7NEg9sO0GEhg6L32WIGH3RHVXZd7JG+LzheEFu4pAc6KPFqhk4NumKTO+7bzFI@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz72KJin/fIk/Xor5kl5rGPIk7HURKsxALwLsTLZDSfc2NOCY28
 XE1hZ1pquoKVAANUcQzL1JJbwr1ksJScI23uD5es2V/0TenoPyjamxjT
X-Gm-Gg: Acq92OEW55KzvwzMI0gNNmkq7HFDeiZObSz4ce2ZYU4jID5ouFoGN+S/ur63xsDjXRM
 aYOyIMvl5b9KHTmfe/MLx7okLC+kVvAVwV3p8G17VhTi34VydC652TY4CWbimKL37dCF3b+CNlQ
 ixgYym8wv837viQkkZ+AvzTMLhf2gzim1MKmyxBifZZCGHrEiPgLlUkL92I7aqpn8wHjon9Pf/h
 57zf+Wqs1aHNrImV/zchvjtzYw2LRXnq+x3ivEY1X96Nk9ojfaR6sIOxoOQZTeHPyikIfeLAdqK
 lwHeMCe5c8/b1RWNXYJBTgnaulxifiB6Z5AWq4v+9h/yGjfiFymM8SsDmcyBim9Lvoj4bxqUUqu
 06g2QV6NewaR/tibO/c6lP4oryA6POAjFsdCnlR37kPVNUfq6mm8/f20n6xbx8d+xu6pZJXXBv3
 tQTH2/K5W7p+nDdEn0Fdyww2gH6zDzXtVhO+ShlGPTVFv7Dxzp8OZqCQEano/DRgTtu4iulbxev
 7U84Lv5uKmk69gjhGmmhfQIij5X+ohTlXvGamTxi2wPDxLkgGx+wOCLrq06HU3+gHbDfH0g6atO
 GufIYopSlPW9OrnLakq9MBI3P68b
X-Received: by 2002:a05:701b:4183:20b0:136:b370:64c5 with SMTP id
 a92af1059eb24-138422d9798mr282268c88.30.1781141418926; 
 Wed, 10 Jun 2026 18:30:18 -0700 (PDT)
Received: from ethan-latitude5420..
 (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13842ed1ccdsm332436c88.0.2026.06.10.18.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 18:30:18 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Rodrigo Siqueira <siqueira@igalia.com>,
 "GitAuthor: Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/amd/display: remove check for nonexistent CONFIG_HAVE_KGDB
Date: Wed, 10 Jun 2026 18:30:11 -0700
Message-ID: <20260611013015.433679-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 10:49:23 +0000
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

drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h checks for
CONFIG_HAVE_KGDB or CONFIG_KGDB to determine whether to call
kgdb_breakpoint(). CONFIG_HAVE_KGDB has never existed in the kernel.
Remove the check for it and retain only the correct check for
CONFIG_KGDB.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h
index a6f6132df241..a0e9df382582 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h
@@ -5,7 +5,7 @@
 #ifndef SPL_DEBUG_H
 #define SPL_DEBUG_H
 
-#if defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB)
+#ifdef CONFIG_KGDB
 #define SPL_ASSERT_CRITICAL(expr) do {	\
 	if (WARN_ON(!(expr))) { \
 		kgdb_breakpoint(); \
@@ -17,7 +17,7 @@
 		; \
 	} \
 } while (0)
-#endif /* CONFIG_HAVE_KGDB || CONFIG_KGDB */
+#endif /* CONFIG_KGDB */
 
 #if defined(CONFIG_DEBUG_KERNEL_DC)
 #define SPL_ASSERT(expr) SPL_ASSERT_CRITICAL(expr)
-- 
2.43.0

