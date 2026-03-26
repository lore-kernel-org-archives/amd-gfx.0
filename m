Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0D310ED675
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C633210EE19;
	Fri, 27 Mar 2026 12:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k2rJ5HDF";
	dkim-atps=neutral
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE0F510EB8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:45 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-4042905015cso814083fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551285; x=1775156085; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0sBYQSvT/W3L1mc7F8xF1oVUSz9OX/m/AEikTG2UrU=;
 b=k2rJ5HDF1ha7PEtUWfC5Z8ZonvFK8KviMkOUsanftQekjClC9Dc6NUiftoY+Ei+BqK
 GvqEZTLwwglzDPGhVxvPM8x8dDCDRzGEbW/4h7xbp5oukTd96MaxzJD/xDyJNc2hJZDN
 B5ITDp/xrPoc77yLljW9UkgVl2GyCj5oOgJ9v+pdX3FbNposuIx4KvpXKGMhlU8UhlxZ
 EMxvI1abDiLlJBFy0W1jFDSMTSpvKr4aQCDOGYgo+z7C29yXpb0LAMt4IS/zvjzKu5Lc
 evccn8Q0uArQFHzSAgc8p5DeNhq7PzYzfYgrAwqcUqmEqjfN9uq34RGuIvQ1xx6VIFpN
 Wysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551285; x=1775156085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q0sBYQSvT/W3L1mc7F8xF1oVUSz9OX/m/AEikTG2UrU=;
 b=K+RCbbhkSFau9REwQxj2qJx8d1kNopU3qBWAHxtIn7Qi8LKhSwfDzWwG8buOLufYZC
 fr1qp64myQCGsIsIjVO9TrYEoHKu3C25+YgdhfOGYNU3iEh5nhzPzmCNqMSrGgjbWlJR
 jh0nvHSH6a30RwbG8uSqv3drMCZefraVT064AaaUekX58zs3s3aILuQFCmL/Uwxd6Q2w
 ssKx2NezcegE5QZCZafnIlfSlPeyGMsUzNMAgsNO8HkElqihAubRMIAcBW/2kekH6uu1
 C8rm6GMuMwImtOKyK0bXaFN/LVMaDGEhyO6LKeU5Mxb6hAvuomgOf+O3tiLFBY8phT4V
 89xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT2seYmksg15A7CaK0PSCm4+ExHauPH7c9uupuCoDxoodjR1/lalss7GqNJHJHIGn9M2Zgnlq0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzH/DbTVAKRad0tb/NpCZv6nDleXr7am4E7U7U9gRL1XqWV0o5
 pUnA0e0LoRCefSOghqZ0mn8uttzlTq+4nabUxGfVd8GEUM4BUmte2tQZ
X-Gm-Gg: ATEYQzy/u2ZL7wTvTuGGxCnHCwOSQ9yERoAsl3XMgJYdYLbGAlbne/98mNWu2JdAtye
 fbBqXYTWq49mGYDSKQ/nSZi+QJPUI5qP53iso81tHrB1cMIBChaPbtI8D6PB2xDnjaLSWh6Io1r
 wwTX9yUUQM0GxPyeEdraLnmTFsB6xapxB3fj9dMMJXyDKvPmowHildEvLDj8bw8YohieTFi1Wmm
 8MzycmDbnHkq6BqN38WOKGPXEuzaD7/wdz/AANffULlFDqBkpaJ9allb4wVG57etlfpIgUhrGi0
 yaT229KWU+x9anB/mUz+crLcytc9+4rTZQjhn2TFCzy/bO+6yTccuD9GdFBumsZpK5+pr1sx72u
 D6qSgbv1tzp+RIhgBeCoa2WAIff7Jah0pnGMSUYu+PilwUc+AcLOFWfy/lbNuJtXRMmF4Mz5EKf
 3VueT+2BW1TRKshX6kEgjNe5jqnNHrTGhr/TvmSIqxDwGC5LWeOJQ82TyZfsg=
X-Received: by 2002:a05:6870:20c:b0:417:2156:ffea with SMTP id
 586e51a60fabf-41ca6fcb4f3mr4549318fac.13.1774551284964; 
 Thu, 26 Mar 2026 11:54:44 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:44 -0700 (PDT)
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
Subject: [PATCH v12 10/69] dyndbg: reword "class unknown,
 " to "class:_UNKNOWN_"
Date: Thu, 26 Mar 2026 12:53:14 -0600
Message-ID: <20260326185413.1205870-11-jim.cromie@gmail.com>
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

When a dyndbg classname is unknown to a kernel module (as before
previous patch), the callsite is un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6b1e983cfedc..a9caf84ddb22 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1166,7 +1166,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 
-- 
2.53.0

