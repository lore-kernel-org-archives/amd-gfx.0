Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA99C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EBE61358
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EBE61358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E00F66F4EA;
	Thu, 20 May 2021 19:13:05 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54EAE6F4E6;
 Thu, 20 May 2021 19:13:04 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id h9so17441405oih.4;
 Thu, 20 May 2021 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=f1HOQI0BiwYrzUbgtBfaRLayWrin0jlbAh0a0ONBLOo=;
 b=uQBkLZJqm0DE/dKM+x7eb9gLh8/XDQt5USaoCAeW2WbEHrTj2uym/bC+wCmhG0gcl4
 v4NQnxVANDznwTrUF2WAxSaLDVfwZPjcLsiIUd7gsifdF2O/K+9d/qSdM6vpL8UzCQ2/
 73uBQdlN03hLEV+x5rSZqiIJ5du8gB+Fgd9odvQcpXzIPrTOB/QGQ9IXdoDesyE8sy52
 kfTPxvTssaqnqYUnD5b3xYlU05n8y4dO7HzRUksofF4xi+w4eDcv4jFMSjbhQpef7aRE
 3zbqsXANWhvcqhHJDz3Qn1pw7IL/xwiWgYZDEcs/RBTUJ1t8qLRcLfZsz6YLEMgo8I/0
 DINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=f1HOQI0BiwYrzUbgtBfaRLayWrin0jlbAh0a0ONBLOo=;
 b=qAhTkT6wGkxjTrx6p2wCKgRsS5kJJSHtp6wySs+bERlCbEEZwqM7v3MfCu/lKF5pT4
 gc1ffmLD4Q6dZz2i92c8TD6zC8aQM9Y16BDEJSiy6FFdHQzS0Zsbz07EBPrBQTRVn0r5
 jGCeRe4bxIJ/BGPAwODrOuwlNiUgPjNrwOxKNaFob3TYAJb9fUWxmvGO/+SbN63ryJuE
 pmrV2V8wortZf5TP8xOH8fXYpOTWORgQb1Q/3wi3IRnqvLJAuGNV+WxPiIXwKuiVmClG
 ocsvL+CFMx2u06rua9MEakxJk0sVGUUQ96Sr08p9SecGWehr2YBeJKZ2eX7lYR4zqIDZ
 v3jg==
X-Gm-Message-State: AOAM531jL8RySTKdjU5gr2FgbGug3MqPAU+OhWi3smKWiPqdHnyOFqjv
 4A2Cr8aZQOO+yQ6HuRW5IVLc2T8LkUMU84yhRimUyiWk
X-Google-Smtp-Source: ABdhPJxpLtprybsUn1KTxq9uRURqDKRbgBwQ5gkvNzCxNnBiUHkZOfWu506pJSfVTEeY/5X+bvFi9I9ic2wihYDZZHc=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr4186705oie.120.1621537983767; 
 Thu, 20 May 2021 12:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-14-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-14-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:12:52 -0400
