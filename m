Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FE7C433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 06:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D507A21D7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 06:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyJLK66w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D507A21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB1D6E04A;
	Thu, 15 Oct 2020 06:51:00 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D7A96E04A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 06:50:58 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id t25so1941250ejd.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 23:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=pOMXtJ17ATC/3zDoazRszVXckAXvUqmvXp+WDo+Uj9A=;
 b=KyJLK66wxv+WZJbH4+SYACW8/sfwAoRoAiQeh46NZbT6UR4t2uInsmDUZxHyuL2eAA
 J0YMFpvQXqeiVr2Lnez8C4kXOJ54qjfNjkYbcUzt0/WBt4beHTb85YExsd3fJe62bRRV
 Ao37ClxRJOvKW4Eb9QLKgWLbxaJZktcZ4Wt+Awdt63lZ12OPVA/p1spTErT9nbAHYR+1
 4/4oZ4+XtlAaJxdaPyl9mD5yg+8vH/XHLNxCnGMo2Bf776+ZZt5H3JySHenewViIlOMG
 T4GMz7pNNNAhCenbW/8t367l5+1lSx4eNKLRC0lUr50tYCJD0DqNuK2B+qj7KJ2A7bqB
 nPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=pOMXtJ17ATC/3zDoazRszVXckAXvUqmvXp+WDo+Uj9A=;
 b=qfeMWw9381/73aCMfdfPBVz0bYtf5H5LWNxyWIjmWyomfS3fga+nDO9Wsdom0rzHAB
 lQjLzqnjqWicS8n64ANJAY3Ba2LbPa4HWpTF+xkWMXZBCczn0rgbL3ySNrezab5bggX3
 sQXNvKAxb20UW1R9cn+/lOsKGv8OIgbBvYX0oMdBsPfT9QP5v9ADsR98u51+9Zaj913O
 fFY263z8LiXjF26Mnm9QpRw0eMWub37S/8ADnECHM0N/Rhpa9uAgRPLivJF0snhsC0Eh
 +UtEmuJKDrjv6YVmTkdWmRqRV8MaDtLwWUp9GcCdiU6sD/HQS14757uu1Gtd1CpCRoGj
 RWxQ==
X-Gm-Message-State: AOAM530asXMGreLBkHXR0RMV1YmDVOTEWfvZZD2DcQulEgYBjYJNAGDA
 XDhLbcbzz7qfFaEQ86egtuA=
X-Google-Smtp-Source: ABdhPJwxAjBO186ja7ncbSw9Q//wlmSsYv32kf41PeaCduFzxE064dzKVMSuNOYUnNghnwQhMipl4g==
X-Received: by 2002:a17:906:7fd8:: with SMTP id
 r24mr2790204ejs.553.1602744656870; 
 Wed, 14 Oct 2020 23:50:56 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id p10sm891964ejy.68.2020.10.14.23.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 23:50:56 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: protect eeprom update from GPU reset
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20201014094031.22448-1-Dennis.Li@amd.com>
 <DM6PR12MB4075AC679F9E58AEBDD7F211FC050@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM5PR12MB253373BD9752583C364FB7A9ED050@DM5PR12MB2533.namprd12.prod.outlook.com>
 <DM6PR12MB40753F2E51102A9BB82AAF29FC050@DM6PR12MB4075.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <266ac347-96ec-d844-42c4-1fb1a654f30d@gmail.com>
Date: Thu, 15 Oct 2020 08:50:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB40753F2E51102A9BB82AAF29FC050@DM6PR12MB4075.namprd12.prod.outlook.com>
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

