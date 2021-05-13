Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5198C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 07:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888956008E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 07:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888956008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB4EF6E851;
	Thu, 13 May 2021 07:57:02 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 524826E851
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 07:57:01 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id w3so38678063ejc.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 00:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=SGspoSiWWeO05p0idByqkzj7gns1gkPL6aCjtxZXsfk=;
 b=TiFV3eyEi7qCXvQsNux0S3lu2EwnLCjVFD93KY5zOJepLCTKuUPdGjnKLzMOVL1Od/
 hBWBOPRn32DGdkKRtyIrxI9hTECZWu+BeMQ3XH3y7SXHjHX1GngZSUE0sGHk3Lo+C5UP
 kqxx/Q00P5vP1hEoMKLoMwU8txoXYHzoT8mTbeMLtmWaGfc8j91Lk42OHzy1CxdAirs6
 C7YN8/gD1LQkz0A3eua2yNb7HbatDFoUUI2KKXyHv4PYhdqCNDQ7VvUsYgPOfMv3Og2g
 3BmD3MLb9CaIrgl0GaZ2sK5BeIuZvJjS1iBDYEDd7lPQU+FyccMeF6Hvsnk9cOkW1gZ2
 8EhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=SGspoSiWWeO05p0idByqkzj7gns1gkPL6aCjtxZXsfk=;
 b=L9xdl2Jv3ZTYX1g3vBNeLMy+lZJFlATZ3DpO4SrXS14LzHg+l64YIvTFxbNeqedfpk
 lqWADkDJIqUz8IBqocNg/uWabVF7kbprTz463y/ksyX4HF5jV1V7tjac39hTmrzHZAlk
 J0o6PVZCIMpUNovmK90phDFYyuOL6oo6hiqajgur9FHtjSS86NoYvjwPODy57TnMQ2cK
 OvQHOwTkAlnHrz18k7zR1cZ4jjtRKkMvde/B0s05ipOQf4ORanzmNrx3O97gzr4Hc8J9
 vu79KdvtNVf1hVHliO7sqRxxU1oPXBq4GRWvWm50SMvuL/BjE0Cu/GIsDjX4HjiOUbIg
 daxQ==
X-Gm-Message-State: AOAM533FCCCoxPni8/RotiwpAtVI95Qn5xbKhH3dgcvjj+wc+/plYRcm
 vF3ZYrYxkjwEB4s9+nu2gK4=
