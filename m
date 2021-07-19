Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A67C07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 11:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0016C600EF
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 11:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0016C600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EE2D89C98;
	Mon, 19 Jul 2021 11:10:03 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 080D289C98
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 11:10:03 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 l17-20020a05600c1d11b029021f84fcaf75so12585325wms.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=HFlH21ikEA69udLFLRVWVQydYlEW8p9DTDBPr0JQM/E=;
 b=rGJOezCOl3av8LWaC5hyJMGHo7Q1my7YwG6zyNyKp3zLf16SAkfEeItNw/q/y5pwn2
 pHD+8vspepNAEdvVxnBfGiVr1ZSkRLsXTzcBMdogv9Kuo3m3/+Fc9Y0Mc+V0BvEV8h0M
 33FIWQQAXN5JsRxlqVbFKoCXryWg/jXvIF18ZrTqTdSuk/sAT+aZGVyjnt2KLg04080M
 amc/Q6yrivxcuPFiYiLxkmP6eV/Uo1EFFt7sKTaGYoq4N6DT+XpqpnPgCpPS8GJTicmQ
 0Hl6W+LcpRlxrniC3QlWKPtf6G97hRnEoewa2IfaflybmAnobZd9pXuZvNponqEQs3nH
 TMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=HFlH21ikEA69udLFLRVWVQydYlEW8p9DTDBPr0JQM/E=;
 b=hKN2anF3OK2/iddIuOUIugENxoscMqaab8TUoRSJvz6pTt5bBLX3j22W7eVjjN4dld
 tSh22dk+wC1yklT3hLl5ref1u7HldCPB1ICEoa028+jOGVLASrSVoh9TzbygRqyMSf1S
 2WW8/9e6FwyUM7NZ78n2tViRAkpA6eG4/gMysxhEyeLIg33a38SDqpnJL0c82Jl3Hbo2
 G/EuZY8mGHi7gsf1h0iwussAuzWhtao1oYmytbtGsGaSzHkjcfVMWGRttSHhM66l+xRO
 aIEEC2FK2XTWT32mPkSRER0dF94SGjXxMBV9sKEpY6ohbvr863/loGJOGch/RyJjLLyG
 ubvg==
X-Gm-Message-State: AOAM5319KkRZRUO7E8DbQNS92dzg/tZbQP3LNdQvY/OSesi5RngdXzts
 Ukv1sJ5Gwtz7xmJu3a6wiGo=
X-Google-Smtp-Source: ABdhPJxfYtrqkpuXSFEzDAGqDr+Q4kKdvAjF4bk7SSvV+aBIT/wWSu9yT875NcmrDT4PuIG3k5za9w==
X-Received: by 2002:a1c:2052:: with SMTP id g79mr8634630wmg.158.1626693001671; 
 Mon, 19 Jul 2021 04:10:01 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:e48d:68a9:5ef4:9e09?
 ([2a02:908:1252:fb60:e48d:68a9:5ef4:9e09])
 by smtp.gmail.com with ESMTPSA id x18sm19212134wrw.19.2021.07.19.04.10.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 04:10:01 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: vm entities should have kernel priority
To: "Liu, Monk" <Monk.Liu@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210719055754.244832-1-Jingwen.Chen2@amd.com>
 <a56009a5-4793-7301-2a80-b4b051db6c0c@gmail.com>
 <BL1PR12MB5269EC6B2D9822EAAC4A292A84E19@BL1PR12MB5269.namprd12.prod.outlook.com>
 <BL1PR12MB526951A39795137AA03FA19984E19@BL1PR12MB5269.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <73d76ebe-9850-9429-25cd-c723a40b99dc@gmail.com>
