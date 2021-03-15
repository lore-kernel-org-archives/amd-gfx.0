Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CA0C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 10:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0DE64E20
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 10:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0DE64E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1328589CE3;
	Mon, 15 Mar 2021 10:14:42 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD5EE89CE3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 10:14:41 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id lr13so65211494ejb.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=mwO6qa+64bTmNfof/OvZTc79WCSUSR++eUzDuSenXyM=;
 b=SpSmMNbCZ1s3FOhyY7bYxjjoLq1WCvt3Xm+m/ZmmkLUeA/U5wUj6aFQ0ck8BESBwkD
 5DewdvrrJzguuv46QHTo1+W+68Kbs0ukurwfiIRcpq/2NDxXrBEwX6umWBvzGXCd2EF3
 uIbGh7j0qQogIcr+Qr5HBHqj9w5MUHxpA68RKZVaUIc2JGwZDHMMJ5gI3DeDRf3riU23
 4CnGWGM2XX+13+spClQI66lGDgKEckMLXqyIhUiCiDYH/agIWV7RE+rY1A4ZazRL92VG
 5Fqrqz3UmBBPn/m5+cxir9FOt4nBwCa5WP+JIWJe4o/cugO+/i09VFHj4fuur1G90ZYF
 6qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=mwO6qa+64bTmNfof/OvZTc79WCSUSR++eUzDuSenXyM=;
 b=BP+/Voj4Ju64xB9m6lRkD30opYX90lSp5kAoM12iEpboVYgQovIsUECcGQGf9cWnAc
 IQBVRuK8AThanmUIZEYJlMzNNCTbKnTRG2dRCoNTzwpok4ExXnXDusZBleFagVAyd/20
 jM4k7eUSxy/D96kiJm+MAm2cFhSYYm08QN68IlRuvEeshIz1B3c72BJZHLGDwDePYN78
 EI7V3eBiwfQUqfPGdkcmrVLzOdhaP5WMHqwJYtzPED1G/zDJUWl0xRmqnziR0Ac3jmYF
 KEe2hLlejbZOBxbOQnehxoXpAeb0V5P959c8R9TR/AZ6d+p+MGedir+eumcwlMj6wPMA
 Zsig==
X-Gm-Message-State: AOAM532VymphZDL5gIjFlbwnxvSUtGJ87/I7gWhrjWRUHzzL62opKKlV
 7F6ck0TmCZbcAKaR4AV8Ls32wjTqYME=
