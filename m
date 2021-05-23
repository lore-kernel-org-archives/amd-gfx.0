Return-Path: <SRS0=bUVd=KS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02809C47080
	for <amd-gfx@archiver.kernel.org>; Sun, 23 May 2021 16:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952A4611CC
	for <amd-gfx@archiver.kernel.org>; Sun, 23 May 2021 16:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952A4611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D171489CB5;
	Sun, 23 May 2021 16:55:54 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D155789CB5
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 May 2021 16:55:52 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id s6so29061610edu.10
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 May 2021 09:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=xqWQ99UaYuuVuH9VzUWeiQVTrYuGlWB1vZz64Su1WO8=;
 b=TM0ejDs9j9ksCF2Y7Cm99c/ISOSLGu/W4QrfsOx6iQu2Z7MVSmnRt9V6MvvKBMTadO
 jEufppHzeepl/Dkq2bD5UmIWKk8Du+9eIWS1yAoyNMqvh0D2Ay7Hi3MnydQrDlH1nF3e
 H6lDh/Got4p1/E5eaUhD+GFWQr4DF8+fn/w6dV9ZFtGfw4vHernZlSEIigA/R0EQpyHF
 V3HZ1VE4Q/7bQWtMK70o2KueSuLnOc7NM5jFc15nga/LiwyTT7oUSM5kyPH7dqFZ1DPh
 A6eXf9vfY4JlElJ6ex8Onhelf5eJkC4RdeLlBgj9nYfGEgqHXJrpN+yjwbJfU4Fo5TFh
 G5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=xqWQ99UaYuuVuH9VzUWeiQVTrYuGlWB1vZz64Su1WO8=;
 b=sThZpOrIrZLrQ4KjxrwrsvuOFlZIT71J0ksYITNgfWpi2izDTf49TL4Wv0W0dGFbB/
 3Odu9AA4Nu+UzyjfVh11Rp5Yzp4PHUv/a7YogwVnrwxAK3lEbwPIiJ8aIesCh8ruvgx0
 4G03dyLwjyc5/kusa4OPrTfwHDE/oiPA2lG4XHfofk/cDYKzS24WVVz4hpQuTqvNGQoD
 Ldy2qxGP6/Iz7MjNWmrx1ljO9Io0LeI9w95sQsAu3FYlL29CgbA/9jb+lvFuV0DM59Xt
 +BTAuHISOmfrd7MeHlLNTMIqydghEm5yk8Af3zdWaL0b/GQ1cTjHNxYOIVpHWjcVy8PE
 ElMg==
X-Gm-Message-State: AOAM532MJm6Dz7es+IJrwepvhSO+glbotwbZDdoFFmUgaf5Nq085Qua5
 phFpuNK0+t2q73nOOYZij16oGl5xyR4=
X-Google-Smtp-Source: ABdhPJwjt7UCF86QI8cxzWhezoaY9ESLcr5+VS8NoyLHe2TYdx3Bc/beW6B0u61U6pSerdHvl+FVtQ==
X-Received: by 2002:a05:6402:4394:: with SMTP id
 o20mr3116403edc.357.1621788951665; 
 Sun, 23 May 2021 09:55:51 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:d716:abf2:6ef8:7167?
 ([2a02:908:1252:fb60:d716:abf2:6ef8:7167])
 by smtp.gmail.com with ESMTPSA id bo25sm8140519edb.67.2021.05.23.09.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 May 2021 09:55:51 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix a BUG_ON due to resv trylock fails
To: Felix Kuehling <felix.kuehling@amd.com>, xinhui pan <xinhui.pan@amd.com>, 
 amd-gfx@lists.freedesktop.org
References: <20210522021114.4166-1-xinhui.pan@amd.com>
 <f0221594-e9e1-5a84-2225-065a106b2995@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d66ced99-6311-6698-dc75-e88f30ab7535@gmail.com>
