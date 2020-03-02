Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16745C3F2D2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5CB246B4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3/EFSfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5CB246B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18F96E1F3;
	Mon,  2 Mar 2020 09:29:09 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D11F6E20D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 09:29:09 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id e10so10136544wrr.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2020 01:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=qTiF7mIC9XF5mIr7gF89wT8sEOUvWCNrJ/KU3kRso24=;
 b=V3/EFSfNL9p+YIVOOFg4F26i7ikvrxEg0jzscg9IUCWqZnA/PEJyrXPEQquXSxcHZq
 /FzRmzkECGXixBphISSQ8IDI6iOYRxlq6y3TRnPg9RJat9rI+Nbw84SwXRh8ci0jsFPw
 txpzeQi54fvvwAHIIn8TFqi+K5bS1+KztPmRPYdH3CG1B+cgJg2YjCT3VPp6llcQUFhd
 xTt9GX0vgY3a/Rz1o9i8rgMCqsGlIQl1WIcOskfF3IoNFjJFVccV8ekW+c47MwOATjYH
 uhTjFOE9Xt75seknttYucyd/M+WRGY02pUXAA4FVooPqTx7MlOroPg8NUbHPLr4kwJ0U
 8gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qTiF7mIC9XF5mIr7gF89wT8sEOUvWCNrJ/KU3kRso24=;
 b=V5sN6SSXqDLOcNLUkUa7kAivw+foX4k1wC1K+9TuiFmZPznEbfqBK9sNFZAvmVpFzy
 evO31GoHkUpuFPxEIXgwlZkPZ3yyzNXX2dEp8o2T7MuMpnDqGqDqkqR+D2Wp+Bc0Rnwg
 mzrds+0BjKXMneC9q8JDAAgNuQrlebHly+Ln1+oEMg+ktXeTHPASa/S2HoAIc5ygP0Uj
 TMHe3+H9+/UyHSUTaIBXXneMs0bg1lNFHz07n9K61xjby5GWGZnmLV/9vNor5W7MOY8f
 j03odaogsM9C83iZ1EIJmrC0YKWbX6pndX70RPB3gCKnj7WZbUdvIWL7N1vggEIdksix
 fagg==
X-Gm-Message-State: APjAAAVF0fS2zAvt7u8BKjnX8lHqLD+yNJYssBwgD8ZLQ+RKaIy1Q01x
 a5vKVpg7BFmYJcsiijhUmRHYy0MM
X-Google-Smtp-Source: APXvYqxmCo+uV0EqM2lHjFbwFmJ0BEgOSnlElRD52d+n+6B5Dk0QXAo+2AUaDHvk0A+e8x3MZcCFuA==
X-Received: by 2002:adf:f70f:: with SMTP id r15mr21714814wrp.269.1583141347845; 
 Mon, 02 Mar 2020 01:29:07 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id x12sm15150639wmc.20.2020.03.02.01.29.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2020 01:29:07 -0800 (PST)
Subject: Re: [PATCH 3/3] drm/amdgpu: stop using sratch_reg in IB test
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583140927-19809-1-git-send-email-Monk.Liu@amd.com>
 <1583140927-19809-3-git-send-email-Monk.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9ea80064-2389-3b18-739c-c6210d95103b@gmail.com>
Date: Mon, 2 Mar 2020 10:29:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583140927-19809-3-git-send-email-Monk.Liu@amd.com>
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

