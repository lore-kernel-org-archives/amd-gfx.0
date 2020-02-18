Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C708BC34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 09:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9553020658
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 09:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hanXTuzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9553020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CEEC6E1B3;
	Tue, 18 Feb 2020 09:21:52 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02696E1B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 09:21:50 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id n10so21028716wrm.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 01:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=9dC3q7g2MUgNohHMTE3FQm/BcrzFUdonWQ4kNQ91hCg=;
 b=hanXTuzLujA1IwbMCjh38mXaxjhoLpCmqRhLVMsQqO7AVfZnYI6H+p75GrMpk4nx6D
 FwYZGpEozKS3ab983A+iycIDtwNl+euTSFLKoeJ3JgMrCPZPpdp4AyPz8eEWWMsA6+ie
 p9Iw9uYriG+uTGwkKrnFvYlUcHvKyD6yoUvlrcNGVlqFoWnGNV4FNY0UFH18KaVZU50J
 e5r2aClD50SiQR82FWBbLeZbBbTMF2+ATYp8MNBbpk9xCkJ73IcfCPHFHnK6Ih0ynIra
 onLjqlxd7qDJtFui8fOMEgKCe6Fy0ukBYO3dgAWsY+V1CC8ywRmOdzigtvGyPjffygwB
 VZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=9dC3q7g2MUgNohHMTE3FQm/BcrzFUdonWQ4kNQ91hCg=;
 b=JnqICXq+S0JA3LU8mn47jchmCNUcH9XZlwMVC/aw69raq4MmTVsYDgDMGYLDl0x0WQ
 qopFzU8jFQL6baJpQOboaHOw+X8fNnlFQNFFPjLXJb3xd0ktHmQ7+bRC34QsfhPnargM
 rhkUK8HngeXg2JqI5VJ+Df5sjMjQL94FwuOCkTluWRe1twf9J+IEYc2KkCIu91xKVL1u
 qs1BkJdI5K1pJ6/lFfr1NG0obwvhWJcwQqP3rIxFDmV509Nv1X7DPjgu96QyWP5Q9wTm
 LkVAL3GuXrrTREt2oJ+lSPuqlC6zKFr7bdgFwLGbtB+dd0OFwHp/Jac+MEMnsP6Ijg/9
 p5cQ==
X-Gm-Message-State: APjAAAX2srce0JNsV1kw8IJLJKF+ykNAxhjqEB8vcHEDWUBYf3hBpEsE
 LHFmaaRRmOCSNhaY9FgejqZlRsCW
X-Google-Smtp-Source: APXvYqzLZwcZeTFpypBs2o2u1OA3Ge/nCWLmq7DdSDVGV7D4XgcGu7Wcv3lbubn59kkyLfXZ6BPDEA==
X-Received: by 2002:adf:e50f:: with SMTP id j15mr28005545wrm.356.1582017709408; 
 Tue, 18 Feb 2020 01:21:49 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b10sm5032146wrt.90.2020.02.18.01.21.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Feb 2020 01:21:48 -0800 (PST)
