Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD178C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 14:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB4F20829
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 14:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1B0TvkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB4F20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F566E90E;
	Thu, 30 Jul 2020 14:46:43 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF2F46E90E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 14:46:42 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id g19so14437275ejc.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 07:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Gj1ssIjU+Ppz7NQVmR1Q1UNE+8fV3x8j3Pf50etWHT8=;
 b=D1B0TvkXhfrYdlCTIpezWGoYt8fnZYRBzw5zcbfOROCgmMI2jUu2crktLnJDJGgHbm
 iLU4/EDE98EPYZdslS5UandsgmgGIUSz+XsYakq5V6F3neuMbJADtUkb/ftW7TZARIj5
 Or96z24zz8hkTIW1LfB6O9iLOjbj0iuT4sBvRT8KvJqbXzXxKd631Nb4LLStqbWGZEH0
 I1lpsVTzpvwS+rqZi3xpgOvcLl1B7st30YoHJvuSee0lb4Gb4pJsAlxHY7WrRUCa4+6r
 P5p5wzRGcra504Jn/DqsGTips+jdTsDE47KuRgydI9MuU+Dyo9iIKY1i9FyNAGefKI3H
 T2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Gj1ssIjU+Ppz7NQVmR1Q1UNE+8fV3x8j3Pf50etWHT8=;
 b=lyFW3ejop1QQQLUkN9J5KOTtksz74L+b129t1Q9QOO5lQoqOzjp5izP9ZAMDpv0rKl
 iePS84MHsH3d1Qo2bbGLgfSJW7OCUNpDnEukZRNRJf7YpXOZ/TojdHQ7xEvGbpKNDjUF
 qmA8oTvaStX5EPyXcGFaE+bRB6VucPrmNzHdTx3T4a7Mqv10I4moh/2wa8OAqFOipnea
 U5R33YwA9aioFHNXHOy413WCcGMwsChUEmPEwROigJfDTNEQVsXYaPrfeGHYioz7N/ZJ
 O1x8I3fLsG0SjNoRuq7bp2FGnd14aHdzB88D20cmY/bNzp9nxJTM0octS4lXLdzn/ZPV
 X/rw==
X-Gm-Message-State: AOAM533oVoLDGeRPAKeSmx8YuygBv18XNR5V0XfP1c+stc5s4F+G8E//
 z4GOt/hT56RQIrjmwn8jPnSmS62L
