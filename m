Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E3C107BCCC
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2948710E44F;
	Fri, 13 Mar 2026 16:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FrZEtlKu";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28DF10E060
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:06 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-4670464029eso1288815b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408186; x=1774012986; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wIIBK2xLHmy9ZZczWpP2RzFmOx4bELZz7aMw+RGO2w=;
 b=FrZEtlKuDuEfFlrIRTNM2hGm6GGCDKItlzdd/w8l+TdKrX2ND6iD0ziBfgO5Czgs62
 9evv8DmgMv/EnjUId0sgIcXW9ofQkAZ0YzGJaIf74VUMUqufCsJuCbKmbSfaiD61G7cq
 JtDRg+ZpKIfMvVDi9DFkwo6kxRs/p1pYU4EEwCVUBrqxG4mc3XTVETEkFWPAGEWnqP8b
 iU11ycRAOS+IrY6RDnJLFGb7KSRPDZS/mi5VAN3zcYC43jiQ4ZiNCZdBwJW1nYY8V6uH
 T1w31A7U0xz0CcMYcraNWtgFfeMNjaU1TK8KD5T9bIam1lHNQ6HCbaSdRi62IS1S9VTK
 DFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408186; x=1774012986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4wIIBK2xLHmy9ZZczWpP2RzFmOx4bELZz7aMw+RGO2w=;
 b=sVZq7u7ZleHC5xP1NJZfaDVq82Y0zqk17thBxkM7W4vwAigjZXkwwwQikKoIGu6dJ/
 BYHvr0Y56eHpf21pWdgTEL3DgeiYRWm7jJSZ9sazooD6vi33P3n4T9nHMcc+7Gkvn6JZ
 AviGBYujkmuJN73ZOrGUCiTTdn5QLsyvhVRxb/bHLixnMsMpKcOCubxVZgXd7xp+Vxwb
 RLjQcc31hMJ+rIkYJhlBa3IgzmJ6urFI10gaxDDwYSVfiObySssuyv3JsrM/5F20UQUJ
 7m2RDF0xlHPEzzGQQasC0ypS+MWHhYx44+6ktZ89qX4aqYbXuWklorn5x9MGPWiQk59G
 dTRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgXUbidLsgBt7kK32606y5eL7qZNT6Qmnuvk5V86m6p11fYhQKhjG0kxXYlmgYQK2ALEuWkuLu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvmokWqjSxJVCqJ6MUN2CPBX9acOo9ZynwKbc+pV6Ij+S+tD2P
 wx0OdZgzaiyuDO7OasRFiKWR7BjridDHdYTpREvR/zXbvlNZ5U8zCreA
X-Gm-Gg: ATEYQzz2iUTeH48Rzr1lAQzJbrPOnsW5Gj8400+RPBt+32U7DHXUho/Q2DAEjeoHy8G
 y2Nwaga+QN5okJ28nXrW+6GF4jayf1eigqq38cDshsV+8BcRdGnWPmfac6Rwb1FZyqXd+U43mgh
 vWufOE5GC/mhapQwkCcIvPEuri1HXXOSIJs4oCm6JPanUGBl1ggNueAHqe39kfHyygQZVkDZ8gs
 76qxJe92ZDWwbkPgYFBvE3HuWJEmR9ig0WaK+JJpq6EbbUu6sPLRgUdPnD299xNhHS4iUfwfkJO
 yVb9LNoHTYK5So4NUgKveXnCl2I3DaIf/kyyKzRP/KIPrFvVsdSMYGvYthAImF+NN+HLkb3LehF
 qiN7NtrAnMaB3T8XwRynsyOjjQn35QdCeHhwlGoa9K6eG9AiWmg8449PV9B1sR4vVMiqVMpkE7I
 04yOTvCvNTH0Osymb7oceealhbt+wuAshmce8Q+cKTHRAvK/eO
X-Received: by 2002:a05:6808:15a2:b0:467:1e5:6766 with SMTP id
 5614622812f47-4675766748fmr1758674b6e.45.1773408185885; 
 Fri, 13 Mar 2026 06:23:05 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 05/65] docs/dyndbg: explain flags parse 1st
Date: Fri, 13 Mar 2026 07:19:30 -0600
Message-ID: <20260313132103.2529746-6-jim.cromie@gmail.com>
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

