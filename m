Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D721C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 14:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3725664F0A
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 14:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3725664F0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67596E8D4;
	Tue,  2 Mar 2021 14:13:15 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BA96E8D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 14:13:14 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id hs11so35517103ejc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Mar 2021 06:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=16G8sC3MKVdaVxkqRCVwHqYXd65ABKWGpjF4A8bVD7A=;
 b=T8E7WKrh6nGEYmEE67AC92xXsiyxw/VkvXxGonfkSkE6GjmwA69gErpIM0gK+ugiRg
 mPQl6wfck/PWKif6pEk6Cw0wMiPwCYVhiP/mg/+QWFQM4f3odOTjji7+3zwK6WHbbXKj
 VDEvN4bzTRzzvJciFDiR91+iaQhZ4Cy/B0b4dRwL8Ew7OjrEW/kSyGaIqMMuop3SWnvc
 xZYUqnKFdXp1GukGJX7zAduAKlbCCny5NUKVlrxnusgXZXaZ74+w1FyVINLdWhrGMDcV
 q0JAsbm5+KK83Gf6Zs6HrJWxwZ0Ps2tTVXv0TSsGNayBnjvas/sA8XjOrJ/2r/eYAgqI
 FODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=16G8sC3MKVdaVxkqRCVwHqYXd65ABKWGpjF4A8bVD7A=;
 b=eYGsugVUphC86AjaKbOLrtbi8HcdKX6a5uRdCazVI0KR6hs/+sKgTTh3rtrKwtWwh9
 A3pdvyEbhRym7x6gVe2ehRjKwhh8SwLC/Yi87GJA+6MT20DJ3fPblScQ9kG/4JWY3u79
 0odxsXBGEHS6GAaFnaKWCf3E0j7kViIwhPaTMr0aJY4zgswuEAuG+9DYnFqNZIzmi0/E
 8G66hSWhnEVuzop/KxvG2U+MVRntqhTLRj6QTQdaf6lLgpHED1OGcmlm86sf9d6R1f2i
 NC1x40946nRuxpizS5Lq27TDoaPN5GIcVs/RhSxet8k/GY8QlpTs0pJrvZ7YGTj+oCqC
 eXxg==
X-Gm-Message-State: AOAM532h5oE1qHb0MBQx/O5CVlS+K2IxkO83Nhc6uSzIHKKGSxJqEXxq
 D+HtFn3PjRKaf7pyTiWXlZR5bc48IuoF7w==
X-Google-Smtp-Source: ABdhPJwEdBI9M+eI64ciCGebDUdP6Ny9Srw8AU0dNS4mMD6N+5t8Kx+vf61gzZsIDs4F5/8UrIhyRg==
X-Received: by 2002:a17:906:b6cc:: with SMTP id
 ec12mr20901049ejb.520.1614694393235; 
 Tue, 02 Mar 2021 06:13:13 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:9804:8dfd:7f6e:acec?
 ([2a02:908:1252:fb60:9804:8dfd:7f6e:acec])
 by smtp.gmail.com with ESMTPSA id i18sm18230806edt.68.2021.03.02.06.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Mar 2021 06:13:12 -0800 (PST)
