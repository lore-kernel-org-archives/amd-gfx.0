Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90321C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 02:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5AA01133DC;
	Thu, 14 Jul 2022 02:47:59 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736BF1133DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 02:47:57 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id j3so879954oif.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 19:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ReUqQP41hRJpW7GcN87sBXGhzZkqMnUsoH546sV6VKY=;
 b=SIX4vN8TPgX2BtBUspHbNB615cbnXSc1XZVLiq14jP9qconpJ3L3HoucMotgQep4kt
 zOrHq7+WPJWilJ51kChHNMPbwnCkQFlxwpfdq9qHCVkKkelCTWmRPb5y+GyJfy5x19W6
 u5YZ3YgoUvbDTS6FXZt29NZe/9pFhnooQL5oNuNYN6xShL2JucMs/AfaxIGeB7kVII5Y
 fBmR8DJRF31psmSReTFkeLerDnbX2hc3ih7vHpwU32Q8lp6eLa3jYkpoqN/bqYhWxswS
 HkV+qQexTxbeEJ7Lu7/WIkj1qj6nkjFV9cKD4KqLhptNNAPcwbSL7AuCFz3eBUTWBcm3
 +vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ReUqQP41hRJpW7GcN87sBXGhzZkqMnUsoH546sV6VKY=;
 b=1giZGUBKQVa3+YsMrGHhJ0FpK+xFxE1lgLbtqM5JYPMoCiM+XwtnFBhSCxtw//5NYP
 nSSYLLgwL8YoIpgpbZER6uAc23CWcnVzclVvy/mYSUc3E0VNHKc8WT0kCLm/yUCzCP3g
 hoDiaN5jatuk1SM8eb3bD7u0R76Wnyh9ei8zRXf2M57eov0q7w6h91IzT08+w5uSy58I
 eDyihzg95+YDTO2/3z2NKAPLUScxSQVp+6wsc4+FnjNMd/6Vmt3XDDQO0ULpOo4AEWTy
 tu5UguwB4ygJYTMCIuMzi5Rmv4NGlOyDGcLV2YrCTR5iqkLyxNKgjMkhJHBn33+fM3EN
 HKnw==
X-Gm-Message-State: AJIora8qhVrYJLqNt3pwrAAkCud/ylbZLja4DEMBTVlMczXOe2+UDD3P
 aoQSQVl3jrQ3q3uUlhCBZ6Y=
X-Google-Smtp-Source: AGRyM1vTFT9gmo60HSkT77N9LIRLzIAmipxyG8nJbqH1Qe/j4dfmURrSzzX2b1V0R9wf0D61dSWciQ==
X-Received: by 2002:aca:dad6:0:b0:32e:80bb:9c2 with SMTP id
 r205-20020acadad6000000b0032e80bb09c2mr6468084oig.106.1657766876163; 
 Wed, 13 Jul 2022 19:47:56 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a4aa78c000000b0035ef3da8387sm145781oom.4.2022.07.13.19.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jul 2022 19:47:55 -0700 (PDT)
From: Tales Aparecida <tales.aparecida@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] objtool: Fix truncated string warning
Date: Wed, 13 Jul 2022 23:47:47 -0300
Message-Id: <20220714024748.29696-2-tales.aparecida@gmail.com>
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

From: Sergei Trofimovich <slyich@gmail.com>

On GCC 12, the build fails due to a possible truncated string:

    check.c: In function 'validate_call':
    check.c:2865:58: error: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 9 [-Werror=format-truncation=]
     2865 |                 snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
          |                                                          ^~

In theory it's a valid bug:

    static char pvname[16];
    int idx;
    ...
    idx = (rel->addend / sizeof(void *));
    snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);

There are only 7 chars for %d while it could take up to 9, so the
printed "pv_ops[%d]" string could get truncated.

In reality the bug should never happen, because pv_ops only has ~80
entries, so 7 chars for the integer is more than enough.  Still, it's
worth fixing.  Bump the buffer size by 2 bytes to silence the warning.

[ jpoimboe: changed size to 19; massaged changelog ]

Fixes: db2b0c5d7b6f ("objtool: Support pv_opsindirect calls for noinstr")
Reported-by: Adam Borowski <kilobyte@angband.pl>
Reported-by: Martin Liška <mliska@suse.cz>
Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220120233748.2062559-1-slyich@gmail.com
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 21735829b860..750ef1c446c8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2823,7 +2823,7 @@ static inline bool func_uaccess_safe(struct symbol *func)
 
 static inline const char *call_dest_name(struct instruction *insn)
 {
-	static char pvname[16];
+	static char pvname[19];
 	struct reloc *rel;
 	int idx;
 
-- 
2.37.0