Subject: Re: [RFC PATCH v5] drm/amdgpu: Remove kfd eviction fence before
 release bo
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200218033650.7665-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <910dfea7-0798-6b99-42fc-64050c61acda@gmail.com>
Date: Tue, 18 Feb 2020 10:21:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200218033650.7665-1-xinhui.pan@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTguMDIuMjAgdW0gMDQ6MzYgc2NocmllYiB4aW5odWkgcGFuOgo+IE5vIG5lZWQgdG8gdHJp
Z2dlciBldmljdGlvbiBhcyB0aGUgbWVtb3J5IG1hcHBpbmcgd2lsbCBub3QgYmUgdXNlZAo+IGFu
eW1vcmUuCj4KPiBBbGwgcHQvcGQgYm9zIHNoYXJlIHNhbWUgcmVzdiwgaGVuY2UgdGhlIHNhbWUg
c2hhcmVkIGV2aWN0aW9uIGZlbmNlLgo+IEV2ZXJ5dGltZSBwYWdlIHRhYmxlIGlzIGZyZWVkLCB0
aGUgZmVuY2Ugd2lsbCBiZSBzaWdubGVkIGFuZCB0aGF0IGN1YXNlcwo+IGtmZCB1bmV4Y2VwdGVk
IGV2aWN0aW9ucy4KPgo+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1k
LmNvbT4KPiBDQzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+
IENDOiBGZWxpeCBLdWVobGluZyA8ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4KPiBDQzogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gY2hhbmdlIGZyb20gdjQ6
Cj4gYmFzZWQgb24gbmV3IHR0bSBjb2RlLgo+Cj4gY2hhbmdlIGZyb20gdjM6Cj4gZml4IGEgY29k
aW5nIGVycm9yCj4KPiBjaGFuZ2UgZnJvbSB2MjoKPiBiYXNlZCBvbiBDaHJpcycgZHJtL3R0bTog
cmV3b3JrIEJPIGRlbGF5ZWQgZGVsZXRlIHBhdGNoc2V0Lgo+Cj4gLS0tCj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmggICAgfCAgMSArCj4gICAuLi4v
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyAgfCAzNyArKysrKysrKysr
KysrKysrKysrCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMg
ICAgfCAgNCArKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4gaW5kZXggOWU4ZGI3MDJk
ODc4Li4wZWU4YWFlNmM1MTkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZC5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZC5oCj4gQEAgLTk2LDYgKzk2LDcgQEAgc3RydWN0IGFtZGdwdV9hbWRrZmRfZmVu
Y2UgKmFtZGdwdV9hbWRrZmRfZmVuY2VfY3JlYXRlKHU2NCBjb250ZXh0LAo+ICAgCQkJCQkJICAg
ICAgIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKTsKPiAgIGJvb2wgYW1ka2ZkX2ZlbmNlX2NoZWNrX21t
KHN0cnVjdCBkbWFfZmVuY2UgKmYsIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKTsKPiAgIHN0cnVjdCBh
bWRncHVfYW1ka2ZkX2ZlbmNlICp0b19hbWRncHVfYW1ka2ZkX2ZlbmNlKHN0cnVjdCBkbWFfZmVu
Y2UgKmYpOwo+ICtpbnQgYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZmVuY2Vfb25fcHRfcGRfYm9zKHN0
cnVjdCBhbWRncHVfYm8gKmJvKTsKPiAgIAo+ICAgc3RydWN0IGFtZGtmZF9wcm9jZXNzX2luZm8g
ewo+ICAgCS8qIExpc3QgaGVhZCBvZiBhbGwgVk1zIHRoYXQgYmVsb25nIHRvIGEgS0ZEIHByb2Nl
c3MgKi8KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
cHV2bS5jCj4gaW5kZXggZWY3MjFjYjY1ODY4Li42YWEyMGFhODJiZDMgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gQEAgLTI3
Niw2ICsyNzYsNDEgQEAgc3RhdGljIGludCBhbWRncHVfYW1ka2ZkX3JlbW92ZV9ldmljdGlvbl9m
ZW5jZShzdHJ1Y3QgYW1kZ3B1X2JvICpibywKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+ICtp
bnQgYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZmVuY2Vfb25fcHRfcGRfYm9zKHN0cnVjdCBhbWRncHVf
Ym8gKmJvKQo+ICt7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2JvICpyb290ID0gYm87Cj4gKwlzdHJ1Y3Qg
YW1kZ3B1X3ZtX2JvX2Jhc2UgKnZtX2JvOwo+ICsJc3RydWN0IGFtZGdwdV92bSAqdm07Cj4gKwlz
dHJ1Y3QgYW1ka2ZkX3Byb2Nlc3NfaW5mbyAqaW5mbzsKPiArCXN0cnVjdCBhbWRncHVfYW1ka2Zk
X2ZlbmNlICplZjsKPiArCWludCByZXQ7Cj4gKwo+ICsJd2hpbGUgKHJvb3QtPnBhcmVudCkKPiAr
CQlyb290ID0gcm9vdC0+cGFyZW50Owo+ICsKPiArCXZtX2JvID0gcm9vdC0+dm1fYm87Cj4gKwlp
ZiAoIXZtX2JvKQo+ICsJCXJldHVybiAwOwo+ICsKPiArCXZtID0gdm1fYm8tPnZtOwo+ICsJaWYg
KCF2bSkKPiArCQlyZXR1cm4gMDsKPiArCj4gKwlpbmZvID0gdm0tPnByb2Nlc3NfaW5mbzsKPiAr
CWlmICghaW5mbyB8fCAhaW5mby0+ZXZpY3Rpb25fZmVuY2UpCj4gKwkJcmV0dXJuIDA7Cj4gKwo+
ICsJZWYgPSBjb250YWluZXJfb2YoZG1hX2ZlbmNlX2dldCgmaW5mby0+ZXZpY3Rpb25fZmVuY2Ut
PmJhc2UpLAo+ICsJCQlzdHJ1Y3QgYW1kZ3B1X2FtZGtmZF9mZW5jZSwgYmFzZSk7Cj4gKwo+ICsJ
ZG1hX3Jlc3ZfbG9jayhiby0+dGJvLmJhc2UucmVzdiwgTlVMTCk7Cj4gKwlyZXQgPSBhbWRncHVf
YW1ka2ZkX3JlbW92ZV9ldmljdGlvbl9mZW5jZShibywgZWYpOwo+ICsJZG1hX3Jlc3ZfdW5sb2Nr
KGJvLT50Ym8uYmFzZS5yZXN2KTsKPiArCj4gKwlkbWFfZmVuY2VfcHV0KCZlZi0+YmFzZSk7Cj4g
KwlyZXR1cm4gcmV0Owo+ICt9Cj4gKwo+ICAgc3RhdGljIGludCBhbWRncHVfYW1ka2ZkX2JvX3Zh
bGlkYXRlKHN0cnVjdCBhbWRncHVfYm8gKmJvLCB1aW50MzJfdCBkb21haW4sCj4gICAJCQkJICAg
ICBib29sIHdhaXQpCj4gICB7Cj4gQEAgLTEwNDUsNiArMTA4MCw4IEBAIHZvaWQgYW1kZ3B1X2Ft
ZGtmZF9ncHV2bV9kZXN0cm95X2NiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCWxp
c3RfZGVsKCZ2bS0+dm1fbGlzdF9ub2RlKTsKPiAgIAltdXRleF91bmxvY2soJnByb2Nlc3NfaW5m
by0+bG9jayk7Cj4gICAKPiArCXZtLT5wcm9jZXNzX2luZm8gPSBOVUxMOwo+ICsKPiAgIAkvKiBS
ZWxlYXNlIHBlci1wcm9jZXNzIHJlc291cmNlcyB3aGVuIGxhc3QgY29tcHV0ZSBWTSBpcyBkZXN0
cm95ZWQgKi8KPiAgIAlpZiAoIXByb2Nlc3NfaW5mby0+bl92bXMpIHsKPiAgIAkJV0FSTl9PTigh
bGlzdF9lbXB0eSgmcHJvY2Vzc19pbmZvLT5rZmRfYm9fbGlzdCkpOwo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPiBpbmRleCA2ZjYwYTU4MWUzYmEuLjE2NTg2
NjUxMDIwZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmMKPiBAQCAtMTMwNyw2ICsxMzA3LDEwIEBAIHZvaWQgYW1kZ3B1X2JvX3JlbGVhc2Vfbm90aWZ5
KHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8pCj4gICAJaWYgKGFiby0+a2ZkX2JvKQo+ICAg
CQlhbWRncHVfYW1ka2ZkX3VucmVzZXJ2ZV9tZW1vcnlfbGltaXQoYWJvKTsKPiAgIAo+ICsJLyog
V2Ugb25seSByZW1vdmUgdGhlIGZlbmNlIGlmIHRoZSByZXN2IGhhcyBpbmRpdmlkdWFsaXplZC4g
Ki8KPiArCWlmIChiby0+YmFzZS5yZXN2ID09ICZiby0+YmFzZS5fcmVzdikKPiArCQlhbWRncHVf
YW1ka2ZkX3JlbW92ZV9mZW5jZV9vbl9wdF9wZF9ib3MoYWJvKTsKPiArCj4gICAJaWYgKGJvLT5t
ZW0ubWVtX3R5cGUgIT0gVFRNX1BMX1ZSQU0gfHwgIWJvLT5tZW0ubW1fbm9kZSB8fAo+ICAgCSAg
ICAhKGFiby0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9WUkFNX1dJUEVfT05fUkVMRUFTRSkp
Cj4gICAJCXJldHVybjsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
