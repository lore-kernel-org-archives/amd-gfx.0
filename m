Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2296EC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 17:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD86564F1C
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 17:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD86564F1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C626E159;
	Tue,  2 Mar 2021 17:56:31 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A16B76E159
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 17:56:29 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id l133so22863431oib.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Mar 2021 09:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LJhobmleC2WDHVCAr/bKuaQ8007ndbO+4oTw0fIlodo=;
 b=aU2OFgw/64sR+TGPki/XfKx494/QiGRYuxIXrmikpmaB3qmBnQwgCcOBmVthJp3kL3
 IjWUZ/5BNSUj6jh+GzcAKTzJ1IpMsIqzxtbUbX3Jpn+2lp46UgGccZI/zxAtfSIZr0Pt
 Ze8G4NQYdK7G9R/r2bp43nweavMFt/RY8oRErT8ltSPNs2z08xXx7+WjObh6nJ585ab9
 uNxQbR9Ef+8C6xQfix1qhil202bSp9ASee1nsicbVXBqk7f8GV77pbqGfQ/JFJqC2mDP
 9gKsp4jluVbc7NKVTOsbGuvfocJz1pBiLpFTR4RdPrtAO5MjmIYa9BdQxtPeWf/C3rJd
 ujNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LJhobmleC2WDHVCAr/bKuaQ8007ndbO+4oTw0fIlodo=;
 b=g1zeRirHklCk+Tulp/HOCe6cGIRmc6lpNyTjwt8zxxgN4VAAx7m6tfxH+Mp22jqqov
 Nli4y8BfwICw+fY64YEIsbvpVukpgreskf4qYXr+Ao6HXHAnGVBAmK6O80sjFqnEwlEL
 eYBv0/V3lSRrRV9zEbgZUW/Ugu3X8ham1MOmpYHNgUeIWVkkK6K1DHbWWN+V3lH2b4eN
 kFxPu98SzIyvUZv/GPaHHgx7yGHhvDFhy23XAGJw+IkJSUk7+3HVLpW460OgFGQPvJ+I
 FQico2rHKLVZPmWaSHEY8QPEMbIVXQW1gtuW7+swnP4as5wXoF9jP6QlVlZ0MZF1D7J+
 prTA==
X-Gm-Message-State: AOAM532essiztyQ7QZifbqqVR/lL9BtDTdRDOWc+CXsQQ2txNj40GTZN
 68TWrQ98spxm/MQ7kzZpoLb6sUKIiXlax1iZoBQ=
X-Google-Smtp-Source: ABdhPJxzBUsjiSBxxNgCJARy781tuGGoG7z7aSO2sdGy5EMjpIqeG/QlJFUuuiv/OsXIwC/ota0Rm2P1jEBp2JYcASc=
X-Received: by 2002:a05:6808:f15:: with SMTP id
 m21mr4027748oiw.123.1614707788969; 
 Tue, 02 Mar 2021 09:56:28 -0800 (PST)
MIME-Version: 1.0
References: <87wnuqt5tn.wl-chenli@uniontech.com>
 <91acb410-2060-fee7-0791-f7585ab7a1d8@gmail.com>
