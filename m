Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9B0C4708A
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC14761090
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC14761090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5976EE27;
	Thu, 27 May 2021 04:26:46 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 557B06EE24;
 Thu, 27 May 2021 04:26:45 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id j75so3858532oih.10;
 Wed, 26 May 2021 21:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MAqtfQh3kqLNCeKLPTeKdUEM29PsijCc//DfraUHLwQ=;
 b=eqBhr8eAXHo+lVRn+9mISIFH3Gy2q+Zk8dohqjdKoojg0OgqzwQqg/0IEaIiA0jsVW
 6GaZ41eYjO/4AmuMb5xxcLJhsiXwAjOM8Qr6mDvVlQQzm1AAd5V/63pX8Sm0Pzi0NcJm
 gAh4bKbpmXUdqNzhxHUeks+X2gJEy5A0+DKQ6KsygLSrh2ui01rFbvoCLBDgXCFk3uyw
 QvUeEWGHZ0CvivmK8gqV+qPaIBcRvB0qZiCAeifLCaR3PyBEOdTi7y4uVyAZZA6SMPIY
 IBrx46ptfW+pDG3f1o/m9elVSGqs0PNpHr8abQWVO9k5py7B8jilH9Kv+4XTHyGLdK8O
 WEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MAqtfQh3kqLNCeKLPTeKdUEM29PsijCc//DfraUHLwQ=;
 b=ewjH48dNp3vBfVZNRvR3leA1t4QquPgXLBiBV8p6HEE+4PBzddFJ3YtyZO5UGr4cQm
 IEwTt6vPkG4Z24hgyhjF4flhMrTNWOKMjIAiYXVRFrHnqwZt4YDiuOWkkNdvA32A8Otc
 wBwYRBCEeS0IUqeecVnWEonmh96hAPdWX7bCJg3yGF7Ywbx3Ze67t+5KWVKTR/pbq9hB
 uQ5Foe0gbX2vO5rtF1M6GUxjJ707C1cBhYK+x12oG2xTQo2rUQPhYab/J7w9EHfKPMIY
 qdZ32QkFZaKpG0DDI0bYleRiz4FpttNcVh4bGGnD5x2P8+VneqGGXiy5AUWDJrPq7Ipw
 U9dQ==
X-Gm-Message-State: AOAM530EYzxorGI55tVZaox2zopemt1cAcWIOU9Ped1yi3wrKCrB41B4
 lqDD0064v8lQthpwZGVZdo78huO7SGRGSVZkIF0=
X-Google-Smtp-Source: ABdhPJzSqLPyykDzrtM8uq9qKFXoEWkTve47q5DnAyeOgEMSN6yyg5sq5O2i3SRoUEnG6rHpKT45/NvEAbzcnTful+Q=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr1079682oiw.123.1622089604710; 
 Wed, 26 May 2021 21:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-23-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-23-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 May 2021 00:26:33 -0400
