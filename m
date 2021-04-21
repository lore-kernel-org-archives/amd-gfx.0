Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55BFC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 07:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7687A61434
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 07:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7687A61434
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A92826E15E;
	Wed, 21 Apr 2021 07:56:03 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B54116E15E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 07:56:02 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id g17so47518535edm.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=wkpzWoZWqj5laLOjUX1VjR5OEpoQvpALRsP3YpVaoII=;
 b=Zk9sviwKt49UgJSpZw09a3IwB/nBO75fkm9jpFGXElg+uDpaHkB31MDziX6rl1DcDT
 BnGjVt8+z6mR8wmQ9NwFA5FcrK+Qo1MVDTgwTM0it5+QzFVO/Bogp9D6IrLrNpZNGz1P
 Ae7TQ/Tcyt4iv4IZDfhySChmgBOmKWN4g4nSdi4udOuondfUBxA39TJlFjLutshrXIL8
 ezWmHkRntNhw0AxpDCs7QIYJW5EJ3hBM0SiN2TShbH16klt2/c6ZGT2ZxaZG533dKP7m
 /wRFpIKnKKQTBMu+DfLERBamvgOyl3G0QUY2ADFdfdG7LpDrX1TGpjY/7k50+4k78RnQ
 xIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=wkpzWoZWqj5laLOjUX1VjR5OEpoQvpALRsP3YpVaoII=;
 b=HwX4r+7SoSZJIezyuXPeHXaFq7PijVMNYjXVsqe+yMM9grBL1kWeQi7gSmTj7iSQul
 saNz5EStpsCyFEJgzlIhgx4eXO/dmIAjYE/CEh1VWFBfQ8MTmBHdQzaR/yeZcU3OoqQX
 UbmQnOdCFzu+zDsbWeDMt8H7NGfCxrWb5X07LH/UoWQul/HIMSxNoyOKQVAdkzVGWMCb
 gQeMe3bpX6tlQge17uWdKMFPothjMkRciAcBQmmw9Gv7yStfscTyHNrDa4Ed6UJcRwDT
 NWYMV/hXcwDjdglcQZBCQftpEllf3AvZ3MZTesSEV6ywn37au0teoGEwm4faK079bCZg
 LcCQ==
X-Gm-Message-State: AOAM530ytBC5Yj9L8Z/u2Xi8s7a633DZfOtyvw+XSnwyE3QjYCkRbd99
 Lnnfp04UVgpE6IO51h1qllY=
X-Google-Smtp-Source: ABdhPJzkvVjJSNC+lwaXta4LavimxQFo+woeUYgxo//ChBTkq2XXd3+PeIOHRRkljnfVx5FDSp3wbA==
X-Received: by 2002:a05:6402:202a:: with SMTP id
 ay10mr19970961edb.225.1618991761468; 
 Wed, 21 Apr 2021 00:56:01 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:30c1:a1b7:433d:2c5d?
 ([2a02:908:1252:fb60:30c1:a1b7:433d:2c5d])
 by smtp.gmail.com with ESMTPSA id s9sm2041857edd.16.2021.04.21.00.56.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Apr 2021 00:56:00 -0700 (PDT)
Subject: Re: [PATCH 4/6] drm/amdgpu: address remove from fault filter
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20210420202122.4701-1-Philip.Yang@amd.com>
 <20210420202122.4701-4-Philip.Yang@amd.com>
 <d9ff9130-667f-1b5f-83b9-d7dc77743db3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <818c1295-2340-a6fe-9b64-e7a5e74d411e@gmail.com>
