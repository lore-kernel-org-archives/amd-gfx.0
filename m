Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2307CA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 14:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95112087E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 14:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95112087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC616EA51;
	Wed, 30 Oct 2019 14:50:48 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F24D6EA51
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 14:50:47 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id w9so2496386wmm.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 07:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=wCOjkVWcV9SLy2ywBX18iGbnb6pVYcDo8I4emUftezI=;
 b=AzHGWX6zEjW0gGlNLhI/91NHL17ShvdGZRJ9MbFjIE2DUVGP1tvZyyjm/fVgc8u+YJ
 IGnlCSoLlZLJeXSCMDLG6XxMHXN2vMvepI/HmVwWloka5TzcD5asE41hR35RqaxsiZ8u
 XoEwNLM8OMyewNlmd0ThzzjIu5SRX0m4hjwVrN/Zhj+P0C7FNO9immi8WxyocISjzuMZ
 5sdlJZo005Vq33sGsvZBLXsLuznmewA3/Qy/CushQfRV69kzdTHO115gY8HpBijJE79t
 Y/zMFZTljPXr/1U83gkP6n6AZAblaopmrk7RMi7Z0oB4r15f8OWz7MHlHzNHZHps4bOa
 x6oQ==
X-Gm-Message-State: APjAAAX/9KVcw8TPNhJwH7JwWojUvUWqFIJmuIdgNJwrz3iZS0fTmWGv
 7fg6nFVQW8cp88MYxJgK72rZa0tV
X-Google-Smtp-Source: APXvYqxES9c61tPm9kAhtCfrXWZBB24FrETvf1H5o9MShI9sG3lVdwJASEJdd57WEypueualTthswg==
X-Received: by 2002:a1c:44b:: with SMTP id 72mr9003457wme.72.1572447045461;
 Wed, 30 Oct 2019 07:50:45 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u68sm311973wmu.12.2019.10.30.07.50.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Oct 2019 07:50:44 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: guard ib scheduling while in reset
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "S, Shirish" <Shirish.S@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <1571914692-9430-1-git-send-email-shirish.s@amd.com>
 <23ea615d-5ef4-d0b3-a0ec-6fae67b102f2@gmail.com>
 <f3be329d-d350-c821-00b7-d94858335796@amd.com>
 <d573688c-0997-1928-0c56-b60a29ff7fde@gmail.com>
 <b5e99dc3-5658-7e48-63f7-bf9533f582f8@amd.com>
 <2505c476-9e10-f70e-355c-33765a37d607@amd.com>
 <a1c31f37-128f-51b1-f747-fe75d78d4214@amd.com>
 <a9789f76-3ba5-ad71-1507-5eac6f589b82@amd.com>
 <971115b1-6208-1dd5-d99f-c9377663a80b@amd.com>
 <2e2ebf73-9a25-5ad2-78e7-07c8b1db1b37@amd.com>
 <08e3c44f-5d08-d5f5-bc76-ea9b77032e5a@amd.com>
 <1e1d0b06-75ab-160c-a6c7-baede02f1e7d@amd.com>
 <f5b7aeff-c4ce-fa2f-1390-e8892fa7a964@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d73c46e2-ed85-f56e-3a2a-cbf2919d0a3f@gmail.com>
Date: Wed, 30 Oct 2019 15:50:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f5b7aeff-c4ce-fa2f-1390-e8892fa7a964@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=wCOjkVWcV9SLy2ywBX18iGbnb6pVYcDo8I4emUftezI=;
 b=bkvj/lQEi4l39Ioi4dQMiCFNOO+KbiXCq8qVJaFaJEeis/7E4plVWVVAhIgL/rd4k/
 N3vGv8+VKePohNz8LNjW2OjORsQ/9APtnDl4xqSji7GE5obVmrO3zKQgKEhYbYpZf3NY
 foITctEAqSET2ClbwawFSXjxSFkZlAb3cctKDjg3brzXy23Ps0peRg+1C9pm2NyA5j4n
 iUw6prX8YSQgp+sKOP2hsZ4FKIHjoSR3b11YVZWqsEQjxyNH65BJ67PxhbHOcHmz9Ldh
 4Tnkl2KlbRY5SpVWudi1ayM8GLwbp0QYXxJnhgHmmzDmD6G1XPZv7j1XMAhvkc7IHubz
 Glzw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030145043.m84aktbaiIuS6ZC69bCsFzQrmd8aWk-NFOw25xVRkQE@z>

