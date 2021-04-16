Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8AAC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 16:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED0860238
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 16:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED0860238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3791F6EC80;
	Fri, 16 Apr 2021 16:57:29 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D92F66EC23
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:38:01 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id w18so32626385edc.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q9QkHlwJDar64oIul6Zxhmqo4CTxwCRZxxTfk+OGqes=;
 b=eY+BehDOCCwJrQBgJvFkrLf60qYGNjp86LQ95v4aL7ItluI4Kc1SOgueUMBeL7xVO0
 HabFWzx1pws/L5MRCFq5LUoT5qfUy3s5FD/uSxeZFuyHKY3170WEz1Csbb4fSPaBDIqN
 oRoIS2YwYhl3F0P/wmetAgGaxJNwr8QMpvE56Jxb1rGkseV0sHdrWs1gzTSOL2x1NJS0
 Vj80LYVwo8lXzAojSa+aNSIeTjnQWOA9oP0WJp53MrM0/1L47DLNnl/6xm51fQAC1llu
 FYuAOZoo41nr91MY3qLkcrnWrr3xBTW/WLIuUjkwS7wdSBtV0LoR2GWHCg5gPjz2JP4q
 OdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q9QkHlwJDar64oIul6Zxhmqo4CTxwCRZxxTfk+OGqes=;
 b=i4N46QmnDD/0ERXFnNUu6H1PgvpgoQD1h3Kc2RLH9pIdLVn3eB7qFtI/hf18SSGNwH
 pTWWoVfDlyYJebEnFB9Sw+4T0fjXC0b/96uNOmma1cG75Ff/j+2KHnpak2/+OqgxVnzO
 uqG1fVq1uRbfexP5L6t3KLzLUDAbk8B4TCAX8kmhZ4xzUM+4eoua9TCw8jqwoNqL3IMW
 ZoH0sCjNZo63t5AWM/tOkiWHANPdwrn2NUxIjd5DAtctWEGadRcHo4vWEs42lbD4NuyR
 B1/7M16DMpM04xq27I9vJM/GoMt6Zfvl8O1nxwtPcu95K7xPvtm+UXlwN0cwC8G+qGgZ
 vudQ==
X-Gm-Message-State: AOAM531oYqDBL5aZUuM4YEyIfYcQpYvRMMwYOm9kkVWCDcW80bPEt9XT
 3oOBLwk+wr0FtpF6WcLJtzO8yA==
X-Google-Smtp-Source: ABdhPJyfwppiWNh6UNq5J0oc3JQa61CxtXjxBSY55rvdOBADEXG3x0lLiRIZS3Wa6Jra3UH/lva7pA==
X-Received: by 2002:a05:6402:cb3:: with SMTP id
 cn19mr2427916edb.206.1618583880589; 
 Fri, 16 Apr 2021 07:38:00 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 07:38:00 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 29/40] drm/amd/amdgpu/amdgpu_fence: Provide description for
 'sched_score'
Date: Fri, 16 Apr 2021 15:37:14 +0100
Message-Id: <20210416143725.2769053-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 16 Apr 2021 16:57:23 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, Jerome Glisse <glisse@freedesktop.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmM6NDQ0OiB3YXJuaW5nOiBGdW5jdGlv
biBwYXJhbWV0ZXIgb3IgbWVtYmVyICdzY2hlZF9zY29yZScgbm90IGRlc2NyaWJlZCBpbiAnYW1k
Z3B1X2ZlbmNlX2RyaXZlcl9pbml0X3JpbmcnCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwg
VmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBs
aW5hcm8ub3JnPgpDYzogSmVyb21lIEdsaXNzZSA8Z2xpc3NlQGZyZWVkZXNrdG9wLm9yZz4KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1z
aWdAbGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0Bs
aW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5j
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCmluZGV4IDQ3ZWE0Njg1OTYxODQuLjMwNzcyNjA4ZWFj
NmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCkBAIC00MzQs
NiArNDM0LDcgQEAgaW50IGFtZGdwdV9mZW5jZV9kcml2ZXJfc3RhcnRfcmluZyhzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcsCiAgKgogICogQHJpbmc6IHJpbmcgdG8gaW5pdCB0aGUgZmVuY2UgZHJp
dmVyIG9uCiAgKiBAbnVtX2h3X3N1Ym1pc3Npb246IG51bWJlciBvZiBlbnRyaWVzIG9uIHRoZSBo
YXJkd2FyZSBxdWV1ZQorICogQHNjaGVkX3Njb3JlOiBvcHRpb25hbCBzY29yZSBhdG9taWMgc2hh
cmVkIHdpdGggb3RoZXIgc2NoZWR1bGVycwogICoKICAqIEluaXQgdGhlIGZlbmNlIGRyaXZlciBm
b3IgdGhlIHJlcXVlc3RlZCByaW5nIChhbGwgYXNpY3MpLgogICogSGVscGVyIGZ1bmN0aW9uIGZv
ciBhbWRncHVfZmVuY2VfZHJpdmVyX2luaXQoKS4KLS0gCjIuMjcuMAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
