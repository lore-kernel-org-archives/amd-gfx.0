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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1ACC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 10:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90A464E89
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 10:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90A464E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66ADE8945A;
	Mon, 15 Mar 2021 10:22:44 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AEE78945A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 10:22:43 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id h13so16618774eds.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=5LqGxQkJD+R9tF/UZF5JbcHpRq2KDrCGNaepkYnTMhk=;
 b=l3ecp7iKTqUn6wsPomRrq+IbO/ZtD3Op55eLV5zJv608bJOGxPAr6SuezeoHxOU6D1
 3M1HIcDt7qtG0pupGtVhVpaDdgz/GjkpXrfrg/ZhvKl4ek1mXEJmZVv/gEtIkBWVOOuh
 7Iv0ZLkrVOGxBGM/oxwSO4jMNoSfUWXK7OG6bBwudvq1UELsHuy3yT6XSXUHWIn4u6jc
 b5qnm21nQunY1y5cWm/omV9b6HgJLhHLF/AYXIGhOop/HW32Q5/qPsPPD3YRaFWeJ2hX
 v55vy5Wa/bTP0mk07vnqxJZuIHULpLEE+JftGzG9OKMrNHWgepWLZX6vbm5TLHOfnTNs
 zXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5LqGxQkJD+R9tF/UZF5JbcHpRq2KDrCGNaepkYnTMhk=;
 b=iOttL6WQGmm5nGpd9eZq3GEqJA6tjHO9xK/8MkMcOfyhuRpzBaZJdjxUo2k4uFaIcB
 udpmKVH4z1WOCVPiwdFWX7yAc1Aa/EN5/Lsc/8zRpCToyhgBG8FQ1yhcDBkrZM6nu/yO
 jL3KeCe3bzNMs8SeViOFKC4jSIuSUPzbcVY/Pe/r45dUdxGBlvyItApLn5Szjg6EY6y+
 oatTR82YuLJVIXGeCY7FVr4Riw/oMVpLV753U3tSoX9gaukh6HThCQw6BsOpIkdk7/HU
 yaFX46sG9E8JGFy5yQYArU1dfxhD853kwsdL7sgiS+VMfg86bLTwSulntLnhQhNq2V11
 11bQ==
X-Gm-Message-State: AOAM532orw7XVJtWRoxLtaZUrLyYOJFRb8DQgPHAXQcSbo6RFBN37tK1
 zGzjujUqicFX/DVGXeaUsgE=
X-Google-Smtp-Source: ABdhPJxXDyWYI3wm2OFr5z9DZOqY7tozZfM+ji4DCyOFs8IQPQ2q62LPVn+iRmIhvjOwnqhNGVAXHA==
X-Received: by 2002:aa7:de8b:: with SMTP id j11mr29101044edv.363.1615803761869; 
 Mon, 15 Mar 2021 03:22:41 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:dd5e:327:8807:376f?
 ([2a02:908:1252:fb60:dd5e:327:8807:376f])
 by smtp.gmail.com with ESMTPSA id gj26sm6886305ejb.67.2021.03.15.03.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 03:22:41 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdkfd: Fix resource cursor initialization
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210313024351.10908-1-Felix.Kuehling@amd.com>
 <20210313024351.10908-3-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <84a69b44-6d5b-7068-f88f-889c252472c9@gmail.com>
Date: Mon, 15 Mar 2021 11:22:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210313024351.10908-3-Felix.Kuehling@amd.com>
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

QW0gMTMuMDMuMjEgdW0gMDM6NDMgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBNYWtlIHN1cmUg
dGhlIGN1ci0+c2l6ZSBkb2Vzbid0IGV4Y2VlZCBjdXItPnJlbWFpbmluZy4gT3RoZXJ3aXNlIHRo
ZQo+IGZpcnN0IGNhbGwgdG8gYW1kZ3B1X3Jlc19uZXh0IHdpbGwgdHJpZ2dlciB0aGUgQlVHX09O
IGluIHRoYXQgZnVuY3Rpb24uCgpNaG0gdGhlIEJVR19PTiBpcyBjb3JyZWN0IHNpbmNlIHRoZSBm
dW5jdGlvbiBjb21wbGFpbnMgdGhhdCB3ZSB3YW50IHRvIAptb3ZlIHRoZSBjdXJzb3IgZm9yd2Fy
ZCBieSBtb3JlIHRoYW4gb3JpZ2luYWxseSBleHBlY3RlZC4KClRoZSBwcm9ibGVtIGlzIHJhdGhl
ciB0aGF0IHNvbWVib2R5IGlzIHVzaW5nIGN1ci0+c2l6ZSB3aGljaCBpcyB0aGUgc2l6ZSAKb2Yg
dGhlIGN1cnJlbnQgc2VnbWVudCBhcyBwYXJhbWV0ZXIgZm9yIGFtZGdwdV9yZXNfbmV4dCgpLgoK
RG8geW91IGhhdmUgYSBiYWNrdHJhY2Ugb2YgdGhpcz8KClRoYW5rcywKQ2hyaXN0aWFuLgoKPgo+
IEZpeGVzOiAzYWYwYTAxOGE3MjggKCJkcm0vYW1kZ3B1OiBuZXcgcmVzb3VyY2UgY3Vyc29yIikK
PiBDQzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IFNpZ25l
ZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+IC0tLQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc19jdXJzb3IuaCB8IDIgKy0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oCj4gaW5kZXgg
MTMzNWUwOTg1MTBmLi5iNDlhNjFkMDdkNjAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jlc19jdXJzb3IuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgKPiBAQCAtNjgsNyArNjgsNyBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgYW1kZ3B1X3Jlc19maXJzdChzdHJ1Y3QgdHRtX3Jlc291cmNlICpyZXMsCj4g
ICAJCXN0YXJ0IC09IG5vZGUrKy0+c2l6ZSA8PCBQQUdFX1NISUZUOwo+ICAgCj4gICAJY3VyLT5z
dGFydCA9IChub2RlLT5zdGFydCA8PCBQQUdFX1NISUZUKSArIHN0YXJ0Owo+IC0JY3VyLT5zaXpl
ID0gKG5vZGUtPnNpemUgPDwgUEFHRV9TSElGVCkgLSBzdGFydDsKPiArCWN1ci0+c2l6ZSA9IG1p
bigobm9kZS0+c2l6ZSA8PCBQQUdFX1NISUZUKSAtIHN0YXJ0LCBzaXplKTsKPiAgIAljdXItPnJl
bWFpbmluZyA9IHNpemU7Cj4gICAJY3VyLT5ub2RlID0gbm9kZTsKPiAgIH0KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
