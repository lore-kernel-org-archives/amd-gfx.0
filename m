Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2C0C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 19:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED60D24673
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 19:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED60D24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87836FA83;
	Fri,  6 Dec 2019 19:24:19 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27F806FA81
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 19:24:18 +0000 (UTC)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-hxcoUmv8MT2jZr0yy3C3Tw-1; Fri, 06 Dec 2019 14:24:14 -0500
Received: by mail-qt1-f200.google.com with SMTP id d9so5715997qtq.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2019 11:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=S8lr3mwGxXhI82WmKp3XKXy3xSh21+B3Dvk4LNThQO0=;
 b=Li14PLka8WY35osIgtTt19okCFZAqvJ4udlfpaBezzsEbWFEErxgRVUKhq7KJRxBM3
 TmLbxxNQwnsXC6iOIKn4INDj65zxk2WBfGVC9c758oJUaPaauTMUsOb2SNIEN5IlN6eE
 0cliO8N4FDFSyx5baPgGriyKl3KssY/d6ePJO8chLHRu8VIr9YKO9xnjTU2OCgTmTH7z
 UuKDGbKKVFf/VrPH0Hz9YmN/9ZP3B03VmT+kvaylvkWZWMm1AmgwoSLTsxDMRyfzWyBF
 0YxVsWkl/xE3M15e3sE35VQ1GIQvvG97wWclIip8EL6UwYRYhmloqMK9dCIeN9IBwj5M
 suSQ==
X-Gm-Message-State: APjAAAXkCuoZ7nT7AjPFk8lAsoy0hSHu9GjW0f76q9pbvRlN5M98Mxn5
 58SGYAI2KyqIeoEbwhO/D7StQ5QyAvPIYn2xobixny860GZyYOZbb7HFiaWpOEFJGmz3LXENcGS
 X5EjMHABYRM4Fdpw69Pg+yCYJPw==
X-Received: by 2002:ac8:67cb:: with SMTP id r11mr13999612qtp.54.1575660253730; 
 Fri, 06 Dec 2019 11:24:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwX3PjTHrOow2vN7EK2A8jxrFjf0XyZzUwkotrX3+LAqSHG3uRAB0KHOmew9nARPynN51H3Ug==
X-Received: by 2002:ac8:67cb:: with SMTP id r11mr13999592qtp.54.1575660253395; 
 Fri, 06 Dec 2019 11:24:13 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id 17sm6285222qkk.81.2019.12.06.11.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2019 11:24:12 -0800 (PST)
Message-ID: <a6c4db964da7e00a6069d40abcb3aa887ef5522b.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp_mst: Remove VCPI while disabling topology mgr
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Date: Fri, 06 Dec 2019 14:24:11 -0500
In-Reply-To: <20191205090043.7580-1-Wayne.Lin@amd.com>
References: <20191205090043.7580-1-Wayne.Lin@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: hxcoUmv8MT2jZr0yy3C3Tw-1
X-Mimecast-Spam-Score: 0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1575660257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8lr3mwGxXhI82WmKp3XKXy3xSh21+B3Dvk4LNThQO0=;
 b=i6eGPlospQys+5S2slAlqYJxmfxP2CXVIQW7Qedv3kflxajH8f21F60rBQSuKRz7S673Gw
 Q77m4+3EaHtmHVfpOPCEb+1QjEJ6qkiFhVLBupiDUNUyMkEDiPcch/m8XCGfvVPQ+1w7rk
 13VrJmDVc+xAF5lk9QLx2/mAX0lRl7w=
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

