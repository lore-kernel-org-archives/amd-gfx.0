Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D4C63798
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970E420702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tj5vDTXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970E420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B613089F41;
	Mon, 23 Nov 2020 13:58:02 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD68D89FA0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:20:06 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id c198so15635195wmd.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nVQkRWnV9jg6+Ada1H2Ew94/golbusCXMuvb/nmCqqU=;
 b=tj5vDTXoZ7s7BPKmO/w/NnSIr9175PGoUapOPiOyTm9MIvdIVTwGlWFPjgvv6ccVwu
 BPNoyYf9q/lfk+xKsUamao8DV4+aNU8DZRD/W6KSeAxQd2jm5pb/K4oOwPmyXlyutKyw
 6jf5zucwL+kphS42Ud1rMc58qo/BM/kjXcGp2cOKoy+BOHyvMNfUKwWlG+uwWKogNljr
 J7edQrZj8GhEgIV4msgKIOWfO0B2hZkrK4NVEltL3QApq+hvQwih476iQyw08FtEyU9i
 rfeV1BdjA7rWMJcWEMP16O5ZnllwohZp31bhDl8WhtP6Jfkt3A70v4Pgi779K0P+UMtO
 IJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nVQkRWnV9jg6+Ada1H2Ew94/golbusCXMuvb/nmCqqU=;
 b=je0esen/TpS7qaiJJOvX+to3wSskSqa7BYQLdUO72AXSWRMNNkfpSdnsryiuYUYXgl
 uNZXjPhT/rz9strOZaIAktQaVseSZPiemVwWR8ENPyBbC+iKmj5f0xtKf5tSgdeV6a24
 qQ+dX2nlmghpl1fwNCUcwewaKXBsZN+7IkAgwUBXsoVsTYMmJvVUEVv0VPlwED8DeXN9
 t1//+ZCN31XNC1U9iat4B1PiO7W7pzgh/L4hnN59e/ykZIcDHsgnMoq52jPWM2rzt4/9
 5snhsYyHLW3VK/w9eUQeimKGLp0Z+6rX2nCZaJ1CASF5qoH1CXlorThjl+6dshyNElXk
 TdCQ==
X-Gm-Message-State: AOAM531+eYMGj2ExJkWLIrb3hDp7bHV0QB8HoBjb3IN6r4nWQyRufCOQ
 tLJDrtEHdERaFVjrVn0QQZCsqA==
X-Google-Smtp-Source: ABdhPJzJTRphnS4m5QCyP59RQ8emH9hrAl6jgmA4rnoY67SeHNnqPkBKDiNGxhkeGQXBc1q0SBqu5w==
X-Received: by 2002:a1c:2d47:: with SMTP id t68mr23427316wmt.148.1606130405294; 
 Mon, 23 Nov 2020 03:20:05 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:20:04 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 30/40] drm/amd/include/dimgrey_cavefish_ip_offset: Mark
 top-level IP_BASE as __maybe_unused
Date: Mon, 23 Nov 2020 11:19:09 +0000
Message-Id: <20201123111919.233376-31-lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, Tao Zhou <tao.zhou1@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Jiansong Chen <Jiansong.Chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgpJbiBmaWxl
IGluY2x1ZGVkIGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGltZ3JleV9jYXZlZmlz
aF9yZWdfaW5pdC5jOjI4Ogpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRlL2Rp
bWdyZXlfY2F2ZWZpc2hfaXBfb2Zmc2V0Lmg6MTUxOjI5OiB3YXJuaW5nOiDigJhVTUNfQkFTReKA
mSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQoxNTEgfCBz
dGF0aWMgY29uc3Qgc3RydWN0IElQX0JBU0UgVU1DX0JBU0UgPSB7IHsgeyB7IDB4MDAwMTQwMDAs
IDB4MDI0MjU4MDAsIDAsIDAsIDAsIDAgfSB9LAp8IF5+fn5+fn5+CmRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL2luY2x1ZGUvZGltZ3JleV9jYXZlZmlzaF9pcF9vZmZzZXQuaDo4MToyOTog
d2FybmluZzog4oCYRlVTRV9CQVNF4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1j
b25zdC12YXJpYWJsZT1dCjgxIHwgc3RhdGljIGNvbnN0IHN0cnVjdCBJUF9CQVNFIEZVU0VfQkFT
RSA9IHsgeyB7IHsgMHgwMDAxNzQwMCwgMHgwMjQwMTQwMCwgMCwgMCwgMCwgMCB9IH0sCnwgXn5+
fn5+fn5+CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvZGltZ3JleV9jYXZl
ZmlzaF9pcF9vZmZzZXQuaDo3NDoyOTogd2FybmluZzog4oCYRFBDU19CQVNF4oCZIGRlZmluZWQg
YnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCjc0IHwgc3RhdGljIGNvbnN0
IHN0cnVjdCBJUF9CQVNFIERQQ1NfQkFTRSA9IHsgeyB7IHsgMHgwMDAwMDAxMiwgMHgwMDAwMDBD
MCwgMHgwMDAwMzRDMCwgMHgwMDAwOTAwMCwgMHgwMjQwM0MwMCwgMCB9IH0sCnwgXn5+fn5+fn5+
CgpOQjogU25pcHBlZCBsb3RzIG9mIHRoZXNlCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwg
VmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBUYW8gWmhvdSA8dGFvLnpob3UxQGFtZC5jb20+
CkNjOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+CkNjOiBKaWFuc29uZyBD
aGVuIDxKaWFuc29uZy5DaGVuQGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBM
ZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
aW5jbHVkZS9kaW1ncmV5X2NhdmVmaXNoX2lwX29mZnNldC5oIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9pbmNsdWRlL2RpbWdyZXlfY2F2ZWZpc2hfaXBfb2Zmc2V0LmggYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2luY2x1ZGUvZGltZ3JleV9jYXZlZmlzaF9pcF9vZmZzZXQuaAppbmRleCBi
NDEyNjNkZThhOWI2Li5mODQ5OTZhNzNkZTk0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2luY2x1ZGUvZGltZ3JleV9jYXZlZmlzaF9pcF9vZmZzZXQuaAorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2luY2x1ZGUvZGltZ3JleV9jYXZlZmlzaF9pcF9vZmZzZXQuaApAQCAtMzMsNyAr
MzMsNyBAQCBzdHJ1Y3QgSVBfQkFTRV9JTlNUQU5DRQogc3RydWN0IElQX0JBU0UKIHsKICAgICBz
dHJ1Y3QgSVBfQkFTRV9JTlNUQU5DRSBpbnN0YW5jZVtNQVhfSU5TVEFOQ0VdOwotfTsKK30gX19t
YXliZV91bnVzZWQ7CiAKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBJUF9CQVNFIEFUSFVCX0JBU0Ug
PSB7IHsgeyB7IDB4MDAwMDBDMDAsIDB4MDI0MDhDMDAsIDAsIDAsIDAsIDAgfSB9LAotLSAKMi4y
NS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