X-Google-Smtp-Source: ABdhPJy0pyb0ROfCLqDeYFGZ62bJEOpCeBY7EPqDa9mekMR2s9avY+9GSRzB0VAx8sXu40XRho5Djw==
X-Received: by 2002:a17:906:d978:: with SMTP id
 rp24mr42545397ejb.333.1620892619962; 
 Thu, 13 May 2021 00:56:59 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:1e3f:7b0a:2eb9:c6dc?
 ([2a02:908:1252:fb60:1e3f:7b0a:2eb9:c6dc])
 by smtp.gmail.com with ESMTPSA id jt11sm1403774ejb.83.2021.05.13.00.56.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 May 2021 00:56:59 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: Don't query CE and UE errors
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210512170302.64951-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9d7f82e8-6528-154f-9a23-bf78ff249505@gmail.com>
Date: Thu, 13 May 2021 09:56:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512170302.64951-1-luben.tuikov@amd.com>
Content-Language: en-US
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>, stable@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxMi4wNS4yMSB1bSAxOTowMyBzY2hyaWViIEx1YmVuIFR1aWtvdjoKPiBPbiBRVUVSWTIg
SU9DVEwgZG9uJ3QgcXVlcnkgY291bnRzIG9mIGNvcnJlY3RhYmxlCj4gYW5kIHVuY29ycmVjdGFi
bGUgZXJyb3JzLCBzaW5jZSB3aGVuIFJBUyBpcwo+IGVuYWJsZWQgYW5kIHN1cHBvcnRlZCBvbiBW
ZWdhMjAgc2VydmVyIGJvYXJkcywKPiB0aGlzIHRha2VzIGluc3VybW91bnRhYmx5IGxvbmcgdGlt
ZSwgaW4gTyhuXjMpLAo+IHdoaWNoIHNsb3dzIHRoZSBzeXN0ZW0gZG93biB0byB0aGUgcG9pbnQg
b2YgaXQKPiBiZWluZyB1bnVzYWJsZSB3aGVuIHdlIGhhdmUgR1VJIHVwLgo+Cj4gRml4ZXM6IGFl
MzYzYTIxMmIxNCAoImRybS9hbWRncHU6IEFkZCBhIG5ldyBmbGFnIHRvIEFNREdQVV9DVFhfT1Bf
UVVFUllfU1RBVEUyIikKPiBDYzogQWxleGFuZGVyIERldWNoZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+Cj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBM
dWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIHwgMjYgKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+IGluZGV4IDAxZmU2MGZl
ZGNiZS4uZDQ4MWEzM2Y0ZWFmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9jdHguYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9jdHguYwo+IEBAIC0zNjMsMTkgKzM2MywxOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9jdHhfcXVl
cnkyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCQlvdXQtPnN0YXRlLmZsYWdzIHw9
IEFNREdQVV9DVFhfUVVFUlkyX0ZMQUdTX0dVSUxUWTsKPiAgIAo+ICAgCS8qcXVlcnkgdWUgY291
bnQqLwo+IC0JcmFzX2NvdW50ZXIgPSBhbWRncHVfcmFzX3F1ZXJ5X2Vycm9yX2NvdW50KGFkZXYs
IGZhbHNlKTsKPiAtCS8qcmFzIGNvdW50ZXIgaXMgbW9ub3RvbmljIGluY3JlYXNpbmcqLwo+IC0J
aWYgKHJhc19jb3VudGVyICE9IGN0eC0+cmFzX2NvdW50ZXJfdWUpIHsKPiAtCQlvdXQtPnN0YXRl
LmZsYWdzIHw9IEFNREdQVV9DVFhfUVVFUlkyX0ZMQUdTX1JBU19VRTsKPiAtCQljdHgtPnJhc19j
b3VudGVyX3VlID0gcmFzX2NvdW50ZXI7Cj4gLQl9Cj4gLQo+IC0JLypxdWVyeSBjZSBjb3VudCov
Cj4gLQlyYXNfY291bnRlciA9IGFtZGdwdV9yYXNfcXVlcnlfZXJyb3JfY291bnQoYWRldiwgdHJ1
ZSk7Cj4gLQlpZiAocmFzX2NvdW50ZXIgIT0gY3R4LT5yYXNfY291bnRlcl9jZSkgewo+IC0JCW91
dC0+c3RhdGUuZmxhZ3MgfD0gQU1ER1BVX0NUWF9RVUVSWTJfRkxBR1NfUkFTX0NFOwo+IC0JCWN0
eC0+cmFzX2NvdW50ZXJfY2UgPSByYXNfY291bnRlcjsKPiAtCX0KPiArCS8qIHJhc19jb3VudGVy
ID0gYW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9jb3VudChhZGV2LCBmYWxzZSk7ICovCj4gKwkvKiAv
XCpyYXMgY291bnRlciBpcyBtb25vdG9uaWMgaW5jcmVhc2luZypcLyAqLwo+ICsJLyogaWYgKHJh
c19jb3VudGVyICE9IGN0eC0+cmFzX2NvdW50ZXJfdWUpIHsgKi8KPiArCS8qIAlvdXQtPnN0YXRl
LmZsYWdzIHw9IEFNREdQVV9DVFhfUVVFUlkyX0ZMQUdTX1JBU19VRTsgKi8KPiArCS8qIAljdHgt
PnJhc19jb3VudGVyX3VlID0gcmFzX2NvdW50ZXI7ICovCj4gKwkvKiB9ICovCj4gKwo+ICsJLyog
L1wqcXVlcnkgY2UgY291bnQqXC8gKi8KPiArCS8qIHJhc19jb3VudGVyID0gYW1kZ3B1X3Jhc19x
dWVyeV9lcnJvcl9jb3VudChhZGV2LCB0cnVlKTsgKi8KPiArCS8qIGlmIChyYXNfY291bnRlciAh
PSBjdHgtPnJhc19jb3VudGVyX2NlKSB7ICovCj4gKwkvKiAJb3V0LT5zdGF0ZS5mbGFncyB8PSBB
TURHUFVfQ1RYX1FVRVJZMl9GTEFHU19SQVNfQ0U7ICovCj4gKwkvKiAJY3R4LT5yYXNfY291bnRl
cl9jZSA9IHJhc19jb3VudGVyOyAqLwo+ICsJLyogfSAqLwoKUGxlYXNlIGNvbXBsZXRlbHkgZHJv
cCB0aGUgY29kZS4gV2UgdXN1YWxseSBkb24ndCBrZWVwIGNvbW1lbnRlZCBvdXQgCmNvZGUgaW4g
dGhlIGRyaXZlci4KCldpdGggdGhhdCBkb25lIHRoZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyAKPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCkNocmlzdGlhbi4KCj4g
ICAKPiAgIAltdXRleF91bmxvY2soJm1nci0+bG9jayk7Cj4gICAJcmV0dXJuIDA7CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
