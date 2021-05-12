Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E387C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 18:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2874761166
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 18:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2874761166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868C16EC9B;
	Wed, 12 May 2021 18:10:52 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74AE26EC9B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 18:10:51 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 u19-20020a0568302493b02902d61b0d29adso20592811ots.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=g4khvy1B+qf8DKVGB+FYWo0K3p/b/KxfO1QLOUhHmPE=;
 b=oegMANYRSQg9x+Vjb38pP3Js9DkKpjkuVRIfw5X2f2L5ZuqHXr6U+g0lkGyUUztF7V
 tL02erQKnzv3iPgj5lMSJCmI8p5UZW/G4SINtWiElsMs3WWZfdQy1/3Mq6omE8hom9oS
 9Q84MEvmUJSmP4LWjvnH264H8SC5LFXYkU7vp5WXeG2902PobZ7eSwZs6Khu9LM7thLe
 CggPiUyZARtKcSvQqyPa3L0d/dsecZH+pX2yTZC/nCNAQY2XiCkOXPb7ARvJqI+W4ojJ
 QIwUUjJzrIsMdofX7vvMslpc2kHK3YhctOo3xvuxMoxMzb6r1E1wfNENckpJkxdZdbdX
 18aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=g4khvy1B+qf8DKVGB+FYWo0K3p/b/KxfO1QLOUhHmPE=;
 b=inLkRqYfSI30OQONDbm2AlGmeD6g9ZTwSYr6FUiOofjJU95bYFDxQn2RhEykYZjcj0
 ypw9f/y+bJ8uE0LqhAqbFmNZQV6Qg6hVT+qImOZKQ42jxHMNHZatv8m9T7OHi8SeYjVo
 HC0UQv+aExY4oB4NjGsb8gjpWc8caSgz3opmRqyiSaavvL9RNCWemYfh+kkwXIgBQD5V
 5OnE0sQEpT4KhlBIA8KVdF2W/n9H/nIGIbyZ4pwO+AUDmhZ6WXWuUzQ7u8lLFBuNvC0/
 +MUeSnwD2vSUViMC4EPsaX7FLdPyNfxcigQ2CYgjoTCr5yHirCud2ZkbWPJhqpuK4lhw
 /3wA==
X-Gm-Message-State: AOAM532CshbWbvRP6SnoTzil5LQoN2u1v0GdOD3A5mKuoFIE9xttItyo
 EijnU0Z54L6Dj0CCB4U5OzupDYay28dpDrnhR8k=
X-Google-Smtp-Source: ABdhPJw389chTixYkNo7uT7Ik5H6a1swF+n+8cRlTuNrS8JeUMMVGVcqkk/55E6UeyC5ro7Y+KEuSFWboJH53jHXLn8=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr29533561oti.23.1620843050744; 
 Wed, 12 May 2021 11:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210512101850.1466-1-christian.koenig@amd.com>
In-Reply-To: <20210512101850.1466-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 May 2021 14:10:40 -0400
Message-ID: <CADnq5_NMkh1zRESUDZRfzuxe3ixfSiwr7ys8kHOa+jQsdFynVA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: use the dummy page for GART if needed
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
Cc: Takashi Iwai <tiwai@suse.de>, arvin.kebob@gmail.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, mail@dennisfoster.us
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBNYXkgMTIsIDIwMjEgYXQgNjoxOCBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBJbXBvcnRlZCBCT3MgZG9uJ3Qg
aGF2ZSBhIHBhZ2VsaXN0IGFueSBtb3JlLgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IEZpeGVzOiAwNTc1ZmYzZDMzY2QgKCJk
cm0vcmFkZW9uOiBzdG9wIHVzaW5nIHBhZ2VzIHdpdGggZHJtX3ByaW1lX3NnX3RvX3BhZ2VfYWRk
cl9hcnJheXMgdjIiKQo+IENDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNS4xMgoKUmV2aWV3
ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCj4gLS0tCj4g
IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2dhcnQuYyB8IDMgKystCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9nYXJ0LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9nYXJ0LmMKPiBpbmRleCAzODA4YTc1MzEyN2IuLjA0MTA5YTJhNmZkNyAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9nYXJ0LmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9nYXJ0LmMKPiBAQCAtMzAxLDcgKzMwMSw4IEBA
IGludCByYWRlb25fZ2FydF9iaW5kKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCB1bnNpZ25l
ZCBvZmZzZXQsCj4gICAgICAgICBwID0gdCAvIChQQUdFX1NJWkUgLyBSQURFT05fR1BVX1BBR0Vf
U0laRSk7Cj4KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBwYWdlczsgaSsrLCBwKyspIHsKPiAt
ICAgICAgICAgICAgICAgcmRldi0+Z2FydC5wYWdlc1twXSA9IHBhZ2VsaXN0W2ldOwo+ICsgICAg
ICAgICAgICAgICByZGV2LT5nYXJ0LnBhZ2VzW3BdID0gcGFnZWxpc3QgPyBwYWdlbGlzdFtpXSA6
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmRldi0+ZHVtbXlfcGFnZS5wYWdlOwo+ICAgICAg
ICAgICAgICAgICBwYWdlX2Jhc2UgPSBkbWFfYWRkcltpXTsKPiAgICAgICAgICAgICAgICAgZm9y
IChqID0gMDsgaiA8IChQQUdFX1NJWkUgLyBSQURFT05fR1BVX1BBR0VfU0laRSk7IGorKywgdCsr
KSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcGFnZV9lbnRyeSA9IHJhZGVvbl9nYXJ0X2dl
dF9wYWdlX2VudHJ5KHBhZ2VfYmFzZSwgZmxhZ3MpOwo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGlu
ZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
