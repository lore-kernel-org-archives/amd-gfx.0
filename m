Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDE8C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 15:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433482067C
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 15:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433482067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D296E0FB;
	Mon, 11 Jan 2021 15:39:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8DD36E0F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610379562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6s22bNSoq1L+NIFn/JvX6d51nE1mLRjnfTwZ0WeTw4=;
 b=UGpgWj79HBcdJnkBtUIGCZqpsA1rgF0hz/DFMjZHuYug6vpA4KOagjokW6GGCDOnPOXy/I
 WtpLn9zvsSG9Hpw/8bhHHCQj8qrP2yO52FgTgzx5VDrtOQJQhchCugxLHDn7ImNudFdUQN
 bo0YbxhPoItwWo1XdJeas/XaIGt23fQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-Y2nnYFJeOeKlUB67JMteyg-1; Mon, 11 Jan 2021 10:39:21 -0500
X-MC-Unique: Y2nnYFJeOeKlUB67JMteyg-1
Received: by mail-il1-f200.google.com with SMTP id x15so2962344ilu.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 07:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=V6s22bNSoq1L+NIFn/JvX6d51nE1mLRjnfTwZ0WeTw4=;
 b=N/ix6zi+dj+VuKO6SS4JvuX8GEC3SAB5xEQJeTf3nuITaPeg+TNouvz7wqa8OOOV/b
 Fp2UaYaHd2CesM+D8aRxlR1dAchSysh1TnWV8sx3Lc+ZbwRGOsAaXKi2pXAKlWLT4vLi
 edUnThlkhOZBJmn/bCiTcomELl0ai+LgY4/8yM3Y17GW7Mn8sWXSZGV6gpdqoXgliQBq
 LBiQEs0UP4SdZapPSBo7OkOMzaw4YK+rtXVRZ6uOFBzHxVCTo3Y9PG8INHZ9CgCG+K4/
 O6Nu/s2VKasTxCYXI8kaXR7dzDeto9qETo+HxwiuDiL6LJBVCqr2kI5JB1d1J0vdjp0Z
 nqXg==
X-Gm-Message-State: AOAM533XHEbinmJq5FAm9XEs1CZO84Etb3KwTpPoxLCeku/7LAbTT8Oa
 z50YkNktqa1sKieBXJMpuchuAj5pMgHiTOihO1jy55ZnOBvMpwGNcauzrWhtW3aQ/T7nhKB9Kzs
 CS+qsNAVjRG9wEK3ofV67iNOMUA==
X-Received: by 2002:a92:cf44:: with SMTP id c4mr15547588ilr.207.1610379560567; 
 Mon, 11 Jan 2021 07:39:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzlggvM+nwzezd73mKCuiQILg/y8Tnj4twPqnA644Y3DXvue24trNEi0s1w98pXs6fxCdnvw==
X-Received: by 2002:a92:cf44:: with SMTP id c4mr15547567ilr.207.1610379560359; 
 Mon, 11 Jan 2021 07:39:20 -0800 (PST)
Received: from xps13 ([2605:a601:a63a:4d01:c3c1:7008:ba35:96])
 by smtp.gmail.com with ESMTPSA id t2sm16862182ili.31.2021.01.11.07.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 07:39:19 -0800 (PST)
Date: Mon, 11 Jan 2021 10:39:17 -0500
From: Jeremy Cline <jcline@redhat.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH] amdgpu: Avoid sleeping during FPU critical sections
Message-ID: <20210111153917.GA22594@xps13>
References: <20210108215838.470637-1-jcline@redhat.com>
 <3c94f9d6-501d-271c-ca83-1cf4229cb3ab@amd.com>
