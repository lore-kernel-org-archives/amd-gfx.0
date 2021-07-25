Return-Path: <SRS0=Cxcf=MR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3789CC4338F
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Jul 2021 16:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B4E60E77
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Jul 2021 16:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9B4E60E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57CB46E2D7;
	Sun, 25 Jul 2021 16:49:11 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1216E2D7
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jul 2021 16:49:09 +0000 (UTC)
Date: Sun, 25 Jul 2021 16:49:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1627231746;
 bh=vBWhTF9xJubLN+MXwZjwdzDlVU06Urw0TPrb7/PJRR8=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=EVrLGgRXT4ing5wIt7Khj52gcayUEpbjdUzDe2PegHm/5DWkbV2XqbiITHjKGJC/4
 zQbqQVNXLJeOXqrV8T0JNhJ9DgbFwXt3ixPABqwFyf795XNDgJ2qULd7aZUd0UHFtD
 tqZzO9fzMUmWfcPCNyR8lpmYdit1UtuuhSiWOzou1x/XRA7djA1opFg2cvV9Rrlfxs
 Pi0XA4U+ES5LZlUrHV+RZUJuWmEYai7AAbRNtvptr3eMonydUq+fkN5V6LZlRPxCyD
 XvxRlcOZZcpEfxdJ8G0jd/AvWBrCT3IXMmcdgnKvLcqVmLUt2bjZ0drlkGu9S3I00o
 bDf+Rjt9VTnuw==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH] maintainers: add bugs and chat URLs for amdgpu
Message-ID: <N971xcA16PS0LZcvKTedK0IqLA2nrpKeiTBqJjXg@cp3-web-012.plabs.ch>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWRkIGxpbmtzIHRvIHRoZSBpc3N1ZSB0cmFja2VyIGFuZCB0aGUgSVJDIGNoYW5uZWwgZm9yIHRo
ZSBhbWRncHUKZHJpdmVyLgoKU2lnbmVkLW9mZi1ieTogU2ltb24gU2VyIDxjb250YWN0QGVtZXJz
aW9uLmZyPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogUGFuIFhpbmh1
aSA8WGluaHVpLlBhbkBhbWQuY29tPgotLS0KIE1BSU5UQUlORVJTIHwgMiArKwogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRB
SU5FUlMKaW5kZXggMGRjODQzMzljZmY0Li43OGJmMTBhMWY1ZDUgMTAwNjQ0Ci0tLSBhL01BSU5U
QUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0xNTI5Nyw2ICsxNTI5Nyw4IEBAIE06CVBhbiwg
WGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+CiBMOglhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwogUzoJU3VwcG9ydGVkCiBUOglnaXQgaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3Jn
L2FnZDVmL2xpbnV4LmdpdAorQjoJaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9h
bWQvLS9pc3N1ZXMKK0M6CWlyYzovL2lyYy5vZnRjLm5ldC9yYWRlb24KIEY6CWRyaXZlcnMvZ3B1
L2RybS9hbWQvCiBGOglkcml2ZXJzL2dwdS9kcm0vcmFkZW9uLwogRjoJaW5jbHVkZS91YXBpL2Ry
bS9hbWRncHVfZHJtLmgKLS0gCjIuMzIuMAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
