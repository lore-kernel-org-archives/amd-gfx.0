Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA127107BCCC
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFFA10EC55;
	Fri, 13 Mar 2026 16:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nd/Pq6GT";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F0B010EBF8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:10 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-46704177508so1465015b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408189; x=1774012989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0sBYQSvT/W3L1mc7F8xF1oVUSz9OX/m/AEikTG2UrU=;
 b=nd/Pq6GT3nGpTT+SwcRtjUEdQPnAKTWNE/CT6RIuMu974vq71a2L+kutdFp51duJaI
 ew2wY7xP83poJz+C2RAo1aQNVIaRZifelsnced5HP7ZmTWxVmln6S/qE1SeDZeHPiina
 /pybKCTDVCV9HmTeqp0IA4wy1Xxuizzb3C+Eo3VUDTcxfW8ReddsXeiBdiaj606ohT6y
 bBTxKmAJKpgP0Gj52vj4xZxwgtaMTH3R7RtZXDWNxWQ8YdjiT9DzwDpVxyIOEt4LlNwd
 YuZiU55aaIIhxaSCOdiP7aWWI7vdIkfaiuSopAjzOaGFJ0mNNZGAJPLOUTjTG7UzqL3c
 6QCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408189; x=1774012989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q0sBYQSvT/W3L1mc7F8xF1oVUSz9OX/m/AEikTG2UrU=;
 b=iZA7fBmxkRs8D3g/sA6fxf8s4sC+WM78AP3/8I0YyzoIKw4XUA23V1flIUQyYCL5sg
 /A0YNkg0iTBHYdBD+maN/4xrLYxuG/YObnhomHD2y4ZCiLHhc49tWMWKAYPDXi2zfL9f
 8UZidou/1h6x7F3a9OdBznTBxBoa8eM57KCXW2YgDMjodT6+4+bx56OWevjlUZsEk0Od
 gxicryJ1Vv1tk+brv6i+yr9a+A/CH+jT6HiqoNx7GclcW7KdupBbU9Y0oLM7PgOQRksM
 pqhZFzAwEvG+SlheT/fG5Q4T6HHF/ZznXMNHM26OLtGLSO2gsnRTV0LJcO13hbOA9RJn
 2TnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqjBxzmHC8/1ehAIw8iVf2KTFBHFGfS/KL7ZJYToNLk+CpAavhV+OsSoqcpeMD+0cpW4XHtuwU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyG2KiIi+G7iqx5Ux5iroOWWUrZE3KvZ15uJYI4zsnSJNPHZYsW
 3wqIl0b3p5yil8BEGW6NrALVqjVllbZ4GZCvFWkPsOzGEK1AahqhyTjt
X-Gm-Gg: ATEYQzx3da31uUftkiQ63wbtSfIv/m5XRYKfNw2MbFaN6DvLOp9QBQHi3m6mXRVSgr7
 vu3sx7l1mNzwL/o3tBqiJiE2Ij708o+bLkoBfRZa4dJcbJOsBmnG6C42rQc+bfmlS6mHKRekuaK
 CsWUJwURwuBISgOmxdhh95v9etKlqCcrM7+UCKhOTgT0azMZUXC29TuZFY2N5h2+JfUUAoPsg1P
 Fb8NJqIPpV5ZpCSDsHcF45ICC4tJtqcmY7Prqm3xdtY0ijEeHeecBEkCEp7oG2VJRdIeEwYmyLH
 PqWW3WXedPImE4ApMjI9eDAjqbAYrkuUAGyHIZy5wnRPYs3edSRM85t02gGiPRFy+fKrvyoPUAm
 mREgl26zkkyT8H77NMghhBvle0kiQj5R/6zCZFYksuN6ItDhFDhm9xgyLyhPVvHAnncyTypHd0h
 AwVUXR9QOHdVb9UvfRLjuWF30pYPNo5kNQTgH1J8RAXPADOhAOdXBERI/NmQI=
X-Received: by 2002:a05:6808:4f49:b0:467:1941:1f18 with SMTP id
 5614622812f47-4675715ea52mr1607049b6e.14.1773408189500; 
 Fri, 13 Mar 2026 06:23:09 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 07/65] dyndbg: reword "class unknown,
 " to "class:_UNKNOWN_"
Date: Fri, 13 Mar 2026 07:19:32 -0600
Message-ID: <20260313132103.2529746-8-jim.cromie@gmail.com>
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

