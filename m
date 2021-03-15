Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F91C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 13:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407D264EF3
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 13:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407D264EF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC412896FA;
	Mon, 15 Mar 2021 13:15:59 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09DE3896FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 13:15:59 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id p7so54796419eju.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=XSSr60W8+wVkOzbXRbpbDFdfliFbn8u7eRsj8riLCY8=;
 b=a842kjZnCxgKRCHTpJJJTYYZeW8r8YZqhn6mE/HJvQfUhiIwrffnuf+Mcu0CneMRVs
 DotOL20vZFi9K4roOxOYUtUmBZXcJRA+yu6YMaiRchfOVW7QNKc8xqcpJEHdve0KcwWK
 LrdyZgefw08lR6pPlJGXLO1y2Qun1NdCx2yRGEnoDbtSTzJugawf6+BfYof86lnUZSW3
 B9ITfs56A0QSvFW35twnwCNQ9cv9TRW3Dwqq5wUEfkPoFll9g31a35rgo6HyNWLjs5al
 gvoKiBm86YMHNTz8MTw7eLxrbYnCQNFyn3DjmJgEj0AO1hEZm33lJp8cdboFEYtU2xtL
 J/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XSSr60W8+wVkOzbXRbpbDFdfliFbn8u7eRsj8riLCY8=;
 b=OrNCd0m+xtRxpbOt8cQIgyS0mXUJDCK7E9Jb9b+HNafry+Ygelm4ZW7WD2kemKTF6v
 g3XYfbH/PSLTAhW8eXog+/FvtmGTrxvXmF2UsnNCgvY0YRge+2Oyk/O4WVQ4GvFlXEz8
 JQgptyyFbDWXlMujfMh2t0aiNEKptohxgbnfjxg7Pc0mLi1sBSCSOcI8Rk5nGNFL2Icr
 nuxGAg4HeZ9lEDVaj19IoiLIjNx88E5/aj5KO6PV/TI9WxbUs+Z1mtOIKgu8LPLjVEDB
 jwV2rp0gG4tSTd89dulX3F4i1nNBYvfheUUCRormFWgX3gAdK6vfK9rGFZFPDxJvxazB
 bVMg==
X-Gm-Message-State: AOAM530auRuwtsSwluv0FkhwFVpQHlf6fXg2jC3V7QdLHyO7Xu5dFcBn
 XhKb1k3tL+2MHSgkiY9ORbAhW2xy/xE=
X-Google-Smtp-Source: ABdhPJzFPYb7TGyPB+r5YlK4pNHNqL50CPJavUgeKpszZBMla/E1bLazBKbVh/830JBx7JRMxpWYQw==
X-Received: by 2002:a17:906:d8d3:: with SMTP id
 re19mr23701127ejb.440.1615814157761; 
 Mon, 15 Mar 2021 06:15:57 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:dd5e:327:8807:376f?
 ([2a02:908:1252:fb60:dd5e:327:8807:376f])
 by smtp.gmail.com with ESMTPSA id v15sm8018154edw.28.2021.03.15.06.15.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 06:15:57 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdkfd: Fix resource cursor initialization
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210313024351.10908-1-Felix.Kuehling@amd.com>
 <20210313024351.10908-3-Felix.Kuehling@amd.com>
 <84a69b44-6d5b-7068-f88f-889c252472c9@gmail.com>
 <aec5a6f2-6b1b-18b1-6297-c24ad8673657@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c32307d0-847a-9fe0-0d66-1584bc2ebfaf@gmail.com>
