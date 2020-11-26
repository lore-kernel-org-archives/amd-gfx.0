Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD42C64E7B
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28CF520674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEVwjuFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CF520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85356EC00;
	Fri, 27 Nov 2020 10:14:49 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52E306E958
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:43 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id p22so2196249wmg.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zLqbaHF4oQ5Kpx8U3OblV0PJbsOkOQQuGTnjvNzXmds=;
 b=zEVwjuFPYeI2CWymPGhLbmOeKMvU5W3/wdholUcUe5f/F7/8WIFuy6M4mCe2yTvJnf
 pBRES8hLWfSY4jRjS/Md271YTIjdVoLHGh+8kdCF9wNzy3YXwC+HOAfM3nibIIdNfowt
 i1TVSkH6uoteGEpwYjcBNUzX+ypeYJFKJsoLmaHNK9p5XgVq9YNMUv/1sxtKLLNokI4N
 WT4nfVAmbqBpmgp5DoptVNYdwvr3XqjgwDXKR8Vr0Y7zTdZBDzO8E4eL9iCyIsXjkQ/+
 AacXFu31oboKBxp6l7xi9WFI+noLXhM6aoe0OJrYzxVqCbccmnQ28laoCs8P71Ehozuk
 xvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zLqbaHF4oQ5Kpx8U3OblV0PJbsOkOQQuGTnjvNzXmds=;
 b=BM4Zz2gGVWIAyLrom+JY4NSRDG7/0/UTah5sQDLjwvHMq1o2eV9CU9EEaY5Se477/a
 4RkeYgySX78IOuKv0RY+5Y0PddRLu1PEDWk+YOEv0N6lvFzvxEIHWaQVTmzh/MMOGolF
 AIDGfihLZeofQLH8soThpZUb3zWl7SkbIV8KMMHrgbxS4phIz6PgTogs/+1yNeALsDva
 PmYrtAWd32QNDKqhnGf3eSxlIY485wlykETLsgLwDf4ND3npoBsWa0uEQQ3sJfo03EwB
 mNG6J7DTo1S3ZbjP75VMk8KREUeBDKctQB/TuddEe5JwvtrOQontyi/xvBGqca0wJLmA
 0SuA==
X-Gm-Message-State: AOAM5323t6+ocvbxr4mqBpoV0JoEei/lVu2pQZTn55PrKyUSt4bqVZfu
 mqiuU23VXfAPMrZpA+283fta5Q==
X-Google-Smtp-Source: ABdhPJxmBjpBm7+d3exEEq0cH0WG4UWwwz1Febmm2eAsCGEAZgFo/aK9XZK0D10TkghDYILLIkq8XA==
X-Received: by 2002:a1c:808d:: with SMTP id b135mr3423753wmd.45.1606398221973; 
 Thu, 26 Nov 2020 05:43:41 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:41 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 39/40] drm/amd/display/dc/basics/fixpt31_32: Remove unused
 variable 'dc_fixpt_pi'
Date: Thu, 26 Nov 2020 13:42:39 +0000
Message-Id: <20201126134240.3214176-40-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iYXNpY3MvZml4cHQzMV8zMi5jOjI5
OjMyOiB3YXJuaW5nOiDigJhkY19maXhwdF9waeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1
bnVzZWQtY29uc3QtdmFyaWFibGU9XQoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFu
ZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5p
ZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IExlZSBKb25lcyA8bGVl
LmpvbmVzQGxpbmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzog
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMg
PGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9iYXNpY3MvZml4cHQzMV8zMi5jIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iYXNpY3MvZml4
cHQzMV8zMi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jhc2ljcy9maXhwdDMx
XzMyLmMKaW5kZXggNTlmMzc1NjM3MDRhZC4uMTcyNmJkZjg5YmFlOCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jhc2ljcy9maXhwdDMxXzMyLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jhc2ljcy9maXhwdDMxXzMyLmMKQEAgLTI2LDcg
KzI2LDYgQEAKICNpbmNsdWRlICJkbV9zZXJ2aWNlcy5oIgogI2luY2x1ZGUgImluY2x1ZGUvZml4
ZWQzMV8zMi5oIgogCi1zdGF0aWMgY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNfZml4cHRfcGkg
PSB7IDEzNDkzMDM3NzA1TEwgfTsKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZml4ZWQzMV8zMiBkY19m
aXhwdF90d29fcGkgPSB7IDI2OTg2MDc1NDA5TEwgfTsKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZml4
ZWQzMV8zMiBkY19maXhwdF9sbjIgPSB7IDI5NzcwNDQ0NzFMTCB9Owogc3RhdGljIGNvbnN0IHN0
cnVjdCBmaXhlZDMxXzMyIGRjX2ZpeHB0X2xuMl9kaXZfMiA9IHsgMTQ4ODUyMjIzNkxMIH07Ci0t
IAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