QSBsb2NrIGluc2lkZSB0aGUgc2NoZWR1bGVyIGlzIHJhdGhlciB0cmlja3kgdG8gaW1wbGVtZW50
LgoKV2hhdCB5b3UgbmVlZCB0byBkbyBpcyB0byBnZXQgcmlkIG9mIHRoZSBwYXJrKCkvdW5wYXJr
KCkgaGFjayBpbiAKZHJtX3NjaGVkX2VudGl0eV9maW5pKCkuCgpXZSBjb3VsZCBkbyB0aGlzIHdp
dGggYSBzdHJ1Y3QgY29tcGxldGlvbiBvciBjb252ZXJ0IHRoZSBzY2hlZHVsZXIgZnJvbSAKYSB0
aHJlYWQgdG8gYSB3b3JrIGl0ZW0uCgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAzMC4xMC4xOSB1
bSAxNTo0NCBzY2hyaWViIEdyb2R6b3Zza3ksIEFuZHJleToKPiBUaGF0IGdvb2TCoCBhcyBwcm9v
ZiBvZiBSQ0EgYnV0IEkgc3RpbGwgdGhpbmsgd2Ugc2hvdWxkIGdyYWIgYSBkZWRpY2F0ZWQKPiBs
b2NrIGluc2lkZSBzY2hlZHVsZXIgc2luY2UgdGhlIHJhY2UgaXMgaW50ZXJuYWwgdG8gc2NoZWR1
bGVyIGNvZGUgc28KPiB0aGlzIGJldHRlciB0byBoYW5kbGUgaXQgaW5zaWRlIHRoZSBzY2hlZHVs
ZXIgY29kZSB0byBtYWtlIHRoZSBmaXggYXBwbHkKPiBmb3IgYWxsIGRyaXZlcnMgdXNpbmcgaXQu
Cj4KPiBBbmRyZXkKPgo+IE9uIDEwLzMwLzE5IDQ6NDQgQU0sIFMsIFNoaXJpc2ggd3JvdGU6Cj4+
Pj4+IFdlIHN0aWxsIGhhdmUgaXQgYW5kIGlzbid0IGRvaW5nIGt0aHJlYWRfcGFyaygpL3VucGFy
aygpIGZyb20KPj4+Pj4gZHJtX3NjaGVkX2VudGl0eV9maW5pIHdoaWxlIEdQVSByZXNldCBpbiBw
cm9ncmVzcyBkZWZlYXRzIGFsbCB0aGUKPj4+Pj4gcHVycG9zZSBvZiBkcm1fc2NoZWRfc3RvcC0+
a3RocmVhZF9wYXJrID8gSWYKPj4+Pj4gZHJtX3NjaGVkX2VudGl0eV9maW5pLT4ga3RocmVhZF91
bnBhcmsgaGFwcGVucyBBRlRFUgo+Pj4+PiBkcm1fc2NoZWRfc3RvcC0+a3RocmVhZF9wYXJrIG5v
dGhpbmcgcHJldmVudHMgZnJvbSBhbm90aGVyICh0aGlyZCkKPj4+Pj4gdGhyZWFkIGtlZXAgc3Vi
bWl0dGluZyBqb2IgdG8gSFcgd2hpY2ggd2lsbCBiZSBwaWNrZWQgdXAgYnkgdGhlCj4+Pj4+IHVu
cGFya2VkIHNjaGVkdWxlciB0aHJlYWQgdHJ5IHRvIHN1Ym1pdCB0byBIVyBidXQgZmFpbCBiZWNh
dXNlIHRoZQo+Pj4+PiBIVyByaW5nIGlzIGRlYWN0aXZhdGVkLgo+Pj4+Pgo+Pj4+PiBJZiBzbyBt
YXliZSB3ZSBzaG91bGQgc2VyaWFsaXplIGNhbGxzIHRvCj4+Pj4+IGt0aHJlYWRfcGFyay91bnBh
cmsoc2NoZWQtPnRocmVhZCkgPwo+Pj4+Pgo+Pj4+IFllYWgsIHRoYXQgd2FzIG15IHRoaW5raW5n
IGFzIHdlbGwuIFByb2JhYmx5IGJlc3QgdG8ganVzdCBncmFiIHRoZQo+Pj4+IHJlc2V0IGxvY2sg
YmVmb3JlIGNhbGxpbmcgZHJtX3NjaGVkX2VudGl0eV9maW5pKCkuCj4+Pgo+Pj4gU2hpcmlzaCAt
IHBsZWFzZSB0cnkgbG9ja2luZyAmYWRldi0+bG9ja19yZXNldCBhcm91bmQgY2FsbHMgdG8KPj4+
IGRybV9zY2hlZF9lbnRpdHlfZmluaSBhcyBDaHJpc3RpYW4gc3VnZ2VzdHMgYW5kIHNlZSBpZiB0
aGlzIGFjdHVhbGx5Cj4+PiBoZWxwcyB0aGUgaXNzdWUuCj4+Pgo+PiBZZXMgdGhhdCBhbHNvIHdv
cmtzLgo+Pgo+PiBSZWdhcmRzLAo+Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
