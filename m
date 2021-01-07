Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA9CC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 10:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D080820738
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 10:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D080820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C73E6E42D;
	Thu,  7 Jan 2021 10:54:08 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A970F6E10C;
 Thu,  7 Jan 2021 10:54:06 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id d26so5145004wrb.12;
 Thu, 07 Jan 2021 02:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7YYeMhGELMZiAnUMT2kL7gLDNzPP0YU5Iwm5piFtbEg=;
 b=kTPH6LcChytUGrqI6W/ZNuaWbRPoETDxO3KTR7RAg4yLQ8tqE4RRvPneX7k0hSwV47
 Q9DwQSn46fg6adqv6Ic90JnIFPbxko43G3Sok78FCh2yi0Y/anGMjGTw9tdzTeSnXALi
 NNFJDxpL7a2LhgQT/0q44mi2uKpUqXoMMpeHSnOgmMEaOYcng6se75a1eCjEDx8reQHN
 ro2RNQUh4T9wNdjxlwobNmO1qYJK1BkCw1nLtii9uxm3ZPeTXm9Up+TU88G2j/JcoYRh
 K50PJnPMsfjRLJJZi2EO9oWoX9wb8ggyfwYG/i61VJJmk7/h+gE/dVCbLzfhzw3KGmIu
 DNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=7YYeMhGELMZiAnUMT2kL7gLDNzPP0YU5Iwm5piFtbEg=;
 b=qOPEybnzvNlv9pBG/uEjQZE+tNG1ppFAysFFUDddsQupv2ui6r2mcYyTisYWDQeqy1
 237AMtl/aKkvRZ16r/Cje47lTofI7fYsBMX9wOO6gCdi8N5xEURebUPU55USggzeFOhK
 wb/yPaUDVAne/a4Dj85i3s+RoQKhW3gnbR87H+YpfNbcPTDfMeeJLsT8A+FRN+RUfZ+F
 mDvo0nQ9rtfFii9Cz16Pe72gnNBI85PEwjELvNKTahfTocRNlINTl6/WBMTulTsU1faD
 Wp54En0bQOHyG48is6F00jcw0+cDFpl3eG+aVr65y+w6mepON6XyRfl1SjAoPz2brhcJ
 fASw==
X-Gm-Message-State: AOAM533HmHBkbMfNfdUbsrlY03Dgs+ewfGct5bOFxXaq8U3mCu7I85t9
 LFR7fQKMFOVeqdnVL8l64vU=
X-Google-Smtp-Source: ABdhPJyNpDzR3TzC2skJ+Q8MLS7dVJyn2jRHr7GklPbkZxDqWnSIfo7rly3CDGJY34cFZc/la9bSOQ==
X-Received: by 2002:a05:6000:90:: with SMTP id
 m16mr8467721wrx.165.1610016845464; 
 Thu, 07 Jan 2021 02:54:05 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id r2sm7644711wrn.83.2021.01.07.02.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Jan 2021 02:54:05 -0800 (PST)
Subject: Re: [PATCH 12/35] drm/amdgpu: export vm update mapping interface
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20210107030127.20393-1-Felix.Kuehling@amd.com>
 <20210107030127.20393-13-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9d37e791-98fb-38fc-6760-ee3965841ad5@gmail.com>
