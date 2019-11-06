Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A37C5DF62
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 09:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1C92087E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 09:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1C92087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE936EC81;
	Wed,  6 Nov 2019 09:31:54 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F696EC80
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 09:31:52 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id m17so2482999wmi.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Nov 2019 01:31:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Bjj9esJTbBMs5GLL08CDgcwJIG5MrgmVU6YUkRqwNXQ=;
 b=s+D0as1Fa/n49Z31HkVJOyZ3vACLq5OFPGYOxP6AdAkkdgLFzARPCMUzl2XryxhsHC
 sub0uGj9sSRFBVKD1TspbzYk3yMa6YQ1YZ4YQOCMtLgT0SnU+zA2H62fdbICZ8KE2dOX
 zqMn8xsMLYJajfAbC0bRhK70kSseKmYbRNnSI89eri6Gm66mcE0D6ZpTfvCPgEjPRXhV
 5zStctzyMQaTYoc8jvVuSnT/rc9JrQK81YqLyhkmC+Rdr0cMGEeMzr3wqcRG+nioOceb
 Uwb7+kY4lqbLt99BgbS/4urc7lLIPDY0FanmbMCkK0VfKR9AdDgnSk3GNuiwYXajvoTj
 SM1g==
X-Gm-Message-State: APjAAAV8Rtqsz0EeUiXRohsazjrAmeJO1ArYbLBHgb6PO3CPe+qv0XfF
 FHUFtYiVMCoaQ71Wk9T5KyM9gwdp
X-Google-Smtp-Source: APXvYqxvtgWK4QKL/L4p3QExfKLTS+43tc9sGdOsrWU4eBWWAIeM79h59Xfkt14bcCxuvbjHGH9wtw==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr1508052wmh.40.1573032710926; 
 Wed, 06 Nov 2019 01:31:50 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y15sm10170989wrh.94.2019.11.06.01.31.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Nov 2019 01:31:50 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Need to disable msix when unloading driver
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1573021419-15518-1-git-send-email-Emily.Deng@amd.com>
 <MN2PR12MB2975A3DFE6CCED7BB3D6D2748F790@MN2PR12MB2975.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6be1e7b9-13a9-f382-ef66-00c284a14a14@gmail.com>
Date: Wed, 6 Nov 2019 10:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB2975A3DFE6CCED7BB3D6D2748F790@MN2PR12MB2975.namprd12.prod.outlook.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Bjj9esJTbBMs5GLL08CDgcwJIG5MrgmVU6YUkRqwNXQ=;
 b=W+e4TNNpWbqy1JgGNWlbag2AfRnaMdc2a+yrO9HaKcsRKrkVs4EQUqXiyDCHZB8MfB
 f65KN/MeWqdB+BsRyGDeZcdP11u7n6UtzrSPY6V54q6mrRB+faxLCWT8qDZ4cqoob922
 ERDb/KridFGIkddCidZFh0Wk9ZlFolcaDS1YMrHzHXNHssiI2UvGqlxNsMKbtyURYX5E
 1NXOAUqLa44tSK+kz4rCxuuXA4qEw/bWoe7PeJSDOwhFPerI1ney5rh/ZzGhfaJdf4h8
 R+iE5jcxNrDrM8Cv7/pddwmhymlPvPVxYutziZ+4Uyi3f5WmsdU5fxiJf5wR8p8hsDir
 GNew==
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
Message-ID: <20191106093149.5bh5P-g0hp9gdGkqclpwMFI8wEFkps23Z8jUQRHCW2c@z>

Tm90IGFuIGV4cGVydCBvbiB0aGUgUENJIElSUSBzdHVmZiwgYnV0IGZyb20gd2hhdCBJIGtub3cg
dGhhdCBsb29rcyAKY29ycmVjdCB0byBtZS4KCk9ubHkgcXVlc3Rpb24gSSBjYW4gc2VlIGlzIHdo
eSBkb24ndCB3ZSB1c2UgcGNpX2FsbG9jX2lycV92ZWN0b3JzKCk/IApBbGV4IHByb2JhYmx5IG5l
ZWRzIHRvIHRha2UgYSBsb29rLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKQW0gMDYuMTEuMTkgdW0g
MDc6Mjggc2NocmllYiBEZW5nLCBFbWlseToKPiBIaSBhbGwsCj4gICAgICBQbGVhc2UgaGVscCB0
byByZXZpZXcgdGhpcy4gVGhpcyBpcyB0byBmaXggZHJpdmVyIHJlbG9hZCBpc3N1ZS4KPgo+IEJl
c3Qgd2lzaGVzCj4gRW1pbHkgRGVuZwo+Cj4KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0K
Pj4gRnJvbTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgo+PiBTZW50OiBXZWRuZXNk
YXksIE5vdmVtYmVyIDYsIDIwMTkgMjoyNCBQTQo+PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPj4gQ2M6IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+Cj4+IFN1Ympl
Y3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogTmVlZCB0byBkaXNhYmxlIG1zaXggd2hlbiB1bmxvYWRp
bmcgZHJpdmVyCj4+Cj4+IEZvciBkcml2ZXIgcmVsb2FkIHRlc3QsIGl0IHdpbGwgcmVwb3J0ICJj
YW4ndCBlbmFibGUgTVNJIChNU0ktWCBhbHJlYWR5IGVuYWJsZWQpIi4KPj4KPj4gU2lnbmVkLW9m
Zi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgo+PiAtLS0KPj4gZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jIHwgMiArLQo+PiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYwo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9pcnEuYwo+PiBpbmRleCA2ZjNiMDNmLi4zMGQ1NDBkIDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmMKPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jCj4+IEBAIC0zMTEsNyArMzExLDcg
QEAgdm9pZCBhbWRncHVfaXJxX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+IAkJ
ZHJtX2lycV91bmluc3RhbGwoYWRldi0+ZGRldik7Cj4+IAkJYWRldi0+aXJxLmluc3RhbGxlZCA9
IGZhbHNlOwo+PiAJCWlmIChhZGV2LT5pcnEubXNpX2VuYWJsZWQpCj4+IC0JCQlwY2lfZGlzYWJs
ZV9tc2koYWRldi0+cGRldik7Cj4+ICsJCQlwY2lfZnJlZV9pcnFfdmVjdG9ycyhhZGV2LT5wZGV2
KTsKPj4gCQlpZiAoIWFtZGdwdV9kZXZpY2VfaGFzX2RjX3N1cHBvcnQoYWRldikpCj4+IAkJCWZs
dXNoX3dvcmsoJmFkZXYtPmhvdHBsdWdfd29yayk7Cj4+IAl9Cj4+IC0tCj4+IDIuNy40Cj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
