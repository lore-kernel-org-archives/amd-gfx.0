Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B73EC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 15:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AF164EE2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 15:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AF164EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD276E5D2;
	Wed, 17 Mar 2021 15:21:13 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA616E5D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 15:21:12 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 g8-20020a9d6c480000b02901b65ca2432cso2132717otq.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=c7YbQLxKgYpIchVSXDruMFF1hfIqQOZsc01bWJch2aI=;
 b=j6ZMTgd/uC3VczzwvCdnj2oTpgxF/NRuBFtlfji/YLnd2PWnXzGJSK+Bl4JGk2/xqo
 u+wdZaiFLFueNqrOoT99EOGynwFU5fk5mzSIZ6BiVEfPNgvvrAMnHeFqKvCAarCB0bVt
 1fDnuDCmMMBQqb6NRotwfpW1jt6ep2uf3EJ/5FYO9IPjDUtwgWQHu/zlIEnkKV+C511H
 RufjBLHj92eTgSgx7O27ta3ygOHXVjiccTtnqGO+HKzrHErstFA1blOqaqT7ljnUNp3F
 9YOxGxOfm048zVsaOnQFEB3xP8qPqX+Vi++dg3Kdh7iObXdbfhCVEUCYX59X4tq1OIyO
 3nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=c7YbQLxKgYpIchVSXDruMFF1hfIqQOZsc01bWJch2aI=;
 b=DydvSx++3MIF+tpYKQiXP5ogXqYUpMzMNnKnrpSOv0/u76i6itRjKY4ysRaYv5d+oH
 n1pAFC6xHSHqmq86B/19AIMjkSPOwYq8GnZvL0eL2FN4toL1Hyfe2BgFabgTRSGqyYWh
 58mT5KmvlkRWWFvyPGliDLr8dhipE3Bb+phV8PQxOSq/GvsXil0a/JeSrHMuLSD32UsA
 +NiTa6PFL+i+y0rvEmSmm2CdwstijHnQG9tocRRHsDTLOibJV61bK5Acf9/hNAIv1d8g
 5ivq752ONHIbZB/vWbn2HI6WEViXfX6a1LhBdT7fDgFqXGUKJaW47g8MC5SYYfBH0aX/
 24QA==
X-Gm-Message-State: AOAM531UjZ47w8Ihfa+CgmHWGTRNBN/rHCi5wy+OwnC2zfDygSsHZ2at
 3F7l5G+YhqWGq2pxpJDSUdq91B8uJBdi2lgjewo=
X-Google-Smtp-Source: ABdhPJx5neWOI2sN/V2VprEo67tYCWibRihZGFWrNRY8kRsNSwRzy9rOuyKHRPIswg88ViFFDRwlHHf1Lc7lJEcw4vw=
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr3761549ota.311.1615994471710; 
 Wed, 17 Mar 2021 08:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <87wnu5eszm.wl-chenli@uniontech.com>
 <0145c9dc-26ec-8145-ff3f-44c7376ae121@gmail.com>
