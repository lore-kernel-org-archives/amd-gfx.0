Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE29AC32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 10:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FAD20673
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 10:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAg5WkyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FAD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F4C6E3C7;
	Thu,  9 Jan 2020 10:38:12 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E556E3C7
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 10:38:10 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id f129so2250231wmf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2020 02:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=0xCel+NirtV4UqAJ/e2DWe6N2h1oYoBUGYMyVOUhKuI=;
 b=pAg5WkyDbcafAL1siNvN1Cm1KKxwbyePpCCTAh1A70PugA9s8y8Ic3sA3F0eVc1Nbj
 wfKK50SLhKe9GjRt8dH/nASOr0nzHv071JxkBjLU1JKVotzBspqrCEns0VDDhhs4j/4q
 HWfJ43b+fCuUcWDu7E6k+BbVIpGq32+UH/PcrjYArsj1yXfGDjHF2mcvb+v1QU0X9573
 16lemPbRTxEZUNdwVf1KAgaVcpf4Rxi7HdxoE2IVkTxwYfnV12D46EuQWRQFjg1QUs9X
 gTLldrmESyRx3B2DUAEo8zyHkKqzKtItAT/fCbTA+7h101TpBzDfEfVhGfCm/XSP9p1F
 SJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=0xCel+NirtV4UqAJ/e2DWe6N2h1oYoBUGYMyVOUhKuI=;
 b=S620v/NvXXtPqF/HWeEfaOnbC/dj2Q7KHHMzAyss90kJLdCjwt0grVDs1JBv99fF9U
 0iyHPeUahCWvtKYppPUfrVAWAaonFVLzKTn4znY/sAHIEa1d8eCfYENxRNe9KMsKXPBC
 eda/dIlc1vC/3b4PQiBammTWNyUWlH/EibLwhKdVo+Kx30xpEAlPV+nOxqAymUYfMi4Q
 xNjxscpjXLUzp26+yy7yM637hLswdFd4paGUPZUTJHXdUTTCvpTkCMigaNOMEHVbM83b
 oa4+IqcTiIcsg9ixCYLtL59ftpdZzYCG0nWJjxAc54YL88MM9VzsbW/7hGiek1G+iSIp
 UhUQ==
X-Gm-Message-State: APjAAAUEsjHV+oYFU6c6ndyp0nZ23/Abx8F+NC0tq556G7SkZeN6Nuor
 t5SpJmTruQ0NjHoelOsLjo/V/V3k