Date: Thu, 7 Jan 2021 11:54:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107030127.20393-13-Felix.Kuehling@amd.com>
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
Cc: alex.sierra@amd.com, Philip Yang <Philip.Yang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDcuMDEuMjEgdW0gMDQ6MDEgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBGcm9tOiBQaGls
aXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KPgo+IEl0IHdpbGwgYmUgdXNlZCBieSBrZmQg
dG8gbWFwIHN2bSByYW5nZSB0byBHUFUsIGJlY2F1c2Ugc3ZtIHJhbmdlIGRvZXMKPiBub3QgaGF2
ZSBhbWRncHVfYm8gYW5kIGJvX3ZhLCBjYW5ub3QgdXNlIGFtZGdwdV9ib191cGRhdGUgaW50ZXJm
YWNlLCB1c2UKPiBhbWRncHUgdm0gdXBkYXRlIGludGVyZmFjZSBkaXJlY3RseS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQuY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDE3ICsrKysrKysrLS0tLS0t
LS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCB8IDEwICsrKysr
KysrKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggZmRiZTdk
NGU4YjhiLi45YzU1N2U4YmYwZTUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYwo+IEBAIC0xNTg5LDE1ICsxNTg5LDE0IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3Vw
ZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAo+ICAgICog
UmV0dXJuczoKPiAgICAqIDAgZm9yIHN1Y2Nlc3MsIC1FSU5WQUwgZm9yIGZhaWx1cmUuCj4gICAg
Ki8KPiAtc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCj4gLQkJCQkgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmJvX2Fk
ZXYsCj4gLQkJCQkgICAgICAgc3RydWN0IGFtZGdwdV92bSAqdm0sIGJvb2wgaW1tZWRpYXRlLAo+
IC0JCQkJICAgICAgIGJvb2wgdW5sb2NrZWQsIHN0cnVjdCBkbWFfcmVzdiAqcmVzdiwKPiAtCQkJ
CSAgICAgICB1aW50NjRfdCBzdGFydCwgdWludDY0X3QgbGFzdCwKPiAtCQkJCSAgICAgICB1aW50
NjRfdCBmbGFncywgdWludDY0X3Qgb2Zmc2V0LAo+IC0JCQkJICAgICAgIHN0cnVjdCBkcm1fbW1f
bm9kZSAqbm9kZXMsCj4gLQkJCQkgICAgICAgZG1hX2FkZHJfdCAqcGFnZXNfYWRkciwKPiAtCQkJ
CSAgICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2UpCj4gK2ludCBhbWRncHVfdm1fYm9fdXBk
YXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gKwkJCQlzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYm9fYWRldiwKPiArCQkJCXN0cnVjdCBhbWRncHVfdm0gKnZtLCBib29sIGlt
bWVkaWF0ZSwKPiArCQkJCWJvb2wgdW5sb2NrZWQsIHN0cnVjdCBkbWFfcmVzdiAqcmVzdiwKPiAr
CQkJCXVpbnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBsYXN0LCB1aW50NjRfdCBmbGFncywKPiArCQkJ
CXVpbnQ2NF90IG9mZnNldCwgc3RydWN0IGRybV9tbV9ub2RlICpub2RlcywKPiArCQkJCWRtYV9h
ZGRyX3QgKnBhZ2VzX2FkZHIsCj4gKwkJCQlzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2UpCj4gICB7
Cj4gICAJc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zIHBhcmFtczsKPiAgIAllbnVtIGFt
ZGdwdV9zeW5jX21vZGUgc3luY19tb2RlOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5oCj4gaW5kZXggMmJmNGVmNWZiM2UxLi43M2NhNjMwNTIwZmQgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAo+IEBAIC0zNjYsNiArMzY2LDggQEAgc3RydWN0
IGFtZGdwdV92bV9tYW5hZ2VyIHsKPiAgIAlzcGlubG9ja190CQkJCXBhc2lkX2xvY2s7Cj4gICB9
Owo+ICAgCj4gK3N0cnVjdCBhbWRncHVfYm9fdmFfbWFwcGluZzsKPiArCj4gICAjZGVmaW5lIGFt
ZGdwdV92bV9jb3B5X3B0ZShhZGV2LCBpYiwgcGUsIHNyYywgY291bnQpICgoYWRldiktPnZtX21h
bmFnZXIudm1fcHRlX2Z1bmNzLT5jb3B5X3B0ZSgoaWIpLCAocGUpLCAoc3JjKSwgKGNvdW50KSkp
Cj4gICAjZGVmaW5lIGFtZGdwdV92bV93cml0ZV9wdGUoYWRldiwgaWIsIHBlLCB2YWx1ZSwgY291
bnQsIGluY3IpICgoYWRldiktPnZtX21hbmFnZXIudm1fcHRlX2Z1bmNzLT53cml0ZV9wdGUoKGli
KSwgKHBlKSwgKHZhbHVlKSwgKGNvdW50KSwgKGluY3IpKSkKPiAgICNkZWZpbmUgYW1kZ3B1X3Zt
X3NldF9wdGVfcGRlKGFkZXYsIGliLCBwZSwgYWRkciwgY291bnQsIGluY3IsIGZsYWdzKSAoKGFk
ZXYpLT52bV9tYW5hZ2VyLnZtX3B0ZV9mdW5jcy0+c2V0X3B0ZV9wZGUoKGliKSwgKHBlKSwgKGFk
ZHIpLCAoY291bnQpLCAoaW5jciksIChmbGFncykpKQo+IEBAIC0zOTcsNiArMzk5LDE0IEBAIGlu
dCBhbWRncHVfdm1fY2xlYXJfZnJlZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJ
CQkgIHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSk7Cj4gICBpbnQgYW1kZ3B1X3ZtX2hhbmRsZV9t
b3ZlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkJCSAgIHN0cnVjdCBhbWRncHVf
dm0gKnZtKTsKPiAraW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKPiArCQkJCXN0cnVjdCBhbWRncHVfZGV2aWNlICpib19hZGV2LAo+ICsJ
CQkJc3RydWN0IGFtZGdwdV92bSAqdm0sIGJvb2wgaW1tZWRpYXRlLAo+ICsJCQkJYm9vbCB1bmxv
Y2tlZCwgc3RydWN0IGRtYV9yZXN2ICpyZXN2LAo+ICsJCQkJdWludDY0X3Qgc3RhcnQsIHVpbnQ2
NF90IGxhc3QsIHVpbnQ2NF90IGZsYWdzLAo+ICsJCQkJdWludDY0X3Qgb2Zmc2V0LCBzdHJ1Y3Qg
ZHJtX21tX25vZGUgKm5vZGVzLAo+ICsJCQkJZG1hX2FkZHJfdCAqcGFnZXNfYWRkciwKPiArCQkJ
CXN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSk7Cj4gICBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkJCXN0cnVjdCBhbWRncHVfYm9fdmEgKmJv
X3ZhLAo+ICAgCQkJYm9vbCBjbGVhcik7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
