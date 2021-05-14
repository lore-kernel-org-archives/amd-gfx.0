Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF85C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 15:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A30613F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 15:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A30613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB7066EEB6;
	Fri, 14 May 2021 15:14:51 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9CBC6EEB8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 15:14:50 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id t4so45228903ejo.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=lkUQRrmsd5Mij7ezcpU5+YyAuXMSHffZy9ShcHAmvko=;
 b=QuoBSQyABVtVbjMzORCmPyBmlmbt2iUZpVnKijLI54xYIcfmdSyv7nrj9kqmQm16tM
 ZqM4P1v2PDMw7GZBI7q9wYZZ1rzCLW/ERdV/EyNK7vfzUz40+hzfiGMXbTyqFD++EEY5
 kRHs9WkI1p1A2seQeHjGGbNcnH4uHVImyzMnN/0OsJO8qRQUlwaj8tLIWlV1Ik2wTosh
 3DqyGUaIE4dA970mx01eFD8ntey/46eutTQuvsylCxX5KSwrkGY1f7l7KDiMNxlIpr2v
 nQxrj2Tam0nK8opLorUIyJ3Pp4VgG2dky2ErrTM15SGunuGg26PfClnnz9y6s6oyIjkq
 d9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lkUQRrmsd5Mij7ezcpU5+YyAuXMSHffZy9ShcHAmvko=;
 b=Cp+Dn6gzgdVrCpXgS7yzM8S3BsbPghcUPlNjsEILcQQ26ECCDo/9ip0f0HSSzkwX+l
 Bg3s75RApMktuhq9DTQjo4YnZ38TFdznSC7c1itI5miUwWQCLNfgZcQ42fVyrQiJCNd2
 aKxAuFEeYCSi9rSyC8fiFYk5QvO5ieaDYB9V1zkIbYTsl7z/YkAlNwp8xY3o2LkUWmBT
 ekZosUYsGQlmErD7WC6TfNAZl9NGB0WybMa2HaPSUvvz6T4FLVoTUoEclKx8XFQWQIlK
 GbzaprxyMP0pzss3NevKpbA0dekbQ0tyZVK8LP04ISfsZ9JOhS7zO2TO8t8RWTa255dN
 NtCA==
X-Gm-Message-State: AOAM533dcZOr1z6GScwHRDJfFr6Uii3PZHttsA/Vk9xAzM+JXL7cY8HH
 uhPh+i9mTL5HlysW/jAUwlnZMeYpIvc=
X-Google-Smtp-Source: ABdhPJzji1wqyxsut9JgYB/ugY+VZU6bc5ohOYKPpVJMAtjUhvLFa8ydTLR/LSGaQyYqa4eYz7QxOQ==
X-Received: by 2002:a17:906:bcd6:: with SMTP id
 lw22mr4832254ejb.250.1621005289399; 
 Fri, 14 May 2021 08:14:49 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:cf70:a0fd:8c48:efd4?
 ([2a02:908:1252:fb60:cf70:a0fd:8c48:efd4])
 by smtp.gmail.com with ESMTPSA id g9sm3775827ejo.8.2021.05.14.08.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 May 2021 08:14:48 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] drm/amdkfd: heavy-weight flush TLB after unmap
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210513165855.16395-2-Philip.Yang@amd.com>
 <20210514144222.24206-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d5fba451-f75b-b77c-7fbf-a289914e97e5@gmail.com>
Date: Fri, 14 May 2021 17:14:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210514144222.24206-1-Philip.Yang@amd.com>
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

