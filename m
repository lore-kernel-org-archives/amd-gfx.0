Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B848BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 10:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D54064EAA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 10:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D54064EAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE3496E853;
	Mon,  8 Feb 2021 10:04:48 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CCB96E853
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Feb 2021 10:04:48 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id sa23so23718559ejb.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Feb 2021 02:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Ns7lM1FjL+J7PiAEoQEVxaQB5SkXoz357aPn+O2nAhc=;
 b=V4gzQfu+BHUDbxw80ZVlBDpTBF8jIjPhbAIknEZMnUmTDw1jp2154XWbWkVfBWmGrc
 WdkcEprw9jnVExJCehRAJdfyK0Uj2EldEr0AMN8WaHzg91oGizRKXFIkHCY49BRsjB5j
 iQBFAInd6b+Mf7YLI4EflNTLC4Qls9Vta0Om5c1z6EvBGRdw9AVwlVAVQxcpyHYNMRBD
 ARVL/pSXpXltGdC9gM6uBEFphcwgSkmDZz9KwGbjXGNyG10AmsU8xrNTaA//smmtfQo5
 mRbt9WqCFO2ScjY+FDLXmFpghajdZSNic5leSAbX5D2kKVgzQJr/SZY7v7eD1P1sq6JU
 dD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Ns7lM1FjL+J7PiAEoQEVxaQB5SkXoz357aPn+O2nAhc=;
 b=ifPqo3DPSUrr2XaWFuXsamFrWV57B98bLsqSWXYZUQi0ZVO4M7vO1HN7ncNI10R4gA
 j5jj9GBwg9PyY756788lpEEVrX95E5xAqz/L45gZjTY04NTcjU2HVxxMwzcjoM/ttNma
 yCgmFVf7+wszi6Q+fHaGEnFoCysksRTdXotAqzXeT0QCDuCJazpXaSjMsxOrAZmDHleb
 gYHykcoaR1wvkYDRmbkVOGObYgl0V/D70MSYNTS/PNNSdkSidsXxirDsESot9I1U9141
 0xul2KWcTfH38j9r3oaQ9WuO0VU5k9AlYbj/6GH8V/Tm6/FXskEd1MetM6RT6vf4++/N
 Uhgg==
X-Gm-Message-State: AOAM530CV4H1Jk+e0QypPI08Biq+9sp9ZkP2FIdQHekTDEO/ABOb3++a
 uV70QlXwOLbuRo21R6/K+pzeohNa3vw=
X-Google-Smtp-Source: ABdhPJybibsokE9UP21PD3Z+GYKZZALyWJ1B1Vor9IHJViXTTPX+kCLhuT6TLLl4RTkMtmK/bk4kUA==
X-Received: by 2002:a17:906:5d0b:: with SMTP id
 g11mr15981040ejt.542.1612778686742; 
 Mon, 08 Feb 2021 02:04:46 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u2sm2606121edo.38.2021.02.08.02.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 02:04:46 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: extend MAX_KIQ_REG_TRY to 1000
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210208054555.23421-1-Jiawei.Gu@amd.com>
 <13337a59-f698-a91b-5662-1673e14a3cd7@gmail.com>
 <DM6PR12MB4170DCA058C4A96998CC8BFBF88F9@DM6PR12MB4170.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <25cdc423-c22e-7b89-7ff8-272afd197e4f@gmail.com>
