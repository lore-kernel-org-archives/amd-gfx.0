Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D013C10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 12:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAC52067C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 12:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4/s6UrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAC52067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0185E6E1EE;
	Thu, 12 Mar 2020 12:49:43 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 791846E1E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 12:49:41 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id s14so7292772wrt.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ioD/qBl8Mfc3d0njFq0iKnZ77FFqxNQdq4M4dg+UGWk=;
 b=D4/s6UrCAS6peehnXhpo0VWUtj9szYe8xuR1LeDr1K4MpB6ZtuqaIfbDTsyICw7NY5
 hSb/PhAefncE1ecoEurAmBoeiy4L8IYfzY98g4i68MsK1+oDPqCdIWKIWPnx6NmTHjfv
 /WL0FK6VZmJ4koIxpj8KjWDvvZ3Kdn4nyPoGmAFJte9SPxr5FOE+SkxeKFXV2UUuq22U
 mElOslsz9Mbgf4EYAGpKNq5KM9ovVZN49pTFr5zcF92j7jWz8LCnzzGKF+oxroEsTJzD
 j/Ksi/61WVjcu4TzcRwrbM/lA4swRdQzUPiRb6jAZLEJJvS5pqITy0rOLubuzdC8uUCV
 uifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ioD/qBl8Mfc3d0njFq0iKnZ77FFqxNQdq4M4dg+UGWk=;
 b=Za3fjm5ZExhLvQHSaeZdtxB4TgNHAoiYcgzX73RI/u7PpMTQ2MNDFKECYpwp7G4ms1
 yjOo5UpP4Vcct5RLKJTQo8u0X+FcHDOJDye0V2AH8O0O4jlI7LHJ4OmQdVFpnZfdBA7Y
 xJawVOBgBEDb8Z6PbGENAc64sT0oRtO2kPR/J9ezwSsDRDmoBFGW11jRIyb20f8+1wTG
 1jqWO06u/cZaKgmONmWKNqLNccsxYGuLAZZTHFgVjqeeyYFQCVJkWfELoWZr4Stq5kux
 Tk6lp8ZkycP1MCPWaOutuZsbpRHAhgNcp31jRO5QHQ/AiXbKlXgo1C/B6cJHhstCbBDP
 T1rA==
X-Gm-Message-State: ANhLgQ2Ls0kHOjlKkkDoYJ/RuBTHZW1lsnnQoGOnHZb5wyZAD1p+EO8e
 q6VHwyAnEYt9gdl06kEVSQCq6/FB
X-Google-Smtp-Source: ADFU+vtHazGZlk0Xrx7+SwjrdJ96cvSmKDSv1LWJ2ky0VBUxIRD+nzTeXq7D7AO/GhKvq3hAAbm7Fw==
X-Received: by 2002:a5d:4582:: with SMTP id p2mr10955284wrq.80.1584017379761; 
 Thu, 12 Mar 2020 05:49:39 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id o11sm66141369wrn.6.2020.03.12.05.49.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Mar 2020 05:49:39 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close
To: "Liu, Monk" <Monk.Liu@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200312111203.81500-1-christian.koenig@amd.com>
 <MN2PR12MB39335E821319112A6D42CD1784FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <eb87e9c1-7e76-11a1-2aa9-fc719e28901c@gmail.com>
Date: Thu, 12 Mar 2020 13:49:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB39335E821319112A6D42CD1784FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
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

