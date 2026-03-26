Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5E210ED664
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0E110EDF2;
	Fri, 27 Mar 2026 12:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YjJVDNpF";
	dkim-atps=neutral
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5824A10EBB9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:13 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7d7d4ebccf7so1047033a34.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551312; x=1775156112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=COes0JAbo1d/mRlXxq1tSmCpD+ZApr8iQ8/8rv37VLw=;
 b=YjJVDNpFxC65rE4MOW8HuXzzV0RSZPKn+UF8SGHOPgX2JUbPFg6vOOy6LVv1L2RaCW
 fEefvUaVT6yuZPOrEL159P5m5NC3v358tZxKLNKJ0umporzwxWeTE8o49u4pR4iqFIcb
 D/MC+lhnnTCZal1Kk8a1AYkik3LzjACA3zwA4FGE8N2A2KCFhE3V2QF6wck9Zw/kUU7i
 1AhFxj51sd1NORbLiCw0DDNTmeDGY/liygdU6M8VLqmipIgOV055du/72VXWN7U19qkX
 w93fz6XVVQU6/PF3Tv+ZVd8Cf0FeImlbnAliKRbSJj63TuORbUTf2eqdLBLkUyAGcrK4
 0vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551312; x=1775156112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=COes0JAbo1d/mRlXxq1tSmCpD+ZApr8iQ8/8rv37VLw=;
 b=onsIshxnsVqhGcXwEFDt6LmpDPKL0MuSjHL4S9GpHbi93QZzkUgLrlZ5GczXI+z+6K
 rMa6AiifCKzd9eJBAm/5VTbL7IPPSBwpu4OwvVYn1OCBk+Bq3Zd11WnfmKHtiBPRMbK6
 NSca+4xZdoJom/fySsMIjcDA/Rt6XCeajC/SkU7jR+japHuaxv6Hc12QP4Fyx5bhyQ4I
 9GSTshLZtoDKimEXR5b3SvlDLn30OFEagbOQzm4IiDFF1eXPN3A3NIlGmvzY+oWoZkqi
 vAe/VxNG07Zkssb4yCIUh1NeETaHkowX3BcsbCabt9XI+gG15UPoQ/DcTazzBNi2qAWi
 bHQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6HJYvb2ga48lf6Ra4PK6X8+J+AGgR/XdzAUkp16r6mxIw38GUCrHn8Uu2S08Cs2THy/2u084W@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yydx1sGuyeVl428Wy/aA9s+KpC6GCuwCqtLt6k6z8u1RX5dr65d
 26hv8VtZfA7oa4YZ1kzwLPDZ8Ee0904ZpDOSxY1R5pVgw00PEi1k6hG3
X-Gm-Gg: ATEYQzxJ4Uxb7oMyCVe2TrEGYaXjVgVjv/dNhHxr2fdu7hnH6queVN8bKmumZ58vj/c
 LcjI8xNqmvze/eMts8XxW2nLPqkQJiVYUEEzw9hdraHptmLJERit95UQ+lRSb17MVo7RlytpHr/
 4J1QpkOOYBlq1AE4jcgppHLVeYTrMvS+IiNAvkmvijB1fyb2+IgEg/RUa00VSqKL7InMVblYMif
 m3ME1rBpxtAAqPVRsR7FF8/Ygda0hfukhyl1rN9sUoWOfDtpkPEzOzTMw/niWh8jZxsdVkjdlRU
 ad35gSX5mOm/bluwXqxHih60um/VSlEcZlSqTNhOYg3yuuIfpz5pLCkRfTIaKzRJx7oT2tC84G3
 t/LL/24H6ijRgdN4IeL2xRVwcqbmqOgQJoXh/b1yLim87If111CQaW2RtVL3ytKIW5f/MBTbbNz
 w/NUYak1LYJmvY8pYIdnF9Ro86bm/fF+cjXvHsYOyAOcIVinky
X-Received: by 2002:a05:6830:4392:b0:7d7:e792:b98e with SMTP id
 46e09a7af769-7d9d6617e9bmr4694632a34.8.1774551312358; 
 Thu, 26 Mar 2026 11:55:12 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:12 -0700 (PDT)
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
Subject: [PATCH v12 28/69] dyndbg-test: change do_prints testpoint to accept a
 loopct
Date: Thu, 26 Mar 2026 12:53:32 -0600
Message-ID: <20260326185413.1205870-29-jim.cromie@gmail.com>
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

echo 1000 > /sys/module/test_dynamic_debug/parameters/do_prints

This allows its use as a scriptable load generator, to generate
dynamic-prefix-emits for flag combinations vs undecorated messages.
This will make it easy to assess the cost of the prefixing.

Reading the ./do_prints node also prints messages (once).

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 5036fd58d7c6..756bbb7506ea 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -29,18 +29,25 @@
 
 #include <linux/module.h>
 
-/* re-gen output by reading or writing sysfs node: do_prints */
-
-static void do_prints(void); /* device under test */
+/* re-trigger debug output by reading or writing sysfs node: do_prints */
+static void do_prints(unsigned int); /* device under test */
 static int param_set_do_prints(const char *instr, const struct kernel_param *kp)
 {
-	do_prints();
+	int rc;
+	unsigned int ct;
+
+	rc = kstrtouint(instr, 0, &ct);
+	if (rc) {
+		pr_err("expecting numeric input, using 1 instead\n");
+		ct = 1;
+	}
+	do_prints(ct);
 	return 0;
 }
 static int param_get_do_prints(char *buffer, const struct kernel_param *kp)
 {
-	do_prints();
-	return scnprintf(buffer, PAGE_SIZE, "did do_prints\n");
+	do_prints(1);
+	return scnprintf(buffer, PAGE_SIZE, "did 1 do_prints\n");
 }
 static const struct kernel_param_ops param_ops_do_prints = {
 	.set = param_set_do_prints,
@@ -194,17 +201,20 @@ static void do_levels(void)
 	prdbg(V7);
 }
 
-static void do_prints(void)
+static void do_prints(unsigned int ct)
 {
-	pr_debug("do_prints:\n");
-	do_cats();
-	do_levels();
+	/* maybe clamp this */
+	pr_debug("do-prints %d times:\n", ct);
+	for (; ct; ct--) {
+		do_cats();
+		do_levels();
+	}
 }
 
 static int __init test_dynamic_debug_init(void)
 {
 	pr_debug("init start\n");
-	do_prints();
+	do_prints(1);
 	pr_debug("init done\n");
 	return 0;
 }
-- 
2.53.0

