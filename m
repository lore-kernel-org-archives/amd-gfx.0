Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07433F0181F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 08:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D6A010ECA5;
	Fri,  6 Mar 2026 08:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fp7i4V/e";
	dkim-atps=neutral
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 664EF10E2F0
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 01:51:13 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7d18d0e6d71so6417932a34.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2026 17:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772761870; x=1773366670; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBdiOYK9OqacwkN82GElrUr530ZKa03hWcr3nX6dVyA=;
 b=Fp7i4V/eOX6IhHuA14XXtTanknN8Y76o3kmMhbZUtog+mOGMjYrexwuiYKbkDcxUi9
 vQScxp9MaE0s19345coQM4gxHl+ChvaIyrUiWnseqZHITdzUDw3qQSghJrKCOZEK/1KA
 zgc5fBUYrHRkx6Ar5X74y09cS2d+FUqtWc84NGVMJYInqWq37fU29dVWlfjspv4cFBsU
 GdWu/08/EiN+uvJdYei5qmpZMYBg78OKv4Tv5x9QdoHgWHPEgxIJqPO7VEhynj9fkfTJ
 YGj8A2umI7k5jrX6PQmPVED7D6LNhuj6lzYiotj65un3MBTCAkOnMFd4WVvpImrw57mn
 TM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772761870; x=1773366670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LBdiOYK9OqacwkN82GElrUr530ZKa03hWcr3nX6dVyA=;
 b=WCH9GKOJTTiBSLv9uwbq/oxNseQ43DO0TUFjvTIxhODVJsbuZxI06gbAQXtuHHAJuI
 3AqKHmLHp/6EWttU1jHaInpHe7rWR90YhBgO1Q0Z7kbh67fF59OZ+4lo26WGi626a29h
 eLX3W50ydWR5WyW4Ja2rN8KcE6vKFtN2ssI6P858kRhOznCe7/+1JJW1UYpDvnm8LQwg
 f+iS5WfKJMoifOwbenBl94PllwfOLB4LuVmP3/uB2Puqf7lIqMuAnLwHS/383mwdXBmM
 XEK9raXBiuLldV6YKlQi6Spa4a4HZFPUqwb/yNOA8XpQUGJ3yctmrv13IGYdj4FpmKnv
 JIbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtNwNNw0zYrwt5NdFno1BfAJ4mosyiBF22Hc2l6XCSkkF5facPnyhkhehFf7xEJFhOQIIvSYo+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydmLlsAKn0fLZRuCaxxVH1CvGAO3gLPGE7DhFfJrWPHW1iwvAG
 TJThYA9ulJyK0gVPD55M2JhDBIFXF4n5P1waVl2eFWXr7iF1wTVNukmk
X-Gm-Gg: ATEYQzwLvAO98/1iE0Q9UrpLcrLhNNHdSWlMG2lxs9kni2elB+cp8OQ8WMIeXltxXNu
 hWhpDPsuAwioveVrTlFLYYXcYv2efayiTo3jxX+hI+cOZgPPwAq4Xi5RESZbFJ0S9ScdyoapwOH
 o7tgF8uSh5ihNZPGftEqrMEUMTfv2WKj3tnrI8TqcIthGAo18e58qe93850NAe9jmpvAwqTYnh2
 X7tK7A6zF480kNCl0eFJXIAJw2vkDQowQFzUsXMsWau+aS6HnNz0fAQMdTgxbWrXpBDDz2SFozQ
 ByQ0fuQoq/1hDjX7tPwGMsC2n1tXqBzKiY1j5kg9Gr3CdtpO0taAwCcOx8wURdPLPSTV9JAuv9c
 Y2oQDNB1GBJ63nevVCie2TaFfVfFYSTL42w9zX6n3PxEQD3beLt+po8SPNl/WKEYaRwNmBvirDl
 ohI4p/RiIAbSsQokiD/O07klcl+TOBATB6bO0qP1KrumG7TZwl
