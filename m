Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5999FC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 14:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3553D20748
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 14:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3553D20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34F36E1FB;
	Mon,  2 Dec 2019 14:59:14 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD4B89336
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 14:59:12 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id b11so37399wmj.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Dec 2019 06:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=FAhIzjwofTOeqJUPEF0UE4FObYTL/m+LEXcJ8XUPRkI=;
 b=TkMJ5pueLHx2ike6w0EzJvmlmdsHpjSu56wkJ2cfaOmJuoSY2B+3h+CGAd02Sn7nP+
 6CQ1SR4bdZwtjO17aQq/hdt8yM3xZmixKXGnu7ykwY5H6PY3Dh5h9fc873FnLplhVpJa
 qELzH9r3oWkACU+Ia7R3Qc+B59c6rxJT8FlNm7gpDbom/hssR1tutFb7ai8Yj5J+9u2u
 p0yftic7PHaIpQ12JO2t393GJ987ZZFfk1lBG6XggFPqe0VCf0v+PdODxxTl9I4SXdze
 lpgSOdvva2YhAEGC+DevQyYd5j3KjQPGOAVOFPB3wXdlFFKjSLuXOOZ4Qac5vMBoq2OS
 PcVg==
X-Gm-Message-State: APjAAAVDv+h8W401r3WBESrfcolBW9b/zPersPEjX+ZcFzb4RymQ1URU
 kbrmmOZbu0NkI1bb3vCYZ8KXsKoJ
X-Google-Smtp-Source: APXvYqxS5gUbEHeBOIunBFUoa21nnqNFtsuW7LJeNSzZ8VAtwimpJHbw2PDZnfe4sS1frlkcngjJog==
X-Received: by 2002:a1c:f705:: with SMTP id v5mr27879596wmh.82.1575298751323; 
 Mon, 02 Dec 2019 06:59:11 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b17sm40388367wrp.49.2019.12.02.06.59.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Dec 2019 06:59:10 -0800 (PST)
Subject: Re: [RFC PATCH] drm/amdgpu: allocate entities on demand
To: Nirmoy <nirmodas@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, alexander.deucher@amd.com, kenny.ho@amd.com
References: <20191125231719.108949-1-nirmoy.das@amd.com>
 <2e514ab3-1582-6508-d81a-cbc2d12f42d7@amd.com>
 <74fd0faf-fd99-e33e-8d7a-95f9bb8be26a@gmail.com>
 <4954a31a-dfbb-1432-9ffe-42ad9f89073c@amd.com>
 <b141b429-42ae-9640-d9eb-7ab243240ea2@amd.com>
 <8e74a3fb-6aff-38cb-5bc0-a60cdd05e5ff@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <91f6a4cb-7034-cdc6-741a-4050e26d7a9d@gmail.com>
Date: Mon, 2 Dec 2019 15:59:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8e74a3fb-6aff-38cb-5bc0-a60cdd05e5ff@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=FAhIzjwofTOeqJUPEF0UE4FObYTL/m+LEXcJ8XUPRkI=;
 b=WJnXgPMpOhLowsosMT9gtGMYoXd0f1FrODe9kwc1XZMmOv7KF2cUJXnIlwBivcqeF2
 Qt2l04dhOIvYStyJiLZR1IEHBh3bT/cH5+YONDlgeOLgslDYUctYiCu5LQXuzeK1fvJG
 5s/S9MVexkG24/XMQAbYkbmAPt5WV43n+HuxeqmcakfY4KOw40BDPSWPOu6Me8klopB9
 DRaQDZYZ4e5V+jz62sew0qBBL8D+xiuQ9dYIrR72yKnu9CSBKo0DzPNyXO/xQolvoaxT
 Xj9pSmm7fTaqeEbINfOqHaLOHqqQbMnJaLDF8cHpNhtUSgP9JRcY0KuG7HOxVbMHEiAP
 dYmA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMTIuMTkgdW0gMTU6NDMgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAxMS8yOS8xOSA3OjQy
IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAyOS4xMS4xOSB1bSAxNToyOSBzY2hy
aWViIE5pcm1veToKPj4+IEhpIENocmlzdGlhbiwKPj4+Cj4+PiBPbiAxMS8yNi8xOSAxMDo0NSBB
TSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBJdCBsb29rcyBsaWtlIGEgc3RhcnQsIGJ1
dCB0aGVyZSBudW1lcm91cyB0aGluZ3Mgd2hpY2ggbmVlZHMgdG8gYmUgCj4+Pj4gZml4ZWQuCj4+
Pj4KPj4+PiBRdWVzdGlvbiBudW1iZXIgb25lIGlzOiBXaGF0J3MgdGhhdCBnb29kIGZvcj8gRW50
aXRpZXMgYXJlIG5vdCB0aGUgCj4+Pj4gcHJvYmxlbSBoZXJlLiBUaGUgcmVhbCBpc3N1ZSBpcyB0
aGUgZmVuY2UgcmluZyBhbmQgdGhlIHJxX2xpc3QuCj4+Pj4KPj4+PiBUaGUgcnFfbGlzdCBjb3Vs
ZCBhY3R1YWxseSBiZSBtYWRlIGNvbnN0YW50IHNpbmNlIGl0IHNob3VsZCBuZXZlciAKPj4+PiBi
ZSBjaGFuZ2VkIGJ5IHRoZSBlbnRpdHkuIEl0IGlzIG9ubHkgY2hhbmdlZCBmb3IgYmFja3dhcmQg
Cj4+Pj4gY29tcGF0aWJpbGl0eSBpbiBkcm1fc2NoZWRfZW50aXR5X3NldF9wcmlvcml0eSgpLgo+
Pj4+Cj4+Pj4gU28gSSB3b3VsZCBzdGFydCB0aGVyZSBhbmQgY2xlYW51cCB0aGUgCj4+Pj4gZHJt
X3NjaGVkX2VudGl0eV9zZXRfcHJpb3JpdHkoKSB0byBhY3R1YWxseSBqdXN0IHNldCBhIG5ldyBj
b25zdGFudCAKPj4+PiBycSBsaXN0IGluc3RlYWQuCj4+Pgo+Pj4gSSBhbSBtaXNzaW5nIHNvbWUg
Y29udGV4dCBoZXJlLiBDYW4geW91IHBsZWFzZSBleHBsYWluIGJpdCBtb3JlPyBJIAo+Pj4gbG9v
a2VkIG92ZXIgYW5kIG92ZXIgYWdhaW4gYnV0IEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0
IGRvIHlvdSAKPj4+IG1lYW4gYnnCoCBuZXcgY29uc3RhbnQgcnEgbGlzdCA6Lwo+Pgo+PiBPayB0
aGF0IG5lZWRzIGEgYml0IHdpZGVyIGV4cGxhbmF0aW9uLgo+Pgo+PiBUaGUgR1BVIHNjaGVkdWxl
ciBjb25zaXN0cyBtYWlubHkgb2YgZHJtX2dwdV9zY2hlZHVsZXIgaW5zdGFuY2VzLiAKPj4gRWFj
aCBvZiB0aG9zZSBpbnN0YW5jZXMgY29udGFpbiBtdWx0aXBsZSBydW5xdWV1ZXMgd2l0aCBkaWZm
ZXJlbnQgCj4+IHByaW9yaXRpZXMgKDUgSUlSQykuCj4+Cj4+IE5vdyBmb3IgZWFjaCBlbnRpdHkg
d2UgZ2l2ZSBhIGxpc3Qgb2YgcnVucXVldWVzIHdoZXJlIHRoaXMgZW50aXR5IGNhbiAKPj4gYmUg
c2VydmVkIG9uLCBlLmcuIHdoZXJlIHRoZSBqb2JzIHdoaWNoIGFyZSBwdXNoZWQgdG8gdGhlIGVu
dGl0aWVzIAo+PiBhcmUgZXhlY3V0ZWQuCj4+Cj4+IFRoZSBlbnRpdHkgaXRzZWxmIGtlZXBzIGEg
Y29weSBvZiB0aGF0IHJ1bnF1ZXVlIGxpc3QgYmVjYXVzZSB3ZSBoYXZlIAo+PiB0aGUgZHJtX3Nj
aGVkX2VudGl0eV9zZXRfcHJpb3JpdHkoKSB3aGljaCBtb2RpZmllcyB0aGlzIHJ1bnF1ZXVlIGxp
c3QuCj4+Cj4+IEJ1dCBlc3NlbnRpYWxseSB0aGF0IGlzIGNvbXBsZXRlIG92ZXJraWxsLCB0aGUg
cnVucXVldWUgbGlzdHMgYXJlIAo+PiBjb25zdGFudCBmb3IgZWFjaCBhbWRncHUgZGV2aWNlLCBl
LmcuIGFsbCBjb250ZXh0cyBzaG91bGQgdXNlIFNETUEwIAo+PiBhbmQgU0RNQTEgaW4gdGhlIHNh
bWUgd2F5Lgo+Pgo+PiBJbiBvdGhlciB3b3JkcyBidWlsZGluZyB0aGUgbGlzdCBvbiBydW5xdWV1
ZXMgc2hvdWxkIGhhcHBlbiBvbmx5IG9uY2UgCj4+IGFuZCBub3QgZm9yIGVhY2ggY29udGV4dHMu
Cj4gT2theSBJIHVuZGVyc3RhbmQgbm93IHRoZSByZWFsIHByb2JsZW0uIFRoYW5rcyBmb3IgZGV0
YWlsIGV4cGxhbmF0aW9uLgo+Pgo+PiBNdWx0aXBsZSBhcHByb2FjaCB0byBmaXggdGhpcyB3b3Vs
ZCBiZSBwb3NzaWJsZS4gT25lIHJhdGhlciBlbGVnYW50IAo+PiBzb2x1dGlvbiB3b3VsZCBiZSB0
byBjaGFuZ2UgdGhlIHJxIGxpc3QgaW50byBhIHNjaGVkdWxlciBpbnN0YW5jZXMgCj4+IGxpc3Qg
KyBwcmlvcml0eS4KPgo+IERvIHlvdSBtZWFuIHNvbWV0aGluZyBsaWtlCj4KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oIGIvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxl
ci5oCj4gaW5kZXggNjg0NjkyYThlZDc2Li5hYzY3ZjhmMDk4ZmEgMTAwNjQ0Cj4gLS0tIGEvaW5j
bHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCj4gKysrIGIvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxl
ci5oCj4gQEAgLTgxLDcgKzgxLDcgQEAgZW51bSBkcm1fc2NoZWRfcHJpb3JpdHkgewo+IMKgc3Ry
dWN0IGRybV9zY2hlZF9lbnRpdHkgewo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBsaXN0X2hlYWTC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGlzdDsKPiDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3QgZHJtX3NjaGVkX3JxwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpycTsKPiAtwqDCoMKgwqDC
oMKgIHN0cnVjdCBkcm1fc2NoZWRfcnHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKipycV9saXN0
Owo+ICvCoMKgwqDCoMKgIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlcsKgwqDCoMKgwqDCoMKgICoq
c2NoZWQ7Cj4gwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbnVtX3JxX2xpc3Q7Cj4gwqDCoMKgwqDCoMKgwqAgc3BpbmxvY2tf
dMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBycV9sb2NrOwoKWWVz
LCBleGFjdGx5LiBQcm9ibGVtIGlzIHRoYXQgSSdtIG5vdCAxMDAlIHN1cmUgaWYgdGhhdCByZWFs
bHkgd29ya3MgCndpdGggYWxsIHVzZXJzIG9mIHRoZSBycV9saXN0LgoKUmVnYXJkcywKQ2hyaXN0
aWFuLgoKPgo+Pgo+Pgo+PiBUaGlzIHdheSB3ZSB3b3VsZCBhbHNvIGZpeCB0aGUgYWdlIG9sZCBi
dWcgdGhhdCBjaGFuZ2luZyB0aGUgcHJpb3JpdHkgCj4+IG9mIGEgY29udGV4dCBjb3VsZCBhY3R1
YWxseSBtZXNzIHVwIGFscmVhZHkgc2NoZWR1bGVkIGpvYnMuCj4+Cj4+IFRoZSBhbHRlcm5hdGl2
ZSBJIG5vdGVkIGJlZm9yZSB3b3VsZCBiZSB0byBkcm9wIAo+PiBkcm1fc2NoZWRfZW50aXR5X3Nl
dF9wcmlvcml0eSgpIG9yIGNoYW5nZSBpdCBpbnRvIAo+PiBkcm1fc2NoZWRfZW50aXR5X3NldF9y
dW5xdWV1ZXMoKS4KPiBJIHdhcyB3b3JraW5nIG9uIGl0IGJ1dCB0aGVuIEkgZ290IHN0dWNrIGJ5
IGHCoCAiQlVHOiBrZXJuZWwgTlVMTCAKPiBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiIg
d2hpY2ggSSBhbSB0cnlpbmcgdG8gZmlndXJlIG91dCB3aHkKPj4KPj4gUmVnYXJkcywKPj4gQ2hy
aXN0aWFuLgo+Pgo+Pj4KPj4+Pgo+Pj4+IFRoZW4gd2UgY291bGQgZW1iZWQgdGhlIGZlbmNlcyBp
biBhbWRncHVfY3R4X2VudGl0eSBhcyBkeW5hbWljIAo+Pj4+IGFycmF5IGF0IHRoZSBlbmQgb2Yg
dGhlIHN0cnVjdHVyZS4KPj4+Pgo+Pj4+IEFuZCBsYXN0IHdlIGNhbiBzdGFydCB0byBkeW5hbWlj
IGFsbG9jYXRlIGFuZCBpbml0aWFsaXplIHRoZSAKPj4+PiBhbWRncHVfY3R4X2VudGl0eSgpIHN0
cnVjdHVyZXMuCj4+Pj4KPj4+PiBSZWdhcmRzLAo+Pj4+IENocmlzdGlhbi4KPj4+Pgo+Pj4+Cj4+
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
