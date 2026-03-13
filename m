Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D74107BCD5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFDC310EC9B;
	Fri, 13 Mar 2026 16:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RrrYxXJg";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB0EE10EBF7
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:04 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-4670464029eso1288799b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408184; x=1774012984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vld9IFfyvePqt5M1J9/OwioGOqjnLV2rFk+KzTunpXM=;
 b=RrrYxXJgnrKWeN0l+QdbWnq5Foal5clfVF061dMEPL/IM3MbnAGcDokk5XsfDsB0Pf
 ZaD4/JHNhj4moCvr+tTmuJogZ8AOQnSqv/XXYAdwVOdUIy7r2ECME1QWJu33kD2mqJmT
 SZWQVO7le+P21RnaXTxcCazgM7N+Hq/zqArjHoZx+APjMzP8Q8clBLmaTIyvKE5F4Euu
 CQJNR3NY1yAfr3iyZHVAwkEJ/JQ9RF0VsiVO9Nq36PPJpHChW4W47JK3LUsi+yJRCa+1
 Qou6jjW3aYSuRUZASneMTonBOgeMgc2gD5YGQh/jIErfDK9XO4WsjtbVvfroqkgp6Cp0
 Z1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408184; x=1774012984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vld9IFfyvePqt5M1J9/OwioGOqjnLV2rFk+KzTunpXM=;
 b=FggKQUJTdDebEbhtYBW/glrCvNuBeq7lEHMo9cjvJQdbb7CZCrtdvIOxY/KloY6Hxk
 SXY4MLey0s/sPnUIb/qnjFwWmJW7H9xoHj4HT1H1lfkekW236C97w/3R2EYxayTmTDoZ
 qsPcbYyzAYt+ucAPyp2VeEbxmUVjKfA4r5tgf63ypAdPHWAUiUGilig6ueDyAVPjDvRw
 GkPHffoJBb5dm45t99chp9l18DX/zKlL04KAwBs0gRPtQfmQUdNoF4uo6lxk4K7hftGd
 7KijTZMluDBPGCOBrb3Aq32o0x0OYVxBS12hB3GWkqObuXwtv0js8f+ZGRHWBKePO74U
 b9Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0D2RTy4UWTOC1sv8rGvs7DAzeNQZ3V4mDYicfxxo72H5DI7ewWGMiCPJCAhgg/d7pgXZ0C9Qk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrzDlvsJ1RW//z8FFZ/wdxD+sl07js3R/iUtdk/hqqLcGE3Vc4
 Z+YimC854n2WO8FjSEjG/jGx9hVV442t/CzRn0NzzBEEH7B80E3zDl7B
X-Gm-Gg: ATEYQzz0D4BMpUGfg+2HL2WnNMJH8WcUJgHuFHaIoKM6YCU2nyJE5zzvp/XPS+Tv7aM
 uYIyQC6dJsF2JbGUMDitVN4NwkRAAdWUk45wvElclNISlURAC7APu+QBgR3kHTgvIdADqXw3ZiG
 YFfVkeykZqDSmD/24FOpuJcB2YiB9RSyBx83DMr0DeE8mkRylws6RJIFJEuLbC+Bv3Hsl7yqgTh
 lWSV3Lxykad0ESwLGV75Ph8OshMZVXgkaHVWvojMMysQAorZ1D+JnVP1jtO8dxvPbpbsMOpubn7
 8FBNDXB31P7MvvY+2kA2HqA+pwe8BztzK8nvjnXee8AtVGN4Tj8TYEaiZthwRgqI6aJDocXwm45
 1VzjdpAVOZfWJ3r9q2kHKdMay19Etgp3ILzFrCGaakfe+XuRKIu9swNbfPXrnlkXxc8fryTDMkC
 aqg9qYHzAdbMs8UwhuN9UVLQrCH6Vrl5UUhqYUlyIWCzFvNwXv0Ha3KI+Qgd0=
X-Received: by 2002:a05:6808:1203:b0:466:fb74:1ec9 with SMTP id
 5614622812f47-467570ef685mr1573218b6e.4.1773408183890; 
 Fri, 13 Mar 2026 06:23:03 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:03 -0700 (PDT)
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
Subject: [PATCH v11 04/65] docs/dyndbg: update examples \012 to \n
Date: Fri, 13 Mar 2026 07:19:29 -0600
Message-ID: <20260313132103.2529746-5-jim.cromie@gmail.com>
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
index 095a63892257..4b14d9fd0300 100644
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
2.53.0