QW0gMDIuMDMuMjAgdW0gMTA6MjIgc2NocmllYiBNb25rIExpdToKPiBzY3JhdGNoX3JlZzAgaXMg
dXNlZCBieSBSTENHIGZvciByZWdpc3RlciBhY2Nlc3MgdXNhZ2UKPiBpbiBTUklPViBjYXNlLgo+
Cj4gYm90aCBDUCBmaXJtd2FyZSBhbmQgZHJpdmVyIGNhbiBpbnZva2UgUkxDRyB0byBkbwo+IGNl
cnRhaW4gcmVnaXN0ZXIgYWNjZXNzICh0aHJvdWdoIHNjcmF0Y2hfcmVnMC8xLzIvMykKPiBidXQg
cmxjZyBub3cgZG9zZW4ndCBoYXZlIHJhY2UgY29uY2VybiBzbyBpZiB0d28KPiBjbGllbnRzIGFy
ZSBpbiBwYXJhbGxlbCBkb2luZyB0aGUgUkxDRyByZWcgYWNjZXNzCj4gdGhlbiB3ZSBhcmUgY29s
bGlkaW5nLAo+Cj4gR0ZYIElCIHRlc3QgaXMgYSBydW50aW1lIHdvcmssIHNvIGl0IGlzIGZvcmJp
ZGRlbgo+IHRvIHVzZSBzY3JhY2hfcmVnMC8xLzIvMyBkdXJpbmcgSUIgdGVzdCBwZXJpb2QKPgo+
IG5vdGU6Cj4gQWx0aG91Z2ggd2UgY2FuIG9ubHkgaGF2ZSB0aGlzIGNoYW5nZSBmb3IgU1JJT1Ys
IGJ1dAo+IGxvb2tzIGl0IGRvZXNuJ3Qgd29ydGggdGhlIGVmZm9ydCB0byBkaWZmZXJlbnRpYXRl
Cj4gYmFyZS1tZXRhbCB3aXRoIFNSSU9WIG9uIHRoZSBHRlggaWIgdGVzdAo+Cj4gU2lnbmVkLW9m
Zi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKTXVzdCBoYXZlIGJlZW4gY29weSZw
YXN0ZWQgZnJvbSBzb21lIG9sZCBjb2RlLiBJSVJDIHdlIHN0b3BlZCB1c2luZyAKc2NyYXRjaCBy
ZWdzIGZvciBnZng5IGZvciBxdWl0ZSBhIHdoaWxlIGFzIHdlbGwuCgpDaHJpc3RpYW4uCgo+IC0t
LQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAzOCArKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0
aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYwo+IGluZGV4IGFmYWU0Y2MuLmI4NmE1MzEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjEwXzAuYwo+IEBAIC01MDAsMjkgKzUwMCwyOCBAQCBzdGF0aWMgaW50IGdm
eF92MTBfMF9yaW5nX3Rlc3RfaWIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBsb25nIHRpbWVv
dXQpCj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owo+ICAgCXN0
cnVjdCBhbWRncHVfaWIgaWI7Cj4gICAJc3RydWN0IGRtYV9mZW5jZSAqZiA9IE5VTEw7Cj4gLQl1
aW50MzJfdCBzY3JhdGNoOwo+IC0JdWludDMyX3QgdG1wID0gMDsKPiArCXVuc2lnbmVkIGluZGV4
Owo+ICsJdWludDY0X3QgZ3B1X2FkZHI7Cj4gKwl1aW50MzJfdCB0bXA7Cj4gICAJbG9uZyByOwo+
ICAgCj4gLQlyID0gYW1kZ3B1X2dmeF9zY3JhdGNoX2dldChhZGV2LCAmc2NyYXRjaCk7Cj4gLQlp
ZiAocikgewo+IC0JCURSTV9FUlJPUigiYW1kZ3B1OiBmYWlsZWQgdG8gZ2V0IHNjcmF0Y2ggcmVn
ICglbGQpLlxuIiwgcik7Cj4gKwlyID0gYW1kZ3B1X2RldmljZV93Yl9nZXQoYWRldiwgJmluZGV4
KTsKPiArCWlmIChyKQo+ICAgCQlyZXR1cm4gcjsKPiAtCX0KPiAtCj4gLQlXUkVHMzIoc2NyYXRj
aCwgMHhDQUZFREVBRCk7Cj4gICAKPiArCWdwdV9hZGRyID0gYWRldi0+d2IuZ3B1X2FkZHIgKyAo
aW5kZXggKiA0KTsKPiArCWFkZXYtPndiLndiW2luZGV4XSA9IGNwdV90b19sZTMyKDB4Q0FGRURF
QUQpOwo+ICAgCW1lbXNldCgmaWIsIDAsIHNpemVvZihpYikpOwo+IC0JciA9IGFtZGdwdV9pYl9n
ZXQoYWRldiwgTlVMTCwgMjU2LCAmaWIpOwo+IC0JaWYgKHIpIHsKPiAtCQlEUk1fRVJST1IoImFt
ZGdwdTogZmFpbGVkIHRvIGdldCBpYiAoJWxkKS5cbiIsIHIpOwo+ICsJciA9IGFtZGdwdV9pYl9n
ZXQoYWRldiwgTlVMTCwgMTYsICZpYik7Cj4gKwlpZiAocikKPiAgIAkJZ290byBlcnIxOwo+IC0J
fQo+ICAgCj4gLQlpYi5wdHJbMF0gPSBQQUNLRVQzKFBBQ0tFVDNfU0VUX1VDT05GSUdfUkVHLCAx
KTsKPiAtCWliLnB0clsxXSA9ICgoc2NyYXRjaCAtIFBBQ0tFVDNfU0VUX1VDT05GSUdfUkVHX1NU
QVJUKSk7Cj4gLQlpYi5wdHJbMl0gPSAweERFQURCRUVGOwo+IC0JaWIubGVuZ3RoX2R3ID0gMzsK
PiArCWliLnB0clswXSA9IFBBQ0tFVDMoUEFDS0VUM19XUklURV9EQVRBLCAzKTsKPiArCWliLnB0
clsxXSA9IFdSSVRFX0RBVEFfRFNUX1NFTCg1KSB8IFdSX0NPTkZJUk07Cj4gKwlpYi5wdHJbMl0g
PSBsb3dlcl8zMl9iaXRzKGdwdV9hZGRyKTsKPiArCWliLnB0clszXSA9IHVwcGVyXzMyX2JpdHMo
Z3B1X2FkZHIpOwo+ICsJaWIucHRyWzRdID0gMHhERUFEQkVFRjsKPiArCWliLmxlbmd0aF9kdyA9
IDU7Cj4gICAKPiAgIAlyID0gYW1kZ3B1X2liX3NjaGVkdWxlKHJpbmcsIDEsICZpYiwgTlVMTCwg
JmYpOwo+ICAgCWlmIChyKQo+IEBAIC01MzAsMTUgKzUyOSwxMyBAQCBzdGF0aWMgaW50IGdmeF92
MTBfMF9yaW5nX3Rlc3RfaWIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBsb25nIHRpbWVvdXQp
Cj4gICAKPiAgIAlyID0gZG1hX2ZlbmNlX3dhaXRfdGltZW91dChmLCBmYWxzZSwgdGltZW91dCk7
Cj4gICAJaWYgKHIgPT0gMCkgewo+IC0JCURSTV9FUlJPUigiYW1kZ3B1OiBJQiB0ZXN0IHRpbWVk
IG91dC5cbiIpOwo+ICAgCQlyID0gLUVUSU1FRE9VVDsKPiAgIAkJZ290byBlcnIyOwo+ICAgCX0g
ZWxzZSBpZiAociA8IDApIHsKPiAtCQlEUk1fRVJST1IoImFtZGdwdTogZmVuY2Ugd2FpdCBmYWls
ZWQgKCVsZCkuXG4iLCByKTsKPiAgIAkJZ290byBlcnIyOwo+ICAgCX0KPiAgIAo+IC0JdG1wID0g
UlJFRzMyKHNjcmF0Y2gpOwo+ICsJdG1wID0gYWRldi0+d2Iud2JbaW5kZXhdOwo+ICAgCWlmICh0
bXAgPT0gMHhERUFEQkVFRikKPiAgIAkJciA9IDA7Cj4gICAJZWxzZQo+IEBAIC01NDcsOCArNTQ0
LDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfcmluZ190ZXN0X2liKHN0cnVjdCBhbWRncHVfcmlu
ZyAqcmluZywgbG9uZyB0aW1lb3V0KQo+ICAgCWFtZGdwdV9pYl9mcmVlKGFkZXYsICZpYiwgTlVM
TCk7Cj4gICAJZG1hX2ZlbmNlX3B1dChmKTsKPiAgIGVycjE6Cj4gLQlhbWRncHVfZ2Z4X3NjcmF0
Y2hfZnJlZShhZGV2LCBzY3JhdGNoKTsKPiAtCj4gKwlhbWRncHVfZGV2aWNlX3diX2ZyZWUoYWRl
diwgaW5kZXgpOwo+ICAgCXJldHVybiByOwo+ICAgfQo+ICAgCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
