Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D1AC56201
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 15:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7B622264
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 15:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs/YqI2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7B622264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870A16E8D6;
	Fri, 20 Nov 2020 15:59:52 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D593D89B5F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 15:59:41 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id bo9so7806741ejb.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 07:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=C95NVCFViTXqqkB/dlq1rAc3Tr6hIjyL567RlHdUEos=;
 b=Cs/YqI2BCbO8H7nSOrJNuU3S6EVJR3PfaZMrYTXwuYr/vgZZ2llsOC0ei2FkJJ8bE/
 lFluXe0e3GaxgBvmMIEgQt74ayEZQeKmvHuqlB3mFF0EsylqqxK1+zKXWQLkqOEH6aJX
 Bno7BX6OKy1jjY+f1HmlUYdFsmHa8BK3o50ibEf3GE+uoTcpWwkD+1AqZUE67IvAzel9
 mTHX0H/As/yZictcRdzghlmR3F1jDZ8v7VccFD90VXRht673cTlYnpeWGRFSM4VFCZYS
 hHIfvW4HuctYdhDHRtTZldXoKOUpDp1tAfpusaYFN/Ci+WKZ54XFpnSrxDmNPfArSqTS
 xoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=C95NVCFViTXqqkB/dlq1rAc3Tr6hIjyL567RlHdUEos=;
 b=NjKlAoXBtGBPEkNPD546ENhEKn+a7g4N28kVVmLD1Weumcwn9Hfc8ip+xbEueRYrTN
 JgeUlNDfO8gelQqlukB7eeo8ttdwaQx390udiXhyQtoWE/pb2alnBgTRWG0+xicitURh
 vTMt9r6f2qXqW9tsdHQ3zIGc5CofqShiH3UdshrA1OSAizsEcqdP8puRCOw0BNvrje7z
 7gznVcABE5aPWTB/tGt5Zvra0rKJrsK67kEm7JqiQiPMx2nDsDAtBvHsJvXER4wZ52Hn
 FWhpvfW3eVWM7Q14DPIGGH4EwJFDCZL0FXVGS79Fx+hYYnm2o15AvgHvbd2mKwdH+aQM
 BiQg==
X-Gm-Message-State: AOAM531TJJfRly40sUbyRTrURi87x6Z4VQcpYWVYgKSRFyLhG2xi5kZI
 uFjyhN7mnzoMqK1qwDt2f9TuGeJKFRU=
X-Google-Smtp-Source: ABdhPJxJG04A0CHn7MsPZKrI83U1m2Oo5j6b9rtC7UzI2d2/VG8FlEgBVbW3A/5fwcJqE3oLUoI6Aw==
X-Received: by 2002:a17:906:46d5:: with SMTP id
 k21mr33947806ejs.495.1605887980588; 
 Fri, 20 Nov 2020 07:59:40 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id mj12sm1259668ejb.117.2020.11.20.07.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2020 07:59:40 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: only register VGA devices with the VGA arbiter
To: "Xu, Feifei" <Feifei.Xu@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201120145526.305912-1-alexander.deucher@amd.com>
 <BL0PR12MB4707B251571E1D43126A324CFEFF0@BL0PR12MB4707.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <18041777-544a-b741-1e48-4a6911fece0f@gmail.com>
