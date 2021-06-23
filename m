Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F2EC48BC2
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 08:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213066100B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 08:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213066100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850596E877;
	Wed, 23 Jun 2021 08:29:02 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8662D6E873;
 Wed, 23 Jun 2021 08:29:00 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 h21-20020a1ccc150000b02901d4d33c5ca0so740342wmb.3; 
 Wed, 23 Jun 2021 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=iGLnjprEGYlXcZhGs3cEjGPCgjZd4lu1pdphqPFGrAk=;
 b=hn1OT7a5ErM/BbqDEIhwJUJXm3D4BDwroSHwOULWH9DyBhUnIxxRh926G+SbboAtsc
 EsMv6KyZCLphhKupf5CNk44+SRwx9/GGYbKBjyi7HfKI+xzYSlXXDgPC1kIQxV76gi8Z
 gKWwPWoT4HeAeuAMXgz96Ajn1FFHiT5MjEDXk0EEFfdJReK89CWoCpfbt2KekI0NbIr+
 GloRkEyh5R9KUnTbGU6YygsiBtro4kRzseZsBgu4SArtQ8BZjUvYG4Iax93ci7373Mii
 iS4Bu2w7/UqaXSqA2LMMjviO8d79wsxz0S5/kqQ7Y9ww4OM+zb7z0cy13w0W6YJj0fLu
 XFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=iGLnjprEGYlXcZhGs3cEjGPCgjZd4lu1pdphqPFGrAk=;
 b=V+EXle5FojVk3IiXl61qlTPe8inTI24AjAat7/rr50AYa+M7ltegWvewDOuLSx6AHv
 BttPT75v/8ReibnBV/MplI8pqUCRlqPyUudzSsyqr5Bw58Egr4h6/s+KbW+o309NQ6UI
 hGIgs1G5aDMBB0uxesb07ZPDvaANF4+hyTpHCJFxOGGlqVxa8Z19IY1KPQq1BPJVEqjj
 WV3oFqftovi88zMyiJIkznin/d2xQ2mwDNwrpJAr3CRIdjNiVyI2L40LUnykJpQvg0Ea
 PT4NlDBk0nw6YGsLvIHINw+lQUCnqtv0A5jO3yUWBobypP3IFpMKtvLPoMZRD3THnzT1
 93RA==
X-Gm-Message-State: AOAM533p2a4paf29C644l7Uy9C733LCtFoGQVD2EWPTIMYHehDOZfoP8
 XSubhqKRpJfHfJ/rowL1K8M=
X-Google-Smtp-Source: ABdhPJy0daVOZ0ZzvkGD8uQj/iFySMHissc7mUK18SsdoNhhNOswCLaQqFyTlA5VruYHtSG4OdzYNA==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr9408542wme.130.1624436939248; 
 Wed, 23 Jun 2021 01:28:59 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:69e4:a619:aa86:4e9c?
 ([2a02:908:1252:fb60:69e4:a619:aa86:4e9c])
 by smtp.gmail.com with ESMTPSA id y4sm2048949wrw.71.2021.06.23.01.28.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 01:28:58 -0700 (PDT)
Subject: Re: [PATCH 6/6] drm/ttm: Fix multihop assert on eviction.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20210622162339.761651-1-andrey.grodzovsky@amd.com>
 <20210622162339.761651-6-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8172566c-82e5-3490-13e1-cf3e6f0839a8@gmail.com>
