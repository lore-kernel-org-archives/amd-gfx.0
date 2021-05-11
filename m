Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A1AC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 15:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7311613DE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 15:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7311613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC196E525;
	Tue, 11 May 2021 15:12:27 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37EA56E525;
 Tue, 11 May 2021 15:12:26 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id j19so932686edr.12;
 Tue, 11 May 2021 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=zKRbLMLHni1uSr1DImbAUndUBx0nq2VWk5639tbMukI=;
 b=oBjNWH+WMgcbpyfUM7y/7U5RBqMsqb/sqyJokcI0nVOjPMgU7E5yqQWVcjEv/PjMmN
 Cr8+ptcFICXfuEvAZy9hxh5QxmBikJZbYvKgTjKfi1ykRPIdfBSByZHdRC+kfV+f9r1H
 A6q6geTsFSf+VdXPbQ9z2KJ2hd12ES7AiN9CyujUJeWh2arLPCjZKNjED9JwxN7/D/oX
 Ll4nJxRfmIZCE3bYOy9FzWLfUZGMjkeVagE6cK4T4q2zZ8UOcrornFh0Eh0t+o/14EE2
 906Qknh9z2WD0K/3MdOUiMomDYRuBJF3+QuxIzSWtvlxPK5nrhsel2NqehAQSIkNk0jf
 toVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zKRbLMLHni1uSr1DImbAUndUBx0nq2VWk5639tbMukI=;
 b=Iuyh6SttIbxpro5sN/ulmGQ0nRY3+H5Fa1dJxtPsobDfV1CUwtG4EvrZTpIu7Kf9KW
 6gM3S0S3Pp1f4svtxcwXoG+NUI9swxyyQ4s/Y0wtmsm1T4koovKFPPWZlDfrwnQu19IW
 T4O/y/OxMAV/uezC5qP5xRVftT7JRwpdSEjqNYUaxdTO18BOZQH4MZ/2hrTsPc8Go7Zc
 cgaEd04006XxHb+66jRRyE1CvqpoHw48l0VKTLTv38p+mbnjz4tdwVFo9LvQXtU0W63+
 heBibfLiEekIsRSUOVwdEevYrIqWAsvtX/4/bjVEY9QbUf7GVhDG28KEI1WpU+nkAbeJ
 Jf5w==
X-Gm-Message-State: AOAM532XabDqSnQEHhzN4vPzv1HGtvBp3xMm5HGK7XfVyAteXJsa4DF9
 51s45oC1HTZc2vhluuP9768=
X-Google-Smtp-Source: ABdhPJw6vg98A40F++SSvvN1acf7Y11Xa7T1+np+N+ENc/IjZMEtCTj4xHR3SDcUUvBc46sA42hKyw==
X-Received: by 2002:a05:6402:1c07:: with SMTP id
 ck7mr37282815edb.149.1620745944768; 
 Tue, 11 May 2021 08:12:24 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:5935:8b67:3cdd:7cc1?
 ([2a02:908:1252:fb60:5935:8b67:3cdd:7cc1])
 by smtp.gmail.com with ESMTPSA id p14sm14552993eds.28.2021.05.11.08.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 08:12:24 -0700 (PDT)
Subject: Re: [PATCH v6 01/16] drm/ttm: Remap all page faults to per process
 dummy page.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-2-andrey.grodzovsky@amd.com>
 <e4bb49b1-393d-10aa-7e18-f445d7e71ef7@gmail.com>
 <897f1ca4-9e78-1136-961e-18e6c2cbab50@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2d46bfc0-1aed-4c9c-272e-8ceb619c999b@gmail.com>
