Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05A5C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 17:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7CA610A1
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 17:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7CA610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416F26E120;
	Mon,  7 Jun 2021 17:40:09 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F746E120
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 17:40:08 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 n17-20020a7bc5d10000b0290169edfadac9so212936wmk.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jun 2021 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6ihflNVYCBBWbydz2AG8wQIglwg0QS1ACbgwLyzNwxY=;
 b=UlQDRufGa7QsNg17cR/rJpNLyrRyS3yInPuYrkuhuhzxBLiWVwdNGkWHcsR/Z4U9AU
 J44kwPdk0LpFUoOlKNx31ft6Kf4H/iy+VfBZ2TgYWzbvPpRNg8fiVf97UED6YM4Q5kSv
 KFNbQJFbrf1zyN6frFJ3hnEZSxHolMVSn+vxnOHgS1erw09VBIC24PWUpvxoI9ad7IEY
 erkugXxoGv4tN1CyMKjEcqZiHHevG1nO6rrrFhtJ7ODywLSCaSFN8F9mi2lSrRCsb10s
 j4mgTlqS/6pmi85pzgMtKD7jqHKeN9KOSqJiQmh8dHZbyIe1Y1YzEvORQ89cTWe4HlOX
 UIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6ihflNVYCBBWbydz2AG8wQIglwg0QS1ACbgwLyzNwxY=;
 b=Fveu4s0pG81zlwDNbGS+kVY2QEIKEeVoJoyJNlhRReTgj37UdGldXq0DpRyO2RuFcA
 vSkcH3hagm4ifL9i1wL5jZMUFeWmZm4/quzlv061YjbA5unNH8Vwt2zCNu7vznguYII1
 kobCf4/piJQJgc8+BeuzdjJR80jH5GjYOAz3zHeJsiRFvg96t4Wfw+WTlFSK6xDCnqsM
 wQrsQX6/C8DWauOMWygmSIwhkQ9D7yvTk3UIdDLXDbCVYSR9PB07C4OYbowprFr8W5TU
 cE840VR51TFR4QChXdIwuCtZxvF1Db3ZcoB2zH8+FgfIjD0K6/C67QKNJwYToNu0eCOA
 iCBw==
X-Gm-Message-State: AOAM5315uoIeOqiTqBCz7wWzrYqErKNtF1sOI5K/hCieol3BWfq+/Tek
 vIrsr3o8ZA5qLnCkfIffCWw=
X-Google-Smtp-Source: ABdhPJyOc2S3U2BhRs+krQ2Kh410JQb5d4P8jIwcrFDIr2/hNr4c0wQj44GElyE0nQvM3ZD7UFvqLA==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr18201434wme.147.1623087607134; 
 Mon, 07 Jun 2021 10:40:07 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:ce67:4e4d:875d:ffeb?
 ([2a02:908:1252:fb60:ce67:4e4d:875d:ffeb])
 by smtp.gmail.com with ESMTPSA id k42sm239050wms.0.2021.06.07.10.40.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jun 2021 10:40:06 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
To: "Khaire, Rohit" <Rohit.Khaire@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
References: <20210607142343.13509-1-rohit.khaire@amd.com>
 <392d7f26-51d6-f60e-6081-870afe8276b7@amd.com>
 <BL0PR12MB4755039C3515004ADD1051AA87389@BL0PR12MB4755.namprd12.prod.outlook.com>
 <da0025b0-308f-6f2f-e4d8-b5a68117828c@amd.com>
 <BL0PR12MB47552C90D8667E1107279AD487389@BL0PR12MB4755.namprd12.prod.outlook.com>
 <bf87ed0d-d32d-5701-f9bf-c71f6a6b23b6@amd.com>
 <fddc3188-55b9-55e4-485c-4568a621c466@amd.com>
 <4d486c0b-8bd1-71aa-fdb4-3413e27beeb0@amd.com>
 <BL0PR12MB475518F3384F7E42EE7428D887389@BL0PR12MB4755.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9c5b5cc7-4abc-9805-7da9-88abb9890fc6@gmail.com>
