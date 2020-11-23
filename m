Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA621C2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B40220702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x43XL5Sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B40220702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB3089F5F;
	Mon, 23 Nov 2020 13:58:03 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E58689D8A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:19:54 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id t4so5262146wrr.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GNPMH7+BshXFtHvJRFR/Pz67utL4+c2zXgvOMeOYi1w=;
 b=x43XL5SjSI8fFhB+JucQYDS6mMeFgr//tbZ0jm1MCQ9P0QBt6aEmfPzxG6yD50eqQd
 NMHzrMMk4AgiHPrCgw9MpvOFhdCWMwZYGoD0lFKSesvOzp88G8aRRsbScKsdMbf9Q3p8
 QYi8NcCu1k5AzonhQ1VCH6zCT+3+AkNgrwjHiMtXMveewofVxbNK/makoLjx6W/mvQb5
 w2WODjf+b+8MZRkQF7lxK3wFyP4wZiynPH2YI42EtGDXT+d75ltrHmB4OZkczxlduGLQ
 MvIfrBqudWXGr7o2EHHoLMrgkL8mpc96BMWOhnOSnyiegEQ7PlOG2hlcT5EjOxDI35z4
 ZjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GNPMH7+BshXFtHvJRFR/Pz67utL4+c2zXgvOMeOYi1w=;
 b=tg2yb9+KdzmGj4htGecu4OmcxHEZGBpRcrD6BgFrWBuFR7tkzuhGrq2heIpvGh2dHJ
 sDBnu+jJHWNlqyKm1pxporbZizcaZTgU59oulNvCFRXO5j0LdYeMf17IpsWOsZkxQQv2
 bemLxM6Go8ncBempUgb50if7jgOXNxWfdEKuCFEgesM4XdowxH72BRubVTfidw6yceCs
 g98a2moTIstE5TSebkOUCokBKm3UgFWzzJyCtO8mVfW/eBHxsF6pMplsWq5mVYiRqp+z
 U1/jNXzNqsykclQ/XnChCU3CCeCdm+NMtAF5XILs6ZJeHMCZlpaioOF/eeyZqzxkDilG
 CKHQ==
X-Gm-Message-State: AOAM532O7ZewlSRaCP7NeEARWztVZFqOYO8ZFcqJFR+Tidv6jpiR1oeg
 FHTWs+JoqToWO2NHY3I340j9cQ==
X-Google-Smtp-Source: ABdhPJzrDah+u91N2/j3UWxTUP9JFlQRPTokZt/Vi5apdBbebjcxWKcx2wIFaChw2/Z19djyE7hbqg==
X-Received: by 2002:adf:dec3:: with SMTP id i3mr931833wrn.263.1606130392924;
 Mon, 23 Nov 2020 03:19:52 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:19:52 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 24/40] drm/amd/include/navi10_ip_offset: Mark top-level
 IP_BASE as __maybe_unused
Date: Mon, 23 Nov 2020 11:19:03 +0000
Message-Id: <20201123111919.233376-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 23 Nov 2020 13:58:01 +0000
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9yZWdfaW5p
dC5jOjI3OgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9uYXZpMTBfaXBf
b2Zmc2V0Lmg6MTI3OjI5OiB3YXJuaW5nOiDigJhVTUNfQkFTReKAmSBkZWZpbmVkIGJ1dCBub3Qg
dXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQogMTI3IHwgc3RhdGljIGNvbnN0IHN0cnVj
dCBJUF9CQVNFIFVNQ19CQVNFID17IHsgeyB7IDB4MDAwMTQwMDAsIDAsIDAsIDAsIDAsIDAgfSB9
LAogfCBefn5+fn5+fgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9uYXZp
MTBfaXBfb2Zmc2V0Lmg6MTA5OjI5OiB3YXJuaW5nOiDigJhSU01VX0JBU0XigJkgZGVmaW5lZCBi
dXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KIDEwOSB8IHN0YXRpYyBjb25z
dCBzdHJ1Y3QgSVBfQkFTRSBSU01VX0JBU0UgPSB7IHsgeyB7IDB4MDAwMTIwMDAsIDAsIDAsIDAs
IDAsIDAgfSB9LAogfCBefn5+fn5+fn4KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2lu
Y2x1ZGUvbmF2aTEwX2lwX29mZnNldC5oOjYxOjI5OiB3YXJuaW5nOiDigJhGVVNFX0JBU0XigJkg
ZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KIDYxIHwgc3Rh
dGljIGNvbnN0IHN0cnVjdCBJUF9CQVNFIEZVU0VfQkFTRSA9eyB7IHsgeyAweDAwMDE3NDAwLCAw
LCAwLCAwLCAwLCAwIH0gfSwKIHwgXn5+fn5+fn5+CgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5p
ZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBM
ZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
aW5jbHVkZS9uYXZpMTBfaXBfb2Zmc2V0LmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2luY2x1ZGUvbmF2aTEwX2lwX29mZnNldC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRl
L25hdmkxMF9pcF9vZmZzZXQuaAppbmRleCBkNGE5ZGRjNzc4MmZmLi5kNjgyNGJiNjEzOWRiIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvbmF2aTEwX2lwX29mZnNldC5o
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9uYXZpMTBfaXBfb2Zmc2V0LmgKQEAg
LTMxLDcgKzMxLDcgQEAgc3RydWN0IElQX0JBU0VfSU5TVEFOQ0UgewogIAogc3RydWN0IElQX0JB
U0UgewogCXN0cnVjdCBJUF9CQVNFX0lOU1RBTkNFIGluc3RhbmNlW01BWF9JTlNUQU5DRV07Ci19
OworfSBfX21heWJlX3VudXNlZDsKIAogCiBzdGF0aWMgY29uc3Qgc3RydWN0IElQX0JBU0UgQVRI
VUJfQkFTRSAgICAgICAgICAgID17IHsgeyB7IDB4MDAwMDBDMDAsIDAsIDAsIDAsIDAsIDAgfSB9
LAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
