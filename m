Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98467C2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 15:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E64920759
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 15:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSPFqA8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E64920759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331146E063;
	Wed,  4 Nov 2020 15:20:23 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54A096E055;
 Wed,  4 Nov 2020 15:20:21 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id e18so11686304edy.6;
 Wed, 04 Nov 2020 07:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=9iHINUPztdXJT1/XCPbKjId6dxADhBL2QcIoiIOznIw=;
 b=vSPFqA8r2PbLFpSFPOF0HHZS1aGu+jgHNhjs0zSutvtxG3TPtJv4tLouv7B417H7R5
 6GFEaf12h5P+TJDjtKH0Pb+70xBpoKdYXLGU2KqpU4hv3lng0SivYVFvIqnhZLRbUrk4
 tu89ZLgNieR04bW7rvse9oJVl+TphAdB7z/u2u99o6+jnbaV7evSzrjwBYWy+QQlIuwE
 dkSff4xpYM6m27xQtEMrzOJU7bP6YfBQJ9Z2N/YwOP6EOyxi+1XUZJWrud74oHOGfA0B
 ptRfjuOltZLtFOZAJFxrY3EArR+p0zaXWD3gboZ3ggCoZ6AjXQObi35Fpkkryu522wdO
 hqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9iHINUPztdXJT1/XCPbKjId6dxADhBL2QcIoiIOznIw=;
 b=PX7S/odVPmIfTJzuprWVFGIFWOLnHuDjRh9/FQN+kL67AS7J4+XIO66ojNd9ZH6KAu
 i3ux6OUaWl3N8jjO68CVUhNrM3Bgeo7LsDthfpaq4/bTSZripRWPsGXcHjA1ESUgrMox
 /3OkvJQ96nu0j6JlMCZ+d56gHUK/oz+mUNM/x5xs8REQb8zUhtxogRh3CxKiYBcUwpcp
 qZFuIiu7SM6Gc2KwWqUWBFK2HyoqI5Wli53v/VpszC0CHCKAs+uAU7RdH+wlqI1NCcyT
 2ItV7Y4FjxrFKl31GmmwmZp8qkp72BJQERJS8hV4zv+laMy3AYrWxzeAebObWaI/RWqq
 MGIQ==
X-Gm-Message-State: AOAM530vGZzSjB2D7wNZzWmGiq0N8dsv472IFHjo7y5Sgm+dKVxm8wuZ
 5xj3U7H3Vfh8rsebKzowxfo=
X-Google-Smtp-Source: ABdhPJy+J2KPbmkO9Ole5/OvXG6TfuEtPx1fnftkDEYDhniSshEU7K3eTaHLQE4Ue/qXqWGf0Ig+cg==
X-Received: by 2002:a05:6402:3136:: with SMTP id
 dd22mr15592036edb.256.1604503220063; 
 Wed, 04 Nov 2020 07:20:20 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 22sm1157421ejw.27.2020.11.04.07.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 07:20:19 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: replace idr_init() by idr_init_base()
To: Deepak R Varma <mh12gx2825@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20201104151630.GA69221@localhost>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <765f1539-c657-ede4-96d6-586555f5e658@gmail.com>
Date: Wed, 4 Nov 2020 16:20:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104151630.GA69221@localhost>
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