Date: Mon, 19 Jul 2021 13:10:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <BL1PR12MB526951A39795137AA03FA19984E19@BL1PR12MB5269.namprd12.prod.outlook.com>
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTkuMDcuMjEgdW0gMTE6NDIgc2NocmllYiBMaXUsIE1vbms6Cj4gW0FNRCBPZmZpY2lhbCBV
c2UgT25seV0KPgo+IEJlc2lkZXMsIEkgdGhpbmsgb3VyIGN1cnJlbnQgS01EIGhhdmUgdGhyZWUg
dHlwZXMgb2Yga2VybmVsIHNkbWEgam9iczoKPiAxKSBhZGV2LT5tbWFuLmVudGl0eSwgaXQgaXMg
YWxyZWFkeSBhIEtFUk5FTCBwcmlvcml0eSBlbnRpdHkKPiAyKSB2bS0+aW1tZWRpYXRlCj4gMykg
dm0tPmRlbGF5Cj4KPiBEbyB5b3UgbWVhbiBub3cgdm0tPmltbWVkaWF0ZSBvciBkZWxheSBhcmUg
dXNlZCBhcyBtb3Zpbmcgam9icyBpbnN0ZWFkIG9mIG1tYW4uZW50aXR5ID8KCk5vLCBleGFjdGx5
IHRoYXQncyB0aGUgcG9pbnQuIHZtLT5pbW1lZGlhdGUgYW5kIHZtLT5kZWxheWVkIGFyZSBub3Qg
Zm9yIAprZXJuZWwgcGFnaW5nIGpvYnMuCgpUaG9zZSBhcmUgdXNlZCBmb3IgdXNlcnNwYWNlIHBh
Z2UgdGFibGUgdXBkYXRlcy4KCkkgYWdyZWUgdGhhdCB0aG9zZSBzaG91bGQgcHJvYmFibHkgbm90
IGNvbnNpZGVyZWQgZ3VpbHR5LCBidXQgbW9kaWZ5aW5nIAp0aGUgcHJpb3JpdHkgb2YgdGhlbSBp
cyBub3QgdGhlIHJpZ2h0IHdheSBvZiBkb2luZyB0aGF0LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoK
Pgo+IFRoYW5rcwo+Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gTW9uayBMaXUgfCBDbG91ZC1HUFUgQ29yZSB0ZWFtCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZy
b206IExpdSwgTW9uawo+IFNlbnQ6IE1vbmRheSwgSnVseSAxOSwgMjAyMSA1OjQwIFBNCj4gVG86
ICdDaHJpc3RpYW4gS8O2bmlnJyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+OyBD
aGVuLCBKaW5nV2VuIDxKaW5nV2VuLkNoZW4yQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+IENjOiBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVuQGFtZC5jb20+Cj4gU3Vi
amVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZC9hbWRncHU6IHZtIGVudGl0aWVzIHNob3VsZCBoYXZl
IGtlcm5lbCBwcmlvcml0eQo+Cj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0KPgo+IElmIHRoZXJl
IGlzIG1vdmUgam9icyBjbGFzaGluZyB0aGVyZSB3ZSBwcm9iYWJseSBuZWVkIHRvIGZpeCB0aGUg
YnVncyBvZiB0aG9zZSBtb3ZlIGpvYnMKPgo+IFByZXZpb3VzbHkgSSBiZWxpZXZlIHlvdSBhbHNv
IHJlbWVtYmVyIHRoYXQgd2UgYWdyZWVkIHRvIGFsd2F5cyB0cnVzdCBrZXJuZWwgam9icyBlc3Bl
Y2lhbGx5IHBhZ2luZyBqb2JzLAo+Cj4gV2l0aG91dCBzZXQgcGFnaW5nIGpvYnMnIHByaW9yaXR5
IHRvIEtFUk5FTCBsZXZlbCBob3cgY2FuIHdlIGtlZXAgdGhhdCBwcm90b2NvbCA/IGRvIHlvdSBo
YXZlIGEgYmV0dGVyIGlkZWE/Cj4KPiBUaGFua3MKPgo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQo+IE1vbmsgTGl1IHwgQ2xvdWQtR1BVIENvcmUgdGVhbQo+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Cj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1
bWVya2VuQGdtYWlsLmNvbT4KPiBTZW50OiBNb25kYXksIEp1bHkgMTksIDIwMjEgNDoyNSBQTQo+
IFRvOiBDaGVuLCBKaW5nV2VuIDxKaW5nV2VuLkNoZW4yQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IENjOiBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVuQGFtZC5jb20+
OyBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJt
L2FtZC9hbWRncHU6IHZtIGVudGl0aWVzIHNob3VsZCBoYXZlIGtlcm5lbCBwcmlvcml0eQo+Cj4g
QW0gMTkuMDcuMjEgdW0gMDc6NTcgc2NocmllYiBKaW5nd2VuIENoZW46Cj4+IFtXaHldCj4+IEN1
cnJlbnQgdm1fcHRlIGVudGl0aWVzIGhhdmUgTk9STUFMIHByaW9yaXR5LCBpbiBTUklPViBtdWx0
aS12ZiB1c2UKPj4gY2FzZSwgdGhlIHZmIGZsciBoYXBwZW5zIGZpcnN0IGFuZCB0aGVuIGpvYiB0
aW1lIG91dCBpcyBmb3VuZC4KPj4gVGhlcmUgY2FuIGJlIHNldmVyYWwgam9icyB0aW1lb3V0IGR1
cmluZyBhIHZlcnkgc21hbGwgdGltZSBzbGljZS4KPj4gQW5kIGlmIHRoZSBpbm5vY2VudCBzZG1h
IGpvYiB0aW1lIG91dCBpcyBmb3VuZCBiZWZvcmUgdGhlIHJlYWwgYmFkCj4+IGpvYiwgdGhlbiB0
aGUgaW5ub2NlbnQgc2RtYSBqb2Igd2lsbCBiZSBzZXQgdG8gZ3VpbHR5IGFzIGl0IG9ubHkgaGFz
Cj4+IE5PUk1BTCBwcmlvcml0eS4gVGhpcyB3aWxsIGxlYWQgdG8gYSBwYWdlIGZhdWx0IGFmdGVy
IHJlc3VibWl0dGluZwo+PiBqb2IuCj4+Cj4+IFtIb3ddCj4+IHNkbWEgc2hvdWxkIGFsd2F5cyBo
YXZlIEtFUk5FTCBwcmlvcml0eS4gVGhlIGtlcm5lbCBqb2Igd2lsbCBhbHdheXMgYmUKPj4gcmVz
dWJtaXR0ZWQuCj4gSSdtIG5vdCBzdXJlIGlmIHRoYXQgaXMgYSBnb29kIGlkZWEuIFdlIGludGVu
dGlvbmFsbHkgZGlkbid0IGdhdmUgdGhlIHBhZ2UgdGFibGUgdXBkYXRlcyBrZXJuZWwgcHJpb3Jp
dHkgdG8gYXZvaWQgY2xhc2hpbmcgd2l0aCB0aGUgbW92ZSBqb2JzLgo+Cj4gQ2hyaXN0aWFuLgo+
Cj4+IFNpZ25lZC1vZmYtYnk6IEppbmd3ZW4gQ2hlbiA8SmluZ3dlbi5DaGVuMkBhbWQuY29tPgo+
PiAtLS0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA0ICsr
LS0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
Pj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
Cj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gaW5kZXggMzU4
MzE2ZDZhMzhjLi5mNzUyNmI2N2NjNWQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jCj4+IEBAIC0yOTIzLDEzICsyOTIzLDEzIEBAIGludCBhbWRncHVfdm1faW5p
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0pCj4+ICAg
IAlJTklUX0xJU1RfSEVBRCgmdm0tPmRvbmUpOwo+PiAgICAKPj4gICAgCS8qIGNyZWF0ZSBzY2hl
ZHVsZXIgZW50aXRpZXMgZm9yIHBhZ2UgdGFibGUgdXBkYXRlcyAqLwo+PiAtCXIgPSBkcm1fc2No
ZWRfZW50aXR5X2luaXQoJnZtLT5pbW1lZGlhdGUsIERSTV9TQ0hFRF9QUklPUklUWV9OT1JNQUws
Cj4+ICsJciA9IGRybV9zY2hlZF9lbnRpdHlfaW5pdCgmdm0tPmltbWVkaWF0ZSwgRFJNX1NDSEVE
X1BSSU9SSVRZX0tFUk5FTCwKPj4gICAgCQkJCSAgYWRldi0+dm1fbWFuYWdlci52bV9wdGVfc2No
ZWRzLAo+PiAgICAJCQkJICBhZGV2LT52bV9tYW5hZ2VyLnZtX3B0ZV9udW1fc2NoZWRzLCBOVUxM
KTsKPj4gICAgCWlmIChyKQo+PiAgICAJCXJldHVybiByOwo+PiAgICAKPj4gLQlyID0gZHJtX3Nj
aGVkX2VudGl0eV9pbml0KCZ2bS0+ZGVsYXllZCwgRFJNX1NDSEVEX1BSSU9SSVRZX05PUk1BTCwK
Pj4gKwlyID0gZHJtX3NjaGVkX2VudGl0eV9pbml0KCZ2bS0+ZGVsYXllZCwgRFJNX1NDSEVEX1BS
SU9SSVRZX0tFUk5FTCwKPj4gICAgCQkJCSAgYWRldi0+dm1fbWFuYWdlci52bV9wdGVfc2NoZWRz
LAo+PiAgICAJCQkJICBhZGV2LT52bV9tYW5hZ2VyLnZtX3B0ZV9udW1fc2NoZWRzLCBOVUxMKTsK
Pj4gICAgCWlmIChyKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
