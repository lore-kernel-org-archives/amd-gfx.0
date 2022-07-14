Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B41DC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 02:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2710011A9B2;
	Thu, 14 Jul 2022 02:48:01 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E130D11A8C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 02:47:59 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-10bd4812c29so891123fac.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 19:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ea4IZlyrjSvU0YdpTpT64+A0BD/twd5LiqN1oRGuBK0=;
 b=d+7RVYXqsEq+OuD2wpe5BeC4ix6+wTfMIkfPMtGlVdMc8k5meUuR5PV9TZc8i2zzD6
 04LOJJuYpY8mjqWzblLo2y7KJfEVigGLMToQoRqRunOS4iruUwJkkF+VqACnKLreQ788
 lXFzVNoezKHsm0LV4ljMnmgWnXp9JfOJaAN40hCSX2plI85fuw0BAQ0B+iPd/ZEXSFhP
 UBFivS7B5bPlUBn02uZIqy/GIg+o8XgazGR2cfJVkp2oaTokmkiSylMju2xATwIfGDbs
 H5ILHxHhzNLc9I3LsUgbi3/n6oP2PGIzDo2LMZPT750fyWShVFQyx51zqUbI2M14/sLW
 mfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ea4IZlyrjSvU0YdpTpT64+A0BD/twd5LiqN1oRGuBK0=;
 b=Y76MGsCEEHRnBtTJNKT8iFLadWBTg81LbPz8mqLxFz9BLyhKsZBJM3UKM6/ZmsI45A
 +6jdFG46GODSVzdiqb/LfZQ+maHgYZbATVTrjXJWZOyJsS6T7eC/ybeb+Pj92uqkg3dZ
 bl6bfDbW5gTWxDTS9j0or2rcYCnMNUGkg5LI7/fCUf5IpnsGJ54SVauNP50BvPJ3mP2v
 OSkoe6lLu73tNOiwo51snq7UfT097OIArIRFIdJVXhru/0gb7K0z1jPohBpAfSO0SeHW
 aR9JAkcc4ctUoboydEN14ZW+yWtzXanM7uZ8ncP3pYWhVqAJ/MELa3pI/TQRl2lB5a8s
 cplQ==
X-Gm-Message-State: AJIora9o5p1fAM7Piu++QXzgorn8NFyE0i9Qnxl2BnHSlfQiywClV2Rw
 4FiLdQu97bgFjkaYHWSTJaQ=
X-Google-Smtp-Source: AGRyM1tM5mZYQrf2ZSK7p68gxwUEEGffUmvOooVyLm5GCHxqfptxwjKkGC2qqT/ET8LcYbJnNsNggA==
X-Received: by 2002:a05:6870:73c7:b0:10c:24de:63d4 with SMTP id
 a7-20020a05687073c700b0010c24de63d4mr3447162oan.76.1657766879001; 
 Wed, 13 Jul 2022 19:47:59 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a4aa78c000000b0035ef3da8387sm145781oom.4.2022.07.13.19.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jul 2022 19:47:58 -0700 (PDT)
From: Tales Aparecida <tales.aparecida@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] libsubcmd: Fix use-after-free for realloc(..., 0)
Date: Wed, 13 Jul 2022 23:47:48 -0300
Message-Id: <20220714024748.29696-3-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220714024748.29696-1-tales.aparecida@gmail.com>
References: <20220714024748.29696-1-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: siqueirajordao@riseup.net, magalilemes00@gmail.com,
 tales.aparecida@gmail.com, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 mairacanal@riseup.net, Isabella Basso <isabbasso@riseup.net>,
 andrealmeid@riseup.net, Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kees Cook <keescook@chromium.org>

GCC 12 correctly reports a potential use-after-free condition in the
xrealloc helper. Fix the warning by avoiding an implicit "free(ptr)"
when size == 0:

In file included from help.c:12:
In function 'xrealloc',
    inlined from 'add_cmdname' at help.c:24:2: subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
   56 |                 ret = realloc(ptr, size);
      |                       ^~~~~~~~~~~~~~~~~~
subcmd-util.h:52:21: note: call to 'realloc' here
   52 |         void *ret = realloc(ptr, size);
      |                     ^~~~~~~~~~~~~~~~~~
subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
   58 |                         ret = realloc(ptr, 1);
      |                               ^~~~~~~~~~~~~~~
subcmd-util.h:52:21: note: call to 'realloc' here
   52 |         void *ret = realloc(ptr, size);
      |                     ^~~~~~~~~~~~~~~~~~

Fixes: 2f4ce5ec1d447beb ("perf tools: Finalize subcmd independence")
Reported-by: Valdis Klētnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Kees Kook <keescook@chromium.org>
Tested-by: Valdis Klētnieks <valdis.kletnieks@vt.edu>
Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-hardening@vger.kernel.org
Cc: Valdis Klētnieks <valdis.kletnieks@vt.edu>
Link: http://lore.kernel.org/lkml/20220213182443.4037039-1-keescook@chromium.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/subcmd-util.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/lib/subcmd/subcmd-util.h b/tools/lib/subcmd/subcmd-util.h
index 794a375dad36..b2aec04fce8f 100644
--- a/tools/lib/subcmd/subcmd-util.h
+++ b/tools/lib/subcmd/subcmd-util.h
@@ -50,15 +50,8 @@ static NORETURN inline void die(const char *err, ...)
 static inline void *xrealloc(void *ptr, size_t size)
 {
 	void *ret = realloc(ptr, size);
-	if (!ret && !size)
-		ret = realloc(ptr, 1);
-	if (!ret) {
-		ret = realloc(ptr, size);
-		if (!ret && !size)
-			ret = realloc(ptr, 1);
-		if (!ret)
-			die("Out of memory, realloc failed");
-	}
+	if (!ret)
+		die("Out of memory, realloc failed");
 	return ret;
 }
 
-- 
2.37.0

