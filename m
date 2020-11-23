Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5579C63798
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700DB20702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kq+yTUs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700DB20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFCE6E030;
	Mon, 23 Nov 2020 13:58:25 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB94E89DA4
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:19:57 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a186so14726357wme.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+BSX8iGmFlpNBkCwyYHsXehrutNO54wnnUYTt1a8UO4=;
 b=kq+yTUs0Z36Ahw7u+PzIXO7sgObe2HM66BxwQRS4z8siLlP0bqTJ1E4ekPh8ZzB2xV
 KrPXoI5LzXiWCUU6gv/h+Ac5AkvBrXCtGIdXzqiD3E6fzjlaykwmpnp0ncc9mpMPXwpF
 7ZO7x5sszZgxTW0UZBhGM+nZPJNMfDadL033J9dDknwd0n71CmxAJxEfiOSfp9ZWRYzT
 VjWz7KhkCFs8qGvbkbLv6YhVXaOHIHxX+gga4D1/GLSvPxglfwfHNhszl9lcqHMNlukf
 3bU5zyK0fgnAlzHDZ9nRCXu6URdAznRm6+l/O3LsPeBn+y817mC4us+NHZemgltRJsTy
 MAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+BSX8iGmFlpNBkCwyYHsXehrutNO54wnnUYTt1a8UO4=;
 b=foKSNXA5OEcIA3JtqDYNRy0XB59CaGaOkoIQOq9t/Hy7Jw0ZRcKo036PYHAInZPO+7
 n9P34OlrbPdZjHW90PL7xS/+QOxNuafqC843IM6/io/3QD7S+oVQkYJeAvBD9CrA5N/P
 uO+/EoHGeyIWDlmq6V01T4WxPtMu/SDdp4f75nuppUYoh/l4vPXtv1UxMf8sxb3M7aO3
 Rw0VnrLxgXB+JWPf6wuIRvRkck7AhROCiJ1rVhTFZgbKX3p+EfVkIccaBmBNKEiyz4Jk
 3U+2Ut7yLk3GA2Cr8qtP5XsTnwgHkSVgokqcDsa6mYDmNX6aePRKnVtOf67/Rg65FDhP
 wcNw==
X-Gm-Message-State: AOAM531fOV+7/2AY5JhmfP8nZZT1tco0XvVa+8mEO8NuOez8z6nFU0Jo
 Xju7pLSr1xSFS6eDgVUNNrI7HA==
X-Google-Smtp-Source: ABdhPJyN4OEr/YOxNYffIUn5qCnDBtG2DeSQZgaAWBIDjmJjXk/O+zQ0IJfMgrsLJnio9vIdj85SYw==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr22882338wme.23.1606130396662; 
 Mon, 23 Nov 2020 03:19:56 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:19:56 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 27/40] drm/amd/include/navi12_ip_offset: Mark top-level
 IP_BASE as __maybe_unused
Date: Mon, 23 Nov 2020 11:19:06 +0000
Message-Id: <20201123111919.233376-28-lee.jones@linaro.org>
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
ZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMl9yZWdfaW5p
dC5jOjI3OgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9uYXZpMTJfaXBf
b2Zmc2V0Lmg6MTc5OjI5OiB3YXJuaW5nOiDigJhVU0IwX0JBU0XigJkgZGVmaW5lZCBidXQgbm90
IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KIDE3OSB8IHN0YXRpYyBjb25zdCBzdHJ1
Y3QgSVBfQkFTRSBVU0IwX0JBU0UgPXsgeyB7IHsgMHgwMjQyQTgwMCwgMHgwNUIwMDAwMCwgMCwg
MCwgMCB9IH0sCiB8IF5+fn5+fn5+fgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5j
bHVkZS9uYXZpMTJfaXBfb2Zmc2V0Lmg6MTcyOjI5OiB3YXJuaW5nOiDigJhVTUNfQkFTReKAmSBk
ZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQogMTcyIHwgc3Rh
dGljIGNvbnN0IHN0cnVjdCBJUF9CQVNFIFVNQ19CQVNFID17IHsgeyB7IDB4MDAwMTQwMDAsIDB4
MDI0MjU4MDAsIDAsIDAsIDAgfSB9LAogfCBefn5+fn5+fgogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvLi4vaW5jbHVkZS9uYXZpMTJfaXBfb2Zmc2V0Lmg6MTUxOjI5OiB3YXJuaW5nOiDigJhT
RE1BX0JBU0XigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxl
PV0KIDE1MSB8IHN0YXRpYyBjb25zdCBzdHJ1Y3QgSVBfQkFTRSBTRE1BX0JBU0UgPXsgeyB7IHsg
MHgwMDAwMTI2MCwgMHgwMDAwQTAwMCwgMHgwMjQwMkMwMCwgMCwgMCB9IH0sCiB8IF5+fn5+fn5+
fgoKTkI6IFNuaXBwZWQgYSBmZXcgb2YgdGhlc2UKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmll
bCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExl
ZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9p
bmNsdWRlL25hdmkxMl9pcF9vZmZzZXQuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
aW5jbHVkZS9uYXZpMTJfaXBfb2Zmc2V0LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUv
bmF2aTEyX2lwX29mZnNldC5oCmluZGV4IDZjMmNjNjI5NmMwNjEuLmQ4ZmMwMDQ3OGI2YTAgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9uYXZpMTJfaXBfb2Zmc2V0LmgK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL25hdmkxMl9pcF9vZmZzZXQuaApAQCAt
MzMsNyArMzMsNyBAQCBzdHJ1Y3QgSVBfQkFTRV9JTlNUQU5DRQogc3RydWN0IElQX0JBU0UKIHsK
ICAgICBzdHJ1Y3QgSVBfQkFTRV9JTlNUQU5DRSBpbnN0YW5jZVtNQVhfSU5TVEFOQ0VdOwotfTsK
K30gX19tYXliZV91bnVzZWQ7CiAKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBJUF9CQVNFIEFUSFVC
X0JBU0UgPXsgeyB7IHsgMHgwMDAwMEMwMCwgMHgwMjQwOEMwMCwgMCwgMCwgMCB9IH0sCi0tIAoy
LjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
