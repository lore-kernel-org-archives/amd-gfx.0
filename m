Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCC310ED664
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD5F10EC64;
	Fri, 27 Mar 2026 12:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TjqwWb5G";
	dkim-atps=neutral
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA84A10E28A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:31 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-417c34b0509so1006697fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551271; x=1775156071; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYmxGb7uQeQFtcBU/KNsuA+yly7Rfm4LYjwUpGocOHU=;
 b=TjqwWb5GfAnUTWbVAzSskWTaDEPtTz/b7OPVQN/5Ma5Wuf1I567u6DSkxA7iOaovgQ
 IDzHtKn+TzhVCrYhcnDKf1k5sTOpzmgWDa9s+Y3ACvs5B0Xivzk6m7P6CEggnzumVrnS
 buj+xiaFONeP2nQYiZpNFCh8JCghweLMKIGfsdRLyTsvSULY0uO4KexWEIGU+9taJgLA
 B7JUTKsQfvV1BvRc5oXaAkYNK5qgUlSdWN8J6Wo1hGI/bSHnVzWsw6aIlz7/m3lnwZc0
 jwyrC0Djr9CSuXCXYPAzjKO1vEku83BXVv+e1QmnouzWVkOzW23qUQgQ1WRfPqALUbYH
 MsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551271; x=1775156071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gYmxGb7uQeQFtcBU/KNsuA+yly7Rfm4LYjwUpGocOHU=;
 b=BPWTUJ5nontqW378KPhw4rOUitL1rEsnf227ukDAEKhsQgeLCqGwQJF4NyXt/CwrI+
 WnEY+tSVhagnkKOSajpE4t2S4oilFBEpa5CqWveYheUnMmmqGeYxK9Nl56odjeAMTEUU
 oy0K3Po5qAgpD5ROaymRLSQi5Ftdv6Aoxtb9R2sxp4NWI732IkxXnRb8fUnGIoUTzXP6
 pnbXLp/qUoSkk9HEH57vEUGjk5KJYzMeveKuuO1+ggCAYxCqzWZteTXh2XoU/rq/doQ5
 sSOBSkMIuBYuX/aT07kdLEDDNr8bwgA5yfAB6KASMG9Dj+M9jXNpFRZd9uCIUnHTLAco
 BKiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7hT8IlBUxCPVd2Aqjk/wtX6gaKqIknleUuCaucBM3h+DkRulMFkyC1tCVHItomD32I4iQ5/gu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwID8/WHXh4CKlWa0at949F97LexZqUsC0LrqKM25/vo/KjH6fr
 a5oCo2MKjqa9b9pHLltiINlQMjjuGZEFy3czgOvXtfLV1bIs9NAvLeoh
X-Gm-Gg: ATEYQzyCObY4u+SUen5tIucJJJ3HvT/UoBQzC7guEJVcpbzUJHXMZoZGeX3dRxQX5nV
 v9FOZy1pMKfwQ+Mp8sf2awE3ZE/0ijYH5djZEVhlcEaaJLcyz/qaaRn18La4EeYK+NhF9tP6Jp9
 x3nN3+ytly5LG+ov0fE/QWWWxT+7p/3oP8yzs5Wk7aVfMfhBB576uluOreZ35bsRCpZq7ougRth
 DQeCir3m+jiqXyUHxQd6XAKydFK5hLufUR03hFg3gDbOZTN8xhLKOu1Ppm8laC+S1MZOZFO7E3E
 4JZMid7wmIZ2p0X/im8Vd5CS0kst/61L/P5F3M1azsZol/yeQbsu3MfVHWtAuQ+o5mFol2uH3Il
 BMu83nuXOI0H0kuAaG2zEkLY2HRgWF0KKcg29lsRS6GUQU2EInwZ7739s4VCOddFFo+J/hGXWUB
 mD3siDwiJdquh9cSYFy30Triw3cd4OO393AGI2YdpVgpxU38fq
X-Received: by 2002:a05:6870:8131:b0:417:ab68:fbaf with SMTP id
 586e51a60fabf-41ca6ddbde6mr5024881fac.20.1774551271056; 
 Thu, 26 Mar 2026 11:54:31 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:30 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v12 01/69] dyndbg: fix NULL ptr on i386 due to section
 mis-alignment
Date: Thu, 26 Mar 2026 12:53:05 -0600
Message-ID: <20260326185413.1205870-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 12:40:00 +0000
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

When dyndbg classmaps get used (later in this series), the
__dyndbg_classes section (which has 28 byte structs on i386), causes
mis-alignment of the following __dyndbg section, resulting in a NULL
pointer deref in dynamic_debug_init().

Fix this by:

Adding ALIGN(8) to the BOUNDED_SECTION* macros.  This aligns all
sections using those macros, including the problem section above.
Almost all the other macro uses are already ALIGN(8), either
directly or by being below one.

Removing BOUNDED_SECTION* uses in ORC_UNWINDER sections.  These
explicitly have smaller alignments, and using the modified macros here
would override that aligment, which scripts/sorttable.c does not
tolerate.

Move __dyndbg section back above __dyndbg_classes, restoring its
orignal position.  This is cosmetic, given the alignment added to the
macros.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202601211325.7e1f336-lkp@intel.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1e1580febe4b..58daa551420b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -212,11 +212,13 @@
 #endif
 
 #define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	. = ALIGN(8);							\
 	_BEGIN_##_label_ = .;						\
 	KEEP(*(_sec_))							\
 	_END_##_label_ = .;
 
 #define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	. = ALIGN(8);							\
 	_label_##_BEGIN_ = .;						\
 	KEEP(*(_sec_))							\
 	_label_##_END_ = .;
@@ -869,15 +871,21 @@
 #ifdef CONFIG_UNWINDER_ORC
 #define ORC_UNWIND_TABLE						\
 	.orc_header : AT(ADDR(.orc_header) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_header, _orc_header)		\
+		__start_orc_header = .;					\
+		KEEP(*(.orc_header))					\
+		__stop_orc_header = .;					\
 	}								\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
-		BOUNDED_SECTION_BY(.orc_unwind_ip, _orc_unwind_ip)	\
+		__start_orc_unwind_ip = .;				\
+		KEEP(*(.orc_unwind_ip))					\
+		__stop_orc_unwind_ip = .;				\
 	}								\
 	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_unwind, _orc_unwind)		\
+		__start_orc_unwind = .;					\
+		KEEP(*(.orc_unwind))					\
+		__stop_orc_unwind = .;					\
 	}								\
 	text_size = _etext - _stext;					\
 	. = ALIGN(4);							\
-- 
2.53.0

