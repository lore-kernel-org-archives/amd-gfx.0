Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0D5C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 14:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D92261A06
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 14:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D92261A06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9156EA12;
	Wed, 24 Mar 2021 14:59:47 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36DD6EA1B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 14:58:29 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id u9so2934187ljd.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PLtdqjyb6ZpFLIDzj9Gxiz79SYwzEifApQNTVEfut1U=;
 b=A3EPC3UQ8kD+Rd3alctOKpLMlz4xxaxxrnxbDYlbKDZ8X+oYDBwGzDBJJT5NcJFn5z
 Okdhg9HaLhWsZR/JRw1FzIss7RlY3Tha0v3+gxSo+Yp3POvySTGsEJxAcVfIx0ngHclO
 qNezcOLDQM1V7OjKABpI7pMl1OATgOTUjDx0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PLtdqjyb6ZpFLIDzj9Gxiz79SYwzEifApQNTVEfut1U=;
 b=KfvheRXHIfP8r9z/Lig6cC+HOowags7t8UMA94ck420CEqRsJgJaxlLaZdrI5sgXXb
 0f8tlWKIYTofeRsk30KVWd2CJIYrdEBAfpttK6JlW6+UL46NIUP8QQaWxlVjJ5TaqQmJ
 wxFc/wF5W5mOW3nLCBMQDLECjxIxB3+HmDM0g/LOcNPItzgF65Rx3RsXi1Xh4L8rmUiy
 0tEgLMRjceUUXHb1Dtrr/wdg+IPmLFOuebYg8KRe+ZL6BwkkSDjfN7B0TYnhetpnsBtV
 nubb5xf0/Bjdi+BYvvpz+xZYgdp6ffgVM6HY8x2Cp0w0eioSc4N5N4nyGi7qIxs5mlf/
 Q7oQ==
X-Gm-Message-State: AOAM5318YU+z12eaGsQbqmNPKPHaJ6V/hSBlx/9R3TggDq7E+910RNKm
 O9QUjo7g63slZD6p/7vu9nXVbgVbCnM+U3+k1klh6A==
X-Google-Smtp-Source: ABdhPJzOSWH3/u+MPhUU07Njrv73s8fqFdHTjDExCoqX7Y6oA+pTxQz90sS6GqREY59FPaVymifkHkn8/sj5qqBxcJk=
X-Received: by 2002:a2e:7403:: with SMTP id p3mr2331523ljc.239.1616597907996; 
 Wed, 24 Mar 2021 07:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210310161444.1015500-1-markyacoub@chromium.org>
 <CADnq5_P9aYcedOP2qduSz7VN1fCSnmQEtPa+FdjYu9Co7TwPog@mail.gmail.com>
 <CAC0gqY7Y2WxtAZ3GnWmASPYq7ahYTfmPhOHAAX5UjMNS9k098w@mail.gmail.com>
 <b4070483-5aa5-c712-6435-dcb4a206ca76@daenzer.net>
 <CAP+8YyExtmmZbFfAO_YR=XWHE+HbH6m7JqyJV4LB_hbGwsihBA@mail.gmail.com>
 <CAPj87rP+WkUPbS3yyGGfy0SRm_hsnCCUav99Dg2Q+tXCiJ5D+A@mail.gmail.com>
In-Reply-To: <CAPj87rP+WkUPbS3yyGGfy0SRm_hsnCCUav99Dg2Q+tXCiJ5D+A@mail.gmail.com>
From: Mark Yacoub <markyacoub@chromium.org>
Date: Wed, 24 Mar 2021 10:58:17 -0400
Message-ID: <CAJUqKUqQ0yrxpr+QVRXYXMk1hBRNByD0TP6mM0oLY54jDZimbw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Ensure that the modifier requested is
 supported by plane.
