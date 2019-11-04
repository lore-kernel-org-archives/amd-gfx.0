Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF7BCA9EA0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 11:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9A321D7F
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 11:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9A321D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06756E2F9;
	Mon,  4 Nov 2019 11:50:26 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD9E06E2F9
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 11:50:25 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 11so16342686wmk.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Nov 2019 03:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rntsHgqokAc6hqODqYXC33+49oL+CfVDaZl2gVwzn2E=;
 b=c+Y0jFzsUt9CEzqG8bc9YHnaokoXuchgauSEKox/P0ehmIBNiwXXzdp1wAgZ2347cl
 cA9xm1nzvIWUX4dx9jYWYUuMO/n3Qc5dHpZw0CXmlDcjjT4voiFNOHG/IlhL4eXqcIZt
 hjisRdVh8Dy0xYo2QHx80xPI01YhRuioBtho042jjVZVJQsmFUSmkFlaSTn3hzl3OFha
 vDnySlIqQa9LzNxEcMSCwpD/aqyYpQmQVLGNX2sfXSoQ/Z2Lt5dGDla54FhH+ZB+9qks
 xx5kbKgk36Nn9e6z2wBSVu7fH9hM/4M2/qV6S7xCgW9Ubn0UZU2wdCTg6VGoOFMBmyPJ
 2yzg==
X-Gm-Message-State: APjAAAUPBwUxEBXMbQD7Vj+HdA31oXqp5idXyQxtYuHeg0L18ttiuvyc
 kNzApgIgMVHhXQPyOGFfcdrfSMsz
X-Google-Smtp-Source: APXvYqxcLksA4vBPGCOpECfIE397Ui4MW+jBZmtuswMhN+7wyk+uLTNjQNqQEu3/EK0bVam8dFYk4g==
X-Received: by 2002:a05:600c:1002:: with SMTP id
 c2mr2924662wmc.79.1572868224204; 
 Mon, 04 Nov 2019 03:50:24 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id p12sm18428815wrm.62.2019.11.04.03.50.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Nov 2019 03:50:23 -0800 (PST)
Subject: Re: [PATCH v2] drm/amdgpu: Need to free discovery memory
To: "Deng, Emily" <Emily.Deng@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1572836597-31265-1-git-send-email-Emily.Deng@amd.com>
 <MN2PR12MB3087E540D23C1A98B8269239897F0@MN2PR12MB3087.namprd12.prod.outlook.com>
 <MN2PR12MB29751F7D33E9D6398FEF7D508F7F0@MN2PR12MB2975.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3c4b0c65-4234-626f-4616-3d75c0767552@gmail.com>
Date: Mon, 4 Nov 2019 12:50:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB29751F7D33E9D6398FEF7D508F7F0@MN2PR12MB2975.namprd12.prod.outlook.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=rntsHgqokAc6hqODqYXC33+49oL+CfVDaZl2gVwzn2E=;
 b=m/nMQMdn4bv9q+6PM6L77Q33T4+ajxGKnvH7bi5mvFWA2N5ZLZ5uXMs8hvJCm9yo0Q
 4eGROwR4sUtfYY0bDbNre9S1dR+r7s4lrO4RkD7ueWiCM4PierVC3U1ZtZ17uBN8Vg6a
 TN70XNi50pH4xEy7txUCwk3VPw+Brp7Wn2Qn+R4cYhbfxZrcmCU53MQi47clCIThkl3f
 PB7Hc3qeRJLb6NT37uCU2a76RyF6QDNFdl6D3Ie0p1P8lEzC0AM+nz8HIQ827+i6Arui
 gnPETfFwP2ZF4n5nYOsuK2vl26CN1Ly/FOB6EfCk75ildcyf94BcjF/x2Ombw+5AuX6U
 VJzA==
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
Message-ID: <20191104115022.39KKvwCioon3KJf-n4NrtqghQ1DuOC6sKiWM5G1JL0w@z>

