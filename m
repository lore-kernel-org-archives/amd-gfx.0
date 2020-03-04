Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A49C3F2CD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 12:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D4720848
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 12:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnhbwOjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D4720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62CF6E165;
	Wed,  4 Mar 2020 12:41:59 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E68F86E165
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 12:41:58 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id m9so1383154qke.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2020 04:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=HS9s8FXb4BbtFMbzCeijRh0AU3RtA/C4jDOqOCY9wec=;
 b=JnhbwOjP82oiJFaiLHO6wfirv4Ac1fz08qrwtgczOAEbDpOtNtMHzlPv1iHkos7/+n
 uqVsAEZ+vFmJear86w1zDykQmExSWTtU3dUqR4ohGQNEyXuWy3ydftrSPlknpy7Isvqk
 BhT7KaLwKmMEFtFbV1dzzoGG+I6XHrrhjO4MRRw/GlzZAFc7wlaTVrcrHsFiwSlX2lQ5
 BMazK+VvBILfrGHduIWj/g0i1Iu9+3U1NiFpK1cT0zHOcFhReL7T+3j8+RhOeZfsb1fZ
 k3+WhvbbONS8dVeC48QP8UCJbRelxGAO8zkIy9uIr0wstYKrGyDiWOJzEzaKXVJBBdIc
 GA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=HS9s8FXb4BbtFMbzCeijRh0AU3RtA/C4jDOqOCY9wec=;
 b=NJr5A7zWkuZtw5mWjRTUv/vjwrp5ECSQBE6LWH9nkHXkNtSqvqL82VWfng0gOA3bfk
 kU7Hu7xLEe9jW/Fe/vLFU6zmr6P5q2W/6eVbwfDq2OGPuWOLn2uEo5yIvVbRyprYgDMh
 sF58zQ1hHyWG9C9o/c4YPHjEyMrraLSUi208foJRbz/GYTb4mFw1GtlkkkcBiz9HL8dN
 6qcbUNeUyoDgtYJ7dXOvaZap4mvfYE3UKbu3FFaGhLThCSjQwJDA+3JIOvcvrK1VUpRc
 C7NIF3KKQ3e9P1IKhznCVWUZoxeGcn5qN4XhP69zZTISSWTq/nij0tBhhWWGgIg8yywe
 IBDw==
X-Gm-Message-State: ANhLgQ0gIvuRW9rrOIkdeX8AJWzhErFPu4YviWZjexUuWcHvuOhozHUz
 Y2dLWkoqRtQe4Fx+bf3DnebDUD8g
X-Google-Smtp-Source: ADFU+vvN26bIyYY9VD0zVBYIfi2nAbau4lKelR2eWdU1uz3SYiHnWPKPRq03AuAM3B7lIak7KvmzxA==
X-Received: by 2002:a05:620a:919:: with SMTP id
 v25mr2456377qkv.363.1583325717884; 
 Wed, 04 Mar 2020 04:41:57 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id z8sm1385454qtq.11.2020.03.04.04.41.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Mar 2020 04:41:57 -0800 (PST)
Subject: Re: Few TMZ BO move patches
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200302121759.13003-1-christian.koenig@amd.com>
 <bb3600de-0448-667b-c3c0-eaaf6292f447@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d195639d-2c36-a199-6f85-5d17efa2ab1c@gmail.com>
Date: Wed, 4 Mar 2020 13:41:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bb3600de-0448-667b-c3c0-eaaf6292f447@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGFkIHRvIGNvbW1pdCB0aGF0IHRvZGF5IHNpbmNlIEkgbmVlZCB0byB3b3JrIG9uIGEgZGlmZmVy
ZW50IHByb2plY3QuCgpJZiB5b3UgZmluZCBhbnl0aGluZyBsZXQgbWUga25vdyBhbmQgd2UgY2Fu
IGZpeCBpdCBpbiBhIGZvbGxvdyB1cCBwYXRjaC4KCkNocmlzdGlhbi4KCkFtIDAyLjAzLjIwIHVt
IDIyOjQ3IHNjaHJpZWIgTHViZW4gVHVpa292Ogo+IFRoYW5rcyBDaHJpc3RpYW4uIEknbGwgdGFr
ZSBhIGxvb2sgYW5kIHBsYXkgd2l0aCBpdC4KPgo+IFJlZ2FyZHMsCj4gTHViZW4KPgo+IE9uIDIw
MjAtMDMtMDIgNzoxNyBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBCZWNhdXNlIG9m
IGEgc2hpZnQgaW4gcHJpb3JpdGllcyBJIHdvbid0IHdvcmsgb24gVE1aIHRoaXMgd2Vlay4KPj4K
Pj4gU28gYXR0YWNoZWQgYXJlIGEgZmV3IHNtYWxsZXIgcGF0Y2hlcyBJIGFscmVhZHkgcHJlcGFy
ZWQsIGJ1dCB0aGUgYm91bmNlIGNvcHkgZm9yIHN5c3RlbSBldmljdGlvbiBpcyBzdGlsbCBtaXNz
aW5nLgo+Pgo+PiBQYXRjaGVzIGFyZSB0b3RhbGx5IHVudGVzdGVkLCBidXQgSSBhbnlib2R5IGZp
bmQgdGhlbSB1c2VmdWwgZmVlbCBmcmVlIHRvIHRlc3QgYW5kIHJldmlldyB0aGVtLgo+Pgo+PiBS
ZWdhcmRzLAo+PiBDaHJpc3RpYW4uCj4+Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUy
Rm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2x1YmVuLnR1
aWtvdiU0MGFtZC5jb20lN0NiYjBhMDRmZGUxZWE0Yjc5NjBkNDA4ZDdiZWEzYzJkMCU3QzNkZDg5
NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxODc0ODI4ODc1NjE5NTAm
YW1wO3NkYXRhPUYxS0olMkJYJTJGMDRLa2o3V3p3NGJzYzFUWExSZUxOVmtyY3c5UjVvaGJndk9R
JTNEJmFtcDtyZXNlcnZlZD0wCj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
