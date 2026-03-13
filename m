Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9422107BCD2
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C9A10ECAD;
	Fri, 13 Mar 2026 16:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mBj6Vi2M";
	dkim-atps=neutral
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F346310EBF5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:11:41 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7d73d6976adso1891894a34.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773407501; x=1774012301; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7LRJl13Yqup7eJj7JB8u2raYRuugKEd6d7nm5DRaag=;
 b=mBj6Vi2MDxTFYIK/A9AgbY2ZgG+K1INm0YEZ1FvjMjql5fLh8qPHrsUSeIzunwcRsg
 Fznf72wJCp0rq9KPuUbje87jDh0kzB9pe/+psZedK1RsP7y83xTX9Hc7UJAC7KSdP/qD
 jonOPQNiTb6gsLhxZWmYUhS7lNX95m1L6FOjkvvh40sH0lvGiuWMiaX9fWBLqJolvcRi
 RqPNQurZl8uTQRO7BxHFilIjeF/0VHNoxab4nHJVjRtMYgd6EEEkjLmLTt6Vo5e4Rt74
 AZv0pzL2Ihm+hn9mQ9atVQEDVLkoCQOE7Pmji9rLcPvGd48jpvP5PC3ZjMExky5WhzZf
 htmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773407501; x=1774012301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J7LRJl13Yqup7eJj7JB8u2raYRuugKEd6d7nm5DRaag=;
 b=kyxZzoAih2QqVmxhTLcGqkg7VjmnSn/Z4EWj5yk1ihg4HWCvt9Tn+uham3jDpwMpiY
 goOani7Y9crOAiUEXiQcIqD+VyIpT1Ql2IetnawO49NqNwrW3rdfT1gmz1MqEjzlBpkH
 TJfTsmmeYBaQc+1lQZugFU5ma7aJ+H0E1Zy5/5jrKMxM3qiKTQGMdvncihcpx+GMr38X
 TXco8Gdgq6p3X3ScO/X7RuNANJwBPjolZlAQJZOadwvh6/mS0rCOctwA4+9aieEeXl5N
 bmq3fppgWzB7OayaNQ4+72ZyGRWeU3bvROp8+WF4O4ki7+MoGjiIfLkndVmcBFK74QTN
 1+/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1hV68AX0ZpUSlKIbMt/yP1rYas8OZLW4iEw0hOKuDn+p4Ib9k7jcL3zU4AtPosNKhY7liidx7@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyk+pkDhQNMXE02UnFOkXmFtQ3+GeUh6UXWJbVUxh2O6ujfcfZm
 TQCO4YYN7lFSsmbRbuH3J81O9l/q9OEIyoSFwhI5j76Mw5YxmvW4/HLk
X-Gm-Gg: ATEYQzzFKnhFIIsvjA8Bs9WnuWGP17kqI2U78DRQBxgztFgRdp0ix5cfvlaDnhdYH2R
 Dz/Il/U6itgB1rviy4BaDUDEiWomaFHKArM24S2srS0XhPht352Kx0TBNIwGNg7HQougi+w7W+C
 +BeFjfU7ax+wy30+yBaEbi7BRYxjQbbxfk2Y59A8RyaZfnhwGMtQrPCgOmK3e5sYj83pVKwuaQZ
 erWWq2JiwAEZY975uMNuCDaqAbLkFtMKNFjM/EiYiollMPmKDMayl22o0i9AeosI+xtxQOQS8Fm
 Tg3LPRk0HEcKaan/Fdeq9E/jURWWkDdkSdQKm6thTjXriE0ZMSFUhdFN1FWVPkFneUoQkxvFK81
 8TYUz1nf2fGLPsGAKoo2mptPC/ZxGkqIMngXqn7w7JTsmY1/WvzBvb8qfoU6QL9yLEvkw7+URuF
 rkehU6B32TbxxmvSg4Bz/YxbmyUiROOni27MqymtZWzvstFIIc
X-Received: by 2002:a05:6830:258c:b0:7d1:586a:32a2 with SMTP id
 46e09a7af769-7d78232b1a0mr2235981a34.0.1773407500985; 
 Fri, 13 Mar 2026 06:11:40 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7d76ae90586sm6733728a34.22.2026.03.13.06.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:11:40 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v11 01/65] dyndbg: fix NULL ptr on i386 due to section
 alignment
Date: Fri, 13 Mar 2026 07:09:08 -0600
Message-ID: <20260313131045.2526422-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313131045.2526422-1-jim.cromie@gmail.com>
References: <20260313131045.2526422-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Mar 2026 16:51:10 +0000
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

To fix this, employ belt + suspenders:

1. move __dyndbg section above __dyndbg_classes.  This restores it to
its original position directly after the ALIGN(8), and fixes the
immediate problem.

2. add ALIGN(8) to the BOUNDED_SECTION* macros.  This aligns all
existing sections using the macro, and also fixes a future
dyndbg_class_* addition which would suffer the same misalignment on
i386.  Many of the existing macro uses already have a preceding ALIGN,
these are now redundant, but are harmless, so are left to avoid churn.

3. remove BOUNDED_SECTION* uses in ORC_UNWINDER sections.  These have
smaller alignments, *and* scripts/sorttable.c does not tolerate the
added ALIGN(8) padding.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202601211325.7e1f336-lkp@intel.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index eeb070f330bd..a2ba7e3d9994 100644
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
@@ -383,8 +385,8 @@
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
-	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
 	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
+	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
 	CODETAG_SECTIONS()						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
@@ -867,15 +869,21 @@
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