Date: Mon, 7 Jun 2021 19:40:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BL0PR12MB475518F3384F7E42EE7428D887389@BL0PR12MB4755.namprd12.prod.outlook.com>
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhdCB3b24ndCB3b3JrIGVpdGhlci4KCldlIHN0aWxsIG5lZWQgdG8gaW5pdGlhbGl6ZSB0aGUg
Y29udHJvbCByZWdpc3RlcnMgYW5kIHRlbGwgdGhlIGhhcmR3YXJlIAp0aGF0IHdlIGhhdmUgcHJv
cGVybHkgc2V0dXAgdGhlIHJpbmcgYnVmZmVycy4KCkp1c3QgYWRkIHRoZSBlcnJvciBtZXNzYWdl
IHRvIHBzcF9yZWdfcHJvZ3JhbSgpIGluc3RlYWQgb2YgZHVwbGljYXRpbmcgCnRoYXQgb3ZlciBh
bmQgb3ZlciBhZ2Fpbi4KCkNocmlzdGlhbi4KCkFtIDA3LjA2LjIxIHVtIDE5OjMzIHNjaHJpZWIg
S2hhaXJlLCBSb2hpdDoKPiBbQU1EIFB1YmxpYyBVc2VdCj4KPiBPSy4KPgo+IEkgd2lsbCBqdXN0
IHNraXAgdGhlIGZ1bmN0aW9uIGNhbGwgZm9yIFNSSU9WIGFuZCByZXNlbmQuCj4KPiBSb2hpdAo+
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPgo+IFNlbnQ6IEp1bmUgNywgMjAyMSAxMjo0MiBQTQo+
IFRvOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBLaGFpcmUsIFJv
aGl0IDxSb2hpdC5LaGFpcmVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywg
SGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdA
YW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IFpob3UsIFBlbmcgSnUgPFBl
bmdKdS5aaG91QGFtZC5jb20+OyBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVuQGFtZC5jb20+Cj4g
Q2M6IE1pbmcsIERhdmlzIDxEYXZpcy5NaW5nQGFtZC5jb20+Cj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gZHJtL2FtZGdwdTogVXNlIFBTUCB0byBwcm9ncmFtIElIX1JCX0NOVExfUklORzEvMiBvbiBT
UklPVgo+Cj4gQWgsIGdvb2QgcG9pbnQuIEluIHRoaXMgY2FzZSB3ZSBzaG91bGQgcHJvYmFibHkg
cmF0aGVyIHNhdmUgdGhhbiBzb3JyeS4KPgo+IFRoZW4gSSBzdWdnZXN0IHRvIGNsZWFuIHVwIHRo
aXMgcGF0Y2gsIHJlcGVhdGluZyB0aGUgcHNwX3JlZ19wcm9ncmFtKCkgYW5kIGVycm9yIG1lc3Nh
Z2UgaXMgcHJldHR5IGhvcnJpYmxlIGNvZGluZyBzdHlsZS4KPgo+IENocmlzdGlhbi4KPgo+IEFt
IDA3LjA2LjIxIHVtIDE4OjM2IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+IFdpdGggU1JJT1Ys
IHRoZSBpbnRlcnJ1cHQgcm91dGluZyBpcyBzZXR1cCBieSB0aGUgaHlwZXJ2aXNvciBkcml2ZXIu
Cj4+IFdlIG5lZWQgdGhlIHNlY29uZGFyeSBJSCByaW5ncyBpbiBjYXNlIHRoZSBoeXBlcnZpc29y
IGVuYWJsZWQKPj4gcmVyb3V0aW5nIG9mIHBhZ2UgZmF1bHQgaW50ZXJydXB0cy4gSSdtIG5vdCBz
dXJlIHdoYXQgdGhlIGh5cGVydmlzb3IgZHJpdmVyIGRvZXMgdG9kYXkuCj4+Cj4+IFJlZ2FyZHMs
Cj4+ICAgwqAgRmVsaXgKPj4KPj4KPj4gQW0gMjAyMS0wNi0wNyB1bSAxMjoyOSBwLm0uIHNjaHJp
ZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4+IFRoYXQncyBhIHdvcmthcm91bmQgZm9yIGJhcmUgbWV0
YWwgYW5kIGFzIGZhciBhcyBJIGtub3cgZG9lc24ndCBhcHBseQo+Pj4gdG8gU1JJT1YuCj4+Pgo+
Pj4gV2Ugb25seSBuZWVkIHRoZSBhZGRpdGlvbmFsIElIIHJpbmdzIGZvciBwYWdlIGZhdWx0IGhh
bmRsaW5nIG9yIGxvZwo+Pj4gaGFuZGxpbmcgYW5kIGFzIGZhciBhcyBJIGtub3cgdGhhdCBpcyBp
bmNvbXBhdGlibGUgd2l0aCBTUklPViBmb3IgdGhlCj4+PiBtb21lbnQuIEJ1dCBGZWxpeCBtaWdo
dCBoYXZlIHNvbWUgbW9yZSB1cGRhdGVzIG9uIHRoaXMuCj4+Pgo+Pj4gU28gYXMgbG9uZyBhcyB3
ZSBkb24ndCBzdXBwb3J0IHRoYXQgdW5kZXIgU1JJT1Ygd2UgZG9uJ3QgbmVlZCB0aGlzCj4+PiBw
YXRjaCBlaXRoZXIuCj4+Pgo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+IEFtIDA3LjA2LjIxIHVtIDE3
OjU5IHNjaHJpZWIgS2hhaXJlLCBSb2hpdDoKPj4+PiBbQU1EIFB1YmxpYyBVc2VdCj4+Pj4KPj4+
PiBUaGUgaGFzaCBpcyA1ZWE2ZjljCj4+Pj4KPj4+PiBSb2hpdAo+Pj4+Cj4+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0KPj4+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPgo+Pj4+IFNlbnQ6IEp1bmUgNywgMjAyMSAxMTo1OCBBTQo+Pj4+IFRv
OiBLaGFpcmUsIFJvaGl0IDxSb2hpdC5LaGFpcmVAYW1kLmNvbT47Cj4+Pj4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcgo+Pj4+IDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47Cj4+
Pj4gRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVA
YW1kLmNvbT47Cj4+Pj4gWmhvdSwgUGVuZyBKdSA8UGVuZ0p1Llpob3VAYW1kLmNvbT47IENoZW4s
IEhvcmFjZQo+Pj4+IDxIb3JhY2UuQ2hlbkBhbWQuY29tPgo+Pj4+IENjOiBNaW5nLCBEYXZpcyA8
RGF2aXMuTWluZ0BhbWQuY29tPgo+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6
IFVzZSBQU1AgdG8gcHJvZ3JhbQo+Pj4+IElIX1JCX0NOVExfUklORzEvMiBvbiBTUklPVgo+Pj4+
Cj4+Pj4gRG8geW91IGhhdmUgdGhlIGhhc2ggZm9yIHRoaXMgY29tbWl0Pwo+Pj4+Cj4+Pj4gVGhh
bmtzLAo+Pj4+IENocmlzdGlhbi4KPj4+Pgo+Pj4+IEFtIDA3LjA2LjIxIHVtIDE3OjMwIHNjaHJp
ZWIgS2hhaXJlLCBSb2hpdDoKPj4+Pj4gW0FNRCBQdWJsaWMgVXNlXQo+Pj4+Pgo+Pj4+PiBXZSBk
b24ndCBuZWVkIFJJTkcxIGFuZCBSSU5HMiBmdW5jdGlvbmFsaXR5IGZvciBTUklPViBhZmFpay4K
Pj4+Pj4KPj4+Pj4gQnV0IGxvb2tpbmcgYXQgdGhlIGRlc2NyaXB0aW9uIG9mIHRoZSBvcmlnaW5h
bCBjb21taXQgbWVzc2FnZSBpdAo+Pj4+PiBhZmZlY3RzIFJJTkcwIHRvbz8KPj4+Pj4KPj4+Pj4g
IiBkcm0vYW1kZ3B1OiBhZGQgdGltZW91dCBmbHVzaCBtZWNoYW5pc20gdG8gdXBkYXRlIHdwdHIg
Zm9yIHNlbGYKPj4+Pj4gaW50ZXJydXB0ICh2MikKPj4+Pj4KPj4+Pj4gb3V0c3RhbmRpbmcgbG9n
IHJlYWNoZXMgdGhyZXNob2xkIHdpbGwgdHJpZ2dlciBJSCByaW5nMS8yJ3Mgd3B0cgo+Pj4+PiBy
ZXBvcnRlZCwgdGhhdCB3aWxsIGF2b2lkIGdlbmVyYXRpbmcgaW50ZXJydXB0cyB0byByaW5nMCB0
b28gZnJlcXVlbnQuCj4+Pj4+IEJ1dCBpZiByaW5nMS8yJ3Mgd3B0ciBoYXNuJ3QgYmVlbiBpbmNy
ZWFzZWQgZm9yIGEgbG9uZyB0aW1lLCB0aGUKPj4+Pj4gb3V0c3RhbmRpbmcgbG9nIGNhbid0IHJl
YWNoIHRocmVzaG9sZCBzbyB0aGF0IGRyaXZlciBjYW4ndCBnZXQKPj4+Pj4gbGF0ZXN0IHdwdHIg
aW5mbyBhbmQgbWlzcyBzb21lIGludGVycnVwdHMuIgo+Pj4+Pgo+Pj4+PiBSb2hpdAo+Pj4+Pgo+
Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+Pj4+PiBGcm9tOiBLb2VuaWcsIENocmlz
dGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPgo+Pj4+PiBTZW50OiBKdW5lIDcsIDIwMjEg
MTA6MzEgQU0KPj4+Pj4gVG86IEtoYWlyZSwgUm9oaXQgPFJvaGl0LktoYWlyZUBhbWQuY29tPjsK
Pj4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcgo+
Pj4+PiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nCj4+Pj4+IDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+OyBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsg
TGl1LAo+Pj4+PiBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgWmhvdSwgUGVuZyBKdSA8UGVuZ0p1
Llpob3VAYW1kLmNvbT47IENoZW4sCj4+Pj4+IEhvcmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT4K
Pj4+Pj4gQ2M6IE1pbmcsIERhdmlzIDxEYXZpcy5NaW5nQGFtZC5jb20+Cj4+Pj4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IFVzZSBQU1AgdG8gcHJvZ3JhbQo+Pj4+PiBJSF9SQl9D
TlRMX1JJTkcxLzIgb24gU1JJT1YKPj4+Pj4KPj4+Pj4gV2h5IGFyZSB0aGUgcmluZyAxJjIgZW5h
YmxlZCBvbiBTUklPViBpbiB0aGUgZmlyc3QgcGxhY2U/Cj4+Pj4+Cj4+Pj4+IENocmlzdGlhbi4K
Pj4+Pj4KPj4+Pj4gQW0gMDcuMDYuMjEgdW0gMTY6MjMgc2NocmllYiBSb2hpdCBLaGFpcmU6Cj4+
Pj4+PiBUaGlzIGlzIHNpbWlsYXIgdG8gSUhfUkJfQ05UTCBwcm9ncmFtbWluZyBpbgo+Pj4+Pj4g
bmF2aTEwX2loX3RvZ2dsZV9yaW5nX2ludGVycnVwdHMKPj4+Pj4+Cj4+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBSb2hpdCBLaGFpcmUgPHJvaGl0LmtoYWlyZUBhbWQuY29tPgo+Pj4+Pj4gLS0tCj4+Pj4+
PiAgIMKgwqDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYyB8IDIwCj4+
Pj4+PiArKysrKysrKysrKysrKysrKystLQo+Pj4+Pj4gICDCoMKgwqAgMSBmaWxlIGNoYW5nZWQs
IDE4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pj4+Pgo+Pj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jCj4+Pj4+PiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jCj4+Pj4+PiBpbmRleCBlYWM1NjRlOGRk
NTIuLmU0MTE4OGMwNDg0NiAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L25hdmkxMF9paC5jCj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9uYXZpMTBfaWguYwo+Pj4+Pj4gQEAgLTEyMCwxMSArMTIwLDI3IEBAIGZvcmNlX3VwZGF0ZV93
cHRyX2Zvcl9zZWxmX2ludChzdHJ1Y3QKPj4+Pj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+Pj4+
PiAgIMKgwqDCoMKgwqDCoMKgIGloX3JiX2NudGwgPSBSRUdfU0VUX0ZJRUxEKGloX3JiX2NudGws
IElIX1JCX0NOVExfUklORzEsCj4+Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFJCX1VTRURfSU5UX1RIUkVTSE9MRCwgdGhyZXNob2xkKTsKPj4+Pj4+
ICAgwqDCoMKgIC3CoMKgwqAgV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJ
TkcxLCBpaF9yYl9jbnRsKTsKPj4+Pj4+ICvCoMKgwqAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2
KSAmJgo+Pj4+Pj4gYW1kZ3B1X3NyaW92X3JlZ19pbmRpcmVjdF9paChhZGV2KSkgewo+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIGlmIChwc3BfcmVnX3Byb2dyYW0oJmFkZXYtPnBzcCwgUFNQX1JFR19J
SF9SQl9DTlRMX1JJTkcxLAo+Pj4+Pj4gaWhfcmJfY250bCkpIHsKPj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIERSTV9FUlJPUigiUFNQIHByb2dyYW0gSUhfUkJfQ05UTF9SSU5HMSBmYWls
ZWQhXG4iKTsKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCB9Cj4+Pj4+PiArwqDCoMKgIH0gZWxzZSB7Cj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJTkcxLCBpaF9yYl9j
bnRsKTsKPj4+Pj4+ICvCoMKgwqAgfQo+Pj4+Pj4gKwo+Pj4+Pj4gICDCoMKgwqDCoMKgwqDCoCBp
aF9yYl9jbnRsID0gUlJFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJTkcyKTsK
Pj4+Pj4+ICAgwqDCoMKgwqDCoMKgwqAgaWhfcmJfY250bCA9IFJFR19TRVRfRklFTEQoaWhfcmJf
Y250bCwgSUhfUkJfQ05UTF9SSU5HMiwKPj4+Pj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgUkJfVVNFRF9JTlRfVEhSRVNIT0xELCB0aHJlc2hvbGQpOwo+
Pj4+Pj4gLcKgwqDCoCBXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0NOVExfUklORzIs
IGloX3JiX2NudGwpOwo+Pj4+Pj4gK8KgwqDCoCBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpICYm
Cj4+Pj4+PiBhbWRncHVfc3Jpb3ZfcmVnX2luZGlyZWN0X2loKGFkZXYpKSB7Cj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgaWYgKHBzcF9yZWdfcHJvZ3JhbSgmYWRldi0+cHNwLCBQU1BfUkVHX0lIX1JC
X0NOVExfUklORzIsCj4+Pj4+PiBpaF9yYl9jbnRsKSkgewo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgRFJNX0VSUk9SKCJQU1AgcHJvZ3JhbSBJSF9SQl9DTlRMX1JJTkcyIGZhaWxlZCFc
biIpOwo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIH0KPj4+Pj4+ICvCoMKgwqAgfSBlbHNlIHsKPj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0NOVExfUklORzIsIGloX3JiX2NudGwp
Owo+Pj4+Pj4gK8KgwqDCoCB9Cj4+Pj4+PiArCj4+Pj4+PiAgIMKgwqDCoMKgwqDCoMKgIFdSRUcz
Ml9TT0MxNShPU1NTWVMsIDAsIG1tSUhfQ05UTDIsIGloX2NudGwpOwo+Pj4+Pj4gICDCoMKgwqAg
fQo+Pj4+Pj4gICAgICAgCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