UmV2aWV3ZWQtYnk6IEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5jb20+CgpJJ2xsIGdvIGFoZWFk
IGFuZCBwdXNoIHRoaXMgdG8gZHJtLW1pc2MtbmV4dC1maXhlcyByaWdodCBub3csIHRoYW5rcyEK
Ck9uIFRodSwgMjAxOS0xMi0wNSBhdCAxNzowMCArMDgwMCwgV2F5bmUgTGluIHdyb3RlOgo+IFtX
aHldCj4gCj4gVGhpcyBwYXRjaCBpcyB0cnlpbmcgdG8gYWRkcmVzcyB0aGUgaXNzdWUgb2JzZXJ2
ZWQgd2hlbiBob3RwbHVnIERQCj4gZGFpc3kgY2hhaW4gbW9uaXRvcnMuCj4gCj4gZS5nLgo+IHNy
Yy1tc3RiLW1zdGItc3N0IC0+IHNyYyAodW5wbHVnKSBtc3RiLW1zdGItc3N0IC0+IHNyYy1tc3Ri
LW1zdGItc3N0Cj4gKHBsdWcgaW4gYWdhaW4pCj4gCj4gT25jZSB1bnBsdWcgYSBEUCBNU1QgY2Fw
YWJsZSBkZXZpY2UsIGRyaXZlciB3aWxsIGNhbGwKPiBkcm1fZHBfbXN0X3RvcG9sb2d5X21ncl9z
ZXRfbXN0KCkgdG8gZGlzYWJsZSBNU1QuIEluIHRoaXMgZnVuY3Rpb24sCj4gaXQgY2xlYW5zIGRh
dGEgb2YgdG9wb2xvZ3kgbWFuYWdlciB3aGlsZSBkaXNhYmxpbmcgbXN0X3N0YXRlLiBIb3dldmVy
LAo+IGl0IGRvZXNuJ3QgY2xlYW4gdXAgdGhlIHByb3Bvc2VkX3ZjcGlzIG9mIHRvcG9sb2d5IG1h
bmFnZXIuCj4gSWYgcHJvcG9zZWRfdmNwaSBpcyBub3QgcmVzZXQsIG9uY2UgcGx1ZyBpbiBNU1Qg
ZGFpc3kgY2hhaW4gbW9uaXRvcnMKPiBsYXRlciwgY29kZSB3aWxsIGZhaWwgYXQgY2hlY2tpbmcg
cG9ydCB2YWxpZGF0aW9uIHdoaWxlIHRyeWluZyB0bwo+IGFsbG9jYXRlIHBheWxvYWRzLgo+IAo+
IFdoZW4gTVNUIGNhcGFibGUgZGV2aWNlIGlzIHBsdWdnZWQgaW4gYWdhaW4gYW5kIHRyeSB0byBh
bGxvY2F0ZQo+IHBheWxvYWRzIGJ5IGNhbGxpbmcgZHJtX2RwX3VwZGF0ZV9wYXlsb2FkX3BhcnQx
KCksIHRoaXMKPiBmdW5jdGlvbiB3aWxsIGl0ZXJhdGUgb3ZlciBhbGwgcHJvcG9zZWQgdmlydHVh
bCBjaGFubmVscyB0byBzZWUgaWYKPiBhbnkgcHJvcG9zZWQgVkNQSSdzIG51bV9zbG90cyBpcyBn
cmVhdGVyIHRoYW4gMC4gSWYgYW55IHByb3Bvc2VkCj4gVkNQSSdzIG51bV9zbG90cyBpcyBncmVh
dGVyIHRoYW4gMCBhbmQgdGhlIHBvcnQgd2hpY2ggdGhlCj4gc3BlY2lmaWMgdmlydHVhbCBjaGFu
bmVsIGRpcmVjdGVkIHRvIGlzIG5vdCBpbiB0aGUgdG9wb2xvZ3ksIGNvZGUgdGhlbgo+IGZhaWxz
IGF0IHRoZSBwb3J0IHZhbGlkYXRpb24uIFNpbmNlIHRoZXJlIGFyZSBzdGFsZSBWQ1BJIGFsbG9j
YXRpb25zCj4gZnJvbSB0aGUgcHJldmlvdXMgdG9wb2xvZ3kgZW5hYmxlbWVudCBpbiBwcm9wb3Nl
ZF92Y3BpW10sIGNvZGUgd2lsbCBmYWlsCj4gYXQgcG9ydCB2YWxpZGF0aW9uIGFuZCByZXVybiBF
SU5WQUwuCj4gCj4gW0hvd10KPiAKPiBDbGVhbiB1cCB0aGUgZGF0YSBvZiBzdGFsZSBwcm9wb3Nl
ZF92Y3BpW10gYW5kIHJlc2V0IG1nci0+cHJvcG9zZWRfdmNwaXMKPiB0byBOVUxMIHdoaWxlIGRp
c2FibGluZyBtc3QgaW4gZHJtX2RwX21zdF90b3BvbG9neV9tZ3Jfc2V0X21zdCgpLgo+IAo+IENo
YW5nZXMgc2luY2UgdjE6Cj4gKkFkZCBvbiBtb3JlIGRldGFpbHMgaW4gY29tbWl0IG1lc3NhZ2Ug
dG8gZGVzY3JpYmUgdGhlIGlzc3VlIHdoaWNoIHRoZSAKPiBwYXRjaCBpcyB0cnlpbmcgdG8gZml4
Cj4gCj4gU2lnbmVkLW9mZi1ieTogV2F5bmUgTGluIDxXYXluZS5MaW5AYW1kLmNvbT4KPiAtLS0K
PiAgZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYyB8IDEyICsrKysrKysrKysr
Kwo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jCj4gYi9kcml2ZXJzL2dwdS9kcm0v
ZHJtX2RwX21zdF90b3BvbG9neS5jCj4gaW5kZXggYWU1ODA5YTFmMTlhLi5iZjRmNzQ1YTRlZGIg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMKPiBAQCAtMzM4Niw2ICsz
Mzg2LDcgQEAgc3RhdGljIGludCBkcm1fZHBfZ2V0X3ZjX3BheWxvYWRfYncodTggZHBfbGlua19i
dywKPiB1OCAgZHBfbGlua19jb3VudCkKPiAgaW50IGRybV9kcF9tc3RfdG9wb2xvZ3lfbWdyX3Nl
dF9tc3Qoc3RydWN0IGRybV9kcF9tc3RfdG9wb2xvZ3lfbWdyICptZ3IsCj4gYm9vbCBtc3Rfc3Rh
dGUpCj4gIHsKPiAgCWludCByZXQgPSAwOwo+ICsJaW50IGkgPSAwOwo+ICAJc3RydWN0IGRybV9k
cF9tc3RfYnJhbmNoICptc3RiID0gTlVMTDsKPiAgCj4gIAltdXRleF9sb2NrKCZtZ3ItPmxvY2sp
Owo+IEBAIC0zNDQ2LDEwICszNDQ3LDIxIEBAIGludCBkcm1fZHBfbXN0X3RvcG9sb2d5X21ncl9z
ZXRfbXN0KHN0cnVjdAo+IGRybV9kcF9tc3RfdG9wb2xvZ3lfbWdyICptZ3IsIGJvb2wgbXMKPiAg
CQkvKiB0aGlzIGNhbiBmYWlsIGlmIHRoZSBkZXZpY2UgaXMgZ29uZSAqLwo+ICAJCWRybV9kcF9k
cGNkX3dyaXRlYihtZ3ItPmF1eCwgRFBfTVNUTV9DVFJMLCAwKTsKPiAgCQlyZXQgPSAwOwo+ICsJ
CW11dGV4X2xvY2soJm1nci0+cGF5bG9hZF9sb2NrKTsKPiAgCQltZW1zZXQobWdyLT5wYXlsb2Fk
cywgMCwgbWdyLT5tYXhfcGF5bG9hZHMgKiBzaXplb2Yoc3RydWN0Cj4gZHJtX2RwX3BheWxvYWQp
KTsKPiAgCQltZ3ItPnBheWxvYWRfbWFzayA9IDA7Cj4gIAkJc2V0X2JpdCgwLCAmbWdyLT5wYXls
b2FkX21hc2spOwo+ICsJCWZvciAoaSA9IDA7IGkgPCBtZ3ItPm1heF9wYXlsb2FkczsgaSsrKSB7
Cj4gKwkJCXN0cnVjdCBkcm1fZHBfdmNwaSAqdmNwaSA9IG1nci0+cHJvcG9zZWRfdmNwaXNbaV07
Cj4gKwo+ICsJCQlpZiAodmNwaSkgewo+ICsJCQkJdmNwaS0+dmNwaSA9IDA7Cj4gKwkJCQl2Y3Bp
LT5udW1fc2xvdHMgPSAwOwo+ICsJCQl9Cj4gKwkJCW1nci0+cHJvcG9zZWRfdmNwaXNbaV0gPSBO
VUxMOwo+ICsJCX0KPiAgCQltZ3ItPnZjcGlfbWFzayA9IDA7Cj4gKwkJbXV0ZXhfdW5sb2NrKCZt
Z3ItPnBheWxvYWRfbG9jayk7Cj4gIAl9Cj4gIAo+ICBvdXRfdW5sb2NrOgotLSAKQ2hlZXJzLAoJ
THl1ZGUgUGF1bAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