Message-ID: <CADnq5_PsDZPaJxmxYJBv3sY17Wu=9W4Eqgtb2EDo6PgxdzgwWQ@mail.gmail.com>
Subject: Re: [PATCH 22/34] drm/amd/display/dc/core/dc: Convert function
 headers to kernel-doc
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDggQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUvZGMuYzozMzI0OiB3YXJuaW5nOiBDYW5ub3QgdW5kZXJz
dGFuZCAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vZGlzcGxheS9kYy9jb3JlL2RjLmM6MzM0NDogd2FybmluZzogQ2Fubm90IHVuZGVyc3RhbmQg
ICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rp
c3BsYXkvZGMvY29yZS9kYy5jOjM0MTc6IHdhcm5pbmc6IENhbm5vdCB1bmRlcnN0YW5kICAqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKgo+Cj4gQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBh
bWQuY29tPgo+IENjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KPiBDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxp
bnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+
IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIHwgNDYgKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
LCAzNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvY29yZS9kYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGMuYwo+IGluZGV4IGVmMTU3YjgzYmFjZDIuLjM0YzIwN2Y5MmRmOTggMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKPiBAQCAtMzMzNSwxOCArMzMzNSwxMCBA
QCB2b2lkIGRjX2hhcmR3YXJlX3JlbGVhc2Uoc3RydWN0IGRjICpkYykKPiAgI2VuZGlmCj4KPiAg
LyoqCj4gLSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKgo+IC0gKiAgRnVuY3Rpb246IGRjX2VuYWJsZV9k
bXViX25vdGlmaWNhdGlvbnMKPiArICogZGNfZW5hYmxlX2RtdWJfbm90aWZpY2F0aW9ucyAtIFJl
dHVybnMgd2hldGhlciBkbXViIG5vdGlmaWNhdGlvbiBjYW4gYmUgZW5hYmxlZAo+ICsgKiBAZGM6
IGRjIHN0cnVjdHVyZQo+ICAgKgo+IC0gKiAgQGJyaWVmCj4gLSAqICAgICAgICAgICAgIFJldHVy
bnMgd2hldGhlciBkbXViIG5vdGlmaWNhdGlvbiBjYW4gYmUgZW5hYmxlZAo+IC0gKgo+IC0gKiAg
QHBhcmFtCj4gLSAqICAgICAgICAgICAgIFtpbl0gZGM6IGRjIHN0cnVjdHVyZQo+IC0gKgo+IC0g
KiAgICAgQHJldHVybgo+IC0gKiAgICAgICAgICAgICBUcnVlIHRvIGVuYWJsZSBkbXViIG5vdGlm
aWNhdGlvbnMsIEZhbHNlIG90aGVyd2lzZQo+IC0gKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKPiArICog
UmV0dXJuczogVHJ1ZSB0byBlbmFibGUgZG11YiBub3RpZmljYXRpb25zLCBGYWxzZSBvdGhlcndp
c2UKPiAgICovCj4gIGJvb2wgZGNfZW5hYmxlX2RtdWJfbm90aWZpY2F0aW9ucyhzdHJ1Y3QgZGMg
KmRjKQo+ICB7Cj4gQEAgLTMzNTUsMjEgKzMzNDcsMTMgQEAgYm9vbCBkY19lbmFibGVfZG11Yl9u
b3RpZmljYXRpb25zKHN0cnVjdCBkYyAqZGMpCj4gIH0KPgo+ICAvKioKPiAtICoqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqCj4gLSAqICBGdW5jdGlvbjogZGNfcHJvY2Vzc19kbXViX2F1eF90cmFuc2Zlcl9h
c3luYwo+IC0gKgo+IC0gKiAgQGJyaWVmCj4gLSAqICAgICAgICAgICAgIFN1Ym1pdHMgYXV4IGNv
bW1hbmQgdG8gZG11YiB2aWEgaW5ib3ggbWVzc2FnZQo+IC0gKiAgICAgICAgICAgICBTZXRzIHBv
cnQgaW5kZXggYXBwcm9wcmlhdGVseSBmb3IgbGVnYWN5IEREQwo+IC0gKgo+IC0gKiAgQHBhcmFt
Cj4gLSAqICAgICAgICAgICAgIFtpbl0gZGM6IGRjIHN0cnVjdHVyZQo+IC0gKiAgICAgICAgICAg
ICBbaW5dIGxpbmtfaW5kZXg6IGxpbmsgaW5kZXgKPiAtICogICAgICAgICAgICAgW2luXSBwYXls
b2FkOiBhdXggcGF5bG9hZAo+ICsgKiBkY19wcm9jZXNzX2RtdWJfYXV4X3RyYW5zZmVyX2FzeW5j
IC0gU3VibWl0cyBhdXggY29tbWFuZCB0byBkbXViIHZpYSBpbmJveCBtZXNzYWdlCj4gKyAqICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTZXRzIHBvcnQgaW5kZXggYXBwcm9w
cmlhdGVseSBmb3IgbGVnYWN5IEREQwo+ICsgKiBAZGM6IGRjIHN0cnVjdHVyZQo+ICsgKiBAbGlu
a19pbmRleDogbGluayBpbmRleAo+ICsgKiBAcGF5bG9hZDogYXV4IHBheWxvYWQKPiAgICoKPiAt
ICogICAgIEByZXR1cm4KPiAtICogICAgICAgICAgICAgVHJ1ZSBpZiBzdWNjZXNzZnVsLCBGYWxz
ZSBpZiBmYWlsdXJlCj4gLSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgo+ICsgKiBSZXR1cm5zOiBUcnVl
IGlmIHN1Y2Nlc3NmdWwsIEZhbHNlIGlmIGZhaWx1cmUKPiAgICovCj4gIGJvb2wgZGNfcHJvY2Vz
c19kbXViX2F1eF90cmFuc2Zlcl9hc3luYyhzdHJ1Y3QgZGMgKmRjLAo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDMyX3QgbGlua19pbmRleCwKPiBAQCAtMzQyOCwxNiArMzQx
Miw4IEBAIGJvb2wgZGNfcHJvY2Vzc19kbXViX2F1eF90cmFuc2Zlcl9hc3luYyhzdHJ1Y3QgZGMg
KmRjLAo+ICB9Cj4KPiAgLyoqCj4gLSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgo+IC0gKiAgRnVuY3Rp
b246IGRjX2Rpc2FibGVfYWNjZWxlcmF0ZWRfbW9kZQo+IC0gKgo+IC0gKiAgQGJyaWVmCj4gLSAq
ICAgICAgICAgICAgIGRpc2FibGUgYWNjZWxlcmF0ZWQgbW9kZQo+IC0gKgo+IC0gKiAgQHBhcmFt
Cj4gLSAqICAgICAgICAgICAgIFtpbl0gZGM6IGRjIHN0cnVjdHVyZQo+IC0gKgo+IC0gKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioKPiArICogZGNfZGlzYWJsZV9hY2NlbGVyYXRlZF9tb2RlIC0gZGlzYWJs
ZSBhY2NlbGVyYXRlZCBtb2RlCj4gKyAqIEBkYzogZGMgc3RydWN0dXJlCj4gICAqLwo+ICB2b2lk
IGRjX2Rpc2FibGVfYWNjZWxlcmF0ZWRfbW9kZShzdHJ1Y3QgZGMgKmRjKQo+ICB7Cj4gLS0KPiAy
LjMxLjEKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
