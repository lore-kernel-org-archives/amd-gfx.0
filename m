Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9C5E674A0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 08:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF6FD10E5A3;
	Mon, 22 Dec 2025 08:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="etp3SIpI";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1E010E0D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 08:21:40 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7b75e366866so1656446b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 00:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766391699; x=1766996499; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oa5wcVDeV5J5v7vkbrVOxP4Roi/4nUDRF2hheke3WoM=;
 b=etp3SIpIip4a4W83G1BEONzUT5560Sf4rxQFWftsNWB0RKNviA1iFcNzUiRbN9OSvz
 AMSqOnlJN9iMvvIpc2fLWCzPDXio2YnOTsVab0wJsQOBX2oMXyXBZa3A2RBPr/T8kXpU
 Z2EOo0T2zx4ilEmjuF2qfeLyHG1yTCtoIuf4EXkBBwgVzIPX6sMkN/XPpNx3og0j6qW2
 QxphxG2B6lQ6KUEYCUkd7j68WG2BfqKcHt6+0tqSJ2M/v2CfiQpGmFz/JmHZSJdIPDnK
 N+Fu6ZyMcSQwRfJgotq5YiH76yHwPiWa86XNUSNHWC9mjfyHuCrHKulfhkzlmbk13gHP
 Yx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766391699; x=1766996499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oa5wcVDeV5J5v7vkbrVOxP4Roi/4nUDRF2hheke3WoM=;
 b=nOu4jQUTZ0Djv9/5y8VIGk5oV2cN4LMEtI5VJRBR4eQcOsg18xZn53j5fU52YxfYAZ
 7hJfuI593GJz1RlkT3oDTBcx06iohKXV7AIs7A4Jr/gEfib4/mAYikwnAd27grRjlQza
 83HVSjJ7RYywWuUuc9ysJW/MLFOrUo5YhiNwImSQL5lUdEKgqIXr+6qpIN9XrjYGsPEz
 nH72oTzEuzmcD2/0P3IOr8BZqyeTnVGYUjmDTi4eQXdydze23obSSZ5AVs1a9feXPysm
 FRxdsw1kQBoc02/6soSraoxztqdx9m+Ea36napwkrbQine/Gc6yvLzD/Yvz8HIjyfDiA
 fKKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBfwlvmfKAgtqz4S+k7Iuw22EKvba8mVPX9dgU5CiA1UuSeC7lIjM1Dp47x0WuVl8UJKxqu5/4@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0OhoDcEHIXJ95TYc2JSlVTJ3cByH2XPK2VFXwgSRtTLn+69EC
 d9WNoETidsu9O+xlrd1x12S/I7bXT7PCPbHjiUY8Ky9tOk8yUlES4dVK
X-Gm-Gg: AY/fxX4hIEyZwbngwI5+WjWvhD814o/TRoVXwmMZnQ/axJqUHcPxTQ1aXRWgHoM7kfa
 Dm4arGu1vaoWLtWqQJoemDzTFFgmnOjiM3YTRbV287SZ5wtSqBGx5Lo4S7QzQGGNFrouDcoowUT
 BXRjx522ERoAkX+/KUYBG+1LdpvxYv82uV+tmhuLsBbRgbHJ3G3r9ssm6+8TxWuhxZR8cboqSeb
 j9oanjyb0MTvzLLgJqc4VR9OjlflOcLYKc0hpYAit7gAcXRx2IQhyW1W7tVPDPDuJM5Ds/soAm8
 FY4guElyhN3v7YZ9BFhGgdth/yEVpUFKd7M4o6q9ziWMCc+zPRfMzfWi7ob6RwJTN9i4dq3/97M
 jHPvbcdliGnQdgyjsAMzFO03F0cPSvTEhOwvXsRwQ7gYOqXM7tMxNtYYEvumQodgrNpfX1yGBWF
 f6T6Z2luhh
X-Google-Smtp-Source: AGHT+IGcO+eahZ8Qfw1ltSxeW3EKuc0v2WQb9oj5sDZDssHMRosJcxJCeuE1JFMWMkIMkTP6ZaGDLg==
X-Received: by 2002:a05:6a00:300a:b0:7fb:e662:5b9 with SMTP id
 d2e1a72fcca58-7ff65b89e90mr9317037b3a.31.1766391699395; 
 Mon, 22 Dec 2025 00:21:39 -0800 (PST)
Received: from frodo ([2404:4400:417e:3d00:8b90:7f55:1261:772f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e493123sm9540699b3a.50.2025.12.22.00.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:21:38 -0800 (PST)
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
Subject: [PATCH v7 03/31] docs/dyndbg: update examples \012 to \n
Date: Mon, 22 Dec 2025 21:20:20 +1300
Message-ID: <20251222082049.1782440-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222082049.1782440-3-jim.cromie@gmail.com>
References: <20251222082049.1782440-3-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Dec 2025 08:23:36 +0000
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

commit 47ea6f99d06e ("dyndbg: use ESCAPE_SPACE for cat control")
changed the control-file to display format strings with "\n" rather
than "\012".  Update the docs to match the new reality.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 7c036590cd07..4ac18c0a1d95 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -38,12 +38,12 @@ You can view the currently configured behaviour in the *prdbg* catalog::
 
   :#> head -n7 /proc/dynamic_debug/control
   # filename:lineno [module]function flags format
-  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\012
-  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\012"
-  init/main.c:1424 [main]run_init_process =_ "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =_ "    %s\012"
-  init/main.c:1427 [main]run_init_process =_ "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =_ "    %s\012"
+  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\n"
+  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\n"
+  init/main.c:1424 [main]run_init_process =_ "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =_ "    %s\n"
+  init/main.c:1427 [main]run_init_process =_ "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =_ "    %s\n"
 
 The 3rd space-delimited column shows the current flags, preceded by
 a ``=`` for easy use with grep/cut. ``=p`` shows enabled callsites.
@@ -59,10 +59,10 @@ query/commands to the control file.  Example::
 
   :#> ddcmd '-p; module main func run* +p'
   :#> grep =p /proc/dynamic_debug/control
-  init/main.c:1424 [main]run_init_process =p "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =p "    %s\012"
-  init/main.c:1427 [main]run_init_process =p "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =p "    %s\012"
+  init/main.c:1424 [main]run_init_process =p "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =p "    %s\n"
+  init/main.c:1427 [main]run_init_process =p "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =p "    %s\n"
 
 Error messages go to console/syslog::
 
-- 
2.52.0

