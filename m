Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA0DC4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 08:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80E5229F0
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 08:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80E5229F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CFB6E063;
	Mon, 14 Dec 2020 08:12:11 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFD786E063
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 08:12:09 +0000 (UTC)
Received: by mail-ed1-x543.google.com with SMTP id b2so16216944edm.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 00:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fp6bk54lSbfy1qxlmU1wUCGeZJovYGJfb2N7De5bdNA=;
 b=KcZCT7ApH9rwUvvWUCXGPYfD9F593nA71bC8Uei+kDS3pCZYmBT6smKcrn+mCrl3Fg
 2kHFuepcC3kL0zxxVZh+TLTbSnnw7uCsWSHDawlmfd2bEHLJKw+5yP1ZdloqgLfzitlV
 geMFNEhLjmscwdOFr1niU4UTxIduhBv8jeFEqBtc5C3r2bDDih2OzcXZ2HEmnqFwwnJH
 HJ4LP/yUqUVLDUDRx61YVtV5Y7y2b+O4+WT/siRxgec8hW0eDHZN1g5nz4L9i9rIher9
 Ig+1+91hSbBS7gSHZfGI6ffMSQxvp+yz+X3FWriepd6vPcMVE1WAXyH3bRvWxeZxwFKH
 rgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fp6bk54lSbfy1qxlmU1wUCGeZJovYGJfb2N7De5bdNA=;
 b=mgSSz/Ktj5QiE3LLhPPrA4ZpOM9+n98nQvX00M5QsV+IEOrXeD0TfKLKhGSR8Ch04T
 Dj2eL6nIWOhquVZmaJXzxTcdthEuIMMOPUgcWAUShgcmAmosUj8eMJ+BquMG5ge//E3H
 mVZTBBkuqGIMIgmvRG37mQi4dfJA8cCKooPoaO4TssXwcI6PtJL4JlasDod806PwAjAe
 VYIFZpo+1krKo+jZk5QlSWRgng1d7fzrDabktndAun1wKePg7QJXj+2T5QZ9K2e3+Z6Q
 dd+/kg3RdtBZBFx8fesLx5VkuAZGMJhzY/HVDoyqX0HiZL6TSeqREPnFb33pQd/qT/4U
 o7UA==
X-Gm-Message-State: AOAM532cYA5kCtwa0a3ykGvj9kfLbUb7v4TtKofo4ML2eDNgcwpMrUkT
 60SDHM9d4RLUqu1F8n5SA2c=
X-Google-Smtp-Source: ABdhPJzQIGRUf9/xU5plLocntTtsKOb/vw6JWFeppZ2KsrgP3l66IpVfv+XHHNjGWGJLgRSUhC6tWg==
X-Received: by 2002:aa7:d485:: with SMTP id b5mr22914611edr.214.1607933528366; 
 Mon, 14 Dec 2020 00:12:08 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id pg9sm13054677ejb.102.2020.12.14.00.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Dec 2020 00:12:07 -0800 (PST)
Subject: Re: [PATCH 3/7] amdgpu: resize BAR0 to the maximum available size,
 even if it doesn't cover VRAM (v2)
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
 Darren Salt <devspam@moreofthesa.me.uk>
References: <20201211005506.4554-1-devspam@moreofthesa.me.uk>
 <20201211005506.4554-4-devspam@moreofthesa.me.uk>
 <67019c3e-13cb-0196-73f1-2e71b0a5b6f9@gmail.com>
 <58E2B73AC8%devspam@moreofthesa.me.uk>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1d482d3c-ef99-ffdf-84c6-61182fd0f757@gmail.com>
Date: Mon, 14 Dec 2020 09:12:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <58E2B73AC8%devspam@moreofthesa.me.uk>
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

QW0gMTEuMTIuMjAgdW0gMTg6MzEgc2NocmllYiBEYXJyZW4gU2FsdDoKPiBbU05JUF0KPj4gSWYg
dGhhdCBpc24ndCB0aGUgY2FzZSB1c2UgZmxzKCkgdG8gZ2V0IHRoZSBoaWdoZXN0IHNldCBiaXQg
PCAxMy4KPiBUaGF0IHN1Z2dlc3RzIHRoYXQgaXQnbGwgYmUgZWFzaWVzdCB0byBjbGVhciBlYWNo
IGJpdCBhZnRlciB0aGUgY29ycmVzcG9uZGluZwo+IHNpemUgaXMgY2hlY2tlZCwgSSB0aGluay4K
Ck9rLCB3ZWxsIHlvdSBkb24ndCBzZWVtIHRvIHVuZGVyc3RhbmQgbXkgY29uc3RyYWluIGhlcmU6
IE5ldmVyIGNoZWNrIAptb3JlIHRoYW4gb25lIHNpemUhCgpGaW5kIHRoZSBmaXJzdCB2YWxpZCBz
aXplIHdoaWNoIGlzIGdvb2QgZm9yIHlvdSBhbmQgdGhlbiB0cnkgdG8gcmVzaXplIAp0byB0aGF0
IG9uZSwgaWYgdGhpcyBkb2Vzbid0IHdvcmsgYWJvcnQuCgo+IEFsc28sIHRoaXMgbG9va3MgbGlr
ZSBpdCdzIGFkZGluZyBjb21wbGV4aXR5IHRvCj4gdHJ5IHRvIG1ha2UgcmFyZWx5LWV4ZWN1dGVk
IGNvZGUgc2xpZ2h0bHkgZmFzdGVyIGluIHNvbWUgY2FzZXMgKEkgY2FuJ3Qgc2VlCj4gaXQgaGVs
cGluZyB3aGVyZSBhdmFpbGFibGVfc2l6ZXMgPT0gMHgzRjAwLCBmb3IgZXhhbXBsZSkuCgpUaGUg
aW50ZW50aW9uIGhlcmUgaXMgbm90IHRvIG1ha2UgdGhlIGNvZGUgZmFzdGVyLCBidXQgdG8gcHJl
dmVudCBpc3N1ZXMgCm9uIHN5c3RlbSB3aGVyZSB3ZSBwcm9iZSBtdWx0aXBsZSBHUFVzIGF0IG9u
Y2UuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+IEluY2lkZW50YWxseSwgaXMgaXQgd29ydGggdHJ5
aW5nIHRvIHJlZHVjZSB0aGUgQkFSIHNpemUgYXQgYWxsPyBUaGlua2luZwo+IG1haW5seSBvZiB0
d28gc2l0dWF0aW9ucyDigJMgbGltaXRpbmcgdGhlIG1heGltdW0gc2l6ZSwgYW5kIHRoZSBCSU9T
IGhhdmluZwo+IGFsbG9jYXRlZCBvbmUgbXVjaCB0b28gbGFyZ2UuCj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