Date: Sun, 23 May 2021 18:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f0221594-e9e1-5a84-2225-065a106b2995@amd.com>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDUuMjEgdW0gMDQ6NTcgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBXaGVuIHRoZSBC
TyBnZXRzIGluZGl2aWR1YWxpemVkLCB0aGVyZSBpcyBhbiBhc3N1bXB0aW9uIHRoYXQgbm9ib2R5
IGlzCj4gYWNjZXNzaW5nIGl0IGFueSBtb3JlLiBTZWUgdGhpcyBjb21tZW50IGluIHR0bV9ib19p
bmRpdmlkdWFsaXplX3Jlc3Y6Cj4KPiAgICAgICAgICAgICAgICAgIC8qIFRoaXMgd29ya3MgYmVj
YXVzZSB0aGUgQk8gaXMgYWJvdXQgdG8gYmUgZGVzdHJveWVkIGFuZCBub2JvZHkKPiAgICAgICAg
ICAgICAgICAgICAqIHJlZmVyZW5jZSBpdCBhbnkgbW9yZS4gVGhlIG9ubHkgdHJpY2t5IGNhc2Ug
aXMgdGhlIHRyeWxvY2sgb24KPiAgICAgICAgICAgICAgICAgICAqIHRoZSByZXN2IG9iamVjdCB3
aGlsZSBob2xkaW5nIHRoZSBscnVfbG9jay4KPiAgICAgICAgICAgICAgICAgICAqLwo+Cj4gVGhh
dCBpcyB2aW9sYXRlZCB3aGVuIHRoZSBCTyBpcyBzdGlsbCBiZWluZyBzd2FwcGVkIG91dCBhdCB0
aGlzIHN0YWdlLgo+IFlvdSBjYW4ga2luZCBvZiBwYXBlciB0aGF0IG92ZXIgYnkgdGFraW5nIHRo
ZSBMUlUgbG9jay4gQnV0IHRoZXJlIGFyZQo+IHByb2JhYmx5IG90aGVyIHJhY2UgY29uZGl0aW9u
cyBnb2luZyBvbiB3aGVuIHRoZSByZXNlcnZhdGlvbiBnZXRzCj4gc3dhcHBlZCBieSAiaW5kaXZp
ZHVhbGl6ZSIgZHVyaW5nIGFuIGV2aWN0aW9uLgo+Cj4gSSB0aGluayB0byBhdm9pZCBhbGwgdGhh
dCBUVE0gbmVlZHMgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIEJPIGlzIG5vCj4gbG9uZ2VyIG9uIHRo
ZSBMUlUgbGlzdCB3aGVuIGl0IGdldHMgaW5kaXZpZHVhbGl6ZWQuCgpFeGFjdGx5IHRoYXQgaXMg
d2hhdCB3ZSB0cnkgdG8gYXZvaWQgYmVjYXVzZSB3ZSB3YW50IHRvIGtlZXAgdGhlIApwb3NpdGlv
biBvbiB0aGUgTFJVIHRoZSBzYW1lLgoKSW5kaXZpZHVhbGl6aW5nIHdvcmtzIGJlY2F1c2UgdGhl
IHN3YXAgYW5kIGV2aWN0IGNvZGUgaWdub3JlcyBCT3Mgd2l0aCAKemVybyByZWZlcmVuY2UgY291
bnQuCgpTbyB5ZXMgSSB0aGluayBYaW5odWkncyBwYXRjaCBzaG91bGQgd29yayBmaW5lLgoKUmVn
YXJkcywKQ2hyaXN0aWFuLgoKPgo+IFJlZ2FyZHMsCj4gIMKgIEZlbGl4Cj4KPgo+IEFtIDIwMjEt
MDUtMjEgdW0gMTA6MTEgcC5tLiBzY2hyaWViIHhpbmh1aSBwYW46Cj4+IFRoZSByZXNlcnZhdGlv
biBvYmplY3QgbWlnaHQgYmUgbG9ja2VkIGFnYWluIGJ5IGV2aWN0L3N3YXAgYWZ0ZXIKPj4gaW5k
aXZpZHVhbGl6ZWQuIFRoZSByYWNlIGlzIGxpa2UgYmVsb3cuCj4+IGNwdSAwICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjcHUgMQo+PiBCTyByZWxlYXNlCQkJCUJPIGV2aWN0IG9y
IHN3YXAKPj4gCQkJCQlsb2NrIGxydV9sb2NrCj4+IHR0bV9ib19pbmRpdmlkdWFsaXplX3Jlc3Yg
e3Jlc3YgPSAmX3Jlc3Z9Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdHRtX2JvX2V2aWN0X3N3YXBvdXRfYWxsb3dhYmxlCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFfcmVzdl90cnlsb2NrKHJlc3YpCj4+IC0+
cmVsZWFzZV9ub3RpZnkoKSB7QlVHX09OKCF0cnlsb2NrKHJlc3YpKX0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXR0bV9ib19nZXRfdW5sZXNzX3plcm8p
KQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1h
X3Jlc3ZfdW5sb2NrKHJlc3YpCj4+IAkJCQkJdW5sb2NrIGxydV9sb2NrCj4+IFRvIGZpeCBpdCBz
aW1wbHksIGxldCdzIGFjcXVpcmUgbHJ1X2xvY2sgYmVmb3JlIHJlc3YgdHJ5bG9jayB0byBhdm9p
ZAo+PiB0aGUgcmFjZSBhYm92ZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGlu
aHVpLnBhbkBhbWQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2dwdXZtLmMgfCAyICsrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZF9ncHV2bS5jCj4+IGluZGV4IDkyOGU4ZDU3Y2QwOC4uOGY2ZGEwMDM0ZGI5IDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMK
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5j
Cj4+IEBAIC0zMTgsNyArMzE4LDkgQEAgaW50IGFtZGdwdV9hbWRrZmRfcmVtb3ZlX2ZlbmNlX29u
X3B0X3BkX2JvcyhzdHJ1Y3QgYW1kZ3B1X2JvICpibykKPj4gICAJZWYgPSBjb250YWluZXJfb2Yo
ZG1hX2ZlbmNlX2dldCgmaW5mby0+ZXZpY3Rpb25fZmVuY2UtPmJhc2UpLAo+PiAgIAkJCXN0cnVj
dCBhbWRncHVfYW1ka2ZkX2ZlbmNlLCBiYXNlKTsKPj4gICAKPj4gKwlzcGluX2xvY2soJmJvLT50
Ym8uYmRldi0+bHJ1X2xvY2spOwo+PiAgIAlCVUdfT04oIWRtYV9yZXN2X3RyeWxvY2soYm8tPnRi
by5iYXNlLnJlc3YpKTsKPj4gKwlzcGluX3VubG9jaygmYm8tPnRiby5iZGV2LT5scnVfbG9jayk7
Cj4+ICAgCXJldCA9IGFtZGdwdV9hbWRrZmRfcmVtb3ZlX2V2aWN0aW9uX2ZlbmNlKGJvLCBlZik7
Cj4+ICAgCWRtYV9yZXN2X3VubG9jayhiby0+dGJvLmJhc2UucmVzdik7Cj4+ICAgCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
