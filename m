Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AB2C3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 11:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A7E2146E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 11:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFNgzc71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A7E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A94EB6E25B;
	Thu,  5 Mar 2020 11:25:15 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2B66E25B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 11:25:14 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id 6so1116183wre.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2020 03:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=68aKX7Boy1dgs9T+g5execPAPvmnX3avQ0qCOFZm8uM=;
 b=FFNgzc71VwLEkYPc8PRo8lJcM7fEbcwlcVjWE8D6fCSPl2AsupXGZCQtreXGyIQmt8
 XCbcSxxJvyN1yi8Mffg3LUfPXdsHMZlm7+tczqLQjsBeAprK2voJXw2Gb7wSxD24V6b9
 JF2IhSSbW0iZxdXIAt/HTXK2LDqSbEaplwF05ewgnGpYOgntUG6ATwspjmMC31tQBpQI
 0huvI4Wxamnmf0ZExwtDfijRZ5CmKNXxr+SObGAYHKOQwixJlO1EyhTCbOnl+2okoZv7
 OvwV9O3dqmZ+HAYRowXHQN1erB/aiqKn/knsxlV/bEGzYbuEBaTJh27CyrohbWPWrI5x
 l6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=68aKX7Boy1dgs9T+g5execPAPvmnX3avQ0qCOFZm8uM=;
 b=EfcI5PJdFUWZLcB2ndrDyrA3y0N9DaYf0941Kyza8TGWp9VEuNRE+y5CW1xm+ZfQs5
 +LuSUfop+DZ4zaX9jNwH/WvnPAoOu7vJEMvpNSM+d470HK7rk9SXk6P4g1WDtJkuhQkD
 qX3barx0wmpxQM0O9pym9+sR/1ahYA2G/GEhgm/7lqafU246OUEjrLcqSJgdGX55r+ef
 6qcR0pN5H2WXb9IyYN9KOUyJHaX48qVtYO1uDCAa7cY07eor1Eevai+QbkZXL0z3mx/N
 1vogGboJMZ4awnesTAQidA7IJU4Ly2B6XwCyhcV9m+rffvt2wTExaJIxfm5iG+eEAPAh
 uwUQ==
X-Gm-Message-State: ANhLgQ3JwLdhuqKENSQTOlGme4zizGlhJXf9Or7MyA7aEMuaeimJC3zU
 MLj1kZx0sxG5Q2/I1SHcmug4jldQ
X-Google-Smtp-Source: ADFU+vuq8R28mBM9YeNQJjdIXmzGZOsZHYxfcrbvAbJBZXmiNDADnL0x6aChLSIGAID/4x9E+KT7fg==
X-Received: by 2002:a5d:6083:: with SMTP id w3mr9674040wrt.395.1583407513203; 
 Thu, 05 Mar 2020 03:25:13 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id l4sm45975090wrv.22.2020.03.05.03.25.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 03:25:12 -0800 (PST)
Subject: Re: [PATCH v2 1/4] drm/amdgpu/vcn: fix race condition issue for vcn
 start
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
 <1583339699-11332-1-git-send-email-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9d50a60f-0b1d-ad1c-944c-7ff3a7b7cec5@gmail.com>
