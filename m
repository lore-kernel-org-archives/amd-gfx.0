Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638D3C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4CD2235D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4CD2235D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE0386E116;
	Wed, 20 Nov 2019 08:47:06 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E967C6E116
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 08:47:05 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id t1so27075115wrv.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 00:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=OCqTNzS7K1L5dNyqmytSWOd0k8+BqisAY+AllPSDDks=;
 b=kayCrM0byuefY3IcifezMg2p3Qtv9zLf66W2DTqTXD7boo1AUNAgVOysTtU9W/XMWb
 lLyzKGS/pQWg065tCCHjdpBMdUBSVZBT6x6bVn2EYxkRr1tK4XsTKIoJIrI3kvdkgTkR
 S5byh8k28CaJCBBdu5CP6R3f+4Gm/O/4XBdLvzhPVh2Hs1KZwHfbFJ5RXfT2lNS0QOH1
 PIkDZE6bcj0zViKItH+r3Tz3hXcN9QwqBGKKVatLbj64000nWTEa+50X9hxNLvV5/zNT
 2YWaEwBurHoZaMWg/0wEQgIgYCas9Rp+Xqj04Sd/uYTKxu8dFyn/TDd6QOCc+l2OUjBA
 HWfA==
X-Gm-Message-State: APjAAAXyJu1EHwM/S04J2WG5SvY+Hye0BU/Htcb/SirMb1NkUKt3kKtR
 ejsUBCQTH/n/lXeZXPXdtLA=
X-Google-Smtp-Source: APXvYqxK8mKDRQR+iO2SEoz578iaAZQyqHHk8LUKqK8UrrSVqhOfkwEJ+IgKPE6tkWAHhyhw3aQx7w==
X-Received: by 2002:adf:ef8a:: with SMTP id d10mr1837623wro.314.1574239624461; 
 Wed, 20 Nov 2019 00:47:04 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id o189sm6177328wmo.23.2019.11.20.00.47.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Nov 2019 00:47:04 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu/gfx10: re-init clear state buffer after gpu
 reset
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191120064701.2765-1-xiaojie.yuan@amd.com>
 <DM5PR12MB1418A32EB8199ABFFCCAEC04FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
 <DM5PR12MB14185B32B9CB4356233E5903FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <01af7844-2fbe-fd1a-5662-c8a9ec5812f0@gmail.com>
Date: Wed, 20 Nov 2019 09:47:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB14185B32B9CB4356233E5903FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=OCqTNzS7K1L5dNyqmytSWOd0k8+BqisAY+AllPSDDks=;
 b=UswoGkihYNOXw92NIXOVVDJzmyCTzWh+DgjuhWJTm5RDVf90WK9GfcRf/I/7MFu1wj
 HqCRQlh5cbpa5vXkVVN6SNAZOcpU2xx92fu0AJdY/13TnZlT4DvQ/RtP3Gc1vfV1iSXg
 NKNPu/3Vkox5zz4w8b9na7gB944nlvJp1eY7LKF6nTMZhr8rwLL5phy+7XI957j/pFTJ
 k2FdGkKS2kdymJgr+tArV5DLQp/tDGOpG4wSIOxt1nHpoEiKzpME7EsbmxxtP649r0Un
 qlhZnhb3zRy6d0sflpSmhWHwjZvFzgeusFAJORv4aatsddILwdQDe+o21C2HWYoeQYaQ
 zImg==
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120084703.jTtBwN7YAwB3dnW9boeErDBxLrVK0blMCYD0ydyW22M@z>

