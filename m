Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0AEC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180126113C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180126113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94CFB6EC07;
	Tue, 18 May 2021 15:54:05 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C156EC07
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 15:54:04 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id k10so15351791ejj.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=Ns5mFZu+r54pxn+AGqCjMRjC4s8MzKTMYRp6YoEmm6o=;
 b=HnmZsbNMLDckinofKXGJufNxT2MVIy4Iwa4/RT4+2nm/ZlTtSOuGcGjvu9XeI7ObTh
 HE8jpCCYCRGVz9YhEOW368mlfCekEzSfB294+SY8FM8YZo5kb6JiakeGj30erG40Atjc
 x1HlLB3/5hM6/nqlnxrSmLFXTIvKBtp0WlFSkBo8b2L6rqIeAvP1t8o6sjntG10IgcLu
 r39CKnxlJWL+JZBRxhZebAtD0qFomjESyGBELow9WZWRFtAXn7mlrXsMHPMXzC2/JieB
 JavVvvtizJjxegwjKTeU2nTkzwd0MeIozh5oMZRuuD/Xtox8AK53u6/HvQhsG3VDoQ2G
 Bkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Ns5mFZu+r54pxn+AGqCjMRjC4s8MzKTMYRp6YoEmm6o=;
 b=jeLK8q2+ZV6DedKtTPzCVQw2+OB0h+rp58tJpRB/WTqmGMUlD4e/lx4HQnBBFE279d
 ZEzdOeIM7AOpqqnrVulnpby1kIDaEHMf0EgVQugYHOEBCpz2delqV/R3w8Z+avqmnMO1
 TN2SFE7FncFhYriCG2YU1j7KkAj+ltfGvQdQhjhIOGUOZDAk5yw0FWbb+BycmPlBkNki
 S+1Ug3cNMNNRjC8pqPrUVVM77xylNTHAymsAu4jacGfLPWP1bNiAR+qKsSB9vDFmsWin
 9vrFbt1PbeyKgs2jr4QC8Tb5Vn8GdtdoN+hY2TYLLCAUr9PluNrEk8hRXClIOHEHEALl
 KAqQ==
X-Gm-Message-State: AOAM530Fk4BXhXuF3gmNyUbvLfY/+JGBj3sMIzmuWXwNQVwXMdRk5mi9
 R60eaHtXCwl8CHGDYVZIAsqRXEWHh1E=
X-Google-Smtp-Source: ABdhPJxoOsKtCkFHVt1K9I/CKSbwehALC9mwl06FbHuBkr+vloYG+g+AVAVqCVPXz5I/Y0VKevEw4w==
X-Received: by 2002:a17:907:9008:: with SMTP id
 ay8mr6867185ejc.474.1621353243373; 
 Tue, 18 May 2021 08:54:03 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:3b27:1830:9671:4cc9?
 ([2a02:908:1252:fb60:3b27:1830:9671:4cc9])
 by smtp.gmail.com with ESMTPSA id u14sm2897083edy.47.2021.05.18.08.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 08:54:03 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/vcn1: add cancel_delayed_work_sync before
 power gate
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1621350686-25923-1-git-send-email-James.Zhu@amd.com>
 <352509e8-a836-f803-fbda-e31e0283dc41@gmail.com>
 <af3751e7-c65b-b1d2-ac84-d88509ad9e31@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <bc35c564-0b25-3e9d-7bf7-04762405f640@gmail.com>