X-Google-Smtp-Source: ABdhPJxz7Z3uSI+4VFg25xEYAS761blHcunWtlCEslW7GPpsuU2hMJK/Ajn69oEL264oXuDUe3tCtg==
X-Received: by 2002:a17:906:5ac8:: with SMTP id
 x8mr2934559ejs.486.1596120401126; 
 Thu, 30 Jul 2020 07:46:41 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id i26sm6401322edv.70.2020.07.30.07.46.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 07:46:40 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: new ids flag for tmz (v2)
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200730135457.38848-1-pierre-eric.pelloux-prayer@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <93bcdc83-24b6-5a66-2e73-adea528c2edb@gmail.com>
Date: Thu, 30 Jul 2020 16:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730135457.38848-1-pierre-eric.pelloux-prayer@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzAuMDcuMjAgdW0gMTU6NTQgc2NocmllYiBQaWVycmUtRXJpYyBQZWxsb3V4LVByYXllcjoK
PiBBbGxvd3MgVU1EIHRvIGtub3cgaWYgVE1aIGlzIHN1cHBvcnRlZCBhbmQgZW5hYmxlZC4KPgo+
IFRoaXMgY29tbWl0IGFsc28gYnVtcHMgS01TX0RSSVZFUl9NSU5PUiBiZWNhdXNlIGlmIHdlIGRv
bid0Cj4gVU1EIGNhbid0IHRlbGwgaWYgImlkc19mbGFncyAmIEFNREdQVV9JRFNfRkxBR1NfVE1a
ID09IDAiIG1lYW5zCj4gInRteiBpcyBub3QgZW5hYmxlZCIgb3IgInRteiBtYXkgYmUgZW5hYmxl
ZCBidXQgdGhlIGtlcm5lbCBkb2Vzbid0Cj4gcmVwb3J0IGl0Ii4KPgo+IHYyOiB1c2UgYW1kZ3B1
X2lzX3RteigpIGFuZCByZXdvcmRlZCBjb21taXQgbWVzc2FnZS4KCllvdXIgc2lnbmVkLW9mZi1i
eSBsaW5lIGlzIG1pc3NpbmcsIGJ1dCBhcGFydCBmcm9tIHRoYXQgdGhlIHBhdGNoIGlzIApSZXZp
ZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAt
LS0KPiBQYXRjaCBmb3IgdXNpbmcgaXQgaW4gTWVzYSBpcyBhdCBodHRwczovL2dpdGxhYi5mcmVl
ZGVza3RvcC5vcmcvbWVzYS9tZXNhLy0vbWVyZ2VfcmVxdWVzdHMvNjA0OQo+IChhYy9ncHVfaW5m
bzogYWRkIGRldGVjdGlvbiBvZiBUTVogc3VwcG9ydCkuCj4gSSd2ZSBrZXB0IHRoZSBBTURHUFVf
SURTX0ZMQUdTX1RNWiBuYW1lIHRvIG1hdGNoIHRoZSBleGlzdGluZwo+IEFNREdQVV9JRFNfRkxB
R1NfUFJFRU1QVElPTiBmbGFnLgo+Cj4gUGllcnJlLUVyaWMKPgo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgMyArKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDIgKysKPiAgIGluY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2Ry
bS5oICAgICAgICAgICB8IDEgKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMK
PiBpbmRleCA2MjkxZjVmMGQyMjMuLjZkY2FiMjU5MTRjZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiBAQCAtODgsOSArODgsMTAgQEAKPiAgICAqIC0gMy4z
Ny4wIC0gTDIgaXMgaW52YWxpZGF0ZWQgYmVmb3JlIFNETUEgSUJzLCBuZWVkZWQgZm9yIGNvcnJl
Y3RuZXNzCj4gICAgKiAtIDMuMzguMCAtIEFkZCBBTURHUFVfSUJfRkxBR19FTUlUX01FTV9TWU5D
Cj4gICAgKiAtIDMuMzkuMCAtIERNQUJVRiBpbXBsaWNpdCBzeW5jIGRvZXMgYSBmdWxsIHBpcGVs
aW5lIHN5bmMKPiArICogLSAzLjQwLjAgLSBBZGQgQU1ER1BVX0lEU19GTEFHU19UTVoKPiAgICAq
Lwo+ICAgI2RlZmluZSBLTVNfRFJJVkVSX01BSk9SCTMKPiAtI2RlZmluZSBLTVNfRFJJVkVSX01J
Tk9SCTM5Cj4gKyNkZWZpbmUgS01TX0RSSVZFUl9NSU5PUgk0MAo+ICAgI2RlZmluZSBLTVNfRFJJ
VkVSX1BBVENITEVWRUwJMAo+ICAgCj4gICBpbnQgYW1kZ3B1X3ZyYW1fbGltaXQgPSAwOwo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPiBpbmRleCBlZWJiZTIxMDNlMzIu
LmQzNTNkZWQzNTNiYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfa21zLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21z
LmMKPiBAQCAtNzM2LDYgKzczNiw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2luZm9faW9jdGwoc3Ry
dWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxlCj4gICAJCQlk
ZXZfaW5mby5pZHNfZmxhZ3MgfD0gQU1ER1BVX0lEU19GTEFHU19GVVNJT047Cj4gICAJCWlmIChh
bWRncHVfbWNicCB8fCBhbWRncHVfc3Jpb3ZfdmYoYWRldikpCj4gICAJCQlkZXZfaW5mby5pZHNf
ZmxhZ3MgfD0gQU1ER1BVX0lEU19GTEFHU19QUkVFTVBUSU9OOwo+ICsJCWlmIChhbWRncHVfaXNf
dG16KGFkZXYpKQo+ICsJCQlkZXZfaW5mby5pZHNfZmxhZ3MgfD0gQU1ER1BVX0lEU19GTEFHU19U
TVo7Cj4gICAKPiAgIAkJdm1fc2l6ZSA9IGFkZXYtPnZtX21hbmFnZXIubWF4X3BmbiAqIEFNREdQ
VV9HUFVfUEFHRV9TSVpFOwo+ICAgCQl2bV9zaXplIC09IEFNREdQVV9WQV9SRVNFUlZFRF9TSVpF
Owo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCBiL2luY2x1ZGUv
dWFwaS9kcm0vYW1kZ3B1X2RybS5oCj4gaW5kZXggNzY1YTk0ZWM0NDIwLi5iODI2ZjJkNmVmZTEg
MTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKPiArKysgYi9pbmNs
dWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAo+IEBAIC02NzYsNiArNjc2LDcgQEAgc3RydWN0IGRy
bV9hbWRncHVfY3NfY2h1bmtfZGF0YSB7Cj4gICAgKi8KPiAgICNkZWZpbmUgQU1ER1BVX0lEU19G
TEFHU19GVVNJT04gICAgICAgICAweDEKPiAgICNkZWZpbmUgQU1ER1BVX0lEU19GTEFHU19QUkVF
TVBUSU9OICAgICAweDIKPiArI2RlZmluZSBBTURHUFVfSURTX0ZMQUdTX1RNWiAgICAgICAgICAg
IDB4NAo+ICAgCj4gICAvKiBpbmRpY2F0ZSBpZiBhY2NlbGVyYXRpb24gY2FuIGJlIHdvcmtpbmcg
Ki8KPiAgICNkZWZpbmUgQU1ER1BVX0lORk9fQUNDRUxfV09SS0lORwkJMHgwMAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