Date: Wed, 23 Jun 2021 10:28:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622162339.761651-6-andrey.grodzovsky@amd.com>
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
Cc: Lang.Yu@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDYuMjEgdW0gMTg6MjMgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiBQcm9ibGVt
Ogo+IFVuZGVyIG1lbW9yeSBwcmVzc3VyZSB3aGVuIEdUVCBkb21haW4gaXMgYWxtb3N0IGZ1bGwg
bXVsdGlob3AgYXNzZXJ0Cj4gd2lsbCBjb21lIHVwIHdoZW4gdHJ5aW5nIHRvIGV2aWN0IExSVSBC
TyBmcm9tIFZSQU0gdG8gU1lTVEVNLgo+Cj4gRml4Ogo+IERvbid0IGFzc2VydCBvbiBtdWx0aWhv
cCBlcnJvciBpbiBldmljdCBjb2RlIGJ1dCByYXRoZXIgZG8gYSByZXRyeQo+IGFzIHdlIGRvIGlu
IHR0bV9ib19tb3ZlX2J1ZmZlcgo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kg
PGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKQnV0IEkgdGhpbmsgeW91IG5lZWQgdG8gbW92
ZSB0aGlzIHBhdGNoIGVhcmxpZXIgaW4gdGhlIHNlcmllcyBvciAKb3RoZXJ3aXNlIHlvdSBicmVh
ayBhbWRncHUgZXZpY3Rpb24gaW4gYmV0d2Vlbi4KCkNocmlzdGlhbi4KCj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jIHwgNjMgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyBiL2Ry
aXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKPiBpbmRleCA0NTE0NWQwMmFlZDIuLjVhMmRjNzEy
YzYzMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwo+IEBAIC00ODUsNiArNDg1LDMxIEBAIHZvaWQg
dHRtX2JvX3VubG9ja19kZWxheWVkX3dvcmtxdWV1ZShzdHJ1Y3QgdHRtX2RldmljZSAqYmRldiwg
aW50IHJlc2NoZWQpCj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MKHR0bV9ib191bmxvY2tfZGVsYXll
ZF93b3JrcXVldWUpOwo+ICAgCj4gK3N0YXRpYyBpbnQgdHRtX2JvX2JvdW5jZV90ZW1wX2J1ZmZl
cihzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAo+ICsJCQkJICAgICBzdHJ1Y3QgdHRtX3Jl
c291cmNlICoqbWVtLAo+ICsJCQkJICAgICBzdHJ1Y3QgdHRtX29wZXJhdGlvbl9jdHggKmN0eCwK
PiArCQkJCSAgICAgc3RydWN0IHR0bV9wbGFjZSAqaG9wKQo+ICt7Cj4gKwlzdHJ1Y3QgdHRtX3Bs
YWNlbWVudCBob3BfcGxhY2VtZW50Owo+ICsJc3RydWN0IHR0bV9yZXNvdXJjZSAqaG9wX21lbTsK
PiArCWludCByZXQ7Cj4gKwo+ICsJaG9wX3BsYWNlbWVudC5udW1fcGxhY2VtZW50ID0gaG9wX3Bs
YWNlbWVudC5udW1fYnVzeV9wbGFjZW1lbnQgPSAxOwo+ICsJaG9wX3BsYWNlbWVudC5wbGFjZW1l
bnQgPSBob3BfcGxhY2VtZW50LmJ1c3lfcGxhY2VtZW50ID0gaG9wOwo+ICsKPiArCS8qIGZpbmQg
c3BhY2UgaW4gdGhlIGJvdW5jZSBkb21haW4gKi8KPiArCXJldCA9IHR0bV9ib19tZW1fc3BhY2Uo
Ym8sICZob3BfcGxhY2VtZW50LCAmaG9wX21lbSwgY3R4KTsKPiArCWlmIChyZXQpCj4gKwkJcmV0
dXJuIHJldDsKPiArCS8qIG1vdmUgdG8gdGhlIGJvdW5jZSBkb21haW4gKi8KPiArCXJldCA9IHR0
bV9ib19oYW5kbGVfbW92ZV9tZW0oYm8sIGhvcF9tZW0sIGZhbHNlLCBjdHgsIE5VTEwpOwo+ICsJ
aWYgKHJldCkgewo+ICsJCXR0bV9yZXNvdXJjZV9mcmVlKGJvLCAmaG9wX21lbSk7Cj4gKwkJcmV0
dXJuIHJldDsKPiArCX0KPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICAgc3RhdGljIGludCB0dG1f
Ym9fZXZpY3Qoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywKPiAgIAkJCXN0cnVjdCB0dG1f
b3BlcmF0aW9uX2N0eCAqY3R4KQo+ICAgewo+IEBAIC01MjQsMTIgKzU0OSwxNyBAQCBzdGF0aWMg
aW50IHR0bV9ib19ldmljdChzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAo+ICAgCQlnb3Rv
IG91dDsKPiAgIAl9Cj4gICAKPiArYm91bmNlOgo+ICAgCXJldCA9IHR0bV9ib19oYW5kbGVfbW92
ZV9tZW0oYm8sIGV2aWN0X21lbSwgdHJ1ZSwgY3R4LCAmaG9wKTsKPiAtCWlmICh1bmxpa2VseShy
ZXQpKSB7Cj4gLQkJV0FSTihyZXQgPT0gLUVNVUxUSUhPUCwgIlVuZXhwZWN0ZWQgbXVsdGlob3Ag
aW4gZXZpY3Rpb24gLSBsaWtlbHkgZHJpdmVyIGJ1Z1xuIik7Cj4gLQkJaWYgKHJldCAhPSAtRVJF
U1RBUlRTWVMpCj4gKwlpZiAocmV0ID09IC1FTVVMVElIT1ApIHsKPiArCQlyZXQgPSB0dG1fYm9f
Ym91bmNlX3RlbXBfYnVmZmVyKGJvLCAmZXZpY3RfbWVtLCBjdHgsICZob3ApOwo+ICsJCWlmIChy
ZXQpIHsKPiAgIAkJCXByX2VycigiQnVmZmVyIGV2aWN0aW9uIGZhaWxlZFxuIik7Cj4gLQkJdHRt
X3Jlc291cmNlX2ZyZWUoYm8sICZldmljdF9tZW0pOwo+ICsJCQl0dG1fcmVzb3VyY2VfZnJlZShi
bywgJmV2aWN0X21lbSk7Cj4gKwkJCWdvdG8gb3V0Owo+ICsJCX0KPiArCQkvKiB0cnkgYW5kIG1v
dmUgdG8gZmluYWwgcGxhY2Ugbm93LiAqLwo+ICsJCWdvdG8gYm91bmNlOwo+ICAgCX0KPiAgIG91
dDoKPiAgIAlyZXR1cm4gcmV0Owo+IEBAIC04NDQsMzEgKzg3NCw2IEBAIGludCB0dG1fYm9fbWVt
X3NwYWNlKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCj4gICB9Cj4gICBFWFBPUlRfU1lN
Qk9MKHR0bV9ib19tZW1fc3BhY2UpOwo+ICAgCj4gLXN0YXRpYyBpbnQgdHRtX2JvX2JvdW5jZV90
ZW1wX2J1ZmZlcihzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAo+IC0JCQkJICAgICBzdHJ1
Y3QgdHRtX3Jlc291cmNlICoqbWVtLAo+IC0JCQkJICAgICBzdHJ1Y3QgdHRtX29wZXJhdGlvbl9j
dHggKmN0eCwKPiAtCQkJCSAgICAgc3RydWN0IHR0bV9wbGFjZSAqaG9wKQo+IC17Cj4gLQlzdHJ1
Y3QgdHRtX3BsYWNlbWVudCBob3BfcGxhY2VtZW50Owo+IC0Jc3RydWN0IHR0bV9yZXNvdXJjZSAq
aG9wX21lbTsKPiAtCWludCByZXQ7Cj4gLQo+IC0JaG9wX3BsYWNlbWVudC5udW1fcGxhY2VtZW50
ID0gaG9wX3BsYWNlbWVudC5udW1fYnVzeV9wbGFjZW1lbnQgPSAxOwo+IC0JaG9wX3BsYWNlbWVu
dC5wbGFjZW1lbnQgPSBob3BfcGxhY2VtZW50LmJ1c3lfcGxhY2VtZW50ID0gaG9wOwo+IC0KPiAt
CS8qIGZpbmQgc3BhY2UgaW4gdGhlIGJvdW5jZSBkb21haW4gKi8KPiAtCXJldCA9IHR0bV9ib19t
ZW1fc3BhY2UoYm8sICZob3BfcGxhY2VtZW50LCAmaG9wX21lbSwgY3R4KTsKPiAtCWlmIChyZXQp
Cj4gLQkJcmV0dXJuIHJldDsKPiAtCS8qIG1vdmUgdG8gdGhlIGJvdW5jZSBkb21haW4gKi8KPiAt
CXJldCA9IHR0bV9ib19oYW5kbGVfbW92ZV9tZW0oYm8sIGhvcF9tZW0sIGZhbHNlLCBjdHgsIE5V
TEwpOwo+IC0JaWYgKHJldCkgewo+IC0JCXR0bV9yZXNvdXJjZV9mcmVlKGJvLCAmaG9wX21lbSk7
Cj4gLQkJcmV0dXJuIHJldDsKPiAtCX0KPiAtCXJldHVybiAwOwo+IC19Cj4gLQo+ICAgc3RhdGlj
IGludCB0dG1fYm9fbW92ZV9idWZmZXIoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywKPiAg
IAkJCSAgICAgIHN0cnVjdCB0dG1fcGxhY2VtZW50ICpwbGFjZW1lbnQsCj4gICAJCQkgICAgICBz
dHJ1Y3QgdHRtX29wZXJhdGlvbl9jdHggKmN0eCkKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