In-Reply-To: <0145c9dc-26ec-8145-ff3f-44c7376ae121@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Mar 2021 11:21:00 -0400
Message-ID: <CADnq5_NYtBFH6HXZFMK_tJ0G+9285+1USyDfCxphnq2RCQm_TA@mail.gmail.com>
Subject: Re: [PATCH V2] radeon: use kvcalloc for relocs and chunks
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

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCgpPbiBXZWQsIE1hciAxNywgMjAyMSBhdCAxMToxOCBB
TSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3Jv
dGU6Cj4KPiBBbSAxNy4wMy4yMSB1bSAxNTo0OCBzY2hyaWViIENoZW4gTGk6Cj4gPgo+ID4ga3Zt
YWxsb2NfYXJyYXkgKyBfX0dGUF9aRVJPIGlzIHRoZSBzYW1lIHdpdGgga3ZjYWxsb2MuCj4gPgo+
ID4gQXMgZm9yIHAtPmNodW5rcywgaXQgd2lsbCBiZSB1c2VkIGluOgo+ID4gYGBgCj4gPiBpZiAo
aWJfY2h1bmstPmtkYXRhKQo+ID4gICAgICAgICAgICAgICBtZW1jcHkocGFyc2VyLT5pYi5wdHIs
IGliX2NodW5rLT5rZGF0YSwgaWJfY2h1bmstPmxlbmd0aF9kdyAqIDQpOwo+ID4gYGBgCj4gPgo+
ID4gSWYgY2h1bmtzIGRvZXNuJ3QgemVybyBvdXQgd2l0aCBfX0dGUF9aRVJPLCBpdCBtYXkgcG9p
bnQgdG8gc29tZXdoZXJlIGVsc2UsIGUuZy4sCj4gPiBgYGAKPiA+IFVuYWJsZSB0byBoYW5kbGUg
a2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDEwMDAw
Cj4gPiAuLi4KPiA+IHBjIGlzIGF0IG1lbWNweSsweDg0LzB4MjUwCj4gPiByYSBpcyBhdCByYWRl
b25fY3NfaW9jdGwrMHgzNjgvMHhiOTAgW3JhZGVvbl0KPiA+IGBgYAo+ID4KPiA+IGFmdGVyIGFs
bG9jYXRpbmcgY2h1bmtzIHdpdGggX19HRlBfS0VSTkVML2t2Y2FsbG9jLCB0aGlzIGJ1ZyBpcyBm
aXhlZC4KPiA+IEZpeGVzOiAzZmNiNGYwMWRlZWQgKCJkcm0vcmFkZW9uOiBVc2Uga3ZtYWxsb2Mg
Zm9yIENTIGNodW5rcyIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGVuIExpIDxjaGVubGlAdW5pb250
ZWNoLmNvbT4KPgo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4KPiA+IC0tLQo+ID4KPiA+IGNoYW5nZWxvZzoKPiA+ICAgIHYxLT52Mjog
YWRkIEZpeGVzOiB0YWcKPiA+Cj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Nz
LmMgfCA2ICsrKy0tLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYwo+ID4gaW5kZXgg
ZmI3MzZlZjlmOWFhLi4wNTk0MzE2ODljMmQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9jcy5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9jcy5jCj4gPiBAQCAtOTMsOCArOTMsOCBAQCBzdGF0aWMgaW50IHJhZGVvbl9jc19wYXJz
ZXJfcmVsb2NzKHN0cnVjdCByYWRlb25fY3NfcGFyc2VyICpwKQo+ID4gICAgICAgcC0+ZG1hX3Jl
bG9jX2lkeCA9IDA7Cj4gPiAgICAgICAvKiBGSVhNRTogd2UgYXNzdW1lIHRoYXQgZWFjaCByZWxv
Y3MgdXNlIDQgZHdvcmRzICovCj4gPiAgICAgICBwLT5ucmVsb2NzID0gY2h1bmstPmxlbmd0aF9k
dyAvIDQ7Cj4gPiAtICAgICBwLT5yZWxvY3MgPSBrdm1hbGxvY19hcnJheShwLT5ucmVsb2NzLCBz
aXplb2Yoc3RydWN0IHJhZGVvbl9ib19saXN0KSwKPiA+IC0gICAgICAgICAgICAgICAgICAgICBH
RlBfS0VSTkVMIHwgX19HRlBfWkVSTyk7Cj4gPiArICAgICBwLT5yZWxvY3MgPSBrdmNhbGxvYyhw
LT5ucmVsb2NzLCBzaXplb2Yoc3RydWN0IHJhZGVvbl9ib19saXN0KSwKPiA+ICsgICAgICAgICAg
ICAgICAgICAgICBHRlBfS0VSTkVMKTsKPiA+ICAgICAgIGlmIChwLT5yZWxvY3MgPT0gTlVMTCkg
ewo+ID4gICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPiA+ICAgICAgIH0KPiA+IEBAIC0y
OTksNyArMjk5LDcgQEAgaW50IHJhZGVvbl9jc19wYXJzZXJfaW5pdChzdHJ1Y3QgcmFkZW9uX2Nz
X3BhcnNlciAqcCwgdm9pZCAqZGF0YSkKPiA+ICAgICAgIH0KPiA+ICAgICAgIHAtPmNzX2ZsYWdz
ID0gMDsKPiA+ICAgICAgIHAtPm5jaHVua3MgPSBjcy0+bnVtX2NodW5rczsKPiA+IC0gICAgIHAt
PmNodW5rcyA9IGt2bWFsbG9jX2FycmF5KHAtPm5jaHVua3MsIHNpemVvZihzdHJ1Y3QgcmFkZW9u
X2NzX2NodW5rKSwgR0ZQX0tFUk5FTCk7Cj4gPiArICAgICBwLT5jaHVua3MgPSBrdmNhbGxvYyhw
LT5uY2h1bmtzLCBzaXplb2Yoc3RydWN0IHJhZGVvbl9jc19jaHVuayksIEdGUF9LRVJORUwpOwo+
ID4gICAgICAgaWYgKHAtPmNodW5rcyA9PSBOVUxMKSB7Cj4gPiAgICAgICAgICAgICAgIHJldHVy
biAtRU5PTUVNOwo+ID4gICAgICAgfQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
