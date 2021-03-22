Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53412C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 13:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3036361930
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 13:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3036361930
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D7B6E471;
	Mon, 22 Mar 2021 13:36:54 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D40C56E471
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 13:36:53 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id w70so13044835oie.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IKX91CVLsysBuqgW2IV9FPxIuN4MJbVJi9aSymCIVIQ=;
 b=H99tmx948javoOPGemI0niAxhCXvwULc1m0MNoOM/sV2Uo6iIIS4gcGod74jWC3Ds2
 wcfdwbs2M7CP4pKtgtxZd/D44H9MxoO4ZByJbYgp2X4q38AWNqH7p5F/EO/aZLvPwfXW
 jP+gh0Mpa0DmCd+9zO/qcwpT0sAmBOaLx5/a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IKX91CVLsysBuqgW2IV9FPxIuN4MJbVJi9aSymCIVIQ=;
 b=BJBi3L3JANCmRBZjmr550QJL5lLmq8XeDSKYlHayBtYUX3fsYnfjaUXtKPoiHxR5o2
 6o6bSshljy/CXNMT7Rc30/kVHU+YwcwOz5f0pNPaUGG/igZt/4IOGwXaYop+Ld7/qPmI
 nQeBw9NXSaVAqFbipoR5fZIqTUZ7e0czq9Uox/ciqXEq4HogBMZFcfeJMdJ3ulgcEFwv
 VojBoTMlQd9xKvffMUXkd+UENkQ4IGT0j6Pvx9iL4gkf0ECc61bPfmEfEgd40DItPYkS
 jYxJMByI5JQVxmelBcdX3UZNBEmoSZ6st3EaHZcZmf7yv3LKKbl7LHygSjRcsoHNJVCE
 ru3g==
X-Gm-Message-State: AOAM532i8Qq5vMFNjNkCzAKHShMbg0lLa6bDcUpMcpnqmXfsd9BG7+zJ
 k7PAfD0xMS3/d39j9Fe4qhcyexbrnsIeolV+lhBmTw==
X-Google-Smtp-Source: ABdhPJz1OoCXWxHQ6O1CtSMOOkxlolkptb9qETkrT32wtHPg1v5F+sC2LqHgUKcgQ1JkOXWJlLU6ZeO7uvAkGar8d+Y=
X-Received: by 2002:aca:4188:: with SMTP id o130mr9706845oia.101.1616420213155; 
 Mon, 22 Mar 2021 06:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210322112206.4574-1-christian.koenig@amd.com>
In-Reply-To: <20210322112206.4574-1-christian.koenig@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 22 Mar 2021 14:36:41 +0100
Message-ID: <CAKMK7uEesyYzDy+MfhN5YeS=XaChBaGxrhDjo1bu7EP8-fwrFw@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: stop warning on TT shrinker failure v2
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
Cc: Liang.Liang@amd.com, dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBNYXIgMjIsIDIwMjEgYXQgMTI6MjIgUE0gQ2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5p
Zy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gRG9uJ3QgcHJpbnQgYSB3YXJu
aW5nIHdoZW4gd2UgZmFpbCB0byBhbGxvY2F0ZSBhIHBhZ2UgZm9yIHN3YXBwaW5nIHRoaW5ncyBv
dXQuCj4KPiB2Mjogb25seSBzdG9wIHRoZSB3YXJuaW5nCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogRGFu
aWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4KCkl0IGlzIGtpbmRhIHN1cnByaXNp
bmcgdGhhdCBwYWdlIGFsbG9jYXRvciB3YXJucyBoZXJlIGV2ZW4gdGhvdWdoIHdlCmV4cGxpY2l0
bHkgYXNrZWQgZm9yIG5vbi1HRlBfS0VSTkVMICh3aGljaCBpcyB0aGUgb25seSBvbmUgd2hlcmUg
eW91CnByZXR0eSBtdWNoIGNhbiBhc3N1bWUgeW91IHdpbGwgZ2V0IG1lbW9yeSBubyBtYXR0ZXIg
d2hhdCwgc2luY2Ugd29yc3QKY2FzZSB0aGUgT09NIGtpbGxlciBtYWtlcyBzcGFjZSBmb3IgeW91
KS4KCkJ1dCB0aGVuIHdpdGggbWVtYWxsb2Nfbm8qIGFuZCBmcmllbmRzIHRoZXNlIGZhaWx1cmVz
IGNvdWxkIGhhcHBlbiBpbgp1bmV4cGVjdGVkIHBsYWNlcywgYW5kIEkgdGhpbmsgdGhlIGNvZGUg
dGhhdCB3YXJucyBpc24ndCBhd2FyZSBvZiB0aGUKb3JpZ2luYWwgZ2ZwIGZsYWdzLCBzbyBtYWtl
cyBzb21lIHNlbnNlIGZyb20gYW4gaW1wbGVtZW50YXRpb24gcG92LgotRGFuaWVsCgoKPiAtLS0K
PiAgZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fdHQuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3R0bS90dG1fdHQuYyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMKPiBpbmRl
eCAyZjA4MzNjOThkMmMuLjQ4YjlhNjUwNjMwYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV90dC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fdHQuYwo+IEBA
IC0zNjksNyArMzY5LDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgdHRtX3R0X3Nocmlua2VyX3Nj
YW4oc3RydWN0IHNocmlua2VyICpzaHJpbmssCj4gICAgICAgICB9Owo+ICAgICAgICAgaW50IHJl
dDsKPgo+IC0gICAgICAgcmV0ID0gdHRtX2JvX3N3YXBvdXQoJmN0eCwgR0ZQX05PRlMpOwo+ICsg
ICAgICAgcmV0ID0gdHRtX2JvX3N3YXBvdXQoJmN0eCwgR0ZQX05PRlMgfCBfX0dGUF9OT1dBUk4p
Owo+ICAgICAgICAgcmV0dXJuIHJldCA8IDAgPyBTSFJJTktfRU1QVFkgOiByZXQ7Cj4gIH0KPgo+
IC0tCj4gMi4yNS4xCj4KCgotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50
ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
