Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1727CC56201
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 08:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A161A2080A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 08:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTGy57DS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A161A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788B0898F5;
	Tue, 10 Nov 2020 08:25:47 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE35896C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 07:20:56 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id k2so8095547wrx.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 23:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=xAGL+MqhZzKyrUoLXU8MWIWR+zEnYIu8+jLrfBt+Ymo=;
 b=rTGy57DSN9XQoBCQvVJsCf80xY/yL1F27+sV2Uck0Evb3/yyznaYfcwmF25iXGPxHP
 s/J4Bga12wkOZlS7jy8pwfMXUK6eH4uzgipq8uUt83TcEmKfJpzDJYrIy+1uQnyqWB45
 i8N5hdwv5bOHhmk2wGJQ4i5chN0fAiB3CdIDUK9+doprcsIYTY86Exju6DGVzQDIOVP5
 ZQXoBAyv4528nn2m3gHAsuTOvGXqyTQMbEDgUGYfEa8zHxaAEllgMbsLA4CgPLOdDa4x
 wXD1xFHk3IPDXk+P0m9KyoQdXtugrRey4DiuUFtiQ5dyDaxKNH7sIzt+ePd57A6Fj/q5
 8DpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xAGL+MqhZzKyrUoLXU8MWIWR+zEnYIu8+jLrfBt+Ymo=;
 b=psjXmnkvceEUZ01ek+7Wj6DQ4fotCg1BNH/zBRO+27tg1lVnxKb+Yey+6Tt+1sLIoW
 p4gzag5lxYmwVfR9NkJxeorzKNoMWJ0/Oim0N7NSK+hQ7x7bNJQv87RPh8Vt10lALlni
 QpBwRlxqkY/hBt+4eh4z+Hi05SnN+y4IWTgNtH0Wt0/4DF50ZATaTaIPgTHXv5Bhoynl
 tS+nYlfsWVg6aUFn5GBbWwd5dgbuiWlmP00uVow1cSLwgxKjCwhesM32ApriaMKWxR6/
 ltWvfvtDVj+Rwyi9FSOGi+hhqy45IUMh3UM5gubKnoERP2FCzVa+fp5GDmchr/IEshcl
 edtg==
X-Gm-Message-State: AOAM532bEjSrJjRy0fx2aMCxUqR9wi83ikDfl12ebyax76sJqK7xQmF6
 UAa742r15Px9u75W9H77bAaLeg==
X-Google-Smtp-Source: ABdhPJyijq/ksDVuRAKwo3BX7XOAe+raYXlSVEktgYFSH6CSRs0ryV7el71/y3dyTkGCoqBbojSefA==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr18936180wrb.132.1604992855052; 
 Mon, 09 Nov 2020 23:20:55 -0800 (PST)
Received: from dell ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id q1sm4777033wrj.59.2020.11.09.23.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 23:20:54 -0800 (PST)
Date: Tue, 10 Nov 2020 07:20:46 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 00/20] [Set 3] Rid W=1 warnings from GPU
Message-ID: <20201110072024.GE2063125@dell>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
 <CADnq5_N1BbXosxsGoc7L2NCY3rf3dqFB7SD84PNsFTC7rJPY6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_N1BbXosxsGoc7L2NCY3rf3dqFB7SD84PNsFTC7rJPY6Q@mail.gmail.com>