To: Daniel Stone <daniel@fooishbar.org>
X-Mailman-Approved-At: Wed, 24 Mar 2021 14:59:46 +0000
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
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBNYXIgMjQsIDIwMjEgYXQgODoxMCBBTSBEYW5pZWwgU3RvbmUgPGRhbmllbEBmb29p
c2hiYXIub3JnPiB3cm90ZToKPgo+IE9uIFdlZCwgMjQgTWFyIDIwMjEgYXQgMTA6NTMsIEJhcyBO
aWV1d2VuaHVpemVuIDxiYXNAYmFzbmlldXdlbmh1aXplbi5ubD4gd3JvdGU6Cj4+Cj4+IE9uIFdl
ZCwgTWFyIDI0LCAyMDIxIGF0IDExOjEzIEFNIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnpl
ci5uZXQ+IHdyb3RlOgo+Pj4KPj4+IE5vIG1vZGlmaWVyIHN1cHBvcnQgZG9lcyBub3QgaW1wbHkg
bGluZWFyLiBJdCdzIGdlbmVyYWxseSBzaWduYWxsZWQgdmlhIERSTV9GT1JNQVRfTU9EX0lOVkFM
SUQsIHdoaWNoIHJvdWdobHkgbWVhbnMgInRpbGluZyBpcyBkZXRlcm1pbmVkIGJ5IGRyaXZlciBz
cGVjaWZpYyBtZWNoYW5pc21zIi4KU28geW91IG1lYW4gaXQgd291bGQgbWFrZSBtb3JlIHNlbnNl
IHRvIGJlIG1vcmUgZXhwbGljaXQgaW4gaGFuZGxpbmcKRFJNX0ZPUk1BVF9NT0RfSU5WQUxJRCBh
cyBhbiBpbmNvbWluZyBtb2RpZmllciAod2hpY2ggd2lsbCwganVzdCBsaWtlCkRSTV9GT1JNQVRf
TU9EX0xJTkVBUiwgd2lsbCByZXR1cm4gdHJ1ZSBpbgpkbV9wbGFuZV9mb3JtYXRfbW9kX3N1cHBv
cnRlZCk/Cj4+Cj4+Cj4+IERvZXNuJ3QgcXVpdGUgd29yayB0aGF0IHdheSBpbiB0aGUga2VybmVs
IHNhZGx5LiBJZiB5b3UgZG9uJ3Qgc2V0IERSTV9NT0RFX0ZCX01PRElGSUVSUyB0aGVuIHRoZSBt
b2RpZmllciBmaWVsZHMgaGF2ZSB0byBiZSAwICh3aGljaCBoYXBwZW5zIHRvIGFsaWFzIERSTV9G
T1JNQVRfTU9EX0xJTkVBUiBhbmQgdGhlbiBub3cgZGVwcmVjYXRlZCBEUk1fRk9STUFUX01PRF9O
T05FKS4gVGhpcyBpcyB2ZXJpZmllZCBpbiBzaGFyZWQgZHJtIGNvZGUuCj4+Cj4+IChhbmQgYWxs
IHVzZXJzcGFjZSBjb2RlIEkndmUgc2VlbiBzaW1wbHkgZG9lc24ndCBzZXQgRFJNX01PREVfRkJf
TU9ESUZJRVJTIGlmIHRoZSBpbmNvbWluZyBtb2RpZmllciBpcyBEUk1fRk9STUFUX01PRF9JTlZB
TElEKQo+Cj4KPiBZZXMsIGJ1dCBldmVuIHRob3VnaCB0aGUgZmllbGQgaXMgemVybywgdGhlIGxh
Y2sgb2YgdGhlIGZsYWcgbWVhbnMgaXQgbXVzdCBiZSB0cmVhdGVkIGFzIElOVkFMSUQuIElmIHRo
ZSBrZXJuZWwgaXMgbm90IGRvaW5nIHRoaXMsIHRoZSBrZXJuZWwgaXMgb2JqZWN0aXZlbHkgd3Jv
bmcuIChBbmQgSSBrbm93IGl0IGRvZXNuJ3QgZG8gdGhpcyBpbiBtb3N0IGNhc2VzLCBiZWNhdXNl
IG90aGVyd2lzZSBJIHdvdWxkbid0IGJlIGFibGUgdG8gdXNlIHRoaXMgR05PTUUgc2Vzc2lvbiBv
biBhbiBJbnRlbCBsYXB0b3AsIHdoZXJlIG1vZGlmaWVycyBhcmUgYmxhY2tsaXN0ZWQuKQo+Cj4g
Q2hlZXJzLAo+IERhbmllbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