Message-ID: <CADnq5_NPpWbDwOffhShmWGTydz+fu0K-OQ=HO81+tcOWKzaicQ@mail.gmail.com>
Subject: Re: [PATCH 13/38] drm/amd/amdgpu/cik_sdma: Fix a few incorrectly
 named functions
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0g
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9s
bG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9jaWtfc2RtYS5jOjczNTogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBm
b3IgY2lrX3NkbWFfdm1fY29weV9wYWdlcygpLiBQcm90b3R5cGUgd2FzIGZvciBjaWtfc2RtYV92
bV9jb3B5X3B0ZSgpIGluc3RlYWQKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX3Nk
bWEuYzo3NjI6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIGNpa19zZG1hX3ZtX3dy
aXRlX3BhZ2VzKCkuIFByb3RvdHlwZSB3YXMgZm9yIGNpa19zZG1hX3ZtX3dyaXRlX3B0ZSgpIGlu
c3RlYWQKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX3NkbWEuYzo3OTI6IHdhcm5p
bmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIGNpa19zZG1hX3ZtX3NldF9wYWdlcygpLiBQcm90
b3R5cGUgd2FzIGZvciBjaWtfc2RtYV92bV9zZXRfcHRlX3BkZSgpIGluc3RlYWQKPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX3NkbWEuYzo4MTQ6IHdhcm5pbmc6IGV4cGVjdGluZyBw
cm90b3R5cGUgZm9yIGNpa19zZG1hX3ZtX3BhZF9pYigpLiBQcm90b3R5cGUgd2FzIGZvciBjaWtf
c2RtYV9yaW5nX3BhZF9pYigpIGluc3RlYWQKPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6
IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogU3VtaXQgU2Vtd2FsIDxzdW1p
dC5zZW13YWxAbGluYXJvLm9yZz4KPiBDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4K
PiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IENjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzog
bGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVz
IDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvY2lrX3NkbWEuYyB8IDggKysrKy0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9jaWtfc2RtYS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX3NkbWEu
Ywo+IGluZGV4IGM0YmI4ZWVkMjQ2ZDYuLmM4ZWJkMTA4NTQ4ZDMgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX3NkbWEuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2Npa19zZG1hLmMKPiBAQCAtNzIwLDcgKzcyMCw3IEBAIHN0YXRpYyBpbnQg
Y2lrX3NkbWFfcmluZ190ZXN0X2liKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgbG9uZyB0aW1l
b3V0KQo+ICB9Cj4KPiAgLyoqCj4gLSAqIGNpa19zZG1hX3ZtX2NvcHlfcGFnZXMgLSB1cGRhdGUg
UFRFcyBieSBjb3B5aW5nIHRoZW0gZnJvbSB0aGUgR0FSVAo+ICsgKiBjaWtfc2RtYV92bV9jb3B5
X3B0ZSAtIHVwZGF0ZSBQVEVzIGJ5IGNvcHlpbmcgdGhlbSBmcm9tIHRoZSBHQVJUCj4gICAqCj4g
ICAqIEBpYjogaW5kaXJlY3QgYnVmZmVyIHRvIGZpbGwgd2l0aCBjb21tYW5kcwo+ICAgKiBAcGU6
IGFkZHIgb2YgdGhlIHBhZ2UgZW50cnkKPiBAQCAtNzQ2LDcgKzc0Niw3IEBAIHN0YXRpYyB2b2lk
IGNpa19zZG1hX3ZtX2NvcHlfcHRlKHN0cnVjdCBhbWRncHVfaWIgKmliLAo+ICB9Cj4KPiAgLyoq
Cj4gLSAqIGNpa19zZG1hX3ZtX3dyaXRlX3BhZ2VzIC0gdXBkYXRlIFBURXMgYnkgd3JpdGluZyB0
aGVtIG1hbnVhbGx5Cj4gKyAqIGNpa19zZG1hX3ZtX3dyaXRlX3B0ZSAtIHVwZGF0ZSBQVEVzIGJ5
IHdyaXRpbmcgdGhlbSBtYW51YWxseQo+ICAgKgo+ICAgKiBAaWI6IGluZGlyZWN0IGJ1ZmZlciB0
byBmaWxsIHdpdGggY29tbWFuZHMKPiAgICogQHBlOiBhZGRyIG9mIHRoZSBwYWdlIGVudHJ5Cj4g
QEAgLTc3NSw3ICs3NzUsNyBAQCBzdGF0aWMgdm9pZCBjaWtfc2RtYV92bV93cml0ZV9wdGUoc3Ry
dWN0IGFtZGdwdV9pYiAqaWIsIHVpbnQ2NF90IHBlLAo+ICB9Cj4KPiAgLyoqCj4gLSAqIGNpa19z
ZG1hX3ZtX3NldF9wYWdlcyAtIHVwZGF0ZSB0aGUgcGFnZSB0YWJsZXMgdXNpbmcgc0RNQQo+ICsg
KiBjaWtfc2RtYV92bV9zZXRfcHRlX3BkZSAtIHVwZGF0ZSB0aGUgcGFnZSB0YWJsZXMgdXNpbmcg
c0RNQQo+ICAgKgo+ICAgKiBAaWI6IGluZGlyZWN0IGJ1ZmZlciB0byBmaWxsIHdpdGggY29tbWFu
ZHMKPiAgICogQHBlOiBhZGRyIG9mIHRoZSBwYWdlIGVudHJ5Cj4gQEAgLTgwNCw3ICs4MDQsNyBA
QCBzdGF0aWMgdm9pZCBjaWtfc2RtYV92bV9zZXRfcHRlX3BkZShzdHJ1Y3QgYW1kZ3B1X2liICpp
YiwgdWludDY0X3QgcGUsCj4gIH0KPgo+ICAvKioKPiAtICogY2lrX3NkbWFfdm1fcGFkX2liIC0g
cGFkIHRoZSBJQiB0byB0aGUgcmVxdWlyZWQgbnVtYmVyIG9mIGR3Cj4gKyAqIGNpa19zZG1hX3Jp
bmdfcGFkX2liIC0gcGFkIHRoZSBJQiB0byB0aGUgcmVxdWlyZWQgbnVtYmVyIG9mIGR3Cj4gICAq
Cj4gICAqIEByaW5nOiBhbWRncHVfcmluZyBzdHJ1Y3R1cmUgaG9sZGluZyByaW5nIGluZm9ybWF0
aW9uCj4gICAqIEBpYjogaW5kaXJlY3QgYnVmZmVyIHRvIGZpbGwgd2l0aCBwYWRkaW5nCj4gLS0K
PiAyLjMxLjEKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
