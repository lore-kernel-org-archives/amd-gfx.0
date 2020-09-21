Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADFBC4363C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 19:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6545A2193E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 19:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6FPH/bX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6545A2193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6656E56D;
	Mon, 21 Sep 2020 19:55:27 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2EC56E563;
 Mon, 21 Sep 2020 19:55:12 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id e17so688359wme.0;
 Mon, 21 Sep 2020 12:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YnHM6Hb2y75zAmIL8oMRMNOuTr0UGFyFVBu7fGiSews=;
 b=p6FPH/bXd02fVePtnRBJz3I1Vs4o+uGl8AUxVqGp329LcXDKk3VCkOUKY3G/kkIwtm
 YUgnsCOjAv+E1XErdswu98/iRlqOni8BJyXmyFKLOSCAZuWbBvDo+nlrhcrdSju/el56
 KdNQPfu3WsQ7Iv6ki9szDXn51b1CU2ZJhA//wUd+jeaBb5URBSMRk3k/F3WEbX4c3cYA
 RYdXPuj87JW6/RPe0xxa+3sfNf+iHaGdPgqQUt86/QnRXzVFMX9DltQFNLgdM+byistd
 huKGd258rIEXAmf3fIuhrCtS34bcMMGf30hnGmAgqiYZo7/yyug5WUMH2r3EXvmi5Vhu
 +fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YnHM6Hb2y75zAmIL8oMRMNOuTr0UGFyFVBu7fGiSews=;
 b=kIGlqGUsfrev0RVDDjXy5GJzHWdpgGvzjhT9cXhGsTJk2be52iln8sHr4tempReN7T
 kWjN1LYqSr5OA5JL9p19q947qdCFMHDEvFU3JAJ1skSUZJUZESqCKRdkQxqHsqbp3jiv
 9EbkDozY963CHeaLKzd05aQBTPIfbf1MTlGiPw7rdr3TleNRWVa70xFgwj5hSIXjWGcY
 JfqLFxjoXA0JykvsQ0InQtntfwEXJXLTtkuqKwK8g14Ou/ly5deDN/rUCGHCwCPHwZWe
 igjHJKQMQk3MwS3x9pX8tnFKLd62qkzZV14czK3zydGs9ZFOwd/GURusEWbGwCBnOh1x
 A8jA==
X-Gm-Message-State: AOAM531bVDglbwZEA9UqirRhRaPn4p9kFr6ePDhNnOXep9veoub6ssOj
 QC8ILdH8+UQMySdM41hY7vkQUJ7B3hiv+IPjMKs=
X-Google-Smtp-Source: ABdhPJwZgwV6vkAAjowteBj5ihZxbhwD17IBcHMtzvMBYdjNxn4Ob2SIcxa+cIei8JjO78UQaTrO9VPBs6T/VC7upMk=
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr912983wmc.73.1600718111467;
 Mon, 21 Sep 2020 12:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200915071820.76620-1-sudheesh.mavila@amd.com>
 <888285ed-62e9-53d7-7fde-e40ac64bc5a4@amd.com>
In-Reply-To: <888285ed-62e9-53d7-7fde-e40ac64bc5a4@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2020 15:55:00 -0400
Message-ID: <CADnq5_NWnMraD_WPoms0G-bqmNxf7tN86h34Dm1Z+6ZTeqqzNg@mail.gmail.com>
Subject: Re: [PATCH v1 ] drm/amd/pm: Removed fixed clock in auto mode DPM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Tom St Denis <tom.stdenis@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
 Jason Yan <yanaijie@huawei.com>, Dave Airlie <airlied@linux.ie>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, zhengbin <zhengbin13@huawei.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Sudheesh Mavila <sudheesh.mavila@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZCB3aXRoIGZpeGVkIHVwIHdoaXRlc3BhY2UuCgpUaGFua3MsCgpBbGV4CgpPbiBUdWUs
