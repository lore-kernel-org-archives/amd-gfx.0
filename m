Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5FBC433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 21:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF31B2313B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 21:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF31B2313B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A06B8929F;
	Wed,  6 Jan 2021 21:28:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F7689152
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 21:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609968461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yoHpt4zDYO1k6h9cr2ReVEpkPY4WN/rFBT3ndPAITWY=;
 b=iNUsT846w7EumaaZ10cmntOHiQoJ1z5V8z2yIuvvJDWY/BEidxtsmYgj7I3mILD4ikjn4B
 oV5HH4dexTq2zoE5AGnTCJz4/icv0IlvOa4jb1s7SlaIC3YWKT5VtiLqbAEOm/mSf9gUOy
 Qb43Ws19sFb6+mB+PzWQUoWKr81lKMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-cxn40vahMXeCYY0QVTRpiQ-1; Wed, 06 Jan 2021 16:27:36 -0500
X-MC-Unique: cxn40vahMXeCYY0QVTRpiQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44851809DC9;
 Wed,  6 Jan 2021 21:27:35 +0000 (UTC)
Received: from starship (unknown [10.35.206.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 584CA5D9CD;
 Wed,  6 Jan 2021 21:27:33 +0000 (UTC)
Message-ID: <efc25ad84748f8f343e8d13e818af917e73ea4d5.camel@redhat.com>
Subject: Re: Couple of issues with amdgpu on my WX4100
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
Date: Wed, 06 Jan 2021 23:27:32 +0200
In-Reply-To: <83f4291c-abe4-2995-b4ba-9f84c9235d14@amd.com>
References: <4df8585ab0aac5abb1e9502d1d7cc49daa2a464f.camel@redhat.com>
 <83f4291c-abe4-2995-b4ba-9f84c9235d14@amd.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Wed, 06 Jan 2021 21:28:41 +0000
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
Cc: David Airlie <airlied@linux.ie>, Alex Deucher <alexander.deucher@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Williamson <alwillia@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCAyMDIxLTAxLTA0IGF0IDEyOjM0ICswMTAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3Rl
Ogo+IEhpIE1heGltLAo+IAo+IEkgY2FuJ3QgaGVscCB3aXRoIHRoZSBkaXNwbGF5IHJlbGF0ZWQg
c3R1ZmYuIFByb2JhYmx5IGJlc3QgYXBwcm9hY2ggdG8gZ2V0IHRoaXMgZml4ZXMgd291bGQgYmUg
dG8gb3BlbiB1cCBhIGJ1ZyB0cmFja2VyIGZvciB0aGlzIG9uIEZETy4KCkRvbmUsIGJ1Z3MgYXJl
IG9wZW5lZApodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8x
NDI5Cmh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzE0MzAK
CkFib3V0IHRoZSBFRElEIGlzc3VlLCB0aGVyZSBkbyBzZWVtIHRvIGJlIGZldyBvcGVuIGJ1Z3Mg
YWJvdXQgaXQsCmJ1dCB3aGF0IGRpZmZlcnMgaW4gbXkgY2FzZSBJIHRoaW5rIGlzIHRoYXQgRURJ
RCBmYWlsdXJlIGhhcHBlbnMKb25seSBvbmNlIGluIGEgd2hpbGUsIHJhdGhlciB0aGF0IGFsd2F5
cywgYW5kIGl0IHNlZW1zIHRvIGJyaW5nCnRoZSB3aG9sZSBkZXZpY2UgZG93bi4KCkJlc3QgcmVn
YXJkcywKCU1heGltIExldml0c2t5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
