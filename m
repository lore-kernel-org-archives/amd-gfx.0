Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7803C10ED66F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9189D10EE27;
	Fri, 27 Mar 2026 12:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CjHObJXX";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBD5C10EBF2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:09 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-464ba2bb3aeso745614b6e.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551369; x=1775156169; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4W3w9+Cd3LB8UtvA4xSE2rspTRatyv6KzC/l1k+Ff0=;
 b=CjHObJXXc8iTOat71jFYbA0lC96kHEBouJWuxm+wM4YfaHcKhFCrj++EdKTfowfnwC
 t8a/S9O5YE6HtmHRuJg+G+Sllih551sfoQHTSBqqoZ2wgsCFG9WuFCFl4DgKfYHqY5wC
 tfRQIIr9fnVL3hbVAI30tDJQ49bACzyAdvI6UkP57QN0UYAzKg5QjFjGu3zuHP2Iy6IB
 qGr1oGsFfQssyphIjhBlCinGOM/Uo2lEtyXIR2XV54GAA/H8PHpawQgQDzDt2uA/P/bg
 +evSE6hdk+Iptp1CH/nC+uCdn2I7HHn8hSoc92ZR5knKv0zjPrq2F5iESzXZOPb568kW
 UPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551369; x=1775156169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S4W3w9+Cd3LB8UtvA4xSE2rspTRatyv6KzC/l1k+Ff0=;
 b=eSASoeT5C+3pkm+VSzvNbZXLmCaCNMP0DmLpOurEUbbUCCeryw6JGmkgN86eox7ynG
 NaIp5GzZFyMysCLWM9JzurffPjiax2HJn+0PnyO4+eiw9Sp8hpoT1ofiQ/hSAnhHssuN
 o2YwYrJb949l04v1MQhNjaYyhhLolNc/h237wePlLh6dE2snow+1r3AIvYd2L9R34Tca
 36P8q9+Wc7BNcVtsMFxTYq2naYEWkNqIKHmoXhvdcXEBnWb3fik4WRHbIxih/x2I8h/B
 np0uFeftRjVAaapnzRPowc0vHccQE7pSgnXcpN9Tj+KGZ9d26apea0Tf63Fa04HvQ0rA
 mZYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPQainl+Mure3s5kHR7ItHJLJ107IykcU6lg7c2AGtBuddXpFFOoth87v0GRQjyVPICdR5Css8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyY7weLekjKj0czaH2eENJHN26thbdorqK0uWSe6rkWdU5uy4VP
 ms0wLg/IVgoBZbEZKGt2zdzkYAeT6QBWCo1UUN+BKC/Zo0eGHmdl2O3x
X-Gm-Gg: ATEYQzzHmvI36H4/UejlM6cQikwsdWVTL16Jce76muN73hQn7CXlmJIziVYH9ULA7NI
 Msc7hxX0fZlHC+E+ow4WbFhJU+w9UcQzGKIxEchgRMXoNDauuAZitGFvxhhYwyK12CXOD9crrRm
 9HrsSGoaRVh66ocb4XW6sdk4u1bsvIotBPh0yK6ripBXMDpm/dJXp3Uin3Icfyif0Ngxk4RzRA0
 NM8qnGCGDV16vS1XjAtkYjs2VlWNmPC/UWHLpkYiQRqChTGf6snegk3pldxZWOiI+Qzodetj0Ig
 mj3377idHPBdVcVuvscSjcIb2kMs+a3EzytPXSNfIbiNDhtLDjKv9SgfqpL3AVCCnqCjylzW3Mg
 JmVrGIZ5hMcNUniVu3/xCI+R8MNcvxy24GUvO/G4wUlaJmDqaE2iZMGgR7lKwIlpPE9YFe+vwCY
 ZcOsyxrgfzsIzPZdQA4uSZ/+3wjGEpiBUmCImpsBEucUkARau8
X-Received: by 2002:a05:6808:1807:b0:468:4b3:d12d with SMTP id
 5614622812f47-46a7a88ab56mr1246480b6e.11.1774551369095; 
 Thu, 26 Mar 2026 11:56:09 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:08 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 64/69] drm-dyndbg: restore CONFIG_DRM_USE_DYNAMIC_DEBUG
 un-BROKEN
Date: Thu, 26 Mar 2026 12:54:08 -0600
Message-ID: <20260326185413.1205870-65-jim.cromie@gmail.com>
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

Time for some thorough CI.

NOTE: the previous ~18 1-liner patches adding DRM_CLASSMAP_USE, can be
replaced by a single call to DYNAMIC_DEBUG_CLASSMAP_USE, from a source
file linked into all drm drivers & helpers.

Heres how it works:

1- drm/drm_dyndbg_classmap_user.h calls the macro.
   This is a weird header, since it declares a record (inside an ifdef).

2. drm/Makefile: ccflags-subdir-$(DRM_USE_DYNAMIC_DEBUG)
   adds -include $(drm-src)/drm_dyndbg_classmap_user.h
   This "header" is compiled into every object file in every module

3. the DYNAMIC_DEBUG_CLASSMAP_USE macro is altered to declare the
   classmap-user records as __weak, and to place them into the
   .gnu.linkonce.d.__dyndbg_class_user.* section.  This allows
   multiple declarations in a module to collapse to 1 record.

4. dyndbg.lds.h's MOD_DYNDBG_SECTIONS() renames the section, stripping
   the .gnu.linkonce.d prefix, so kernel/module/main can find the
   section and dyndbg can process it as before.

5. drm/Makefile: adds several ccflags-$(MODNAME)-DRM_DYNDBG_USER_SKIP
   definitions, this is one of the ifdefs in [1].  Its needed to break
   the dependency loop that is created when drm.ko depends upon
   itself, or when drm-quirks that it depends upon also depend on it.

So this works, but it is weird (horrible, hacky, obscure, marvelous),
and I dont have asbestos underwear.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
index 05dc43c0b8c5..6c83b1276870 100644
--- a/drivers/gpu/drm/Kconfig.debug
+++ b/drivers/gpu/drm/Kconfig.debug
@@ -1,7 +1,6 @@
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
 	default n
-	depends on BROKEN
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.53.0