TG9va3MgbGlrZSB0aGUgcmlnaHQgYXBwcm9hY2ggdG8gbWUgYXMgd2VsbC4KClBhdGNoIGlzIFJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LgoK
UmVnYXJkcywKQ2hyaXN0aWFuLgoKQW0gMTQuMTAuMjAgdW0gMTM6NDQgc2NocmllYiBaaGFuZywg
SGF3a2luZzoKPiBbQU1EIFB1YmxpYyBVc2VdCj4KPiBUaGFua3MgZm9yIHRoZSBjbGFyaWZ5aW5n
LCBEZW5uaXMuIFNvIHRoaXMgaXMga2luZCBvZiByYWNlIGNvbmRpdGlvbiBiZXR3ZWVuIG5vcm1h
bCBHUFUgcmVzZXQgYW5kIHJhcyBHUFUgcmVzZXQuIEkgJ20gZmluZSB3aXRoIHRoZSBjaGFuZ2Uu
IFRoZSBwYXRjaCBpcwo+Cj4gUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT4KPgo+IFJlZ2FyZHMsCj4gSGF3a2luZwo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0KPiBGcm9tOiBMaSwgRGVubmlzIDxEZW5uaXMuTGlAYW1kLmNvbT4KPiBTZW50OiBX
ZWRuZXNkYXksIE9jdG9iZXIgMTQsIDIwMjAgMTg6MDgKPiBUbzogWmhhbmcsIEhhd2tpbmcgPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLdWVobGluZywgRmVs
aXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPgo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRncHU6IHByb3Rl
Y3QgZWVwcm9tIHVwZGF0ZSBmcm9tIEdQVSByZXNldAo+Cj4gW0FNRCBQdWJsaWMgVXNlXQo+Cj4g
SGksIEhhd2tpbmcsCj4gICAgICAgIERyaXZlciBoYXMgbXVsdGktcGF0aCBpbnRvIEdQVSByZXNl
dCwgc28gZHJpdmVyIGNvdWxkbid0IGd1YXJhbnRlZSB0aGF0IGJhZCByZWNvcmQgdXBkYXRlIGhh
cyBiZWVuIGRvbmUgYmVmb3JlIEdQVSByZXNldC4KPgo+IEJlc3QgUmVnYXJkcwo+IERlbm5pcyBM
aQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogWmhhbmcsIEhhd2tpbmcgPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT4KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTQsIDIwMjAg
NTo1MiBQTQo+IFRvOiBMaSwgRGVubmlzIDxEZW5uaXMuTGlAYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+OyBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPgo+IENjOiBMaSwgRGVubmlz
IDxEZW5uaXMuTGlAYW1kLmNvbT4KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kZ3B1OiBw
cm90ZWN0IGVlcHJvbSB1cGRhdGUgZnJvbSBHUFUgcmVzZXQKPgo+IFtBTUQgUHVibGljIFVzZV0K
Pgo+IEhtbSwgSSB0aGluayBiYWQgcGFnZSByZWNvcmQgdXBkYXRlIGlzIGRvbmUgYWhlYWQgb2Yg
c2NoZWR1bGluZyBncHUgcmVzZXQgd29yay4gRm9yIG1HUFUgY2FzZSwgc2hhbGwgd2Ugd2FsayB0
aHJvdWdoIGFsbCB0aGUgbm9kZXMgaW4gYSBoaXZlIGJlZm9yZSBpc3N1ZSBncHUgcmVzZXQgd29y
az8KPgo+IFJlZ2FyZHMsCj4gSGF3a2luZwo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0K
PiBGcm9tOiBEZW5uaXMgTGkgPERlbm5pcy5MaUBhbWQuY29tPgo+IFNlbnQ6IFdlZG5lc2RheSwg
T2N0b2JlciAxNCwgMjAyMCAxNzo0MQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS3VlaGxp
bmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+Cj4gQ2M6IExpLCBEZW5uaXMgPERlbm5pcy5MaUBhbWQuY29tPgo+IFN1YmplY3Q6IFtQ
QVRDSF0gZHJtL2FtZGdwdTogcHJvdGVjdCBlZXByb20gdXBkYXRlIGZyb20gR1BVIHJlc2V0Cj4K
PiBiZWNhdXNlIGkyYyBpcyB1bnN0YWJsZSBpbiBHUFUgcmVzZXQsIGRyaXZlciBuZWVkIHByb3Rl
Y3QgZWVwcm9tIHVwZGF0ZSBmcm9tIEdQVSByZXNldCwgdG8gbm90IG1pc3MgYW55IGJhZCBwYWdl
IHJlY29yZC4KPgo+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBMaSA8RGVubmlzLkxpQGFtZC5jb20+
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19l
ZXByb20uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMK
PiBpbmRleCAwZTY0YzM5YTIzNzIuLjY5NWJjZmM1Yzk4MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYwo+IEBAIC0xNDksNyArMTQ5LDEx
IEBAIHN0YXRpYyBpbnQgX191cGRhdGVfdGFibGVfaGVhZGVyKHN0cnVjdCBhbWRncHVfcmFzX2Vl
cHJvbV9jb250cm9sICpjb250cm9sLAo+ICAgCj4gICAJbXNnLmFkZHIgPSBjb250cm9sLT5pMmNf
YWRkcmVzczsKPiAgIAo+ICsJLyogaTJjIG1heSBiZSB1bnN0YWJsZSBpbiBncHUgcmVzZXQgKi8K
PiArCWRvd25fcmVhZCgmYWRldi0+cmVzZXRfc2VtKTsKPiAgIAlyZXQgPSBpMmNfdHJhbnNmZXIo
JmFkZXYtPnBtLnNtdV9pMmMsICZtc2csIDEpOwo+ICsJdXBfcmVhZCgmYWRldi0+cmVzZXRfc2Vt
KTsKPiArCj4gICAJaWYgKHJldCA8IDEpCj4gICAJCURSTV9FUlJPUigiRmFpbGVkIHRvIHdyaXRl
IEVFUFJPTSB0YWJsZSBoZWFkZXIsIHJldDolZCIsIHJldCk7Cj4gICAKPiBAQCAtNTU3LDcgKzU2
MSwxMSBAQCBpbnQgYW1kZ3B1X3Jhc19lZXByb21fcHJvY2Vzc19yZWNvZHMoc3RydWN0IGFtZGdw
dV9yYXNfZWVwcm9tX2NvbnRyb2wgKmNvbnRyb2wsCj4gICAJCWNvbnRyb2wtPm5leHRfYWRkciAr
PSBFRVBST01fVEFCTEVfUkVDT1JEX1NJWkU7Cj4gICAJfQo+ICAgCj4gKwkvKiBpMmMgbWF5IGJl
IHVuc3RhYmxlIGluIGdwdSByZXNldCAqLwo+ICsJZG93bl9yZWFkKCZhZGV2LT5yZXNldF9zZW0p
Owo+ICAgCXJldCA9IGkyY190cmFuc2ZlcigmYWRldi0+cG0uc211X2kyYywgbXNncywgbnVtKTsK
PiArCXVwX3JlYWQoJmFkZXYtPnJlc2V0X3NlbSk7Cj4gKwo+ICAgCWlmIChyZXQgPCAxKSB7Cj4g
ICAJCURSTV9FUlJPUigiRmFpbGVkIHRvIHByb2Nlc3MgRUVQUk9NIHRhYmxlIHJlY29yZHMsIHJl
dDolZCIsIHJldCk7Cj4gICAKPiAtLQo+IDIuMTcuMQo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
