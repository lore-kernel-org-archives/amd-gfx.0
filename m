Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A4C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 19:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2EB24677
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 19:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2EB24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675F56FA88;
	Fri,  6 Dec 2019 19:57:08 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71C286FA89
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 19:57:07 +0000 (UTC)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-3uCBw1sqNjasLJVQ0u4qAg-1; Fri, 06 Dec 2019 14:57:04 -0500
Received: by mail-qv1-f69.google.com with SMTP id d12so520447qvj.16
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2019 11:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=mnbiz0aMko2Xu1mk9CJ3thPybxK/sVkyzXNX584wmt4=;
 b=Lix0j/Z2q1MdoBND1pg7+cAzy42H2GUkj+rwyXV2XFyXRM70O6Zl24NG1j6gq8nhl1
 6gj2xuTs13GeMz1HRtf1qZN9YImpwXzBNQ1wYXYET4Gi8Ta5TsJzmtIcmJNS1fSkfv2U
 berZiqRuO9EJwqYWIScE4v2kTjNSMEi2sMlX0ESAL7pYNmZgwYBaq1WqRHop0W9UqJi6
 nSE2leDCvynoduN5lOEbTYha6qYQP39HmXBDTuLOpr+eL6oWP4kNMusFOR3aNmoZzuB1
 PgkBZ1s0XxM1ulfmZast4IQt9D88HoxsSPsG9MJ9FoXj4hEo6aSJ9GuexrGrTnZbySRN
 yoFQ==
X-Gm-Message-State: APjAAAUtKIt0038N3aSwXqP5peBm8VB4EubCWNfGiofVeZzh5owvBEE5
 hd52bfhB6qPEpZXEeDJjTmrIXx/FZGgGJ7Z3Y0D+xtTgnh7YG3WKV5BU9OaXDas9b/BxZixkfYF
 SGPcTjFNQ2ngGfGYmLF7bKyx5Lw==
X-Received: by 2002:ac8:3f02:: with SMTP id c2mr14601018qtk.172.1575662224121; 
 Fri, 06 Dec 2019 11:57:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZt1ynXXvg1Q6Rg+BR8GgD1VE8dpn6UFzBpg+ntd8RuIsVWUlvn6Ns5zhUOQlFwasVOuMgqg==
X-Received: by 2002:ac8:3f02:: with SMTP id c2mr14600998qtk.172.1575662223931; 
 Fri, 06 Dec 2019 11:57:03 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id u12sm6896518qta.79.2019.12.06.11.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2019 11:57:03 -0800 (PST)
Message-ID: <ec3e020798d99ce638c05b0f3eb00ebf53c3bd7c.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp_mst: Remove VCPI while disabling topology mgr
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Date: Fri, 06 Dec 2019 14:57:01 -0500
In-Reply-To: <a6c4db964da7e00a6069d40abcb3aa887ef5522b.camel@redhat.com>
References: <20191205090043.7580-1-Wayne.Lin@amd.com>
 <a6c4db964da7e00a6069d40abcb3aa887ef5522b.camel@redhat.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: 3uCBw1sqNjasLJVQ0u4qAg-1
X-Mimecast-Spam-Score: 0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1575662226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnbiz0aMko2Xu1mk9CJ3thPybxK/sVkyzXNX584wmt4=;
 b=Q3XXp2hvltLqGROw5ZhzMdMy7Gsq8xnKLK9JmdcJyO2DdBfGGnuDJPYVXLvDt0myVZt+AL
 gN1UQa5/w/gNkVPlw6Ex/CWuQpNi1fXZTw+Ya+pNpnf3vTR8zmi2+9dScG1T4STNhn7UtY
 2wkZtxgITxSLo2uC5zE3fsK1GAjdP20=
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
Cc: jerry.zuo@amd.com, harry.wentland@amd.com, Nicholas.Kazlauskas@amd.com,
 stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCAyMDE5LTEyLTA2IGF0IDE0OjI0IC0wNTAwLCBMeXVkZSBQYXVsIHdyb3RlOgo+IFJl
