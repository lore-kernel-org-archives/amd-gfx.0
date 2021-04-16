Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BAEC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 11:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EAB61153
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 11:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EAB61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EDB16EB8F;
	Fri, 16 Apr 2021 11:26:06 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57CDF6EB8D
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 11:26:05 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id w3so41656535ejc.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 04:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=SQSU0KE65SZvJcJOlDP7DTAwVkQQ/SkbSYgc/NJ9jWg=;
 b=PsW1WW4rbOt9fHLKolvGYjo5oMijupwQyWK2z+iwlgooOOaVB+PKI/7DNM3it32AQc
 X4Juwl+aQwWs1HJOWXXmcJg1/Ys3Vva5snCvkc6qqgA1TleHNiXv0+uBWa+faBRvS1T8
 p7cxXUV58KMpaAEpQkggw1Q4Qc+cqoM0KbmoX4DDnzfn165bAKgiuTMy1KTaKYlBut/N
 CJ85SvYev+huIupPpcBV7z3QJ/eIZMcvvv6HXv9e6/lFKVTqY0Paw7noYIhfnDPhhvLp
 gmf0c5R9I8AJKpdSOTOgCLbl+Iw5X2yePY3ZPHMnq7rzL2OVmf0pUr+q4MSZJy8jlvjI
 Br0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=SQSU0KE65SZvJcJOlDP7DTAwVkQQ/SkbSYgc/NJ9jWg=;
 b=R0ANjGPphtWmg2Fs5C7NfEwkUTL4VawC9Szd8yRv2Pb7u5VMwrAhMJJWhz8rJTS4N9
 gpwLm/d971W2HD6fV73as4zqdCanYGxnwGkiPqjjN4rccQ9h4ub8Es1vmnKD4kMbX6Mc
 tleyK+Ck7c1cU+EE9w0sQHcTfk8X5j9cF8Y/E6TbaQjr4GSN3LvQt66VZw4sZXzjehD/
 IMIdZavRrBbbipPbM7FG3O+Ymgypk8ltHKvkt3WGggk8nUrUXoX0rUVabIbKznK/eFFh
 HUfNErLBS1R+XDL+xoughob5SoAUFtfoC5LSO4PsxCf07DmeGZelNiZZBzZeHaGCR44C
 /1XQ==
X-Gm-Message-State: AOAM532IIMJvEvLagPGkd6tQDCNmaqSMSnXINQafV8qu6dD8d3JRcuSN
 lDjM6zxpuhRqZ2oypBvlcaI=
X-Google-Smtp-Source: ABdhPJxcyv8ptfSLReD0WKEYX6NdYg3hZ6oM3acFrP8Q5Ds6YXDSejUiWNZiuU2H4h4MkRCcywU7jw==
X-Received: by 2002:a17:907:7690:: with SMTP id
 jv16mr7994944ejc.529.1618572363982; 
 Fri, 16 Apr 2021 04:26:03 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7856:2ddb:903a:d51a?
 ([2a02:908:1252:fb60:7856:2ddb:903a:d51a])
 by smtp.gmail.com with ESMTPSA id cn2sm5262225edb.64.2021.04.16.04.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Apr 2021 04:26:03 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