Date: Mon, 15 Mar 2021 14:15:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <aec5a6f2-6b1b-18b1-6297-c24ad8673657@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxNS4wMy4yMSB1bSAxNDowOCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IEFtIDIwMjEt
MDMtMTUgdW0gNjoyMiBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4gQW0gMTMuMDMu
MjEgdW0gMDM6NDMgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4+IE1ha2Ugc3VyZSB0aGUgY3Vy
LT5zaXplIGRvZXNuJ3QgZXhjZWVkIGN1ci0+cmVtYWluaW5nLiBPdGhlcndpc2UgdGhlCj4+PiBm
aXJzdCBjYWxsIHRvIGFtZGdwdV9yZXNfbmV4dCB3aWxsIHRyaWdnZXIgdGhlIEJVR19PTiBpbiB0
aGF0IGZ1bmN0aW9uLgo+PiBNaG0gdGhlIEJVR19PTiBpcyBjb3JyZWN0IHNpbmNlIHRoZSBmdW5j
dGlvbiBjb21wbGFpbnMgdGhhdCB3ZSB3YW50IHRvCj4+IG1vdmUgdGhlIGN1cnNvciBmb3J3YXJk
IGJ5IG1vcmUgdGhhbiBvcmlnaW5hbGx5IGV4cGVjdGVkLgo+Pgo+PiBUaGUgcHJvYmxlbSBpcyBy
YXRoZXIgdGhhdCBzb21lYm9keSBpcyB1c2luZyBjdXItPnNpemUgd2hpY2ggaXMgdGhlCj4+IHNp
emUgb2YgdGhlIGN1cnJlbnQgc2VnbWVudCBhcyBwYXJhbWV0ZXIgZm9yIGFtZGdwdV9yZXNfbmV4
dCgpLgo+Pgo+PiBEbyB5b3UgaGF2ZSBhIGJhY2t0cmFjZSBvZiB0aGlzPwo+IEkgZGlkbid0IHNh
dmUgdGhlIGJhY2t0cmFjZS4gVGhlIHByb2JsZW0gd2FzIGluCj4gYW1kZ3B1X3ZtX2JvX3VwZGF0
ZV9tYXBwaW5nLiBudW1fZW50cmllcyBpcyBiYXNlZCBvbiBjdXJzb3Iuc2l6ZSBhbmQKPiBsYXRl
ciB1c2VkIGluIHRoZSBhbWRwdV9yZXNfbmV4dCBjYWxsLgoKWWVhaCwgZm91bmQgdGhhdCBpbiB0
aGUgbWVhbnRpbWUgYXMgd2VsbC4KCj4gQnV0IEkgdGhpbmsgdGhhdCBzaG91bGQgYmUgT0suIElm
IGN1cnNvci5zaXplIGlzIHRoZSBjdXJyZW50IHNlZ21lbnQKPiBzaXplLCBpdCBzaG91bGQgbm90
IGV4Y2VlZCBjdXJzb3IucmVtYWluaW5nLiBPdGhlcndpc2UgZXZlcnkgdXNlciBvZiB0aGUKPiBj
dXJzb3Igd291bGQgaGF2ZSB0byBjaGVjayBib3RoIGN1cnNvci5zaXplIGFuZCBjdXJzb3IucmVt
YWluaW5nIGFsbCB0aGUKPiB0aW1lLCB3aGljaCB3b3VsZCBiZSBpbmNvbnZlbmllbnQuIGFtZGdw
dV9yZXNfbmV4dCBlbnN1cmVzIHRoYXQgd2l0aAo+IGN1ci0+c2l6ZSA9IG1pbihub2RlLT5zaXpl
IDw8IFBBR0VfU0hJRlQsIGN1ci0+cmVtYWluaW5nKS4gSSB0aGluawo+IGFtZGdwdV9yZXNfZmly
c3Qgc2hvdWxkIGRvIHRoZSBzYW1lLgoKT2ssIGdvb2QgcG9pbnQuIFBhdGNoIGlzIFJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIAo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB0aGVuLgoK
UmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IFJlZ2FyZHMsCj4gIMKgIEZlbGl4Cj4KPgo+PiBUaGFu
a3MsCj4+IENocmlzdGlhbi4KPj4KPj4+IEZpeGVzOiAzYWYwYTAxOGE3MjggKCJkcm0vYW1kZ3B1
OiBuZXcgcmVzb3VyY2UgY3Vyc29yIikKPj4+IENDOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVs
aXguS3VlaGxpbmdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gIMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmggfCAyICstCj4+PiAgwqAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgKPj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc19jdXJzb3IuaAo+Pj4gaW5kZXggMTMzNWUwOTg1
MTBmLi5iNDlhNjFkMDdkNjAgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oCj4+PiBAQCAtNjgsNyArNjgsNyBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgYW1kZ3B1X3Jlc19maXJzdChzdHJ1Y3QKPj4+IHR0bV9yZXNvdXJjZSAqcmVzLAo+
Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBzdGFydCAtPSBub2RlKystPnNpemUgPDwgUEFHRV9TSElG
VDsKPj4+ICDCoCDCoMKgwqDCoMKgIGN1ci0+c3RhcnQgPSAobm9kZS0+c3RhcnQgPDwgUEFHRV9T
SElGVCkgKyBzdGFydDsKPj4+IC3CoMKgwqAgY3VyLT5zaXplID0gKG5vZGUtPnNpemUgPDwgUEFH
RV9TSElGVCkgLSBzdGFydDsKPj4+ICvCoMKgwqAgY3VyLT5zaXplID0gbWluKChub2RlLT5zaXpl
IDw8IFBBR0VfU0hJRlQpIC0gc3RhcnQsIHNpemUpOwo+Pj4gIMKgwqDCoMKgwqAgY3VyLT5yZW1h
aW5pbmcgPSBzaXplOwo+Pj4gIMKgwqDCoMKgwqAgY3VyLT5ub2RlID0gbm9kZTsKPj4+ICDCoCB9
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