QSBiYWNvIHJlc2V0IGFsc28gcmVzZXRzIHRoZSBNQywgZG9lc24ndCBpdD8gbiB0aGlzIGNhc2Ug
aXQgd291bGQgYmUgCmV4cGVjdGVkIHRoYXQgdGhlIGNvbnRlbnQgb2YgVlJBTSBpcyBjb3JydXB0
ZWQuCgpDaHJpc3RpYW4uCgpBbSAyMC4xMS4xOSB1bSAwOTo0NSBzY2hyaWViIFpoYW5nLCBIYXdr
aW5nOgo+IE9yIGluIGFub3RoZXIgd29yZCwgd2UgYXJlIHN0aWxsIG5vdCBjbGVhciB3aGVuIHRo
ZSBjb3JydXB0aW9uIGFjdHVhbGx5IGhhcHBlbnMsIHJpZ2h0Pwo+Cj4gUmVnYXJkcywKPiBIYXdr
aW5nCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4
LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgWmhhbmcsIEhhd2tp
bmcKPiBTZW50OiAyMDE55bm0MTHmnIgyMOaXpSAxNjo0NAo+IFRvOiBZdWFuLCBYaWFvamllIDxY
aWFvamllLll1YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6
IExvbmcsIEdhbmcgPEdhbmcuTG9uZ0BhbWQuY29tPjsgWGlhbywgSmFjayA8SmFjay5YaWFvQGFt
ZC5jb20+Cj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZGdwdS9nZngxMDogcmUtaW5pdCBj
bGVhciBzdGF0ZSBidWZmZXIgYWZ0ZXIgZ3B1IHJlc2V0Cj4KPiBKdXN0IG1ha2Ugc3VyZSBJIHVu
ZGVyc3RhbmQgeW91IGNvcnJlY3RseS4gU28gdW50aWwgZncgdGVhbSByb290IGNhdXNlIHRoZSBy
ZWFzb24gb2YgY3NiIGNvcnJ1cHRpb24sIHdlIGtlZXAgdGhlIHdvcmthcm91bmQgaW4gZHJpdmVy
LCBjb3JyZWN0Pwo+Cj4gUmVnYXJkcywKPiBIYXdraW5nCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0KPiBGcm9tOiBZdWFuLCBYaWFvamllIDxYaWFvamllLll1YW5AYW1kLmNvbT4KPiBTZW50
OiAyMDE55bm0MTHmnIgyMOaXpSAxNDo0Nwo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IENjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgWGlhbywg
SmFjayA8SmFjay5YaWFvQGFtZC5jb20+OyBMb25nLCBHYW5nIDxHYW5nLkxvbmdAYW1kLmNvbT47
IFl1YW4sIFhpYW9qaWUgPFhpYW9qaWUuWXVhbkBhbWQuY29tPgo+IFN1YmplY3Q6IFtQQVRDSF0g
ZHJtL2FtZGdwdS9nZngxMDogcmUtaW5pdCBjbGVhciBzdGF0ZSBidWZmZXIgYWZ0ZXIgZ3B1IHJl
c2V0Cj4KPiBUaGlzIHBhdGNoIGZpeGVzIDJuZCBiYWNvIHJlc2V0IGZhaWx1cmUgd2l0aCBnZnhv
ZmYgZW5hYmxlZCBvbiBuYXZpMXguCj4KPiBjbGVhciBzdGF0ZSBidWZmZXIgKHJlc2lkZXMgaW4g
dnJhbSkgaXMgY29ycnVwdGVkIGFmdGVyIDFzdCBiYWNvIHJlc2V0LCB1cG9uIGdmeG9mZiBleGl0
LCBDUEYgZ2V0cyBnYXJiYWdlIGhlYWRlciBpbiBDU0lCIGFuZCBoYW5ncy4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55dWFuQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDQzICsrKysrKysrKysrKysrKysr
KysrKystLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEw
XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gaW5kZXggOTI3
NGJkNGI2YzY4Li44ZTI0ZWEwOGNhMzkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjEwXzAuYwo+IEBAIC0xNzg5LDI3ICsxNzg5LDUyIEBAIHN0YXRpYyB2b2lkIGdmeF92MTBf
MF9lbmFibGVfZ3VpX2lkbGVfaW50ZXJydXB0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+
ICAgCVdSRUczMl9TT0MxNShHQywgMCwgbW1DUF9JTlRfQ05UTF9SSU5HMCwgdG1wKTsgIH0KPiAg
IAo+IC1zdGF0aWMgdm9pZCBnZnhfdjEwXzBfaW5pdF9jc2Ioc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCj4gK3N0YXRpYyBpbnQgZ2Z4X3YxMF8wX2luaXRfY3NiKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQo+ICAgewo+ICsJaW50IHI7Cj4gKwo+ICsJaWYgKGFkZXYtPmluX2dwdV9yZXNl
dCkgewo+ICsJCXIgPSBhbWRncHVfYm9fcmVzZXJ2ZShhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRl
X29iaiwgZmFsc2UpOwo+ICsJCWlmIChyKQo+ICsJCQlyZXR1cm4gcjsKPiArCj4gKwkJciA9IGFt
ZGdwdV9ib19rbWFwKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqLAo+ICsJCQkJICAgKHZv
aWQgKiopJmFkZXYtPmdmeC5ybGMuY3NfcHRyKTsKPiArCQlpZiAoIXIpIHsKPiArCQkJYWRldi0+
Z2Z4LnJsYy5mdW5jcy0+Z2V0X2NzYl9idWZmZXIoYWRldiwKPiArCQkJCQlhZGV2LT5nZngucmxj
LmNzX3B0cik7Cj4gKwkJCWFtZGdwdV9ib19rdW5tYXAoYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0
ZV9vYmopOwo+ICsJCX0KPiArCj4gKwkJYW1kZ3B1X2JvX3VucmVzZXJ2ZShhZGV2LT5nZngucmxj
LmNsZWFyX3N0YXRlX29iaik7Cj4gKwkJaWYgKHIpCj4gKwkJCXJldHVybiByOwo+ICsJfQo+ICsK
PiAgIAkvKiBjc2liICovCj4gICAJV1JFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19DU0lCX0FERFJf
SEksCj4gICAJCSAgICAgYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9ncHVfYWRkciA+PiAzMik7
Cj4gICAJV1JFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19DU0lCX0FERFJfTE8sCj4gICAJCSAgICAg
YWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9ncHVfYWRkciAmIDB4ZmZmZmZmZmMpOwo+ICAgCVdS
RUczMl9TT0MxNShHQywgMCwgbW1STENfQ1NJQl9MRU5HVEgsIGFkZXYtPmdmeC5ybGMuY2xlYXJf
c3RhdGVfc2l6ZSk7Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiAtc3RhdGljIHZvaWQg
Z2Z4X3YxMF8wX2luaXRfcGcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gK3N0YXRpYyBp
bnQgZ2Z4X3YxMF8wX2luaXRfcGcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICB7Cj4g
ICAJaW50IGk7Cj4gKwlpbnQgcjsKPiAgIAo+IC0JZ2Z4X3YxMF8wX2luaXRfY3NiKGFkZXYpOwo+
ICsJciA9IGdmeF92MTBfMF9pbml0X2NzYihhZGV2KTsKPiArCWlmIChyKQo+ICsJCXJldHVybiBy
Owo+ICAgCj4gICAJZm9yIChpID0gMDsgaSA8IGFkZXYtPm51bV92bWh1YnM7IGkrKykKPiAgIAkJ
YW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiKGFkZXYsIDAsIGksIDApOwo+ICAgCj4gICAJLyogVE9E
TzogaW5pdCBwb3dlciBnYXRpbmcgKi8KPiAtCXJldHVybjsKPiArCXJldHVybiAwOwo+ICAgfQo+
ICAgCj4gICB2b2lkIGdmeF92MTBfMF9ybGNfc3RvcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikgQEAgLTE5MTEsNyArMTkzNiwxMCBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9ybGNfcmVzdW1l
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCQlyID0gZ2Z4X3YxMF8wX3dhaXRfZm9y
X3JsY19hdXRvbG9hZF9jb21wbGV0ZShhZGV2KTsKPiAgIAkJaWYgKHIpCj4gICAJCQlyZXR1cm4g
cjsKPiAtCQlnZnhfdjEwXzBfaW5pdF9wZyhhZGV2KTsKPiArCj4gKwkJciA9IGdmeF92MTBfMF9p
bml0X3BnKGFkZXYpOwo+ICsJCWlmIChyKQo+ICsJCQlyZXR1cm4gcjsKPiAgIAo+ICAgCQkvKiBl
bmFibGUgUkxDIFNSTSAqLwo+ICAgCQlnZnhfdjEwXzBfcmxjX2VuYWJsZV9zcm0oYWRldik7Cj4g
QEAgLTE5MzcsNyArMTk2NSwxMCBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9ybGNfcmVzdW1lKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCQkJCXJldHVybiByOwo+ICAgCQl9Cj4gICAK
PiAtCQlnZnhfdjEwXzBfaW5pdF9wZyhhZGV2KTsKPiArCQlyID0gZ2Z4X3YxMF8wX2luaXRfcGco
YWRldik7Cj4gKwkJaWYgKHIpCj4gKwkJCXJldHVybiByOwo+ICsKPiAgIAkJYWRldi0+Z2Z4LnJs
Yy5mdW5jcy0+c3RhcnQoYWRldik7Cj4gICAKPiAgIAkJaWYgKGFkZXYtPmZpcm13YXJlLmxvYWRf
dHlwZSA9PSBBTURHUFVfRldfTE9BRF9STENfQkFDS0RPT1JfQVVUTykgewo+IC0tCj4gMi4yMC4x
Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFt
ZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