Date: Thu, 5 Mar 2020 12:25:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583339699-11332-1-git-send-email-James.Zhu@amd.com>
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDQuMDMuMjAgdW0gMTc6MzQgc2NocmllYiBKYW1lcyBaaHU6Cj4gRml4IHJhY2UgY29uZGl0
aW9uIGlzc3VlIHdoZW4gbXVsdGlwbGUgdmNuIHN0YXJ0cyBhcmUgY2FsbGVkLgo+Cj4gdjI6IFJl
bW92ZWQgY2hlY2tpbmcgdGhlIHJldHVybiB2YWx1ZSBvZiBjYW5jZWxfZGVsYXllZF93b3JrX3N5
bmMoKQo+IHRvIHByZXZlbnQgcG9zc2libGUgcmFjZXMgaGVyZS4KPgo+IFNpZ25lZC1vZmYtYnk6
IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyB8IDE1ICsrKysrKysrKy0tLS0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIHwgIDEgKwo+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+IGluZGV4IGY5NjQ2NGUuLjhhODQwNmIgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4gQEAgLTYzLDYgKzYzLDcgQEAg
aW50IGFtZGdwdV92Y25fc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAlp
bnQgaSwgcjsKPiAgIAo+ICAgCUlOSVRfREVMQVlFRF9XT1JLKCZhZGV2LT52Y24uaWRsZV93b3Jr
LCBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKTsKPiArCW11dGV4X2luaXQoJmFkZXYtPnZj
bi52Y25fcGdfbG9jayk7Cj4gICAKPiAgIAlzd2l0Y2ggKGFkZXYtPmFzaWNfdHlwZSkgewo+ICAg
CWNhc2UgQ0hJUF9SQVZFTjoKPiBAQCAtMjEwLDYgKzIxMSw3IEBAIGludCBhbWRncHVfdmNuX3N3
X2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJfQo+ICAgCj4gICAJcmVsZWFz
ZV9maXJtd2FyZShhZGV2LT52Y24uZncpOwo+ICsJbXV0ZXhfZGVzdHJveSgmYWRldi0+dmNuLnZj
bl9wZ19sb2NrKTsKPiAgIAo+ICAgCXJldHVybiAwOwo+ICAgfQo+IEBAIC0zMTksMTMgKzMyMSwx
MyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykKPiAgIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3Qg
YW1kZ3B1X3JpbmcgKnJpbmcpCj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYg
PSByaW5nLT5hZGV2Owo+IC0JYm9vbCBzZXRfY2xvY2tzID0gIWNhbmNlbF9kZWxheWVkX3dvcmtf
c3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7Cj4gICAKPiAtCWlmIChzZXRfY2xvY2tzKSB7Cj4g
LQkJYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxzZSk7Cj4gLQkJYW1kZ3B1X2RldmljZV9p
cF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgQU1EX0lQX0JMT0NLX1RZUEVfVkNOLAo+IC0J
CSAgICAgICBBTURfUEdfU1RBVEVfVU5HQVRFKTsKPiAtCX0KPiArCWNhbmNlbF9kZWxheWVkX3dv
cmtfc3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7Cj4gKwo+ICsJbXV0ZXhfbG9jaygmYWRldi0+
dmNuLnZjbl9wZ19sb2NrKTsKPiArCWFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgZmFsc2UpOwo+
ICsJYW1kZ3B1X2RldmljZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgQU1EX0lQX0JM
T0NLX1RZUEVfVkNOLAo+ICsJICAgICAgIEFNRF9QR19TVEFURV9VTkdBVEUpOwo+ICAgCj4gICAJ
aWYgKGFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfVkNOX0RQRykJewo+ICAgCQlzdHJ1
Y3QgZHBnX3BhdXNlX3N0YXRlIG5ld19zdGF0ZTsKPiBAQCAtMzQ1LDYgKzM0Nyw3IEBAIHZvaWQg
YW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4gICAK
PiAgIAkJYWRldi0+dmNuLnBhdXNlX2RwZ19tb2RlKGFkZXYsIHJpbmctPm1lLCAmbmV3X3N0YXRl
KTsKPiAgIAl9Cj4gKwltdXRleF91bmxvY2soJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7Cj4gICB9
Cj4gICAKPiAgIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2VuZF91c2Uoc3RydWN0IGFtZGdwdV9yaW5n
ICpyaW5nKQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dmNuLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKPiBpbmRleCA2
ZmUwNTczLi4yYWUxMTBkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y24uaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
Y24uaAo+IEBAIC0yMDAsNiArMjAwLDcgQEAgc3RydWN0IGFtZGdwdV92Y24gewo+ICAgCXN0cnVj
dCBkcm1fZ3B1X3NjaGVkdWxlciAqdmNuX2RlY19zY2hlZFtBTURHUFVfTUFYX1ZDTl9JTlNUQU5D
RVNdOwo+ICAgCXVpbnQzMl90CQkgbnVtX3Zjbl9lbmNfc2NoZWQ7Cj4gICAJdWludDMyX3QJCSBu
dW1fdmNuX2RlY19zY2hlZDsKPiArCXN0cnVjdCBtdXRleAkJIHZjbl9wZ19sb2NrOwo+ICAgCj4g
ICAJdW5zaWduZWQJaGFydmVzdF9jb25maWc7Cj4gICAJaW50ICgqcGF1c2VfZHBnX21vZGUpKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
