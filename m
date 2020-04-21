Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751ECC2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 09:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A58420CC7
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 09:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwYg4o+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A58420CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054D66E8F8;
	Tue, 21 Apr 2020 09:52:15 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81F96E8FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 09:52:13 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id b11so15707282wrs.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 02:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Tter+Y2t2fsrg5o/EZqVAflfolSerWmtGIfndXK5o9s=;
 b=iwYg4o+ANjkcExC3SanJX+qANN/5UgYGqe1L2PKPzc8NjZnGXF1imKBKDt7gHzR/4u
 DC84jukXJAz/CbLytNaYFkJFa4vZC6qBbuuYQETBDR/wRH2hIMKnII9v6NxOYkzUhBzR
 Qn0je+0Jmd9WNnelssyxGnj6MOKujRHDX22vMFPo8py3fS2a57kxY4zNpFx/SnI1h9DJ
 XMhTCrY0nQ2/YMj5sVn875wRTKCdl/2RMn8lkztdcl0TJdS9iMM/8d/fVlopMDh6x7xn
 2gOiYlYPQZW39v7NOaGr7gYW8cGa+apCC1Vfewfhrr0C8gjKVEJuhJnfA3h0UO4j84gs
 x3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Tter+Y2t2fsrg5o/EZqVAflfolSerWmtGIfndXK5o9s=;
 b=j4imXHF08Y9b/o370hkUdomOV5XldJO1pm6HrhJOBz7+hXKaE+IlcWl74t3C1Q7Aqn
 zwrwp7tQfDaXPgFDGhyriUwC2h6ZiIT/fBnQEaDC1cPswXLJypR+KyDqVXno9WEH0I76
 iYn0CDFciMDcbpzkErtemvHlDL3U9icNj6luydqj05mfT2nFrOHduO6eMvJ20W5ZeW55
 2kK5YCdWutDm95tSLM2Uc/20bbWyllYj05gx9TKrMq4yrSxw6lmLa2yBzYABtB5GBP8U
 CsaQj1VFW5P2FQfLGSxaWprOQemXnbp3zvAvCp7qi+wObxSFinmWrnhJUCVl/cDPy3Ev
 Jl2Q==
X-Gm-Message-State: AGi0PubMipIfrVslJklv5BcDQuYqSlGHItCNdGrUZegs8WXOQTDNfASf
 gIzyzsaDIUBtw2/IYRnsN8HL5ON1
X-Google-Smtp-Source: APiQypI28PwuB0IIT+CJ2DYJDckVjUWocNEvGvhEDQQGd5+NDBLY5o89PxiFi0BRgV9q/NMwMe1VyA==
X-Received: by 2002:adf:9793:: with SMTP id s19mr5036577wrb.147.1587462732511; 
 Tue, 21 Apr 2020 02:52:12 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id p5sm3466650wrg.49.2020.04.21.02.52.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Apr 2020 02:52:12 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: cleanup SPM VMID update
To: "Tao, Yintian" <Yintian.Tao@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "He, Jacob" <Jacob.He@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200421091004.130041-1-christian.koenig@amd.com>
 <MN2PR12MB30398FD163EB6424F5E8E502E5D50@MN2PR12MB3039.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3c1996ea-82a6-7962-7ef9-d6b5b1a4e6e1@gmail.com>