X-Google-Smtp-Source: ABdhPJyOdfm+i0VqzYZLuN2DDsFzwCnghj7POXCiRpZKU8cMpHyoPd2NqZ5YTLCl8uW/2FFVxvQJZw==
X-Received: by 2002:a17:907:ea3:: with SMTP id
 ho35mr22712371ejc.219.1615803280433; 
 Mon, 15 Mar 2021 03:14:40 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:dd5e:327:8807:376f?
 ([2a02:908:1252:fb60:dd5e:327:8807:376f])
 by smtp.gmail.com with ESMTPSA id bx24sm7125273ejc.88.2021.03.15.03.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 03:14:39 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: wrap kiq ring ops with kiq spinlock
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210312170810.10934-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9dc4c021-864e-ebb9-6ab4-b3505779e3ba@gmail.com>
Date: Mon, 15 Mar 2021 11:14:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312170810.10934-1-nirmoy.das@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTIuMDMuMjEgdW0gMTg6MDggc2NocmllYiBOaXJtb3kgRGFzOgo+IEtJUSByaW5nIGlzIGJl
aW5nIG9wZXJhdGVkIGJ5IGtmZCBhcyB3ZWxsIGFzIGFtZGdwdS4KPiBLRkQgaXMgdXNpbmcga2lx
IGxvY2ssIHdlIHNob3VsZCB0aGUgc2FtZSBmcm9tIGFtZGdwdSBzaWRlCj4gYXMgd2VsbC4KPgo+
IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KCkFja2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIHwgMTUgKysrKysrKysrKyst
LS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMKPiBpbmRleCAxOTE1Yjli
OTUxMDYuLjg5MmRjNmIyNjlmYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ2Z4LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2Z4LmMKPiBAQCAtNDYyLDIwICs0NjIsMjUgQEAgaW50IGFtZGdwdV9nZnhfZGlzYWJsZV9r
Y3Eoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9r
aXEgKmtpcSA9ICZhZGV2LT5nZngua2lxOwo+ICAgCXN0cnVjdCBhbWRncHVfcmluZyAqa2lxX3Jp
bmcgPSAma2lxLT5yaW5nOwo+IC0JaW50IGk7Cj4gKwlpbnQgaSwgcjsKPiAgIAo+ICAgCWlmICgh
a2lxLT5wbWYgfHwgIWtpcS0+cG1mLT5raXFfdW5tYXBfcXVldWVzKQo+ICAgCQlyZXR1cm4gLUVJ
TlZBTDsKPiAgIAo+ICsJc3Bpbl9sb2NrKCZhZGV2LT5nZngua2lxLnJpbmdfbG9jayk7Cj4gICAJ
aWYgKGFtZGdwdV9yaW5nX2FsbG9jKGtpcV9yaW5nLCBraXEtPnBtZi0+dW5tYXBfcXVldWVzX3Np
emUgKgo+IC0JCQkJCWFkZXYtPmdmeC5udW1fY29tcHV0ZV9yaW5ncykpCj4gKwkJCQkJYWRldi0+
Z2Z4Lm51bV9jb21wdXRlX3JpbmdzKSkgewo+ICsJCXNwaW5fdW5sb2NrKCZhZGV2LT5nZngua2lx
LnJpbmdfbG9jayk7Cj4gICAJCXJldHVybiAtRU5PTUVNOwo+ICsJfQo+ICAgCj4gICAJZm9yIChp
ID0gMDsgaSA8IGFkZXYtPmdmeC5udW1fY29tcHV0ZV9yaW5nczsgaSsrKQo+ICAgCQlraXEtPnBt
Zi0+a2lxX3VubWFwX3F1ZXVlcyhraXFfcmluZywgJmFkZXYtPmdmeC5jb21wdXRlX3JpbmdbaV0s
Cj4gICAJCQkJCSAgIFJFU0VUX1FVRVVFUywgMCwgMCk7Cj4gKwlyID0gYW1kZ3B1X3JpbmdfdGVz
dF9oZWxwZXIoa2lxX3JpbmcpOwo+ICsJc3Bpbl91bmxvY2soJmFkZXYtPmdmeC5raXEucmluZ19s
b2NrKTsKPiAgIAo+IC0JcmV0dXJuIGFtZGdwdV9yaW5nX3Rlc3RfaGVscGVyKGtpcV9yaW5nKTsK
PiArCXJldHVybiByOwo+ICAgfQo+ICAgCj4gICBpbnQgYW1kZ3B1X3F1ZXVlX21hc2tfYml0X3Rv
X3NldF9yZXNvdXJjZV9iaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gQEAgLTUxOCwx
MiArNTIzLDEzIEBAIGludCBhbWRncHVfZ2Z4X2VuYWJsZV9rY3Eoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCj4gICAKPiAgIAlEUk1fSU5GTygia2lxIHJpbmcgbWVjICVkIHBpcGUgJWQgcSAl
ZFxuIiwga2lxX3JpbmctPm1lLCBraXFfcmluZy0+cGlwZSwKPiAgIAkJCQkJCQlraXFfcmluZy0+
cXVldWUpOwo+IC0KPiArCXNwaW5fbG9jaygmYWRldi0+Z2Z4LmtpcS5yaW5nX2xvY2spOwo+ICAg
CXIgPSBhbWRncHVfcmluZ19hbGxvYyhraXFfcmluZywga2lxLT5wbWYtPm1hcF9xdWV1ZXNfc2l6
ZSAqCj4gICAJCQkJCWFkZXYtPmdmeC5udW1fY29tcHV0ZV9yaW5ncyArCj4gICAJCQkJCWtpcS0+
cG1mLT5zZXRfcmVzb3VyY2VzX3NpemUpOwo+ICAgCWlmIChyKSB7Cj4gICAJCURSTV9FUlJPUigi
RmFpbGVkIHRvIGxvY2sgS0lRICglZCkuXG4iLCByKTsKPiArCQlzcGluX3VubG9jaygmYWRldi0+
Z2Z4LmtpcS5yaW5nX2xvY2spOwo+ICAgCQlyZXR1cm4gcjsKPiAgIAl9Cj4gICAKPiBAQCAtNTMy
LDYgKzUzOCw3IEBAIGludCBhbWRncHVfZ2Z4X2VuYWJsZV9rY3Eoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCj4gICAJCWtpcS0+cG1mLT5raXFfbWFwX3F1ZXVlcyhraXFfcmluZywgJmFkZXYt
PmdmeC5jb21wdXRlX3JpbmdbaV0pOwo+ICAgCj4gICAJciA9IGFtZGdwdV9yaW5nX3Rlc3RfaGVs
cGVyKGtpcV9yaW5nKTsKPiArCXNwaW5fdW5sb2NrKCZhZGV2LT5nZngua2lxLnJpbmdfbG9jayk7
Cj4gICAJaWYgKHIpCj4gICAJCURSTV9FUlJPUigiS0NRIGVuYWJsZSBmYWlsZWRcbiIpOwo+ICAg
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
