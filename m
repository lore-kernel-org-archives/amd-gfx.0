Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF57C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 16:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD02E6112E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 16:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD02E6112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BE926E98C;
	Wed, 15 Sep 2021 16:40:32 +0000 (UTC)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8596E98C;
 Wed, 15 Sep 2021 16:40:31 +0000 (UTC)
Received: by mail-il1-x12a.google.com with SMTP id w1so3628973ilv.1;
 Wed, 15 Sep 2021 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wKV+lnWpUuZH5SUW1lKdicYs9iS1/HR/b6CwzZGnc9c=;
 b=S9I+VL+60lvXHiO1v3wKQjh2TLgFoU2zIMfzmpRCanTOXm0N805LWXpU8PnOp9+jBj
 YRCXjIVfoFkZ0qnzooWi4jakjLgWMbAhWAGnHoggpwQ+cbUtEdpNW92p7uTS6p17DZvH
 N/vmiOTIXtvaMLaIBIMoDS0HFQzImkKIDtAaEy2Eiacl3SS/Y0777LgQwBUaup2DuSa8
 IsPKTtGe5qWSyD7QwLAOsd60/KMq0v8ig3ixgX4L7G1sbcngNYtVDt4l6AWqxEb10axD
 u+Tiv4xEKG8II9Rt70IxMS3jnRfWXoL9qtIUaQh0lex3l7c6thr6oFOVWitknzptZEi2
 +DLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wKV+lnWpUuZH5SUW1lKdicYs9iS1/HR/b6CwzZGnc9c=;
 b=n4jbGnNF3L+ai5/DjXeEO6R8/hY87QCQvSOrd6omoVB0SUTmO/jhvl0SuvrkoN4hTF
 K85i6jADtkpq2yczAJ4Df5GNhTJ248Pl5jWUww0gwjzCkcHP5Cdci9w4Nmh6xq6H57YB
 d7vuj0UouWxlaSkN7qhgHbrUgB+GduPWPvc3toT+lnkEKqWMW3gWOiMNOaLOtk2LZj9X
 vTxvrTznVCQ7HqDYdC0d9cZaQ4V8tQ8xEZBCvSZrY3lfSwYRi19WBW8M5v4YCtQrP7SU
 Ot3ikGeW0NaFIpAt/ylvtheUDZcwDSXuNcTaEbXiM2RC9SQwOdYaD6Nrok9SlEIbRltp
 WjKQ==
X-Gm-Message-State: AOAM531l33KUebunIX0/1c0DXr5mkEKMSnVMN207kLFLKVIHMZpza9qj
 TVZuv34GWMYPSvvE9mtbsr0=
X-Google-Smtp-Source: ABdhPJzFjY9IDEO5W7WNqwgctTlwlHwbvpjLICXGhOw3Qy7mcpDmGs/yUuIDeGAG/TErArDsOWTdTA==
X-Received: by 2002:a05:6e02:5a3:: with SMTP id
 k3mr688180ils.283.1631724030459; 
 Wed, 15 Sep 2021 09:40:30 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
 by smtp.googlemail.com with ESMTPSA id a5sm299540ilf.27.2021.09.15.09.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 09:40:29 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel@ffwll.ch
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 02/16] dyndbg: pr-info in boot-param should say so
Date: Wed, 15 Sep 2021 10:39:43 -0600
Message-Id: <20210915163957.2949166-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915163957.2949166-1-jim.cromie@gmail.com>
References: <20210915163957.2949166-1-jim.cromie@gmail.com>
MIME-Version: 1.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add "bootparam" to format. no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dfe1e6a857bc..da91ff507117 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -998,7 +998,7 @@ static int ddebug_dyndbg_param_cb(char *param, char *val,
 static int ddebug_dyndbg_boot_param_cb(char *param, char *val,
 				const char *unused, void *arg)
 {
-	vpr_info("%s=\"%s\"\n", param, val);
+	vpr_info("bootparam %s=\"%s\"\n", param, val);
 	return ddebug_dyndbg_param_cb(param, val, NULL, 0);
 }
 
-- 
2.31.1