Date: Tue, 21 Apr 2020 11:52:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB30398FD163EB6424F5E8E502E5D50@MN2PR12MB3039.namprd12.prod.outlook.com>
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
Cc: "Gu, Frans" <Frans.Gu@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjEuMDQuMjAgdW0gMTE6NDUgc2NocmllYiBUYW8sIFlpbnRpYW46Cj4KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0
enVtZXJrZW5AZ21haWwuY29tPgo+IFNlbnQ6IDIwMjDlubQ05pyIMjHml6UgMTc6MTAKPiBUbzog
TGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgVGFvLCBZaW50aWFuIDxZaW50aWFuLlRhb0Bh
bWQuY29tPjsgSGUsIEphY29iIDxKYWNvYi5IZUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiBDYzogR3UsIEZyYW5zIDxGcmFucy5HdUBhbWQuY29tPgo+IFN1YmplY3Q6
IFtQQVRDSF0gZHJtL2FtZGdwdTogY2xlYW51cCBTUE0gVk1JRCB1cGRhdGUKPgo+IFRoZSBSTEMg
U1BNIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIgY29udGFpbnMgdGhlIGluZm9ybWF0aW9uIGhvdyB0
aGUgbWVtb3J5IGFjY2VzcyBpcyBtYWRlIChWTUlELCBNVFlQRSwgZXRjLi4uLikgd2hpY2ggc2hv
dWxkIGFsd2F5cyBiZSBjb25zaXN0ZW50Lgo+Cj4gU28gaW5zdGVhZCBvZiBhIHJlYWQgbW9kaWZ5
IHdyaXRlIGN5Y2xlIG9mIHRoZSBWTUlEIGFsd2F5cyB1cGRhdGUgdGhlIHdob2xlIHJlZ2lzdGVy
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMg
fCA3ICstLS0tLS0gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMgIHwgNyAr
LS0tLS0tICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jICB8IDcgKy0tLS0t
LSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAgfCA3ICstLS0tLS0KPiAg
IDQgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gaW5kZXggMGEwM2UyYWQ1ZDk1Li4y
YTY1NTYzNzEwNDYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3YxMF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+
IEBAIC03MDMwLDEyICs3MDMwLDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfdXBkYXRlX2dmeF9j
bG9ja19nYXRpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAKPiAgIHN0YXRpYyB2
b2lkIGdmeF92MTBfMF91cGRhdGVfc3BtX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IHVuc2lnbmVkIHZtaWQpICB7Cj4gLQl1MzIgZGF0YTsKPiAtCj4gLQlkYXRhID0gUlJFRzMyX1NP
QzE1KEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05UTCk7Cj4gLQo+IC0JZGF0YSAmPSB+UkxDX1NQTV9N
Q19DTlRMX19STENfU1BNX1ZNSURfTUFTSzsKPiAtCWRhdGEgfD0gKHZtaWQgJiBSTENfU1BNX01D
X0NOVExfX1JMQ19TUE1fVk1JRF9NQVNLKSA8PCBSTENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1J
RF9fU0hJRlQ7Cj4gKwl1MzIgZGF0YSA9IFJFR19TRVRfRklFTEQoMCwgUkxDX1NQTV9NQ19DTlRM
LCBSTENfU1BNX1ZNSUQsIHZtaWQpOwo+IFt5dHRhb106IFRoZSBvcmlnX3ZhbCBpcyAwIHdoaWNo
IG1lYW5zIGV4Y2VwdCBWTUlEIGZpZWxkIG90aGVyIHJlc2V0IGZpZWxkcyB3aWxsIGJlIHNldCB0
byAwLiBXaGV0aGVyIGl0IGlzIGxlZ2FsPwoKQWNjb3JkaW5nIHRvIHRoZSByZWdpc3RlciBzcGVj
aWZpY2F0aW9uIHRoYXQgaXMgdGhlIGRlZmF1bHQgdmFsdWUgZm9yIAp0aG9zZSBiaXRzIG9uIGdm
eDkvMTAuCgpDb3VsZCBvbmx5IGJlIHRoYXQgdGhlIGZpcm13YXJlIHVwZGF0ZXMgdGhlIGJpdHMg
dG8gc29tZXRoaW5nIG5vbiAKZGVmYXVsdCwgSSdtIGdvaW5nIHRvIGRvdWJsZSBjaGVjayB0aGF0
IG9uIGEgVmVnYTEwLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPiAgIAo+ICAgCVdSRUczMl9TT0Mx
NShHQywgMCwgbW1STENfU1BNX01DX0NOVEwsIGRhdGEpOyAgfSBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92N18wLmMKPiBpbmRleCBiMmYxMGUzOWVmZjEuLmE5MjQ4NmNkMDM4ZiAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYwo+IEBAIC0zNTcwLDEyICszNTcwLDcg
QEAgc3RhdGljIGludCBnZnhfdjdfMF9ybGNfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQo+ICAgCj4gICBzdGF0aWMgdm9pZCBnZnhfdjdfMF91cGRhdGVfc3BtX3ZtaWQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIHZtaWQpICB7Cj4gLQl1MzIgZGF0YTsKPiAt
Cj4gLQlkYXRhID0gUlJFRzMyKG1tUkxDX1NQTV9WTUlEKTsKPiAtCj4gLQlkYXRhICY9IH5STENf
U1BNX1ZNSURfX1JMQ19TUE1fVk1JRF9NQVNLOwo+IC0JZGF0YSB8PSAodm1pZCAmIFJMQ19TUE1f
Vk1JRF9fUkxDX1NQTV9WTUlEX01BU0spIDw8IFJMQ19TUE1fVk1JRF9fUkxDX1NQTV9WTUlEX19T
SElGVDsKPiArCXUzMiBkYXRhID0gUkVHX1NFVF9GSUVMRCgwLCBSTENfU1BNX1ZNSUQsIFJMQ19T
UE1fVk1JRCwgdm1pZCk7Cj4gICAKPiAgIAlXUkVHMzIobW1STENfU1BNX1ZNSUQsIGRhdGEpOwo+
ICAgfQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwo+IGluZGV4IGZjNmMyZjJi
Yzc2Yy4uNDRmZGRhNjhkYjk4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhf
MC5jCj4gQEAgLTU2MTMsMTIgKzU2MTMsNyBAQCBzdGF0aWMgdm9pZCBnZnhfdjhfMF91bnNldF9z
YWZlX21vZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAKPiAgIHN0YXRpYyB2b2lk
IGdmeF92OF8wX3VwZGF0ZV9zcG1fdm1pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5z
aWduZWQgdm1pZCkgIHsKPiAtCXUzMiBkYXRhOwo+IC0KPiAtCWRhdGEgPSBSUkVHMzIobW1STENf
U1BNX1ZNSUQpOwo+IC0KPiAtCWRhdGEgJj0gflJMQ19TUE1fVk1JRF9fUkxDX1NQTV9WTUlEX01B
U0s7Cj4gLQlkYXRhIHw9ICh2bWlkICYgUkxDX1NQTV9WTUlEX19STENfU1BNX1ZNSURfTUFTSykg
PDwgUkxDX1NQTV9WTUlEX19STENfU1BNX1ZNSURfX1NISUZUOwo+ICsJdTMyIGRhdGEgPSBSRUdf
U0VUX0ZJRUxEKDAsIFJMQ19TUE1fVk1JRCwgUkxDX1NQTV9WTUlELCB2bWlkKTsKPiAgIAo+ICAg
CVdSRUczMihtbVJMQ19TUE1fVk1JRCwgZGF0YSk7Cj4gICB9Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jCj4gaW5kZXggNTRlZGVkOWE2YWM1Li5iMzZmYmY5OTEzMTMgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiBAQCAtNDk1MCwxMiArNDk1MCw3
IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfdXBkYXRlX2dmeF9jbG9ja19nYXRpbmcoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAKPiAgIHN0YXRpYyB2b2lkIGdmeF92OV8wX3VwZGF0ZV9z
cG1fdm1pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgdm1pZCkgIHsKPiAt
CXUzMiBkYXRhOwo+IC0KPiAtCWRhdGEgPSBSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1NQTV9N
Q19DTlRMKTsKPiAtCj4gLQlkYXRhICY9IH5STENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1JRF9N
QVNLOwo+IC0JZGF0YSB8PSAodm1pZCAmIFJMQ19TUE1fTUNfQ05UTF9fUkxDX1NQTV9WTUlEX01B
U0spIDw8IFJMQ19TUE1fTUNfQ05UTF9fUkxDX1NQTV9WTUlEX19TSElGVDsKPiArCXUzMiBkYXRh
ID0gUkVHX1NFVF9GSUVMRCgwLCBSTENfU1BNX01DX0NOVEwsIFJMQ19TUE1fVk1JRCwgdm1pZCk7
Cj4gICAKPiAgIAlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMLCBkYXRhKTsg
IH0KPiAtLQo+IDIuMTcuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
