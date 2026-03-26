Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AF510ED673
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A753510EE17;
	Fri, 27 Mar 2026 12:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TG25N/Z3";
	dkim-atps=neutral
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF3E10EB43
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:42 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-67e0d3f288aso621732eaf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551282; x=1775156082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wIIBK2xLHmy9ZZczWpP2RzFmOx4bELZz7aMw+RGO2w=;
 b=TG25N/Z3YTgPWXOmXhWjfDAVnM5B6uECwSBVH/Jwb7R/cwOeUBFflRFIfFwpgz6hk5
 aG9SGOFnS8nEvkQIeSuO/6t1xRe2TDfpXzuztD8A7oXMCbejTrgkGkVsW9GKizhZcdR2
 UFWLdT6p40MNOkwM573U3qV/2qzAfs4FviP5SwdAXVSZS2uny7XXGINMT95ZN1aJMhZh
 ne8k9pVBnY65GsX7R1+fypPJzgZGmUHfkLnIcbAk8WCgMi4ajlR6n000Hw5jA1fpj+I2
 bLCmFNRi4pm909OaqfQtdnZSJv6zpQo0UDDRlXZTRvHjLMYcZ3p257Lo39PWik60xBgc
 35VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551282; x=1775156082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4wIIBK2xLHmy9ZZczWpP2RzFmOx4bELZz7aMw+RGO2w=;
 b=ZtenEN6nc0/+3Mz435Li2gl6eA/8iGxwkma+CD4HEPrqkpgFB+ODKW1B/jvv41K9rB
 q/IPsB3Www/ZTgAC5Q9Gigu3qhCLLXkB7ffRXSOaWI90XRiIvPF9OU6Mk2Yz8Dwjss3E
 SSp93Naf/XiibyM35O6719t3ReTinKcf/2XWK0xMsA44HB78jJOkPlK+hhr8VcmrBcvW
 DfrPvSRftpPn1XxUn860YAmc7M3cSExIphbbeMiUxejwOP5T6r7weBrb97XGkWtk6ydd
 VnE16nwQ410XaFC1KoZKlPqSvp2f4w9fUg9FfWuOs2QAoi6VihjX7ZZJ19gaM4DSTZId
 UMGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZsCSJU4SAi0osjQUyblCRRsPry7SN0TL4RP7Rxs9Hw52camYYxMErfF+50YQYHcbZS+fMzjX1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdgBItEQdvnfOCruBd2J7glCYUfVByaffkPQXZvPToDF1mlphd
 6sJNAJhEmxGiDycYqXW15F0z3m7SBlUZUEnXB6urnTJCHN/HJ+PhCdmx
X-Gm-Gg: ATEYQzzxGD24K+ALGH0ckPXbyUObIft2Xx4+rkPibKKE954THKkEqEfyGVBUXLzQ8ZY
 0RDmx4VMApvdMGAEuwebFdwYmghKzwR06ub3bHqdIt4TZkBnLbzCqQsR9+5SXSurVzpJ8GQl49/
 xqTtflB1agaIzmS+vChKmuodqN4cphFoxefI+vkAKgnHPbgGL2XO6Qc67+eCYzVkuRl+nwtegxp
 CdXll2CzofMQ2bYWwpGLK6X2D0xhLNnMu75zHQXfIb6ulEiYIAgCaEeS3cvEbJOZKti2PYzB05E
 nVkNDK92l1WKS+EtvAIPDwuiCfhQYaFQTMyUiw4n1m+ygWS5KQ8IMGzeujnEP6zm9/TwnpYkyo/
 W4PIBfF6osndJpApodxlJHmUYUITVvhMTd6LPHWKzLE4k4NwR0rTCjrlNgDDJTITz8y1USTKxko
 GdFJQbW2NuwkDHrBMOuO7mEuGuGGNf6yBEbqJo7D43KXAr2XHb
X-Received: by 2002:a05:6820:174b:b0:67c:2af2:a66a with SMTP id
 006d021491bc7-67dff37caf7mr4976746eaf.11.1774551281759; 
 Thu, 26 Mar 2026 11:54:41 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:41 -0700 (PDT)
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
 linux-doc@vger.kernel.org
Subject: [PATCH v12 08/69] docs/dyndbg: explain flags parse 1st
Date: Thu, 26 Mar 2026 12:53:12 -0600
Message-ID: <20260326185413.1205870-9-jim.cromie@gmail.com>
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

When writing queries to >control, flags are parsed 1st, since they are
the only required field, and they require specific compositions.  So
if the flags draw an error (on those specifics), then keyword errors
aren't reported.  This can be mildly confusing/annoying, so explain it
instead.

cc: linux-doc@vger.kernel.org
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst         | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 4b14d9fd0300..9c2f096ed1d8 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -109,10 +109,19 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
-A match specification is a keyword, which selects the attribute of
-the callsite to be compared, and a value to compare against.  Possible
-keywords are:::
+Note that since the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword and value.  Flag errs will hide keyword errs::
+
+  bash-5.2# ddcmd mod bar +foo
+  dyndbg: read 13 bytes from userspace
+  dyndbg: query 0: "mod bar +foo" mod:*
+  dyndbg: unknown flag 'o'
+  dyndbg: flags parse failed
+  dyndbg: processed 1 queries, with 0 matches, 1 errs
+
+So a match-spec is a keyword, which selects the attribute of the
+callsite to be compared, and a value to compare against.  Possible
+keywords are::
 
   match-spec ::= 'func' string |
 		 'file' string |
-- 
2.53.0