Date: Wed, 21 Apr 2021 09:55:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d9ff9130-667f-1b5f-83b9-d7dc77743db3@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjEuMDQuMjEgdW0gMDM6MjAgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIxLTA0
LTIwIHVtIDQ6MjEgcC5tLiBzY2hyaWViIFBoaWxpcCBZYW5nOgo+PiBBZGQgaW50ZXJmYWNlIHRv
IHJlbW92ZSBhZGRyZXNzIGZyb20gZmF1bHQgZmlsdGVyIHJpbmcgYnkgcmVzZXR0aW5nCj4+IGZh
dWx0IHJpbmcgZW50cnkgb2YgdGhlIGZhdWx0IGFkZHJlc3MgdGltZXN0YW1wIHRvIDAsIHRoZW4g
ZnV0dXJlIHZtCj4+IGZhdWx0IG9uIHRoZSBhZGRyZXNzIHdpbGwgYmUgcHJvY2Vzc2VkIHRvIHJl
Y292ZXIuCj4+Cj4+IENoZWNrIGZhdWx0IGFkZHJlc3MgZnJvbSBmYXVsdCByaW5nLCBhZGQgYWRk
cmVzcyBpbnRvIGZhdWx0IHJpbmcgYW5kCj4+IHJlbW92ZSBhZGRyZXNzIGZyb20gZmF1bHQgcmlu
ZyBhcmUgc2VyaWFsaXplZCBpbiBzYW1lIGludGVycnVwdCBkZWZlcnJlZAo+PiB3b3JrLCBkb24n
dCBoYXZlIHJhY2UgY29uZGl0aW9uLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgWWFuZyA8
UGhpbGlwLllhbmdAYW1kLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dtYy5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrCj4+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oIHwgIDIgKysKPj4gICAyIGZpbGVzIGNo
YW5nZWQsIDI2IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nbWMuYwo+PiBpbmRleCBjMzllZDllYjA5ODcuLjMzOGU0NWZhNjZjYiAxMDA2NDQKPj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+PiBAQCAtMzg3LDYgKzM4Nywz
MCBAQCBib29sIGFtZGdwdV9nbWNfZmlsdGVyX2ZhdWx0cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgdWludDY0X3QgYWRkciwKPj4gICAJcmV0dXJuIGZhbHNlOwo+PiAgIH0KPj4gICAKPj4g
Ky8qKgo+PiArICogYW1kZ3B1X2dtY19maWx0ZXJfZmF1bHRzX3JlbW92ZSAtIHJlbW92ZSBhZGRy
ZXNzIGZyb20gVk0gZmF1bHRzIGZpbHRlcgo+PiArICoKPj4gKyAqIEBhZGV2OiBhbWRncHUgZGV2
aWNlIHN0cnVjdHVyZQo+PiArICogQGFkZHI6IGFkZHJlc3Mgb2YgdGhlIFZNIGZhdWx0Cj4+ICsg
KiBAcGFzaWQ6IFBBU0lEIG9mIHRoZSBwcm9jZXNzIGNhdXNpbmcgdGhlIGZhdWx0Cj4+ICsgKgo+
PiArICogUmVtb3ZlIHRoZSBhZGRyZXNzIGZyb20gZmF1bHQgZmlsdGVyLCB0aGVuIGZ1dHVyZSB2
bSBmYXVsdCBvbiB0aGlzIGFkZHJlc3MKPj4gKyAqIHdpbGwgcGFzcyB0byByZXRyeSBmYXVsdCBo
YW5kbGVyIHRvIHJlY292ZXIuCj4+ICsgKi8KPj4gK3ZvaWQgYW1kZ3B1X2dtY19maWx0ZXJfZmF1
bHRzX3JlbW92ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDY0X3QgYWRkciwKPj4g
KwkJCQkgICAgIHVpbnQxNl90IHBhc2lkKQo+PiArewo+PiArCXN0cnVjdCBhbWRncHVfZ21jICpn
bWMgPSAmYWRldi0+Z21jOwo+PiArCj4+ICsJdWludDY0X3Qga2V5ID0gYWRkciA8PCA0IHwgcGFz
aWQ7Cj4+ICsJc3RydWN0IGFtZGdwdV9nbWNfZmF1bHQgKmZhdWx0Owo+PiArCXVpbnQzMl90IGhh
c2g7Cj4+ICsKPj4gKwloYXNoID0gaGFzaF82NChrZXksIEFNREdQVV9HTUNfRkFVTFRfSEFTSF9P
UkRFUik7Cj4+ICsJZmF1bHQgPSAmZ21jLT5mYXVsdF9yaW5nW2dtYy0+ZmF1bHRfaGFzaFtoYXNo
XS5pZHhdOwo+IFlvdSBuZWVkIHRvIGxvb3Agb3ZlciB0aGUgZmF1bHQgcmluZyB0byBmaW5kIGEg
ZmF1bHQgd2l0aCB0aGUgbWF0Y2hpbmcKPiBrZXkgc2luY2UgdGhlcmUgbWF5IGJlIGhhc2ggY29s
bGlzaW9ucy4KPgo+IFlvdSBhbHNvIG5lZWQgdG8gbWFrZSBzdXJlIHlvdSBkb24ndCBicmVhayB0
aGUgc2luZ2xlIGxpbmsgbGlzdCBvZiBrZXlzCj4gd2l0aCB0aGUgc2FtZSBoYXNoIHdoZW4geW91
IHJlbW92ZSBhbiBlbnRyeS4gSSB0aGluayB0aGUgZWFzaWVyIHdheSB0bwo+IHJlbW92ZSBhbiBl
bnRyeSB3aXRob3V0IGJyZWFraW5nIHRoaXMgcmluZytjbG9zZWQgaGFzaGluZyBzdHJ1Y3R1cmUg
aXMKPiB0byByZXNldCB0aGUgZmF1bHQtPmtleSByYXRoZXIgdGhhbiB0aGUgZmF1bHQtPnRpbWVz
dGFtcC4KPgo+IEZpbmFsbHksIHlvdSBuZWVkIHRvIGFkZCBsb2NraW5nIHRvIHRoZSBmYXVsdCBy
aW5nIHN0cnVjdHVyZS4gQ3VycmVudGx5Cj4gaXQncyBub3QgcHJvdGVjdGVkIGJ5IGFueSBsb2Nr
cyBiZWNhdXNlIG9ubHkgb25lIHRocmVhZCAodGhlIGludGVycnVwdAo+IGhhbmRsZXIpIGFjY2Vz
c2VzIGl0LiBOb3cgeW91IGhhdmUgYW5vdGhlciB0aHJlYWQgdGhhdCBjYW4gcmVtb3ZlCj4gZW50
cmllcywgc28geW91IG5lZWQgdG8gcHJvdGVjdCBpdCB3aXRoIGEgbG9jay4gSWYgeW91IGFyZSBo
YW5kbGluZwo+IHJldHJ5IGZhdWx0cywgeW91IGtub3cgdGhhdCB0aGUgaW50ZXJydXB0IGhhbmRs
ZXIgaXMgcmVhbGx5IGEgd29ya2VyCj4gdGhyZWFkLCBzbyB5b3UgY2FuIHVzZSBhIG11dGV4IG9y
IGEgc3Bpbi1sb2NrLCBidXQgaXQgZG9lc24ndCBuZWVkIHRvIGJlCj4gaW50ZXJydXB0LXNhZmUu
CgpJIGRvbid0IHRoaW5rIHlvdSBuZWVkIGEgbG9jayBhdCBhbGwuCgpKdXN0IHVzaW5nIGNtcHhj
aGcoKSB0byB1cGRhdGUgdGhlIGtleSBzaG91bGQgZG8gaXQuCgpTb21ldGhpbmcgbGlrZSB0aGlz
OgoKIMKgwqDCoMKgwqDCoMKgIGhhc2ggPSBoYXNoXzY0KGtleSwgQU1ER1BVX0dNQ19GQVVMVF9I
QVNIX09SREVSKTsKIMKgwqDCoMKgwqDCoMKgIGZhdWx0ID0gJmdtYy0+ZmF1bHRfcmluZ1tnbWMt
PmZhdWx0X2hhc2hbaGFzaF0uaWR4XTsKIMKgwqDCoMKgwqDCoMKgIHdoaWxlIChmYXVsdC0+dGlt
ZXN0YW1wID49IHN0YW1wKSB7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDY0
X3QgdG1wOwoKIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBjbXB4Y2hnKCZmYXVsdC0+a2V5
LCBrZXksIDApOwoKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0bXAgPSBmYXVsdC0+
dGltZXN0YW1wOwogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhdWx0ID0gJmdtYy0+
ZmF1bHRfcmluZ1tmYXVsdC0+bmV4dF07CgogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC8qIENoZWNrIGlmIHRoZSBlbnRyeSB3YXMgcmV1c2VkICovCiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKGZhdWx0LT50aW1lc3RhbXAgPj0gdG1wKQogwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKIMKgwqDCoMKgwqDCoMKgIH0K
ClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBSZWdhcmRzLAo+ICDCoCBGZWxpeAo+Cj4KPj4gKwlm
YXVsdC0+dGltZXN0YW1wID0gMDsKPj4gK30KPj4gKwo+PiAgIGludCBhbWRncHVfZ21jX3Jhc19s
YXRlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+ICAgewo+PiAgIAlpbnQgcjsK
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaCBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaAo+PiBpbmRleCA5ZDExYzAy
YTM5MzguLjQ5OGE3YTBkNWE5ZSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dtYy5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nbWMuaAo+PiBAQCAtMzE4LDYgKzMxOCw4IEBAIHZvaWQgYW1kZ3B1X2dtY19hZ3BfbG9j
YXRpb24oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+ICAgCQkJICAgICBzdHJ1Y3QgYW1k
Z3B1X2dtYyAqbWMpOwo+PiAgIGJvb2wgYW1kZ3B1X2dtY19maWx0ZXJfZmF1bHRzKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCB1aW50NjRfdCBhZGRyLAo+PiAgIAkJCSAgICAgIHVpbnQxNl90
IHBhc2lkLCB1aW50NjRfdCB0aW1lc3RhbXApOwo+PiArdm9pZCBhbWRncHVfZ21jX2ZpbHRlcl9m
YXVsdHNfcmVtb3ZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50NjRfdCBhZGRyLAo+
PiArCQkJCSAgICAgdWludDE2X3QgcGFzaWQpOwo+PiAgIGludCBhbWRncHVfZ21jX3Jhc19sYXRl
X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwo+PiAgIHZvaWQgYW1kZ3B1X2dtY19y
YXNfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cj4+ICAgaW50IGFtZGdwdV9nbWNf
YWxsb2NhdGVfdm1faW52X2VuZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