QW0gMDQuMTEuMjAgdW0gMTY6MTYgc2NocmllYiBEZWVwYWsgUiBWYXJtYToKPiBpZHJfaW5pdCgp
IHVzZXMgYmFzZSAwIHdoaWNoIGlzIGFuIGludmFsaWQgaWRlbnRpZmllci4gVGhlIG5ldyBmdW5j
dGlvbgo+IGlkcl9pbml0X2Jhc2UgYWxsb3dzIElEUiB0byBzZXQgdGhlIElEIGxvb2t1cCBmcm9t
IGJhc2UgMS4gVGhpcyBhdm9pZHMKPiBhbGwgbG9va3VwcyB0aGF0IG90aGVyd2lzZSBzdGFydHMg
ZnJvbSAwIHNpbmNlIDAgaXMgYWx3YXlzIHVudXNlZC4KPgo+IFJlZmVyZW5jZXM6IGNvbW1pdCA2
Y2U3MTFmMjc1MDAgKCJpZHI6IE1ha2UgMS1iYXNlZCBJRFJzIG1vcmUgZWZmaWNpZW50IikKPgo+
IFNpZ25lZC1vZmYtYnk6IERlZXBhayBSIFZhcm1hIDxtaDEyZ3gyODI1QGdtYWlsLmNvbT4KClJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+
IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIHwgMiArLQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgMiArLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgIHwgMiArLQo+ICAgMyBmaWxlcyBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4gaW5kZXggYzgwZDgzMzlmNThjLi5iOThhZTE3M2E5
ZGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4gQEAgLTU3
Niw3ICs1NzYsNyBAQCBpbnQgYW1kZ3B1X2N0eF93YWl0X3ByZXZfZmVuY2Uoc3RydWN0IGFtZGdw
dV9jdHggKmN0eCwKPiAgIHZvaWQgYW1kZ3B1X2N0eF9tZ3JfaW5pdChzdHJ1Y3QgYW1kZ3B1X2N0
eF9tZ3IgKm1ncikKPiAgIHsKPiAgIAltdXRleF9pbml0KCZtZ3ItPmxvY2spOwo+IC0JaWRyX2lu
aXQoJm1nci0+Y3R4X2hhbmRsZXMpOwo+ICsJaWRyX2luaXRfYmFzZSgmbWdyLT5jdHhfaGFuZGxl
cywgMSk7Cj4gICB9Cj4gICAKPiAgIGxvbmcgYW1kZ3B1X2N0eF9tZ3JfZW50aXR5X2ZsdXNoKHN0
cnVjdCBhbWRncHVfY3R4X21nciAqbWdyLCBsb25nIHRpbWVvdXQpCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwo+IGluZGV4IGVmZGEzODM0OWEwMy4uZDY1YTE4ODg2ODNi
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwo+IEBAIC0xMDUy
LDcgKzEwNTIsNyBAQCBpbnQgYW1kZ3B1X2RyaXZlcl9vcGVuX2ttcyhzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGV2LCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGVfcHJpdikKPiAgIAl9Cj4gICAKPiAgIAltdXRl
eF9pbml0KCZmcHJpdi0+Ym9fbGlzdF9sb2NrKTsKPiAtCWlkcl9pbml0KCZmcHJpdi0+Ym9fbGlz
dF9oYW5kbGVzKTsKPiArCWlkcl9pbml0X2Jhc2UoJmZwcml2LT5ib19saXN0X2hhbmRsZXMsIDEp
Owo+ICAgCj4gICAJYW1kZ3B1X2N0eF9tZ3JfaW5pdCgmZnByaXYtPmN0eF9tZ3IpOwo+ICAgCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCBkZjExMGFmYTk3YmYu
LjAxNTQyODI3NzFjNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
Cj4gQEAgLTMxOTksNyArMzE5OSw3IEBAIHZvaWQgYW1kZ3B1X3ZtX21hbmFnZXJfaW5pdChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAlhZGV2LT52bV9tYW5hZ2VyLnZtX3VwZGF0ZV9t
b2RlID0gMDsKPiAgICNlbmRpZgo+ICAgCj4gLQlpZHJfaW5pdCgmYWRldi0+dm1fbWFuYWdlci5w
YXNpZF9pZHIpOwo+ICsJaWRyX2luaXRfYmFzZSgmYWRldi0+dm1fbWFuYWdlci5wYXNpZF9pZHIs
IDEpOwo+ICAgCXNwaW5fbG9ja19pbml0KCZhZGV2LT52bV9tYW5hZ2VyLnBhc2lkX2xvY2spOwo+
ICAgfQo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