dmlld2VkLWJ5OiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29tPgo+IAo+IEknbGwgZ28gYWhl
YWQgYW5kIHB1c2ggdGhpcyB0byBkcm0tbWlzYy1uZXh0LWZpeGVzIHJpZ2h0IG5vdywgdGhhbmtz
IQoKV2hvb3BzLW1lYW50IHRvIHNheSBkcm0tbWlzYy1uZXh0IGhlcmUsIGFueXdheSwgcHVzaGVk
IQo+IAo+IE9uIFRodSwgMjAxOS0xMi0wNSBhdCAxNzowMCArMDgwMCwgV2F5bmUgTGluIHdyb3Rl
Ogo+ID4gW1doeV0KPiA+IAo+ID4gVGhpcyBwYXRjaCBpcyB0cnlpbmcgdG8gYWRkcmVzcyB0aGUg
aXNzdWUgb2JzZXJ2ZWQgd2hlbiBob3RwbHVnIERQCj4gPiBkYWlzeSBjaGFpbiBtb25pdG9ycy4K
PiA+IAo+ID4gZS5nLgo+ID4gc3JjLW1zdGItbXN0Yi1zc3QgLT4gc3JjICh1bnBsdWcpIG1zdGIt
bXN0Yi1zc3QgLT4gc3JjLW1zdGItbXN0Yi1zc3QKPiA+IChwbHVnIGluIGFnYWluKQo+ID4gCj4g
PiBPbmNlIHVucGx1ZyBhIERQIE1TVCBjYXBhYmxlIGRldmljZSwgZHJpdmVyIHdpbGwgY2FsbAo+
ID4gZHJtX2RwX21zdF90b3BvbG9neV9tZ3Jfc2V0X21zdCgpIHRvIGRpc2FibGUgTVNULiBJbiB0
aGlzIGZ1bmN0aW9uLAo+ID4gaXQgY2xlYW5zIGRhdGEgb2YgdG9wb2xvZ3kgbWFuYWdlciB3aGls
ZSBkaXNhYmxpbmcgbXN0X3N0YXRlLiBIb3dldmVyLAo+ID4gaXQgZG9lc24ndCBjbGVhbiB1cCB0
aGUgcHJvcG9zZWRfdmNwaXMgb2YgdG9wb2xvZ3kgbWFuYWdlci4KPiA+IElmIHByb3Bvc2VkX3Zj
cGkgaXMgbm90IHJlc2V0LCBvbmNlIHBsdWcgaW4gTVNUIGRhaXN5IGNoYWluIG1vbml0b3JzCj4g
PiBsYXRlciwgY29kZSB3aWxsIGZhaWwgYXQgY2hlY2tpbmcgcG9ydCB2YWxpZGF0aW9uIHdoaWxl
IHRyeWluZyB0bwo+ID4gYWxsb2NhdGUgcGF5bG9hZHMuCj4gPiAKPiA+IFdoZW4gTVNUIGNhcGFi
bGUgZGV2aWNlIGlzIHBsdWdnZWQgaW4gYWdhaW4gYW5kIHRyeSB0byBhbGxvY2F0ZQo+ID4gcGF5
bG9hZHMgYnkgY2FsbGluZyBkcm1fZHBfdXBkYXRlX3BheWxvYWRfcGFydDEoKSwgdGhpcwo+ID4g
ZnVuY3Rpb24gd2lsbCBpdGVyYXRlIG92ZXIgYWxsIHByb3Bvc2VkIHZpcnR1YWwgY2hhbm5lbHMg
dG8gc2VlIGlmCj4gPiBhbnkgcHJvcG9zZWQgVkNQSSdzIG51bV9zbG90cyBpcyBncmVhdGVyIHRo
YW4gMC4gSWYgYW55IHByb3Bvc2VkCj4gPiBWQ1BJJ3MgbnVtX3Nsb3RzIGlzIGdyZWF0ZXIgdGhh
biAwIGFuZCB0aGUgcG9ydCB3aGljaCB0aGUKPiA+IHNwZWNpZmljIHZpcnR1YWwgY2hhbm5lbCBk
aXJlY3RlZCB0byBpcyBub3QgaW4gdGhlIHRvcG9sb2d5LCBjb2RlIHRoZW4KPiA+IGZhaWxzIGF0
IHRoZSBwb3J0IHZhbGlkYXRpb24uIFNpbmNlIHRoZXJlIGFyZSBzdGFsZSBWQ1BJIGFsbG9jYXRp
b25zCj4gPiBmcm9tIHRoZSBwcmV2aW91cyB0b3BvbG9neSBlbmFibGVtZW50IGluIHByb3Bvc2Vk
X3ZjcGlbXSwgY29kZSB3aWxsIGZhaWwKPiA+IGF0IHBvcnQgdmFsaWRhdGlvbiBhbmQgcmV1cm4g
RUlOVkFMLgo+ID4gCj4gPiBbSG93XQo+ID4gCj4gPiBDbGVhbiB1cCB0aGUgZGF0YSBvZiBzdGFs
ZSBwcm9wb3NlZF92Y3BpW10gYW5kIHJlc2V0IG1nci0+cHJvcG9zZWRfdmNwaXMKPiA+IHRvIE5V
TEwgd2hpbGUgZGlzYWJsaW5nIG1zdCBpbiBkcm1fZHBfbXN0X3RvcG9sb2d5X21ncl9zZXRfbXN0
KCkuCj4gPiAKPiA+IENoYW5nZXMgc2luY2UgdjE6Cj4gPiAqQWRkIG9uIG1vcmUgZGV0YWlscyBp
biBjb21taXQgbWVzc2FnZSB0byBkZXNjcmliZSB0aGUgaXNzdWUgd2hpY2ggdGhlIAo+ID4gcGF0
Y2ggaXMgdHJ5aW5nIHRvIGZpeAo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBXYXluZSBMaW4gPFdh
eW5lLkxpbkBhbWQuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3Rf
dG9wb2xvZ3kuYyB8IDEyICsrKysrKysrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21z
dF90b3BvbG9neS5jCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMK
PiA+IGluZGV4IGFlNTgwOWExZjE5YS4uYmY0Zjc0NWE0ZWRiIDEwMDY0NAo+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYwo+ID4gQEAgLTMzODYsNiArMzM4Niw3IEBAIHN0YXRp
YyBpbnQgZHJtX2RwX2dldF92Y19wYXlsb2FkX2J3KHU4IGRwX2xpbmtfYncsCj4gPiB1OCAgZHBf
bGlua19jb3VudCkKPiA+ICBpbnQgZHJtX2RwX21zdF90b3BvbG9neV9tZ3Jfc2V0X21zdChzdHJ1
Y3QgZHJtX2RwX21zdF90b3BvbG9neV9tZ3IgKm1nciwKPiA+IGJvb2wgbXN0X3N0YXRlKQo+ID4g
IHsKPiA+ICAJaW50IHJldCA9IDA7Cj4gPiArCWludCBpID0gMDsKPiA+ICAJc3RydWN0IGRybV9k
cF9tc3RfYnJhbmNoICptc3RiID0gTlVMTDsKPiA+ICAKPiA+ICAJbXV0ZXhfbG9jaygmbWdyLT5s
b2NrKTsKPiA+IEBAIC0zNDQ2LDEwICszNDQ3LDIxIEBAIGludCBkcm1fZHBfbXN0X3RvcG9sb2d5
X21ncl9zZXRfbXN0KHN0cnVjdAo+ID4gZHJtX2RwX21zdF90b3BvbG9neV9tZ3IgKm1nciwgYm9v
bCBtcwo+ID4gIAkJLyogdGhpcyBjYW4gZmFpbCBpZiB0aGUgZGV2aWNlIGlzIGdvbmUgKi8KPiA+
ICAJCWRybV9kcF9kcGNkX3dyaXRlYihtZ3ItPmF1eCwgRFBfTVNUTV9DVFJMLCAwKTsKPiA+ICAJ
CXJldCA9IDA7Cj4gPiArCQltdXRleF9sb2NrKCZtZ3ItPnBheWxvYWRfbG9jayk7Cj4gPiAgCQlt
ZW1zZXQobWdyLT5wYXlsb2FkcywgMCwgbWdyLT5tYXhfcGF5bG9hZHMgKiBzaXplb2Yoc3RydWN0
Cj4gPiBkcm1fZHBfcGF5bG9hZCkpOwo+ID4gIAkJbWdyLT5wYXlsb2FkX21hc2sgPSAwOwo+ID4g
IAkJc2V0X2JpdCgwLCAmbWdyLT5wYXlsb2FkX21hc2spOwo+ID4gKwkJZm9yIChpID0gMDsgaSA8
IG1nci0+bWF4X3BheWxvYWRzOyBpKyspIHsKPiA+ICsJCQlzdHJ1Y3QgZHJtX2RwX3ZjcGkgKnZj
cGkgPSBtZ3ItPnByb3Bvc2VkX3ZjcGlzW2ldOwo+ID4gKwo+ID4gKwkJCWlmICh2Y3BpKSB7Cj4g
PiArCQkJCXZjcGktPnZjcGkgPSAwOwo+ID4gKwkJCQl2Y3BpLT5udW1fc2xvdHMgPSAwOwo+ID4g
KwkJCX0KPiA+ICsJCQltZ3ItPnByb3Bvc2VkX3ZjcGlzW2ldID0gTlVMTDsKPiA+ICsJCX0KPiA+
ICAJCW1nci0+dmNwaV9tYXNrID0gMDsKPiA+ICsJCW11dGV4X3VubG9jaygmbWdyLT5wYXlsb2Fk
X2xvY2spOwo+ID4gIAl9Cj4gPiAgCj4gPiAgb3V0X3VubG9jazoKLS0gCkNoZWVycywKCUx5dWRl
IFBhdWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
