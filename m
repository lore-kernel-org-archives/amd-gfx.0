Return-Path: <SRS0=ZBQi=HB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707ADC433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Jan 2021 15:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17FF764DFA
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Jan 2021 15:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FF764DFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD086E0EA;
	Sat, 30 Jan 2021 15:50:27 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00496E0EA
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Jan 2021 15:50:26 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id z22so14013986edb.9
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Jan 2021 07:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=jwfd0gD2o4+wHjMCeqyQ6OTsQbHq3C8uQXyFJyv1rgM=;
 b=vI1aVk3EfFNfsjYbZ88yCu/Qhisby5UlJ6M6uelCIXd9mDIoumT5tOywIZZKNwAdCY
 iWFAVCBbhJIUnBG51DQqx5wE+jLbd02mDvMlnHyJAN4CB5r+k7l7YypbQdJ2C4WZkOrv
 wY39PPZmokxT/buY0S+/ji5SbVXdtpW8oz2tm2J41K9lhGwEBt1uTs6T6pBvTqgE8j7t
 XklHaCoHbt21zWa07zViYAWNIuLm4FOgFwqV9jl63m9MMtghXV0583YMg4+48FIqhJTT
 mJ8Tut3zfJ0gyRKpqtsu00qxsXh4Mw40nd8lWcDSNJJXrw8JW/yYNvtbjxsDs//c+ZxC
 W1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=jwfd0gD2o4+wHjMCeqyQ6OTsQbHq3C8uQXyFJyv1rgM=;
 b=DfpuhhY1Um8Dg2P5ySE094N31D6OY2MpN+8BrwvA0BxPcSWte1KBYoo7NE2LfBUM22
 +9oVDmkX/59uq4TQl8ipVM9xRCkDRRrpNG81fDrOSq6EaY0vsIH0iLixeIoUNV08krYg
 OCvX/xNJMieAtZ3VG9F6KPOE84qs4zQE6rkgsaChNrscQLKMmSqDiL0rB/zlefh5cFzd
 ko6VmfncKZMYG6uTDtND5RF5QL4drHKrOC1L9ODpEj6sorVDJErhfyu1tpuxL582naKx
 a+FWMZB5ABuyax5Lm477CH56wHkN9eRxpJ6du8J2D6om60h+hUh/we1z617Zr/jQe2Z9
 iTFw==
X-Gm-Message-State: AOAM530/bv0/jfQ9dR9DeDK+hvaV//4z6kySl95aGhWHG2woUT4spRCz
 7eBjujsiff3+NczwseqrQ38=
X-Google-Smtp-Source: ABdhPJzF+gGZPViKa8Y445WZ13z0JJ5hR/HiqPL7iIjlII05pz/WYi/aRX7WS1Uh0MarwYsNt/MJpw==
X-Received: by 2002:a05:6402:4310:: with SMTP id
 m16mr10729390edc.207.1612021825354; 
 Sat, 30 Jan 2021 07:50:25 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id q16sm5377163ejd.39.2021.01.30.07.50.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Jan 2021 07:50:24 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Fix a false positive when pin non-VRAM memory
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210130010002.21222-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4409ffa8-12e3-7d8e-22b1-a90227ae6227@gmail.com>
Date: Sat, 30 Jan 2021 16:50:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210130010002.21222-1-xinhui.pan@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: alexander.deucher@amd.com, Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzAuMDEuMjEgdW0gMDI6MDAgc2NocmllYiB4aW5odWkgcGFuOgo+IEZsYWcgVFRNX1BMX0ZM
QUdfQ09OVElHVU9VUyBpcyBvbmx5IHZhbGlkIGZvciBWUkFNIGRvbWFpbi4gU28gZml4IHRoZQo+
IGZhbHNlIHBvc2l0aXZlIGJ5IGNoZWNraW5nIG1lbW9yeSB0eXBlIHRvby4KPgo+IFN1Z2dlc3Rl
ZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4gQWNrZWQtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBTaWduZWQtb2Zm
LWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDMgKystCj4gICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gaW5kZXggMTM3ZjI3NWY5MGVlLi41Njg1NGEz
ZWUxOWMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29i
amVjdC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5j
Cj4gQEAgLTkxOSw3ICs5MTksOCBAQCBpbnQgYW1kZ3B1X2JvX3Bpbl9yZXN0cmljdGVkKHN0cnVj
dCBhbWRncHVfYm8gKmJvLCB1MzIgZG9tYWluLAo+ICAgCQlpZiAoIShkb21haW4gJiBhbWRncHVf
bWVtX3R5cGVfdG9fZG9tYWluKG1lbV90eXBlKSkpCj4gICAJCQlyZXR1cm4gLUVJTlZBTDsKPiAg
IAo+IC0JCWlmICgoYm8tPmZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9DT05USUdVT1VT
KSAmJgo+ICsJCWlmICgobWVtX3R5cGUgPT0gVFRNX1BMX1ZSQU0pICYmCj4gKwkJICAgIChiby0+
ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMpICYmCj4gICAJCSAgICAh
KG1lbV9mbGFncyAmIFRUTV9QTF9GTEFHX0NPTlRJR1VPVVMpKQo+ICAgCQkJcmV0dXJuIC1FSU5W
QUw7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
