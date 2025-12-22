Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251E3E6749E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 08:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35CC10E5BC;
	Mon, 22 Dec 2025 08:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hKLtnzj6";
	dkim-atps=neutral
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B62310E566
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 08:22:29 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id
 d2e1a72fcca58-7d26a7e5639so4230939b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 00:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766391748; x=1766996548; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7ftMB0O2RO6V6KEGBmyXf/qaI8CtnkfkNTYnuarQaQ=;
 b=hKLtnzj6qWyMUEvZ6n0Wha1kMlHHX8NKuPU8vc8FRKwL2LQSRQyKyks78b1aY0c8dr
 chQ55OikODbpoTWW8/nAHK16cENFU1MarSWDvCrKpserunbDfv4SZSAu5x+w67YMtweQ
 jmwrRZCXQcpN8+Caie5ianEJZkX/4tzsSEhQ30wPUuso3kj1fv91NYG/v4HdzJc96Tky
 qZbFs1N+24vqVc2nHe2unGyhpXtD711aXWKfwtFAtEjTd5YZCV35AefseMQr88pBnH6v
 oet93qmIkMiAMlcSDyqgY90pUcM8E4UFUfwTFgG9SeALcsXn6MZWwAYqPnM24IZjFvZl
 TVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766391748; x=1766996548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U7ftMB0O2RO6V6KEGBmyXf/qaI8CtnkfkNTYnuarQaQ=;
 b=kdwyZJKI8uXBhYXSSzFFMbYPbMby+s7/87xWybyKVopNYthxezExalTZNa1GJI1P7j
 NzwUDIMebIQPHF/nV+y6BKBu2Npu85jlTysflQai3PdvA9cuZ5frD09MTiXeo5KqbBKo
 nkNzCGKp9127ufWkS+hqKsPaa/3jBFTXgN5nZu1pvZWp7LIAcrP1IU4+w+1u+JucP9IN
 5A4pG6mHHvOUYq06+VUtE/WZZXSuBnqPk7ISi89mVQoucMDi1vpmD+a91LNhNDTbfhb/
 BU9U/ldJ1nyaVadz2LqhUvLWOcE5Tw7LvfTvuVypDY5LntNls/CAmGFNa+w7APgCk6L8
 RFjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKoAci0IG+6rbw4lXlR3B6cPAuOPJOZP0mM1jZOyBadHjRe+qa4gwDWKl87pt1Rlt8HKo3So/C@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZJNFs2InJFy7gGk5OGdkG4UI/e/l2EteXxgcCc/RK03H3lkGD
 C1vtEn/Jrka1P+J1YAoWB/wNNpZjuntXEZ5EPo+fXuO2ZBUyBjLIBGA0
X-Gm-Gg: AY/fxX5aDBsOKUewAQEa1+d1DuDhQI3irQ6suf4ygV66fyRefdCczsgnThCPHXIjQ50
 9rqp/VQLRNsmOuRLm82yvTr0KTAUXZ/hvt9WSomwtYDbXBRMJaD3I3UM2YPLPwFp+n0XVLJSp0c
 YRM1cLRpK1dqj6ikHAofcJ442wwraet6SCqWsxKQikOvJAJUqo0dFWgC1c94pwbeKAnpJZzbGL9
 Aem3hTNwpUGK/oKrLLWrUeunNCMJ26Do2S3/bwsm6oOXP8amkBlvGe8ZdN/dd6W/yFAAofk29AI
 SByWiFNrOPjtZQkiPGZGsnRdefx7GOlxd3iwif3TweFVkjKUspJCGk4oSCVPqPrk7pFS1h8IVd5
 28+q3FHsMtfuw6U23Lkl2o/hyzsxXmQyV3kZNUDYwExrX4sgDgHU66GdY3MEANUf6G/UxHPI3HH
 6yqxkUZg7Y
X-Google-Smtp-Source: AGHT+IFIaB8eWc1HtVa50QiWjAkChZ0TUx+nROmHgF5xveLYAYPTgHVZsZQQy8Wrx7bUcj5BQhCb5g==
X-Received: by 2002:a05:6a00:a24e:b0:7ab:63fe:d7d5 with SMTP id
 d2e1a72fcca58-7ff648ed939mr9692669b3a.20.1766391748333; 
 Mon, 22 Dec 2025 00:22:28 -0800 (PST)
Received: from frodo ([2404:4400:417e:3d00:8b90:7f55:1261:772f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e493123sm9540699b3a.50.2025.12.22.00.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:22:27 -0800 (PST)
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
Subject: [PATCH v7 06/31] dyndbg: reword "class unknown, " to "class:_UNKNOWN_"
Date: Mon, 22 Dec 2025 21:20:23 +1300
Message-ID: <20251222082049.1782440-7-jim.cromie@gmail.com>
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
index eb5146bcfaca..cb171088850c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1165,7 +1165,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 
-- 
2.52.0