Subject: Re: [PATCH] drm/radeon: Use kvmalloc for CS chunks
To: Chen Li <chenli@uniontech.com>, amd-gfx@lists.freedesktop.org
References: <87wnuqt5tn.wl-chenli@uniontech.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <91acb410-2060-fee7-0791-f7585ab7a1d8@gmail.com>
Date: Tue, 2 Mar 2021 15:13:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87wnuqt5tn.wl-chenli@uniontech.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDMuMjEgdW0gMDc6NDIgc2NocmllYiBDaGVuIExpOgo+IFRoZSBudW1iZXIgb2YgY2h1
bmtzL2NodW5rc19hcnJheSBtYXkgYmUgcGFzc2VkIGluCj4gYnkgdXNlcnNwYWNlIGFuZCBjYW4g
YmUgbGFyZ2UuCgpJJ20gd29uZGVyaW5nIGlmIHdlIHNob3VsZG4ndCByYXRoZXIgcmVzdHJpY3Qg
dGhlIG51bWJlciBvZiBjaHVua3MuCgo+IEl0IGhhcyBiZWVuIG9ic2VydmVkIHRvIGNhdXNlIGtj
YWxsb2MgZmFpbHVyZXMgZnJvbSB0cmluaXR5IGZ1enp5IHRlc3Q6Cj4KPiBgYGAKPiAgIFdBUk5J
Tkc6IENQVTogMCBQSUQ6IDU0ODcgYXQgbW0vcGFnZV9hbGxvYy5jOjQzODUKPiAgIF9fYWxsb2Nf
cGFnZXNfbm9kZW1hc2srMHgyZDgvMHgxNGQwCj4KPiAuLi4uLi4KPgo+IFRyYWNlOgo+IF9fd2Fy
bi5wYXJ0LjQrMHgxMWMvMHgxNzQKPiBfX2FsbG9jX3BhZ2VzX25vZGVtYXNrKzB4MmQ4LzB4MTRk
MAo+IHdhcm5fc2xvd3BhdGhfbnVsbCsweDg0LzB4YjAKPiBfX2FsbG9jX3BhZ2VzX25vZGVtYXNr
KzB4MmQ4LzB4MTRkMAo+IF9fYWxsb2NfcGFnZXNfbm9kZW1hc2srMHgyZDgvMHgxNGQwCj4gYWxs
b2NfcGFnZXNfY3VycmVudCsweGYwLzB4MWIwCj4gZnJlZV9idWZmZXJfaGVhZCsweDg4LzB4ZjAK
PiBqYmQyX2pvdXJuYWxfdHJ5X3RvX2ZyZWVfYnVmZmVycysweDFlMC8weDJhMAo+IGV4dDRfcmVs
ZWFzZXBhZ2UrMHg4NC8weDE0MAo+IHJlbGVhc2VfcGFnZXMrMHg0MTQvMHg0YzAKPiByZWxlYXNl
X3BhZ2VzKzB4NDJjLzB4NGMwCj4gX19maW5kX2dldF9ibG9jaysweDFhNC8weDViMAo+IGFsbG9j
X3BhZ2VzX2N1cnJlbnQrMHhjYy8weDFiMAo+IGttYWxsb2Nfb3JkZXIrMHgzMC8weGIwCj4gX19r
bWFsbG9jKzB4MzAwLzB4MzkwCj4ga21hbGxvY19vcmRlcl90cmFjZSsweDQ4LzB4MTEwCj4gX19r
bWFsbG9jKzB4MzAwLzB4MzkwCj4gcmFkZW9uX2NzX3BhcnNlcl9pbml0LnBhcnQuMSsweDc0LzB4
NjcwIFtyYWRlb25dCj4gY3J5cHRvX3NoYXNoX3VwZGF0ZSsweDVjLzB4MWMwCj4gcmFkZW9uX2Nz
X3BhcnNlcl9pbml0LnBhcnQuMSsweDc0LzB4NjcwIFtyYWRlb25dCj4gX193YWtlX3VwX2NvbW1v
bl9sb2NrKzB4YjgvMHgyMTAKPiByYWRlb25fY3NfaW9jdGwrMHhjOC8weGI4MCBbcmFkZW9uXQo+
IHJhZGVvbl9jc19pb2N0bCsweDUwLzB4YjgwIFtyYWRlb25dCj4gZHJtX2lvY3RsX2tlcm5lbCsw
eGY0LzB4MTYwCj4gcmFkZW9uX2NzX2lvY3RsKzB4MC8weGI4MCBbcmFkZW9uXQo+IGRybV9pb2N0
bF9rZXJuZWwrMHhhMC8weDE2MAo+IGRybV9pb2N0bCsweDJkYy8weDRmMAo+IHJhZGVvbl9kcm1f
aW9jdGwrMHg4MC8weGYwIFtyYWRlb25dCj4gbmV3X3N5bmNfd3JpdGUrMHgxMjAvMHgxYzAKPiB0
aW1lcnF1ZXVlX2FkZCsweDg4LzB4MTQwCj4gZG9fdmZzX2lvY3RsKzB4ZTQvMHg5OTAKPiBrc3lz
X2lvY3RsKzB4ZGMvMHgxMTAKPiBrc3lzX2lvY3RsKzB4NzgvMHgxMTAKPiBzeXNfaW9jdGwrMHgy
Yy8weDUwCj4gZW50U3lzKzB4YTAvMHhjMAoKUGxlYXNlIGRyb3AgdGhlIGJhY2t0cmFjZSwgaXQg
ZG9lc24ndCBhZGQgYW55IHZhbHVlIHRvIHRoZSBjb21taXQgbG9nLgoKPiBgYGAKPgo+IE9idmlv
dXNseSwgdGhlIHJlcXVpcmVkIG9yZGVyIGluIHRoaXMgY2FzZSBpcyBsYXJnZXIgdGhhbiBNQVhf
T1JERVIuCj4gU28sIGp1c3QgdXNlIGt2bWFsbG9jIGluc3RlYWQuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBDaGVuIExpIDxjaGVubGlAdW5pb250ZWNoLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpUaGUgc2FtZSBwYXRjaCBzaG91bGQg
cHJvYmFibHkgYXBwbGllZCB0byBhbWRncHUgYXMgd2VsbCBpZiB3ZSBkb24ndCAKYWxyZWFkeSB1
c2Uga3ZtYWxsb2MgdGhlcmUgYXMgd2VsbC4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4gLS0tCj4g
ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jcy5jIHwgOCArKysrLS0tLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jcy5jIGIvZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25fY3MuYwo+IGluZGV4IDM1ZTkzN2QzOWI1MS4uZmI3MzZlZjlmOWFhIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jcy5jCj4gQEAgLTI4OCw3ICsyODgsNyBAQCBp
bnQgcmFkZW9uX2NzX3BhcnNlcl9pbml0KHN0cnVjdCByYWRlb25fY3NfcGFyc2VyICpwLCB2b2lk
ICpkYXRhKQo+ICAgCXAtPmNodW5rX3JlbG9jcyA9IE5VTEw7Cj4gICAJcC0+Y2h1bmtfZmxhZ3Mg
PSBOVUxMOwo+ICAgCXAtPmNodW5rX2NvbnN0X2liID0gTlVMTDsKPiAtCXAtPmNodW5rc19hcnJh
eSA9IGtjYWxsb2MoY3MtPm51bV9jaHVua3MsIHNpemVvZih1aW50NjRfdCksIEdGUF9LRVJORUwp
Owo+ICsJcC0+Y2h1bmtzX2FycmF5ID0ga3ZtYWxsb2NfYXJyYXkoY3MtPm51bV9jaHVua3MsIHNp
emVvZih1aW50NjRfdCksIEdGUF9LRVJORUwpOwo+ICAgCWlmIChwLT5jaHVua3NfYXJyYXkgPT0g
TlVMTCkgewo+ICAgCQlyZXR1cm4gLUVOT01FTTsKPiAgIAl9Cj4gQEAgLTI5OSw3ICsyOTksNyBA
QCBpbnQgcmFkZW9uX2NzX3BhcnNlcl9pbml0KHN0cnVjdCByYWRlb25fY3NfcGFyc2VyICpwLCB2
b2lkICpkYXRhKQo+ICAgCX0KPiAgIAlwLT5jc19mbGFncyA9IDA7Cj4gICAJcC0+bmNodW5rcyA9
IGNzLT5udW1fY2h1bmtzOwo+IC0JcC0+Y2h1bmtzID0ga2NhbGxvYyhwLT5uY2h1bmtzLCBzaXpl
b2Yoc3RydWN0IHJhZGVvbl9jc19jaHVuayksIEdGUF9LRVJORUwpOwo+ICsJcC0+Y2h1bmtzID0g
a3ZtYWxsb2NfYXJyYXkocC0+bmNodW5rcywgc2l6ZW9mKHN0cnVjdCByYWRlb25fY3NfY2h1bmsp
LCBHRlBfS0VSTkVMKTsKPiAgIAlpZiAocC0+Y2h1bmtzID09IE5VTEwpIHsKPiAgIAkJcmV0dXJu
IC1FTk9NRU07Cj4gICAJfQo+IEBAIC00NTIsOCArNDUyLDggQEAgc3RhdGljIHZvaWQgcmFkZW9u
X2NzX3BhcnNlcl9maW5pKHN0cnVjdCByYWRlb25fY3NfcGFyc2VyICpwYXJzZXIsIGludCBlcnJv
ciwgYm8KPiAgIAlrdmZyZWUocGFyc2VyLT52bV9ib3MpOwo+ICAgCWZvciAoaSA9IDA7IGkgPCBw
YXJzZXItPm5jaHVua3M7IGkrKykKPiAgIAkJa3ZmcmVlKHBhcnNlci0+Y2h1bmtzW2ldLmtkYXRh
KTsKPiAtCWtmcmVlKHBhcnNlci0+Y2h1bmtzKTsKPiAtCWtmcmVlKHBhcnNlci0+Y2h1bmtzX2Fy
cmF5KTsKPiArCWt2ZnJlZShwYXJzZXItPmNodW5rcyk7Cj4gKwlrdmZyZWUocGFyc2VyLT5jaHVu
a3NfYXJyYXkpOwo+ICAgCXJhZGVvbl9pYl9mcmVlKHBhcnNlci0+cmRldiwgJnBhcnNlci0+aWIp
Owo+ICAgCXJhZGVvbl9pYl9mcmVlKHBhcnNlci0+cmRldiwgJnBhcnNlci0+Y29uc3RfaWIpOwo+
ICAgfQo+IC0tCj4gMi4zMC4wCj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
