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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74CEC433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Jan 2021 15:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA6E64E09
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Jan 2021 15:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA6E64E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69616E0EF;
	Sat, 30 Jan 2021 15:56:15 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32AF86E0EF
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Jan 2021 15:56:15 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id g1so14031347edu.4
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Jan 2021 07:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=qJ+o17cEwXNRco0XzG0I253pH65npzbEEjZx+MadMy0=;
 b=nl+Fb+KACX3RgKgtOsNwLBkeTsEYPw+4+bIb/tCl6dkxp8t0VPj0bB7gi1yG24dI39
 omMs3kFzXczM654Q6WhWgdaziCFCKbzmSMRGfomvYQbZXXFMTCrYjrZHpIyCAQ7gOiBs
 k1GUJoO8cJIAHL48qmnK6kSAuR46mA3DUVsX0RcWZgcnjRNjqW/pzpoUduhvyayEgzA5
 CmzqxiZfXtirkuBhvWgUk/QAAYD1W6rbd9/ve75uozbfaa8LAd+vwdH91FMDV5gFJun9
 uI21pUfvIk0MD/FTL577neUkgCeURGI+mZ5DTfnVfsaEg8nW2/OK+p2ITV5xOxs8Tp0a
 i9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=qJ+o17cEwXNRco0XzG0I253pH65npzbEEjZx+MadMy0=;
 b=Atlk6kewz3F2S2Tbodaz2XryQmFMa4FFsGSu/9erijQlyckpBfennJHYmgf2duyLAN
 cO+OfA2gkYLV0M94q4Gq6OOto955hTVh1KmmOigZRDOp5NNWDUxYSRZiN6A+5fvfIC1O
 9zJtx47szTfqCsZBqMBKB87/ZdlefC+gPTJPQiVcWuE971NaOABe+6bpo0EuVw009gCM
 iIRALhphTToS7dOi5gQoUOXrwoFoYrvZG+RmIUaZlemvdPvIENf4B+ErAIJMfw0QgBrS
 RTHwuYfnFB8DopXt6KR6VHvKaaOd4VnFvabQETXBUkVWEUiHw149pb7QAXOe4sDfnltQ
 /i3A==
X-Gm-Message-State: AOAM5325fGynipmLRcwkEiDKqmPtvcr0zWsM54xU4L/0R40pMqvGlDZm
 wiRTmF+0q197sKRlOJ+OV/fGIz8V03g=
X-Google-Smtp-Source: ABdhPJygPjTYF1ZT45JhJTkIhBOEq3bHyPnidVtprJQ6mP/n9Y3NsDltUjqwJC7sF4Xzlfcw2ubp8Q==
X-Received: by 2002:a05:6402:31a4:: with SMTP id
 dj4mr10587091edb.156.1612022173920; 
 Sat, 30 Jan 2021 07:56:13 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id e22sm775362edu.61.2021.01.30.07.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Jan 2021 07:56:13 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: fix the issue that retry constantly once the
 buffer is oversize
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210130091430.3079814-1-ray.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8d18737f-faba-7033-c1da-c88ad0255ca2@gmail.com>
Date: Sat, 30 Jan 2021 16:56:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210130091430.3079814-1-ray.huang@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzAuMDEuMjEgdW0gMTA6MTQgc2NocmllYiBIdWFuZyBSdWk6Cj4gV2UgY2Fubm90IG1vZGlm
eSBpbml0aWFsX2RvbWFpbiBldmVyeSB0aW1lIHdoaWxlIHRoZSByZXRyeSBzdGFydHMuIFRoYXQK
PiB3aWxsIGNhdXNlIHRoZSBidXN5IHdhaXRpbmcgdGhhdCB1bmFibGUgdG8gc3dpdGNoIHRvIEdU
VCB3aGlsZSB0aGUgdnJhbQo+IGlzIG5vdCBlbm91Z2guCj4KPiBGaXhlczogZjhhYWI2MDQyMmMz
ICgiZHJtL2FtZGdwdTogSW5pdGlhbGlzZSBkcm1fZ2VtX29iamVjdF9mdW5jcyBmb3IKPiBpbXBv
cnRlZCBCT3MiKQo+Cj4gU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNv
bT4KPiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgoKXl4gSSBuZWVkIHRvIHJ1biBteSBtZW1vcnkgcHJlc3N1cmUgdGVzdCBtb3JlIG9mdGVuLgoK
UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgfCAyICst
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPiBpbmRleCBhNWM0MmMzMDA0YTAu
LmI0NDM5MDdhZmNlYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ2VtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Vt
LmMKPiBAQCAtMjY5LDggKzI2OSw4IEBAIGludCBhbWRncHVfZ2VtX2NyZWF0ZV9pb2N0bChzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLAo+ICAgCQlyZXN2ID0gdm0tPnJvb3QuYmFz
ZS5iby0+dGJvLmJhc2UucmVzdjsKPiAgIAl9Cj4gICAKPiAtcmV0cnk6Cj4gICAJaW5pdGlhbF9k
b21haW4gPSAodTMyKSgweGZmZmZmZmZmICYgYXJncy0+aW4uZG9tYWlucyk7Cj4gK3JldHJ5Ogo+
ICAgCXIgPSBhbWRncHVfZ2VtX29iamVjdF9jcmVhdGUoYWRldiwgc2l6ZSwgYXJncy0+aW4uYWxp
Z25tZW50LAo+ICAgCQkJCSAgICAgaW5pdGlhbF9kb21haW4sCj4gICAJCQkJICAgICBmbGFncywg
dHRtX2JvX3R5cGVfZGV2aWNlLCByZXN2LCAmZ29iaik7CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