Date: Tue, 11 May 2021 17:12:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <897f1ca4-9e78-1136-961e-18e6c2cbab50@amd.com>
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxMS4wNS4yMSB1bSAxNjo0NCBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Cj4gT24g
MjAyMS0wNS0xMSAyOjM4IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDEwLjA1
LjIxIHVtIDE4OjM2IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+PiBPbiBkZXZpY2UgcmVt
b3ZhbCByZXJvdXRlIGFsbCBDUFUgbWFwcGluZ3MgdG8gZHVtbXkgcGFnZS4KPj4+Cj4+PiB2MzoK
Pj4+IFJlbW92ZSBsb29wIHRvIGZpbmQgRFJNIGZpbGUgYW5kIGluc3RlYWQgYWNjZXNzIGl0Cj4+
PiBieSB2bWEtPnZtX2ZpbGUtPnByaXZhdGVfZGF0YS4gTW92ZSBkdW1teSBwYWdlIGluc3RhbGxh
dGlvbgo+Pj4gaW50byBhIHNlcGFyYXRlIGZ1bmN0aW9uLgo+Pj4KPj4+IHY0Ogo+Pj4gTWFwIHRo
ZSBlbnRpcmUgQk9zIFZBIHNwYWNlIGludG8gb24gZGVtYW5kIGFsbG9jYXRlZCBkdW1teSBwYWdl
Cj4+PiBvbiB0aGUgZmlyc3QgZmF1bHQgZm9yIHRoYXQgQk8uCj4+Pgo+Pj4gdjU6IFJlbW92ZSBk
dXBsaWNhdGUgcmV0dXJuLgo+Pj4KPj4+IHY2OiBQb2xpc2ggdHRtX2JvX3ZtX2R1bW15X3BhZ2Us
IHJlbW92ZSBzdXBlcmZsb3VzIGNvZGUuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdy
b2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZl
cnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMgfCA1NyAKPj4+ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLQo+Pj4gwqAgaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19hcGkuaMKgwqDCoCB8
wqAgMiArKwo+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3Zt
LmMgCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMKPj4+IGluZGV4IGIzMWIx
ODA1ODk2NS4uZTVhOTYxNTUxOWQxIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0
bS90dG1fYm9fdm0uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYwo+
Pj4gQEAgLTM0LDYgKzM0LDggQEAKPj4+IMKgICNpbmNsdWRlIDxkcm0vdHRtL3R0bV9ib19kcml2
ZXIuaD4KPj4+IMKgICNpbmNsdWRlIDxkcm0vdHRtL3R0bV9wbGFjZW1lbnQuaD4KPj4+IMKgICNp
bmNsdWRlIDxkcm0vZHJtX3ZtYV9tYW5hZ2VyLmg+Cj4+PiArI2luY2x1ZGUgPGRybS9kcm1fZHJ2
Lmg+Cj4+PiArI2luY2x1ZGUgPGRybS9kcm1fbWFuYWdlZC5oPgo+Pj4gwqAgI2luY2x1ZGUgPGxp
bnV4L21tLmg+Cj4+PiDCoCAjaW5jbHVkZSA8bGludXgvcGZuX3QuaD4KPj4+IMKgICNpbmNsdWRl
IDxsaW51eC9yYnRyZWUuaD4KPj4+IEBAIC0zODAsMTkgKzM4Miw3MiBAQCB2bV9mYXVsdF90IHR0
bV9ib192bV9mYXVsdF9yZXNlcnZlZChzdHJ1Y3QgCj4+PiB2bV9mYXVsdCAqdm1mLAo+Pj4gwqAg
fQo+Pj4gwqAgRVhQT1JUX1NZTUJPTCh0dG1fYm9fdm1fZmF1bHRfcmVzZXJ2ZWQpOwo+Pj4gwqAg
K3N0YXRpYyB2b2lkIHR0bV9ib19yZWxlYXNlX2R1bW15X3BhZ2Uoc3RydWN0IGRybV9kZXZpY2Ug
KmRldiwgCj4+PiB2b2lkICpyZXMpCj4+PiArewo+Pj4gK8KgwqDCoCBzdHJ1Y3QgcGFnZSAqZHVt
bXlfcGFnZSA9IChzdHJ1Y3QgcGFnZSAqKXJlczsKPj4+ICsKPj4+ICvCoMKgwqAgX19mcmVlX3Bh
Z2UoZHVtbXlfcGFnZSk7Cj4+PiArfQo+Pj4gKwo+Pj4gK3ZtX2ZhdWx0X3QgdHRtX2JvX3ZtX2R1
bW15X3BhZ2Uoc3RydWN0IHZtX2ZhdWx0ICp2bWYsIHBncHJvdF90IHByb3QpCj4+PiArewo+Pj4g
K8KgwqDCoCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSA9IHZtZi0+dm1hOwo+Pj4gK8KgwqDC
oCBzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvID0gdm1hLT52bV9wcml2YXRlX2RhdGE7Cj4+
PiArwqDCoMKgIHN0cnVjdCBkcm1fZGV2aWNlICpkZGV2ID0gYm8tPmJhc2UuZGV2Owo+Pj4gK8Kg
wqDCoCB2bV9mYXVsdF90IHJldCA9IFZNX0ZBVUxUX05PUEFHRTsKPj4+ICvCoMKgwqAgdW5zaWdu
ZWQgbG9uZyBhZGRyZXNzOwo+Pj4gK8KgwqDCoCB1bnNpZ25lZCBsb25nIHBmbjsKPj4+ICvCoMKg
wqAgc3RydWN0IHBhZ2UgKnBhZ2U7Cj4+PiArCj4+PiArwqDCoMKgIC8qIEFsbG9jYXRlIG5ldyBk
dW1teSBwYWdlIHRvIG1hcCBhbGwgdGhlIFZBIHJhbmdlIGluIHRoaXMgVk1BIAo+Pj4gdG8gaXQq
Lwo+Pj4gK8KgwqDCoCBwYWdlID0gYWxsb2NfcGFnZShHRlBfS0VSTkVMIHwgX19HRlBfWkVSTyk7
Cj4+PiArwqDCoMKgIGlmICghcGFnZSkKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gVk1fRkFV
TFRfT09NOwo+Pj4gKwo+Pj4gK8KgwqDCoCBwZm4gPSBwYWdlX3RvX3BmbihwYWdlKTsKPj4+ICsK
Pj4+ICvCoMKgwqAgLyogUHJlZmF1bHQgdGhlIGVudGlyZSBWTUEgcmFuZ2UgcmlnaHQgYXdheSB0
byBhdm9pZCBmdXJ0aGVyIAo+Pj4gZmF1bHRzICovCj4+PiArwqDCoMKgIGZvciAoYWRkcmVzcyA9
IHZtYS0+dm1fc3RhcnQ7IGFkZHJlc3MgPCB2bWEtPnZtX2VuZDsgYWRkcmVzcyArPSAKPj4+IFBB
R0VfU0laRSkgewo+Pj4gKwo+Pgo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICh1bmxpa2VseShhZGRy
ZXNzID49IHZtYS0+dm1fZW5kKSkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+
Pgo+PiBUaGF0IGV4dHJhIGNoZWNrIGNhbiBiZSByZW1vdmVkIGFzIGZhciBhcyBJIGNhbiBzZWUu
Cj4+Cj4+Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHZtYS0+dm1fZmxhZ3MgJiBWTV9N
SVhFRE1BUCkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHZtZl9pbnNlcnRfbWl4
ZWRfcHJvdCh2bWEsIGFkZHJlc3MsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fcGZuX3RvX3Bmbl90KHBmbiwgUEZOX0RFViksCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHByb3QpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGVsc2UKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldCA9IHZtZl9pbnNlcnRfcGZuX3Byb3Qodm1hLCBhZGRyZXNzLCBwZm4sIHByb3QpOwo+
Pj4gK8KgwqDCoCB9Cj4+PiArCj4+Cj4+PiArwqDCoMKgIC8qIFNldCB0aGUgcGFnZSB0byBiZSBm
cmVlZCB1c2luZyBkcm1tIHJlbGVhc2UgYWN0aW9uICovCj4+PiArwqDCoMKgIGlmIChkcm1tX2Fk
ZF9hY3Rpb25fb3JfcmVzZXQoZGRldiwgdHRtX2JvX3JlbGVhc2VfZHVtbXlfcGFnZSwgCj4+PiBw
YWdlKSkKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gVk1fRkFVTFRfT09NOwo+Pgo+PiBZb3Ug
c2hvdWxkIHByb2JhYmx5IG1vdmUgdGhhdCBiZWZvcmUgaW5zZXJ0aW5nIHRoZSBwYWdlIGludG8g
dGhlIFZNQSAKPj4gYW5kIGFsc28gZnJlZSB0aGUgYWxsb2NhdGVkIHBhZ2UgaWYgaXQgZ29lcyB3
cm9uZy4KPgo+Cj4gZHJtbV9hZGRfYWN0aW9uX29yX3Jlc2V0IHdpbGwgYXV0b21hdGljYWxseSBy
ZWxlYXNlIHRoZSBwYWdlIGlmIHRoZSAKPiBhZGQgYWN0aW9uIGZhaWxzLCB0aGF0IHRoZSAncmVz
ZXQnIHBhcnQgb2YgdGhlIGZ1bmN0aW9uLgoKQWghIE9rIHRoYXQgbWFrZXMgaXQgZXZlbiBtb3Jl
IGltcG9ydGFudCB0aGF0IHlvdSBkbyB0aGlzIGJlZm9yZSB5b3UgCmluc2VydCB0aGUgcGFnZSBp
bnRvIGFueSBWTUEuCgpPdGhlcndpc2UgdXNlcnNwYWNlIGhhcyBhY2Nlc3MgdG8gYSBmcmVlZCBw
YWdlIHdpdGggdGhlIHJhdGhlciB1Z2x5IApjb25zZXF1ZW5jZXMuCgpDaHJpc3RpYW4uCgo+Cj4g
QW5kcmV5Cj4KPgo+Pgo+PiBBcGFydCBmcm9tIHRoYXQgcGF0Y2ggbG9va3MgZ29vZCB0byBtZSwK
Pj4gQ2hyaXN0aWFuLgo+Pgo+Pj4gKwo+Pj4gK8KgwqDCoCByZXR1cm4gcmV0Owo+Pj4gK30KPj4+
ICtFWFBPUlRfU1lNQk9MKHR0bV9ib192bV9kdW1teV9wYWdlKTsKPj4+ICsKPj4+IMKgIHZtX2Zh
dWx0X3QgdHRtX2JvX3ZtX2ZhdWx0KHN0cnVjdCB2bV9mYXVsdCAqdm1mKQo+Pj4gwqAgewo+Pj4g
wqDCoMKgwqDCoCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSA9IHZtZi0+dm1hOwo+Pj4gwqDC
oMKgwqDCoCBwZ3Byb3RfdCBwcm90Owo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgdHRtX2J1ZmZlcl9v
YmplY3QgKmJvID0gdm1hLT52bV9wcml2YXRlX2RhdGE7Cj4+PiArwqDCoMKgIHN0cnVjdCBkcm1f
ZGV2aWNlICpkZGV2ID0gYm8tPmJhc2UuZGV2Owo+Pj4gwqDCoMKgwqDCoCB2bV9mYXVsdF90IHJl
dDsKPj4+ICvCoMKgwqAgaW50IGlkeDsKPj4+IMKgIMKgwqDCoMKgwqAgcmV0ID0gdHRtX2JvX3Zt
X3Jlc2VydmUoYm8sIHZtZik7Cj4+PiDCoMKgwqDCoMKgIGlmIChyZXQpCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+IMKgIMKgwqDCoMKgwqAgcHJvdCA9IHZtYS0+dm1fcGFn
ZV9wcm90Owo+Pj4gLcKgwqDCoCByZXQgPSB0dG1fYm9fdm1fZmF1bHRfcmVzZXJ2ZWQodm1mLCBw
cm90LCAKPj4+IFRUTV9CT19WTV9OVU1fUFJFRkFVTFQsIDEpOwo+Pj4gK8KgwqDCoCBpZiAoZHJt
X2Rldl9lbnRlcihkZGV2LCAmaWR4KSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IHR0bV9i
b192bV9mYXVsdF9yZXNlcnZlZCh2bWYsIHByb3QsIAo+Pj4gVFRNX0JPX1ZNX05VTV9QUkVGQVVM
VCwgMSk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgZHJtX2Rldl9leGl0KGlkeCk7Cj4+PiArwqDCoMKg
IH0gZWxzZSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gdHRtX2JvX3ZtX2R1bW15X3BhZ2Uo
dm1mLCBwcm90KTsKPj4+ICvCoMKgwqAgfQo+Pj4gwqDCoMKgwqDCoCBpZiAocmV0ID09IFZNX0ZB
VUxUX1JFVFJZICYmICEodm1mLT5mbGFncyAmIAo+Pj4gRkFVTFRfRkxBR19SRVRSWV9OT1dBSVQp
KQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+PiDCoCBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9kcm0vdHRtL3R0bV9ib19hcGkuaCAKPj4+IGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9i
b19hcGkuaAo+Pj4gaW5kZXggNjM5NTIxODgwYzI5Li4yNTRlZGU5N2Y4ZTMgMTAwNjQ0Cj4+PiAt
LS0gYS9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2FwaS5oCj4+PiArKysgYi9pbmNsdWRlL2RybS90
dG0vdHRtX2JvX2FwaS5oCj4+PiBAQCAtNjIwLDQgKzYyMCw2IEBAIGludCB0dG1fYm9fdm1fYWNj
ZXNzKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCAKPj4+IHVuc2lnbmVkIGxvbmcgYWRkciwK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqYnVmLCBpbnQgbGVuLCBpbnQg
d3JpdGUpOwo+Pj4gwqAgYm9vbCB0dG1fYm9fZGVsYXllZF9kZWxldGUoc3RydWN0IHR0bV9kZXZp
Y2UgKmJkZXYsIGJvb2wgcmVtb3ZlX2FsbCk7Cj4+PiDCoCArdm1fZmF1bHRfdCB0dG1fYm9fdm1f
ZHVtbXlfcGFnZShzdHJ1Y3Qgdm1fZmF1bHQgKnZtZiwgcGdwcm90X3QgCj4+PiBwcm90KTsKPj4+
ICsKPj4+IMKgICNlbmRpZgo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