Date: Fri, 20 Nov 2020 16:59:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BL0PR12MB4707B251571E1D43126A324CFEFF0@BL0PR12MB4707.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
CkFtIDIwLjExLjIwIHVtIDE2OjA0IHNjaHJpZWIgWHUsIEZlaWZlaToKPiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4KPiBSZXZpZXdlZC1ieTog
RmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNvbT4KPgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zz4gT24gQmVoYWxmIE9mIEFsZXggRGV1Y2hlcgo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMjAs
IDIwMjAgMTA6NTUgUE0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzog
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPgo+IFN1YmplY3Q6
IFtQQVRDSF0gZHJtL2FtZGdwdTogb25seSByZWdpc3RlciBWR0EgZGV2aWNlcyB3aXRoIHRoZSBW
R0EgYXJiaXRlcgo+Cj4gV2Ugb25seSBuZWVkIHRvIGFyYml0cmF0ZSBWR0EgYWNjZXNzIG9uIFZH
QSBjb21wYXRpYmxlIGRldmljZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA2ICsrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKPiBpbmRleCAyZjYwYjcwODRmNGQuLjI2NzBmYjExM2JhMSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtMzM0
Niw3ICszMzQ2LDggQEAgaW50IGFtZGdwdV9kZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKPiAgIC8qIGlmIHdlIGhhdmUgPiAxIFZHQSBjYXJkcywgdGhlbiBkaXNhYmxlIHRo
ZSBhbWRncHUgVkdBIHJlc291cmNlcyAqLwo+ICAgLyogdGhpcyB3aWxsIGZhaWwgZm9yIGNhcmRz
IHRoYXQgYXJlbid0IFZHQSBjbGFzcyBkZXZpY2VzLCBqdXN0Cj4gICAgKiBpZ25vcmUgaXQgKi8K
PiAtdmdhX2NsaWVudF9yZWdpc3RlcihhZGV2LT5wZGV2LCBhZGV2LCBOVUxMLCBhbWRncHVfZGV2
aWNlX3ZnYV9zZXRfZGVjb2RlKTsKPiAraWYgKChhZGV2LT5wZGV2LT5jbGFzcyA+PiA4KSA9PSBQ
Q0lfQ0xBU1NfRElTUExBWV9WR0EpCj4gK3ZnYV9jbGllbnRfcmVnaXN0ZXIoYWRldi0+cGRldiwg
YWRldiwgTlVMTCwgYW1kZ3B1X2RldmljZV92Z2Ffc2V0X2RlY29kZSk7Cj4KPiAgIGlmIChhbWRn
cHVfZGV2aWNlX3N1cHBvcnRzX2JvY28oZGRldikpCj4gICBib2NvID0gdHJ1ZTsKPiBAQCAtMzYw
NSw3ICszNjA2LDggQEAgdm9pZCBhbWRncHVfZGV2aWNlX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCj4gICB2Z2Ffc3dpdGNoZXJvb191bnJlZ2lzdGVyX2NsaWVudChhZGV2LT5wZGV2
KTsKPiAgIGlmIChhbWRncHVfZGV2aWNlX3N1cHBvcnRzX2JvY28oYWRldl90b19kcm0oYWRldikp
KQo+ICAgdmdhX3N3aXRjaGVyb29fZmluaV9kb21haW5fcG1fb3BzKGFkZXYtPmRldik7Cj4gLXZn
YV9jbGllbnRfcmVnaXN0ZXIoYWRldi0+cGRldiwgTlVMTCwgTlVMTCwgTlVMTCk7Cj4gK2lmICgo
YWRldi0+cGRldi0+Y2xhc3MgPj4gOCkgPT0gUENJX0NMQVNTX0RJU1BMQVlfVkdBKQo+ICt2Z2Ff
Y2xpZW50X3JlZ2lzdGVyKGFkZXYtPnBkZXYsIE5VTEwsIE5VTEwsIE5VTEwpOwo+ICAgaWYgKGFk
ZXYtPnJpb19tZW0pCj4gICBwY2lfaW91bm1hcChhZGV2LT5wZGV2LCBhZGV2LT5yaW9fbWVtKTsK
PiAgIGFkZXYtPnJpb19tZW0gPSBOVUxMOwo+IC0tCj4gMi4yNS40Cj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0
Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL25hbTExLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVz
a3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDEl
N0NGZWlmZWkuWHUlNDBhbWQuY29tJTdDOGVhYzY1ODAyYzI4NDFhNDAxNjQwOGQ4OGQ2NDU3Mzcl
N0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NDE0ODA5Mzkw
MDE3NTI4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlq
b2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRh
PTRZR1lUWG0lMkZZOE1BUWlxczRRSjFNVUljeTIlMkY0d2F1Y0RySWVvYjYzb2drJTNEJmFtcDty
ZXNlcnZlZD0wCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
