Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D1E107BCDE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56DCB10ECA3;
	Fri, 13 Mar 2026 16:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P6vP+0xY";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D4710EBF0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:22:33 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-464bc03efd8so1513985b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408153; x=1774012953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7LRJl13Yqup7eJj7JB8u2raYRuugKEd6d7nm5DRaag=;
 b=P6vP+0xYxO9sZtCWii4VtPh5zzqKSuFYLYAw0VtG421GZefD8mQfEpEb/KZhx8+8e7
 1ZBCYP9X4EzER48qBQs0of/nEhW0v+LPzSjV6k2oz6Ob67ttyiwDRjoS0oMVgReLvQUa
 6SgpW0fezSZshQwOOKO135t7Roqo8KdfKymO8bMBG5EHpS4D9Cy2sjumcp5+Xe7ZsiKy
 QmKnVJbpA6CIGM24SKwVGFtSOuU/s/k0kUMPTF3Xkr7XjJpXsRnavkEHGTZ3vY+YZXIL
 P9Zz78XJbgWe2OG3xUtp2QJtDq9Oc2XQE9dDxFoFjK1RuABq2pS878adfB2TAgwOB+rA
 A8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408153; x=1774012953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J7LRJl13Yqup7eJj7JB8u2raYRuugKEd6d7nm5DRaag=;
 b=C66D2vF2SE3uQhBjkuG1r0313WrEAAYomHsaoUlpYzDyuwFrtiJPxDpWqgK8dw5oXt
 I7XkNxrmMuNarFIlG9MgsokevPVstYyTRXJDO0PB7WKV4qFkfrcZm+Us3yVyaqiionqd
 SXNlIIBAxZLeMKYjjUGBnWly5DOpMG2VtpV2RQebKNr4kBfb5GgbujY7gtJgED+sT/nz
 +i4ZWc5F5Q7/37utfl2kJu9vvJn8USSND9/l7ySzAsSOkVZdHErSPscjfXsnug5Q5lLP
 mTKF1/iaEfwJDzJ4QjTZXwNagTwve/t3MmLDufhequRO4s3erZ70rOMXX1AZPdZon93c
 WHGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcYwnPZqUGACr7VPzNfsDwtrykYyAEtz2EVWqRGxtcu0eImE/LLlJPy796ZMXMJ2CLQvhhSISy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxNpm5ghw4+Vac8S7EYhwGzf4Ysx5MdPzpHK/jW9CDVmtjtRI8
 vguBdWyz8u1fNUpwg3qxsLb1qeug6cj/rBs4WkP9azi0F8uuBn2F8Vdx
X-Gm-Gg: ATEYQzxo3MRpiOYs7a38t4i7fT6Csw0i/EQykem9bXYnumrMko71KtWPh9OI3y6WTr7
 tZRQdVbl80AkWocS9ltsfZIu2CrR+myca+KugPrHKKm5dPFWrvUm+uQ/+wXmPNfUe+qzDI3NG7J
 j+IibTwXVoQrbYfZl8JIu2wkCFsVw77cBPZroZWJt1NZiM79lpM2g2mFPIfAmDpO/Xy65rsxxyw
 MdFiiXAzON18U9Muc0ASaPnT4lslgjNY+aAg5T168JBsvnn+tg35h4egRZhO49xj5l8rgAaKdAi
 SGJp38KaLfm3bNFDeL3rFApWtc16dIVpV/I8ZR1suB7eEpiTpNi5AQT5gc5ySi66hzeVenZYFeC
 DCfWYZMfMYtp0ZSf/Qv2HdUOCzyzbOMyc5cYlfbdPE1Pxs93bt98AlmtQng0xUL4zMLfiokTPsK
 K2cAlc2p4AyERwgw0wTs/Wc5fPo8w/juH1lYROYlmNKY4Xy0hc
X-Received: by 2002:a05:6808:1b24:b0:450:d471:dce5 with SMTP id
 5614622812f47-4675701babbmr1567747b6e.6.1773408152897; 
 Fri, 13 Mar 2026 06:22:32 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:22:32 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
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
Date: Fri, 13 Mar 2026 07:19:26 -0600
Message-ID: <20260313132103.2529746-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
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

