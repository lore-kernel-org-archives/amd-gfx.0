Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4200EC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C5D206BA
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C5D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E41786E9A9;
	Mon, 11 Nov 2019 17:54:30 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C48B16E9A9;
 Mon, 11 Nov 2019 17:54:29 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id r10so15653305wrx.3;
 Mon, 11 Nov 2019 09:54:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6Sh3JJblGl5/+Mmu7ju06QN1EZSaD9aHUrB6Yg5UQ0o=;
 b=c2vMavoLvIADvJThq4aUuQy/M6EYttGy3j8FuWl80mNQ4/l8ZdM7TUXIDh7CezXfzg
 v6vIruUOHMdVTD24Xiu7/eJ5MRteJhbmHfNrVsAYeTrZFqV9vu+utu+ph2KqbthE0M7M
 dGQYKPob4IIjYv0zgZ0LO1s6mbVjOg0IvZS8+Kq75rJ6lik8dKKlvL5OeMgTwSisl6mO
 lzJGwy0EtbK+t+Loeu2GJhm+8N5ZDxy5/fQek80BLCH50FLH9fIRrH+0lUlmgQcBUzo4
 ME2KNrYsYJwIFHbUVf05UUoCyyNw+u6GO5cFt+XFv6uUup2M0cmzELzEV8S04TBaJE5Q
 /+gw==
X-Gm-Message-State: APjAAAXkRAf7/asdGerLEKyKg9BbEbLyvfSM/JNjCzTT7UksKl+OXVM3
 NOU8f3XdLck6EA+Oe335y8qnFSCin+LJ8eQ80HA=
X-Google-Smtp-Source: APXvYqxR25uCeTdSyttMsdVrlPfMICg98Vgwdo81lJpEi4B13P1POaqyz6VPDw1XUatFI0hYCHZmUXpNyac50HIWjWI=
X-Received: by 2002:a05:6000:18c:: with SMTP id
 p12mr21154459wrx.154.1573494868418; 
 Mon, 11 Nov 2019 09:54:28 -0800 (PST)
MIME-Version: 1.0
References: <1573464793-34901-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1573464793-34901-1-git-send-email-zhengbin13@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Nov 2019 12:54:16 -0500
Message-ID:
 <CADnq5_O9mh6=2RVe-GhxuV1DqN5iCpiXQWLQzK1cfE9zXye9-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use static const, not const static
To: zhengbin <zhengbin13@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=6Sh3JJblGl5/+Mmu7ju06QN1EZSaD9aHUrB6Yg5UQ0o=;
 b=E6f+1TMkdLBiDpmSLwCjovrEbCAF0/6MPKhnAz1P41xUH+BR9ykypQ1NS18Z730eLy
 xGlAFCZ7ZScXnkIRt5VlQgClWdKidOKarK0OCa33M1Xf0V4z2gjaqR/UUZDt7xfsq+i+
 nSqRWst+vAW+RBdBME10NmRbWlZJ2d7P7uqWvxl+zrwTgr2GVaHVY9pPSnt3yrn0X9A2
 DmjxH2Nh7QlhlInS1soDkQJQWcBPSR6W7Rykjey+dc5YTnf3vSB0TmkssXF9OnItaEqt
 AXu0WgxVBhzIuped3XmDDrPVwvXZYGFTCLMk2cMUFSX1unNldwLg3q3BRAJlX2fsfVgv
 lmpQ==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Chunming Zhou <David1.Zhou@amd.com>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111175416.mp-iTHL1OvrC7iXgGZJGtVhWvU4BHKGxcfcOVPiYLzE@z>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIE1vbiwgTm92IDExLCAyMDE5IGF0IDk6MTEgQU0g
emhlbmdiaW4gPHpoZW5nYmluMTNAaHVhd2VpLmNvbT4gd3JvdGU6Cj4KPiBNb3ZlIHRoZSBzdGF0
aWMga2V5d29yZCB0byB0aGUgZnJvbnQgb2YgZGVjbGFyYXRpb25zLgo+Cj4gUmVwb3J0ZWQtYnk6
IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPgo+IFNpZ25lZC1vZmYtYnk6IHpoZW5nYmlu
IDx6aGVuZ2JpbjEzQGh1YXdlaS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9jb3JlL2RjLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9jb3JlL2RjLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9k
Yy5jCj4gaW5kZXggMWZkYmExMy4uMGQ4YzY2MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGMuYwo+IEBAIC02OSw3ICs2OSw3IEBACj4gICNkZWZpbmUgRENfTE9H
R0VSIFwKPiAgICAgICAgIGRjLT5jdHgtPmxvZ2dlcgo+Cj4gLWNvbnN0IHN0YXRpYyBjaGFyIERD
X0JVSUxEX0lEW10gPSAicHJvZHVjdGlvbi1idWlsZCI7Cj4gK3N0YXRpYyBjb25zdCBjaGFyIERD
X0JVSUxEX0lEW10gPSAicHJvZHVjdGlvbi1idWlsZCI7Cj4KPiAgLyoqCj4gICAqIERPQzogT3Zl
cnZpZXcKPiAtLQo+IDIuNy40Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
