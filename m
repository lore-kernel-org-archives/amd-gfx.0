Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DD7C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 11:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506A761004
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 11:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506A761004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979316ED85;
	Wed, 19 May 2021 11:56:24 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B966ED85;
 Wed, 19 May 2021 11:56:23 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id g7so2850460edm.4;
 Wed, 19 May 2021 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=kMwtQn6dV3yt3Ot507gI7+kLTeD78TGfI26lLWSJ/c4=;
 b=OPRSudK29E1xqPKA4nzwRHZmiy8tPSCdaTH2oQIa4jgyGW7GROLeGAWFha4fTXBRQv
 f12rebmAxnRqfoav2+mPoI2oJfxwPqOtlvuaSm/wYvzWe30STVRwMb0/8Hl34cv8QlLl
 svuSp4yMqsuAUL1g/eYEe0QbKNERq5P4Sw8r1PNSB0Iu2y/Cc5aeEIKZd/YmPr8xXd7Z
 U2t9GiiVk2Fj5wQYMygbAlw4V7qp+pCShHnx1E52JLoJI+z9I/eVwvXFzwMfbutGOAUV
 HiUjDEaa61Yx+s2T/hcg1qWK0QOFbkMSbC068iPmFLJ7gG+BndP1OU42pGBILTTxe2QN
 jvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=kMwtQn6dV3yt3Ot507gI7+kLTeD78TGfI26lLWSJ/c4=;
 b=IVfgdkIQDAX6Sqp50byyVfT81I8Zz6G9lsvIHT7nkqq53a/Qd/manGu4cIu3xACzbc
 WFf+IyreCYMeXgSrqFFfTj+7J4WJSOOuS7Op2nhlOWQeWorha7dKNw0QMzkWqegLtCh/
 LaCm1fQpuIiylMx65vV2WroJDBVfmr1/OY4+tN2nB5SfLlQJL8MNXKZCVpfktHTQr4tW
 3DjkWuOTyhWc3OyQU2VcXxkx23XTgIRI1Zmvk780dZtWHWpz+C66cxF+zwFVqj+bOePE
 D00YMk6Y9Y19N+SurD5/ZSdIw2CYIxPooP2F4WVN0gCop6XQe3mNXGaa1+rFmi+m7Gx3
 29Mw==
X-Gm-Message-State: AOAM533wlA3jyhkq7O11Ugp8mRC7dUBZN74Nm6aPtjPepm8mHlBLdclU
 F6/Fq3mkhUSEoDFbpaD/VjI=
X-Google-Smtp-Source: ABdhPJwtcTnsX9qzeGwPKZ/RMedIxGukbaLl5MGcU5rIZW83uBy37Pu5ENlyzkncBPUylzWbAksKhg==
X-Received: by 2002:aa7:de8b:: with SMTP id j11mr14010358edv.363.1621425382249; 
 Wed, 19 May 2021 04:56:22 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8e28:1d3:41f3:e15a?
 ([2a02:908:1252:fb60:8e28:1d3:41f3:e15a])
 by smtp.gmail.com with ESMTPSA id u11sm15608540edr.13.2021.05.19.04.56.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 May 2021 04:56:21 -0700 (PDT)
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-14-andrey.grodzovsky@amd.com>
 <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
 <f0c5dea7-af35-9ea5-028e-6286e57a469a@amd.com>
 <34d4e4a8-c577-dfe6-3190-28a5c63a2d23@amd.com>
 <da1f9706-d918-cff8-2807-25da0c01fcde@amd.com>
 <8228ea6b-4faf-bb7e-aaf4-8949932e869a@amd.com>
 <ec157a35-85fb-11e5-226a-c25d699102c6@amd.com>
 <53f281cc-e4c0-ea5d-9415-4413c85a6a16@amd.com>
 <0b49fc7b-ca0b-58c4-3f76-c4a5fab97bdc@amd.com>
 <31febf08-e9c9-77fa-932d-a50505866ec4@amd.com>
 <cd6bbe33-cbc5-43cb-80f7-1cb82a81e65d@amd.com>
 <77efa177-f313-5f1e-e273-6672ed46a90a@gmail.com>
 <4a9af53a-564d-62ae-25e1-06ca4129857f@amd.com>
 <1622338a-d95a-fe13-e4a4-c99cb4a31f6c@amd.com>
 <bc94fbc3-8e02-c860-fc58-6301219b84e5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fa81de6a-e272-66cf-61d8-5bb2d0ebcb03@gmail.com>
