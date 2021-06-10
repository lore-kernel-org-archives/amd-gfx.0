Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325F6C47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0444613DD
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0444613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6446EDAD;
	Thu, 10 Jun 2021 16:44:27 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3EC56EDA9;
 Thu, 10 Jun 2021 16:44:26 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id c9so3063653wrt.5;
 Thu, 10 Jun 2021 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7+oHmU4eRe/lusT8CbRatuJ3o4g6a4ul0yc5NKtcGOA=;
 b=sYtsN1qVTmpgxZ3nt/R00IffVRXPBQUB5nJs6+9QczXM7mZvO5njCQdUPPpi4qteJ/
 oz8za3uWis5KMoDaJ3Ymd3u/ABuE2eJkOlZ4Xm87OGstQFEJ0/FjEDQ5CZAe1XJTwC/j
 kE/tXvyUHgIEKtYbU8pB803B/9Okn+LKT28metmT4hedpzutuH0Xou657cMwq5TDg51e
 1ZVLhejCYRB69ntn5hmO4JGk+fX47AaMlMBT+TWrc0tx3QUJVRC3U5EYkC5iSgSrUDwy
 LemTxLMjfzNRqV2NZDRav8ozEvxcy8oRvhNQZfJIcLIPE6K5/uuoexrKRHeKNOhB8GlO
 vjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7+oHmU4eRe/lusT8CbRatuJ3o4g6a4ul0yc5NKtcGOA=;
 b=D412Zt8MkvntE/AOZKXV7xFY51E6Tcz/8taLVvmkK7iCU6JElvGehpaZcd0gSxrN3K
 1riLv63jwPkNCpBaZP5YsCUkgjz5B9WT9QmV4SMqqDbdbotO0hFfikDZdVPVYZ8oabiu
 FLqkb3o1MVqjBsS1Z418qR17MkB1o48YNBfg9sbYiSw5ODZQhukMAnWlS/gkT/qasp50
 2hshubzZ3k/bEnDisIvLAx6i0J+yTz06wvN/Q6UpNSxRddhkb15vI+7r4gCP3Pz423Iu
 kwclqt3fi0Rj5JOOuWDXevxqHdgjPRoyIeOUzV7iT8s8I3JpaLZ9QO8PfXAsRhqBlHpn
 J3YA==
X-Gm-Message-State: AOAM532/gut5/M+BYQX/t7XJ/H4sHANh/qQUI0+qoris9rT38wPreewZ
 +XCTfltuK+dctgBE0r1no4HZ34mvxjg=
X-Google-Smtp-Source: ABdhPJzddWvuZfx+is4l65I3v6uHI0MCZXRAu5+8XAO+yaH6kuWQyrSszEcPsRwlymwGlCyornJcPw==
X-Received: by 2002:adf:e943:: with SMTP id m3mr6439979wrn.384.1623343465373; 
 Thu, 10 Jun 2021 09:44:25 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c285:5f9a:99f5:633e?
 ([2a02:908:1252:fb60:c285:5f9a:99f5:633e])
 by smtp.gmail.com with ESMTPSA id w23sm10018028wmi.0.2021.06.10.09.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 09:44:24 -0700 (PDT)
Subject: Re: Change how amdgpu stores fences in dma_resv objects
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
References: <20210610091800.1833-1-christian.koenig@amd.com>
 <f3788c24-bb42-4913-6334-fb3549c21fb9@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <03aaeb20-433c-db7d-1fa9-c954e913f943@gmail.com>
