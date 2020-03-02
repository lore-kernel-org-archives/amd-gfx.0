Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBB6C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5852173E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKUTkbmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5852173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8D389F89;
	Mon,  2 Mar 2020 12:28:08 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A71F89F89
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 12:28:07 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id e26so4892948wme.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2020 04:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Ibmq0rh7G6R92QzSD9U+A7qVQUvAhcAhiJp07c6cTn0=;
 b=uKUTkbmYIv5Nlj5Cfp1DbCbDLlEgaAfbco26Wy453bM1XTZF0apl+Nl9n3h5GT/eGq
 ws7ShqwSwePN/GyOCh7lDg2gQqojjDtnuixYXeUBinE6jIYWnoCWW/LeaSTOV+jZysoF
 Xy28RJyJ1lJEA2C43+yCgIpcwG4SK9Q+TzPLUD0l4Jn5ARf0CpM5v4Whj2RJPv5wAcKo
 YgEOHqKGzA8st+nXDeePhOguScOOLRzN6dlmqiPkgL2qOSV+T6q1NOGnbfZ6QI1L0Xq6
 pvpo/wvwiN+UDJgRU8RL0BXGWCn8mW89Hnuf5Yf2sP8PLcUSB4IxdcLABrPs0M/JjGFm
 ysmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Ibmq0rh7G6R92QzSD9U+A7qVQUvAhcAhiJp07c6cTn0=;
 b=LZpBwkzWv8+UdsH1QyXxnM1NjrsUdeZKFom2o6g57FNivmYZskqcWSk1n905qvE9lq
 5I4lhZcruo2srznTMdymhgfC9rY/SPnENaGL9gaOozHpZvaBxXwux+4JN40bSnbMuMZ5
 beaBMQ/i2oXECYJ+vnkspDAzTzSHoWF7i84Hiv7j8OdglqZtHPgoIEUo344qV1eaQczA
 cZXFC6qmOJJkTaIKvcaJjS36JieVbVO5gZxiC/ViDmyQYp/BksNDuzaV71324/0v7zjW
 okC+Lt5GRi+CSFg2EbNlRiTEIyM1O3PUYvADloOeb2eKBVqP3s0YPvRK5Jvyca7kFezQ
 qjwA==
X-Gm-Message-State: ANhLgQ3e8FIHk/3B5NLYdV0NcJ3Krgr9AA0tdR7gf2PzxoDWVMPV0Ou+
 t5E/3kdJys2YXcEVpc0ilrottRZe
X-Google-Smtp-Source: ADFU+vsgSPW4nmg74hPYQ+Chdj3tpbEVG+ir2H7jCNpCpv+Zc9sjBTuzdRLKs0EGzDRPczFFsdnUKA==
X-Received: by 2002:a1c:1b13:: with SMTP id b19mr1972714wmb.91.1583152085688; 
 Mon, 02 Mar 2020 04:28:05 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j4sm16594632wrr.0.2020.03.02.04.28.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2020 04:28:04 -0800 (PST)
Subject: Re: [PATCH v3 3/4] drm/amdgpu: change hw sched list on ctx priority
 override
To: Nirmoy <nirmodas@amd.com>, christian.koenig@amd.com,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200302095234.3638-1-nirmoy.das@amd.com>
 <20200302095234.3638-3-nirmoy.das@amd.com>
 <e3cd9281-fa33-2050-f69a-261444f26bf5@gmail.com>
 <f687e152-a1e1-49f6-a81d-c09ec8f5d6ee@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4c592b11-6d1b-562f-1563-d0c3e863d860@gmail.com>