MIME-Version: 1.0
In-Reply-To: <3c94f9d6-501d-271c-ca83-1cf4229cb3ab@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jcline@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Cc: Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Timothy Pearson <tpearson@raptorengineering.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGksCgpPbiBNb24sIEphbiAxMSwgMjAyMSBhdCAwOTo1Mzo1NkFNICswMTAwLCBDaHJpc3RpYW4g
S8O2bmlnIHdyb3RlOgo+IEFtIDA4LjAxLjIxIHVtIDIyOjU4IHNjaHJpZWIgSmVyZW15IENsaW5l
Ogo+ID4gZGNuMjBfcmVzb3VyY2VfY29uc3RydWN0KCkgaW5jbHVkZXMgYSBudW1iZXIgb2Yga3ph
bGxvYyhHRlBfS0VSTkVMKQo+ID4gY2FsbHMgd2hpY2ggY2FuIHNsZWVwLCBidXQga2VybmVsX2Zw
dV9iZWdpbigpIGRpc2FibGVzIHByZWVtcHRpb24gYW5kCj4gPiBzbGVlcGluZyBpbiB0aGlzIGNv
bnRleHQgaXMgaW52YWxpZC4KPiA+IAo+ID4gVGhlIG9ubHkgcGxhY2VzIHRoZSBGUFUgYXBwZWFy
cyB0byBiZSByZXF1aXJlZCBpcyBpbiB0aGUKPiA+IGluaXRfc29jX2JvdW5kaW5nX2JveCgpIGZ1
bmN0aW9uIGFuZCB3aGVuIGNhbGN1bGF0aW5nIHRoZQo+ID4ge21pbixtYXh9X2ZpbGxfY2xrX21o
ei4gTmFycm93IHRoZSBzY29wZSB0byBqdXN0IHRoZXNlIHR3byBwYXJ0cyB0bwo+ID4gYXZvaWQg
c2xlZXBpbmcgd2hpbGUgdXNpbmcgdGhlIEZQVS4KPiA+IAo+ID4gRml4ZXM6IDdhOGEzNDMwYmUx
NSAoImFtZGdwdTogV3JhcCBGUFUgZGVwZW5kZW50IGZ1bmN0aW9ucyBpbiBkYzIwIikKPiA+IENj
OiBUaW1vdGh5IFBlYXJzb24gPHRwZWFyc29uQHJhcHRvcmVuZ2luZWVyaW5nLmNvbT4KPiA+IFNp
Z25lZC1vZmYtYnk6IEplcmVteSBDbGluZSA8amNsaW5lQHJlZGhhdC5jb20+Cj4gCj4gR29vZCBj
YXRjaCwgYnV0IEkgd291bGQgcmF0aGVyIHJlcGxhY2UgdGhlIGt6YWxsb2MoR0ZQX0tFUk5FTCkg
d2l0aCBhCj4ga3phbGxvYyhHRlBfQVRPTUlDKSBmb3Igbm93Lgo+IAo+IFdlIGhhdmUgdG9ucyBv
ZiBwcm9ibGVtcyB3aXRoIHRoaXMgRENfRlBfU1RBUlQoKS9EQ19GUF9FTkQoKSBhbm5vdGF0aW9u
cyBhbmQKPiBhcmUgZXZlbiBpbiB0aGUgcHJvY2VzcyBvZiBtb3ZpbmcgdGhlbSBvdXQgb2YgdGhl
IGZpbGUgYmVjYXVzZSB0aGUgY29tcGlsZXMKPiB0ZW5kIHRvIGNsdXR0ZXIgRlAgcmVnaXN0ZXJz
IGV2ZW4gb3V0c2lkZSBvZiB0aGUgYW5ub3RhdGVkIHJhbmdlcyBvbiBzb21lCj4gYXJjaGl0ZWN0
dXJlcy4KPiAKClRoYW5rcyBmb3IgdGhlIHJldmlldy4gSXMgaXQgYWNjZXB0YWJsZSB0byBtb3Zl
IHRoZSBEQ19GUF9FTkQoKQphbm5vdGF0aW9uIHVwIHRvIHRoZSBsYXN0IHVzYWdlPyBLZWVwaW5n
IGl0IHdoZXJlIGl0IGlzIGlzIHByb2JhYmx5CmRvLWFibGUsIGJ1dCBjb3ZlcnMgdGhpbmdzIGxp
a2UgY2FsbHMgdG8gcmVzb3VyY2VfY29uc3RydWN0KCkgd2hpY2gKbWFrZXMgdXNlIG9mIHN0cnVj
dCByZXNvdXJjZV9jcmVhdGVfZnVuY3MuIEknbSBndWVzc2luZyBvbmx5IGEgc3ViLXNldApvZiB0
aGUgaW1wbGVtZW50YXRpb25zIGFyZSBjYWxsZWQgdmlhIHRoaXMgZnVuY3Rpb24sIGJ1dCBoYXZp
bmcgYW4KaW50ZXJmYWNlIHdoaWNoIGNhbid0IHNsZWVwIHNvbWV0aW1lcyBkb2Vzbid0IHNvdW5k
IGFwcGVhbGluZy4KCkhhcHB5IHRvIGRvIGl0LCBidXQgYmVmb3JlIEkgZ28gZG93biB0aGF0IHJv
YWQgSSBqdXN0IHdhbnRlZCB0byBtYWtlCnN1cmUgdGhhdCdzIHdoYXQgeW91IGhhZCBpbiBtaW5k
LgoKVGhhbmtzLApKZXJlbXkKCj4gPiAtLS0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgfCA4ICsrKystLS0tCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2Uu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5j
Cj4gPiBpbmRleCBlMDRlY2YwZmMwZGIuLmE0ZmE1YmYwMTZjMSAxMDA2NDQKPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2Uu
Ywo+ID4gQEAgLTM2MjIsNiArMzYyMiw3IEBAIHN0YXRpYyBib29sIGluaXRfc29jX2JvdW5kaW5n
X2JveChzdHJ1Y3QgZGMgKmRjLAo+ID4gICAJaWYgKGJiICYmIEFTSUNSRVZfSVNfTkFWSTEyX1Ao
ZGMtPmN0eC0+YXNpY19pZC5od19pbnRlcm5hbF9yZXYpKSB7Cj4gPiAgIAkJaW50IGk7Cj4gPiAr
CQlEQ19GUF9TVEFSVCgpOwo+ID4gICAJCWRjbjJfMF9udjEyX3NvYy5zcl9leGl0X3RpbWVfdXMg
PQo+ID4gICAJCQkJZml4ZWQxNl90b19kb3VibGVfdG9fY3B1KGJiLT5zcl9leGl0X3RpbWVfdXMp
Owo+ID4gICAJCWRjbjJfMF9udjEyX3NvYy5zcl9lbnRlcl9wbHVzX2V4aXRfdGltZV91cyA9Cj4g
PiBAQCAtMzcyMSw2ICszNzIyLDcgQEAgc3RhdGljIGJvb2wgaW5pdF9zb2NfYm91bmRpbmdfYm94
KHN0cnVjdCBkYyAqZGMsCj4gPiAgIAkJCWRjbjJfMF9udjEyX3NvYy5jbG9ja19saW1pdHNbaV0u
ZHJhbV9zcGVlZF9tdHMgPQo+ID4gICAJCQkJCWZpeGVkMTZfdG9fZG91YmxlX3RvX2NwdShiYi0+
Y2xvY2tfbGltaXRzW2ldLmRyYW1fc3BlZWRfbXRzKTsKPiA+ICAgCQl9Cj4gPiArCQlEQ19GUF9F
TkQoKTsKPiA+ICAgCX0KPiA+ICAgCWlmIChwb29sLT5iYXNlLnBwX3NtdSkgewo+ID4gQEAgLTM3
NzcsOCArMzc3OSw2IEBAIHN0YXRpYyBib29sIGRjbjIwX3Jlc291cmNlX2NvbnN0cnVjdCgKPiA+
ICAgCWVudW0gZG1sX3Byb2plY3QgZG1sX3Byb2plY3RfdmVyc2lvbiA9Cj4gPiAgIAkJCWdldF9k
bWxfcHJvamVjdF92ZXJzaW9uKGN0eC0+YXNpY19pZC5od19pbnRlcm5hbF9yZXYpOwo+ID4gLQlE
Q19GUF9TVEFSVCgpOwo+ID4gLQo+ID4gICAJY3R4LT5kY19iaW9zLT5yZWdzID0gJmJpb3NfcmVn
czsKPiA+ICAgCXBvb2wtPmJhc2UuZnVuY3MgPSAmZGNuMjBfcmVzX3Bvb2xfZnVuY3M7Cj4gPiBA
QCAtMzk1OSw4ICszOTU5LDEwIEBAIHN0YXRpYyBib29sIGRjbjIwX3Jlc291cmNlX2NvbnN0cnVj
dCgKPiA+ICAgCQkJCXJhbmdlcy5yZWFkZXJfd21fc2V0c1tpXS53bV9pbnN0ID0gaTsKPiA+ICAg
CQkJCXJhbmdlcy5yZWFkZXJfd21fc2V0c1tpXS5taW5fZHJhaW5fY2xrX21oeiA9IFBQX1NNVV9X
TV9TRVRfUkFOR0VfQ0xLX1VOQ09OU1RSQUlORURfTUlOOwo+ID4gICAJCQkJcmFuZ2VzLnJlYWRl
cl93bV9zZXRzW2ldLm1heF9kcmFpbl9jbGtfbWh6ID0gUFBfU01VX1dNX1NFVF9SQU5HRV9DTEtf
VU5DT05TVFJBSU5FRF9NQVg7Cj4gPiArCQkJCURDX0ZQX1NUQVJUKCk7Cj4gPiAgIAkJCQlyYW5n
ZXMucmVhZGVyX3dtX3NldHNbaV0ubWluX2ZpbGxfY2xrX21oeiA9IChpID4gMCkgPyAobG9hZGVk
X2JiLT5jbG9ja19saW1pdHNbaSAtIDFdLmRyYW1fc3BlZWRfbXRzIC8gMTYpICsgMSA6IDA7Cj4g
PiAgIAkJCQlyYW5nZXMucmVhZGVyX3dtX3NldHNbaV0ubWF4X2ZpbGxfY2xrX21oeiA9IGxvYWRl
ZF9iYi0+Y2xvY2tfbGltaXRzW2ldLmRyYW1fc3BlZWRfbXRzIC8gMTY7Cj4gPiArCQkJCURDX0ZQ
X0VORCgpOwo+ID4gICAJCQkJcmFuZ2VzLm51bV9yZWFkZXJfd21fc2V0cyA9IGkgKyAxOwo+ID4g
ICAJCQl9Cj4gPiBAQCAtNDEyNSwxMiArNDEyNywxMCBAQCBzdGF0aWMgYm9vbCBkY24yMF9yZXNv
dXJjZV9jb25zdHJ1Y3QoCj4gPiAgIAkJcG9vbC0+YmFzZS5vZW1fZGV2aWNlID0gTlVMTDsKPiA+
ICAgCX0KPiA+IC0JRENfRlBfRU5EKCk7Cj4gPiAgIAlyZXR1cm4gdHJ1ZTsKPiA+ICAgY3JlYXRl
X2ZhaWw6Cj4gPiAtCURDX0ZQX0VORCgpOwo+ID4gICAJZGNuMjBfcmVzb3VyY2VfZGVzdHJ1Y3Qo
cG9vbCk7Cj4gPiAgIAlyZXR1cm4gZmFsc2U7Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