Date: Tue, 18 May 2021 17:54:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <af3751e7-c65b-b1d2-ac84-d88509ad9e31@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxOC4wNS4yMSB1bSAxNzo0NSBzY2hyaWViIEphbWVzIFpodToKPgo+IE9uIDIwMjEtMDUt
MTggMTE6MjMgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTguMDUuMjEgdW0g
MTc6MTEgc2NocmllYiBKYW1lcyBaaHU6Cj4+PiBBZGQgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5j
IGJlZm9yZSBzZXQgcG93ZXIgZ2F0aW5nIHN0YXRlCj4+PiB0byBhdm9pZCByYWNlIGNvbmRpdGlv
biBpc3N1ZSB3aGVuIHBvd2VyIGdhdGluZy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBa
aHUgPEphbWVzLlpodUBhbWQuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y25fdjFfMC5jIHwgMTkgKysrKysrKysrKysrKysrKysrLQo+Pj4gwqAgMSBmaWxl
IGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYyAKPj4+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYwo+Pj4gaW5kZXggMGMxYmVlZi4uNmM1YzA4
MyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMK
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKPj4+IEBAIC0y
MzAsMTAgKzIzMCwyNyBAQCBzdGF0aWMgaW50IHZjbl92MV8wX2h3X2luaXQodm9pZCAqaGFuZGxl
KQo+Pj4gwqAgc3RhdGljIGludCB2Y25fdjFfMF9od19maW5pKHZvaWQgKmhhbmRsZSkKPj4+IMKg
IHsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKiloYW5kbGU7Cj4+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZzsKPj4+ICvCoMKgwqAgaW50IGk7Cj4+PiArCj4+PiArwqDCoMKgIHJpbmcgPSAmYWRldi0+dmNu
Lmluc3QtPnJpbmdfZGVjOwo+Pj4gK8KgwqDCoCByaW5nLT5zY2hlZC5yZWFkeSA9IGZhbHNlOwo+
Pj4gKwo+Pj4gK8KgwqDCoCBmb3IgKGkgPSAwOyBpIDwgYWRldi0+dmNuLm51bV9lbmNfcmluZ3M7
ICsraSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJpbmcgPSAmYWRldi0+dmNuLmluc3QtPnJpbmdf
ZW5jW2ldOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4+
PiArwqDCoMKgIH0KPj4+ICsKPj4+ICvCoMKgwqAgcmluZyA9ICZhZGV2LT5qcGVnLmluc3QtPnJp
bmdfZGVjOwo+Pj4gK8KgwqDCoCByaW5nLT5zY2hlZC5yZWFkeSA9IGZhbHNlOwo+Pgo+PiBUaGlu
a2luZyBtb3JlIGFib3V0IHRoYXQgdGhpcyBpcyBhIHJlYWxseSBiaWcgTkFLLiBUaGUgc2NoZWR1
bGVyIAo+PiB0aHJlYWRzIG11c3QgdG8gc3RheSByZWFkeSBkdXJpbmcgYSByZXNldC4KPj4KPj4g
VGhpcyBpcyBjb250cm9sbGVkIGJ5IHRoZSB1cHBlciBsYXllciBhbmQgc2hvdWxkbid0IGJlIG1l
c3NlZCB3aXRoIGluIAo+PiB0aGUgaGFyZHdhcmUgc3BlY2lmaWMgYmFja2VuZCBhdCBhbGwuCj4K
Pj4gW0paXSBJIHBvcnRlZCB0aGlzIGZyb20gY3VycmVudCB2Y24zIGh3X2ZpbmkuIEp1c3Qgd2Fu
dCB0byBtYWtlIHN1cmUgCj4+IHRoYXQgbm8gbW9yZSBuZXcgam9icyB3aWxsIGJlIHNjaGVkdWxl
ZCBhZnRlciBzdXNwZW5kIHByb2Nlc3Mgc3RhcnRzLgo+IEl0IG1heSBhIHJlZHVuZGFuY3ksIHNp
bmNlIHNjaGVkdWxlciBtYXliZSBhbHJlYWR5IHN1c3BlbmQuIEkgY2FuIAo+IHJlbW92ZSB0aG9z
ZSBpZiB5b3UgYXJlIHN1cmUgbm8gc2lkZSBlZmZlY3QsCgpXZWxsLCB3ZSAqbXVzdCogcmVtb3Zl
IHRob3NlLiBUaGlzIGZsYWcgY29udHJvbHMgaWYgdGhlIGhhcmR3YXJlIGVuZ2luZSAKY2FuIGJl
IHVzZWQgZm9yIGNvbW1hbmQgc3VibWlzc2lvbiBhbmQgaXMgb25seSBiZSBzZXQgdG8gdHJ1ZS9m
YWxzZSAKZHVyaW5nIGluaXRpYWwgZHJpdmVyIGxvYWQuCgpJZiB5b3UgY2hhbmdlIGl0IHRvIGZh
bHNlIGR1cmluZyBod19maW5pIHRoZSBlbmdpbmUgd29uJ3Qgd29yayBjb3JyZWN0bHkgCmFueSBt
b3JlIGFmdGVyIEdQVSByZXNldCBvciByZXN1bWUuCgpJZiB5b3UgaGF2ZSBhbnkgaWRlYSBob3cg
dG8gZG9jdW1lbnQgdGhhdCBmYWN0IHRoZW4gcGxlYXNlIHNwZWFrIHVwLCAKY2F1c2Ugd2UgaGFk
IHRoaXMgcHJvYmxlbSBhIGNvdXBsZSBvZiB0aW1lcyBub3cuCgpKdXN0IHNlbmQgb3V0IGEgcGF0
Y2ggZml4aW5nIHZhcmlvdXMgb3RoZXIgb2NjYXNpb25zIG9mIHRoYXQuCgpSZWdhcmRzLApDaHJp
c3RpYW4uCgo+Cj4+IEkndmUgcmVtb3ZlZCBhbGwgb2YgdGhvc2UgYSBjb3VwbGUgb2YgeWVhcnMg
YWdvLgo+Pgo+PiBSZWdhcmRzLAo+PiBDaHJpc3RpYW4uCj4+Cj4+PiArCj4+PiArwqDCoMKgIGNh
bmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7Cj4+PiDCoCDCoMKg
wqDCoMKgIGlmICgoYWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9WQ05fRFBHKSB8fAo+
Pj4gLcKgwqDCoMKgwqDCoMKgIFJSRUczMl9TT0MxNShWQ04sIDAsIG1tVVZEX1NUQVRVUykpCj4+
PiArwqDCoMKgwqDCoMKgwqAgKGFkZXYtPnZjbi5jdXJfc3RhdGUgIT0gQU1EX1BHX1NUQVRFX0dB
VEUgJiYKPj4+ICvCoMKgwqDCoMKgwqDCoMKgIFJSRUczMl9TT0MxNShWQ04sIDAsIG1tVVZEX1NU
QVRVUykpKSB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdmNuX3YxXzBfc2V0X3Bvd2VyZ2F0aW5n
X3N0YXRlKGFkZXYsIEFNRF9QR19TVEFURV9HQVRFKTsKPj4+ICvCoMKgwqAgfQo+Pj4gwqAgwqDC
oMKgwqDCoCByZXR1cm4gMDsKPj4+IMKgIH0KPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
