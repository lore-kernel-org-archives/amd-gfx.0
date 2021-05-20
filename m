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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E0BC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECE5611AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECE5611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741866F4E4;
	Thu, 20 May 2021 19:10:20 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE456F4E4;
 Thu, 20 May 2021 19:10:15 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 g7-20020a9d12870000b0290328b1342b73so7994998otg.9; 
 Thu, 20 May 2021 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qZmqhErjNw9NpB4sTEi7TBGKOlHWpPlsaMkchqCd25U=;
 b=VUk9UBH/QcIR0qeCSyhDdMQ/L42ux4gncCKIrTFJFcDzd6FRRipqIKh8piNmD1KJnl
 kmHeFjswq2lFGSXDBDXUCEt1dLMwk6XSOgtK6Ax11cwQyipfUaJRO0Z6bHFj7Sf19SoB
 LJASG5MubLxCC7Dv0UYkWWlAwT1hTF6AFdkCqD5f/pSvAHyVWMELpLmJaV8XQZIv7eMZ
 n7Fw0Xpf1bwMUgAOMFuUhGe6cIyjjTMicraKgLuYtwvFkS0D8jNaRI0I40CCB527W60y
 ptF9CSJPC7NFp2kmV0GTbc2GoN1Qc2vNoo3XHRFV7uD2bnguZGzpNtbozHgPPM7XHbnx
 MmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qZmqhErjNw9NpB4sTEi7TBGKOlHWpPlsaMkchqCd25U=;
 b=gqRImbYsI1OZz+rXSclsUnknz/Dtr5EfDp9/Qd0AxuWPA5+vb7YN+JF/wfLWMqrfsh
 1GEkVLMHIe7ggGj4bkLIvb5DMhFHC9UWij5qOWC5TBmcuhmd1P2wxezNMTKk8l4QDRA7
 htse51WxpDTzUT4CxJDG9tXpy1NwlubH0ch0R/Qs+Ox09GFxv/sdivPgw+Ha+pVCVkmM
 ltMSW1vcP2qDxFvqiKEKFcyOzDb3iOHh0Wyk4dZAOM9SmZsAsP5x4k3xFMcoPGtXqZfM
 E2J5OKIK9a6aLH56lwx3CtE9ZOh/V8q5oUnDkDYI6K/PgdhdTM7/25UWs0UZmpmXG+I4
 E1tg==
X-Gm-Message-State: AOAM532AbWUHx2gwmIe22gF/jss/pljlx7glQh7uJf0Js0O5GebIQhGN
 VdlZC0LXTD2qmf5eLU/2vDahM1p9U4TOeuWzSMs=
X-Google-Smtp-Source: ABdhPJwMqj/CKQBdLb7dxshnqMhIbg//f1Ttg3En9FmwFe/Hdagzvy9jXwWeDIpGu4wupnXvU9vTUoBsQYzf0ZLnT+8=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr5119212otl.132.1621537814661; 
 Thu, 20 May 2021 12:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-12-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-12-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:10:03 -0400
Message-ID: <CADnq5_P1zF2Pw5BW54n+XEXyfNOLRnEvsk_zzZcz0TuanobubA@mail.gmail.com>
Subject: Re: [PATCH 11/38] drm/amd/amdgpu/amdgpu_debugfs: Fix a couple of
 misnamed functions
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
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0g
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9s
bG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jOjEwMDQ6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90
b3R5cGUgZm9yIGFtZGdwdV9kZWJ1Z2ZzX3JlZ3NfZ2Z4b2ZmX3dyaXRlKCkuIFByb3RvdHlwZSB3
YXMgZm9yIGFtZGdwdV9kZWJ1Z2ZzX2dmeG9mZl93cml0ZSgpIGluc3RlYWQKPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYzoxMDUzOiB3YXJuaW5nOiBleHBlY3Rp
bmcgcHJvdG90eXBlIGZvciBhbWRncHVfZGVidWdmc19yZWdzX2dmeG9mZl9zdGF0dXMoKS4gUHJv
dG90eXBlIHdhcyBmb3IgYW1kZ3B1X2RlYnVnZnNfZ2Z4b2ZmX3JlYWQoKSBpbnN0ZWFkCj4KPiBD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0
aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+
Cj4gQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+Cj4gQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbmFyby1tbS1z
aWdAbGlzdHMubGluYXJvLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVz
QGxpbmFyby5vcmc+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZWJ1Z2ZzLmMgfCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGVidWdmcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVn
ZnMuYwo+IGluZGV4IGJjYWYyNzFiMzliZjUuLmE5YmJiMDAzNGUxZWMgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKPiBAQCAtOTkwLDcgKzk5MCw3
IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9kZWJ1Z2ZzX2dwcl9yZWFkKHN0cnVjdCBmaWxlICpm
LCBjaGFyIF9fdXNlciAqYnVmLAo+ICB9Cj4KPiAgLyoqCj4gLSAqIGFtZGdwdV9kZWJ1Z2ZzX3Jl
Z3NfZ2Z4b2ZmX3dyaXRlIC0gRW5hYmxlL2Rpc2FibGUgR0ZYT0ZGCj4gKyAqIGFtZGdwdV9kZWJ1
Z2ZzX2dmeG9mZl93cml0ZSAtIEVuYWJsZS9kaXNhYmxlIEdGWE9GRgo+ICAgKgo+ICAgKiBAZjog
b3BlbiBmaWxlIGhhbmRsZQo+ICAgKiBAYnVmOiBVc2VyIGJ1ZmZlciB0byB3cml0ZSBkYXRhIGZy
b20KPiBAQCAtMTA0MSw3ICsxMDQxLDcgQEAgc3RhdGljIHNzaXplX3QgYW1kZ3B1X2RlYnVnZnNf
Z2Z4b2ZmX3dyaXRlKHN0cnVjdCBmaWxlICpmLCBjb25zdCBjaGFyIF9fdXNlciAqYnUKPgo+Cj4g
IC8qKgo+IC0gKiBhbWRncHVfZGVidWdmc19yZWdzX2dmeG9mZl9zdGF0dXMgLSByZWFkIGdmeG9m
ZiBzdGF0dXMKPiArICogYW1kZ3B1X2RlYnVnZnNfZ2Z4b2ZmX3JlYWQgLSByZWFkIGdmeG9mZiBz
dGF0dXMKPiAgICoKPiAgICogQGY6IG9wZW4gZmlsZSBoYW5kbGUKPiAgICogQGJ1ZjogVXNlciBi
dWZmZXIgdG8gc3RvcmUgcmVhZCBkYXRhIGluCj4gLS0KPiAyLjMxLjEKPgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