PiBQbGVhc2UgdXNlICdkcm0vYW1kZ3B1L2Rpc2NvdmVyeTogJyBwcmVmaXggaW4gY29tbWl0IG1l
c3NhZ2UgdG8gbGV0IHVzIGVhc2lseQo+IHRyYWNrIGFsbCBkaXNjb3ZlcnktcmVsZWF0ZWQgY2hh
bmdlcy4KCkFjdHVhbGx5IHBsZWFzZSBkb24ndC4gVGhlIHByZWZpeCBpcyB0byBkZW5vdGUgd2hp
Y2ggZHJpdmVyL2NvZGUgYmFzZSBpcyAKY2hhbmdlZC4KCklQIGRpc2NvdmVyeSBpcyBqdXN0IGEg
ZmVhdHVyZSBhbmQgbm90IGxpbWl0ZWQgdG8gYSBjZXJ0YWluIGNvZGUgYmFzZSAKaW5zaWRlIHRo
ZSBkcml2ZXIuCgpNZW50aW9uaW5nICJkaXNjb3ZlcnkgbWVtb3J5IiBpbiB0aGUgY29tbWl0IG1l
c3NhZ2Ugc2hvdWxkIGJlIGZpbmUgYWxyZWFkeS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCkFtIDA0
LjExLjE5IHVtIDA1OjQ1IHNjaHJpZWIgRGVuZywgRW1pbHk6Cj4gVGhhbmtzLCBkb25lLgo+Cj4g
QmVzdCB3aXNoZXMKPiBFbWlseSBEZW5nCj4KPgo+Cj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tCj4+IEZyb206IFl1YW4sIFhpYW9qaWUgPFhpYW9qaWUuWXVhbkBhbWQuY29tPgo+PiBTZW50
OiBNb25kYXksIE5vdmVtYmVyIDQsIDIwMTkgMTE6NDEgQU0KPj4gVG86IERlbmcsIEVtaWx5IDxF
bWlseS5EZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBOZWVkIHRvIGZyZWUgZGlzY292ZXJ5IG1l
bW9yeQo+Pgo+PiBQbGVhc2UgdXNlICdkcm0vYW1kZ3B1L2Rpc2NvdmVyeTogJyBwcmVmaXggaW4g
Y29tbWl0IG1lc3NhZ2UgdG8gbGV0IHVzIGVhc2lseQo+PiB0cmFjayBhbGwgZGlzY292ZXJ5LXJl
bGVhdGVkIGNoYW5nZXMuCj4+IE90aGVyIHRoYW4gdGhpcywgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6
IFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55dWFuQGFtZC5jb20+Cj4+Cj4+IEJSLAo+PiBYaWFvamll
Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gRnJvbTog
YW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gb24gYmVoYWxm
IG9mIEVtaWx5Cj4+IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4KPj4gU2VudDogTW9uZGF5LCBO
b3ZlbWJlciA0LCAyMDE5IDExOjAzIEFNCj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+PiBDYzogRGVuZywgRW1pbHkKPj4gU3ViamVjdDogW1BBVENIIHYyXSBkcm0vYW1kZ3B1
OiBOZWVkIHRvIGZyZWUgZGlzY292ZXJ5IG1lbW9yeQo+Pgo+PiBXaGVuIHVubG9hZGluZyBkcml2
ZXIsIG5lZWQgdG8gZnJlZSBkaXNjb3ZlcnkgbWVtb3J5Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBF
bWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+Cj4+IC0tLQo+PiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCA2ICsrKy0tLQo+PiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3R0bS5jCj4+IGluZGV4IDI4YjA5ZjYuLjdjYmU2ZDkgMTAwNjQ0Cj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPj4gQEAgLTIxMDYsOSArMjEwNiw2
IEBAIHZvaWQgYW1kZ3B1X3R0bV9sYXRlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UKPj4gKmFk
ZXYpCj4+ICAgICAgICAgdm9pZCAqc3RvbGVuX3ZnYV9idWY7Cj4+ICAgICAgICAgLyogcmV0dXJu
IHRoZSBWR0Egc3RvbGVuIG1lbW9yeSAoaWYgYW55KSBiYWNrIHRvIFZSQU0gKi8KPj4gICAgICAg
ICBhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPnN0b2xlbl92Z2FfbWVtb3J5LCBOVUxMLAo+
PiAmc3RvbGVuX3ZnYV9idWYpOwo+PiAtCj4+IC0gICAgICAgLyogcmV0dXJuIHRoZSBJUCBEaXNj
b3ZlcnkgVE1SIG1lbW9yeSBiYWNrIHRvIFZSQU0gKi8KPj4gLSAgICAgICBhbWRncHVfYm9fZnJl
ZV9rZXJuZWwoJmFkZXYtPmRpc2NvdmVyeV9tZW1vcnksIE5VTEwsIE5VTEwpOwo+PiB9Cj4+Cj4+
IC8qKgo+PiBAQCAtMjEyMSw3ICsyMTE4LDEwIEBAIHZvaWQgYW1kZ3B1X3R0bV9maW5pKHN0cnVj
dCBhbWRncHVfZGV2aWNlCj4+ICphZGV2KQo+Pgo+PiAgICAgICAgIGFtZGdwdV90dG1fZGVidWdm
c19maW5pKGFkZXYpOwo+PiAgICAgICAgIGFtZGdwdV90dG1fdHJhaW5pbmdfcmVzZXJ2ZV92cmFt
X2ZpbmkoYWRldik7Cj4+ICsgICAgICAgLyogcmV0dXJuIHRoZSBJUCBEaXNjb3ZlcnkgVE1SIG1l
bW9yeSBiYWNrIHRvIFZSQU0gKi8KPj4gKyAgICAgICBhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFk
ZXYtPmRpc2NvdmVyeV9tZW1vcnksIE5VTEwsIE5VTEwpOwo+PiAgICAgICAgIGFtZGdwdV90dG1f
ZndfcmVzZXJ2ZV92cmFtX2ZpbmkoYWRldik7Cj4+ICsKPj4gICAgICAgICBpZiAoYWRldi0+bW1h
bi5hcGVyX2Jhc2Vfa2FkZHIpCj4+ICAgICAgICAgICAgICAgICBpb3VubWFwKGFkZXYtPm1tYW4u
YXBlcl9iYXNlX2thZGRyKTsKPj4gICAgICAgICBhZGV2LT5tbWFuLmFwZXJfYmFzZV9rYWRkciA9
IE5VTEw7Cj4+IC0tCj4+IDIuNy40Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
