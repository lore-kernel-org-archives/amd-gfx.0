Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E73CCCD18D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78CDE10EB51;
	Fri, 10 Oct 2025 08:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R8Im8tds";
	dkim-atps=neutral
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com
 [209.85.166.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0088310EAD0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:58:48 +0000 (UTC)
Received: by mail-il1-f179.google.com with SMTP id
 e9e14a558f8ab-42f7a4bf805so13342145ab.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032728; x=1760637528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=upmZ+84nb0PGLfZ0odEvQVtU0YnnK5GejiW4j5Z157Q=;
 b=R8Im8tdsv2zzqASIRywI5B236infNfWjEGa4pwGA7nhPyqZMtWw3Jv8JtMbXv6phpp
 i4MlAtADR4S4M3OMN7kXgSN1gT2Sl2W2odc9BLV4GQx+BMrjsQdJbqBT3gGbh3ONPww/
 wME6y5Vg52qe/zJSjuF7ql6wR7Yil0CMA3pBDW4YOl9nugC8rtbvcn95hXwfSRJqoh/N
 ge4kGDUaaXrg52YOs1Ybj//tjmWgQxi1r5ubaB88NdudJvY9ddt+MUaRbqzX5JhxYSVX
 6z9DLaLbM/H4abE0PyQW9Q4MCED0qdjYbqA3Q8P1WTW5QmOKV+tWWxdiop8G9inA4FHs
 e5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032728; x=1760637528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=upmZ+84nb0PGLfZ0odEvQVtU0YnnK5GejiW4j5Z157Q=;
 b=eUlF+Upbt9nP0pmMme9A+2AoDLtIydSvV8jva+6wOCfOOIar+PmYQiyTBAvmAiJBEa
 bxS5TTzYiKsvtWWPQKsKdYeobAF8m/QvWAHWuXFaJDwy2aRw4TPgn2RV9jH6TJITH66I
 qlHopLAupaybsTbjHIPxN+TYL9EoMnEjsTSrdtdXNTVPGQLT3UKeb26zIiXr1cQOSj5n
 5isHNOkH/KPSnETC9N8hsq1IzYmkn5IM237uyoYQW2CFDMUxxDLeh7XQLzkbKhcVij16
 Khi0q+v0AdS4tXUW+TiZjc/ZdqCjeqvbQKyZFZCbQbIBbVb2I7FTfBP7c2suEKSUn7nd
 0Qmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcY7mRV9DG+CY784Eyv2EFDsJ1OM9wsg2Df7ZaPav+h5wt2RD+X4yQOSqjypysntaiaKJfTrlX@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7uvMUm9RkEnqbOB8i4T9t4A3Sz6H76OOilfmsjPL0EuuneQuO
 RTVFRJt2xZa2gPMb60mmXJ+OzcozSAfp0icysHz/EmPwTsYrBDe/xs/K
X-Gm-Gg: ASbGncui7e39B6oipN6pyIYJWq4g3rwHiDEvpvGimyY3VRYFrlvQYZScdv65evcLicA
 ZpnRNa8GV+vMDNKR0l6k9FVivtBD1Kc1wQjVMi7BpDyWU57NrqJayKyRtfcNpvQu2XoKNjB6okd
 q9r/aS1PXGhde66VPYKFF/V4/bJVUwcO5SLIOmj3TlN/gBPxkjeW2YW+qFmXNJeYtb9KewdMSos
 +Fcvby9WXOQQrwvFtveIcugBUl+u1Qks9wnbbNZj0VfVtm1VS+X1YZ/Zzs4bdaao1AhNehKCqxg
 dVqydx/dMuv8SFcmYOGjrnlO4YJOX20YZ7YctScYt/L6kBXlcVhlFNRdxtOUxXx8IQ2uazQTfz5
 4JkiEbhwVdhRxn1XI2Cuhcf+jibUHDHl491xTOdvUZtfLGpBLF9E1Rzq5NUAlEgYK8I+Lt+sl5Y
 I0/sFui/IP264ZvhNLcIJfUKzaRERA7gZh3Q+PwlOIufaRdJSz
X-Google-Smtp-Source: AGHT+IEP/KYeFsU48bhRAsguavBTqOpW4JiVNFuGMdDXElpSwlucCVx3RZG6w7iiJpXxsucAPDZNmA==
X-Received: by 2002:a05:6e02:18cf:b0:42e:73f7:79c4 with SMTP id
 e9e14a558f8ab-42f873fb613mr81674845ab.27.1760032728078; 
 Thu, 09 Oct 2025 10:58:48 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:58:47 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>,
 linux-doc@vger.kernel.org
Subject: [PATCH v5 02/30] docs/dyndbg: explain flags parse 1st
Date: Thu,  9 Oct 2025 11:58:06 -0600
Message-ID: <20251009175834.1024308-3-jim.cromie@gmail.com>
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

When writing queries to >control, flags are parsed 1st, since they are
the only required field, and they require specific compositions.  So
if the flags draw an error (on those specifics), then keyword errors
aren't reported.  This can be mildly confusing/annoying, so explain it
instead.

cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 4ac18c0a1d95..63a511f2337b 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -109,9 +109,18 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
-A match specification is a keyword, which selects the attribute of
-the callsite to be compared, and a value to compare against.  Possible
+Note: because the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword values.  Flag errs will hide keyword errs:
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
 keywords are:::
 
   match-spec ::= 'func' string |
-- 
2.51.0

