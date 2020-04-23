Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65A9C54FCB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 14:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E162074F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 14:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tbcco9AE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E162074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E23A6E880;
	Thu, 23 Apr 2020 14:55:35 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EBA16E880
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 14:55:34 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id j2so7193674wrs.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=H1YDdrW1qFNgDf3sWJRICdkWeBD9FXxamu4eCju/NfQ=;
 b=Tbcco9AE9/AUPe9FFx3b/aqprHtn/KiAX+dwCMbfO+fILMM1iKH1MjEqinAy/Yd7r3
 Y8y6anqwXtz/4OlJxt+l5frpR41ReD/UqG3+lJrmIpdp5THlxqo0QD0VzCFHRc3TdrUh
 NwdKwNjPp8QqIDDON4eUP/UaymmcpjfeF0iI5gjcZ9TJ7lbfaQcnZXdNPGLcgP1AtYoG
 bvB5BvE1ytV11YRwZXl5ttWSgFq3qRmrcAF6LrPKEoTm7f0ydOF+11T8dx556O6c8wPj
 AedbRA6CPkYhZmB1bgoMt/3JOwWarJzaARAAaGrKFgH1ioTvOtuZLvv3JMXgtIWUqWCf
 MfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=H1YDdrW1qFNgDf3sWJRICdkWeBD9FXxamu4eCju/NfQ=;
 b=EtTFK9m7a9bSNjZf0n6H+TcZnhgdAX0KBC+sbMVSKCQsFZTXlD3nwcY4j2EydeZVxx
 1GuCDAV4zeFFlYuah3E68pBEN0jWBWZUargsR5QD6ychHOLYNYI9BTpO97eiIz0H/5Do
 AvWQdY0D4d7BlvT0DXH02Mw+fD22MOdbiw9tSB4OoTDwg4lYv/kqNKyLcOh0vlhg4eAl
 3xftUpJRrKaF8wmbyAdfQa9RKPnwWv7FaDIfw4HZDVU4YgBqvffiVS7+4MwI+qzXmcW1
 7EGhbiDlQFY1D7fYJoSZgczM1YwOc52BjF8MRaGs650YOFbfGNQPFWNMUN1vUk19/gRi
 VgXg==
X-Gm-Message-State: AGi0PuYROgiEdkZPYE7Kji+YGhvVEVjlYlaMlZErrMsnxdePeuqkCoha
 2fH5Vc/0mByvsjykzFlFP5NLNVeY
X-Google-Smtp-Source: APiQypIlvpK0PluyVpRSaFpTNk+AC1rdF77bW9rMp8fhCXM+Z1kxBVMtPxC4+5SzhoMnb198v6HTzw==
X-Received: by 2002:adf:bb94:: with SMTP id q20mr5774126wrg.105.1587653732916; 
 Thu, 23 Apr 2020 07:55:32 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 36sm4104471wrc.35.2020.04.23.07.55.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Apr 2020 07:55:32 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: stop cp resume when compute ring test
 failed
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1587632511-12504-1-git-send-email-Hawking.Zhang@amd.com>
 <fe584171-c45f-4b97-f141-5f2a516a88c2@gmail.com>
 <DM6PR12MB4075AD71C58D06670395B0EAFCD30@DM6PR12MB4075.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <16fa3733-d478-ab23-57e9-80eb853c3790@gmail.com>
Date: Thu, 23 Apr 2020 16:55:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB4075AD71C58D06670395B0EAFCD30@DM6PR12MB4075.namprd12.prod.outlook.com>
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