To: Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210416050411.29220-1-Roy.Sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <97a6853d-5c4e-4422-d812-7a4aab0cb500@gmail.com>
Date: Fri, 16 Apr 2021 13:26:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210416050411.29220-1-Roy.Sun@amd.com>
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTYuMDQuMjEgdW0gMDc6MDQgc2NocmllYiBSb3kgU3VuOgo+IFVwZGF0ZSB0aGUgdGltZXN0
YW1wIG9mIHNjaGVkdWxlZCBmZW5jZSBvbiBIVwo+IGNvbXBsZXRpb24gb2YgdGhlIHByZXZpb3Vz
IGZlbmNlcwo+Cj4gVGhpcyBhbGxvdyBtb3JlIGFjY3VyYXRlIHRyYWNraW5nIG9mIHRoZSBmZW5j
ZQo+IGV4ZWN1dGlvbiBpbiBIVwo+Cj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTSBOaWV0byA8ZGF2
aWQubmlldG9AYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBSb3kgU3VuIDxSb3kuU3VuQGFtZC5j
b20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPiBmb3IgdGhlIHNlcmllcy4KCk5pcm1veSBpZiB5b3UgYXJlIGlkbGUgYWdhaW4gY291bGQg
eW91IGdpdmUgdGhhdCBhIHRlc3Rpbmcgcm91bmQ/IEkgCmRvbid0IGV4cGVjdCBpdCB0byBjYXVz
ZSB0cm91YmxlLCBqdXN0IHdhbnQgdG8gZG91YmxlIGNoZWNrIHRoYXQgd2UgCmhhdmVuJ3QgZm9y
Z290dGVuIHRha2luZyBhIGxvY2sgb3Igc3R1ZmYgbGlrZSB0aGF0LgoKVGhhbmtzLApDaHJpc3Rp
YW4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgfCAx
MSArKysrKysrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVk
X21haW4uYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4gaW5kZXgg
OTJkOGRlMjRkMGExLi40ZTVkOGQ0YWYwMTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVy
L3NjaGVkX21haW4uYwo+IEBAIC01MTUsNyArNTE1LDcgQEAgdm9pZCBkcm1fc2NoZWRfcmVzdWJt
aXRfam9icyhzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKQo+ICAgRVhQT1JUX1NZTUJP
TChkcm1fc2NoZWRfcmVzdWJtaXRfam9icyk7Cj4gICAKPiAgIC8qKgo+IC0gKiBkcm1fc2NoZWRf
cmVzdWJtaXRfam9ic19leHQgLSBoZWxwZXIgdG8gcmVsdW5jaCBjZXJ0YWluIG51bWJlciBvZiBq
b2JzIGZyb20gbWlycm9yIHJpbmcgbGlzdAo+ICsgKiBkcm1fc2NoZWRfcmVzdWJtaXRfam9ic19l
eHQgLSBoZWxwZXIgdG8gcmVsdW5jaCBjZXJ0YWluIG51bWJlciBvZiBqb2JzIGZyb20gcGVuZGlu
ZyBsaXN0Cj4gICAgKgo+ICAgICogQHNjaGVkOiBzY2hlZHVsZXIgaW5zdGFuY2UKPiAgICAqIEBt
YXg6IGpvYiBudW1iZXJzIHRvIHJlbGF1bmNoCj4gQEAgLTY3MSw3ICs2NzEsNyBAQCBkcm1fc2No
ZWRfc2VsZWN0X2VudGl0eShzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKQo+ICAgc3Rh
dGljIHN0cnVjdCBkcm1fc2NoZWRfam9iICoKPiAgIGRybV9zY2hlZF9nZXRfY2xlYW51cF9qb2Io
c3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkKPiAgIHsKPiAtCXN0cnVjdCBkcm1fc2No
ZWRfam9iICpqb2I7Cj4gKwlzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqam9iLCAqbmV4dDsKPiAgIAo+
ICAgCS8qCj4gICAJICogRG9uJ3QgZGVzdHJveSBqb2JzIHdoaWxlIHRoZSB0aW1lb3V0IHdvcmtl
ciBpcyBydW5uaW5nICBPUiB0aHJlYWQKPiBAQCAtNjkwLDYgKzY5MCwxMyBAQCBkcm1fc2NoZWRf
Z2V0X2NsZWFudXBfam9iKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQpCj4gICAJaWYg
KGpvYiAmJiBkbWFfZmVuY2VfaXNfc2lnbmFsZWQoJmpvYi0+c19mZW5jZS0+ZmluaXNoZWQpKSB7
Cj4gICAJCS8qIHJlbW92ZSBqb2IgZnJvbSBwZW5kaW5nX2xpc3QgKi8KPiAgIAkJbGlzdF9kZWxf
aW5pdCgmam9iLT5saXN0KTsKPiArCQkvKiBhY2NvdW50IGZvciB0aGUgbmV4dCBmZW5jZSBpbiB0
aGUgcXVldWUgKi8KPiArCQluZXh0ID0gbGlzdF9maXJzdF9lbnRyeV9vcl9udWxsKCZzY2hlZC0+
cGVuZGluZ19saXN0LAo+ICsJCQkJc3RydWN0IGRybV9zY2hlZF9qb2IsIGxpc3QpOwo+ICsJCWlm
IChuZXh0KSB7Cj4gKwkJCW5leHQtPnNfZmVuY2UtPnNjaGVkdWxlZC50aW1lc3RhbXAgPQo+ICsJ
CQkJam9iLT5zX2ZlbmNlLT5maW5pc2hlZC50aW1lc3RhbXA7Cj4gKwkJfQo+ICAgCX0gZWxzZSB7
Cj4gICAJCWpvYiA9IE5VTEw7Cj4gICAJCS8qIHF1ZXVlIHRpbWVvdXQgZm9yIG5leHQgam9iICov
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
