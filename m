Return-Path: <SRS0=sYuP=EU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38419C5519F
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2020 08:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1F3205CA
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2020 08:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAwhVJPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1F3205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C7056E8F9;
	Sat, 14 Nov 2020 08:43:41 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 971CC6E8FA
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2020 08:43:39 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id cw8so17254085ejb.8
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2020 00:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=iCK8vXynABB/5srdPFB+7ey35YOlCN5J9VsjGeser8g=;
 b=bAwhVJPW+oeLG0XJSUqeRCcjeoWuZfbfW8BSoSATKlwO+oO9kWDcN23o4fKrt+2y4H
 glU6Qzgx1TGEWG+N15jEmxEKnqED7XGhIP9YvFkD4kao2yOzVVpi1sQ2mrrbGrsxTROL
 vO9ObZb9Gt69bOCWIzoJllTQHbvbTK51Xs9sUaC7gveOysJoZAfcqvFbX1xipyHRj6T6
 zaqIEoxAuXH76qylbReURKrWou8zOVoYzloFmGBskM6QeAtUrKifRsEZ90x9VtgZWCea
 GEpkQ0+ymTkLsDwXIwfdMQCt9EYqTBgUMM8VBg2iJOhDMsk9mVewElI+Mmlz/OfuO8XK
 cd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=iCK8vXynABB/5srdPFB+7ey35YOlCN5J9VsjGeser8g=;
 b=s0aA9iI9QEhVPBDtpkPjpobPViCxiQmwmI9Cs9r/Q5SI9cIy3s7gEvR4i9UKiWa2IL
 0GkAKlIE05BViAV0w/7bJ49z2kC6Se9ccfG+Ot/0ZrXJVzUZAmkQTeRkFtvobrogduX/
 HmgMF6R7ASbOTOkx4nOowGssvrLDghlQ7K+HN1A6wZ0NnvK8CezZKofqLFUe0hj3TtsX
 U8wlGC7t2U1MsQOPeTw8qO8E6IgCGV0WbA7TQiSRFiSSbHhglYiXL3u+sLxohkG6oAVf
 44AxGD9rdvh9MToZMoEpoNNU2AmKawUaeUPxlhNvF8Ml+2auPb0LKkGUBKG5jeu9HvlQ
 RKEA==
X-Gm-Message-State: AOAM5316i4RZxn9h0T8GW500ECy57XO5Ca6kxLqTnP2re/2jN+qyYyGX
 32caEYZ+EwElwJ6MERHXkZM=
X-Google-Smtp-Source: ABdhPJzGospmwA1MM4UZrs0FCv1bA5NAJaouySRSAWsU4X0PeIEJAWXSaso0O8Xt2RdyWNfXAVEXxQ==
X-Received: by 2002:a17:906:4c41:: with SMTP id
 d1mr6081733ejw.485.1605343418279; 
 Sat, 14 Nov 2020 00:43:38 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:2086:a6aa:197c:bcb?
 ([2a02:908:1252:fb60:2086:a6aa:197c:bcb])
 by smtp.gmail.com with ESMTPSA id g20sm6134824ejk.3.2020.11.14.00.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2020 00:43:37 -0800 (PST)
Subject: Re: [PATCH 1/1] drm/amdgpu: fix usable gart size calculation
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201113173346.38622-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <914c052b-ff19-4371-45e1-c06cc9eb1b9a@gmail.com>
Date: Sat, 14 Nov 2020 09:43:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113173346.38622-1-nirmoy.das@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTMuMTEuMjAgdW0gMTg6MzMgc2NocmllYiBOaXJtb3kgRGFzOgo+IGFtZGdwdV9kb190ZXN0
X21vdmVzKCkgaXMgZmFpbGluZyBiZWNhdXNlIG9mIHdyb25nCj4gdXNhYmxlIGdhcnQgc2l6ZSBj
YWxjdWxhdGlvbiBhbmQgdGhyb3dpbmc6Cj4KPiBbZHJtOmFtZGdwdV9kb190ZXN0X21vdmVzIFth
bWRncHVdXSAqRVJST1IqIDAwMDAwMDAwMjBiZGM5ZjMgYmluZCBmYWlsZWQKPgo+IFNpZ25lZC1v
ZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rlc3QuYyB8IDEzICsrKystLS0tLS0tLS0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rlc3QuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90ZXN0LmMKPiBpbmRleCA2MDQyYjNiODFhNGMu
LjdiMjMwYmNiZjJjNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdGVzdC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rl
c3QuYwo+IEBAIC00MiwxNiArNDIsMTEgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RvX3Rlc3RfbW92
ZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJc2l6ZSA9IDEwMjQgKiAxMDI0Owo+
ICAgCj4gICAJLyogTnVtYmVyIG9mIHRlc3RzID0KPiAtCSAqIChUb3RhbCBHVFQgLSBJQiBwb29s
IC0gd3JpdGViYWNrIHBhZ2UgLSByaW5nIGJ1ZmZlcnMpIC8gdGVzdCBzaXplCj4gKwkgKiAoVG90
YWwgR1RUIC0gZ2FydF9waW5fc2l6ZSAtICgyIHRyYW5zZmVyIHdpbmRvd3MgZm9yIGJ1ZmZlciBt
b3ZlcykpIC8gdGVzdCBzaXplCj4gICAJICovCj4gLQluID0gYWRldi0+Z21jLmdhcnRfc2l6ZSAt
IEFNREdQVV9JQl9QT09MX1NJWkU7Cj4gLQlmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9SSU5H
UzsgKytpKQo+IC0JCWlmIChhZGV2LT5yaW5nc1tpXSkKPiAtCQkJbiAtPSBhZGV2LT5yaW5nc1tp
XS0+cmluZ19zaXplOwo+IC0JaWYgKGFkZXYtPndiLndiX29iaikKPiAtCQluIC09IEFNREdQVV9H
UFVfUEFHRV9TSVpFOwo+IC0JaWYgKGFkZXYtPmlycS5paC5yaW5nX29iaikKPiAtCQluIC09IGFk
ZXYtPmlycS5paC5yaW5nX3NpemU7Cj4gKwluID0gYWRldi0+Z21jLmdhcnRfc2l6ZSAtIGF0b21p
YzY0X3JlYWQoJmFkZXYtPmdhcnRfcGluX3NpemUpOwo+ICsJbiAtPSBBTURHUFVfR1RUX01BWF9U
UkFOU0ZFUl9TSVpFICogQU1ER1BVX0dUVF9OVU1fVFJBTlNGRVJfV0lORE9XUyAqCj4gKwkJQU1E
R1BVX0dQVV9QQUdFX1NJWkU7Cj4gICAJbiAvPSBzaXplOwo+ICAgCj4gICAJZ3R0X29iaiA9IGtj
YWxsb2Mobiwgc2l6ZW9mKCpndHRfb2JqKSwgR0ZQX0tFUk5FTCk7CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
