Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AB6E677F0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 15:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A80D10E6C9;
	Mon, 22 Dec 2025 15:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RQvrTyqo";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBCCA10E5BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 08:24:56 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso6064622b3a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 00:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766391896; x=1766996696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgJaffb+G8M2IXpwFpfYggq/3ogV1jI3bmNBB+yiGR4=;
 b=RQvrTyqooS4I1OuftFOJxV7Vemd2N0GjeH7zs5n+Cc3c2Wgu0PE2S0G2thVLoZgwvN
 B+Rv9O1y1bJpFrIPn065S8AA5c6IcfaQTCEretrk7dYigtGb2QNlWgGH/XSGpawoIUr+
 p65UhHMT2W/0bsKFjgSaP+AcR7LI3OE/8iCV3Uhb6Dz3t8h0sVJA4r319o8n6wn9ohYG
 02x7NExK4A+qbnE10ypC/f7CS1pCsMizQyJla1woaIS0b492HNAS/qGvLLP6ed1vJgjg
 dZeooiF8ETS59lfYbyFhViv1gA0y0b4NCq0n5VuB61UKlwAYgKnOgFPAjxVgY+Boz+u6
 bP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766391896; x=1766996696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kgJaffb+G8M2IXpwFpfYggq/3ogV1jI3bmNBB+yiGR4=;
 b=Qd+hqgnWMMIQePsUAqPjQX9Z9eaVUH0XMOWQuDpRuQWvemPwsQbL1wH/JRebkVd8Ec
 819lMoaQsX3V21ZQHlUksg5HI3HygcqlfHYnVNJpe/1iX8wJixaQ18aa1fO8UndnFVGf
 wZsTcuMXLacXC1ORAZwFypqII6Z7nqokadf2Y6PQas2nBi28gXlOy/ts3ZcQ5e2SIyny
 MrzVc6IkppXNNXIjleiMx9mojjVFokzd/tSEBBKcPOp5Q4Y4kLj4OkOOcKjAPOdv0Vmr
 4W1f4/I33550O9u3Oe+Zy8M1Alj3M2tlVDMCsqMHGHk81B39MiBUonImyb1tczA0LlRv
 P07A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSoIYYQwwnhAneJFLxaavPj++oRoxWtqwsmhfCOb3wrtblXHBXe/gZPLGgijmyeMnfXX+8NwDI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZv6Hb0dLqLE8Lz9V3bh2AOpmZH2W8BWGW79IcPbWQ8r319UjX
 SKd8hzE9NpQnvKT5Ub8X1B5kMnAw6m2PlVJxfb1XY2zpuQkAzV9ULFY3
X-Gm-Gg: AY/fxX4Di3hvSCJNGu+kWVGKIPyCZPEfYWojhXfE12v4IVThPqoS8PlhgtJ6K3MTcJG
 ay09CVUKDv3EyKZn14jXG+XRV1KJUVEjnXmp22gDOLscwZ+GOe5XkXceIG+eB/9lcDCfMZ/3oLO
 Uf4wnW5MzYXluRA80gnb9oq1od2M+jooRvwF1Lhn6i7cJc9H3OFuAmEAgyoin7W1ExFgAeobGvU
 UAHi9TF3xphLdhXkxEhgJhrJgdkgYCValS3SetlYM3IMKxE0YrPZjEkMWb6DrOySBWZad0Sluv8
 yyoOWAhFtSdetLdc1d3Sv/H3jEMX+sKBFGpNfKlDR9XeyGSWGz9QoKTW7hY76+QDv2pKjoI0n2l
 GFoX7GZQt4JB0YQyn9q9UxE8gCJ7gw5C/h8JDCJ7ShpBXFUurvmLeUlecgLRJrW6d7kV381OqNn
 Odfl9Hn+F3
X-Google-Smtp-Source: AGHT+IEBN8n7tfe9iu0lB0z5JyKVlf1YDr7ixcXKx8kSouS/KoZMy7Fhajpfqtky2YSRXNA/9ikrkg==
X-Received: by 2002:a05:6a00:1d12:b0:7b8:16af:3bbc with SMTP id
 d2e1a72fcca58-7ff650ce054mr9990683b3a.31.1766391896403; 
 Mon, 22 Dec 2025 00:24:56 -0800 (PST)
Received: from frodo ([2404:4400:417e:3d00:8b90:7f55:1261:772f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e493123sm9540699b3a.50.2025.12.22.00.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:24:55 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, jbaron@akamai.com,
 gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 seanpaul@chromium.org, robdclark@gmail.com, groeck@google.com,
 yanivt@google.com, bleung@google.com, quic_saipraka@quicinc.com,
 will@kernel.org, catalin.marinas@arm.com, quic_psodagud@quicinc.com,
 maz@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, mingo@redhat.com, jim.cromie@gmail.com
Subject: [PATCH v7 20/31] dyndbg: change __dynamic_func_call_cls* macros into
 expressions
Date: Mon, 22 Dec 2025 21:20:37 +1300
Message-ID: <20251222082049.1782440-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222082049.1782440-3-jim.cromie@gmail.com>
References: <20251222082049.1782440-3-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Dec 2025 15:34:03 +0000
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

The Xe driver's XE_IOCTL_DBG macro calls drm_dbg() from inside an if
(expression).  This breaks when CONFIG_DRM_USE_DYNAMIC_DEBUG=y because
the invoked macro has a do-while-0 wrapper, and is not an expression.

   if (cond && (drm_dbg("expr-form"),1)) {
      ... do some more stuff
   }

Fix for this usage by changing __dynamic_func_call_cls{,_no_desc}
macros into expressions, by replacing the do-while-0s with a ({ })
wrapper.  In the common usage, the trailing ';' converts the
expression into a statement.

   drm_dbg("statement form");

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index d543b84d447e..c4ebbccca5d1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -217,20 +217,20 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
  * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
  */
-#define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
 	if (DYNAMIC_DEBUG_BRANCH(id))				\
 		func(&id, ##__VA_ARGS__);			\
-} while (0)
+})
 #define __dynamic_func_call(id, fmt, func, ...)				\
 	__dynamic_func_call_cls(id, _DPRINTK_CLASS_DFLT, fmt,		\
 				func, ##__VA_ARGS__)
 
-#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);		\
 	if (DYNAMIC_DEBUG_BRANCH(id))					\
 		func(__VA_ARGS__);					\
-} while (0)
+})
 #define __dynamic_func_call_no_desc(id, fmt, func, ...)			\
 	__dynamic_func_call_cls_no_desc(id, _DPRINTK_CLASS_DFLT,	\
 					fmt, func, ##__VA_ARGS__)
-- 
2.52.0