WWVhaCwgd2UgY2VydGFpbmx5IGNvdWxkIHRyeSB0aGlzIGFnYWluLiBCdXQgbWF5YmUgc3BsaXQg
dGhhdCB1cCBpbnRvIAppbmRpdmlkdWFsIHBhdGNoZXMgZm9yIGdmeDcvOC85LgoKSW4gb3RoZXIg
d29yZHMgbWFrZSBpdCBlYXN5IHRvIHJldmVydCBpZiB0aGlzIHN0aWxsIGRvZXNuJ3Qgd29yayB3
ZWxsIG9uIApnZng3IG9yIHNvbWUgb3RoZXIgZ2VuZXJhdGlvbi4KCkNocmlzdGlhbi4KCkFtIDIz
LjA0LjIwIHVtIDE1OjQzIHNjaHJpZWIgWmhhbmcsIEhhd2tpbmc6Cj4gW0FNRCBPZmZpY2lhbCBV
c2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQo+Cj4gV291bGQgeW91IG1pbmQg
dG8gZW5hYmxlIHRoaXMgYW5kIHRyeSBpdCBhZ2Fpbj8gVGhlIHJlY2VudCBncHUgcmVzZXQgdGVz
dGluZyBvbiB2ZWdhMjAgbG9va3MgdmVyeSBwb3NpdGl2ZS4KPgo+IFJlZ2FyZHMsCj4gSGF3a2lu
Zwo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+Cj4gU2VudDogVGh1cnNkYXksIEFwcmls
IDIzLCAyMDIwIDIwOjMxCj4gVG86IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MS8yXSBkcm0vYW1kZ3B1OiBzdG9wIGNwIHJlc3VtZSB3aGVuIGNvbXB1dGUgcmluZyB0ZXN0IGZh
aWxlZAo+Cj4gQW0gMjMuMDQuMjAgdW0gMTE6MDEgc2NocmllYiBIYXdraW5nIFpoYW5nOgo+PiBk
cml2ZXIgc2hvdWxkIHN0b3AgY3AgcmVzdW1lIG9uY2UgY29tcHV0ZSByaW5nIHRlc3QgZmFpbGVk
Cj4gTWhtIGludGVudGlvbmFsbHkgaWdub3JlZCB0aG9zZSBlcnJvcnMgYmVjYXVzZSB0aGUgY29t
cHV0ZSByaW5ncyBzb21ldGltZXMgZG9lc24ndCBjb21lIHVwIGFnYWluIGFmdGVyIGEgR1BVIHJl
c2V0Lgo+Cj4gV2UgZXZlbiBoYXZlIHRoZSBuZWNlc3NhcnkgbG9naWMgaW4gdGhlIFNXIHNjaGVk
dWxlciB0byByZWRpcmVjdCB0aGUgam9icyB0byBhbm90aGVyIGNvbXB1dGUgcmluZyB3aGVuIG9u
ZSBmYWlscyB0byBjb21lIHVwIGFnYWluLgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+IENoYW5nZS1JZDog
STRjZDMzMjhmMzhlMDc1NWQwYzg3NzQ4NDkzNjEzMmQyMDRjOWZlNTAKPj4gU2lnbmVkLW9mZi1i
eTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgo+PiAtLS0KPj4gICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYyB8IDQgKysrLQo+PiAgICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIHwgNCArKystCj4+ICAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCA0ICsrKy0KPj4gICAgMyBmaWxlcyBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y3XzAuYwo+PiBpbmRleCBiMmYxMGUzLi5mY2VlNzU4IDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jCj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMKPj4gQEAgLTMxMzIsNyArMzEzMiw5IEBA
IHN0YXRpYyBpbnQgZ2Z4X3Y3XzBfY3BfY29tcHV0ZV9yZXN1bWUoc3RydWN0Cj4+IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpCj4+ICAgIAo+PiAgICAJZm9yIChpID0gMDsgaSA8IGFkZXYtPmdmeC5udW1f
Y29tcHV0ZV9yaW5nczsgaSsrKSB7Cj4+ICAgIAkJcmluZyA9ICZhZGV2LT5nZnguY29tcHV0ZV9y
aW5nW2ldOwo+PiAtCQlhbWRncHVfcmluZ190ZXN0X2hlbHBlcihyaW5nKTsKPj4gKwkJciA9IGFt
ZGdwdV9yaW5nX3Rlc3RfaGVscGVyKHJpbmcpOwo+PiArCQlpZiAocikKPj4gKwkJCXJldHVybiBy
Owo+PiAgICAJfQo+PiAgICAKPj4gICAgCXJldHVybiAwOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OF8wLmMKPj4gaW5kZXggNmM1NmNlZC4uOGRjOGU5MCAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwo+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCj4+IEBAIC00NzgxLDcgKzQ3ODEsOSBAQCBz
dGF0aWMgaW50IGdmeF92OF8wX2NwX3Rlc3RfYWxsX3JpbmdzKHN0cnVjdAo+PiBhbWRncHVfZGV2
aWNlICphZGV2KQo+PiAgICAKPj4gICAgCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5nZngubnVtX2Nv
bXB1dGVfcmluZ3M7IGkrKykgewo+PiAgICAJCXJpbmcgPSAmYWRldi0+Z2Z4LmNvbXB1dGVfcmlu
Z1tpXTsKPj4gLQkJYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIocmluZyk7Cj4+ICsJCXIgPSBhbWRn
cHVfcmluZ190ZXN0X2hlbHBlcihyaW5nKTsKPj4gKwkJaWYgKHIpCj4+ICsJCQlyZXR1cm4gcjsK
Pj4gICAgCX0KPj4gICAgCj4+ICAgIAlyZXR1cm4gMDsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jCj4+IGluZGV4IDA5YWE1ZjUuLjIwOTM3MDU5IDEwMDY0NAo+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPj4gQEAgLTM4NDYsNyArMzg0Niw5IEBAIHN0
YXRpYyBpbnQgZ2Z4X3Y5XzBfY3BfcmVzdW1lKHN0cnVjdAo+PiBhbWRncHVfZGV2aWNlICphZGV2
KQo+PiAgICAKPj4gICAgCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5nZngubnVtX2NvbXB1dGVfcmlu
Z3M7IGkrKykgewo+PiAgICAJCXJpbmcgPSAmYWRldi0+Z2Z4LmNvbXB1dGVfcmluZ1tpXTsKPj4g
LQkJYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIocmluZyk7Cj4+ICsJCXIgPSBhbWRncHVfcmluZ190
ZXN0X2hlbHBlcihyaW5nKTsKPj4gKwkJaWYgKHIpCj4+ICsJCQlyZXR1cm4gcjsKPj4gICAgCX0K
Pj4gICAgCj4+ICAgIAlnZnhfdjlfMF9lbmFibGVfZ3VpX2lkbGVfaW50ZXJydXB0KGFkZXYsIHRy
dWUpOwo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
