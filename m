Return-Path: <SRS0=bOP+=ZI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2A6C432C3
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 09:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F50120692
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 09:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F50120692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C038D6E06B;
	Sat, 16 Nov 2019 09:32:19 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 907116E06B
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2019 09:32:18 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id f2so13551808wrs.11
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2019 01:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=hrHT9XqR4P6psARlg4/9JVHCpAlcsbYNxYwP1hE2RXA=;
 b=pG4IKcByMlDrrTKquIZ/dw+i9+D5ujYVhDsH9rT1KsZpSWm201K+LhOCFVdPKSmLG3
 9Co4x6+a10Mj/scepwWf7Ifne1grbbMm8Ukh+azsqI58dQvTIT+OgTU15uCUIq3IQq5m
 7IBYkubA0ogf3yPbQES8dsxZpcFIV6pXNx+DoQePCgnJg0ihyFg2bn7acI/UB4BRB2Qr
 MDvuaYsbEO/Hz16uyjPALTt+t+pPr35KyZbEK8oYXldnTN3n2PQaCf6XRR1AqFgR/nbE
 sxprnBtXMYgRavM3/fMnmjotQ6Uhj4AoFsr+6JHvNiP3Uh6MIHw9fcXGFbkX0sWGtirR
 lPDA==
X-Gm-Message-State: APjAAAVbR0sk47IEh1vwUgmE90WYeBHVE7A0r4qF1i9KCaimAfxIx7yo
 ePeuEwXJzOMFaxQmx63OrsR3YbGz
X-Google-Smtp-Source: APXvYqxqYZiLlwOpNEru7fTO3ykcDpxWfo9Y6MOchu93S+gczlophyEhgkiLM/y1rj8sd3u3aiAxsQ==
X-Received: by 2002:a5d:4146:: with SMTP id c6mr19053532wrq.250.1573896737024; 
 Sat, 16 Nov 2019 01:32:17 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y8sm12182239wmi.9.2019.11.16.01.32.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 16 Nov 2019 01:32:16 -0800 (PST)
Subject: Re: [PATCH] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191115223830.29769-1-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <50939675-48ba-6f58-9480-6e3e2bad21da@gmail.com>
Date: Sat, 16 Nov 2019 10:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115223830.29769-1-alex.sierra@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=hrHT9XqR4P6psARlg4/9JVHCpAlcsbYNxYwP1hE2RXA=;
 b=rXC8fMDKLnJ/E/QEEZwBAHIPwjyLmBoWv9qJqvmHgqU/e/ZdSUAK0EARVSggN3txvc
 ifDyo4owMifD07H9UUawqi039kfE8HzFwYHoq5LIgXdZMNJNv8r6BqMa0BpVJtzQih3Q
 NJH8eVrC3SeQ1Mxs9VtiRw5yxccE5rTAxfu8JCMcHLMWzVO6KqAHovbZp/yLsaBqrox2
 yPJOu2w6Oi700feBStjjXjtvX4aTVBWetT3amt7BrJqupaRukQSFnRhLCflLqL5zQiOT
 sesaqe27MnEsPtEbTAsst1DkT0nmThdgUmzMz1btjHYY4kziCAa4Ig7Z8toRsG62E4yF
 F4xQ==
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191116093211.DG3jVtjfdQwsDijnQZXJqBpxjlCE6mYBOX66XJMFhdI@z>

