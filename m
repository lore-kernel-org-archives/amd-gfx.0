Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3344CCD187
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A26B10EB4B;
	Fri, 10 Oct 2025 08:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cObmjkkk";
	dkim-atps=neutral
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com
 [209.85.166.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98D0510EAD9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:58:58 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id
 ca18e2360f4ac-937b40137b4so98984639f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032738; x=1760637538; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+G5LpRSmzQv8Uk4Lzh4jg4DDwzNtpQJGLN6ei9qbCY=;
 b=cObmjkkkxiaJ/EAw4vwin6tvCGkvkmKxyAhWsfqEawQTeOC/CxDayaznjI1AUPxkcp
 47pQ3gCD/tKLhyQDiIzrEG9b0wfdSm5Py+WL7ZU80pYV371aICbDZJpUPGbUQyAYQQOa
 eokCbYDT23IHvQfPJxM3s/utf0JP7CQ07ZVapQXL2bc/qTHsvksSE2wgWqThIXwqkDGp
 yIqlspEfaKcKaiaCwQm7xDqLz0FlK/O/7e4Ks6hNko3J05Uw2tHis7RY54kwXmLBzPu4
 3bmgP7ZwmO1GJLKVexRhgHByhqFc3YU3fEO8Fm41l66+QUD29tFvzXAa3It5XkIB6CFa
 vWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032738; x=1760637538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+G5LpRSmzQv8Uk4Lzh4jg4DDwzNtpQJGLN6ei9qbCY=;
 b=PDp39qULjz1SXcZre9YEESOSBiOCj0lJ2yH2hx+tZNpDbyJMRjZG6QB7/l937e7lox
 iEFKi1718KY0pdeOR/roj444zNWTw63zAUUNaUMAeeqth9KrVfll7BTR02qAJ1UHnWPm
 lIuBM4ck3TUyBOhAQowQbWdtqoAW37vucnZ19+ep3HRGpePb44RRJQuLBQqdZ4y9Mcad
 WdZwPR+dhZAqTnH1sN5heuQKmkPD+8IUWkADyz16q0LuD6jQDugwG+nIXenddfuMh2r6
 eAYzozowN+x4YH7YqUXkyRiVuyyhpmQx63nxJG9Si+Hhx4w8nYT5z0vshBOFWa84qFqj
 4FDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+YdKyh9CqRl5AK5xuUqz0mwPUKCnAuDUOIr9CfZj2WtODgfnsNnvALoWOgppE2qtLlA43gQAN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrWYXJQSKL4ILiHLXyFleq3KvWGWUa/eAegyFRgLLplmlb7rnR
 PxeFo6IIYws5aMxH6WOaPBC5zo9LR6Yji9KV/dXM2knVb6H4LTvvKtUY
X-Gm-Gg: ASbGncsuo5w3ly9OubxPL9yIguCVIFgaVuhC9OAi04ZsBaWTSpePI2BHciOJQveMLr8
 DnNNvXfFH1nx2sxwlxm6fYfDLk8Az9oIkYjvB/on52LewcNP0t4swxuWij6+C2VzfQZ+TBMRYwk
 cvJjXJVsKQ9S4xV0heSTEcYkEuSbQm1YGF2uPAKAtKXT7nHOVQ8obeM1lBCKGkASKAfmVl/kRyO
 i+SDPONByEmNITn13ZZZrpfrcILoommAn+A+d6jZmlGe4bmEXQKRZjWpJjX/eT8cqvgpMBE/5YM
 0Cb+GKhggYpuxS1oiEDHVO5tl38XUy4Lk2x/Lo8J4ctGx087GHPLpudEJupdWFyU/YyvdY8b56P
 k+5XWRW/ERg1fMRkbITzTafOD//5UILYjLx2wtznVqdAYZ3NRN8Q9xNWFiSX42h+/7fFGYcE9tD
 HLwN/eGENdLzOU2Zou/HKTT6+KKh+Ntw+0tV/dblwpveet9k3S
X-Google-Smtp-Source: AGHT+IFuL6dXa56UawxDS7QbBZMvD0b6eokP6AmRif2uOK68pKBSgTMBBEBchUQxGhuaWuFmQYhoQA==
X-Received: by 2002:a92:cdac:0:b0:405:d8c4:ab8f with SMTP id
 e9e14a558f8ab-42f7c3b2655mr137429405ab.14.1760032737756; 
 Thu, 09 Oct 2025 10:58:57 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:58:57 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 10/30] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
Date: Thu,  9 Oct 2025 11:58:14 -0600
Message-ID: <20251009175834.1024308-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Oct 2025 08:03:12 +0000
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

old_bits arg is currently a pointer to the input bits, but this could
allow inadvertent changes to the input by the fn.  Disallow this.
And constify new_bits while here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 96cd31c457e2..08d095dd19ef 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -595,7 +595,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -604,12 +605,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
+		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
@@ -621,9 +622,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
@@ -679,7 +680,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, *dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -689,7 +690,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -743,7 +744,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -756,7 +757,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:
-- 
2.51.0