In-Reply-To: <91acb410-2060-fee7-0791-f7585ab7a1d8@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Mar 2021 12:56:17 -0500
Message-ID: <CADnq5_NpUL9kknskMjvNNX-jTRn+2_Xkx9oOzYJuZi4aXPLa7Q@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Use kvmalloc for CS chunks
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Chen Li <chenli@uniontech.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFR1ZSwgTWFyIDIsIDIwMjEgYXQgOToxMyBBTSBD
aHJpc3RpYW4gS8O2bmlnCjxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6
Cj4KPiBBbSAwMi4wMy4yMSB1bSAwNzo0MiBzY2hyaWViIENoZW4gTGk6Cj4gPiBUaGUgbnVtYmVy
IG9mIGNodW5rcy9jaHVua3NfYXJyYXkgbWF5IGJlIHBhc3NlZCBpbgo+ID4gYnkgdXNlcnNwYWNl
IGFuZCBjYW4gYmUgbGFyZ2UuCj4KPiBJJ20gd29uZGVyaW5nIGlmIHdlIHNob3VsZG4ndCByYXRo
ZXIgcmVzdHJpY3QgdGhlIG51bWJlciBvZiBjaHVua3MuCj4KPiA+IEl0IGhhcyBiZWVuIG9ic2Vy
dmVkIHRvIGNhdXNlIGtjYWxsb2MgZmFpbHVyZXMgZnJvbSB0cmluaXR5IGZ1enp5IHRlc3Q6Cj4g
Pgo+ID4gYGBgCj4gPiAgIFdBUk5JTkc6IENQVTogMCBQSUQ6IDU0ODcgYXQgbW0vcGFnZV9hbGxv
Yy5jOjQzODUKPiA+ICAgX19hbGxvY19wYWdlc19ub2RlbWFzaysweDJkOC8weDE0ZDAKPiA+Cj4g
PiAuLi4uLi4KPiA+Cj4gPiBUcmFjZToKPiA+IF9fd2Fybi5wYXJ0LjQrMHgxMWMvMHgxNzQKPiA+
IF9fYWxsb2NfcGFnZXNfbm9kZW1hc2srMHgyZDgvMHgxNGQwCj4gPiB3YXJuX3Nsb3dwYXRoX251
bGwrMHg4NC8weGIwCj4gPiBfX2FsbG9jX3BhZ2VzX25vZGVtYXNrKzB4MmQ4LzB4MTRkMAo+ID4g
X19hbGxvY19wYWdlc19ub2RlbWFzaysweDJkOC8weDE0ZDAKPiA+IGFsbG9jX3BhZ2VzX2N1cnJl
bnQrMHhmMC8weDFiMAo+ID4gZnJlZV9idWZmZXJfaGVhZCsweDg4LzB4ZjAKPiA+IGpiZDJfam91
cm5hbF90cnlfdG9fZnJlZV9idWZmZXJzKzB4MWUwLzB4MmEwCj4gPiBleHQ0X3JlbGVhc2VwYWdl
KzB4ODQvMHgxNDAKPiA+IHJlbGVhc2VfcGFnZXMrMHg0MTQvMHg0YzAKPiA+IHJlbGVhc2VfcGFn
ZXMrMHg0MmMvMHg0YzAKPiA+IF9fZmluZF9nZXRfYmxvY2srMHgxYTQvMHg1YjAKPiA+IGFsbG9j
X3BhZ2VzX2N1cnJlbnQrMHhjYy8weDFiMAo+ID4ga21hbGxvY19vcmRlcisweDMwLzB4YjAKPiA+
IF9fa21hbGxvYysweDMwMC8weDM5MAo+ID4ga21hbGxvY19vcmRlcl90cmFjZSsweDQ4LzB4MTEw
Cj4gPiBfX2ttYWxsb2MrMHgzMDAvMHgzOTAKPiA+IHJhZGVvbl9jc19wYXJzZXJfaW5pdC5wYXJ0
LjErMHg3NC8weDY3MCBbcmFkZW9uXQo+ID4gY3J5cHRvX3NoYXNoX3VwZGF0ZSsweDVjLzB4MWMw
Cj4gPiByYWRlb25fY3NfcGFyc2VyX2luaXQucGFydC4xKzB4NzQvMHg2NzAgW3JhZGVvbl0KPiA+
IF9fd2FrZV91cF9jb21tb25fbG9jaysweGI4LzB4MjEwCj4gPiByYWRlb25fY3NfaW9jdGwrMHhj
OC8weGI4MCBbcmFkZW9uXQo+ID4gcmFkZW9uX2NzX2lvY3RsKzB4NTAvMHhiODAgW3JhZGVvbl0K
PiA+IGRybV9pb2N0bF9rZXJuZWwrMHhmNC8weDE2MAo+ID4gcmFkZW9uX2NzX2lvY3RsKzB4MC8w
eGI4MCBbcmFkZW9uXQo+ID4gZHJtX2lvY3RsX2tlcm5lbCsweGEwLzB4MTYwCj4gPiBkcm1faW9j
dGwrMHgyZGMvMHg0ZjAKPiA+IHJhZGVvbl9kcm1faW9jdGwrMHg4MC8weGYwIFtyYWRlb25dCj4g
PiBuZXdfc3luY193cml0ZSsweDEyMC8weDFjMAo+ID4gdGltZXJxdWV1ZV9hZGQrMHg4OC8weDE0
MAo+ID4gZG9fdmZzX2lvY3RsKzB4ZTQvMHg5OTAKPiA+IGtzeXNfaW9jdGwrMHhkYy8weDExMAo+
ID4ga3N5c19pb2N0bCsweDc4LzB4MTEwCj4gPiBzeXNfaW9jdGwrMHgyYy8weDUwCj4gPiBlbnRT
eXMrMHhhMC8weGMwCj4KPiBQbGVhc2UgZHJvcCB0aGUgYmFja3RyYWNlLCBpdCBkb2Vzbid0IGFk
ZCBhbnkgdmFsdWUgdG8gdGhlIGNvbW1pdCBsb2cuCj4KPiA+IGBgYAo+ID4KPiA+IE9idmlvdXNs
eSwgdGhlIHJlcXVpcmVkIG9yZGVyIGluIHRoaXMgY2FzZSBpcyBsYXJnZXIgdGhhbiBNQVhfT1JE
RVIuCj4gPiBTbywganVzdCB1c2Uga3ZtYWxsb2MgaW5zdGVhZC4KPiA+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBDaGVuIExpIDxjaGVubGlAdW5pb250ZWNoLmNvbT4KPgo+IFJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4KPiBUaGUgc2FtZSBwYXRj
aCBzaG91bGQgcHJvYmFibHkgYXBwbGllZCB0byBhbWRncHUgYXMgd2VsbCBpZiB3ZSBkb24ndAo+
IGFscmVhZHkgdXNlIGt2bWFsbG9jIHRoZXJlIGFzIHdlbGwuCj4KPiBSZWdhcmRzLAo+IENocmlz
dGlhbi4KPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMg
fCA4ICsrKystLS0tCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2NzLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jcy5jCj4gPiBpbmRleCAz
NWU5MzdkMzliNTEuLmZiNzM2ZWY5ZjlhYSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX2NzLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2NzLmMKPiA+IEBAIC0yODgsNyArMjg4LDcgQEAgaW50IHJhZGVvbl9jc19wYXJzZXJfaW5p
dChzdHJ1Y3QgcmFkZW9uX2NzX3BhcnNlciAqcCwgdm9pZCAqZGF0YSkKPiA+ICAgICAgIHAtPmNo
dW5rX3JlbG9jcyA9IE5VTEw7Cj4gPiAgICAgICBwLT5jaHVua19mbGFncyA9IE5VTEw7Cj4gPiAg
ICAgICBwLT5jaHVua19jb25zdF9pYiA9IE5VTEw7Cj4gPiAtICAgICBwLT5jaHVua3NfYXJyYXkg
PSBrY2FsbG9jKGNzLT5udW1fY2h1bmtzLCBzaXplb2YodWludDY0X3QpLCBHRlBfS0VSTkVMKTsK
PiA+ICsgICAgIHAtPmNodW5rc19hcnJheSA9IGt2bWFsbG9jX2FycmF5KGNzLT5udW1fY2h1bmtz
LCBzaXplb2YodWludDY0X3QpLCBHRlBfS0VSTkVMKTsKPiA+ICAgICAgIGlmIChwLT5jaHVua3Nf
YXJyYXkgPT0gTlVMTCkgewo+ID4gICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPiA+ICAg
ICAgIH0KPiA+IEBAIC0yOTksNyArMjk5LDcgQEAgaW50IHJhZGVvbl9jc19wYXJzZXJfaW5pdChz
dHJ1Y3QgcmFkZW9uX2NzX3BhcnNlciAqcCwgdm9pZCAqZGF0YSkKPiA+ICAgICAgIH0KPiA+ICAg
ICAgIHAtPmNzX2ZsYWdzID0gMDsKPiA+ICAgICAgIHAtPm5jaHVua3MgPSBjcy0+bnVtX2NodW5r
czsKPiA+IC0gICAgIHAtPmNodW5rcyA9IGtjYWxsb2MocC0+bmNodW5rcywgc2l6ZW9mKHN0cnVj
dCByYWRlb25fY3NfY2h1bmspLCBHRlBfS0VSTkVMKTsKPiA+ICsgICAgIHAtPmNodW5rcyA9IGt2
bWFsbG9jX2FycmF5KHAtPm5jaHVua3MsIHNpemVvZihzdHJ1Y3QgcmFkZW9uX2NzX2NodW5rKSwg
R0ZQX0tFUk5FTCk7Cj4gPiAgICAgICBpZiAocC0+Y2h1bmtzID09IE5VTEwpIHsKPiA+ICAgICAg
ICAgICAgICAgcmV0dXJuIC1FTk9NRU07Cj4gPiAgICAgICB9Cj4gPiBAQCAtNDUyLDggKzQ1Miw4
IEBAIHN0YXRpYyB2b2lkIHJhZGVvbl9jc19wYXJzZXJfZmluaShzdHJ1Y3QgcmFkZW9uX2NzX3Bh
cnNlciAqcGFyc2VyLCBpbnQgZXJyb3IsIGJvCj4gPiAgICAgICBrdmZyZWUocGFyc2VyLT52bV9i
b3MpOwo+ID4gICAgICAgZm9yIChpID0gMDsgaSA8IHBhcnNlci0+bmNodW5rczsgaSsrKQo+ID4g
ICAgICAgICAgICAgICBrdmZyZWUocGFyc2VyLT5jaHVua3NbaV0ua2RhdGEpOwo+ID4gLSAgICAg
a2ZyZWUocGFyc2VyLT5jaHVua3MpOwo+ID4gLSAgICAga2ZyZWUocGFyc2VyLT5jaHVua3NfYXJy
YXkpOwo+ID4gKyAgICAga3ZmcmVlKHBhcnNlci0+Y2h1bmtzKTsKPiA+ICsgICAgIGt2ZnJlZShw
YXJzZXItPmNodW5rc19hcnJheSk7Cj4gPiAgICAgICByYWRlb25faWJfZnJlZShwYXJzZXItPnJk
ZXYsICZwYXJzZXItPmliKTsKPiA+ICAgICAgIHJhZGVvbl9pYl9mcmVlKHBhcnNlci0+cmRldiwg
JnBhcnNlci0+Y29uc3RfaWIpOwo+ID4gICB9Cj4gPiAtLQo+ID4gMi4zMC4wCj4gPgo+ID4KPiA+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+ID4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+Cj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4
IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