QW0gMTUuMTEuMTkgdW0gMjM6Mzggc2NocmllYiBBbGV4IFNpZXJyYToKPiBBZnRlciBhIHJldHJ5
LWZhdWx0IGhhcHBlbnMsIHRoZSBmYXVsdCBoYW5kbGVyIHdpbGwgbW9kaWZ5IHRoZSBVVENMMiB0
bwo+IHNldCBQVEUgYml0cyB0byBmb3JjZSBhIG5vLXJldHJ5LWZhdWx0LiBUaGlzIHdpbGwgY2F1
c2UgdGhlIHdhdmUgdG8KPiBlbnRlciB0aGUgdHJhcCBoYW5kbGVyLgoKTkFLLCB5b3UgY2FuJ3Qg
ZG8gdGhpcyB1bmNvbmRpdGlvbmFsbHkgc2luY2UgdGhhdCBiZWhhdmlvciBpcyBub3Qgd2FudGVk
IApmb3IgZ3JhcGhpY3MuCgpDaHJpc3RpYW4uCgo+Cj4gQ2hhbmdlLUlkOiBJMTc3MTAyODkxZjcx
NTA2OGYxNTYwNTk1N2ZmMjNiMGNhYjg2MjYwMwo+IFNpZ25lZC1vZmYtYnk6IEFsZXggU2llcnJh
IDxhbGV4LnNpZXJyYUBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgfCAxNSArKysrKysrLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYwo+IGluZGV4IDNjMGJkNjQ3MmE0Ni4uOWFkNzM0NWQzMTVkIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMzE2Nyw3ICszMTY3LDgg
QEAgYm9vbCBhbWRncHVfdm1faGFuZGxlX2ZhdWx0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCB1bnNpZ25lZCBpbnQgcGFzaWQsCj4gICAJCQkgICAgdWludDY0X3QgYWRkcikKPiAgIHsKPiAg
IAlzdHJ1Y3QgYW1kZ3B1X2JvICpyb290Owo+IC0JdWludDY0X3QgdmFsdWUsIGZsYWdzOwo+ICsJ
dWludDY0X3QgdmFsdWUgPSAwOwo+ICsJdWludDY0X3QgZmxhZ3M7Cj4gICAJc3RydWN0IGFtZGdw
dV92bSAqdm07Cj4gICAJbG9uZyByOwo+ICAgCj4gQEAgLTMxOTYsMTcgKzMxOTcsMTUgQEAgYm9v
bCBhbWRncHVfdm1faGFuZGxlX2ZhdWx0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNp
Z25lZCBpbnQgcGFzaWQsCj4gICAJCWdvdG8gZXJyb3JfdW5sb2NrOwo+ICAgCj4gICAJYWRkciAv
PSBBTURHUFVfR1BVX1BBR0VfU0laRTsKPiAtCWZsYWdzID0gQU1ER1BVX1BURV9WQUxJRCB8IEFN
REdQVV9QVEVfU05PT1BFRCB8Cj4gLQkJQU1ER1BVX1BURV9TWVNURU07Cj4gICAKPiAgIAlpZiAo
YW1kZ3B1X3ZtX2ZhdWx0X3N0b3AgPT0gQU1ER1BVX1ZNX0ZBVUxUX1NUT1BfTkVWRVIpIHsKPiAt
CQkvKiBSZWRpcmVjdCB0aGUgYWNjZXNzIHRvIHRoZSBkdW1teSBwYWdlICovCj4gLQkJdmFsdWUg
PSBhZGV2LT5kdW1teV9wYWdlX2FkZHI7Cj4gLQkJZmxhZ3MgfD0gQU1ER1BVX1BURV9FWEVDVVRB
QkxFIHwgQU1ER1BVX1BURV9SRUFEQUJMRSB8Cj4gLQkJCUFNREdQVV9QVEVfV1JJVEVBQkxFOwo+
ICsJCS8qIFNldHRpbmcgUFRFIGZsYWdzIHRvIHRyaWdnZXIgYSBuby1yZXRyeS1mYXVsdCAgKi8K
PiArCQlmbGFncyA9IEFNREdQVV9QVEVfRVhFQ1VUQUJMRSB8IEFNREdQVV9QREVfUFRFIHwKPiAr
CQkJQU1ER1BVX1BURV9URjsKPiAgIAl9IGVsc2Ugewo+ICAgCQkvKiBMZXQgdGhlIGh3IHJldHJ5
IHNpbGVudGx5IG9uIHRoZSBQVEUgKi8KPiAtCQl2YWx1ZSA9IDA7Cj4gKwkJZmxhZ3MgPSBBTURH
UFVfUFRFX1ZBTElEIHwgQU1ER1BVX1BURV9TTk9PUEVEIHwKPiArCQkJQU1ER1BVX1BURV9TWVNU
RU07Cj4gICAJfQo+ICAgCj4gICAJciA9IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhhZGV2
LCB2bSwgdHJ1ZSwgTlVMTCwgYWRkciwgYWRkciArIDEsCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