Date: Mon, 2 Mar 2020 13:28:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f687e152-a1e1-49f6-a81d-c09ec8f5d6ee@amd.com>
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDMuMjAgdW0gMTM6Mjcgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAzLzIvMjAgMToxMCBQ
TSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDIuMDMuMjAgdW0gMTA6NTIgc2Nocmll
YiBOaXJtb3kgRGFzOgo+Pj4gU3dpdGNoIHRvIGFwcHJvcHJpYXRlIHNjaGVkIGxpc3QgZm9yIGFu
IGVudGl0eSBvbiBwcmlvcml0eSBvdmVycmlkZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBOaXJt
b3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyB8IDMwIAo+Pj4gKysrKysrKysrKysrKysrKysrKysr
LS0tLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9jdHguYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4+
PiBpbmRleCA0MjY2ZGExZjM5NzcuLjU3NDQ1YTYxYTRjZCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4+PiBAQCAtNTIyLDYgKzUyMiwzMCBAQCBzdHJ1
Y3QgZG1hX2ZlbmNlICphbWRncHVfY3R4X2dldF9mZW5jZShzdHJ1Y3QgCj4+PiBhbWRncHVfY3R4
ICpjdHgsCj4+PiDCoMKgwqDCoMKgIHJldHVybiBmZW5jZTsKPj4+IMKgIH0KPj4+Cj4+PiArc3Rh
dGljIHZvaWQgYW1kZ3B1X2N0eF9zZXRfZW50aXR5X3ByaW9yaXR5KHN0cnVjdCBhbWRncHVfY3R4
ICpjdHgsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBh
bWRncHVfY3R4X2VudGl0eSAqYWVudGl0eSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaW50IGh3X2lwLCBlbnVtIGRybV9zY2hlZF9wcmlvcml0eSBwcmlvcml0eSkK
Pj4+ICt7Cj4+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gY3R4LT5hZGV2
Owo+Pj4gK8KgwqDCoCBlbnVtIGdmeF9waXBlX3ByaW9yaXR5IGNvbXB1dGVfcHJpb3JpdHk7Cj4+
Cj4+IE1heWJlIHVzZSBzb21lIHNob3J0ZXIgbmFtZSwgZS5nLiBod19wcmlvIG9yIHNvbWV0aGlu
ZyBsaWtlIHRoYXQuCj4+Cj4+PiArwqDCoMKgIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqKnNj
aGVkcyA9IE5VTEw7Cj4+PiArwqDCoMKgIHVuc2lnbmVkIG51bV9zY2hlZHMgPSAwOwo+Pgo+PiBE
b24ndCBpbml0aWFsaXplIHRob3NlIGhlcmUuCj4+Cj4+PiArCj4+PiArwqDCoMKgIHN3aXRjaCAo
aHdfaXApIHsKPj4+ICvCoMKgwqAgY2FzZSBBTURHUFVfSFdfSVBfQ09NUFVURToKPj4+ICvCoMKg
wqDCoMKgwqDCoCBjb21wdXRlX3ByaW9yaXR5ID0KPj4+ICsgYW1kZ3B1X2N0eF9zY2hlZF9wcmlv
X3RvX2NvbXB1dGVfcHJpbyhwcmlvcml0eSk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgc2NoZWRzID0g
YWRldi0+Z2Z4LmNvbXB1dGVfcHJpb19zY2hlZFtjb21wdXRlX3ByaW9yaXR5XTsKPj4+ICvCoMKg
wqDCoMKgwqDCoCBudW1fc2NoZWRzID0gYWRldi0+Z2Z4Lm51bV9jb21wdXRlX3NjaGVkW2NvbXB1
dGVfcHJpb3JpdHldOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4gK8KgwqDCoCBkZWZh
dWx0Ogo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4+ICvCoMKgwqAgfQo+Pj4gKwo+Pj4g
K8KgwqDCoCBkcm1fc2NoZWRfZW50aXR5X21vZGlmeV9zY2hlZCgmYWVudGl0eS0+ZW50aXR5LCBz
Y2hlZHMsIAo+Pj4gbnVtX3NjaGVkcyk7Cj4+Cj4+IFRoYXQgbmVlZHMgdG8gYmUgdW5kZXIgdGhl
ICJjYXNlIEFNREdQVV9IV19JUF9DT01QVVRFIiBvciBvdGhlcndpc2UgCj4+IHdlIHNldCB0aGUg
c2NoZWR1bGVycyB0byBOVUxMIGZvciBTRE1BLgo+IFNETUEgd2lsbCBmYWxsIGludG/CoCBkZWZh
dWx0IGNhc2Ugd2hpY2ggd2lsbCByZXR1cm4gZnJvbSB0aGUgZnVuY3Rpb24gCj4gaW1tZWRpYXRl
bHkuCgpPaCwgdGhhdCdzIGEgYmFkIGlkZWEuIFdlIHN0aWxsIHdhbnQgdGhlIGNhbGwgdG8gCmRy
bV9zY2hlZF9lbnRpdHlfc2V0X3ByaW9yaXR5KCkgaW4gdGhpcyBjYXNlLgoKTWF5YmUgbW92ZSB0
aGUgY2FsbCB0byBkcm1fc2NoZWRfZW50aXR5X3NldF9wcmlvcml0eSgpIGFib3ZlIHRoZSBzd2l0
Y2g/CgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Pgo+PiBSZWdhcmRzLAo+PiBDaHJpc3RpYW4uCj4+
Cj4+PiArIGRybV9zY2hlZF9lbnRpdHlfc2V0X3ByaW9yaXR5KCZhZW50aXR5LT5lbnRpdHksIHBy
aW9yaXR5KTsKPj4+ICt9Cj4+PiArCj4+PiDCoCB2b2lkIGFtZGdwdV9jdHhfcHJpb3JpdHlfb3Zl
cnJpZGUoc3RydWN0IGFtZGdwdV9jdHggKmN0eCwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGVudW0gZHJtX3NjaGVkX3ByaW9yaXR5IHByaW9yaXR5KQo+Pj4gwqAg
ewo+Pj4gQEAgLTUzNCwxMyArNTU4LDExIEBAIHZvaWQgYW1kZ3B1X2N0eF9wcmlvcml0eV9vdmVy
cmlkZShzdHJ1Y3QgCj4+PiBBTURHUFVfR0ZYX1BJUEVfUFJJT19NQVgKPj4+IGFtZGdwdV9jdHgg
KmN0eCwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN0eC0+aW5pdF9wcmlvcml0eSA6
IGN0eC0+b3ZlcnJpZGVfcHJpb3JpdHk7Cj4+PiDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBB
TURHUFVfSFdfSVBfTlVNOyArK2kpIHsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgKGogPSAw
OyBqIDwgYW1kZ3B1X2N0eF9udW1fZW50aXRpZXNbaV07ICsraikgewo+Pj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eTsKPj4+IC0KPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghY3R4LT5lbnRpdGllc1tpXVtqXSkKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+Pgo+Pj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZW50aXR5ID0gJmN0eC0+ZW50aXRpZXNbaV1bal0tPmVudGl0eTsK
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRybV9zY2hlZF9lbnRpdHlfc2V0X3ByaW9yaXR5
KGVudGl0eSwgY3R4X3ByaW8pOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2N0
eF9zZXRfZW50aXR5X3ByaW9yaXR5KGN0eCwgY3R4LT5lbnRpdGllc1tpXVtqXSwKPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aSwgY3R4X3ByaW8pOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+IMKgwqDCoMKgwqAgfQo+
Pj4gwqAgfQo+Pj4gLS0gCj4+PiAyLjI1LjAKPj4+Cj4+PiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3Rv
cC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0Nu
aXJtb3kuZGFzJTQwYW1kLmNvbSU3Q2NlY2U0MGIxM2JhNzRhNmRhZjdiMDhkN2JlYTJhYmQxJTdD
M2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE4NzQ3ODE4ODA2
NjQwNyZhbXA7c2RhdGE9VGRxbnNwZFpMNjNEWEtlJTJCanNJdkUyWUxlb3hrdFRUSjU3N2x6MGNM
Vlk0JTNEJmFtcDtyZXNlcnZlZD0wIAo+Pj4KPj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