QW0gMTQuMDUuMjEgdW0gMTY6NDIgc2NocmllYiBQaGlsaXAgWWFuZzoKPiBOZWVkIGRvIGEgaGVh
dnktd2VpZ2h0IFRMQiBmbHVzaCB0byBtYWtlIHN1cmUgd2UgaGF2ZSBubyBtb3JlIGRpcnR5IGRh
dGEKPiBpbiB0aGUgY2FjaGUgZm9yIHRoZSB1bm1hcHBlZCBwYWdlcy4KPgo+IERlZmluZSBlbnVt
IFRMQl9GTFVTSF9UWVBFLCBhZGQgZmx1c2hfdHlwZSBwYXJhbWV0ZXIgdG8KPiBhbWRncHVfYW1k
a2ZkX2ZsdXNoX2dwdV90bGJfcGFzaWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgWWFuZyA8
UGhpbGlwLllhbmdAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZC5jIHwgNCArKy0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYW1ka2ZkLmggfCA5ICsrKysrKysrLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3Byb2Nlc3MuYyAgIHwgMiArLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3N2bS5jICAgICAgIHwgNCArKy0tCj4gICA0IGZpbGVzIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZC5jCj4gaW5kZXggNWY2Njk2YTNjNzc4Li5iZmFiMmY5ZmRkMTcgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4gQEAgLTY3MCwx
MCArNjcwLDEwIEBAIGludCBhbWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90bGJfdm1pZChzdHJ1Y3Qg
a2dkX2RldiAqa2dkLCB1aW50MTZfdCB2bWlkKQo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4g
LWludCBhbWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90bGJfcGFzaWQoc3RydWN0IGtnZF9kZXYgKmtn
ZCwgdWludDE2X3QgcGFzaWQpCj4gK2ludCBhbWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90bGJfcGFz
aWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDE2X3QgcGFzaWQsCj4gKwkJCQkgICAgICBlbnVt
IFRMQl9GTFVTSF9UWVBFIGZsdXNoX3R5cGUpCj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilrZ2Q7Cj4gLQljb25zdCB1aW50MzJf
dCBmbHVzaF90eXBlID0gMDsKPiAgIAlib29sIGFsbF9odWIgPSBmYWxzZTsKPiAgIAo+ICAgCWlm
IChhZGV2LT5mYW1pbHkgPT0gQU1ER1BVX0ZBTUlMWV9BSSkKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4gaW5kZXggMzEzZWU0OWI5ZjE3Li5mNGRlNTBkZTM1
OWIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZC5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4g
QEAgLTM2LDYgKzM2LDEyIEBACj4gICAKPiAgIGV4dGVybiB1aW50NjRfdCBhbWRncHVfYW1ka2Zk
X3RvdGFsX21lbV9zaXplOwo+ICAgCj4gK2VudW0gVExCX0ZMVVNIX1RZUEUgewo+ICsJVExCX0ZM
VVNIX0xFR0FDWSA9IDAsCj4gKwlUTEJfRkxVU0hfTElHSFRXRUlHSFQsCj4gKwlUTEJfRkxVU0hf
SEVBVllXRUlHSFQKPiArfTsKPiArCj4gICBzdHJ1Y3QgYW1kZ3B1X2RldmljZTsKPiAgIAo+ICAg
c3RydWN0IGtmZF9ib192YV9saXN0IHsKPiBAQCAtMTM1LDcgKzE0MSw4IEBAIGludCBhbWRncHVf
YW1ka2ZkX3N1Ym1pdF9pYihzdHJ1Y3Qga2dkX2RldiAqa2dkLCBlbnVtIGtnZF9lbmdpbmVfdHlw
ZSBlbmdpbmUsCj4gICB2b2lkIGFtZGdwdV9hbWRrZmRfc2V0X2NvbXB1dGVfaWRsZShzdHJ1Y3Qg
a2dkX2RldiAqa2dkLCBib29sIGlkbGUpOwo+ICAgYm9vbCBhbWRncHVfYW1ka2ZkX2hhdmVfYXRv
bWljc19zdXBwb3J0KHN0cnVjdCBrZ2RfZGV2ICprZ2QpOwo+ICAgaW50IGFtZGdwdV9hbWRrZmRf
Zmx1c2hfZ3B1X3RsYl92bWlkKHN0cnVjdCBrZ2RfZGV2ICprZ2QsIHVpbnQxNl90IHZtaWQpOwo+
IC1pbnQgYW1kZ3B1X2FtZGtmZF9mbHVzaF9ncHVfdGxiX3Bhc2lkKHN0cnVjdCBrZ2RfZGV2ICpr
Z2QsIHVpbnQxNl90IHBhc2lkKTsKPiAraW50IGFtZGdwdV9hbWRrZmRfZmx1c2hfZ3B1X3RsYl9w
YXNpZChzdHJ1Y3Qga2dkX2RldiAqa2dkLCB1aW50MTZfdCBwYXNpZCwKPiArCQkJCSAgICAgIGVu
dW0gVExCX0ZMVVNIX1RZUEUgZmx1c2hfdHlwZSk7Cj4gICAKPiAgIGJvb2wgYW1kZ3B1X2FtZGtm
ZF9pc19rZmRfdm1pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIHZtaWQpOwo+ICAg
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4gaW5kZXggOWQ0ZjUy
N2JkYTdjLi41YjZjNTY2OWMwM2QgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3Byb2Nlc3MuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wcm9jZXNzLmMKPiBAQCAtMTg1Myw3ICsxODUzLDcgQEAgdm9pZCBrZmRfZmx1c2hfdGxiKHN0
cnVjdCBrZmRfcHJvY2Vzc19kZXZpY2UgKnBkZCkKPiAgIAkJCQkJCQlwZGQtPnFwZC52bWlkKTsK
PiAgIAl9IGVsc2Ugewo+ICAgCQlhbWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90bGJfcGFzaWQoZGV2
LT5rZ2QsCj4gLQkJCQkJCXBkZC0+cHJvY2Vzcy0+cGFzaWQpOwo+ICsJCQkJCXBkZC0+cHJvY2Vz
cy0+cGFzaWQsIFRMQl9GTFVTSF9MRUdBQ1kpOwo+ICAgCX0KPiAgIH0KPiAgIAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPiBpbmRleCBhNTJlNDU5NDc4NWYuLmYyOTAxZTdhOTkz
ZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPiBAQCAtMTEyNyw3ICsx
MTI3LDcgQEAgc3ZtX3JhbmdlX3VubWFwX2Zyb21fZ3B1cyhzdHJ1Y3Qgc3ZtX3JhbmdlICpwcmFu
Z2UsIHVuc2lnbmVkIGxvbmcgc3RhcnQsCj4gICAJCQkJYnJlYWs7Cj4gICAJCX0KPiAgIAkJYW1k
Z3B1X2FtZGtmZF9mbHVzaF9ncHVfdGxiX3Bhc2lkKChzdHJ1Y3Qga2dkX2RldiAqKWFkZXYsCj4g
LQkJCQkJCSAgcC0+cGFzaWQpOwo+ICsJCQkJCXAtPnBhc2lkLCBUTEJfRkxVU0hfSEVBVllXRUlH
SFQpOwo+ICAgCX0KPiAgIAo+ICAgCXJldHVybiByOwo+IEBAIC0xMTgzLDcgKzExODMsNyBAQCBz
dm1fcmFuZ2VfbWFwX3RvX2dwdShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFt
ZGdwdV92bSAqdm0sCj4gICAKPiAgIAkJcCA9IGNvbnRhaW5lcl9vZihwcmFuZ2UtPnN2bXMsIHN0
cnVjdCBrZmRfcHJvY2Vzcywgc3Ztcyk7Cj4gICAJCWFtZGdwdV9hbWRrZmRfZmx1c2hfZ3B1X3Rs
Yl9wYXNpZCgoc3RydWN0IGtnZF9kZXYgKilhZGV2LAo+IC0JCQkJCQkgIHAtPnBhc2lkKTsKPiAr
CQkJCQkJcC0+cGFzaWQsIFRMQl9GTFVTSF9MRUdBQ1kpOwo+ICAgCX0KPiAgIG91dDoKPiAgIAlw
cmFuZ2UtPm1hcHBpbmcuYm9fdmEgPSBOVUxMOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
