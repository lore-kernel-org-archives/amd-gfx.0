Return-Path: <SRS0=udmR=3H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DE4C33CB1
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jan 2020 13:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D7321D7D
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jan 2020 13:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qByW8Xej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D7321D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152116E07F;
	Sat, 18 Jan 2020 13:22:45 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28836E07F
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Jan 2020 13:22:43 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id t14so10251413wmi.5
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Jan 2020 05:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=1+Ep5Kbr/QUtG2Tfombb5MGhSgcDGCRsyfnYxGxCYUo=;
 b=qByW8XejjMVhGs8W0oFOZ0haPrSFtI0scwRChKZKZvHCxUpkiVS3RgOWhHM1QzAoFQ
 AbfUzu8RZNprYgHRbEXCWg02UKe/tcaH/rdq92kMs1VKzdlcKF16r9fZ1lWXbwDP0SC3
 +kjToclivruQbHdbosGP36TcYqqE97b0LusdZHt49WF+NXtwlg9bOLheHbCUjgZQJkJM
 o/n/W2HVbCg9kMzwMWJf3JrpkGLedEULYl50FV1jG95YZF/7b0H7O1h2gMYEREZJoGmm
 9NbqY4KPiJbV6HGz6EGffm5WhPBDf7HZtddbsjuzrTKyq22psOZ8eCPYIWyj792x4SqE
 kjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1+Ep5Kbr/QUtG2Tfombb5MGhSgcDGCRsyfnYxGxCYUo=;
 b=mpT6sOV/+qvBAWQb63UgaA6vzTjpFaEv8vxagmDABp9tMtggXfYvBaLpadgCfDzdSd
 Y7oCiZJl9KSalwd+tdJXNRRgMXhZpMXdVpUi1nj5bW+hVs26MBLSOa9RHgXm0jMq5q6f
 EDobpMJwXPnlCN1fWjYQy3ET7cNPPDkGm/QaTEeFYguPLbEFMH7i8IswGqf4uYGQXFhb
 CFbDN/NdA4orq+t1gP2qHEQy4BMivcq/E4EzUh8kobfFBb3Fv/8IsbLQOBmfYx66owXn
 eZN8NI8JqmQxzlYPC3BPNcp2+2g/r/p9ZDuIp5VSQaQkD3igsANyyoSJ1h1hxrm7QPTp
 CD4Q==
X-Gm-Message-State: APjAAAULaWSDQj9bb7AuJFwe7VkBo4t1y8BGIMEPd72JLWxEuWmt/zit
 zq8zslQQZP7jw/VZO1TM1FVTQOTi
X-Google-Smtp-Source: APXvYqyOJSQVDr82pqDG4zH4SsKeta8Tb2zsDdeWD9M/ACLz3W9oR2gmIYtONIhN/8iw0SthG/ehWA==
X-Received: by 2002:a1c:9849:: with SMTP id a70mr9407691wme.76.1579353762192; 
 Sat, 18 Jan 2020 05:22:42 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u18sm38247294wrt.26.2020.01.18.05.22.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 18 Jan 2020 05:22:41 -0800 (PST)
Subject: Re: [PATCH 1/3] drm/amdgpu: Fix TLB invalidation request when using
 semaphore
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200118013735.19361-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e29279a6-4555-f8cd-bbb1-da63f2163915@gmail.com>
Date: Sat, 18 Jan 2020 14:22:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200118013735.19361-1-Felix.Kuehling@amd.com>
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