X-Received: by 2002:a05:6820:198e:b0:672:fec8:e61 with SMTP id
 006d021491bc7-67b9bcc0fabmr433464eaf.32.1772761870142; 
 Thu, 05 Mar 2026 17:51:10 -0800 (PST)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 006d021491bc7-67b9cc1a627sm115245eaf.6.2026.03.05.17.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 17:51:09 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: Jim Cromie <jim.cromie@gmail.com>, Jason Baron <jbaron@akamai.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 4/7] dyndbg: use static-key queueing API in dynamic-debug
Date: Thu,  5 Mar 2026 18:50:07 -0700
Message-ID: <20260306015022.1940986-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306015022.1940986-1-jim.cromie@gmail.com>
References: <20260306015022.1940986-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Mar 2026 08:52:54 +0000
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

Use the new static-key queueing API in dynamic-debug

function _get_cal_count() {
    # Sum all CPU columns for the 'CAL' (Function call interrupts) line
    grep CAL /proc/interrupts | awk '{ sum=0; for(i=2; i<NF-2; i++) sum+=$i; print sum }'
}
function ddcmdq () {
    local cal_before=$(_get_cal_count)
    echo $* > /proc/dynamic_debug/control
    local cal_after=$(_get_cal_count)
    printf "Delta-CAL (IPI): %d\n" "$((cal_after - cal_before))"
}

Before:

  #> ddcmdq +p
  #> ddcmdq -p
  ...
  [   37.165860] virtqueue callback for 000000009e760656 (00000000011de1b1)
  [   37.165952] virtiofs virtio0: virtio_fs_vq_done requests.0
  [   37.166119] dyndbg: query 0: "-p" mod:*
  Delta-CAL (IPI): 16154

After:
  ...
  [   32.189131] dyndbg: batch desc: ffffffff89468028, static_key addr ffffffff89468050 (fbcon_startup:1032)
  [   32.189225] dyndbg: batch desc: ffffffff89468060, static_key addr ffffffff89468088 (acpi_table_parse_entries_array:264)
  [   32.189332] dyndbg: batch desc: ffffffff89468098, static_key addr ffffffff894680c0 (acpi_table_print_madt_entry:229)
  Delta-CAL (IPI): 134

Extra context:

  #> wc /proc/dynamic_debug/control
  1903 15092 185427 /proc/dynamic_debug/control
  #> ddgrep dynamic_debug
  lib/dynamic_debug.c:386 [dynamic_debug]ddebug_change =_ "batch desc: %px, static_key addr %px (%s:%d)\n"
  lib/dynamic_debug.c:397 [dynamic_debug]ddebug_change =_ "applied queued updates to %d sites in total\n"
  #> dmesg | grep queued
  [   26.837520] dyndbg: applied queued updates to 1902 sites in total
  [   26.837631] applying 1866 queued jump_labels

The baseline has the 2 ratelimited patches cherry-picked in, so both
of these numbers include whatever overhead is caused by virtio and
dynamic-debugs pr_debug()s.

Cc: Jason Baron <jbaron@akamai.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index aa16782bc93b..e555a8dbdc27 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -371,10 +371,12 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 #ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
 				if (!(newflags & _DPRINTK_FLAGS_PRINT))
-					static_branch_disable(&dp->key.dd_key_true);
+					static_branch_disable_queued(&dp->key.dd_key_true);
 			} else if (newflags & _DPRINTK_FLAGS_PRINT) {
-				static_branch_enable(&dp->key.dd_key_true);
+				static_branch_enable_queued(&dp->key.dd_key_true);
 			}
+			pr_debug("batch desc: %px, static_key addr %px (%s:%d)\n",
+				 dp, &dp->key.dd_key_true, dp->function, dp->lineno);
 #endif
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
@@ -384,6 +386,8 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 			dp->flags = newflags;
 		}
 	}
+	pr_debug("applied queued updates to %d sites in total\n", nfound);
+	static_key_apply_queued();
 	mutex_unlock(&ddebug_lock);
 
 	return nfound;
-- 
2.53.0