IEZyb20gdGhlIHNlbWFudGljIHRoZSBkbWFfcmVzdiBvYmplY3QgY29udGFpbnMgYSBzaW5nbGUg
ZXhjbHVzaXZlIGFuZCAKbXVsdGlwbGUgc2hhcmVkIGZlbmNlcyBhbmQgaXQgaXMgbWFuZGF0b3J5
IHRoYXQgdGhlIHNoYXJlZCBmZW5jZXMgCmNvbXBsZXRlIGFmdGVyIHRoZSBleGNsdXNpdmUgb25l
LgoKTm93IHdoYXQgaGFwcGVucyBpcyB0aGF0IGNsZWFyaW5nIHRoZSBWTSBwYWdlIHRhYmxlcyBy
dW5zIGFzeW5jaHJvbm91c2x5IAp0byB0aGUgZXhjbHVzaXZlIGZlbmNlIHdoaWNoIG1vdmVzIHRo
ZSBidWZmZXIgYXJvdW5kLgoKQW5kIGJlY2F1c2Ugb2YgdGhpcyBYaW5odWkgcmFuIGludG8gYSBy
YXJlIHByb2JsZW0gdGhhdCBUVE0gdGhvdWdodCBpdCAKY291bGQgcmV1c2UgdGhlIG1lbW9yeSB3
aGlsZSBpbiByZWFsaXR5IGl0IHdhcyBzdGlsbCBpbiB1c2UuCgpSZWdhcmRzLApDaHJpc3RpYW4u
CgpBbSAxMi4wMy4yMCB1bSAxMjozMCBzY2hyaWViIExpdSwgTW9uazoKPiBDYW4geW91IGdpdmUg
bW9yZSBkZXRhaWxzIGFib3V0ICIgd2UgY2FuJ3QgZ3VhcmFudGVlIHRoZSB0aGUgY2xlYXIgZmVu
Y2Ugd2lsbCBjb21wbGV0ZSBhZnRlciB0aGUgZXhjbHVzaXZlIG9uZS4iID8KPgo+IFRoYW5rcwo+
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IE1vbmsgTGl1fEdQVSBW
aXJ0dWFsaXphdGlvbiBUZWFtIHxBTUQKPgo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0K
PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBP
biBCZWhhbGYgT2YgQ2hyaXN0aWFuIEs/bmlnCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDEyLCAy
MDIwIDc6MTIgUE0KPiBUbzogUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT47IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBm
aXggYW5kIGNsZWFudXAgYW1kZ3B1X2dlbV9vYmplY3RfY2xvc2UKPgo+IFRoZSBwcm9ibGVtIGlz
IHRoYXQgd2UgY2FuJ3QgYWRkIHRoZSBjbGVhciBmZW5jZSB0byB0aGUgQk8gd2hlbiB0aGVyZSBp
cyBhbiBleGNsdXNpdmUgZmVuY2Ugb24gaXQgc2luY2Ugd2UgY2FuJ3QgZ3VhcmFudGVlIHRoZSB0
aGUgY2xlYXIgZmVuY2Ugd2lsbCBjb21wbGV0ZSBhZnRlciB0aGUgZXhjbHVzaXZlIG9uZS4KPgo+
IFRvIGZpeCB0aGlzIHJlZmFjdG9yIHRoZSBmdW5jdGlvbiBhbmQgd2FpdCBmb3IgYW55IHBvdGVu
dGlhbCBleGNsdXNpdmUgZmVuY2Ugd2l0aCBhIHNtYWxsIHRpbWVvdXQgYmVmb3JlIGFkZGluZyB0
aGUgc2hhcmVkIGNsZWFyIGZlbmNlLgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgNDEgKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+IGluZGV4IDQyNzcxMjVhNzllZS4u
MDc4MjE2MmZiNWYzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nZW0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0u
Ywo+IEBAIC0xNjEsMTAgKzE2MSwxMSBAQCB2b2lkIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlKHN0
cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqLAo+ICAgCj4gICAJc3RydWN0IGFtZGdwdV9ib19saXN0
X2VudHJ5IHZtX3BkOwo+ICAgCXN0cnVjdCBsaXN0X2hlYWQgbGlzdCwgZHVwbGljYXRlczsKPiAr
CXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlID0gTlVMTDsKPiAgIAlzdHJ1Y3QgdHRtX3ZhbGlkYXRl
X2J1ZmZlciB0djsKPiAgIAlzdHJ1Y3Qgd3dfYWNxdWlyZV9jdHggdGlja2V0Owo+ICAgCXN0cnVj
dCBhbWRncHVfYm9fdmEgKmJvX3ZhOwo+IC0JaW50IHI7Cj4gKwlsb25nIHI7Cj4gICAKPiAgIAlJ
TklUX0xJU1RfSEVBRCgmbGlzdCk7Cj4gICAJSU5JVF9MSVNUX0hFQUQoJmR1cGxpY2F0ZXMpOwo+
IEBAIC0xODIsMjQgKzE4MywzMiBAQCB2b2lkIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlKHN0cnVj
dCBkcm1fZ2VtX29iamVjdCAqb2JqLAo+ICAgCQlyZXR1cm47Cj4gICAJfQo+ICAgCWJvX3ZhID0g
YW1kZ3B1X3ZtX2JvX2ZpbmQodm0sIGJvKTsKPiAtCWlmIChib192YSAmJiAtLWJvX3ZhLT5yZWZf
Y291bnQgPT0gMCkgewo+IC0JCWFtZGdwdV92bV9ib19ybXYoYWRldiwgYm9fdmEpOwo+ICsJaWYg
KCFib192YSB8fCAtLWJvX3ZhLT5yZWZfY291bnQpCj4gKwkJZ290byBvdXRfdW5sb2NrOwo+ICAg
Cj4gLQkJaWYgKGFtZGdwdV92bV9yZWFkeSh2bSkpIHsKPiAtCQkJc3RydWN0IGRtYV9mZW5jZSAq
ZmVuY2UgPSBOVUxMOwo+ICsJYW1kZ3B1X3ZtX2JvX3JtdihhZGV2LCBib192YSk7Cj4gKwlpZiAo
IWFtZGdwdV92bV9yZWFkeSh2bSkpCj4gKwkJZ290byBvdXRfdW5sb2NrOwo+ICAgCj4gLQkJCXIg
PSBhbWRncHVfdm1fY2xlYXJfZnJlZWQoYWRldiwgdm0sICZmZW5jZSk7Cj4gLQkJCWlmICh1bmxp
a2VseShyKSkgewo+IC0JCQkJZGV2X2VycihhZGV2LT5kZXYsICJmYWlsZWQgdG8gY2xlYXIgcGFn
ZSAiCj4gLQkJCQkJInRhYmxlcyBvbiBHRU0gb2JqZWN0IGNsb3NlICglZClcbiIsIHIpOwo+IC0J
CQl9Cj4gICAKPiAtCQkJaWYgKGZlbmNlKSB7Cj4gLQkJCQlhbWRncHVfYm9fZmVuY2UoYm8sIGZl
bmNlLCB0cnVlKTsKPiAtCQkJCWRtYV9mZW5jZV9wdXQoZmVuY2UpOwo+IC0JCQl9Cj4gLQkJfQo+
IC0JfQo+ICsJciA9IGFtZGdwdV92bV9jbGVhcl9mcmVlZChhZGV2LCB2bSwgJmZlbmNlKTsKPiAr
CWlmIChyIHx8ICFmZW5jZSkKPiArCQlnb3RvIG91dF91bmxvY2s7Cj4gKwo+ICsJciA9IGRtYV9y
ZXN2X3dhaXRfdGltZW91dF9yY3UoYm8tPnRiby5iYXNlLnJlc3YsIGZhbHNlLCBmYWxzZSwKPiAr
CQkJCSAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTApKTsKPiArCWlmIChyID09IDApCj4gKwkJciA9
IC1FVElNRURPVVQ7Cj4gKwlpZiAocikKPiArCQlnb3RvIG91dF91bmxvY2s7Cj4gKwo+ICsJYW1k
Z3B1X2JvX2ZlbmNlKGJvLCBmZW5jZSwgdHJ1ZSk7Cj4gKwlkbWFfZmVuY2VfcHV0KGZlbmNlKTsK
PiArCj4gK291dF91bmxvY2s6Cj4gKwlpZiAodW5saWtlbHkocikpCj4gKwkJZGV2X2VycihhZGV2
LT5kZXYsICJmYWlsZWQgdG8gY2xlYXIgcGFnZSAiCj4gKwkJCSJ0YWJsZXMgb24gR0VNIG9iamVj
dCBjbG9zZSAoJWQpXG4iLCByKTsKPiAgIAl0dG1fZXVfYmFja29mZl9yZXNlcnZhdGlvbigmdGlj
a2V0LCAmbGlzdCk7ICB9Cj4gICAKPiAtLQo+IDIuMTcuMQo+Cj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Au
b3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDbW9u
ay5saXUlNDBhbWQuY29tJTdDMzgyNmNkMDI5YzlhNGQwMDYxNzAwOGQ3YzY3NjM0MzMlN0MzZGQ4
OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTk2MDgzMzIwOTEwNzY4
JmFtcDtzZGF0YT0xakNJTkpMemJZaFh4OWF0NSUyRlUlMkZYNmQ2NDc2RmhiaFVZWnJzNTNBUlNB
WSUzRCZhbXA7cmVzZXJ2ZWQ9MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