QW0gMTguMDEuMjAgdW0gMDI6Mzcgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBVc2UgYSBtb3Jl
IG1lYW5pbmdmdWwgdmFyaWFibGUgbmFtZSBmb3IgdGhlIGludmFsaWRhdGlvbiByZXF1ZXN0Cj4g
dGhhdCBpcyBkaXN0aW5jdCBmcm9tIHRoZSB0bXAgdmFyaWFibGUgdGhhdCBnZXRzIG92ZXJ3cml0
dGVuIHdoZW4KPiBhY3F1aXJpbmcgdGhlIGludmFsaWRhdGlvbiBzZW1hcGhvcmUuCj4KPiBGaXhl
czogMDBmNjA3ZjM4ZDgyICgiZHJtL2FtZGdwdTogaW52YWxpZGF0ZSBtbWh1YiBzZW1hcGhvcmUg
d29ya2Fyb3VuZCBpbiBnbWM5L2dtYzEwIikKPiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGlu
ZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciB0aGlzIG9uZSBhbmQgIzIuCgpBY2tlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBmb3IgIzMuCgo+
IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgfCA1ICsrKy0t
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jICB8IDggKysrKy0tLS0K
PiAgIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKPiBpbmRleCA4NmY0ZmZlNDA4ZTcu
LmQ5MTQ1NTVlMTIxMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjEwXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5j
Cj4gQEAgLTI2Miw3ICsyNjIsOCBAQCBzdGF0aWMgdm9pZCBnbWNfdjEwXzBfZmx1c2hfdm1faHVi
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLAo+ICAgewo+ICAgCWJv
b2wgdXNlX3NlbWFwaG9yZSA9IGdtY192MTBfMF91c2VfaW52YWxpZGF0ZV9zZW1hcGhvcmUoYWRl
diwgdm1odWIpOwo+ICAgCXN0cnVjdCBhbWRncHVfdm1odWIgKmh1YiA9ICZhZGV2LT52bWh1Ylt2
bWh1Yl07Cj4gLQl1MzIgdG1wID0gZ21jX3YxMF8wX2dldF9pbnZhbGlkYXRlX3JlcSh2bWlkLCBm
bHVzaF90eXBlKTsKPiArCXUzMiBpbnZfcmVxID0gZ21jX3YxMF8wX2dldF9pbnZhbGlkYXRlX3Jl
cSh2bWlkLCBmbHVzaF90eXBlKTsKPiArCXUzMiB0bXA7Cj4gICAJLyogVXNlIHJlZ2lzdGVyIDE3
IGZvciBHQVJUICovCj4gICAJY29uc3QgdW5zaWduZWQgZW5nID0gMTc7Cj4gICAJdW5zaWduZWQg
aW50IGk7Cj4gQEAgLTI4OSw3ICsyOTAsNyBAQCBzdGF0aWMgdm9pZCBnbWNfdjEwXzBfZmx1c2hf
dm1faHViKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLAo+ICAgCQkJ
RFJNX0VSUk9SKCJUaW1lb3V0IHdhaXRpbmcgZm9yIHNlbSBhY3F1aXJlIGluIFZNIGZsdXNoIVxu
Iik7Cj4gICAJfQo+ICAgCj4gLQlXUkVHMzJfTk9fS0lRKGh1Yi0+dm1faW52X2VuZzBfcmVxICsg
ZW5nLCB0bXApOwo+ICsJV1JFRzMyX05PX0tJUShodWItPnZtX2ludl9lbmcwX3JlcSArIGVuZywg
aW52X3JlcSk7Cj4gICAKPiAgIAkvKgo+ICAgCSAqIElzc3VlIGEgZHVtbXkgcmVhZCB0byB3YWl0
IGZvciB0aGUgQUNLIHJlZ2lzdGVyIHRvIGJlIGNsZWFyZWQKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dtY192OV8wLmMKPiBpbmRleCA1NGJkYzE3ODZhYjEuLjZkOTVkZTE0MTNjNCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+IEBAIC00NzYsMTMgKzQ3NiwxMyBA
QCBzdGF0aWMgdm9pZCBnbWNfdjlfMF9mbHVzaF9ncHVfdGxiKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCB1aW50MzJfdCB2bWlkLAo+ICAgewo+ICAgCWJvb2wgdXNlX3NlbWFwaG9yZSA9IGdt
Y192OV8wX3VzZV9pbnZhbGlkYXRlX3NlbWFwaG9yZShhZGV2LCB2bWh1Yik7Cj4gICAJY29uc3Qg
dW5zaWduZWQgZW5nID0gMTc7Cj4gLQl1MzIgaiwgdG1wOwo+ICsJdTMyIGosIGludl9yZXEsIHRt
cDsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtaHViICpodWI7Cj4gICAKPiAgIAlCVUdfT04odm1odWIg
Pj0gYWRldi0+bnVtX3ZtaHVicyk7Cj4gICAKPiAgIAlodWIgPSAmYWRldi0+dm1odWJbdm1odWJd
Owo+IC0JdG1wID0gZ21jX3Y5XzBfZ2V0X2ludmFsaWRhdGVfcmVxKHZtaWQsIGZsdXNoX3R5cGUp
Owo+ICsJaW52X3JlcSA9IGdtY192OV8wX2dldF9pbnZhbGlkYXRlX3JlcSh2bWlkLCBmbHVzaF90
eXBlKTsKPiAgIAo+ICAgCS8qIFRoaXMgaXMgbmVjZXNzYXJ5IGZvciBhIEhXIHdvcmthcm91bmQg
dW5kZXIgU1JJT1YgYXMgd2VsbAo+ICAgCSAqIGFzIEdGWE9GRiB1bmRlciBiYXJlIG1ldGFsCj4g
QEAgLTQ5Myw3ICs0OTMsNyBAQCBzdGF0aWMgdm9pZCBnbWNfdjlfMF9mbHVzaF9ncHVfdGxiKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLAo+ICAgCQl1aW50MzJfdCBy
ZXEgPSBodWItPnZtX2ludl9lbmcwX3JlcSArIGVuZzsKPiAgIAkJdWludDMyX3QgYWNrID0gaHVi
LT52bV9pbnZfZW5nMF9hY2sgKyBlbmc7Cj4gICAKPiAtCQlhbWRncHVfdmlydF9raXFfcmVnX3dy
aXRlX3JlZ193YWl0KGFkZXYsIHJlcSwgYWNrLCB0bXAsCj4gKwkJYW1kZ3B1X3ZpcnRfa2lxX3Jl
Z193cml0ZV9yZWdfd2FpdChhZGV2LCByZXEsIGFjaywgaW52X3JlcSwKPiAgIAkJCQkxIDw8IHZt
aWQpOwo+ICAgCQlyZXR1cm47Cj4gICAJfQo+IEBAIC01MjEsNyArNTIxLDcgQEAgc3RhdGljIHZv
aWQgZ21jX3Y5XzBfZmx1c2hfZ3B1X3RsYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWlu
dDMyX3Qgdm1pZCwKPiAgIAkJCURSTV9FUlJPUigiVGltZW91dCB3YWl0aW5nIGZvciBzZW0gYWNx
dWlyZSBpbiBWTSBmbHVzaCFcbiIpOwo+ICAgCX0KPiAgIAo+IC0JV1JFRzMyX05PX0tJUShodWIt
PnZtX2ludl9lbmcwX3JlcSArIGVuZywgdG1wKTsKPiArCVdSRUczMl9OT19LSVEoaHViLT52bV9p
bnZfZW5nMF9yZXEgKyBlbmcsIGludl9yZXEpOwo+ICAgCj4gICAJLyoKPiAgIAkgKiBJc3N1ZSBh
IGR1bW15IHJlYWQgdG8gd2FpdCBmb3IgdGhlIEFDSyByZWdpc3RlciB0byBiZSBjbGVhcmVkCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