Date: Wed, 19 May 2021 13:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bc94fbc3-8e02-c860-fc58-6301219b84e5@amd.com>
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTkuMDUuMjEgdW0gMTM6NTEgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPgo+Cj4gT24g
MjAyMS0wNS0xOSA3OjQ2IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE5LjA1
LjIxIHVtIDEzOjAzIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pgo+Pj4KPj4+IE9uIDIw
MjEtMDUtMTkgNjo1NyBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+IEFtIDE4LjA1
LjIxIHVtIDIwOjQ4IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pj4+IFtTTklQXQo+Pj4+
Pj4+Cj4+Pj4+Pj4gV291bGQgdGhpcyBiZSB0aGUgcmlnaHQgd2F5IHRvIGRvIGl0ID8KPj4+Pj4+
Cj4+Pj4+PiBZZXMsIGl0IGlzIGF0IGxlYXN0IGEgc3RhcnQuIFF1ZXN0aW9uIGlzIGlmIHdlIGNh
biB3YWl0IGJsb2NraW5nIAo+Pj4+Pj4gaGVyZSBvciBub3QuCj4+Pj4+Pgo+Pj4+Pj4gV2UgaW5z
dGFsbCBhIGNhbGxiYWNrIGEgYml0IGxvd2VyIHRvIGF2b2lkIGJsb2NraW5nLCBzbyBJJ20gCj4+
Pj4+PiBwcmV0dHkgc3VyZSB0aGF0IHdvbid0IHdvcmsgYXMgZXhwZWN0ZWQuCj4+Pj4+Pgo+Pj4+
Pj4gQ2hyaXN0aWFuLgo+Pj4+Pgo+Pj4+PiBJIGNhbid0IHNlZSB3aHkgdGhpcyB3b3VsZCBjcmVh
dGUgcHJvYmxlbXMsIGFzIGxvbmcgYXMgdGhlIAo+Pj4+PiBkZXBlbmRlbmNpZXMKPj4+Pj4gY29t
cGxldGUgb3IgZm9yY2UgY29tcGV0ZWQgaWYgdGhleSBhcmUgZnJvbSBzYW1lIGRldmljZSAKPj4+
Pj4gKGV4dHJhY3RlZCkgYnV0Cj4+Pj4+IG9uIGEgZGlmZmVyZW50IHJpbmcgdGhlbiBsb29rcyB0
byBtZSBpdCBzaG91bGQgd29yay4gSSB3aWxsIGdpdmUgaXQKPj4+Pj4gYSB0cnkuCj4+Pj4KPj4+
PiBPaywgYnV0IHBsZWFzZSBhbHNvIHRlc3QgdGhlIGNhc2UgZm9yIGEga2lsbGVkIHByb2Nlc3Mu
Cj4+Pj4KPj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4gWW91IG1lYW4gc29tZXRoaW5nIGxpa2UgcnVu
IGdseGdlYXJzIGFuZCB0aGVuIHNpbXBseQo+Pj4gdGVybWluYXRlIGl0ID8gQmVjYXVzZSBJIGRv
bmUgdGhhdC4gT3Igc29tZXRoaW5nIG1vcmUgPwo+Pgo+PiBXZWxsIGdseGdlYXJzIGlzIGEgYml0
IHRvIGxpZ2h0d2VpZ2h0IGZvciB0aGF0Lgo+Pgo+PiBZb3UgbmVlZCBhdCBsZWFzdCBzb21lIHRl
c3Qgd2hpY2ggaXMgbGltaXRlZCBieSB0aGUgcmVuZGVyaW5nIHBpcGVsaW5lLgo+Pgo+PiBDaHJp
c3RpYW4uCj4KPiBZb3UgbWVhbiBzb21ldGhpbmcgdGhhdCBmaWxsIHRoZSBlbnRpdHkgcXVldWUg
ZmFzdGVyIHRoZW4gc2NoZWQgdGhyZWFkCj4gZW1wdGllcyBpdCBzbyB3aGVuIHdlIGtpbGwgdGhl
IHByb2Nlc3Mgd2UgYWN0dWFsbHkgbmVlZCB0byBleHBsaWNpdGx5IGdvCj4gdGhyb3VnaCByZW1h
aW5pbmcgam9icyB0ZXJtaW5hdGlvbiA/IEkgZG9uZSB0aGF0IHRvbyBieSBpbnNlcnRpbmcKPiBh
cnRpZmljaWFsIGRlbGF5IGluIGRybV9zY2hlZF9tYWluLgoKWWVhaCwgc29tZXRoaW5nIGxpa2Ug
dGhhdC4KCk9rIGluIHRoYXQgY2FzZSBJIHdvdWxkIHNheSB0aGF0IHRoaXMgc2hvdWxkIHdvcmsg
dGhlbi4KCkNocmlzdGlhbi4KCj4KPiBBbmRyZXkKPgo+Pgo+Pj4KPj4+IEFuZHJleQo+Pj4KPj4+
Cj4+Pj4KPj4+Pj4KPj4+Pj4gQW5kcmV5Cj4+Pj4KPj4+PiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+Pj4g
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+PiBodHRwczovL25hbTExLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVz
a3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDEl
N0NhbmRyZXkuZ3JvZHpvdnNreSU0MGFtZC5jb20lN0NjZTEyNTJlNTVmYWU0MzM4NzEwZDA4ZDkx
YWI0ZGUwMSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1
NzAxODYzOTMxMDcwNzElN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01E
QWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZh
bXA7c2RhdGE9dkdxeFk1c3hwRUlpUUdGQk5uMlBXa0txVmp2aU0yOXIzNFlqdjB3dWpmNCUzRCZh
bXA7cmVzZXJ2ZWQ9MCAKPj4+Pgo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