X-Google-Smtp-Source: APXvYqzpXLUbQW14s+dMY+wFawOeVdvHFJF7+WYc2hKUzk07K0NpRM6t5IIUPRU9fVmlqDIroDB59w==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr3943292wmb.81.1578566289504;
 Thu, 09 Jan 2020 02:38:09 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y22sm2337657wma.35.2020.01.09.02.38.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jan 2020 02:38:09 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: fix modprobe failure of the secondary GPU
 when GDDR6 training enabled(V2)
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200109101710.16945-1-tianci.yin@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <df260593-5816-0a7e-6736-b683667010c0@gmail.com>
Date: Thu, 9 Jan 2020 11:38:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200109101710.16945-1-tianci.yin@amd.com>
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
Cc: Long Gang <Gang.Long@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDkuMDEuMjAgdW0gMTE6MTcgc2NocmllYiBUaWFuY2kgWWluOgo+IEZyb206ICJUaWFuY2ku
WWluIiA8dGlhbmNpLnlpbkBhbWQuY29tPgo+Cj4gW3doeV0KPiBJbiBkdWFsIEdQVXMgc2NlbmFy
aW8sIHN0b2xlbl9zaXplIGlzIGFzc2lnbmVkIHRvIHplcm8gb24gdGhlIHNlY29uZGFyeSBHUFUs
Cj4gc2luY2UgdGhlcmUgaXMgbm8gcHJlLU9TIGNvbnNvbGUgdXNpbmcgdGhhdCBtZW1vcnkuIFRo
ZW4gdGhlIGJvdHRvbSByZWdpb24gb2YKPiBWUkFNIHdhcyBhbGxvY2F0ZWQgYXMgR1RULCB1bmZv
cnR1bmF0ZWx5IGEgc21hbGwgcmVnaW9uIG9mIGJvdHRvbSBWUkFNIHdhcwo+IGVuY3JvYWNoZWQg
YnkgVU1DIGZpcm13YXJlIGR1cmluZyBHRERSNiBCSVNUIHRyYWluaW5nLCB0aGlzIGNhdXNlIHBh
Z2UgZmF1bHQuCj4KPiBbaG93XQo+IEZvcmNpbmcgc3RvbGVuX3NpemUgdG8gM01CLCB0aGVuIHRo
ZSBib3R0b20gcmVnaW9uIG9mIFZSQU0gd2FzCj4gYWxsb2NhdGVkIGFzIHN0b2xlbiBtZW1vcnks
IEdUVCBjb3JydXB0aW9uIGF2b2lkLgo+Cj4gQ2hhbmdlLUlkOiBJMzEwYTcyYmEwNDAyOTk0ZGVm
YmU1MDgzOTg0MmE4ZWRiMDI1YTg2OAo+IFNpZ25lZC1vZmYtYnk6IFRpYW5jaS5ZaW4gPHRpYW5j
aS55aW5AYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nbWMuaCB8ICA1ICsrKysrCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEw
XzAuYyAgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrCj4gICAyIGZpbGVzIGNoYW5nZWQs
IDMzIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ21jLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21j
LmgKPiBpbmRleCBjOTFkZDYwMmQ1ZjEuLmU0YjJmOWJjYWViNyAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKPiBAQCAtNjAsNiArNjAsMTEgQEAKPiAgICAqLwo+
ICAgI2RlZmluZSBBTURHUFVfR01DX0ZBVUxUX1RJTUVPVVQJNTAwMFVMTAo+ICAgCj4gKy8qCj4g
KyAqIERlZmF1bHQgc3RvbGVuIG1lbW9yeSBzaXplLCAxMDI0ICogNzY4ICogNAo+ICsgKi8KPiAr
I2RlZmluZSBBTURHUFVfU1RPTEVOX1ZHQV9ERUZBVUxUX1NJWkUJMHgzMDAwMDBVTEwKPiArCj4g
ICBzdHJ1Y3QgZmlybXdhcmU7Cj4gICAKPiAgIC8qCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z21jX3YxMF8wLmMKPiBpbmRleCA3ZGM4YzA2OGM2MmEuLjBlMGZkZjc1OTZlYiAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCj4gQEAgLTU2Niw2ICs1NjYsMTMgQEAg
c3RhdGljIGludCBnbWNfdjEwXzBfbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkKPiAgIAlzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKPiAg
IAlpbnQgcjsKPiAgIAo+ICsJLyoKPiArCSAqIENhbid0IGZyZWUgdGhlIHN0b2xlbiBWR0EgbWVt
b3J5IHdoZW4gaXQgbWlnaHQgYmUgdXNlZCBmb3IgbWVtb3J5Cj4gKwkgKiB0cmFpbmluZyBhZ2Fp
bi4KPiArCSAqLwo+ICsJaWYgKCFhZGV2LT5md192cmFtX3VzYWdlLm1lbV90cmFpbl9zdXBwb3J0
KQo+ICsJCWFtZGdwdV9ib19sYXRlX2luaXQoYWRldik7Cj4gKwo+ICAgCXIgPSBhbWRncHVfZ21j
X2FsbG9jYXRlX3ZtX2ludl9lbmcoYWRldik7Cj4gICAJaWYgKHIpCj4gICAJCXJldHVybiByOwo+
IEBAIC03NTcsNiArNzY0LDE5IEBAIHN0YXRpYyBpbnQgZ21jX3YxMF8wX3N3X2luaXQodm9pZCAq
aGFuZGxlKQo+ICAgCj4gICAJYWRldi0+Z21jLnN0b2xlbl9zaXplID0gZ21jX3YxMF8wX2dldF92
Ymlvc19mYl9zaXplKGFkZXYpOwo+ICAgCj4gKwkvKgo+ICsJICogSW4gZHVhbCBHUFVzIHNjZW5h
cmlvLCBzdG9sZW5fc2l6ZSBpcyBhc3NpZ25lZCB0byB6ZXJvIG9uIHRoZQo+ICsJICogc2Vjb25k
YXJ5IEdQVSwgc2luY2UgdGhlcmUgaXMgbm8gcHJlLU9TIGNvbnNvbGUgdXNpbmcgdGhhdCBtZW1v
cnkuCj4gKwkgKiBUaGVuIHRoZSBib3R0b20gcmVnaW9uIG9mIFZSQU0gd2FzIGFsbG9jYXRlZCBh
cyBHVFQsIHVuZm9ydHVuYXRlbHkgYQo+ICsJICogc21hbGwgcmVnaW9uIG9mIGJvdHRvbSBWUkFN
IHdhcyBlbmNyb2FjaGVkIGJ5IFVNQyBmaXJtd2FyZSBkdXJpbmcKPiArCSAqIEdERFI2IEJJU1Qg
dHJhaW5pbmcsIHRoaXMgY2F1c2UgcGFnZSBmYXVsdC4KPiArCSAqIFRoZSBwYWdlIGZhdWx0IGNh
biBiZSBmaXhlZCBieSBmb3JjaW5nIHN0b2xlbl9zaXplIHRvIDNNQiwgdGhlbiB0aGUKPiArCSAq
IGJvdHRvbSByZWdpb24gb2YgVlJBTSB3YXMgYWxsb2NhdGVkIGFzIHN0b2xlbiBtZW1vcnksIEdU
VCBjb3JydXB0aW9uCj4gKwkgKiBhdm9pZC4KPiArCSAqLwo+ICsJYWRldi0+Z21jLnN0b2xlbl9z
aXplID0gbWF4KGFkZXYtPmdtYy5zdG9sZW5fc2l6ZSwKPiArCQkJCSAgICBBTURHUFVfU1RPTEVO
X1ZHQV9ERUZBVUxUX1NJWkUpOwo+ICsKPiAgIAkvKiBNZW1vcnkgbWFuYWdlciAqLwo+ICAgCXIg
PSBhbWRncHVfYm9faW5pdChhZGV2KTsKPiAgIAlpZiAocikKPiBAQCAtNzk2LDYgKzgxNiwxNCBA
QCBzdGF0aWMgdm9pZCBnbWNfdjEwXzBfZ2FydF9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQo+ICAgc3RhdGljIGludCBnbWNfdjEwXzBfc3dfZmluaSh2b2lkICpoYW5kbGUpCj4gICB7
Cj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KiloYW5kbGU7Cj4gKwl2b2lkICpzdG9sZW5fdmdhX2J1ZjsKPiArCj4gKwkvKkFMVSB1dGlsaXph
dGlvbi7CoCBCZWNhdXNlIG9mIHRoZSB3YXkgdGhhdCBwcmVkaWNhdGlvbiBpcyB1c2VkIHRvIGRl
YWwKPiB3aXRoIGRpdmVyZ2VudCBjb250cm9sLWZsb3csIHlvdSBjYW4gZW5kIHVwIGV4ZWN1dGlu
ZyBtb3JlIGluc3RydWN0aW9ucwo+IHRoYW4gYW55IHNpbmdsZSBpbnZvY2F0aW9uIG5lZWRzLsKg
IEFzIGEgd29yc3QtY2FzZSBleGFtcGxlLCBzdXBwb3NlIHlvdXIKPiAgIHNoYWRlciBzdGFydHMg
d2l0aCBhIGJpZyBzd2l0Y2ggc3RhdGVtZW50IHdoZXJlIGVhY2ggY2FzZSBpcyBzb21lCj4gbm9u
LXRyaXZpYWwgcGllY2Ugb2YgY29kZS7CoCBGdXJ0aGVyIHN1cHBvc2UgdGhhdCB5b3UgaGF2ZSBz
b21lIHNoYWRlcgo+IHRocmVhZCB3aGVyZSBlYWNoIGludm9jYXRpb24gdGFrZXMgYSBkaWZmZXJl
bnQgY2FzZSBpbiB0aGUgc3dpdGNoLgo+IFRoYW5rcyB0byB0aGUgd2F5IGRpdmVyZ2VudCBjb250
cm9sLWZsb3cgaGFzIHRvIGJlIGhhbmRsZWQsIHlvdSB3b3VsZAo+IGVuZCB1cCBlZmZlY3RpdmVs
eSBleGVjdXRpbmcgZWFjaCBpbnZvY2F0aW9uIHNlcGFyYXRlbHkgYW5kIG5vdGhpbmcKPiB3b3Vs
ZCBiZSBwYXJhbGxlbGl6ZWQuCj4gKwkgKiBGcmVlIHRoZSBzdG9sZW4gVkdBIG1lbW9yeSB3aGVu
IGl0IG1pZ2h0IGJlIHVzZWQgZm9yIG1lbW9yeSB0cmFpbmluZy4KPiArCSAqLwo+ICsJaWYgKGFk
ZXYtPmZ3X3ZyYW1fdXNhZ2UubWVtX3RyYWluX3N1cHBvcnQpCgpZb3UgY2FuIGRyb3AgdGhlICJp
ZiIsIGZyZWVpbmcgdGhlIEJPIHR3aWNlIGlzIGhhcm1sZXNzIGJlY2F1c2Ugd2Ugc2V0IAp0aGUg
cG9pbnRlciB0byBOVUxMIGFmdGVyIHRoZSBmaXJzdCB0aW1lLgoKWW91IG1pZ2h0IGFsc28gd2Fu
dCB0byBjbGVhcmlmeSB0aGUgY29tbWVudCBhIGJpdCwgc29tZXRoaW5nIGxpa2UgIkZyZWUgCnRo
ZSBzdG9sZW4gbWVtb3J5IGlmIGl0IHdhc24ndCBhbHJlYWR5IGZyZWVkIGluIGxhdGVfaW5pdCBi
ZWNhdXNlIG9mIAptZW1vcnkgdHJhaW5pbmciLgoKQXBhcnQgZnJvbSB0aGF0IGxvb2tzIGdvb2Qg
dG8gbWUgYXMgd2VsbCwgYnV0IHlvdSBzaG91bGQgc3luYyB3aXRoIEFsZXggCndobyBpcyBnb2lu
ZyB0byBkbyB0aGUgcGF0Y2hlcy4KCkNoZWVycywKQ2hyaXN0aWFuLgoKPiArCQlhbWRncHVfYm9f
ZnJlZV9rZXJuZWwoJmFkZXYtPnN0b2xlbl92Z2FfbWVtb3J5LCBOVUxMLAo+ICsJCQkJICAgICAg
JnN0b2xlbl92Z2FfYnVmKTsKPiAgIAo+ICAgCWFtZGdwdV92bV9tYW5hZ2VyX2ZpbmkoYWRldik7
Cj4gICAJZ21jX3YxMF8wX2dhcnRfZmluaShhZGV2KTsKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