X-Mailman-Approved-At: Tue, 10 Nov 2020 08:25:45 +0000
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Slava Grigorev <slava.grigorev@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Jerome Glisse <glisse@freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 report to <xorg-driver-ati@lists.x.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCAwOSBOb3YgMjAyMCwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBPbiBNb24sIE5vdiA5
LCAyMDIwIGF0IDQ6MTkgUE0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6
Cj4gPgo+ID4gVGhpcyBzZXQgaXMgcGFydCBvZiBhIGxhcmdlciBlZmZvcnQgYXR0ZW1wdGluZyB0
byBjbGVhbi11cCBXPTEKPiA+IGtlcm5lbCBidWlsZHMsIHdoaWNoIGFyZSBjdXJyZW50bHkgb3Zl
cndoZWxtaW5nbHkgcmlkZGxlZCB3aXRoCj4gPiBuaWdnbHkgbGl0dGxlIHdhcm5pbmdzLgo+ID4K
PiA+IFRoaXMgc2V0IHRha2VzIHRoZSBydW5uaW5nIChkZWNyZWFzaW5nKSB0b3RhbCBmcm9tIDUw
MDAgYmVmb3JlCj4gPiBbU2V0IDFdIGRvd24gdG8gMjMwMC4KPiA+Cj4gPiBMZWUgSm9uZXMgKDIw
KToKPiA+ICAgZHJtL3JhZGVvbi9yYWRlb25fdHRtOiBQbGFjZSBkZWNsYXJhdGlvbiBvZiAncmRl
dicgaW4gc2FtZSBjbGF1c2UgYXMKPiA+ICAgICBpdHMgdXNlCj4gPiAgIGRybS9yYWRlb246IE1v
dmUgcmFkZW9uX3R0bXtpbml0LGZpbml9IHRvIHNoYXJlZCBsb2NhdGlvbgo+ID4gICBkcm0vcmFk
ZW9uL3JhZGVvbl9mZW5jZTogRGVtb3RlIHNvbWUgbm9uLWNvbmZvcm1hbnQga2VybmVsLWRvYyBo
ZWFkZXJzCj4gPiAgICAgYW5kIGZpeCBhbm90aGVyCj4gPiAgIGRybS9yYWRlb246IE1vdmUgJ3Jh
ZGVvbl9hZGRfbGVnYWN5X2VuY29kZXInIHByb3RvdHlwZSB0byBzaGFyZWQKPiA+ICAgICBoZWFk
ZXIKPiA+ICAgZHJtL3JhZGVvbjogTW92ZSAncmFkZW9uX2FkZF9sZWdhY3lfZW5jb2RlcidzIHBy
b3RvdHlwZSB0byBzaGFyZWQKPiA+ICAgICBsb2NhdGlvbgo+ID4gICBkcm0vcmFkZW9uL3JhZGVv
bl9jb25uZWN0b3JzOiBTdHJpcCBvdXQgc2V0IGJ1dCB1bnVzZWQgdmFyaWFibGUgJ3JldCcKPiA+
ICAgZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheTogUmVtb3ZlIHVudXNlZCB2YXJpYWJsZSAnbW9k
Jwo+ID4gICBkcm0vcmFkZW9uL3JhZGVvbl9pMmM6IFJlbW92ZSBwb2ludGxlc3MgZnVuY3Rpb24g
aGVhZGVyCj4gPiAgIGRybS9yYWRlb24vcmFkZW9uX2lycV9rbXM6IERlbW90ZSBub24tY29uZm9y
bWFudCBrZXJuZWwtZG9jIGZpeAo+ID4gICAgIGFub3RoZXIKPiA+ICAgZHJtL3JhZGVvbi9yYWRl
b25fcmluZzogQWRkIG1pc3NpbmcgZnVuY3Rpb24gcGFyYW1ldGVycyAncmRldicgYW5kCj4gPiAg
ICAgJ2RhdGEnCj4gPiAgIGRybS9yYWRlb24vcjYwMDogU3RyaXAgb3V0IHNldCBidXQgdW51c2Vk
ICd0bXAnIHZhcmlhYmxlcwo+ID4gICBkcm0vcmFkZW9uL3JhZGVvbl9jczogRml4IGEgYnVuY2gg
b2YgZG9jLXJvdCBpc3N1ZXMKPiA+ICAgZHJtL3JhZGVvbi9ldmVyZ3JlZW46IE1vdmUgJ3J2Nzcw
X3NldF9jbGtfYnlwYXNzX21vZGUnIHByb3RvdHlwZSB0bwo+ID4gICAgIHNoYXJlZCBsb2NhdGlv
bgo+ID4gICBkcm0vcmFkZW9uOiBNb3ZlICdyYWRlb25fcG1fYWNwaV9ldmVudF9oYW5kbGVyJyBw
cm90b3R5cGUgaW50byBzaGFyZWQKPiA+ICAgICBoZWFkZXIKPiA+ICAgZHJtL3JhZGVvbi9yNjAw
ZDogTW92ZSAncmM2MDBfKicgcHJvdG90eXBlcyBpbnRvIHNoYXJlZCBoZWFkZXIKPiA+ICAgZHJt
L3JhZGVvbi9yYWRlb25fYXVkaW86IE1vdmUgJ2RjZTNfMl8qJyBwcm90b3R5cGVzIHRvIHNoYXJl
ZCBsb2NhdGlvbgo+ID4gICBkcm0vcmFkZW9uL2V2ZXJncmVlbmQ6IE1vdmUgJ2V2ZXJncmVlbl8q
JyBhbmQgJ3N1bW9fKicgcHJvdG90eXBlcyBvdXQKPiA+ICAgICB0byBzaGFyZWQgbG9jYXRpb24K
PiA+ICAgZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheTogRml4IGZ1bmN0aW9uIGRvYyBmb3JtYXR0
aW5nIGFuZCBtaXNzaW5nCj4gPiAgICAgcGFyYW0gaXNzdWVzCj4gPiAgIGRybS9yYWRlb24vcjYw
MDogRml4IGEgbWlzbmFtZWQgcGFyYW1ldGVyIGRlc2NyaXB0aW9uIGFuZCBhIGZvcm1hdHRpbmcK
PiA+ICAgICBpc3N1ZQo+ID4gICBkcm0vcmFkZW9uL2NpazogRml4IGEgYnVuY2ggb2YgZnVuY3Rp
b24gcGFyYW1ldGVyIGRlc2NyaXB0aW9ucwo+ID4KPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L2Npay5jICAgICAgICAgICAgICAgfCAxMCArKystLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9ldmVyZ3JlZW4uYyAgICAgICAgIHwgIDEgLQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vbmkuYyAgICAgICAgICAgICAgICB8IDE2IC0tLS0tLS0tLS0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3I2MDAuYyAgICAgICAgICAgICAgfCAxMSArKystLS0tCj4gPiAgZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yNjAwZC5oICAgICAgICAgICAgIHwgMTQgKysrKysrKysrCj4gPiAgZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb24uaCAgICAgICAgICAgIHwgMzQgKysrKysrKysrKysr
KysrKysrKysrKwo+ID4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2FjcGkuYyAgICAg
ICB8ICAyIC0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuYyAg
IHwgIDUgLS0tLQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F1ZGlvLmMgICAg
ICB8IDIzICstLS0tLS0tLS0tLS0tLQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9u
X2F1ZGlvLmggICAgICB8IDEyICsrKysrKysrCj4gPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fY29tYmlvcy5jICAgIHwgIDUgLS0tLQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX2Nvbm5lY3RvcnMuYyB8ICA0ICstLQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX2NzLmMgICAgICAgICB8IDEyICsrKystLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fZGlzcGxheS5jICAgIHwgMTcgKysrKystLS0tLS0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9lbmNvZGVycy5jICAgfCAgMyAtLQo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2ZlbmNlLmMgICAgICB8ICA2ICsrLS0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9pMmMuYyAgICAgICAgfCAgNCAtLS0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9pcnFfa21zLmMgICAgfCAgNiArKy0tCj4gPiAgZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0LmMgICAgIHwgIDIgLS0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9yaW5nLmMgICAgICAgfCAgMyArKwo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jICAgICAgICB8ICA4ICsrLS0tCj4gPiAgZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9zaS5jICAgICAgICAgICAgICAgIHwgIDYgLS0tLQo+ID4gIDIyIGZpbGVz
IGNoYW5nZWQsIDk2IGluc2VydGlvbnMoKyksIDEwOCBkZWxldGlvbnMoLSkKPiAKPiBJbnN0ZWFk
IG9mIGp1c3QgZHVtcGluZyBldmVyeXRoaW5nIGluIHJhZGVvbi5oLCBJIHRoaW5rIGl0IHdvdWxk
IGJlCj4gY2xlYW5lciB0byBhZGQgbmV3IGhlYWRlcnMgdGhhdCBtYXRjaCB0aGUgLmMgZmlsZXMg
dGhhdCBkZWZpbmUgdGhlbS4KPiBFLmcuLCBhZGQgZXZlcmdyZWVuLmggYW5kIHB1dCBhbGwgdGhl
IHN0dWZmIGZyb20gZXZlcmdyZWVuLmMgaW4gdGhlcmUuCj4gQWRkIHJ2NzcwLmggYW5kIGFkZCBh
bGwgdGhlIHN0dWZmIGRlZmluZWQgaW4gcnY3NzAuYywgZXRjLgoKVGhpcyB3YXMgbXkgb3JpZ2lu
YWwgc29sdXRpb24sIGJ1dCBTYW0gcHVzaGVkIGJhY2suCgpQbGVhc2UgY2FuIHlvdSBkZWNpZGUg
YW1vbmdzdCB5b3Vyc2VsdmVzIHdoYXQgaXMgdGhlIGJlc3Qgd2F5IGZvcndhcmQ/CgpJIHdpbGwg
YWJpZGUgYnkgd2hhdGV2ZXIgeW91IGRlY2lkZS4KCj4gPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
Cj4gPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+ID4gQ2M6IERhdmlkIEFp
cmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiA+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gPiBDYzogSmVyb21lIEdsaXNzZSA8Z2xpc3NlQGZyZWVkZXNrdG9wLm9yZz4KPiA+
IENjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKPiA+IENjOiBsaW51eC1tZWRpYUB2
Z2VyLmtlcm5lbC5vcmcKPiA+IENjOiByZXBvcnQgdG8gPHhvcmctZHJpdmVyLWF0aUBsaXN0cy54
Lm9yZz4KPiA+IENjOiBTbGF2YSBHcmlnb3JldiA8c2xhdmEuZ3JpZ29yZXZAYW1kLmNvbT4KPiA+
IENjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgo+ID4KPiA+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBkcmktZGV2ZWwg
bWFpbGluZyBsaXN0Cj4gPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiBodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAoKLS0g
CkxlZSBKb25lcyBb5p2O55C85pavXQpTZW5pb3IgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIg
U2VydmljZXMKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0Nz
CkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