IFNlcCAxNSwgMjAyMCBhdCAzOjQ1IEFNIENocmlzdGlhbiBLw7ZuaWcKPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAxNS4wOS4yMCB1bSAwOToxOCBzY2hyaWViIFN1ZGhl
ZXNoIE1hdmlsYToKPiA+ICAgICAgU01VMTBfVU1EX1BTVEFURV9QRUFLX0ZDTEsgdmFsdWUgc2hv
dWxkIG5vdCBiZSB1c2VkIHRvIHNldCB0aGUgRFBNLgo+ID4KPiA+ICAgICAgQ2hhbmdlICBzdWdn
ZXN0ZWQgYnkgRXZhbi5RdWFuQGFtZC5jb20KPgo+IENhbid0IHNheSBtdWNoIGFib3V0IHRoZSBj
aGFuZ2UgaXRzZWxmLCBidXQgdGhlIENvbW1pdCBtZXNzYWdlIGlzCj4gaW5kZW50ZWQgYW5kIHRo
ZSBpbmRlbnRhdGlvbiBpbiB0aGUgY29kZSBkb2Vzbid0IGxvb2sgY29uc2lzdGVudCBlaXRoZXIu
Cj4KPiBDaHJpc3RpYW4uCj4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTdWRoZWVzaCBNYXZpbGEg
PHN1ZGhlZXNoLm1hdmlsYUBhbWQuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmMgfCAxMCArKysrKystLS0tCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdy
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5jCj4g
PiBpbmRleCBjOWNmZTkwYTI5NDcuLjA4MWNiOWIxYjdjOCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmMKPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmMKPiA+IEBAIC01
NjYsNiArNTY2LDggQEAgc3RhdGljIGludCBzbXUxMF9kcG1fZm9yY2VfZHBtX2xldmVsKHN0cnVj
dCBwcF9od21nciAqaHdtZ3IsCj4gPiAgICAgICBzdHJ1Y3Qgc211MTBfaHdtZ3IgKmRhdGEgPSBo
d21nci0+YmFja2VuZDsKPiA+ICAgICAgIHVpbnQzMl90IG1pbl9zY2xrID0gaHdtZ3ItPmRpc3Bs
YXlfY29uZmlnLT5taW5fY29yZV9zZXRfY2xvY2s7Cj4gPiAgICAgICB1aW50MzJfdCBtaW5fbWNs
ayA9IGh3bWdyLT5kaXNwbGF5X2NvbmZpZy0+bWluX21lbV9zZXRfY2xvY2svMTAwOwo+ID4gKyAg
ICAgdWludDMyX3QgaW5kZXhfZmNsayA9IGRhdGEtPmNsb2NrX3ZvbF9pbmZvLnZkZF9kZXBfb25f
ZmNsay0+Y291bnQgLSAxOwo+ID4gKyAgICAgdWludDMyX3QgaW5kZXhfc29jY2xrID0gZGF0YS0+
Y2xvY2tfdm9sX2luZm8udmRkX2RlcF9vbl9zb2NjbGstPmNvdW50IC0gMTsKPiA+Cj4gPiAgICAg
ICBpZiAoaHdtZ3ItPnNtdV92ZXJzaW9uIDwgMHgxRTM3MDApIHsKPiA+ICAgICAgICAgICAgICAg
cHJfaW5mbygic211IGZpcm13YXJlIHZlcnNpb24gdG9vIG9sZCwgY2FuIG5vdCBzZXQgZHBtIGxl
dmVsXG4iKTsKPiA+IEBAIC02NzksMTMgKzY4MSwxMyBAQCBzdGF0aWMgaW50IHNtdTEwX2RwbV9m
b3JjZV9kcG1fbGV2ZWwoc3RydWN0IHBwX2h3bWdyICpod21nciwKPiA+ICAgICAgICAgICAgICAg
c211bV9zZW5kX21zZ190b19zbWNfd2l0aF9wYXJhbWV0ZXIoaHdtZ3IsCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUFBTTUNfTVNHX1NldEhhcmRNaW5G
Y2xrQnlGcmVxLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGh3bWdyLT5kaXNwbGF5X2NvbmZpZy0+bnVtX2Rpc3BsYXkgPiAzID8KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTTVUxMF9VTURfUFNUQVRFX1BF
QUtfRkNMSyA6Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGEt
PmNsb2NrX3ZvbF9pbmZvLnZkZF9kZXBfb25fZmNsay0+ZW50cmllc1swXS5jbGsgOgo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1pbl9tY2xrLAo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwpOwo+ID4K
PiA+ICAgICAgICAgICAgICAgc211bV9zZW5kX21zZ190b19zbWNfd2l0aF9wYXJhbWV0ZXIoaHdt
Z3IsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUFBT
TUNfTVNHX1NldEhhcmRNaW5Tb2NjbGtCeUZyZXEsCj4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgU01VMTBfVU1EX1BTVEFURV9NSU5fU09DQ0xLLAo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYXRhLT5jbG9ja192b2xfaW5m
by52ZGRfZGVwX29uX3NvY2Nsay0+ZW50cmllc1swXS5jbGssCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7Cj4gPiAgICAgICAgICAgICAgIHNt
dW1fc2VuZF9tc2dfdG9fc21jX3dpdGhfcGFyYW1ldGVyKGh3bWdyLAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBQU01DX01TR19TZXRIYXJkTWluVmNu
LAo+ID4gQEAgLTY5OCwxMSArNzAwLDExIEBAIHN0YXRpYyBpbnQgc211MTBfZHBtX2ZvcmNlX2Rw
bV9sZXZlbChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwpOwo+ID4gICAgICAgICAgICAgICBzbXVtX3Nl
bmRfbXNnX3RvX3NtY193aXRoX3BhcmFtZXRlcihod21nciwKPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQUFNNQ19NU0dfU2V0U29mdE1heEZjbGtCeUZy
ZXEsCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU01V
MTBfVU1EX1BTVEFURV9QRUFLX0ZDTEssCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBkYXRhLT5jbG9ja192b2xfaW5mby52ZGRfZGVwX29uX2ZjbGstPmVudHJpZXNbaW5kZXhfZmNs
a10uY2xrLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IE5VTEwpOwo+ID4gICAgICAgICAgICAgICBzbXVtX3NlbmRfbXNnX3RvX3NtY193aXRoX3BhcmFt
ZXRlcihod21nciwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBQUFNNQ19NU0dfU2V0U29mdE1heFNvY2Nsa0J5RnJlcSwKPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTTVUxMF9VTURfUFNUQVRFX1BFQUtfU09D
Q0xLLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YS0+Y2xvY2tfdm9sX2lu
Zm8udmRkX2RlcF9vbl9zb2NjbGstPmVudHJpZXNbaW5kZXhfc29jY2xrXS5jbGssCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7Cj4gPiAgICAg
ICAgICAgICAgIHNtdW1fc2VuZF9tc2dfdG9fc21jX3dpdGhfcGFyYW1ldGVyKGh3bWdyLAo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBQU01DX01TR19T
ZXRTb2Z0TWF4VmNuLAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