Date: Mon, 8 Feb 2021 11:04:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB4170DCA058C4A96998CC8BFBF88F9@DM6PR12MB4170.namprd12.prod.outlook.com>
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgSmlhd2VpLAoKb2sgaW4gdGhpcyBjYXNlIGl0J3MgZmluZSB3aXRoIG1lLgoKSnVzdCBwbGVh
c2UgYWxzbyBnZXQgYSByZXZpZXdlZC1ieSBmcm9tIHNvbWVib2R5IHdoaWNoIGhhcyBtb3JlIEtJ
USAKYmFja2dyb3VuZCB0aGFuIEkgaGF2ZS4KClRoYW5rcywKQ2hyaXN0aWFuLgoKQW0gMDguMDIu
MjEgdW0gMTE6MDAgc2NocmllYiBHdSwgSmlhV2VpIChXaWxsKToKPiBbQU1EIE9mZmljaWFsIFVz
ZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4KPiBIaSBDaHJpc3RpYW4sCj4K
PiBUaGF0J3MgaG93IG1hbnkgdGltZXMgaXQgd291bGQgcmV0cnkgYmVmb3JlIGdpdmUgdXAuCj4g
QW5kIHdlIGFsd2F5cyBza2lwIHRoaXMgcmV0cnkgcm91dGluZSBpZiB3ZSBhcmUgaW4gaW50ZXJy
dXB0LCBzbyBpdCdzIGZpbmUgZm9yIGludGVycnVwdCBjb25kaXRpb24uCj4KPiBCZXN0IHJlZ2Fy
ZHMsCj4gSmlhd2VpCj4KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IENocmlz
dGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPgo+IFNlbnQ6IE1v
bmRheSwgRmVicnVhcnkgOCwgMjAyMSA1OjI4IFBNCj4gVG86IEd1LCBKaWFXZWkgKFdpbGwpIDxK
aWFXZWkuR3VAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IERl
bmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJt
L2FtZGdwdTogZXh0ZW5kIE1BWF9LSVFfUkVHX1RSWSB0byAxMDAwCj4KPiBBbSAwOC4wMi4yMSB1
bSAwNjo0NSBzY2hyaWViIEppYXdlaSBHdToKPj4gRXh0ZW5kIHJldHJ5IHRpbWVzIG9mIEtJUSB0
byBhdm9pZCBzdGFydmF0aW9uIHNpdHVhdGlvbiBjYXVzZWQgYnkgbG9uZwo+PiB0aW1lIGZ1bGwg
YWNjZXNzIG9mIEdQVSBieSBvdGhlciBWRnMuCj4gSW4gd2hhdCB1bml0cyBpcyB0aGF0PyBXZSBh
bHNvIG5lZWQgdGhlIEtJUSBkdXJpbmcgaW50ZXJydXB0IGhhbmRsaW5nIGFuZCB0aGF0IGxvb2tz
IGxpa2UgKndheSogdG8gYmlnIGZvciB0aGF0Lgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+IFNpZ25lZC1v
ZmYtYnk6IEppYXdlaSBHdSA8Smlhd2VpLkd1QGFtZC5jb20+Cj4+IC0tLQo+PiAgICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCB8IDIgKy0KPj4gICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oCj4+IGluZGV4IDYzOWRiMzJjMTM4My4uZTBjNzk3YTVmNzM5IDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+PiBAQCAtMjg4LDcgKzI4OCw3IEBAIGVu
dW0gYW1kZ3B1X2tpcV9pcnEgewo+PiAgICAKPj4gICAgI2RlZmluZSBNQVhfS0lRX1JFR19XQUlU
ICAgICAgIDUwMDAgLyogaW4gdXNlY3MsIDVtcyAqLwo+PiAgICAjZGVmaW5lIE1BWF9LSVFfUkVH
X0JBSUxPVVRfSU5URVJWQUwgICA1IC8qIGluIG1zZWNzLCA1bXMgKi8KPj4gLSNkZWZpbmUgTUFY
X0tJUV9SRUdfVFJZIDgwIC8qIDIwIC0+IDgwICovCj4+ICsjZGVmaW5lIE1BWF9LSVFfUkVHX1RS
WSAxMDAwCj4+ICAgIAo+PiAgICBpbnQgYW1kZ3B1X2RldmljZV9pcF9zZXRfY2xvY2tnYXRpbmdf
c3RhdGUodm9pZCAqZGV2LAo+PiAgICAJCQkJCSAgIGVudW0gYW1kX2lwX2Jsb2NrX3R5cGUgYmxv
Y2tfdHlwZSwKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