Date: Thu, 10 Jun 2021 18:44:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f3788c24-bb42-4913-6334-fb3549c21fb9@daenzer.net>
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMDYuMjEgdW0gMTg6MzQgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPiBPbiAyMDIxLTA2
LTEwIDExOjE3IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFNpbmNlIHdlIGNhbid0
IGZpbmQgYSBjb25zZW5zdXMgb24gaG90IHRvIG1vdmUgZm9yd2FyZCB3aXRoIHRoZSBkbWFfcmVz
diBvYmplY3QgSSBjb25jZW50cmF0ZWQgb24gY2hhbmdpbmcgdGhlIGFwcHJvYWNoIGZvciBhbWRn
cHUgZmlyc3QuCj4+Cj4+IFRoaXMgbmV3IGFwcHJvYWNoIGNoYW5nZXMgaG93IHRoZSBkcml2ZXIg
c3RvcmVzIHRoZSBjb21tYW5kIHN1Ym1pc3Npb24gZmVuY2UgaW4gdGhlIGRtYV9yZXN2IG9iamVj
dCBpbiBETUEtYnVmIGV4cG9ydGVkIEJPcy4KPj4KPj4gRm9yIGV4cG9ydGVkIEJPcyB3ZSBub3cg
c3RvcmUgdGhlIENTIGZlbmNlIGluIGEgZG1hX2ZlbmNlX2NoYWluIGNvbnRhaW5lciBhbmQgYXNz
aWduIHRoYXQgb25lIHRvIHRoZSBleGNsdXNpdmUgZmVuY2VzIHNsb3QuCj4+Cj4+IER1cmluZyBz
eW5jaHJvbml6YXRpb24gdGhpcyBkbWFfZmVuY2VfY2hhaW4gY29udGFpbmVyIGlzIHVucGFja2Vk
IGFnYWluIGFuZCB0aGUgY29udGFpbmluZyBmZW5jZXMgaGFuZGxlZCBpbmRpdmlkdWFsbHkuCj4+
Cj4+IFRoaXMgaGFzIGEgbGl0dGxlIGJpdCBtb3JlIG92ZXJoZWFkIHRoYW4gdGhlIG9sZCBhcHBy
b2FjaCwgYnV0IGl0IGFsbG93cyBmb3Igd2FpdGluZyBmb3IgdGhlIGV4Y2x1c2l2ZSBzbG90IGZv
ciB3cml0ZXMgYWdhaW4uCj4gTmljZSEKPgo+IFRoaXMgc2VlbXMgdG8gd29yayBhcyBleHBlY3Rl
ZCB3aXRoIGh0dHBzOi8vZ2l0bGFiLmdub21lLm9yZy9HTk9NRS9tdXR0ZXIvLS9tZXJnZV9yZXF1
ZXN0cy8xODgwOiBTb21lIGJ1ZmZlcnMgbm93IGRvbid0IHBvbGwgcmVhZGFibGUgYXQgZmlyc3Qs
IHVudGlsIHRoZSBHUFUgaXMgZG9uZSBwcm9jZXNzaW5nIHRoZW0uCgpXZWxsIEknbSBzdGlsbCBw
cmV0dHkgc3VyZSB0aGF0IGFueSBwb2xsaW5nIG9uIHRoZSBDUFUgc2hvdWxkIGJlIAphdm9pZGVk
LCBidXQgeWVzIGl0IGlzIG5pY2UgdG8gaGF2ZSB0aGF0IHdvcmtpbmcgbm93IGluIGdlbmVyYWwu
Cgo+IFVuZm9ydHVuYXRlbHksIGFzIGV4cGVjdGVkLCB3aXRob3V0IGEgaGlnaCBwcmlvcml0eSBj
b250ZXh0IGZvciB0aGUgY29tcG9zaXRvciB3aGljaCBjYW4gcHJlZW1wdCBjbGllbnQgZHJhd2lu
ZywgdGhpcyBpc24ndCBlbm91Z2ggdG8gcHJldmVudCBzbG93IGNsaWVudHMgZnJvbSBzbG93aW5n
IGRvd24gdGhlIGNvbXBvc2l0b3IgYXMgd2VsbC4gQnV0IGl0IHNob3VsZCBhbHJlYWR5IGhlbHAg
Zm9yIGZ1bGxzY3JlZW4gYXBwcyB3aGVyZSB0aGUgY29tcG9zaXRvciBjYW4gZGlyZWN0bHkgc2Nh
biBvdXQgdGhlIGNsaWVudCBidWZmZXJzIGF0IGxlYXN0LgoKSSBoYXZlIHNlZW4gcGF0Y2hlcyBm
b3IgdGhpcyBmbHlpbmcgYnkgaW50ZXJuYWxseSwgYnV0IG5vdCBzdXJlIGFib3V0IAp0aGUgc3Rh
dHVzLgoKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
